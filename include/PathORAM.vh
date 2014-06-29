
	parameter				ORAMB =					512, 	// block size in bits
							ORAMU =					32, 	// program addr (at byte-addressable block granularity) width
							ORAML =					13, 	// the number of bits needed to determine a path down the tree (actual # levels is ORAML + 1)
							ORAMZ =					5, 		// data block slots per bucket
							ORAMC =					10, 	// Number of slots in the stash, _in addition_ to the length of one path
							ORAME = 				5; 		// E parameter for REW ORAM (don't care if EnableREW == 0)
								
	parameter				FEDWidth =				64, 	// data width of frontend busses (reading/writing from/to stash, LLC network interface width)
															// This is typically (but doesn't have to be) <= BEDWidth
							BEDWidth =				512, 	// backend datapath width (AES bits/cycle, should be == to MEMWidth if possible)
							MEMWidth =				512;	// memory (e.g., DRAM) bus width
															// Note: 	- Specifying 	BEDWidth < MEMWidth will cause TinyORAM area and bandwidth to decrease proportionally
															//							BEDWidth == MEMWidth means ORAM will rate match memory
															//							BEDWidth > MEMWidth is bogus
															
	parameter				Overclock = 			1; 		// Pipeline various operations inside the stash (needed for 200 Mhz operation)
								
	parameter				EnableAES =				0, 		// Should ORAM include encryption?  (All secure designs should pick 1; 0 is easier to debug)
							EnableREW =				0, 		// Backend mode: 0 - path ORAM with background eviction; 1 - REWORAM with background eviction
							EnableIV =          	0; 		// Integrity verification
							
	parameter				DelayedWB = 			0;		// delayed write back to save SHA engines for integrity
