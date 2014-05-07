`include "Const.vh"

 `timescale 1ns/1ns

module testFrontEnd;
						
	parameter					ORAMB =				512;
	parameter				    ORAMU =				32; 
	parameter                   ORAML = `ifdef ORAML `ORAML `else 10 `endif;
	parameter                   ORAMZ = `ifdef ORAMZ `ORAMZ `else 5 `endif;
	parameter					ORAMC =				10; 
								
	parameter                   FEDWidth = `ifdef FEDWidth `FEDWidth `else 32 `endif;
	parameter                   BEDWidth = `ifdef BEDWidth `BEDWidth `else 512 `endif;
    
    parameter                   NumValidBlock = 1024;
    parameter                   Recursion = 3;
                
    parameter                   PLBCapacity = 1024;     // in bits

    `include "PathORAMBackendLocal.vh"
    `include "PLBLocal.vh"

    wire  Clock; 
    wire Reset; 
    reg  CmdInValid, DataInValid, ReturnDataReady;
    wire CmdInReady, DataInReady, ReturnDataValid;
    reg [1:0] CmdIn;
    reg [ORAMU-1:0] AddrIn;
    wire [FEDWidth-1:0] DataIn, ReturnData;
	
    wire					BEnd_CmdValid, BEnd_CmdReady;
    wire	[BECMDWidth-1:0] BEnd_Cmd;
    wire	[ORAMU-1:0]		BEnd_PAddr;
    wire	[ORAML-1:0]		CurrentLeaf, RemappedLeaf;

    wire	[FEDWidth-1:0]	LoadData, StoreData;
    wire					LoadReady, StoreValid;
    reg                     LoadValid, StoreReady;
    

   UORamController #(  	        .ORAMU(         		ORAMU), 
    							.ORAML(         		ORAML), 
    							.ORAMB(         		ORAMB), 
    							.FEDWidth(				FEDWidth),
    							.NumValidBlock( 		NumValidBlock), 
    							.Recursion(     		Recursion), 
    							.LeafWidth(     		LeafWidth), 
    							.PLBCapacity(   		PLBCapacity)) 
    				front_end(	.Clock(             	Clock), 
    							.Reset(					Reset), 
    							
    							.CmdInReady(			CmdInReady), 
    							.CmdInValid(			CmdInValid), 
    							.CmdIn(					CmdIn), 
    							.ProgAddrIn(			AddrIn),
    							.DataInReady(			DataInReady), 
    							.DataInValid(			DataInValid), 
    							.DataIn(				DataIn),                                    
    							.ReturnDataReady(		ReturnDataReady), 
    							.ReturnDataValid(		ReturnDataValid), 
    							.ReturnData(			ReturnData),
    		                        
    							.CmdOutReady(			BEnd_CmdReady), 
    							.CmdOutValid(			BEnd_CmdValid), 
    							.CmdOut(				BEnd_Cmd), 
    							.AddrOut(				BEnd_PAddr), 
    							.OldLeaf(				CurrentLeaf), 
    							.NewLeaf(				RemappedLeaf), 
    							.StoreDataReady(		StoreReady), 
    							.StoreDataValid(		StoreValid), 
    							.StoreData(				StoreData),
    							.LoadDataReady(			LoadReady), 
    							.LoadDataValid(			LoadValid), 
    							.LoadData(				LoadData));
					
	//--------------------------------------------------------------------------

    
	// cycle count and clock generation
    reg [64-1:0] CycleCount;
    initial begin
        CycleCount = 0;
    end
    always@(negedge Clock) begin
        CycleCount = CycleCount + 1;
    end

    assign Reset = CycleCount < 30;
    assign DataIn = 1;
    assign BEnd_CmdReady = (CycleCount % 100) == 0;
  
    localparam   Freq =	100_000_000;
    localparam   Cycle = 1000000000/Freq;	
    ClockSource #(Freq) ClockF100Gen(1'b1, Clock);

