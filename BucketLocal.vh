
	// TODO merge with Ling's parameters for calculating BktSize_DDRWords

	localparam					BlkSize_BEDChunks =		`divceil(ORAMB, BEDWidth);
	localparam					BlkBEDWidth =			`max(`log2(BlkSize_BEDChunks), 1);
	localparam					PathSize_BEDChunks =	(ORAML + 1) * ORAMZ * BlkSize_BEDChunks;
	localparam					PBEDWidth =				`log2(PathSize_BEDChunks);
	