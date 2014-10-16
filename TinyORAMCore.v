
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		TinyORAMCore
//	Desc:		The Top-level TinyORAM module.
//				Includes {Unified} x {Basic, REW} frontends/backends with
//				encryption, integrity verification, & a FIFO DRAM interface.
//
//				This module can be instantiated in a larger design or
//				synthesized directly as a top module (using the default
//				parameters specified below).
//==============================================================================
module TinyORAMCore(
  	Clock, Reset,

	Cmd, PAddr, WMask,
	CmdValid, CmdReady,

	DataIn,
	DataInValid, DataInReady,

	DataOut,
	DataOutValid, DataOutReady,

	DRAMAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,
	
	Mode_DummyGen,
	
	JTAG_UORAM, JTAG_PMMAC, JTAG_Frontend,
	JTAG_AES, JTAG_StashCore, JTAG_Stash, JTAG_StashTop, JTAG_BackendCore, JTAG_Backend	
	);

	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------

	// Debugging

	/*
		SlowAESClock:			AES should use the same clock as the rest of the design
		DebugDRAMReadTiming: 	Don't send PathBuffer data to AES until the PathBuffer has received an entire path.  
								This eliminates differences in MIG vs. simulation read timing.
	*/
	parameter				SlowAESClock =			1; // NOTE: set to 0 for performance run
	parameter				DebugDRAMReadTiming =	0; // NOTE: set to 0 for performance run [NOTE: we un-implemented this.  look in SVN for old code ...]

	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	
	`include "PathORAM.vh" 
	`include "UORAM.vh" 
	
	`include "DMLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "CommandsLocal.vh"
	`include "JTAG.vh"
	
	localparam				ORAMUValid = ORAML + 3; // Note: +3 assumes 50% utilization at Z=4

	// TODO: remove 	localparam	DelayedWB =	0; 
	// there is some logic in BackendControllerCore that implicitly
	// assumes REW==DWB.  Careful when enabling it.

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------

  	input 					Clock, Reset;

	//--------------------------------------------------------------------------
	//	User interface
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] Cmd;
	input	[ORAMU-1:0]		PAddr;
	input	[DMWidth-1:0]	WMask;
	input					CmdValid;
	output 					CmdReady;

	input	[FEDWidth-1:0]	DataIn;
	input					DataInValid;
	output 					DataInReady;

	output	[FEDWidth-1:0]	DataOut;
	output 					DataOutValid;
	input 					DataOutReady;

	//--------------------------------------------------------------------------
	//	DRAM interface
	//--------------------------------------------------------------------------

	output	[DDRAWidth-1:0]	DRAMAddress;
	output	[DDRCWidth-1:0]	DRAMCommand;
	output					DRAMCommandValid;
	input					DRAMCommandReady;

	input	[BEDWidth-1:0]	DRAMReadData;
	input					DRAMReadDataValid;

	output	[BEDWidth-1:0]	DRAMWriteData;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;

	//--------------------------------------------------------------------------
	//	Utility interface
	//--------------------------------------------------------------------------

	input					Mode_DummyGen;

	//--------------------------------------------------------------------------
	//	Status/Debugging interface
	//--------------------------------------------------------------------------
	
	output	[JTWidth_PMMAC-1:0] JTAG_PMMAC;
	output	[JTWidth_UORAM-1:0] JTAG_UORAM;
	output	[JTWidth_Frontend-1:0] JTAG_Frontend;	
	
	output	[JTWidth_AES-1:0] JTAG_AES;
	output	[JTWidth_StashCore-1:0] JTAG_StashCore;
	output	[JTWidth_Stash-1:0] JTAG_Stash;
	output	[JTWidth_StashTop-1:0] JTAG_StashTop;	
	output	[JTWidth_BackendCore-1:0] JTAG_BackendCore;
	output	[JTWidth_Backend-1:0] JTAG_Backend;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	wire					AESClock;

	// Frontend - Backend

	(* mark_debug = "TRUE" *)	wire					BEnd_CmdReady, BEnd_CmdValid;
	(* mark_debug = "TRUE" *)	wire	[BECMDWidth-1:0] BEnd_Cmd;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]		BEnd_PAddr;
	(* mark_debug = "TRUE" *)	wire	[ORAML-1:0]		CurrentLeaf, RemappedLeaf;

	(* mark_debug = "TRUE" *)	wire	[FEDWidth-1:0]	LoadData, StoreData;
	(* mark_debug = "TRUE" *)	wire					LoadReady, LoadValid, StoreValid, StoreReady;

	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------

	`ifdef SIMULATION
		initial begin
			$display("[%m] DDRAWidth = %d", DDRAWidth);

			if (ORAML + 1 > 32) begin
				$display("[%m] WARNING: Designs with more than 32 levels will be slightly more expensive resource-wise, because path-deep FIFOs won't pack as efficiently into LUTRAM.");
			end

			if (DDRDWidth < BEDWidth ||
				DebugDRAMReadTiming || // TODO this is commented out in backend right now ...
				DDRDWidth % BEDWidth != 0) 	begin
				$display("[%m] ERROR: Illegal parameter setting."); // See BucketLocal.vh for more information.
				$finish;
			end
		end
	`endif

	//--------------------------------------------------------------------------
	//	Clocking
	//--------------------------------------------------------------------------

	generate if (SlowAESClock || `ifdef ASIC 1 `else 0 `endif) begin:SLOW_AES
		assign	AESClock =							Clock;
	end else begin:FAST_AES
		// Increases the clock by 50%
		aes_clock	ci15( 	.clk_in1(				Clock),
							.clk_out1(				AESClock),
							.reset(					Reset),
							.locked(				));
	end endgenerate

	//--------------------------------------------------------------------------
	//	Core modules
	//--------------------------------------------------------------------------

	Frontend #(  			.ORAMU(         		ORAMU),
							.ORAML(         		ORAML),
							.ORAMB(         		ORAMB),
							.FEDWidth(				FEDWidth),
							.EnableIV(				EnableIV),
							.Recursion(     		Recursion),
							.EnablePLB(				EnablePLB),
							.PLBCapacity(   		PLBCapacity),
							.PRFPosMap(				PRFPosMap))

				front_end(	.Clock(             	Clock),
							.Reset(					Reset),

							.CmdInReady(			CmdReady),
							.CmdInValid(			CmdValid),
							.CmdIn(					Cmd),
							.WMaskIn(				WMask),
							.ProgAddrIn(			PAddr),
							.DataInReady(			DataInReady),
							.DataInValid(			DataInValid),
							.DataIn(				DataIn),
							.ReturnDataReady(		DataOutReady),
							.ReturnDataValid(		DataOutValid),
							.ReturnData(			DataOut),

							.CmdOutReady(			BEnd_CmdReady),
							.CmdOutValid(			BEnd_CmdValid),
							.CmdOut(				BEnd_Cmd),
							.AddrOut(				BEnd_PAddr),
							.OldLeaf(				CurrentLeaf),
							.NewLeaf(				RemappedLeaf),
							.StoreDataReady(		StoreReady),
							.StoreDataValid(		StoreValid),
							.StoreData(				StoreData),
							.LoadDataReady(			LoadReady),
							.LoadDataValid(			LoadValid),
							.LoadData(				LoadData),
							
							.JTAG_PMMAC(			JTAG_PMMAC), 
							.JTAG_UORAM(			JTAG_UORAM), 
							.JTAG_Frontend(			JTAG_Frontend));

	PathORAMBackend #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.ORAME(					ORAME),

							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							.DelayedWB(				1'b0),

							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),
							.ORAMUValid(			ORAMUValid))
				back_end (	.Clock(					Clock),
			                .AESClock(				AESClock),
							.Reset(					Reset),

							.Command(				BEnd_Cmd),
							.PAddr(					BEnd_PAddr),
							.CurrentLeaf(			CurrentLeaf),
							.RemappedLeaf(			RemappedLeaf),
							.CommandValid(			BEnd_CmdValid),
							.CommandReady(			BEnd_CmdReady),
							.LoadData(				LoadData),
							.LoadValid(				LoadValid),
							.LoadReady(				LoadReady),
							.StoreData(				StoreData),
							.StoreValid(			StoreValid),
							.StoreReady(			StoreReady),

							.DRAMCommandAddress(	DRAMAddress),
							.DRAMCommand(			DRAMCommand),
							.DRAMCommandValid(		DRAMCommandValid),
							.DRAMCommandReady(		DRAMCommandReady),

							.DRAMReadData(			DRAMReadData),
							.DRAMReadDataValid(		DRAMReadDataValid),

							.DRAMWriteData(			DRAMWriteData),
							.DRAMWriteDataValid(	DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMWriteDataReady),
							
							.Mode_DummyGen(			Mode_DummyGen),
							
							.JTAG_AES(				JTAG_AES),
							.JTAG_StashCore(		JTAG_StashCore), 
							.JTAG_Stash(			JTAG_Stash), 
							.JTAG_StashTop(			JTAG_StashTop), 
							.JTAG_BackendCore(		JTAG_BackendCore), 
							.JTAG_Backend(			JTAG_Backend));

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
