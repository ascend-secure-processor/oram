				
/* Pros and cons of this style:

*/
			
parameter				DataWidth =				128,
						StashCapacity =			100, // isn't restricted to be > path length
						ORAMB =					512,
						ORAMU =					32,
						ORAML =					32,
						ORAMZ =					2;

`ifdef MACROSAFE
	localparam			DummyBlockAddress =		32'hdeadbeef;

	localparam			NumChunks =				ORAMB / DataWidth;
	localparam			ChunkAWidth =			`log2(NumChunks);
	localparam			StashEAWidth =			`log2(StashCapacity);
	localparam			StashDAWidth =			StashEAWidth + ChunkAWidth; // addr width into data-based memories
	localparam			StashHDWidth =			ORAMU + ORAML; // stash entry header
	localparam			SNULL =					StashCapacity; // an invalid stash location

	localparam			ORAMLP1 =				ORAML + 1; // the actual number of levels
	localparam			BucketAWidth =			`log2(ORAMLP1); // bucket lookup
	localparam			BlocksOnPath =			ORAMLP1 * ORAMZ;
	localparam			ScanTableAWidth =		`log2(BlocksOnPath);

	localparam			BCWidth =				`log2(ORAMZ) + 1; // need +1 to account for full buckets
	localparam			BCLWidth =	 			ORAMLP1 * BCWidth; // bitvector of bucket counts
	
	localparam			ScanTableLatency =		0; // UPDATE if this changes
	localparam			ScanDelay =				StashCapacity + ScanTableLatency;
	localparam			SCWidth =				`log2(ScanDelay);
`endif

// Commands understood by StashCore
localparam				CMDWidth =				3,
						CMD_Push =				3'd0,
						CMD_Overwrite =			3'd1,
						CMD_Peak = 				3'd2,
						CMD_Dump =				3'd3,
						CMD_Sync =				3'd4;
