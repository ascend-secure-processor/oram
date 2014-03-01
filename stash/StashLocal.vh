
	localparam					BASEDUMMY =			32'hdeadbeef;
	localparam					DummyBlockAddress =	(ORAMU > 32) ? { {ORAMU{1'b0}}, BASEDUMMY} : BASEDUMMY[ORAMU-1:0]; // TODO this was replaced by valid bits?

	localparam					NumChunks =			ORAMB / BEDWidth;
	localparam					ChunkAWidth =		`log2(NumChunks);
	localparam					StashEAWidth =		`log2(StashCapacity);
	localparam					StashDAWidth =		StashEAWidth + ChunkAWidth; // addr width into data-based memories
	localparam					StashHDWidth =		ORAMU + ORAML; // stash entry header
	localparam					SNULL =				StashCapacity; // an invalid stash location

	localparam					ORAMLP1 =			ORAML + 1; // the actual number of levels
	localparam					BucketAWidth =		`log2(ORAMLP1); // bucket lookup
	localparam					BlocksOnPath =		ORAMLP1 * ORAMZ;
	localparam					ScanTableAWidth =	`log2(BlocksOnPath);

	localparam					BCWidth =			`log2(ORAMZ) + 1; // need +1 to account for full buckets
	localparam					BCLWidth =	 		ORAMLP1 * BCWidth; // bitvector of bucket counts
			
	localparam					ScanTableLatency =	(Pipelined) ? 2 : 0; // = total latency through ScanTable [count the number of mpipe_X instances]
	localparam					ScanDelay =			StashCapacity + ScanTableLatency;
	localparam					SCWidth =			`log2(ScanDelay);

	// Commands understood by StashCore, called by Stash
	// TODO change naming to match PathORAMBackend
	localparam					SCMDWidth =			3,
								SCMD_Push =			3'd0,
								SCMD_Overwrite =	3'd1,
								SCMD_Peak = 		3'd2,
								SCMD_Dump =			3'd3,
								SCMD_Sync =			3'd4,
								SCMD_UpdateHeader =	3'd5;