
	// Suffix meanings:
	// 	RawBits = what it sounds like ...
	// 	RndBits = bits rounded to some value (usually a DDR3 burst)
	// 	DRBursts = in terms of DDR3 bursts
	// 	DRWords = in terms of DDR3 DQ bus width (typically 64b)

`ifdef SIMULATION
	initial begin
		if (ORAMB == PINIT ||
			ORAMU == PINIT ||
			ORAML == PINIT ||
			ORAMZ == PINIT ||
			BEDWidth == PINIT ||
		    EnableIV == PINIT) begin
			$display("[%m] ERROR: parameter uninitialized.");
			$finish;
		end
	end
`endif

	localparam				IVINITValue =			{AESEntropy{1'b0}};

	//--------------------------------------------------------------------------
	//	Raw bit fields
	//--------------------------------------------------------------------------

	// Header flit
	localparam				BigVWidth =				ORAMZ,
							BigUWidth =				ORAMU * ORAMZ,
							BigLWidth =				ORAML * ORAMZ,
							BigHWidth =				ORAMH * ORAMZ;
	localparam				BktHSize_ValidBits =	`divceil(ORAMZ, 8) * 8, 
							BktHWaste_ValidBits =	BktHSize_ValidBits - ORAMZ,
							BktHVStart =			AESEntropy,
							BktHUStart =			BktHVStart + BktHSize_ValidBits, // at what position do the U's start?
							BktHLStart =			BktHUStart + BigUWidth, // at what position do the L's start?
							BktHHStart =			BktHLStart + BigLWidth,	// at what position do the Hashes start?
							BktHSize_RawBits = 		BktHHStart + ((EnableIV) ? BigHWidth : 0);

	//--------------------------------------------------------------------------
	//	Quantities in terms of the Memory/DRAM width
	//--------------------------------------------------------------------------

	// Now, we align bitfields to DDR3 burst lengths.  This means (for BEDWidth
	// == DDRDWidth) that we won't need expensive re-alignment logic in ORAM.
	// For the BEDWidth < DDRDWidth case, we will lose bandwidth if ORAMB % DDRDWidth != 0.

	localparam				BlkSize_DRBursts =		`divceil(ORAMB, DDRDWidth),
							BktHSize_DRBursts = 	`divceil(BktHSize_RawBits, DDRDWidth),
							BktPSize_DRBursts =		ORAMZ * BlkSize_DRBursts,
							BktHSize_RndBits =		BktHSize_DRBursts * DDRDWidth, // = 512 or 1024 for all configs we care about
							BktPSize_RndBits =		BktPSize_DRBursts * DDRDWidth;

	localparam				BktSize_DRBursts =		BktHSize_DRBursts + BktPSize_DRBursts,
							BktSize_RndBits =		BktSize_DRBursts * DDRDWidth,
							BktSize_DRWords =		BktSize_RndBits / DDRDQWidth; // = E.g., for Z = 5, BktSize_TotalRnd = 3072 and BktSize_DDRWords = 48

	// ... and associated helper params
	localparam
							PathSize_DRBursts =		(ORAML + 1) * BktSize_DRBursts,
							PathPSize_DRBursts =	(ORAML + 1) * BktPSize_DRBursts,
							BBSTWidth =				`log2(BktSize_DRBursts), // Bucket DRAM burst width
							PBSTWidth =				`log2(PathSize_DRBursts); // Path DRAM burst width

	//--------------------------------------------------------------------------
	//	Quantities in terms of BEDWidth
	//--------------------------------------------------------------------------

	// BEDWidth/FEDWidth-related quantities
	localparam				BstSize_BEDChunks =		`divceil(DDRDWidth, BEDWidth),
							BlkSize_BEDChunks =		BlkSize_DRBursts * BstSize_BEDChunks,
							BktHSize_BEDChunks =	`divceil(BktHSize_RndBits, BEDWidth),
							BktPSize_BEDChunks =	`divceil(BktPSize_RndBits, BEDWidth),
							BktSize_BEDChunks =		BktHSize_BEDChunks + BktPSize_BEDChunks,
							PathPSize_BEDChunks =	(ORAML + 1) * BktPSize_BEDChunks,
							PathSize_BEDChunks =	(ORAML + 1) * BktSize_BEDChunks;

	localparam				RHWidth =				BktHSize_BEDChunks * BEDWidth;

	//--------------------------------------------------------------------------
	//	DRAM Addressing
	//--------------------------------------------------------------------------

	localparam 				L_st = 					`log2f(DDRROWWidth / BktSize_DRWords + 1);
	localparam 				numST = 				(ORAML + 1 + L_st - 1) / L_st; // the number of subtrees on a path

	localparam 				numTallST = 			((1 << ((numST-1)*L_st)) - 1) / ((1 << L_st) - 1); // the number of not-short subtreess 
	localparam 				numTotalST = 			((1 << (numST*L_st)) - 1) / ((1 << L_st) - 1); // the number of total subtreess 

    localparam				NumBuckets =  			(1 << (ORAML + 1)) + numTotalST; // Last addr of the ORAM tree (in buckets). We waste one bucket per subtree.

	localparam				DDRAWidth =				`log2(NumBuckets + 1) + `log2(BktSize_DRWords); // DRAM burst address for last bucket

`ifdef SIMULATION
	initial begin
		$display("DDRAWidth = %d", DDRAWidth);
	end
`endif