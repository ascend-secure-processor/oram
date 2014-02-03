
	// TODO merge with Ling's parameters for calculating BktSize_DDRWords

	// Suffix meanings:
	// 	RawBits = what it sounds like ...
	// 	RndBits = bits rounded to some value (usually a DDR3 burst)
	// 	DRBursts = in terms of DDR3 bursts
	// 	BRWords = in terms of DDR3 DQ bus width (typically 64b)
	
	// Calculate size of fields in the bucket header
	localparam					BktHSize_ValidBits =	`divceil(ORAMZ,8) * 8; // = 8 bits for Z < 9
	localparam					BktHULStart =			IVEntropyWidth + BktHSize_ValidBits + IVEntropyWidth; // at what position do the U/Ls start?
	localparam					BHULWidth =				ORAMZ * (ORAMU + ORAML);
	localparam					BktHSize_RawBits = 		BktHULStart + BHULWidth;
	localparam					BktHSize_DRBursts = 	`divceil(BktHSize_HeaderRaw, DDRDWidth);
	localparam					BktHSize_RndBits =		BktHSize_DRBursts * DDRDWidth; // = 512 for all configs we care about
	
	// Header bus widths ...
	localparam					BHWidth =				`log2(BktHSize_DRBursts);
	
	// Calculate size of whole bucket
	localparam					BktSize_RawBits =		BktHSize_RndBits + (ORAMZ * ORAMB);
	localparam					BktSize_DRBursts =		`divceil(BktSize_RawBits, DDRDWidth);
	localparam					BktSize_RndBits =		BktSize_DRBursts * DDRDWidth;
	localparam					BktSize_DRWords =		BktSize_RndBits / DDRDQWidth; // = E.g., for Z = 5, BktSize_TotalRnd = 3072 and BktSize_DDRWords = 48
	
	// Bucket bus widths ...
	
	// Translate into how many bursts of data the AES units will get
	localparam					BktSize_DRBursts =		BktSize_DDRWords / DDRBstLen;
	localparam					PathSize_DRBursts =		(ORAML + 1) * Z * BktSize_DRBursts;
	
	// ... same for BEDWidth chunks