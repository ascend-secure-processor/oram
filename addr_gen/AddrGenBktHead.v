`include "Const.vh"

module AddrGenBktHead 
(
   Clock, Reset, Start, Enable, 
   leaf,                    
   currentLevel, 
   BktIdx,     
   
   STIdx, BktIdxInST  // tmp
);

	parameter ORAML = 10, DDRROWWidth = 1024, BktSize_DRWords = 8;
	`include "SubTreeLocal.vh"
	localparam ORAMLogL = `log2(ORAML) + 1;
	
	input Clock, Reset, Start, Enable;
	input [ORAML-1:0] leaf;                     // the input leaf label
	output reg [ORAMLogL-1:0]  currentLevel; 
	output [ORAML+1:0] BktIdx;            // A tree of depth L needs L+1 bits to denote the node. 
                                        // And we waste several spots due to subtree, requiring L+2 bits
	output [ORAML:0] STIdx, BktIdxInST;  // tmp output for debugging
  
  `ifndef ASIC
  	initial begin
		currentLevel = -1;
	end
  `endif
  
  /*
  // reverse the leaf
  // Note: not used
  wire [ORAML-1:0] leaf_reverse;
  generate for(genvar i = 0; i < ORAML; i = i + 1) begin:REVERSE
    assign leaf_reverse[i] = leaf[ORAML-1-i];
  end endgenerate
  */
  
  reg [ORAML-1:0] leaf_shift;
  
  // One PathGen module walks the subtrees and the other inside a subtree
  // wire [ORAML-1:0] STIdx, BktIdxInST;
  wire switchST;
  PathGen #(ORAML) STGen(Clock, Start, Enable, switchST, leaf_shift[0], STIdx); 
  PathGen #(ORAML) BktGen(Clock, Start || (Enable && switchST), Enable, Enable, leaf_shift[0], BktIdxInST);
    // or equivalently
    // PathGen2 BktGen(Clock, Reset || switchST, Enable, leaf_reverse_shift[0], BktIdxInST);
  
  // control logic for STGen and BktGen
  reg [ORAMLogL-1:0] currentLvlinST;
  assign switchST = currentLvlinST >= L_st - 1;
  always@(posedge Clock) begin
    if (Reset) begin
      currentLevel <= -1;
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
  
  assign BktIdx = BktIdxInST + 
                (
                    shortTreeAtBottom ? 
                    (numTallST << LogSTSize) + ((STIdx-numTallST) << LogSTSizeBottom) :
                    (STIdx << LogSTSize)
                );
  
endmodule
