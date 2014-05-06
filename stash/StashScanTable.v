
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		StashScanTable
//	Desc:		O(1) stash scan logic
//------------------------------------------------------------------------------
module StashScanTable(
  	Clock, Reset, PerAccessReset, 
	AccessComplete,
	ResetDone,

	CurrentLeaf, IsWritebackCandidate,
	
	InScanLeaf, InScanPAddr, InScanSAddr, InScanAdd,
	InScanValid, InScanDone, InScanStreaming,
	
	OutScanSAddr, OutScanAccepted, OutScanAdd,
	OutScanValid, OutScanDone, OutScanStreaming,
	
	InDMAAddr, InDMAValid,
	
	OutDMAAddr, OutDMAValid, OutDMAReady
	);
	
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------
	
	`include "PathORAM.vh"
	`include "Stash.vh"
	
	`include "BucketLocal.vh"
	`include "StashLocal.vh"
	
	localparam				FIFOWidth =				`log2(BlocksOnPath+1);
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset, PerAccessReset; 
	input					AccessComplete; // debugging
	output					ResetDone;
	
	//--------------------------------------------------------------------------
	//	Scan interface
	//--------------------------------------------------------------------------
		
	input	[ORAML-1:0]		CurrentLeaf;
	input					IsWritebackCandidate;
	
	input	[ORAML-1:0]		InScanLeaf;
	input	[ORAMU-1:0]		InScanPAddr; // debugging
	input	[SEAWidth-1:0]	InScanSAddr;
	input					InScanAdd;
	input					InScanValid;
	input					InScanDone;
	input					InScanStreaming;
	
	output	[SEAWidth-1:0]	OutScanSAddr;
	output					OutScanAccepted;
	output					OutScanAdd;
	output					OutScanValid;
	output					OutScanDone;
	output					OutScanStreaming;
	
	//--------------------------------------------------------------------------
	//	DMA (Path writeback) interface
	//--------------------------------------------------------------------------
		
	input	[STAWidth-1:0] 	InDMAAddr;
	input					InDMAValid;
	
	output	[SEAWidth-1:0]	OutDMAAddr;
	output 					OutDMAValid;
	input					OutDMAReady;	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	wire					ResetDone_Internal;
	
	wire	[ORAMLP1-1:0]	CurrentLeafP1, InLeafP1;
	
	wire	[ORAMLP1-1:0]	FullMask, Intersection, CommonSubpath, CompatibleBuckets,
							CompatibleBuckets_Space, CompatibleBuckets_Space_rev,
							HighestLevel_Onehot;
	wire	[BktAWidth-1:0]	HighestLevel_Bin;

	wire	[BCWidth-1:0]	BucketOccupancy;
	wire	[STAWidth-1:0]	ScanTable_Address;
	wire	[SEAWidth-1:0]	ScanTable_DataIn;
	wire					ScanTable_WE;

	wire	[BCLWidth-1:0]	BCounts, BCounts_New;

	wire	[STAWidth-1:0]	ResetCount;
	
	// Pipelining
	
	wire	[ORAMLP1-1:0]	Intersection_Dly, CommonSubpath_Dly, CompatibleBuckets_Dly;
	wire	[SEAWidth-1:0]	InScanSAddr_Dly0, InScanSAddr_Dly1, InScanSAddr_Dly2;
	wire					IsWritebackCandidate_Dly0, IsWritebackCandidate_Dly1, IsWritebackCandidate_Dly2;
	wire					InScanValid_Dly0, InScanValid_Dly1, InScanValid_Dly2;	

	wire	[BktAWidth-1:0]	HighestLevel_Bin_Pre;
	wire	[BCLWidth-1:0]	BCounts_Pre;
	wire					OutScanValid_Pre, OutScanAccepted_Pre;
	wire	[SEAWidth-1:0]	OutScanSAddr_Pre;

	// DMA Fifo
	
	wire	[SEAWidth-1:0]	DMAAddr_Internal;
	wire					DMAValid_Internal, DMAReady_Internal;						
	wire	[FIFOWidth-1:0]	STFIFOCount;
	
	wire					DMAGate;
	wire					OutDMAValid_Pre, OutDMAReady_Pre;
	
	wire	[SEAWidth-1:0]	DummyWire;
	
	//--------------------------------------------------------------------------
	//	Software debugging 
	//--------------------------------------------------------------------------

	`ifdef SIMULATION
		integer ind;
		reg ResetDone_Delayed;
		
		reg	LeafSet = 0;
		reg	[ORAML-1:0]	LeafThisAccess;
		wire [ORAMU-1:0] InScanPAddr_Dly;
		
		Pipeline	#(	.Width(					ORAMU),
						.Stages(				Overclock))
			sim_pipe(	.Clock(					Clock),
						.Reset(					Reset), 
						.InData(				InScanPAddr), 
						.OutData(				InScanPAddr_Dly));
		
		always @(posedge Clock) begin
			ResetDone_Delayed <= ResetDone;
			
	`ifdef SIMULATION_VERBOSE_STASH	
			if (InScanValid & IsWritebackCandidate) begin
				$display("[%m @ %t] Scan table start [SAddr: %x, PAddr: %x, Access leaf: %x, Block leaf: %x]", $time, InScanSAddr_Dly2, InScanPAddr, CurrentLeaf, InScanLeaf);

				$display("\tIntersection:        %x", Intersection);
				$display("\tCommonSubpath:       %x", CompatibleBuckets);
				$display("\tFull mask:           %x", FullMask);
				$display("\tCommonSubpath_Space: %x", CompatibleBuckets_Space);
				$display("\tHighest level:       %x (one hot), %d (bin)", HighestLevel_Onehot, HighestLevel_Bin_Pre);
				
				if (OutScanAccepted_Pre & OutScanValid_Pre)
					$display("\tScan accept: entry %d will be written back", OutScanSAddr_Pre);
				if (~OutScanAccepted_Pre & OutScanValid_Pre)
					$display("\tScan reject: entry %d will NOT be written back", OutScanSAddr_Pre);
			end
	`endif		

			// Make sure the leaf is steady; if not, scan results are bogus
			if (AccessComplete) begin
				LeafSet <= 1'b0;
			end
			else if (IsWritebackCandidate) begin
				LeafSet <= 1'b1;
				LeafThisAccess <= CurrentLeaf;
			end
			if (LeafSet & (LeafThisAccess !== CurrentLeaf)) begin
				$display("[%m @ %t] ERROR: ScanTable leaf changed during an access", $time);
				$stop;
			end
			
			if (~DMAReady_Internal & DMAValid_Internal) begin
				$display("[%m @ %t] ERROR: ScanTable FIFO overflow", $time);
				$stop;			
			end
			
			if (IsWritebackCandidate & InScanValid & InScanLeaf &
				((^CurrentLeaf === 1'bx) | (^InScanLeaf === 1'bx) | (^InScanSAddr === 1'bx))) begin
				$display("[%m @ %t] ERROR: ScanTable got XX Current/Scan leaf or InScanSAddr", $time);
				$stop;
			end
			
			if ( (OutScanAccepted_Pre | InScanValid) & InDMAValid ) begin
				$display("[%m @ %t] ERROR: ScanTable is multitasking", $time);
				$stop;
			end
			
			if (AccessComplete & |BCounts_Pre) begin
				$display("[%m @ %t] ERROR: ScanTable BCounts not reset", $time);
				$stop;				
			end
			
	`ifndef SIMULATION_ASIC
			if (~ResetDone_Delayed & ResetDone) begin
				ind = 0;
				while (ind != BlocksOnPath) begin
					if (st_ram.Mem[ind] != SNULL) begin
						$display("[%m @ %t] ERROR: Scan table address %d not initialized to SNULL (found %d)", $time, ind, st_ram.Mem[ind]);
						$stop;
					end
					//$display("OK %d", ScanTable.Mem[ind]);
					ind = ind + 1;
				end
			end
	`endif // endif SIMULATION_ASIC
		end
	`endif

	//--------------------------------------------------------------------------
	//	Stash matching logic
	//--------------------------------------------------------------------------

	// add a spot for the root bucket
	assign	CurrentLeafP1 = 						{CurrentLeaf, 1'b0};
	assign	InLeafP1 = 								{InScanLeaf, 1'b0};
	
	// Depending on leaf orientation ...
	//Reverse		#(			.Width(				ORAMLP1))
	//				Rev1(		.In(				InLeafP1 ^ CurrentLeafP1), 
	//							.Out(				Intersection));
	assign	Intersection =							InLeafP1 ^ CurrentLeafP1;

	Pipeline	#(			.Width(					2 + SEAWidth + ORAMLP1),
							.Stages(				Overclock))
				mpipe_1(	.Clock(					Clock),
							.Reset(					Reset), 
							.InData(				{InScanValid,		IsWritebackCandidate,		InScanSAddr, 		Intersection}), 
							.OutData(				{InScanValid_Dly0,	IsWritebackCandidate_Dly0,	InScanSAddr_Dly0,	Intersection_Dly}));	
	
	assign	CommonSubpath = 						Intersection_Dly & -Intersection_Dly;
	
	Pipeline	#(			.Width(					2 + SEAWidth + ORAMLP1),
							.Stages(				Overclock))
				mpipe_2(	.Clock(					Clock),
							.Reset(					Reset), 
							.InData(				{InScanValid_Dly0,	IsWritebackCandidate_Dly0,	InScanSAddr_Dly0, 	CommonSubpath}), 
							.OutData(				{InScanValid_Dly1,	IsWritebackCandidate_Dly1,	InScanSAddr_Dly1,	CommonSubpath_Dly}));	
	
	assign	CompatibleBuckets =						CommonSubpath_Dly - 1;
	
	Pipeline	#(			.Width(					2 + SEAWidth + ORAMLP1),
							.Stages(				Overclock))
				mpipe_3(	.Clock(					Clock),
							.Reset(					Reset), 
							.InData(				{InScanValid_Dly1,	IsWritebackCandidate_Dly1,	InScanSAddr_Dly1, 	CompatibleBuckets}), 
							.OutData(				{InScanValid_Dly2,	IsWritebackCandidate_Dly2,	InScanSAddr_Dly2,	CompatibleBuckets_Dly}));
							
	assign	CompatibleBuckets_Space =				CompatibleBuckets_Dly & ~FullMask;

	Reverse		#(			.Width(					ORAMLP1))
				Rev2(		.In(					CompatibleBuckets_Space),
							.Out(					CompatibleBuckets_Space_rev));

	Reverse		#(			.Width(					ORAMLP1))
				Rev3(		.In(					CompatibleBuckets_Space_rev & -CompatibleBuckets_Space_rev), 
							.Out(					HighestLevel_Onehot));

	OneHot2Bin	#(			.Width(					ORAMLP1))
				OH2B(		.OneHot(				HighestLevel_Onehot), 
							.Bin(					HighestLevel_Bin_Pre));								
							
	//--------------------------------------------------------------------------
	//	Outputs (these can be delayed if this module creates a critical path)
	//--------------------------------------------------------------------------

	assign 	OutScanAccepted_Pre =					IsWritebackCandidate_Dly2 & InScanValid_Dly2 & |HighestLevel_Onehot;
	assign	OutScanSAddr_Pre =						InScanSAddr_Dly2;
	assign	OutScanValid_Pre = 						InScanValid_Dly2;
	
	//--------------------------------------------------------------------------
	//	Feed-forward retiming
	//--------------------------------------------------------------------------

	Pipeline	#(			.Width(					3),
							.Stages(				ScanTableLatency))
				full_dly(	.Clock(					Clock),
							.Reset(					Reset), 
							.InData(				{InScanDone, 	InScanAdd,	InScanStreaming}), 
							.OutData(				{OutScanDone,	OutScanAdd,	OutScanStreaming}));						
		
	//--------------------------------------------------------------------------
	//	Update bucket occupancy (feedback path)
	//--------------------------------------------------------------------------
	
	genvar	i;
	generate for(i = 0; i < ORAMLP1; i = i + 1) begin:FANOUT
		assign 	BCounts_New[BCWidth*(i+1)-1:BCWidth*i] = 	BCounts_Pre[BCWidth*(i+1)-1:BCWidth*i] + 
															((HighestLevel_Bin_Pre == i) ? 1 : 0);
	end endgenerate

	/*
		The number of real blocks mapped to this bucket so far during this 
		access.  Implementing this as registers is done to (a) reduce internal 
		fragmentation (BCLWidth bits << smallest SRAM?) and (b) to make reset a 
		single-cycle operation.  It is also convenient that this is asynchronous 
		read ...
	*/
	Register	#(			.Width(					BCLWidth))
				BucketCnts(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Enable(				OutScanAccepted_Pre),
							.In(					BCounts_New),
							.Out(					BCounts_Pre));

	generate for(i = 0; i < ORAMLP1; i = i + 1) begin:FULLMASK
		assign 	FullMask[i] = 						BCounts_Pre[BCWidth*(i+1)-1:BCWidth*i] == ORAMZ;
	end endgenerate

	Pipeline	#(			.Width(					BktAWidth + BCLWidth + 2 + SEAWidth),
							.Stages(				Overclock))
				mpipe_4(	.Clock(					Clock),
							.Reset(					Reset), 
							.InData(				{HighestLevel_Bin_Pre,	BCounts_Pre,	OutScanValid_Pre,	OutScanAccepted_Pre,	OutScanSAddr_Pre}), 
							.OutData(				{HighestLevel_Bin, 		BCounts, 		OutScanValid, 		OutScanAccepted, 		OutScanSAddr}));			
							
	//--------------------------------------------------------------------------
	//	Reset
	//--------------------------------------------------------------------------
	
	Counter		#(			.Width(					STAWidth))
				rst_cnt(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				~ResetDone_Internal),
							.In(					{STAWidth{1'bx}}),
							.Count(					ResetCount));
							
	assign	ResetDone_Internal =					ResetCount == BlocksOnPath;
	
	Register	#(			.Width(					1))
				rst_hold(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					ResetDone_Internal),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ResetDone));
	
	//--------------------------------------------------------------------------
	//	Usage tables
	//--------------------------------------------------------------------------
	
	Mux			#(			.Width(					BCWidth),
							.NPorts(				ORAMLP1),
							.SelectCode(			0))
				bc_mux(		.Select(				HighestLevel_Bin), 
							.Input(					BCounts),
							.Output(				BucketOccupancy));
							
	assign 	ScanTable_Address = 					(~ResetDone_Internal) ? ResetCount : HighestLevel_Bin * ORAMZ + BucketOccupancy;
	assign	ScanTable_WE =							OutScanAccepted | ~ResetDone_Internal;

	assign	ScanTable_DataIn =						(~ResetDone_Internal) ? SNULL : OutScanSAddr;
	
	/*
		Points directly to locations in StashD, where blocks live that are to be 
		written back during this ORAM access.

		NOTE: This table is scanned from address 0 ... 2^SEAWidth-1 in that 
		order.
	*/
	RAM			#(			.DWidth(				SEAWidth),
							.AWidth(				STAWidth),
							.NPorts(				2))
				st_ram(		.Clock(					{2{Clock}}),
							.Reset(					/* not connected */),
							.Enable(				2'b11),
							.Write(					{1'b0, 					ScanTable_WE}),
							.Address(				{InDMAAddr, 			ScanTable_Address}),
							.DIn(					{{SEAWidth{1'bx}}, 		ScanTable_DataIn}),
							.DOut(					{DMAAddr_Internal, 		DummyWire}));

	Pipeline	#(			.Width(					1),
							.Stages(				1))
			dma_vld_dly(	.Clock(					Clock),
							.Reset(					Reset), 
							.InData(				InDMAValid), 
							.OutData(				DMAValid_Internal));								
	
	// decouple the ScanTableLatency from path writeback control logic
	// ... we can avoid this FIFO by just wrapping st_ram better
	FIFORAM		#(			.Width(					SEAWidth),
							.Buffering(				BlocksOnPath))
				st_fifo(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DMAAddr_Internal),
							.InValid(				DMAValid_Internal),
							.InAccept(				DMAReady_Internal),
							.OutFullCount(			STFIFOCount),
							.OutData(				OutDMAAddr),
							.OutSend(				OutDMAValid),
							.OutReady(				OutDMAReady));

	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------

