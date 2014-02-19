
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		Stash
//	Desc:		The Path ORAM stash
//
//	General notes:
//		- Leaf orientation: least significant bit is root bucket
// 		- Writeback occurs in root -> leaf bucket order
//
//	Low level notes on PathORAMBackend operations:
//		Peak/ReadRmv/Read: As a path read occurs, the scan marks when it finds 
//		the block in question.  We can then perform update/read/remove on that 
//		block by interacting with StashCore.
//
//	TODO:
//		- return interface
//		- dummy/real accesses
//------------------------------------------------------------------------------
module Stash #(`include "PathORAM.vh", `include "Stash.vh") (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 						Clock, Reset,
	output						ResetDone,

	//--------------------------------------------------------------------------
	//	Commands
	//--------------------------------------------------------------------------
	
	input	[ORAML-1:0]			RemapLeaf,
	input	[ORAML-1:0]			AccessLeaf,
	input	[ORAMU-1:0]			AccessPAddr,
	
	/*	Controls the Return/Eviction interfaces 
		Command code:
			IsDummy ==	1		Command ==	X
			IsDummy ==	0		Perform command */
	input						AccessIsDummy,
	input	[BECMDWidth-1:0]	AccessCommand,
	
	/*	Start scanning the contents of the stash.  This should be pulsed as soon 
		as the PosMap is read.  The level command signals must be valid at this 
		time. */
	input						StartScan,
	
	/*	Start dumping data to AES encrypt in the NEXT cycle.  This should be 
		pulsed as soon as the last dummy block is decrypted */
	input						StartWriteback,		
		
	//--------------------------------------------------------------------------
	//	Data return interface (Stash -> LLC)
	//--------------------------------------------------------------------------
	
	output	[BEDWidth-1:0]		ReturnData,
	output	[ORAMU-1:0]			ReturnPAddr,
	output	[ORAML-1:0]			ReturnLeaf,
	output						ReturnDataOutValid,
	//input						ReturnDataOutReady,	// reads are block DMAs
	output						BlockReturnComplete,
	
	//--------------------------------------------------------------------------
	//	Data eviction interface (LLC -> Stash)
	//--------------------------------------------------------------------------	
	
	input	[BEDWidth-1:0]		EvictData,
	input	[ORAMU-1:0]			EvictPAddr,
	input	[ORAML-1:0]			EvictLeaf,
	input						EvictDataInValid,
	output						EvictDataInReady,
	output						BlockEvictComplete,	
	
	//--------------------------------------------------------------------------
	//	ORAM write interface (external memory -> Decryption -> stash)
	//--------------------------------------------------------------------------

	input	[BEDWidth-1:0]		WriteData,
	input	[ORAMU-1:0]			WritePAddr,
	input	[ORAML-1:0]			WriteLeaf,
	input						WriteInValid,
	output						WriteInReady,	
	/* Pulsed during the last cycle that a block is being written */
	output						BlockWriteComplete,
	
	//--------------------------------------------------------------------------
	//	ORAM read interface (stash -> encryption -> external memory)
	//--------------------------------------------------------------------------

	output	[BEDWidth-1:0]		ReadData,
	/* Set to DummyBlockAddress (see StashCore.constants) for dummy block. */
	output	[ORAMU-1:0]			ReadPAddr,
	output	[ORAML-1:0]			ReadLeaf,
	output						ReadOutValid,
	input						ReadOutReady,
	/* Pulsed during last cycle that a block is being read */
	output	 					BlockReadComplete,
	output						PathReadComplete,
	
	//--------------------------------------------------------------------------
	//	Status/Debugging interface
	//--------------------------------------------------------------------------

	output 						StashAlmostFull,
	output						StashOverflow,
	output	[StashEAWidth-1:0] 	StashOccupancy
	);

	//--------------------------------------------------------------------------
	//	Constants
	//-------------------------------------------------------------------------- 
	
	`include "StashLocal.vh"
	`include "BucketLocal.vh"
	`include "PathORAMBackendLocal.vh"
	
	localparam					OBWidth =				`log2(BlkSize_BEDChunks * StashOutBuffering) + 1;
	
	localparam					STWidth =				4,
								ST_Reset =				4'd0,
								ST_Idle = 				4'd1,
								ST_Scan1 =				4'd2,
								ST_PathRead =			4'd3,
								ST_Scan2 =				4'd4,
								ST_PathWriteback = 		4'd5,
								ST_Evict =				4'd6,
								ST_Turnaround1 =		4'd7,
								ST_Turnaround2 =		4'd8,
								ST_CoreSync =			4'd9;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	wire						PerAccessReset;

	wire 						StateTransition;

	reg		[STWidth-1:0]		CS, NS;
	wire						CSIdle, CSPathRead, CSPathWriteback, CSScan1, 
								CSScan2, CSEvict, CSTurnaround1, CSTurnaround2,
								CSCoreSync;
		
	wire						StartScan_pass, StartScan_set, StartScan_primed;
				
	wire						CoreResetDone;
	wire	[SCMDWidth-1:0]		CoreCommand;
	wire						PerformCoreHeaderUpdate, CoreHeaderRemove;
	wire						CoreCommandValid, CoreCommandReady;				
				
	wire	[BEDWidth-1:0]		Core_InData;
	wire	[ORAMU-1:0]			Core_InPAddr;
	wire	[ORAML-1:0]			Core_InLeaf;
	wire						Core_InValid, Core_InReady;			
	
	wire	[BEDWidth-1:0]		Core_OutData;
	wire	[ORAMU-1:0]			Core_OutPAddr;
	wire	[ORAML-1:0]			Core_OutLeaf;
	wire						Core_OutValid;
	
	wire	[ORAMU-1:0]			ScanPAddr;
	wire	[ORAML-1:0]			ScanLeaf;
	wire	[StashEAWidth-1:0]	ScanSAddr;
	wire						ScanLeafValid;

	wire	[StashEAWidth-1:0]	ScannedSAddr;
	wire						ScannedLeafAccepted, ScannedLeafValid;
	
	wire						StopReading, StopReading_Hold;
	wire						BlockReadComplete_InternalPre;
	reg							BlockReadComplete_Internal;
	
	wire						PathWriteback_Waiting;
	wire	[ScanTableAWidth-1:0] BlocksRead;
		
	wire	[SCWidth-1:0]		ScanCount;
	wire						SentScanCommand, Scan2Complete_Conservative;
	wire 						ScanTableResetDone;
	
	wire						PrepNextPeak, Core_AccessComplete, Top_AccessComplete;
	
	wire	[ScanTableAWidth-1:0]BlocksReading;
	wire	[StashEAWidth-1:0]	OutDMAAddr;	
	wire						InDMAValid, OutDMAValid;
	wire						PathWriteback_Tick;
	
	wire	[OBWidth-1:0]		OutBufferEmptyCount, OutBufferCount;	
	wire						OutBufferHasSpace, TickOutHeader, OutHeaderValid;
	wire						OutBufferInReady, OutHBufferInReady, OutBufferInValid;

	wire	[ORAML-1:0]			MappedLeaf;
	wire						CurrentLeafValid;
		
	wire						LookForBlock, FoundBlock;
	wire						ReturnInProgress;
	wire	[StashEAWidth-1:0]	CRUD_SAddr, CoreCommandSAddr;
	
	//--------------------------------------------------------------------------
	//	Debugging interface
	//--------------------------------------------------------------------------
	
	`ifdef SIMULATION
		reg [STWidth-1:0] CS_Delayed;
		wire BlockFound;
		
		initial begin
			if (StashOutBuffering < 1) begin
				$display("[%m @ %t] ERROR (usage): StashOutBuffering must be >= 1", $time);
				$stop;
			end
		end
	
		Register	#(	.Width(					1))
			found_block(.Clock(					Clock),
						.Reset(					Reset | CSIdle),
						.Set(					FoundBlock),
						.Enable(				1'b0),
						.In(					1'bx),
						.Out(					BlockFound));
		
		always @(posedge Clock) begin
			CS_Delayed <= CS;
			
			if (	(TickOutHeader & ~OutHeaderValid) |
					(OutBufferInValid & ~OutBufferInReady) |
					(OutBufferHInValid & ~OutHBufferInReady)	) begin
				$display("[%m @ %t] ERROR: Illegal signal combination (data will be lost)", $time);
				$stop;
			end
			
			if (	(~Core_InReady & CoreCommandValid & CoreCommandReady & (	(CoreCommand == SCMD_Push) | 
																				(CoreCommand == SCMD_Overwrite))) | 
					(~Core_OutValid & CoreCommandValid & CoreCommandReady & (	(CoreCommand == SCMD_Peak)))) begin
				$display("[%m @ %t] ERROR: Illegal command/data transaction (data will be lost)", $time);
				$stop;
			end
			
			if (	(WriteInValid & WriteInReady & BlockWriteComplete) &
					((^WriteLeaf === 1'bx) | (^WritePAddr === 1'bx))) begin
				$display("[%m @ %t] ERROR: writing block with X paddr/leaf", $time);
				$stop;
			end
			
			if (	(ReadOutValid & ReadOutReady & BlockReadComplete) &
					(ReadPAddr != DummyBlockAddress) & 
					((^ReadLeaf === 1'bx) | (^ReadPAddr === 1'bx))) begin
				$display("[%m @ %t] ERROR: reading block with X paddr/leaf", $time);
				$stop;
			end			
			
			if (CSTurnaround1 & LookForBlock & ~BlockFound) begin
				$display("[%m @ %t] ERROR: the FE block wasn't in ORAM/stash", $time);
				$stop;
			end
			
			if (LookForBlock & CSTurnaround1 & 
				core.StashH.Mem[CRUD_SAddr][ORAML+ORAMU-1:ORAML] != AccessPAddr) begin
				$display("[%m @ %t] ERROR: the block being accessed wasn't written to the stash", $time);
				$stop;
			end
			
			if (StashOverflow) begin
				$display("[%m] ERROR: stash overflowed");
				$stop;
			end
			
			if (CS_Delayed != CS) begin
				if (CSScan1)
					$display("[%m @ %t] Stash: start Scan1", $time);
				if (CSPathRead)
					$display("[%m @ %t] Stash: start PathRead", $time);
				if (CSScan2)
					$display("[%m @ %t] Stash: start Scan2", $time);
				if (CSPathWriteback)
					$display("[%m @ %t] Stash: start PathWriteback", $time);
			end
			
			if (PerAccessReset)
				$display("[%m @ %t] Stash *** Per-module reset *** (ORAM access should be complete)", $time);
				
			/* This is a nice sanity check, but we got rid of _actual ...
			if (~Scan2Complete_Actual & Scan2Complete_Conservative) begin
				$display("[%m @ %t] ERROR: scan took longer than worst-case time...", $time);
				$stop;
			end*/
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	State transitions & control logic
	//--------------------------------------------------------------------------

	assign	ResetDone =								CoreResetDone & ScanTableResetDone;
	assign	PerAccessReset =						Top_AccessComplete & Core_AccessComplete;
	
	assign	BlockEvictComplete =					CSEvict & CoreCommandReady;
	assign	BlockWriteComplete =					CSPathRead & CoreCommandReady;
	assign	BlockReadComplete_InternalPre =			(CSTurnaround1 | CSPathWriteback) & CoreCommandReady;
	assign	PathReadComplete =						PerAccessReset;
	
	assign 	StateTransition =						NS != CS;
	assign	CSIdle =								CS == ST_Idle;
	assign	CSPathRead = 							CS == ST_PathRead;
	assign	CSTurnaround1 =							CS == ST_Turnaround1;
	assign	CSTurnaround2 =							CS == ST_Turnaround2;
	assign	CSCoreSync =							CS == ST_CoreSync;
	assign	CSPathWriteback = 						CS == ST_PathWriteback;
	assign	CSScan1 = 								CS == ST_Scan1; 
	assign	CSScan2 = 								CS == ST_Scan2;
	assign	CSEvict =								CS == ST_Evict;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Reset;
		else CS <= 									NS;
		
		BlockReadComplete_Internal <=				BlockReadComplete_InternalPre;
	end
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Reset : 
				if (CoreResetDone) NS =				ST_Idle;
			ST_Idle :
				if (AccessStart) 
					NS =							ST_Scan1;
				else if (EvictDataInValid & AccessCommand == BECMD_Append)
					NS =							ST_Evict;
			ST_Scan1 :
				if (WriteInValid & SentScanCommand) 
					NS =			 				ST_PathRead;
				else if (StartWriteback) 
					NS = 							ST_Scan2;
			ST_PathRead :
				if (StartWriteback) 
					NS =							ST_Scan2;
			ST_Scan2 : 
				if (Scan2Complete_Conservative & SentScanCommand & OutBufferHasSpace) 
					NS = 							ST_Turnaround1;
			ST_Turnaround1 : 
				if (CoreCommandReady)
					NS =							ST_Turnaround2;
			ST_Turnaround2 : 
				if (CoreCommandReady)
					NS =							ST_CoreSync;
			ST_CoreSync :
				if (CoreCommandReady)
					NS =							ST_PathWriteback;
			ST_PathWriteback :
				if (PerAccessReset) 
					NS =							ST_Idle;
			ST_Evict :
				if (CoreCommandReady)
					NS =							ST_Idle;
		endcase
	end
		
	//--------------------------------------------------------------------------
	//	Input control & timing
	//--------------------------------------------------------------------------
	
	// Don't start the access until we are back in the Idle state; this ensures 
	// AccessLeaf is valid when the scan starts
	Register	#(				.Width(				1))
				scan_hold(		.Clock(				Clock),
								.Reset(				Reset | PerAccessReset),
								.Set(				StartScan),
								.Enable(			1'b0),
								.In(				1'bx),
								.Out(				StartScan_primed));
	assign	StartScan_pass = 						CSIdle & (StartScan | StartScan_primed);

	// Generate valid signals for this access
	Register	#(				.Width(				1))
				access_start(	.Clock(				Clock),
								.Reset(				Reset | PerAccessReset),
								.Set(				StartScan_pass),
								.Enable(			1'b0),
								.In(				1'bx),
								.Out(				StartScan_set));
	assign	AccessStart =							StartScan_set | StartScan_pass;
	
	//--------------------------------------------------------------------------
	//	Inner modules
	//--------------------------------------------------------------------------
	
	assign	CoreCommand =							(CSScan1 | CSScan2) ? 									SCMD_Dump :
													(CSPathRead | CSEvict) ? 								SCMD_Push :
													(CSTurnaround1 & AccessIsDummy) ? 						SCMD_Peak : // read something random
													(CSTurnaround1 & (AccessCommand == BECMD_Update)) ? 	SCMD_Overwrite :
													(CSTurnaround1 & (AccessCommand == BECMD_Read)) ? 		SCMD_Peak :
													(CSTurnaround1 & (AccessCommand == BECMD_ReadRmv)) ? 	SCMD_Peak :
													(CSTurnaround2) ? 										SCMD_UpdateHeader :
													(CSCoreSync) ?											SCMD_Sync :
													(CSPathWriteback) ? 									SCMD_Peak : 
																											{SCMDWidth{1'bx}};
							
	assign	CoreCommandSAddr =						(CSTurnaround1 | CSTurnaround2) ? CRUD_SAddr : OutDMAAddr;
	
	assign	Core_InPAddr = 							(CSEvict) ? 		EvictPAddr : 
													(CSTurnaround2) ? 	AccessPAddr : // this should match the old contents 
																		WritePAddr;
													
	assign	Core_InLeaf = 							(CSEvict) ? 		EvictLeaf : 
													(CSTurnaround2) ? 	RemapLeaf : 
																		WriteLeaf;
							
	assign	PerformCoreHeaderUpdate =				~AccessIsDummy & 
													(	(AccessCommand == BECMD_Update) | 
														(AccessCommand == BECMD_Read) |
														(AccessCommand == BECMD_ReadRmv));
	assign	CoreHeaderRemove =						~AccessIsDummy & (AccessCommand == BECMD_ReadRmv);
	
	assign 	CoreCommandValid =						CSPathRead | CSEvict |
													(CSScan1 & ~SentScanCommand) | 
													(CSScan2 & ~SentScanCommand) | 
													CSTurnaround1 | 
													CSTurnaround2 |
													CSCoreSync |
													(CSPathWriteback & OutDMAValid & ~PathWriteback_Waiting);
	
	assign	Core_InData = 							(CSEvict) ? EvictData 			: WriteData;
	assign	Core_InValid =							(CSEvict) ? EvictDataInValid 	: WriteInValid;
	assign	EvictDataInReady =						CSEvict & Core_InReady;
	assign	WriteInReady =							~CSEvict & Core_InReady;
													
	StashCore	#(			.StashCapacity(			StashCapacity),
							.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
							
				core(		.Clock(					Clock), 
							.Reset(					Reset),
							.PerAccessReset(		PerAccessReset),
							.ResetDone(				CoreResetDone),
						
							.InData(				Core_InData),
							.InValid(				Core_InValid),
							.InReady(				Core_InReady),

							.OutData(				Core_OutData),
							.OutPAddr(				Core_OutPAddr),
							.OutLeaf(				Core_OutLeaf),
							.OutValid(				Core_OutValid),

							.InSAddr(				CoreCommandSAddr),
							.InPAddr(				Core_InPAddr),
							.InLeaf(				Core_InLeaf),
							.InHeaderUpdate(		PerformCoreHeaderUpdate),
							.InHeaderRemove(		CoreHeaderRemove),
							.InCommand(				CoreCommand),
							.InCommandValid(		CoreCommandValid),
							.InCommandReady(		CoreCommandReady),
											
							.OutScanPAddr(			ScanPAddr),
							.OutScanLeaf(			ScanLeaf),
							.OutScanSAddr(			ScanSAddr),
							.OutScanValid(			ScanLeafValid),

							.InScanSAddr(			ScannedSAddr),
							.InScanAccepted(		ScannedLeafAccepted),
							.InScanValid(			ScannedLeafValid),
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		StashOccupancy),
							
							.PrepNextPeak(			PrepNextPeak),
							.SyncComplete(			Core_AccessComplete));

	// leaf remapping step
	assign	MappedLeaf =							(LookForBlock & FoundBlock) ? RemapLeaf : ScanLeaf;
	
	// don't try to push back blocks that we are removing
	assign	CurrentLeafValid =						~(LookForBlock & FoundBlock & CoreHeaderRemove) & AccessStart;
	
	StashScanTable #(		.StashCapacity(			StashCapacity),
							.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ)) 
							
				scan_table(	.Clock(					Clock),
							.Reset(					Reset),
							.PerAccessReset(		PerAccessReset),
							.ResetDone(				ScanTableResetDone),
							
							.CurrentLeaf(			AccessLeaf),
							.CurrentLeafValid(		CurrentLeafValid),
							
							.InScanLeaf(			MappedLeaf),
							.InScanPAddr(			ScanPAddr),
							.InScanSAddr(			ScanSAddr),
							.InScanValid(			ScanLeafValid),
							.OutScanSAddr(			ScannedSAddr),
							.OutScanAccepted(		ScannedLeafAccepted),
							.OutScanValid(			ScannedLeafValid),
						
							.InDMAAddr(				BlocksReading),
							.InDMAValid(			InDMAValid),
							.InDMAReset(			PathWriteback_Tick),
							.OutDMAAddr(			OutDMAAddr),
							.OutDMAValid(			OutDMAValid));	

	//--------------------------------------------------------------------------
	// Front-end command handling
	//--------------------------------------------------------------------------

	Register	#(			.Width(					1))
				CRUD_op(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Enable(				CSIdle & AccessStart),
							.In(					PerformCoreHeaderUpdate),
							.Out(					LookForBlock));

	assign	FoundBlock =							ScanLeafValid & (ScanPAddr == AccessPAddr);
	
	Register	#(			.Width(					StashEAWidth))
				block_addr(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				FoundBlock),
							.In(					ScanSAddr),
							.Out(					CRUD_SAddr));

	// We don't want to wait until the read operation finishes to start the next 
	// operation
	Register	#(			.Width(					1))
				ret_start(	.Clock(					Clock),
							.Reset(					Reset | BlockReturnComplete),
							.Set(					CSTurnaround1 & ~BlockReturnComplete),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ReturnInProgress));							

	assign	ReturnData =							Core_OutData;
	assign	ReturnPAddr =							Core_OutPAddr;
	assign	ReturnLeaf =							Core_OutLeaf;
	assign	ReturnDataOutValid =					ReturnInProgress & ~AccessIsDummy & Core_OutValid;
	assign	BlockReturnComplete =					ReturnInProgress & ~AccessIsDummy & BlockReadComplete_Internal;
	
	//--------------------------------------------------------------------------
	//	Scan control
	//--------------------------------------------------------------------------

	// count the worst-case scan latency (for security)
	Counter		#(			.Width(					SCWidth),
							.Limited(				1),
							.Limit(					ScanDelay))
				scan_count(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSScan1 | CSScan2),
							.In(					{SCWidth{1'bx}}),
							.Count(					ScanCount));
	
	Register	#(			.Width(					1))
				sent_cmd(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset | StateTransition),
							.Set(					CoreCommandValid & CoreCommandReady & (CSScan1 | CSScan2)),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					SentScanCommand));
	
	assign	Scan2Complete_Conservative =			CSScan2 & ScanCount == ScanDelay;
	
	//--------------------------------------------------------------------------
	//	Read control
	//--------------------------------------------------------------------------
	
	assign	PathWriteback_Tick =					CSPathWriteback & PrepNextPeak;
	assign	StopReading =							CSPathWriteback & ReadingLastBlock & PrepNextPeak;
	
	// ticks at start of block read
	Counter		#(			.Width(					ScanTableAWidth),
							.Limited(				1),
							.Limit(					BlocksOnPath - 1))
				rd_st_count(.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				PathWriteback_Tick),
							.In(					{ScanTableAWidth{1'bx}}),
							.Count(					BlocksReading));
	CountCompare #(			.Width(					ScanTableAWidth),
							.Compare(				BlocksOnPath - 1))
				rd_st_cmp(	.Count(					BlocksReading), 
							.TerminalCount(			ReadingLastBlock));							

	Register	#(			.Width(					1))
				stop_rd(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					StopReading),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					StopReading_Hold));	
					
	assign	InDMAValid =							CSPathWriteback & ~StopReading & ~StopReading_Hold;
					
	// ticks at end of block read
	Counter		#(			.Width(					ScanTableAWidth))
				rd_ret_count(.Clock(				Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSPathWriteback & BlockReadComplete_Internal),
							.In(					{ScanTableAWidth{1'bx}}),
							.Count(					BlocksRead));
	assign	Top_AccessComplete =					BlocksRead == BlocksOnPath;
							
	// Block-level backpressure for reads (due to random DRAM delays)
	Register	#(			.Width(					1))
				read_wait(	.Clock(					Clock),
							.Reset(					Reset | OutBufferHasSpace),
							.Set(					PathWriteback_Tick & ~OutBufferHasSpace),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					PathWriteback_Waiting));
							
	assign	Top_AccessComplete =					BlocksRead == BlocksOnPath;

	//--------------------------------------------------------------------------
	// Read interface buffering
	//--------------------------------------------------------------------------

	assign	OutBufferHasSpace =						OutBufferEmptyCount >= BlkSize_BEDChunks;

	assign	OutBufferInValid =						CSPathWriteback & Core_OutValid;
	assign	OutBufferHInValid =						CSPathWriteback & Core_OutValid & BlockReadComplete_Internal;
	
	assign	BlockReadComplete =						TickOutHeader & ReadOutValid & ReadOutReady;
	
	FIFORAM		#(			.Width(					BEDWidth),
							.Buffering(				BlkSize_BEDChunks * StashOutBuffering))
				out_P_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				Core_OutData),
							.InValid(				OutBufferInValid),
							.InAccept(				OutBufferInReady),
							.InEmptyCount(			OutBufferEmptyCount),
							.OutData(				ReadData),
							.OutSend(				ReadOutValid),
							.OutReady(				ReadOutReady));

	FIFORAM		#(			.Width(					ORAMU + ORAML),
							.Buffering(				StashOutBuffering))
				out_H_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{Core_OutPAddr, Core_OutLeaf}),
							.InValid(				OutBufferHInValid),
							.InAccept(				OutHBufferInReady),
							.OutData(				{ReadPAddr, ReadLeaf}),
							.OutSend(				OutHeaderValid),
							.OutReady(				TickOutHeader));		

	Counter		#(			.Width(					OBWidth))
				out_H_cnt(	.Clock(					Clock),
							.Reset(					Reset | BlockReadComplete),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				ReadOutValid & ReadOutReady),
							.In(					{OBWidth{1'bx}}),
							.Count(					OutBufferCount));
	CountCompare #(			.Width(					OBWidth),
							.Compare(				BlkSize_BEDChunks - 1))
				out_H_cmp(	.Count(					OutBufferCount), 
							.TerminalCount(			TickOutHeader));
							
	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

