
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.v"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		StashCore
//	Desc:		Implements core stash operations		
//
//	Commands:
//		Push - 	add element to stash.  This is only used on a path read --- NOT 
//				when a dirty LLC block gets evicted.
//		Peak - 	read (do not remove) element from stash
//		Overwrite - update the data for a block currently in the stash
//		Dump - 	scan all elements in stash and fill table that indicates the 
//				highest position in the ORAM tree, where each block can be 
//				written back to.  This operation destroys the stash pointer 
//				memory and must be followed by a Sync command.
//		Sync - 	Reconstruct the stash pointer memory
//------------------------------------------------------------------------------
module StashCore(
			Clock, 
			Reset,
			PerAccessReset,
			ResetDone,
			
			InCommand,
			InSAddr,
			InCommandValid,
			InCommandReady,

			InData,
			InPAddr,
			InLeaf,
			InValid,
			InReady,

			OutData,
			OutPAddr,
			OutLeaf,
			OutValid,

			OutScanPAddr,
			OutScanLeaf,
			OutScanSAddr,
			OutScanValid,

			InScanSAddr,
			InScanAccepted,
			InScanValid,
			
			PrepNextPeak,
			UpdatesComplete
	);

	//--------------------------------------------------------------------------
	//	Parameters & constants
	//--------------------------------------------------------------------------
	
	`include "StashCore.constants"

	localparam				STWidth =				3,
							ST_Reset =				3'd0,
							ST_Idle = 				3'd1,
							ST_Pushing = 			3'd2, // write, add
							ST_Overwriting = 		3'd3, // overwrite current entry
							ST_Peaking =			3'd4, // read, do not remove
							ST_Dumping =			3'd5; // stash scan [rename?]

	localparam				ENWidth =				1,
							EN_Free =				1'b0,
							EN_Used =				1'b1;

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 						Clock, Reset, PerAccessReset;
	output						ResetDone;

	//--------------------------------------------------------------------------
	//	Command interface
	//--------------------------------------------------------------------------
		
	input	[CMDWidth-1:0] 		InCommand;
	input	[StashEAWidth-1:0]	InSAddr;
	input						InCommandValid;
	output 						InCommandReady;

	//--------------------------------------------------------------------------
	//	Input interface
	//--------------------------------------------------------------------------
	
	input	[DataWidth-1:0]		InData;
	input	[ORAMU-1:0]			InPAddr;
	input	[ORAML-1:0]			InLeaf;
	input						InValid;
	output 						InReady;

	//--------------------------------------------------------------------------
	//	Output interface
	//--------------------------------------------------------------------------
	
	output	[DataWidth-1:0]		OutData;
	output	[ORAMU-1:0]			OutPAddr;
	output	[ORAML-1:0]			OutLeaf;
	output 						OutValid;

	//--------------------------------------------------------------------------
	//	Scan interface
	//--------------------------------------------------------------------------
	
	output	[ORAMU-1:0]			OutScanPAddr;
	output	[ORAML-1:0]			OutScanLeaf;
	output	[StashEAWidth-1:0]	OutScanSAddr;
	output						OutScanValid;

	input	[StashEAWidth-1:0]	InScanSAddr;
	input						InScanAccepted;
	input						InScanValid;

	//--------------------------------------------------------------------------
	//	Hacks that help get the job done ...
	//--------------------------------------------------------------------------
	
	output						PrepNextPeak;
	output						UpdatesComplete;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	reg		[STWidth-1:0]		CS, NS;
	wire						CSReset, CSIdle, CSPeaking, CSPushing, CSOverwriting, CSDumping, CSSyncing;
	wire 						CNSPushing, CNSOverwriting;

	wire						PerAccessReset;
	
	wire	[StashEAWidth-1:0]	ResetCount;

	wire	[ORAMU-1:0]			OutPAddr_Pre;
	
	wire	[DataWidth-1:0]		StashD_DataOut;
	wire						WriteTransfer, DataTransfer, Add_Terminator;
	wire						Transfer_Terminator, Transfer_Terminator_Pre;

	wire	[StashAWidth-1:0]	StashD_Address;
	wire	[StashEAWidth-1:0]	StashE_Address;
	reg		[StashEAWidth-1:0]	StashE_Address_Delayed;
	wire						FirstChunk, LastChunk_Pre, LastChunk;

	wire 	[ChunkAWidth-1:0]	CurrentChunk;

	wire 	[StashEAWidth-1:0]	UsedListHead, FreeListHead;
	wire 	[StashEAWidth-1:0]	UsedListHead_New, FreeListHead_New;

	wire	[StashEAWidth-1:0] 	StashOccupancy;
	
	wire	[StashEAWidth-1:0]	StashP_Address, StashP_DataOut, StashP_DataIn;
	wire						StashP_WE;
	
	wire	[StashEAWidth-1:0]	StashC_Address;
	wire	[ENWidth-1:0] 		StashC_DataIn, StashC_DataOut;
	wire						StashC_WE;
	
	wire	[StashEAWidth-1:0]	StashWalk;
	wire						StashWalk_Terminator;
	wire 						OutScanValidCutoff;
	wire						OutScanValidPush, OutScanValidDump;
	
	wire						Dump_Preempt, Dump_Phase2;
	wire	[StashEAWidth-1:0]	LastDumpAddress;

	wire	[StashEAWidth-1:0]	SyncCount, Sync_StashPUpdateSrc, LastULE, LastFLE;
	wire						ULHSet, FLHSet;
	wire						Sync_SettingULH, Sync_SettingFLH;
	wire						Sync_FoundUsedElement, Sync_FoundFreeElement;
	wire						Sync_Terminator;
	wire						CSSyncing_Pre, Sync_Complete;
	
	// Derived signals

	reg		[StashEAWidth-1:0] 	StashWalk_Delayed;
	reg							CSPeaking_Delayed, CSDumping_Delayed,
								CSSyncing_Delayed,
								InScanValid_Delayed, OutScanValid_Delayed;
	wire						CSDumping_FirstCycle, CSSyncing_FirstCycle;

	initial begin
		CS = ST_Reset;
		CSPeaking_Delayed = 1'b0;
		CSDumping_Delayed = 1'b0;
	end

	//--------------------------------------------------------------------------
	//	Hardware debug interface
	//--------------------------------------------------------------------------
	
	Register	#(			.Width(					1))
				Overflow(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					(StashOccupancy == BlockCount) & WriteTransfer),
							.Enable(				1'bx),
							.In(					1'bx),
							.Out(					StashOverflow));

	//--------------------------------------------------------------------------
	//	Software debugging
	//--------------------------------------------------------------------------
	
	/* 
		Other things to check:
		1 - elements in used list are not in free list (and vice versa)
		2 - no element with same program address appears twice
		3 - after sync, each list is of expected length
	*/

	`ifdef MODELSIM
		reg [StashEAWidth-1:0] 	MS_pt;
		integer 				i;
		// align the printouts in time
		reg						MS_FinishedWrite, MS_StartingWrite, MS_FinishedSync;
		reg [STWidth-1:0]		CS_Delayed, LS;
		
		initial begin
			LS = 				ST_Reset;
		end
		
		always @(posedge Clock) begin
			if (MS_StartingWrite) begin
				$display("[%m @ %t] Writing [a=%x, l=%x]", $time, InPAddr, InLeaf);
				if (CSOverwriting) begin
					$display("\t(Overwrite)");
				end
			end

			MS_FinishedWrite <=	(CSPushing | CSOverwriting) & Transfer_Terminator;
			MS_StartingWrite <= WriteTransfer & FirstChunk;
			MS_FinishedSync <= CSSyncing & Sync_Terminator;
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
			
			if (CSSyncing_FirstCycle & Sync_SettingULH == Sync_SettingFLH) begin
				$display("ERROR: both free/used list given same pointer during sync");
				$stop;
			end
			
			if (MS_FinishedSync) begin
				MS_pt = UsedListHead;
				i = 0;
				$display("\tUsedListHead = %d", MS_pt);
				while (MS_pt != SNULL) begin
					$display("\t\tStashP[%d] = %d (Used? = %b)", MS_pt, StashP.Mem[MS_pt], StashC.Mem[MS_pt]);
					MS_pt = StashP.Mem[MS_pt];
					i = i + 1;
					if (StashC.Mem[MS_pt] == EN_Free) begin
						$display("[ERROR] used list entry tagged as free");
						$stop;
					end
					
					if (i > BlockCount) begin
						$display("[ERROR] no terminator (UsedList)");
						$stop;
					end
				end
				//
				MS_pt = FreeListHead;
				i = 0;
				$display("\tFreeListHead = %d", MS_pt);
				while (MS_pt != SNULL) begin
					$display("\t\tStashP[%d] = %d (Used? = %b)", MS_pt, StashP.Mem[MS_pt], StashC.Mem[MS_pt]);
					MS_pt = StashP.Mem[MS_pt];
					i = i + 1;
					if (i > BlockCount) begin
						$display("[ERROR] no terminator (FreeList)");
						$stop;
					end
				end
			end

			if (OutValid)
				$display("[%m @ %t] Reading %d", $time, OutData);
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
	*/
	assign	InCommandReady =						(CSPeaking | CSPushing | CSOverwriting) ? Transfer_Terminator :
													(CSDumping) ? CSDumping_FirstCycle : // this is so we will see push commands in the queue
													1'b0;

	assign	OutData =								StashD_DataOut;
			
	assign	InReady =								CNSPushing | CNSOverwriting;
	assign 	OutValid = 								CSPeaking_Delayed;

	assign 	WriteTransfer = 						InReady & InValid;
	assign 	ReadTransfer = 							CSPeaking; // will we have valid data out in the next cycle?
	assign 	DataTransfer = 							WriteTransfer | ReadTransfer;

	assign	Add_Terminator =						LastChunk & WriteTransfer & CSPushing;
	assign	Transfer_Terminator =					LastChunk & DataTransfer;
	assign	Transfer_Terminator_Pre =				LastChunk_Pre & DataTransfer;
	assign	Dump_Preempt =							InCommand == CMD_Push & InValid & InCommandValid;
	
	// We need this cycle early because the stash scan table is a synchronous memory
	assign	PrepNextPeak =							Transfer_Terminator_Pre;
	assign	UpdatesComplete =						Sync_Terminator;
	
	assign	CSReset =								CS == ST_Reset;

	assign	CSIdle =								CS == ST_Idle;
	assign	CSPeaking = 							CS == ST_Peaking; 
	assign	CSPushing = 							CS == ST_Pushing;
	assign	CSOverwriting =							CS == ST_Overwriting;
	assign	CSDumping = 							CS == ST_Dumping;

	/* 	
		Mealy machine to decrease rd->wr/etc op turnover time.  This design 
		allows us to move to read/write/etc immediately, which is arguably 
		better than waiting 1 cycle initially (Moore machine) and then 
		avoiding turnover to the Idle stage for a cycle after each read/write. 
	*/
	assign	CNSPushing = 							CSPushing | (NS == ST_Pushing); 
	assign 	CNSOverwriting =						CSOverwriting | (NS == ST_Overwriting);
	
	assign	CSDumping_FirstCycle = 					CSDumping & ~CSDumping_Delayed;
	assign	CSSyncing_FirstCycle =					CSSyncing & ~CSSyncing_Delayed;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Reset;
		else CS <= 									NS;

		CSPeaking_Delayed <=						CSPeaking;
		CSDumping_Delayed <=						CSDumping;
		CSSyncing_Delayed <=						CSSyncing;
		StashWalk_Delayed <=						StashWalk;
		InScanValid_Delayed <=						InScanValid;
		OutScanValid_Delayed <=						OutScanValid;
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
					if (InCommand == CMD_Push & InValid)
						NS =						ST_Pushing;
					if (InCommand == CMD_Overwrite & InValid)
						NS =						ST_Overwriting;
					if (InCommand == CMD_Peak)
						NS =						ST_Peaking;
					if (InCommand == CMD_Dump)
						NS =						ST_Dumping;
				end
			ST_Pushing :
				if (Transfer_Terminator)
					NS =							ST_Idle;
			ST_Overwriting :
				if (Transfer_Terminator)
					NS =							ST_Idle;
			ST_Peaking :
				if (InCommand != CMD_Peak)
					NS =							ST_Idle;
			ST_Dumping : 
				// TODO need to put data being processed by ScanTable somewhere if ScanTableLatency > 0
				if (Dump_Preempt)
					NS = 							ST_Pushing;
				else if (StashWalk_Terminator)
					NS =							ST_Idle;
		endcase
	end

	Register	#(			.Width(					1))
				SyncOn(		.Clock(					Clock),
							.Reset(					Reset | Sync_Terminator),
							.Set(					CSPeaking),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					CSSyncing_Pre));
	Register	#(			.Width(					1))
				SyncDone(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					Sync_Terminator),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					Sync_Complete));
	assign	CSSyncing = 							CSSyncing_Pre & ~Sync_Complete;
	
	//--------------------------------------------------------------------------
	//	Reset logic
	//--------------------------------------------------------------------------

	Counter			#(			.Width(				StashEAWidth))
					InitCounter(.Clock(				Clock),
								.Reset(				Reset),
								.Set(				1'b0),
								.Load(				1'b0),
								.Enable(			~ResetDone),
								.In(				{StashEAWidth{1'bx}}),
								.Count(				ResetCount));
	assign	ResetDone =								ResetCount == (BlockCount - 1);

	//--------------------------------------------------------------------------
	//	Core memories
	//--------------------------------------------------------------------------

	assign	StashE_Address = 						(CSPeaking | CNSOverwriting) ? InSAddr : 
													(CSDumping) ? StashWalk : 
													FreeListHead;
	assign	StashD_Address =						{StashE_Address, {ChunkAWidth{1'b0}}} + CurrentChunk;

	/* 
		Stores data blocks.  This memory is indexed using 
		{EntryID, EntryOffset}. 
	*/
	RAM			#(			.DWidth(				DataWidth),
							.AWidth(				StashAWidth))
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
	Counter		#(			.Width(					ChunkAWidth))
				ChunkCount(	.Clock(					Clock),
							.Reset(					Reset | Transfer_Terminator),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				~LastChunk & (DataTransfer | CSPeaking)),
							.In(					{ChunkAWidth{1'bx}}),
							.Count(					CurrentChunk));

	assign FirstChunk =								CurrentChunk == {ChunkAWidth{1'b0}};
	assign LastChunk_Pre = 							CurrentChunk == NumChunks - 2;
	assign LastChunk =								CurrentChunk == NumChunks - 1;

	/*
		For each data block, store its program address / leaf label.
	*/
	RAM			#(			.DWidth(				StashHDWidth),
							.AWidth(				StashEAWidth))
				StashH(		.Clock(					Clock),
							.Reset(					1'b0),
							.Enable(				1'b1),
							.Write(					WriteTransfer & FirstChunk), // TODO latch this in on last chunk?
							.Address(				StashE_Address),
							.DIn(					{InPAddr, 		InLeaf}),
							.DOut(					{OutPAddr_Pre, 	OutLeaf}));
	assign	OutPAddr =								(StashE_Address_Delayed == SNULL) ? DummyBlockAddress : OutPAddr_Pre;

	//--------------------------------------------------------------------------
	//	Management
	//--------------------------------------------------------------------------

	assign FreeListHead_New =						(CNSPushing) ? 	StashP_DataOut : 
													(CSSyncing) ? 	SyncCount : 
													(CSSyncing_FirstCycle & Sync_SettingULH) ? SNULL :	
													SyncCount;
	assign UsedListHead_New = 						(CNSPushing) ? 	FreeListHead : 
													(CSSyncing_FirstCycle & Sync_SettingFLH) ? SNULL :	
													SyncCount;
																	
	/*
		The head of the used/free lists.
	*/
	Register	#(			.Width(					StashEAWidth),
							.ResetValue(			SNULL))
				UsedListH(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				Add_Terminator | Sync_SettingULH | CSSyncing_FirstCycle),
							.In(					UsedListHead_New),
							.Out(					UsedListHead));
	Register	#(			.Width(					StashEAWidth))
				FreeListH(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				Add_Terminator | Sync_SettingFLH | CSSyncing_FirstCycle),
							.In(					FreeListHead_New),
							.Out(					FreeListHead));
							
	/* 
		StashP: pointers that make up both the used list/free list. 
	*/
	
	assign	StashP_Address = 						(CSReset) ? 	ResetCount : 
													(CNSPushing) ? 	FreeListHead : // read at end of second to last write cycle
													(CSDumping) ? 	StashWalk : 
													(CSSyncing) ? 	Sync_StashPUpdateSrc : 
																	{StashEAWidth{1'bx}};
	assign	StashP_DataIn = 						(CSReset) ? 	ResetCount + 1 :
													(CNSPushing) ? 	UsedListHead : 
													(CSSyncing) ? 	SyncCount : 
																	{StashEAWidth{1'bx}};
	assign	StashP_WE =								CSReset | Add_Terminator | (CSSyncing & ~Sync_SettingULH & ~Sync_SettingFLH);
		
	RAM			#(			.DWidth(				StashEAWidth),
							.AWidth(				StashEAWidth))
				StashP(		.Clock(					Clock),
							.Reset(					/* not connected */),
							.Enable(				1'b1),
							.Write(					StashP_WE),
							.Address(				StashP_Address),
							.DIn(					StashP_DataIn),
							.DOut(					StashP_DataOut));

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

	assign	StashC_Address = 						(CSPushing | CSDumping) ? InScanSAddr : 
													(CSReset) ? 	ResetCount : 
													(CSSyncing) ?	SyncCount : 
																	{StashEAWidth{1'bx}};
																	
	assign	StashC_DataIn = 						(CSPushing | CSDumping) ? ((InScanAccepted) ? EN_Free : EN_Used) :
													(CSReset) ? 	EN_Free :  
																	{ENWidth{1'bx}};
	assign	StashC_WE =								CSReset | InScanValid;
		
	RAM			#(			.DWidth(				ENWidth), // 1b typically
							.AWidth(				StashEAWidth),
							.RLatency(				0))
				StashC(		.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				1'b1),
							.Write(					StashC_WE),
							.Address(				StashC_Address),
							.DIn(					StashC_DataIn),
							.DOut(					StashC_DataOut));

	// We could also just update this at the end of the access ...
	UDCounter	#(			.Width(					StashEAWidth))
				ElementCount(.Clock(				Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Up(					InScanValid & ~InScanAccepted),
							.Down(					InScanValid & InScanAccepted),
							.In(					{StashEAWidth{1'bx}}),
							.Count(					StashOccupancy));

	//--------------------------------------------------------------------------
	//	Dumping the UsedList
	//--------------------------------------------------------------------------

	/*
		Connect the UsedList scanning logic to the ScanTable logic.  The 
		termination condition is based on the ScanInValid logic (NOT 
		ScanOutValid) so that we can add pipelining to StashScanTable as needed.
	*/

	assign	StashWalk = 							(CSDumping_FirstCycle & Dump_Phase2) ? LastDumpAddress : 
													(CSDumping_FirstCycle & ~Dump_Phase2) ? UsedListHead : 
													StashP_DataOut;
	assign 	StashWalk_Terminator =					CSDumping & ((~InScanValid & InScanValid_Delayed) | // we've stopped getting scan data
																(CSDumping_FirstCycle & StashWalk == SNULL)); // the stash was empty to begin with

	assign	OutScanSAddr =							(CSPushing) ? FreeListHead : StashWalk_Delayed;
	assign	OutScanPAddr =							(CSPushing) ? InPAddr : OutPAddr;
	assign	OutScanLeaf =							(CSPushing) ? InLeaf : OutLeaf;
	
	assign	OutScanValidPush =						CSPushing & Add_Terminator;
	assign	OutScanValidDump =						CSDumping_Delayed & OutScanSAddr != SNULL & 
													~OutScanValidCutoff & ~Dump_Preempt;
	assign	OutScanValid =							OutScanValidPush | OutScanValidDump;
	
	Register	#(			.Width(					1)) // brings valid low a cycle earlier
				SawLast(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					~OutScanValid & OutScanValid_Delayed),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					OutScanValidCutoff));

	/*
		We need to be able to stall the dump in the middle when data comes back 
		from DRAM.  The dump can be restarted in the middle using another Dump 
		command.
	*/

	Register	#(			.Width(					1))
				DumpStage(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					Dump_Preempt | StashWalk_Terminator),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					Dump_Phase2));
							
	// if we get interrupted, save where we were in the used list
	Register	#(			.Width(					StashEAWidth))
				LastAddrReg(.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Enable(				CSDumping & (Dump_Preempt | StashWalk_Terminator)),
							.In(					StashWalk),
							.Out(					LastDumpAddress));
							
	//--------------------------------------------------------------------------
	//	StashC <-> StashP Sync
	//--------------------------------------------------------------------------

	/*
		After determining which ORAM blocks to writeback to the tree, re-create 
		the used/free lists based on the contents in StashC.  This circuit 
		implements the following psuedo-code:
		
		Set UsedListHead/FreeListHead to SNULL (both empty)
		for SyncCount from 0...BlockCount:
			if StashC[SyncCount] == EN_Used:
				if UsedListHead == SNULL:
					UsedListHead = SyncCount
				else:
					StashP[LastULE] = i
				LastULE = SyncCount	
			else: ... same logic for free list	
	*/
	
	Counter		#(			.Width(					StashEAWidth))
				SyncCounter(.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSSyncing),
							.In(					{StashEAWidth{1'bx}}),
							.Count(					SyncCount));

	assign	Sync_Terminator = 						SyncCount == (BlockCount - 1);
	
	assign	Sync_StashPUpdateSrc =					(StashC_DataOut == EN_Used) ? LastULE : LastFLE;

	assign	Sync_FoundUsedElement =					CSSyncing & StashC_DataOut == EN_Used;
	assign	Sync_FoundFreeElement =					CSSyncing & StashC_DataOut == EN_Free;

	assign	Sync_SettingULH =						CSSyncing & ~ULHSet & Sync_FoundUsedElement;
	assign	Sync_SettingFLH =						CSSyncing & ~FLHSet & Sync_FoundFreeElement;	
	
	Register	#(			.Width(					1))
				ULHSetReg(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					Sync_FoundUsedElement),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ULHSet));
	Register	#(			.Width(					StashEAWidth))
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
	Register	#(			.Width(					StashEAWidth))
				LastFLEReg(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Enable(				Sync_FoundFreeElement),
							.In(					SyncCount),
							.Out(					LastFLE));

	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

