`include "Const.vh"

module UORamController
#(`include "UORAM.vh", `include "PathORAM.vh", `include "PLB.vh")
(
    input Clock, Reset, 
    
    // receive command from network
    output CmdInReady,
    input CmdInValid, 
    input [1:0] CmdIn,                // 00 for write, 01 for read, 10 for read_remove
    input [ORAMU-1:0] ProgAddrIn,
    
    // receive data from network
    output DataInReady,
    input DataInValid,
    input [FEDWidth-1:0] DataIn,
    
    // return data to network
    input  ReturnDataReady,
    output ReturnDataValid,
    output [FEDWidth-1:0] ReturnData,
    
    // send request to backend
    input  CmdOutReady,
    output CmdOutValid,
    output [1:0] CmdOut,
    output [ORAMU-1:0] AddrOut,
    output [ORAML-1:0] OldLeaf, NewLeaf,
    
    // send data to backend
    input  StoreDataReady,
    output StoreDataValid, 
    output [FEDWidth-1:0] StoreData,
    
    // receive response from backend
    output LoadDataReady,
    input  LoadDataValid,
    input  [FEDWidth-1:0] LoadData
);

    `include "PathORAMBackendLocal.vh";
    `include "CacheCmdLocal.vh";
    `include "PLBLocal.vh";  

    // FrontEnd state machines
    reg [1:0] CmdReg;
    reg [MaxLogRecursion-1:0] QDepth;   // TODO: maximum recursion
    reg [ORAMU-1:0] AddrQ [Recursion-1:0];
    
    reg Preparing, Accessing;
    reg RefillStarted;
    wire ExpectingProgramData;
    assign CmdInReady = !Preparing && !Accessing && !ExpectingProgramData && PPPCmdReady;
       
    // ================================== PosMapPLB ============================
    wire PPPCmdReady, PPPCmdValid;
    wire [1:0] PPPCmd;
    wire [ORAMU-1:0] PPPAddrIn, PPPAddrOut;   
    wire PPPRefill;
    wire [LeafWidth-1:0] PPPRefillData;  
    wire PPPOutReady, PPPValid, PPPHit, PPPUnInit, PPPEvict;
    wire [ORAML-1:0] PPPOldLeaf, PPPNewLeaf;  
    wire PPPEvictDataValid;
    wire [LeafWidth-1:0] PPPEvictData;
       
    PosMapPLB #(.ORAMU(             ORAMU), 
                .ORAML(             ORAML), 
                .ORAMB(             ORAMB), 
                .NumValidBlock(     NumValidBlock), 
                .Recursion(         Recursion), 
                .LeafWidth(         LeafWidth), 
                .PLBCapacity(       PLBCapacity)) 
        PPP (   .Clock(             Clock), 
                .Reset(             Reset), 
                .CmdReady(          PPPCmdReady), 
                .CmdValid(          PPPCmdValid), 
                .Cmd(               PPPCmd), 
                .AddrIn(            PPPAddrIn), 
                .DInValid(          PPPRefill), 
                .DIn(               PPPRefillData), 
                .OutReady(          PPPOutReady), 
                .Valid(             PPPValid), 
                .Hit(               PPPHit), 
                .UnInit(            PPPUnInit), 
                .OldLeafOut(        PPPOldLeaf), 
                .NewLeafOut(        PPPNewLeaf), 
                .Evict(             PPPEvict), 
                .AddrOut(           PPPAddrOut),
                .EvictDataOutValid( PPPEvictDataValid), 
                .EvictDataOut(      PPPEvictData));   
 
    wire PPPMiss, PPPUnInitialized;
    reg  PPPLookup, PPPInitRefill;
      
    assign PPPMiss = PPPValid && !PPPHit;
    assign PPPUnInitialized = PPPValid && PPPHit && PPPUnInit;
    
    assign PPPRefill = Accessing && (PPPRefillDataValid || PPPInitRefill);    
    assign PPPCmdValid = PPPLookup || (PPPRefill && !RefillStarted);
    assign PPPCmd = PPPRefill ? (PPPInitRefill ? CacheInitRefill : CacheRefill) : Preparing ? CacheRead : CacheWrite;
    assign PPPAddrIn = PPPRefill ? AddrQ[QDepth] : AddrQ[QDepth];
    
    assign PPPOutReady = Preparing || (PPPValid && !PPPHit && !PPPEvict) || 
            (PPPUnInitialized && QDepth > 0) || CmdOutReady;

            // 4 cases: read result, refill but no evict, uninitialized, evict or access
    // =============================================================================
    
    // ============================== Cmd to Backend ==============================
    wire EvictionRequest, InitRequest, SwitchReq;
    assign EvictionRequest = PPPValid && PPPEvict;
    assign InitRequest = QDepth == 0 && PPPUnInitialized;
    assign CmdOutValid = Accessing && PPPValid && ((PPPHit && !PPPUnInit) || InitRequest || PPPEvict);

    // if EvictionRequest, write back a PosMap block; otherwise serve the next access in the queue  
    assign CmdOut = (EvictionRequest || InitRequest) ? BECMD_Append : QDepth != 0 ? BECMD_ReadRmv : CmdReg;
    assign AddrOut = EvictionRequest ? NumValidBlock + PPPAddrOut / LeafInBlock : AddrQ[QDepth];
    assign OldLeaf = PPPOldLeaf;
    assign NewLeaf = PPPNewLeaf;
    
    assign SwitchReq = (CmdOutReady && CmdOutValid && !EvictionRequest) || (QDepth > 0 && PPPUnInitialized);
                    // transition to next access, after sending out or initializing the current one
    // =============================================================================
    
    task UORamInit;
        begin
            Preparing <= 0;
            Accessing <= 0;
            PPPLookup <= 0;
            PPPInitRefill <= 0;  
        end
    endtask

    integer i;
    
    always @(posedge Clock) begin
        if (Reset) begin
            UORamInit;       
        end

        else if (CmdInValid && CmdInReady) begin
            CmdReg <= CmdIn;
            QDepth <= 0;                  
            Preparing <= 1;
            PPPLookup  <= 1;
            PPPInitRefill <= 0;
            Accessing <= 0;
                        
            AddrQ[0] = ProgAddrIn;
            for (i = 1; i < Recursion; i = i+1) begin
                AddrQ[i] = NumValidBlock + AddrQ[i-1] / LeafInBlock;
            end       
        end
        
        else if (Preparing) begin
            PPPLookup <= PPPMiss;              // make the next query after receiving the previous one
                                                // this also sets up PPPLookup for the first access
            QDepth <= QDepth + PPPMiss;         // PPP (PLB) miss, look for the next PosMap block
            if (PPPValid && PPPHit) begin       // PPP hit, done
                Preparing <= 0;
                Accessing <= 1;
                PPPLookup <= 1;
                RefillStarted <= 0;
                
                $display("\t\tPosMap Hit  in Block %d for Block %d", AddrQ[QDepth+1], AddrQ[QDepth]);
            end
            else if (PPPMiss)
                $display("\t\tPosMap Miss in Block %d for Block %d", AddrQ[QDepth+1], AddrQ[QDepth]);
        end
        
        else if (Accessing) begin       
            if (SwitchReq) begin                                          // or initializing the current one
                
                if (QDepth > 0 && PPPUnInitialized)
                    $display("\t\tInitialize Block %d", AddrQ[QDepth]);
                else
                    $display("\t\tRequest Block %d", AddrQ[QDepth]);
                
                QDepth <= QDepth - 1;
                Accessing <= QDepth > 0;       
               
                RefillStarted <= 0;
                PPPLookup <= 0;
                PPPInitRefill <= QDepth > 0 && PPPUnInitialized;             
            end
            
            else if (CmdOutReady && CmdOutValid && EvictionRequest) begin
                $display("\t\tEvict Block %d to leaf %d", AddrOut, NewLeaf);
            end
            
            else begin
                RefillStarted <= RefillStarted || (PPPRefill && PPPCmdReady);  
                PPPLookup <= RefillStarted && PPPCmdReady;   // refill done
                if (PPPInitRefill && PPPCmdReady)
                    PPPInitRefill <= 0;      
            end
        end
    end            

    // =================== data interface with network and backend ====================
    wire PPPEvictDataReady;
    
    UORamDataPath #(.FEDWidth(FEDWidth), .LeafWidth(LeafWidth), .ORAMB(ORAMB))
    DataScheduler (Clock, Reset,
                    SwitchReq, (QDepth == 0), CmdReg,
                    ExpectingProgramData,
                    
                    // IO interface with network
                    DataInReady, DataInValid, DataIn,
                    ReturnDataReady, ReturnDataValid, ReturnData,
                    
                    // IO interface with PPP
                    PPPEvictDataReady, PPPEvictDataValid, PPPEvictData,
                    1'b1, PPPRefillDataValid, PPPRefillData,         // PLB refill is always ready
                    
                    // IO interface with backend
                    StoreDataReady, StoreDataValid, StoreData,
                    LoadDataReady, LoadDataValid, LoadData          
    );
    // ================================================================================    
endmodule
