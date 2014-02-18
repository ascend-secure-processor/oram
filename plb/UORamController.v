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
    localparam MaxLogRecursion = 4;

    reg [1:0] CmdReg;
    reg [MaxLogRecursion-1:0] QDepth;   // TODO: maximum recursion
    reg [ORAMU-1:0] AddrQ [Recursion-1:0];
    
    reg Preparing, Accessing;
    reg RefillStarted;
    reg ExpectingPosMapBlock, ExpectingDataBlock, ExpectingProgStore;
    assign CmdInReady = !Preparing && !Accessing && !ExpectingProgStore && !ExpectingDataBlock;
       
    // ================================== PosMapPLB ============================
    wire PPPCmdReady, PPPCmdValid;
    wire [1:0] PPPCmd;
    wire [ORAMU-1:0] PPPAddrIn, PPPAddrOut;   
    wire PPPRefill;
    wire [FEDWidth-1:0] PPPDIn;  
    wire PPPOutReady, PPPValid, PPPHit, PPPUnInit, PPPEvict;
    wire [ORAML-1:0] PPPOldLeaf, PPPNewLeaf;  
    wire PPPEvictDataValid;
    wire [FEDWidth-1:0] PPPEvictData;
       
    PosMapPLB //#() 
    PPP (Clock, Reset, 
        PPPCmdReady, 
        PPPCmdValid, PPPCmd, PPPAddrIn, 
        PPPRefill, PPPDIn, 
        PPPOutReady, PPPValid, PPPHit, PPPUnInit, PPPOldLeaf, PPPNewLeaf, PPPEvict, PPPAddrOut,
        PPPEvictDataValid, PPPEvictData);   
 
    wire PPPMiss, PPPUnInitialized;
    reg  PPPLookup, PPPInitRefill;
      
    assign PPPMiss = PPPValid && !PPPHit;
    assign PPPUnInitialized = PPPValid && PPPHit && PPPUnInit;
    assign PPPRefill = Accessing && ExpectingPosMapBlock && (LoadDataValid || PPPInitRefill);
    
    assign PPPCmdValid = PPPLookup || (PPPRefill && !RefillStarted);
    assign PPPCmd = PPPRefill ? (PPPInitRefill ? CacheInitRefill : CacheRefill) : Preparing ? CacheRead : CacheWrite;
    assign PPPAddrIn = PPPRefill ? AddrQ[QDepth] : AddrQ[QDepth];
    assign PPPDIn = LoadData;
    assign PPPEvictDataReady = !ExpectingProgStore && StoreDataReady;
    
    assign PPPOutReady = Preparing || CmdOutReady || 
            (PPPValid && !PPPHit && !PPPEvict) || (PPPUnInitialized && QDepth > 0) ;
        // 3 cases: read result, refill but no evict, evict or access
    // =============================================================================
    
    // ============================== Cmd to Backend ==============================
    wire EvictionRequest, InitRequest;
    assign EvictionRequest = PPPValid && PPPEvict;
    assign InitRequest = QDepth == 0 && PPPUnInitialized;
    assign CmdOutValid = Accessing && PPPValid && ((PPPHit && !PPPUnInit) || InitRequest || PPPEvict);

    // if EvictionRequest, write back a PosMap block; otherwise serve the next access in the queue  
    assign CmdOut = (EvictionRequest || InitRequest) ? BECMD_Append : QDepth != 0 ? BECMD_ReadRmv : CmdReg;
    assign AddrOut = EvictionRequest ? NumValidBlock + PPPAddrOut / LeafInBlock : AddrQ[QDepth];
    assign OldLeaf = PPPOldLeaf;
    assign NewLeaf = PPPNewLeaf;
    // =============================================================================
    
    initial begin
        Preparing <= 0;
        Accessing <= 0;
        PPPLookup <= 0;
        PPPInitRefill <= 0;  
    end
     
    always @(posedge Clock) begin
        if (Reset) begin
            Preparing <= 0;
            Accessing <= 0;
            PPPLookup <= 0;  
            PPPInitRefill <= 0;         
        end

        else if (CmdInValid && CmdInReady) begin
            CmdReg <= CmdIn;
            QDepth <= 0;                  
            Preparing <= 1;
            PPPLookup  <= 1;
            PPPInitRefill <= 0;
            Accessing <= 0;
                        
            AddrQ[0] = ProgAddrIn;
            for (integer i = 1; i < Recursion; i = i+1) begin
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
                
                $display("\t\tPosMap Hit  in Block %d for Block %d", AddrQ[QDepth+1], AddrQ[QDepth]);
            end
            else if (PPPMiss)
                $display("\t\tPosMap Miss in Block %d for Block %d", AddrQ[QDepth+1], AddrQ[QDepth]);
        end
        
        else if (Accessing) begin       
            if ((CmdOutReady && CmdOutValid && !EvictionRequest)    // transition to next access, after sending out the current one   
                || (QDepth > 0 && PPPUnInitialized)) begin                                          // or initializing the current one
                
                if (QDepth > 0 && PPPUnInitialized)
                    $display("\t\tBlock %d initialized", AddrQ[QDepth]);
                else
                    $display("\t\tBlock %d requested", AddrQ[QDepth]);
                
                QDepth <= QDepth - 1;
                Accessing <= QDepth > 0;       

                ExpectingPosMapBlock <= QDepth > 0;
                ExpectingDataBlock <= QDepth == 0 && (CmdReg == BECMD_Read || CmdReg == BECMD_ReadRmv);  // only if it's a read
                ExpectingProgStore <= QDepth == 0 && (CmdReg == BECMD_Append || CmdReg == BECMD_Update);  // only if it's a write                
                RefillStarted <= 0;
                PPPLookup <= 0;
                PPPInitRefill <= QDepth > 0 && PPPUnInitialized;             
            end
            
            else if (CmdOutReady && CmdOutValid && EvictionRequest)
                $display("\t\tEvict Block %d to leaf %d", AddrOut, NewLeaf);
            
            else begin
                RefillStarted <= RefillStarted || (PPPRefill && PPPCmdReady);  
                PPPLookup <= RefillStarted && PPPCmdReady;   // refill done
                if (PPPInitRefill && PPPCmdReady)
                    PPPInitRefill <= 0;      
            end
        end
    end            

    // =================== data interface with network and backend ====================

    // storebuffer to back end
    wire StoreBufferReady, StoreBufferValid;
    wire [FEDWidth-1:0] StoreBufferDIn;
    
    /*
    FIFORAM #(.Width(FEDWidth), .Buffering(FEORAMBChunks)) 
        StoreBuffer (.Clock(Clock), .Reset(Reset), 
                        .InAccept(StoreBufferReady), .InValid(StoreBufferValid), .InData(StoreBufferDIn),
                        .OutReady(StoreDataReady), .OutSend(StoreDataValid), .OutData(StoreData));  
    */
    
    FIFO #(FEDWidth, FEORAMBChunks) 
        StoreBuffer (Clock, Reset, 
                        StoreBufferReady, StoreBufferValid, StoreBufferDIn,
                        StoreDataReady, StoreDataValid, StoreData);     
                         
    // if ExpectingDataBlock, backend ==> network; otherwise backend ==> PLB  
    assign LoadDataReady = ExpectingDataBlock ? ReturnDataReady : 1;    // PLB refill is always ready
    assign ReturnDataValid = ExpectingDataBlock && LoadDataValid;
    assign ReturnData = LoadData;
    
    // if ExpectingStoreData, network ==> backend; otherwise PLB ==> backend
    assign DataInReady = ExpectingProgStore && StoreBufferReady;
    assign StoreBufferValid = ExpectingProgStore ? DataInValid : PPPEvictDataValid;
    assign StoreBufferDIn = ExpectingProgStore ? DataIn : PPPEvictData;
    
    reg [LogFEORAMBChunks-1:0] ProgDataCounter;
    
    initial begin
        ExpectingDataBlock <= 0;
        ExpectingPosMapBlock <= 0;
        ExpectingProgStore <= 0;  
        ProgDataCounter <= 0;
    end
    
    always @(posedge Clock) begin
        if (Reset) begin
            ExpectingDataBlock <= 0;
            ExpectingPosMapBlock <= 0;
            ExpectingProgStore <= 0;  
            ProgDataCounter <= 0;
        end
    
        else if ((ExpectingProgStore && DataInValid && DataInReady)
                || (ExpectingDataBlock && ReturnDataReady && ReturnDataValid)) begin
            ProgDataCounter <= ProgDataCounter + 1;          
            ExpectingProgStore <= !(ExpectingProgStore && ProgDataCounter == FEORAMBChunks - 1);
            ExpectingDataBlock <= !(ExpectingDataBlock && ProgDataCounter == FEORAMBChunks - 1);
        end
    end
    // ================================================================================    
endmodule
