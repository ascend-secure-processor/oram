
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
	StashPAddr, StashLeaf, StashMAC,
	OperationComplete,
	
	DRAMData, DRAMValid, DRAMReady
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "StashLocal.vh"
	
	localparam				Space =					RHWidth - BktHSize_RawBits,
							BBEDWidth =				`log2(BktSize_BEDChunks);
	
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
	input	[ORAMH-1:0]		StashMAC;
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
		
	wire					HeaderUp_InReady, HeaderUp_OutValid, HeaderUp_OutReady;

	wire	[ORAMZ-1:0] 	HeaderUp_ValidBits;
	wire	[BigUWidth-1:0]	HeaderUp_PAddrs;
	wire	[BigLWidth-1:0]	HeaderUp_Leaves;
	wire	[BigHWidth-1:0]	HeaderUp_MACs;

	wire					WritebackBlockIsValid;
	wire 					WritebackBlockCommit;
	
	wire	[BEDWidth-1:0]	HeaderOut;
	wire					HeaderOutValid, HeaderOutReady;
	
	wire	[BEDWidth-1:0]	PayloadOut;
	wire					PayloadOutValid, PayloadOutReady;	
	
	wire 					ReadingHeader;		
	wire	[RHWidth-1:0]	HeaderUp;
							
	wire	[BBEDWidth-1:0] BucketCtr;
				
	//--------------------------------------------------------------------------
	//	Data path
	//--------------------------------------------------------------------------
	
	// Note: It is probably best that Stash computes these; not changing them now to save time
	assign	WritebackBlockIsValid =					StashPAddr != DummyBlockAddress;
	assign	WritebackBlockCommit =					OperationComplete & StashValid & StashReady;
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (~HeaderUp_InReady & WritebackBlockCommit) begin
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
							.InAccept(				HeaderUp_InReady),
							.OutData(			    HeaderUp_PAddrs),
							.OutValid(				HeaderUp_OutValid),
							.OutReady(				HeaderUp_OutReady));
	ShiftRegister #(		.PWidth(				BigLWidth),
							.SWidth(				ORAML))
				out_L_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				WritebackBlockCommit), 
							.SIn(					StashLeaf), 
							.POut(					HeaderUp_Leaves));
	generate if (EnableIV) begin:MAC
		ShiftRegister #(	.PWidth(				BigHWidth),
							.SWidth(				ORAMH))
				out_H_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				WritebackBlockCommit), 
							.SIn(					StashMAC), 
							.POut(					HeaderUp_MACs));							
	end endgenerate
	ShiftRegister #(		.PWidth(				ORAMZ),
							.SWidth(				1))
				out_V_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				WritebackBlockCommit), 
							.SIn(					WritebackBlockIsValid), 
							.POut(					HeaderUp_ValidBits));
						
	assign	HeaderUp =								{	
														(EnableIV) ? 	{{Space{1'b0}}, HeaderUp_MACs} : 
																		 {Space{1'b0}},
														HeaderUp_Leaves,
														HeaderUp_PAddrs,
														{BktHWaste_ValidBits{1'b0}},
														HeaderUp_ValidBits, 
														IVINITValue	
													};
	
	FIFOShiftRound #(		.IWidth(				RHWidth),
							.OWidth(				BEDWidth),
							.Reverse(				1))
				out_DR_shft(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderUp),
							.InValid(				HeaderUp_OutValid),
							.InAccept(				HeaderUp_OutReady),
							.OutData(				HeaderOut),
							.OutValid(				HeaderOutValid),
							.OutReady(				HeaderOutReady));
	
	// PERFORMANCE/FUNCTIONALITY: We output (U, L, D) tuples; we need to buffer 
	// whole bucket so that we can write back to DRAM in {Header, Payload} order
	FIFORAM		#(			.Width(					BEDWidth),
							.Buffering(				BktPSize_BEDChunks))
				out_D_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				StashData),
							.InValid(				StashValid),
							.InAccept(				StashReady),
							.OutData(				PayloadOut),
							.OutSend(				PayloadOutValid),
							.OutReady(				PayloadOutReady));

	assign	ReadingHeader =							BucketCtr < BktHSize_BEDChunks;

	CountAlarm  #(  		.Threshold(             BktSize_BEDChunks))
				out_bkt_cnt(.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				DRAMValid & DRAMReady),
							.Count(					BucketCtr));
		
	//--------------------------------------------------------------------------
	//	DRAM Interface
	//--------------------------------------------------------------------------
	
	assign	DRAMData =								(ReadingHeader) ? HeaderOut : PayloadOut;

	assign	DRAMValid =								( ReadingHeader & 	HeaderOutValid) | 
													(~ReadingHeader & 	PayloadOutValid);

	assign	PayloadOutReady =						 ~ReadingHeader & 	DRAMReady;
	assign	HeaderOutReady =						  ReadingHeader & 	DRAMReady;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
