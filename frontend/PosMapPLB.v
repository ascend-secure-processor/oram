`include "Const.vh"

module PosMapPLB
(	Clock, Reset, CmdReady, CmdValid, Cmd, AddrIn, DInValid, DIn, 
	OutReady, Valid, Hit, UnInit, OldLeafOut, NewLeafOut, Evict, AddrOut, RefillDataReady, EvictDataOutValid, EvictDataOut
);
	`include "UORAM.vh"; 
	`include "PathORAM.vh"; 
	`include "PLB.vh";
 
    `include "CacheCmdLocal.vh" 
    `include "PLBLocal.vh"     
 
    input Clock, Reset; 
    output CmdReady;
    input  CmdValid;
    input  [CacheCmdWidth-1:0] Cmd;        // 00 for update, 01 for read, 10 for refill, 11 for init_refill
    input  [ORAMU-1:0] AddrIn;
    
    input  DInValid;
    input  [LeafWidth-1:0] DIn;
    
    input  OutReady;
    output reg Valid;
    output reg Hit;
    output reg UnInit;
    output reg [ORAML-1:0] OldLeafOut;
    output reg [ORAML-1:0] NewLeafOut;    
    output reg Evict;
    output reg [ORAMU-1:0] AddrOut;
    // evict and refill data
    output RefillDataReady;
    output EvictDataOutValid;
    output [LeafWidth-1:0] EvictDataOut;

    // Select between PLB and PosMap
    wire InOnChipPosMap;
    assign InOnChipPosMap = AddrIn >= FinalPosMapStart; 
 
    // receive input cmd
    wire [CacheCmdWidth-1:0] LastCmd;
    Register #(.Width(CacheCmdWidth))
        CmdReg (Clock, Reset, 1'b0, CmdReady && CmdValid, Cmd, LastCmd);
        
    wire Busy;
    Register1b BusyReg (	.Clock(Clock), 
							.Reset(Reset || (Valid && OutReady)), 
							.Set(CmdReady && CmdValid), 
							.Out(Busy)
						);
    
	wire [LeafWidth-1:0] NewLeafIn_Pre;
    wire [ORAML-1:0] NewLeafIn;
    wire NewLeafValid, NewLeafAccept;
    PRNG #(	.RandWidth(	LeafWidth),
			.SecretKey(	128'hd8_40_e1_a8_dc_ca_e7_ec_d9_1f_61_48_7a_f2_cb_73))
        LeafGen (   Clock, Reset,
                    NewLeafAccept,
                    NewLeafValid,
                    NewLeafIn_Pre
                );
	assign NewLeafIn = NewLeafIn_Pre[ORAML-1:0];

    // ============================== onchip PosMap ====================================
    wire PosMapEnable, PosMapWrite;
    wire [LogFinalPosMapEntry-1:0] PosMapAddr;
    wire [ORAML:0] PosMapIn, PosMapOut;

    RAM #(.DWidth(ORAML+1), .AWidth(LogFinalPosMapEntry) `ifdef ASIC , .ASIC(1) `endif )
        PosMap (    .Clock(Clock), .Reset(Reset), 
                    .Enable(PosMapEnable), .Write(PosMapWrite), .Address(PosMapAddr), 
                    .DIn(PosMapIn), .DOut(PosMapOut)
                );
   
    // PosMap control and input
    wire PosMapSelect, PosMapBusy, PosMapValid, PosMapInit;
      
    Register #(.Width(1))
        PosMapValidReg (.Clock(Clock), .Reset(Reset), .Set(1'b0), .Enable(1'b1), 
                        .In(PosMapSelect), .Out(PosMapValid));       
    Register #(.Width(1))
        PosMapBusyReg (.Clock(Clock), .Reset(Reset), .Set(1'b0), .Enable(1'b1), 
                        .In(PosMapSelect && Cmd == CacheWrite), .Out(PosMapBusy)); 
    
    wire InitEnd;
    wire [LogFinalPosMapEntry-1:0] InitAddr;
    Register1b PosMapInitReg	(.Clock(Clock), .Reset(InitEnd), .Set(Reset), .Out(PosMapInit)); 
	CountAlarm #(			.Threshold(				FinalPosMapEntry))
		PosMapInitCounter (	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				PosMapInit),
							.Count(					InitAddr),
							.Done(					InitEnd)
						);
	
    assign PosMapSelect = InOnChipPosMap && CmdReady && CmdValid;                       
    assign PosMapEnable = PosMapInit || PosMapSelect || PosMapBusy;
    assign PosMapWrite = PosMapInit || PosMapBusy;        
    assign PosMapAddr = PosMapInit ? InitAddr : AddrIn - FinalPosMapStart;
    assign PosMapIn = {!PosMapInit, NewLeafIn};     // if init, invalidate; otherwise, validate
    // ===============================================================================

    // ============================================= PLB =============================
    wire PLBReady, PLBEnable, PLBValid, PLBHit, PLBEvict;
    wire [1:0] PLBCmd;
    wire [ORAMU-1:0] PLBAddrIn, PLBAddrOut;  
    wire [LeafWidth-1:0] PLBDIn, PLBDOut;
    wire [ORAML-1:0] PLBLeafIn, PLBLeafOut;

    DM_Cache #( .DataWidth(		LeafWidth), 
				.LogLineSize(	LogLeafInBlock), 
                .Capacity(		EnablePLB ? PLBCapacity : ORAMB), 
				.AddrWidth(		ORAMU), 
				.ExtraTagWidth(	ORAML)) 
        PLB (   .Clock(         Clock), 
                .Reset(         Reset), 
                .Ready(         PLBReady), 
                .Enable(        PLBEnable), 
                .Cmd(           PLBCmd), 
                .AddrIn(        PLBAddrIn), 
                .DIn(           PLBDIn), 
                .ExtraTagIn(    PLBLeafIn),
                 
                .OutValid(      PLBValid), 
                .Hit(           PLBHit), 
                .DOut(          PLBDOut),
                .RefillDataReady(   RefillDataReady),
                .Evicting(      PLBEvict), 
                .AddrOut(       PLBAddrOut), 
                .ExtraTagOut(   PLBLeafOut)
            );
    
	// How to disable PLB?
	// 	.Reset(Reset || (!EnablePLB && PLBValid && PLBHit)) is wrong because there are still newly-initialized blocks in the PLB		
	
    assign EvictDataOutValid = PLBEvict;
    assign EvictDataOut = PLBDOut;
                                                      
    // PLB control and input 
    wire PLBRefill, PLBInitRefill;
    assign PLBRefill = (CmdReady && CmdValid && Cmd == CacheRefill) || (LastCmd == CacheRefill && !PLBReady);   // Refill start or Refilling
    assign PLBInitRefill = (CmdReady && CmdValid && Cmd == CacheInitRefill) || (LastCmd == CacheInitRefill && !PLBReady);   // InitRefill
    
    assign PLBEnable = (CmdReady && CmdValid && !InOnChipPosMap) || (PLBRefill && DInValid) || PLBInitRefill;  
    assign PLBCmd = Cmd == CacheInitRefill ? CacheRefill : Cmd; 
    assign PLBAddrIn = (PLBRefill || PLBInitRefill) ? (AddrIn >> LogLeafInBlock) << LogLeafInBlock : AddrIn;
    assign PLBDIn = PLBRefill ? DIn : PLBInitRefill ? {LeafWidth{1'b0}} : {1'b1, NewLeafIn};
    assign PLBLeafIn = NewLeafOut;     // Cache refill does not and cannot use random leaf
                                      // Must be NewLeafOut! The previous leaf that's still in store, 
    // =============================================================================  
    wire PPPHit;
    assign PPPHit = PosMapValid || (PLBValid && PLBHit);
       
    assign NewLeafAccept = PPPHit && !Valid && LastCmd == CacheWrite;
    assign CmdReady = !PosMapInit && !Busy && !PosMapBusy && PLBReady;        

    always @(posedge Clock) begin
        if (Reset) begin
            Valid <= 0;                
        end    
        else if (Valid && OutReady) begin
            Valid <= 0;
        end
        
        else if ((PosMapValid || PLBValid) && !Valid) begin
            Valid <= 1;
            Hit <= PPPHit;
            UnInit <= (PosMapValid && PosMapOut[ORAML] == 0) || (PLBValid && PLBHit && PLBDOut[ORAML] == 0);
            OldLeafOut <= PosMapValid ? PosMapOut[ORAML-1:0] : PLBDOut[ORAML-1:0];
            Evict <= PLBValid && PLBEvict;
            AddrOut <= PLBAddrOut;         
                            
            if (PPPHit && LastCmd == CacheWrite) begin     // only update. Cache refill does not and cannot use random leaf     
                NewLeafOut <= NewLeafIn;
			`ifdef SIMULATION
                if (!NewLeafValid) begin
                    $display("Error: run out of random leaves.");
					$finish;
                end
			`endif
            end
            else if (LastCmd == CacheRefill || LastCmd == CacheInitRefill) begin
                NewLeafOut <= PLBLeafOut;
            end           
        end
    end 
endmodule
