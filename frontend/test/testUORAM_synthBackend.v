`include "Const.vh"

module testUORAM_synthBackend;
	
	`include "PathORAM.vh"
	`include "UORAM.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "CommandsLocal.vh"
	`include "BucketLocal.vh" 
	`include "PLBLocal.vh" 
	
    wire 						Clock, AESClock; 
    wire 						Reset; 
    reg  						CmdInValid, DataInValid, ReturnDataReady;
    wire 						CmdInReady, DataInReady, ReturnDataValid;
    reg [1:0] 					CmdIn;
    reg [ORAMU-1:0] 			AddrIn;
    wire [FEDWidth-1:0] 		ReturnData;
	reg  [FEDWidth-1:0] 		DataIn;
	
	wire	[DDRCWidth-1:0]		DDR3SDRAM_Command;
	wire	[DDRAWidth-1:0]		DDR3SDRAM_Address;
	wire	[BEDWidth-1:0]		DDR3SDRAM_WriteData, DDR3SDRAM_ReadData; 
	wire	[DDRMWidth-1:0]		DDR3SDRAM_WriteMask;

	wire	[DDRDWidth-1:0]		DDR3SDRAM_ReadData_Wide,	DDR3SDRAM_ReadData_Wide_Pre;
	wire						DDR3SDRAM_ReadValid_Wide, 	DDR3SDRAM_ReadReady_Wide;
	wire						DDR3SDRAM_ReadValid_Wide_Pre, DDR3SDRAM_ReadReady_Wide_Pre;
	
	wire	[DDRDWidth-1:0]		DDR3SDRAM_WriteData_Wide;
	wire						DDR3SDRAM_WriteValid_Wide, DDR3SDRAM_WriteReady_Wide;

	wire						DDR3SDRAM_ReadReady;
	
	wire						DDR3SDRAM_CommandValid, DDR3SDRAM_CommandReady;
	wire						DDR3SDRAM_WriteValid, DDR3SDRAM_WriteReady;
	wire						DDR3SDRAM_ReadValid;
	
	wire	[BECMDWidth-1:0]	DDR3SDRAM_Command_Pre;
	
	UORAMController uoram(	.Clock(             	Clock), 
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
							
							.CmdOutReady(			DDR3SDRAM_CommandReady), 
							.CmdOutValid(			DDR3SDRAM_CommandValid), 
							.CmdOut(				DDR3SDRAM_Command_Pre), 
							.AddrOut(				DDR3SDRAM_Address), 
							.OldLeaf(				), 
							.NewLeaf(				), 
							.StoreDataReady(		DDR3SDRAM_WriteReady), 
							.StoreDataValid(		DDR3SDRAM_WriteValid), 
							.StoreData(				DDR3SDRAM_WriteData),
							.LoadDataReady(			DDR3SDRAM_ReadReady), 
							.LoadDataValid(			DDR3SDRAM_ReadValid), 
							.LoadData(				DDR3SDRAM_ReadData));
							
	assign	DDR3SDRAM_Command =						(DDR3SDRAM_Command_Pre == BECMD_Update || DDR3SDRAM_Command_Pre == BECMD_Append) ? DDR3CMD_Write : DDR3CMD_Read;		
	assign	DDR3SDRAM_WriteMask =					{DDRMWidth{1'b0}};
	
	//--------------------------------------------------------------------------
	//	DDR -> BRAM (to make simulation faster)
	//--------------------------------------------------------------------------
	
	// These FIFOs must be reversed; the stash assumes this.
	// It is cleaner and also makes more sense since IV/seed comes first now
   
	FIFOShiftRound #(		.IWidth(				DDRDWidth),
							.OWidth(				FEDWidth),
							.Reverse(				1))
				in_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DDR3SDRAM_ReadData_Wide),
							.InValid(				DDR3SDRAM_ReadValid_Wide),
							.InAccept(				DDR3SDRAM_ReadReady_Wide),
							.OutData(				DDR3SDRAM_ReadData),
							.OutValid(				DDR3SDRAM_ReadValid),
							.OutReady(				DDR3SDRAM_ReadReady));
							
	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				DDRDWidth),
							.Reverse(				1))
				out_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DDR3SDRAM_WriteData),
							.InValid(				DDR3SDRAM_WriteValid),
							.InAccept(				DDR3SDRAM_WriteReady),
							.OutData(				DDR3SDRAM_WriteData_Wide),
							.OutValid(				DDR3SDRAM_WriteValid_Wide),
							.OutReady(				DDR3SDRAM_WriteReady_Wide));
	
	wire	[DDRAWidth-1:0]	DRAMReadAddr;
	wire					DRAMReadAddrValid;
	FIFORAM	#(				.Width(					DDRAWidth),
							.Buffering(				500))
		rd_addr(			.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DDR3SDRAM_Address),
							.InValid(				DDR3SDRAM_Command == DDR3CMD_Read && DDR3SDRAM_CommandValid && DDR3SDRAM_CommandReady),
							.InAccept(				),
							.OutData(				DRAMReadAddr),
							.OutSend(				DRAMReadAddrValid),
							.OutReady(				DDR3SDRAM_ReadValid_Wide && DDR3SDRAM_ReadReady_Wide));
	/*
	FIFORAM	#(				.Width(					DDRAWidth),
							.Buffering(				500))
		wr_addr(			.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DDR3SDRAM_Address),
							.InValid(				DDR3SDRAM_Command == DDR3CMD_Write && DDR3SDRAM_CommandValid && DDR3SDRAM_CommandReady),
							.InAccept(				),
							.OutData(				DRAMWriteAddr),
							.OutSend(				DRAMWriteAddrValid),
							.OutReady(				DDR3SDRAM_WriteValid_Wide & DDR3SDRAM_WriteReady_Wide));
	*/
	always @(posedge Clock) begin
		if (DDR3SDRAM_Command == DDR3CMD_Write && DDR3SDRAM_CommandValid && DDR3SDRAM_CommandReady) begin
			$display("[%m @ %t] Write DRAM[%x]", $time, DDR3SDRAM_Address);
		end
	
		if (DDR3SDRAM_WriteValid_Wide & DDR3SDRAM_WriteReady_Wide) begin
			$display("[%m @ %t] Write DRAM:    		%x", $time, DDR3SDRAM_WriteData_Wide);
		end
		
		if (DDR3SDRAM_ReadValid_Wide & DDR3SDRAM_ReadReady_Wide) begin
			$display("[%m @ %t] Read DRAM[%x]:     %x", $time, DRAMReadAddr, DDR3SDRAM_ReadData_Wide);
		end
		
		if (DDR3SDRAM_ReadValid_Wide_Pre && !DDR3SDRAM_ReadReady_Wide_Pre) begin
			$display("Lose DRAM read data");
			$finish;
		end
	end
	
	localparam   InBufDepth = 6,
                OutInitLat = 30,
                OutBandWidth = 57;
	SynthesizedRandDRAM	#(	.InBufDepth(			InBufDepth),
	                        .OutInitLat(			OutInitLat),
	                        .OutBandWidth(			OutBandWidth),
                            .UWidth(				64),
                            .AWidth(				DDRAWidth),
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
                            
                            .DataIn(				DDR3SDRAM_WriteData_Wide),
                            .DataInMask(			DDR3SDRAM_WriteMask), // TODO: this may get mis-aligned because of the shifters, but we won't change it anyway
                            .DataInValid(			DDR3SDRAM_WriteValid_Wide),
                            .DataInReady(			DDR3SDRAM_WriteReady_Wide),
                            
                            .DataOut(				DDR3SDRAM_ReadData_Wide_Pre),
                            .DataOutValid(			DDR3SDRAM_ReadValid_Wide_Pre),
                            .DataOutReady(			DDR3SDRAM_ReadReady_Wide_Pre));

	FIFORAM	#(				.Width(					DDRDWidth),
							.Buffering(				1023))
		rd_data(			.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DDR3SDRAM_ReadData_Wide_Pre),
							.InValid(				DDR3SDRAM_ReadValid_Wide_Pre),
							.InAccept(				DDR3SDRAM_ReadReady_Wide_Pre),
							.OutData(				DDR3SDRAM_ReadData_Wide),
							.OutSend(				DDR3SDRAM_ReadValid_Wide),
							.OutReady(				DDR3SDRAM_ReadReady_Wide));
								
	
	localparam  				NN = 200;
	localparam					nn = 5;
	localparam					nn2 = nn * 29;	

    reg [64-1:0] CycleCount;
    initial begin
        CycleCount = 0;
		$vcdpluson;
    end
    always@(negedge Clock) begin
        CycleCount = CycleCount + 1;
    end

    assign Reset = CycleCount < 5;
  
    localparam  Freq =	200_000_000,
				FastFreq = 300_000_000;
    localparam   Cycle = 1000000000/Freq;	
    ClockSource #(Freq) ClockF200Gen(1'b1, Clock);
	ClockSource #(FastFreq) ClockF300Gen(1'b1, AESClock);

    reg [ORAML:0] GlobalPosMap [TotalNumBlock-1:0];
    reg  [31:0] TestCount;
    reg [ORAMU-1:0] AddrRand;
	
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

	integer i; 
	task Handle_ProgStore;
		begin
			#(Cycle);
			#(Cycle / 2.0) DataInValid <= 1;
			for (i = 0; i < FEORAMBChunks; i = i + 1) begin
				DataIn = AddrIn + i;
				while (!DataInReady)  #(Cycle);
				#(Cycle);
			end
			DataInValid <= 0;
		end
	endtask
    
	reg Checking_ProgData;
	reg [ORAMB-1:0] ReceivedData;
	wire [ORAMB-1:0] ExpectedReadData;

    genvar g;
	generate for (g = 0; g < FEORAMBChunks; g = g + 1) begin:foo
		assign	ExpectedReadData[(g+1)*FEDWidth-1:g*FEDWidth] = AddrIn + g;
	end endgenerate

	task Check_ProgData;
		begin
			Checking_ProgData <= 1;
			ReceivedData = 0;
			for (i = 0; i < FEORAMBChunks; i = i + 1) begin
				while (!ReturnDataReady || !ReturnDataValid)  #(Cycle);
				ReceivedData <= {ReturnData, ReceivedData[ORAMB-1:FEDWidth]};
				#(Cycle);
			end

			if (ExpectedReadData != ReceivedData) begin
				$display("Received data does not match for Block %d, %x != %x", AddrIn, ReceivedData, ExpectedReadData);
				$finish;
			end
			Checking_ProgData <= 0;
		end
	endtask

	wire [1:0] Op;
	wire  Exist;

	assign Exist = GlobalPosMap[AddrRand][ORAML];
	assign Op = Exist ? {GlobalPosMap[AddrRand][0], 1'b0} : 2'b00;
	//assign	Op = {TestCount[0], 1'b0};
	
	initial begin
		TestCount <= 0;
		CmdInValid <= 0;
		DataInValid <= 0;
		ReturnDataReady <= 1;   
		AddrRand <= 0;
		Checking_ProgData <= 0;

		for (i = 0; i < TotalNumBlock; i=i+1) begin
			GlobalPosMap[i][ORAML] <= 0;
		end
	end

    always @(posedge Clock) begin
        if (!Reset && CmdInReady) begin
            if (TestCount < 2 * NN) begin
                #(Cycle * 100);       
                Task_StartORAMAccess(Op, AddrRand);
                #(Cycle);		
				TestCount <= TestCount + 1;
				AddrRand <=  TestCount;//((TestCount+1) / nn2) * nn + (TestCount+1) % nn;	   
                	   
				if (AddrRand > NumValidBlock)
					$finish;   
            end
            else begin
                $display("ALL TESTS PASSED!");
                $finish;
				$vcdplusclose;
            end
        end
    end
   
    wire WriteCmd;
	assign WriteCmd = CmdIn == BECMD_Append || CmdIn == BECMD_Update;
   
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
       
endmodule
