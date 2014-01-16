module AddrGen#
  (
   parameter MAX_ORAM_L = 32,
   parameter MAX_LOG_L = 5,
   parameter ADDR_WIDTH = 30,
   parameter DATA_WIDTH = 512
   )
  (
   Clock,
   Reset,
   Enable,
   leaf,
   ORAMLevels,
   L_st,
   BktSize,
   STSize,
   NumCompST,
   STSize_bot,
   CurrentLevel,
   PhyAddr,
   STIdx,
   BktIdx, // tmp output for debugging
   );

  input Clock, Reset, Enable;
  input [MAX_ORAM_L-1:0] leaf;
  input [MAX_LOG_L-1:0]  ORAMLevels, L_st;
  input [MAX_ORAM_L-1:0] BktSize, STSize, NumCompST, STSize_bot;  // Bytes related parameters
  output reg [MAX_LOG_L-1:0]  CurrentLevel;
  output [ADDR_WIDTH-1:0] PhyAddr;

  // ORAM structure information and state counters
  wire [MAX_LOG_L-1:0] numST;
  wire [MAX_ORAM_L-1:0] leaf_padded, leaf_in;
  reg [MAX_LOG_L-1:0] currentST;

  assign numST = (ORAMLevels + L_st - 1) / L_st;
  assign leaf_padded = leaf << (numST * L_st - ORAMLevels + 1);
  assign leaf_in = (leaf >> (ORAMLevels - 1 - currentST * L_st)) % (1 << L_st);
  initial begin
    currentST = 1;
    CurrentLevel = 0;
  end

  // use two PathGen modules to get subtree indices and bucket indices
  output wire [MAX_ORAM_L-1:0] STIdx, BktIdx;
  wire switchST;
  PathGen STGen(Clock, Reset, switchST, leaf_padded, L_st, numST, STIdx);
  PathGen BktGen(Clock, switchST, Enable, leaf_in, L_st-L_st+1, L_st, BktIdx);

  // control logic for PathGen
  assign switchST = (CurrentLevel % L_st) == L_st - 1;
  always@(posedge Clock) begin
    if (switchST)
      currentST = currentST + 1;
    if (Enable)
      CurrentLevel = CurrentLevel + 1;
  end

  // adjust for the (possibly) incomplete subtrees at the bottom
  wire inCompleteTree;
  assign inCompleteTree = (numST * L_st != ORAMLevels) && CurrentLevel >= (numST-1) * L_st;
  assign PhyAddr = STIdx * STSize + BktIdx * BktSize - inCompleteTree * (STSize - STSize_bot) * (STIdx - NumCompST);

endmodule
