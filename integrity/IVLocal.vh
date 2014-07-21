
	localparam				MIWidth =				ORAMU + AESEntropy,
							BlkSize_FEDChunks = 	`divceil(ORAMB, FEDWidth),
							
							MAC_FEDChunks =			`divceil(ORAMH, FEDWidth),
							MACHeader_FEDChunks =	`divceil(MIWidth, FEDWidth),
							
							MACHPADWidth =			MACHeader_FEDChunks * FEDWidth,
							MACPADWidth =			AESEntropy * MAC_FEDChunks,
							SMH_Padding =			MACHeader_FEDChunks * FEDWidth - MIWidth,
							
							BFHWidth =				`log2(MACHeader_FEDChunks),
							BFPWidth =				`log2(BlkSize_FEDChunks),
							BEPWidth =				`log2(BlkSize_FEDChunks + MAC_FEDChunks); // FED chunks in ORAMB + hash
				