
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMBackend
//	Desc:		The stash, AES, address generation, and throughput back-pressure 
//				logic (e.g., dummy access control, R^(E+1)W pattern control)
//
//	TODO
//		- Read command
//		- Read/remove command
//		- Update command
//		- AES
//		- REW ORAM
//		- Integrity verification
//		- Timing obfuscation
//==============================================================================
module PathORAMBackend #(	`include "PathORAM.vh", `include "DDR3SDRAM.vh",
							`include "AES.vh", `include "Stash.vh") (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 						Clock, Reset,
	
	//--------------------------------------------------------------------------
	//	Frontend Interface
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] 	Command,
	input	[ORAMU-1:0]			PAddr,
	input	[ORAML-1:0]			CurrentLeaf, // If Command == Append, this is XX 
	input	[ORAML-1:0]			RemappedLeaf,
	input						CommandValid,
	output 						CommandReady,

	// TODO set CommandReady = 0 if LoadDataReady = 0 (i.e., the front end can't take our result!)
	
	output	[FEDWidth-1:0]		LoadData,
	output						LoadValid,
	input 						LoadReady,

	input	[FEDWidth-1:0]		StoreData,
	input 						StoreValid,
	output 						StoreReady,
	
	//--------------------------------------------------------------------------
	//	DRAM Interface
	//--------------------------------------------------------------------------

	output	[DDRAWidth-1:0]		DRAMCommandAddress,
	output	[DDRCWidth-1:0]		DRAMCommand,
	output						DRAMCommandValid,
	input						DRAMCommandReady,
	
	input	[DDRDWidth-1:0]		DRAMReadData,
	input						DRAMReadDataValid,
	
	output	[DDRDWidth-1:0]		DRAMWriteData,
	output	[DDRMWidth-1:0]		DRAMWriteMask,
	output						DRAMWriteDataValid,
	input						DRAMWriteDataReady
	);
		
	//------------------------------------------------------------------------------
	//	Constants
	//------------------------------------------------------------------------------ 

	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	
	localparam					BigUWidth =			ORAMU * ORAMZ,
								BigLWidth =			ORAML * ORAMZ;
								
	localparam					SpaceRemaining =	BktHSize_RndBits - BktHSize_RawBits;
	
	localparam					STWidth =			3,
								ST_Initialize =		3'd0,
								ST_Idle =			3'd1,
								ST_Append =			3'd2,
								ST_StartRead =		3'd3,
								ST_PathRead =		3'd4,
								ST_StartWriteback =	3'd5,
								ST_PathWriteback =	3'd6;
								
	//------------------------------------------------------------------------------
	//	Wires & Regs
	//------------------------------------------------------------------------------ 

	// Control logic
	
	wire						AllResetsDone;
	reg		[STWidth-1:0]		CS, NS;
	wire						CSInitialize, CSIdle, CSAppend, CSStartRead, 
								CSStartWriteback, CSPathRead, CSPathWriteback;
	wire						AccessIsDummy;
	
	wire						AppendComplete, PathReadComplete, Stash_PathWritebackComplete;
	
	wire	[ORAML-1:0]			DummyLeaf;
	
	// Read pipeline

	wire						PathBuffer_InReady;

	wire						PathBuffer_OutValid, PathBuffer_OutReady;
	wire	[DDRDWidth-1:0]		PathBuffer_OutData;
		
	wire						HeaderDownShift_InValid, HeaderDownShift_InReady;
	wire						DataDownShift_InValid, DataDownShift_InReady;
		
	wire	[BktBSTWidth-1:0]	BucketReadCtr;
	wire						ReadProcessingHeader;	
	wire						BucketReadCtr_Reset, ReadBucketTransition;	
	
	wire	[ORAMZ-1:0] 		HeaderDownShift_ValidBits;
	wire	[BigUWidth-1:0]		HeaderDownShift_PAddrs;
	wire	[BigLWidth-1:0]		HeaderDownShift_Leaves;
		
	wire						ReadBlockIsValid, BlockPresent;
	
	wire	[BEDWidth-1:0]		DataDownShift_OutData;
	wire						DataDownShift_OutValid, DataDownShift_OutReady;
	wire						BlockReadValid, BlockReadReady;
	
	wire	[ORAMU-1:0]			HeaderDownShift_OutPAddr; 
	wire	[ORAML-1:0]			HeaderDownShift_OutLeaf;
	wire						HeaderDownShift_OutValid;		
	
	wire	[PBEDWidth-1:0]		PathReadCtr;
	wire						IncrementReadCtr;
	
	wire						BlockReadCtr_Reset;
	wire	[BlkBEDWidth-1:0] 	BlockReadCtr; 	
	wire 						InPath_BlockReadComplete;	
	
	// Writeback pipeline

	wire						Stash_BlockReadComplete;
	
	wire	[ORAMU-1:0]			HeaderUpShift_InPAddr; 
	wire	[ORAML-1:0]			HeaderUpShift_InLeaf;
	wire						HeaderUpShift_OutValid, HeaderUpShift_OutReady;
	wire						HeaderUpShift_InReady;
	
	wire	[BEDWidth-1:0]		DataUpShift_InData;
	wire						DataUpShift_InValid, DataUpShift_InReady;
	wire	[DDRDWidth-1:0]		DataUpShift_OutData;
	wire						DataUpShift_OutValid, DataUpShift_OutReady;
	
	wire	[ORAMZ-1:0] 		HeaderUpShift_ValidBits;
	wire	[BigUWidth-1:0]		HeaderUpShift_PAddrs;
	wire	[BigLWidth-1:0]		HeaderUpShift_Leaves;	
	
	wire						WritebackBlockIsValid;
	
	wire 						WritebackProcessingHeader;		
	wire	[DDRDWidth-1:0]		UpShift_HeaderFlit, BucketBuf_OutData;
	wire						BucketBuf_OutValid, BucketBuf_OutReady;
							
	wire						BucketWritebackValid;
	wire	[BktBSTWidth-1:0]	BucketWritebackCtr;
	wire						BucketWritebackCtr_Reset, WritebackBucketTransition;
							
	wire	[DDRDWidth-1:0]		UpShift_DRAMWriteData;
	wire	[DDRMWidth-1:0]		UpShift_DRAMWriteMask;
	
	// Stash & frontend
	
	wire						Stash_StartScanOp, Stash_StartWritebackOp;
	
	wire	[BEDWidth-1:0]		FEStash_EvictData;						
	wire						FEStash_EvictDataValid, FEStash_EvictDataReady;
	
	wire	[BEDWidth-1:0]		StashFE_ReadData;
	wire						StashFE_ReadDataValid, StashFE_ReadDataReady;
	
	wire						Stash_ResetDone;
	
	wire	[BECMDWidth-1:0] 	FEStash_Command;
	wire	[ORAMU-1:0]			FEStash_PAddr;
	wire	[ORAML-1:0]			FEStash_CurrentLeaf, FEStash_RemappedLeaf;
	wire						FEStash_CommandValid, FEStash_CommandReady;
	
	wire						FEStash_EvictBlockValid, FEStash_EvictBlockReady;

	wire						Stash_BlockWriteComplete;
	
	// ORAM initialization
	
	wire	[DDRAWidth-1:0]		DRAMInit_DRAMCommandAddress;
	wire	[DDRCWidth-1:0]		DRAMInit_DRAMCommand;
	wire						DRAMInit_DRAMCommandValid, DRAMInit_DRAMCommandReady;

	wire	[DDRDWidth-1:0]		DRAMInit_DRAMWriteData;
	wire	[DDRMWidth-1:0]		DRAMInit_DRAMWriteMask;
	wire						DRAMInit_DRAMWriteDataValid, DRAMInit_DRAMWriteDataReady;
	
	wire						DRAMInit_Done;
	
	// Address generator
	
	wire	[DDRAWidth-1:0]		AddrGen_DRAMCommandAddress;
	wire	[DDRCWidth-1:0]		AddrGen_DRAMCommand;
	wire						AddrGen_DRAMCommandValid, AddrGen_DRAMCommandReady;
	
	wire						AddrGen_Reading;
	
	wire	[ORAML-1:0]			AddrGen_Leaf;
	wire						AddrGen_InReady, AddrGen_InValid;

	//------------------------------------------------------------------------------
	//	Simulation checks
	//------------------------------------------------------------------------------

	`ifdef SIMULATION
		reg [STWidth-1:0] CS_Delayed;
	
		initial begin
			if (BEDWidth > DDRDWidth) begin
				$display("[%m @ %t] ERROR: BEDWidth should never be > DDRDWidth", $time);
				$stop;
			end
		end
		
		always @(posedge Clock) begin
			CS_Delayed <= CS;
		
			if (CS_Delayed != CS) begin
				if (CSStartRead)
					$display("[%m @ %t] Backend: start access, dummy = %b, command = %x, leaf = %x", $time, AccessIsDummy, FEStash_Command, AddrGen_Leaf);
				if (CSAppend)
					$display("[%m @ %t] Backend: start append", $time);
			end
		
			if (StashOverflow) begin
				// This is checked in StashCore.v ...
			end
			
			if (~PathBuffer_InReady & DRAMReadDataValid) begin
				$display("[%m @ %t] ERROR: DRAM was sending data and we had no space", $time);
				$stop;
			end

		end
	`endif
	
	//------------------------------------------------------------------------------
	//	Control logic
	//------------------------------------------------------------------------------
	
	assign	CSInitialize =							CS == ST_Initialize;
	assign	CSIdle =								CS == ST_Idle;
	assign	CSAppend =								CS == ST_Append;
	assign	CSStartRead =							CS == ST_StartRead;
	assign	CSStartWriteback =						CS == ST_StartWriteback;
	assign	CSPathRead =							CS == ST_PathRead;
	assign	CSPathWriteback =						CS == ST_PathWriteback;
	
	assign	AllResetsDone =							Stash_ResetDone & DRAMInit_Done;

	assign	Stash_StartScanOp =						CSStartRead;
	assign	Stash_StartWritebackOp =				CSStartWriteback;
	
	assign	FEStash_CommandReady =					AppendComplete | 
													(CSPathWriteback & Stash_PathWritebackComplete & ~AccessIsDummy);

	// Don't allow evictions when we only have space for a path
	assign	FEStash_EvictDataReady = 				FEStash_EvictBlockReady & 	FEStash_CommandValid & ~StashAlmostFull;
	assign	FEStash_EvictBlockValid = 				FEStash_EvictDataValid & 	FEStash_CommandValid & ~StashAlmostFull;
	
	assign	AddrGen_InValid =						CSStartRead | CSStartWriteback; 
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Initialize;
		else CS <= 									NS;
	end
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Initialize : 
				if (AllResetsDone) 
					NS =						 	ST_Idle;
			ST_Idle :
				if (StashAlmostFull) // highest priority
					NS =							ST_StartRead;
				else if (FEStash_CommandValid & 	FEStash_Command == BECMD_Append) // appends aren't much work --- do them first
					NS =							ST_Append;
				else if (FEStash_CommandValid & (	FEStash_Command == BECMD_Update | 
													FEStash_Command == BECMD_Read | 
													FEStash_Command == BECMD_ReadRmv))
					NS =							ST_StartRead;
			ST_Append :
				if (AppendComplete)
					NS = 							ST_Idle;
			ST_StartRead : 
				if (AddrGen_InReady)
					NS =							ST_PathRead;
			ST_PathRead : 							
				if (PathReadComplete)
					NS =							ST_StartWriteback;
			ST_StartWriteback :
				if (AddrGen_InReady)
					NS =							ST_PathWriteback;
			ST_PathWriteback : 
				if (Stash_PathWritebackComplete)
					NS =							ST_Idle;
		endcase
	end
	
	Register	#(			.Width(					1))
				dummy_reg(	.Clock(					Clock),
							.Reset(					Reset | (CSIdle & ~StashAlmostFull)),
							.Set(							 CSIdle & StashAlmostFull),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					AccessIsDummy));
	
	//------------------------------------------------------------------------------
	//	Frontend interface
	//------------------------------------------------------------------------------	

	FIFORegister #(			.Width(					BECMDWidth + ORAMU + ORAML*2))
				cmd_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{Command,			PAddr, 			CurrentLeaf, 		RemappedLeaf}),
							.InValid(				CommandValid),
							.InAccept(				CommandReady),
							.OutData(				{FEStash_Command,	FEStash_PAddr,	FEStash_CurrentLeaf,FEStash_RemappedLeaf}),
							.OutSend(				FEStash_CommandValid),
							.OutReady(				FEStash_CommandReady));
	
	// TODO we may not need these expensive shifts if we can incrementally write 
	// FEDWidth chunks to the stash; check: are they really that expensive?  If we 
	// can pack them into 2 SLICEM's each, then its no problem
	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				BEDWidth))
				st_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				StoreData),
							.InValid(				StoreValid),
							.InAccept(				StoreReady),
							.OutData(				FEStash_EvictData),
							.OutValid(				FEStash_EvictDataValid),
							.OutReady(				FEStash_EvictDataReady));
	
	FIFOShiftRound #(		.IWidth(				BEDWidth),
							.OWidth(				FEDWidth))
				ld_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				StashFE_ReadData),
							.InValid(				StashFE_ReadDataValid),
							.InAccept(				StashFE_ReadDataReady),
							.OutData(				LoadData),
							.OutValid(				LoadValid),
							.OutReady(				LoadReady));
	
	//------------------------------------------------------------------------------
	//	Random leaf generator
	//------------------------------------------------------------------------------ 
	
	// TODO use AES for this
	
	Counter		#(			.Width(					ORAML))
				SyncCounter(.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSStartRead),
							.In(					{ORAML{1'bx}}),
							.Count(					DummyLeaf));
	
	//------------------------------------------------------------------------------
	//	Address generation & initialization
	//------------------------------------------------------------------------------

	assign	AddrGen_Reading = 						CSStartRead;
	assign	AddrGen_Leaf =							(AccessIsDummy) ? DummyLeaf : FEStash_CurrentLeaf;
	
    AddrGen #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth))
			addr_gen(		.Clock(					Clock),
							.Reset(					Reset | CSInitialize),
							.Start(					AddrGen_InValid), 
							.Ready(					AddrGen_InReady),
							.RWIn(					AddrGen_Reading),
							.BHIn(					1'b0), // TODO change when we do REW ORAM
							.leaf(					AddrGen_Leaf),
							.CmdReady(				AddrGen_DRAMCommandReady),
							.CmdValid(				AddrGen_DRAMCommandValid),
							.Cmd(					AddrGen_DRAMCommand),
							.Addr(					AddrGen_DRAMCommandAddress));
							
	DRAMInitializer #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
			dram_init(		.Clock(					Clock),
							.Reset(					Reset),
							.DRAMCommandAddress(	DRAMInit_DRAMCommandAddress),
							.DRAMCommand(			DRAMInit_DRAMCommand),
							.DRAMCommandValid(		DRAMInit_DRAMCommandValid),
							.DRAMCommandReady(		DRAMInit_DRAMCommandReady),
							.DRAMWriteData(			DRAMInit_DRAMWriteData),
							.DRAMWriteMask(			DRAMInit_DRAMWriteMask),
							.DRAMWriteDataValid(	DRAMInit_DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMInit_DRAMWriteDataReady),
							.Done(					DRAMInit_Done));
							
	//------------------------------------------------------------------------------
	//	[Read path] Buffers and down shifters
	//------------------------------------------------------------------------------
		
	// Buffers the whole incoming path (... this is a lazy design?)
	// NOTE: This buffer requires ~1% of the LUT RAM on the chip
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				PathSize_DRBursts))
				in_path_buf(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMReadData),
							.InValid(				DRAMReadDataValid),
							.InAccept(				PathBuffer_InReady), // debugging
							.OutData(				PathBuffer_OutData),
							.OutSend(				PathBuffer_OutValid),
							.OutReady(				PathBuffer_OutReady));
	
	// Count where we are in a bucket (so we can determine when we are at a header)
	Counter		#(			.Width(					BktBSTWidth))
				in_bkt_cnt(	.Clock(					Clock),
							.Reset(					Reset | ReadBucketTransition),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				PathBuffer_OutValid & PathBuffer_OutReady),
							.In(					{BktBSTWidth{1'bx}}),
							.Count(					BucketReadCtr));	
	CountCompare #(			.Width(					BktBSTWidth),
							.Compare(				BktSize_DRBursts - 1))
				in_bkt_cmp(	.Count(					BucketReadCtr), 
							.TerminalCount(			BucketReadCtr_Reset));
	assign	ReadBucketTransition =					BucketReadCtr_Reset & PathBuffer_OutValid & PathBuffer_OutReady;
	
	// Per-bucket header/payload arbitration
	assign	ReadProcessingHeader =					BucketReadCtr < BktHSize_DRBursts;
	assign	HeaderDownShift_InValid =				PathBuffer_OutValid & ReadProcessingHeader;
	assign	DataDownShift_InValid =					PathBuffer_OutValid & ~ReadProcessingHeader;
	assign	PathBuffer_OutReady =					(ReadProcessingHeader) ? HeaderDownShift_InReady : DataDownShift_InReady;
	
	assign	HeaderDownShift_ValidBits =				PathBuffer_OutData[IVEntropyWidth+ORAMZ-1:IVEntropyWidth];
	assign	HeaderDownShift_PAddrs =				PathBuffer_OutData[BktHULStart+ORAMZ*ORAMU-1:BktHULStart];
	assign	HeaderDownShift_Leaves =				PathBuffer_OutData[BktHULStart+ORAMZ*(ORAMU+ORAML)-1:BktHULStart+ORAMZ*ORAMU];
	
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
							.SOut(					HeaderDownShift_OutLeaf));

	FIFOShiftRound #(		.IWidth(				DDRDWidth),
							.OWidth(				BEDWidth))
				in_D_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				PathBuffer_OutData),
							.InValid(				DataDownShift_InValid),
							.InAccept(				DataDownShift_InReady),
							.OutData(				DataDownShift_OutData),
							.OutValid(				DataDownShift_OutValid),
							.OutReady(				DataDownShift_OutReady));

	//------------------------------------------------------------------------------
	//	[Read path] Dummy block handling
	//------------------------------------------------------------------------------

	assign	InPath_BlockReadComplete =				Stash_BlockWriteComplete | BlockReadCtr_Reset;
	assign	BlockReadValid =						DataDownShift_OutValid & HeaderDownShift_OutValid & (ReadBlockIsValid & BlockPresent);
	assign	DataDownShift_OutReady =				(BlockPresent) ? ((ReadBlockIsValid) ? BlockReadReady : 1'b1) : 1'b0; 
	
	FIFOShiftRound #(		.IWidth(				ORAMZ),
							.OWidth(				1))
				in_V_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderDownShift_ValidBits),
							.InValid(				HeaderDownShift_InValid),
							.InAccept(				), // will be the same as in_L_shft
							.OutData(			    ReadBlockIsValid),
							.OutValid(				BlockPresent),
							.OutReady(				InPath_BlockReadComplete));	
	
	Counter		#(			.Width(					BlkBEDWidth))
				in_blk_cnt(	.Clock(					Clock),
							.Reset(					Reset | BlockReadCtr_Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DataDownShift_OutValid & DataDownShift_OutReady & ~ReadBlockIsValid & BlockPresent),
							.In(					{BlkBEDWidth{1'bx}}),
							.Count(					BlockReadCtr));	
	CountCompare #(			.Width(					BlkBEDWidth),
							.Compare(				BlkSize_BEDChunks - 1))
				in_blk_cmp(	.Count(					BlockReadCtr), 
							.TerminalCount(			BlockReadCtr_Reset));
	
	//------------------------------------------------------------------------------
	//	[Read path] Path counters
	//------------------------------------------------------------------------------	
	
	// count number of real/dummy blocks on path and signal the end of the path 
	// read when we read a whole path's worth 	
	
	assign	IncrementReadCtr =						DataDownShift_OutValid & DataDownShift_OutReady;
	
	Counter		#(			.Width(					PBEDWidth))
				in_path_cnt(.Clock(					Clock),
							.Reset(					Reset | CSIdle),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				IncrementReadCtr & ~PathReadComplete),
							.In(					{PBEDWidth{1'bx}}),
							.Count(					PathReadCtr));
	CountCompare #(			.Width(					PBEDWidth),
							.Compare(				PathSize_BEDChunks))
				in_path_cmp(.Count(					PathReadCtr), 
							.TerminalCount(			PathReadComplete));
	
	//------------------------------------------------------------------------------
	//	Stash
	//------------------------------------------------------------------------------
	
	Stash	#(				.StashCapacity(			StashCapacity),
							.StashOutBuffering(		2), // this should be good enough ...
							.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
							
			stash(			.Clock(					Clock),
							.Reset(					Reset),
							.ResetDone(				Stash_ResetDone),
							
							.AccessLeaf(			AddrGen_Leaf),
							.AccessPAddr(			FEStash_PAddr),
							.AccessIsDummy(			AccessIsDummy),
							
							.StartScan(				Stash_StartScanOp),  
							.StartWriteback(		Stash_StartWritebackOp),
							
							.ReturnData(			StashFE_ReadData),
							.ReturnPAddr(			), // not connected
							.ReturnLeaf(			), // not connected
							.ReturnDataOutValid(	StashFE_ReadDataValid),
							.ReturnDataOutReady(	StashFE_ReadDataReady),
							.BlockReturnComplete(	), // not connected
							
							// TODO add flag to indicate append?
							.EvictData(				FEStash_EvictData),
							.EvictPAddr(			FEStash_PAddr),
							.EvictLeaf(				FEStash_RemappedLeaf),
							.EvictDataInValid(		FEStash_EvictBlockValid),
							.EvictDataInReady(		FEStash_EvictBlockReady),
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
							.PathReadComplete(		Stash_PathWritebackComplete),
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		)); // debugging	
	
	//------------------------------------------------------------------------------
	//	[Writeback path] Buffers and up shifters
	//------------------------------------------------------------------------------
	
	// Translate:
	//		{Z{ULD}} (the stash's format) 
	//		to 
	//		{ {Z{U}}, {Z{L}}, {Z{L}} } (the DRAM's format)
	
	// TODO change the stash interface so that dummies are single bit signals
	assign	WritebackBlockIsValid =					HeaderUpShift_InPAddr != DummyBlockAddress;
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (~HeaderUpShift_InReady & Stash_BlockReadComplete) begin
				$display("[%m @ %t] ERROR: Illegal signal combination (data will be lost)", $time);
				$stop;
			end
		end
	`endif
	
	FIFOShiftRound #(		.IWidth(				ORAMU),
							.OWidth(				BigUWidth))
				out_U_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderUpShift_InPAddr),
							.InValid(				Stash_BlockReadComplete),
							.InAccept(				HeaderUpShift_InReady),
							.OutData(			    HeaderUpShift_PAddrs),
							.OutValid(				HeaderUpShift_OutValid),
							.OutReady(				HeaderUpShift_OutReady));
	ShiftRegister #(		.PWidth(				BigLWidth),
							.SWidth(				ORAML))
				out_L_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				Stash_BlockReadComplete), 
							.SIn(					HeaderUpShift_InLeaf), 
							.POut(					HeaderUpShift_Leaves));							
	ShiftRegister #(		.PWidth(				ORAMZ),
							.SWidth(				1))
				out_V_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				Stash_BlockReadComplete), 
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
	
	// TODO add real initialization vector when we add AES
	assign	UpShift_HeaderFlit =					{	{SpaceRemaining{1'bx}},
														HeaderUpShift_Leaves,
														HeaderUpShift_PAddrs,
														{IVEntropyWidth{1'bx}}, 
														{BktHWaste_ValidBits{1'b0}},
														HeaderUpShift_ValidBits, 
														{IVEntropyWidth{1'bx}}	};
	assign	UpShift_DRAMWriteData =					(WritebackProcessingHeader) ? UpShift_HeaderFlit : BucketBuf_OutData;
	assign	UpShift_DRAMWriteMask =					{DDRMWidth{1'b0}}; // TODO this will change with REW ORAM

	assign	BucketWritebackValid =					(WritebackProcessingHeader & 	HeaderUpShift_OutValid) | 
													(~WritebackProcessingHeader & 	BucketBuf_OutValid);

	Counter		#(			.Width(					BktBSTWidth))
				out_bkt_cnt(.Clock(					Clock),
							.Reset(					Reset | WritebackBucketTransition),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				BucketWritebackValid & DRAMWriteDataReady),
							.In(					{BktBSTWidth{1'bx}}),
							.Count(					BucketWritebackCtr));	
	CountCompare #(			.Width(					BktBSTWidth),
							.Compare(				BktSize_DRBursts - 1))
				out_bkt_cmp(.Count(					BucketWritebackCtr), 
							.TerminalCount(			BucketWritebackCtr_Reset));
	assign	WritebackBucketTransition =				BucketWritebackCtr_Reset & BucketWritebackValid & DRAMWriteDataReady;
	
	//------------------------------------------------------------------------------
	//	DRAM interface multiplexing
	//------------------------------------------------------------------------------

	assign	DRAMCommandAddress =					(CSInitialize) ? DRAMInit_DRAMCommandAddress 	: AddrGen_DRAMCommandAddress;
	assign	DRAMCommand =							(CSInitialize) ? DRAMInit_DRAMCommand 			: AddrGen_DRAMCommand;
	assign	DRAMCommandValid =						(CSInitialize) ? DRAMInit_DRAMCommandValid 		: AddrGen_DRAMCommandValid; 
	assign	AddrGen_DRAMCommandReady =				DRAMCommandReady & ~CSInitialize;
	assign	DRAMInit_DRAMCommandReady =				DRAMCommandReady & CSInitialize;
	assign	DRAMInit_DRAMWriteDataReady =			DRAMWriteDataReady & CSInitialize;
	
	assign	DRAMWriteData =							(CSInitialize) ? DRAMInit_DRAMWriteData : UpShift_DRAMWriteData;
	assign	DRAMWriteMask =							(CSInitialize) ? DRAMInit_DRAMWriteMask : UpShift_DRAMWriteMask;
	assign	DRAMWriteDataValid =					(CSInitialize) ? DRAMInit_DRAMWriteDataValid : BucketWritebackValid;
	
	assign	DRAMInit_DRAMWriteDataReady = 			CSInitialize & DRAMWriteDataReady;										
	assign	BucketBuf_OutReady =					~CSInitialize & ~WritebackProcessingHeader & DRAMWriteDataReady;
	assign	HeaderUpShift_OutReady =				~CSInitialize & WritebackProcessingHeader & DRAMWriteDataReady;
		
	//------------------------------------------------------------------------------	
endmodule
//------------------------------------------------------------------------------
