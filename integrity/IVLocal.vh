
	localparam				MIWidth =				ORAMU + AESEntropy,
	
							BlkSize_FEDChunks = 	`divceil(ORAMB, FEDWidth),						
							MI_FEDChunks =			`divceil(MIWidth, FEDWidth),
							MAC_FEDChunks =			`divceil(ORAMH, FEDWidth),
							
							MIPADWidth =			MI_FEDChunks * FEDWidth,
							MACPADWidth =			MAC_FEDChunks * FEDWidth,
							
							BFHWidth =				`log2(MI_FEDChunks),
							BFPWidth =				`log2(BlkSize_FEDChunks),
							BEPWidth =				`log2(BlkSize_FEDChunks + MAC_FEDChunks); // FED chunks in ORAMB + hash
				