
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		Stash
//	Desc:		The Path ORAM stash.  This module provides interfaces for both 
//				the path read/writeback operations and also frontend update/read
//				/read-remove/append operations.
//
//	NOTE #1:	This stash does not pre-empt its internal scan when the path 
//				read data arrives.  This is fine (no possibility to lose data 
//				even with pathological DRAM behavior) as long as we buffer the 
//				whole path OUTSIDE of the stash.  This won't cause performance 
//				penalty unless ORAMC is large (> 60; where 60 is a reasonable 
//				estimate for the AES/etc module's latency).
//
//	NOTE #2:	Leaf orientation: least significant bit is root bucket.
// 				Writeback occurs in root -> leaf bucket order.
//------------------------------------------------------------------------------
module Stash(
  	Clock, Reset,
	ResetDone,

	IsIdle,
	
	RemapLeaf, AccessLeaf, AccessPAddr, AccessMAC,
	AccessIsDummy, AccessCommand,
	StartAppend, StartScan, AccessSkipsWriteback, StartWriteback,
		
	ReturnData, ReturnPAddr, ReturnLeaf, ReturnMAC,
	ReturnDataOutValid, BlockReturnComplete,
	
	EvictData, EvictPAddr, EvictLeaf, EvictMAC,
	EvictDataInValid, EvictDataInReady, BlockEvictComplete,	
	
	UpdateData, 
	UpdateDataInValid, UpdateDataInReady, BlockUpdateComplete,
 
	WriteData, WritePAddr, WriteLeaf, WriteMAC,
	WriteInValid, WriteInReady, BlockWriteComplete,
	
	ReadData, ReadPAddr, ReadLeaf, ReadMAC,
	ReadOutValid, ReadOutReady, BlockReadComplete, PathReadComplete,
	
	StashAlmostFull, StashOverflow, StashOccupancy,
	
	JTAG_StashCore, JTAG_Stash
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//-------------------------------------------------------------------------- 
	
	`include "PathORAM.vh"
	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "CommandsLocal.vh"
	`include "StashLocal.vh"
	
	`include "DMLocal.vh"
	`include "JTAG.vh"
			
	parameter				// improves throughput for path writeback operations
							// [if == 2, throughput will be <= 50%, == 3, 100% is possible, > 3 for very unpredictable DRAM]
							StashOutBuffering =		3,
								
							// When we simulate, should we fail if we are looking for a block but cannot find it?
							// KEEP THIS DEFAULTED TO 1
							StopOnBlockNotFound = 	1;

	parameter				ORAMUValid = 			ORAML + 3; // Note: +3 assumes 50% utilization at Z=4

	localparam				OBWidth =				`log2(BlkSize_BEDChunks * StashOutBuffering + 1);		
		
	localparam				STWidth =				4,
							ST_Reset =				4'd0,
							ST_Idle = 				4'd1,
							ST_Scan =				4'd2,
							ST_PathRead =			4'd3,
							ST_PathWriteback = 		4'd4,
							ST_Evict =				4'd5,
							ST_Turnaround1 =		4'd6,
							ST_Turnaround2 =		4'd7,
							ST_CoreSync =			4'd8,
							ST_ROReset =			4'd9,
							ST_Error =				4'd10;
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	output					ResetDone;

	//--------------------------------------------------------------------------
	//	Commands
	//--------------------------------------------------------------------------
	
	output					IsIdle;
	
	input	[ORAML-1:0]		RemapLeaf;
	input	[ORAML-1:0]		AccessLeaf;
	input	[ORAMU-1:0]		AccessPAddr;
	input	[ORAMH-1:0]		AccessMAC;
	/*	Controls the Return/Eviction interfaces 
		Command code:
			IsDummy ==	1		Command ==	X
			IsDummy ==	0		Perform command */
	input					AccessIsDummy;
	input					AccessSkipsWriteback;
	input	[BECMDWidth-1:0]AccessCommand;
	
	input					StartAppend;
	
	/*	Start scanning the contents of the stash.  This should be pulsed as soon 
		as the PosMap is read.  The level command signals must be valid at this 
		time. */
	input					StartScan;
	
	/*	Start dumping data to AES encrypt in the NEXT cycle.  This should be 
		pulsed as soon as the last dummy block is decrypted */
	input					StartWriteback;		
		
	//--------------------------------------------------------------------------
	//	Data return interface (Stash -> LLC)
	//--------------------------------------------------------------------------
	
	output	[BEDWidth-1:0]	ReturnData;
	output	[ORAMU-1:0]		ReturnPAddr;
	output	[ORAML-1:0]		ReturnLeaf;
	output	[ORAMH-1:0]		ReturnMAC;
	output					ReturnDataOutValid;
	//input					ReturnDataOutReady;	// reads are block DMAs
	output					BlockReturnComplete;
	
	//--------------------------------------------------------------------------
	//	Data eviction interface (LLC -> Stash)
	//--------------------------------------------------------------------------	
	
	input	[BEDWidth-1:0]	EvictData;
	input	[ORAMU-1:0]		EvictPAddr;
	input	[ORAML-1:0]		EvictLeaf;
	input	[ORAMH-1:0]		EvictMAC;
	input					EvictDataInValid;
	output					EvictDataInReady;
	output					BlockEvictComplete;	
	
	//--------------------------------------------------------------------------
	//	Data update (dirty block update) interface (LLC -> Stash)
	//--------------------------------------------------------------------------	
	
	input	[BEDWidth-1:0]	UpdateData;
	input					UpdateDataInValid;
	output					UpdateDataInReady;
	output					BlockUpdateComplete;
	
	//--------------------------------------------------------------------------
	//	ORAM write interface (external memory -> Decryption -> stash)
	//--------------------------------------------------------------------------

	input	[BEDWidth-1:0]	WriteData;
	input	[ORAMU-1:0]		WritePAddr;
	input	[ORAML-1:0]		WriteLeaf;
	input	[ORAMH-1:0]		WriteMAC;
	input					WriteInValid;
	output					WriteInReady;	
	/* Pulsed during the last cycle that a block is being written */
	output					BlockWriteComplete;
	
	//--------------------------------------------------------------------------
	//	ORAM read interface (stash -> encryption -> external memory)
	//--------------------------------------------------------------------------

	output	[BEDWidth-1:0]	ReadData;
	/* Set to DummyBlockAddress (see StashCore.constants) for dummy block. */
	output	[ORAMU-1:0]		ReadPAddr;
	output	[ORAML-1:0]		ReadLeaf;
	output	[ORAMH-1:0]		ReadMAC;
	output					ReadOutValid;
	input					ReadOutReady;
	/* Pulsed during last cycle that a block is being read */
	output	 				BlockReadComplete;
	output					PathReadComplete;
	
	//--------------------------------------------------------------------------
	//	Status/Debugging interface
	//--------------------------------------------------------------------------

	output 					StashAlmostFull;
	output					StashOverflow;
	output	[SEAWidth-1:0] 	StashOccupancy;
	
	output	[JTWidth_StashCore-1:0] JTAG_StashCore;
	output	[JTWidth_Stash-1:0] JTAG_Stash;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	wire					PerAccessReset;
	wire					AccessStarted; 

	// Control
	
	(* mark_debug = "TRUE" *)	reg		[STWidth-1:0]	CS, NS;
	wire					CSIdle, CSPathRead, CSPathWriteback, CSScan, 
							CSEvict, CSTurnaround1, CSTurnaround2,
							CSCoreSync, CSROReset;
	reg						CSTurnaround1_Delayed;
	wire					CSTurnaround1_FirstCycle;
	
	wire 					NormalWriteback, KillWriteback;

	// Input timing
	
	wire					StartScan_Pass, StartScan_Set, StartScan_Primed;
	wire					StartWriteback_Pass, StartWriteback_Primed;
				
	// Core interface
				
	wire					Core_ResetDone;
	wire	[SCMDWidth-1:0]	Core_Command;
	wire					Core_CommandValid, Core_CommandReady, Core_CommandComplete;
	wire					PerformReturnData, PerformCoreHeaderUpdate, CoreHeaderRemove;
	
	wire	[BEDWidth-1:0]	Core_InData;
	wire	[ORAMU-1:0]		Core_InPAddr;
	wire	[ORAML-1:0]		Core_InLeaf;
	wire	[ORAMH-1:0]		Core_InMAC;
	wire					Core_InValid, Core_InReady;			
	
	wire					TurnoverUpdate;
	
	wire	[BEDWidth-1:0]	Core_OutData;
	wire	[ORAMU-1:0]		Core_OutPAddr;
	wire	[ORAML-1:0]		Core_OutLeaf;
	wire	[ORAMH-1:0]		Core_OutMAC;
	wire					Core_OutValid;
	
	// ScanTable interface
	
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]		Scan_PAddr; 
	(* mark_debug = "TRUE" *)	wire	[ORAML-1:0]		Scan_Leaf;
	(* mark_debug = "TRUE" *)	wire	[SEAWidth-1:0]	Scan_SAddr;
	(* mark_debug = "TRUE" *)	wire					Scan_Add, Scan_LeafValid, Scan_Done;
	(* mark_debug = "TRUE" *)	wire					Scan_Streaming;

	wire	[SEAWidth-1:0]	Scanned_SAddr;
	wire					Scanned_Add, Scanned_LeafAccepted, Scanned_LeafValid, Scanned_Done;
	wire					Scanned_Streaming;
	
	wire	[SEAWidth-1:0]	OutDMAAddr;
	wire					InDMAValid;
	wire					OutDMAValid_Pre, OutDMAValid, OutDMAReady;
	
	// Scan control
	
	wire	[SCWidth-1:0]	ScanCount;
	wire					SentCoreCommand, ScanComplete_Conservative;
	wire 					ScanTableResetDone;	
	
	// Writeback control

	wire					ReadingLastBlock;	
	wire					BlockReadComplete_Internal;

	wire	[STAP1Width-1:0] BlocksReading;
	wire	[STAP1Width-1:0] BlocksRead;
	
	wire					Core_AccessComplete, Top_AccessComplete;

	wire					ScanTableReset;		
	
	// Read control
	
	wire					OutSpaceGate;
	
	wire	[OBWidth-1:0]	OutBufferSpace, OutBufferCount;	
	wire					OutBufferInValid, OutBufferInReady;
	wire					TickOutHeader, BlockReadCommit;
	
	wire	[SHDWidth-1:0]	OutHBufferDataIn, OutHBufferDataOut;
	
	wire					OutHBufferInValid, OutHBufferInReady;
	wire					OutHeaderValid;
	
	// Frontend control
	
	wire	[ORAML-1:0]		MappedLeaf;
	wire					IsWritebackCandidate;
	
	wire					LookForBlock, FoundBlock_ThisCycle, BlockWasFound;
	wire					FoundRemoveBlock;
	wire					ReturnInProgress;
	wire	[SEAWidth-1:0]	CRUD_SAddr, Core_CommandSAddr;
	
	// Debugging
	
	(* mark_debug = "TRUE" *)	wire					BogusU, BlockNotFound, BlockNotFoundValid;	
	
	(* mark_debug = "TRUE" *)	wire					ERROR_BlockNotFound, ERROR_ISC1, ERROR_ISC2, ERROR_ISC3, ERROR_StashOverflow, ERROR_ISC4, ERROR_BOGUSU, ERROR_StashOverflowConservative, ERROR_Stash;
	
	//--------------------------------------------------------------------------
	//	Initial state
	//--------------------------------------------------------------------------	
	
	`ifdef FPGA
		initial begin
			CS = ST_Reset;
		end
	`endif	
	
	//--------------------------------------------------------------------------
	//	Debugging
	//--------------------------------------------------------------------------
	
	assign	BlockNotFound = 						LookForBlock & ~BlockWasFound;
	assign	BlockNotFoundValid =					CSTurnaround1_FirstCycle;
	
	assign	BogusU =								Scan_LeafValid && |Scan_PAddr[ORAMU-1:ORAMUValid];
	
	Register1b 	errno1(Clock, Reset, StopOnBlockNotFound && BlockNotFound && BlockNotFoundValid, 	ERROR_BlockNotFound); 	
	Register1b 	errno2(Clock, Reset, BlockReadCommit & ~OutHeaderValid, 							ERROR_ISC1);	
	Register1b 	errno3(Clock, Reset, OutBufferInValid & ~OutBufferInReady, 							ERROR_ISC2);
	Register1b 	errno4(Clock, Reset, OutHBufferInValid & ~OutHBufferInReady, 						ERROR_ISC3);
	Register1b 	errno5(Clock, Reset, StashOverflow, 												ERROR_StashOverflow);
	Register1b 	errno6(Clock, Reset, ScanComplete_Conservative & (Scanned_LeafValid | Scan_LeafValid), ERROR_ISC4);
	Register1b 	errno7(Clock, Reset, BogusU, 														ERROR_BOGUSU);
	Register1b 	errno8(Clock, Reset, CSIdle && StashOccupancy > ORAMC,								ERROR_StashOverflowConservative);
	
	Register1b 	errANY(Clock, Reset, ERROR_BlockNotFound | ERROR_ISC1 | ERROR_ISC2 | ERROR_ISC3 | ERROR_ISC4 | ERROR_StashOverflow | ERROR_BOGUSU | ERROR_StashOverflowConservative, ERROR_Stash);

	assign	JTAG_Stash =							{
														ERROR_BlockNotFound, 
														ERROR_ISC1, 
														ERROR_ISC2, 
														ERROR_ISC3, 
														ERROR_ISC4, 
														ERROR_StashOverflow, 
														ERROR_BOGUSU, 
														ERROR_StashOverflowConservative
													};
	
	// TODO: add assertion to check that _every_ real block written to stash has a valid common subpath with the current leaf
	
	`ifdef SIMULATION
		reg [STWidth-1:0] CS_Delayed;
		
		initial begin
			if (StashOutBuffering < 2) begin
				$display("[%m @ %t] ERROR (usage): StashOutBuffering must be >= 2", $time);
				$finish;
			end
		end
		
		always @(posedge Clock) begin
			CS_Delayed <= CS;
			
			if (ERROR_ISC1) begin
				$display("[%m @ %t] ERROR: Illegal signal combination 1 (HEADER lost)", $time);
				$finish;			
			end
			if (ERROR_ISC2) begin
				$display("[%m @ %t] ERROR: Illegal signal combination 2 (DATA buffer overflow)", $time);
				$finish;			
			end
			if (ERROR_ISC3) begin
				$display("[%m @ %t] ERROR: Illegal signal combination 3 (HEADER buffer overflow)", $time);
				$finish;			
			end			

			if (	(WriteInValid & WriteInReady & BlockWriteComplete) &
					((^WriteLeaf === 1'bx) | (^WritePAddr === 1'bx))) begin
				$display("[%m @ %t] ERROR: writing block with X paddr/leaf", $time);
				$finish;
			end
			
			if (	(ReadOutValid & ReadOutReady & BlockReadComplete) &
					(ReadPAddr != DummyBlockAddress) & 
					((^ReadLeaf === 1'bx) | (^ReadPAddr === 1'bx))) begin
				$display("[%m @ %t] ERROR: reading block with X paddr/leaf", $time);
				$finish;
			end			
			
			if (ERROR_BlockNotFound) begin
				$display("[%m @ %t] ERROR: the FE block wasn't in ORAM/stash", $time);
				if (StopOnBlockNotFound) $finish;
			end
			
	`ifndef SIMULATION_ASIC	
			if (LookForBlock & BlockWasFound & CSTurnaround1 &
				core.StashH.BEHAVIORAL.Mem[CRUD_SAddr][ORAML-1:0] != AccessLeaf) begin
				$display("[%m @ %t] ERROR: the block being accessed didn't have correct leaf", $time);
				$finish;
			end
			
			if (LookForBlock & BlockWasFound & CSTurnaround1 &
				core.StashH.BEHAVIORAL.Mem[CRUD_SAddr][ORAML+ORAMU-1:ORAML] != AccessPAddr) begin
				$display("[%m @ %t] ERROR: the block being accessed didn't have correct PAddr", $time);
				$finish;
			end
	`endif
	
			if (ERROR_StashOverflow) begin
				$display("[%m] ERROR: stash overflowed");
				$finish;
			end
			
			/* The StashTestbench abuses this by illegally filling the stash.  Re-enable for BackendTestbench */
			if (ERROR_ISC4) begin
				$display("[%m] ERROR: the scan took longer than our _conservative_ estimate");
				$finish;
			end
			
			if (ERROR_BOGUSU) begin
				$display("[%m] ERROR: tried to scan a block with a bogus PAddr");
				$finish;			
			end
			
			if (ERROR_StashOverflowConservative) begin
				$display("[%m] ERROR: we have too many blocks in the stash during an idle period");
				$finish;				
			end
			
			if (CS_Delayed != CS) begin
				if (CSScan)
					$display("[%m @ %t] Stash: start Scan", $time);
				if (CSPathRead)
					$display("[%m @ %t] Stash: start PathRead (cmd = %d, leaf = %x, paddr = %x, dummy = %b, RO access = %b)", $time, AccessCommand, AccessLeaf, AccessPAddr, AccessIsDummy, AccessSkipsWriteback);
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
	assign	PerAccessReset =						CSROReset | (Top_AccessComplete & Core_AccessComplete);
	
	assign	IsIdle =								CSIdle;
	
	assign	BlockUpdateComplete =					TurnoverUpdate & Core_CommandComplete;
	
	// FUNCTIONALITY: scan table latency will delay updating StashOccupancy
	generate if (Overclock) begin:DELAY_EVICT
		ShiftRegister #(	.PWidth(				ScanTableLatency),
							.SWidth(				1))
				evict_cmpl(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				1'b1), 
							.SIn(					CSEvict & Core_CommandComplete), 
							.SOut(					BlockEvictComplete));
	end else begin:PASS_EVICT
		assign	BlockEvictComplete =				CSEvict & Core_CommandComplete;
	end endgenerate	
	
	assign	BlockWriteComplete =					CSPathRead & 						Core_CommandComplete;
	assign	BlockReadComplete_Internal =			(CSTurnaround1 | CSPathWriteback) & Core_CommandComplete;
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
	assign	CSROReset =								CS == ST_ROReset;
	
	assign	CSTurnaround1_FirstCycle =				CSTurnaround1 & CSTurnaround1_Delayed;
	
	assign	NormalWriteback = 						CSTurnaround2 & Core_CommandComplete & ~AccessSkipsWriteback;
	assign	KillWriteback = 						CSTurnaround2 & Core_CommandComplete & AccessSkipsWriteback;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Reset;
		else CS <= 									NS;
		
		CSTurnaround1_Delayed <=					CSTurnaround1;
	end
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Reset : 
				if (Core_ResetDone) NS =			ST_Idle;
			ST_Idle :
				if (ERROR_Stash)
					NS =							ST_Error;
				else if (AccessStarted) 
					NS =							ST_Scan;
				else if (StartAppend)
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
				if (NormalWriteback)
					NS =							ST_CoreSync;
				else if (KillWriteback)
					NS =							ST_ROReset;
			ST_CoreSync :
				if (Core_CommandComplete)
					NS =							ST_PathWriteback;			
			ST_PathWriteback :
				if (PerAccessReset) 
					NS =							ST_Idle;
			ST_Evict :
				if (BlockEvictComplete)
					NS =							ST_Idle;
			ST_ROReset :
				NS =								ST_Idle;
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
	assign	StartScan_Pass = 						CSIdle & (StartScan | StartScan_Primed); // TODO this is a bit of an overdesign now ... StashTop won't send StartScan at wrong times anymore.
	
	// Generate valid signals for this access
	Register	#(				.Width(				1))
				access_start(	.Clock(				Clock),
								.Reset(				Reset | PerAccessReset),
								.Set(				StartScan_Pass),
								.Enable(			1'b0),
								.In(				1'bx),
								.Out(				StartScan_Set));
	assign	AccessStarted =							StartScan_Set | StartScan_Pass; 
	
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
													(CSPathRead | CSEvict) ? 								SCMD_Append :
													(CSTurnaround1 & AccessIsDummy) ? 						SCMD_Read : // read something random
													(CSTurnaround1 & (AccessCommand == BECMD_Update)) ? 	SCMD_Update :
													(CSTurnaround1 & (AccessCommand == BECMD_Read)) ? 		SCMD_Read :
													(CSTurnaround1 & (AccessCommand == BECMD_ReadRmv)) ? 	SCMD_Read :
													(CSTurnaround2) ? 										SCMD_UpdateHeader :
													(CSCoreSync) ?											SCMD_Sync :
													(CSPathWriteback) ? 									SCMD_Read : 
																											{SCMDWidth{1'bx}};
							
	assign	Core_CommandSAddr =						(CSTurnaround1 | CSTurnaround2) ? CRUD_SAddr : OutDMAAddr;
	
	assign	Core_InPAddr = 							(CSEvict) ? 		EvictPAddr : 
													(CSTurnaround2) ? 	AccessPAddr : // this should match the old contents 
																		WritePAddr;
													
	assign	Core_InLeaf = 							(CSEvict) ? 		EvictLeaf : 
													(CSTurnaround2) ? 	RemapLeaf : 
																		WriteLeaf;
	
	assign	Core_InMAC =							(CSEvict) ? 		EvictMAC : 
													(CSTurnaround2) ? 	AccessMAC : 
																		WriteMAC;
	
	assign	PerformCoreHeaderUpdate =				AccessStarted & ~AccessIsDummy & 
													(	(AccessCommand == BECMD_Update) | 
														(AccessCommand == BECMD_Read) |
														(AccessCommand == BECMD_ReadRmv));
									
	assign	PerformReturnData =						AccessStarted & ~AccessIsDummy & 
													(	(AccessCommand == BECMD_Read) |
														(AccessCommand == BECMD_ReadRmv));
									
	// Having BlockWasFound prevents us from removing blocks that aren't there.  
	// Handling this case is only important for debugging											
	assign	CoreHeaderRemove =						AccessStarted & ~AccessIsDummy & BlockWasFound & 
													(AccessCommand == BECMD_ReadRmv);
	
	Register	#(			.Width(					1))
				sent_cmd(	.Clock(					Clock),
							.Reset(					Reset | 
													ScanComplete_Conservative | 
													StartWriteback_Pass | 
													PerAccessReset | 
													(~CSEvict & Core_CommandComplete) |
													BlockEvictComplete),
							.Set(					Core_CommandValid & Core_CommandReady),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					SentCoreCommand));	
	
	assign 	Core_CommandValid =						((CSEvict | CSScan | CSTurnaround1 | CSTurnaround2 | CSCoreSync) & ~SentCoreCommand) |
													  CSPathRead | // increases path write performance
													  OutDMAValid;
	
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
	
	StashCore	#(			.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.BEDWidth(				BEDWidth),
							.EnableIV(				EnableIV),
							.Overclock(				Overclock))
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
							.OutMAC(				Core_OutMAC),
							.OutValid(				Core_OutValid),

							.InSAddr(				Core_CommandSAddr),
							.InPAddr(				Core_InPAddr),
							.InLeaf(				Core_InLeaf),
							.InMAC(					Core_InMAC),
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
							.OutScanDone(			Scan_Done),
							.OutScanStreaming(		Scan_Streaming),
							
							.InScanSAddr(			Scanned_SAddr),
							.InScanAccepted(		Scanned_LeafAccepted),
							.InScanAdd(				Scanned_Add),
							.InScanValid(			Scanned_LeafValid),
							.InScanDone(			Scanned_Done),
							.InScanStreaming(		Scanned_Streaming),
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		StashOccupancy),
							.ROAccess(				AccessSkipsWriteback),
							
							.CancelPushCommand(		StartWriteback_Pass),
							.SyncComplete(			Core_AccessComplete),
							.StartingEviction(		CSPathWriteback),
							
							.JTAG_StashCore(		JTAG_StashCore));

	// leaf remapping step
	assign	MappedLeaf =							(LookForBlock & FoundBlock_ThisCycle) ? RemapLeaf : Scan_Leaf;
	
	// don't try to push back blocks that we are removing
	assign	FoundRemoveBlock =						(LookForBlock & FoundBlock_ThisCycle) & (AccessCommand == BECMD_ReadRmv);
	assign	IsWritebackCandidate =					~FoundRemoveBlock & ~AccessSkipsWriteback & AccessStarted;
	
	StashScanTable #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.EnableIV(				EnableIV),
							.Overclock(				Overclock),
							.BEDWidth(				BEDWidth)) 
				scan_table(	.Clock(					Clock),
							.Reset(					Reset),		
							.PerAccessReset(		ScanTableReset),
							.AccessComplete(		PerAccessReset),
							.ResetDone(				ScanTableResetDone),
							
							.CurrentLeaf(			AccessLeaf),
							.IsWritebackCandidate(	IsWritebackCandidate),
							
							.InScanLeaf(			MappedLeaf),
							.InScanPAddr(			Scan_PAddr),
							.InScanSAddr(			Scan_SAddr),
							.InScanAdd(				Scan_Add),
							.InScanValid(			Scan_LeafValid),
							.InScanDone(			Scan_Done),
							.InScanStreaming(		Scan_Streaming),
							
							.OutScanSAddr(			Scanned_SAddr),
							.OutScanAccepted(		Scanned_LeafAccepted),
							.OutScanAdd(			Scanned_Add),
							.OutScanValid(			Scanned_LeafValid),
							.OutScanDone(			Scanned_Done),
							.OutScanStreaming(		Scanned_Streaming),
							
							.InDMAAddr(				BlocksReading[STAWidth-1:0]),
							.InDMAValid(			InDMAValid),
							
							.OutDMAAddr(			OutDMAAddr),
							.OutDMAValid(			OutDMAValid_Pre),
							.OutDMAReady(			OutDMAReady));

	//--------------------------------------------------------------------------
	// Front-end command handling
	//--------------------------------------------------------------------------

	Register	#(			.Width(					1))
				CRUD_op(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Enable(				CSIdle & AccessStarted),
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
							.Reset(					Reset | ( Core_CommandComplete && CSTurnaround1)),
							.Set(							 ~Core_CommandComplete && CSTurnaround1 && PerformReturnData && BlockWasFound),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ReturnInProgress));							

	assign	ReturnData =							Core_OutData;
	assign	ReturnPAddr =							Core_OutPAddr;
	assign	ReturnLeaf =							Core_OutLeaf;
	assign	ReturnMAC =								Core_OutMAC;
	assign	ReturnDataOutValid =					ReturnInProgress & Core_OutValid;
	assign	BlockReturnComplete =					ReturnInProgress & Core_CommandComplete;
	
	//--------------------------------------------------------------------------
	//	Intra-access waiting
	//--------------------------------------------------------------------------
	
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
	
	assign	OutDMAValid = 							CSPathWriteback & OutSpaceGate & OutDMAValid_Pre;
	assign	OutDMAReady =							CSPathWriteback & OutSpaceGate & Core_CommandReady;

	// which block are we currently writing back?
	Counter		#(			.Width(					STAP1Width))
				rd_st_cnt(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSPathWriteback & ~ReadingLastBlock),
							.In(					{STAP1Width{1'bx}}),
							.Count(					BlocksReading));
	CountCompare #(			.Width(					STAP1Width),
							.Compare(				BlocksOnPath))
				rd_st_cmp(	.Count(					BlocksReading), 
							.TerminalCount(			ReadingLastBlock));
					
	// ticks at end of block read
	Counter		#(			.Width(					STAP1Width))
				rd_ret_cnt(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSPathWriteback & BlockReadComplete_Internal),
							.In(					{STAP1Width{1'bx}}),
							.Count(					BlocksRead));
	CountCompare #(			.Width(					STAP1Width),
							.Compare(				BlocksOnPath))
				rd_ret_cmp(	.Count(					BlocksRead), 
							.TerminalCount(			Top_AccessComplete));
							
	//--------------------------------------------------------------------------
	// Read interface buffering
	//--------------------------------------------------------------------------
	
	// *2 = this is the largest number of blocks StashCore might still give us even after we tell it to stop
	assign	OutSpaceGate =							OutBufferSpace > (BlkSize_BEDChunks << 1);	
	
	assign	OutBufferInValid =						CSPathWriteback & Core_OutValid;
	assign	OutHBufferInValid =						OutBufferInValid & BlockReadComplete_Internal;
	
	assign	BlockReadComplete =						TickOutHeader; // TODO should be BlockReadCommit ...
	assign	BlockReadCommit = 						BlockReadComplete & ReadOutValid & ReadOutReady;
	
	FIFORAM		#(			.Width(					BEDWidth),
							.Buffering(				BlkSize_BEDChunks * StashOutBuffering))
				out_P_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				Core_OutData),
							.InValid(				OutBufferInValid),
							.InAccept(				OutBufferInReady),
							.InEmptyCount(			OutBufferSpace),
							.OutData(				ReadData),
							.OutSend(				ReadOutValid),
							.OutReady(				ReadOutReady));

	assign	OutHBufferDataIn =						(EnableIV) ? 	{Core_OutMAC, Core_OutPAddr, Core_OutLeaf} :
																				{ Core_OutPAddr, Core_OutLeaf};
	
	FIFORAM		#(			.Width(					SHDWidth),
							.Buffering(				StashOutBuffering))
				out_H_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				OutHBufferDataIn),
							.InValid(				OutHBufferInValid),
							.InAccept(				OutHBufferInReady),
							.OutData(				OutHBufferDataOut),
							.OutSend(				OutHeaderValid),
							.OutReady(				BlockReadCommit));		

	generate if (EnableIV) begin:MAC_BUFFEROUT
		assign	{ReadMAC, ReadPAddr, ReadLeaf} =	OutHBufferDataOut;
	end else begin:MAC_NOBUFFEROUT
		assign	{ReadPAddr, ReadLeaf} =				OutHBufferDataOut;
	end endgenerate
	
	Counter		#(			.Width(					OBWidth))
				out_H_cnt(	.Clock(					Clock),
							.Reset(					Reset | BlockReadCommit),
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

