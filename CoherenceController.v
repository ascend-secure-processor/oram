
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
	
    ROPAddr, ROAccess, REWRoundDummy, CSPathRead, CSPathWriteback, DRAMInitComplete,

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
	`include "IVCCLocal.vh"
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	input	[ORAMU-1:0]		ROPAddr;
    input					ROAccess, REWRoundDummy, CSPathRead, CSPathWriteback, DRAMInitComplete;
	
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
	output 	[DDRDWidth-1:0]  	DataFromIV;
	input 	[DDRDWidth-1:0]  	DataToIV;
	
	output  					IVReady_BktOfI;
	input						IVDone_BktOfI;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
    wire RWAccess;
    
    assign RWAccess = DRAMInitComplete && !ROAccess;
    
		//--------------------------------------------------------------------------
	// CC handles header write back
	//-------------------------------------------------------------------------- 
              
	// distinguish headers from payloads
	wire HeaderInValid;
    wire  [`log2(BktSize_DRBursts)-1:0] BlkCtr;   
	
	CountAlarm #(		.Threshold(				BktSize_DRBursts))
		blk_ctr 	(	.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				FromDecDataValid && FromDecDataReady),
						.Count(					BlkCtr)
					);
		
	assign HeaderInValid = ROAccess && FromDecDataValid && BlkCtr < BktHSize_DRBursts;	 
	
	// invalidate the bit for the target block
	wire HdOfInterest;
	wire [DDRDWidth-1:0]	HeaderIn;
	wire [ORAMZ-1:0]        ValidBitsIn, ValidBitsOut;
	
	reg  [`log2(ORAML+1)-1:0]	BktOfInterest;
	reg  [ORAMZ-1:0]			ValidBitsReg;
	
	genvar j;
	for (j = 0; j < ORAMZ; j = j + 1) begin: VALID_BIT
		assign ValidBitsIn[j] = FromDecData[IVEntropyWidth+j];
		assign ValidBitsOut[j] = (ValidBitsIn[j] && ROAccess && !REWRoundDummy && ROPAddr == FromDecData[BktHUStart + (j+1)*ORAMU - 1: BktHUStart + j*ORAMU]) ? 0 : ValidBitsIn[j];                  
	end 
	
	assign HdOfInterest = (ValidBitsIn != ValidBitsOut) && HeaderInValid;
	assign HeaderIn = {FromDecData[DDRDWidth-1:IVEntropyWidth+ORAMZ], ValidBitsOut, FromDecData[IVEntropyWidth-1:0]};
		
	//--------------------------------------------------------------------------
	// Integrity Verification needs two path buffers and requires delaying path and header write back
	//-------------------------------------------------------------------------- 
    generate if (EnableIV) begin: FULL_BUF
		
		initial begin
			if (!EnableREW) begin
				$display("Integrity verification without REW ORAM? Not supported.");
				$finish;
			end
		end
	
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
		wire 					PthRW_Transition;
		
		wire [DDRDWidth-1:0] 	BufP1Reg_DOut;
		wire 					BufP1Reg_InValid, BufP1Reg_InReady, BufP1Reg_OutValid, BufP1Reg_OutReady;
		wire [1:0]				BufP1Reg_EmptyCount;
		wire [`log2(ORAML+1)-1:0]	HdOnPthCtr;
		
		FIFORAM #(			.Width(					DDRDWidth),
							.Buffering(				2))
			out_path_reg (	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BufP1_DOut),
							.InValid(				BufP1Reg_InValid),
							.InAccept(				BufP1Reg_InReady),
							.InEmptyCount(			BufP1Reg_EmptyCount),
							.OutData(				BufP1Reg_DOut),
							.OutSend(				BufP1Reg_OutValid),
							.OutReady(				BufP1Reg_OutReady));
		
		CCPortArbiter # (	.DWidth(				DDRDWidth),
							.ORAML(					ORAML),
							.BktSize_DRBursts(		BktSize_DRBursts)	)
							
			port_arbiter(	.Clock(					Clock),
							.Reset(					Reset),
							
							.ROAccess(				ROAccess),
							.RWAccess(				RWAccess),
							.CSPathRead(			CSPathRead),
							.CSPathWriteback(		CSPathWriteback),
							
							.HeaderInValid(			HeaderInValid),
							.HdOfInterest(			HdOfInterest),
							
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
							
							.BufReg_InValid(		BufP1Reg_InValid),
							.PthRW_Transition(		PthRW_Transition),
							.HdOnPthCtr(			HdOnPthCtr),
							.BktOfI_Transition(		IVReady_BktOfI)
						);
	
		//	AES --> Stash Passthrough 	
		assign	ToStashData =			FromDecData;
		assign	ToStashDataValid =		FromDecDataValid; 
		assign	FromDecDataReady = 		ToStashDataReady;

		//	ROAccess: header write back CC --> AES. RWAccess: BufP1 --> AES
		assign	ToEncData =				RWAccess ? BufP1Reg_DOut 
										: ROAccess ? BufP1Reg_DOut
										: FromStashData;
										
		assign	ToEncDataValid =		RWAccess ? BufP1Reg_OutValid //&& IVDone
										: ROAccess ? BufP1Reg_OutValid //&& IVDone_BktOfI
										: FromStashDataValid;
		
		assign  BufP1Reg_OutReady = 	RWAccess ? ToEncDataReady //&& IVDone 
										: ROAccess ? ToEncDataReady //&& IVDone_BktOfI
										: 0;
		
		assign	FromStashDataReady = 	!DRAMInitComplete ? ToEncDataReady : RWAccess && CSPathWriteback;
		
		//--------------------------------------------------------------------------
		// Port2 : read and written by IV
		//-------------------------------------------------------------------------- 
		reg [1:0] 	HdOfIStat;
		
		assign 	IVStart = RWAccess && CSPathRead && PthRW_Transition;
		
		assign  BufP2_Enable = IVRequest;
		assign  BufP2_Write = IVWrite;
		assign  BufP2_Address = IVAddress != OBktOfIStartAddr ? IVAddress : (HdStartAddr + BktOfInterest);
		assign  BufP2_DIn = DataFromIV;		
		
		assign  DataToIV = HdOfIStat != 2 ? BufP2_DOut : {BufP2_DOut[DDRDWidth-1:IVEntropyWidth+ORAMZ], ValidBitsReg, BufP2_DOut[IVEntropyWidth-1:0]};;
		
		always @(posedge Clock) begin
		    if (Reset) begin
		        HdOfIStat <= 0;
		    end
			if (HdOfInterest) begin
				HdOfIStat <= 0;
				BktOfInterest <=  HdOnPthCtr;
				ValidBitsReg  <=  ValidBitsIn;
			end
			
			else if (IVAddress == OBktOfIStartAddr && IVRequest && !IVWrite)
				HdOfIStat <= HdOfIStat + 1;
			else if (HdOfIStat == 2)
				HdOfIStat <= HdOfIStat + 1;
		end
		
	end else begin: NO_BUF
	
		wire HeaderInReady, HeaderInValid, HeaderOutValid;
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
						.OutReady(				ToEncDataReady)
					);     
	
	
		//	AES --> Stash Passthrough 	
		assign	ToStashData =			FromDecData;
		assign	ToStashDataValid =		FromDecDataValid; 
		assign	FromDecDataReady = 		ToStashDataReady;

		//	ROAccess: header write back CC --> AES. RWAccess: Stash --> AES
		assign	ToEncData =				ROAccess ? HeaderOut : FromStashData;
		assign	ToEncDataValid =		ROAccess ? HeaderOutValid :	FromStashDataValid;
		
		assign	FromStashDataReady = 	!ROAccess && ToEncDataReady;

	end endgenerate

endmodule
//------------------------------------------------------------------------------
