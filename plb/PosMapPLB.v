`include "Const.vh"

module PosMapPLB
#(`include "UORAM.vh", `include "PathORAM.vh", `include "PLB.vh")
(
    input Clock, Reset, 
    output CmdReady,
    input  CmdValid,
    input  [1:0] Cmd,        // 00 for update, 01 for read, 10 for refill
    input  [ORAMU-1:0] AddrIn,
    
    input  DInValid,
    input  [LeafWidth-1:0] DIn,
    
    input  OutReady,
    output reg Valid,
    output reg Hit,
    output reg [ORAML-1:0] OldLeafOut,
    output reg [ORAML-1:0] NewLeafOut,    
    output reg Evict,
    output reg [ORAMU-1:0] AddrOut,
    
    // evict data
    output EvictDataOutValid,
    output [LeafWidth-1:0] EvictDataOut
);
 
    `include "CacheCmdLocal.vh"; 
 
    // Select between PLB and PosMap
    localparam FinalPosMapStart = NumValidBlock + (NumValidBlock >> LogLeafInBlock) + (NumValidBlock >> (2*LogLeafInBlock));
                // TODO: hardcode Recursion = 4 for now
    wire InOnChipPosMap;
    assign InOnChipPosMap = AddrIn >= FinalPosMapStart; 
 
    reg [ORAMU-1:0] NewLeafIn;      // TODO: should be the output of some RNG

    // ============================== onchip PosMap ====================================
    localparam  FinalPosMapEntry = NumValidBlock >> (LogLeafInBlock * (Recursion-1));
    localparam  LogFinalPosMapEntry = `log2(FinalPosMapEntry);
    wire PosMapEnable, PosMapWrite;
    wire [LogFinalPosMapEntry-1:0] PosMapAddr;
    wire [ORAML-1:0] PosMapIn, PosMapOut;
    RAM #(ORAML, LogFinalPosMapEntry) PosMap (Clock, Reset, PosMapEnable, PosMapWrite, PosMapAddr, PosMapIn, PosMapOut);
    
    // PosMap control and input
    reg  PosMapBusy, PosMapValid; 
    assign PosMapEnable = (InOnChipPosMap && CmdReady && CmdValid) || PosMapBusy;
    assign PosMapWrite = PosMapBusy;        
    assign PosMapAddr = AddrIn - FinalPosMapStart;
    assign PosMapIn = NewLeafIn;
           
    always @(posedge Clock) begin
        PosMapValid <= CmdReady && CmdValid && InOnChipPosMap;
        PosMapBusy <= InOnChipPosMap && CmdReady && CmdValid && Cmd == CacheWrite;      // write PosMap has a latency of 1 cycle
    end
    // ===============================================================================

    // ============================================= PLB =============================
    wire PLBReady, PLBEnable, PLBValid, PLBHit, PLBEvict;
    wire [1:0] PLBCmd;
    wire [ORAMU-1:0] PLBAddrIn, PLBAddrOut;  
    wire [LeafWidth-1:0] PLBDIn, PLBDOut;
    wire [ORAML-1:0] PLBLeafIn, PLBLeafOut;

    localparam LeafInBlock = ORAMB / LeafWidth;
    localparam LogLeafInBlock = `log2f(LeafInBlock);

    DM_Cache #(LeafWidth, LogLeafInBlock, PLBCapacity, ORAMU, ORAML) 
        PLB (Clock, Reset, PLBReady, PLBEnable, PLBCmd, PLBAddrIn, PLBDIn, PLBLeafIn, 
                PLBValid, PLBHit, PLBDOut, PLBEvict, PLBAddrOut, PLBLeafOut);
    
    assign EvictDataOutValid = PLBEvict;
    assign EvictDataOut = PLBDOut;
                                                      
    // PLB control and input 
    wire PLBRefill;
    assign PLBRefill = (CmdReady && CmdValid && Cmd == CacheRefill) || (CmdReg == CacheRefill && !PLBReady);   // Refill start or Refilling
    assign PLBEnable = (CmdReady && CmdValid && !InOnChipPosMap) || (PLBRefill && DInValid);  
    assign PLBCmd = Cmd; 
    assign PLBAddrIn = PLBRefill ? (AddrIn >> LogLeafInBlock) << LogLeafInBlock : AddrIn;
    assign PLBDIn = PLBRefill ? DIn : NewLeafIn;    
    assign PLBLeafIn = NewLeafOut;     // Cache refill does not and cannot use random leaf
                                      // Must be NewLeafOut! The previous leaf that's still in store, 
    // =============================================================================  
      
    assign CmdReady = !PosMapBusy && PLBReady && !Valid;
   
    initial begin
        CmdReg <= 0;
        PosMapValid <= 0;
        PosMapBusy <= 0;
        Valid <= 0;
            
        NewLeafIn <= $random;    
    end
    
    reg [1:0] CmdReg; 
    always @(posedge Clock) begin
        if (CmdReady && CmdValid) begin
            CmdReg <= Cmd; 
        end
        
        if (Valid && OutReady) begin
            Valid <= 0;
        end
        
        else if ((PosMapValid || PLBValid) && !Valid) begin
            Valid <= 1;
            Hit <= PosMapValid || (PLBValid && PLBHit);
            OldLeafOut <= PosMapValid ? PosMapOut : PLBDOut;
            Evict <= PLBValid && PLBEvict;
            AddrOut <= PLBAddrOut;         
                            
            if (CmdReg == CacheWrite) begin     // only update. Cache refill does not and cannot use random leaf     
                NewLeafIn <= $random;      // TODO: should be the output of some RNG
                NewLeafOut <= NewLeafIn;
            end
            else if (CmdReg == CacheRefill) begin
                NewLeafOut <= PLBLeafOut;
            end           
        end
    end 
endmodule