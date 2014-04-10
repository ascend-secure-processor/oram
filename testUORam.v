`include "Const.vh"

// `timescale 1ns/1ns

module testUORam;
	parameter 					DDR_nCK_PER_CLK = 	4;
	parameter					DDRDQWidth =		64;
	parameter					DDRCWidth =			3;
						
    parameter					ORAMB =				512;
	parameter				    ORAMU =				32; 
	parameter                   ORAML = `ifdef ORAML `ORAML `else 10 `endif;
	parameter                   ORAMZ = `ifdef ORAMZ `ORAMZ `else 5 `endif;
	parameter					ORAMC =				10; 
	parameter					ORAME =				5;
	
	parameter                   FEDWidth = `ifdef FEDWidth `FEDWidth `else 32 `endif;
	parameter                   BEDWidth = `ifdef BEDWidth `BEDWidth `else 512 `endif;
	

    parameter                   DDRAWidth =		`log2(ORAMB * (ORAMZ + 1)) + ORAML + 1;
    
    parameter                   NumValidBlock = 1024;
    parameter                   Recursion = 3;
                
    parameter                   LeafWidth = 32;         // in bits       
    parameter                   PLBCapacity = 1024;     // in bits

	parameter				Overclock = 		0; 
	parameter				EnableAES =			0;
	parameter				EnableREW =			1; 
    parameter				EnableIV =          1;
	
    `include "PathORAMBackendLocal.vh"
    `include "PLBLocal.vh" 
    `include "BucketLocal.vh"
    `include "DDR3SDRAMLocal.vh"

    wire Clock; 
    wire Reset; 
    reg  CmdInValid, DataInValid, ReturnDataReady;
    wire CmdInReady, DataInReady, ReturnDataValid;
    reg [1:0] CmdIn;
    reg [ORAMU-1:0] AddrIn;
    wire [FEDWidth-1:0] DataIn, ReturnData;
	
	wire	[DDRCWidth-1:0]		DDR3SDRAM_Command;
	wire	[DDRAWidth-1:0]		DDR3SDRAM_Address;
	wire	[DDRDWidth-1:0]		DDR3SDRAM_WriteData, DDR3SDRAM_ReadData; 
	wire	[DDRMWidth-1:0]		DDR3SDRAM_WriteMask;
	
	wire						DDR3SDRAM_CommandValid, DDR3SDRAM_CommandReady;
	wire						DDR3SDRAM_WriteValid, DDR3SDRAM_WriteReady;
	wire						DDR3SDRAM_ReadValid;

    PathORamTop        #(	.StopOnBlockNotFound(	0),
                            .ORAMB(					ORAMB),
                            .ORAMU(					ORAMU),
                            .ORAML(					ORAML),
                            .ORAMZ(					ORAMZ),
                            .ORAME(					ORAME),
							.FEDWidth(				FEDWidth),
                            .BEDWidth(				BEDWidth),
							
							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							
                            .NumValidBlock(         NumValidBlock), 
                            .Recursion(             Recursion), 
                            .LeafWidth(             LeafWidth), 
                            .PLBCapacity(           PLBCapacity))
                            
            ORAM    (		.Clock(					Clock),
                            .Reset(					Reset),
                            
                            // interface with network			
                            .Cmd(				    CmdIn),
                            .PAddr(					AddrIn),
                            .CmdValid(			    CmdInValid),
                            .CmdReady(			    CmdInReady),
                            .DataInReady(           DataInReady), 
                            .DataInValid(           DataInValid), 
                            .DataIn(                DataIn),                                    
                            .DataOutReady(          ReturnDataReady), 
                            .DataOutValid(          ReturnDataValid), 
                            .DataOut(               ReturnData),
                            
                            // interface with DRAM		
                            .DRAMAddress(           DDR3SDRAM_Address),
                            .DRAMCommand(			DDR3SDRAM_Command),
                            .DRAMCommandValid(		DDR3SDRAM_CommandValid),
                            .DRAMCommandReady(		DDR3SDRAM_CommandReady),			
                            .DRAMReadData(			DDR3SDRAM_ReadData),
                            .DRAMReadDataValid(		DDR3SDRAM_ReadValid),			
                            .DRAMWriteData(			DDR3SDRAM_WriteData),
                            .DRAMWriteMask(			DDR3SDRAM_WriteMask),
                            .DRAMWriteDataValid(	DDR3SDRAM_WriteValid),
                            .DRAMWriteDataReady(	DDR3SDRAM_WriteReady));
					
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	DDR -> BRAM (to make simulation faster)
	//--------------------------------------------------------------------------
    parameter   InBufDepth = 6,
                OutInitLat = 30,
                OutBandWidth = 57;
	
	SynthesizedRandDRAM	#(	.InBufDepth(InBufDepth),
	                        .OutInitLat(OutInitLat),
	                        .OutBandWidth(OutBandWidth),
	                           
                            .UWidth(				8),
                            .AWidth(				DDRAWidth + 6),
                            .DWidth(				DDRDWidth),
                            .BurstLen(				1), // just for this module ...
                            .EnableMask(			1),
                            .Class1(				1),
                            .RLatency(				1),
                            .WLatency(				1)) 
        ddr3model(	        .Clock(					Clock),
                            .Reset(					Reset),
                            
                            .Initialized(			),
                            .PoweredUp(				),
                            
                            .CommandAddress(		{DDR3SDRAM_Address, 6'b000000}),
                            .Command(				DDR3SDRAM_Command),
                            .CommandValid(			DDR3SDRAM_CommandValid),
                            .CommandReady(			DDR3SDRAM_CommandReady),
                            
                            .DataIn(				DDR3SDRAM_WriteData),
                            .DataInMask(			DDR3SDRAM_WriteMask),
                            .DataInValid(			DDR3SDRAM_WriteValid),
                            .DataInReady(			DDR3SDRAM_WriteReady),
                            
                            .DataOut(				DDR3SDRAM_ReadData),
                            .DataOutErrorChecked(	),
                            .DataOutErrorCorrected(	),
                            .DataOutValid(			DDR3SDRAM_ReadValid),
                            .DataOutReady(			1'b1));

    reg [64-1:0] CycleCount;
    initial begin
        CycleCount = 0;
    end
    always@(negedge Clock) begin
        CycleCount = CycleCount + 1;
    end

    assign Reset = CycleCount < 30;
    assign DataIn = 1;
  
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
    reg [ORAML:0] GlobalPosMap [TotalNumBlock-1:0];
    reg  [31:0] TestCount;
    
    task Task_StartORAMAccess;
        input [1:0] cmd;
        input [ORAMU-1:0] addr;
        begin   
            CmdInValid <= 1;
            CmdIn <= cmd;
            AddrIn <= addr;
            $display("[t = %d] Start Access %d: %s Block %d",
                CycleCount, TestCount,
                cmd == 0 ? "Update" : cmd == 1 ? "Append" : cmd == 2 ? "Read" : "ReadRmv",
                addr);
            #(Cycle + Cycle / 2) CmdInValid <= 0;
        end
    endtask
    
    task Check_Leaf;
       begin
           $display("\t[t = %d] %s Block %d, \tLeaf %d --> %d",
		   CycleCount, 
                   ORAM.BEnd_Cmd == 0 ? "Update" : ORAM.BEnd_Cmd == 1 ? "Append" : ORAM.BEnd_Cmd == 2 ? "Read" : "ReadRmv",
                   ORAM.BEnd_PAddr, ORAM.BEnd_Cmd == 1 ? -1 : ORAM.CurrentLeaf, ORAM.RemappedLeaf);
               
           if (ORAM.BEnd_Cmd == BECMD_Append) begin
               if (GlobalPosMap[ORAM.BEnd_PAddr][ORAML]) begin
                   $display("Error: appending existing Block %d", ORAM.BEnd_PAddr);
                   $finish;
               end
           end
           else if (GlobalPosMap[ORAM.BEnd_PAddr][ORAML] == 0) begin
               $display("Error: requesting non-existing Block %d", ORAM.BEnd_PAddr);
               $finish;               
           end
           else if (GlobalPosMap[ORAM.BEnd_PAddr][ORAML-1:0] != ORAM.CurrentLeaf) begin
               $display("Error: leaf label does not match, should be %d, %d provided", GlobalPosMap[ORAM.BEnd_PAddr][ORAML-1:0], ORAM.CurrentLeaf);
               $finish;              
           end
              
           GlobalPosMap[ORAM.BEnd_PAddr] <= ORAM.BEnd_Cmd == BECMD_ReadRmv ? 0 : {1'b1, ORAM.RemappedLeaf};
       end 
    endtask    
  
   integer i; 
   task Handle_ProgStore;
       begin
          #(Cycle);
          #(Cycle / 2) DataInValid <= 1;
          for (i = 0; i < FEORAMBChunks; i = i + 1) begin
              while (!DataInReady)  #(Cycle);        
              #(Cycle);
          end
          //DataInValid <= 0;
       end
   endtask
    
   reg  [ORAMU-1:0] AddrRand;
   wire [1:0] Op;
   wire  Exist;
   
   assign Exist = GlobalPosMap[AddrRand][ORAML];
   assign Op = Exist ? {GlobalPosMap[AddrRand][0], 1'b0} : 2'b00;
   
   initial begin
        $display("ORAML = %d", ORAML);
        TestCount <= 0;
        CmdInValid <= 0;
        DataInValid <= 0;
        ReturnDataReady <= 1;   
        AddrRand <= 0;
         
        for (i = 0; i < TotalNumBlock; i=i+1) begin
            GlobalPosMap[i][ORAML] <= 0;
        end 
   end
   
   wire WriteCmd;
   assign WriteCmd = CmdIn == BECMD_Append || CmdIn == BECMD_Update;
   
   always @(posedge Clock) begin
       if (!Reset && CmdInReady) begin
           if (TestCount < 100) begin
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
   
   always @(posedge Clock) begin
       if (CmdInValid && CmdInReady && WriteCmd) begin
           Handle_ProgStore;
       end
   end
   
    always @(posedge Clock) begin    
       if (ORAM.BEnd_CmdValid && ORAM.BEnd_CmdReady) begin
           Check_Leaf;
       end
   end
       
endmodule
