
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMBackendCore
//	Desc:		Stash, DRAM address and top level state machine that interfaces
//				with the FrontEnd.
//==============================================================================
module PathORAMBackendCore(
	Clock, Reset,

	Command, PAddr, CurrentLeaf, RemappedLeaf,
	CommandValid, CommandReady,

	LoadData,
	LoadValid, LoadReady,

	StoreData,
	StoreValid, StoreReady,

	DRAMCommandAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,

	ROPAddr, ROLeaf, REWRoundDummy,
	
	Mode_DummyGen,
	
	JTAG_StashCore, JTAG_Stash, JTAG_StashTop, JTAG_BackendCore
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"

	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "IVLocal.vh"
	`include "CommandsLocal.vh"
	
	`include "DMLocal.vh"
	`include "JTAG.vh"

	localparam				STWidth =				2,
							ST_Idle =				2'd0,
							ST_Append =				2'd1,
							ST_Access =				2'd2;

	localparam				BBEDWidth =				`max(`log2(BlkSize_BEDChunks + 1), 1); // Block BED width

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------

  	input 					Clock, Reset;

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
	output					DRAMReadDataReady;

	output	[BEDWidth-1:0]	DRAMWriteData;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;

	//--------------------------------------------------------------------------
	//	REW Interface
	//--------------------------------------------------------------------------

	output  [ORAMU-1:0]		ROPAddr;
	output  [ORAML-1:0]		ROLeaf;
	output 					REWRoundDummy;

	//--------------------------------------------------------------------------
	//	Utility Interface
	//--------------------------------------------------------------------------
	
	input					Mode_DummyGen;
	
	//--------------------------------------------------------------------------
	//	Status/Debugging Interface
	//--------------------------------------------------------------------------
	
	output	[JTWidth_StashCore-1:0] JTAG_StashCore;
	output	[JTWidth_Stash-1:0] JTAG_Stash;
	output	[JTWidth_StashTop-1:0] JTAG_StashTop;	
	output	[JTWidth_BackendCore-1:0] JTAG_BackendCore;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	// Control logic

	(* mark_debug = "TRUE" *)	reg		[STWidth-1:0]	CS, NS;
	wire					CSIdle, CSAppend, CSAccess;

	(* mark_debug = "FALSE" *)	wire					Stash_AppendCmdValid, Stash_RdRmvCmdValid, Stash_UpdateCmdValid;

	// Front-end interfaces

	(* mark_debug = "FALSE" *)	wire	[BECMDWidth-1:0] Command_Internal;
	(* mark_debug = "FALSE" *)	wire	[ORAMU-1:0]		PAddr_Internal;
	(* mark_debug = "FALSE" *)	wire	[ORAML-1:0]		CurrentLeaf_Internal, RemappedLeaf_Internal;
	(* mark_debug = "FALSE" *)	wire					Command_InternalValid, Command_InternalReady;

	wire	[BEPWidth-1:0]	MACSCount;
	wire	[ORAMH-1:0]		Stash_ReturnMAC;
	wire					StoreValid_Pre, StoreReady_Pre, StoringMAC, Store_MACValid;

	wire	[FEDWidth-1:0]	LoadData_Pre;
	wire					LoadValid_Pre, LoadReady_Pre;

	(* mark_debug = "FALSE" *)	wire	[BBEDWidth-1:0] EvictBuf_Chunks;
	(* mark_debug = "FALSE" *)	wire	[BBEDWidth-1:0] ReturnBuf_Space;

	(* mark_debug = "FALSE" *)	wire	[BEDWidth-1:0]	Store_ShiftBufData;
	(* mark_debug = "FALSE" *)	wire					Store_ShiftBufValid, Store_ShiftBufReady;

	(* mark_debug = "FALSE" *)	wire	[BEDWidth-1:0]	Load_ShiftBufData;
	(* mark_debug = "FALSE" *)	wire					Load_ShiftBufValid, Load_ShiftBufReady;

	// Stash

	(* mark_debug = "FALSE" *)	wire	[BEDWidth-1:0]	Stash_StoreData;
	(* mark_debug = "FALSE" *)	wire					Stash_StoreDataValid, Stash_StoreDataReady;

	(* mark_debug = "FALSE" *)	wire	[BEDWidth-1:0]	Stash_ReturnData;
	wire					Stash_ReturnComplete;
	(* mark_debug = "FALSE" *)	wire					Stash_ReturnDataValid, Stash_ReturnDataReady;

	(* mark_debug = "FALSE" *)	wire	[BEDWidth-1:0]	Stash_DRAMWriteData;
	(* mark_debug = "FALSE" *)	wire					Stash_DRAMWriteDataValid, Stash_DRAMWriteDataReady;

	(* mark_debug = "FALSE" *)	wire					StashAlmostFull;

	// Address generator

	(* mark_debug = "FALSE" *)	wire	[DDRAWidth-1:0]	AddrGen_DRAMCommandAddress;
	(* mark_debug = "FALSE" *)	wire	[DDRCWidth-1:0]	AddrGen_DRAMCommand;
	(* mark_debug = "FALSE" *)	wire					AddrGen_DRAMCommandValid, AddrGen_DRAMCommandReady;

	(* mark_debug = "FALSE" *)	wire	[DDRAWidth-1:0]	AddrGen_DRAMCommandAddress_Internal;
	(* mark_debug = "FALSE" *)	wire	[DDRCWidth-1:0]	AddrGen_DRAMCommand_Internal;
	(* mark_debug = "FALSE" *)	wire					AddrGen_DRAMCommandValid_Internal, AddrGen_DRAMCommandReady_Internal;

	// Stash

	(* mark_debug = "FALSE" *)	wire	[STCMDWidth-1:0] Stash_Command;
	(* mark_debug = "FALSE" *)	wire					Stash_CommandValid, Stash_CommandReady;

	(* mark_debug = "FALSE" *)	wire	[BECMDWidth-1:0] Stash_BECommand;
	(* mark_debug = "FALSE" *)	wire	[ORAMU-1:0]		Stash_PAddr;
	(* mark_debug = "FALSE" *)	wire	[ORAML-1:0]		Stash_CurrentLeaf;
	(* mark_debug = "FALSE" *)	wire	[ORAML-1:0]		Stash_RemappedLeaf;
	(* mark_debug = "FALSE" *)	wire	[ORAMH-1:0]		Stash_MAC;
	(* mark_debug = "FALSE" *)	wire					Stash_SkipWriteback, Stash_AccessIsDummy;

	(* mark_debug = "FALSE" *)	wire	[BECMDWidth-1:0] Control_Command;
	(* mark_debug = "FALSE" *)	wire	[ORAMU-1:0]		Control_PAddr;
	(* mark_debug = "FALSE" *)	wire	[ORAML-1:0]		Control_CurrentLeaf;
	(* mark_debug = "FALSE" *)	wire	[ORAML-1:0]		Control_RemappedLeaf;
	(* mark_debug = "FALSE" *)	wire					Control_CommandReq, Control_CommandDone;

	(* mark_debug = "FALSE" *)	wire	[ORAML-1:0]		AddrGen_Leaf;
	(* mark_debug = "FALSE" *)	wire					AddrGen_InReady, AddrGen_InValid;
	(* mark_debug = "FALSE" *)	wire					AddrGen_PathRead, AddrGen_HeaderOnly;

	// debugging

	(* mark_debug = "TRUE" *)	wire					ERROR_OF1, ERROR_OF2, ERROR_BEndInner;

	//--------------------------------------------------------------------------
	//	Initial state
	//--------------------------------------------------------------------------

	`ifdef FPGA
		initial begin
			CS = ST_Idle;
		end
	`endif

	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------

	Register1b 	errno1(Clock, Reset, DRAMReadDataValid && ~DRAMReadDataReady, 			ERROR_OF1);
	Register1b 	errno2(Clock, Reset, Stash_ReturnDataValid && !Stash_ReturnDataReady, 	ERROR_OF2);
	Register1b 	errANY(Clock, Reset, ERROR_OF1 || ERROR_OF2,							ERROR_BEndInner);

	assign	JTAG_BackendCore =						{
														ERROR_OF1,
														ERROR_OF2
													};
	
	`ifdef SIMULATION
		reg [STWidth-1:0] CS_Delayed;
		integer WriteCount_Sim = 0;
		reg	StartedFirstAccess = 1'b0;

		always @(posedge Clock) begin
			CS_Delayed <= CS;

			if (ERROR_OF1) begin
				$display("[%m @ %t] ERROR: BEnd needed backpressure!", $time);
				$finish;
			end

			if (ERROR_OF2) begin
				$display("[%m @ %t] ERROR: BEnd load buffer needed backpressure! (or we returned data when we shouldn't have ...)", $time);
				$finish;
			end

			if (CSAccess) StartedFirstAccess <= 1'b1;

			if (DRAMWriteDataValid & DRAMWriteDataReady)
				WriteCount_Sim = WriteCount_Sim + 1;

			if (StartedFirstAccess & DRAMReadDataValid & DRAMReadDataReady & (WriteCount_Sim % PathSize_DRBursts)) begin
				// Whenever we are doing reads, we should have written the right amount back
				$display("[%m @ %t] ERROR: We wrote back %d blocks (not aligned to path length ...)", $time, WriteCount_Sim);
				$finish;
			end

			if (CS_Delayed != CS) begin
				if (CSAccess)
					$display("[%m @ %t] Backend: start access, dummy = %b, command = %x, leaf = %x", $time, Stash_AccessIsDummy, Command_Internal, AddrGen_Leaf);
				if (CSAppend)
					$display("[%m @ %t] Backend: start append", $time);
			end
	`ifdef SIMULATION_VERBOSE_BE
			if (DRAMCommandValid & DRAMCommandReady) begin
				$display("[%m @ %t] DRAM command write? = %b, addr = %d (hex = %x)", $time, DRAMCommand == DDR3CMD_Write, DRAMCommandAddress, DRAMCommandAddress);
			end

			if (DRAMWriteDataValid & DRAMWriteDataReady) begin
				$display("[%m @ %t] DRAM write %x", $time, DRAMWriteData);
			end

			if (DRAMReadDataValid) begin
				$display("[%m @ %t] DRAM read %x", $time, DRAMReadData);
			end
	`endif
		end
	`endif

	//--------------------------------------------------------------------------
	//	Front-end commands
	//--------------------------------------------------------------------------

	FIFORegister #(			.Width(					BECMDWidth + ORAMU + ORAML*2),
							.BWLatency(				1))
				cmd_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{Command,			PAddr, 			CurrentLeaf, 			RemappedLeaf}),
							.InValid(				CommandValid),
							.InAccept(				CommandReady),
							.OutData(				{Command_Internal,	PAddr_Internal,	CurrentLeaf_Internal,	RemappedLeaf_Internal}),
							.OutSend(				Command_InternalValid),
							.OutReady(				Command_InternalReady));

	//--------------------------------------------------------------------------
	//	Control logic
	//--------------------------------------------------------------------------

	assign	CSIdle =								CS == ST_Idle;
	assign	CSAppend =								CS == ST_Append;
	assign	CSAccess =								CS == ST_Access;

	// SECURITY: We don't allow _any_ access to start until DummyLeaf_Valid; we
	// don't want to start real accesses _earlier_ than dummy accesses
	assign	Stash_AppendCmdValid =					CSIdle & Command_InternalValid & (Command_Internal == BECMD_Append) & (EvictBuf_Chunks >= BlkSize_BEDChunks) & Store_MACValid;
	assign	Stash_UpdateCmdValid =					CSIdle & Command_InternalValid & (Command_Internal == BECMD_Update) & (EvictBuf_Chunks >= BlkSize_BEDChunks) & Store_MACValid;
	assign	Stash_RdRmvCmdValid = 					CSIdle & Command_InternalValid & ((Command_Internal == BECMD_Read) | (Command_Internal == BECMD_ReadRmv)) & (ReturnBuf_Space >= BlkSize_BEDChunks);

	assign	Control_Command =						Command_Internal;
	assign	Control_PAddr =							PAddr_Internal;
	assign	Control_CurrentLeaf =					CurrentLeaf_Internal;
	assign	Control_RemappedLeaf =					RemappedLeaf_Internal;
	assign	Control_CommandReq =					CSAppend | CSAccess;

	assign	Command_InternalReady =					Control_CommandDone & (CSAppend | CSAccess);

	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Idle;
		else CS <= 									NS;
	end

	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Idle :
				if (~ERROR_BEndInner)
					if (Stash_AppendCmdValid) // do appends first ("greedily") because they are cheap
						NS =						ST_Append;
					else if (Stash_RdRmvCmdValid)
						NS =						ST_Access;
					else if (Stash_UpdateCmdValid)
						NS = 						ST_Access;
			ST_Append :
				if (Control_CommandDone) // When last chunk of data is appended
					NS = 							ST_Idle;
			ST_Access :
				if (Control_CommandDone) // At end of access
					NS =							ST_Idle;
		endcase
	end

	//--------------------------------------------------------------------------
	//	Front-end stores
	//--------------------------------------------------------------------------

	generate if (EnableIV) begin:STORE_MAC
		wire	[MACPADWidth-1:0] Stash_MAC_Wide;
		wire				StoreMACValid, StoreMACReady;

		MCounter #(BEPWidth) MAC_sc(Clock, 	Reset || Control_CommandDone, StoreValid && StoreReady, MACSCount);

		assign	StoringMAC =						MACSCount >= BlkSize_FEDChunks;
		assign	StoreReady =						CSIdle && ((StoringMAC) ? StoreMACReady : StoreReady_Pre);

		assign	StoreMACValid =						CSIdle && StoreValid && StoringMAC;

		FIFOShiftRound #(	.IWidth(				FEDWidth),
							.OWidth(				MACPADWidth),
							.Reverse(				1))
				st_m_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				StoreData),
							.InValid(				StoreMACValid),
							.InAccept(				StoreMACReady),
							.OutData(				Stash_MAC_Wide),
							.OutValid(				Store_MACValid),
							.OutReady(				Control_CommandDone));
		assign	Stash_MAC =							Stash_MAC_Wide[ORAMH-1:0];
	end else begin:STORE_NO_MAC
		assign	Store_MACValid =					1'b1;
		assign	StoringMAC =						1'b0;
		assign	StoreReady =						CSIdle && StoreReady_Pre;
	end endgenerate

	assign	StoreValid_Pre =						CSIdle && StoreValid && !StoringMAC;

	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				BEDWidth))
				st_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				StoreData),
							.InValid(				StoreValid_Pre),
							.InAccept(				StoreReady_Pre),
							.OutData(				Store_ShiftBufData),
							.OutValid(				Store_ShiftBufValid),
							.OutReady(				Store_ShiftBufReady));

	// SECURITY: Don't make a write-update unless the FE gives us a block first
	FIFORAM		#(			.Width(					BEDWidth),
							.Buffering(				BlkSize_BEDChunks))
				st_buf(		.Clock(					Clock),
							.Reset(					Reset),
							.OutFullCount(			EvictBuf_Chunks),
							.InData(				Store_ShiftBufData),
							.InValid(				Store_ShiftBufValid),
							.InAccept(				Store_ShiftBufReady),
							.OutData(				Stash_StoreData),
							.OutSend(				Stash_StoreDataValid),
							.OutReady(				Stash_StoreDataReady));

	//--------------------------------------------------------------------------
	//	Front-end loads
	//--------------------------------------------------------------------------

	generate if (EnableIV) begin:LOAD_MAC
		wire	[MACPADWidth-1:0] LoadMACData_Pre;
		wire	[FEDWidth-1:0] LoadMACData;
		wire				LoadMACValid, LoadMACReady;
		wire				BlockLoaded, LoadingMAC, LoadComplete;

		CountAlarm  #(  	.IThreshold(			BlkSize_FEDChunks),
							.Threshold(             BlkSize_FEDChunks + MAC_FEDChunks))
				MAC_lc(		.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				LoadValid && LoadReady),
							.Intermediate(			BlockLoaded),
							.Done(					LoadComplete));

		Register1b ldm_m(Clock, Reset || LoadComplete, BlockLoaded, LoadingMAC);

		if (MACPADWidth != ORAMH) begin:LMACWIDE
			assign	LoadMACData_Pre =				{{MACPADWidth-ORAMH{1'bx}}, Stash_ReturnMAC};
		end else begin:LMACNARROW
			assign	LoadMACData_Pre =				Stash_ReturnMAC;
		end
		
		FIFOShiftRound #(	.IWidth(				MACPADWidth),
							.OWidth(				FEDWidth),
							.Reverse(				1))
				st_m_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				LoadMACData_Pre),
							.InValid(				Stash_ReturnComplete),
							.InAccept(				),
							.OutData(				LoadMACData),
							.OutValid(				LoadMACValid),
							.OutReady(				LoadMACReady));

		assign	LoadData =							(LoadingMAC) ? LoadMACData : LoadData_Pre;
		assign	LoadValid =							(LoadingMAC) ? LoadMACValid : LoadValid_Pre;
		assign	LoadMACReady =						 LoadingMAC && LoadReady;
		assign	LoadReady_Pre =						~LoadingMAC && LoadReady;
	end else begin:NO_LOAD_MAC
		assign	LoadData =							LoadData_Pre;
		assign	LoadValid =							LoadValid_Pre;
		assign	LoadReady_Pre =						LoadReady;
	end endgenerate

	// SECURITY: Don't perform a read/rm until the front-end can take a whole block
	// NOTE: this should come before the shifter because the Stash ReturnData path
	// doesn't have backpressure
	//
	// Note: if we assume a bit more about the FE-BE interface, this can go away
	FIFORAM		#(			.Width(					BEDWidth),
							.Buffering(				BlkSize_BEDChunks))
				ld_buf(		.Clock(					Clock),
							.Reset(					Reset),
							.InEmptyCount(			ReturnBuf_Space),
							.InData(				Stash_ReturnData),
							.InValid(				Stash_ReturnDataValid),
							.InAccept(				Stash_ReturnDataReady),
							.OutData(				Load_ShiftBufData),
							.OutSend(				Load_ShiftBufValid),
							.OutReady(				Load_ShiftBufReady));

	FIFOShiftRound #(		.IWidth(				BEDWidth),
							.OWidth(				FEDWidth))
				ld_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				Load_ShiftBufData),
							.InValid(				Load_ShiftBufValid),
							.InAccept(				Load_ShiftBufReady),
							.OutData(				LoadData_Pre),
							.OutValid(				LoadValid_Pre),
							.OutReady(				LoadReady_Pre));

	//--------------------------------------------------------------------------
	//	Stash & AddrGen Control
	//--------------------------------------------------------------------------

	BackendCoreController #(.ORAMB(					ORAMB),
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
				control(	.Clock(					Clock),
							.Reset(					Reset),

							.Command(				Control_Command),
							.PAddr(					Control_PAddr),
							.CurrentLeaf(			Control_CurrentLeaf),
							.RemappedLeaf(			Control_RemappedLeaf),
							.CommandRequest(		Control_CommandReq),
							.CommandDone(			Control_CommandDone),

							.AddrGenLeaf(			AddrGen_Leaf),
							.AddrGenRead(			AddrGen_PathRead),
							.AddrGenHeader(			AddrGen_HeaderOnly),
							.AddrGenInValid(		AddrGen_InValid),
							.AddrGenInReady(		AddrGen_InReady),

							.StashCommand(			Stash_Command),
							.StashCommandValid(		Stash_CommandValid),
							.StashCommandReady(		Stash_CommandReady),

							.StashBECommand(		Stash_BECommand),
							.StashPAddr(			Stash_PAddr),
							.StashCurrentLeaf(		Stash_CurrentLeaf),
							.StashRemappedLeaf(		Stash_RemappedLeaf),
							.StashSkipWriteback(	Stash_SkipWriteback),
							.StashAccessIsDummy(	Stash_AccessIsDummy),

							.DataReadTransfer(		DRAMReadDataValid & DRAMReadDataReady),
							.DataWriteTransfer(		DRAMWriteDataValid & DRAMWriteDataReady),
							.AddrTransfer(			AddrGen_DRAMCommandValid_Internal & AddrGen_DRAMCommandReady_Internal),

							.StashAlmostFull(		StashAlmostFull),

							.ROPAddr(				ROPAddr),
							.ROLeaf(				ROLeaf),
							.REWRoundDummy(			REWRoundDummy),
							
							.Mode_DummyGen(			Mode_DummyGen));

	//--------------------------------------------------------------------------
	//	AddrGen
	//--------------------------------------------------------------------------

    AddrGen #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.BEDWidth(				BEDWidth),
							.EnableIV(				EnableIV))
				addr_gen(	.Clock(					Clock),
							.Reset(					Reset),
							.Start(					AddrGen_InValid),
							.Ready(					AddrGen_InReady),
							.RWIn(					AddrGen_PathRead),
							.BHIn(					AddrGen_HeaderOnly),
							.leaf(					AddrGen_Leaf),
							.CmdReady(				AddrGen_DRAMCommandReady_Internal),
							.CmdValid(				AddrGen_DRAMCommandValid_Internal),
							.Cmd(					AddrGen_DRAMCommand_Internal),
							.Addr(					AddrGen_DRAMCommandAddress_Internal));

	generate if (Overclock) begin:ADDR_DELAY
		FIFORegister	#(	.Width(					DDRAWidth + DDRCWidth))
				addr_dly(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{AddrGen_DRAMCommand_Internal,	AddrGen_DRAMCommandAddress_Internal}),
							.InValid(				AddrGen_DRAMCommandValid_Internal),
							.InAccept(				AddrGen_DRAMCommandReady_Internal),
							.OutData(				{AddrGen_DRAMCommand,			AddrGen_DRAMCommandAddress}),
							.OutSend(				AddrGen_DRAMCommandValid),
							.OutReady(				AddrGen_DRAMCommandReady));
	end else begin:ADDR_PASS
		assign	{AddrGen_DRAMCommand, AddrGen_DRAMCommandAddress} = {AddrGen_DRAMCommand_Internal, AddrGen_DRAMCommandAddress_Internal};
		assign	AddrGen_DRAMCommandValid =			AddrGen_DRAMCommandValid_Internal;
		assign	AddrGen_DRAMCommandReady_Internal =	AddrGen_DRAMCommandReady;
	end endgenerate

	//--------------------------------------------------------------------------
	//	StashTop
	//--------------------------------------------------------------------------

	StashTop	#(			.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAME(					ORAME),
							.ORAMC(					ORAMC),
							.BEDWidth(				BEDWidth),
							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableIV(				EnableIV),
							.EnableREW(             EnableREW))
				stash_top(	.Clock(					Clock),
							.Reset(					Reset),

							.StashAlmostFull(       StashAlmostFull),

							.Command(				Stash_Command),
							.CommandValid(			Stash_CommandValid),
							.CommandReady(			Stash_CommandReady),

							.BECommand(				Stash_BECommand),
							.PAddr(					Stash_PAddr),
							.CurrentLeaf(			Stash_CurrentLeaf),
							.RemappedLeaf(			Stash_RemappedLeaf),
							.MAC(					Stash_MAC),
							.AccessSkipsWriteback(	Stash_SkipWriteback),
							.AccessIsDummy(			Stash_AccessIsDummy),

							.FEReadData(			Stash_ReturnData),
							.FEReadMAC(				Stash_ReturnMAC),
							.FEReadComplete(		Stash_ReturnComplete),
							.FEReadDataValid(		Stash_ReturnDataValid),

							.FEWriteData(			Stash_StoreData),
							.FEWriteDataValid(		Stash_StoreDataValid),
							.FEWriteDataReady(		Stash_StoreDataReady),

							.DRAMReadData(			DRAMReadData),
							.DRAMReadDataValid(		DRAMReadDataValid),
							.DRAMReadDataReady(		DRAMReadDataReady),

							.DRAMWriteData(			Stash_DRAMWriteData),
							.DRAMWriteDataValid(	Stash_DRAMWriteDataValid),
							.DRAMWriteDataReady(	Stash_DRAMWriteDataReady),
							
							.JTAG_StashCore(		JTAG_StashCore),
							.JTAG_Stash(			JTAG_Stash),
							.JTAG_StashTop(			JTAG_StashTop));
							
	//--------------------------------------------------------------------------
	//	DRAM interface multiplexing
	//--------------------------------------------------------------------------

	// Note: this is redundant now that we got rid of DRAMInit

	assign	DRAMCommandAddress =					AddrGen_DRAMCommandAddress;
	assign	DRAMCommand =							AddrGen_DRAMCommand;
	assign	DRAMCommandValid =						AddrGen_DRAMCommandValid;
	assign	AddrGen_DRAMCommandReady =				DRAMCommandReady;

	assign	DRAMWriteData =							Stash_DRAMWriteData;
	assign	DRAMWriteDataValid =					Stash_DRAMWriteDataValid;

	assign	Stash_DRAMWriteDataReady =				DRAMWriteDataReady;

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
