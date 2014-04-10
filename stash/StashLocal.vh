
	localparam					ORAMLP1 =			ORAML + 1; // the actual number of levels
	localparam					BktAWidth =			`log2(ORAMLP1); // bucket lookup
	localparam					BlocksOnPath =		ORAMLP1 * ORAMZ;
	localparam					StashCapacity =		BlocksOnPath + ORAMC; // including the path ...
	localparam					SNULL =				StashCapacity; // an invalid stash location
	localparam					BASEDUMMY =			32'hdeadbeef;
	localparam					DummyBlockAddress =	(ORAMU > 32) ? { {ORAMU{1'b0}}, BASEDUMMY} : BASEDUMMY[ORAMU-1:0];
	localparam					DummyLeaf =			(ORAML > 32) ? { {ORAML{1'b0}}, BASEDUMMY} : BASEDUMMY[ORAML-1:0];
	localparam					DummyBlock =		{BEDWidth{1'b0}};
	
	localparam					NumChunks =			ORAMB / BEDWidth;
	localparam					ChnkAWidth =		`log2(NumChunks);
	localparam					SEAWidth =			`log2(StashCapacity); // Stash entry address width (into header-based memories)
	localparam					SDAWidth =			SEAWidth + ChnkAWidth; // addr width into data-based memories
	localparam					SHDWidth =			ORAMU + ORAML; // Stash header width

	localparam					STAWidth =			`log2(BlocksOnPath); // ScanTable Address Width

	localparam					BCWidth =			`log2(ORAMZ) + 1; // need +1 to account for full buckets
	localparam					BCLWidth =	 		ORAMLP1 * BCWidth; // bitvector of bucket counts
			
	localparam					ScanTableLatency =	(Overclock) ? 4 : 0; // = total latency through ScanTable [count the number of mpipe_X instances]
	localparam					ScanDelay =			ORAMC + ScanTableLatency;
	localparam					SCWidth =			`log2(ScanDelay);

	// Commands understood by StashCore, called by Stash
	localparam					SCMDWidth =			3,
								SCMD_Push =			3'd0,
								SCMD_Overwrite =	3'd1,
								SCMD_Peak = 		3'd2,
								SCMD_Dump =			3'd3,
								SCMD_Sync =			3'd4,
								SCMD_UpdateHeader =	3'd5;
