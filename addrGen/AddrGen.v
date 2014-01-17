module AddrGen
#(
  parameter MAX_ORAM_L = 32,
  parameter MAX_LOG_L = 5,
  parameter ADDR_WIDTH = 30
)
(
  input Clock, Reset, Enable, 
  input [MAX_ORAM_L-1:0] leaf,                     // the input leaf label
  input [MAX_LOG_L-1:0] ORAMLevels, L_st, numST,   // ORAM depth related
  input [MAX_ORAM_L-1:0] BktSize, STSize, numCompST, STSize_bot,  // Bytes related parameters
  output reg [MAX_LOG_L-1:0]  currentLevel, 
  output [ADDR_WIDTH-1:0] PhyAddr,
  output [MAX_ORAM_L-1:0] STIdx, BktIdx   // tmp output for debugging
);


  // reverse leaf and leaf shifter
  wire [MAX_ORAM_L-1:0] leaf_reverse;
  Reverse #(MAX_ORAM_L, 1, MAX_ORAM_L) rev(leaf, leaf_reverse);
  reg [MAX_ORAM_L-1:0] leaf_reverse_shift;
  
  // One PathGen module walks the subtrees and the other inside a subtree
  // wire [MAX_ORAM_L-1:0] STIdx, BktIdx;
  wire switchST;
  PathGen #(MAX_ORAM_L, MAX_LOG_L, ADDR_WIDTH) 
    STGen(Clock, Reset, Enable, switchST, leaf_reverse_shift[0], STIdx); 
  PathGen #(MAX_ORAM_L, MAX_LOG_L, ADDR_WIDTH) 
    BktGen(Clock, Reset || switchST, Enable, Enable, leaf_reverse_shift[0], BktIdx);
    // or equivalently
    // PathGen2 BktGen(Clock, Reset || switchST, Enable, leaf_reverse_shift[0], BktIdx);
  
  // control logic for STGen and BktGen
  reg [MAX_LOG_L-1:0] currentLvlinST;
  assign switchST = currentLvlinST >= L_st - 1;
  always@(posedge Clock) begin
    if (Reset) begin
      currentLevel <= 0;
      currentLvlinST <= 0;
      leaf_reverse_shift <= leaf_reverse >> (MAX_ORAM_L - ORAMLevels + 1);
    end 
    else if (Enable) begin
      currentLevel <= currentLevel + 1;
      currentLvlinST <= switchST ? 0 : currentLvlinST + 1;
      leaf_reverse_shift <= leaf_reverse_shift >> 1;    
    end
  end
  
  // adjust for the (possibly) shorter subtrees at the bottom 
  wire shortTreeAtBottom;
  assign shortTreeAtBottom = (numST * L_st != ORAMLevels) && currentLevel >= (numST-1) * L_st;
  assign PhyAddr = STIdx * STSize + BktIdx * BktSize - shortTreeAtBottom * (STSize - STSize_bot) * (STIdx - numCompST); 
  
endmodule
