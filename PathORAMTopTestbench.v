
`timescale 1ps/100fs

//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

module PathORAMTopTestbench;

	localparam RESET_PERIOD = 200000; //in pSec  
	parameter CLKIN_PERIOD          = 5000;

	//**************************************************************************//
	// Wire Declarations
	//**************************************************************************//

	reg                                sys_rst_n;
	wire                               sys_rst;


	reg									sys_clk_i;
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

	// We need to declare these to make the local.vh files happy
	// NOTE: we don't want to pass params to CUT ... we want this to simulate 
	// ascend_vc707.v as accurately as possible
	parameter				ORAML = 				CUT.ORAML;
	parameter				ORAMB = 				CUT.ORAMB;
	parameter				ORAMU =					CUT.ORAMU;
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

	reg		[31:0]			InitWait = 0;
	reg						Start = 1'b0;
	
	always @(posedge sys_clk_p) begin
		InitWait <= InitWait + 1;
		if (InitWait == 250) Start <= 1'b1;
	end
	
	Counter		#(			.Width(					TimeWidth))
				rd_ret_cnt(	.Clock(					sys_clk_p),
							.Reset(					sys_rst),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				UARTShftDataInValid & UARTShftDataInReady),
							.In(					{TimeWidth{1'bx}}),
							.Count(					CmdCount));
							
													// CRUD Format:			Cmd   					PAddr		DataBase		TimeDelay
													// Seed Format:			Cmd						Seed		AccessCount		Offset
	assign	UARTShftDataIn =						{						TCMD_CmdRnd_AddrRnd, 	32'hff, 	1 << ORAML, 	32'd0};
													//{						TCMD_Start, 			32'h0, 		32'h0, 			32'd0};
													/*(CmdCount == 0) ? 	{8'd0, 	32'h0, 	32'h0, 		32'd0} :
													(CmdCount == 1) ? 	{8'd0, 	32'h1, 	32'hf, 		32'd0} : 
													(CmdCount == 2) ? 	{8'd0, 	32'h2, 	32'hff, 	32'd0} : 
													(CmdCount == 3) ? 	{8'd0, 	32'h3, 	32'h0, 		32'd0} :
													(CmdCount == 4) ? 	{8'd0, 	32'h4, 	32'hf, 		32'd0} : 
													(CmdCount == 5) ? 	{8'd0, 	32'h5, 	32'hff, 	32'd0} : 
													(CmdCount == 6) ? 	{8'd0, 	32'h6, 	32'h0, 		32'd0} :
													(CmdCount == 7) ? 	{8'd0, 	32'h7, 	32'hf, 		32'd0} : 
													
													(CmdCount == 8) ? 	{8'd2, 	32'h0, 	32'h0, 		32'd0} :
													(CmdCount == 9) ? 	{8'd2, 	32'h1, 	32'h0, 		32'd0} :
													(CmdCount == 10) ? 	{8'd2, 	32'h2, 	32'h0, 		32'd0} :
													(CmdCount == 11) ? 	{8'd2, 	32'h3, 	32'h0, 		32'd0} :
													(CmdCount == 12) ? 	{8'd2, 	32'h4, 	32'h0, 		32'd0} :
													(CmdCount == 13) ? 	{8'd2, 	32'h5, 	32'h0, 		32'd0} :
													(CmdCount == 14) ? 	{8'd2, 	32'h6, 	32'h0, 		32'd0} :
													(CmdCount == 15) ? 	{8'd2, 	32'h7, 	32'h0, 		32'd0} :
																		{8'hff, 32'h0, 	32'h0, 		32'd0}; */ // start
	assign	UARTShftDataInValid =					Start & CmdCount < 1;
	
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
	
	UART		#(			.ClockFreq(				200_000_000), // this much match sys_clk_p freq
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
	
	ascend_vc707 CUT(		.sys_clk_p(				sys_clk_p),
							.sys_clk_n(				sys_clk_n),

							.sys_rst(				sys_rst),

							.uart_txd(				uart_txd),
							.uart_rxd(				uart_rxd));

	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
