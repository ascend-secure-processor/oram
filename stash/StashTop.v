
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
	BECommand, PAddr, CurrentLeaf, RemappedLeaf, AccessIsDummy, AccessSkipsWriteback,

	FEReadData, FEReadDataValid,
	FEWriteData, FEWriteDataValid, FEWriteDataReady,
	
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	`include "Stash.vh"
	
	`include "SecurityLocal.vh"
	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	
	localparam				SpaceRemaining =		BktHSize_RndBits - BktHSize_RawBits,
							PBEDP1Width = 			PBEDWidth + 1;

	parameter				ORAMUValid =			21;
															
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
	input					AccessIsDummy;
	input					AccessSkipsWriteback;
	
	output	[BEDWidth-1:0]	FEReadData;
	output					FEReadDataValid;
	
	input	[BEDWidth-1:0]	FEWriteData;						
	input					FEWriteDataValid;
	output					FEWriteDataReady;
	
	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------
	
	input	[DDRDWidth-1:0]	DRAMReadData;
	input					DRAMReadDataValid;
	output					DRAMReadDataReady;
	
	output	[DDRDWidth-1:0]	DRAMWriteData;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	// Control logic & commands
	
	wire	[STCMDWidth-1:0] WritebackCommand;
	
	wire					ResetDone, StashIdle;
	
	wire					StartAppendOp, StartScanOp, StartWritebackOp;
	wire					AppendComplete, UpdateComplete;
	
	wire					EvictGate, UpdateGate;
	
	(* mark_debug = "TRUE" *)	reg		[STWidth-1:0]	CS, NS;	
	wire					CSIdle, CSRead, CSStartWrite, CSWrite, CSAppend, CSUpdate;

	wire					LatchCommand, LatchBECommand;
	
	wire	[BECMDWidth-1:0] BECommand_Internal;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]		PAddr_Internal;
	wire	[ORAML-1:0]		CurrentLeaf_Internal;
	wire	[ORAML-1:0]		RemappedLeaf_Internal;
	wire					AccessIsDummy_Internal, AccessSkipsWriteback_Internal;
	
	// Read pipeline
		
	wire					HeaderDownShift_InValid, HeaderDownShift_InReady;
	wire					DataDownShift_InValid, DataDownShift_InReady;
		
	wire	[BktBSTWidth-1:0] BucketReadCtr;
	wire					ReadProcessingHeader;	
	
	wire	[ORAMZ-1:0] 	HeaderDownShift_ValidBits;
	wire	[BigUWidth-1:0]	HeaderDownShift_PAddrs;
	wire	[BigLWidth-1:0]	HeaderDownShift_Leaves;
		
	wire					ValidDownShift_OutData, ValidDownShift_OutValid;
	
	wire	[BEDWidth-1:0]	DataDownShift_OutData;
	wire					DataDownShift_OutValid, DataDownShift_OutReady;
	wire					BlockReadValid, BlockReadReady;
	
	wire	[ORAMU-1:0]		HeaderDownShift_OutPAddr; 
	wire	[ORAML-1:0]		HeaderDownShift_OutLeaf;
	wire					HeaderDownShift_OutValid;		
	
	wire					DataDownShift_Transfer;
	
	wire					BlockReadCtr_Reset;
	wire	[BlkBEDWidth-1:0] BlockReadCtr; 	
	wire 					InPath_BlockReadComplete;	
	
	// Writeback pipeline

	wire					Stash_BlockReadComplete;
	
	wire	[ORAMU-1:0]		HeaderUpShift_InPAddr; 
	wire	[ORAML-1:0]		HeaderUpShift_InLeaf;
	wire					HeaderUpShift_InReady;
	wire					HeaderUpShift_OutValid, HeaderUpShift_OutReady;

	wire	[ORAMZ-1:0] 	HeaderUpShift_ValidBits;
	wire	[BigUWidth-1:0]	HeaderUpShift_PAddrs;
	wire	[BigLWidth-1:0]	HeaderUpShift_Leaves;	
	
	wire	[BEDWidth-1:0]	DataUpShift_InData;
	wire					DataUpShift_InValid, DataUpShift_InReady;
	wire	[DDRDWidth-1:0]	DataUpShift_OutData;
	wire					DataUpShift_OutValid, DataUpShift_OutReady;

	wire					WritebackBlockIsValid;
	wire 					WritebackBlockCommit;
	
	wire 					WritebackProcessingHeader;		
	wire	[DDRDWidth-1:0]	UpShift_HeaderFlit, BucketBuf_OutData;
	wire					BucketBuf_OutValid, BucketBuf_OutReady;
							
	wire					BucketWritebackValid;
	wire	[BktBSTWidth-1:0] BucketWritebackCtr;
							
	wire	[DDRDWidth-1:0]	UpShift_DRAMWriteData;
				
	// Stash
	
	wire					Stash_UpdateBlockValid, Stash_UpdateBlockReady;
	wire					Stash_EvictBlockValid, Stash_EvictBlockReady;

	wire					Stash_BlockWriteComplete;

	// Derived signals
	
	reg						CSRead_Delayed, CSAppend_Delayed;
	wire					CSRead_FirstCycle, CSAppend_FirstCycle;
	
	// debugging
	
	(* mark_debug = "TRUE" *)	wire					ERROR_ISC2, ERROR_ISC3, ERROR_ISC4, ERROR_SOF, ERROR_StashTop;
	
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
	
	Register1b 	errno2(Clock, Reset, CSIdle & CommandValid & (Command != STCMD_StartRead & Command != STCMD_Append), 	ERROR_ISC2);
	Register1b 	errno3(Clock, Reset, CSRead & CommandValid & Command != STCMD_StartWrite, 								ERROR_ISC3);
	Register1b 	errno4(Clock, Reset, CommandValid & Command == STCMD_Append & BECommand != BECMD_Append, 				ERROR_ISC4);
	Register1b 	errno5(Clock, Reset, LatchBECommand & StashAlmostFull & ~AccessIsDummy, 								ERROR_SOF);
	
	Register1b 	errANY(Clock, Reset, ERROR_ISC1 | ERROR_ISC2 | ERROR_ISC3 | ERROR_ISC4 | ERROR_SOF, 					ERROR_StashTop);
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (ValidDownShift_OutValid & ^ValidDownShift_OutData === 1'bx) begin
				$display("[%m] ERROR: control signal is X");
				$finish;
			end
			
			if (ERROR_ISC1) begin
				$display("[%m] ERROR: Stash received more blocks than BEndInner sent ...");
				$finish;
			end
			
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
	
	PathReadCommitted
	
	assign	EvictGate =								CSAppend;
	assign	UpdateGate = 							CSUpdate;
	
	assign	FEWriteDataReady = 						(Stash_EvictBlockReady & 	EvictGate) | 
													(Stash_UpdateBlockReady & 	UpdateGate);
	assign	Stash_EvictBlockValid = 				FEWriteDataValid & 			EvictGate;
	assign	Stash_UpdateBlockValid =				FEWriteDataValid & 			UpdateGate;
	
	assign	CommandReady =							(CSIdle & StashIdle) | CSRead;
	
	assign	CSIdle =								CS == ST_Idle;
	assign	CSRead =								CS == ST_Read;
	assign	CSStartWrite =							CS == ST_StartWriteback;
	assign	CSUpdate =								CS == ST_Update;
	assign	CSWrite =								CS == ST_Writeback;
	assign	CSAppend =								CS == ST_Append;
	
	assign	StartAppendOp =							CSAppend_FirstCycle;
	assign	StartScanOp =							CSRead_FirstCycle;
	assign	StartWritebackOp =						CSStartWrite & WritebackCommand == STCMD_StartWrite;

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
				if (CommandValid)
					NS =						 	ST_StartWriteback;
			ST_StartWriteback :
				if (		PathReadCommitted & ~AccessIsDummy_Internal & BECommand_Internal == BECMD_Update)
					 NS =							ST_Update;
				else if (	PathReadCommitted)
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
	
	assign	LatchCommand =							CommandValid & CommandReady & CSRead;
	assign	LatchBECommand =						CommandValid & CommandReady & CSIdle;
	
	Register	#(			.Width(					STCMDWidth))
				cmd_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				LatchCommand),
							.In(					Command),
							.Out(					WritebackCommand));
	
	Register	#(			.Width(					BECMDWidth + ORAMU + 2*ORAML + 1 + 1))
				becmd_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				LatchBECommand),
							.In(					{BECommand, 			PAddr, 			CurrentLeaf, 			RemappedLeaf, 			AccessIsDummy,				AccessSkipsWriteback}),
							.Out(					{BECommand_Internal, 	PAddr_Internal, CurrentLeaf_Internal, 	RemappedLeaf_Internal,	AccessIsDummy_Internal, 	AccessSkipsWriteback_Internal}));			

	//--------------------------------------------------------------------------
	//	[Read path] Buffers and down shifters
	//--------------------------------------------------------------------------
	
	// Count where we are in a bucket (so we can determine when we are at a header)
	CountAlarm  #(  		.Threshold(             BktHSize_DRBursts + BktPSize_DRBursts))
				in_bkt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				DRAMReadDataValid & DRAMReadDataReady),
							.Count(					BucketReadCtr));
	
	// Per-bucket header/payload arbitration
	assign	ReadProcessingHeader =					BucketReadCtr < BktHSize_DRBursts;
	assign	HeaderDownShift_InValid =				DRAMReadDataValid & ReadProcessingHeader;
	assign	DataDownShift_InValid =					DRAMReadDataValid & ~ReadProcessingHeader;
	assign	DRAMReadDataReady =						(ReadProcessingHeader) ? HeaderDownShift_InReady : DataDownShift_InReady;
	
	assign	HeaderDownShift_ValidBits =				DRAMReadData[BktHVStart+BigVWidth-1:BktHVStart];
	assign	HeaderDownShift_PAddrs =				DRAMReadData[BktHUStart+BigUWidth-1:BktHUStart];
	assign	HeaderDownShift_Leaves =				DRAMReadData[BktHLStart+BigLWidth-1:BktHLStart];
	
	FIFOShiftRound #(		.IWidth(				BigUWidth),
							.OWidth(				ORAMU))
				in_U_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderDownShift_PAddrs),
							.InValid(				HeaderDownShift_InValid),
							.InAccept(				HeaderDownShift_InReady),
							.OutData(			    HeaderDownShift_OutPAddr),
							.OutValid(				HeaderDownShift_OutValid),
							.OutReady(				InPath_BlockReadComplete));
	ShiftRegister #(		.PWidth(				BigLWidth),
							.SWidth(				ORAML))
				in_L_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					HeaderDownShift_InValid & HeaderDownShift_InReady), 
							.Enable(				InPath_BlockReadComplete), 
							.PIn(					HeaderDownShift_Leaves), 
							.SIn(					{ORAML{1'bx}}),
							.SOut(					HeaderDownShift_OutLeaf));

	FIFOShiftRound #(		.IWidth(				DDRDWidth),
							.OWidth(				BEDWidth),
							.Register(				1))
				in_D_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMReadData),
							.InValid(				DataDownShift_InValid),
							.InAccept(				DataDownShift_InReady),
							.OutData(				DataDownShift_OutData),
							.OutValid(				DataDownShift_OutValid),
							.OutReady(				DataDownShift_OutReady));

	//--------------------------------------------------------------------------
	//	[Read path] Dummy block handling
	//--------------------------------------------------------------------------

	assign	InPath_BlockReadComplete =				Stash_BlockWriteComplete | (BlockReadCtr_Reset & DataDownShift_Transfer);
	assign	BlockReadValid =						DataDownShift_OutValid & HeaderDownShift_OutValid & (ValidDownShift_OutData & ValidDownShift_OutValid);
	assign	DataDownShift_OutReady =				(ValidDownShift_OutValid) ? ((ValidDownShift_OutData) ? BlockReadReady : 1'b1) : 1'b0; 
	
	assign	DataDownShift_Transfer =				DataDownShift_OutValid & DataDownShift_OutReady;
	
	// Use FIFOShiftRound to generate ValidDownShift_OutValid signal
	FIFOShiftRound #(		.IWidth(				ORAMZ),
							.OWidth(				1))
				in_V_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderDownShift_ValidBits),
							.InValid(				HeaderDownShift_InValid),
							.InAccept(				), // will be the same as in_L_shft
							.OutData(			    ValidDownShift_OutData),
							.OutValid(				ValidDownShift_OutValid),
							.OutReady(				InPath_BlockReadComplete));	
	
	Counter		#(			.Width(					BlkBEDWidth))
				in_blk_cnt(	.Clock(					Clock),
							.Reset(					Reset | BlockReadCtr_Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DataDownShift_Transfer & ~ValidDownShift_OutData & ValidDownShift_OutValid),
							.In(					{BlkBEDWidth{1'bx}}),
							.Count(					BlockReadCtr));	
	CountCompare #(			.Width(					BlkBEDWidth),
							.Compare(				BlkSize_BEDChunks - 1))
				in_blk_cmp(	.Count(					BlockReadCtr), 
							.TerminalCount(			BlockReadCtr_Reset));
	
	//--------------------------------------------------------------------------
	//	[Read path] Path counters
	//--------------------------------------------------------------------------	
	
	// count number of real/dummy blocks on path and signal the end of the path 
	// read when we read a whole path's worth 	

	Counter		#(			.Width(					PBEDP1Width))
				inner_cnt(	.Clock(					Clock),
							.Reset(					Reset | CSIdle),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DataDownShift_Transfer),
							.In(					{PBEDP1Width{1'bx}}),
							.Count(					InnerCount));	
	
	//--------------------------------------------------------------------------
	//	Stash
	//--------------------------------------------------------------------------
	
	Stash		#(			.StashOutBuffering(		4), // this should be good enough ...
							.StopOnBlockNotFound(	StopOnBlockNotFound),
							.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.Overclock(				Overclock),
							
							.ORAMUValid(			ORAMUValid))
				stash(		.Clock(					Clock),
							.Reset(					Reset),
							.ResetDone(				ResetDone),
							
							.IsIdle(				StashIdle),
							
							.AccessCommand(			BECommand_Internal),
							.RemapLeaf(				RemappedLeaf_Internal),
							.AccessLeaf(			CurrentLeaf_Internal),
							.AccessPAddr(			PAddr_Internal),
							.AccessIsDummy(			AccessIsDummy_Internal),
							.AccessSkipsWriteback(	AccessSkipsWriteback_Internal),
							
							.StartAppend(			StartAppendOp),
							.StartScan(				StartScanOp),
							.StartWriteback(		StartWritebackOp),
							
							.ReturnData(			FEReadData),
							.ReturnPAddr(			), // not connected
							.ReturnLeaf(			), // not connected
							.ReturnDataOutValid(	FEReadDataValid),
							.BlockReturnComplete(	), // not connected
							
							.UpdateData(			FEWriteData),
							.UpdateDataInValid(		Stash_UpdateBlockValid),
							.UpdateDataInReady(		Stash_UpdateBlockReady),
							.BlockUpdateComplete(	UpdateComplete),
							
							.EvictData(				FEWriteData),
							.EvictPAddr(			PAddr_Internal),
							.EvictLeaf(				RemappedLeaf_Internal),
							.EvictDataInValid(		Stash_EvictBlockValid),
							.EvictDataInReady(		Stash_EvictBlockReady),
							.BlockEvictComplete(	AppendComplete),

							.WriteData(				DataDownShift_OutData),
							.WriteInValid(			BlockReadValid),
							.WriteInReady(			BlockReadReady), 
							.WritePAddr(			HeaderDownShift_OutPAddr),
							.WriteLeaf(				HeaderDownShift_OutLeaf),
							.BlockWriteComplete(	Stash_BlockWriteComplete), 
							
							.ReadData(				DataUpShift_InData),
							.ReadPAddr(				HeaderUpShift_InPAddr),
							.ReadLeaf(				HeaderUpShift_InLeaf),
							.ReadOutValid(			DataUpShift_InValid), 
							.ReadOutReady(			DataUpShift_InReady), 
							.BlockReadComplete(		Stash_BlockReadComplete),
							.PathReadComplete(		), // not connected
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			),
							.StashOccupancy(		)); // debugging

	//--------------------------------------------------------------------------
	//	[Writeback path] Buffers and up shifters
	//--------------------------------------------------------------------------
	
	// Translate:
	//		{Z{ULD}} (the stash's format) 
	//		to 
	//		{ {Z{U}}, {Z{L}}, {Z{L}} } (the DRAM's format)
	
	// Note: It is probably best that Stash computes these; not changing them now to save time
	assign	WritebackBlockIsValid =					HeaderUpShift_InPAddr != DummyBlockAddress;
	assign	WritebackBlockCommit =					Stash_BlockReadComplete & DataUpShift_InValid & DataUpShift_InReady;
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (~HeaderUpShift_InReady & WritebackBlockCommit) begin
				$display("[%m @ %t] ERROR: Illegal signal combination (data will be lost)", $time);
				$finish;
			end
		end
	`endif
	
	FIFOShiftRound #(		.IWidth(				ORAMU),
							.OWidth(				BigUWidth))
				out_U_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderUpShift_InPAddr),
							.InValid(				WritebackBlockCommit),
							.InAccept(				HeaderUpShift_InReady),
							.OutData(			    HeaderUpShift_PAddrs),
							.OutValid(				HeaderUpShift_OutValid),
							.OutReady(				HeaderUpShift_OutReady));
	ShiftRegister #(		.PWidth(				BigLWidth),
							.SWidth(				ORAML))
				out_L_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				WritebackBlockCommit), 
							.SIn(					HeaderUpShift_InLeaf), 
							.POut(					HeaderUpShift_Leaves));							
	ShiftRegister #(		.PWidth(				ORAMZ),
							.SWidth(				1))
				out_V_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				WritebackBlockCommit), 
							.SIn(					WritebackBlockIsValid), 
							.POut(					HeaderUpShift_ValidBits));
	FIFOShiftRound #(		.IWidth(				BEDWidth),
							.OWidth(				DDRDWidth))
				out_D_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DataUpShift_InData),
							.InValid(				DataUpShift_InValid),
							.InAccept(				DataUpShift_InReady),
							.OutData(			    DataUpShift_OutData),
							.OutValid(				DataUpShift_OutValid),
							.OutReady(				DataUpShift_OutReady));
							
	// FUNCTIONALITY: We output (U, L, D) tuples; we need to buffer whole bucket 
	// so that we can write back to DRAM in {Header, Payload} order
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				BktPSize_DRBursts))
				out_bkt_buf(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DataUpShift_OutData),
							.InValid(				DataUpShift_OutValid),
							.InAccept(				DataUpShift_OutReady),
							.OutData(				BucketBuf_OutData),
							.OutSend(				BucketBuf_OutValid),
							.OutReady(				BucketBuf_OutReady));

	assign	WritebackProcessingHeader =				BucketWritebackCtr < BktHSize_DRBursts;
	
	assign	UpShift_HeaderFlit =					{	{SpaceRemaining{1'b0}},
														HeaderUpShift_Leaves,
														HeaderUpShift_PAddrs,
														{BktHWaste_ValidBits{1'b0}},
														HeaderUpShift_ValidBits, 
														IVINITValue	};
	assign	UpShift_DRAMWriteData =					(WritebackProcessingHeader) ? UpShift_HeaderFlit : BucketBuf_OutData;

	assign	BucketWritebackValid =					(WritebackProcessingHeader & 	HeaderUpShift_OutValid) | 
													(~WritebackProcessingHeader & 	BucketBuf_OutValid);

	CountAlarm  #(  		.Threshold(             BktHSize_DRBursts + BktPSize_DRBursts))
				out_bkt_cnt(.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				BucketWritebackValid & DRAMWriteDataReady),
							.Count(					BucketWritebackCtr));
	
	assign	DRAMWriteData = 						UpShift_DRAMWriteData;
	assign	DRAMWriteDataValid = 					BucketWritebackValid;	

	assign	BucketBuf_OutReady =					~WritebackProcessingHeader & DRAMWriteDataReady;
	assign	HeaderUpShift_OutReady =				WritebackProcessingHeader & DRAMWriteDataReady;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
