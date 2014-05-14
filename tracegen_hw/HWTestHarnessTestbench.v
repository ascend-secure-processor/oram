
`timescale 1ps/100fs

//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

module HWTestHarnessTestbench;

	localparam RESET_PERIOD = 200000; //in pSec  
	parameter CLKIN_PERIOD          = 5000;

  //**************************************************************************//
  // Wire Declarations
  //**************************************************************************//
  reg                                sys_rst_n;
  wire                               sys_rst;


  reg								sys_clk_i;
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

	parameter				SystemClockFreq =		100_000_000,
							ORAMClockFreq =			200_000_000,
							GenHistogram =			1;
		
	parameter				ORAMB = 				CUT.ORAMB;
	parameter				ORAMU = 				CUT.ORAMU;
	parameter				FEDWidth =				CUT.FEDWidth;
	
	`include "PathORAMBackendLocal.vh"
	`include "TestHarnessLocal.vh"

	wire	[UARTWidth-1:0]	UARTDataIn;
	wire					UARTDataInValid, UARTDataInReady;
	
	wire					uart_txd, uart_rxd;

	wire	[TimeWidth-1:0]	CmdCount;
	wire	[THPWidth-1:0]	UARTShftDataIn;
	wire					UARTShftDataInValid, UARTShftDataInReady;
	
	wire	[UARTWidth-1:0]	UARTDataOut;
	wire					UARTDataOutValid, UARTDataOutReady;
	
	wire	[DBaseWidth-1:0] RecvData;
	wire					RecvDataValid;
	
	Counter		#(			.Width(					TimeWidth))
				rd_ret_cnt(	.Clock(					sys_clk_p),
							.Reset(					sys_rst),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				UARTShftDataInValid & UARTShftDataInReady),
							.In(					{TimeWidth{1'bx}}),
							.Count(					CmdCount));

	generate if (GenHistogram) begin
		assign	UARTShftDataIn =					(CmdCount == 0) ? 	{TCMD_Fill, 			32'hff, 	1 << 5, 	32'd1024} :
													(CmdCount == 1) ? 	{TCMD_CmdLin_AddrRnd, 	32'hff, 	1 << 5, 	32'd1024} : 
																		{TCMD_Start, 			32'h0, 		32'h0, 		32'd0};
	
		/*assign	UARTShftDataIn =					(CmdCount == 0) ? {8'd0, 32'h00000000, 32'h0, 32'd0} : // write
													(CmdCount == 1) ? {8'd0, 32'hf0000001, 32'h2f, 32'd0} : // write
													(CmdCount == 2) ? {8'd2, 32'hf0000000, 32'h3f, 32'd0} : 
													(CmdCount == 3) ? {8'd2, 32'hf0000001, 32'h4f, 32'd0} : 
													(CmdCount == 4) ? {8'd2, 32'hf0000001, 32'h4f, 32'd0} : 
													{8'hff, 32'h0, 32'h0, 32'd0};*/
		assign	UARTShftDataInValid =				CmdCount < 3;
	end else begin
		assign	UARTShftDataIn =					(CmdCount == 0) ? {8'd0, 32'hdeadbeef, 32'h0, 32'd0} : // write
													(CmdCount == 1) ? {8'd1, 32'hf0000000, 32'h2f, 32'd128} : // write
													(CmdCount == 2) ? {8'd2, 32'hf0000001, 32'h3f, 32'd256} : 
													(CmdCount == 3) ? {8'd3, 32'hf0000002, 32'h4f, 32'd512} : 
													(CmdCount == 4) ? {8'd0, 32'hf0000003, 32'h5f, 32'd1024} : // write
													{8'hff, 32'h0, 32'h0, 32'd512};
		assign	UARTShftDataInValid =				CmdCount < 6;
	end endgenerate
	
	FIFOShiftRound #(		.IWidth(				THPWidth),
							.OWidth(				UARTWidth),
							.Reverse(				1))
				uart_I_shft(.Clock(					sys_clk_p),
							.Reset(					sys_rst),
							.InData(				UARTShftDataIn),
							.InValid(				UARTShftDataInValid),
							.InAccept(				UARTShftDataInReady),
							.OutData(				UARTDataIn),
							.OutValid(				UARTDataInValid),
							.OutReady(				UARTDataInReady));
	
	UART		#(			.ClockFreq(				ORAMClockFreq),
							.Baud(					UARTBaud),
							.Width(					UARTWidth))
				uart(		.Clock(					sys_clk_p), 
							.Reset(					sys_rst), 
							.DataIn(				UARTDataIn), 
							.DataInValid(			UARTDataInValid), 
							.DataInReady(			UARTDataInReady), 
							.DataOut(				UARTDataOut), 
							.DataOutValid(			UARTDataOutValid), 
							.DataOutReady(			UARTDataOutReady), 
							.SIn(					uart_txd), 
							.SOut(					uart_rxd));
				
	FIFOShiftRound #(		.IWidth(				UARTWidth),
							.OWidth(				DBaseWidth))
				uart_O_shft(.Clock(					sys_clk_p),
							.Reset(					sys_rst),
							.InData(				UARTDataOut),
							.InValid(				UARTDataOutValid),
							.InAccept(				UARTDataOutReady),
							.OutData(				RecvData),
							.OutValid(				RecvDataValid),
							.OutReady(				1'b1));				
				
	always @(posedge sys_clk_p) begin
		if (RecvDataValid)
			$display("[%m @ %t] Received data = %x", $time, RecvData);
	end

	HWTestHarnessTop #(		.SystemClockFreq(		SystemClockFreq),
							.ORAMClockFreq(			ORAMClockFreq),
							.GenHistogram(			GenHistogram))
				CUT(		.sys_clk_p(				sys_clk_p),
							.sys_clk_n(				sys_clk_n),

							.sys_rst(				sys_rst),

							.uart_txd(				uart_txd),
							.uart_rxd(				uart_rxd));

	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
