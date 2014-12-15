
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
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,
	
	Mode_DummyGen,
	
	JTAG_AES, JTAG_StashCore, JTAG_Stash, JTAG_StashTop, JTAG_BackendCore, JTAG_Backend
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"

	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "CommandsLocal.vh"
	
	`include "DMLocal.vh"
	`include "JTAG.vh"

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
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;

	//--------------------------------------------------------------------------
	//	Utility interface
	//--------------------------------------------------------------------------
	
	input					Mode_DummyGen;
	
	//--------------------------------------------------------------------------
	//	Status/Debugging interface
	//--------------------------------------------------------------------------
	
	output	[JTWidth_AES-1:0] JTAG_AES;
	output	[JTWidth_StashCore-1:0] JTAG_StashCore;
	output	[JTWidth_Stash-1:0] JTAG_Stash;
	output	[JTWidth_StashTop-1:0] JTAG_StashTop;	
	output	[JTWidth_BackendCore-1:0] JTAG_BackendCore;
	output	[JTWidth_Backend-1:0] JTAG_Backend;
	
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
	
	// Debugging

	wire					// F1
							CommandValid_Delay,
							CommandReady_Delay,
							LoadValid_Delay,
							LoadReady_Delay,
							StoreValid_Delay,
							StoreReady_Delay,
							
							// F2
							DRAMReadDataValid_Delay,
							PBF_DRAMReadDataReady_Delay,
							DRAMWriteDataValid_Delay,
							DRAMWriteDataReady_Delay,
							AES_DRAMReadDataValid_Delay,
							AES_DRAMReadDataReady_Delay,
							AES_DRAMWriteDataValid_Delay,
							AES_DRAMWriteDataReady_Delay;
	
	wire	[BECMDWidth-1:0] Command_Delay;
	wire	[ORAMU-1:0]		PAddr_Delay;
	wire	[ORAML-1:0]		CurrentLeaf_Delay, RemappedLeaf_Delay;
	
	wire	[DBCCWidth-1:0] BEndDataLoadCount, BEndDataStoreCount;		
			
	wire	[DBDCWidth-1:0]	AESDataLoadCount,
							AESDataStoreCount,
							DRAMDataLoadCount,
							DRAMDataStoreCount;
							
							// F3
	wire					ERROR_OF1;
	
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------

	MCounter #(DBCCWidth) 	bdatal(Clock, Reset, LoadValid_Delay && LoadReady_Delay, BEndDataLoadCount),
							bdatas(Clock, Reset, StoreValid_Delay && StoreReady_Delay, BEndDataStoreCount);	
														
	MCounter #(DBDCWidth) 	aesdatal(Clock, Reset, AES_DRAMReadDataValid_Delay && AES_DRAMReadDataReady_Delay, AESDataLoadCount),
							aesdatas(Clock, Reset, AES_DRAMWriteDataValid_Delay && AES_DRAMWriteDataReady_Delay, AESDataStoreCount),
							
							dramdatal(Clock, Reset, DRAMReadDataValid_Delay, DRAMDataLoadCount),
							dramdatas(Clock, Reset, DRAMWriteDataValid_Delay && DRAMWriteDataReady_Delay, DRAMDataStoreCount);
												
	assign	JTAG_Backend =							{
														ERROR_OF1,
														
														CommandValid_Delay,
														CommandReady_Delay,
														LoadValid_Delay,
														LoadReady_Delay,
														StoreValid_Delay,
														StoreReady_Delay,
														
														DRAMReadDataValid_Delay,
														PBF_DRAMReadDataReady_Delay,
														DRAMWriteDataValid_Delay,
														DRAMWriteDataReady_Delay,
														
														AES_DRAMReadDataValid_Delay,
														AES_DRAMReadDataReady_Delay,
														AES_DRAMWriteDataValid_Delay,
														AES_DRAMWriteDataReady_Delay,
														
														BEndDataLoadCount,
														BEndDataStoreCount,
														
														AESDataLoadCount,
														AESDataStoreCount,
														DRAMDataLoadCount,
														DRAMDataStoreCount,
							
														Command_Delay, 
														PAddr_Delay, 	
														CurrentLeaf_Delay,
														RemappedLeaf_Delay
													};
	
	Register	#(			.Width(					BECMDWidth + ORAMU + 2 * ORAML))
				lastcmd(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				CommandValid && CommandReady),
							.In(					{Command, 		PAddr, 			CurrentLeaf, 		RemappedLeaf}),
							.Out(					{Command_Delay, PAddr_Delay, 	CurrentLeaf_Delay, 	RemappedLeaf_Delay}));
	
	Pipeline 	#(JTWidth_BackendF1 + JTWidth_BackendF2) 
				jtag_pipe(Clock, Reset, 
													{
														CommandValid,
														CommandReady,
														LoadValid,
														LoadReady,
														StoreValid,
														StoreReady,
														
														DRAMReadDataValid,
														PBF_DRAMReadDataReady,
														DRAMWriteDataValid,
														DRAMWriteDataReady,
														AES_DRAMReadDataValid,
														AES_DRAMReadDataReady,
														AES_DRAMWriteDataValid,
														AES_DRAMWriteDataReady
													}, 
													
													{
														CommandValid_Delay,
														CommandReady_Delay,
														LoadValid_Delay,
														LoadReady_Delay,
														StoreValid_Delay,
														StoreReady_Delay,
														
														DRAMReadDataValid_Delay,
														PBF_DRAMReadDataReady_Delay,
														DRAMWriteDataValid_Delay,
														DRAMWriteDataReady_Delay,
														AES_DRAMReadDataValid_Delay,
														AES_DRAMReadDataReady_Delay,
														AES_DRAMWriteDataValid_Delay,
														AES_DRAMWriteDataReady_Delay
													});
	
	Register1b 	errno1(Clock, Reset, DRAMReadDataValid && ~PBF_DRAMReadDataReady, ERROR_OF1);
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (ERROR_OF1) begin
				$display("[%m @ %t] ERROR: Path buffer overflow", $time);
				$finish;
			end
		end
	`endif

	//--------------------------------------------------------------------------
	//	Address generation & the stash
	//--------------------------------------------------------------------------

`ifndef FPGA
	PathORAMBackendCore
