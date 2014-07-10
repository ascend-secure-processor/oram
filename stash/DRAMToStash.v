
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
//				Specifically, translate:
//					{ {Z{U}}, {Z{L}}, {Z{L}} } (the DRAM's format)
//					to 
//					{Z{ULD}} (the stash's format) 
//
//				This is a separate module because depending on ORAML, ORAMU, 
//				ORAMZ and BEDWidth, this logic will look quite different and 
//				it's cleaner to quarantine the mess in one place.
//
//				When BEDWidth == large, we can peel out L,U,V bits for free 
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

	PathTransition,
	
	DRAMData, DRAMValid, DRAMReady,
	
	StashData, StashValid, StashReady,
	StashPAddr, StashLeaf
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	
	`include "BucketLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	
	localparam				RHWidth =				BktHSize_BEDChunks * BEDWidth;
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;

	//--------------------------------------------------------------------------
	//	Command Interface
	//--------------------------------------------------------------------------
	
	output					PathTransition;
	
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
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	wire					HeaderValid, PayloadValid, ReadingPayload;
	
	wire					BucketTransition, BlockTransition;
							
	wire	[BEDWidth-1:0]	DRAMData_Inner;
	wire					DRAMValid_Inner;
	
	wire	[ORAMZ-1:0] 	HeaderDown_ValidBits;
	wire	[BigUWidth-1:0]	HeaderDown_PAddrs;
	wire	[BigLWidth-1:0]	HeaderDown_Leaves;
	
	wire	[ORAMU-1:0]		HeaderDown_PAddr;
	wire	[ORAML-1:0]		HeaderDown_Leaf;
	wire					HeaderDown_ValidBit;		
	
	wire					RW_R_DoneAlarm, RO_R_DoneAlarm;
	
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------	
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (PayloadValid && HeaderDown_ValidBit === 1'bx) begin
				$display("[%m] ERROR: control signal is X");
				$finish;
			end	
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Shifters
	//--------------------------------------------------------------------------	
	
	CountAlarm  #(  		.Threshold(             BktSize_BEDChunks))
				in_bkt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				DRAMValid & DRAMReady),
							.Done(					BucketTransition));
	
	generate if (BEDWidth < BktHSize_RawBits) begin:NARROW_BEDWIDTH
		// NOTE: this isn't the optimal ASIC design because we have so many 
		// flops.  But I don't think it matters much in overall area...
	
		FIFOShiftRound #(	.IWidth(				BEDWidth),
							.OWidth(				RHWidth))
				in_DR_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMData),
							.InValid(				HeaderValid),
							.InAccept(				),
							.OutData(			    DRAMData_Inner),
							.OutValid(				DRAMValid_Inner),
							.OutReady(				1'b1));
	end else begin:WIDE_BEDWIDTH
		assign	DRAMData_Inner =					DRAMData;
		assign	DRAMValid_Inner =					DRAMValid;
	end endgenerate

	assign	DRAMReady = 							StashReady;	
	
	Register1b pheader(Clock, Reset || BucketTransition, DRAMValid_Inner, ReadingPayload);					
								
	assign	HeaderValid =							DRAMValid_Inner && ~ReadingPayload;
	assign	PayloadValid = 							DRAMValid && 		ReadingPayload;

	assign	HeaderDown_ValidBits =					DRAMData_Inner[BktHVStart+BigVWidth-1:BktHVStart];
	assign	HeaderDown_PAddrs =						DRAMData_Inner[BktHUStart+BigUWidth-1:BktHUStart];
	assign	HeaderDown_Leaves =						DRAMData_Inner[BktHLStart+BigLWidth-1:BktHLStart];
	
	ShiftRegister #(		.PWidth(				BigUWidth),
							.SWidth(				ORAMU))
				in_U_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					HeaderValid), 
							.Enable(				BlockTransition), 
							.PIn(					HeaderDown_PAddrs), 
							.SIn(					{ORAMU{1'bx}}),
							.SOut(					HeaderDown_PAddr));							
	ShiftRegister #(		.PWidth(				BigLWidth),
							.SWidth(				ORAML))
				in_L_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					HeaderValid), 
							.Enable(				BlockTransition), 
							.PIn(					HeaderDown_Leaves), 
							.SIn(					{ORAML{1'bx}}),
							.SOut(					HeaderDown_Leaf));
	ShiftRegister #(		.PWidth(				ORAMZ),
							.SWidth(				1))
				in_V_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					HeaderValid), 
							.Enable(				BlockTransition), 
							.PIn(					HeaderDown_ValidBits), 
							.SIn(					{ORAML{1'bx}}),
							.SOut(					HeaderDown_ValidBit));							

	CountAlarm  #(  		.Threshold(             BlkSize_BEDChunks))
				valid_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				PayloadValid && StashReady),
							.Done(					BlockTransition));
	
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

							.RW_R_Transfer(			PayloadValid),
							.RO_R_Transfer(			PayloadValid),
							
							.RW_R_DoneAlarm(		RW_R_DoneAlarm),
							.RO_R_DoneAlarm(		RO_R_DoneAlarm));
	
	assign	PathTransition =						RW_R_DoneAlarm || RO_R_DoneAlarm;

	//--------------------------------------------------------------------------
	//	Stash Interface
	//--------------------------------------------------------------------------
		
	assign	StashData =								DRAMData;
	assign	StashValid =							PayloadValid && HeaderDown_ValidBit;
	
	assign	StashPAddr =							HeaderDown_PAddr;
	assign	StashLeaf =								HeaderDown_Leaf;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
