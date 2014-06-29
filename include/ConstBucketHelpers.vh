	
	// TODO shouldn't hash digest be factored in here?

	// Suffix meanings:
	// 	RawBits = what it sounds like ...
	// 	RndBits = bits rounded to some value (usually a DDR3 burst)
	// 	DRBursts = in terms of DDR3 bursts
	// 	DRWords = in terms of DDR3 DQ bus width (typically 64b)

	// Encryption initialization vector init values (1'bx makes it a bit cheaper in HW)
	`ifdef SIMULATION
	localparam				IVINITValue =			{32'hdeadbeef, {AESEntropy-32{1'b0}}};
	`else
	localparam				IVINITValue =			{AESEntropy{1'bx}};
	`endif

	// BEDWidth/FEDWidth-related quantities
	localparam				BlkSize_FEDChunks =		`divceil(ORAMB, FEDWidth),
							BlkSize_BEDChunks =		`divceil(ORAMB, BEDWidth),
							BktSize_BEDChunks =		ORAMZ * BlkSize_BEDChunks,
							PathSize_BEDChunks =	(ORAML + 1) * BktSize_BEDChunks;

	// ... and associated widths
	localparam				BBEDWidth =				`max(`log2(BlkSize_BEDChunks + 1), 1), // Block BED width
							PBEDWidth =				`log2(PathSize_BEDChunks); // Path BED width
	
	// DRAM header flit params
	localparam				BigVWidth =				ORAMZ,
							BigUWidth =				ORAMU * ORAMZ,
							BigLWidth =				ORAML * ORAMZ;
	localparam				BktHSize_ValidBits =	`divceil(ORAMZ,8) * 8, // = 8 bits for Z < 9
							BktHWaste_ValidBits =	BktHSize_ValidBits - ORAMZ,
							BktHVStart =			AESEntropy,
							BktHUStart =			BktHVStart + BktHSize_ValidBits, // at what position do the U's start?
							BktHLStart =			BktHUStart + BigUWidth, // at what position do the U's start?
							BktHSize_RawBits = 		BktHLStart + BigLWidth, // valid bits, addresses, leaf labels; TODO change to be in terms of BktHLStart
							BktHSize_DRBursts = 	`divceil(BktHSize_RawBits, DDRDWidth),
							BktHSize_RndBits =		BktHSize_DRBursts * DDRDWidth; // = 512 for all configs we care about
	
	// DRAM data block/bucket params
	localparam				BktPSize_RawBits =		ORAMZ * ORAMB,
							BktPSize_DRBursts =		`divceil(BktPSize_RawBits, DDRDWidth),
							BktSize_RawBits =		BktHSize_RndBits + BktPSize_RawBits,
							BktSize_DRBursts =		`divceil(BktSize_RawBits, DDRDWidth),
							BktSize_RndBits =		BktSize_DRBursts * DDRDWidth,
							BktSize_DRWords =		BktSize_RndBits / DDRDQWidth; // = E.g., for Z = 5, BktSize_TotalRnd = 3072 and BktSize_DDRWords = 48

	// ... and associated helper params
	localparam				BlkSize_DRBursts =		`divceil(ORAMB, DDRDWidth),
							PathSize_DRBursts =		(ORAML + 1) * BktSize_DRBursts,
							BBSTWidth =				`log2(BktSize_DRBursts), // Block DRAM burst width
							PBSTWidth =				`log2(PathSize_DRBursts); // Path DRAM burst width
