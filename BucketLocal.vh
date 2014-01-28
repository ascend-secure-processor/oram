
	// Calculate size of fields in the bucket header
	localparam					BktSize_ValidBits =	divceil(ORAMZ,8) * 8;
	localparam					BktSize_HeaderRaw = IVEntropyWidth + BucketSize_ValidBits + IVEntropyWidth + (ORAMU * ORAMZ) + (ORAML * ORAMZ);
	localparam					BktSize_HeaderRnd =	divceil(BktSize_HeaderRaw, DDRDWidth) * DDRDWidth;
	
	// Calculate size of whole bucket
	localparam					BktSize_TotalRaw =	BktSize_HeaderRnd + (ORAMZ * ORAMB);
	localparam					BktSize_TotalRnd =	divceil(BktSize_TotalRaw, DDRDWidth) * DDRDWidth;
	
	// Translate to DDR3 words
	localparam					BktSize_DDRWords =	BktSize_TotalRnd / DDRDQWidth;