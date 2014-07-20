
	localparam				BlkSize_FEDChunks = 	`divceil(ORAMB, FEDWidth),
							MIWidth =				ORAMU + AESEntropy,
							
							MAC_FEDChunks =			`divceil(AESEntropy, FEDWidth),
							MACHeader_FEDChunks =	`divceil(MIWidth, FEDWidth),
							
							MACHPADWidth =			MACHeader_FEDChunks * FEDWidth,
							MACPADWidth =			AESEntropy * MAC_FEDChunks,
							SMH_Padding =			MACHeader_FEDChunks * FEDWidth - MIWidth,
							BFHWidth =				`log2(MACHeader_FEDChunks),
							BFPWidth =				`log2(BlkSize_FEDChunks),
							BEPWidth =				`log2(BlkSize_FEDChunks + MAC_FEDChunks); // FED chunks in ORAMB + hash
				