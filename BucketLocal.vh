
	// TODO merge with Ling's parameters for calculating BktSize_DDRWords

	// Calculate size of fields in the bucket header
	localparam					BktHSize_ValidBits =	`divceil(ORAMZ,8) * 8; // = 8 bits for Z < 9
	localparam					BktHSize_Bits = 		IVEntropyWidth + BktHSize_ValidBits + IVEntropyWidth + (ORAMU * ORAMZ) + (ORAML * ORAMZ);
	localparam					BktHSize_DRBursts = 	`divceil(BktHSize_HeaderRaw, DDRDWidth);
	localparam					BktHSize_RndBits =		BktHSize_DRBursts * DDRDWidth; // = 512 for all configs we care about
	
	// Calculate size of whole bucket
	localparam					BktSize_RawBits =		BktHSize_RndBits + (ORAMZ * ORAMB);
	localparam					BktSize_RndBits =		`divceil(BktSize_RawBits, DDRDWidth) * DDRDWidth;
	
	// Translate to DDR3 words
	localparam					BktSize_DDRWords =		BktSize_RndBits / DDRDQWidth; // = E.g., for Z = 5, BktSize_TotalRnd = 3072 and BktSize_DDRWords = 48
	
	// Translate into how many bursts of data the AES units will get
	localparam					BktSize_DRBursts =		BktSize_DDRWords / DDRBstLen;
	localparam					PathSize_DRBursts =		(ORAML + 1) * Z * BktSize_DRBursts;