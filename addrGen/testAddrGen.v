module testAddrGen;
  
    `include "PathORAM.vh";
    `include "PathORAMLocal.vh";
    `include "DDR3SDRAM.vh";
  
	localparam   Freq =	100_000_000;
	localparam 	 Cycle = 1000000000/Freq;	

	wire Clock, Reset, Start;
	wire RW, BH;
	wire Ready, CmdReady, CmdValid;
   
    wire [ORAML-1:0] leaf;
    wire [ORAMLogL-1:0]  currentLevel;
    wire [DDRAWidth-1:0] Addr;
    wire [ORAML-1:0] STIdx, BktIdx;
    
    reg [ORAML-1:0] CycleCount;
    initial begin
        CycleCount = 0;
    end
    always@(posedge Clock) begin
        CycleCount = CycleCount + 1;
    end
    
    assign Reset = CycleCount == 15;
    assign Start = CycleCount == 2 || CycleCount == 20 || CycleCount == 102;
    assign RW = CycleCount < 100;
    assign BH = CycleCount < 100;
    assign leaf = 125316;
    assign CmdReady = CycleCount % 2;
 
 
  ClockSource #(Freq) ClockF100Gen(1'b1, Clock); 
  
  AddrGen addGen
    (Clock, 
      Reset, Start,
      RW, BH, 
      leaf,
      Ready,
      
      CmdReady,
      CmdValid,
      Cmd,
      Addr,
      
      currentLevel,
      STIdx, BktIdx // tmp output for debugging
    );   
  
endmodule