
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.v"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		Stash
//	Desc:		The Path ORAM stash.
//
//	Interface specification:
//	
//	- 	Command interface: Before sending read requests to external memory, 
//		place current leaf and current request program address on command 
//		interface.  The Stash WILL NOT be ready to receive decrypted data until 
//		the command interface asserts CommandInReady
//
//	- Leaf orientation: least significant bit is root bucket
//
//------------------------------------------------------------------------------
module Stash(
			Clock, 
			Reset,

			EvictedData,
			EvictedPAddr,
			EvictedLeaf,
			EvictedDataInValid,
			EvictedDataInReady,

			ReturnData,
			ReturnPAddr,
			ReturnLeaf,
			ReturnDataOutValid,
			ReturnDataOutReady,

			ReadData,
			ReadPAddr,
			ReadLeaf,
			ReadInValid,
			ReadInReady,

			WriteData,
			WritePAddr,
			WriteLeaf,
			WriteOutValid,
			WriteOutReady,

			CommandWritebackLeaf,
			CommandReturnPAddr,
			CommandInValid,
			CommandInReady,

			StashAlmostFull,
			StashOverflow
		);

	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	
	parameter				LeafWidth =				32,
							DataWidth =				64,
							ORAMC =					100,
							ORAMB =					512,
							ORAMU =					32,
							ORAMZ =					4,
							ORAML =					32;

	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
					
	`ifdef MACROSAFE				
		localparam			StashEntryCount =		ORAMC + ORAMZ * ORAML;
		localparam			NumChunks =				`log2(ORAMB) - `log2(DataWidth);
		localparam			ChunkAWidth =			`log2(NumChunks);
		localparam			StashEAWidth =			`log2(StashEntryCount); // addr width into entry-based memories
		localparam			StashAWidth =			`log2(StashEAWidth) + NumChunks; // addr width into data-based memories
		localparam			StashHDWidth =			ORAMU + ORAML; // stash entry header
		localparam			StashPDWidth = 			StashEAWidth + 1;
		localparam			BucketAWidth =			`log2(ORAML);
		localparam			ScanTableAWidth =		`log2(ORAML * ORAMZ);
		localparam			BucketCapacityWidth =	`log2(ORAMZ);
	`endif

	localparam				StateWidth =			3, // TODO re-encode
							STATE_Reset =			3'd0, // resetting memories
							STATE_Idle =			3'd1, // not doing work
							STATE_DataTransferEviction = 3'dx, // servicing eviction from LLC -> stash
							STATE_DataTransferScanPre =	 3'dx, // scan stash for elements already present
							STATE_DataTransferScanMain = 3'dx, // scan stream of input data
							STATE_DataTransferScanPost = 3'dx; // writeback results and reset tables
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset; 
		
	//--------------------------------------------------------------------------
	//	Data eviction interface (chip LLC -> ORAM controller)
	//--------------------------------------------------------------------------
		
	input	[DataWidth-1:0]	EvictedData;
	input	[ORAMU-1:0]		EvictedPAddr;
	input	[LeafWidth-1:0]	EvictedLeaf;
	input					EvictedDataInValid;
	output					EvictedDataInReady;
	
	//--------------------------------------------------------------------------
	//	Data return interface (ORAM controller -> LLC)
	//--------------------------------------------------------------------------
	
	output	[DataWidth-1:0]	ReturnData;
	output	[ORAMU-1:0]		ReturnPAddr;
	output	[LeafWidth-1:0]	ReturnLeaf;
	output					ReturnDataOutValid;
	input					ReturnDataOutReady;	
	
	//--------------------------------------------------------------------------
	//	ORAM read interface (external memory -> Decryption -> stash)
	//--------------------------------------------------------------------------

	input	[DataWidth-1:0]	ReadData;
	input	[ORAMU-1:0]		ReadPAddr;
	input	[LeafWidth-1:0]	ReadLeaf;
	input					ReadInValid;
	output					ReadInReady;	
	
	//--------------------------------------------------------------------------
	//	ORAM write interface (stash -> encryption -> external memory)
	//--------------------------------------------------------------------------

	output	[DataWidth-1:0]	WriteData;
	output	[ORAMU-1:0]		WritePAddr;
	output	[LeafWidth-1:0]	WriteLeaf;
	output					WriteOutValid;
	input					WriteOutReady;	
	
	//--------------------------------------------------------------------------
	//	Command interface
	//--------------------------------------------------------------------------

	input	[LeafWidth-1:0]	CommandWritebackLeaf;
	input	[ORAMU-1:0]		CommandReturnPAddr;
	input					CommandInValid;
	output					CommandInReady;

	//--------------------------------------------------------------------------
	//	Status interface
	//--------------------------------------------------------------------------

	output 					StashAlmostFull;
	output					StashOverflow;

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	wire						CSReset, CSIdle;

	wire	[StashAWidth-1:0]	StashCore_Address;
	wire	[DataWidth-1:0]		StashCore_DataIn, StashCore_DataOut;

	wire	[StashHDWidth-1:0]	StashCore_HeaderIn;
	wire	[ORAMU-1:0] 		StashCore_HeaderPAddrOut;
	wire	[ORAML-1:0]			StashCore_HeaderLeafOut;

	wire	[StashEAWidth-1:0]	StashCore_EntryAddress;

	wire	[StashEAWdith-1:0]	UsedListReadPtr;
	
	wire 	[ChunkAWidth-1:0] 	CurrentChunk;
	wire 						FirstChunk, LastChunk_Pre, LastChunk;
	
	wire					 	DataTransfer, CoreReading, CoreWriting;

	//--------------------------------------------------------------------------
	//	Top-level assigns
	//--------------------------------------------------------------------------
	
	assign	WriteData =								StashCore_DataOut;
	assign	WritePAddr = 							StashCore_HeaderPAddrOut; 
	assign	WriteLeaf = 							StashCore_HeaderLeafOut;

	assign	ReturnData =							StashCore_DataOut;
	assign	ReturnPAddr = 							StashCore_HeaderPAddrOut; 
	assign	ReturnLeaf = 							StashCore_HeaderLeafOut;

	//--------------------------------------------------------------------------
	//	Debug interface
	//--------------------------------------------------------------------------
	
