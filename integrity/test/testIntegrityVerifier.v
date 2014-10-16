module testIntegrityVerifier;

	parameter NUMSHA3 = 1;
	
	`include "DDR3SDRAMLocal.vh"

	wire  Clock, Reset;
	wire Request, Write;
	wire [8:0] Address;		// TODO
	wire  [DDRDWidth-1:0]  DataIn;
	wire [DDRDWidth-1:0]  DataOut;

    // Clock
    reg [64-1:0] CycleCount;
    initial begin
        CycleCount = 0;
    end
    always@(negedge Clock) begin
        CycleCount = CycleCount + 1;
    end

    assign Reset = CycleCount < 30;
    assign DataIn = {64{"deadbeef"}};
  
    localparam   Freq =	100_000_000;
    localparam   Cycle = 1000000000/Freq;	
    ClockSource #(Freq) ClockF100Gen(1'b1, Clock);

	IntegrityVerifier IV (Clock, Reset, Request, Write, Address, DataIn, DataOut);
	
endmodule