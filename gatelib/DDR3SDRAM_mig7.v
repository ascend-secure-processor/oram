
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		DDR3SDRAM_mig7
//	Desc: 		Wrapper for MIG7 or synthesized DRAM.  This module is specific 
//				to MIG7 since it contains some ugly work-arounds to fix some 
//				MIG7 bugs.
//
//				This module currently doesn't support byte write enable because 
//				the Tiny ORAM project doesn't need it.
//
//==============================================================================
module DDR3SDRAM_mig7(
	UserClock, UserReset,

	DRAMAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid,
	DRAMWriteData, /*DRAMWriteMask,*/ DRAMWriteDataValid, DRAMWriteDataReady,
	
	sys_clk_p, sys_clk_n, sys_rst,
	
	ddr3_dq, ddr3_dqs_n, ddr3_dqs_p,
	ddr3_addr, ddr3_ba,
	ddr3_ras_n, ddr3_cas_n,
	ddr3_we_n, ddr3_reset_n,
	ddr3_ck_p, ddr3_ck_n,
	ddr3_cke, ddr3_cs_n,
	ddr3_dm, ddr3_odt,
	
	CalibrationComplete
	);
	
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------
	
	`include "DDR3SDRAMLocal.vh"	
	
	parameter				SlowUserClock =			1,
							IntroduceErrors =		0,
							ErrorRate =				100,
							ErrorRate2 =			2;
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------	

	output					UserClock, UserReset;
	
	//--------------------------------------------------------------------------
	//	User interface
	//--------------------------------------------------------------------------	

	input	[DDRAWidth-1:0]	DRAMAddress;
	input	[DDRCWidth-1:0]	DRAMCommand;
	input					DRAMCommandValid;
	output					DRAMCommandReady;
	
	output	[DDRDWidth-1:0]	DRAMReadData;
	output					DRAMReadDataValid;
	
	input	[DDRDWidth-1:0]	DRAMWriteData;
	//input	[DDRMWidth-1:0]	DRAMWriteMask;
	input					DRAMWriteDataValid;
	output					DRAMWriteDataReady;		

	//--------------------------------------------------------------------------
	//	DRAM interface
	//--------------------------------------------------------------------------	
	
	input					sys_clk_p;
	input					sys_clk_n;
	input					sys_rst;
	
	inout 	[63:0]			ddr3_dq;
	inout 	[7:0]			ddr3_dqs_n;
	inout 	[7:0]			ddr3_dqs_p;			
	output 	[13:0]			ddr3_addr;
	output 	[2:0]			ddr3_ba;
	output					ddr3_ras_n;
	output					ddr3_cas_n;
	output					ddr3_we_n;
	output					ddr3_reset_n;
	output 	[0:0]			ddr3_ck_p;
	output 	[0:0]			ddr3_ck_n;
	output 	[0:0]			ddr3_cke;
	output 	[0:0]			ddr3_cs_n;
	output 	[7:0]			ddr3_dm;
	output 	[0:0]			ddr3_odt;

	//------------------------------------------------------------------------------
	//	Status interface
	//------------------------------------------------------------------------------	
	
	output					CalibrationComplete;
	
	//------------------------------------------------------------------------------
	//	Wires & Regs
	//------------------------------------------------------------------------------
	
	// Clocking
	
	wire					MemoryClock; // always 200 Mhz (matches MIG)
	wire					MemoryReset_Pre;
	reg						MemoryReset;
	
	// MIG/DDR3 DRAM
	
	wire	[DDRDWidth-1:0]	DRAMReadData_Pre;
	
	(* mark_debug = "FALSE" *)	wire					DDR3SDRAM_CommandValid_MIG_Pre, DDR3SDRAM_DataInValid_MIG_Pre;
	(* mark_debug = "FALSE" *)	wire					DDR3SDRAM_CommandReady_MIG_Pre, DDR3SDRAM_DataInReady_MIG_Pre;
	
	(* mark_debug = "FALSE" *)	wire	[DDRCWidth-1:0]	DDR3SDRAM_Command_MIG;
	(* mark_debug = "FALSE" *)	wire	[DDRAWidth-1:0]	DDR3SDRAM_Address_MIG;
	(* mark_debug = "FALSE" *)	wire	[DDRDWidth-1:0]	DDR3SDRAM_WriteData_MIG, DDR3SDRAM_ReadData_MIG; 
	wire	[DDRMWidth-1:0]	DDR3SDRAM_WriteMask_MIG;

	(* mark_debug = "FALSE" *)	wire					DDR3SDRAM_CommandValid_MIG, DDR3SDRAM_CommandReady_MIG;
	(* mark_debug = "FALSE" *)	wire					DDR3SDRAM_DataInValid_MIG, DDR3SDRAM_DataInReady_MIG;
	(* mark_debug = "FALSE" *)	wire					DDR3SDRAM_DataOutValid_MIG;	
		
	(* mark_debug = "FALSE" *)	wire					PathWriteback;

	//------------------------------------------------------------------------------
	//	Debugging bit errors
	//------------------------------------------------------------------------------	

	// This code artificially injects errors into data returned by DRAM to simulate 
	// broken FPGA boards.
	
	generate if (IntroduceErrors && `ifdef SIMULATION 1 `else 0 `endif) begin:ADD_ERRORS
		reg		[`log2(DDRDWidth)-1:0] ErrorPosition, ErrorPosition2;
		reg					IntroduceError, IntroduceError2;
		
		initial begin
			ErrorPosition = {`log2(DDRDWidth){1'b0}};
			IntroduceError = 1'b0;
		end
		
		always @(posedge UserClock) begin
			if (DRAMReadDataValid) begin
				ErrorPosition <=						$random % DDRDWidth;
				ErrorPosition2 <=						$random % DDRDWidth;
				IntroduceError <=						($random % ErrorRate) == 0;
				IntroduceError2 <=						($random % ErrorRate2) == 0;
			end

			if (DRAMReadDataValid && IntroduceError) begin
				$display("[%m @ %t] INFO: flipped DRAM bit at position %d", $time, ErrorPosition);
				if (IntroduceError2) $display("[%m @ %t] INFO: flipped _second_ DRAM bit at position %d", $time, ErrorPosition2);
			end
		end
		
		assign	DRAMReadData =							( (IntroduceError) ? 						{{DDRDWidth-1{1'b0}}, 1'b1} << ErrorPosition : {DDRDWidth{1'b0}} ) ^
														( (IntroduceError && IntroduceError2) ? 	{{DDRDWidth-1{1'b0}}, 1'b1} << ErrorPosition2 : {DDRDWidth{1'b0}} ) ^
														DRAMReadData_Pre;
	end else begin:NO_ERRORS
		assign	DRAMReadData =							DRAMReadData_Pre;	
	end endgenerate
	
	//------------------------------------------------------------------------------
	//	Debugging clock crossings
	//------------------------------------------------------------------------------	

	generate if (SlowUserClock) begin:MEM_CLK_CROSS
		wire				CommandBuf_Full, WriteDataBuf_Full;
		wire				MMCMF100Locked;
	
		F100ClockGen cd2(		.clk_in1(			MemoryClock),
								.clk_out1(			UserClock),
								.reset(				MemoryReset),
								.locked(			MMCMF100Locked));
		assign	UserReset =							~MMCMF100Locked;
		
		assign	DRAMCommandReady = 					~CommandBuf_Full;
		ClkCross512x128 dcmd(	.rst(				UserReset),
								.wr_clk(			UserClock),
								.rd_clk(			MemoryClock),
								
								.din(				{DRAMCommand, 	DRAMAddress}),
								.wr_en(				DRAMCommandValid),
								.full(				CommandBuf_Full),
								
								.dout(				{DDR3SDRAM_Command_MIG, DDR3SDRAM_Address_MIG}),
								.rd_en(				DDR3SDRAM_CommandReady_MIG_Pre),
								.valid(				DDR3SDRAM_CommandValid_MIG_Pre));

		assign	DRAMWriteDataReady = 				~WriteDataBuf_Full;
		ClkCross512x512 dwr(	.rst(				UserReset), // Note: DRAMWriteMask was passed through here
								.wr_clk(			UserClock),
								.rd_clk(			MemoryClock),
								
								.din(				DRAMWriteData),
								.wr_en(				DRAMWriteDataValid),
								.full(				WriteDataBuf_Full),
								
								.dout(				DDR3SDRAM_WriteData_MIG),
								.rd_en(				DDR3SDRAM_DataInReady_MIG_Pre),
								.valid(				DDR3SDRAM_DataInValid_MIG_Pre));
		
		ClkCross512x512 drd(	.rst(				UserReset),
								.wr_clk(			MemoryClock),
								.rd_clk(			UserClock),
								.din(				DDR3SDRAM_ReadData_MIG),
								.wr_en(				DDR3SDRAM_DataOutValid_MIG),
								.rd_en(				1'b1),
								.dout(				DRAMReadData_Pre),
								.full(				),
								.valid(				DRAMReadDataValid));	
	end else begin:MEM_CLK_PASS
		assign	UserClock =							MemoryClock;
		assign	UserReset =							MemoryReset;
		
		assign	DDR3SDRAM_Command_MIG =				DRAMCommand;
		assign	DDR3SDRAM_Address_MIG =				DRAMAddress;
		assign	DDR3SDRAM_CommandValid_MIG_Pre =	DRAMCommandValid;
		assign	DRAMCommandReady = 					DDR3SDRAM_CommandReady_MIG_Pre;
		
		assign	DDR3SDRAM_WriteData_MIG =			DRAMWriteData;
		//assign	DDR3SDRAM_WriteMask_MIG =		DRAMWriteMask;
		assign	DDR3SDRAM_DataInValid_MIG_Pre =		DRAMWriteDataValid;
		assign	DRAMWriteDataReady = 				DDR3SDRAM_DataInReady_MIG_Pre;
		
		assign	DRAMReadData_Pre =					DDR3SDRAM_ReadData_MIG;
		assign	DRAMReadDataValid = 				DDR3SDRAM_DataOutValid_MIG;
	end endgenerate
	
	assign	DDR3SDRAM_WriteMask_MIG =				{DDRMWidth{1'b0}}; // all bytes enabled
	
	//------------------------------------------------------------------------------
	//	Join command & write interface
	//------------------------------------------------------------------------------	
	
	// This is needed only because MIG is bugged and will drop write data if we 
	// present WriteCommands & WriteData out of sync with each other
	// NOTE: this workaround doesn't impact writeback performance
	
	`ifdef SIMULATION
		always @(posedge MemoryClock) begin
			if (PathWriteback === 1'bx) begin
				$display("PathWriteback is X.");
				$finish;
			end
		end
	`endif
	
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

	assign	CalibrationComplete =					~MemoryReset;
	
	SynthesizedRandDRAM	#(	.InBufDepth(			6), // Set to match MIG7
							.InDataBufDepth(		16), // Set to match MIG7
	                        .OutInitLat(			25), // Set to match MIG7
	                        .OutBandWidth(			100), // Set to match MIG7
							.UWidth(				DDRDQWidth),
							.AWidth(				DDRAWidth),
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
							.init_calib_complete(	CalibrationComplete),
														
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
