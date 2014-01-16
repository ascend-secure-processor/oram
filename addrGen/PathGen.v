module PathGen#
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
   logFanOut,
   Levels,
   NodeIdx
   );

  input   Clock, Reset, Enable;
  input   [MAX_ORAM_L-1:0] leaf;
  input   [MAX_LOG_L-1:0]  logFanOut;
  input   [MAX_LOG_L-1:0]  Levels;
  output  reg [MAX_ORAM_L-1:0]  NodeIdx;

  reg [MAX_LOG_L-1:0] level;

  initial begin
      NodeIdx = 0;
      level = 0;
  end

  wire [MAX_ORAM_L-1:0] Child;
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
