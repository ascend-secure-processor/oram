
`timescale 1ps/100fs

//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

module ascend_vc707_testbench_HWTestHarness;

	localparam RESET_PERIOD = 200000; //in pSec  
	parameter CLKIN_PERIOD          = 5000;

  //**************************************************************************//
  // Wire Declarations
  //**************************************************************************//
  reg                                sys_rst_n;
  wire                               sys_rst;


  reg                     sys_clk_i;
  wire                               sys_clk_p;
  wire                               sys_clk_n;

  //**************************************************************************//
  // Reset Generation
  //**************************************************************************//
  initial begin
    sys_rst_n = 1'b0;
    #RESET_PERIOD
      sys_rst_n = 1'b1;
   end

   assign sys_rst = ~sys_rst_n;

  //**************************************************************************//
  // Clock Generation
  //**************************************************************************//

  initial
    sys_clk_i = 1'b0;
  always
    sys_clk_i = #(CLKIN_PERIOD/2.0) ~sys_clk_i;

  assign sys_clk_p = sys_clk_i;
  assign sys_clk_n = ~sys_clk_i;

	//--------------------------------------------------------------------------
	//	CUT
	//--------------------------------------------------------------------------

	parameter				ORAMB =					512,
							ORAMU =					32,
							ORAML =					25,
							ORAMZ =					5,
							ORAMC =					10;

	parameter				FEDWidth =				64,
							BEDWidth =				512; // TODO this will be higher!							
								
	parameter				Overclock =				1;
								
	parameter 				DDR_nCK_PER_CLK = 		4,
							DDRDQWidth =			64,
							DDRCWidth =				3,
							DDRAWidth =				28;
								
	parameter				IVEntropyWidth =		64;	
		
	parameter				SystemClockFreq =		100_000_000;
	
	`include "PathORAMBackendLocal.vh"
	`include "TestHarnessLocal.vh"

	wire	[UARTWidth-1:0]	UARTDataIn;
	wire					UARTDataInValid, UARTDataInReady;
	
	wire					uart_txd, uart_rxd;

	wire	[TimeWidth-1:0]	CmdCount;
	wire	[THPWidth-1:0]	UARTShftDataIn;
	wire					UARTShftDataInValid, UARTShftDataInReady;
	
	Counter		#(			.Width(					TimeWidth))
				rd_ret_cnt(	.Clock(					sys_clk_p),
							.Reset(					sys_rst),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				UARTShftDataInValid & UARTShftDataInReady),
							.In(					{TimeWidth{1'bx}}),
							.Count(					CmdCount));

	assign	UARTShftDataIn =						(CmdCount == 0) ? {8'd0, 32'hdeadbeef, 32'h0, 32'd0} : 
													(CmdCount == 1) ? {8'd1, 32'hf0000000, 32'hf, 32'd128} : 
													(CmdCount == 2) ? {8'd2, 32'hf0000001, 32'h2f, 32'd256} :
													(CmdCount == 3) ? {8'd3, 32'hf0000002, 32'h3f, 32'd512} :
													(CmdCount == 4) ? {8'd0, 32'hf0000003, 32'h4f, 32'd1024} :
													{8'hff, 32'h0, 32'h0, 32'd512};
	assign	UARTShftDataInValid =					CmdCount < 6;
	
	FIFOShiftRound #(		.IWidth(				THPWidth),
							.OWidth(				UARTWidth),
							.Reverse(				1))
				uart_shft(	.Clock(					sys_clk_p),
							.Reset(					sys_rst),
							.InData(				UARTShftDataIn),
							.InValid(				UARTShftDataInValid),
							.InAccept(				UARTShftDataInReady),
							.OutData(				UARTDataIn),
							.OutValid(				UARTDataInValid),
							.OutReady(				UARTDataInReady));
	
	UART		#(			.ClockFreq(				200_000_000),
							.Baud(					UARTBaud),
							.Width(					UARTWidth))
				uart(		.Clock(					sys_clk_p), 
							.Reset(					sys_rst), 
							.DataIn(				UARTDataIn), 
							.DataInValid(			UARTDataInValid), 
							.DataInReady(			UARTDataInReady), 
							.DataOut(				), 
							.DataOutValid(			), 
							.DataOutReady(			), 
							.SIn(					uart_txd), 
							.SOut(					uart_rxd));
				
	ascend_vc707 #(			.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.Overclock(				Overclock),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),							
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth),
							.SystemClockFreq(		SystemClockFreq))
				CUT(		.sys_clk_p(				sys_clk_p),
							.sys_clk_n(				sys_clk_n),

							.sys_rst(				sys_rst),

							.uart_txd(				uart_txd),
							.uart_rxd(				uart_rxd));

	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
