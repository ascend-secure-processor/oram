
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMBackendInner
//	Desc:		Stash, DRAM address and top level state machine that interfaces 
//				with the FrontEnd
//==============================================================================
module PathORAMBackendInner(
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

	ROPAddr, ROLeaf, ROStart, REWRoundDummy, 
	
	DRAMInitComplete
	);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"

	`include "SecurityLocal.vh"	
	`include "StashLocal.vh"
	`include "StashTopLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	
	localparam				STWidth =				2,
							ST_Initialize =			2'd0,
							ST_Idle =				2'd1,
							ST_Append =				2'd2,
							ST_Access =				2'd3;
	
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
	
	input	[DDRDWidth-1:0]	DRAMReadData;
	input					DRAMReadDataValid;
	output					DRAMReadDataReady;
	
	output	[DDRDWidth-1:0]	DRAMWriteData;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;

	//--------------------------------------------------------------------------
	//	REW Interface
	//--------------------------------------------------------------------------
	
	output  [ORAMU-1:0]		ROPAddr;
	output  [ORAML-1:0]		ROLeaf;
	output					ROStart;
	output 					REWRoundDummy;
	
	//--------------------------------------------------------------------------
	//	Status Interface
	//--------------------------------------------------------------------------

	output					DRAMInitComplete;
								
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 

	// TODO clean this out
	
	// Control logic

	reg		[STWidth-1:0]	CS, NS;
	wire					CSInitialize, CSIdle, CSAppend, CSAccess;

	wire					SetDummy, ClearDummy;
	wire					AccessIsDummy, AccessSkipsWriteback;
	
	wire					AppendQueued, OperationComplete;
	
	wire					Stash_AppendCmdValid, Stash_RdRmvCmdValid, Stash_UpdateCmdValid;

	// REW
	wire					ROAccess, RWAccess;
	wire 					RW_R_DoneAlarm, RW_W_DoneAlarm, RO_R_DoneAlarm, RO_W_DoneAlarm;
	wire	[ORAML-1:0]		GentryLeaf;	
		
	// Front-end interfaces
	
	wire	[BECMDWidth-1:0] Command_Internal;
	wire	[ORAMU-1:0]		PAddr_Internal;
	wire	[ORAML-1:0]		CurrentLeaf_Internal, RemappedLeaf_Internal;
	wire					Command_InternalValid, Command_InternalReady;

	wire	[BlkBEDWidth-1:0] EvictBuf_Chunks;
	wire	[BlkBEDWidth-1:0] ReturnBuf_Space;
		
	wire	[BEDWidth-1:0]	Store_ShiftBufData;	
	wire					Store_ShiftBufValid, Store_ShiftBufReady;
	
	wire	[BEDWidth-1:0]	Load_ShiftBufData;
	wire					Load_ShiftBufValid, Load_ShiftBufReady;
		
	// Stash
	
	wire	[BEDWidth-1:0]	Stash_StoreData;						
	wire					Stash_StoreDataValid, Stash_StoreDataReady;
	
	wire	[BEDWidth-1:0]	Stash_ReturnData;
	wire					Stash_ReturnDataValid, Stash_ReturnDataReady;
	
	wire	[DDRDWidth-1:0]	Stash_DRAMWriteData;
	wire					Stash_DRAMWriteDataValid, Stash_DRAMWriteDataReady;
	
	(* mark_debug = "TRUE" *)	wire					StashAlmostFull;
	
	// ORAM initialization
	
	wire	[DDRAWidth-1:0]	DRAMInit_DRAMCommandAddress;
	wire	[DDRCWidth-1:0]	DRAMInit_DRAMCommand;
	wire					DRAMInit_DRAMCommandValid, DRAMInit_DRAMCommandReady;

	wire	[DDRDWidth-1:0]	DRAMInit_DRAMWriteData;
	wire					DRAMInit_DRAMWriteDataValid, DRAMInit_DRAMWriteDataReady;
	
	wire					DRAMInitializing;
	
	// Address generator
	
	wire	[DDRAWidth-1:0]	AddrGen_DRAMCommandAddress;
	wire	[DDRCWidth-1:0]	AddrGen_DRAMCommand;
	wire					AddrGen_DRAMCommandValid, AddrGen_DRAMCommandReady;
	
	wire	[DDRAWidth-1:0]	AddrGen_DRAMCommandAddress_Internal;
	wire	[DDRCWidth-1:0]	AddrGen_DRAMCommand_Internal;
	wire					AddrGen_DRAMCommandValid_Internal, AddrGen_DRAMCommandReady_Internal;									

	// TODO move this to the right place
	

	wire	[STCMDWidth-1:0] Stash_Command;
	wire					Stash_CommandValid, Stash_CommandReady;

	wire	[BECMDWidth-1:0] Stash_BECommand;
	wire	[ORAMU-1:0]		Stash_PAddr;
	wire	[ORAML-1:0]		Stash_CurrentLeaf;
	wire	[ORAML-1:0]		Stash_RemappedLeaf;
	wire					Stash_SkipWriteback, Stash_AccessIsDummy;	

	wire	[BECMDWidth-1:0] Control_Command;
	wire	[ORAMU-1:0]		Control_PAddr;
	wire	[ORAML-1:0]		Control_CurrentLeaf; 
	wire	[ORAML-1:0]		Control_RemappedLeaf; 
	wire					Control_CommandValid, Control_CommandReady;	
	
	wire	[ORAML-1:0]		AddrGen_Leaf;
	wire					AddrGen_InReady, AddrGen_InValid;	
	wire					AddrGen_PathRead, AddrGen_HeaderOnly;
		
	//--------------------------------------------------------------------------
	//	Initial state
	//--------------------------------------------------------------------------	
	
	`ifndef ASIC
		initial begin
			CS = ST_Initialize;
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------

	`ifdef SIMULATION
		reg [STWidth-1:0] CS_Delayed;
		integer WriteCount_Sim = 0;
		reg	StartedFirstAccess = 1'b0;
		
		initial begin
			if (BEDWidth > DDRDWidth) begin
				$display("[%m @ %t] ERROR: BEDWidth should never be > DDRDWidth", $time);
				$stop;
			end
		end
		
		always @(posedge Clock) begin
			CS_Delayed <= CS;
		
			if (CSAccess) StartedFirstAccess <= 1'b1;
				
			if (~CSInitialize & DRAMWriteDataValid & DRAMWriteDataReady)
				WriteCount_Sim = WriteCount_Sim + 1;
				
			if (StartedFirstAccess & CSIdle & (WriteCount_Sim % PathSize_DRBursts)) begin
				$display("[%m @ %t] We wrote back %d blocks (not aligned to path length ...)", $time, WriteCount_Sim);
				$stop;
			end
		
	`ifdef SIMULATION_VERBOSE_BE
			if (CS_Delayed != CS) begin
				if (CSAccess)
					$display("[%m @ %t] Backend: start access, dummy = %b, command = %x, leaf = %x", $time, AccessIsDummy, Command_Internal, AddrGen_Leaf);
				if (CSAppend)
					$display("[%m @ %t] Backend: start append", $time);
			end
		
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

	FIFORegister #(			.Width(					BECMDWidth + ORAMU + ORAML*2))
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

	assign	CSInitialize =							CS == ST_Initialize;
	assign	CSIdle =								CS == ST_Idle;
	assign	CSAppend =								CS == ST_Append;
	assign	CSAccess =								CS == ST_Access;
	
	// SECURITY: We don't allow _any_ access to start until DummyLeaf_Valid; we 
	// don't want to start real accesses _earlier_ than dummy accesses
	assign	Stash_AppendCmdValid =					CSIdle & Command_InternalValid & (Command_Internal == BECMD_Append) & 										(EvictBuf_Chunks >= BlkSize_BEDChunks);
	assign	Stash_RdRmvCmdValid = 					CSIdle & Command_InternalValid & ((Command_Internal == BECMD_Read) | (Command_Internal == BECMD_ReadRmv)) & (ReturnBuf_Space >= BlkSize_BEDChunks);
	assign	Stash_UpdateCmdValid =					CSIdle & Command_InternalValid & ( Command_Internal == BECMD_Update) & 										(EvictBuf_Chunks >= BlkSize_BEDChunks);
	
	assign	Control_Command =						Command_Internal;
	assign	Control_PAddr =							PAddr_Internal;
	assign	Control_CurrentLeaf =					CurrentLeaf_Internal;
	assign	Control_RemappedLeaf =					RemappedLeaf_Internal;
	assign	Control_CommandValid =					Stash_AppendCmdValid | Stash_RdRmvCmdValid | Stash_UpdateCmdValid;
	assign	Command_InternalReady =					Command_InternalReady & (CSAppend | CSAccess);
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Initialize;
		else CS <= 									NS;
	end
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Initialize : 
				if (DRAMInitComplete) 
					NS =						 	ST_Idle;
			ST_Idle :
				if (		Control_CommandReady & Stash_AppendCmdValid) // do appends first ("greedily") because they are cheap
					NS =							ST_Append;
				else if (	Control_CommandReady & Stash_RdRmvCmdValid)
					NS =							ST_Access;
				else if (	Control_CommandReady & Stash_UpdateCmdValid)
					NS = 							ST_Access;
			ST_Append :
				if (Control_CommandReady) // When last chunk of data is appended
					NS = 							ST_Idle;
			ST_Access :   
				if (Control_CommandReady) // At end of access
					NS =							ST_Idle;
		endcase
	end

	//--------------------------------------------------------------------------
	//	Front-end stores
	//--------------------------------------------------------------------------	

	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				BEDWidth))
				st_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				StoreData),
							.InValid(				StoreValid),
							.InAccept(				StoreReady),
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
	
	// SECURITY: Don't perform a read/rm until the front-end can take a whole block
	// NOTE: this should come before the shifter because the Stash ReturnData path 
	// doesn't have backpressure
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
							.OutData(				LoadData),
							.OutValid(				LoadValid),
							.OutReady(				LoadReady));
							
	//--------------------------------------------------------------------------
	//	Stash & AddrGen Control
	//--------------------------------------------------------------------------

	BackendInnerControl #(	.ORAMB(					ORAMB),
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
							.Reset(					Reset | DRAMInitializing),

							.Command(				Control_Command), 
							.PAddr(					Control_PAddr), 
							.CurrentLeaf(			Control_CurrentLeaf), 
							.RemappedLeaf(			Control_RemappedLeaf), 
							.CommandValid(			Control_CommandValid), 
							.CommandReady(			Control_CommandReady),

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
							.ROStart(				ROStart), 
							.REWRoundDummy(			REWRoundDummy));
	
	//--------------------------------------------------------------------------
	//	AddrGen
	//--------------------------------------------------------------------------	
	
    AddrGen #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
				addr_gen(	.Clock(					Clock),
							.Reset(					Reset | DRAMInitializing),
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
	//	DRAM Initialization
	//--------------------------------------------------------------------------
				
	// Basic path ORAM needs to zero/encrypt valid bits in a bucket.   
	// REW ORAM uses gentry bucket version #s to determine whether a bucket is 
	// valid; thus no initialization is necessary.
	
	generate if (EnableREW) begin:AUTO_INIT
		assign	DRAMInitComplete =					1'b1;
		assign	DRAMInit_DRAMCommandAddress =		{DDRAWidth{1'bx}};
		assign	DRAMInit_DRAMCommand =				DDR3CMD_Write;
		assign	DRAMInit_DRAMCommandValid =			1'b0;
		
		assign	DRAMInit_DRAMWriteData =			{DDRDWidth{1'bx}};
		assign	DRAMInit_DRAMWriteDataValid =		1'b0;
	end else begin:DRAM_INIT
		DRAMInitializer #(	.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
				dram_init(	.Clock(					Clock),
							.Reset(					Reset),
							.DRAMCommandAddress(	DRAMInit_DRAMCommandAddress),
							.DRAMCommand(			DRAMInit_DRAMCommand),
							.DRAMCommandValid(		DRAMInit_DRAMCommandValid),
							.DRAMCommandReady(		DRAMInit_DRAMCommandReady),
							.DRAMWriteData(			DRAMInit_DRAMWriteData),
							.DRAMWriteDataValid(	DRAMInit_DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMInit_DRAMWriteDataReady),
							.Done(					DRAMInitComplete));
	end endgenerate
	
	assign	DRAMInitializing =						~DRAMInitComplete;								
	
	//--------------------------------------------------------------------------
	//	StashTop
	//--------------------------------------------------------------------------
	
	StashTop	#(			.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.Overclock(				Overclock),
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
							.AccessSkipsWriteback(	Stash_SkipWriteback),
							.AccessIsDummy(			Stash_AccessIsDummy),
							
							.FEReadData(			Stash_ReturnData),
							.FEReadDataValid(		Stash_ReturnDataValid),
							
							.FEWriteData(			Stash_StoreData),
							.FEWriteDataValid(		Stash_StoreDataValid),
							.FEWriteDataReady(		Stash_StoreDataReady),
							
							.DRAMReadData(			DRAMReadData),
							.DRAMReadDataValid(		DRAMReadDataValid),
							.DRAMReadDataReady(		DRAMReadDataReady),
							
							.DRAMWriteData(			Stash_DRAMWriteData),
							.DRAMWriteDataValid(	Stash_DRAMWriteDataValid),
							.DRAMWriteDataReady(	Stash_DRAMWriteDataReady));
							
	//--------------------------------------------------------------------------
	//	DRAM interface multiplexing
	//--------------------------------------------------------------------------

	assign	DRAMCommandAddress =					(DRAMInitializing) ? 	DRAMInit_DRAMCommandAddress : 	AddrGen_DRAMCommandAddress;
	assign	DRAMCommand =							(DRAMInitializing) ? 	DRAMInit_DRAMCommand : 			AddrGen_DRAMCommand;
	assign	DRAMCommandValid =						(DRAMInitializing) ? 	DRAMInit_DRAMCommandValid : 	AddrGen_DRAMCommandValid; 
	assign	AddrGen_DRAMCommandReady =				DRAMCommandReady &	   ~DRAMInitializing;
	assign	DRAMInit_DRAMCommandReady =				DRAMCommandReady & 		DRAMInitializing;
	
	assign	DRAMWriteData =							(DRAMInitializing) ? 	DRAMInit_DRAMWriteData : 		Stash_DRAMWriteData;
	assign	DRAMWriteDataValid =					(DRAMInitializing) ? 	DRAMInit_DRAMWriteDataValid : 	Stash_DRAMWriteDataValid;
	
	assign	DRAMInit_DRAMWriteDataReady =			DRAMWriteDataReady &	DRAMInitializing;
	assign	Stash_DRAMWriteDataReady =				DRAMWriteDataReady &	~DRAMInitializing;
	
	//--------------------------------------------------------------------------	
endmodule
//------------------------------------------------------------------------------
