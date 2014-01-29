`include "Const.vh"

module AddrGenBktHead 
#(`include "PathORAM.vh", `include "DDR3SDRAM.vh")
(
  input Clock, Reset, Start, Enable, 
  input [ORAML-1:0] leaf,                     // the input leaf label
  output reg [ORAMLogL-1:0]  currentLevel, 
  output [DDRAWidth-1:0] PhyAddr,
  output [ORAML-1:0] STIdx, BktIdx  // tmp output for debugging
);

  initial begin
    currentLevel = -1;
  end

  `include "PathORAMLocal.vh"
  `include "DDR3SDRAMLocal.vh"
 
  // subtree related parameters
  localparam BktSize = (ORAMZ + 1) * DDRBstLen;
  
  localparam L_st = `log2f(DDRROWWidth / BktSize + 1);
  localparam numST = (ORAML + 1 + L_st - 1) / L_st;
  
  localparam STSize = (1 << L_st) * BktSize;    // subtree size, it could be (1 << numST) - 1; this is optimal for Z=3 
  localparam STSize_bot = (1 << ((ORAML+1) % L_st)) * BktSize;          // short trees' size at the bottom
  localparam numCompST = ((1 << ((numST-1)*L_st)) - 1) / ((1 << L_st) - 1); // the number of not-short subtreess 
  
  // reverse the leaf
  wire [ORAML-1:0] leaf_reverse;
  generate for(genvar i = 0; i < ORAML; i = i + 1) begin:REVERSE
    assign leaf_reverse[i] = leaf[ORAML-1-i];
	end endgenerate
  reg [ORAML-1:0] leaf_shift;
  
  // One PathGen module walks the subtrees and the other inside a subtree
  // wire [ORAML-1:0] STIdx, BktIdx;
  wire switchST;
  PathGen #(ORAML) STGen(Clock, Start, Enable, switchST, leaf_shift[0], STIdx); 
  PathGen #(ORAML) BktGen(Clock, Start || switchST, Enable, Enable, leaf_shift[0], BktIdx);
    // or equivalently
    // PathGen2 BktGen(Clock, Reset || switchST, Enable, leaf_reverse_shift[0], BktIdx);
  
  // control logic for STGen and BktGen
  reg [ORAMLogL-1:0] currentLvlinST;
  assign switchST = currentLvlinST >= L_st - 1;
  always@(posedge Clock) begin
    if (Reset) begin
      currentLevel = -1;
    end
    else if (Start) begin
      currentLevel <= 0;
      currentLvlinST <= 0;
      // leaf_reverse_shift <= leaf_reverse;
      leaf_shift <= leaf;
    end 
    else if (Enable) begin
      currentLevel <= currentLevel + 1;
      currentLvlinST <= switchST ? 0 : currentLvlinST + 1;
      leaf_shift <= leaf_shift >> 1;    
    end
  end
  
  // adjust for the (possibly) shorter subtrees at the bottom 
  wire shortTreeAtBottom;
  assign shortTreeAtBottom = (numST * L_st != ORAML) && currentLevel >= (numST-1) * L_st;
  assign PhyAddr = STIdx * STSize + BktIdx * BktSize - shortTreeAtBottom * (STSize - STSize_bot) * (STIdx - numCompST); 
  
endmodule
