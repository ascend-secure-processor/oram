			
		parameter				StashCapacity =		100, // isn't restricted to be > path length
	
								// improves throughput for path writeback operations
								// [if == 1, throughput will be <= 50%, == 2, 100% is possible, > 2 for very unpredictable DRAM]
								StashOutBuffering =	2