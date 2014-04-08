
	localparam				ROHeader_AESChunks =	`divceil(BktHSize_ValidBits + ORAMZ * ORAMU, AESWidth), // # AES chunks per bucket for RO IV
							RWBkt_AESChunks =		BktSize_DRBursts * `divceil(DDRDWidth, AESWidth) - ROHeader_AESChunks, // # AES chunks per bucket for Gentry IV
							RWPath_AESChunks =		RWBkt_AESChunks * (ORAML + 1),
							ROCIDWidth =			`log2(ROHeader_AESChunks),
							RWCIDWidth =			`log2(RWBkt_AESChunks),
							BIDWidth =				ORAML + 2, // Bucket ID width; matching AddrGen
							SeedSpaceRemaining =	AESWidth - IVEntropyWidth - BIDWidth - CIDWidth;
							
	localparam				BlkSize_AESChunks =		`divceil(ORAMB, AESWidth);						
							
	// RO command encodings.  Only AESREWORAM needs these.
	localparam				PCCMDWidth =			1,
							PCMD_ROHeader =			1'b0,
							PCMD_ROData =			1'b1;							
			
	// Inner command encodings.  Only REWAESCore needs these.
	localparam				ACCMDWidth =			2,
							ACMDROBit =				0, // Bit position that distinguishes RO commands
							ACMDRWBit =				1, // Bit position that distinguishes RO from RW accesses
							CMD_ROHeader =			{1'b0, PCMD_ROHeader},
							CMD_ROData =			{1'b0, PCMD_ROData},
							CMD_RWData =			2'b10;