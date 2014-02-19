`include "Const.vh"

module UORamDataPath
#(`include "UORAM.vh", `include "PathORAM.vh", `include "PLB.vh")
(
    input Clock, Reset, 
    
    // input control state, output data state
    input SwitchReq,
    input [3:0] QDepth,
    input [1:0] Cmd,
    
    output ExpectingProgramData, 
    
    // receive data from network
    output DataInReady,
    input DataInValid,
    input [FEDWidth-1:0] DataIn,
    
    // return data to network
    input  ReturnDataReady,
    output ReturnDataValid,
    output [FEDWidth-1:0] ReturnData,
    
    // receive data from PLB
    output PPPEvictDataReady,
    input  PPPEvictDataValid,
    input  [LeafWidth-1:0] PPPEvictData,
    
    // return data to PLB
    input  PPPRefillDataReady,
    output PPPRefillDataValid,
    output [LeafWidth-1:0] PPPRefillData,
    
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
    
    // storebuffer to back end
    wire StoreBufferReady, StoreBufferValid;
    wire [FEDWidth-1:0] StoreBufferDIn;
    
    /*
    FIFORAM #(.Width(FEDWidth), .Buffering(FEORAMBChunks)) 
        StoreBuffer (.Clock(Clock), .Reset(Reset), 
                        .InAccept(StoreBufferReady), .InValid(StoreBufferValid), .InData(StoreBufferDIn),
                        .OutReady(StoreDataReady), .OutSend(StoreDataValid), .OutData(StoreData));  
    */
    
    // TODO: Funnel both ways
    
    FIFO #(FEDWidth, FEORAMBChunks) 
        StoreBuffer (Clock, Reset, 
                        StoreBufferReady, StoreBufferValid, StoreBufferDIn,
                        StoreDataReady, StoreDataValid, StoreData);     
    
    reg ExpectingPosMapBlock, ExpectingDataBlock, ExpectingProgStore;
    assign ExpectingProgramData =  ExpectingDataBlock || ExpectingProgStore;
    
    // if ExpectingStoreData, network ==> backend; otherwise PLB ==> backend
    assign DataInReady = ExpectingProgStore && StoreBufferReady;
    assign PPPEvictDataReady = !ExpectingProgStore && StoreBufferReady;
    
    assign StoreBufferValid = ExpectingProgStore ? DataInValid : PPPEvictDataValid; // TODO: store Funnel
    assign StoreBufferDIn = ExpectingProgStore ? DataIn : PPPEvictData;
                        
    // if ExpectingDataBlock, backend ==> network; if ExpectingPosMapBlock, backend ==> PLB  
    assign LoadDataReady = ExpectingDataBlock ? ReturnDataReady : PPPRefillDataReady;    // PLB refill is always ready

    assign ReturnDataValid = ExpectingDataBlock && LoadDataValid;
    assign ReturnData = LoadData;
    
    assign PPPRefillDataValid = ExpectingPosMapBlock && LoadDataValid;
    assign PPPRefillData = LoadData;    // TODO: load Funnel
    
    reg [LogFEORAMBChunks-1:0] ProgDataCounter;
    
    task UORamDataPathInit;
        begin
            ExpectingDataBlock <= 0;
            ExpectingPosMapBlock <= 0;
            ExpectingProgStore <= 0;  
            ProgDataCounter <= 0;
        end
    endtask 
    
    initial begin
        UORamDataPathInit;
    end
    
    always @(posedge Clock) begin
        if (Reset) begin
            UORamDataPathInit;
        end
        
        else if (SwitchReq) begin
            ExpectingPosMapBlock <= QDepth > 0;
            ExpectingDataBlock <= QDepth == 0 && (Cmd == BECMD_Read || Cmd == BECMD_ReadRmv);  // only if it's a read
            ExpectingProgStore <= QDepth == 0 && (Cmd == BECMD_Append || Cmd == BECMD_Update);  // only if it's a write    
        end
    
        if (ExpectingProgStore && DataInValid && DataInReady) begin
            ProgDataCounter <= ProgDataCounter + 1;
            ExpectingProgStore <= ProgDataCounter != FEORAMBChunks - 1;  
        end
        else if (ExpectingDataBlock && ReturnDataReady && ReturnDataValid) begin
            ProgDataCounter <= ProgDataCounter + 1; 
            ExpectingDataBlock <= ProgDataCounter != FEORAMBChunks - 1;     
        end
    end
     
endmodule
