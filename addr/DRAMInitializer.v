
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
	`include "BucketLocal.vh"
	`include "CommandsLocal.vh"

	parameter					IV =				IVINITValue;

	localparam					Space = 			BktHSize_RndBits - AESEntropy - BktHSize_ValidBits;
	localparam					NumBSTHFlits =		NumBuckets,
								NumBEDHFlits =		NumBuckets * `divceil(DDRDWidth, BEDWidth), // num header flits in tree in BEDWidth chunks
								BANWidth =			`log2(NumBSTHFlits),
								BAWidth =			`log2(NumBEDHFlits);

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

	output	[BEDWidth-1:0]		DRAMWriteData;
	output						DRAMWriteDataValid;
	input						DRAMWriteDataReady;

	//--------------------------------------------------------------------------
	//	Status interface
	//--------------------------------------------------------------------------

	output 						Done;

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	wire	[BANWidth-1:0] 		DRAMWriteCount_Inner;
	wire	[BAWidth-1:0] 		DRAMWriteCount_Outer;

	wire	[DDRDWidth-1:0]		DRAMWriteData_Pre;
	wire						DRAMWriteDataValid_Pre, DRAMWriteDataReady_Pre;
	wire						AddressDone, DataDone;

	//--------------------------------------------------------------------------
	//	Commands
	//--------------------------------------------------------------------------

	assign	Done =									AddressDone & DataDone;

	Counter		#(			.Width(					DDRAWidth),
							.Factor(				BktSize_DRWords))
				cmd_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DRAMCommandValid & DRAMCommandReady),
							.In(					{DDRAWidth{1'bx}}),
							.Count(					DRAMCommandAddress));

	assign	DRAMCommand =							DDR3CMD_Write;
	assign	DRAMCommandValid =						DRAMCommandAddress != LastBuckerAddr;

	assign	AddressDone =							~DRAMCommandValid;

	//--------------------------------------------------------------------------
	//	Write data
	//--------------------------------------------------------------------------

	Counter		#(			.Width(					BANWidth))
				wrt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DRAMWriteDataValid_Pre & DRAMWriteDataReady_Pre),
							.In(					{BANWidth{1'bx}}),
							.Count(					DRAMWriteCount_Inner));

	assign	DRAMWriteData_Pre = 					{
														{Space{1'bx}},
														{BktHSize_ValidBits{1'b0}},
														IV
													};
	assign	DRAMWriteDataValid_Pre =				DRAMWriteCount_Inner != NumBSTHFlits;

	generate if (BEDWidth < DDRDWidth) begin:NARROW_BEDWIDTH
		FIFOShiftRound #(	.IWidth(				DDRDWidth),
							.OWidth(				BEDWidth),
                                        .Reverse(1))
				in_DR_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMWriteData_Pre),
							.InValid(				DRAMWriteDataValid_Pre),
							.InAccept(				DRAMWriteDataReady_Pre),
							.OutData(				DRAMWriteData),
							.OutValid(				DRAMWriteDataValid),
							.OutReady(				DRAMWriteDataReady));

		Counter		#(		.Width(					BAWidth))
				wrt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DRAMWriteDataValid & DRAMWriteDataReady),
							.In(					{BAWidth{1'bx}}),
							.Count(					DRAMWriteCount_Outer));

		assign	DataDone =							DRAMWriteCount_Outer == NumBEDHFlits;
	end else begin:WIDE_BEDWIDTH
		assign	DRAMWriteData =						DRAMWriteData_Pre;
		assign	DRAMWriteDataValid =				DRAMWriteDataValid_Pre;
		assign	DRAMWriteDataReady_Pre =			DRAMWriteDataReady;

		assign	DataDone =							DRAMWriteCount_Inner == NumBEDHFlits;
	end endgenerate

	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
