
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		HWTestHarness
//	Desc:		Connect PathORAMTop directly to a software routine, running on a 
//				host machine, which can send address requests directly to 
//				PathORAMTop
//==============================================================================
module HWTestHarness #(		`include "PathORAM.vh",

	parameter				SlowClockFreq =			100_000_000
	) (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
	
  	input 					SlowClock, FastClock,
	input					SlowReset, FastReset,

	//--------------------------------------------------------------------------
	//	CUT (ORAM) interface
	//--------------------------------------------------------------------------

	output	[BECMDWidth-1:0] ORAMCommand,
	output	[ORAMU-1:0]		ORAMPAddr,
	output					ORAMCommandValid,
	input					ORAMCommandReady,
	
	//--------------------------------------------------------------------------
	//	HW<->SW interface
	//--------------------------------------------------------------------------

	input					UARTRX,
	output					UARTTX
	);

	//--------------------------------------------------------------------------
	//	Constants
	//-------------------------------------------------------------------------- 
		
	`include "PathORAMBackendLocal.vh"
	`include "TestHarnessLocal.vh"
	
	//------------------------------------------------------------------------------
	// 	Wires & Regs
	//------------------------------------------------------------------------------
	
	(* mark_debug = "TRUE" *)	wire	[UARTWidth-1:0]	UARTDataIn;
	(* mark_debug = "TRUE" *)	wire				UARTDataInValid, UARTDataInReady;

	(* mark_debug = "TRUE" *)	wire	[UARTWidth-1:0] UARTDataOut;
	(* mark_debug = "TRUE" *)	wire				UARTDataOutValid, UARTDataOutReady;
	
	(* mark_debug = "TRUE" *)	wire	[THPWidth-1:0] CrossBufDataIn;
	(* mark_debug = "TRUE" *)	wire	[THPWidth-1:0] CrossBufDataOut;
	(* mark_debug = "TRUE" *)	wire				CrossBufDataInValid, CrossBufDataInReady;	
	
	(* mark_debug = "TRUE" *)	wire				CrossBufFull, CrossBufEmpty;
	(* mark_debug = "TRUE" *)	wire				CrossBufDataOutReady;
	
	(* mark_debug = "TRUE" *)	wire	[TCMDWidth-1:0]	SlowCommand, FastCommand;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]	FastPAddr;
	(* mark_debug = "TRUE" *)	wire	[DBaseWidth-1:0] FastDataBase;
	(* mark_debug = "TRUE" *)	wire	[TimeWidth-1:0]	FastTimeDelay;
	
	(* mark_debug = "TRUE" *)	wire				TimeGate;
	(* mark_debug = "TRUE" *)	wire	[TimeWidth-1:0]	PacketAge;
	
	(* mark_debug = "TRUE" *)	wire				StartGate, SlowStartSignal;
	(* mark_debug = "TRUE" *)	wire				FastStartSignal;
	(* mark_debug = "TRUE" *)	wire				FastStartSignal_Pre, StarCrossEmpty;
		
	(* mark_debug = "TRUE" *)	wire				BurstComplete;
	(* mark_debug = "TRUE" *)	wire				ORAMRegInValid, ORAMRegInReady;
	(* mark_debug = "TRUE" *)	wire				ORAMRegOutValid, ORAMRegOutReady;
	
	(* mark_debug = "TRUE" *)	wire	[TimeWidth-1:0]	ORAMTimeDelay;
	
	//------------------------------------------------------------------------------
	// 	HW<->SW Bridge (UART)
	//------------------------------------------------------------------------------	
	
	UART		#(			.ClockFreq(				SlowClockFreq),
							.Baud(					UARTBaud),
							.Width(					UARTWidth))
				uart(		.Clock(					SlowClock), 
							.Reset(					SlowReset), 
							.DataIn(				UARTDataIn), 
							.DataInValid(			UARTDataInValid), 
							.DataInReady(			UARTDataInReady), 
							.DataOut(				UARTDataOut), 
							.DataOutValid(			UARTDataOutValid), 
							.DataOutReady(			UARTDataOutReady), 
							.SIn(					UARTRX), 
							.SOut(					UARTTX));

	// Additional debugging
	FIFORegister #(			.Width(					UARTWidth))
				loopback(	.Clock(					SlowClock),
							.Reset(					SlowReset),
							.InData(				UARTDataOut),
							.InValid(				UARTDataOutValid),
							.InAccept(				),
							.OutData(				UARTDataIn),
							.OutSend(				UARTDataInValid),
							.OutReady(				UARTDataInReady));							
						
	//------------------------------------------------------------------------------
	// 	Clock crossing
	//------------------------------------------------------------------------------
						
	FIFOShiftRound #(		.IWidth(				UARTWidth),
							.OWidth(				THPWidth),
							.Reverse(				1))
				tst_shift(	.Clock(					SlowClock),
							.Reset(					SlowReset),
							.InData(				UARTDataOut),
							.InValid(				UARTDataOutValid),
							.InAccept(				UARTDataOutReady),
							.OutData(				CrossBufDataIn),
							.OutValid(				CrossBufDataInValid),
							.OutReady(				CrossBufDataInReady));

	assign	SlowCommand =							CrossBufDataIn[THPWidth-1:THPWidth-TCMDWidth];
	assign	SlowStartSignal =						SlowCommand == TCMD_Start;
	
	assign	CrossBufDataInReady =					~CrossBufFull;

	// ********************************						
	// Slow -> Fast clock crossing
	// ********************************

	CmdCross start_cross(	.rst(					SlowReset),
							.wr_clk(				SlowClock),
							.rd_clk(				FastClock),
							.din(					SlowStartSignal),
							.full(					),
							.wr_en(					CrossBufDataInValid & CrossBufDataInReady),
							.dout(					FastStartSignal_Pre),
							.empty(					StarCrossEmpty),
							.rd_en(					1'b1));	
	assign	FastStartSignal =						FastStartSignal_Pre & ~StarCrossEmpty;
	
	// 1024x104b FIFO
	HWTestBuffer tst_fifo(	.rst(					SlowReset),
							.wr_clk(				SlowClock),
							.rd_clk(				FastClock),
							.din(					CrossBufDataIn),
							.full(					CrossBufFull),
							.wr_en(					CrossBufDataInValid),
							.dout(					CrossBufDataOut),
							.empty(					CrossBufEmpty),
							.rd_en(					CrossBufDataOutReady));

	assign	{FastCommand, FastPAddr, FastDataBase, FastTimeDelay} =	CrossBufDataOut;
	assign	ORAMRegInValid =						StartGate & ~CrossBufEmpty & FastCommand != TCMD_Start;
	assign	CrossBufDataOutReady =					StartGate & ORAMRegInReady;
	
	//------------------------------------------------------------------------------
	// 	Start command gating
	//------------------------------------------------------------------------------

	assign	BurstComplete =							StartGate & CrossBufEmpty;
	
	Register	#(			.Width(					1))
				start_reg(	.Clock(					FastClock),
							.Reset(					FastReset | BurstComplete),
							.Set(					FastStartSignal),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					StartGate));
							
	FIFORegister #(			.Width(					BECMDWidth + ORAMU + TimeWidth))
				oram_freg(	.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				{FastCommand[BECMDWidth-1:0], 	FastPAddr, FastTimeDelay}),
							.InValid(				ORAMRegInValid),
							.InAccept(				ORAMRegInReady),
							.OutData(				{ORAMCommand, 					ORAMPAddr, ORAMTimeDelay}),
							.OutSend(				ORAMRegOutValid),
							.OutReady(				ORAMRegOutReady));

	//------------------------------------------------------------------------------
	// 	Time gating
	//------------------------------------------------------------------------------
							
	Counter		#(			.Width(					TimeWidth))
				time_cnt(	.Clock(					FastClock),
							.Reset(					FastReset | (TimeGate & ORAMCommandValid & ORAMCommandReady)),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				ORAMRegOutValid & ~TimeGate),
							.In(					{TimeWidth{1'bx}}),
							.Count(					PacketAge));
	assign	TimeGate =								PacketAge >= ORAMTimeDelay;							
							
	assign	ORAMCommandValid =						TimeGate & ORAMRegOutValid;
	assign	ORAMRegOutReady =						TimeGate & ORAMCommandReady;
	
	//------------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------