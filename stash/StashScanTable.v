
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
	
	`include "DDR3SDRAMLocal.vh" // TODO cleanup
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

	wire	[STAP1Width-1:0] ResetCount;
	
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
	
	// debugging
	
	wire					InScanAdd_Dbg0, InScanAdd_Dbg1;
	(* mark_debug = "TRUE" *)	wire					ERROR_OF1, ERROR_ISC1, ERROR_ISC2, ERROR_BADLEAF, ERROR_StashScanTable;
	
	//--------------------------------------------------------------------------
	//	Software debugging 
	//--------------------------------------------------------------------------
	
	Register1b 	errno1(Clock, Reset, ~DMAReady_Internal & DMAValid_Internal, 					ERROR_OF1);
	Register1b 	errno2(Clock, Reset, (OutScanAccepted_Pre | InScanValid) & InDMAValid, 			ERROR_ISC1);
	Register1b 	errno3(Clock, Reset, AccessComplete & |BCounts_Pre, 							ERROR_ISC2);
	Register1b 	errno4(Clock, Reset, InScanAdd_Dbg1 & InScanValid_Dly1 & ~|CompatibleBuckets, 	ERROR_BADLEAF);
	
	Register1b 	errANY(Clock, Reset, ERROR_OF1 | ERROR_ISC1 | ERROR_ISC2 | ERROR_BADLEAF,		ERROR_StashScanTable);
	
	`ifdef SIMULATION
		integer ind;
		reg ResetDone_Delayed;
		
		reg	LeafSet = 0;
		reg	[ORAML-1:0]	LeafThisAccess;
		
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
				$finish;
			end
			
			if (ERROR_OF1) begin
				$display("[%m @ %t] ERROR: ScanTable FIFO overflow", $time);
				$finish;			
			end
			
			if (IsWritebackCandidate & InScanValid & InScanLeaf &
				((^CurrentLeaf === 1'bx) | (^InScanLeaf === 1'bx) | (^InScanSAddr === 1'bx))) begin
				$display("[%m @ %t] ERROR: ScanTable got XX Current/Scan leaf or InScanSAddr", $time);
				$finish;
			end
			
			if (ERROR_ISC1) begin
				$display("[%m @ %t] ERROR: ScanTable is multitasking", $time);
				$finish;
			end
			
			if (ERROR_ISC2) begin
				$display("[%m @ %t] ERROR: ScanTable BCounts not reset", $time);
				$finish;				
			end
			
			if (ERROR_BADLEAF) begin
				$display("[%m @ %t] ERROR: Block that is being added to the Stash has an incompatible leaf", $time);
				$finish;					
			end
			
	`ifndef SIMULATION_ASIC
			if (~ResetDone_Delayed & ResetDone) begin
				ind = 0;
				while (ind != BlocksOnPath) begin
					if (st_ram.BEHAVIORAL.core.BEHAVIORAL.Mem[ind] != SNULL) begin
						$display("[%m @ %t] ERROR: Scan table address %d not initialized to SNULL (found %d)", $time, ind, st_ram.BEHAVIORAL.core.BEHAVIORAL.Mem[ind]);
						$finish;
					end
					//$display("OK %d", ScanTable.BEHAVIORAL.core.BEHAVIORAL.Mem[ind]);
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

	Pipeline	#(			.Width(					3 + SEAWidth + ORAMLP1),
							.Stages(				Overclock))
				mpipe_1(	.Clock(					Clock),
							.Reset(					Reset), 
							.InData(				{InScanAdd,			InScanValid,		IsWritebackCandidate,		InScanSAddr, 		Intersection}), 
							.OutData(				{InScanAdd_Dbg0,	InScanValid_Dly0,	IsWritebackCandidate_Dly0,	InScanSAddr_Dly0,	Intersection_Dly}));	
	
	assign	CommonSubpath = 						Intersection_Dly & -Intersection_Dly;
	
	Pipeline	#(			.Width(					3 + SEAWidth + ORAMLP1),
							.Stages(				Overclock))
				mpipe_2(	.Clock(					Clock),
							.Reset(					Reset), 
							.InData(				{InScanAdd_Dbg0,	InScanValid_Dly0,	IsWritebackCandidate_Dly0,	InScanSAddr_Dly0, 	CommonSubpath}), 
							.OutData(				{InScanAdd_Dbg1,	InScanValid_Dly1,	IsWritebackCandidate_Dly1,	InScanSAddr_Dly1,	CommonSubpath_Dly}));	
	
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
	assign	OutScanValid_Pre = 						~ERROR_StashScanTable & InScanValid_Dly2;
	
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
		assign 	BCounts_New[BCWidth*(i+1)-1:BCWidth*i] = 	BCounts_Pre[BCWidth*(i+1)-1:BCWidth*i] + (HighestLevel_Bin_Pre == i);
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
	
	Counter		#(			.Width(					STAP1Width))
				rst_cnt(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				~ResetDone_Internal),
							.In(					{STAP1Width{1'bx}}),
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
	SDPRAM		#(			.DWidth(				SEAWidth),
							.AWidth(				STAWidth))
				st_ram(		.Clock(					Clock),
							.Reset(					1'b0),
							.Write(					ScanTable_WE),								
							.WriteAddress(			ScanTable_Address),
							.WriteData(				ScanTable_DataIn),
							.Read(					1'b1),
							.ReadAddress(			InDMAAddr), 
							.ReadData(				DMAAddr_Internal));

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

