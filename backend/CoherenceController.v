
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
	
    ROPAddr, REWRoundDummy,

	FromDecData, FromDecDataValid, FromDecDataReady,
	ToEncData, ToEncDataValid, ToEncDataReady,
	
	ToStashData, ToStashDataValid, ToStashDataReady,
	FromStashData, FromStashDataValid, FromStashDataReady,
	
	
	IVRequest, IVWrite, IVAddress, DataFromIV, DataToIV,
	PathReady_IV, PathDone_IV, BOIReady_IV, BOIDone_IV
);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

    `include "PathORAM.vh"
    
	`include "SecurityLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "SHA3Local.vh"
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	input	[ORAMU-1:0]		ROPAddr;
    input					REWRoundDummy;
	
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

	input 						IVRequest, IVWrite;
	input 	[PathBufAWidth-1:0] 	IVAddress;
	input 	[DDRDWidth-1:0]  	DataFromIV;
	output 	[DDRDWidth-1:0]  	DataToIV;
	
	output  					PathReady_IV, BOIReady_IV;
	input						PathDone_IV, BOIDone_IV;
	
	wire 	ROAccess, RWAccess, PathRead, PathWriteback;
	
	wire 	RW_R_DoneAlarm, RW_W_DoneAlarm, RO_R_DoneAlarm, RO_W_DoneAlarm;
	
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
							.Overlap(				0),
							.RW_R_Chunk(			RW_R_Chunk),
							.RW_W_Chunk(			RW_W_Chunk),
							.RO_R_Chunk(			RO_R_Chunk),
							.RO_W_Chunk(			RO_W_Chunk))
							
		rew_stat		(	.Clock(					Clock),
							.Reset(					Reset),
							
							.RW_R_Transfer(			FromDecDataValid && FromDecDataReady),
							.RW_W_Transfer(			ToEncDataValid && ToEncDataReady),
							.RO_R_Transfer(			FromDecDataValid && FromDecDataReady),
							.RO_W_Transfer(			ToEncDataValid && ToEncDataReady),
							
							.ROAccess(				ROAccess),
							.RWAccess(				RWAccess),
							.Read(					PathRead),
							.Writeback(				PathWriteback),
							
							.RW_R_Ctr(				RW_R_Ctr),
							.RW_W_Ctr(				RW_W_Ctr),
							.RO_R_Ctr(				RO_R_Ctr),
							.RO_W_Ctr(				RO_W_Ctr),

							.RW_R_DoneAlarm(		RW_R_DoneAlarm),
							.RW_W_DoneAlarm(		RW_W_DoneAlarm),
							.RO_R_DoneAlarm(		RO_R_DoneAlarm),
							.RO_W_DoneAlarm(		RO_W_DoneAlarm)							
						);
	
	
	//--------------------------------------------------------------------------
	// CC handles header write back
	//-------------------------------------------------------------------------- 
	wire HeaderInValid, HeaderInBkfOfI, BktOfIInValid;	
	
	assign 	HeaderInValid = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr < RO_R_Chunk - BktSize_DRBursts;	 	
	assign	HeaderInBkfOfI = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr == RO_R_Chunk - BktSize_DRBursts;	
	assign	BktOfIInValid = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr >= RO_R_Chunk - BktSize_DRBursts; 	
	
	// invalidate the bit for the target block
	wire HdOfInterest;
	wire [DDRDWidth-1:0]	HeaderIn;
	wire [ORAMZ-1:0]        ValidBitsIn, ValidBitsOfI, ValidBitsOut;
	
	reg  [`log2(ORAML+1)-1:0]	BktOfInterest;
	reg  [ORAMZ-1:0]			ValidBitsReg;
	
	genvar j;
	for (j = 0; j < ORAMZ; j = j + 1) begin: VALID_BIT
		assign 	ValidBitsIn[j] = FromDecData[AESEntropy+j];
		assign	ValidBitsOfI[j] = ValidBitsIn[j] && ROAccess && (!REWRoundDummy && ROPAddr == FromDecData[BktHUStart + (j+1)*ORAMU - 1: BktHUStart + j*ORAMU]);
			// one hot signal that if a block is of interest
	end 
	
	assign ValidBitsOut = ValidBitsOfI ^ ValidBitsIn;    
	
	assign HdOfInterest = HeaderInValid && !REWRoundDummy && (| ValidBitsOfI);
	assign HeaderIn = {FromDecData[DDRDWidth-1:AESEntropy+ORAMZ], ValidBitsOut, FromDecData[AESEntropy-1:0]};
	
	
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
							
            cc_path_buf  (	.Clock(					{2{Clock}}),
                            .Reset(					{2{Reset}}),
                            .Enable(				{BufP1_Enable, BufP2_Enable}),
                            .Write(					{BufP1_Write, BufP2_Write}),
                            .Address(				{BufP1_Address, BufP2_Address}),
                            .DIn(					{BufP1_DIn, BufP2_DIn}),
                            .DOut(					{BufP1_DOut, BufP2_DOut})
                        );     
		
		//--------------------------------------------------------------------------
		// Port1 : written by Stash, read and written by AES, read and written by CC to resolve conflict
		//-------------------------------------------------------------------------- 	
		wire [DDRDWidth-1:0] 	BufP1Reg_DIn, BufP1Reg_DOut;
		wire 					BufP1Reg_DInValid, BufP1Reg_DInReady, BufP1Reg_DOutValid, BufP1Reg_DOutReady;
		wire [1:0]				BufP1Reg_EmptyCount;
		
		wire [`log2(ORAML+1)-1:0]	HdOnPthCtr;
		wire 						HdOfIWriteBack;
		reg [TrancateDigestWidth-1:0] BktOfINewHash;
		
		assign	HdOfIWriteBack = ROAccess && PathWriteback && HdOfIStat == 2 && (HdOnPthCtr == (BktOfInterest + 1) % (ORAML+1));
		assign 	BufP1Reg_DIn =  (HdOfIWriteBack) ? {BktOfINewHash, BufP1_DOut[BktHSize_RawBits-1:0]}
									: BufP1_DOut;
		
		FIFORAM #(			.Width(					DDRDWidth),
							.Buffering(				3))
			out_path_reg (	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BufP1Reg_DIn),
							.InValid(				BufP1Reg_DInValid),
							.InAccept(				BufP1Reg_DInReady),
							.InEmptyCount(			BufP1Reg_EmptyCount),
							.OutData(				BufP1Reg_DOut),
							.OutSend(				BufP1Reg_DOutValid),
							.OutReady(				BufP1Reg_DOutReady));
		
		Register #(	.Width(1))	// TODO: Read from P1 but not for AES? Yes, when delayed write back
			to_enc_valid ( Clock, Reset, 1'b0, 1'b1, 	BufP1_Enable && !BufP1_Write,	BufP1Reg_DInValid);
		
		wire [PthBSTWidth-1:0]	BlkOnPthCtr;
		reg  PthRW, HdRW;
		wire PthCtrEnable, HdCtrEnable;
		wire HdRW_Transition, PthRW_Transition;	
		
		wire FromDecDataTransfer, FromStashDataTransfer;
		assign FromDecDataTransfer = FromDecDataReady && FromDecDataValid;
		assign FromStashDataTransfer = FromStashDataReady && FromStashDataValid;
		
		assign PthCtrEnable = RWAccess && BufP1_Enable;
		CountAlarm #(		.Threshold(				PathSize_DRBursts))
			blk_ctr (		.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				PthCtrEnable),
							.Count(					BlkOnPthCtr),
							.Done(					PthRW_Transition)
					);
		
		assign HdCtrEnable = ROAccess && BufP1_Enable && !BktOfIInValid;
		CountAlarm #(		.Threshold(				ORAML + 1))
			hd_ctr (		.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				HdCtrEnable),
							.Count(					HdOnPthCtr),
							.Done(					HdRW_Transition)
					);
		
		// 1 means read from DRAM,  write to buffer; 0 means write to DRAM, read from buffer
		always @(posedge Clock) begin
			if (Reset) begin
				PthRW <= 1'b1;
				HdRW <= 1'b1;
			end
			else begin 
				if (RWAccess && PathWriteback && PthRW_Transition) 
					PthRW <= !PthRW;				
				else if (ROAccess && HdRW_Transition) 
					HdRW <= !HdRW;			
			end
		end
	
		assign BufP1_Enable = RWAccess ? 
									(	PathRead ? FromDecDataTransfer
										: PthRW ? FromStashDataTransfer 
												: PathDone_IV && BufP1Reg_EmptyCount > 1)			// Send data to AES							
							: ROAccess ? 
									(	PathRead ? FromDecDataTransfer 						// header and BktOfI from Dec
										: !HdRW && BOIDone_IV && BufP1Reg_EmptyCount > 1)		// Send headers to AES
							: 0;							
			
		assign BufP1_Write = 	RWAccess ? 	(	PathRead ? 1'b1 : PthRW )
								: ROAccess ? (	PathRead ? 1'b1 : HdRW )
								: 0;
						
		assign BufP1_Address = RWAccess ?  (	PathRead ? IPthStartAddr + BlkOnPthCtr : OPthStartAddr + BlkOnPthCtr )
								: ROAccess ? (	PathRead ? 
											(	BktOfIInValid ? OBktOfIStartAddr + RO_R_Ctr - RO_W_Chunk	// bucket of interest										     										  																								 		
												: HdStartAddr + HdOnPthCtr)		// save header										
										: HdStartAddr + HdOnPthCtr)				// header write back								
								: 0;
								
		assign BufP1_DIn = 	RWAccess ? 	(	PathRead ? FromDecData : FromStashData)							
							: ROAccess ? (	BktOfIInValid ? FromDecData : HeaderIn) 
							: 0;	
		
		//	AES --> Stash  	
		assign	ToStashData =			HeaderInBkfOfI ? {FromDecData[DDRDWidth-1:AESEntropy+ORAMZ], ValidBitsOfI, FromDecData[AESEntropy-1:0]}
											: FromDecData;
											
		assign	ToStashDataValid = 		RWAccess ? FromDecDataValid : BktOfIInValid;
											
		assign	FromDecDataReady = 		ToStashDataReady;

		// BufP1 --> buffer --> AES
		assign	ToEncData =				BufP1Reg_DOut;
		assign	ToEncDataValid = 		BufP1Reg_DOutValid;
		assign	BufP1Reg_DOutReady = 	ToEncDataReady;
		
		assign	FromStashDataReady = 	RWAccess && PathWriteback;
		
		//--------------------------------------------------------------------------
		// Port2 : read and written by IV
		//--------------------------------------------------------------------------
		
		reg [1:0] 	HdOfIStat;
		
		assign 	PathReady_IV = RW_R_DoneAlarm;
		assign	BOIReady_IV = RO_R_DoneAlarm;
		
		assign  BufP2_Enable = IVRequest;
		assign  BufP2_Write = IVWrite;
		assign  BufP2_Address = IVAddress;
		assign  BufP2_DIn = DataFromIV;		
		
		assign  DataToIV = HdOfIStat != 1 ? BufP2_DOut : {BufP2_DOut[DDRDWidth-1:AESEntropy+ORAMZ], ValidBitsReg, BufP2_DOut[AESEntropy-1:0]};;
			
		// hacky solution to pass the two versions of bucket of interest to IV	
		always @(posedge Clock) begin
		    if (Reset) begin
		        HdOfIStat <= 3;
		    end
						
			if (HdOfInterest) begin
				HdOfIStat <= 0;
				BktOfInterest <=  HdOnPthCtr;//(HdOnPthCtr + ORAML) % (ORAML+1);		// effectively HdOnPthCtr - 1 because read latency = 1
				ValidBitsReg  <=  ValidBitsOut;		// save new valid bits
			end
			
			// there should be 2 reads and 1 write
			// 0 - found; 1 - have read once; 2 - have read twice; 3 - all set.		
			else if (HdOfIStat < 3 && IVRequest && IVAddress == OBktOfIStartAddr) begin	
				if (!IVWrite && HdOfIStat < 2)
					HdOfIStat <= HdOfIStat + 1;
				else
					BktOfINewHash <= DataFromIV[DigestStart-1:DigestEnd];			
			end
			
			else if (HdOfIStat == 2 && PathRead)
				HdOfIStat <= 3;
		end
		
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
		assign	ToStashData =			HeaderInBkfOfI ? {FromDecData[DDRDWidth-1:AESEntropy+ORAMZ], ValidBitsOfI, FromDecData[AESEntropy-1:0]}
											: FromDecData;
		assign	ToStashDataValid =		RWAccess ? FromDecDataValid : BktOfIInValid;
											
		assign	FromDecDataReady = 		ToStashDataReady;

		//	ROAccess: header write back CC --> AES. RWAccess: Stash --> AES
		assign	ToEncData =				ROAccess ? HeaderOut: FromStashData;
		assign	ToEncDataValid =		ROAccess ? HeaderOutValid  && PathWriteback:	FromStashDataValid;
		assign  HeaderOutReady = 		ROAccess && PathWriteback && ToEncDataReady;
		
		assign	FromStashDataReady = 	!ROAccess && ToEncDataReady;

	end endgenerate

endmodule
//------------------------------------------------------------------------------
