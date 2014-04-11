
	localparam				ROHeader_AESChunks =	`divceil(BktHSize_ValidBits + ORAMZ * ORAMU, AESWidth), // # AES chunks per bucket for RO IV
							RWHeader_RawBits =		ORAMZ * ORAML,
							RWHeader_AESChunks =	`divceil(RWHeader_RawBits, AESWidth),
							RWBlk_AESChunks =		`divceil(ORAMB, AESWidth),
							RWBkt_AESChunks =		ORAMZ * RWBlk_AESChunks, // # AES chunks per bucket for Gentry IV
							RWBkt_MaskChunks =		`divceil(RWBkt_AESChunks + RWHeader_AESChunks, RWBlk_AESChunks), // # mask out FIFO commits per bucket
							RWPath_AESChunks =		RWBkt_AESChunks * (ORAML + 1),
							CIDWidth =				`max(`log2(ROHeader_AESChunks), `log2(RWBkt_AESChunks)),
							BIDWidth =				ORAML + 2, // Bucket ID width; ORAML + 2 to account for wasted space in subtree scheme (TODO: add this param to addr gen as well)
							SeedSpaceRemaining =	AESWidth - IVEntropyWidth - BIDWidth - CIDWidth;
							
	localparam				BlkSize_AESChunks =		`divceil(ORAMB, AESWidth);						
							
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