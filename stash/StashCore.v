
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		StashCore
//	Desc:		Implements core stash operations
//
//	Commands:
//		Push - 	add element to stash.  This is only used on a path read --- NOT 
//				when a dirty LLC block gets evicted.
//		Peak - 	read (do not remove) element from stash
//		Overwrite - update the data for a block currently in the stash; DO NOT 
//				update the header
//		Dump - 	scan all elements in stash and fill table that indicates the 
//				highest position in the ORAM tree, where each block can be 
//				written back to.  This operation destroys the stash pointer 
//				memory and must be followed by a Sync command.
//		Sync - 	Reconstruct the stash pointer memory
//
//	Alternate implementation:
//		Replace linked list with an ORAMC bit wide bitvector (similar to StashC).
//		Pros: 
//			- 	no more complicated linked list add operations [easier to 
//				implement wide stashes]
//			- 	no more Sync operation
//		Cons:
//			- 	To convert bitvector into an address that points to first used/
//				free slot, we need the A & -A bithack.  Expensive at this bit 
//				width!
//			- 	Cost of ORAMC bits in registers?  Also we need a way to mask out 
//				locations we have already scanned.  Naively done, this is 
//				another ORAMC bits but we can use a log(capacity) binary -> many 
//				hot 
//				encoding to make it cheaper.
//		Notes: 
//			-	StashC is already asynchronous read ... we already pay this cost
//			-	The old design isn't performance (in cycles) scalable to large 
//				ORAMC: the scan/sync will dominate
//			-	This new design isn't performance (in combinational latency) 
//				scalable to large ORAMC: the bitvector and logic get slow 
//------------------------------------------------------------------------------
module StashCore #(`include "PathORAM.vh", `include "Stash.vh") (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset, PerAccessReset,
	output					ResetDone,

	//--------------------------------------------------------------------------
	//	Command interface
	//--------------------------------------------------------------------------
		
	input	[SCMDWidth-1:0] InCommand,
	input	[SEAWidth-1:0]	InSAddr,
	input	[ORAMU-1:0]		InPAddr,
	input	[ORAML-1:0]		InLeaf,
	/* 	Only used for header update command
		SECURITY: InHeaderUpdate is redundant, but we will always do real/dummy 
		header update to prevent timing variations (we could also just use a 
		counter but this is simpler to implement) */
	input					InHeaderUpdate,
	input					InHeaderRemove,
	input					InCommandValid,
	// High during at the beginning (first cycle) of an operation
	output 					InCommandReady,
	// High during the last cycle of an operation (the last cycle when valid 
	// data is being written OR read out)
	output					InCommandComplete,

	//--------------------------------------------------------------------------
	//	Input interface
	//--------------------------------------------------------------------------
	
	input	[BEDWidth-1:0]	InData,
	input					InValid,
	output 					InReady,

	//--------------------------------------------------------------------------
	//	Output interface
	//--------------------------------------------------------------------------
	
	output	[BEDWidth-1:0]	OutData,
	output	[ORAMU-1:0]		OutPAddr,
	output	[ORAML-1:0]		OutLeaf,
	output 					OutValid,

	//--------------------------------------------------------------------------
	//	Scan interface
	//--------------------------------------------------------------------------
	
	output	[ORAMU-1:0]		OutScanPAddr,
	output	[ORAML-1:0]		OutScanLeaf,
	output	[SEAWidth-1:0]	OutScanSAddr,
	output					OutScanAdd,
	output					OutScanValid,
	output					OutScanStreaming,

	input	[SEAWidth-1:0]	InScanSAddr,
	input					InScanAccepted,
	input					InScanAdd,
	input					InScanValid,
	input					InScanStreaming,
	
	//--------------------------------------------------------------------------
	//	Status interface
	//--------------------------------------------------------------------------

	output 					StashAlmostFull,
	output					StashOverflow,	
	output	[SEAWidth-1:0] 	StashOccupancy,

	//--------------------------------------------------------------------------
	//	Stash internal signals
	//--------------------------------------------------------------------------
	
	/*	We will issue one more push request than we want during path reads (this 
		helps maintain 100% throughput).  So, we need to kill the last request. */
	input					CancelPushCommand,
	output					SyncComplete
	);
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	
	`include "BucketLocal.vh"
	`include "StashLocal.vh"

	localparam				STWidth =				3,
							ST_Reset =				3'd0,
							ST_Idle = 				3'd1,
							ST_Pushing = 			3'd2, // write, add
							ST_Overwriting = 		3'd3, // overwrite current entry
							ST_Peaking =			3'd4, // read, do not remove
							ST_Dumping =			3'd5,
							ST_UpdatingHeader =		3'd6,
							ST_StartSync =			3'd7;

	localparam				SyncSTWidth =			3,
							ST_Sync_Idle =			3'd0,
							ST_Sync_Main =			3'd1,
							ST_Sync_CapUL = 		3'd2,
							ST_Sync_CapFL = 		3'd3,
							ST_Sync_Done =			3'd4;
							
	localparam				ENWidth =				1,
							EN_Free =				1'b0,
							EN_Used =				1'b1;	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	// Control
	
	reg		[STWidth-1:0]	CS, NS;
	wire					CSReset, CSIdle, CSPeaking, CSPushing, 
							CSOverwriting, CSDumping, CSHUpdate, CSStartSync;

	wire 					StreamingCRUDOp;
							
	wire					ContinuePeak, ContinuePush;
							
	wire					WriteTransfer, DataTransfer;
	wire					FirstChunk_Transfer;
	wire					Transfer_Terminator;
	wire 					AddBlock, RemoveBlock;

	// Reset
	
	wire	[SEAWidth-1:0]	ResetCount;
	
	// Stash memories
	
	wire	[ORAMU-1:0]		OutPAddr_Pre;
	
	wire	[BEDWidth-1:0]	StashD_DataOut;

	wire	[SDAWidth-1:0]	StashD_Address;
	wire	[SEAWidth-1:0]	StashE_Address;
	reg		[SEAWidth-1:0]	StashE_Address_Delayed;

	wire					StashH_WE;	
		
	wire	[SEAWidth-1:0]	StashP_Address, StashP_DataOut, StashP_DataIn;
	wire					StashP_WE;
	
	wire	[SEAWidth-1:0]	StashC_Address;
	wire	[ENWidth-1:0] 	StashC_DataIn, StashC_DataOut;
	wire					StashC_WE;
	
	// Chunk counting
	
	wire					FirstChunk, LastChunk;
	wire 	[ChnkAWidth-1:0]CurrentChunk;

	// Free/used lists
	
	wire 	[SEAWidth-1:0]	UsedListHead, FreeListHead;
	wire 	[SEAWidth-1:0]	FreeList_Resolved;
	wire 	[SEAWidth-1:0]	UsedListHead_New, FreeListHead_New;
	
	// Scan/Dump
	
	wire	[SEAWidth-1:0]	StashWalk;
	wire					SWTerminator_Finished, SWTerminator_Empty, StashWalk_Terminator;
	wire					OutScanValidPush, OutScanValidDump;
	
	// Syncing
	
	reg 	[SyncSTWidth-1:0] NS_Sync, CS_Sync;
	wire 					CSSyncing, CSSyncing_Main, CSSyncing_CapUL, CSSyncing_CapFL;
	
	wire	[SEAWidth-1:0]	SyncCount, Sync_StashPUpdateSrc, LastULE, LastFLE;
	wire					ULHSet, FLHSet;
	wire					Sync_SettingULH, Sync_SettingFLH;
	wire					Sync_FoundUsedElement, Sync_FoundFreeElement;
	wire					Sync_Terminator;
	
	// Derived signals

	reg		[SEAWidth-1:0] 	StashWalk_Delayed;
	reg						CSPeaking_Delayed, CSDumping_Delayed,
							CSSyncing_Delayed,
							InScanValid_Delayed;
	wire					CSDumping_FirstCycle, CSSyncing_FirstCycle;

	initial begin
		CS = ST_Reset;
		CSPeaking_Delayed = 1'b0; // TODO remove
		CSDumping_Delayed = 1'b0;
	end

	//--------------------------------------------------------------------------
	//	Software debugging
	//--------------------------------------------------------------------------
	
	/* 
		Other things to check:
		1 - elements in used list are not in free list (and vice versa)
		2 - no element with same program address appears twice
		3 - after sync, each list is of expected length
	*/

	`ifdef SIMULATION
		reg [SEAWidth-1:0] 	MS_pt;
		reg	[ORAMU-1:0]		PAddrTemp;
		integer 			i;
		// align the printouts in time
		reg					MS_FinishedWrite, SyncComplete_Delayed;
		wire				MS_StartingWrite;
		reg [STWidth-1:0]	CS_Delayed, LS;
		wire				MS_FinishedSync;
		
		initial begin
			LS = 			ST_Reset;
			
			if (StashCapacity < BlocksOnPath) begin
				$display("[%m] ERROR: retarded stash capacity (%d < %d)", StashCapacity, BlocksOnPath);
				$stop;
			end
		end
		
		assign	MS_FinishedSync	= ~SyncComplete_Delayed & SyncComplete;
		
		assign	MS_StartingWrite = WriteTransfer & FirstChunk;
		
		always @(posedge Clock) begin
			if (MS_StartingWrite) begin
				$display("[%m @ %t] Writing [a=%x, l=%x, sloc=%d]", $time, InPAddr, InLeaf, StashE_Address);
				if (CSOverwriting) begin
					$display("\t(Overwrite)");
				end
			end

			MS_FinishedWrite <=	(CSPushing | CSOverwriting) & Transfer_Terminator;
			
			SyncComplete_Delayed <= SyncComplete;
			CS_Delayed <= CS;
			
			if (CS_Delayed != CS & CS == ST_Idle)
				LS <= CS_Delayed;
			
			/* obsolete check with all of the operation interleaving ...
			if (LS == ST_Dumping & ~CSSyncing & ~CSIdle & ~CSPushing) begin
				// This is so the block count gets updated ...
				$display("ERROR: must perform sync after dump");
				$stop;
			end
			*/
			
			if (RemoveBlock & StashOccupancy == 0) begin
				$display("[%m] ERROR: we removed a block from an empty stash");
				$stop;			
			end
			
			if (CSSyncing_FirstCycle & Sync_SettingULH == Sync_SettingFLH) begin
				$display("[%m] ERROR: both free/used list given same pointer during sync");
				$stop;
			end
			
			if (WriteTransfer & StashE_Address == SNULL) begin
				$display("[%m] ERROR: overwriting the SNULL entry");
				$stop;
			end
			
			if (MS_FinishedSync) begin
				MS_pt = UsedListHead;
				i = 0;
	`ifdef SIMULATION_VERBOSE_STASH
				$display("\tUsedListHead = %d", MS_pt);
	`endif
				while (MS_pt != SNULL) begin
	`ifdef SIMULATION_VERBOSE_STASH
					$display("\t\tStashP[%d] = %d (Used? = %b)", MS_pt, StashP.Mem[MS_pt], StashC.Mem[MS_pt] == EN_Used);
	`endif
					MS_pt = StashP.Mem[MS_pt];
					i = i + 1;
					if (StashC.Mem[MS_pt] == EN_Free) begin
						$display("[ERROR] used list entry tagged as free");
						$stop;
					end
					
					if (i > StashCapacity) begin
						$display("[ERROR] no terminator (UsedList)");
						$stop;
					end
				end
				MS_pt = FreeListHead;
				i = 0;
	`ifdef SIMULATION_VERBOSE_STASH
				$display("\tFreeListHead = %d", MS_pt);
	`endif
				while (MS_pt != SNULL) begin
	`ifdef SIMULATION_VERBOSE_STASH
					$display("\t\tStashP[%d] = %d (Used? = %b)", MS_pt, StashP.Mem[MS_pt], StashC.Mem[MS_pt] == EN_Used);
	`endif
					MS_pt = StashP.Mem[MS_pt];
					i = i + 1;
					if (i > StashCapacity) begin
						$display("[ERROR] no terminator (FreeList)");
						$stop;
					end
				end	
			end
			
			// Are the stash data structure / occupancy counts in Sync?
			if (PerAccessReset) begin
				MS_pt = UsedListHead;
				i = 0;
				while (MS_pt != SNULL) begin
					MS_pt = StashP.Mem[MS_pt];
					i = i + 1;
				end
				if (i != StashOccupancy) begin
					$display("FAIL: Stash occupancy %d != direct inspection Occupancy %d", StashOccupancy, i);
					$stop;
				end	
			end
			
			// No duplicate blocks allowed
			if (CSPushing & StashH_WE) begin
				MS_pt = UsedListHead;
				i = 0;
				while (MS_pt != SNULL) begin
					PAddrTemp = StashH.Mem[MS_pt][ORAMU+ORAML-1:ORAML];
					if (PAddrTemp == InPAddr) begin
						$display("FAIL: Tried to add block (paddr = %x) to stash but it was already present @ sloc = %d!", InPAddr, MS_pt);
						$stop;
					end
					MS_pt = StashP.Mem[MS_pt];
					i = i + 1;
					if (i > StashCapacity) begin
						$display("[ERROR] no terminator (UsedList)");
						$stop;
					end					
				end
			end
			
			if (CSPeaking & Transfer_Terminator)
				if (OutPAddr == DummyBlockAddress)
					$display("[%m @ %t] Reading dummy block", $time);
				else
					$display("[%m @ %t] Reading [a=%x, l=%x, sloc=%d]", $time, OutPAddr, OutLeaf, StashE_Address_Delayed);
		end	
	`endif
	
	//--------------------------------------------------------------------------
	//	State transitions & control logic
	//--------------------------------------------------------------------------

	/* 	
		Pulsed during the last cycle of an operation.  InCommandReady will be 
		high during the last write cycle and _second to last_ read cycle because 
		reads have fdlat = 1.  This allows read->write turnovers to happen 
		without a cycle gap. 
		
		NOTE: 	This interface isn't RV... we assume CommandValid is high when 
				CommandReady is high (is this still true???)
	*/
	
	assign	InCommandReady =						(CSPushing | CSOverwriting) ? FirstChunk & StreamingCRUDOp : 
													(CSPeaking) ? FirstChunk : 
													CSIdle;

	wire Transfer_Terminator_Delayed; // TODO		
											
	// Note: Stash.v doesn't expect CommandComplete for Dumps
	assign	InCommandComplete =						(CSPushing | CSOverwriting) ? Transfer_Terminator : // TODO cleanup
													(CSPeaking) ? Transfer_Terminator_Delayed : // TODO cleanup 
													(CSHUpdate | CSStartSync);
													
	assign	OutData =								StashD_DataOut;
			
	assign	InReady =								CSPushing | CSOverwriting;
	assign 	OutValid = 								CSPeaking;

	assign 	WriteTransfer = 						InReady & InValid;
	assign 	ReadTransfer = 							OutValid; // will we have valid data out in the next cycle?
	assign 	DataTransfer = 							WriteTransfer | ReadTransfer;

	assign	FirstChunk_Transfer =					FirstChunk & WriteTransfer & CSPushing;
	assign	Transfer_Terminator =					LastChunk & DataTransfer; // TODO cleanup

	assign	CSReset =								CS == ST_Reset;
	
	assign	CSIdle =								CS == ST_Idle;
	assign	CSPeaking = 							CS == ST_Peaking; 
	assign	CSPushing = 							CS == ST_Pushing;
	assign	CSOverwriting =							CS == ST_Overwriting;
	assign	CSDumping = 							CS == ST_Dumping;
	assign	CSHUpdate =								CS == ST_UpdatingHeader;
	assign	CSStartSync =							CS == ST_StartSync;
	
	assign	CSDumping_FirstCycle = 					CSDumping & ~CSDumping_Delayed;
	assign	CSSyncing_FirstCycle =					CSSyncing & ~CSSyncing_Delayed;
	
	assign	ContinuePush =							InCommandValid & InCommand == SCMD_Push & Transfer_Terminator;
	assign	ContinuePeak =							(InCommandValid & InCommand == SCMD_Peak & Transfer_Terminator_Delayed); // TODO cleanup
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Reset;
		else CS <= 									NS;

		CSPeaking_Delayed <=						CSPeaking;
		CSDumping_Delayed <=						CSDumping;
		CSSyncing_Delayed <=						CSSyncing;
		StashWalk_Delayed <=						StashWalk;
		InScanValid_Delayed <=						InScanValid;
		StashE_Address_Delayed <=					StashE_Address;
	end

	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Reset : 
				if (ResetDone) 
					NS =						 	ST_Idle;
			ST_Idle :
				if (InCommandValid) begin
					if (InCommand == SCMD_Push & ~CancelPushCommand)
						NS =						ST_Pushing;
					if (InCommand == SCMD_Overwrite)
						NS =						ST_Overwriting;
					if (InCommand == SCMD_Peak)
						NS =						ST_Peaking;
					if (InCommand == SCMD_Dump)
						NS =						ST_Dumping;
					if (InCommand == SCMD_UpdateHeader)
						NS =						ST_UpdatingHeader;
					if (InCommand == SCMD_Sync)
						NS =						ST_StartSync;
				end
			ST_Pushing :
				if (ContinuePush)
					NS =							ST_Pushing;
				else if (Transfer_Terminator | CancelPushCommand)
					NS =							ST_Idle;
			ST_Overwriting :
				if (InCommandValid & InCommand == SCMD_Overwrite & Transfer_Terminator)
					NS =							ST_Overwriting;
				else if (Transfer_Terminator)
					NS =							ST_Idle;
			ST_Peaking :
				if (ContinuePeak)
					NS =							ST_Peaking;
				else if (Transfer_Terminator_Delayed)
					NS =							ST_Idle;
			ST_Dumping : 
				if (StashWalk_Terminator)
					NS =							ST_Idle;
			ST_UpdatingHeader :
					NS =							ST_Idle;
			ST_StartSync :
					NS =							ST_Idle;
		endcase
	end
	
	generate if (BlkSize_BEDChunks > 1) begin:HOLD_RDY
		Register #(			.Width(					1))
				stream_reg(	.Clock(					Clock),
							.Reset(					Reset | CSIdle),
							.Set(					(CSPeaking | CSPushing | CSOverwriting) & FirstChunk & DataTransfer),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					StreamingCRUDOp));
		Register #(			.Width(					1))
				term_dly(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				1'b1),
							.In(					Transfer_Terminator),
							.Out(					Transfer_Terminator_Delayed));							
	end else begin:PASS_RDY
		assign	StreamingCRUDOp =					1'b1;
		assign	Transfer_Terminator_Delayed =		1'b1;
	end endgenerate
	
	//--------------------------------------------------------------------------
	//	Reset logic
	//--------------------------------------------------------------------------

	Counter		#(			.Width(					SEAWidth))
				InitCounter(.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				~ResetDone),
							.In(					{SEAWidth{1'bx}}),
							.Count(					ResetCount));
	assign	ResetDone =								ResetCount == (StashCapacity - 1);

	//--------------------------------------------------------------------------
	//	Core memories
	//--------------------------------------------------------------------------

	wire	[SEAWidth-1:0] InSAddr_Reg; // TODO
	Register	#(			.Width(					SEAWidth))
				Eaddr(		.Clock(					Clock), // TODO name
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				InCommandValid & InCommandReady),
							.In(					InSAddr),
							.Out(					InSAddr_Reg));	

	wire	[SEAWidth-1:0] FLResolved_Reg; // TODO
	Register	#(			.Width(					SEAWidth))
				Faddr(		.Clock(					Clock), // TODO name
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				FirstChunk & InValid & InReady),
							.In(					FreeList_Resolved),
							.Out(					FLResolved_Reg));	
							
	assign	StashE_Address = 						(CSDumping) ? 	StashWalk : 
													(CSPushing & FirstChunk) ? 	FreeList_Resolved : 
													(CSPushing) ? FLResolved_Reg :
													(FirstChunk) ?	InSAddr :
																	InSAddr_Reg;
	assign	StashD_Address =						{StashE_Address, {ChnkAWidth{1'b0}}} + CurrentChunk;

	/* 
		Stores data blocks.  This memory is indexed using {EntryID, EntryOffset}. 
	*/
	RAM			#(			.DWidth(				BEDWidth),
							.AWidth(				SDAWidth))
				StashD(		.Clock(					Clock),
							.Reset(					1'b0),
							.Enable(				1'b1),
							.Write(					WriteTransfer),
							.Address(				StashD_Address),
							.DIn(					InData),
							.DOut(					StashD_DataOut));

	/*
		Since we always read/write blocks atomically, the offset is a simple 
		counter.
	*/
	Counter		#(			.Width(					ChnkAWidth))
				chunk_cnt(	.Clock(					Clock),
							.Reset(					Reset | Transfer_Terminator),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				~LastChunk & (DataTransfer | (InCommandValid & InCommandReady & CSIdle & InCommand == SCMD_Peak)) & ~(CSPeaking & ~ContinuePeak & Transfer_Terminator_Delayed)), // TODO cleanup
							.In(					{ChnkAWidth{1'bx}}),
							.Count(					CurrentChunk));
	CountCompare #(			.Width(					ChnkAWidth),
							.Compare(				NumChunks - 1))
				chunk_cnt_f(.Count(					CurrentChunk), 
							.TerminalCount(			LastChunk));
							
	assign FirstChunk =								~|CurrentChunk;

	assign	StashH_WE =								(CSHUpdate & InHeaderUpdate) |
													(WriteTransfer & FirstChunk & ~CSOverwriting);
	
	/*
		For each data block, store its program address / leaf label.
	*/
	RAM			#(			.DWidth(				SHDWidth),
							.AWidth(				SEAWidth))
				StashH(		.Clock(					Clock),
							.Reset(					1'b0),
							.Enable(				1'b1),
							.Write(					StashH_WE),
							.Address(				StashE_Address),
							.DIn(					{InPAddr, 		InLeaf}),
							.DOut(					{OutPAddr_Pre, 	OutLeaf}));
	assign	OutPAddr =								(StashE_Address_Delayed == SNULL) ? DummyBlockAddress : OutPAddr_Pre;

	//--------------------------------------------------------------------------
	//	Management
	//--------------------------------------------------------------------------

	assign	FreeList_Resolved =						(CSPushing_FirstCycle) ? 					FreeListHead :
																								StashP_DataOut;
	
	assign 	FreeListHead_New =						(CSPushing_Delayed) ? 						StashP_DataOut : 
													(CSSyncing) ? 								SyncCount : 
													(CSSyncing_FirstCycle & Sync_SettingULH) ? 	SNULL :	
																								SyncCount; // TODO simplify
	assign 	UsedListHead_New = 						(CSPushing) ? 								FreeList_Resolved :
													(CSSyncing_FirstCycle & Sync_SettingFLH) ? 	SNULL :	
																								SyncCount;
  
	wire FirstChunk_Terminator_Delayed;
	wire CSPushing_Delayed, CSPushing_FirstCycle; // TODO
	wire StashP_EN;
	
	// TODO turn this into the normal delay syntax
	Register	#(			.Width(					2))
				dreg1(		.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				1'b1),
							.In(					{CSPushing, 		FirstChunk_Transfer}),
							.Out(					{CSPushing_Delayed, FirstChunk_Terminator_Delayed}));
	assign	CSPushing_FirstCycle =					~CSPushing_Delayed & CSPushing;
	
	/*
		The head of the used/free lists.
	*/
	Register	#(			.Width(					SEAWidth),
							.ResetValue(			SNULL))
				UsedListH(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				FirstChunk_Transfer | Sync_SettingULH | CSSyncing_FirstCycle),
							.In(					UsedListHead_New),
							.Out(					UsedListHead));
	Register	#(			.Width(					SEAWidth))
				FreeListH(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				FirstChunk_Terminator_Delayed | Sync_SettingFLH | CSSyncing_FirstCycle),
							.In(					FreeListHead_New),
							.Out(					FreeListHead));
							
	/* 
		StashP: pointers that make up both the used list/free list. 
	*/
	
	assign	StashP_Address = 						(CSReset) ? 	ResetCount : 
													(CSDumping) ? 	StashWalk : 
													(CSSyncing) ? 	Sync_StashPUpdateSrc : 
																	FreeList_Resolved;
	assign	StashP_DataIn = 						(CSReset) ? 	ResetCount + 1 :
													(CSSyncing) ? 	SyncCount : 
																	UsedListHead;
	assign	StashP_WE =								CSReset | 
													FirstChunk_Transfer | 
													(CSSyncing_Main & ~Sync_SettingULH & ~Sync_SettingFLH) |
													(CSSyncing_CapUL & ULHSet) | 
													(CSSyncing_CapFL & FLHSet);
	assign	StashP_EN =								~CSPushing | FirstChunk_Transfer;
	
	wire	[SEAWidth-1:0]	DummyWire; // TODO move
			
	RAM			#(			.DWidth(				SEAWidth),
							.AWidth(				SEAWidth),
							.NPorts(				2))
				StashP(		.Clock(					{2{Clock}}),
							.Reset(					/* not connected */),
							.Enable(				{2{StashP_EN}}),
							.Address(				{2{StashP_Address}}),
							.Write(					{1'b0, 				StashP_WE}),
							.DIn(					{{SEAWidth{1'bx}}, 	StashP_DataIn}),
							.DOut(					{StashP_DataOut, 	DummyWire}));

	/* 
		StashC: indicates whether each element in the stash is in the used list 
		or free list.  This is needed to avoid a subtlety in the stash scan 
		logic.  Suppose the Scan table and StashP contain the following:

			i	ScanTable	StashP	UsedListHead = 0
			-	--------- 	------
			0	0			1
			1	1			2
			2	2			3

		We scan the ScanTable from top to bottom to perform the ORAM writeback 
		operation.  If we want to remove elements from StashP as we scan the 
		ScanTable, each entry in the ScanTable must be a parent pointer.  In the 
		above example, this operation _cannot_ work (try it yourself: the 
		problem is that StashP[1] will be used to store a pointer in the free 
		list after the 0th iteration).  So, we use StashC to reconstruct the 
		used/free list while ScanTable is being scanned (hides latency and is 
		simple to code).
	*/

	assign	StashC_Address = 						(InScanStreaming) ? 	InScanSAddr : 
													(CSHUpdate) ? 			InSAddr :
													(CSReset) ? 			ResetCount : 
													(CSSyncing) ?			SyncCount : 
																			{SEAWidth{1'bx}};

	assign	StashC_DataIn = 						(InScanStreaming) ? 	((InScanAccepted) ? EN_Free : EN_Used) :
													(CSHUpdate) ?			EN_Free : 
													(CSReset) ? 			EN_Free : 
																			{ENWidth{1'bx}};
	assign	StashC_WE =								CSReset | InScanValid | (CSHUpdate & InHeaderRemove); // TODO timing will be off
		
	RAM			#(			.DWidth(				ENWidth), // 1b typically
							.AWidth(				SEAWidth),
							.RLatency(				0)) // THIS might be a problem critical-path-wise
				StashC(		.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				1'b1),
							.Write(					StashC_WE),
							.Address(				StashC_Address),
							.DIn(					StashC_DataIn),
							.DOut(					StashC_DataOut));

	//--------------------------------------------------------------------------
	//	Element counting
	//--------------------------------------------------------------------------
	
	assign	AddBlock =								  InScanAdd & InScanValid & ~InScanAccepted;
	assign	RemoveBlock =							(~InScanAdd & InScanValid & InScanAccepted) |
													(CSHUpdate & InHeaderRemove);
	
	UDCounter	#(			.Width(					SEAWidth))
				ElementCount(.Clock(				Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Up(					AddBlock),
							.Down(					RemoveBlock),
							.In(					{SEAWidth{1'bx}}),
							.Count(					StashOccupancy));

	assign	StashAlmostFull =						(StashOccupancy + BlocksOnPath) >= StashCapacity - 1; // - 1 because we reserve last spot for SNULL
	assign	StashOverflow =							AddBlock & StashOccupancy == StashCapacity;	
							
	//--------------------------------------------------------------------------
	//	Dumping the UsedList
	//--------------------------------------------------------------------------
	
	assign	StashWalk = 							(CSDumping_FirstCycle) ? UsedListHead : StashP_DataOut;
																							
	assign	SWTerminator_Finished =					CSDumping & ~InScanValid & InScanValid_Delayed;
	assign	SWTerminator_Empty =					CSDumping & CSDumping_FirstCycle & StashWalk == SNULL;
	assign 	StashWalk_Terminator =					SWTerminator_Finished | SWTerminator_Empty;
	
	assign	OutScanSAddr =							(CSPushing) ? FreeList_Resolved : StashWalk_Delayed;
	assign	OutScanPAddr =							(CSPushing) ? InPAddr : OutPAddr;
	assign	OutScanLeaf =							(CSPushing) ? InLeaf : OutLeaf;
	
	assign	OutScanAdd =							CSPushing;
	assign	OutScanStreaming =						CSPushing | CSDumping;
	
	assign	OutScanValidPush =						CSPushing & FirstChunk_Transfer;
	assign	OutScanValidDump =						CSDumping_Delayed & CSDumping & // wait a cycle for StashP's latency & don't overshoot
													OutScanSAddr != SNULL; // don't send end-of-list marker
	assign	OutScanValid =							OutScanValidPush | OutScanValidDump;

	//--------------------------------------------------------------------------
	//	StashC <-> StashP Sync
	//--------------------------------------------------------------------------
			
	assign	CSSyncing_Main =						CS_Sync == ST_Sync_Main;
	assign	CSSyncing_CapUL =						CS_Sync == ST_Sync_CapUL;
	assign	CSSyncing_CapFL =						CS_Sync == ST_Sync_CapFL;
	assign	CSSyncing =								CSSyncing_Main | CSSyncing_CapUL | CSSyncing_CapFL;
	assign	SyncComplete = 							CS_Sync == ST_Sync_Done;
	
	always @(posedge Clock) begin
		if (Reset) CS_Sync <= 						ST_Sync_Idle;
		else CS_Sync <= 							NS_Sync;
	end
	
	always @( * ) begin
		NS_Sync = 									CS_Sync;
		case (CS_Sync)
			ST_Sync_Idle : 
				if (CSStartSync) 
					NS_Sync =						ST_Sync_Main;
			ST_Sync_Main : 
				if (Sync_Terminator)
					NS_Sync =						ST_Sync_CapUL;
			ST_Sync_CapUL : 
					NS_Sync =						ST_Sync_CapFL;
			ST_Sync_CapFL :
					NS_Sync =						ST_Sync_Done;
			ST_Sync_Done :
				if (PerAccessReset)
					NS_Sync =						ST_Sync_Idle;
		endcase
	end
	
	/*
		After determining which ORAM blocks to writeback to the tree, re-create 
		the used/free lists based on the contents in StashC.  This circuit 
		implements the following psuedo-code:
		
		Set UsedListHead/FreeListHead to SNULL (both empty)
		for SyncCount from 0...StashCapacity:
			if StashC[SyncCount] == EN_Used:
				if UsedListHead == SNULL:
					UsedListHead = SyncCount
				else:
					StashP[LastULE] = i
				LastULE = SyncCount	
			else: ... same logic for free list	
	*/
	
	Counter		#(			.Width(					SEAWidth),
							.Limited(				1),
							.Limit(					StashCapacity))
				SyncCounter(.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSSyncing),
							.In(					{SEAWidth{1'bx}}),
							.Count(					SyncCount));

	assign	Sync_Terminator = 						SyncCount == (StashCapacity - 1);
	
	assign	Sync_StashPUpdateSrc =					((CSSyncing_CapUL | StashC_DataOut == EN_Used) & ~CSSyncing_CapFL) ? LastULE : LastFLE;
													
	assign	Sync_FoundUsedElement =					CSSyncing_Main & StashC_DataOut == EN_Used;
	assign	Sync_FoundFreeElement =					CSSyncing_Main & StashC_DataOut == EN_Free;

	assign	Sync_SettingULH =						CSSyncing_Main & ~ULHSet & Sync_FoundUsedElement;
	assign	Sync_SettingFLH =						CSSyncing_Main & ~FLHSet & Sync_FoundFreeElement;	
	
	Register	#(			.Width(					1))
				ULHSetReg(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					Sync_FoundUsedElement),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ULHSet));
	Register	#(			.Width(					SEAWidth))
				LastULEReg(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Enable(				Sync_FoundUsedElement),
							.In(					SyncCount),
							.Out(					LastULE));

	Register	#(			.Width(					1))
				FLHSetReg(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					Sync_FoundFreeElement),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					FLHSet));
	Register	#(			.Width(					SEAWidth))
				LastFLEReg(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Enable(				Sync_FoundFreeElement),
							.In(					SyncCount),
							.Out(					LastFLE));

	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

