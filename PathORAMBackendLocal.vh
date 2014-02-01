
	localparam					FEBEChunks =		BEDWidth / FEDWidth;
	
	// TODO this command naming scheme is terrible.  And make it correspond better to the convention in Stash.v
	
	// TODO do we need ReadRmv for inclusive ORAM?
	
	// Commands understood by PathORAMBackend, called by PathORAMFrontend/top module
	localparam					BECMDWidth =		2,
								CMD_Update =		2'd0, // update existing block (Write)
								CMD_Append =		2'd1, // add non-existing block (Write)
								CMD_Read = 			2'd2, // Read existing block, but leave in place (Read)
								CMD_ReadRmv =		2'd3; // Read existing block and remove (Read)