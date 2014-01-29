
	// TODO merge with Ling's parameters for calculating BktSize_DDRWords

	// Calculate size of fields in the bucket header
	localparam					BktSize_ValidBits =	`divceil(ORAMZ,8) * 8; // = 8 bits for Z < 9
	localparam					BktSize_HeaderRaw = IVEntropyWidth + BktSize_ValidBits + IVEntropyWidth + (ORAMU * ORAMZ) + (ORAML * ORAMZ);
	localparam					BktSize_HeaderRnd =	`divceil(BktSize_HeaderRaw, DDRDWidth) * DDRDWidth; // = 512 for all configs we care about
	
	// Calculate size of whole bucket
	localparam					BktSize_TotalRaw =	BktSize_HeaderRnd + (ORAMZ * ORAMB);
	localparam					BktSize_TotalRnd =	`divceil(BktSize_TotalRaw, DDRDWidth) * DDRDWidth;
	
	// Translate to DDR3 words
	localparam					BktSize_DDRWords =	BktSize_TotalRnd / DDRDQWidth; // = E.g., for Z = 5, BktSize_TotalRnd = 3072 and BktSize_DDRWords = 48