module testAddrGen;

  `include "addrGenConst.v"

	localparam   Freq =	100_000_000;
	localparam 	 Cycle = 1000000000/Freq;

	wire Clock, Reset, Enable;

  wire [maxORAML-1:0] leaf;
  wire [maxlogL-1:0]  ORAMLevels, L_st, CurrentLevel;
  wire [maxAddrWidth-1:0] PhyAddr;
  wire [maxORAML-1:0] STIdx, BktIdx;

  wire [maxORAML-1:0] BktSize, STSize, numCompST, STSize_bot;  // Bytes related parameters

  assign Reset = 0;
  assign Enable = 1;
  assign leaf = 125316;
  assign ORAMLevels = 27;
  assign L_st = 6;

  assign BktSize = 1;
  assign STSize = 4096;
  assign NumCompST = 0;
  assign STSize_bot = 4096;

  ClockSource #(Freq) ClockF100Gen(1'b1, Clock);

  AddrGen addGen(Clock, Reset, Enable,
              leaf, ORAMLevels, L_st,
              BktSize, STSize, NumCompST, STSize_bot,
              CurrentLevel, PhyAddr,
              STIdx, BktIdx,  // tmp output for debugging
              );

endmodule