
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		DRAMToStash
//	Desc:		Takes a stream of data formatted as DRAM buckets as input and 
//				outputs what the Stash expects (i.e., Leaf:Addr:Data in 
//				parallel).
//
//				This is a separate module because depending on ORAML, ORAMU, 
//				ORAMZ and BEDWidth, this logic will look quite different and 
//				it's cleaner to quarantine the mess in one place.
//
//				When BEDWidth == large, we can peel out ORAML,U,V bits for free 
//				because all become available at _known offsets_ in a single 
//				cycle. 
//
//				When BEDWidth == small (e.g., 64b), we need to de-packetsize the 
//				BEDWidth chunks.  Here are some design options:
//
//				(a) extract L/U/V from BEDWidth stream of flits: this requires
//				complicated re-alignment logic.
//
//				(b) put gaps in the data stream so that L/U/V is aligned: this
//				adds some wasted bandwidth
//
//				(c) use a shifter to widen the L/U/V out, then do the same bit
//				extraction we do in the BEDWidth case: this adds the cost of the
//				shifter. [NOTE: THIS IS HOW WE ENDED UP IMPLEMENTING IT --- its
//				simple, and the header flit shifter isn't that big]
//
//	Opt note:	When BEDWidth is small, we will have some wasted bandwidth due
//				to flits we don't need (AES IV, hash, etc).  We can peel them
//				out like a de-packetizer as an optimization but this probably
//				doesn't help much.
//==============================================================================
module DRAMToStash(
	Clock, Reset,

	PathReadCommitted,
	
	DRAMData, DRAMValid, DRAMReady,
	
	StashData, StashValid, StashReady,
	StashPAddr, StashLeaf,
	BlockWriteComplete
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	
	`include "ConstCommands.vh"
	`include "ConstBucketHelpers.vh"
	`include "StashLocal.vh"
	
	`include "DDR3SDRAMLocal.vh"
	
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

	input	[BEDWidth-1:0]	DRAMData;
	input					DRAMValid;
	output					DRAMReady;
	
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
		
	wire					HeaderDownShift_InValid, HeaderDownShift_InReady;
	wire					DataDownShift_InValid, DataDownShift_InReady;
		
	wire	[BBSTWidth-1:0] BucketReadCtr;
	wire					ReadProcessingHeader;	
	
	wire	[ORAMZ-1:0] 	HeaderDownShift_ValidBits;
	wire	[BigUWidth-1:0]	HeaderDownShift_PAddrs;
	wire	[BigLWidth-1:0]	HeaderDownShift_Leaves;
		
	wire					ValidDownShift_OutData, ValidDownShift_OutValid;
	
	wire	[BEDWidth-1:0]	DataDownShift_OutData;
	wire					DataDownShift_OutValid, DataDownShift_OutReady;
	wire					BlockReadValid;
	
	wire	[ORAMU-1:0]		HeaderDownShift_OutPAddr;
	wire	[ORAML-1:0]		HeaderDownShift_OutLeaf;
	wire					HeaderDownShift_OutValid;		
	
	wire					DataDownShift_Transfer;
	
	wire					BlockReadCtr_Reset;
	wire	[BBEDWidth-1:0] BlockReadCtr; 	
	wire 					InPath_BlockReadComplete;	
	
	wire					RW_R_DoneAlarm, RO_R_DoneAlarm;
	
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------	
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (ValidDownShift_OutValid & ^ValidDownShift_OutData === 1'bx) begin
				$display("[%m] ERROR: control signal is X");
				$finish;
			end	
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	
	//--------------------------------------------------------------------------	
	
	//generate if (BEDWidth > BktHSize_RawBits) begin:WIDE_BEDWIDTH
	
	// Count where we are in a bucket (so we can determine when we are at a header)
	CountAlarm  #(  		.Threshold(             BktHSize_DRBursts + BktPSize_DRBursts))
				in_bkt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				DRAMValid & DRAMReady),
							.Count(					BucketReadCtr));
	
	// Per-bucket header/payload arbitration
	assign	ReadProcessingHeader =					BucketReadCtr < BktHSize_DRBursts;
	assign	HeaderDownShift_InValid =				DRAMValid & ReadProcessingHeader;
	assign	DataDownShift_InValid =					DRAMValid & ~ReadProcessingHeader;
	assign	DRAMReady =								(ReadProcessingHeader) ? HeaderDownShift_InReady : DataDownShift_InReady;
	
	assign	HeaderDownShift_ValidBits =				DRAMData[BktHVStart+BigVWidth-1:BktHVStart];
	assign	HeaderDownShift_PAddrs =				DRAMData[BktHUStart+BigUWidth-1:BktHUStart];
	assign	HeaderDownShift_Leaves =				DRAMData[BktHLStart+BigLWidth-1:BktHLStart];
	
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
							.InData(				DRAMData),
							.InValid(				DataDownShift_InValid),
							.InAccept(				DataDownShift_InReady),
							.OutData(				DataDownShift_OutData),
							.OutValid(				DataDownShift_OutValid),
							.OutReady(				DataDownShift_OutReady));

	//--------------------------------------------------------------------------
	//	Dummy block handling
	//--------------------------------------------------------------------------

	assign	InPath_BlockReadComplete =				BlockWriteComplete | (BlockReadCtr_Reset & DataDownShift_Transfer);
	assign	BlockReadValid =						DataDownShift_OutValid & HeaderDownShift_OutValid & (ValidDownShift_OutData & ValidDownShift_OutValid);
	assign	DataDownShift_OutReady =				(ValidDownShift_OutValid) ? ((ValidDownShift_OutData) ? StashReady : 1'b1) : 1'b0; 
	
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
	
	Counter		#(			.Width(					BBEDWidth))
				in_blk_cnt(	.Clock(					Clock),
							.Reset(					Reset | BlockReadCtr_Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DataDownShift_Transfer & ~ValidDownShift_OutData & ValidDownShift_OutValid),
							.In(					{BBEDWidth{1'bx}}),
							.Count(					BlockReadCtr));	
	CountCompare #(			.Width(					BBEDWidth),
							.Compare(				BlkSize_BEDChunks - 1))
				in_blk_cmp(	.Count(					BlockReadCtr), 
							.TerminalCount(			BlockReadCtr_Reset));
	
	//--------------------------------------------------------------------------
	//	Path counters
	//--------------------------------------------------------------------------	
	
	// count number of real/dummy blocks on path and signal the end of the path 
	// read when we read a whole path's worth
	
	REWStatCtr	#(			.USE_REW(				EnableREW),
							.ORAME(					ORAME),
							.Overlap(				0),
							.RW_R_Chunk(			PathPSize_DRBursts),
							.RW_W_Chunk(			0),
							.RO_R_Chunk(			BktPSize_DRBursts),
							.RO_W_Chunk(			0))

		commit_count(		.Clock(					Clock),
							.Reset(					Reset),

							.RW_R_Transfer(			DataDownShift_Transfer),
							.RO_R_Transfer(			DataDownShift_Transfer),
							
							.RW_R_DoneAlarm(		RW_R_DoneAlarm),
							.RO_R_DoneAlarm(		RO_R_DoneAlarm));
	
	assign	PathReadCommitted =						RW_R_DoneAlarm || RO_R_DoneAlarm;

	//--------------------------------------------------------------------------
	//	Stash Interface
	//--------------------------------------------------------------------------
		
	assign	StashData =								DataDownShift_OutData;
	assign	StashValid =							BlockReadValid;
	
	assign	StashPAddr =							HeaderDownShift_OutPAddr;
	assign	StashLeaf =								HeaderDownShift_OutLeaf;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
