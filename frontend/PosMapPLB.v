//==============================================================================
//	Module:		PosMapPLB
//	Desc:		A nice and simple abstraction of PLB plus PosMap (PPP) to frontend
//				This hides the different address space & level of recursion
//				The frontend keeps looking up for next PosMap block until it hits.
//				Currently support Read/Write/Refill/InitRefill.
//				InitRefill is hidden from DM_Cache (turned into Refill)
//==============================================================================

// TODO: How do we support counter tricks in PosMap?

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
    output Valid;
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
    (* mark_debug = "TRUE" *) wire InOnChipPosMap;
    assign InOnChipPosMap = AddrIn >= FinalPosMapStart; 
 
    // receive input cmd
	wire	CmdTransfer;
    (* mark_debug = "TRUE" *) wire [CacheCmdWidth-1:0] LastCmd;
	assign	CmdTransfer = CmdReady && CmdValid;
    Register #(.Width(CacheCmdWidth))
        CmdReg (Clock, 1'b0, 1'b0, CmdTransfer, Cmd, LastCmd);
        
    (* mark_debug = "TRUE" *) wire Busy;
    Register1b BusyReg (	.Clock(	Clock), 
							.Reset(	Reset || (Valid && OutReady)), 
							.Set(	CmdTransfer), 
							.Out(	Busy)
						);
						
    wire CmdIsWrite, mdIsRefill, CmdIsInitRefill;
	assign CmdIsWrite = Cmd == CacheWrite;
	assign CmdIsRefill = Cmd == CacheRefill;
	assign CmdIsInitRefill = Cmd == CacheInitRefill;
	
	// PRNG to generate new leaf
	(* mark_debug = "TRUE" *) wire [LeafWidth-1:0] NewLeafIn_Pre;
    (* mark_debug = "TRUE" *) wire [ORAML-1:0] NewLeafIn;
    (* mark_debug = "TRUE" *) wire NewLeafValid, NewLeafAccept;
    PRNG #(	.RandWidth(	LeafWidth))
        LeafGen (   .Clock(Clock), 
					.Reset(Reset),
                    .RandOutReady(NewLeafAccept),
                    .RandOutValid(NewLeafValid),
                    .RandOut(NewLeafIn_Pre),
					.SecretKey(128'hd8_40_e1_a8_dc_ca_e7_ec_d9_1f_61_48_7a_f2_cb_73)
                );
	assign NewLeafIn = NewLeafIn_Pre[ORAML-1:0];

    // ============================== onchip PosMap ====================================
    (* mark_debug = "TRUE" *) wire PosMapEnable, PosMapWrite;
    (* mark_debug = "TRUE" *) wire [LogFinalPosMapEntry-1:0] PosMapAddr;
    (* mark_debug = "TRUE" *) wire [ORAML:0] PosMapIn, PosMapOut;

    RAM #(.DWidth(ORAML+1), .AWidth(LogFinalPosMapEntry) `ifdef ASIC , .ASIC(1) `endif )
        PosMap (    .Clock(Clock), .Reset(Reset), 
                    .Enable(PosMapEnable), .Write(PosMapWrite), .Address(PosMapAddr), 
                    .DIn(PosMapIn), .DOut(PosMapOut)
                );
   
    // PosMap control and input
    (* mark_debug = "TRUE" *) wire PosMapSelect, PosMapBusy, PosMapValid, PosMapInit;
      
    Pipeline #(.Width(1), .Stages(1))	PosMapValidReg 	(Clock, Reset, PosMapSelect, PosMapValid);
    Pipeline #(.Width(1), .Stages(1))	PosMapBusyReg	(Clock, Reset, PosMapSelect && CmdIsWrite, PosMapBusy);
    
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
	
    assign PosMapSelect = InOnChipPosMap && CmdTransfer;                       
    assign PosMapEnable = PosMapInit || PosMapSelect || PosMapBusy;
    assign PosMapWrite = PosMapInit || PosMapBusy;        
    assign PosMapAddr = PosMapInit ? InitAddr : AddrIn - FinalPosMapStart;
    assign PosMapIn = {!PosMapInit, NewLeafIn};     // if init, invalidate; otherwise, validate
    // ===============================================================================

    // ============================================= PLB =============================
    (* mark_debug = "TRUE" *) wire PLBReady, PLBEnable, PLBValid, PLBHit, PLBEvict;
    (* mark_debug = "TRUE" *) wire [1:0] PLBCmd;
    (* mark_debug = "TRUE" *) wire [ORAMU-1:0] PLBAddrIn, PLBAddrOut;  
    (* mark_debug = "TRUE" *) wire [LeafWidth-1:0] PLBDIn, PLBDOut;
    (* mark_debug = "TRUE" *) wire [ORAML-1:0] PLBLeafIn, PLBLeafOut;

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
    (* mark_debug = "TRUE" *) wire PLBRefill, ;
	assign PLBRefill = (CmdTransfer && CmdIsRefill) || (!CmdTransfer && LastCmd == CacheRefill);   // Refill start or Refilling	
    assign PLBEnable = CmdTransfer && !InOnChipPosMap;
    assign PLBCmd = CmdIsInitRefill ? CacheRefill : Cmd; 
    assign PLBAddrIn = (CmdIsRefill || CmdIsInitRefill) ? (AddrIn >> LogLeafInBlock) << LogLeafInBlock : AddrIn;
    assign PLBDIn = PLBRefill ? DIn : {CmdTransfer && CmdIsWrite, NewLeafIn};
				// Refill --> data from backend; Write --> {1'b1, NewLeafIn}; InitRefill --> {1'b0, xxxx}
    assign PLBLeafIn = NewLeafOut;    
				// CacheRefill must use NewLeafOut (not NewLeafIn), the previous leaf that's still in store.
	
`ifdef SIMULATION
	always @ (posedge Clock) begin
		if (PLB.RefillWriting && !DInValid) begin
			$display("Error: PLB is a passive device. Once started refill, data must come in every cycle");
			$finish;
		end
	end
`endif	
									  
    // =============================================================================  
    (* mark_debug = "TRUE" *) wire PPPHit;
    assign PPPHit = PosMapValid || (PLBValid && PLBHit);
       
    assign NewLeafAccept = PPPHit && !Valid && LastCmd == CacheWrite;	// random leaf is used only on a write hit
    assign CmdReady = !PosMapInit && !Busy && !PosMapBusy && PLBReady;        

	Register1b ValidReg (	.Clock(		Clock), 
							.Reset(		Reset || (Valid && OutReady)), 
							.Set(		PosMapValid || PLBValid), 
							.Out(		Valid)
						);
	
    always @(posedge Clock) begin      
        if ((PosMapValid || PLBValid) && !Valid) begin
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
