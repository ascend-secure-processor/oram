
	localparam  FullDigestWidth = 224;
	
	localparam  TrancateDigestWidth = `min(BktHSize_RndBits - BktHSize_RawBits, FullDigestWidth); // TODO trigger an assertion if this is too small (say < 80)
	
	`ifdef SIMULATION
		initial begin
			if (TrancateDigestWidth < HashPreimage) begin
				$display("[%m @ %t] ERROR: Digest size doesn't meet preimage resistance requirements.", $time);
				$finish;
			end
		end
	`endif
	
	localparam	DigestStart = FullDigestWidth,
				DigestEnd = FullDigestWidth - TrancateDigestWidth;
				
	localparam PathBufAWidth = `log2(2 * PathSize_DRBursts + 2 * BktSize_DRBursts + BktHSize_DRBursts * (ORAML+1));