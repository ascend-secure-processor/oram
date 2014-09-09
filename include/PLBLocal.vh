function [31:0] GeoSum;
    input [31:0] start, scale, num;
    integer i, tmp;
    begin
        GeoSum = 0;
		tmp = start; 
        for (i = 0; i < num; i = i + 1) begin
            GeoSum = GeoSum + tmp;
            tmp = tmp / scale;
        end
    end
endfunction  

localparam LeafWidth = PRFPosMap ? AESEntropy : 32;	
localparam LeafOutWidth = PRFPosMap ? AESEntropy : ORAML;

localparam LeafInBlock = ORAMB / LeafWidth;
localparam LogLeafInBlock = `log2f(LeafInBlock);

localparam TotalNumBlock = GeoSum(NumValidBlock, LeafInBlock, Recursion);
localparam FinalPosMapStart = GeoSum(NumValidBlock, LeafInBlock, Recursion-1);
    
localparam  FinalPosMapEntry = TotalNumBlock - FinalPosMapStart;
localparam  LogFinalPosMapEntry = `log2(FinalPosMapEntry);