`else
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
							.BEDWidth(				BEDWidth))
`endif							
			bend_core(		.Clock(					Clock),
				`ifndef FPGA
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
							
							.Mode_DummyGen(			Mode_DummyGen),
							
							.JTAG_StashCore(		JTAG_StashCore), 
							.JTAG_Stash(			JTAG_Stash), 
							.JTAG_StashTop(			JTAG_StashTop), 
							.JTAG_BackendCore(		JTAG_BackendCore));

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
							.DelayedWB(				DelayedWB))
			aes(			.Clock(					Clock),
							.FastClock(				AESClock),
			`ifndef FPGA
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
	`ifndef FPGA
		AESPathORAM
	`else
		AESPathORAM #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.Overclock(				Overclock),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth))
	`endif						
				aes(		.Clock(					Clock),
				`ifndef FPGA
							.Reset(					Reset),
				`else
							.Reset(					1'b0),
				`endif
				
							// Note: we tie this to constant here so that in ASIC, when we build AESPathORAM.v as a top module, logic doesn't get pruned.
							.Key(					{AESWidth{1'b1}}),
				
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
							.BackendWReady(			AES_DRAMWriteDataReady),
							
							.JTAG_AES(				JTAG_AES));
	end else begin:NO_AES
		assign	JTAG_AES =							{JTWidth_AES{1'b0}};
	
		assign	AES_DRAMReadData =					DRAMReadData;
		assign	AES_DRAMReadDataValid =				DRAMReadDataValid;
		assign	PBF_DRAMReadDataReady =				AES_DRAMReadDataReady;

		assign	DRAMWriteData =						AES_DRAMWriteData;
		assign	DRAMWriteDataValid =				AES_DRAMWriteDataValid;
		assign	AES_DRAMWriteDataReady =			DRAMWriteDataReady;
	end endgenerate
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
