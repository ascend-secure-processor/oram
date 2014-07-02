
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		StashToDRAM
//	Desc:		The inverse of DRAMToStash -- see that module for documentation. 
//==============================================================================
module StashToDRAM(
	Clock, Reset,

	StashData, StashValid, StashReady,
	StashPAddr, StashLeaf,
	OperationComplete,
	
	DRAMData, DRAMValid, DRAMReady
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	
	`include "BucketLocal.vh"
	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	
	localparam				SpaceRemaining =		BktHSize_RndBits - BktHSize_RawBits;
	
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;

	//--------------------------------------------------------------------------
	//	Stash Interface
	//--------------------------------------------------------------------------
	
	input	[BEDWidth-1:0]	StashData;
	input	[ORAMU-1:0]		StashPAddr;
	input	[ORAML-1:0]		StashLeaf;
	input					StashValid;
	output					StashReady;
	input					OperationComplete;	
	
	//--------------------------------------------------------------------------
	//	DRAM Interface
	//--------------------------------------------------------------------------

	output	[BEDWidth-1:0]	DRAMData;
	output					DRAMValid;
	input					DRAMReady;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
		
	wire					HeaderUpShift_InReady;
	wire					HeaderUpShift_OutValid, HeaderUpShift_OutReady;

	wire	[ORAMZ-1:0] 	HeaderUpShift_ValidBits;
	wire	[BigUWidth-1:0]	HeaderUpShift_PAddrs;
	wire	[BigLWidth-1:0]	HeaderUpShift_Leaves;	

	wire	[DDRDWidth-1:0]	DataUpShift_OutData;
	wire					DataUpShift_OutValid, DataUpShift_OutReady;

	wire					WritebackBlockIsValid;
	wire 					WritebackBlockCommit;
	
	wire 					WritebackProcessingHeader;		
	wire	[DDRDWidth-1:0]	UpShift_HeaderFlit, BucketBuf_OutData;
	wire					BucketBuf_OutValid, BucketBuf_OutReady;
							
	wire					BucketWritebackValid;
	wire	[BBSTWidth-1:0] BucketWritebackCtr;
							
	wire	[DDRDWidth-1:0]	UpShift_DRAMWriteData;
				
	//--------------------------------------------------------------------------
	//	Data path
	//--------------------------------------------------------------------------
	
	// Translate:
	//		{Z{ULD}} (the stash's format) 
	//		to 
	//		{ {Z{U}}, {Z{L}}, {Z{L}} } (the DRAM's format)
	
	// Note: It is probably best that Stash computes these; not changing them now to save time
	assign	WritebackBlockIsValid =					StashPAddr != DummyBlockAddress;
	assign	WritebackBlockCommit =					OperationComplete & StashValid & StashReady;
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (~HeaderUpShift_InReady & WritebackBlockCommit) begin
				$display("[%m @ %t] ERROR: Illegal signal combination (data will be lost)", $time);
				$finish;
			end
		end
	`endif
	
	FIFOShiftRound #(		.IWidth(				ORAMU),
							.OWidth(				BigUWidth))
				out_U_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				StashPAddr),
							.InValid(				WritebackBlockCommit),
							.InAccept(				HeaderUpShift_InReady),
							.OutData(			    HeaderUpShift_PAddrs),
							.OutValid(				HeaderUpShift_OutValid),
							.OutReady(				HeaderUpShift_OutReady));
	ShiftRegister #(		.PWidth(				BigLWidth),
							.SWidth(				ORAML))
				out_L_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				WritebackBlockCommit), 
							.SIn(					StashLeaf), 
							.POut(					HeaderUpShift_Leaves));							
	ShiftRegister #(		.PWidth(				ORAMZ),
							.SWidth(				1))
				out_V_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				WritebackBlockCommit), 
							.SIn(					WritebackBlockIsValid), 
							.POut(					HeaderUpShift_ValidBits));
	FIFOShiftRound #(		.IWidth(				BEDWidth),
							.OWidth(				DDRDWidth))
				out_D_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				StashData),
							.InValid(				StashValid),
							.InAccept(				StashReady),
							.OutData(			    DataUpShift_OutData),
							.OutValid(				DataUpShift_OutValid),
							.OutReady(				DataUpShift_OutReady));
							
	// FUNCTIONALITY: We output (U, L, D) tuples; we need to buffer whole bucket 
	// so that we can write back to DRAM in {Header, Payload} order
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				BktPSize_DRBursts))
				out_bkt_buf(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DataUpShift_OutData),
							.InValid(				DataUpShift_OutValid),
							.InAccept(				DataUpShift_OutReady),
							.OutData(				BucketBuf_OutData),
							.OutSend(				BucketBuf_OutValid),
							.OutReady(				BucketBuf_OutReady));

	assign	WritebackProcessingHeader =				BucketWritebackCtr < BktHSize_DRBursts;
	
	assign	UpShift_HeaderFlit =					{	{SpaceRemaining{1'b0}},
														HeaderUpShift_Leaves,
														HeaderUpShift_PAddrs,
														{BktHWaste_ValidBits{1'b0}},
														HeaderUpShift_ValidBits, 
														IVINITValue	};
	assign	UpShift_DRAMWriteData =					(WritebackProcessingHeader) ? UpShift_HeaderFlit : BucketBuf_OutData;

	assign	BucketWritebackValid =					(WritebackProcessingHeader & 	HeaderUpShift_OutValid) | 
													(~WritebackProcessingHeader & 	BucketBuf_OutValid);

	CountAlarm  #(  		.Threshold(             BktHSize_DRBursts + BktPSize_DRBursts))
				out_bkt_cnt(.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				BucketWritebackValid & DRAMReady),
							.Count(					BucketWritebackCtr));
	
	assign	DRAMData = 								UpShift_DRAMWriteData;
	assign	DRAMValid = 							BucketWritebackValid;	

	assign	BucketBuf_OutReady =					~WritebackProcessingHeader & DRAMReady;
	assign	HeaderUpShift_OutReady =				WritebackProcessingHeader & DRAMReady;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