/*
    initial begin
        Clock <= 0;    
        while (1) begin
            #(Cycle/2);
            Clock <= ~Clock;
         end
    end
*/
    // tasks and check logic
	
    reg [ORAML+1:0] GlobalPosMap [TotalNumBlock-1:0];
    reg  [31:0] TestCount;
    
    reg  [BECMDWidth-1:0] BEnd_Cmd_Reg;
    reg  [ORAMU-1:0]		BEnd_PAddr_Reg;
    
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
             #(Cycle + Cycle / 2) CmdInValid <= 0;
         end
     endtask
     
     task Check_Leaf;
        begin
            BEnd_Cmd_Reg <= BEnd_Cmd;
            BEnd_PAddr_Reg <= BEnd_PAddr;
            
            $display("\t%s Block %d, \tLeaf %d --> %d", 
                    BEnd_Cmd == 0 ? "Update" : BEnd_Cmd == 1 ? "Append" : BEnd_Cmd == 2 ? "Read" : "ReadRmv",
                    BEnd_PAddr, BEnd_Cmd == 1 ? -1 : CurrentLeaf, RemappedLeaf);
                
            if (BEnd_Cmd == BECMD_Append) begin
                if (GlobalPosMap[BEnd_PAddr][ORAML+1]) begin
                    $display("Error: appending existing Block %d", BEnd_PAddr);
                    $finish;
                end
            end
            else if (GlobalPosMap[BEnd_PAddr][ORAML+1] == 0) begin
                $display("Error: requesting non-existing Block %d", BEnd_PAddr);
                $finish;               
            end
            else if (GlobalPosMap[BEnd_PAddr][ORAML-1:0] != CurrentLeaf) begin
                $display("Error: leaf label does not match, should be %d, %d provided", GlobalPosMap[BEnd_PAddr][ORAML-1:0], CurrentLeaf);
                $finish;              
            end
               
            GlobalPosMap[BEnd_PAddr][ORAML-1:0] <= RemappedLeaf;
            GlobalPosMap[BEnd_PAddr][ORAML] <= 1'b1;
            GlobalPosMap[BEnd_PAddr][ORAML+1] <= BEnd_Cmd != BECMD_ReadRmv;
                        
        end 
     endtask    
    
    integer ProgStore_iter;
    task Handle_ProgStore;
        begin
           #(Cycle);
           #(Cycle / 2) DataInValid <= 1;
           for (ProgStore_iter = 0; ProgStore_iter < FEORAMBChunks; ProgStore_iter = ProgStore_iter + 1) begin
               while (!DataInReady)  #(Cycle);        
               #(Cycle);
           end
           DataInValid <= 0;
        end
    endtask
    
    integer BEResponse_iter;
    task Handle_BEResponse;
        begin
           #(Cycle * 30);
           #(Cycle / 2) LoadValid <= 1;
           for (BEResponse_iter = 0; BEResponse_iter < FEORAMBChunks; BEResponse_iter = BEResponse_iter + 1) begin
               while (!LoadReady)  #(Cycle);  
          //    	    $display("[Response Chunk %d]  Block %d currently --> leaf %d (existence = %d)",
	  //		BEResponse_iter, 
	  //		(BEnd_PAddr_Reg - NumValidBlock) * FEORAMBChunks + BEResponse_iter, 
	  //		LoadData[ORAML-1:0], LoadData[ORAML]);
               #(Cycle);
           end
           LoadValid <= 0;
        end
    endtask
    
    assign LoadData = BEnd_PAddr_Reg < NumValidBlock ? 0 : 
            GlobalPosMap[(BEnd_PAddr_Reg - NumValidBlock) * FEORAMBChunks + BEResponse_iter];

    integer BEWrite_iter;    
    task Handle_BEWrite;
        begin
           #(Cycle / 2) StoreReady <= 1;
           for (BEWrite_iter = 0; BEWrite_iter < FEORAMBChunks; BEWrite_iter = BEWrite_iter + 1) begin
	        while (!StoreValid)  begin
			$display("[t = %d]", CycleCount);
			#(Cycle);
		end               
                if (BEnd_PAddr_Reg >= NumValidBlock) begin
                    GlobalPosMap[(BEnd_PAddr_Reg - NumValidBlock) * FEORAMBChunks + BEWrite_iter][ORAML:0] <= StoreData[ORAML:0];     
		end
        //       	    $display("[t = %d, Chunk %d (end = %d)] Block %d currently --> leaf %d (existence = %d)",
	//		CycleCount, BEWrite_iter , StoreValid,
	//		(BEnd_PAddr_Reg - NumValidBlock) * FEORAMBChunks + BEWrite_iter, 
	//		StoreData[ORAML-1:0], StoreData[ORAML]);
		#(Cycle);
           end
           StoreReady <= 0;
        end
    endtask
    
    reg  [ORAMU-1:0] AddrRand;
    wire [1:0] Op;
    wire  Exist;
    
    assign Exist = GlobalPosMap[AddrRand][ORAML];
    assign Op = Exist ? {GlobalPosMap[AddrRand][0], 1'b0} : 2'b00;
   
    integer i; 
    initial begin
         $display("ORAML = %d", ORAML);
         TestCount <= 0;
         CmdInValid <= 0;
         DataInValid <= 0;
         ReturnDataReady <= 1;  
         LoadValid <= 0; 
         AddrRand <= 0;
         StoreReady <= 0;         

         DataInValid <= 1;
          
         for (i = 0; i < TotalNumBlock; i=i+1) begin
             GlobalPosMap[i][ORAML+1:ORAML] <= 0;
         end         
    end
    
    wire WriteCmd;
    assign WriteCmd = CmdIn == BECMD_Append || CmdIn == BECMD_Update;
    
    always @(posedge Clock) begin
        if (!Reset && CmdInReady) begin
            if (TestCount < 1000) begin
                #(Cycle * 10);       
                Task_StartORAMAccess(Op, AddrRand);
                #(Cycle);       
                AddrRand <= ($random % (NumValidBlock / 2)) + NumValidBlock / 2;
                TestCount <= TestCount + 1;
            end
            else begin
                $display("ALL TESTS PASSED!");
                $finish;  
            end
        end
    end
 
 /*   
    always @(posedge Clock) begin
        if (CmdInValid && CmdInReady && WriteCmd) begin
            Handle_ProgStore;
        end
    end
  */  
     always @(posedge Clock) begin    
        if (BEnd_CmdValid && BEnd_CmdReady) begin
            Check_Leaf;
            if (BEnd_Cmd == BECMD_ReadRmv || BEnd_Cmd == BECMD_Read)
                Handle_BEResponse;
            else if (BEnd_Cmd == BECMD_Append || BEnd_Cmd == BECMD_Update)
                Handle_BEWrite;       
        end
    end
       
endmodule
