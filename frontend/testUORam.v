`include "Const.vh"

// `timescale 1ns/1ns

module testUORam;
    parameter					ORAMB =				512;
	parameter				    ORAMU =				32; 
	parameter                   ORAML = `ifdef ORAML `ORAML `else 15 `endif;
	parameter                   ORAMZ = `ifdef ORAMZ `ORAMZ `else 5 `endif;
	parameter					ORAMC =				10; 
	parameter					ORAME =				5;
	
	parameter                   FEDWidth = `ifdef FEDWidth `FEDWidth `else 32 `endif;
	parameter                   BEDWidth = `ifdef BEDWidth `BEDWidth `else 512 `endif;
	
    parameter                   DDRAWidth_Sim =		`log2(ORAMZ) + ORAML + 2;
    
    parameter                   NumValidBlock = 	1 << (ORAML - 1);
    parameter                   Recursion = 		3;
                   
    parameter                   PLBCapacity = 		8192 << 3; // in bits

	parameter					Overclock = 		1;
	parameter					EnableAES =			1;
	parameter					EnableREW =			1;
    parameter					EnableIV =          0;
	
    `include "PathORAMBackendLocal.vh"
    `include "PLBLocal.vh" 
    `include "BucketLocal.vh"
    `include "DDR3SDRAMLocal.vh"

    wire Clock, FastClock; 
    wire Reset; 
    reg  CmdInValid, DataInValid, ReturnDataReady;
    wire CmdInReady, DataInReady, ReturnDataValid;
    reg [1:0] CmdIn;
    reg [ORAMU-1:0] AddrIn;
    wire [FEDWidth-1:0] ReturnData;
	reg  [FEDWidth-1:0] DataIn;
	
	wire	[DDRCWidth-1:0]		DDR3SDRAM_Command;
	wire	[DDRAWidth_Sim-1:0]	DDR3SDRAM_Address;
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
                            .PLBCapacity(           PLBCapacity))
                            
            ORAM    (		.Clock(					Clock),
							.FastClock(				FastClock),
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
	
	SynthesizedRandDRAM	#(	.InBufDepth(			InBufDepth),
	                        .OutInitLat(			OutInitLat),
	                        .OutBandWidth(			OutBandWidth),
                            .UWidth(				64),
                            .AWidth(				DDRAWidth_Sim),
                            .DWidth(				DDRDWidth),
                            .BurstLen(				1),
                            .EnableMask(			1),
                            .Class1(				1),
                            .RLatency(				1),
                            .WLatency(				1)) 
        ddr3model(	        .Clock(					Clock),
                            .Reset(					Reset),
                            
                            .CommandAddress(		DDR3SDRAM_Address),
                            .Command(				DDR3SDRAM_Command),
                            .CommandValid(			DDR3SDRAM_CommandValid),
                            .CommandReady(			DDR3SDRAM_CommandReady),
                            
                            .DataIn(				DDR3SDRAM_WriteData),
                            .DataInMask(			DDR3SDRAM_WriteMask),
                            .DataInValid(			DDR3SDRAM_WriteValid),
                            .DataInReady(			DDR3SDRAM_WriteReady),
                            
                            .DataOut(				DDR3SDRAM_ReadData),
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
  
    localparam  Freq =	200_000_000,
				FastFreq = 300_000_000;
    localparam   Cycle = 1000000000/Freq;	
    ClockSource #(Freq) ClockF200Gen(1'b1, Clock);
	ClockSource #(FastFreq) ClockF300Gen(1'b1, FastClock);

    reg [ORAML:0] GlobalPosMap [TotalNumBlock-1:0];
    reg  [31:0] TestCount;
    reg [ORAMU-1:0] AddrRand, AddrPrev;
	
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

	reg [ORAMB-1:0] GlobalData [0:NumValidBlock-1];
	
	
	integer i; 
	task Handle_ProgStore;
		begin
			#(Cycle);
			#(Cycle / 2.0) DataInValid <= 1;
			GlobalData[AddrIn] = 0;
			for (i = 0; i < FEORAMBChunks; i = i + 1) begin
				DataIn = $random;
				GlobalData[AddrIn] <= (GlobalData[AddrIn] << FEDWidth) + DataIn;
				while (!DataInReady)  #(Cycle);   
				#(Cycle);
			end
			DataInValid <= 0;
		end
	endtask
    
	reg Checking_ProgData;
	reg [ORAMB-1:0] ReceivedData;
	task Check_ProgData;
		begin
			Checking_ProgData <= 1;
			ReceivedData = 0;
			for (i = 0; i < FEORAMBChunks; i = i + 1) begin
				while (!ReturnDataReady || !ReturnDataValid)  #(Cycle);
				ReceivedData <= (ReceivedData << FEDWidth) + ReturnData;
				#(Cycle);
			end

			if (GlobalData[AddrPrev] != ReceivedData) begin
				$display("Received data does not match for Block %d, %x != %x", AddrPrev, ReceivedData, GlobalData[AddrPrev]);
				$stop;
			end
			Checking_ProgData <= 0;
		end
	endtask

	wire [1:0] Op;
	wire  Exist;

	assign Exist = GlobalPosMap[AddrRand][ORAML];
	//assign Op = Exist ? {GlobalPosMap[AddrRand][0], 1'b0} : 2'b00;
	assign Op = Exist ? 2'b10 : 2'b00;
	
	initial begin
		$display("ORAML = %d", ORAML);
		TestCount <= 0;
		CmdInValid <= 0;
		DataInValid <= 0;
		ReturnDataReady <= 1;   
		AddrRand <= 0;
		Checking_ProgData <= 0;

		for (i = 0; i < TotalNumBlock; i=i+1) begin
			GlobalPosMap[i][ORAML] <= 0;
		end
		
		for (i = 0; i < NumValidBlock; i=i+1) begin
			GlobalData[i] <= 0;
		end 
	end
   
   wire WriteCmd;
   assign WriteCmd = CmdIn == BECMD_Append || CmdIn == BECMD_Update;
   
   localparam  NN = 300;
   
    always @(posedge Clock) begin
        if (!Reset && CmdInReady) begin
            if (TestCount < 2 * NN) begin
                #(Cycle * 100);       
                Task_StartORAMAccess(Op, AddrRand);
                #(Cycle); 
				AddrPrev <= AddrRand;
                //AddrRand <= ((573 * TestCount + 421) % (NumValidBlock / 2)) + NumValidBlock / 2;			   
				AddrRand <= TestCount < NN ? TestCount : ((TestCount - NN) * 16) % NN;			   
                TestCount <= TestCount + 1;
  		   
				if (AddrRand > NumValidBlock)
					$finish;   
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
		if (ReturnDataValid && ReturnDataReady && !Checking_ProgData) begin
		   Check_ProgData;
		end
	end
	
	always @(posedge Clock) begin    
		if (ORAM.BEnd_CmdValid && ORAM.BEnd_CmdReady) begin
		   Check_Leaf;
		end
	end
       
endmodule
