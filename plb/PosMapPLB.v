`include "Const.vh"

module PosMapPLB
#(`include "UORAM.vh", `include "PathORAM.vh", `include "PLB.vh")
(
    input Clock, Reset, 
    output CmdReady,
    input  CmdValid,
    input  [1:0] Cmd,        // 00 for update, 01 for read, 10 for refill, 11 for init_refill
    input  [ORAMU-1:0] AddrIn,
    
    input  DInValid,
    input  [LeafWidth-1:0] DIn,
    
    input  OutReady,
    output reg Valid,
    output reg Hit,
    output reg UnInit,
    output reg [ORAML-1:0] OldLeafOut,
    output reg [ORAML-1:0] NewLeafOut,    
    output reg Evict,
    output reg [ORAMU-1:0] AddrOut,
    
    // evict data
    output EvictDataOutValid,
    output [LeafWidth-1:0] EvictDataOut
);
 
    `include "CacheCmdLocal.vh"; 
    `include "PLBLocal.vh";     
 
    // Select between PLB and PosMap
    wire InOnChipPosMap;
    assign InOnChipPosMap = AddrIn >= FinalPosMapStart; 
 
    reg [1:0] CmdReg; 
    reg [ORAML-1:0] NewLeafIn;      // TODO: should be the output of some RNG

    // ============================== onchip PosMap ====================================
    wire PosMapEnable, PosMapWrite;
    wire [LogFinalPosMapEntry-1:0] PosMapAddr;
    wire [ORAML:0] PosMapIn, PosMapOut;
    RAM #(.DWidth(ORAML+1), .AWidth(LogFinalPosMapEntry)) 
        PosMap (    .Clock(Clock), .Reset(Reset), 
                    .Enable(PosMapEnable), .Write(PosMapWrite), .Address(PosMapAddr), 
                    .DIn(PosMapIn), .DOut(PosMapOut)
                );
    
    // PosMap control and input
    reg  PosMapBusy, PosMapValid, PosMapInit;
    assign PosMapEnable = PosMapInit || (InOnChipPosMap && CmdReady && CmdValid) || PosMapBusy;
    assign PosMapWrite = PosMapInit || PosMapBusy;        
    assign PosMapAddr = PosMapInit ? InitAddr : AddrIn - FinalPosMapStart;
    assign PosMapIn = {!PosMapInit, NewLeafIn};     // if init, invalidate; otherwise, validate
    
    wire InitEnd;
    wire [LogFinalPosMapEntry-1:0] InitAddr;
    Counter #(.Width(LogFinalPosMapEntry))
        PosMapInitCounter (Clock, Reset, 1'b0, 1'b0, PosMapInit, {LogFinalPosMapEntry{1'bx}}, InitAddr); // load = set = 0, in= x
        
    CountCompare #(.Width(LogFinalPosMapEntry), .Compare(FinalPosMapEntry - 1))
        PosMapInitCountCmp(InitAddr, InitEnd);
           
    always @(posedge Clock) begin
        if (Reset) begin
            PosMapInit <= 1;
        end
        else if (PosMapInit) begin
            PosMapInit <= !InitEnd;
        end 
        else begin
            PosMapValid <= CmdReady && CmdValid && InOnChipPosMap;
            PosMapBusy <= InOnChipPosMap && CmdReady && CmdValid && Cmd == CacheWrite;      // write PosMap has a latency of 1 cycle
        end
    end
    // ===============================================================================

    // ============================================= PLB =============================
    wire PLBReady, PLBEnable, PLBValid, PLBHit, PLBEvict;
    wire [1:0] PLBCmd;
    wire [ORAMU-1:0] PLBAddrIn, PLBAddrOut;  
    wire [LeafWidth-1:0] PLBDIn, PLBDOut;
    wire [ORAML-1:0] PLBLeafIn, PLBLeafOut;

    DM_Cache #( .DataWidth(LeafWidth), .LogLineSize(LogLeafInBlock), 
                .Capacity(PLBCapacity), .AddrWidth(ORAMU), .ExtraTagWidth(ORAML)) 
        PLB (   .Clock(Clock), .Reset(Reset), 
                .Ready(PLBReady), .Enable(PLBEnable), 
                .Cmd(PLBCmd), .AddrIn(PLBAddrIn), .DIn(PLBDIn), .ExtraTagIn(PLBLeafIn), 
                .OutValid(PLBValid), .Hit(PLBHit), .DOut(PLBDOut), 
                .Evicting(PLBEvict), .AddrOut(PLBAddrOut), .ExtraTagOut(PLBLeafOut)
            );
    
    assign EvictDataOutValid = PLBEvict;
    assign EvictDataOut = PLBDOut;
                                                      
    // PLB control and input 
    wire PLBRefill, PLBInitRefill;
    assign PLBRefill = (CmdReady && CmdValid && Cmd == CacheRefill) || (CmdReg == CacheRefill && !PLBReady);   // Refill start or Refilling
    assign PLBInitRefill = (CmdReady && CmdValid && Cmd == CacheInitRefill) || (CmdReg == CacheInitRefill && !PLBReady);   // InitRefill
    
    assign PLBEnable = (CmdReady && CmdValid && !InOnChipPosMap) || (PLBRefill && DInValid) || PLBInitRefill;  
    assign PLBCmd = Cmd == CacheInitRefill ? CacheRefill : Cmd; 
    assign PLBAddrIn = (PLBRefill || PLBInitRefill) ? (AddrIn >> LogLeafInBlock) << LogLeafInBlock : AddrIn;
    assign PLBDIn = PLBRefill ? DIn : PLBInitRefill ? {LeafWidth{1'b0}} : {1'b1, NewLeafIn};
    assign PLBLeafIn = NewLeafOut;     // Cache refill does not and cannot use random leaf
                                      // Must be NewLeafOut! The previous leaf that's still in store, 
    // =============================================================================  
    
    reg Busy;
    assign CmdReady = !PosMapInit && !Busy && !PosMapBusy && PLBReady ;
   
    always @(posedge Clock) begin
        if (Reset) begin
            Busy <= 0;
            CmdReg <= 0;
            PosMapValid <= 0;
            PosMapBusy <= 0;
            Valid <= 0;              
            NewLeafIn <= $random;    
        end
    
        else if (CmdReady && CmdValid) begin
            CmdReg <= Cmd;
            Busy <= 1; 
        end
        
        else if (Valid && OutReady) begin
            Valid <= 0;
            Busy <= 0;
        end
        
        else if ((PosMapValid || PLBValid) && !Valid) begin
            Valid <= 1;
            Hit <= PosMapValid || (PLBValid && PLBHit);
            UnInit <= (PosMapValid && PosMapOut[ORAML] == 0) || (PLBValid && PLBHit && PLBDOut[ORAML] == 0);
            OldLeafOut <= PosMapValid ? PosMapOut[ORAML-1:0] : PLBDOut[ORAML-1:0];
            Evict <= PLBValid && PLBEvict;
            AddrOut <= PLBAddrOut;         
                            
            if (CmdReg == CacheWrite) begin     // only update. Cache refill does not and cannot use random leaf     
                NewLeafIn <= $random;      // TODO: should be the output of some RNG
                NewLeafOut <= NewLeafIn;
            end
            else if (CmdReg == CacheRefill || CmdReg == CacheInitRefill) begin
                NewLeafOut <= PLBLeafOut;
            end           
        end
    end 
endmodule