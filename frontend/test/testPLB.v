`include "Const.vh"

module testPLB;

    `include "PathORAM.vh"
    `include "UORAM.vh"

    
    wire Clock, Reset, Enable, Hit, Ready, EvictValid;
    wire [1:0] Cmd;
    wire [ORAMU-1:0] Addr;
    wire [LeafWidth-1:0] DIn, DOut;

    localparam LogLeafInBlock = `log2f(ORAMB / LeafWidth);
    DM_Cache #(LeafWidth, LogLeafInBlock, PLBCapacity, ORAMU) PLB (Clock, Reset, Enable, Cmd, Addr, DIn, Hit, DOut, Ready, EvictValid);

    reg [ORAML-1:0] CycleCount;
    initial begin
        CycleCount = 0;
    end
    always@(posedge Clock) begin
        CycleCount = CycleCount + 1;
    end

    assign Reset = 0;
    assign Enable = CycleCount != 48;
    assign Addr = (CycleCount < 48) ? ((CycleCount % 32) / 16 * 16) : CycleCount % 35;
    assign Offset = 0;
    assign Cmd = (CycleCount < 48) ? 2 : ((CycleCount < 60) ? 1 : (CycleCount < 70 ? 0 : 1) );
  
    assign DIn = CycleCount * 100;
 
    localparam   Freq =	100_000_000;
    ClockSource #(Freq) ClockF100Gen(1'b1, Clock); 
    
endmodule
