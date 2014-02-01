
	// algorithm-level ORAM parameters
	parameter					ORAMB =				512,
								ORAMU =				32,
								ORAML =				26, // the number of bits needed to determine a path down the tree (actual # levels is ORAML + 1)
								ORAMZ =				5,

	parameter					FEDWidth =			64, // data width of frontend busses (reading/writing from/to stash, LLC network interface width)
								BEDWidth =			128 // backend datapath width (AES bits/cycle, should be == to DDRDWidth if possible)
	
