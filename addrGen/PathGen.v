module PathGen(Clock, Reset, Enable, leaf, logFanOut, Levels, NodeIdx);
 
  `include "addrGenConst.v"

  input   Clock, Reset, Enable;
  input   [maxORAML-1:0] leaf;
  input   [maxlogL-1:0]  logFanOut;
  input   [maxlogL-1:0]  Levels;
  output  reg [maxORAML-1:0]  NodeIdx;  
  
  reg [maxlogL-1:0] level;

  initial begin
      NodeIdx = 0;
      level = 0;
  end
  
  wire [maxORAML-1:0] Child;
  assign Child = (leaf >> (logFanOut * (Levels - 1 - level))) & ((1 << logFanOut) - 1);
    // Any library to get several bits out? leaf[Levels-level*logFanOut-1:Levels-(level+1)*logFanOut].
  
  always@(posedge Clock) begin
    if (Reset) begin
      NodeIdx = 0;
      level = 0;
    end
    else if (Enable) begin       
      NodeIdx = (NodeIdx << logFanOut) +  Child  + 1;
      level = level + 1;
      //if (level >= Levels)
      //  $finish(21);
    end
  end
  
endmodule
