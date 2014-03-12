
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale 1ps/1ps

//==============================================================================
//	Module:		ascend_vc707
//	Desc: 		Top level module for the Ascend chip.
//==============================================================================
module ascend_vc707 #(	/*	`include "PathORAM.vh", `include "DDR3SDRAM.vh",
							`include "AES.vh", `include "Stash.vh" 	*/) (
			// GPIO
			output	[7:0]	led,

			// System
			input			sys_clk_p,
			input			sys_clk_n,
			input			sys_rst, // SW8

			// DDR3 SDRAM
			inout 	[63:0]	ddr3_dq,
			inout 	[7:0]	ddr3_dqs_n,
			inout 	[7:0]	ddr3_dqs_p,			
			output 	[13:0]	ddr3_addr,
			output 	[2:0]	ddr3_ba,
			output			ddr3_ras_n,
			output			ddr3_cas_n,
			output			ddr3_we_n,
			output			ddr3_reset_n,
			output 	[0:0]	ddr3_ck_p,
			output 	[0:0]	ddr3_ck_n,
			output 	[0:0]	ddr3_cke,
			output 	[0:0]	ddr3_cs_n,
			output 	[7:0]	ddr3_dm,
			output 	[0:0]	ddr3_odt,
			
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
								
	(* mark_debug = "FALSE" *)	wire				ResetF200;
	(* mark_debug = "FALSE" *)	wire				DDR3SDRAM_ResetDone;
	
	// ORAM
	
	wire	[BECMDWidth-1:0] PathORAM_Command;
	wire	[ORAMU-1:0]		PathORAM_PAddr;
	wire					PathORAM_CommandValid, PathORAM_CommandReady;
	
	wire	[FEDWidth-1:0]	PathORAM_DataIn;
	wire					PathORAM_DataInValid, PathORAM_DataInReady;

	wire	[FEDWidth-1:0]	PathORAM_ReturnData;
	wire 					PathORAM_ReturnDataValid, PathORAM_ReturnDataReady;
	
	// MIG/DDR3 DRAM
	
	wire	[DDRCWidth-1:0]	DDR3SDRAM_Command;
	wire	[DDRAWidth-1:0]	DDR3SDRAM_Address;
	wire	[DDRDWidth-1:0]	DDR3SDRAM_WriteData, DDR3SDRAM_ReadData; 
	wire	[DDRMWidth-1:0]	DDR3SDRAM_WriteMask;
	
	wire					DDR3SDRAM_CommandValid, DDR3SDRAM_CommandReady;
	wire					DDR3SDRAM_DataInValid, DDR3SDRAM_DataInReady;
	wire					DDR3SDRAM_DataOutValid;

	//------------------------------------------------------------------------------
	// 	Clocking
	//------------------------------------------------------------------------------

	wire					ClockF200_Bufg;
	
	(* mark_debug = "TRUE" *)	wire				ClockF100;

	(* mark_debug = "TRUE" *)	wire				MMCMF100Locked, ResetF100;
	
/*	
	IBUFGDS	clk_f200_p(		.I(						sys_clk_p),
							.IB(					sys_clk_n),
							.O(						ClockF200_Bufg));
    BUFG 	clk_f200(		.I(						ClockF200_Bufg),
							.O(						ClockF200));
	assign	ResetF200 =								sys_rst;
*/
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
	// 	uBlaze core & caches
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
	// 	ORAM Controller
	//------------------------------------------------------------------------------

    PathORamTop	#(			.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),							
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth),
							.NumValidBlock(         NumValidBlock), 
							.Recursion(             Recursion), 
							.MaxLogRecursion(		MaxLogRecursion),
							.LeafWidth(             LeafWidth), 
							.PLBCapacity(           PLBCapacity))
                oram(		.Clock(					ClockF200),
							.Reset(					ResetF200),
		
							.Cmd(				    PathORAM_Command),
							.PAddr(					PathORAM_PAddr),
							.CmdValid(			    PathORAM_CommandValid),
							.CmdReady(			    PathORAM_CommandReady),
							
							.DataIn(                PathORAM_DataIn),
							.DataInValid(           PathORAM_DataInValid),
							.DataInReady(           PathORAM_DataInReady), 
							
							.ReturnData(            PathORAM_ReturnData),
							.ReturnDataValid(       PathORAM_ReturnDataValid),
							.ReturnDataReady(       PathORAM_ReturnDataReady), 
							
							.DRAMCommand(			DDR3SDRAM_Command),
							.DRAMAddress(           DDR3SDRAM_Address),
							.DRAMCommandValid(		DDR3SDRAM_CommandValid),
							.DRAMCommandReady(		DDR3SDRAM_CommandReady),
							
							.DRAMReadData(			DDR3SDRAM_ReadData),
							.DRAMReadDataValid(		DDR3SDRAM_DataOutValid),
							
							.DRAMWriteData(			DDR3SDRAM_WriteData),
							.DRAMWriteMask(			DDR3SDRAM_WriteMask),
							.DRAMWriteDataValid(	DDR3SDRAM_DataInValid),
							.DRAMWriteDataReady(	DDR3SDRAM_DataInReady));
	
	/*
	PathORAMBackend #(		.ORAMB(					ORAMB),
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
							.IVEntropyWidth(		IVEntropyWidth))
			oram(			.Clock(					ClockF200),
							.Reset(					ResetF200),			
							.Command(				BEnd_Command),
							.PAddr(					BEnd_PAddr),
							.CurrentLeaf(			BEnd_CurrentLeaf),
							.RemappedLeaf(			BEnd_RemappedLeaf),
							.CommandValid(			BEnd_CommandValid),
							.CommandReady(			BEnd_CommandReady),
							.LoadData(				BEnd_LoadData),
							.LoadValid(				BEnd_LoadValid),
							.LoadReady(				BEnd_LoadReady),
							.StoreData(				BEnd_StoreData),
							.StoreValid(			BEnd_StoreValid),
							.StoreReady(			BEnd_StoreReady),
							.DRAMCommandAddress(	DDR3SDRAM_Address),
							.DRAMCommand(			DDR3SDRAM_Command),
							.DRAMCommandValid(		DDR3SDRAM_CommandValid),
							.DRAMCommandReady(		DDR3SDRAM_CommandReady),			
							.DRAMReadData(			DDR3SDRAM_ReadData),
							.DRAMReadDataValid(		DDR3SDRAM_DataOutValid),			
							.DRAMWriteData(			DDR3SDRAM_WriteData),
							.DRAMWriteMask(			DDR3SDRAM_WriteMask),
							.DRAMWriteDataValid(	DDR3SDRAM_DataInValid),
							.DRAMWriteDataReady(	DDR3SDRAM_DataInReady));
	*/
	
	//------------------------------------------------------------------------------
	//	DDR3SDRAM (MIG7)
	//------------------------------------------------------------------------------

	DDR3SDRAM 	DDR3SDRAMController(
							// System interface
							.sys_clk_p(				sys_clk_p),
							.sys_clk_n(				sys_clk_n),
							.sys_rst(				sys_rst),
  							.ui_clk(				ClockF200),
							.ui_clk_sync_rst(		ResetF200),
							.init_calib_complete(	DDR3SDRAM_ResetDone), // TODO not needed?
														
							// DDR3 interface
							.ddr3_addr(				ddr3_addr),
							.ddr3_ba(				ddr3_ba),
							.ddr3_cas_n(			ddr3_cas_n),
							.ddr3_ck_n(				ddr3_ck_n),
							.ddr3_ck_p(				ddr3_ck_p),
							.ddr3_cke(				ddr3_cke),
							.ddr3_ras_n(			ddr3_ras_n),
							.ddr3_reset_n(			ddr3_reset_n),
							.ddr3_we_n(				ddr3_we_n),
							.ddr3_dq(				ddr3_dq),
							.ddr3_dqs_n(			ddr3_dqs_n),
							.ddr3_dqs_p(			ddr3_dqs_p),
							.ddr3_cs_n(				ddr3_cs_n),
							.ddr3_dm(				ddr3_dm),
							.ddr3_odt(				ddr3_odt),
							
							// DRAM Controller <-> ORAM Controller 
							.app_cmd(				DDR3SDRAM_Command),
							.app_addr(				DDR3SDRAM_Address),
							.app_en(				DDR3SDRAM_CommandValid),
							.app_rdy(				DDR3SDRAM_CommandReady),

							.app_rd_data(			DDR3SDRAM_ReadData),
							.app_rd_data_end(		), // useless?
							.app_rd_data_valid(		DDR3SDRAM_DataOutValid),
														
							.app_wdf_data(			DDR3SDRAM_WriteData),
							.app_wdf_mask(			DDR3SDRAM_WriteMask), // this is synchronous to data interface
							.app_wdf_end(			DDR3SDRAM_DataInValid), // since DDR3 BL = 8, each 512b data chunk is the "end" of that burst
							.app_wdf_wren(			DDR3SDRAM_DataInValid),
							.app_wdf_rdy(			DDR3SDRAM_DataInReady),

							.app_sr_req(			1'b0),
							.app_ref_req(			1'b0),
							.app_zq_req(			1'b0),
							.app_sr_active(			), // not connected
							.app_ref_ack(			), // not connected
							.app_zq_ack(			)); // not connected	
	
	//------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------