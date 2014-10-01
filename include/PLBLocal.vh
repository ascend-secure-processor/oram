function [31:0] GeoSum;
    input [31:0] start, scale, num;
    reg [31:0] i, tmp;
    begin
        GeoSum = 0;
		tmp = start; 
        for (i = 0; i < num; i = i + 1) begin
            GeoSum = GeoSum + tmp;
            tmp = tmp / scale;
        end
    end
endfunction  

localparam 	NumValidBlock = (1 << ORAML) << 2; // shift by 2 -> 50% capacity when Z = 4

localparam 	FEORAMBChunks =	ORAMB / FEDWidth;
localparam 	LogFEORAMBChunks = `log2(FEORAMBChunks);

localparam 	LeafWidth = PRFPosMap ? AESEntropy : 32;	
localparam 	LeafOutWidth = PRFPosMap ? AESEntropy : ORAML;

localparam 	LeafInBlock = ORAMB / LeafWidth;
localparam 	LogLeafInBlock = `log2f(LeafInBlock);

localparam 	TotalNumBlock = GeoSum(NumValidBlock, LeafInBlock, Recursion);
localparam 	FinalPosMapStart = GeoSum(NumValidBlock, LeafInBlock, Recursion-1);
    
localparam  FinalPosMapEntry = TotalNumBlock - FinalPosMapStart;
localparam  LogFinalPosMapEntry = `log2(FinalPosMapEntry);

`ifdef SIMULATION
initial begin
	$display("Final PMAP width %d %d %d", LogFinalPosMapEntry, Recursion, NumValidBlock);
	if (ORAMZ != 4) begin
		$display("ERROR: NumValidBlock relies on Z=4");
		$finish;	
	end
end
`endif
