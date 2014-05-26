
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
	parameter				SlowAESClock =			SlowORAMClock; // NOTE: set to 0 for performance run
	parameter				DebugDRAMReadTiming =	0; // NOTE: set to 0 for performance run
	parameter				DebugAES =				1; // NOTE: set to 0 for performance run			[NOTE: set to 0 for CCS; this may help broken DRAM issue]
	
	// See HWTestHarness for documentation
	parameter				GenHistogram = 			1;
	
	// CCS paper configurations
	parameter				UnifiedExperiment =		1;
	parameter				REWExperiment =			1;
	parameter				REWIVExperiment =		`ifdef EnableIV `EnableIV `else 1 `endif;
	
	// ORAM related
	
	parameter				ORAMB =					512,
							ORAMU =					32,
							ORAML =					`ifdef ORAML `ORAML `else 20 `endif, // set to 20 for vc707 board (when Z = 5, B = 512, MIG -> 1 GB DIMM); set to 31 to test ASIC
							ORAMZ =					`ifdef ORAMZ `ORAMZ `else (REWExperiment) ? 5 : 4 `endif,
							ORAMC =					10,
							ORAME =					5;

	parameter				FEDWidth =				512,
							BEDWidth =				512;

    parameter				NumValidBlock = 		1 << ORAML,
							Recursion = 			3,
							EnablePLB = 			UnifiedExperiment,
							PLBCapacity = 			`ifdef PLBCapacity `PLBCapacity `else 8192 << 3 `endif; // 8KB PLB
		
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
					
	`ifdef SIMULATION
		initial begin
			if ( UnifiedExperiment == 0 && REWExperiment == 1 ) begin
				$display("[%m @ %t] ERROR: we aren't interested in this ...", $time);
				$finish;
			end

			if ( REWIVExperiment == 1 && REWExperiment == 0 ) begin
				$display("[%m @ %t] ERROR: bogus params.", $time);
				$finish;			
			end
			
			$display("Starting run: IV=%d, Z=%d,L=%d,PLB=%d", REWIVExperiment, ORAMZ, ORAML, PLBCapacity);
		end
	`endif
					
	//------------------------------------------------------------------------------
	//	Wires & Regs
	//------------------------------------------------------------------------------
	
	// Clocking
	
	wire					ORAMClock; // Configurable (typically >= 100 Mhz, <= 200 Mhz)
	wire					ORAMReset;
	
	wire					SlowClock;
	wire					MMCMF100Locked, SlowReset;

	wire					AESClock; // As fast as possible (~300 Mhz)	
	
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
	
	wire					DRAMCalibrationComplete;
	
	(* mark_debug = "TRUE" *)	wire	[DDRCWidth-1:0]	DDR3SDRAM_Command;
	(* mark_debug = "TRUE" *)	wire	[DDRAWidth_Top-1:0]	DDR3SDRAM_Address;
	(* mark_debug = "TRUE" *)	wire	[DDRDWidth-1:0]	DDR3SDRAM_WriteData, DDR3SDRAM_ReadData; 
	wire	[DDRMWidth-1:0]	DDR3SDRAM_WriteMask;
	
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_CommandValid, DDR3SDRAM_CommandReady;
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_DataInValid, DDR3SDRAM_DataInReady;
	(* mark_debug = "TRUE" *)	wire					DDR3SDRAM_DataOutValid;
		
	//------------------------------------------------------------------------------
	// 	Clocking
	//------------------------------------------------------------------------------
 
	generate if (SlowORAMClock) begin:SLOW_ORAM
		assign	SlowClock =							ORAMClock;
		assign	SlowReset =							ORAMReset;
	end else begin:FAST_ORAM
		F100ClockGen cd2(	.clk_in1(				ORAMClock),
							.clk_out1(				SlowClock),
							.reset(					MemoryReset),
							.locked(				MMCMF100Locked));
		assign	SlowReset =							~MMCMF100Locked;
	end endgenerate
	
	generate if (SlowAESClock) begin:SLOW_AES
		assign	AESClock =							SlowClock;
	end else begin:FAST_AES
		aes_clock	ci15( 	.clk_in1(				ORAMClock),
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

	assign	led[7] =								DRAMCalibrationComplete;
	assign	led[6] = 								UnifiedExperiment;
	assign	led[5] = 								REWExperiment;
	assign	led[4] = 								REWIVExperiment;
	
	assign	led[3] = 								0;
	assign	led[2] = 								0;
	
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
							.NumValidBlock(			NumValidBlock),
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
							.ErrorSendOverflow(		));

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
	//	DRAM Controller
	//------------------------------------------------------------------------------
	
	DDR3SDRAMTop #(			.SlowUserClock(			SlowORAMClock),
							.AWidth(				DDRAWidth_Top))
				mig(		.UserClock(				ORAMClock), 
							.UserReset(				ORAMReset), 
                            
							.DRAMCommand(			DDR3SDRAM_Command),
							.DRAMAddress(			DDR3SDRAM_Address), 
							.DRAMCommandValid(		DDR3SDRAM_CommandValid),  
							.DRAMCommandReady(		DDR3SDRAM_CommandReady), 
							.DRAMReadData(			DDR3SDRAM_ReadData),  
							.DRAMReadDataValid(		DDR3SDRAM_DataOutValid), 
							.DRAMWriteData(			DDR3SDRAM_WriteData),  
							.DRAMWriteMask(			DDR3SDRAM_WriteMask),  
							.DRAMWriteDataValid(	DDR3SDRAM_DataInValid),  
							.DRAMWriteDataReady(	DDR3SDRAM_DataInReady), 
							
							.sys_clk_p(				sys_clk_p),  
							.sys_clk_n(				sys_clk_n),  
							.sys_rst(				sys_rst), 
							.ddr3_dq(				ddr3_dq),  
							.ddr3_dqs_n(			ddr3_dqs_n),  
							.ddr3_dqs_p(			ddr3_dqs_p), 			
							.ddr3_addr(				ddr3_addr),  
							.ddr3_ba(				ddr3_ba), 
							.ddr3_ras_n(			ddr3_ras_n),  
							.ddr3_cas_n(			ddr3_cas_n), 
							.ddr3_we_n(				ddr3_we_n),  
							.ddr3_reset_n(			ddr3_reset_n), 
							.ddr3_ck_p(				ddr3_ck_p),  
							.ddr3_ck_n(				ddr3_ck_n), 
							.ddr3_cke(				ddr3_cke),  
							.ddr3_cs_n(				ddr3_cs_n), 
							.ddr3_dm(				ddr3_dm),  
							.ddr3_odt(				ddr3_odt), 
							
							.CalibrationComplete(	DRAMCalibrationComplete));

	//------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------