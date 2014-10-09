
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMBackend
//	Desc:		The stash, AES, address generation, and throughput back-pressure
//				logic (e.g., dummy access control, REW pattern control)
//==============================================================================
module PathORAMBackend(
	Clock, AESClock, Reset,

	Command, PAddr, CurrentLeaf, RemappedLeaf,
	CommandValid, CommandReady,

	LoadData,
	LoadValid, LoadReady,

	StoreData,
	StoreValid, StoreReady,

	DRAMCommandAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid,
	DRAMWriteData, DRAMWriteMask, DRAMWriteDataValid, DRAMWriteDataReady,
	
	Mode_DummyGen
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"

	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "CommandsLocal.vh"

	parameter				ORAMUValid =			21;

	parameter				DebugDRAMReadTiming =	0;

	localparam				ORAMLogL = 				`log2(ORAML+1);

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------

	input 					Clock, AESClock, Reset;

	//--------------------------------------------------------------------------
	//	Frontend Interface
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] Command;
	input	[ORAMU-1:0]		PAddr;
	input	[ORAML-1:0]		CurrentLeaf; // If Command == Append, this is XX
	input	[ORAML-1:0]		RemappedLeaf;
	input					CommandValid;
	output 					CommandReady;

	// TODO set CommandReady = 0 if LoadDataReady = 0 (i.e., the front end can't take our result!)

	output	[FEDWidth-1:0]	LoadData;
	output					LoadValid;
	input 					LoadReady;

	input	[FEDWidth-1:0]	StoreData;
	input 					StoreValid;
	output 					StoreReady;

	//--------------------------------------------------------------------------
	//	DRAM Interface
	//--------------------------------------------------------------------------

	output	[DDRAWidth-1:0]	DRAMCommandAddress;
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
	//	Utility interface
	//--------------------------------------------------------------------------
	
	input					Mode_DummyGen;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	// Backend - AES

    (* mark_debug = "TRUE" *)	wire 	[BEDWidth-1:0]	AES_DRAMWriteData, AES_DRAMReadData;
    (* mark_debug = "TRUE" *)	wire					AES_DRAMWriteDataValid, AES_DRAMWriteDataReady;
	(* mark_debug = "TRUE" *)	wire					AES_DRAMReadDataValid, AES_DRAMReadDataReady;

	wire					PBF_DRAMReadDataReady;

	// REW

	wire    [ORAMU-1:0]		ROPAddr;
	wire	[ORAML-1:0]		ROLeaf;
	wire                    REWRoundDummy;

	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------

	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (DRAMReadDataValid && ~PBF_DRAMReadDataReady) begin
				$display("[%m @ %t] ERROR: Path buffer overflow", $time);
				$finish;
			end
		end
	`endif

	//--------------------------------------------------------------------------
	//	Address generation & the stash
	//--------------------------------------------------------------------------

	PathORAMBackendCore #(	.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.ORAME(					ORAME),

							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							.DelayedWB(				DelayedWB),

							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),

							.ORAMUValid(			ORAMUValid))
			bend_core(		.Clock(					Clock),
				`ifdef ASIC
							.Reset(					Reset),
				`else
							.Reset(					1'b0),
				`endif
							.Command(				Command),
							.PAddr(					PAddr),
							.CurrentLeaf(			CurrentLeaf),
							.RemappedLeaf(			RemappedLeaf),
							.CommandValid(			CommandValid),
							.CommandReady(			CommandReady),
							.LoadData(				LoadData),
							.LoadValid(				LoadValid),
							.LoadReady(				LoadReady),
							.StoreData(				StoreData),
							.StoreValid(			StoreValid),
							.StoreReady(			StoreReady),

							.DRAMCommandAddress(	DRAMCommandAddress),
							.DRAMCommand(			DRAMCommand),
							.DRAMCommandValid(		DRAMCommandValid),
							.DRAMCommandReady(		DRAMCommandReady),

							.DRAMReadData(			AES_DRAMReadData),
							.DRAMReadDataValid(		AES_DRAMReadDataValid),
							.DRAMReadDataReady(		AES_DRAMReadDataReady),

							.DRAMWriteData(			AES_DRAMWriteData),
							.DRAMWriteDataValid(	AES_DRAMWriteDataValid),
							.DRAMWriteDataReady(	AES_DRAMWriteDataReady),

                            .ROPAddr(               ROPAddr),
							.ROLeaf(				ROLeaf),
							.REWRoundDummy(			REWRoundDummy),
							
							.Mode_DummyGen(			Mode_DummyGen));

	//--------------------------------------------------------------------------
	//	Symmetric Encryption
	//--------------------------------------------------------------------------

	generate if (EnableREW) begin:REW_AES
		AESREWORAM	#(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAME(					ORAME),
							.BEDWidth(				BEDWidth),
							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableIV(				EnableIV),
							.DelayedWB(				DelayedWB),
							.ORAMUValid(			ORAMUValid))
			aes(			.Clock(					Clock),
							.FastClock(				AESClock),
			`ifdef ASIC
							.Reset(					Reset),
			`else
							.Reset(					1'b0),
			`endif
							.ROPAddr(				ROPAddr),
							.ROLeaf(				ROLeaf),
							.ROStartAESValid(		ROStartAESValid),
							.ROStartAESReady(		ROStartAESReady),

							.BEDataOut(				AES_DRAMReadData),
							.BEDataOutValid(		AES_DRAMReadDataValid),

							.BEDataIn(				AES_DRAMWriteData),
							.BEDataInValid(			AES_DRAMWriteDataValid),
							.BEDataInReady(			AES_DRAMWriteDataReady),

							.DRAMReadData(			PBF_DRAMReadData), // TODO this design shouldn't use path buffer either; this won't work right now
							.DRAMReadDataValid(		PBF_DRAMReadDataValid),
							.DRAMReadDataReady(		PBF_DRAMReadDataReady),

							.DRAMWriteData(			DRAMWriteData),
							.DRAMWriteDataValid(	DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMWriteDataReady));
	end else if (EnableAES) begin:BASIC_AES
		AESPathORAM #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.Overclock(				Overclock),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth))
				aes(		.Clock(					Clock),
				`ifdef ASIC
							.Reset(					Reset),
				`else
							.Reset(					1'b0),
				`endif
							.DRAMReadData(			DRAMReadData),
							.DRAMReadDataValid(		DRAMReadDataValid),
							.DRAMReadDataReady(		PBF_DRAMReadDataReady),

							.DRAMWriteData(			DRAMWriteData),
							.DRAMWriteDataValid(	DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMWriteDataReady),

							.BackendRData(			AES_DRAMReadData),
							.BackendRValid(			AES_DRAMReadDataValid),
							.BackendRReady(			AES_DRAMReadDataReady),

							.BackendWData(			AES_DRAMWriteData),
							.BackendWValid(			AES_DRAMWriteDataValid),
							.BackendWReady(			AES_DRAMWriteDataReady));
	end else begin:NO_AES
		assign	AES_DRAMReadData =					DRAMReadData;
		assign	AES_DRAMReadDataValid =				DRAMReadDataValid;
		assign	PBF_DRAMReadDataReady =				AES_DRAMReadDataReady;

		assign	DRAMWriteData =						AES_DRAMWriteData;
		assign	DRAMWriteDataValid =				AES_DRAMWriteDataValid;
		assign	AES_DRAMWriteDataReady =			DRAMWriteDataReady;
	end endgenerate
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	DRAM Write Interface
	//--------------------------------------------------------------------------

	assign	DRAMWriteMask =							{DDRMWidth{1'b0}};

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
