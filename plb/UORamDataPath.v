`include "Const.vh"

module UORamDataPath
#(`include "UORAM.vh", `include "PathORAM.vh", `include "PLB.vh")
(
    input Clock, Reset, 
    
    // input control state, output data state
    input SwitchReq,
    input DataBlockReq,
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
    
    // PPPEvictBuffer
    wire EvictBufferOutReady, EvictBufferOutValid;
    wire [LeafWidth-1:0] EvictBufferDOut;
      
    FIFORAM #(.Width(LeafWidth), .Buffering(LeafInBlock)) 
        EvictBuffer (   .Clock(Clock), 
                        .Reset(Reset), 
                        .InAccept(PPPEvictDataReady), 
                        .InValid(PPPEvictDataValid), 
                        .InData(PPPEvictData),                      
                        .OutReady(EvictBufferOutReady), 
                        .OutSend(EvictBufferOutValid), 
                        .OutData(EvictBufferDOut)
                    ); 
    
    // Funnel for PPPEvictBuffer --> BackEnd
    wire EvictFunnelOutValid;
    wire [FEDWidth-1:0] EvictFunnelDOut;
    
    FIFOShiftRound #(.IWidth(LeafWidth), .OWidth(FEDWidth))
        EvictFunnel (   .Clock(Clock), 
                        .Reset(Reset),  
                        .InAccept(EvictBufferOutReady), 
                        .InValid(EvictBufferOutValid), 
                        .InData(EvictBufferDOut),
                        .OutReady(StoreDataReady), 
                        .OutValid(EvictFunnelOutValid), 
                        .OutData(EvictFunnelDOut)
                    );
    
    // Funnel for LoadData --> PPPRefillData
    wire RefillFunnelReady, RefillFunnelValid;
    
    FIFOShiftRound #(.IWidth(FEDWidth), .OWidth(LeafWidth))
        RefillFunnel (  .Clock(Clock), 
                        .Reset(Reset), 
                        .InAccept(RefillFunnelReady), 
                        .InValid(RefillFunnelValid), 
                        .InData(LoadData),
                        .OutReady(PPPRefillDataReady), 
                        .OutValid(PPPRefillDataValid), 
                        .OutData(PPPRefillData)
                    );

    reg ExpectingPosMapBlock, ExpectingDataBlock, ExpectingProgStore;
    assign ExpectingProgramData =  ExpectingDataBlock || ExpectingProgStore;
    
    // if ExpectingProgStore, network ==> backend; otherwise PLB ==> backend
    assign StoreDataValid = ExpectingProgStore ? DataInValid : EvictFunnelOutValid;
    assign StoreData = ExpectingProgStore ? DataIn : EvictFunnelDOut;
    assign DataInReady = ExpectingProgStore && StoreDataReady;
  
    // if ExpectingDataBlock, backend ==> network; if ExpectingPosMapBlock, backend ==> PLB  
    assign LoadDataReady = ExpectingDataBlock ? ReturnDataReady : RefillFunnelReady;    // PLB refill is always ready
    assign RefillFunnelValid = ExpectingPosMapBlock && LoadDataValid;
    assign ReturnDataValid = ExpectingDataBlock && LoadDataValid;
    assign ReturnData = LoadData;
    
    reg [LogFEORAMBChunks-1:0] ProgDataCounter;
    
    task UORamDataPathInit;
        begin
            ExpectingDataBlock <= 0;
            ExpectingPosMapBlock <= 0;
            ExpectingProgStore <= 0;  
            ProgDataCounter <= 0;
        end
    endtask 
   
    always @(posedge Clock) begin
        if (Reset) begin
            UORamDataPathInit;
        end
        
        else if (SwitchReq) begin
            ExpectingPosMapBlock <= !DataBlockReq;
            ExpectingDataBlock <= DataBlockReq && (Cmd == BECMD_Read || Cmd == BECMD_ReadRmv);  // only if it's a read
            ExpectingProgStore <= DataBlockReq && (Cmd == BECMD_Append || Cmd == BECMD_Update);  // only if it's a write    
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
