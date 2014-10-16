
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		BackendCoreController
//	Desc:		Helper module for BackendCore.
//				Controls the stash and addr gen & manages background evictions /
//				strange writeback patterns / optimizations like delayed RW
//				writeback.
//
//				The original reason this module was created was to better 
//				contain the logic that will change as one adds different 
//				read/write orders.
//==============================================================================
module BackendCoreController(
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

	ROPAddr, ROLeaf, REWRoundDummy,
	
	Mode_DummyGen
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"

	`include "CommandsLocal.vh"
	`include "TrafficGenLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"

	localparam				STWidth =				4,
							ST_Idle =				4'd0,
							ST_Append =				4'd1,
							ST_AppendWait =			4'd2,
							ST_CCROStart =			4'd3,
							ST_AESROStart =			4'd4,
							ST_AddrGenRead =		4'd5,
							ST_StashRead =			4'd6,
							ST_Read =				4'd7,
							ST_AddrGenWrite =		4'd8,
							ST_StashWrite =			4'd9,
							ST_Write =				4'd10,
							ST_AddrGenWrite_DWB =	4'd11;

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
	output reg				REWRoundDummy;

	//--------------------------------------------------------------------------
	//	Utility Interface
	//--------------------------------------------------------------------------
	
	input					Mode_DummyGen;

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	(* mark_debug = "TRUE" *)	reg		[STWidth-1:0]	CS, NS;

	(* mark_debug = "TRUE" *)	wire					RWAccess, ROAccess, PathRead, PathWriteback;
	(* mark_debug = "FALSE" *)	wire					Addr_ROAccess, Addr_RWAccess, Addr_PathRead, Addr_PathWriteback;

	(* mark_debug = "FALSE" *)	wire					RW_R_DoneAlarm, RW_W_DoneAlarm, RO_R_DoneAlarm;	
	(* mark_debug = "FALSE" *)	wire 					Addr_RW_W_DoneAlarm, Addr_RO_W_DoneAlarm;
	
	(* mark_debug = "FALSE" *)	wire					CSIdle, CSAppend, CSAppendWait, CSAddrGenRead, CSAddrGenWrite, CSStashRead, CSStashWrite, CSWrite;

	wire					AddrRWDone, DataRWDone, OperationComplete; // NOTE: do not add debug here; mysteriously causes the tools to fail @ impl
	(* mark_debug = "FALSE" *)	wire					Stash_AppendCmdValid, Stash_DummyCmdValid, Stash_OtherCmdValid;
	
	(* mark_debug = "TRUE" *)	wire					SetDummy, ClearDummy, AccessIsDummy_Reg, AccessIsDummy;
		
	(* mark_debug = "FALSE" *)	wire	[ORAML-1:0]		DummyLeaf_Pre, DummyLeaf;
	(* mark_debug = "FALSE" *)	wire					DummyLeaf_Valid;
	(* mark_debug = "FALSE" *)	wire	[PRNGLWidth-1:0] DummyLeaf_Wide;	
	
	(* mark_debug = "FALSE" *)	wire	[ORAML-1:0]		GentryLeaf;	
	
	//--------------------------------------------------------------------------
	//	Initial state
	//--------------------------------------------------------------------------

	// TODO remove this hack.  The idea is that we don't want to do the first RW 
	// access until we do a few appends.  But that logic should set 'RWAccess', 
	// not 'SetDummy' like the logic does right now.
	wire	OneAccessHasOccurred;
	Register #( .Width(1),	.Initial(1'b0))
		first_access (Clock, Reset, CommandRequest, 1'b0, 1'bx, OneAccessHasOccurred);
	
	`ifdef FPGA
		initial begin
			CS = ST_Idle;
		end 
	`endif
	
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------

	`ifdef SIMULATION
		always @(posedge Clock) begin 
			if (DataReadTransfer & DataWriteTransfer) begin
				$display("[%m @ %t] ERROR: Overlapping read/write transfers.  This could be a valid optimization (eh ... really?), but is more likely a control bug", $time);
				$finish;			
			end
		end
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

	assign	OperationComplete = 					Addr_RO_W_DoneAlarm | (AddrRWDone & DataRWDone);
	assign	CommandDone =							(CSAppendWait & StashCommandReady) | (OperationComplete & ~AccessIsDummy);

	assign	Stash_AppendCmdValid =					DummyLeaf_Valid & CommandRequest & (Command == BECMD_Append);
	assign	Stash_DummyCmdValid =					DummyLeaf_Valid & AccessIsDummy;
	assign	Stash_OtherCmdValid =					DummyLeaf_Valid & CommandRequest & ~Stash_AppendCmdValid & ~Stash_DummyCmdValid;

	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Idle;
		else CS <= 									NS;
	end

	// Implement all the hacky read/write order schemes in this FSM

	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Idle :
				if (	StashCommandReady & Stash_DummyCmdValid) // stash capacity check gets higher priority than append
					if (ROAccess)
						NS =						ST_CCROStart;
					else
						NS =						ST_AddrGenRead;
				else if (	StashCommandReady & Stash_AppendCmdValid) // do appends first ("greedily") because they are cheap
					NS =							ST_Append;
				else if (	StashCommandReady & Stash_OtherCmdValid) // otherwise do a normal access
					if (ROAccess)
						NS =						ST_CCROStart;
					else
						NS =						ST_AddrGenRead;
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
			ST_CCROStart : // TODO: we can remove this state now that ROStart...Ready is gone
				if (EnableAES)
					NS =							ST_AESROStart;
				else 
					NS =							ST_AddrGenRead;
			ST_AESROStart : // TODO: we can remove this state now that ROStart...Ready is gone
					NS =							ST_AddrGenRead;
			ST_AddrGenRead :
				if (AddrGenInReady)
					NS =							ST_StashRead;
			ST_StashRead :
				if (StashCommandReady)
					NS =							ST_Read;
			ST_Read :
				if (	 RW_R_DoneAlarm | RO_R_DoneAlarm)
					NS =							ST_AddrGenWrite;
			ST_AddrGenWrite :
				if (	AddrGenInReady)
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
							.RW_R_Chunk(			PathSize_BEDChunks),
							.RW_W_Chunk(			PathSize_BEDChunks),
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
		(* mark_debug = "FALSE" *) wire [ORAMU-1:0]	ROPAddr_Pre;
		(* mark_debug = "FALSE" *) wire [ORAML-1:0]	ROLeaf_Pre;
		(* mark_debug = "FALSE" *) wire				REWRoundDummy_Pre;

		Counter	#(			.Width(					ORAML))
			gentry_leaf(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				Addr_RW_W_DoneAlarm),
							.In(					{ORAML{1'bx}}),
							.Count(					GentryLeaf));

		assign	ClearDummy =						CSIdle & ~StashAlmostFull & ~RWAccess;
		assign	SetDummy =							CSIdle & (StashAlmostFull | (RWAccess & OneAccessHasOccurred));

		assign	DummyLeaf =							(Addr_RWAccess) ? GentryLeaf : DummyLeaf_Pre;
	
		assign	ROPAddr_Pre =						PAddr;
		assign	ROLeaf_Pre =						(REWRoundDummy_Pre) ? DummyLeaf : CurrentLeaf;
		assign	REWRoundDummy_Pre =					AccessIsDummy;
		if (Overclock) begin:OCLK
			always @(posedge Clock) begin
				ROPAddr <=							ROPAddr_Pre;
				ROLeaf <=							ROLeaf_Pre;
				REWRoundDummy <=					REWRoundDummy_Pre;
			end
		end else begin:UCLK
			always @( * ) begin
				ROPAddr =							ROPAddr_Pre;
				ROLeaf =							ROLeaf_Pre;
				REWRoundDummy =						REWRoundDummy_Pre;
			end
		end
	end else begin:BASIC_CONTROL
		assign	GentryLeaf =						{ORAML{1'bx}};
	
		assign	ClearDummy =						CSIdle & ~StashAlmostFull;
		assign	SetDummy =							CSIdle & StashAlmostFull;

		assign	DummyLeaf =							DummyLeaf_Pre;
		
`ifdef FPGA
		initial begin
			ROPAddr =								{ORAMU{1'bx}};
			ROLeaf =								{ORAML{1'bx}};
			REWRoundDummy =							1'b0;
		end
`endif
	end endgenerate

	//--------------------------------------------------------------------------
	//	Dummy access control
	//--------------------------------------------------------------------------	
	
	Register	#(			.Width(					1))
				dummy_reg(	.Clock(					Clock),
							.Reset(					Reset | ClearDummy),
							.Set(					SetDummy),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					AccessIsDummy_Reg));
	assign	AccessIsDummy =							(AccessIsDummy_Reg & ~ClearDummy) | Mode_DummyGen;

	PRNG 		#(			.RandWidth(				PRNGLWidth)) 
				leaf_gen(	.Clock(					Clock),
							.Reset(					Reset),
							.RandOutReady(			OperationComplete),
							.RandOutValid(			DummyLeaf_Valid),
							.RandOut(				DummyLeaf_Wide),
							.SecretKey(				128'hd8_40_e1_a8_dc_ca_e7_ec_d9_1f_61_48_7a_f2_cb_73)); // TODO make dynamic
	assign	DummyLeaf_Pre =							(Mode_DummyGen) ? DummyGenLeaf : DummyLeaf_Wide[ORAML-1:0];
							
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
	assign	AddrGenRead =							CSAddrGenRead;//Addr_PathRead;
	assign	AddrGenHeader =							Addr_ROAccess & Addr_PathWriteback;
	assign	AddrGenInValid = 						(CSAddrGenRead | CSAddrGenWrite);

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
