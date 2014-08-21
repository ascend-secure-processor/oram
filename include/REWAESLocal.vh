
	localparam				ROHeader_VUBits =		BktHSize_ValidBits + BigUWidth,
							//ROHeader_IVBits =		TODO add support for IV
							ROHeader_RawBits =		ROHeader_VUBits,// + ROHeader_IVBits,
							
							ROHeader_AESChunks =	`divceil(ROHeader_RawBits, AESWidth), // # AES chunks per bucket for RO IV
							RWHeader_AESChunks =	`divceil(BigLWidth, AESWidth),

							Blk_AESChunks =			`divceil(ORAMB, AESWidth),
							RWPayload_AESChunks =	ORAMZ * Blk_AESChunks, // # AES chunks per bucket for Gentry IV
							RWBkt_AESChunks =		RWHeader_AESChunks + RWPayload_AESChunks,
							RWBkt_MaskChunks =		`divceil(RWBkt_AESChunks, Blk_AESChunks), // # mask out FIFO commits per bucket
							RWPath_AESChunks =		RWPayload_AESChunks * (ORAML + 1),
							RWPath_MaskChunks =		RWBkt_MaskChunks * (ORAML + 1),
							ROIWaitSteps =			`divceil(DDRDWidth, AESWidth) - RWBkt_AESChunks % `divceil(DDRDWidth, AESWidth),
							
							CIDWidth =				`max(`log2(ROHeader_AESChunks), `log2(RWPayload_AESChunks)) + 1, // + 1 for when it is a power of 2
							BIDWidth =				ORAML + 1, // Bucket ID width = ORAML + 1, no wasted space in subtree scheme (TODO: add this param to addr gen as well)
							SeedSpaceRemaining =	AESWidth - AESEntropy - BIDWidth - CIDWidth,
							
							// *** NOTA BENE *** if you change the REWMaskFIFO depth, you must change this to match
							MaskFIFODepth =			512,
							InFlightMaskLimit =		`divceil(MaskFIFODepth, RWBkt_MaskChunks) - 1 - 1, // -1 to get divfloor(); -1 because we tick the mask count when the _header_ flit is read
							IFMWidth =				`log2(InFlightMaskLimit);
							
	localparam				AESLatency =			21;	// based on tiny_aes + extra stages we add
	localparam				AESLatencyPlus =		32; // The expected _total_ latency through REWAESCore (factoring in cross clock FIFOs/etc).  We prefer 32deep because this best packs LUTRAMs.
						
	// RO command encodings.  Only AESREWORAM needs these.
	localparam				PCCMDWidth =			1,
							PCMD_ROHeader =			1'b0,
							PCMD_ROData =			1'b1;							
			
	// Inner command encodings.  Only REWAESCore needs these.
	// NOTE: If you change the encoding, make sure to change ACMDROBit, ACMDRWBit as well!
	localparam				ACCMDWidth =			2,
							ACMDROBit =				0, // Bit position that distinguishes RO commands
							ACMDRWBit =				1, // Bit position that distinguishes RO from RW accesses
							CMD_ROHeader =			{1'b0, PCMD_ROHeader},
							CMD_ROData =			{1'b0, PCMD_ROData},
							CMD_RWData =			2'b10;