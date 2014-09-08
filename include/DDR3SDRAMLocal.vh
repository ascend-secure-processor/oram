
	// Configured for DDR3SDRAM

	localparam	 			DDRDQWidth =			64, // DQ bus width / DRAM word width
							DDRCWidth =				3; // Command width
	
	localparam				DDRBstLen =				8, // Burst length (in # of 64b words)
							DDRDWidth = 			DDRBstLen * DDRDQWidth, // Data width in bits (512)
							DDRMWidth =				DDRDWidth / 8, // Byte mask
							DDRROWWidth =			8192; // Big Row size in DRAM column width: 1024 column * 8 banks (TODO: make this in terms of ROW/BANK params)

	localparam				DDR3CMD_Write = 		3'd0,
							DDR3CMD_Read = 			3'd1;
