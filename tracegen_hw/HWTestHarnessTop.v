
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale 1ns/1ns

//==============================================================================
//	Module:		HWTestHarnessTop
//	Desc: 		
//==============================================================================
module HWTestHarnessTop(
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
	
	parameter				ORAMU =					32,
							ORAMB =					512,
							ORAML =					10,
							ORAMZ =					5,			
							FEDWidth =				64,
							BEDWidth =				512;

	// uBlaze/caches/System
	
	parameter				SystemClockFreq =		100_000_000,
							ORAMClockFreq =			200_000_000,
							GenHistogram =			1;
	
	localparam  			Cycle = 				1000000000/ORAMClockFreq;	
	
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

	integer					NumAccess = 1;
	
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
	
	HWTestHarness #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),
							.SlowClockFreq(			SystemClockFreq),
							.GenHistogram(			1))
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
	
	generate if (GenHistogram) begin
		reg	[FEDWidth-1:0]	PathORAM_ReturnDataPre;
		reg 				PathORAM_ReturnDataValidPre = 1'b0;	
		integer	done, j;
		
		assign	PathORAM_DataInReady =				1'b1;
		
		assign	PathORAM_ReturnData =				PathORAM_ReturnDataPre;
		assign	PathORAM_ReturnDataValid =			PathORAM_ReturnDataValidPre;
		
		always @(posedge ClockF200) begin
			if (PathORAM_CommandValid & PathORAM_Command == BECMD_Read) begin
				j = 0;
				while (j < NumAccess * 6) begin
					#(Cycle);
					j = j + 1;
				end
				
				NumAccess = NumAccess + 1;
				
				done = 0;
				PathORAM_ReturnDataPre = 0;
				PathORAM_ReturnDataValidPre = 1'b1;
				while (done == 0) begin
					#(Cycle);
					if (PathORAM_ReturnDataValidPre & PathORAM_ReturnDataReady) begin
						PathORAM_ReturnDataPre = PathORAM_ReturnDataPre + 1;
						if (PathORAM_ReturnDataPre == FEORAMBChunks) 
							done = 1;
					end
				end
				PathORAM_ReturnDataValidPre = 1'b0;
			end
		end
	end else begin
		FIFORAM		#(		.Width(					FEDWidth),
							.Buffering(				16))
				loopback(	.Clock(					ClockF200),
							.Reset(					ResetF200),
							.InData(				PathORAM_DataIn),
							.InValid(				PathORAM_DataInValid),
							.InAccept(				PathORAM_DataInReady),
							.OutData(				PathORAM_ReturnData),
							.OutSend(				PathORAM_ReturnDataValid),
							.OutReady(				PathORAM_ReturnDataReady));
	end endgenerate
	
	//------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------