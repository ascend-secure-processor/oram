
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		DRAMInitializer
//	Desc:		Initializes each bucket's valid bits
//------------------------------------------------------------------------------
module DRAMInitializer #(`include "PathORAM.vh", `include "DDR3SDRAM.vh") (
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
	
	`include "BucketLocal.vh"
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	//--------------------------------------------------------------------------
	//	Address generation
	//-------------------------------------------------------------------------- 
	
	Counter		#(			.Width(					DDRAWidth),
							.Factor(				BktSize_DDRWords))
				cmd_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				),
							.In(					{DDRAWidth{1'bx}}),
							.Count(					DRAMCommandAddress));
							
	Counter		#(			.Width(					DDRAWidth),
							.Factor(				BktSize_DDRWords))
				wrt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				),
							.In(					{DDRAWidth{1'bx}}),
							.Count(					DRAMCommandAddress));							
	
	assign	Done =									; // reached max addr
	
	assign	DRAMCommand =							DDR3CMD_Write;
	assign	DRAMCommandValid =						~Done;
	
	// TODO set initialization vectors to real values when we add AES
	assign	DRAMWriteData = 						{ {IVEntropyWidth{1'bx}}, {BktSize_ValidBits{1'b0}}, {IVEntropyWidth{1'bx}},  };
	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

