			
		parameter				// improves throughput for path writeback operations
								// [if == 2, throughput will be <= 50%, == 3, 100% is possible, > 3 for very unpredictable DRAM]
								StashOutBuffering =	3,
								
								// When we simulate, should we fail if we are looking for a block but cannot find it?
								// KEEP THIS DEFAULTED TO 1
								StopOnBlockNotFound = 1;