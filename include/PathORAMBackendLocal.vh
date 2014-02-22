
	localparam					FEORAMBChunks =		ORAMB / FEDWidth;
	localparam                  LogFEORAMBChunks = `log2(FEORAMBChunks);
	
	// TODO this command naming scheme is terrible.  And make it correspond better to the convention in Stash.v
	
	// Commands understood by PathORAMBackend, called by PathORAMFrontend/top module
	localparam					BECMDWidth =		2,
								BECMD_Update =		2'd0, // update existing block (Write)
								BECMD_Append =		2'd1, // add non-existing block (Write)
								BECMD_Read = 		2'd2, // Read existing block, but leave in place (Read)
								BECMD_ReadRmv =		2'd3; // Read existing block and remove (Read); we need this even with inclusive ORAM for PosMap blocks (i.e., they won't go poof)