/*
	assign StashAlmostFull = 						StashOccupancy >= ORAMC;

	Register	#(			.Width(					1))
				Overflow(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					(StashOccupancy == StashEntryCount) & CoreWriting),
							.Enable(				1'bx),
							.In(					1'bx),
							.Out(					StashOverflow));
*/

	/* 
		Other things to check:
		1 - elements in used list are not in free list (and vice versa)
		2 - elements in scan table must be in used list
	*/

	//--------------------------------------------------------------------------
	//	Input gates
	//--------------------------------------------------------------------------

	Register	#(			.Width(					1))
				EvictGate(	.Clock(					Clock),
							.Reset(					Reset | (CSEviction & LastChunk & CoreWriting)),
							.Set(					CSIdle & ~CommandInValid), // give scans priority?
							.Out(					EvictedDataInReady));

	Register	#(			.Width(					1))
				CommandGate(.Clock(					Clock),
							.Reset(					Reset | CSScan_Pre)),
							.Set(					CSIdle)),
							.Out(					EvictedDataInReady));

	//--------------------------------------------------------------------------
	//	Output gates
	//--------------------------------------------------------------------------

	Register	#(			.Width(					1))
				WriteGate(	.Clock(					Clock),
							.Reset(					Reset | (CSScan_Post & ScanIdleTransition)),
							.Set(					CSScan_Post & ~ScanIdleTransition)),
							.Out(					WriteOutValid));
