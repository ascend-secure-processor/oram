
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		StashScanTable
//------------------------------------------------------------------------------
module StashScanTable #(`include "PathORAM.vh", `include "Stash.vh") (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset, PerAccessReset, 
	input					AccessComplete, // debugging
	output					ResetDone,
	
	//--------------------------------------------------------------------------
	//	Scan interface
	//--------------------------------------------------------------------------
		
	input	[ORAML-1:0]		CurrentLeaf,
	input					CurrentLeafValid,
	
	input	[ORAML-1:0]		InScanLeaf,
	input	[ORAMU-1:0]		InScanPAddr, // debugging
	input	[SEAWidth-1:0]	InScanSAddr,
	input					InScanAdd,
	input					InScanValid,
	input					InScanStreaming,
	
	output	[SEAWidth-1:0]	OutScanSAddr,
	output					OutScanAccepted,
	output					OutScanAdd,
	output					OutScanValid,
	output					OutScanStreaming,
	
	//--------------------------------------------------------------------------
	//	DMA (Path writeback) interface
	//--------------------------------------------------------------------------
		
	input	[STAWidth-1:0] 	InDMAAddr,
	input					InDMAValid,
	
	output	[SEAWidth-1:0]	OutDMAAddr,
	output 					OutDMAValid,
	output					OutDMAReady,
	output					OutDMALast
	);
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	
	`include "BucketLocal.vh"
	`include "StashLocal.vh"
	
	localparam				FIFOWidth =				`log2(BlocksOnPath+1);
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	wire					ResetDone_Internal;
	
	wire	[ORAMLP1-1:0]	CurrentLeafP1, InLeafP1;
	
	wire	[ORAMLP1-1:0]	FullMask, Intersection, CommonSubpath,
							CommonSubpath_Space, CommonSubpath_Space_rev,
							HighestLevel_Onehot;
	wire	[BktAWidth-1:0]	HighestLevel_Bin;

	wire	[BCWidth-1:0]	BucketOccupancy;
	wire	[STAWidth-1:0]	ScanTable_Address;
	wire	[SEAWidth-1:0]	ScanTable_DataIn;
	wire					ScanTable_WE;

	wire	[BCLWidth-1:0]	BCounts, BCounts_New;

	wire	[STAWidth-1:0]	ResetCount;
	
	// Pipelining
	
	wire	[ORAMLP1-1:0]	CommonSubpath_Dly;
	wire	[SEAWidth-1:0]	InScanSAddr_Dly;
	wire					CurrentLeafValid_Dly, InScanValid_Dly;	

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
			if (InScanValid & CurrentLeafValid) begin
				$display("[%m @ %t] Scan table start [SAddr: %x, PAddr: %x, Access leaf: %x, Block leaf: %x]", $time, InScanSAddr_Dly, InScanPAddr, CurrentLeaf, InScanLeaf);

				$display("\tIntersection:        %x", Intersection);
				$display("\tCommonSubpath:       %x", CommonSubpath);
				$display("\tFull mask:           %x", FullMask);
				$display("\tCommonSubpath_Space: %x", CommonSubpath_Space);
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
			else if (CurrentLeafValid) begin
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
			
			if (CurrentLeafValid & InScanValid & InScanLeaf &
				((^CurrentLeaf === 1'bx) | (^InScanLeaf === 1'bx))) begin
				$display("[%m @ %t] ERROR: ScanTable got XX Current/Scan leaf", $time);
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
							
	assign	CommonSubpath = 						(Intersection & -Intersection) - 1;
	
	Pipeline	#(			.Width(					2 + SEAWidth + ORAMLP1),
							.Stages(				Overclock))
			mpipe_1(		.Clock(					Clock),
							.Reset(					Reset), 
							.InData(				{InScanValid,		CurrentLeafValid,		InScanSAddr, 	CommonSubpath}), 
							.OutData(				{InScanValid_Dly,	CurrentLeafValid_Dly,	InScanSAddr_Dly,CommonSubpath_Dly}));
							
	assign	CommonSubpath_Space =					CommonSubpath_Dly & ~FullMask;

	Reverse		#(			.Width(					ORAMLP1))
				Rev2(		.In(					CommonSubpath_Space),
							.Out(					CommonSubpath_Space_rev));

	Reverse		#(			.Width(					ORAMLP1))
				Rev3(		.In(					CommonSubpath_Space_rev & -CommonSubpath_Space_rev), 
							.Out(					HighestLevel_Onehot));

	OneHot2Bin	#(			.Width(					ORAMLP1))
				OH2B(		.OneHot(				HighestLevel_Onehot), 
							.Bin(					HighestLevel_Bin_Pre));								
							
	//--------------------------------------------------------------------------
	//	Outputs (these can be delayed if this module creates a critical path)
	//--------------------------------------------------------------------------

	assign 	OutScanAccepted_Pre =					CurrentLeafValid_Dly & InScanValid_Dly & |HighestLevel_Onehot;
	assign	OutScanSAddr_Pre =						InScanSAddr_Dly;
	assign	OutScanValid_Pre = 						InScanValid_Dly;
	
	//--------------------------------------------------------------------------
	//	Feed-forward retiming
	//--------------------------------------------------------------------------

	Pipeline	#(			.Width(					2),
							.Stages(				ScanTableLatency))
			full_dly(		.Clock(					Clock),
							.Reset(					Reset), 
							.InData(				{InScanAdd,	InScanStreaming}), 
							.OutData(				{OutScanAdd,OutScanStreaming}));						
		
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
			mpipe_2(		.Clock(					Clock),
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
				BCMux(		.Select(				HighestLevel_Bin), 
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
							.OutSend(				OutDMAValid_Pre),
							.OutReady(				OutDMAReady_Pre));

	assign	OutDMAValid =							DMAGate & OutDMAValid_Pre;
	assign	OutDMAReady_Pre = 						DMAGate & OutDMAReady;
							
	// TODO rename to outDMADone
	// TODO adjust to == 2
	// We don't set DMAGate until STFIFOCount == 3 because when BEDWidth = 512, (STFIFOCount == 3) will never be true
	Register	#(			.Width(					1))
				dma_start(	.Clock(					Clock),
							.Reset(					Reset | AccessComplete),
							.Set(					DMAValid_Internal & STFIFOCount == 3),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					DMAGate));
	Register	#(			.Width(					1))
				dma_last(	.Clock(					Clock),
							.Reset(					Reset | AccessComplete),
							.Set(					STFIFOCount == 1 & OutDMAValid_Pre & OutDMAReady_Pre),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					OutDMALast));

	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------

