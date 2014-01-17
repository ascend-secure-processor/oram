module testAddrGen;
  
  `include "addrGenConst.v"
  
	localparam   Freq =	100_000_000;
	localparam 	 Cycle = 1000000000/Freq;	

	wire Clock, Reset, Enable;
   
  wire [maxORAML-1:0] leaf;
  wire [maxlogL-1:0]  ORAMLevels, L_st, numST, currentLevel;
  wire [maxAddrWidth-1:0] PhyAddr;
  wire [maxORAML-1:0] STIdx, BktIdx;
  wire [maxORAML-1:0] BktSize, STSize, numCompST, STSize_bot;  // Bytes related parameters

  reg [maxORAML-1:0] CycleCount;
  initial begin
    CycleCount = 0;
  end
  always@(posedge Clock) begin
    CycleCount = CycleCount + 1;
  end

  assign Reset = CycleCount == 0 || CycleCount == 14;
  assign Enable = 1;
  assign leaf = 125316;
  assign ORAMLevels = 27;
  assign numST = (ORAMLevels + L_st - 1) / L_st;
  assign L_st = 6;
  
  assign BktSize = 1;
  assign STSize = 4096;
  assign numCompST = 0;
  assign STSize_bot = 4096;

  ClockSource #(Freq) ClockF100Gen(1'b1, Clock); 
  
  AddrGen #(maxORAML, maxlogL, maxAddrWidth) addGen
    (Clock, Reset, Enable, 
      leaf, ORAMLevels, L_st, numST,
      BktSize, STSize, numCompST, STSize_bot,
      currentLevel, PhyAddr,
      STIdx, BktIdx // tmp output for debugging
    );   
  
endmodule