/*
	Register	#(			.Width(					1))
				ReturnGate(	.Clock(					Clock),
							.Reset(					Reset | TODO)),
							.Set(					TODO)),
							.Out(					));	
*/
	//--------------------------------------------------------------------------
	//	State transitions
	//--------------------------------------------------------------------------
	
	reg		[StateWidth-1:0]CS, NS;

	wire						ResetDone;
	wire	[StashEAWidth-1:0]	ResetCount;

	wire CommandTransfer, EvictionTransfer, ReadTransfer, WriteTransfer;

	assign 	EvictionTransfer = 						EvictedDataInValid & EvictedDataInReady;
	assign 	CommandTransfer = 						CommandInValid & CommandInReady;
	assign 	ReadTransfer = 							ReadInValid & ReadInReady;
	assign 	WriteTransfer = 						WriteOutValid & WriteOutReady;

	wire CSEviction, CSScan; // TODO add additional states
	assign 	CSReset = 								CS == STATE_Reset;
	assign	CSIdle =								CS == STATE_Idle;
/*	assign 	CSEviction =							CS == STATE_DataTransferEviction;
	assign 	CSScan_Pre =							CS == STATE_DataTransferScan_Pre;
	assign 	CSScan_Main =							CS == STATE_DataTransferScan_Main;
	assign 	CSScan_Post =							CS == STATE_DataTransferScan_Post;
*/
	
	always @(posedge Clock)
		if (Reset) CS <= 							STATE_Reset;
		else CS <= 									NS;

	always @( * ) begin
		NS = 										CS;
		case (CS)
			STATE_Reset : 
				if (ResetDone) 
					NS =						 	STATE_Idle;
