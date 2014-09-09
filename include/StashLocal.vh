
	`ifdef SIMULATION
	initial begin
		if (ORAMB == PINIT || 
			ORAMU == PINIT ||
			ORAML == PINIT ||
			ORAMZ == PINIT ||
			BEDWidth == PINIT ||
			EnableIV == PINIT) begin
			$display("[%m] ERROR: parameter uninitialized.");
			$finish;
		end
	end
	`endif

	localparam					ORAMLP1 =			ORAML + 1; // the actual number of levels
	localparam					BktAWidth =			`log2(ORAMLP1); // bucket lookup
	localparam					BlocksOnPath =		ORAMLP1 * ORAMZ;
	localparam					StashCapacity =		BlocksOnPath + ORAMC; // including the path ...
	localparam					SNULL =				StashCapacity; // an invalid stash location
	localparam					BASEDUMMY =			32'hdeaf9999;
	localparam					DummyHash =			{ORAMH{1'b1}};
	localparam					DummyBlockAddress =	(ORAMU > 32) ? { {ORAMU{1'b0}}, BASEDUMMY} : BASEDUMMY[ORAMU-1:0];
	localparam					DummyLeafLabel =	(ORAML > 32) ? { {ORAML{1'b0}}, BASEDUMMY} : BASEDUMMY[ORAML-1:0];
	localparam					DummyBlock =		{BEDWidth{1'b0}};
	
	localparam					NumChunks =			ORAMB / BEDWidth;
	localparam					ChnkAWidth =		`max(1, `log2(NumChunks));
	localparam					SEAWidth =			`log2(StashCapacity); // Stash entry address width (into header-based memories)
	localparam					SDAWidth =			SEAWidth + ChnkAWidth; // addr width into data-based memories
	localparam					SHDWidth =			ORAMU + ORAML + ((EnableIV) ? ORAMH : 0); // Stash header width

	localparam					STAWidth =			`log2(BlocksOnPath); // ScanTable Address Width
	localparam					STAP1Width =		STAWidth + 1;
	
	localparam					BCWidth =			`log2(ORAMZ) + 1; // need +1 to account for full buckets
	localparam					BCLWidth =	 		ORAMLP1 * BCWidth; // bitvector of bucket counts
			
	localparam					ScanTableLatency =	(Overclock) ? 4 : 0; // = total latency through ScanTable [count the number of mpipe_X instances]
	localparam					ScanDelay =			ORAMC + ScanTableLatency + 2*ORAME;
	localparam					SCWidth =			`max(1, `log2(ScanDelay));
