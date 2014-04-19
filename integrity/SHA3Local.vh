
	localparam  FullDigestWidth = 512;
	
	localparam  TrancateDigestWidth = `min(BktHSize_RndBits - BktHSize_RawBits, FullDigestWidth); // TODO trigger an assertion if this is too small (say < 80)
	
	localparam	DigestStart = FullDigestWidth,
				DigestEnd = FullDigestWidth - TrancateDigestWidth;
				
	localparam PathBufAWidth = `log2(2 * PathSize_DRBursts + 2 * BktSize_DRBursts + BktHSize_DRBursts * (ORAML+1));