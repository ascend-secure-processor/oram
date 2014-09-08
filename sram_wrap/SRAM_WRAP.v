// SRAM wrapper, select the appropriate SRAM cell (the next smallest) 
// Author: Ling Ren

`include "Const.vh"

module SRAM1D_WRAP(Clock, Reset, Enable, Write, Address, DIn, DOut);

	parameter DWidth = 32, AWidth = 10;
	input Clock, Reset, Enable, Write;
	input [AWidth-1:0] Address;
	input [DWidth-1:0] DIn;
	output [DWidth-1:0] DOut;

	// select SRAM parameters
	localparam NWORDS = AWidth <= 8 ? 256 :	
						AWidth <= 9 ? 512 :	
						AWidth <= 10 ? 1024	:
						AWidth <= 11 ? 2048	: 
										0;		// not supported


	localparam AWidth_Pad = `log2(NWORDS);

	localparam 	NBITS = NWORDS == 2048 ? (		32  ) :
						NWORDS == 1024 ? (
							DWidth <= 64 ? 		64 :
							DWidth <= 128 ? 	128 :
							DWidth <= 256 ? 	256 : 
												256 ) :
						NWORDS == 512 ? ( 128 ) :
						//	DWidth <= 64 ? 		64 :
						//	DWidth <= 128 ?		128 :
						//						64 ) :
						NWORDS == 256 ? (
						//	DWidth <= 64 ? 		64 : FIXME get the lef file from mike for RF1DFCMN00256X064D02C064
							DWidth <= 256 ?		256 :
												128 ): 
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
			if (NBITS == 64) 
				SRAM1DFCMN01024X064D04C128_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
			if (NBITS == 128) 
				SRAM1DFCMN01024X128D04C128_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
		end

		else if (NWORDS == 512) begin
			RF1DFCMN00512X128D04C064_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
		end

		else if (NWORDS == 256) begin
			if (NBITS == 256)
				RF1DFCMN00256X256D02C064_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
			if (NBITS == 128) 
				RF1DFCMN00256X128D02C064_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
			if (NBITS == 64) 
				RF1DFCMN00256X064D02C064_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
		end
	end endgenerate

	initial begin
		if (NWORDS == 0 || NBITS == 0) begin
			$display("SRAM1D AWidth not supported");
			$finish;
		end
	end

endmodule

module SRAM2D_WRAP(Clock, Reset, Read, Write, ReadAddress, WriteAddress, DIn, DOut);

	parameter DWidth = 32, AWidth = 10;
	input Clock, Reset, Read, Write;
	input [AWidth-1:0] ReadAddress, WriteAddress;
	input [DWidth-1:0] DIn;
	output [DWidth-1:0] DOut;

	// select SRAM parameters
	localparam NWORDS = AWidth <= 7 ? 128 :
						AWidth <= 8 ? 256 :
						AWidth <= 9 ? 512 :
						AWidth <= 10 ? 1024 : 0;		// not supported

	localparam AWidth_Pad = `log2(NWORDS);

	localparam 	NBITS = NWORDS == 256 ? ( (DWidth <= 128) ?	8   : 256 ) :
						NWORDS == 128 ? 		32	: 
						NWORDS == 512 ?			64  :
						NWORDS == 1024 ?		64  :
						0;

	// pad to a multiple of NBITS
	localparam DWidth_Pad = (DWidth + NBITS - 1) / NBITS * NBITS;	

	wire [AWidth_Pad-1:0] _RAddr, _WAddr;
    wire [DWidth_Pad-1:0] _DIn;
    wire [DWidth_Pad-1:0] _DOut;

    assign _RAddr = ReadAddress;
	assign _WAddr = WriteAddress;
    assign _DIn = DIn;
    assign DOut = _DOut[DWidth-1:0];

	// instantiate SRAM
	genvar dw;
	generate for (dw = 0; dw < DWidth_Pad; dw = dw + NBITS) begin:SRAM_MAT
		/*
		if (NWORDS == 1024) begin
			wire	[NBITS-1:0] _DOutB;
			SRAM2SFCMN01024X064D04C064_WRAP SRAM (Clock, Read, 1'b0, Write, Write, _RAddr, {NBITS{1'bx}}, _DOut[dw+NBITS-1:dw],	_WAddr, _DIn[dw+NBITS-1:dw], _DOutB);
		end

		if (NWORDS == 512) begin
			wire	[NBITS-1:0] _DOutB;
			SRAM2SFCMN00512X064D04C064_WRAP SRAM (Clock, Read, 1'b0, Write, Write, _RAddr, {NBITS{1'bx}}, _DOut[dw+NBITS-1:dw],	_WAddr, _DIn[dw+NBITS-1:dw], _DOutB);
		end

		if (NWORDS == 256) begin
			if (NBITS == 8)
				RF2DFCMN00256X008D04C064_WRAP SRAM (Clock, Read, Write, _RAddr, _WAddr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
			if (NBITS == 256)
				RF2DFCMN00256X256D02C064_WRAP SRAM (Clock, Read, Write, _RAddr, _WAddr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
		end

		else if (NWORDS == 128) begin
			wire	[NBITS-1:0] _DOutB;
			SRAM2SFCMN00128X032D04C064_WRAP SRAM (Clock, Read, 1'b0, Write, Write, _RAddr, {NBITS{1'bx}}, _DOut[dw+NBITS-1:dw],	_WAddr, _DIn[dw+NBITS-1:dw], _DOutB);
		end*/
	end endgenerate

	initial begin
		if (NWORDS == 0 || NBITS == 0) begin
			$display("SRAM2D AWidth not supported");
			$finish;
		end
	end

endmodule


