
	// TODO merge with Ling's parameters for calculating BktSize_DDRWords

	// All sorts of parameters for calculating bucket lengths, paths, etc
	
	// Suffix meanings:
	// 	RawBits = what it sounds like ...
	// 	RndBits = bits rounded to some value (usually a DDR3 burst)
	// 	DRBursts = in terms of DDR3 bursts
	// 	BRWords = in terms of DDR3 DQ bus width (typically 64b)
	
	// Calculate size of fields in the bucket header
	localparam					BktHSize_ValidBits =	`divceil(ORAMZ,8) * 8; // = 8 bits for Z < 9
	localparam					BktHULStart =			IVEntropyWidth + BktHSize_ValidBits + IVEntropyWidth; // at what position do the U/Ls start?
	localparam					BHULWidth =				ORAMZ * (ORAMU + ORAML); // # wires for Us and Ls in a bucket
	localparam					BktHSize_RawBits = 		BktHULStart + BHULWidth;
	localparam					BktHSize_DRBursts = 	`divceil(BktHSize_RawBits, DDRDWidth);
	localparam					BktHSize_RndBits =		BktHSize_DRBursts * DDRDWidth; // = 512 for all configs we care about
	
	// Width of a counter for the # of DDR3 bursts in a bucket header
	localparam					BHBSTWidth =			`max(1, `log2(BktHSize_DRBursts));

	// Calculate size of whole bucket
	localparam					BktPSize_RawBits =		ORAMZ * ORAMB;
	localparam					BktSize_RawBits =		BktHSize_RndBits + BktPSize_RawBits;
	localparam					BktSize_DRBursts =		`divceil(BktSize_RawBits, DDRDWidth);
	localparam					BktSize_RndBits =		BktSize_DRBursts * DDRDWidth;
	localparam					BktSize_DRWords =		BktSize_RndBits / DDRDQWidth; // = E.g., for Z = 5, BktSize_TotalRnd = 3072 and BktSize_DDRWords = 48
	
	// Width of a counter for the # of BEDWidth chunks in a path (worth of data payloads)
	localparam					PBSTWidth =				`log2(`divceil(BktPSize_RawBits, BEDWidth));
	
	// Translate into how many bursts of data the AES units will get
	localparam					PathSize_DRBursts =		(ORAML + 1) * ORAMZ * BktSize_DRBursts;