
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.v"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		StashCore
//	Desc:		
//------------------------------------------------------------------------------
module StashCore(
			Clock, 
			Reset,

			InData,
			InValid,
			InReady,

			OutData,
			OutValid,

			InCommand,
			InPAddr,
			InLeaf,
			InSAddr,
			InCommandValid,
			InCommandReady,

			OutScanPAddr,
			OutScanLeaf,
			OutScanSAddr,
			OutScanValid,

			InScanSAddr,
			InScanAccepted,
			InScanValid
		);

	//--------------------------------------------------------------------------
	//	Parameters & constants
	//--------------------------------------------------------------------------
	
	`include "StashCore.constants"

	localparam				STWidth =				3,
							ST_Reset =				3'd0,
							ST_Idle = 				3'd1,
							ST_Peaking = 			3'd2,
							ST_Pushing =			3'd3,
							ST_Dumping =			3'd4,
							ST_Syncing =			3'd5;

	localparam				ENWidth =				1,
							EN_Free =				1'b0,
							EN_Used =				1'b1;

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 						Clock, Reset; 
		
	//--------------------------------------------------------------------------
	//	Input interface
	//--------------------------------------------------------------------------
	
	input	[DataWidth-1:0]		InData;
	input						InValid;
	output 						InReady;

	input	[CMDWidth-1:0] 		InCommand;
	input	[ORAMU-1:0]			InPAddr;
	input	[ORAML-1:0]			InLeaf;
	input	[StashEAWidth-1:0]	InSAddr;
	input						InCommandValid;
	output 						InCommandReady;

	//--------------------------------------------------------------------------
	//	Output interface
	//--------------------------------------------------------------------------
	
	output	[DataWidth-1:0]		OutData;
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
	//	Wires & Regs
	//--------------------------------------------------------------------------

	reg		[STWidth-1:0]		CS, NS;
	wire						CSPeaking, CSPushing, CSDumping, CSSyncing;
	wire 						CSReset, CNSPeaking, CNSPushing;

	wire	[StashEAWidth-1:0]	ResetCount;
	wire						ResetDone;

	wire	[DataWidth-1:0]		StashD_DataOut;
	wire						WriteTransfer, DataTransfer, Transfer_Terminator;

	wire	[StashAWidth-1:0]	StashD_Address;
	wire	[StashEAWidth-1:0]	StashE_Address;
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
	wire						StashWalk_Terminator, StashWalk_Writeback;
	wire 						OutScanValidCutoff;
	
	wire	[StashEAWidth-1:0]	SyncCount, Sync_StashPUpdateSrc, LastULE, LastFLE;
	wire						ULHSet, FLHSet;
	wire						Sync_SettingULH, Sync_SettingFLH;
	wire						Sync_FoundUsedElement, Sync_FoundFreeElement;
	wire						Sync_Terminator;

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
		3 - no element with same program address appears twice
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
			end

			MS_FinishedWrite <=	CSPushing & Transfer_Terminator;
			MS_StartingWrite <= WriteTransfer & FirstChunk;
			MS_FinishedSync <= CSSyncing & Sync_Terminator;
			CS_Delayed <= CS;
			
			if (CS_Delayed != CS & CS == ST_Idle)
				LS <= 			CS_Delayed;
			
			if (LS == ST_Dumping & CS != ST_Syncing & CS != ST_Idle) begin
				// This is so the block count gets updated ...
				$display("ERROR: must perform sync after dump");
				$stop;
			end
			
			if (CSSyncing_FirstCycle & Sync_SettingULH == Sync_SettingFLH) begin
				$display("ERROR: both free/used list given same pointer during sync");
				$stop;
			end
			
			if (MS_FinishedWrite | MS_FinishedSync) begin
				MS_pt = UsedListHead;
				i = 0;
				$display("Write; new element count = %d", StashOccupancy);
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
	assign	InCommandReady =						(CSPeaking | CSPushing) ? Transfer_Terminator :
													(CSDumping) ? StashWalk_Terminator : 
													(CSSyncing) ? Sync_Terminator : 1'b0;

	assign	OutData =								StashD_DataOut;	
	
	assign	InReady =								CNSPushing;
	assign 	OutValid = 								CS == ST_Peaking | CSPeaking_Delayed;

	assign 	WriteTransfer = 						InReady & InValid;
	assign 	ReadTransfer = 							OutValid;
	assign 	DataTransfer = 							WriteTransfer | ReadTransfer;

	assign	Transfer_Terminator =					LastChunk & DataTransfer;

	assign	CSReset =								CS == ST_Reset;

	assign	CSPeaking = 							CS == ST_Peaking; 
	assign	CSPushing = 							CS == ST_Pushing; 
	assign	CSDumping = 							CS == ST_Dumping;
	assign	CSSyncing =								CS == ST_Syncing;

	/* Mealy machine to decrease rd->wr/etc op turnover time */
	assign	CNSPeaking = 							CSPeaking | (NS == ST_Peaking); 
	assign	CNSPushing = 							CSPushing | (NS == ST_Pushing); 
	
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
					if (InCommand == CMD_Peak)
						NS =						ST_Peaking;
					if (InCommand == CMD_Dump)
						NS =						ST_Dumping;
					if (InCommand == CMD_Sync)
						NS =						ST_Syncing;
				end
			ST_Peaking :
				if (Transfer_Terminator)
					NS =							ST_Idle;
			ST_Pushing :
				if (Transfer_Terminator)
					NS =							ST_Idle;
			ST_Dumping : 
				if (StashWalk_Terminator)
					NS =							ST_Idle;
			ST_Syncing :
				if (Sync_Terminator)
					NS =							ST_Idle;
		endcase
	end

	//--------------------------------------------------------------------------
	//	Reset logic
	//--------------------------------------------------------------------------

	Counter			#(			.Width(				StashEAWidth))
					InitCounter(.Clock(				Clock),
								.Reset(				Reset),
								.Set(				1'b0),
								.Load(				1'b0),
								.Enable(			CSReset),
								.In(				{StashEAWidth{1'bx}}),
								.Count(				ResetCount));
	assign	ResetDone =								ResetCount == (BlockCount - 1);

	//--------------------------------------------------------------------------
	//	Core memories
	//--------------------------------------------------------------------------

	assign	StashE_Address = 						(CNSPeaking) ? InSAddr : 
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
							.Enable(				~LastChunk & (DataTransfer | CNSPeaking)),
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
							.Write(					WriteTransfer & FirstChunk),
							.Address(				StashE_Address),
							.DIn(					{InPAddr, 		InLeaf}),
							.DOut(					{OutScanPAddr, 	OutScanLeaf}));

	//--------------------------------------------------------------------------
	//	Management
	//--------------------------------------------------------------------------

	assign	StashP_Address = 						(CSReset) ? 	ResetCount : 
													(CNSPushing) ? 	FreeListHead : 
													(CSDumping) ? 	StashWalk : 
													(CSSyncing) ? 	Sync_StashPUpdateSrc : 
																	{StashEAWidth{1'bx}};
	assign	StashP_DataIn = 						(CSReset) ? 	ResetCount + 1 :
													(CNSPushing) ? 	UsedListHead : 
													(CSSyncing) ? 	SyncCount : 
																	{StashEAWidth{1'bx}};
	assign	StashP_WE =								CSReset | LastChunk | (CSSyncing & ~Sync_SettingULH & ~Sync_SettingFLH);
																	
	assign	StashC_Address = 						(CSReset) ? 	ResetCount : 
													(CNSPushing) ? 	FreeListHead : 
													(CSDumping) ? 	InScanSAddr : 
													(CSSyncing) ?	SyncCount : 
																	{StashEAWidth{1'bx}};
	assign	StashC_DataIn = 						(CSReset) ? 	EN_Free :
													(CNSPushing) ? 	EN_Used : 
													(CSDumping) ? 	EN_Free : 
																	{ENWidth{1'bx}};
	assign	StashC_WE =								CSReset | LastChunk | StashWalk_Writeback;
	
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
							.Enable(				LastChunk & WriteTransfer | Sync_SettingULH | CSSyncing_FirstCycle),
							.In(					UsedListHead_New),
							.Out(					UsedListHead));
	Register	#(			.Width(					StashEAWidth))
				FreeListH(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				LastChunk & WriteTransfer | Sync_SettingFLH | CSSyncing_FirstCycle),
							.In(					FreeListHead_New),
							.Out(					FreeListHead));
							
	/* 
		StashP: pointers that make up both the used list/free list. 
	*/
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
	RAM			#(			.DWidth(				ENWidth),
							.AWidth(				StashEAWidth),
							.RLatency(				0))
				StashC(		.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				1'b1),
							.Write(					StashC_WE),
							.Address(				StashC_Address),
							.DIn(					StashC_DataIn),
							.DOut(					StashC_DataOut));

	UDCounter	#(			.Width(					StashEAWidth))
				ElementCount(.Clock(				Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Up(					LastChunk & WriteTransfer),
							.Down(					StashWalk_Writeback),
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

	assign	StashWalk = 							(CSDumping_FirstCycle) ? UsedListHead : StashP_DataOut;
	assign 	StashWalk_Terminator =					~InScanValid & InScanValid_Delayed;

	assign	StashWalk_Writeback =					InScanValid & InScanAccepted;

	assign	OutScanSAddr =							StashWalk_Delayed;
	assign	OutScanValid =							CSDumping_Delayed & OutScanSAddr != SNULL & ~OutScanValidCutoff;
	Register	#(			.Width(					1)) // brings valid low a cycle earlier
				SawLast(	.Clock(					Clock),
							.Reset(					Reset | ~CSDumping),
							.Set(					~OutScanValid & OutScanValid_Delayed),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					OutScanValidCutoff));

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
							.Reset(					Reset | Sync_Terminator),
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
							.Reset(					Reset | Sync_Terminator),
							.Set(					Sync_FoundUsedElement),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ULHSet));
	Register	#(			.Width(					StashEAWidth))
				LastULEReg(	.Clock(					Clock),
							.Reset(					Reset | Sync_Terminator),
							.Set(					1'b0),
							.Enable(				Sync_FoundUsedElement),
							.In(					SyncCount),
							.Out(					LastULE));

	Register	#(			.Width(					1))
				FLHSetReg(	.Clock(					Clock),
							.Reset(					Reset | Sync_Terminator),
							.Set(					Sync_FoundFreeElement),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					FLHSet));
	Register	#(			.Width(					StashEAWidth))
				LastFLEReg(	.Clock(					Clock),
							.Reset(					Reset | Sync_Terminator),
							.Set(					1'b0),
							.Enable(				Sync_FoundFreeElement),
							.In(					SyncCount),
							.Out(					LastFLE));

	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

