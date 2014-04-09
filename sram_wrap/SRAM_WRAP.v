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
	localparam NWORDS = AWidth <= 8 ? 256 :		
						AWidth <= 10 ? 1024	:
						AWidth <= 11 ? 2048	: 
										0;		// not supported


	localparam AWidth_Pad = `log2(NWORDS);

	localparam 	NBITS = NWORDS == 2048 ? (
								32) :
						NWORDS == 1024 ? (
							DWidth <= 128 ? 128 : 
						//	DWidth <= 144 ? 144 : 
								128) :
						NWORDS == 256 ? (
							DWidth <= 64 ? 64 : 
								128) : 
						0;

	// pad to a multiple of NBITS
	localparam DWidth_Pad = (DWidth + NBITS - 1) / NBITS * NBITS;	

	wire [AWidth_Pad-1:0] _Addr;
    wire [DWidth_Pad-1:0] _DIn;
    wire [DWidth_Pad-1:0] _DOut;

    assign _Addr = Address;
    assign _DIn = DIn;
    assign DOut = _DOut[DWidth-1:0];

	// instantiate SRAM
	genvar dw;
	generate for (dw = 0; dw < DWidth_Pad; dw = dw + NBITS) begin:SRAM_MAT
		if (NWORDS == 2048) begin
        	if (NBITS == 32) 
				SRAM1DFCMN02048X032D08C128_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
		end
	
		else if (NWORDS == 1024) begin
			if (NBITS == 144) 
				SRAM1DFCMG01024X144D04C128_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
			if (NBITS == 128) 
				SRAM1DFCMN01024X128D04C128_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
		end

		else if (NWORDS == 256) begin
			if (NBITS == 128) 
				RF1DFCMN00256X128D02C064_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
			if (NBITS == 64) 
				RF1DFCMN00256X064D02C064_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
		end

		//	SRAM1DCSN01024X064D04_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn, _DOut);
	end endgenerate

	initial begin
		if (NWORDS == 0 || NBITS == 0) begin
			$display("SRAM AWidth not supported");
			$finish;
		end
	end

endmodule


