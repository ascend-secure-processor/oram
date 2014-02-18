`include "Const.vh"

module testUORam;

    `include "PathORAM.vh";
    `include "UORAM.vh";
    `include "PLB.vh";
    `include "PathORAMBackendLocal.vh";
    `include "PLBLocal.vh"; 

    wire Clock, Reset; 
    reg  CmdInValid, DataInValid, ReturnDataReady;
    wire CmdInReady, DataInReady, ReturnDataValid;
    reg [1:0] CmdIn;
    reg [ORAMU-1:0] AddrIn;
    wire [FEDWidth-1:0] DataIn, ReturnData;

    reg  CmdOutReady; 
    wire CmdOutValid;
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
    assign DataIn = 1;
  
    localparam   Freq =	100_000_000;
    localparam   Cycle = 1000000000/Freq;	
    ClockSource #(Freq) ClockF100Gen(1'b1, Clock);

    reg [ORAML+1:0] GlobalPosMap [TotalNumBlock-1:0];
    
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

    reg ExpectingBEResponse;
    reg [ORAMU-1:0] AddrOutReg;

    task TASK_WaitForAccess;
        begin        
            while (!CmdOutValid) begin
                #(Cycle);
            end
            
            #(Cycle * ($random % 30));
            CmdOutReady <= 1;                     
            #(Cycle);
            CmdOutReady <= 0;
            
            $display("\t%s Block %d, \tLeaf %d --> %d", 
                CmdOut == 0 ? "Update" : CmdOut == 1 ? "Append" : CmdOut == 2 ? "Read" : "ReadRmv",
                AddrOut, CmdOut == 1 ? -1 : OldLeaf, NewLeaf);
            
            if (CmdOut == BECMD_Append) begin
                if (GlobalPosMap[AddrOut][ORAML+1]) begin
                    $display("Error: appending existing Block %d", AddrOut);
                    $finish;
                end
            end
            else if (GlobalPosMap[AddrOut][ORAML] == 0) begin
                $display("Error: requesting non-existing Block %d", AddrOut);
                $finish;               
            end
            else if (GlobalPosMap[AddrOut][ORAML-1:0] != OldLeaf) begin
                $display("Error: leaf label does not match, should be %d, %d provided", GlobalPosMap[AddrOut][ORAML-1:0], OldLeaf);
                $finish;              
            end
               
            GlobalPosMap[AddrOut] <= CmdOut == BECMD_ReadRmv ? {0, GlobalPosMap[AddrOut][ORAML:0]} : {2'b11, NewLeaf};
            AddrOutReg <= AddrOut;
                       
            if ((CmdOut == BECMD_ReadRmv) || (CmdOut == BECMD_Read)) begin
                #(Cycle);    
                #(Cycle * ($random % 30));
                for (integer i = 0; i < FEORAMBChunks; i = i + 1) begin
                    #(Cycle * ($random % 4));
                    LoadDataValid <= 1;
                    LoadData <= AddrOutReg <  NumValidBlock ? CycleCount : 
                            GlobalPosMap[(AddrOutReg - NumValidBlock) * LeafInBlock + i];;
                    #(Cycle);
                    LoadDataValid <= 0;
                end
            end
            
            else if (CmdOut == BECMD_Append || CmdOut == BECMD_Update) begin
                #(Cycle);
                StoreDataReady <= 1;
                DataInValid <= 1;
                for (integer i = 0; i < FEORAMBChunks; i = i + 1) begin
                    while (!StoreDataValid)  #(Cycle);        
                    #(Cycle);
                    if (StoreDataValid && StoreData != 1) begin
                        GlobalPosMap[(AddrOutReg - NumValidBlock) * LeafInBlock + i] <= 
                            {GlobalPosMap[(AddrOutReg - NumValidBlock) * LeafInBlock + i][ORAML+1], StoreData[ORAML:0]};
                    end
                end
                DataInValid <= 0;
                StoreDataReady <= 0;
            end
        end
    endtask
   
    reg  [ORAMU-1:0] AddrRand;
    wire [1:0] Op;
    wire  Exist, OpRand;
    
    assign Exist = GlobalPosMap[AddrRand][ORAML];
    assign OpRand = GlobalPosMap[AddrRand][0];
    assign Op = Exist ? {OpRand, 1'b0} : 2'b00;
    
    initial begin
        CmdInValid <= 0;
        DataInValid <= 0;
        ReturnDataReady <= 1;
        
        StoreDataReady <= 0;
        LoadDataValid <= 0;
        ExpectingBEResponse <= 0;
        
        CmdOutReady <= 0;
        AddrRand <= 0;
        
        for (integer i = 0; i < TotalNumBlock; i=i+1) begin
            GlobalPosMap[i][ORAML+1:ORAML] <= 0;
        end
        
        #(Cycle + Cycle / 2);
        for (integer k = 0; k < 1000; k = k+1) begin
            Task_StartORAMAccess(Op, AddrRand);
            #(Cycle)
            for (integer i = 0; i < 8; i = i+1) begin
                if (!CmdInReady) begin
                    TASK_WaitForAccess;
                end
                #(Cycle);
            end
            AddrRand <= ($random % 128) + 128;
        end
        $display("ALL TESTS PASSED!");
        $finish;        
    end
    
    
    
    wire testRAMEnable, testRAMWrite;
    wire [5-1:0] testRAMAddr;
    wire [12-1:0] testDRAMIn, testDRAMOut;

    RAM #(12, 5) testRAM(Clock, Reset, testRAMEnable, testRAMWrite, testRAMAddr, testDRAMIn, testDRAMOut);
    
    assign testRAMEnable = 1;
    assign testRAMWrite = CycleCount < 30 || CycleCount > 120;
    assign testRAMAddr = CycleCount;
    assign testDRAMIn = CycleCount + 200;
    
endmodule
