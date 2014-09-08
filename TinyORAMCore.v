
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

	Cmd, PAddr,
	CmdValid, CmdReady,

	DataIn,
	DataInValid, DataInReady,

	DataOut,
	DataOutValid, DataOutReady,

	DRAMAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid,
	DRAMWriteData, DRAMWriteMask, DRAMWriteDataValid, DRAMWriteDataReady
	);

	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------

	// Debugging

	/*
		SlowAESClock:			AES should use the same clock as the rest of the
								design
		DebugDRAMReadTiming: 	Don't send PathBuffer data to AES until the
								PathBuffer has received an entire path.  This
								eliminates differences in MIG vs. simulation
								read timing.
	*/
	parameter				SlowAESClock =			1; // NOTE: set to 0 for performance run
	parameter				DebugDRAMReadTiming =	0; // NOTE: set to 0 for performance run

	// Frontend-backend

	parameter				EnablePLB = 			1,
							EnableREW =				0,
							EnableAES =				0,
   							EnableIV =				1;

	// ORAM

	parameter				ORAMB =					512,
							ORAMU =					32,
							ORAML =					21,
							ORAMZ =					`ifdef ORAMZ `ORAMZ `else (EnableREW) ? 5 : 4 `endif,
							ORAML =					8,
							ORAMZ =					`ifdef ORAMZ `ORAMZ `else (EnableREW) ? 5 : 12 `endif,
							ORAMC =					10,
							ORAME =					5;

	parameter				FEDWidth =				64,
							BEDWidth =				64;

    parameter				NumValidBlock = 		1 << 13,
							Recursion = 			2,
							PLBCapacity = 			8192 << 3, // 8KB PLB
							PRFPosMap =         	EnableIV;

	// Hardware

	parameter				Overclock =				0;

	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	`define PARAMS_H `include "PathORAM.vh" `undef PARAMS_H
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "CommandsLocal.vh"

	localparam				ORAMUValid =			`log2(NumValidBlock) + 1;

	// No scheme currently needs DWB
	// [Note] there is some logic in BackendControllerCore that implicitly
	// assumes REW==DWB.  Careful when enabling it.
	// localparam				DelayedWB =				0;

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------

  	input 					Clock, Reset;

	//--------------------------------------------------------------------------
	//	User interface
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] Cmd;
	input	[ORAMU-1:0]		PAddr;
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
	output	[DDRMWidth-1:0]	DRAMWriteMask;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;

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
							.NumValidBlock( 		NumValidBlock),
							.Recursion(     		Recursion),
							.EnablePLB(				EnablePLB),
							.PLBCapacity(   		PLBCapacity),
							.PRFPosMap(				PRFPosMap))

				front_end(	.Clock(             	Clock),
							.Reset(					Reset),

							.CmdInReady(			CmdReady),
							.CmdInValid(			CmdValid),
							.CmdIn(					Cmd),
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
							.LoadData(				LoadData));

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
							.ORAMUValid(			ORAMUValid),
							.DebugDRAMReadTiming(	DebugDRAMReadTiming))
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
							.DRAMWriteMask(			DRAMWriteMask),
							.DRAMWriteDataValid(	DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMWriteDataReady));

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
