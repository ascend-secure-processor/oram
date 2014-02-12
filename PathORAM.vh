
	// algorithm-level ORAM parameters
	parameter					ORAMB =				512, // block size in bits
								ORAMU =				32, // program addr width
								ORAML =				26, // the number of bits needed to determine a path down the tree (actual # levels is ORAML + 1)
								ORAMZ =				5, // bucket Z

	           					FEDWidth =			32, // data width of frontend busses (reading/writing from/to stash, LLC network interface width)
								BEDWidth =			128 // backend datapath width (AES bits/cycle, should be == to DDRDWidth if possible)
	