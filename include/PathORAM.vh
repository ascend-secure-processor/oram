
	// algorithm-level ORAM parameters
	parameter				ORAMB =					512, // block size in bits
							ORAMU =					32, // program addr (at byte-addressable block granularity) width
							ORAML =					13, // the number of bits needed to determine a path down the tree (actual # levels is ORAML + 1)
							ORAMZ =					5, // bucket Z
							ORAMC =					10, // Number of slots in the stash, _in addition_ to the length of one path
							ORAME = 				5, // E parameter for REW ORAM (don't care if EnableREW == 0)
								
							FEDWidth =				64, // data width of frontend busses (reading/writing from/to stash, LLC network interface width)
							BEDWidth =				512, // backend datapath width (AES bits/cycle, should be == to DDRDWidth if possible)
	
							Overclock = 			1, // Pipeline various operations inside the stash (needed for 200 Mhz operation)
							UseBRAM = 			`ifdef ASIC 0 `else Overclock `endif, 
								
							EnableAES =				0, // Should ORAM include encryption?  (All secure designs should pick 1; 0 is easier to debug)

							EnableREW =				0, // Backend mode: 0 - path ORAM with background eviction; 1 - REWORAM with background eviction

							EnableIV =          	0, // Integrity verification
							
							DelayedWB = 			0;	// delayed write back to save SHA engines for integrity
