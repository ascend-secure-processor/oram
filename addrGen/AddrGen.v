module AddrGen(Clock, Reset, Enable, 
              leaf, ORAMLevels, L_st,
              BktSize, STSize, numCompST, STSize_bot,
              currentLevel, PhyAddr,
              STIdx, BktIdx, // tmp output for debugging
              );
  
  `include "addrGenConst.v"
  
  input Clock, Reset, Enable;  
  input [maxORAML-1:0] leaf;
  input [maxlogL-1:0]  ORAMLevels, L_st;  
  input [maxORAML-1:0] BktSize, STSize, numCompST, STSize_bot;  // Bytes related parameters
  output reg [maxlogL-1:0]  currentLevel;
  output [maxAddrWidth-1:0] PhyAddr;

  // ORAM structure information and state counters
  wire [maxlogL-1:0] numST;
  wire [maxORAML-1:0] leaf_padded, leaf_in;  
  reg [maxlogL-1:0] currentST;
  
  assign numST = (ORAMLevels + L_st - 1) / L_st;
  assign leaf_padded = leaf << (numST * L_st - ORAMLevels + 1);
  assign leaf_in = (leaf >> (ORAMLevels - 1 - currentST * L_st)) % (1 << L_st);    
  initial begin    
    currentST = 1;
    currentLevel = 0;
  end
  
  // use two PathGen modules to get subtree indices and bucket indices
  output wire [maxORAML-1:0] STIdx, BktIdx;
  wire switchST;
  PathGen STGen(Clock, Reset, switchST, leaf_padded, L_st, numST, STIdx); 
  PathGen BktGen(Clock, switchST, Enable, leaf_in, L_st-L_st+1, L_st, BktIdx);
  
  // control logic for PathGen
  assign switchST = (currentLevel % L_st) == L_st - 1;
  always@(posedge Clock) begin
    if (switchST)   
      currentST = currentST + 1;  
    if (Enable)
      currentLevel = currentLevel + 1;
  end
   
  // adjust for the (possibly) incomplete subtrees at the bottom 
  wire inCompleteTree;
  assign inCompleteTree = (numST * L_st != ORAMLevels) && currentLevel >= (numST-1) * L_st;
  assign PhyAddr = STIdx * STSize + BktIdx * BktSize - inCompleteTree * (STSize - STSize_bot) * (STIdx - numCompST); 
  
endmodule
