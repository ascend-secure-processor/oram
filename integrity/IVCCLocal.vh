	localparam	IPthStartAddr = 0,
				OPthStartAddr = PathSize_DRBursts,
				//IBktOfIStartAddr = 2 * PathSize_DRBursts,
				//OBktOfIStartAddr = 2 * PathSize_DRBursts + BktSize_DRBursts,
				//HdStartAddr = 2 * PathSize_DRBursts + 2 * BktSize_DRBursts;
				OBktOfIStartAddr = 2 * PathSize_DRBursts,
				HdStartAddr = 2 * PathSize_DRBursts + BktSize_DRBursts;
				
	localparam	TotalBucketD = 2 * (ORAML + 1);