function [31:0] GeoSum;
    input [31:0] start, scale, num;
    begin
        GeoSum = 0;   
        for (integer i = 0; i < num; i = i + 1) begin
            GeoSum = GeoSum + start;
            start = start / scale;
        end
    end
endfunction  

localparam LeafInBlock = ORAMB / LeafWidth;
localparam LogLeafInBlock = `log2f(LeafInBlock);

localparam TotalNumBlock = GeoSum(NumValidBlock, LeafInBlock, Recursion);
localparam FinalPosMapStart = GeoSum(NumValidBlock, LeafInBlock, Recursion-1);
    
localparam  FinalPosMapEntry = TotalNumBlock - FinalPosMapStart;
localparam  LogFinalPosMapEntry = `log2(FinalPosMapEntry);