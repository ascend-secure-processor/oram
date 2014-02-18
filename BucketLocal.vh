
	localparam					BlkSize_FEDChunks =		`divceil(ORAMB, FEDWidth);
	localparam					BlkSize_BEDChunks =		`divceil(ORAMB, BEDWidth);
	localparam					PathSize_BEDChunks =	(ORAML + 1) * ORAMZ * BlkSize_BEDChunks;

	localparam					BlkFEDWidth =			`max(`log2(BlkSize_FEDChunks), 1);
	localparam					BlkBEDWidth =			`max(`log2(BlkSize_BEDChunks), 1);
	localparam					PBEDWidth =				`log2(PathSize_BEDChunks);
	