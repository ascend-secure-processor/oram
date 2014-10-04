
	// Commands sent by user logic / Frontend, understood by Backend/Stash
	localparam				BECMDWidth =			2,
							BECMD_Update =			2'd0, // update existing block (Write)
							BECMD_Append =			2'd1, // add non-existing block (Write)
							BECMD_Read = 			2'd2, // Read existing block, but leave in place (Read)
							BECMD_ReadRmv =			2'd3; // Read existing block and remove (Read); we need this even with inclusive ORAM for PosMap blocks (i.e., they won't go poof)
							
	// Sent by BackendCore, understood by StashTop
	localparam				STCMDWidth =			2,
							STCMD_StartRead =		2'd0,
							STCMD_StartWrite =		2'd1,
							STCMD_Append =			2'd2;
								
	// Sent by Stash, understood by StashCore
	localparam				SCMDWidth =				3,
							SCMD_Update =			3'd0,
							SCMD_Append =			3'd1,
							SCMD_Read = 			3'd2,
							SCMD_Dump =				3'd3,
							SCMD_Sync =				3'd4,
							SCMD_UpdateHeader =		3'd5;
							