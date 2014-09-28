
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
	StashPAddr, StashLeaf, StashMAC
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	
	localparam				BCWidth =				`max(1,`log2(ORAMZ));

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
	output	[ORAMH-1:0]		StashMAC;
	output					StashValid;
	input					StashReady;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	wire					HeaderValid, PayloadValid;
	
	wire					BucketTransition, BlockTransition;
	wire	[BCWidth-1:0] 	CurrentBlock;
	wire	[RHWidth-1:0]	Header_Wide;

	wire	[AESEntropy-1:0] HeaderDown_EncryptionIV;
	wire					BucketValid;

	wire	[ORAMZ-1:0] 	HeaderDown_ValidBits;
	wire	[BigUWidth-1:0]	HeaderDown_PAddrs;
	wire	[BigLWidth-1:0]	HeaderDown_Leaves;

	wire	[BCWidth-1:0]	DMSelect;

	wire	[ORAMU-1:0]		HeaderDown_PAddr;
	wire	[ORAML-1:0]		HeaderDown_Leaf;
	wire					HeaderDown_ValidBit;		
		
	wire					RW_R_DoneAlarm, RO_R_DoneAlarm;
	
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------	
	
	`ifdef SIMULATION
		initial begin
			if (EnableAES == PINIT) begin
				$display("[%m] ERROR: AES uninit");
				$finish;
			end
		end

		always @(posedge Clock) begin
			if (PayloadValid && HeaderDown_ValidBit === 1'bx) begin
				$display("[%m] ERROR: control signal is X");
				$finish;
			end

			if (DRAMValid && DRAMReady) begin
				//$display("[%m] DRAM -> stash reading %x", DRAMData);
			end	
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Shifters
	//--------------------------------------------------------------------------	
	
	assign	DRAMReady = 							StashReady;
	
	assign	PayloadValid = 							DRAMValid && HeaderValid;

	FIFOShiftRound #(		.IWidth(				BEDWidth),
							.OWidth(				RHWidth),
							.Register(				1),
							.Reverse(				1))
				in_H_SP(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMData),
							.InValid(				DRAMValid & ~BucketTransition),
							.InAccept(				),
							.OutData(			    Header_Wide),
							.OutValid(				HeaderValid),
							.OutReady(				BucketTransition));

	assign	HeaderDown_EncryptionIV =				Header_Wide[AESEntropy-1:0];
	assign	HeaderDown_ValidBits =					Header_Wide[BktHVStart+BigVWidth-1:BktHVStart];
	assign	HeaderDown_PAddrs =						Header_Wide[BktHUStart+BigUWidth-1:BktHUStart];
	assign	HeaderDown_Leaves =						Header_Wide[BktHLStart+BigLWidth-1:BktHLStart];
	
	assign	BucketValid =							(EnableAES) ? HeaderValid && HeaderDown_EncryptionIV != IVINITValue : 1'b1;
	
	assign	DMSelect =								ORAMZ - 32'd1 - CurrentBlock;
	Mux	#(.Width(1), 		.NPorts(ORAMZ), .SelectCode(0)) V_mux(DMSelect, HeaderDown_ValidBits, 	HeaderDown_ValidBit);
	Mux	#(.Width(ORAMU), 	.NPorts(ORAMZ), .SelectCode(0)) U_mux(DMSelect, HeaderDown_PAddrs, 		HeaderDown_PAddr);
	Mux	#(.Width(ORAML), 	.NPorts(ORAMZ), .SelectCode(0)) L_mux(DMSelect, HeaderDown_Leaves, 		HeaderDown_Leaf);
	
	CountAlarm  #(  		.Threshold(             BlkSize_BEDChunks))
				valid_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				PayloadValid && StashReady),
							.Done(					BlockTransition));
	CountAlarm  #(  		.Threshold(             ORAMZ))
				blk_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				BlockTransition),
							.Count(					CurrentBlock));
							
	CountAlarm  #(  		.Threshold(             BktSize_BEDChunks))
				in_bkt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				DRAMValid & DRAMReady),
							.Done(					BucketTransition));	
	
	//--------------------------------------------------------------------------
	//	Path counters
	//--------------------------------------------------------------------------	
	
	// count number of real/dummy blocks on path and signal the end of the path 
	// read when we read a whole path's worth
	
	REWStatCtr	#(			.USE_REW(				EnableREW),
							.ORAME(					ORAME),
							.Overlap(				0),
							.RW_R_Chunk(			PathPSize_BEDChunks),
							.RW_W_Chunk(			0),
							.RO_R_Chunk(			BktPSize_BEDChunks),
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
	assign	StashValid =							PayloadValid && HeaderDown_ValidBit && BucketValid;
	
	assign	StashPAddr =							HeaderDown_PAddr;
	assign	StashLeaf =								HeaderDown_Leaf;
	
	//--------------------------------------------------------------------------
	//	MAC Handling
	//--------------------------------------------------------------------------
	
	generate if (EnableIV) begin:MAC
		wire	[ORAMH-1:0] HeaderDown_MAC;
		wire	[BigHWidth-1:0]	HeaderDown_MACs;
	
		assign	HeaderDown_MACs =					Header_Wide[BktHHStart+BigHWidth-1:BktHHStart];
		Mux	#(.Width(ORAMH), .NPorts(ORAMZ), .SelectCode(0)) H_mux(DMSelect, HeaderDown_MACs, HeaderDown_MAC);
		assign	StashMAC =							HeaderDown_MAC;
	end else begin:NO_MAC
		assign	StashMAC =							{ORAMH{1'bx}};
	end endgenerate 
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
