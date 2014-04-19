
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale 1ps/1ps

//==============================================================================
//	Module:		HWTestHarnessTop
//	Desc: 		
//==============================================================================
module HWTestHarnessTop (
			// GPIO
			output	[7:0]	led,

			// System
			input			sys_clk_p,
			input			sys_clk_n,
			input			sys_rst,
			
			// UART / Serial
			output			uart_txd,
			input			uart_rxd
	);
	
	//------------------------------------------------------------------------------
	//	Constants
	//------------------------------------------------------------------------------
	
	// ORAM related
	
	`include "BucketLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	`include "TestHarnessLocal.vh"
	
	parameter				ORAMB =					512,
							ORAMU =					32,
							ORAML =					25,
							ORAMZ =					5,
							ORAMC =					10;

	parameter				FEDWidth =				64,
							BEDWidth =				512;
								
	parameter				Overclock =				1;
								
	parameter 				DDR_nCK_PER_CLK = 		4,
							DDRDQWidth =			64,
							DDRCWidth =				3,
							DDRAWidth =				28;
								
	parameter				IVEntropyWidth =		64;	
	

    parameter				NumValidBlock = 		1024,
							Recursion = 			3,
							MaxLogRecursion = 		4;
	
    parameter				LeafWidth = 			32,
							PLBCapacity = 			8192;

	// uBlaze/caches/System
	
	parameter				SystemClockFreq =		100_000_000;
	
	//------------------------------------------------------------------------------
	//	Wires & Regs
	//------------------------------------------------------------------------------
	
	wire					ClockF200;
	wire					ClockF200_Bufg;
	wire					ClockF100;
	wire					MMCMF100Locked;
	
	(* mark_debug = "FALSE" *)	wire				ResetF100, ResetF200;

	// ORAM
	
	wire	[BECMDWidth-1:0] PathORAM_Command;
	wire	[ORAMU-1:0]		PathORAM_PAddr;
	wire					PathORAM_CommandValid, PathORAM_CommandReady;
	
	wire	[FEDWidth-1:0]	PathORAM_DataIn;
	wire					PathORAM_DataInValid, PathORAM_DataInReady;

	wire	[FEDWidth-1:0]	PathORAM_ReturnData;
	wire 					PathORAM_ReturnDataValid, PathORAM_ReturnDataReady;

	//------------------------------------------------------------------------------
	// 	Clocking
	//------------------------------------------------------------------------------

	IBUFGDS	clk_f200_p(		.I(						sys_clk_p),
							.IB(					sys_clk_n),
							.O(						ClockF200_Bufg));
    BUFG 	clk_f200(		.I(						ClockF200_Bufg),
							.O(						ClockF200));
	assign	ResetF200 =								sys_rst;

	F100ClockGen clk_div_2(	.clk_in1(				ClockF200),
							.clk_out1(				ClockF100),
							.reset(					ResetF200),
							.locked(				MMCMF100Locked));
	assign	ResetF100 =								~MMCMF100Locked;
	
	//------------------------------------------------------------------------------
	// 	GPIO
	//------------------------------------------------------------------------------

	// do something with this
	assign	led[7:2] = 								0;

	//------------------------------------------------------------------------------
	// 	CUT & loopback
	//------------------------------------------------------------------------------
	
	HWTestHarness #(		.ORAMU(					ORAMU),
							.SlowClockFreq(			SystemClockFreq))
				tester(		.SlowClock(				ClockF100),
							.FastClock(				ClockF200),
							.SlowReset(				ResetF100), 
							.FastReset(				ResetF200),
							
							.ORAMCommand(			PathORAM_Command),
							.ORAMPAddr(				PathORAM_PAddr),
							.ORAMCommandValid(		PathORAM_CommandValid),
							.ORAMCommandReady(		PathORAM_CommandReady),
							
							.ORAMDataIn(			PathORAM_DataIn),
							.ORAMDataInValid(		PathORAM_DataInValid),
							.ORAMDataInReady(		PathORAM_DataInReady),
							
							.ORAMDataOut(			PathORAM_ReturnData),
							.ORAMDataOutValid(		PathORAM_ReturnDataValid),
							.ORAMDataOutReady(		PathORAM_ReturnDataReady),
							
							.UARTRX(				uart_rxd),
							.UARTTX(				uart_txd),
							
							.ErrorReceiveOverflow(	led[0]),
							.ErrorReceivePattern(	led[1]),	
							.ErrorSendOverflow(		led[2]));

	assign	PathORAM_CommandReady = 				1'b1;
							
	FIFORAM		#(			.Width(					FEDWidth),
							.Buffering(				16))
				loopback(	.Clock(					ClockF200),
							.Reset(					ResetF200),
							.InData(				PathORAM_DataIn),
							.InValid(				PathORAM_DataInValid),
							.InAccept(				PathORAM_DataInReady),
							.OutData(				PathORAM_ReturnData),
							.OutSend(				PathORAM_ReturnDataValid),
							.OutReady(				PathORAM_ReturnDataReady));

	//------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------