
	localparam				ROHeader_AESChunks =	`divceil(BktHSize_ValidBits + ORAMZ * ORAMU, AESWidth), // # AES chunks per bucket for RO IV
							RWBkt_AESChunks =		BktSize_DRBursts * `divceil(DDRDWidth, AESWidth) - ROHeader_AESChunks, // # AES chunks per bucket for Gentry IV
							RWPath_AESChunks =		RWBkt_AESChunks * (ORAML + 1),
							ROCIDWidth =			`log2(ROHeader_AESChunks),
							RWCIDWidth =			`log2(RWBkt_AESChunks),
							BIDWidth =				ORAML + 2, // Bucket ID width; matching AddrGen
							SeedSpaceRemaining =	AESWidth - IVEntropyWidth - BIDWidth - CIDWidth;