/*			STATE_Idle :
				if (EvictionTransfer)
					NS =							STATE_DataTransferEviction;
				else if (CommandTransfer)
					NS =							STATE_DataTransferScan_Pre;
			STATE_DataTransferScan_Pre :
				if ()
			STATE_DataTransferScan_Pre :
				if ()
			STATE_DataTransferScan_Main :
				if ()
			STATE_DataTransfer_Writeback :
				if ()
*/
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
								.In(				{{1'bx}}),
								.Count(				ResetCount));
	assign	ResetDone =								ResetCount == (StashEntryCount - 1);

	//--------------------------------------------------------------------------
	//	Stash memory core
	//
	//	Handles primitive read/write operations at block granularity
	//--------------------------------------------------------------------------

	assign CoreReading = 							WriteTransfer;
	assign CoreWriting = 							ReadTransfer | EvictionTransfer;
	assign DataTransfer = 							CoreReading | CoreWriting;

	assign	StashCore_EntryAddress = (CoreWriting) ? 	FreeListHeadPtr : 
														UsedListReadPtr;
	assign	StashCore_Address =							{EntryAddress, {ChunkAWidth{1'b0}}} + CurrentChunk;
	assign 	StashCore_DataIn = 	(EvictionTransfer) ? 	EvictedData : 	ReadData; 
	assign 	StashCore_HeaderIn = (EvictionTransfer) ? 	{EvictedPAddr, 	EvictedLeaf} : 
														{ReadPAddr, 	ReadLeaf};

	// stash data memory
	RAM			#(			.DWidth(				DataWidth),
							.AWidth(				StashAWidth))
				StashD(		.Clock(					Clock),
							.Reset(					1'b0),
							.Enable(				1'b1),
							.Write(					CoreWriting),
							.Address(				StashCore_Address),
							.DIn(					StashCore_DataIn),
							.DOut(					StashCore_DataOut));

	// stash entry header information (leaf + paddr per entry)
	RAM			#(			.DWidth(				StashHDWidth),
							.AWidth(				StashEAWdith))
				StashH(		.Clock(					Clock),
							.Reset(					1'b0),
							.Enable(				1'b1),
							.Write(					CoreWriting & FirstChunk),
							.Address(				StashCore_EntryAddress),
							.DIn(					StashCore_HeaderIn),
							.DOut(					{StashCore_HeaderPAddrOut, StashCore_HeaderLeafOut}));

	Counter		#(			.Width(					ChunkAWidth))
				ChunkCount(	.Clock(					Clock),
							.Reset(					Reset | (LastChunk & DataTransfer)),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DataTransfer),
							.In(					{ChunkAWidth{1'bx}}),
							.Count(					CurrentChunk));

	assign FirstChunk =								CurrentChunk == {ChunkAWidth{1'b0}};
	assign LastChunk_Pre = 							CurrentChunk == NumChunks - 1;
	assign LastChunk =								CurrentChunk == NumChunks;

	//--------------------------------------------------------------------------
	//	Stash management
	//
	//	Handles where to read/write
	//--------------------------------------------------------------------------
	
/*
	wire 	[StashPDWidth-1:0]	UsedListHeadPtr, FreeListHeadPtr;
	wire 	[StashPDWidth-1:0]	NewUsedListHeadPtr, NewFreeListHeadPtr;

	wire	[StashEAWidth-1:0] 	StashOccupancy;
	
	StashPAddress
	StashPDataOut
	StashPDataIn
	
	Register	#(			.Width(					StashPDWidth))
				UsedListH(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				LastChunk_Pre & DataTransfer),
							.In(					NewUsedListHeadPtr),
							.Out(					UsedListHeadPtr));

	assign NewFreeListHeadPtr =						(CoreWriting) ? StashPDataOut : 	UsedListHeadPtr; // CHECK - symmetry assumption
	assign NewUsedListHeadPtr = 					(CoreWriting) ? FreeListHeadPtr : 	StashPDataOut; // CHECK - symmetry assumption

	Register	#(			.Width(					StashPDWidth),
							.ResetValue(			{1'b1, {StashPDWidth-1{1'b0}}}))
				FreeListH(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				LastChunk & DataTransfer),
							.In(					NewFreeListHeadPtr),
							.Out(					FreeListHeadPtr));

	UDCounter	#(			.Width(					StashEAWidth))
				ElementCount(.Clock(				Clock),
							.Reset(					Reset),
							.Up(					LastChunk & CoreWriting),
							.Down(					LastChunk & CoreReading),
							.In(					{StashEAWidth{1'bx}}),
							.Count(					StashOccupancy));

													
	// stash entry pointers (shared by used/free list)
	RAM			#(			.DWidth(				StashPDWidth),
							.AWidth(				StashEAWdith))
				StashP(		.Clock(					Clock),
							.Reset(					),
							.Enable(				1'b1),
							.Write(					LastChunk),
							.Address(				StashPAddress),
							.DIn(					StashPDataIn),
							.DOut(					StashPDataOut));

	assign	StashPAddress =	(LastChunk_Pre & CoreWriting) ? FreeListHeadPtr : 
							(LastChunk_Pre & CoreReading) ? UsedListHeadPtr : // CHECK - symmetry assumption
													StashPDataOut ; 
	assign	StashPDataIn = 	(CSReset) ? 			{ResetCount + 1 < StashEntryCount, ResetCount + 1} : 
							(CoreWriting) ? 			UsedListHeadPtr : 
													FreeListHeadPtr; // CHECK - symmetry assumption
	*/
							
	//--------------------------------------------------------------------------
	//	Stash scan table fill logic
	//--------------------------------------------------------------------------

	/*

	// TODO register for return data

	WatchForPAddr, CurrentLeaf

	Scan_CurrentBucketOccupancy

	Scan_CurrentLevel
	Scan_CurrentBlock

	Scan_LastLevel
	Scan_LastBlock

	ScanIdleTransition

	Scan_CurrentPAddr
	Scan_CurrentLeaf

	ReturnPtr


	Scan_CurrentPAddr
	Scan_CurrentLeaf
	Scan_CurrentPtr

	CommonSubpath
	CompatibleBuckets
	CompatibleBuckets_Space
	HighestLevel_Onehot
	HighestLevel_Bin

	BucketCountAddress
	BucketCountDataIn

	ScanTableAddress
	ScanTableDataIn

	Scan_CommitCurrentBlock

	wire [ORAML-1:0] FullMask;

	Register	#(			.Width(					StashHDWidth))
				CurrentCmd(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				CommandTransfer),
							.In(					{CommandWritebackLeaf, 	CommandReturnPAddr}),
							.Out(					{WatchForPAddr, 		CurrentLeaf}));

	// stores a point to the requested block, once we find it.  We will return 
	// it at the end
	Register	#(			.Width(					StashEAWidth))
				MatchedBlk(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				WatchForPAddr == Scan_CurrentPAddr), // TODO put data transfer restriction on this?
							.In(					Scan_CurrentPtr),
							.Out(					ReturnPtr));

	// magic stash logic
	Reverse		#(			.Width(					ORAML))
				Rev1(		.In(					Scan_CurrentLeaf ^ CurrentLeaf), 
							.Out(					CommonSubpath));
	assign	CompatibleBuckets = 					(CommonSubpath & (~CommonSubpath + 1)) - 1;
	Reverse		#(			.Width(					ORAML))
				Rev2(		.In(					CompatibleBuckets ^ ~FullMask), 
							.Out(					CompatibleBuckets_Space));
	Reverse		#(			.Width(					ORAML))
				Rev2(		.In(					CompatibleBuckets_Space & (~CompatibleBuckets_Space + 1)), 
							.Out(					HighestLevel_Onehot));
	OneHot2Bin	#(			.Width(					ORAML))
				OH2B(		.OneHot(				HighestLevel_Onehot), 
							.Bin(					HighestLevel_Bin));

	assign 	BucketCountAddress = (CSScan_Post) ? 	Scan_CurrentLevel : 
													HighestLevel_Bin;
	assign	BucketCountDataIn =						Scan_CurrentBucketOccupancy + 1;

	assign Scan_CommitCurrentBlock =  & |HighestLevel_Onehot;

	// how many blocks in each bucket of ScanTable are valid?
	RAM			#(			.DWidth(				BucketCapacityWidth),
							.AWidth(				BucketAWidth),
							.RLatency(				0)) // simplifies the timing
				BucketCounts(.Clock(				Clock),
							.Reset(					),
							.Enable(				1'b1),
							.Write(					Scan_CommitCurrentBlock),
							.Address(				BucketCountAddress),
							.DIn(					BucketCountDataIn),
							.DOut(					Scan_CurrentBucketOccupancy));

	assign ScanTableAddress = 	(CSScan_Post) ?		{Scan_CurrentLevel, {BucketCapacityWidth{1'b0}}} + Scan_CurrentBlock : 
													{HighestLevel_Bin, {BucketCapacityWidth{1'b0}}} + Scan_CurrentBucketOccupancy;
	assign ScanTableDataIn =						Scan_CurrentPtr;

	// pointers to blocks in stash memory that will be written back
	RAM			#(			.DWidth(				StashEAWdith),
							.AWidth(				ScanTableAWidth))
				ScanTable(	.Clock(					Clock),
							.Reset(					),
							.Enable(				1'b1),
							.Write(					Scan_CommitCurrentBlock),
							.Address(				ScanTableAddress),
							.DIn(					Scan_CurrentPtr),
							.DOut(					));

	Register	#(			.Width(					ORAML))
				FullMaskReg(.Clock(					Clock),
							.Reset(					Reset | ScanIdleTransition),
							.Set(					1'b0),
							.Enable(				Scan_CommitCurrentBlock),
							.In(					FullMask | (HighestLevel_Onehot & (Scan_CurrentBucketOccupancy == (ORAMZ-1)))),
							.Out(					FullMask));

	*/

	//--------------------------------------------------------------------------
	//	Write interface to AES encrypt
	//--------------------------------------------------------------------------
	
	/*

	// current bucket being written back
	Counter		#(			.Width(					BucketAWidth))
				BucketCount(.Clock(					Clock),
							.Reset(					Reset | ),
							.Enable(				CSScan_Post & ),
							.In(					{ChunkAWidth{1'bx}}),
							.Count(					Scan_CurrentLevel));

	// current block in current bucket being written back
	Counter		#(			.Width(					BucketCapacityWidth))
				BlockCount(	.Clock(					Clock),
							.Reset(					Reset | ),
							.Enable(				CSScan_Post & ),
							.In(					{ChunkAWidth{1'bx}}),
							.Count(					Scan_CurrentBlock));

	assign	Scan_LastLevel =						Scan_CurrentLevel == ORAML-1; // TODO make this ORAML configurable
	assign	Scan_LastBlock =						Scan_CurrentBlock == Scan_CurrentBucketOccupancy-1;
	assign	ScanIdleTransition = 					Scan_LastLevel & Scan_LastBlock & CoreReading;

	*/

	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

