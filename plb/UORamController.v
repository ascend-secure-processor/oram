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

    // FrontEnd state machines
    localparam MaxLogRecursion = 4;
    localparam LeafInBlock = ORAMB / LeafWidth;
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
    wire PPPOutReady, PPPValid, PPPHit, PPPEvict;
    wire [ORAML-1:0] PPPOldLeaf, PPPNewLeaf;  
    wire PPPEvictDataValid, PPPEvictData;
       
    PosMapPLB //#() 
    PPP (Clock, Reset, 
        PPPCmdReady, 
        PPPCmdValid, PPPCmd, PPPAddrIn, 
        PPPRefill, PPPDIn, 
        PPPOutReady, PPPValid, PPPHit, PPPOldLeaf, PPPNewLeaf, PPPEvict, PPPAddrOut,
        PPPEvictDataValid, PPPEvictData);   
 
    wire PPPMiss;
    reg  PPPLookup;
      
    assign PPPMiss = PPPValid && !PPPHit;   
    assign PPPRefill = Accessing && ExpectingPosMapBlock && LoadDataValid;
    
    assign PPPCmdValid = PPPLookup || (ExpectingPosMapBlock && !RefillStarted && LoadDataValid);
    assign PPPCmd = PPPRefill ? CacheRefill : Preparing ? CacheRead : CacheWrite;
    assign PPPAddrIn = PPPRefill ? AddrQ[QDepth] : AddrQ[QDepth];
    assign PPPDIn = LoadData;
    assign PPPEvictDataReady = !ExpectingProgStore && StoreDataReady;
    
    assign PPPOutReady = Preparing ? 1 : (PPPValid && !PPPHit && !PPPEvict) ? 1 : CmdOutReady;
        // 3 cases: read result, refill but no evict, evict or access
    // =============================================================================
    
    // ============================== Cmd to Backend ==============================
    assign EvictionRequest = PPPValid && PPPEvict;
    assign CmdOutValid = Accessing && PPPValid && (PPPHit || PPPEvict);

    // if EvictionRequest, write back a PosMap block; otherwise serve the next access in the queue  
    assign CmdOut = EvictionRequest ? BECMD_Append : QDepth != 0 ? BECMD_ReadRmv : CmdReg;
    assign AddrOut = EvictionRequest ? NumValidBlock + PPPAddrOut / LeafInBlock : AddrQ[QDepth];
    assign OldLeaf = PPPOldLeaf;
    assign NewLeaf = PPPNewLeaf;
    // =============================================================================
    
    initial begin
        Preparing <= 0;
        Accessing <= 0;
        PPPLookup <= 0;    
    end
     
    always @(posedge Clock) begin
        if (Reset) begin
            Preparing <= 0;
            Accessing <= 0;
            PPPLookup <= 0;           
        end

        else if (CmdInValid && CmdInReady) begin
            CmdReg <= CmdIn;
            QDepth <= 0;                  
            Preparing <= 1;
            PPPLookup  <= 1;
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
            end           
        end
        
        else if (Accessing) begin       
            if (CmdOutReady && CmdOutValid && !EvictionRequest) begin    // transition to next access, after sending out the current one     
                QDepth <= QDepth - 1;
                Accessing <= QDepth > 0;       

                ExpectingPosMapBlock <= QDepth > 0;
                ExpectingDataBlock <= QDepth == 0 && (CmdReg[1] == 1);  // only if it's a read
                ExpectingProgStore <= QDepth == 0 && (CmdReg[1] == 0);  // only if it's a write                
                RefillStarted <= 0;
                PPPLookup <= 0;                 
            end
            
            else begin
                RefillStarted <= RefillStarted || PPPRefill;  
                PPPLookup <= RefillStarted && PPPCmdReady;   // refill done          
            end
        end
    end            

    // =================== data interface with network and backend ====================
    localparam  ChunkInBlock = ORAMB / FEDWidth;
    localparam  LogChunkInBlock = `log2f(ChunkInBlock);
    // storebuffer to back end
    wire StoreBufferReady, StoreBufferValid;
    wire [FEDWidth-1:0] StoreBufferDIn;
    FIFO #(FEDWidth, ChunkInBlock) 
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
    
    reg [LogChunkInBlock-1:0] ProgDataCounter;
    
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
            ExpectingProgStore <= !(ExpectingProgStore && ProgDataCounter == ChunkInBlock - 1);
            ExpectingDataBlock <= !(ExpectingDataBlock && ProgDataCounter == ChunkInBlock - 1);
        end
    end
    // ================================================================================    
endmodule
