`include "Const.vh"

module testUORam;
						
	parameter 					DDR_nCK_PER_CLK = 	4,
								DDRDQWidth =		64,
								DDRCWidth =			3,
								DDRAWidth =			`log2(ORAMB * (ORAMZ + 1)) + ORAML + 1;
								
	parameter					StashCapacity =		100;
	
	parameter					IVEntropyWidth =	64;

    `include "PathORAM.vh";
    `include "UORAM.vh";
    `include "PLB.vh";
    `include "PathORAMBackendLocal.vh";
    `include "PLBLocal.vh"; 
    `include "BucketLocal.vh"
    `include "DDR3SDRAMLocal.vh"

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
    
    wire StoreDataValid, LoadDataReady, StoreDataReady, LoadDataValid;
    wire [FEDWidth-1:0] StoreData, LoadData;

    UORamController #(  .ORAMU(         ORAMU), 
                        .ORAML(         ORAML), 
                        .ORAMB(         ORAMB), 
                        .NumValidBlock( NumValidBlock), 
                        .Recursion(     Recursion), 
                        .LeafWidth(     LeafWidth), 
                        .PLBCapacity(   PLBCapacity)) 
    FrontEnd    (   .Clock(             Clock), 
                    .Reset(             Reset), 
                    .CmdInReady(        CmdInReady), 
                    .CmdInValid(        CmdInValid), 
                    .CmdIn(             CmdIn), 
                    .ProgAddrIn(        AddrIn),
                    .DataInReady(       DataInReady), 
                    .DataInValid(       DataInValid), 
                    .DataIn(            DataIn),                                    
                    .ReturnDataReady(   ReturnDataReady), 
                    .ReturnDataValid(   ReturnDataValid), 
                    .ReturnData(        ReturnData),
                            
                    .CmdOutReady(       CmdOutReady), 
                    .CmdOutValid(       CmdOutValid), 
                    .CmdOut(            CmdOut), 
                    .AddrOut(           AddrOut), 
                    .OldLeaf(           OldLeaf), 
                    .NewLeaf(           NewLeaf), 
                    .StoreDataReady(    StoreDataReady), 
                    .StoreDataValid(    StoreDataValid), 
                    .StoreData(         StoreData),
                    .LoadDataReady(     LoadDataReady), 
                    .LoadDataValid(     LoadDataValid), 
                    .LoadData(          LoadData)
                );

    // DRAM interface
	wire	[DDRCWidth-1:0]		DRAM_Command;
	wire	[DDRAWidth-1:0]		DRAM_Address;
	wire	[DDRDWidth-1:0]		DRAM_WriteData, DRAM_ReadData; 
	wire	[DDRMWidth-1:0]		DRAM_WriteMask;
	wire						DRAM_CommandValid, DRAM_CommandReady;
	wire						DRAM_WriteDataValid, DRAM_WriteDataReady;
	wire						DRAM_ReadDataValid;	

    PathORAMBackend #(		.StashCapacity(			StashCapacity),
							.StopOnBlockNotFound(	0),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),							
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
            BackEnd(		.Clock(					Clock),
							.Reset(					Reset),			
							.Command(				CmdOut),
							.PAddr(					AddrOut),
							.CurrentLeaf(			OldLeaf),
							.RemappedLeaf(			NewLeaf),
							.CommandValid(			CmdOutValid),
							.CommandReady(			CmdOutReady),
							.LoadData(				LoadData),
							.LoadValid(				LoadDataValid),
							.LoadReady(				LoadDataReady),
							.StoreData(				StoreData),
							.StoreValid(			StoreDataValid),
							.StoreReady(			StoreDataReady),
							.DRAMCommandAddress(	DRAM_Address),
							.DRAMCommand(			DRAM_Command),
							.DRAMCommandValid(		DRAM_CommandValid),
							.DRAMCommandReady(		DRAM_CommandReady),			
							.DRAMReadData(			DRAM_ReadData),
							.DRAMReadDataValid(		DRAM_ReadDataValid),			
							.DRAMWriteData(			DRAM_WriteData),
							.DRAMWriteMask(			DRAM_WriteMask),
							.DRAMWriteDataValid(	DRAM_WriteDataValid),
							.DRAMWriteDataReady(	DRAM_WriteDataReady));
							
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	DDR -> BRAM (to make simulation faster)
	//--------------------------------------------------------------------------
	
	SynthesizedDRAM	#(		.UWidth(				8),
							.AWidth(				DDRAWidth + 6),
							.DWidth(				DDRDWidth),
							.BurstLen(				1), // just for this module ...
							.EnableMask(			1),
							.Class1(				1),
							.RLatency(				1),
							.WLatency(				1)) 
				ddr3model(	.Clock(					Clock),
							.Reset(					Reset),

							.Initialized(			),
							.PoweredUp(				),

							.CommandAddress(		{DRAM_Address, 6'b000000}),
							.Command(				DRAM_Command),
							.CommandValid(			DRAM_CommandValid),
							.CommandReady(			DRAM_CommandReady),

							.DataIn(				DRAM_WriteData),
							.DataInMask(			DRAM_WriteMask),
							.DataInValid(			DRAM_WriteDataValid),
							.DataInReady(			DRAM_WriteDataReady),

							.DataOut(				DRAM_ReadData),
							.DataOutErrorChecked(	),
							.DataOutErrorCorrected(	),
							.DataOutValid(			DRAM_ReadDataValid),
							.DataOutReady(			1'b1));



    reg [64-1:0] CycleCount;
    initial begin
        CycleCount = 0;
    end
    always@(posedge Clock) begin
        CycleCount = CycleCount + 1;
    end

    assign Reset = CycleCount < 30;
    assign DataIn = 1;
  
    localparam   Freq =	100_000_000;
    localparam   Cycle = 1000000000/Freq;	
    ClockSource #(Freq) ClockF100Gen(1'b1, Clock);

    reg [ORAML:0] GlobalPosMap [TotalNumBlock-1:0];
    reg  [31:0] TestCount;
    
    task Task_StartORAMAccess;
        input [1:0] cmd;
        input [ORAMU-1:0] addr;
        begin   
            CmdInValid <= 1;
            CmdIn <= cmd;
            AddrIn <= addr;
            $display("Start Access %d: %s Block %d",
                TestCount,
                cmd == 0 ? "Update" : cmd == 1 ? "Append" : cmd == 2 ? "Read" : "ReadRmv",
                addr);
            #(Cycle) CmdInValid <= 0;
        end
    endtask

    task Check_Leaf;
        begin
            $display("\t%s Block %d, \tLeaf %d --> %d", 
                    CmdOut == 0 ? "Update" : CmdOut == 1 ? "Append" : CmdOut == 2 ? "Read" : "ReadRmv",
                    AddrOut, CmdOut == 1 ? -1 : OldLeaf, NewLeaf);
                
                if (CmdOut == BECMD_Append) begin
                    if (GlobalPosMap[AddrOut][ORAML]) begin
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
                   
                GlobalPosMap[AddrOut] <= CmdOut == BECMD_ReadRmv ? 0 : {1'b1, NewLeaf};
        end 
    endtask    
    
    task Handle_ProgStore;
        begin
           #(Cycle);
           DataInValid <= 1;
           for (integer i = 0; i < FEORAMBChunks; i = i + 1) begin
               while (!DataInReady)  #(Cycle);        
               #(Cycle);
           end
           DataInValid <= 0;
        end
    endtask
    
    
    
    reg  [ORAMU-1:0] AddrRand;
    wire [1:0] Op;
    wire  Exist;
    
    assign Exist = GlobalPosMap[AddrRand][ORAML];
    assign Op = Exist ? {GlobalPosMap[AddrRand][0], 1'b0} : 2'b00;
    
    initial begin
        TestCount <= 0;
        CmdInValid <= 0;
        DataInValid <= 0;
        ReturnDataReady <= 1;   
        AddrRand <= 0;
          
        for (integer i = 0; i < TotalNumBlock; i=i+1) begin
            GlobalPosMap[i][ORAML] <= 0;
        end         
    end
    
    wire WriteCmd;
    assign WriteCmd = CmdOut == BECMD_Append || CmdOut == BECMD_Update;
    
    always @(posedge Clock) begin
        if (CmdInReady) begin
            if (TestCount < 200) begin
                Task_StartORAMAccess(Op, AddrRand);
                #(Cycle);       
                AddrRand <= ($random % (NumValidBlock / 2)) + NumValidBlock / 2;
                TestCount <= TestCount + 1;
            end
            else begin
                $display("ALL UORAM TESTS PASSED!");
                $finish;  
            end
        end
    end
    
    always @(posedge Clock) begin
        if (CmdOutValid && CmdOutReady && WriteCmd && AddrOut < NumValidBlock) begin
            Handle_ProgStore;
        end
    end
    
    always @(posedge Clock) begin    
        if (CmdOutValid && CmdOutReady) begin
            Check_Leaf;
        end
    end
    
endmodule
