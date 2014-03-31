// SRAM wrapper, select the appropriate SRAM cell (the next smallest) 
// Author: Ling Ren

`include "Const.vh"

module SRAM_WRAP(Clock, Reset, Enable, Write, Address, DIn, DOut);

	parameter DWidth = 32, AWidth = 10;
	input Clock, Reset, Enable, Write;
	input [AWidth-1:0] Address;
        input [DWidth-1:0] DIn;
        output [DWidth-1:0] DOut;

	// select SRAM parameters
	localparam NWORDS = AWidth <= 10 ? 1024 : 0;

	localparam NWORDS_LOG = `log2(NWORDS);
	localparam NBITS = DWidth <= 64 ? 64 : 0;

	// padding
	wire [NWORDS_LOG-1:0] _Addr;
        wire [NBITS-1:0] _DIn;
        wire [NBITS-1:0] _DOut;

        assign _Addr = Address;
        assign _DIn = DIn;
        assign DOut = _DOut[DWidth-1:0];

	// instantiate SRAM
	generate if (NWORDS == 1024) begin
        	if (NBITS == 64) begin
			SRAM1DCSN01024X064D04_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn, _DOut);
        	end

	end endgenerate

endmodule


