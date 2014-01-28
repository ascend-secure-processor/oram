
	parameter 					DDR_nCK_PER_CLK = 	4, // 200 Mhz interface; 800 Mhz DRAM
								DDRDQWidth =		64, // DQ bus width / DRAM word width
								DDRCWidth =			3, // Command width
								DDRBstLen =			2 * DDR_nCK_PER_CLK, // Burst length (in # of 64b words)
								DDRDWidth = 		DDRBstLen * DDRDQWidth, // Data width (512b @ 200 Mhz)
								DDRMWidth =			DDRDWidth / 8, // Write mask width
								DDRAWidth =			28 // Address width max 2GB capacity = 2^34B; each unique 28b address maps to 64b of data
								