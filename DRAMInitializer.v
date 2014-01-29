
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		DRAMInitializer
//	Desc:		Initializes each bucket's valid bits, after DDR3 initialization
//				is complete.  This must occur before the first real/dummy ORAM
//				request.
//------------------------------------------------------------------------------
module DRAMInitializer #(	`include "PathORAM.vh", `include "DDR3SDRAM.vh", 
							`include "AES.vh") (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 						Clock, Reset,

	//--------------------------------------------------------------------------
	//	Data return interface (ORAM controller -> LLC)
	//--------------------------------------------------------------------------

	output	[DDRAWidth-1:0]		DRAMCommandAddress,
	output	[DDRCWidth-1:0]		DRAMCommand,
	output						DRAMCommandValid,
	input						DRAMCommandReady,

	output	[DDRDWidth-1:0]		DRAMWriteData,
	output	[DDRMWidth-1:0]		DRAMWriteMask,
	output						DRAMWriteDataValid,
	input						DRAMWriteDataReady,
	
	//--------------------------------------------------------------------------
	//	Status interface
	//--------------------------------------------------------------------------

	output 						Done
	);

	//--------------------------------------------------------------------------
	//	Constants
	//-------------------------------------------------------------------------- 
	
	`include "PathORAMLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	
	localparam					SpaceRemaining = 	BktSize_HeaderRnd - 2 * IVEntropyWidth - BktSize_ValidBits;
	localparam					EndOfTreeAddr =		BktSize_DDRWords * (ORAMN + 1); // this is the first non-existant bucket
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 

	wire	[DDRAWidth-1:0] 	DRAMWriteCount;
	
	//--------------------------------------------------------------------------
	//	Address generation
	//-------------------------------------------------------------------------- 
	
	Counter		#(			.Width(					DDRAWidth),
							.Factor(				BktSize_DDRWords))
				cmd_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DRAMCommandValid & DRAMCommandReady),
							.In(					{DDRAWidth{1'bx}}),
							.Count(					DRAMCommandAddress));
							
	Counter		#(			.Width(					DDRAWidth),
							.Factor(				BktSize_DDRWords))
				wrt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DRAMWriteDataValid & DRAMWriteDataReady),
							.In(					{DDRAWidth{1'bx}}),
							.Count(					DRAMWriteCount));							
	
	assign	DRAMCommandValid =						DRAMCommandAddress != EndOfTreeAddr;
	assign	DRAMWriteDataValid =					DRAMWriteCount != EndOfTreeAddr;
	assign	Done =									~DRAMCommandValid & ~DRAMWriteDataValid;
	
	assign	DRAMCommand =							DDR3CMD_Write;
	
	// TODO set initialization vectors to real values when we add AES
	assign	DRAMWriteData = 						{{IVEntropyWidth{1'bx}}, {BktSize_ValidBits{1'b0}}, {IVEntropyWidth{1'bx}}, {SpaceRemaining{1'bx}}};
	assign	DRAMWriteMask =							{DDRMWidth{1'b0}}; // enable all bits
	
	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

