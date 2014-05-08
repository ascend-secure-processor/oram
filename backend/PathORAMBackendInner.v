
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

	// Control logic

	reg		[STWidth-1:0]	CS, NS;
	wire					CSInitialize, CSIdle, CSAppend, CSAccess;

	wire					Stash_AppendCmdValid, Stash_RdRmvCmdValid, Stash_UpdateCmdValid;
		
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
	wire					Control_CommandReq, Control_CommandDone;	
	
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
				
			if (StartedFirstAccess & DRAMReadDataValid & DRAMReadDataReady & (WriteCount_Sim % PathSize_DRBursts)) begin
				// Whenever we are doing reads, we should have written the right amount back
				$display("[%m @ %t] ERROR: We wrote back %d blocks (not aligned to path length ...)", $time, WriteCount_Sim);
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
	assign	Control_CommandReq =					CSAppend | CSAccess;
	
	assign	Command_InternalReady =					Control_CommandDone & (CSAppend | CSAccess);
	
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
				if (Stash_AppendCmdValid) // do appends first ("greedily") because they are cheap
					NS =							ST_Append;
				else if (Stash_RdRmvCmdValid)
					NS =							ST_Access;
				else if (Stash_UpdateCmdValid)
					NS = 							ST_Access;
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

//==============================================================================
//	Module:		PathORAMBackendInnerControl
//	Desc:		Helper module for BackendInner.
//				Controls the stash and addr gen & manages background evictions / 
//				strange writeback patterns / optimizations like delayed RW 
//				writeback.
//
//				The original reason this module was created was to make sending 
//				_different_ sequences of commands to stash/addr gen easier.
//==============================================================================
module BackendInnerControl(
	Clock, Reset,

	Command, PAddr, CurrentLeaf, RemappedLeaf, 
	CommandRequest, CommandDone,

	AddrGenRead, AddrGenHeader, AddrGenLeaf,	
	AddrGenInValid, AddrGenInReady,
	
	StashCommand,
	StashCommandValid, StashCommandReady,

	StashBECommand,
	StashPAddr,
	StashCurrentLeaf,
	StashRemappedLeaf,
	StashSkipWriteback,
	StashAccessIsDummy,
	
	DataReadTransfer,
	DataWriteTransfer,
	AddrTransfer,
	
	StashAlmostFull,
		
	ROPAddr, ROLeaf, ROStart, REWRoundDummy
	);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"

	`include "SecurityLocal.vh"	
	`include "StashTopLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"

	localparam				STWidth =				4,
							ST_Idle =				4'd0,
							ST_Append =				4'd1,
							ST_AppendWait =			4'd2,
							ST_AddrGenRead =		4'd3,
							ST_StashRead =			4'd4,
							ST_Read =				4'd5,
							ST_AddrGenWrite =		4'd6,
							ST_StashWrite =			4'd7,
							ST_Write =				4'd8,
							ST_AddrGenWrite_DWB =	4'd9;	
	
	localparam				PRNGLWidth =			1 << `log2(ORAML);
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;

	//--------------------------------------------------------------------------
	//	Input Interface
	//--------------------------------------------------------------------------
	
	input	[BECMDWidth-1:0] Command;
	input	[ORAMU-1:0]		PAddr;
	input	[ORAML-1:0]		CurrentLeaf; 
	input	[ORAML-1:0]		RemappedLeaf; 
	input					CommandRequest;
	output					CommandDone;
	
	//--------------------------------------------------------------------------
	//	AddrGen Interface
	//--------------------------------------------------------------------------

	output	[ORAML-1:0]		AddrGenLeaf;
	output					AddrGenRead;
	output					AddrGenHeader;	
	output					AddrGenInValid;
	input					AddrGenInReady;

	//--------------------------------------------------------------------------
	//	Stash Interface
	//--------------------------------------------------------------------------

	output	[STCMDWidth-1:0] StashCommand;
	output					StashCommandValid; 
	input					StashCommandReady;

	output	[BECMDWidth-1:0] StashBECommand;
	output	[ORAMU-1:0]		StashPAddr;
	output	[ORAML-1:0]		StashCurrentLeaf;
	output	[ORAML-1:0]		StashRemappedLeaf;
	output					StashSkipWriteback;
	output					StashAccessIsDummy;
	
	//--------------------------------------------------------------------------
	//	Status Interface
	//--------------------------------------------------------------------------
	
	input					DataReadTransfer, DataWriteTransfer, AddrTransfer;	
	
	input					StashAlmostFull;

	output reg [ORAMU-1:0]	ROPAddr;
	output reg [ORAML-1:0]	ROLeaf;
	output					ROStart; // TODO making this a pulse would be a bit cleaner
	output reg				REWRoundDummy;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 

	reg		[STWidth-1:0]	CS, NS;

	wire					RWAccess, ROAccess, PathRead, PathWriteback;
	wire					Addr_ROAccess, Addr_RWAccess, Addr_PathRead, Addr_PathWriteback;

	wire					RW_R_DoneAlarm, RW_W_DoneAlarm, RO_R_DoneAlarm;	
	wire 					Addr_RW_W_DoneAlarm, Addr_RO_W_DoneAlarm;
	
	wire					CSIdle, CSAppend, CSAppendWait, CSAddrGenRead, CSAddrGenWrite, CSStashRead, CSStashWrite;

	wire					AddrRWDone, DataRWDone, OperationComplete;
	wire					Stash_AppendCmdValid, Stash_DummyCmdValid, Stash_OtherCmdValid;
	
	wire					SetDummy, ClearDummy, AccessIsDummy_Reg, AccessIsDummy;
		
	wire	[ORAML-1:0]		GentryLeaf;
	wire	[ORAML-1:0]		DummyLeaf;
	wire					DummyLeaf_Valid;
	wire	[PRNGLWidth-1:0] DummyLeaf_Wide;	
	
	//--------------------------------------------------------------------------
	//	Initial state
	//--------------------------------------------------------------------------	
	
	`ifndef ASIC
		initial begin
			CS = ST_Idle;
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------

	`ifdef SIMULATION
	
	`endif
	
	//--------------------------------------------------------------------------
	//	Control logic
	//--------------------------------------------------------------------------	

	assign	CSIdle =								CS == ST_Idle;
	assign	CSAppend =								CS == ST_Append;
	assign	CSAppendWait =							CS == ST_AppendWait;
	assign	CSAddrGenRead =							CS == ST_AddrGenRead;
	assign	CSAddrGenWrite =						CS == ST_AddrGenWrite;
	assign	CSStashRead =							CS == ST_StashRead;
	assign	CSStashWrite =							CS == ST_StashWrite;
	assign	CSWrite =								CS == ST_Write;
	
	Register1b arwd(  		.Clock(     			Clock), 
							.Reset(     			Reset | OperationComplete), 
							.Set(       			Addr_RW_W_DoneAlarm), 
							.Out(       			AddrRWDone));
	Register1b drwd(  		.Clock(     			Clock), 
							.Reset(     			Reset | OperationComplete), 
							.Set(       			RW_W_DoneAlarm), 
							.Out(       			DataRWDone));
	
	assign	OperationComplete = 					Addr_RO_W_DoneAlarm | ( (DelayedWB == 1 | AddrRWDone) & DataRWDone);
	assign	CommandDone =							(CSAppendWait & StashCommandReady) | (OperationComplete & ~AccessIsDummy);
	
	assign	Stash_AppendCmdValid =					DummyLeaf_Valid & CommandRequest & (Command == BECMD_Append);
	assign	Stash_DummyCmdValid =					DummyLeaf_Valid & AccessIsDummy;
	assign	Stash_OtherCmdValid =					DummyLeaf_Valid & CommandRequest & ~Stash_AppendCmdValid & ~Stash_DummyCmdValid;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Idle;
		else CS <= 									NS;
	end
	
	// Implement all the hacky schemes in this FSM
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Idle :
				if (		DelayedWB & Addr_RWAccess & Addr_PathWriteback)
					NS =							ST_AddrGenWrite;
				else if (	StashCommandReady & Stash_DummyCmdValid) // stash capacity check gets higher priority than append
					NS =							ST_AddrGenRead;
				else if (	StashCommandReady & Stash_AppendCmdValid) // do appends first ("greedily") because they are cheap
					NS =							ST_Append;
				else if (	StashCommandReady & Stash_OtherCmdValid) // otherwise do a normal access
					NS =							ST_AddrGenRead;
			//
			// Append states
			//
			ST_Append :
				if (StashCommandReady)
					NS = 							ST_AppendWait;
			ST_AppendWait : 
				if (StashCommandReady)
					NS = 							ST_Idle;
			//
			// Main access states
			//
			ST_AddrGenRead : 
				if (AddrGenInReady)
					NS =							ST_StashRead;
			ST_StashRead :
				if (StashCommandReady)
					NS =							ST_Read;
			ST_Read : 
				if (		(RW_R_DoneAlarm | RO_R_DoneAlarm) & DelayedWB & RWAccess)
					NS =							ST_StashWrite;
				else if (	 RW_R_DoneAlarm | RO_R_DoneAlarm)
					NS =							ST_AddrGenWrite;
			ST_AddrGenWrite :
				if (		AddrGenInReady & DelayedWB & Addr_RWAccess & Addr_PathWriteback)
					NS =							ST_AddrGenWrite_DWB;
				else if (	AddrGenInReady)
					NS =							ST_StashWrite;
			ST_StashWrite :
				if (StashCommandReady)
					NS =							ST_Write;
			ST_Write : 
				if (OperationComplete)
					NS =							ST_Idle;
			//
			// Optimization states
			//
			ST_AddrGenWrite_DWB :
				if (~Addr_PathWriteback)
					NS =							ST_Idle;
		endcase
	end	
	
	//--------------------------------------------------------------------------
	//	Basic/REW split control logic
	//--------------------------------------------------------------------------

	// This module is not general enough to accommodate basic control flow as well	
	REWStatCtr	#(			.USE_REW(				EnableREW),
							.ORAME(					ORAME),
							.Overlap(				0),
							.RW_R_Chunk(			PathSize_DRBursts),
							.RW_W_Chunk(			PathSize_DRBursts),
							.RO_R_Chunk(			BktSize_DRBursts),
							.RO_W_Chunk(			0))

		rew_data_stat(		.Clock(					Clock),
							.Reset(					Reset),
							
							.RW_R_Transfer(			DataReadTransfer),
							.RW_W_Transfer(			DataWriteTransfer),
							.RO_R_Transfer(			DataReadTransfer),
						
							.ROAccess(				ROAccess),
							.RWAccess(				RWAccess),
							.Read(					PathRead), // debugging
							.Writeback(				PathWriteback), // debugging

							.RW_R_DoneAlarm(		RW_R_DoneAlarm),
							.RW_W_DoneAlarm(		RW_W_DoneAlarm),
							.RO_R_DoneAlarm(		RO_R_DoneAlarm),
							.RO_W_DoneAlarm(		));

	generate if (EnableREW) begin:REW_CONTROL
		wire [ORAMU-1:0]	ROPAddr_Pre;
		wire [ORAML-1:0]	ROLeaf_Pre;
		wire				REWRoundDummy_Pre;	
		
		Counter	#(			.Width(					ORAML))
			gentry_leaf(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				Addr_RW_W_DoneAlarm),
							.In(					{ORAML{1'bx}}),
							.Count(					GentryLeaf));	
									
		assign	ClearDummy =						CSIdle & ~StashAlmostFull & ~RWAccess;
		assign	SetDummy =							CSIdle & (StashAlmostFull | RWAccess);
		
		assign	DummyLeaf =							(Addr_RWAccess) ? GentryLeaf : DummyLeaf_Wide[ORAML-1:0];

		assign	ROStart = 							CSAddrGenRead & ROAccess;	
		
		assign	ROPAddr_Pre =						PAddr;
		assign	ROLeaf_Pre =						(REWRoundDummy_Pre) ? DummyLeaf : CurrentLeaf;
		assign	REWRoundDummy_Pre =					AccessIsDummy;
		if (Overclock) begin
			always @(posedge Clock) begin
				ROPAddr <=							ROPAddr_Pre;
				ROLeaf <=							ROLeaf_Pre;
				REWRoundDummy <=					REWRoundDummy_Pre;
			end
		end else begin
			always @( * ) begin
				ROPAddr =							ROPAddr_Pre;
				ROLeaf =							ROLeaf_Pre;
				REWRoundDummy =						REWRoundDummy_Pre;
			end		
		end
	end else begin:BASIC_CONTROL
		assign	ClearDummy =						CSIdle & ~StashAlmostFull;
		assign	SetDummy =							CSIdle & StashAlmostFull;
		
		assign	DummyLeaf =							DummyLeaf_Wide[ORAML-1:0];
		
		assign	ROStart =							1'b0;
		
		always @( * ) begin
			ROPAddr =								{ORAMU{1'bx}};
			ROLeaf =								{ORAML{1'bx}};
			REWRoundDummy =							1'b0;
		end
	end endgenerate

	Register	#(			.Width(					1))
				dummy_reg(	.Clock(					Clock),
							.Reset(					Reset | ClearDummy),
							.Set(					SetDummy),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					AccessIsDummy_Reg));
	assign	AccessIsDummy =							AccessIsDummy_Reg & ~ClearDummy;
	
	PRNG 		#(			.RandWidth(				PRNGLWidth),	
							.SecretKey(				128'hd8_40_e1_a8_dc_ca_e7_ec_d9_1f_61_48_7a_f2_cb_00)) // TODO make dynamic
				leaf_gen(	.Clock(					Clock), 
							.Reset(					Reset),
							.RandOutReady(			OperationComplete),
							.RandOutValid(			DummyLeaf_Valid),
							.RandOut(				DummyLeaf_Wide));
	
	//--------------------------------------------------------------------------
	//	Stash Interface
	//--------------------------------------------------------------------------
	
	assign	StashCommand =							(CSStashRead & (Stash_DummyCmdValid | Stash_OtherCmdValid)) ? 	STCMD_StartRead : // Order is important; prioritize dummy reads
													(CSAppend & Stash_AppendCmdValid) ?								STCMD_Append :
																													STCMD_StartWrite;
	assign	StashCommandValid =						CSAppend | CSStashRead | CSStashWrite;
	
	assign	StashBECommand =						Command;
	assign	StashPAddr =							PAddr;
	assign	StashCurrentLeaf =						(AccessIsDummy) ? DummyLeaf : CurrentLeaf;
	assign	StashRemappedLeaf =						RemappedLeaf;
	assign	StashSkipWriteback =					ROAccess & EnableREW;
	assign	StashAccessIsDummy =					AccessIsDummy;	
	
	//--------------------------------------------------------------------------
	//	AddrGen Interface
	//--------------------------------------------------------------------------

	// This module is not general enough to accommodate basic control flow as well	
	REWStatCtr	#(			.USE_REW(				EnableREW),
							.ORAME(					ORAME),
							.Overlap(				0),
							.DelayedWB(				DelayedWB),
							.RW_R_Chunk(			PathSize_DRBursts),
							.RW_W_Chunk(			PathSize_DRBursts),
							.RO_R_Chunk(			PathSize_DRBursts),
							.RO_W_Chunk(			(ORAML+1) * BktHSize_DRBursts))	
							
		rew_addr_stat(		.Clock(					Clock),
							.Reset(					Reset),
							
							.RW_R_Transfer(			AddrTransfer),
							.RW_W_Transfer(			AddrTransfer),
							.RO_R_Transfer(			AddrTransfer),
							.RO_W_Transfer(			AddrTransfer),
						
							.ROAccess(				Addr_ROAccess),
							.RWAccess(				Addr_RWAccess),
							.Read(					Addr_PathRead),
							.Writeback(				Addr_PathWriteback),
							
							.RW_W_DoneAlarm(		Addr_RW_W_DoneAlarm),
							.RO_W_DoneAlarm(		Addr_RO_W_DoneAlarm));	

	assign	AddrGenLeaf =							StashCurrentLeaf;
	assign	AddrGenRead =							Addr_PathRead;
	assign	AddrGenHeader =							Addr_ROAccess & Addr_PathWriteback;
	assign	AddrGenInValid = 						CSAddrGenRead | CSAddrGenWrite;
	
	//--------------------------------------------------------------------------	
endmodule
//------------------------------------------------------------------------------

