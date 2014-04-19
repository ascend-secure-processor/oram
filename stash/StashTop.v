
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		StashTop
//	Desc:		The stash and associated funnels and counters
//==============================================================================
module StashTop(
	Clock, Reset,

	Stash_ResetDone, Stash_IsIdle, StashAlmostFull,
	
	Stash_StartScanOp, Stash_SkipWritebackOp, Stash_StartWritebackOp,
	
	Command, PAddr, CurrentLeaf, RemappedLeaf, AccessIsDummy,  

	Stash_ReturnData, Stash_ReturnDataValid,
	
	Stash_StoreData, Stash_StoreDataValid, Stash_StoreDataReady, AppendComplete,
	
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,
	
	ROAccess, CSAppend, CSIdle, CSORAMAccess, PathReadComplete // to remove
	);
		
	//------------------------------------------------------------------------------
	//	Parameters & Constants
	//------------------------------------------------------------------------------

	`include "PathORAM.vh"
	`include "Stash.vh"
	
	`include "SecurityLocal.vh"
	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	
	localparam				SpaceRemaining =		BktHSize_RndBits - BktHSize_RawBits;

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	
	// stash status
	output					Stash_ResetDone, Stash_IsIdle, StashAlmostFull;
	
	// stash commands
	input					Stash_StartScanOp, Stash_SkipWritebackOp, Stash_StartWritebackOp;
	
	//--------------------------------------------------------------------------
	//	Frontend Interface
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] Command;
	input	[ORAMU-1:0]		PAddr;
	input	[ORAML-1:0]		CurrentLeaf; // If Command == Append, this is XX 
	input	[ORAML-1:0]		RemappedLeaf;
	input					AccessIsDummy;
	
	output	[BEDWidth-1:0]	Stash_ReturnData;
	output					Stash_ReturnDataValid;
	
	input	[BEDWidth-1:0]	Stash_StoreData;						
	input					Stash_StoreDataValid;
	output					Stash_StoreDataReady;
	output                  AppendComplete;
	
	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------
	
	input	[DDRDWidth-1:0]	DRAMReadData;
	input					DRAMReadDataValid;
	output					DRAMReadDataReady;
	
	output	[DDRDWidth-1:0]	DRAMWriteData;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;
	
	input	ROAccess, CSIdle, CSAppend, CSORAMAccess; // TODO to remove
	output	PathReadComplete;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	// Read pipeline
		
	(* mark_debug = "TRUE" *)	wire					HeaderDownShift_InValid, HeaderDownShift_InReady;
	wire					DataDownShift_InValid, DataDownShift_InReady;
		
	wire	[BktBSTWidth-1:0] BucketReadCtr;
	wire					ReadProcessingHeader;	
	
	(* mark_debug = "TRUE" *)	wire	[ORAMZ-1:0] 	HeaderDownShift_ValidBits;
	(* mark_debug = "TRUE" *)	wire	[BigUWidth-1:0]	HeaderDownShift_PAddrs;
	(* mark_debug = "TRUE" *)	wire	[BigLWidth-1:0]	HeaderDownShift_Leaves;
		
	(* mark_debug = "TRUE" *)	wire					ReadBlockIsValid, BlockPresent;
	
	wire	[BEDWidth-1:0]	DataDownShift_OutData;
	wire					DataDownShift_OutValid, DataDownShift_OutReady;
	wire					BlockReadValid, BlockReadReady;
	
	wire	[ORAMU-1:0]		HeaderDownShift_OutPAddr; 
	wire	[ORAML-1:0]		HeaderDownShift_OutLeaf;
	wire					HeaderDownShift_OutValid;		
	
	(* mark_debug = "TRUE" *)	wire	[PBEDWidth-1:0]	PathReadCtr;
	wire					DataDownShift_Transfer;
	
	wire					BlockReadCtr_Reset;
	wire	[BlkBEDWidth-1:0] BlockReadCtr; 	
	wire 					InPath_BlockReadComplete;	
	
	// Writeback pipeline

	wire					Stash_BlockReadComplete;
	
	wire	[ORAMU-1:0]		HeaderUpShift_InPAddr; 
	wire	[ORAML-1:0]		HeaderUpShift_InLeaf;
	wire					HeaderUpShift_InReady;
	(* mark_debug = "TRUE" *)	wire					HeaderUpShift_OutValid, HeaderUpShift_OutReady;

	(* mark_debug = "TRUE" *)	wire	[ORAMZ-1:0] 	HeaderUpShift_ValidBits;
	(* mark_debug = "TRUE" *)	wire	[BigUWidth-1:0]	HeaderUpShift_PAddrs;
	(* mark_debug = "TRUE" *)	wire	[BigLWidth-1:0]	HeaderUpShift_Leaves;	
	
	wire	[BEDWidth-1:0]	DataUpShift_InData;
	wire					DataUpShift_InValid, DataUpShift_InReady;
	wire	[DDRDWidth-1:0]	DataUpShift_OutData;
	(* mark_debug = "TRUE" *)	wire					DataUpShift_OutValid, DataUpShift_OutReady;

	wire					WritebackBlockIsValid;
	wire 					WritebackBlockCommit;
	
	(* mark_debug = "TRUE" *)	wire 					WritebackProcessingHeader;		
	wire	[DDRDWidth-1:0]	UpShift_HeaderFlit, BucketBuf_OutData;
	wire					BucketBuf_OutValid, BucketBuf_OutReady;
							
	wire					BucketWritebackValid;
	wire	[BktBSTWidth-1:0] BucketWritebackCtr;
							
	wire	[DDRDWidth-1:0]	UpShift_DRAMWriteData;
				
	// Stash
	wire					Stash_UpdateBlockValid, Stash_UpdateBlockReady;
	wire					Stash_EvictBlockValid, Stash_EvictBlockReady;

	wire					Stash_BlockWriteComplete;
	
	(* mark_debug = "TRUE" *)	wire					StashOverflow;
	
	(* mark_debug = "TRUE" *)	wire	[SEAWidth-1:0]	StashOccupancy;
	(* mark_debug = "TRUE" *)	wire					BlockNotFound, BlockNotFoundValid;
	
	wire					EvictGate, UpdateGate;
	
	//------------------------------------------------------------------------------
	//	Control logic
	//------------------------------------------------------------------------------
	
	assign	EvictGate =								CSAppend;
	assign	UpdateGate = 							CSORAMAccess & (Command == BECMD_Update);
	assign	Stash_StoreDataReady = 					(Stash_EvictBlockReady & EvictGate) | 
													(Stash_UpdateBlockReady & UpdateGate);
	assign	Stash_EvictBlockValid = 				Stash_StoreDataValid & EvictGate;
	assign	Stash_UpdateBlockValid =				Stash_StoreDataValid & UpdateGate;
		
	//------------------------------------------------------------------------------
	//	[Read path] Buffers and down shifters
	//------------------------------------------------------------------------------
	
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

	//------------------------------------------------------------------------------
	//	[Read path] Dummy block handling
	//------------------------------------------------------------------------------

	assign	InPath_BlockReadComplete =				Stash_BlockWriteComplete | (BlockReadCtr_Reset & DataDownShift_Transfer);
	assign	BlockReadValid =						DataDownShift_OutValid & HeaderDownShift_OutValid & (ReadBlockIsValid & BlockPresent);
	assign	DataDownShift_OutReady =				(BlockPresent) ? ((ReadBlockIsValid) ? BlockReadReady : 1'b1) : 1'b0; 
	
	assign	DataDownShift_Transfer =				DataDownShift_OutValid & DataDownShift_OutReady;
	
	// Use FIFOShiftRound to generate BlockPresent signal
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
							.Enable(				DataDownShift_Transfer & ~ReadBlockIsValid & BlockPresent),
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

	CountAlarm #(			.Threshold(				PathSize_BEDChunks),
							.IThreshold(			BktSize_BEDChunks))
			in_path_cmp(	.Clock(					Clock), 
							.Reset(					Reset | CSIdle), 
							.Enable(				DataDownShift_Transfer),
							.Done(					FullPathReadComplete),
							.Intermediate(			ROPathReadComplete),
							.Count(					PathReadCtr));
	
	assign	PathReadComplete = 						(EnableREW & ROAccess) ? ROPathReadComplete : FullPathReadComplete;	
	
	//------------------------------------------------------------------------------
	//	Stash
	//------------------------------------------------------------------------------
	
	Stash		#(			.StashOutBuffering(		4), // this should be good enough ...
							.StopOnBlockNotFound(	StopOnBlockNotFound),
							.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.Overclock(				Overclock))
				stash(		.Clock(					Clock),
							.Reset(					Reset),
							.ResetDone(				Stash_ResetDone),
							
							.IsIdle(				Stash_IsIdle),
							
							.RemapLeaf(				RemappedLeaf),
							.AccessLeaf(			CurrentLeaf),	// should pass AddrGen_Leaf!!!
							.AccessPAddr(			PAddr),
							.AccessIsDummy(			AccessIsDummy),
							.AccessCommand(			Command),
							
							.StartScan(				Stash_StartScanOp),
							.SkipWriteback(			Stash_SkipWritebackOp),
							.StartWriteback(		Stash_StartWritebackOp),
							
							.ReturnData(			Stash_ReturnData),
							.ReturnPAddr(			), // not connected
							.ReturnLeaf(			), // not connected
							.ReturnDataOutValid(	Stash_ReturnDataValid),
							.BlockReturnComplete(	), // not connected
							
							.UpdateData(			Stash_StoreData),
							.UpdateDataInValid(		Stash_UpdateBlockValid),
							.UpdateDataInReady(		Stash_UpdateBlockReady),
							.BlockUpdateComplete(	), // not connected
							
							.EvictData(				Stash_StoreData),
							.EvictPAddr(			PAddr),
							.EvictLeaf(				RemappedLeaf),
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
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		StashOccupancy), // not connected
							.BlockNotFound(			BlockNotFound), // not connected
							.BlockNotFoundValid(	BlockNotFoundValid)); // not connected

	//------------------------------------------------------------------------------
	//	[Writeback path] Buffers and up shifters
	//------------------------------------------------------------------------------
	
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
				$stop;
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
	
	assign	UpShift_HeaderFlit =					{	{SpaceRemaining{1'bx}},
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
	
	//------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
