
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
//
//				TODO: 	this module can be re-implemented as the F-bit scheme 
//						from the ISCA paper
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
	`include "BucketDRAMLocal.vh"
	
	localparam					SpaceRemaining = 	BktHSize_RndBits - 2 * IVEntropyWidth - BktHSize_ValidBits;
	// localparam					EndOfTreeAddr =		BktSize_DRWords * ORAMN; // this is the first non-existent bucket
	localparam					EndOfTreeAddr =		BktSize_DRWords * ORAMN * 2;
	                                       //TODO: No. We waste some space due to subtree layout. 
	                                       // Let's be conservative and intialize much more. I'll calculate the exact end later. 
	localparam					BAWidth =			`log2(ORAMN) + 1;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 

	wire	[BAWidth-1:0] 		DRAMWriteCount;
	
	//--------------------------------------------------------------------------
	//	Address generation
	//-------------------------------------------------------------------------- 
	
	Counter		#(			.Width(					DDRAWidth),
							.Factor(				BktSize_DRWords))
				cmd_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DRAMCommandValid & DRAMCommandReady),
							.In(					{DDRAWidth{1'bx}}),
							.Count(					DRAMCommandAddress));
							
	Counter		#(			.Width(					BAWidth))
				wrt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DRAMWriteDataValid & DRAMWriteDataReady),
							.In(					{BAWidth{1'bx}}),
							.Count(					DRAMWriteCount));							
	
	assign	DRAMCommandValid =						DRAMCommandAddress != EndOfTreeAddr;
	assign	DRAMWriteDataValid =					DRAMWriteCount != ORAMN * 2;
	assign	Done =									~DRAMCommandValid & ~DRAMWriteDataValid;
	
	assign	DRAMCommand =							DDR3CMD_Write;
	
	// TODO set initialization vectors to real values when we add AES
	assign	DRAMWriteData = 						{	{SpaceRemaining{1'bx}}, 
														IVINITValue, 
														{BktHSize_ValidBits{1'b0}}, 
														IVINITValue	};
	assign	DRAMWriteMask =							{DDRMWidth{1'b0}}; // enable all bits
	
	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

