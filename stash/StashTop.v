
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		StashTop
//	Desc:		A simple command interface for the stash.  This module also 
//				converts the DRAM bucket format into a more stash-efficient 
//				format that will be stored in the Stash internal memories.
//==============================================================================
module StashTop(
	Clock, Reset,

	StashAlmostFull,
	
	Command, CommandValid, CommandReady,
	BECommand, PAddr, CurrentLeaf, RemappedLeaf, MAC, AccessIsDummy, AccessSkipsWriteback,

	FEReadData, FEReadDataValid, FEReadMAC, FEReadComplete,
							
	FEWriteData, FEWriteDataValid, FEWriteDataReady,
	
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,
	
	JTAG_StashCore, JTAG_Stash, JTAG_StashTop
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	
	`include "DDR3SDRAMLocal.vh"
	
	`include "BucketLocal.vh"
	`include "CommandsLocal.vh"
	
	`include "DMLocal.vh"
	`include "JTAG.vh"
		
	localparam				STWidth =				3,
							ST_Initialize =			3'd0,
							ST_Idle =				3'd1,
							ST_Read =				3'd2,
							ST_StartWriteback =		3'd3,
							ST_Update =				3'd4,
							ST_Writeback =			3'd5,
							ST_Append =				3'd6,
							ST_Error =				3'd7;
							
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	
	//--------------------------------------------------------------------------
	//	Frontend Interface
	//--------------------------------------------------------------------------

	output					StashAlmostFull;
	
	input	[STCMDWidth-1:0] Command;
	input					CommandValid;
	output					CommandReady;
	
	// These commands must be valid when CommandValid & CommandReady & Command == StartRead | Command == StartAppend
	input	[BECMDWidth-1:0] BECommand;
	input	[ORAMU-1:0]		PAddr;
	input	[ORAML-1:0]		CurrentLeaf; // If Command == Append, this is XX 
	input	[ORAML-1:0]		RemappedLeaf;
	input	[ORAMH-1:0]		MAC;
	input					AccessIsDummy;
	input					AccessSkipsWriteback;
	
	output	[BEDWidth-1:0]	FEReadData;
	output	[ORAMH-1:0]		FEReadMAC;
	output					FEReadComplete;
	output					FEReadDataValid;
	
	input	[BEDWidth-1:0]	FEWriteData;						
	input					FEWriteDataValid;
	output					FEWriteDataReady;
	
	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------
	
	input	[BEDWidth-1:0]	DRAMReadData;
	input					DRAMReadDataValid;
	output					DRAMReadDataReady;
	
	output	[BEDWidth-1:0]	DRAMWriteData;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;
	
	output	[JTWidth_StashCore-1:0] JTAG_StashCore;
	output	[JTWidth_Stash-1:0] JTAG_Stash;
	output	[JTWidth_StashTop-1:0] JTAG_StashTop;	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	// Control logic & commands
	
	wire					ResetDone, StashIdle;
	
	wire					StartAppendOp, StartScanOp, StartWritebackOp;
	wire					AppendComplete, UpdateComplete;
	
	wire					EvictGate, UpdateGate;
	
	(* mark_debug = "TRUE" *)	reg		[STWidth-1:0]	CS, NS;	
	wire					CSIdle, CSRead, CSStartWrite, CSWrite, CSAppend, CSUpdate;

	wire					LatchBECommand;
	
	wire	[BECMDWidth-1:0] BECommand_Internal;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]		PAddr_Internal;
	wire	[ORAML-1:0]		CurrentLeaf_Internal;
	wire	[ORAML-1:0]		RemappedLeaf_Internal;
	wire	[ORAMH-1:0]		MAC_Internal;
	wire					AccessIsDummy_Internal, AccessSkipsWriteback_Internal;
	
	// Read pipeline
	
	wire					PathReadCommitted;	
		
	wire	[BEDWidth-1:0]	StashWriteData;
	wire					StashWriteValid, StashWriteReady;
	
	wire	[ORAMU-1:0]		StashWritePAddr; 
	wire	[ORAML-1:0]		StashWriteLeaf;
	wire	[ORAMH-1:0]		StashWriteMAC;
	
	// Writeback pipeline

	wire	[BEDWidth-1:0]	StashReadData;
	wire					StashReadValid, StashReadReady;
	
	wire	[ORAMU-1:0]		StashReadPAddr; 
	wire	[ORAML-1:0]		StashReadLeaf;
	wire	[ORAMH-1:0]		StashReadMAC;
	
	wire					StashBlockReadComplete;	

	// Stash
	
	wire					Stash_UpdateBlockValid, Stash_UpdateBlockReady;
	wire					Stash_EvictBlockValid, Stash_EvictBlockReady;

	// Derived signals
	
	reg						CSRead_Delayed, CSAppend_Delayed;
	wire					CSRead_FirstCycle, CSAppend_FirstCycle;
	
	// debugging
	
	(* mark_debug = "TRUE" *)	wire					ERROR_ISC2, ERROR_ISC3, ERROR_ISC4, ERROR_SOF, ERROR_StashTop;
	
	//--------------------------------------------------------------------------
	//	Initial state
	//--------------------------------------------------------------------------	
	
	`ifdef FPGA
		initial begin
			CS = ST_Initialize;
		end
	`endif
		
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------
	
	Register1b 	errno2(Clock, Reset, CSIdle & CommandValid & (Command != STCMD_StartRead & Command != STCMD_Append), 	ERROR_ISC2);
	Register1b 	errno3(Clock, Reset, CSRead & CommandValid & Command != STCMD_StartWrite, 								ERROR_ISC3);
	Register1b 	errno4(Clock, Reset, CommandValid & Command == STCMD_Append & BECommand != BECMD_Append, 				ERROR_ISC4);
	Register1b 	errno5(Clock, Reset, LatchBECommand & StashAlmostFull & ~AccessIsDummy, 								ERROR_SOF);
	
	Register1b 	errANY(Clock, Reset, ERROR_ISC2 | ERROR_ISC3 | ERROR_ISC4 | ERROR_SOF, ERROR_StashTop);
	
	assign	JTAG_StashTop =							{
														ERROR_ISC2, 
														ERROR_ISC3, 
														ERROR_ISC4, 
														ERROR_SOF	
													};
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (ERROR_ISC2) begin
				$display("[%m] ERROR: Only start read commands/appends accepted at this time.");
				$finish;
			end
			
			if (ERROR_ISC3) begin
				$display("[%m] ERROR: Only start write command accepted at this time.");
				$finish;				
			end
			
			if (ERROR_ISC4) begin
				$display("[%m] ERROR: Bogus command.");
				$finish;
			end
			
			if (ERROR_SOF) begin
				$display("[%m] ERROR: We are about to perform a real access but the stash is almost full.");
				$finish;			
			end
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Control logic
	//--------------------------------------------------------------------------
	
	assign	EvictGate =								CSAppend;
	assign	UpdateGate = 							CSUpdate;
	
	assign	FEWriteDataReady = 						(Stash_EvictBlockReady & 	EvictGate) | 
													(Stash_UpdateBlockReady & 	UpdateGate);
	assign	Stash_EvictBlockValid = 				FEWriteDataValid & 			EvictGate;
	assign	Stash_UpdateBlockValid =				FEWriteDataValid & 			UpdateGate;
	
	assign	CommandReady =							(CSIdle & StashIdle) | CSStartWrite;
	
	assign	CSIdle =								CS == ST_Idle;
	assign	CSRead =								CS == ST_Read;
	assign	CSStartWrite =							CS == ST_StartWriteback;
	assign	CSUpdate =								CS == ST_Update;
	assign	CSWrite =								CS == ST_Writeback;
	assign	CSAppend =								CS == ST_Append;
	
	assign	StartAppendOp =							CSAppend_FirstCycle;
	assign	StartScanOp =							CSRead_FirstCycle;
	assign	StartWritebackOp =						CSStartWrite & Command == STCMD_StartWrite;

	assign	CSAppend_FirstCycle =					CSAppend & ~CSAppend_Delayed;
	assign	CSRead_FirstCycle =						CSRead & ~CSRead_Delayed;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Initialize;
		else CS <= 									NS;
		
		CSRead_Delayed <=							CSRead;
		CSAppend_Delayed <=							CSAppend;
	end
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Initialize : 
				if (ResetDone) 
					NS =						 	ST_Idle;
			ST_Idle :
				if (ERROR_StashTop)
					NS =							ST_Error;
				else if (CommandValid & Command == STCMD_Append)
					NS =						 	ST_Append;
				else if (CommandValid)
					NS =						 	ST_Read;
			ST_Read :
				if (PathReadCommitted)
					NS =						 	ST_StartWriteback;
			ST_StartWriteback :
				if (		CommandValid & ~AccessIsDummy_Internal & BECommand_Internal == BECMD_Update)
					NS =							ST_Update;
				else if (	CommandValid)
					NS =							ST_Writeback;
			ST_Update :
				if (UpdateComplete)
					NS =							ST_Writeback;
			ST_Writeback :
				if (StashIdle)
					NS =						 	ST_Idle;
			ST_Append :
				if (AppendComplete)
					NS =						 	ST_Idle;
		endcase
	end	

	//--------------------------------------------------------------------------
	//	Commands from the Backend
	//--------------------------------------------------------------------------
	
	assign	LatchBECommand =						CommandValid & CommandReady & CSIdle;
	
	Register	#(			.Width(					BECMDWidth + ORAMU + 2*ORAML + 1 + 1))
				becmd_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				LatchBECommand),
							.In(					{BECommand, 			PAddr, 			CurrentLeaf, 			RemappedLeaf, 			AccessIsDummy,				AccessSkipsWriteback}),
							.Out(					{BECommand_Internal, 	PAddr_Internal, CurrentLeaf_Internal, 	RemappedLeaf_Internal,	AccessIsDummy_Internal, 	AccessSkipsWriteback_Internal}));			

	generate if (EnableIV) begin:MAC_MODE
	Register	#(			.Width(					ORAMH))
				becmd_mac(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				LatchBECommand),
							.In(					MAC),
							.Out(					MAC_Internal));			
	end else begin:NO_MAC_MODE
		assign	MAC_Internal =						{ORAMH{1'bx}};
	end endgenerate
						
	//--------------------------------------------------------------------------
	//	In Path
	//--------------------------------------------------------------------------
	
	DRAMToStash	#(			.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAME(					ORAME),
							.BEDWidth(				BEDWidth),
							.EnableAES(				EnableAES),
							.EnableIV(				EnableIV),
							.EnableREW(				EnableREW))
				in_convert(	.Clock(					Clock), 
							.Reset(					Reset),

							.PathTransition(		PathReadCommitted),
							
							.DRAMData(				DRAMReadData), 
							.DRAMValid(				DRAMReadDataValid), 
							.DRAMReady(				DRAMReadDataReady),
							
							.StashData(				StashWriteData), 
							.StashValid(			StashWriteValid), 
							.StashReady(			StashWriteReady),
							.StashPAddr(			StashWritePAddr), 
							.StashLeaf(				StashWriteLeaf),
							.StashMAC(				StashWriteMAC));
	
	//--------------------------------------------------------------------------
	//	Stash
	//--------------------------------------------------------------------------
	
	Stash		#(			.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.ORAME(					ORAME),
							.BEDWidth(				BEDWidth),
							.EnableIV(				EnableIV),
							.Overclock(				Overclock),
							.StashOutBuffering(		4), // this should be good enough ...
							.StopOnBlockNotFound(	1))
				stash(		.Clock(					Clock),
							.Reset(					Reset),
							.ResetDone(				ResetDone),
							
							.IsIdle(				StashIdle),
							
							.AccessCommand(			BECommand_Internal),
							.RemapLeaf(				RemappedLeaf_Internal),
							.AccessLeaf(			CurrentLeaf_Internal),
							.AccessMAC(				MAC_Internal),
							.AccessPAddr(			PAddr_Internal),
							.AccessIsDummy(			AccessIsDummy_Internal),
							.AccessSkipsWriteback(	AccessSkipsWriteback_Internal),
							
							.StartAppend(			StartAppendOp),
							.StartScan(				StartScanOp),
							.StartWriteback(		StartWritebackOp),
							
							.ReturnData(			FEReadData),
							.ReturnPAddr(			), // not connected
							.ReturnLeaf(			), // not connected
							.ReturnMAC(				FEReadMAC),
							.ReturnDataOutValid(	FEReadDataValid),
							.BlockReturnComplete(	FEReadComplete),
							
							.UpdateData(			FEWriteData),
							.UpdateDataInValid(		Stash_UpdateBlockValid),
							.UpdateDataInReady(		Stash_UpdateBlockReady),
							.BlockUpdateComplete(	UpdateComplete),
							
							.EvictData(				FEWriteData),
							.EvictPAddr(			PAddr_Internal),
							.EvictLeaf(				RemappedLeaf_Internal),
							.EvictMAC(				MAC_Internal),
							.EvictDataInValid(		Stash_EvictBlockValid),
							.EvictDataInReady(		Stash_EvictBlockReady),
							.BlockEvictComplete(	AppendComplete),

							.WriteData(				StashWriteData),
							.WriteInValid(			StashWriteValid),
							.WriteInReady(			StashWriteReady), 
							.WritePAddr(			StashWritePAddr),
							.WriteLeaf(				StashWriteLeaf),
							.WriteMAC(				StashWriteMAC),
							.BlockWriteComplete(	), 
							
							.ReadData(				StashReadData),
							.ReadPAddr(				StashReadPAddr),
							.ReadLeaf(				StashReadLeaf),
							.ReadMAC(				StashReadMAC),
							.ReadOutValid(			StashReadValid), 
							.ReadOutReady(			StashReadReady), 
							.BlockReadComplete(		StashBlockReadComplete),
							
							.PathReadComplete(		), // not connected
							
							.StashAlmostFull(		StashAlmostFull),
							
							.JTAG_StashCore(		JTAG_StashCore),
							.JTAG_Stash(			JTAG_Stash));
	
	//--------------------------------------------------------------------------
	//	[Writeback path] Buffers and up shifters
	//--------------------------------------------------------------------------
	
	StashToDRAM	#(			.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.BEDWidth(				BEDWidth),
							.EnableIV(				EnableIV))
				out_convert(.Clock(					Clock), 
							.Reset(					Reset),

							.StashData(				StashReadData), 
							.StashValid(			StashReadValid), 
							.StashReady(			StashReadReady),
							.StashPAddr(			StashReadPAddr), 
							.StashLeaf(				StashReadLeaf),
							.StashMAC(				StashReadMAC),
							.OperationComplete(		StashBlockReadComplete),					
							
							.DRAMData(				DRAMWriteData), 
							.DRAMValid(				DRAMWriteDataValid), 
							.DRAMReady(				DRAMWriteDataReady));

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
