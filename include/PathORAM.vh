
	localparam				PINIT =					-1;

	//--------------------------------------------------------------------------
	//	Per-ORAM instance parameters
	//--------------------------------------------------------------------------
	
	/* 	Main design/user-specific parameters.  We put the parameter definitions 
		here.  To set each parameter, instantiate TinyORAMCore and use defparam/
		parameter override syntax to set the parameter.
	
		Note: leave each setting set to PINIT in this file.  That makes it 
		easier to detect when some parameter hasn't been initialized properly. */
	
	parameter				ORAMB =					PINIT, 	// block size in bits
							ORAMU =					PINIT, 	// program addr (at byte-addressable block granularity) width
							ORAML =					PINIT, 	// the number of bits needed to determine a path down the tree (actual # levels is ORAML + 1)
							ORAMZ =					PINIT, 	// data block slots per bucket
							ORAMC =					PINIT, 	// Number of slots in the stash, _in addition_ to the length of one path
							ORAME = 				PINIT; 	// E parameter for REW ORAM (don't care if EnableREW == 0)
								
	parameter				FEDWidth =				PINIT, 	// data width of frontend busses (reading/writing from/to stash, LLC network interface width)
															// This is typically (but doesn't have to be) <= BEDWidth
							BEDWidth =				PINIT; 	// backend datapath width (access latency is \propto Path size / BEDWidth)
					
	parameter				Overclock = 			PINIT; 	// Pipeline various operations inside the stash (needed for 200 Mhz operation)
								
	parameter				EnableAES =				PINIT, 	// Should ORAM include encryption?  (All secure designs should pick 1; 0 is easier to debug)
							EnableREW =				PINIT, 	// Backend mode: 0 - path ORAM with background eviction; 1 - REWORAM with background eviction
							EnableIV =          	PINIT; 	// Integrity verification
							
	parameter				DelayedWB = 			1'b0;		// No reason for delayed WB any more

	//--------------------------------------------------------------------------
	//	Per-design security settings
	//--------------------------------------------------------------------------
	
	/* 	These constants set the security of the system.  They should be 
		specified once per design based on the needs of the design. */
	
	// Symmetric encryption
	
	// Set AESEntropy such that you don't expect to make > 2^AESEntropy ORAM accesses
	localparam				AESEntropy =			64, // 2^64 ciphertexts = ORAM must run for 100+ years; this should be sufficient for all designs
	           				AESWidth =				128; // We use AES-128

	// Integrity verification
	
	// Given ORAMH (the HashPreimage width), the ORAM core will ensure that resistance against preimage attacks is >= 2^HashPreimage.  Resistance against collisions is correspondingly >= 2^(HashPreimage/2).
	localparam				ORAMH =					128; // The minimum recommended preimage resistance according to the HMAC spec
	localparam				HashKeyLength = 		128;
	