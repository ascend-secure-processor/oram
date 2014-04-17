
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		CoherenceController
//	Desc:		Create a coherent view of data in ORAM tree to backend & 
//				integrity verification.  Notation: REW accesses = RO, H, R, W
//
//				Schedule: [ R W (backend only) {E{RO H}} W (write to memory) ] repeat
//
//				Summary of jobs:
//
//				1 - R access:
//					- Store the path read during the access.  This path will be periodically read by IV unit to check R hashes.
//				2 - BACKEND completes W access:
//					- Store plaintext bits that will be written back.  These bits will be periodically read by the IV unit to re-create W hashes.
//					- IV unit will send new hashes back to CoherenceController, which will insert them in proper locations
//				3 - RO access: [coherence step]
//					- For each RO bucket received from AES (decrypted in certain cases), compare that bucket to the set of buckets stored from step 2.  For each aliasing bucket, forward W data to BE/IV unit.
//					- Invariant: all data forwarded to IV/BE must be freshest copy of the data.
//					- Store decrypted header sent from AES (after being coherence checked) internally.
//					- Send IV the bucket of interest to be hashed; send rest to BE
//					- When IV returns hash, merge hash & any modified valid bits back into W path and headers (stored internally) if the bucket of interest had a collision
//				4 - H access: 
//					- Push updated headers back to AES
//				5 - W access (writes to external memory)
//					- Push the fully up to date W path (stored internally and coherent) back to memory
//==============================================================================
module CoherenceController(
	Clock, Reset,
	
    ROPAddr, REWRoundDummy, DRAMInitComplete,

	FromDecData, FromDecDataValid, FromDecDataReady,
	ToEncData, ToEncDataValid, ToEncDataReady,
	
	ToStashData, ToStashDataValid, ToStashDataReady,
	FromStashData, FromStashDataValid, FromStashDataReady,
	
	IVStart, IVDone,
	IVRequest, IVWrite, IVAddress, DataFromIV, DataToIV,
	
	IVReady_BktOfI, IVDone_BktOfI
);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

    `include "PathORAM.vh";
	`include "DDR3SDRAM.vh";
	`include "AES.vh";
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "SHA3Local.vh"
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	input	[ORAMU-1:0]		ROPAddr;
    input					REWRoundDummy, DRAMInitComplete;
	
	//--------------------------------------------------------------------------
	//	AES Interface
	//--------------------------------------------------------------------------
	
	// All read path data from AES
	input	[DDRDWidth-1:0]	FromDecData;
	input					FromDecDataValid;
	output					FromDecDataReady;
	
	// All writeback path data to AES
	output	[DDRDWidth-1:0]	ToEncData;
	output					ToEncDataValid;
	input					ToEncDataReady;

	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------

	// Writeback data
	input	[DDRDWidth-1:0]	FromStashData;
	input					FromStashDataValid;
	output					FromStashDataReady;
	
	// Read data
	output	[DDRDWidth-1:0]	ToStashData;
	output					ToStashDataValid;
	input					ToStashDataReady;	
		
	//--------------------------------------------------------------------------
	//	Integrity Interface
	//--------------------------------------------------------------------------

	output						IVStart;
	input						IVDone;
	input 						IVRequest, IVWrite;
	input 	[PathBufAWidth-1:0] 	IVAddress;
	input 	[DDRDWidth-1:0]  	DataFromIV;
	output 	[DDRDWidth-1:0]  	DataToIV;
	
	output  					IVReady_BktOfI;
	input						IVDone_BktOfI;
	
	wire 	ROAccess, RWAccess, PathRead, PathWriteback;
	
	
	//--------------------------------------------------------------------------
	// CC status control logic
	//-------------------------------------------------------------------------- 
	localparam	RW_R_Chunk = PathSize_DRBursts,
				RW_W_Chunk = PathSize_DRBursts,
				RO_R_Chunk = (ORAML+1) * BktHSize_DRBursts + BktSize_DRBursts,
				RO_W_Chunk = (ORAML+1) * BktHSize_DRBursts;
	
	wire	[`log2(RW_R_Chunk)-1:0]		RW_R_Ctr;
	wire	[`log2(RW_W_Chunk)-1:0]		RW_W_Ctr;
	wire	[`log2(RO_R_Chunk)-1:0]		RO_R_Ctr;
	wire	[`log2(RO_W_Chunk)-1:0]		RO_W_Ctr;
	
	
	REWStatCtr	#(			.ORAME(					ORAME),
							.RW_R_Chunk(			RW_R_Chunk),
							.RW_W_Chunk(			RW_W_Chunk),
							.RO_R_Chunk(			RO_R_Chunk),
							.RO_W_Chunk(			RO_W_Chunk))
							
			rw_stat		(	.Clock(					Clock),
							.Reset(					Reset | !DRAMInitComplete),
							
							.RW_R_Transfer(			RWAccess && PathRead && FromDecDataValid && FromDecDataReady),
							.RW_W_Transfer(			RWAccess && PathWriteback && ToEncDataValid && ToEncDataReady),
							.RO_R_Transfer(			ROAccess && PathRead && FromDecDataValid && FromDecDataReady),
							.RO_W_Transfer(			ROAccess && PathWriteback && ToEncDataValid && ToEncDataReady),
							
							.ROAccess(				ROAccess),
							.RWAccess(				RWAccess),
							.Read(					PathRead),
							.Writeback(				PathWriteback),
							
							.RW_R_Ctr(				RW_R_Ctr),
							.RW_W_Ctr(				RW_W_Ctr),
							.RO_R_Ctr(				RO_R_Ctr),
							.RO_W_Ctr(				RO_W_Ctr)													
						);
	
	
	//--------------------------------------------------------------------------
	// CC handles header write back
	//-------------------------------------------------------------------------- 
              
	// distinguish headers from payloads
	wire HeaderInValid;
    /*
	wire  [`log2(BktSize_DRBursts)-1:0] BlkCtr;   
	
	CountAlarm #(		.Threshold(				BktSize_DRBursts))
		blk_ctr 	(	.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				FromDecDataValid && FromDecDataReady),
						.Count(					BlkCtr)
					);
	*/	
	// assign HeaderInValid = ROAccess && PathRead && FromDecDataValid && BlkCtr < BktHSize_DRBursts;	
	assign HeaderInValid = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr < RO_R_Chunk - BktSize_DRBursts;	 	
	
	// invalidate the bit for the target block
	wire HdOfInterest;
	wire [DDRDWidth-1:0]	HeaderIn;
	wire [ORAMZ-1:0]        ValidBitsIn, ValidBitsOut;
	
	reg  [`log2(ORAML+1)-1:0]	BktOfInterest;
	reg  [ORAMZ-1:0]			ValidBitsReg;
	
	genvar j;
	for (j = 0; j < ORAMZ; j = j + 1) begin: VALID_BIT
		assign ValidBitsIn[j] = FromDecData[IVEntropyWidth+j];
		assign ValidBitsOut[j] = (ValidBitsIn[j] && ROAccess && (!REWRoundDummy && ROPAddr == FromDecData[BktHUStart + (j+1)*ORAMU - 1: BktHUStart + j*ORAMU]) ) ? 0 : ValidBitsIn[j];                  
	end 
	
	assign HdOfInterest = HeaderInValid && !REWRoundDummy && (ValidBitsIn != ValidBitsOut);
	assign HeaderIn = {FromDecData[DDRDWidth-1:IVEntropyWidth+ORAMZ], ValidBitsOut, FromDecData[IVEntropyWidth-1:0]};
	
	
	//--------------------------------------------------------------------------
	// Integrity Verification needs a dual-port path buffer and requires delaying path and header write back
	//-------------------------------------------------------------------------- 
    generate if (EnableIV) begin: FULL_BUF
		
		initial begin
			if (!EnableREW) begin
				$display("Integrity verification without REW ORAM? Not supported.");
				$finish;
			end
		end
	
		`include "IVCCLocal.vh"
		
		//------------------------------------------------------------------------------------------------------
		// in and out path buffer. 
		// 		port1 written by Stash, read and written by AES
		//		port2 read and written by integrity verifier
		//------------------------------------------------------------------------------------------------------
		wire 					BufP1_Enable, BufP2_Enable, BufP1_Write, BufP2_Write;
		wire [PathBufAWidth-1:0] 	BufP1_Address, BufP2_Address;
		wire [DDRDWidth-1:0] 	BufP1_DIn, BufP2_DIn, BufP1_DOut, BufP2_DOut;
		
		RAM		#(          .DWidth(				DDRDWidth),     
                            .AWidth(				PathBufAWidth),
							.NPorts(				2))
							
            out_path_buf  (	.Clock(					{2{Clock}}),
                            .Reset(					{2{Reset}}),
                            .Enable(				{BufP1_Enable, BufP2_Enable}),
                            .Write(					{BufP1_Write, BufP2_Write}),
                            .Address(				{BufP1_Address, BufP2_Address}),
                            .DIn(					{BufP1_DIn, BufP2_DIn}),
                            .DOut(					{BufP1_DOut, BufP2_DOut})
                        );     
		
		//--------------------------------------------------------------------------
		// Port1 : written by Stash, read (through a FIFO) and written by AES
		//-------------------------------------------------------------------------- 
		wire 					PthRW_Transition, BktOfI_Transition;
		
		wire [DDRDWidth-1:0] 	BufP1Reg_DIn, BufP1Reg_DOut;
		wire 					BufP1Reg_DInValid, BufP1Reg_DInReady, BufP1Reg_DOutValid, BufP1Reg_DOutReady;
		wire [1:0]				BufP1Reg_EmptyCount;
		wire [`log2(ORAML+1)-1:0]	HdOnPthCtr;

		assign	HdOfIWriteBack = ROAccess && PathWriteback && HdOfIStat == 2 && (HdOnPthCtr == (BktOfInterest + 1) % (ORAML+1));
		assign 	BufP1Reg_DIn =  (HdOfIWriteBack) ? {BktOfINewHash[DigestStart-1:DigestEnd], BufP1_DOut[BktHSize_RawBits-1:0]}
									: BufP1_DOut;
		
		FIFORAM #(			.Width(					DDRDWidth),
							.Buffering(				2))
			out_path_reg (	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BufP1Reg_DIn),
							.InValid(				BufP1Reg_DInValid),
							.InAccept(				BufP1Reg_DInReady),
							.InEmptyCount(			BufP1Reg_EmptyCount),
							.OutData(				BufP1Reg_DOut),
							.OutSend(				BufP1Reg_DOutValid),
							.OutReady(				BufP1Reg_DOutReady));
				
		CCPortArbiter # (	.DWidth(				DDRDWidth),
							.ORAML(					ORAML),
							.BktSize_DRBursts(		BktSize_DRBursts)	)
							
			port_arbiter(	.Clock(					Clock),
							.Reset(					Reset),
							
							.ROAccess(				ROAccess),
							.RWAccess(				RWAccess),
							.PathRead(			    PathRead),
							.PathWriteback(		    PathWriteback),
							
						//	.HeaderInValid(			HeaderInValid),
						//	.HdOfInterest(			HdOfInterest),
							
							.FromDecDataTransfer(	FromDecDataValid && FromDecDataReady),
							.FromStashDataTransfer(	FromStashDataValid && FromStashDataReady),
							.HeaderDataIn(			HeaderIn),
							.FromDecData(			FromDecData),
							.FromStashData(			FromStashData),
							
							.IVDone(				IVDone),
							.IVDone_BktOfI(			IVDone_BktOfI),
							.BufReg_EmptyCount(		BufP1Reg_EmptyCount),
							
							.Enable(				BufP1_Enable),
							.Write(					BufP1_Write),
							.Address(				BufP1_Address),
							.DIn(					BufP1_DIn),
							
							.BufReg_InValid(		BufP1Reg_DInValid),
							.PthRW_Transition(		PthRW_Transition),
							.HdOnPthCtr(			HdOnPthCtr),
							.BktOfI_Transition(		BktOfI_Transition)
						);
	
		//	AES --> Stash  	
		assign	ToStashData =			FromDecData;
		assign	ToStashDataValid =		RWAccess ?  FromDecDataValid
											: PathRead && FromDecDataValid && RO_R_Ctr >= RO_R_Chunk - BktSize_DRBursts;
											
		assign	FromDecDataReady = 		ToStashDataReady;

		//	ROAccess: header write back CC --> AES. RWAccess: BufP1 --> AES
		assign	ToEncData =				RWAccess ? BufP1Reg_DOut 
										: ROAccess ? BufP1Reg_DOut
										: {DDRDWidth{1'bx}};
										
		assign	ToEncDataValid =		RWAccess ? BufP1Reg_DOutValid //&& IVDone
										: ROAccess ? BufP1Reg_DOutValid //&& IVDone_BktOfI
										: 0;
		
		assign  BufP1Reg_DOutReady = 	RWAccess ? ToEncDataReady //&& IVDone 
										: ROAccess ? ToEncDataReady //&& IVDone_BktOfI
										: 0;
		
		assign	FromStashDataReady = 	!DRAMInitComplete ? ToEncDataReady : RWAccess && PathWriteback;
		
		//--------------------------------------------------------------------------
		// Port2 : read and written by IV
		//-------------------------------------------------------------------------- 
		reg [1:0] 	HdOfIStat;
		reg [TrancateDigestWidth-1:0] BktOfINewHash;
		
		assign 	IVStart = RWAccess && PathRead && PthRW_Transition;
		
		assign  BufP2_Enable = IVRequest;
		assign  BufP2_Write = IVWrite;
		assign  BufP2_Address = IVAddress;
		assign  BufP2_DIn = DataFromIV;		
		
		assign  DataToIV = HdOfIStat != 1 ? BufP2_DOut : {BufP2_DOut[DDRDWidth-1:IVEntropyWidth+ORAMZ], ValidBitsReg, BufP2_DOut[IVEntropyWidth-1:0]};;
			
		// hacky solution to pass the two versions of bucket of interest to IV	
		always @(posedge Clock) begin
		    if (Reset) begin
		        HdOfIStat <= 0;
		    end
						
			if (HdOfInterest) begin
				HdOfIStat <= 0;
				BktOfInterest <=  HdOnPthCtr;//(HdOnPthCtr + ORAML) % (ORAML+1);		// effectively HdOnPthCtr - 1 because read latency = 1
				ValidBitsReg  <=  ValidBitsOut;		// save new valid bits
			end
			
			// there should be 2 reads and 1 write
			// 0 - found; 1 - have read once; 2 - have read twice; 3 - all set.		
			else if (IVRequest && IVAddress == OBktOfIStartAddr) begin	
				if (!IVWrite)
					HdOfIStat <= HdOfIStat + 1;
				else
					BktOfINewHash <= DataFromIV[DigestStart-1:DigestEnd];			
			end
			
			else if (HdOfIStat == 2 && PathRead)
				HdOfIStat <= 3;
		end
		
		assign 	IVReady_BktOfI = HdOfIStat == 0 && BktOfI_Transition;
		
	end else begin: NO_BUF
	
		wire HeaderInReady, HeaderOutValid, HeaderOutReady;
		wire [DDRDWidth-1:0]	HeaderOut;
			 
		always @ (posedge Clock) begin		
			if (!Reset && HeaderInValid && !HeaderInReady) begin
				$display("Error: Header Buffer Overflow!");
				$finish;
			end
		end
	
		// save the headers and write them back later     
		FIFORAM	#(      .Width(					DDRDWidth),     
						.Buffering(				(ORAML+1) * BktHSize_DRBursts ))
		in_hd_buf  (	.Clock(					Clock),
						.Reset(					Reset),
						.InData(				HeaderIn),
						.InValid(				HeaderInValid),
						.InAccept(				HeaderInReady),
						.OutData(				HeaderOut),
						.OutSend(				HeaderOutValid),
						.OutReady(				HeaderOutReady)
					);     
	
	
		//	AES --> Stash 	
		assign	ToStashData =			FromDecData;
		assign	ToStashDataValid =		RWAccess ?  FromDecDataValid
											: PathRead && FromDecDataValid && RO_R_Ctr >= RO_R_Chunk - BktSize_DRBursts;
											
		assign	FromDecDataReady = 		ToStashDataReady;

		//	ROAccess: header write back CC --> AES. RWAccess: Stash --> AES
		assign	ToEncData =				ROAccess ? HeaderOut: FromStashData;
		assign	ToEncDataValid =		ROAccess ? HeaderOutValid  && PathWriteback:	FromStashDataValid;
		assign  HeaderOutReady = 		ROAccess && PathWriteback && ToEncDataReady;
		
		assign	FromStashDataReady = 	!ROAccess && ToEncDataReady;

	end endgenerate

endmodule
//------------------------------------------------------------------------------
