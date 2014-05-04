
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMBackendInnerControl
//	Desc:		Controls the stash and addr gen & manages background evictions / 
//				strange writeback patterns like delayed RW writeback
//==============================================================================
module BackendInnerControl(
	Clock, Reset,

	Command, PAddr, CurrentLeaf, RemappedLeaf, 
	CommandValid, CommandReady,

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
							ST_AddrGenRead =		4'd2,
							ST_StashRead =			4'd3,
							ST_Read =				4'd4,
							ST_AddrGenWrite =		4'd5,
							ST_StashWrite =			4'd6,
							ST_Write =				4'd7,
							ST_AddrGenWrite_DWB =	4'd8;	
	
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
	input					CommandValid;
	output					CommandReady;
	
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
	output					ROStart;
	output reg				REWRoundDummy;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 

	reg		[STWidth-1:0]	CS, NS;

	wire					RWAccess, ROAccess;
	wire					Addr_ROAccess, Addr_RWAccess, Addr_PathRead, Addr_PathWriteback;

	wire					RW_R_DoneAlarm, RW_W_DoneAlarm, RO_R_DoneAlarm, RO_W_DoneAlarm;	
	wire 					Addr_RW_R_DoneAlarm, Addr_RW_W_DoneAlarm, Addr_RO_R_DoneAlarm, Addr_RO_W_DoneAlarm;
	
	wire					CSIdle, CSAppend, CSAddrGenRead, CSAddrGenWrite, CSStashRead, CSStashWrite;
						
	wire					OperationComplete, AppendQueued;
	wire					Stash_AppendCmdValid, Stash_DummyCmdValid, Stash_OtherCmdValid;
	
	wire					AccessIsDummy;
		
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
	assign	CSAddrGenRead =							CS == ST_AddrGenRead;
	assign	CSAddrGenWrite =						CS == ST_AddrGenWrite;
	assign	CSStashRead =							CS == ST_StashRead;
	assign	CSStashWrite =							CS == ST_StashWrite;
	
	assign	OperationComplete = 					RO_W_DoneAlarm | RW_W_DoneAlarm;	
	assign	AppendQueued =							Stash_AppendCmdValid & StashCommandReady & ~Stash_DummyCmdValid;
	assign	CommandReady =							AppendQueued | (OperationComplete & ~AccessIsDummy);
		
	assign	Stash_AppendCmdValid =					CSIdle & DummyLeaf_Valid & CommandValid & (Command == BECMD_Append);
	assign	Stash_DummyCmdValid =					CSIdle & DummyLeaf_Valid & SetDummy;
	assign	Stash_OtherCmdValid =					CSIdle & DummyLeaf_Valid & CommandValid & ~Stash_AppendCmdValid & ~Stash_DummyCmdValid;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Idle;
		else CS <= 									NS;
	end
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Idle :
				if (DelayedWB & Addr_RWAccess & Addr_PathWriteback)
					NS =							ST_AddrGenWrite;
				else if (	StashCommandReady & (Stash_DummyCmdValid | Stash_OtherCmdValid)) // stash capacity check gets higher priority than append
					NS =							ST_AddrGenRead;
				else if (	StashCommandReady & Stash_AppendCmdValid) // do appends first ("greedily") because they are cheap
					NS =							ST_Append;
			ST_Append :
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
				if (RW_R_DoneAlarm | RO_R_DoneAlarm) // Path read complete
					NS =							ST_AddrGenWrite;
			ST_AddrGenWrite :
				if (AddrGenInReady & Addr_RWAccess & Addr_PathWriteback)
					NS =							ST_AddrGenWrite_DWB;
				else if (AddrGenInReady)
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
							.RO_W_Chunk(			0)) // TODO change REWStatCounter

		rew_data_stat(		.Clock(					Clock),
							.Reset(					Reset),
							
							.RW_R_Transfer(			DataReadTransfer),
							.RW_W_Transfer(			DataWriteTransfer),
							.RO_R_Transfer(			DataReadTransfer),
						
							.ROAccess(				ROAccess),
							.RWAccess(				RWAccess),
							.Read(					),
							.Writeback(				),

							.RW_R_DoneAlarm(		RW_R_DoneAlarm),
							.RW_W_DoneAlarm(		RW_W_DoneAlarm),
							.RO_R_DoneAlarm(		RO_R_DoneAlarm),
							.RO_W_DoneAlarm(		RO_W_DoneAlarm));

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
		assign	ROLeaf_Pre =						(REWRoundDummy) ? DummyLeaf : CurrentLeaf;
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
	//	Stash Interface
	//--------------------------------------------------------------------------
	
	assign	StashCommand =							(Stash_DummyCmdValid | Stash_OtherCmdValid) ? 	STCMD_StartRead : // Order is important; prioritize dummy reads
													(Stash_AppendCmdValid) ?						STCMD_Append :
																									STCMD_StartWrite;
	assign	StashCommandValid =						CSStashRead | CSStashWrite;
	
	assign	StashBECommand =						Command;
	assign	StashPAddr =							PAddr;
	assign	StashCurrentLeaf =						(AccessIsDummy) ? DummyLeaf : CurrentLeaf;
	assign	StashRemappedLeaf =						RemappedLeaf;
	assign	StashSkipWriteback =					CSIdle & ROAccess & EnableREW;
	assign	StashAccessIsDummy =					SetDummy;	
	
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
							
							.RW_R_DoneAlarm(		Addr_RW_R_DoneAlarm),
							.RW_W_DoneAlarm(		Addr_RW_W_DoneAlarm),
							.RO_R_DoneAlarm(		Addr_RO_R_DoneAlarm),
							.RO_W_DoneAlarm(		Addr_RO_W_DoneAlarm));	

	assign	AddrGenLeaf =							StashCurrentLeaf;
	assign	AddrGenRead =							Addr_PathRead;
	assign	AddrGenHeader =							Addr_ROAccess & Addr_PathWriteback;
	assign	AddrGenInValid = 						CSAddrGenRead | CSAddrGenWrite;
	
	//--------------------------------------------------------------------------	
endmodule
//------------------------------------------------------------------------------
