`include "Const.vh"

module PLB
#(`include "PathORAM.vh", `include "PLB.vh")
(
    input Clock, Reset, Enable,
    output Ready,
    input [1:0] Cmd,        // 00 for write, 01 for read, 10 for refill, 11 for remove
    input [ORAMU-1:0] AddrIn,
    input [PortWidth-1:0] DIn,
    input [ORAML-1:0] LeafIn,
 
    output Hit,   
    output [PortWidth-1:0] DOut,
    output Evicting,
    output [ORAML-1:0] LeafOut
);

    localparam LeafInBlock = ORAMB / LeafWidth;
    localparam LeafInChunk = PortWidth / LeafWidth;
    localparam LogLeafInBlock = `log2f(LeafInBlock);
    localparam LogLeafInChunk = `log2f(LeafInChunk);

    // To increase DataWidth, we need to support partial write
    DM_Cache #(PortWidth, LogLeafInBlock-LogLeafInChunk, PLBCapacity, ORAMU-LogLeafInChunk, ORAML) 
        plb (Clock, Reset, Enable, Ready, Cmd, AddrIn[ORAMU-1:LogLeafInChunk], DIn, LeafIn, Hit, DOut, Evicting, LeafOut);

    
    
endmodule