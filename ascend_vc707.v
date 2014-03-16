
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
	
	// uBlaze/caches/System
	
	parameter				SystemClockFreq =		100_000_000;
	
	parameter				UseMIG =				1; // NOTE: leave default to 1
	
	// ORAM related
	
	`include "BucketLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	`include "TestHarnessLocal.vh"
	
	parameter				ORAMB =					512,
							ORAMU =					32,
							ORAML =					10,
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
	
	`ifdef SIMULATION
		initial begin
			if ((UseMIG == 0) & (ORAML > 10)) begin
				$display("[%m @ %t] ERROR: you are about to crash your computer", $time);
				$stop;
			end
		end
	`endif
	
	//------------------------------------------------------------------------------
	//	Wires & Regs
	//------------------------------------------------------------------------------
	
	wire					MemoryClock;
	wire					MemoryReset;
	
	wire					ORAMClock;
	wire					ORAMReset;
	
	wire					SlowClock;
	wire					MMCMF100Locked, SlowReset;
		
	// ORAM
	
	(* mark_debug = "TRUE" *)	wire	[BECMDWidth-1:0] PathORAM_Command;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]		PathORAM_PAddr;
	(* mark_debug = "TRUE" *)	wire					PathORAM_CommandValid, PathORAM_CommandReady;
	
	(* mark_debug = "TRUE" *)	wire	[FEDWidth-1:0]	PathORAM_DataIn;
	(* mark_debug = "TRUE" *)	wire					PathORAM_DataInValid, PathORAM_DataInReady;

	(* mark_debug = "TRUE" *)	wire	[FEDWidth-1:0]	PathORAM_ReturnData;
	(* mark_debug = "TRUE" *)	wire 					PathORAM_ReturnDataValid, PathORAM_ReturnDataReady;
	
	// MIG/DDR3 DRAM
	
	wire					DDR3SDRAM_ResetDone;
	
	(* mark_debug = "TRUE" *)	wire	[DDRCWidth-1:0]	DDR3SDRAM_Command;
	(* mark_debug = "TRUE" *)	wire	[DDRAWidth-1:0]	DDR3SDRAM_Address;
	(* mark_debug = "TRUE" *)	wire	[DDRDWidth-1:0]	DDR3SDRAM_WriteData, DDR3SDRAM_ReadData; 
	(* mark_debug = "TRUE" *)	wire	[DDRMWidth-1:0]	DDR3SDRAM_WriteMask;
	
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_CommandValid, DDR3SDRAM_CommandReady;
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_DataInValid, DDR3SDRAM_DataInReady;
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_DataOutValid;

	
	wire	[DDRCWidth-1:0]	DDR3SDRAM_Command_MIG;
	wire	[DDRAWidth-1:0]	DDR3SDRAM_Address_MIG;
	wire	[DDRDWidth-1:0]	DDR3SDRAM_WriteData_MIG, DDR3SDRAM_ReadData_MIG; 
	wire	[DDRMWidth-1:0]	DDR3SDRAM_WriteMask_MIG;
	
	wire					DDR3SDRAM_CommandValid_MIG, DDR3SDRAM_CommandReady_MIG;
	wire					DDR3SDRAM_DataInValid_MIG, DDR3SDRAM_DataInReady_MIG;
	wire					DDR3SDRAM_DataOutValid_MIG;	
	
	wire					CommandBuf_Full, WriteDataBuf_Full;
		
	//------------------------------------------------------------------------------
	// 	Clocking
	//------------------------------------------------------------------------------

	F100ClockGen clk_div_2(	.clk_in1(				MemoryClock),
							.clk_out1(				SlowClock),
							.reset(					MemoryReset),
							.locked(				MMCMF100Locked));
	assign	SlowReset =								~MMCMF100Locked;
	
	assign	ORAMClock =								SlowClock;//MemoryClock;
	assign	ORAMReset =								SlowReset;//MemoryReset;
	
	//------------------------------------------------------------------------------
	// 	GPIO
	//------------------------------------------------------------------------------

	// do something with this
	assign	led[6:2] = 								0;

	assign	led[7] =								DDR3SDRAM_ResetDone;
	
	//------------------------------------------------------------------------------
	// 	uBlaze core & caches
	//------------------------------------------------------------------------------
	
	HWTestHarness #(		.ORAMU(					ORAMU),
							.SlowClockFreq(			SystemClockFreq))
				tester(		.SlowClock(				SlowClock),
							.FastClock(				ORAMClock),
							.SlowReset(				SlowReset), 
							.FastReset(				ORAMReset),
							
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
                oram(		.Clock(					ORAMClock),
							.Reset(					ORAMReset),
		
							.Cmd(				    PathORAM_Command),
							.PAddr(					PathORAM_PAddr),
							.CmdValid(			    PathORAM_CommandValid),
							.CmdReady(			    PathORAM_CommandReady),
							
							.DataIn(                PathORAM_DataIn),
							.DataInValid(           PathORAM_DataInValid),
							.DataInReady(           PathORAM_DataInReady), 
							
							.DataOut(           	PathORAM_ReturnData),
							.DataOutValid(      	PathORAM_ReturnDataValid),
							.DataOutReady(      	PathORAM_ReturnDataReady), 
							
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
	
	//------------------------------------------------------------------------------
	//	Debugging clock crossings
	//------------------------------------------------------------------------------	

	assign	DDR3SDRAM_CommandReady = 				~CommandBuf_Full;
	DebugCommandFIFO dcmd(	.rst(					ORAMReset),
							.wr_clk(				ORAMClock),
							.rd_clk(				MemoryClock),
							
							.din(					{DDR3SDRAM_Command, 	DDR3SDRAM_Address}),
							.wr_en(					DDR3SDRAM_CommandValid),
							.full(					CommandBuf_Full),
							
							.dout(					{DDR3SDRAM_Command_MIG, DDR3SDRAM_Address_MIG}),
							.rd_en(					DDR3SDRAM_CommandReady_MIG),
							.valid(					DDR3SDRAM_CommandValid_MIG));
	
	assign	DDR3SDRAM_WriteMask_MIG =				{DDRMWidth{1'b0}}; // TODO This will break for REW ORAM
	
	assign	DDR3SDRAM_DataInReady = 				~WriteDataBuf_Full;
	DebugDataFIFO dwr(		.rst(					ORAMReset),
							.wr_clk(				ORAMClock),
							.rd_clk(				MemoryClock),
							
							.din(					DDR3SDRAM_WriteData),
							.wr_en(					DDR3SDRAM_DataInValid),
							.full(					WriteDataBuf_Full),
							
							.dout(					DDR3SDRAM_WriteData_MIG),
							.rd_en(					DDR3SDRAM_DataInReady_MIG),
							.valid(					DDR3SDRAM_DataInValid_MIG));
	
	DebugDataFIFO drd(		.rst(					ORAMReset),
							.wr_clk(				MemoryClock),
							.rd_clk(				ORAMClock),
							.din(					DDR3SDRAM_ReadData_MIG),
							.wr_en(					DDR3SDRAM_DataOutValid_MIG),
							.rd_en(					1'b1),
							.dout(					DDR3SDRAM_ReadData),
							.full(					),
							.valid(					DDR3SDRAM_DataOutValid));	
	
	//------------------------------------------------------------------------------
	//	DDR3SDRAM (MIG7)
	//------------------------------------------------------------------------------	
	
	generate if (UseMIG == 1) begin:MIG
		DDR3SDRAM DDR3SDRAMController(
							// System interface
							.sys_clk_p(				sys_clk_p),
							.sys_clk_n(				sys_clk_n),
							.sys_rst(				sys_rst),
  							.ui_clk(				MemoryClock),
							.ui_clk_sync_rst(		MemoryReset),
							.init_calib_complete(	DDR3SDRAM_ResetDone),
														
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
							.app_cmd(				DDR3SDRAM_Command_MIG),
							.app_addr(				DDR3SDRAM_Address_MIG),
							.app_en(				DDR3SDRAM_CommandValid_MIG),
							.app_rdy(				DDR3SDRAM_CommandReady_MIG),

							.app_rd_data(			DDR3SDRAM_ReadData_MIG),
							.app_rd_data_end(		), // useless?
							.app_rd_data_valid(		DDR3SDRAM_DataOutValid_MIG),
														
							.app_wdf_data(			DDR3SDRAM_WriteData_MIG),
							.app_wdf_mask(			DDR3SDRAM_WriteMask_MIG), // this is synchronous to data interface
							.app_wdf_end(			DDR3SDRAM_DataInValid_MIG), // since DDR3 BL = 8, each 512b data chunk is the "end" of that burst
							.app_wdf_wren(			DDR3SDRAM_DataInValid_MIG),
							.app_wdf_rdy(			DDR3SDRAM_DataInReady_MIG),

							.app_sr_req(			1'b0),
							.app_ref_req(			1'b0),
							.app_zq_req(			1'b0),
							.app_sr_active(			), // not connected
							.app_ref_ack(			), // not connected
							.app_zq_ack(			)); // not connected
	end else begin:SYNTH_DRAM
		wire				MemoryClock_Bufg;
		IBUFGDS	clk_f200_p(	.I(						sys_clk_p),
							.IB(					sys_clk_n),
							.O(						MemoryClock_Bufg));
		BUFG 	clk_f200(	.I(						MemoryClock_Bufg),
							.O(						MemoryClock));
		assign	MemoryReset =						sys_rst;

		SynthesizedRandDRAM	#(.InBufDepth(			36),
							.UWidth(				8),
							.AWidth(				DDRAWidth + 6),
							.DWidth(				DDRDWidth),
							.BurstLen(				1), // just for this module ...
							.EnableMask(			1),
							.Class1(				1),
							.RLatency(				1),
							.WLatency(				1)) 
				DDR3SDRAMController(.Clock(			MemoryClock),
							.Reset(					MemoryReset),

							.Initialized(			),
							.PoweredUp(				),

							.CommandAddress(		{DDR3SDRAM_Address_MIG, 6'b000000}),
							.Command(				DDR3SDRAM_Command_MIG),
							.CommandValid(			DDR3SDRAM_CommandValid_MIG),
							.CommandReady(			DDR3SDRAM_CommandReady_MIG),

							.DataIn(				DDR3SDRAM_WriteData_MIG),
							.DataInMask(			DDR3SDRAM_WriteMask_MIG),
							.DataInValid(			DDR3SDRAM_DataInValid_MIG),
							.DataInReady(			DDR3SDRAM_DataInReady_MIG),

							.DataOut(				DDR3SDRAM_ReadData_MIG),
							.DataOutErrorChecked(	),
							.DataOutErrorCorrected(	),
							.DataOutValid(			DDR3SDRAM_DataOutValid_MIG),
							.DataOutReady(			1'b1));
	end endgenerate
	
	//------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------