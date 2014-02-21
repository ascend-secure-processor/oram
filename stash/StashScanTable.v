
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
		
  	input 						Clock, Reset, PerAccessReset, 	
	output						ResetDone,
	
	//--------------------------------------------------------------------------
	//	Input interface
	//--------------------------------------------------------------------------
		
	input	[ORAML-1:0]			CurrentLeaf,
	input						CurrentLeafValid,
	
	input	[ORAML-1:0]			InScanLeaf,
	input	[ORAMU-1:0]			InScanPAddr, // debugging
	input	[StashEAWidth-1:0]	InScanSAddr,
	input						InScanValid,

	//--------------------------------------------------------------------------
	//	Accept/reject interface
	//--------------------------------------------------------------------------
	
	output	[StashEAWidth-1:0]	OutScanSAddr,
	output						OutScanAccepted,
	output						OutScanValid,

	//--------------------------------------------------------------------------
	//	Scan interface
	//--------------------------------------------------------------------------
		
	input	[ScanTableAWidth-1:0] InDMAAddr,
	input						InDMAValid, InDMAReset,
	
	output	[StashEAWidth-1:0]	OutDMAAddr,
	output reg					OutDMAValid
	);
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	
	`include "StashLocal.vh"	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	wire	[ORAMLP1-1:0]		CurrentLeafP1, InLeafP1;
	
	wire	[ORAMLP1-1:0]		FullMask, Intersection, CommonSubpath,
								CommonSubpath_Space, CommonSubpath_Space_rev,
								HighestLevel_Onehot;
	wire	[BucketAWidth-1:0]	HighestLevel_Bin;

	wire	[BCWidth-1:0]		BucketOccupancy;
	wire	[ScanTableAWidth-1:0]ScanTable_Address;
	wire	[StashEAWidth-1:0]	ScanTable_DataIn;
	wire						ScanTable_WE;

	wire	[BCLWidth-1:0]		BCounts, BCounts_New;

	wire	[ScanTableAWidth-1:0]ResetCount;
	
	//--------------------------------------------------------------------------
	//	Software debugging 
	//--------------------------------------------------------------------------

	`ifdef SIMULATION
		integer ind;
		reg ResetDone_Delayed;
		
		reg	LeafSet = 0;
		reg	[ORAML-1:0]	LeafThisAccess;
		
		always @(posedge Clock) begin
			ResetDone_Delayed <= ResetDone;
			
	`ifdef SIMULATION_VERBOSE_STASH	
			if (InScanValid & CurrentLeafValid) begin
				$display("[%m @ %t] Scan table start [SAddr: %x, PAddr: %x, Access leaf: %x, Block leaf: %x]", $time, InScanSAddr, InScanPAddr, CurrentLeaf, InScanLeaf);

				$display("\tIntersection:        %x", Intersection);
				$display("\tCommonSubpath:       %x", CommonSubpath);
				$display("\tFull mask:           %x", FullMask);
				$display("\tCommonSubpath_Space: %x", CommonSubpath_Space);
				$display("\tHighest level:       %x (one hot), %d (bin)", HighestLevel_Onehot, HighestLevel_Bin);
				
				if (OutScanAccepted & OutScanValid)
					$display("\tScan accept: entry %d will be written back", OutScanSAddr);
				if (~OutScanAccepted & OutScanValid)
					$display("\tScan reject: entry %d will NOT be written back", OutScanSAddr);
			end
	`endif		

			// Make sure the leaf is steady; if not, scan results are bogus
			if (PerAccessReset) begin
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
			
			if (CurrentLeafValid & InScanValid & InScanLeaf &
				((^CurrentLeaf === 1'bx) | (^InScanLeaf === 1'bx))) begin
				$display("[%m @ %t] ERROR: ScanTable got XX Current/Scan leaf", $time);
				$stop;
			end
	
			/* This isn't valid for read/rm commands
			if (InScanValid & (^InScanLeaf === 1'bx)) begin
				$display("[%m @ %t] ERROR: ScanTable got XX Scanleaf", $time);
				$stop;
			end
			*/
			
			if ( (OutScanAccepted | InScanValid) & InDMAValid ) begin
				$display("[%m @ %t] ERROR: ScanTable is multitasking", $time);
				$stop;
			end
			
			if (PerAccessReset | (~ResetDone_Delayed & ResetDone)) begin
				ind = 0;
				while (ind != BlocksOnPath) begin
					if (ScanTable.Mem[ind] != SNULL) begin
						$display("[%m @ %t] ERROR: Scan table address %d not initialized to SNULL (found %d)", $time, ind, ScanTable.Mem[ind]);
						$stop;
					end
					//$display("OK %d", ScanTable.Mem[ind]);
					ind = ind + 1;
				end
			end
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Reset
	//--------------------------------------------------------------------------
	
	Counter		#(			.Width(					ScanTableAWidth))
				InitCounter(.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				~ResetDone),
							.In(					{ScanTableAWidth{1'bx}}),
							.Count(					ResetCount));
	assign	ResetDone =								ResetCount == BlocksOnPath;	

	//--------------------------------------------------------------------------
	//	Stash matching logic
	//--------------------------------------------------------------------------

	// add a spot for the root bucket
	assign	CurrentLeafP1 = 						{CurrentLeaf, 1'b0};
	assign	InLeafP1 = 								{InScanLeaf, 1'b0};
	
	// Depending on leaf orientation ...
	//Reverse		#(			.Width(					ORAMLP1))
	//				Rev1(		.In(					InLeafP1 ^ CurrentLeafP1), 
	//							.Out(					Intersection));
	assign	Intersection =							InLeafP1 ^ CurrentLeafP1;
							
	assign	CommonSubpath = 						(Intersection & -Intersection) - 1;
	assign	CommonSubpath_Space =					CommonSubpath & ~FullMask;

	Reverse		#(			.Width(					ORAMLP1))
				Rev2(		.In(					CommonSubpath_Space),
							.Out(					CommonSubpath_Space_rev));

	Reverse		#(			.Width(					ORAMLP1))
				Rev3(		.In(					CommonSubpath_Space_rev & -CommonSubpath_Space_rev), 
							.Out(					HighestLevel_Onehot));

	OneHot2Bin	#(			.Width(					ORAMLP1))
				OH2B(		.OneHot(				HighestLevel_Onehot), 
							.Bin(					HighestLevel_Bin));

	//--------------------------------------------------------------------------
	//	Outputs (these can be delayed if this module creates a critical path)
	//--------------------------------------------------------------------------

	assign 	OutScanAccepted =  						CurrentLeafValid & InScanValid & |HighestLevel_Onehot; // TODO InScanValid is redundant
	assign	OutScanSAddr =							InScanSAddr;
	assign	OutScanValid = 							InScanValid;

	//--------------------------------------------------------------------------
	//	Usage tables
	//--------------------------------------------------------------------------
	
	genvar	i;
	generate for(i = 0; i < ORAMLP1; i = i + 1) begin:FANOUT
		assign 	BCounts_New[BCWidth*(i+1)-1:BCWidth*i] = 	BCounts[BCWidth*(i+1)-1:BCWidth*i] + 
															((HighestLevel_Onehot[i]) ? 1 : 0);
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
							.Enable(				OutScanAccepted),
							.In(					BCounts_New),
							.Out(					BCounts));

	generate for(i = 0; i < ORAMLP1; i = i + 1) begin:FULLMASK
		assign 	FullMask[i] = 						BCounts[BCWidth*(i+1)-1:BCWidth*i] == ORAMZ;
	end endgenerate

	Mux			#(			.Width(					BCWidth),
							.NPorts(				ORAMLP1),
							.SelectCode(			1))
				BCMux(		.Select(				HighestLevel_Onehot), 
							.Input(					BCounts),
							.Output(				BucketOccupancy));
							
	assign 	ScanTable_Address = 					(~ResetDone) ? 	ResetCount :  
													(InScanValid) ? HighestLevel_Bin * ORAMZ + BucketOccupancy : 
																	InDMAAddr;
	assign	ScanTable_WE =							OutScanAccepted | InDMAReset | ~ResetDone;

	assign	ScanTable_DataIn =						(~ResetDone | InDMAReset) ? SNULL : InScanSAddr;
	
	/*
		Points directly to locations in StashD, where blocks live that are to be 
		written back during this ORAM access.

		NOTE: This table is scanned from address 0 ... 2^StashEAWidth-1 in that 
		order.
	*/
	RAM			#(			.DWidth(				StashEAWidth),
							.AWidth(				ScanTableAWidth))
				ScanTable(	.Clock(					Clock),
							.Reset(					/* not connected */),
							.Enable(				1'b1),
							.Write(					ScanTable_WE),
							.Address(				ScanTable_Address),
							.DIn(					ScanTable_DataIn),
							.DOut(					OutDMAAddr));

	// Synchronize with ScanTable latency
	always @(posedge Clock) begin
		OutDMAValid <=								InDMAValid;
	end
							
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------

