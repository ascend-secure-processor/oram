
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		Stash
//	Desc:		The Path ORAM stash
//
//	NOTE #1:	This stash does not pre-empt its internal scan when the path 
//				read data arrives.  This is fine (= no performance penalty & no 
//				possibility to lose data even with pathological DRAM behavior) 
//				as long as we buffer the whole path OUTSIDE of the stash.
//
//	NOTE #2:
//		- Leaf orientation: least significant bit is root bucket
// 		- Writeback occurs in root -> leaf bucket order
//
//------------------------------------------------------------------------------
module Stash #(`include "PathORAM.vh", `include "Stash.vh") (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset,
	output					ResetDone,

	//--------------------------------------------------------------------------
	//	Commands
	//--------------------------------------------------------------------------
	
	input	[ORAML-1:0]		RemapLeaf,
	input	[ORAML-1:0]		AccessLeaf,
	input	[ORAMU-1:0]		AccessPAddr,
	
	/*	Controls the Return/Eviction interfaces 
		Command code:
			IsDummy ==	1		Command ==	X
			IsDummy ==	0		Perform command */
	input					AccessIsDummy,
	input	[BECMDWidth-1:0]AccessCommand,
	
	/*	Start scanning the contents of the stash.  This should be pulsed as soon 
		as the PosMap is read.  The level command signals must be valid at this 
		time. */
	input					StartScan,
	
	/*	Start dumping data to AES encrypt in the NEXT cycle.  This should be 
		pulsed as soon as the last dummy block is decrypted */
	input					StartWriteback,		
		
	//--------------------------------------------------------------------------
	//	Data return interface (Stash -> LLC)
	//--------------------------------------------------------------------------
	
	output	[BEDWidth-1:0]	ReturnData,
	output	[ORAMU-1:0]		ReturnPAddr,
	output	[ORAML-1:0]		ReturnLeaf,
	output					ReturnDataOutValid,
	//input					ReturnDataOutReady,	// reads are block DMAs
	output					BlockReturnComplete,
	
	//--------------------------------------------------------------------------
	//	Data eviction interface (LLC -> Stash)
	//--------------------------------------------------------------------------	
	
	input	[BEDWidth-1:0]	EvictData,
	input	[ORAMU-1:0]		EvictPAddr,
	input	[ORAML-1:0]		EvictLeaf,
	input					EvictDataInValid,
	output					EvictDataInReady,
	output					BlockEvictComplete,	
	
	//--------------------------------------------------------------------------
	//	Data update (dirty block update) interface (LLC -> Stash)
	//--------------------------------------------------------------------------	
	
	input	[BEDWidth-1:0]	UpdateData,
	input					UpdateDataInValid,
	output					UpdateDataInReady,
	output					BlockUpdateComplete,
	
	//--------------------------------------------------------------------------
	//	ORAM write interface (external memory -> Decryption -> stash)
	//--------------------------------------------------------------------------

	input	[BEDWidth-1:0]	WriteData,
	input	[ORAMU-1:0]		WritePAddr,
	input	[ORAML-1:0]		WriteLeaf,
	input					WriteInValid,
	output					WriteInReady,	
	/* Pulsed during the last cycle that a block is being written */
	output					BlockWriteComplete,
	
	//--------------------------------------------------------------------------
	//	ORAM read interface (stash -> encryption -> external memory)
	//--------------------------------------------------------------------------

	output	[BEDWidth-1:0]	ReadData,
	/* Set to DummyBlockAddress (see StashCore.constants) for dummy block. */
	output	[ORAMU-1:0]		ReadPAddr,
	output	[ORAML-1:0]		ReadLeaf,
	output					ReadOutValid,
	input					ReadOutReady,
	/* Pulsed during last cycle that a block is being read */
	output	 				BlockReadComplete,
	output					PathReadComplete,
	
	//--------------------------------------------------------------------------
	//	Status/Debugging interface
	//--------------------------------------------------------------------------

	output 					StashAlmostFull,
	output					StashOverflow,
	output	[SEAWidth-1:0] 	StashOccupancy,
	
	// Indicates that on a read/rm/update, the requested block wasn't found
	// THIS IS AN ERROR
	output					BlockNotFound,
	output					BlockNotFoundValid
	);

	//--------------------------------------------------------------------------
	//	Constants
	//-------------------------------------------------------------------------- 
	
	`include "StashLocal.vh"
	`include "BucketLocal.vh"
	`include "PathORAMBackendLocal.vh"
	
	localparam				OBWidth =				`log2(BlkSize_BEDChunks * StashOutBuffering) + 1;
	
	localparam				STWidth =				4,
							ST_Reset =				4'd0,
							ST_Idle = 				4'd1,
							ST_Scan =				4'd2,
							ST_PathRead =			4'd3,
							ST_PathWriteback = 		4'd4,
							ST_Evict =				4'd5,
							ST_Turnaround1 =		4'd6,
							ST_Turnaround2 =		4'd7,
							ST_CoreSync =			4'd8;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	wire					PerAccessReset;

	// Control
	
	reg		[STWidth-1:0]	CS, NS;
	wire					CSIdle, CSPathRead, CSPathWriteback, CSScan, 
							CSEvict, CSTurnaround1, CSTurnaround2,
							CSCoreSync;
	reg						CSTurnaround1_Delayed;
	wire					CSTurnaround1_FirstCycle;
	
	// Input timing
	
	wire					StartScan_Pass, StartScan_set, StartScan_Primed;
	wire					StartWriteback_Pass, StartWriteback_Primed;
				
	// Core interface
				
	wire					Core_ResetDone;
	wire	[SCMDWidth-1:0]	Core_Command;
	wire					Core_CommandValid, Core_CommandReady, Core_CommandComplete;				
	wire					Evict_CommandComplete;
	wire					PerformCoreHeaderUpdate, CoreHeaderRemove;
	
	wire	[BEDWidth-1:0]	Core_InData;
	wire	[ORAMU-1:0]		Core_InPAddr;
	wire	[ORAML-1:0]		Core_InLeaf;
	wire					Core_InValid, Core_InReady;			
	
	wire					TurnoverUpdate;
	
	wire	[BEDWidth-1:0]	Core_OutData;
	wire	[ORAMU-1:0]		Core_OutPAddr;
	wire	[ORAML-1:0]		Core_OutLeaf;
	wire					Core_OutValid;
	
	// ScanTable interface
	
	wire	[ORAMU-1:0]		Scan_PAddr;
	wire	[ORAML-1:0]		Scan_Leaf;
	wire	[SEAWidth-1:0]	Scan_SAddr;
	wire					Scan_Add, Scan_LeafValid;
	wire					Scan_Streaming;

	wire	[SEAWidth-1:0]	Scanned_SAddr;
	wire					Scanned_Add, Scanned_LeafAccepted, Scanned_LeafValid;
	wire					Scanned_Streaming;
	
	wire	[SEAWidth-1:0]	OutDMAAddr;
	wire					InDMAValid;
	wire					OutDMAValid, OutDMAReady;
	wire					OutDMALast;	
	
	// Scan control
	
	wire	[SCWidth-1:0]	ScanCount;
	wire					SentCoreCommand, ScanComplete_Conservative;
	wire 					ScanTableResetDone;	
	
	// Writeback control
	
	wire					BlockReadComplete_InternalPre;
	reg						BlockReadComplete_Internal;

	wire	[STAWidth-1:0]	BlocksReading;
	
	wire					PathWriteback_Waiting;
	wire	[STAWidth-1:0] 	BlocksRead;
	
	wire					Core_AccessComplete, Top_AccessComplete;
	
	wire					WritebackGate;
	wire					ScanTableReset;		
	
	// Read control
	
	wire	[OBWidth-1:0]	OutBufferEmptyCount, OutBufferCount;	
	wire					OutBufferHasSpace, TickOutHeader, OutHeaderValid;
	wire					OutBufferInReady, OutHBufferInReady, OutBufferInValid;

	// Frontend control
	
	wire	[ORAML-1:0]		MappedLeaf;
	wire					CurrentLeafValid;
	
	wire					LookForBlock, FoundBlock_ThisCycle, BlockWasFound;
	wire					FoundRemoveBlock;
	wire					ReturnInProgress;
	wire	[SEAWidth-1:0]	CRUD_SAddr, Core_CommandSAddr;
	
	//--------------------------------------------------------------------------
	//	Debugging
	//--------------------------------------------------------------------------
	
	assign	BlockNotFound = 						LookForBlock & ~BlockWasFound;
	assign	BlockNotFoundValid =					CSTurnaround1_FirstCycle;
	
	`ifdef SIMULATION
		reg [STWidth-1:0] CS_Delayed;
		
		initial begin
			if (StashOutBuffering < 1) begin
				$display("[%m @ %t] ERROR (usage): StashOutBuffering must be >= 1", $time);
				$stop;
			end
		end
		
		always @(posedge Clock) begin
			CS_Delayed <= CS;
			
			if (	(TickOutHeader & ~OutHeaderValid) |
					(OutBufferInValid & ~OutBufferInReady) |
					(OutBufferHInValid & ~OutHBufferInReady)	) begin
				$display("[%m @ %t] ERROR: Illegal signal combination (data will be lost)", $time);
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
			
			if (BlockNotFound & BlockNotFoundValid) begin
				$display("[%m @ %t] ERROR: the FE block wasn't in ORAM/stash", $time);
				if (StopOnBlockNotFound) $stop;
			end
			
			if (LookForBlock & BlockWasFound & CSTurnaround1 &
				core.StashH.Mem[CRUD_SAddr][ORAML-1:0] != AccessLeaf) begin
				$display("[%m @ %t] ERROR: the block being accessed didn't have correct leaf", $time);
				$stop;
			end
			
			if (LookForBlock & BlockWasFound & CSTurnaround1 &
				core.StashH.Mem[CRUD_SAddr][ORAML+ORAMU-1:ORAML] != AccessPAddr) begin
				$display("[%m @ %t] ERROR: the block being accessed didn't have correct PAddr", $time);
				$stop;
			end
			
			if (StashOverflow) begin
				$display("[%m] ERROR: stash overflowed");
				$stop;
			end
			
			/* The StashTestbench abuses this by illegally filling the stash.  Re-enable for BackendTestbench
			if (ScanComplete_Conservative & (Scanned_LeafValid | Scan_LeafValid)) begin
				$display("[%m] ERROR: the scan took longer than our _conservative_ estimate");
				$stop;
			end
			*/
			
			if (CS_Delayed != CS) begin
				if (CSScan)
					$display("[%m @ %t] Stash: start Scan", $time);
				if (CSPathRead)
					$display("[%m @ %t] Stash: start PathRead (leaf = %x, paddr = %x, dummy = %b)", $time, AccessLeaf, AccessPAddr, AccessIsDummy);
				if (CSTurnaround1)
					$display("[%m @ %t] Stash: start frontend operation", $time);
				if (CSPathWriteback)
					$display("[%m @ %t] Stash: start PathWriteback", $time);
			end
			
			if (PerAccessReset)
				$display("[%m @ %t] Stash ** Per-module reset ** (ORAM access should be complete)", $time);
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	State transitions & control logic
	//--------------------------------------------------------------------------

	assign	ResetDone =								Core_ResetDone & ScanTableResetDone;
	assign	PerAccessReset =						Top_AccessComplete & Core_AccessComplete;
	
	assign	BlockUpdateComplete =					TurnoverUpdate & 	Core_CommandComplete;
	assign	BlockEvictComplete =					CSEvict & 			Evict_CommandComplete;
	assign	BlockWriteComplete =					CSPathRead & 		Core_CommandComplete;
	assign	BlockReadComplete_InternalPre =			(CSTurnaround1 | CSPathWriteback) & Core_CommandComplete;
	assign	PathReadComplete =						PerAccessReset;
	
	assign	TurnoverUpdate =						~AccessIsDummy & CSTurnaround1 & (AccessCommand == BECMD_Update);
	
	assign	CSIdle =								CS == ST_Idle;
	assign	CSPathRead = 							CS == ST_PathRead;
	assign	CSTurnaround1 =							CS == ST_Turnaround1;
	assign	CSTurnaround2 =							CS == ST_Turnaround2;
	assign	CSCoreSync =							CS == ST_CoreSync;
	assign	CSPathWriteback = 						CS == ST_PathWriteback;
	assign	CSScan = 								CS == ST_Scan;
	assign	CSEvict =								CS == ST_Evict;
	
	assign	CSTurnaround1_FirstCycle =				CSTurnaround1 & CSTurnaround1_Delayed;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Reset;
		else CS <= 									NS;
		
		CSTurnaround1_Delayed <=					CSTurnaround1;
		BlockReadComplete_Internal <=				BlockReadComplete_InternalPre;
	end
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Reset : 
				if (Core_ResetDone) NS =			ST_Idle;
			ST_Idle :
				if (AccessStart) 
					NS =							ST_Scan;
				else if (EvictDataInValid & AccessCommand == BECMD_Append)
					NS =							ST_Evict;
			ST_Scan :
				if (ScanComplete_Conservative)
					NS =			 				ST_PathRead;
			ST_PathRead :
				if (StartWriteback_Pass & ~Scanned_Streaming) 
					NS =							ST_Turnaround1;
			ST_Turnaround1 : 
				if (Core_CommandComplete)
					NS =							ST_Turnaround2;
			ST_Turnaround2 : 
				if (Core_CommandComplete)
					NS =							ST_CoreSync;
			ST_CoreSync :
				if (Core_CommandComplete)
					NS =							ST_PathWriteback;
			ST_PathWriteback :
				if (PerAccessReset) 
					NS =							ST_Idle;
			ST_Evict :
				if (Evict_CommandComplete)
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
								.Out(				StartScan_Primed));
	assign	StartScan_Pass = 						CSIdle & (StartScan | StartScan_Primed);

	// Generate valid signals for this access
	Register	#(				.Width(				1))
				access_start(	.Clock(				Clock),
								.Reset(				Reset | PerAccessReset),
								.Set(				StartScan_Pass),
								.Enable(			1'b0),
								.In(				1'bx),
								.Out(				StartScan_set));
	assign	AccessStart =							StartScan_set | StartScan_Pass;
	
	Register	#(				.Width(				1))
				wb_hold(		.Clock(				Clock),
								.Reset(				Reset | PerAccessReset),
								.Set(				StartWriteback),
								.Enable(			1'b0),
								.In(				1'bx),
								.Out(				StartWriteback_Primed));	
	assign	StartWriteback_Pass = 					CSPathRead & (StartWriteback | StartWriteback_Primed);
	
	//--------------------------------------------------------------------------
	//	Inner modules
	//--------------------------------------------------------------------------
	
	assign	Core_Command =							(CSScan) ? 												SCMD_Dump :
													(CSPathRead | CSEvict) ? 								SCMD_Push :
													(CSTurnaround1 & AccessIsDummy) ? 						SCMD_Peak : // read something random
													(CSTurnaround1 & (AccessCommand == BECMD_Update)) ? 	SCMD_Overwrite :
													(CSTurnaround1 & (AccessCommand == BECMD_Read)) ? 		SCMD_Peak :
													(CSTurnaround1 & (AccessCommand == BECMD_ReadRmv)) ? 	SCMD_Peak :
													(CSTurnaround2) ? 										SCMD_UpdateHeader :
													(CSCoreSync) ?											SCMD_Sync :
													(CSPathWriteback) ? 									SCMD_Peak : 
																											{SCMDWidth{1'bx}};
							
	assign	Core_CommandSAddr =						(CSTurnaround1 | CSTurnaround2) ? CRUD_SAddr : OutDMAAddr;
	
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
														
	// Having BlockWasFound prevents us from removing blocks that aren't there.  
	// Handling this case is only important for debugging											
	assign	CoreHeaderRemove =						~AccessIsDummy & BlockWasFound & 
													(AccessCommand == BECMD_ReadRmv);
	
	Register	#(			.Width(					1))
				sent_cmd(	.Clock(					Clock),
							.Reset(					Reset | 
													ScanComplete_Conservative | 
													StartWriteback_Pass | 
													PerAccessReset | 
													(~CSEvict & Core_CommandComplete) |
													(CSEvict & Evict_CommandComplete)),
							.Set(					Core_CommandValid & Core_CommandReady),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					SentCoreCommand));	
	
	assign 	Core_CommandValid =						((CSEvict | CSScan | CSTurnaround1 | CSTurnaround2 | CSCoreSync) & ~SentCoreCommand) |
													  CSPathRead | // increases path write performance
													 (WritebackGate & OutDMAValid);
	
	// since UpdateData == EvictData most likely, this gets optimized away
	assign	Core_InData = 							(CSEvict) ? 		EvictData : 
													(TurnoverUpdate) ? 	UpdateData : 
																		WriteData;
	assign	Core_InValid =							(CSEvict) ? 		EvictDataInValid : 
													(TurnoverUpdate) ? 	UpdateDataInValid : 
																		WriteInValid;
																		
	assign	EvictDataInReady =						CSEvict & 						Core_InReady;
	assign	UpdateDataInReady =						TurnoverUpdate & 				Core_InReady;
	assign	WriteInReady =							~(CSEvict | TurnoverUpdate) & 	Core_InReady;
	
	StashCore	#(			.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC))
							
				core(		.Clock(					Clock), 
							.Reset(					Reset),
							.PerAccessReset(		PerAccessReset),
							.ResetDone(				Core_ResetDone),
						
							.InData(				Core_InData),
							.InValid(				Core_InValid),
							.InReady(				Core_InReady),

							.OutData(				Core_OutData),
							.OutPAddr(				Core_OutPAddr),
							.OutLeaf(				Core_OutLeaf),
							.OutValid(				Core_OutValid),

							.InSAddr(				Core_CommandSAddr),
							.InPAddr(				Core_InPAddr),
							.InLeaf(				Core_InLeaf),
							.InHeaderUpdate(		PerformCoreHeaderUpdate),
							.InHeaderRemove(		CoreHeaderRemove),
							.InCommand(				Core_Command),
							.InCommandValid(		Core_CommandValid),
							.InCommandReady(		Core_CommandReady),
							.InCommandComplete(		Core_CommandComplete),
							
							.OutScanPAddr(			Scan_PAddr),
							.OutScanLeaf(			Scan_Leaf),
							.OutScanSAddr(			Scan_SAddr),
							.OutScanAdd(			Scan_Add),
							.OutScanValid(			Scan_LeafValid),
							.OutScanStreaming(		Scan_Streaming),
							
							.InScanSAddr(			Scanned_SAddr),
							.InScanAccepted(		Scanned_LeafAccepted),
							.InScanAdd(				Scanned_Add),
							.InScanValid(			Scanned_LeafValid),
							.InScanStreaming(		Scanned_Streaming),
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		StashOccupancy),
							
							.CancelPushCommand(		StartWriteback_Pass),
							.CancelPeakCommand(		OutDMALast),
							.SyncComplete(			Core_AccessComplete));

	// leaf remapping step
	assign	MappedLeaf =							(LookForBlock & FoundBlock_ThisCycle) ? RemapLeaf : Scan_Leaf;
	
	// don't try to push back blocks that we are removing
	assign	FoundRemoveBlock =						(LookForBlock & FoundBlock_ThisCycle) & (AccessCommand == BECMD_ReadRmv);
	assign	CurrentLeafValid =						~FoundRemoveBlock & AccessStart;
	
	StashScanTable #(		.Overclock(				Overclock),
							.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC)) 
							
				scan_table(	.Clock(					Clock),
							.Reset(					Reset),
							.PerAccessReset(		ScanTableReset),
							.AccessComplete(		PerAccessReset),
							.ResetDone(				ScanTableResetDone),
							
							.CurrentLeaf(			AccessLeaf),
							.CurrentLeafValid(		CurrentLeafValid),
							
							.InScanLeaf(			MappedLeaf),
							.InScanPAddr(			Scan_PAddr),
							.InScanSAddr(			Scan_SAddr),
							.InScanAdd(				Scan_Add),
							.InScanValid(			Scan_LeafValid),
							.InScanStreaming(		Scan_Streaming),
							
							.OutScanSAddr(			Scanned_SAddr),
							.OutScanAccepted(		Scanned_LeafAccepted),
							.OutScanAdd(			Scanned_Add),
							.OutScanValid(			Scanned_LeafValid),
							.OutScanStreaming(		Scanned_Streaming),
							
							.InDMAAddr(				BlocksReading),
							.InDMAValid(			InDMAValid),
							
							.OutDMAAddr(			OutDMAAddr),
							.OutDMAValid(			OutDMAValid),
							.OutDMAReady(			OutDMAReady),
							.OutDMALast(			OutDMALast));

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

	assign	FoundBlock_ThisCycle =					Scan_LeafValid & (Scan_PAddr == AccessPAddr);
	
	Register	#(			.Width(					SEAWidth))
				block_addr(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				FoundBlock_ThisCycle),
							.In(					Scan_SAddr),
							.Out(					CRUD_SAddr));

	// only needed for debugging
	Register	#(			.Width(					1))
				found_block(.Clock(					Clock),
							.Reset(					Reset | CSIdle),
							.Set(					FoundBlock_ThisCycle),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					BlockWasFound));
	
	// We don't want to wait until the read operation finishes to start the next 
	// operation
	Register	#(			.Width(					1))
				ret_start(	.Clock(					Clock),
							.Reset(					Reset | BlockReturnComplete),
							.Set(					CSTurnaround1 & PerformCoreHeaderUpdate & BlockWasFound & ~BlockReturnComplete),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ReturnInProgress));							

	assign	ReturnData =							Core_OutData;
	assign	ReturnPAddr =							Core_OutPAddr;
	assign	ReturnLeaf =							Core_OutLeaf;
	assign	ReturnDataOutValid =					ReturnInProgress & Core_OutValid;
	assign	BlockReturnComplete =					ReturnInProgress & BlockReadComplete_Internal;
	
	//--------------------------------------------------------------------------
	//	Intra-access waiting
	//--------------------------------------------------------------------------

	// FUNCTIONALITY: scan table latency will delay updating StashOccupancy
	generate if (Overclock) begin:DELAY_EVICT
		ShiftRegister #(	.PWidth(				ScanTableLatency),
							.SWidth(				1))
				evict_cmpl(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				1'b1), 
							.SIn(					Core_CommandComplete), 
							.SOut(					Evict_CommandComplete));
	end else begin:PASS_EVICT
		assign	Evict_CommandComplete =				Core_CommandComplete;
	end endgenerate
	
	// SECURITY: count the worst-case scan latency
	Counter		#(			.Width(					SCWidth),
							.Limited(				1),
							.Limit(					ScanDelay))
				scan_count(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSScan),
							.In(					{SCWidth{1'bx}}),
							.Count(					ScanCount));
	
	assign	ScanComplete_Conservative =				CSScan & ScanCount == ScanDelay;
	
	//--------------------------------------------------------------------------
	//	Read control
	//--------------------------------------------------------------------------
	
	assign	ScanTableReset =						CSPathWriteback & BlocksReading == 0;
	
	assign	InDMAValid =							CSPathWriteback & ~ReadingLastBlock;
	
	// NOTE: don't apply WritebackGate to this signal (we need to tick down the 
	// scan table FIFO properly ...)
	assign	OutDMAReady =							Core_CommandComplete;
	
	// which block are we currently writing back?
	Counter		#(			.Width(					STAWidth))
				rd_st_cnt(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSPathWriteback & ~ReadingLastBlock),
							.In(					{STAWidth{1'bx}}),
							.Count(					BlocksReading));
	CountCompare #(			.Width(					STAWidth),
							.Compare(				BlocksOnPath))
				rd_st_cmp(	.Count(					BlocksReading), 
							.TerminalCount(			ReadingLastBlock));
					
	// ticks at end of block read
	Counter		#(			.Width(					STAWidth))
				rd_ret_cnt(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSPathWriteback & BlockReadComplete_Internal),
							.In(					{STAWidth{1'bx}}),
							.Count(					BlocksRead));
	CountCompare #(			.Width(					STAWidth),
							.Compare(				BlocksOnPath))
				rd_ret_cmp(	.Count(					BlocksRead), 
							.TerminalCount(			Top_AccessComplete));

	// Block-level backpressure for reads (due to random DRAM delays)
	Register	#(			.Width(					1))
				read_wait(	.Clock(					Clock),
							.Reset(					Reset | OutBufferHasSpace),
							.Set(					~OutBufferHasSpace),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					PathWriteback_Waiting));
							
	assign	WritebackGate = 						CSPathWriteback & ~PathWriteback_Waiting;	
							
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

