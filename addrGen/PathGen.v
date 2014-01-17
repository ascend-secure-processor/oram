module PathGen
#(
  parameter MAX_ORAM_L = 32,
  parameter MAX_LOG_L = 5,
  parameter ADDR_WIDTH = 30
)
(
  input Clock, Reset, Enable,
  input Switch,     // indicating the degree of the tree. Assertion every k Enable means 2^k-ary tree. 
  input BinChild,   // left-or-right child 
  output reg [MAX_ORAM_L-1:0]  NodeIdx
);
 
  reg [MAX_ORAM_L-1:0] Accum, Child;  
  
  always@(posedge Clock) begin
    if (Reset) begin
      NodeIdx <= 0;
      Accum <= 0;
      Child <= 0;
    end
    else if (Switch && Enable) begin    // entering a new level in the tree, update NodeIdx
      NodeIdx = (Accum << 1) + (Child << 1) + BinChild + 1;
      Accum <= NodeIdx;
      Child <= 0;
    end
    else if (Enable) begin              // otherwise, just prepare for the next update for a 2^k-ary tree
      Accum <= Accum << 1;
      Child <= (Child << 1) + BinChild;  
    end
  end
  
endmodule
