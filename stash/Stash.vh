			
		parameter				// improves throughput for path writeback operations
								// [if == 1, throughput will be <= 50%, == 2, 100% is possible, > 2 for very unpredictable DRAM]
								StashOutBuffering =	2,
								
								// When we simulate, should we fail if we are looking for a block but cannot find it?
								// KEEP THIS DEFAULTED TO 1
								StopOnBlockNotFound = 1