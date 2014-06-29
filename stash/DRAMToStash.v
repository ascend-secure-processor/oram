
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		DRAMToStash
//	Desc:		Convert from DRAM bucket interface to stash interface.
//				This is a separate module because depending on ORAML, ORAMU, 
//				ORAMZ and BEDWidth, this logic will look quite different.
//==============================================================================
module DRAMToStash(
	Clock, Reset,

	PathReadCommitted,
	
	DRAMData, DRAMDataValid, DRAMDataReady,
	
	StashData, StashValid, StashReady,
	StashPAddr, StashLeaf,
	BlockWriteComplete
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	`include "Stash.vh"
	
	`include "SecurityLocal.vh"
	`include "StashLocal.vh"
	`include "StashTopLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	
	localparam				SpaceRemaining =		BktHSize_RndBits - BktHSize_RawBits,
							PBEDP1Width = 			PBEDWidth + 1;
							
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;

	//--------------------------------------------------------------------------
	//	Command Interface
	//--------------------------------------------------------------------------
	
	output					PathReadCommitted;
	
	//--------------------------------------------------------------------------
	//	DRAM Interface
	//--------------------------------------------------------------------------

	input	[BEDWidth-1:0]	DRAMReadData;
	input					DRAMReadDataValid;
	output					DRAMReadDataReady;
	
	//--------------------------------------------------------------------------
	//	Stash Interface
	//--------------------------------------------------------------------------
	
	output	[BEDWidth-1:0]	StashData;
	output	[ORAMU-1:0]		StashPAddr;
	output	[ORAML-1:0]		StashLeaf;
	output					StashValid;
	input					StashReady;
	input					BlockWriteComplete;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	// Control logic & commands
	
	wire	[STCMDWidth-1:0] WritebackCommand;
	
	wire					ResetDone, StashIdle;
	
	wire					StartAppendOp, StartScanOp, StartWritebackOp;
	wire					AppendComplete, UpdateComplete;
	
	wire					EvictGate, UpdateGate;
	
	(* mark_debug = "TRUE" *)	reg		[STWidth-1:0]	CS, NS;	
	wire					CSIdle, CSRead, CSStartWrite, CSWrite, CSAppend, CSUpdate;
	
	wire	[PBEDP1Width-1:0] InnerCount, OuterCount;

	wire					LatchCommand, LatchBECommand;
	
	wire	[BECMDWidth-1:0] BECommand_Internal;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]		PAddr_Internal;
	wire	[ORAML-1:0]		CurrentLeaf_Internal;
	wire	[ORAML-1:0]		RemappedLeaf_Internal;
	wire					AccessIsDummy_Internal, AccessSkipsWriteback_Internal;
	
	// Read pipeline
		
	wire					HeaderDownShift_InValid, HeaderDownShift_InReady;
	wire					DataDownShift_InValid, DataDownShift_InReady;
		
	wire	[BktBSTWidth-1:0] BucketReadCtr;
	wire					ReadProcessingHeader;	
	
	wire	[ORAMZ-1:0] 	HeaderDownShift_ValidBits;
	wire	[BigUWidth-1:0]	HeaderDownShift_PAddrs;
	wire	[BigLWidth-1:0]	HeaderDownShift_Leaves;
		
	wire					ValidDownShift_OutData, ValidDownShift_OutValid;
	
	wire	[BEDWidth-1:0]	DataDownShift_OutData;
	wire					DataDownShift_OutValid, DataDownShift_OutReady;
	wire					BlockReadValid, BlockReadReady;
	
	wire	[ORAMU-1:0]		HeaderDownShift_OutPAddr; 
	wire	[ORAML-1:0]		HeaderDownShift_OutLeaf;
	wire					HeaderDownShift_OutValid;		
	
	wire					DataDownShift_Transfer;
	
	wire					BlockReadCtr_Reset;
	wire	[BlkBEDWidth-1:0] BlockReadCtr; 	
	wire 					InPath_BlockReadComplete;	
	
	//--------------------------------------------------------------------------
	//	
	//--------------------------------------------------------------------------	
	
	generate if () begin:WIDE_BEDWIDTH
	
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

	//--------------------------------------------------------------------------
	//	[Read path] Dummy block handling
	//--------------------------------------------------------------------------

	assign	InPath_BlockReadComplete =				Stash_BlockWriteComplete | (BlockReadCtr_Reset & DataDownShift_Transfer);
	assign	BlockReadValid =						DataDownShift_OutValid & HeaderDownShift_OutValid & (ValidDownShift_OutData & ValidDownShift_OutValid);
	assign	DataDownShift_OutReady =				(ValidDownShift_OutValid) ? ((ValidDownShift_OutData) ? BlockReadReady : 1'b1) : 1'b0; 
	
	assign	DataDownShift_Transfer =				DataDownShift_OutValid & DataDownShift_OutReady;
	
	// Use FIFOShiftRound to generate ValidDownShift_OutValid signal
	FIFOShiftRound #(		.IWidth(				ORAMZ),
							.OWidth(				1))
				in_V_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderDownShift_ValidBits),
							.InValid(				HeaderDownShift_InValid),
							.InAccept(				), // will be the same as in_L_shft
							.OutData(			    ValidDownShift_OutData),
							.OutValid(				ValidDownShift_OutValid),
							.OutReady(				InPath_BlockReadComplete));	
	
	Counter		#(			.Width(					BlkBEDWidth))
				in_blk_cnt(	.Clock(					Clock),
							.Reset(					Reset | BlockReadCtr_Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DataDownShift_Transfer & ~ValidDownShift_OutData & ValidDownShift_OutValid),
							.In(					{BlkBEDWidth{1'bx}}),
							.Count(					BlockReadCtr));	
	CountCompare #(			.Width(					BlkBEDWidth),
							.Compare(				BlkSize_BEDChunks - 1))
				in_blk_cmp(	.Count(					BlockReadCtr), 
							.TerminalCount(			BlockReadCtr_Reset));
	
	//--------------------------------------------------------------------------
	//	[Read path] Path counters
	//--------------------------------------------------------------------------	
	
	// count number of real/dummy blocks on path and signal the end of the path 
	// read when we read a whole path's worth 	

	Counter		#(			.Width(					PBEDP1Width))
				inner_cnt(	.Clock(					Clock),
							.Reset(					Reset | CSIdle),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DataDownShift_Transfer),
							.In(					{PBEDP1Width{1'bx}}),
							.Count(					InnerCount));	
	
	//--------------------------------------------------------------------------
	//	Stash Interface
	//--------------------------------------------------------------------------
	
	.WriteData(				DataDownShift_OutData),
	.WriteInValid(			BlockReadValid),
	.WriteInReady(			BlockReadReady), 
	.WritePAddr(			HeaderDownShift_OutPAddr),
	.WriteLeaf(				HeaderDownShift_OutLeaf),
	.BlockWriteComplete(	Stash_BlockWriteComplete), 	
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
