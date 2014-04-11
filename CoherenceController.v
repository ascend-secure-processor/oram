
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
	
    ROPAddr, ROAccess, REWRoundDummy, DRAMInitComplete,

	FromDecData, FromDecDataValid, FromDecDataReady,
	ToEncData, ToEncDataValid, ToEncDataReady,
	
	ToStashData, ToStashDataValid, ToStashDataReady,
	FromStashData, FromStashDataValid, FromStashDataReady,
	
	IVStart, IVDone, IVPathSelect,
	IVRequest, IVWrite, IVAddress, DataFromIV, DataToIV
);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

    `include "PathORAM.vh";
	`include "DDR3SDRAM.vh";
	`include "AES.vh";
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	input	[ORAMU-1:0]		ROPAddr;
    input					ROAccess, REWRoundDummy, DRAMInitComplete;
	
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
	input 						IVPathSelect;		// which path are we verifying now? 0 input path, 1 output path
	input 						IVRequest, IVWrite;
	input 	[PthBSTWidth-1:0] 	IVAddress;
	output 	[DDRDWidth-1:0]  	DataFromIV;
	input 	[DDRDWidth-1:0]  	DataToIV;
	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
    wire RWAccess;
    
    assign RWAccess = DRAMInitComplete && !ROAccess;
    
		//--------------------------------------------------------------------------
	// CC handles header write back
	//-------------------------------------------------------------------------- 
              
	// distinguish headers from payloads
	wire ProcessingHeader;
    wire  [`log2(BktSize_DRBursts)-1:0] BlkCtr;   
	
	CountAlarm #(		.Threshold(				BktSize_DRBursts))
		blk_ctr 	(	.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				FromDecDataValid && FromDecDataReady),
						.Count(					BlkCtr)
					);
	
	assign ProcessingHeader = BlkCtr < BktHSize_DRBursts;
					
	wire HeaderInReady, HeaderInValid, HeaderOutReady, HeaderOutValid;
	wire [DDRDWidth-1:0]	HeaderIn;
	wire [DDRDWidth-1:0]	HeaderOut;
	
	assign HeaderInValid = ROAccess && FromDecDataValid && ProcessingHeader;	 
	always @ (posedge Clock) begin		
		if (!Reset && HeaderInValid && !HeaderInReady) begin
			$display("Error: Header Buffer Overflow!");
			$finish;
		end
	end
	
	// invalidate bit for the target block
	wire [ORAMZ-1:0]        ValidBitsIn, ValidBitsOut;
	genvar j;
	for (j = 0; j < ORAMZ; j = j + 1) begin: VALID_BIT
		assign ValidBitsIn[j] = FromDecData[IVEntropyWidth+j];
		assign ValidBitsOut[j] = (ValidBitsIn[j] && ROAccess && !REWRoundDummy && ROPAddr == FromDecData[BktHULStart + (j+1)*ORAMU - 1: BktHULStart + j*ORAMU]) ? 0 : ValidBitsIn[j];                  
	end 
		 
	assign HeaderIn = {FromDecData[DDRDWidth-1:IVEntropyWidth+ORAMZ], ValidBitsOut, FromDecData[IVEntropyWidth-1:0]};
	
	// save the headers and write them back later     
	FIFORAM	#(          .Width(					DDRDWidth),     
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

	//------------------------------------------------------------------------------------
	// input path buffer. port1 written by AES, read by CC; port2 read by IV
	//------------------------------------------------------------------------------------
		
		wire 					IBufP1_Enable, IBufP2_Enable, IBufP1_Write, IBufP2_Write;
		wire [PthBSTWidth-1:0] 	IBufP1_Address, IBufP2_Address;
		wire [DDRDWidth-1:0] 	IBufP1_DIn, IBufP2_DIn, IBufP1_DOut, IBufP2_DOut;
		
		RAM		#(          .DWidth(				DDRDWidth),     
                            .AWidth(				PthBSTWidth),
							.NPorts(				2))
							
            in_path_buf  (	.Clock(					{2{Clock}}),
                            .Reset(					{2{Reset}}),
                            .Enable(				{IBufP1_Enable, IBufP2_Enable}),
                            .Write(					{IBufP1_Write, IBufP2_Write}),
                            .Address(				{IBufP1_Address, IBufP2_Address}),
                            .DIn(					{IBufP1_DIn, IBufP2_DIn}),
                            .DOut(					{IBufP1_DOut, IBufP2_DOut})
                        );     
		
		//--------------------------------------------------------------------------
		// Port1 : written by AES, read by CC
		//-------------------------------------------------------------------------- 
		
		// AES dumps data to input path on a RW access
		assign IBufP1_Enable = RWAccess && FromDecDataValid && FromDecDataReady;
		assign IBufP1_Write = 1;
		assign IBufP1_DIn = FromDecData;
		
		CountAlarm #(		.Threshold(				PathSize_DRBursts))
		in_blk_ctr 	(		.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				IBufP1_Enable),
							.Done(					IVStart),
							.Count(					IBufP1_Address)
					);
					
		//--------------------------------------------------------------------------
		// Port2 : read only by IV
		//-------------------------------------------------------------------------- 
		assign  IBufP2_Enable = IVRequest && !IVPathSelect;
		assign  IBufP2_Write = IVWrite;
		assign  IBufP2_Address = IVAddress;
		assign  IBufP2_DIn = DataFromIV;		
		
	//------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------ 
		
	//------------------------------------------------------------------------------------
	// output path buffer. port1 written by Stash, read by AES; port2 read and written by IV
	//------------------------------------------------------------------------------------
		reg  					OPathRW;
		wire					OPathRW_Transition, OBufP1_Transfer, OBufP2_Transfer;
		wire 					OBufP1_Enable, OBufP2_Enable, OBufP1_Write, OBufP2_Write;
		wire [PthBSTWidth-1:0] 	OBufP1_Address, OBufP2_Address;
		wire [DDRDWidth-1:0] 	OBufP1_DIn, OBufP2_DIn, OBufP1_DOut, OBufP2_DOut;
		
		RAM		#(          .DWidth(				DDRDWidth),     
                            .AWidth(				PthBSTWidth),
							.NPorts(				2))
							
            out_path_buf  (	.Clock(					{2{Clock}}),
                            .Reset(					{2{Reset}}),
                            .Enable(				{OBufP1_Enable, OBufP2_Enable}),
                            .Write(					{OBufP1_Write, OBufP2_Write}),
                            .Address(				{OBufP1_Address, OBufP2_Address}),
                            .DIn(					{OBufP1_DIn, OBufP2_DIn}),
                            .DOut(					{OBufP1_DOut, OBufP2_DOut})
                        );     
		
		//--------------------------------------------------------------------------
		// Port1 : written by Stash, read by AES
		//-------------------------------------------------------------------------- 
		wire [DDRDWidth-1:0] 	OBufP1Reg_DOut;
		wire 					OBufP1Reg_InValid, OBufP1Reg_InReady, OBufP1Reg_OutValid, OBufP1Reg_OutReady;
		wire [1:0]				OBufP1Reg_EmptyCount;
		
		FIFORAM #(			.Width(					DDRDWidth),
							.Buffering(				2))
			out_path_reg (	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				OBufP1_DOut),
							.InValid(				OBufP1Reg_InValid),
							.InAccept(				OBufP1Reg_InReady),
							.InEmptyCount(			OBufP1Reg_EmptyCount),
							.OutData(				OBufP1Reg_DOut),
							.OutSend(				OBufP1Reg_OutValid),
							.OutReady(				OBufP1Reg_OutReady));
		
		
		// Who has the port now. OPathRW == 0, Stash writing the path; OPathRW == 1, AES reading the path
		always @(posedge Clock) begin
			if (Reset)
				OPathRW <= 1;
			else if (OPathRW_Transition)
				OPathRW = !OPathRW;
		end
		
		// Stash dumps data to output path 
		assign OBufP1_Enable = RWAccess && (OPathRW ? (FromStashDataValid && FromStashDataReady) : OBufP1Reg_EmptyCount > OBufP1Reg_InValid);
		assign OBufP1_Write = OPathRW;
		assign OBufP1_DIn = FromStashData;
		
		Register #(	.Width(1))
			to_enc_valid ( Clock, Reset, 1'b0, 1'b1, 	OBufP1_Enable && !OPathRW,	OBufP1Reg_InValid);
		
		assign OBufP1_Transfer = RWAccess && (OPathRW ? (FromStashDataValid && FromStashDataReady) : OBufP1_Enable);
		
		CountAlarm #(		.Threshold(				PathSize_DRBursts))
		out_blk_ctr (		.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				OBufP1_Transfer),
							.Count(					OBufP1_Address),
							.Done(					OPathRW_Transition)
					);
		
		//	AES --> Stash Passthrough 	
		assign	ToStashData =			FromDecData;
		assign	ToStashDataValid =		FromDecDataValid; 
		assign	FromDecDataReady = 		ToStashDataReady;

		//	ROAccess: header write back CC --> AES. RWAccess: OBufP1 --> AES
		assign	ToEncData =				RWAccess ? OBufP1Reg_DOut : ROAccess ? HeaderOut : FromStashData;
		assign	ToEncDataValid =		RWAccess ? OBufP1Reg_OutValid && IVDone: ROAccess ? HeaderOutValid : FromStashDataValid;
		assign  OBufP1Reg_OutReady = 	RWAccess && ToEncDataReady && IVDone;
		
		assign	FromStashDataReady = 	!DRAMInitComplete ? ToEncDataReady : !ROAccess;
		
		//--------------------------------------------------------------------------
		// Port2 : written by Stash, read and written by IV
		//-------------------------------------------------------------------------- 
		assign  OBufP2_Enable = IVRequest && IVPathSelect;
		assign  OBufP2_Write = IVWrite;
		assign  OBufP2_Address = IVAddress;
		assign  OBufP2_DIn = DataFromIV;		
		
		assign  DataToIV = IVPathSelect ? OBufP2_DOut : IBufP2_DOut;
		
	end else begin: NO_BUF
	
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
