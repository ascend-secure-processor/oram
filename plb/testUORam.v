`include "Const.vh"

module testUORam;

    `include "PathORAM.vh";
    `include "UORAM.vh";
    `include "PLB.vh";
    `include "PathORAMBackendLocal.vh";

    wire Clock, Reset; 
    reg  CmdInValid, DataInValid, ReturnDataReady;
    wire CmdInReady, DataInReady, ReturnDataValid;
    reg [1:0] CmdIn;
    reg [ORAMU-1:0] AddrIn;
    wire [FEDWidth-1:0] DataIn, ReturnData;

    wire CmdOutReady, CmdOutValid;
    wire [1:0] CmdOut;
    wire [ORAMU-1:0] AddrOut;
    wire [ORAML-1:0] OldLeaf, NewLeaf;
    
    wire StoreDataValid, LoadDataReady;
    reg  StoreDataReady, LoadDataValid;
    wire [FEDWidth-1:0] StoreData;
    reg  [FEDWidth-1:0] LoadData; 

    UORamController FrontEnd(Clock, Reset, 
                            CmdInReady, CmdInValid, CmdIn, AddrIn,                     
                            DataInReady, DataInValid, DataIn, 
                            ReturnDataReady, ReturnDataValid, ReturnData,
                            CmdOutReady, CmdOutValid, CmdOut, AddrOut, OldLeaf, NewLeaf, 
                            StoreDataReady,  StoreDataValid, StoreData,
                            LoadDataReady, LoadDataValid, LoadData
                            );

    reg [ORAML-1:0] CycleCount;
    initial begin
        CycleCount = 0;
    end
    always@(posedge Clock) begin
        CycleCount = CycleCount + 1;
    end

    assign Reset = 0;
    assign DataIn = CycleCount + 30000;
   
    assign CmdOutReady = CycleCount % 50 == 0;  
  
    localparam   Freq =	100_000_000;
    localparam   Cycle = 1000000000/Freq;	
    ClockSource #(Freq) ClockF100Gen(1'b1, Clock);

    localparam LeafInBlock = ORAMB / LeafWidth;
    localparam LogLeafInBlock = `log2f(LeafInBlock);
    localparam FinalPosMapStart = NumValidBlock + (NumValidBlock >> LogLeafInBlock) + (NumValidBlock >> (2*LogLeafInBlock));
    localparam TotalNumBlock = NumValidBlock + (NumValidBlock >> LogLeafInBlock) + 
        (NumValidBlock >> (2*LogLeafInBlock)) + (NumValidBlock >> (3*LogLeafInBlock));
    reg [ORAML:0] GlobalPosMap [TotalNumBlock-1:0];
    
    task Task_StartORAMAccess;
        input [1:0] cmd;
        input [ORAMU-1:0] addr;
        begin   
            CmdInValid <= 1;
            CmdIn <= cmd;
            AddrIn <= addr;
            $display("Start Access: %s Block %d", 
                cmd == 0 ? "Update" : cmd == 1 ? "Append" : cmd == 2 ? "Read" : "ReadRmv",
                addr);
            #(Cycle) CmdInValid <= 0;
        end
    endtask

    localparam  ChunkInBlock = ORAMB / FEDWidth;
    localparam  LogChunkInBlock = `log2f(ChunkInBlock);

    reg ExpectingBEResponse;
    reg [ORAMU-1:0] AddrOutReg;

    task TASK_WaitForAccess;
        begin        
            while (!CmdOutValid || !CmdOutReady) begin
                #(Cycle);
            end
            $display("\t%s Block %d, \tLeaf %d --> %d", 
                CmdOut == 0 ? "Update" : CmdOut == 1 ? "Append" : CmdOut == 2 ? "Read" : "ReadRmv",
                AddrOut, CmdOut == 1 ? -1 : OldLeaf, NewLeaf);
            
            if (GlobalPosMap[AddrOut] != (CmdOut == 1 ? -1 : OldLeaf)
                && !(AddrOut >= FinalPosMapStart && GlobalPosMap[AddrOut] == {ORAML+1{1'b1}})) begin
                $display("Error: leaf label does not match, should be %d, %d provided", GlobalPosMap[AddrOut], (CmdOut == 1 ? -1 : OldLeaf));
                $finish;
            end          
            GlobalPosMap[AddrOut] <= CmdOut == BECMD_ReadRmv ? -1 : NewLeaf;
            AddrOutReg <= AddrOut;
                       
            if ((CmdOut == BECMD_ReadRmv) || (CmdOut == BECMD_Read)) begin
                #(Cycle);    
                #(Cycle * ($random % 30));
                for (integer i = 0; i < ChunkInBlock; i = i + 1) begin
                    #(Cycle * ($random % 4));
                    LoadDataValid <= 1;
                    LoadData <= AddrO <  NumValidBlock ? 0 : 
                            GlobalPosMap[(AddrOut - NumValidBlock) * LeafInBlock + i];;
                    #(Cycle);
                    LoadDataValid <= 0;
                end
            end 
        end
    endtask
   
    initial begin
        CmdInValid <= 0;
        DataInValid <= 0;
        ReturnDataReady <= 1;
        
        StoreDataReady <= 0;
        LoadDataValid <= 0;
        ExpectingBEResponse <= 0;
        
        for (integer i = 0; i < FinalPosMapStart; i=i+1) begin
            GlobalPosMap[i] <= $random;
            GlobalPosMap[i][ORAML] <= 0;
        end
        for (integer i = FinalPosMapStart; i < TotalNumBlock; i=i+1) begin
            GlobalPosMap[i] <= -1;
        end
        
        #(Cycle + Cycle / 2);
        for (integer k = 0; k < 10; k = k+1) begin
            Task_StartORAMAccess(3, ($random % 128) + 128);
            #(Cycle)
            for (integer i = 0; i < 4; i = i+1) begin
                if (!CmdInReady)
                    TASK_WaitForAccess;
                #(Cycle);
            end
        end
    end
    
endmodule
