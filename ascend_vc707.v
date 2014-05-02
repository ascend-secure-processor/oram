
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
module ascend_vc707(
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
	
	parameter				SlowClockFreq =			100_000_000;
	parameter				MemoryClockFreq =		200_000_000;
	
	/* 	Debugging.
	
		TODO update descriptions
	
		SlowDownORAMClock:	slow the ORAM controller down to make it easier to add 
							ChipScope signals & meet timing
		DebugDRAMTiming:		simulation/board will see exact same bandwidth read to AES */
	parameter				SlowDownORAMClock =		1; // NOTE: set to 0 for performance run
	parameter				DebugDRAMTiming =		0; // NOTE: set to 0 for performance run
	parameter				DebugAES =				0; // NOTE: set to 0 for performance run
	
	// See HWTestHarness for documentation
	parameter				GenHistogram = 			1;
	
	// ORAM related
	
	parameter				ORAMB =					512,
							ORAMU =					32,
							ORAML =					20, // set to 20 for vc707 board; set to 31 to test ASIC
							ORAMZ =					5,
							ORAMC =					10, // Stash capacity will always be 128 - 256
							ORAME =					5;

	parameter				FEDWidth =				64,
							BEDWidth =				512;
								
	parameter				Overclock =				1;
	
	parameter				EnableAES =				1;
	parameter				EnableREW =				1;
	parameter				EnableIV =				0;
	
    parameter				NumValidBlock = 		1 << ORAML,
							Recursion = 			3;
	
    parameter				PLBCapacity = 			8192 << 3;
	
	`include "SecurityLocal.vh"
	`include "BucketLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	`include "TestHarnessLocal.vh"
	`include "SubTreeLocal.vh"
		
	localparam 				TreeInDQChunks =		`divceil(BktSize_RndBits, DDRDQWidth) * ( (1 << (ORAML + 1)) + numTotalST);
	`ifdef SIMULATION
	localparam				DDRAWidth_Top =			`log2(TreeInDQChunks);
	`else
	localparam				DDRAWidth_Top =			DDRAWidth;
	`endif
	
	//------------------------------------------------------------------------------
	//	Wires & Regs
	//------------------------------------------------------------------------------
	
	// Clocking
	
	wire					MemoryClock; // always 200 Mhz (matches MIG)
	wire					MemoryReset_Pre;
	(* mark_debug = "TRUE" *)	reg						MemoryReset;
	
	wire					ORAMClock; // Configurable (typically >= 100 Mhz, <= 200 Mhz)
	wire					ORAMReset;
	
	wire					AESClock; // As fast as possible (~300 Mhz)
	
	wire					SlowClock;
	wire					MMCMF100Locked, SlowReset;
	wire					MMCMF300Locked;
	
	// ORAM
	
	(* mark_debug = "TRUE" *)	wire	[BECMDWidth-1:0] PathORAM_Command;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]		PathORAM_PAddr;
	(* mark_debug = "TRUE" *)	wire					PathORAM_CommandValid, PathORAM_CommandReady;
	
	(* mark_debug = "TRUE" *)	wire	[FEDWidth-1:0]	PathORAM_DataIn;
	(* mark_debug = "TRUE" *)	wire					PathORAM_DataInValid, PathORAM_DataInReady;

	(* mark_debug = "TRUE" *)	wire	[FEDWidth-1:0]	PathORAM_DataOut;
	(* mark_debug = "TRUE" *)	wire 					PathORAM_DataOutValid, PathORAM_DataOutReady;
	
	// MIG/DDR3 DRAM
	
	wire					DDR3SDRAM_ResetDone;
	
	(* mark_debug = "TRUE" *)	wire	[DDRCWidth-1:0]	DDR3SDRAM_Command;
	(* mark_debug = "TRUE" *)	wire	[DDRAWidth_Top-1:0]	DDR3SDRAM_Address;
	(* mark_debug = "TRUE" *)	wire	[DDRDWidth-1:0]	DDR3SDRAM_WriteData, DDR3SDRAM_ReadData; 
	wire	[DDRMWidth-1:0]	DDR3SDRAM_WriteMask;
	
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_CommandValid, DDR3SDRAM_CommandReady;
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_DataInValid, DDR3SDRAM_DataInReady;
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_DataOutValid;

	wire					DDR3SDRAM_CommandValid_MIG_Pre, DDR3SDRAM_DataInValid_MIG_Pre;
	wire					DDR3SDRAM_CommandReady_MIG_Pre, DDR3SDRAM_DataInReady_MIG_Pre;
	
	wire	[DDRCWidth-1:0]	DDR3SDRAM_Command_MIG;
	wire	[DDRAWidth_Top-1:0]	DDR3SDRAM_Address_MIG;
	wire	[DDRDWidth-1:0]	DDR3SDRAM_WriteData_MIG, DDR3SDRAM_ReadData_MIG; 
	wire	[DDRMWidth-1:0]	DDR3SDRAM_WriteMask_MIG;
	
	wire					DDR3SDRAM_CommandValid_MIG, DDR3SDRAM_CommandReady_MIG;
	wire					DDR3SDRAM_DataInValid_MIG, DDR3SDRAM_DataInReady_MIG;
	wire					DDR3SDRAM_DataOutValid_MIG;	
		
	//------------------------------------------------------------------------------
	// 	Clocking
	//------------------------------------------------------------------------------

	F100ClockGen clk_div_2(	.clk_in1(				MemoryClock),
							.clk_out1(				SlowClock),
							.reset(					MemoryReset),
							.locked(				MMCMF100Locked));
	assign	SlowReset =								~MMCMF100Locked;

	aes_clock	ultra( 		.clk_in1(				MemoryClock),
							.clk_out1(				AESClock),
							.reset(					MemoryReset),
							.locked(				MMCMF300Locked));
	
	//------------------------------------------------------------------------------
	// 	GPIO
	//------------------------------------------------------------------------------

	// do something with this
	assign	led[6:2] = 								0;

	assign	led[7] =								DDR3SDRAM_ResetDone;
	
	//------------------------------------------------------------------------------
	// 	uBlaze core & caches
	//------------------------------------------------------------------------------
	
	HWTestHarness #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),
							.GenHistogram(			GenHistogram),
							.SlowClockFreq(			SlowClockFreq))
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
							
							.ORAMDataOut(			PathORAM_DataOut),
							.ORAMDataOutValid(		PathORAM_DataOutValid),
							.ORAMDataOutReady(		PathORAM_DataOutReady),
							
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
							.ORAMC(					ORAMC),
							.ORAME(					ORAME),
							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),
							.NumValidBlock(         NumValidBlock), 
							.Recursion(             Recursion), 
							.PLBCapacity(           PLBCapacity),
							.DebugDRAMTiming(		DebugDRAMTiming),
							.DebugAES(				DebugAES))
                oram(		.Clock(					ORAMClock),
							.FastClock(				AESClock),
							.Reset(					ORAMReset),
		
							.Cmd(				    PathORAM_Command),
							.PAddr(					PathORAM_PAddr),
							.CmdValid(			    PathORAM_CommandValid),
							.CmdReady(			    PathORAM_CommandReady),
							
							.DataIn(                PathORAM_DataIn),
							.DataInValid(           PathORAM_DataInValid),
							.DataInReady(           PathORAM_DataInReady), 
							
							.DataOut(           	PathORAM_DataOut),
							.DataOutValid(      	PathORAM_DataOutValid),
							.DataOutReady(      	PathORAM_DataOutReady), 
							
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

	generate if (SlowDownORAMClock) begin:SLOW_ORAM	
		wire				CommandBuf_Full, WriteDataBuf_Full;
	
		assign	ORAMClock =							SlowClock;
		assign	ORAMReset =							SlowReset;
		
		assign	DDR3SDRAM_CommandReady = 			~CommandBuf_Full;
		DebugCommandFIFO dcmd(	.rst(				ORAMReset),
								.wr_clk(			ORAMClock),
								.rd_clk(			MemoryClock),
								
								.din(				{DDR3SDRAM_Command, 	DDR3SDRAM_Address}),
								.wr_en(				DDR3SDRAM_CommandValid),
								.full(				CommandBuf_Full),
								
								.dout(				{DDR3SDRAM_Command_MIG, DDR3SDRAM_Address_MIG}),
								.rd_en(				DDR3SDRAM_CommandReady_MIG_Pre),
								.valid(				DDR3SDRAM_CommandValid_MIG_Pre));

		assign	DDR3SDRAM_DataInReady = 			~WriteDataBuf_Full;
		DebugDataWFIFO dwr(		.rst(				ORAMReset),
								.wr_clk(			ORAMClock),
								.rd_clk(			MemoryClock),
								
								.din(				{DDR3SDRAM_WriteMask, 		DDR3SDRAM_WriteData}),
								.wr_en(				DDR3SDRAM_DataInValid),
								.full(				WriteDataBuf_Full),
								
								.dout(				{DDR3SDRAM_WriteMask_MIG, 	DDR3SDRAM_WriteData_MIG}),
								.rd_en(				DDR3SDRAM_DataInReady_MIG_Pre),
								.valid(				DDR3SDRAM_DataInValid_MIG_Pre));
		
		DebugDataFIFO drd(		.rst(				ORAMReset),
								.wr_clk(			MemoryClock),
								.rd_clk(			ORAMClock),
								.din(				DDR3SDRAM_ReadData_MIG),
								.wr_en(				DDR3SDRAM_DataOutValid_MIG),
								.rd_en(				1'b1),
								.dout(				DDR3SDRAM_ReadData),
								.full(				),
								.valid(				DDR3SDRAM_DataOutValid));	
	end else begin:FAST_ORAM
		assign	ORAMClock =							MemoryClock;
		assign	ORAMReset =							MemoryReset;
		
		assign	DDR3SDRAM_Command_MIG =				DDR3SDRAM_Command;
		assign	DDR3SDRAM_Address_MIG =				DDR3SDRAM_Address;
		assign	DDR3SDRAM_CommandValid_MIG_Pre =	DDR3SDRAM_CommandValid;
		assign	DDR3SDRAM_CommandReady = 			DDR3SDRAM_CommandReady_MIG_Pre;
		
		assign	DDR3SDRAM_WriteData_MIG =			DDR3SDRAM_WriteData;
		assign	DDR3SDRAM_WriteMask_MIG =			DDR3SDRAM_WriteMask;
		assign	DDR3SDRAM_DataInValid_MIG_Pre =		DDR3SDRAM_DataInValid;
		assign	DDR3SDRAM_DataInReady = 			DDR3SDRAM_DataInReady_MIG_Pre;
		
		assign	DDR3SDRAM_ReadData =				DDR3SDRAM_ReadData_MIG;
		assign	DDR3SDRAM_DataOutValid = 			DDR3SDRAM_DataOutValid_MIG;			
	end endgenerate
	
	//------------------------------------------------------------------------------
	//	Join command & write interface
	//------------------------------------------------------------------------------	
	
	// This is needed only because MIG is bugged and will drop write data if we 
	// present WriteCommands & WriteData out of sync with each other
	// NOTE: this workaround doesn't impact writeback performance
	
	initial begin
		if (EnableREW == 0) $stop; // Create a stat counter for basic ORAM
	end
	
	// We need to specify when to tie the interfaces together
	wire					PathRead, PathWriteback, ROAccess, RWAccess;
	wire					ReadCmdTransfer, WriteCmdTransfer;
	REWStatCtr	#(			.ORAME(					ORAME),
							.RW_R_Chunk(			PathSize_DRBursts),
							.RW_W_Chunk(			PathSize_DRBursts),
							.RO_R_Chunk(			PathSize_DRBursts),
							.RO_W_Chunk(			(ORAML+1) * BktHSize_DRBursts),
							.LatchOutput(			1))
				rw_stat(	.Clock(					MemoryClock),
							.Reset(					MemoryReset),
							
							.RW_R_Transfer(			RWAccess & PathRead & 		ReadCmdTransfer),
							.RW_W_Transfer(			RWAccess & PathWriteback & 	WriteCmdTransfer),
							.RO_R_Transfer(			ROAccess & PathRead & 		ReadCmdTransfer),
							.RO_W_Transfer(			ROAccess & PathWriteback & 	WriteCmdTransfer),

							.Writeback(				PathWriteback),
							.Read(					PathRead),
							.ROAccess(				ROAccess),
							.RWAccess(				RWAccess));
	
	assign	ReadCmdTransfer = 						DDR3SDRAM_CommandValid_MIG & DDR3SDRAM_CommandReady_MIG;
	assign	WriteCmdTransfer =						DDR3SDRAM_CommandValid_MIG & DDR3SDRAM_CommandReady_MIG & DDR3SDRAM_DataInValid_MIG & DDR3SDRAM_DataInReady_MIG;
	
	assign	DDR3SDRAM_CommandValid_MIG =			DDR3SDRAM_CommandValid_MIG_Pre & 	((PathWriteback) ? 	DDR3SDRAM_DataInValid_MIG_Pre & DDR3SDRAM_DataInReady_MIG : 1'b1);
	assign	DDR3SDRAM_DataInValid_MIG =				DDR3SDRAM_CommandValid_MIG_Pre & 						DDR3SDRAM_DataInValid_MIG_Pre & DDR3SDRAM_CommandReady_MIG & PathWriteback;
	
	assign	DDR3SDRAM_CommandReady_MIG_Pre =		DDR3SDRAM_CommandReady_MIG & 		((PathWriteback) ?	DDR3SDRAM_DataInValid_MIG_Pre &	DDR3SDRAM_DataInReady_MIG : 1'b1);
	assign	DDR3SDRAM_DataInReady_MIG_Pre =			DDR3SDRAM_CommandReady_MIG & 							DDR3SDRAM_CommandValid_MIG_Pre & DDR3SDRAM_DataInReady_MIG & PathWriteback;
	
	//------------------------------------------------------------------------------
	//	DDR3SDRAM (MIG7 or some synthetic memory)
	//------------------------------------------------------------------------------
	
	always @(posedge MemoryClock) begin
		MemoryReset <=								MemoryReset_Pre;						
	end
	
	`ifdef SIMULATION
	
	// -------------------------------------------------------------------------
	//	Fake MIG
	// -------------------------------------------------------------------------
	
	wire					MemoryClock_Bufg;
	IBUFGDS	clk_f200_p(		.I(						sys_clk_p),
							.IB(					sys_clk_n),
							.O(						MemoryClock_Bufg));
	BUFG 	clk_f200(		.I(						MemoryClock_Bufg),
							.O(						MemoryClock));
	assign	MemoryReset_Pre =						sys_rst;

	assign	DDR3SDRAM_ResetDone =					~MemoryReset;
	
	SynthesizedRandDRAM	#(	.UWidth(				DDRDQWidth),
							.AWidth(				DDRAWidth_Top),
							.DWidth(				DDRDWidth),
							.BurstLen(				1),
							.EnableMask(			1),
							.Class1(				1),
							.RLatency(				1),
							.WLatency(				1))
				fake_mig(	.Clock(					MemoryClock),
							.Reset(					MemoryReset),

							.CommandAddress(		DDR3SDRAM_Address_MIG),
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
	`else
	
	// -------------------------------------------------------------------------
	//	Real MIG
	// -------------------------------------------------------------------------
	
	// We put MIG here so that the constraint file doesn't need to be changed
	
	DDR3SDRAM DDR3SDRAMController(
							// System interface
							.sys_clk_p(				sys_clk_p),
							.sys_clk_n(				sys_clk_n),
							.sys_rst(				sys_rst),
  							.ui_clk(				MemoryClock),
							.ui_clk_sync_rst(		MemoryReset_Pre),
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
	`endif
	
	//------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------