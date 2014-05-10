
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
			// GPIO LEDs
			output	[7:0]	led,

			// GPIO switches
			input			GPIO_SW_S,
			input			GPIO_SW_N,
			input			GPIO_SW_C,
			input			GPIO_SW_E,
			input			GPIO_SW_W,

			// System
			input			sys_clk_p,
			input			sys_clk_n,
			input			sys_rst, // SW8

	`ifndef SIMULATION
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
	`endif
	
			// UART / Serial
			output			uart_txd,
			input			uart_rxd
	);
	
	//------------------------------------------------------------------------------
	//	Constants
	//------------------------------------------------------------------------------
	
	/* 	Debugging.
	
		SlowORAMClock:		slow the ORAM controller down to make it easier to add 
							ChipScope signals & meet timing
		
		See PathORAMTop for more documentation */
	parameter				SlowORAMClock =			1; // NOTE: set to 0 for performance run
	parameter				SlowAESClock =			1; // NOTE: set to 0 for performance run
	parameter				DebugDRAMReadTiming =	1; // NOTE: set to 0 for performance run
	parameter				DebugAES =				0; // NOTE: set to 0 for performance run
	
	// See HWTestHarness for documentation
	parameter				GenHistogram = 			1;
	
	// CCS paper configurations
	parameter				UnifiedExperiment =		1;
	parameter				REWExperiment =			1;
	parameter				REWIVExperiment =		1;
	
	`ifdef SIMULATION
		initial begin
			if ( UnifiedExperiment == 0 && REWExperiment == 1 ) begin
				$display("[%m @ %t] ERROR: we aren't interested in this ...", $time);
				$stop;			
			end

			if ( REWIVExperiment == 1 && REWExperiment == 0 ) begin
				$display("[%m @ %t] ERROR: bogus params.", $time);
				$stop;			
			end
		end
	`endif
	
	// ORAM related
	
	parameter				ORAMB =					512,
							ORAMU =					32,
							ORAML =					20, // set to 20 for vc707 board (when Z = 5, B = 512, MIG -> 1 GB DIMM); set to 31 to test ASIC
							ORAMZ =					(REWExperiment) ? 5 : 4,
							ORAMC =					10,
							ORAME =					5;

	parameter				FEDWidth =				64,
							BEDWidth =				512;

    parameter				NumValidBlock = 		1 << ORAML,
							Recursion = 			3,
							EnablePLB = 			UnifiedExperiment,   
							PLBCapacity = 			8192 << 3;
		
	parameter				Overclock =				1;
	
	parameter				EnableAES =				REWExperiment;
	parameter				EnableREW =				REWExperiment;
	parameter				EnableIV =				REWIVExperiment;
	parameter				DelayedWB =				EnableIV;
	
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
	
	localparam				SlowClockFreq =			100_000_000,
							MemoryClockFreq =		200_000_000,
							ORAMClockFreq = 		(SlowORAMClock) ? SlowClockFreq : MemoryClockFreq;
							
	//------------------------------------------------------------------------------
	//	Wires & Regs
	//------------------------------------------------------------------------------
	
	// Clocking
	
	wire					MemoryClock; // always 200 Mhz (matches MIG)
	wire					MemoryReset_Pre;
	reg						MemoryReset;
	
	wire					ORAMClock; // Configurable (typically >= 100 Mhz, <= 200 Mhz)
	wire					ORAMReset;
	
	wire					AESClock; // As fast as possible (~300 Mhz)
	
	wire					SlowClock;
	wire					MMCMF100Locked, SlowReset;
	
	// Test harness
	
	wire					Tester_ForceHistogramDumpPre;
	reg						Tester_ForceHistogramDump;
	
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

	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_CommandValid_MIG_Pre, DDR3SDRAM_DataInValid_MIG_Pre;
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_CommandReady_MIG_Pre, DDR3SDRAM_DataInReady_MIG_Pre;
	
	(* mark_debug = "TRUE" *)	wire	[DDRCWidth-1:0]	DDR3SDRAM_Command_MIG;
	(* mark_debug = "TRUE" *)	wire	[DDRAWidth_Top-1:0]	DDR3SDRAM_Address_MIG;
	(* mark_debug = "TRUE" *)	wire	[DDRDWidth-1:0]	DDR3SDRAM_WriteData_MIG, DDR3SDRAM_ReadData_MIG; 
	wire	[DDRMWidth-1:0]	DDR3SDRAM_WriteMask_MIG;

	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_CommandValid_MIG, DDR3SDRAM_CommandReady_MIG;
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_DataInValid_MIG, DDR3SDRAM_DataInReady_MIG;
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_DataOutValid_MIG;	
		
	(* mark_debug = "TRUE" *)	wire					PathWriteback;
		
	//------------------------------------------------------------------------------
	// 	Clocking
	//------------------------------------------------------------------------------

	F100ClockGen clk_div_2(	.clk_in1(				MemoryClock),
							.clk_out1(				SlowClock),
							.reset(					MemoryReset),
							.locked(				MMCMF100Locked));
	assign	SlowReset =								~MMCMF100Locked;

	generate if (SlowAESClock) begin:SLOW_AES
		assign	AESClock =							SlowClock;
	end else begin:FAST_AES
		aes_clock	ultra( 	.clk_in1(				MemoryClock),
							.clk_out1(				AESClock),
							.reset(					MemoryReset),
							.locked(				));
	end endgenerate
	
	//------------------------------------------------------------------------------
	// 	GPIO
	//------------------------------------------------------------------------------

	// We wish to reset the harness first, then dump the histogram
	always @(posedge ORAMClock) begin
		Tester_ForceHistogramDump <=				Tester_ForceHistogramDumpPre;
	end	
	
	// do something with this
	assign	led[6:2] = 								0;

	assign	led[7] =								DDR3SDRAM_ResetDone;
	
	ButtonParse	#(			.Width(					1),
							.DebWidth(				`log2(ORAMClockFreq / 100)), // Use a 10ms button parser (roughly)
							.EdgeOutWidth(			1))
					InBP(	.Clock(					ORAMClock),
							.Reset(					ORAMReset),
							.Enable(				1'b1),
							.In(					GPIO_SW_C),
							.Out(					Tester_ForceHistogramDumpPre));
	
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
							.FastReset(				ORAMReset | Tester_ForceHistogramDumpPre),
							
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
							
							.ForceHistogramDump(	Tester_ForceHistogramDump),
							
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

							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),

							.NumValidBlock(         NumValidBlock), 
							.Recursion(             Recursion),
							.EnablePLB(				EnablePLB),
							.PLBCapacity(           PLBCapacity),

							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							.DelayedWB(				DelayedWB),

							.DebugDRAMReadTiming(	DebugDRAMReadTiming),
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

	generate if (SlowORAMClock) begin:SLOW_ORAM	
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
	
	assign	PathWriteback =							(DDR3SDRAM_Command_MIG == DDR3CMD_Write) & DDR3SDRAM_CommandValid_MIG_Pre;
	
	assign	DDR3SDRAM_CommandValid_MIG =			((PathWriteback) ? 	DDR3SDRAM_DataInValid_MIG_Pre & DDR3SDRAM_DataInReady_MIG : 1'b1) & 	DDR3SDRAM_CommandValid_MIG_Pre;
	assign	DDR3SDRAM_DataInValid_MIG =				PathWriteback & 																			DDR3SDRAM_CommandValid_MIG_Pre & DDR3SDRAM_DataInValid_MIG_Pre & DDR3SDRAM_CommandReady_MIG;
	
	assign	DDR3SDRAM_CommandReady_MIG_Pre =		((PathWriteback) ?	DDR3SDRAM_DataInValid_MIG_Pre &	DDR3SDRAM_DataInReady_MIG : 1'b1) & 	DDR3SDRAM_CommandReady_MIG;
	assign	DDR3SDRAM_DataInReady_MIG_Pre =			PathWriteback & 																			DDR3SDRAM_CommandReady_MIG & DDR3SDRAM_CommandValid_MIG_Pre & DDR3SDRAM_DataInReady_MIG;
	
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
	
	SynthesizedRandDRAM	#(	.InBufDepth(			6), // Set to match MIG7
							.InDataBufDepth(		16), // Set to match MIG7
	                        .OutInitLat(			25), // Set to match MIG7
	                        .OutBandWidth(			100), // Set to match MIG7
							.UWidth(				DDRDQWidth),
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