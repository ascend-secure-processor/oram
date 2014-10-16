
	localparam				DBDCWidth =				32,
							DBCCWidth =				`log2(`divceil(ORAMB, FEDWidth)); // Debug counters

	localparam				JTWidth_AES =			3;						
							
	localparam				JTWidth_StashCore =		3;
	
	localparam				JTWidth_Stash =			8;
	
	localparam				JTWidth_StashTop =		4;
	
	localparam				JTWidth_BackendCore =	2;
	
	localparam				JTWidth_BackendERR =	1, // error signals
							JTWidth_BackendF1 =		6, // PMMAC - BackendCore R/V signals for cmd,store,load
							JTWidth_BackendF2 =		8, // BackendCore - AES and AES - DRAM R/V signals
							JTWidth_BackendCnt =	2 * DBCCWidth + 4 * DBDCWidth,
							JTWidth_BackendCmd =	BECMDWidth + ORAMU + 2 * ORAML, // last BEnd command
							JTWidth_Backend =		JTWidth_BackendERR + 
													JTWidth_BackendF1 + 
													JTWidth_BackendF2 +
													JTWidth_BackendCnt + 
													JTWidth_BackendCmd;
	
	localparam				JTWidth_PMMAC =			1;
	
	localparam				JTWidth_UORAM =			1;
	
	localparam				JTWidth_FrontendF1 =	6, // L2 - UORAMController R/V signals for cmd,store,load
							JTWidth_FrontendF2 =	6, // UORAMController - PMMAC R/V signals for cmd,store,load
							JTWidth_FrontendCnt =	2 * DBDCWidth + 2 * DBDCWidth + 2 * DBCCWidth, // access counters
							JTWidth_FrontendCmd =	BECMDWidth + ORAMU + DMWidth, // last FEnd command
							JTWidth_Frontend =		JTWidth_FrontendF1 + 
													JTWidth_FrontendF2 + 
													JTWidth_FrontendCnt + 
													JTWidth_FrontendCmd;
	
	localparam				JTWidth_Traffic =		1;
	
	localparam				JTWidth_Top =			32; // just deadbeef
	
	localparam				JTWidth =				JTWidth_AES + 
													JTWidth_StashCore +
													JTWidth_Stash + 
													JTWidth_StashTop + 
													JTWidth_BackendCore + 
													JTWidth_Backend + 
													JTWidth_PMMAC + 
													JTWidth_UORAM + 
													JTWidth_Frontend + 
													JTWidth_Traffic + 
													JTWidth_Top;
