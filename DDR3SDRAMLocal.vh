
	localparam					DDR3CMD_Write = 	3'b000;
	localparam					DDR3CMD_Read = 		3'b001;	
	
	localparam					DDRBstLen =			2 * DDR_nCK_PER_CLK; // Burst length (in # of 64b words)
	localparam					DDRDWidth = 		DDRBstLen * DDRDQWidth; // Data width (512b @ 200 Mhz)
	localparam					DDRMWidth =			DDRDWidth / 8; // Write mask width
	localparam					DDRROWWidth =		8192; // Big Row size in DRAM column width: 1024 column * 8 banks