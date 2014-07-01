
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
//	Note: 		This module can be re-implemented as the F-bit scheme from the 
//				ISCA paper
//------------------------------------------------------------------------------
module DRAMInitializer(
	Clock, Reset, Done,
	
	DRAMCommandAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,

	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady
	);

	//--------------------------------------------------------------------------
	//	Constants
	//-------------------------------------------------------------------------- 

	`include "PathORAM.vh"
	
	`include "DDR3SDRAMLocal.vh"
	`include "ConstBucketHelpers.vh"
	`include "ConstCommands.vh"
	`include "SubTreeLocal.vh"
	
	parameter					IV =				IVINITValue;
	
	localparam					SpaceRemaining = 	BktHSize_RndBits - AESEntropy - BktHSize_ValidBits;
	
    localparam					EndOfTree =  		(1 << (ORAML + 1)) + numTotalST; // Last addr of the ORAM tree (in buckets). We waste one bucket per subtree.
    localparam					EndOfTreeAddr =  	EndOfTree * BktSize_DRWords;                                    
		                                       
	localparam					BAWidth =			`log2(EndOfTree);	
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------	
	
  	input 						Clock, Reset;

	//--------------------------------------------------------------------------
	//	Data return interface (ORAM controller -> LLC)
	//--------------------------------------------------------------------------
	
	output	[DDRAWidth-1:0]		DRAMCommandAddress;
	output	[DDRCWidth-1:0]		DRAMCommand;
	output						DRAMCommandValid;
	input						DRAMCommandReady;

	output	[DDRDWidth-1:0]		DRAMWriteData;
	output						DRAMWriteDataValid;
	input						DRAMWriteDataReady;
	
	//--------------------------------------------------------------------------
	//	Status interface
	//--------------------------------------------------------------------------

	output 						Done;
	
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
	assign	DRAMWriteDataValid =					DRAMWriteCount != EndOfTree;
	assign	Done =									~DRAMCommandValid & ~DRAMWriteDataValid;
	
	assign	DRAMCommand =							DDR3CMD_Write;
	
	assign	DRAMWriteData = 						{	{SpaceRemaining{1'bx}},  
														{BktHSize_ValidBits{1'b0}}, 
														IV	};
	
	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

