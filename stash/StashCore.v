
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		StashCore
//	Desc:		Implements low-level stash operations.
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
module StashCore(
  	Clock, Reset, PerAccessReset,
	ResetDone,

	InCommand, InSAddr, InPAddr, InLeaf, InMAC,
	InHeaderUpdate, InHeaderRemove,
	InCommandValid, InCommandReady, InCommandComplete,

	InData, InValid, InReady,
	OutData, OutPAddr, OutLeaf, OutMAC, OutValid,

	OutScanPAddr, OutScanLeaf, OutScanSAddr, OutScanAdd,
	OutScanValid, OutScanDone, OutScanStreaming,

	InScanSAddr, InScanAccepted, InScanAdd,
	InScanValid, InScanDone, InScanStreaming,

	StashAlmostFull, StashOverflow,	StashOccupancy,

	ROAccess,

	CancelPushCommand, SyncComplete, StartingEviction,

	JTAG_StashCore
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

	localparam				STWidth =				4,
							ST_Reset =				4'd0,
							ST_Idle = 				4'd1,
							ST_Pushing = 			4'd2, // write, add
							ST_Overwriting = 		4'd3, // overwrite current entry
							ST_Peaking =			4'd4, // read, do not remove
							ST_Dumping =			4'd5,
							ST_UpdatingHeader =		4'd6,
							ST_StartSync =			4'd7,
							ST_Error =				4'd8;

	localparam				SyncSTWidth =			3,
							ST_Sync_Idle =			3'd0,
							ST_Sync_Main =			3'd1,
							ST_Sync_CapUL = 		3'd2,
							ST_Sync_CapFL = 		3'd3,
							ST_Sync_Done =			3'd4;

	localparam				ENWidth =				1,
							EN_Free =				1'b0,
							EN_Used =				1'b1;

	localparam				ENWWidth = 				ENWidth * StashCapacity;

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------

  	input 					Clock, Reset, PerAccessReset;
	output					ResetDone;

	//--------------------------------------------------------------------------
	//	Command interface
	//--------------------------------------------------------------------------

	input	[SCMDWidth-1:0] InCommand;
	input	[SEAWidth-1:0]	InSAddr;
	input	[ORAMU-1:0]		InPAddr;
	input	[ORAML-1:0]		InLeaf;
	input	[ORAMH-1:0]		InMAC;
	/* 	Only used for header update command
		SECURITY: InHeaderUpdate is redundant, but we will always do real/dummy
		header update to prevent timing variations (we could also just use a
		counter but this is simpler to implement) */
	input					InHeaderUpdate;
	input					InHeaderRemove;
	input					InCommandValid;
	// High during at the beginning (first cycle) of an operation
	output 					InCommandReady;
	// High during the last cycle of an operation (the last cycle when valid
	// data is being written OR read out)
	output					InCommandComplete;

	//--------------------------------------------------------------------------
	//	Input interface
	//--------------------------------------------------------------------------

	input	[BEDWidth-1:0]	InData;
	input					InValid;
	output 					InReady;

	//--------------------------------------------------------------------------
	//	Output interface
	//--------------------------------------------------------------------------

	output	[BEDWidth-1:0]	OutData;
	output	[ORAMU-1:0]		OutPAddr;
	output	[ORAML-1:0]		OutLeaf;
	output	[ORAMH-1:0]		OutMAC;
	output 					OutValid;

	//--------------------------------------------------------------------------
	//	Scan interface
	//--------------------------------------------------------------------------

	output	[ORAMU-1:0]		OutScanPAddr;
	output	[ORAML-1:0]		OutScanLeaf;
	output	[SEAWidth-1:0]	OutScanSAddr;
	output					OutScanAdd;
	output					OutScanValid;
	output					OutScanDone;
	output					OutScanStreaming;

	input	[SEAWidth-1:0]	InScanSAddr;
	input					InScanAccepted;
	input					InScanAdd;
	input					InScanValid;
	input					InScanDone;
	input					InScanStreaming;

	//--------------------------------------------------------------------------
	//	Status/Debugging interface
	//--------------------------------------------------------------------------

	output 					StashAlmostFull;
	output					StashOverflow;
	output	[SEAWidth-1:0] 	StashOccupancy;

	input					ROAccess;

	output	[JTWidth_StashCore-1:0] JTAG_StashCore;

	//--------------------------------------------------------------------------
	//	Stash internal signals
	//--------------------------------------------------------------------------

	/*	We will issue one more push request than we want during path reads (this
		helps maintain 100% throughput).  So, we need to kill the last request. */
	input					CancelPushCommand; // TODO can we refactor to get rid of this signal?
	output					SyncComplete;
	input					StartingEviction;

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	// Control

	(* mark_debug = "TRUE" *)	reg		[STWidth-1:0]	CS, NS;
	wire					CSReset, CSIdle, CSPeaking, CSPushing,
							CSOverwriting, CSDumping, CSHUpdate, CSStartSync;

	wire 					StreamingCRUDOp;

	wire					ContinuePeak, ContinuePush, ContinueOverwrite;
	wire 					EnterPeak, ExitPeak;

	wire					ReadTransfer, WriteTransfer, DataTransfer;
	wire					FirstChunk_Transfer_Write;
	wire 					AddBlock, RemoveBlock;

	wire 					LastChunk_Read;
	wire 					LastChunk_Transfer_Read, LastChunk_Transfer_Write, LastChunk_Transfer_Data;

	// Reset

	wire	[SEAWidth-1:0]	ResetCount;

	// Stash memories

	wire	[ORAMH-1:0]		OutMAC_Pre;
	wire	[ORAMU-1:0]		OutPAddr_Pre;
	wire	[ORAML-1:0]		OutLeaf_Pre;

	wire	[SEAWidth-1:0] 	InSAddr_Reg, FreeList_Resolved_Reg;
	wire	[SEAWidth-1:0] 	ScanAddress, PushAddress;

	wire	[BEDWidth-1:0]	StashD_DataOut;

	wire	[SDAWidth-1:0]	StashD_Address;
	wire	[SEAWidth-1:0]	StashE_Address;
	reg		[SEAWidth-1:0]	StashE_Address_Delayed;

	wire					StashH_WE;
	wire	[SHDWidth-1:0]	StashHDataIn, StashHDataOut;

	wire	[SEAWidth-1:0]	StashP_Address, StashP_DataOut, StashP_DataIn;
	wire					StashP_WE;
	wire					StashP_EN;

	wire	[SEAWidth-1:0]	StashC_Address;
	wire	[ENWidth-1:0] 	StashC_DataIn, StashC_DataOut;
	wire					StashC_WE;

	wire	[ENWidth-1:0]	StashC_RODataOut, StashC_RODataOut_Delayed;
	wire	[SEAWidth-1:0]	StashC_ROAddress;

	wire					CSPushing_FirstTransferred;

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

	wire					StillWalkingStash, DumpStop, DumpStop_Reg, DumpStop_Pass;

	// Syncing

	reg 	[SyncSTWidth-1:0] NS_Sync, CS_Sync, SyncState;
	wire 					CSSyncing, CSSyncing_Main, CSSyncing_CapUL, CSSyncing_CapFL;

	wire	[SEAWidth-1:0]	SyncCount_PreLatch;

	wire					Sync_StashPWE;
	wire	[SEAWidth-1:0]	Sync_StashPUpdateSrc, LastULE, LastFLE;
	reg		[SEAWidth-1:0]	SyncCount;
	wire					ULHSet, FLHSet;
	wire					Sync_SettingULH, Sync_SettingFLH;
	wire					Sync_FoundUsedElement, Sync_FoundFreeElement;
	wire					Sync_Terminator;

	// Derived signals

	reg		[SEAWidth-1:0] 	StashWalk_Delayed;
	reg						CSDumping_Delayed, CSSyncing_Delayed, FirstChunk_Transfer_Delayed;
	wire					CSPushing_FirstCycle, CSDumping_FirstCycle,
							CSSyncing_FirstCycle, CSSyncing_PreLatch;

	// debugging

	(* mark_debug = "TRUE" *)	wire 					StashAlmostFull_Internal;
	(* mark_debug = "TRUE" *)	wire					StashOverflow_Internal;
	(* mark_debug = "TRUE" *)	wire	[SEAWidth-1:0] 	StashOccupancy_Internal;

	(* mark_debug = "TRUE" *)	wire					ERROR_UF1, ERROR_ISC1, ERROR_ISC2, ERROR_StashCore;

	//--------------------------------------------------------------------------
	//	Initial state
	//--------------------------------------------------------------------------

	`ifdef FPGA
		initial begin
			CS = ST_Reset;
			CS_Sync = ST_Sync_Idle;
			SyncState = CS_Sync;

			StashWalk_Delayed = 1'b0;
			CSDumping_Delayed = 1'b0;
			CSSyncing_Delayed = 1'b0;
			FirstChunk_Transfer_Delayed = 1'b0;
		end
	`endif

	//--------------------------------------------------------------------------
	//	Software debugging
	//--------------------------------------------------------------------------

	/*
		Other things to check:
		1 - elements in used list are not in free list (and vice versa)
		2 - no element with same program address appears twice
		3 - after sync, each list is of expected length
	*/

	Register1b 	errno1(Clock, Reset, RemoveBlock & StashOccupancy == 0, 						ERROR_UF1);
	Register1b 	errno2(Clock, Reset, CSSyncing_FirstCycle & Sync_SettingULH == Sync_SettingFLH, ERROR_ISC1);
	Register1b 	errno3(Clock, Reset, WriteTransfer & StashE_Address == SNULL, 					ERROR_ISC2);

	Register1b 	errANY(Clock, Reset, ERROR_UF1 | ERROR_ISC1 | ERROR_ISC2, 						ERROR_StashCore);

	assign	JTAG_StashCore =						{
														ERROR_UF1,
														ERROR_ISC1,
														ERROR_ISC2
													};

	`ifdef SIMULATION
		reg [SEAWidth-1:0] 	MS_pt;
		reg	[ORAMU-1:0]		PAddrTemp;
		integer 			i;
		// align the printouts in time
		reg					MS_FinishedWrite, SyncComplete_Delayed;
		wire				MS_StartingWrite;
		reg [STWidth-1:0]	CS_Delayed, LS;
		wire				MS_FinishedSync;

		reg                 ResetPulsed;

		reg		[SEAWidth-1:0]	PointersChecked [0:StashCapacity-1];
		integer 			pmax, p;
		reg					Evicting;
		
	`ifndef FPGA
		`define STASHC StashC1.BEHAVIORAL.core.BEHAVIORAL.Mem[MS_pt]
	`else
		`define STASHC StashC.BEHAVIORAL.Mem[MS_pt]
	`endif

		initial begin
			LS = 			ST_Reset;
			ResetPulsed =   0;
			pmax =			0;
			Evicting =		0;

			if (StashCapacity < BlocksOnPath) begin
				$display("[%m] ERROR: retarded stash capacity (%d < %d)", StashCapacity, BlocksOnPath);
				$finish;
			end
		end

		assign	MS_FinishedSync	= ~SyncComplete_Delayed & SyncComplete;

		assign	MS_StartingWrite = WriteTransfer & FirstChunk;

		always @(posedge Clock) begin
		    if (Reset)
		        ResetPulsed = 1;

			if (StartingEviction) begin 
				Evicting = 1'b1;
				pmax = 0;
			end
				
			// if (MS_StartingWrite) begin
			// 	$display("[%m @ %t] Writing [a=%x, l=%x, h=%x, sloc=%d]", $time, InPAddr, InLeaf, InMAC, StashE_Address);
			// 	if (CSOverwriting) begin
			// 		$display("\t(Overwrite)");
			// 	end
			// end

			MS_FinishedWrite <=	(CSPushing | CSOverwriting) & LastChunk_Transfer_Data;

			SyncComplete_Delayed <= SyncComplete;
			CS_Delayed <= CS;

			if (CS_Delayed != CS & CS == ST_Idle)
				LS <= CS_Delayed;

			if (StashH_WE & (^InPAddr === 1'bx | ^InLeaf === 1'bx)) begin
				$display("[%m] ERROR: writing some X header into stash");
				$finish;
			end

			if (ResetPulsed && !Reset && (^OutScanValidDump === 1'bx |
				^DumpStop === 1'bx |
				^InScanValid === 1'bx |
				^InScanDone === 1'bx |
				^InValid === 1'bx |
				^InCommandValid === 1'bx)) begin
				$display("[%m] ERROR: control signal is X");
				$finish;
			end

			if (ERROR_UF1) begin
				$display("[%m] ERROR: we removed a block from an empty stash");
				$finish;
			end

			if (ERROR_ISC1) begin
				$display("[%m] ERROR: both free/used list given same pointer during sync");
				$finish;
			end

			if (ERROR_ISC2) begin
				$display("[%m] ERROR: overwriting the SNULL entry");
				$finish;
			end

	`ifndef SIMULATION_ASIC

			if (PerAccessReset) begin
				Evicting = 1'b0;
			
				MS_pt = UsedListHead;
				i = 0;
	`ifdef SIMULATION_VERBOSE_STASH
				$display("\tUsedListHead = %d", MS_pt);
	`endif
				while (MS_pt != SNULL) begin
	`ifdef SIMULATION_VERBOSE_STASH
					$display("\t\tStashP[%d] = %d (Used? = %b)", MS_pt, StashP.BEHAVIORAL.core.BEHAVIORAL.Mem[MS_pt], `STASHC == EN_Used);
	`endif
					if (~ROAccess & `STASHC == EN_Free) begin
						$display("[ERROR] used list entry %d tagged as free", MS_pt);
						$finish;
					end

					MS_pt = StashP.BEHAVIORAL.core.BEHAVIORAL.Mem[MS_pt];
					i = i + 1;

					if (i > StashCapacity) begin
						$display("[ERROR] no terminator (UsedList)");
						$finish;
					end
				end

				// If you want to get really verbose ...

				MS_pt = FreeListHead;
				i = 0;
	`ifdef SIMULATION_VERBOSE_STASH
				$display("\tFreeListHead = %d", MS_pt);
	`endif
				while (MS_pt != SNULL) begin
	`ifdef SIMULATION_VERBOSE_STASH
					$display("\t\tStashP[%d] = %d (Used? = %b)", MS_pt, StashP.BEHAVIORAL.core.BEHAVIORAL.Mem[MS_pt], `STASHC == EN_Used);
	`endif
					MS_pt = StashP.BEHAVIORAL.core.BEHAVIORAL.Mem[MS_pt];
					i = i + 1;
					if (i > StashCapacity) begin
						$display("[ERROR] no terminator (FreeList)");
						$finish;
					end
				end
			end

			// Are the stash data structure / occupancy counts in Sync?
			if (~ROAccess & PerAccessReset) begin
				MS_pt = UsedListHead;
				i = 0;
				while (MS_pt != SNULL) begin
					MS_pt = StashP.BEHAVIORAL.core.BEHAVIORAL.Mem[MS_pt];
					i = i + 1;
				end
				if (i != StashOccupancy) begin
					$display("FAIL: Stash occupancy %d != direct inspection Occupancy %d", StashOccupancy, i);
					$finish;
				end
			end

			// No duplicate blocks allowed
			if (CSPushing & StashH_WE) begin
				MS_pt = UsedListHead;
				i = 0;
				while (MS_pt != SNULL) begin
					PAddrTemp = StashH.BEHAVIORAL.Mem[MS_pt][ORAMU+ORAML-1:ORAML];
					if (PAddrTemp == InPAddr && `STASHC == EN_Used) begin
						$display("FAIL: Tried to add block (paddr = %x) to stash but it was already present @ sloc = %d!", InPAddr, MS_pt);
						$finish;
					end
					MS_pt = StashP.BEHAVIORAL.core.BEHAVIORAL.Mem[MS_pt];
					i = i + 1;
					if (i > StashCapacity) begin
						$display("[ERROR] no terminator (UsedList)");
						$finish;
					end
				end
			end
			
	`endif // endif SIMULATION_ASIC
			
			// Check that, during the eviction, no pointer is read twice
			if (CSPeaking & LastChunk_Read) begin
				if (OutPAddr == DummyBlockAddress) begin
					$display("[%m @ %t] Reading dummy block", $time);
				end else begin
					$display("[%m @ %t] Reading [a=%x, l=%x, h=%x, sloc=%d]", $time, OutPAddr, OutLeaf, OutMAC, StashE_Address_Delayed);
					
					if (Evicting) begin
						p = 0;
						while (p < pmax) begin
							if (PointersChecked[p] == StashE_Address_Delayed) begin
								$display("[%m] ERROR: Same pointer (%d) read twice during eviction (pmax = %d).", StashE_Address_Delayed, pmax);
								$finish;
							end else begin
								//$display("[%m] OK! %d != %d", PointersChecked[p], StashE_Address_Delayed);
							end
							p = p + 1;
						end
						PointersChecked[pmax] = StashE_Address_Delayed;
					end
					
					if (Evicting) pmax = pmax + 1;
				end
			end
			
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

	// Note: Stash.v doesn't expect CommandComplete for Dumps
	assign	InCommandComplete =						(CSPushing | CSOverwriting) ? LastChunk_Transfer_Write :
													(CSPeaking) ? LastChunk_Transfer_Read :
													(CSHUpdate | CSStartSync);

	assign	InReady =								CSPushing | CSOverwriting;
	assign 	OutValid = 								CSPeaking;

	assign 	WriteTransfer = 						InReady & InValid;
	assign 	ReadTransfer = 							OutValid;
	assign 	DataTransfer = 							WriteTransfer | ReadTransfer;

	assign	FirstChunk_Transfer_Write =				FirstChunk & 	WriteTransfer & CSPushing;

	assign	LastChunk_Read =						LastChunk & 	ReadTransfer;
	assign	LastChunk_Transfer_Write =				LastChunk & 	DataTransfer;
	assign	LastChunk_Transfer_Data =				LastChunk & 	(ReadTransfer | WriteTransfer);

	assign	CSReset =								CS == ST_Reset;

	assign	CSIdle =								CS == ST_Idle;
	assign	CSPeaking = 							CS == ST_Peaking;
	assign	CSPushing = 							CS == ST_Pushing;
	assign	CSOverwriting =							CS == ST_Overwriting;
	assign	CSDumping = 							CS == ST_Dumping;
	assign	CSHUpdate =								CS == ST_UpdatingHeader;
	assign	CSStartSync =							CS == ST_StartSync;

	Register #(				.Width(					1))
				tran_latch(	.Clock(					Clock),
							.Reset(					Reset | CSIdle),
							.Set(					FirstChunk_Transfer_Write),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					CSPushing_FirstTransferred));

	assign	CSPushing_FirstCycle =					CSPushing & FirstChunk_Transfer_Write & ~CSPushing_FirstTransferred;
	assign	CSDumping_FirstCycle = 					CSDumping & ~CSDumping_Delayed;
	assign	CSSyncing_FirstCycle =					CSSyncing & ~CSSyncing_Delayed;

	assign	EnterPeak =								InCommandValid & InCommandReady & CSIdle & InCommand == SCMD_Read;
	assign	ExitPeak =								CSPeaking & ~ContinuePeak & LastChunk_Transfer_Read;

	assign	ContinuePush =							InCommandValid & InCommand == SCMD_Append & 	LastChunk_Transfer_Write;
	assign	ContinueOverwrite =						InCommandValid & InCommand == SCMD_Update &		LastChunk_Transfer_Write;
	assign	ContinuePeak =							InCommandValid & InCommand == SCMD_Read & 		LastChunk_Transfer_Read;

	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Reset;
		else CS <= 									NS;

		FirstChunk_Transfer_Delayed <=				FirstChunk_Transfer_Write;
		CSDumping_Delayed <=						CSDumping;
		CSSyncing_Delayed <=						CSSyncing;
		StashWalk_Delayed <=						StashWalk;
		StashE_Address_Delayed <=					StashE_Address;
	end

	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Reset :
				if (ResetDone)
					NS =						 	ST_Idle;
			ST_Idle :
				if (ERROR_StashCore)
					NS =							ST_Error;
				else if (InCommandValid) begin
					if (InCommand == SCMD_Append & ~CancelPushCommand)
						NS =						ST_Pushing;
					if (InCommand == SCMD_Update)
						NS =						ST_Overwriting;
					if (InCommand == SCMD_Read)
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
				else if (LastChunk_Transfer_Write | CancelPushCommand)
					NS =							ST_Idle;
			ST_Overwriting :
				if (ContinueOverwrite)
					NS =							ST_Overwriting;
				else if (LastChunk_Transfer_Write)
					NS =							ST_Idle;
			ST_Peaking :
				if (ContinuePeak)
					NS =							ST_Peaking;
				else if (LastChunk_Transfer_Read)
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
							.In(					LastChunk_Read),
							.Out(					LastChunk_Transfer_Read));
	end else begin:PASS_RDY
		assign	StreamingCRUDOp =					1'b1;
		assign	LastChunk_Transfer_Read =			OutValid;
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
	assign	ResetDone =								ResetCount == (StashCapacity - 32'd1);

	//--------------------------------------------------------------------------
	//	Core memories
	//--------------------------------------------------------------------------

	Register	#(			.Width(					SEAWidth))
				scan_A_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				InCommandValid & InCommandReady),
							.In(					InSAddr),
							.Out(					InSAddr_Reg));
	assign	ScanAddress =							(FirstChunk) ? InSAddr : InSAddr_Reg;

	Register	#(			.Width(					SEAWidth))
				push_A_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				FirstChunk_Transfer_Write),
							.In(					FreeList_Resolved),
							.Out(					FreeList_Resolved_Reg));
	assign	PushAddress =							(FirstChunk) ? FreeList_Resolved : FreeList_Resolved_Reg;

	assign	StashE_Address = 						(CSDumping) ? 	StashWalk :
													(CSPushing) ? 	PushAddress :
																	ScanAddress;
	assign	StashD_Address =						{StashE_Address, {ChnkAWidth{1'b0}}} + CurrentChunk;

	/*
		Stores data blocks.  This memory is indexed using {EntryID, EntryOffset}.
	*/
	RAM			#(			.DWidth(				BEDWidth),
							.AWidth(				SDAWidth)
							`ifndef FPGA_MEMORY , .SRAM(1) `endif)
				StashD(		.Clock(					Clock),
							.Reset(					1'b0),
							.Enable(				1'b1),
							.Write(					WriteTransfer),
							.Address(				StashD_Address),
							.DIn(					InData),
							.DOut(					StashD_DataOut));
	assign	OutData =								(StashE_Address_Delayed == SNULL) ? DummyBlock : StashD_DataOut;

	/*
		Since we always read/write blocks atomically, the offset is a simple
		counter.
	*/
	Counter		#(			.Width(					ChnkAWidth))
				chunk_cnt(	.Clock(					Clock),
							.Reset(					Reset | LastChunk_Transfer_Data),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				~LastChunk & (DataTransfer | EnterPeak) & ~ExitPeak),
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

	assign	StashHDataIn =							(EnableIV) ? {InMAC, InPAddr, InLeaf} :
																		{InPAddr, InLeaf};

	RAM			#(			.DWidth(				SHDWidth),
							.AWidth(				SEAWidth)
							`ifndef FPGA_MEMORY , .SRAM(1) `endif)
				StashH(		.Clock(					Clock),
							.Reset(					1'b0),
							.Enable(				1'b1),
							.Write(					StashH_WE),
							.Address(				StashE_Address),
							.DIn(					StashHDataIn),
							.DOut(					StashHDataOut));

	generate if (EnableIV) begin:MAC_BUFFEROUT
		assign	{OutMAC_Pre, OutPAddr_Pre, OutLeaf_Pre} = StashHDataOut;
	end else begin:MAC_NOBUFFEROUT
		assign	{OutPAddr_Pre, OutLeaf_Pre} =		StashHDataOut;
		assign	OutMAC_Pre =						DummyHash;
	end endgenerate

	assign	OutMAC =								(StashE_Address_Delayed == SNULL) ? DummyHash 			: OutMAC_Pre;
	assign	OutPAddr =								(StashE_Address_Delayed == SNULL) ? DummyBlockAddress 	: OutPAddr_Pre;
	assign	OutLeaf =								(StashE_Address_Delayed == SNULL) ? DummyLeafLabel 		: OutLeaf_Pre;

	//--------------------------------------------------------------------------
	//	Pointer table management
	//--------------------------------------------------------------------------

	assign	FreeList_Resolved =						(CSPushing_FirstCycle) ? 					FreeListHead :
																								StashP_DataOut;

	assign 	FreeListHead_New =						(CSPushing_FirstTransferred) ? 				StashP_DataOut :
													(CSSyncing_FirstCycle & Sync_SettingULH) ? 	SNULL :
																								SyncCount;
	assign 	UsedListHead_New = 						(CSPushing) ? 								FreeList_Resolved :
													(CSSyncing_FirstCycle & Sync_SettingFLH) ? 	SNULL :
																								SyncCount;

	/*
		The head of the used/free lists.
	*/
	Register	#(			.Width(					SEAWidth),
							.ResetValue(			SNULL),
							.Initial(				SNULL))
				UsedListH(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				FirstChunk_Transfer_Write | Sync_SettingULH | CSSyncing_FirstCycle),
							.In(					UsedListHead_New),
							.Out(					UsedListHead));
	Register	#(			.Width(					SEAWidth))
				FreeListH(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				FirstChunk_Transfer_Delayed | Sync_SettingFLH | CSSyncing_FirstCycle),
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
	assign	StashP_WE =								CSReset | FirstChunk_Transfer_Write | Sync_StashPWE;
	assign	StashP_EN =								~CSPushing | FirstChunk_Transfer_Write;

	SDPRAM		#(			.DWidth(				SEAWidth),
							.AWidth(				SEAWidth))
				StashP(		.Clock(					Clock),
							.Reset(					Reset),
							.Write(					StashP_EN & StashP_WE),
							.WriteAddress(			StashP_Address),
							.WriteData(				StashP_DataIn),
							.Read(					StashP_EN),
							.ReadAddress(			StashP_Address),
							.ReadData(				StashP_DataOut));

	//--------------------------------------------------------------------------
	//	Quick-remove bitvector management
	//--------------------------------------------------------------------------

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
													(CSSyncing_PreLatch) ?	SyncCount_PreLatch :
																			{SEAWidth{1'bx}};

	// This logic is for REW ORAM: we want to skip the Sync operation on RO
	// accesses and therefore need to tolerate invalid StashC entries.
	assign	StashC_ROAddress =						StashWalk;																			
																			
	assign	StashC_DataIn = 						(InScanStreaming) ? 	((InScanAccepted) ? EN_Free : EN_Used) :
													(CSHUpdate) ?			EN_Free :
													(CSReset) ? 			EN_Free :
																			{ENWidth{1'bx}};
	assign	StashC_WE =								CSReset | InScanValid | (CSHUpdate & InHeaderRemove);

	// This is a 2-read 1-write register file
	// On FPGA, this should become a LUTRAM
	// On ASIC, this should become an array of registers (not a 1-bit wide SRAM) with manual reset

	`ifndef FPGA
	// The ASIC tools can't handle multi-read port combinational memories
	
	SDPRAM		#(			.DWidth(				ENWidth),
							.AWidth(				SEAWidth),
							.RLatency(				Overclock))
				StashC1(	.Clock(					Clock),
							.Reset(					Reset),
							.Write(					StashC_WE),								
							.WriteAddress(			StashC_Address),
							.WriteData(				StashC_DataIn),
							.Read(					1'b1),
							.ReadAddress(			StashC_Address), 
							.ReadData(				StashC_DataOut));
	
	SDPRAM		#(			.DWidth(				ENWidth),
							.AWidth(				SEAWidth),
							.RLatency(				Overclock))
				StashC2(	.Clock(					Clock),
							.Reset(					Reset),
							.Write(					StashC_WE),								
							.WriteAddress(			StashC_Address),
							.WriteData(				StashC_DataIn),
							.Read(					1'b1),
							.ReadAddress(			StashC_ROAddress), 
							.ReadData(				StashC_RODataOut));	
	`else
	RAM			#(			.DWidth(				ENWidth), // 1b typically
							.AWidth(				SEAWidth),
							.RLatency(				Overclock),
							.EnableInitial(			1),
							.Initial(				{1 << SEAWidth{EN_Free}}),
							.NPorts(				2))
				StashC(		.Clock(					{2{Clock}}),
							.Reset(					{2{Reset}}),
							.Enable(				2'b11),
							.Write(					{1'b0,				StashC_WE}),
							.Address(				{StashC_ROAddress,	StashC_Address}),
							.DIn(					{{ENWidth{1'bx}},	StashC_DataIn}),
							.DOut(					{StashC_RODataOut,	StashC_DataOut}));
	`endif

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
							.Count(					StashOccupancy_Internal));

	assign	StashOccupancy =						StashOccupancy_Internal;
	assign	StashAlmostFull_Internal =				(StashOccupancy + BlocksOnPath) >= StashCapacity - 32'd1; // - 1 because we reserve last spot for SNULL
	assign	StashOverflow_Internal =				AddBlock & StashOccupancy == StashCapacity;

	assign	StashAlmostFull =						StashAlmostFull_Internal;
	assign	StashOverflow =							StashOverflow_Internal;

	//--------------------------------------------------------------------------
	//	Dumping the UsedList
	//--------------------------------------------------------------------------

	assign	StashWalk = 							(CSDumping_FirstCycle) ? UsedListHead : StashP_DataOut;

	assign	SWTerminator_Finished =					CSDumping & InScanDone;
	assign	SWTerminator_Empty =					CSDumping & CSDumping_FirstCycle & (UsedListHead == SNULL);
	assign 	StashWalk_Terminator =					SWTerminator_Finished | SWTerminator_Empty;

	generate if (Overclock == 0) begin:OC_DUMP_DLY // Note: StashP read latency must always == StashC read latency
		Register #(			.Width(					ENWidth)) // TODO change to Pipeline.v
				ROdly(		.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				1'b1),
							.In(					StashC_RODataOut),
							.Out(					StashC_RODataOut_Delayed));
	end else begin:OC_DUMP_PASS
		assign	StashC_RODataOut_Delayed =			StashC_RODataOut;
	end endgenerate

	assign	OutScanSAddr =							(CSPushing) ? FreeList_Resolved : StashWalk_Delayed;
	assign	OutScanPAddr =							(CSPushing) ? InPAddr : OutPAddr;
	assign	OutScanLeaf =							(CSPushing) ? InLeaf : OutLeaf;

	assign	OutScanAdd =							CSPushing;
	assign	OutScanStreaming =						CSPushing | CSDumping;

	assign	StillWalkingStash =						StashWalk_Delayed != SNULL;

	assign	DumpStop =								CSDumping_Delayed & CSDumping & ~StillWalkingStash & ~DumpStop_Reg;

	Register	#(			.Width(					1))
				dump_kill(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					DumpStop),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					DumpStop_Reg));
	assign	DumpStop_Pass =							DumpStop | DumpStop_Reg;

	assign	OutScanValidPush =						CSPushing & FirstChunk_Transfer_Write;
	assign	OutScanValidDump =						CSDumping_Delayed & CSDumping & StashC_RODataOut_Delayed & ~DumpStop_Pass;
	assign	OutScanValid =							OutScanValidPush | OutScanValidDump;
	assign	OutScanDone =							DumpStop_Pass;

	//--------------------------------------------------------------------------
	//	StashC <-> StashP Sync
	//--------------------------------------------------------------------------

	assign	CSSyncing_Main =						SyncState == ST_Sync_Main;
	assign	CSSyncing_CapUL =						SyncState == ST_Sync_CapUL;
	assign	CSSyncing_CapFL =						SyncState == ST_Sync_CapFL;
	assign	CSSyncing_PreLatch =					CS_Sync == ST_Sync_Main | 	CS_Sync == ST_Sync_CapUL | 		CS_Sync == ST_Sync_CapFL;
	assign	CSSyncing =								SyncState == ST_Sync_Main | SyncState == ST_Sync_CapUL | 	SyncState == ST_Sync_CapFL;
	assign	SyncComplete = 							SyncState == ST_Sync_Done;

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

	generate if (Overclock) begin:SYNC_DELAY
		always @(posedge Clock) begin
			SyncState <=							CS_Sync;
			SyncCount <=							SyncCount_PreLatch;
		end
	end else begin:SYNC_PASS
		always @( * ) begin
			SyncState =								CS_Sync;
			SyncCount =								SyncCount_PreLatch;
		end
	end endgenerate

	Counter		#(			.Width(					SEAWidth),
							.Limited(				1),
							.Limit(					StashCapacity))
				SyncCounter(.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSSyncing_PreLatch),
							.In(					{SEAWidth{1'bx}}),
							.Count(					SyncCount_PreLatch));
	assign	Sync_Terminator = 						SyncCount_PreLatch == (StashCapacity - 32'd1);

	assign	Sync_StashPUpdateSrc =					((CSSyncing_CapUL | StashC_DataOut == EN_Used) & ~CSSyncing_CapFL) ? LastULE : LastFLE;
	assign	Sync_StashPWE =							(CSSyncing_Main & ~Sync_SettingULH & ~Sync_SettingFLH) |
													(CSSyncing_CapUL & ULHSet) |
													(CSSyncing_CapFL & FLHSet);

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

