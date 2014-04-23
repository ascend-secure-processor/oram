
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

	ROPAddr, ROLeaf, REWRoundDummy, 
	
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
	
	localparam				SpaceRemaining =		BktHSize_RndBits - BktHSize_RawBits;
	
	localparam				STWidth =				4,
							ST_Initialize =			4'd0,
							ST_Idle =				4'd1,
							ST_Append =				4'd2,
							ST_StartRead =			4'd3,
							ST_StartStash =			4'd4,
							ST_PathRead =			4'd5,
							ST_StartWriteback =		4'd6,
							ST_WBStash =			4'd7,
							ST_PathWriteback =		4'd8;
								
	localparam				PRNGLWidth =			`divceil(ORAML, 8) * 8;
	
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
	
	output reg [ORAMU-1:0]	ROPAddr;
	output reg [ORAML-1:0]	ROLeaf;
	output reg				REWRoundDummy;
	
	//--------------------------------------------------------------------------
	//	Status Interface
	//--------------------------------------------------------------------------

	output					DRAMInitComplete;
								
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 

	// Control logic
	
	wire	[STCMDWidth-1:0] Stash_Command; 
	wire					Stash_CommandValid, Stash_CommandReady;
	
	reg		[STWidth-1:0]	CS, NS;
	wire					CSInitialize, CSIdle, CSAppend, CSStartRead, CSPathRead, 
							CSPathWriteback, CSStartStash, CSWBStash, CSStartWriteback;

	wire					SetDummy, ClearDummy;
	wire					AccessIsDummy, AccessSkipsWriteback;
	
	wire					PathReadComplete, ROPathReadComplete, RWPathReadComplete;
	wire					PathWritebackComplete;
	wire					AppendQueued, OperationComplete_Pre, OperationComplete;
	
	wire					Stash_AppendCmdValid, Stash_DummyCmdValid, Stash_RdRmvCmdValid, Stash_UpdateCmdValid, Stash_WBCmdValid;
	
	wire					ROAccess, RWAccess, StartRW, REWRoundComplete;
	wire	[ORAML-1:0]		GentryLeaf_Pre;	
	
	wire	[ORAML-1:0]		DummyLeaf;
	wire					DummyLeaf_Valid;
	wire	[PRNGLWidth-1:0] DummyLeaf_Wide;
	
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
	
	// Writeback pipeline
	
	wire					PathWritebackComplete_Commands_RW, PathWritebackComplete_Commands_RO, PathWritebackComplete_Data_Pre;
	wire					PathWritebackComplete_Commands, PathWritebackComplete_Data;	
	
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

	wire 					AddrGen_HeaderWriteback;	
	wire					AddrGen_Reading;
	
	wire	[ORAML-1:0]		AddrGen_Leaf;
	wire					AddrGen_InReady, AddrGen_InValid;
	
	wire	[DDRAWidth-1:0]	AddrGen_DRAMCommandAddress_Internal;
	wire	[DDRCWidth-1:0]	AddrGen_DRAMCommand_Internal;
	wire					AddrGen_DRAMCommandValid_Internal, AddrGen_DRAMCommandReady_Internal;									

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
		
			if (CSStartRead) StartedFirstAccess <= 1'b1;
				
			if (~CSInitialize & DRAMWriteDataValid & DRAMWriteDataReady)
				WriteCount_Sim = WriteCount_Sim + 1;
				
			if (StartedFirstAccess & CSIdle & (WriteCount_Sim % PathSize_DRBursts)) begin
				$display("[%m @ %t] We wrote back %d blocks (not aligned to path length ...)", $time, WriteCount_Sim);
				$stop;
			end
			
			if (Command_InternalValid & (Command_Internal == BECMD_Update)) begin
				$display("[%m @ %t] Found update", $time);
				$stop;
			end
		
	`ifdef SIMULATION_VERBOSE_BE
			if (CS_Delayed != CS) begin
				if (CSStartRead)
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
	//	Control logic
	//--------------------------------------------------------------------------	

	assign	CSInitialize =							CS == ST_Initialize;
	assign	CSIdle =								CS == ST_Idle;
	assign	CSAppend =								CS == ST_Append;
	assign	CSStartRead =							CS == ST_StartRead;
	assign	CSStartStash =							CS == ST_StartStash;
	assign	CSStartWriteback =						CS == ST_StartWriteback;
	assign	CSPathRead =							CS == ST_PathRead;
	assign	CSWBStash =								CS == ST_WBStash;
	assign	CSPathWriteback =						CS == ST_PathWriteback;
	
	assign	OperationComplete_Pre =					CSPathWriteback & PathWritebackComplete & AddrGen_InReady & Stash_CommandReady;
		
	generate if (Overclock) begin
		Register #(			.Width(					1),
							.Initial(				0))
				oc_dly(		.Clock(					Clock),
							.Reset(					OperationComplete),
							.Set(					1'b0),
							.Enable(				1'b1),
							.In(					OperationComplete_Pre),
							.Out(					OperationComplete));		
	end else begin
		assign	OperationComplete =					OperationComplete_Pre;
	end endgenerate
	
	assign	AppendQueued =							Stash_AppendCmdValid & Stash_CommandReady & ~Stash_DummyCmdValid;
	assign	Command_InternalReady =					AppendQueued | (OperationComplete & 		~AccessIsDummy);

	assign	AddrGen_InValid =						CSStartRead | CSStartWriteback;

	// SECURITY: We don't allow _any_ access to start until DummyLeaf_Valid; we 
	// don't want to start real accesses _earlier_ than dummy accesses
	assign	Stash_AppendCmdValid =					CSIdle & DummyLeaf_Valid & Command_InternalValid & (Command_Internal == BECMD_Append) & 										(EvictBuf_Chunks >= BlkSize_BEDChunks);
	assign	Stash_DummyCmdValid =					CSIdle & DummyLeaf_Valid & SetDummy;								
	assign	Stash_RdRmvCmdValid = 					CSIdle & DummyLeaf_Valid & Command_InternalValid & ((Command_Internal == BECMD_Read) | (Command_Internal == BECMD_ReadRmv)) & 	(ReturnBuf_Space >= BlkSize_BEDChunks);
	assign	Stash_UpdateCmdValid =					CSIdle & DummyLeaf_Valid & Command_InternalValid & ( Command_Internal == BECMD_Update) & 										(EvictBuf_Chunks >= BlkSize_BEDChunks);
	assign	Stash_WBCmdValid =						CSWBStash;
	
	assign	Stash_Command =							(Stash_DummyCmdValid | Stash_RdRmvCmdValid | Stash_UpdateCmdValid) ? 	STCMD_StartRead : // Order is important; prioritize dummy reads
													(Stash_AppendCmdValid) ?												STCMD_Append :
																															STCMD_StartWrite;

	assign	AccessSkipsWriteback =					CSIdle & ROAccess & EnableREW;
	
	assign	Stash_CommandValid =					Stash_AppendCmdValid | Stash_DummyCmdValid | Stash_RdRmvCmdValid | Stash_UpdateCmdValid | Stash_WBCmdValid;
	
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
				if (		Stash_CommandReady & Stash_DummyCmdValid) // stash capacity check gets higher priority than append
					NS =						ST_StartRead;
				else if (	Stash_CommandReady & Stash_AppendCmdValid) // do appends first ("greedily") because they are cheap
					NS =						ST_Append;
				else if (	Stash_CommandReady & Stash_RdRmvCmdValid)
					NS =						ST_StartRead;
				else if (	Stash_CommandReady & Stash_UpdateCmdValid)
					NS = 						ST_StartRead;
			ST_Append :
				if (Stash_CommandReady)
					NS = 							ST_Idle;
			ST_StartRead : 
				if (AddrGen_InReady)
					NS =							ST_StartStash;
			ST_StartStash :
				if (Stash_CommandReady)
					NS =							ST_PathRead;
			ST_PathRead : 							
				if (PathReadComplete)
					NS =							ST_StartWriteback;
			ST_StartWriteback :
				if (AddrGen_InReady)
					NS =							ST_WBStash;
			ST_WBStash :
				if (Stash_CommandReady)
					NS =							ST_PathWriteback;
			ST_PathWriteback : 
				if (OperationComplete)
					NS =							ST_Idle;
		endcase
	end
	
	//--------------------------------------------------------------------------
	//	Basic/REW split control logic
	//--------------------------------------------------------------------------
	
	generate if (EnableREW) begin:REW_CONTROL
		wire [ORAMU-1:0]	ROPAddr_Pre;
		wire [ORAML-1:0]	ROLeaf_Pre;
		wire				REWRoundDummy_Pre;	
		
		Counter	#(			.Width(					ORAML))
				gentry_leaf(.Clock(					Clock),
							.Reset(					Reset | (REWRoundComplete & &GentryLeaf_Pre)),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				REWRoundComplete),
							.In(					{ORAML{1'bx}}),
							.Count(					GentryLeaf_Pre));
		
		CountAlarm #(		.Threshold(				ORAME))
				rew_rnd_ctr(.Clock(					Clock | REWRoundComplete), 
							.Reset(					Reset), 
							.Enable(				OperationComplete),
							.Done(					StartRW));
		Register #(			.Width(					1))
				rew_rw(		.Clock(					Clock),
							.Reset(					Reset | REWRoundComplete),
							.Set(					StartRW),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					RWAccess));
		assign	REWRoundComplete =					RWAccess & OperationComplete;
							
		assign	ClearDummy =						CSIdle & ~StashAlmostFull & ~RWAccess;
		assign	SetDummy =							CSIdle & (StashAlmostFull | RWAccess);
		
		assign	DummyLeaf =							(RWAccess) ? GentryLeaf_Pre : DummyLeaf_Wide[ORAML-1:0];

		assign	AddrGen_HeaderWriteback =			~RWAccess & CSStartWriteback;
		assign	ROAccess =							~RWAccess;
		
		assign	ROPAddr_Pre =						PAddr_Internal;
		assign	ROLeaf_Pre =						(REWRoundDummy) ? DummyLeaf : CurrentLeaf_Internal;
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
		
		assign	AddrGen_HeaderWriteback =			1'b0;
		assign	ROAccess =							1'b0;
		
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
							.Out(					AccessIsDummy));
	
	PRNG 		#(			.RandWidth(				PRNGLWidth),	
							.SecretKey(				128'hd8_40_e1_a8_dc_ca_e7_ec_d9_1f_61_48_7a_f2_cb_00)) // TODO make dynamic
				leaf_gen(	.Clock(					Clock), 
							.Reset(					Reset),
							.RandOutReady(			OperationComplete),
							.RandOutValid(			DummyLeaf_Valid),
							.RandOut(				DummyLeaf_Wide));
	
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
	//	Address generation & ORAM initialization
	//--------------------------------------------------------------------------

	assign	AddrGen_Reading = 						CSStartRead;
	assign	AddrGen_Leaf =							(SetDummy | (AccessIsDummy & ~ClearDummy)) ? DummyLeaf : CurrentLeaf_Internal;
	
    AddrGen #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
				addr_gen(	.Clock(					Clock),
							.Reset(					Reset | DRAMInitializing),
							.Start(					AddrGen_InValid), 
							.Ready(					AddrGen_InReady),
							.RWIn(					AddrGen_Reading),
							.BHIn(					AddrGen_HeaderWriteback),
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
							
	// Basic path ORAM needs to zero/encrypt valid bits in a bucket.  REW ORAM 
	// uses gentry bucket version #s to determine whether a bucket is valid.
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
			dram_init(		.Clock(					Clock),
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
	//	Read counters
	//--------------------------------------------------------------------------
		
	CountAlarm #(			.Threshold(				PathSize_DRBursts),
							.IThreshold(			BktSize_DRBursts))
			in_path_cmp(	.Clock(					Clock), 
							.Reset(					Reset | CSIdle), 
							.Enable(				DRAMReadDataValid & DRAMReadDataReady),
							.Intermediate(			ROPathReadComplete),
							.Done(					RWPathReadComplete));
	
	assign	PathReadComplete = 						(EnableREW & ROAccess) ? ROPathReadComplete : RWPathReadComplete;	
	
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
							
							.BECommand(				Command_Internal),
							.PAddr(					PAddr_Internal),
							.CurrentLeaf(			AddrGen_Leaf),
							.RemappedLeaf(			RemappedLeaf_Internal),
							.AccessSkipsWriteback(	AccessSkipsWriteback),
							.AccessIsDummy(			SetDummy),
							
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
	//	Writeback counters
	//--------------------------------------------------------------------------

	// Count commands written back	
	CountAlarm #(			.Threshold(				PathSize_DRBursts))
				out_CRW_cnt(.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				(CSWBStash | CSPathWriteback) & DRAMInitComplete & ~ROAccess & DRAMCommandValid & DRAMCommandReady),
							.Done(					PathWritebackComplete_Commands_RW));
	generate if (EnableREW) begin:RO_CMD_CNT
		CountAlarm #(		.Threshold(				BktHSize_DRBursts * (ORAML + 1))) // header writeback
				out_CRO_cnt(.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				(CSWBStash | CSPathWriteback) & DRAMInitComplete & ROAccess & DRAMCommandValid & DRAMCommandReady),
							.Done(					PathWritebackComplete_Commands_RO));
	end endgenerate
	Register	#(			.Width(					1))
				out_C_hld(	.Clock(					Clock),
							.Reset(					Reset | CSIdle),
							.Set(					(PathWritebackComplete_Commands_RO | PathWritebackComplete_Commands_RW) & DRAMCommandValid & DRAMCommandReady),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					PathWritebackComplete_Commands));
	
	// NOTE: this is like having a joint ready-valid.  We only have this logic 
	// here because a lot of the backend internal modules assume all data is 
	// flushed before next access.  This won't impact performance since the next 
	// read path won't be able to proceed until all writes are pushed to ORAM anyway.
	
	// Count data written back (identical logic as above)

	CountAlarm 	#(			.Threshold(				PathSize_DRBursts))
				rw_r_cnt(	.Clock(					Clock), 
							.Reset(					Reset | CSIdle), 
							.Enable(				DRAMWriteDataValid & DRAMWriteDataReady),
							.Done(					PathWritebackComplete_Data_Pre));
										
	Register	#(			.Width(					1))
				out_D_hld(	.Clock(					Clock),
							.Reset(					Reset | CSIdle),
							.Set(					PathWritebackComplete_Data_Pre & DRAMWriteDataValid & DRAMWriteDataReady),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					PathWritebackComplete_Data));	
	
	assign	PathWritebackComplete =					(ROAccess) ? 	PathWritebackComplete_Commands : 
																	PathWritebackComplete_Commands & PathWritebackComplete_Data;

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
