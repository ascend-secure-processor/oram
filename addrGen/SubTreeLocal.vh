localparam L_st = `log2f(DDRROWWidth / BktSize_DRWords + 1);
localparam numST = (ORAML + 1 + L_st - 1) / L_st;       // the number of subtrees on a path

localparam STSize = 1 << L_st;    // subtree size (in buckets), it could be (1 << numST) - 1; this is optimal for Z=3 
localparam STSize_bot = 1 << ((ORAML+1) % L_st);            // short trees' size (in buckets) at the bottom

localparam numTallST = ((1 << ((numST-1)*L_st)) - 1) / ((1 << L_st) - 1);       // the number of not-short subtreess 
localparam numTotalST = ((1 << (numST*L_st)) - 1) / ((1 << L_st) - 1);          // the number of total subtreess 