
	// TODO update this whole file

	// Configured for the VC707 Evaluation board
	localparam	 			DDR_nCK_PER_CLK = 		4, // 200 Mhz interface; 800 Mhz DRAM
							DDRDQWidth =			64, // DQ bus width / DRAM word width
							DDRCWidth =				3, // Command width
	`ifdef SIMULATION
							DDRAWidth =				27;
	`else
							DDRAWidth =				28; // Address width max 2GB capacity = 2^34B; each unique 28b address maps to 64b of data
	`endif
	
	localparam				DDRBstLen =				2 * DDR_nCK_PER_CLK, // Burst length (in # of 64b words) (TODO do not calculate this way!)
							DDRDWidth = 			DDRBstLen * DDRDQWidth, // Data width (512b @ 200 Mhz)
							DDRMWidth =				DDRDWidth / 8, // Write mask width
							DDRROWWidth =			8192; // Big Row size in DRAM column width: 1024 column * 8 banks (TODO: make this in terms of ROW/BANK params)

	// Understood by DDR3SDRAM controllers
	localparam				DDR3CMD_Write = 		3'd0,
							DDR3CMD_Read = 			3'd1;