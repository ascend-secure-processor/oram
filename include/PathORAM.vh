


localparam				PINIT =					-1; 
`ifdef PINIT_HEADER
	
	//--------------------------------------------------------------------------
	//	Per-ORAM instance parameters
	// 		This option is for a design with multiple ORAMs with different parameters.
	//		In that case, pass parameters from outside TinyORAMCore 
	//--------------------------------------------------------------------------

	parameter				ORAMB =					PINIT, 
							ORAMU =					PINIT, 
							ORAML =					PINIT, 
							ORAMZ =					PINIT, 
							ORAMC =					PINIT, 
							ORAME = 				PINIT; 
								
	parameter				FEDWidth =				PINIT, 
														
							BEDWidth =				PINIT; 
					
	parameter				Overclock = 			PINIT; 
								
	parameter				EnableAES =				PINIT, 
							EnableREW =				PINIT, 
							EnableIV =          	PINIT; 
							
	parameter				DelayedWB = 			1'b0;

`else	

	parameter				ORAMB =					512, 	// block size in bits
							ORAMU =					32, 	// program addr (at byte-addressable block granularity) width
							ORAMZ =					4, 		// data block slots per bucket
							ORAMC =					10, 	// Number of slots in the stash, _in addition_ to the length of one path
							ORAME = 				5; 		// E parameter for REW ORAM (don't care if EnableREW == 0)
	
	// the number of bits needed to determine a path down the tree (actual # levels is ORAML + 1)
	`ifdef SIMULATION_VIVADO
		parameter 			ORAML =					20;		// cannot simulate too large an ORAM
	`else
		parameter 			ORAML =					22; 
	`endif
	
	parameter				FEDWidth =				64, 	// data width of frontend busses (reading/writing from/to stash, LLC network interface width)
															// This is typically (but doesn't have to be) <= BEDWidth
							BEDWidth =				64; 	// backend datapath width (access latency is \propto Path size / BEDWidth)
					
	parameter				Overclock = 			1; 		// Pipeline various operations inside the stash (needed for 200 Mhz operation)
								
	parameter				EnableAES =				1, 		// Should ORAM include encryption?  (All secure designs should pick 1; 0 is easier to debug)
							EnableREW =				0, 		// Backend mode: 0 - path ORAM with background eviction; 1 - REWORAM with background eviction
							EnableIV =          	1; 		// Integrity verification
							
	parameter				DelayedWB = 			1'b0;		// No reason for delayed WB any more
	
`endif

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
	
