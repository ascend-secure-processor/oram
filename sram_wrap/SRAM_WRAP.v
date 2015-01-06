// SRAM wrapper, select the appropriate SRAM cell (the next smallest)
// Author: Ling Ren

`include "Const.vh"
`include "define.vh"

module SRAM1D_WRAP(Clock, Reset, Enable, Write, Address, DIn, DOut);

	parameter DWidth = 32, AWidth = 10;
	input Clock, Reset, Enable, Write;
	input [AWidth-1:0] Address;
	input [DWidth-1:0] DIn;
	output [DWidth-1:0] DOut;

	// select SRAM parameters
	localparam NWORDS = AWidth <= 7 ? 128 :
						AWidth <= 9 ? 512 :
						AWidth <= 10 ? 1024	: 0;


	localparam AWidth_Pad = `log2(NWORDS);

	localparam 	NBITS = NWORDS == 128 ? (
							DWidth <= 78 ? 		78 :
							DWidth <= 192 ? 	192 : 0 ) 	:
						NWORDS == 512 ? 		128 		:
						NWORDS == 1024 ?		64	 		:
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
		if (NWORDS == 1024 && NBITS == 64) begin:SRAM1
			//SRAM1DFCMN01024X064D04C128_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
			SRAM1DFCMN01024X064D04C128_PWRAP SRAM(
				.MEMCLK(Clock), .RESET_N(~Reset), .CE(Enable), .TESTEN(1'b0), .FUSE(`BIST_FUSE_WIDTH'b0),
				.A( _Addr),				.RDWEN( ~Write),.BW( {NBITS{1'b1}}), .DIN( _DIn[dw+NBITS-1:dw]), 	.DOUT( _DOut[dw+NBITS-1:dw]),
				.TA({AWidth_Pad{1'b0}}),.TRDWEN(1'b1),	.TBW({NBITS{1'b1}}), .TDIN({NBITS{1'b0}}), 			.TDOUT());
		end

		else if (NWORDS == 128 && NBITS == 78) begin:SRAM2
			//RF1DFCMN00128X078D02C064_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
 			RF1DFCMN00128X078D02C064_PWRAP SRAM(
				.MEMCLK(Clock), .RESET_N(~Reset), .CE(Enable), .TESTEN(1'b0), .FUSE(`BIST_FUSE_WIDTH'b0),
				.A( _Addr),				.RDWEN( ~Write),.BW( {NBITS{1'b1}}), .DIN( _DIn[dw+NBITS-1:dw]), 	.DOUT( _DOut[dw+NBITS-1:dw]),
				.TA({AWidth_Pad{1'b0}}),.TRDWEN(1'b1),	.TBW({NBITS{1'b1}}), .TDIN({NBITS{1'b0}}), 			.TDOUT());
		end

		else if (NWORDS == 128 && NBITS == 192) begin:SRAM3
			//RF1DFCMN00128X192D02C064_WRAP SRAM (Clock, Enable, Write, _Addr, _DIn[dw+NBITS-1:dw], _DOut[dw+NBITS-1:dw]);
 			RF1DFCMN00128X192D02C064_PWRAP SRAM(
				.MEMCLK(Clock), .RESET_N(~Reset), .CE(Enable), .TESTEN(1'b0), .FUSE(`BIST_FUSE_WIDTH'b0),
				.A( _Addr),				.RDWEN( ~Write),.BW( {NBITS{1'b1}}), .DIN( _DIn[dw+NBITS-1:dw]), 	.DOUT( _DOut[dw+NBITS-1:dw]),
				.TA({AWidth_Pad{1'b0}}),.TRDWEN(1'b1),	.TBW({NBITS{1'b1}}), .TDIN({NBITS{1'b0}}), 			.TDOUT());
		end

		else if (NWORDS == 512 && NBITS == 128) begin:SRAM4
			RF1DFCMN00512X128D04C064_PWRAP SRAM(
				.MEMCLK(Clock), .RESET_N(~Reset), .CE(Enable), .TESTEN(1'b0), .FUSE(`BIST_FUSE_WIDTH'b0),
				.A( _Addr),				.RDWEN( ~Write),.BW( {NBITS{1'b1}}), .DIN( _DIn[dw+NBITS-1:dw]), 	.DOUT( _DOut[dw+NBITS-1:dw]),
				.TA({AWidth_Pad{1'b0}}),.TRDWEN(1'b1),	.TBW({NBITS{1'b1}}), .TDIN({NBITS{1'b0}}), 			.TDOUT());
		end
	end endgenerate

`ifdef SIMULATION
	initial begin
		if (NWORDS == 0 || NBITS == 0) begin
			$display("SRAM1D AWidth not supported");
			$finish;
		end
	end
`endif

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

`ifdef SIMULATION
	initial begin
		if (NWORDS == 0 || NBITS == 0) begin
			$display("SRAM2D AWidth not supported");
			$finish;
		end
	end
`endif

endmodule


