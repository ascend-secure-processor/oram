`include "Const.vh"

module testUORAM;
	
	`include "PathORAM.vh"
	`include "UORAM.vh"
	
	`include "DMLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "CommandsLocal.vh"
	`include "BucketLocal.vh" 
	`include "PLBLocal.vh" 
	
    wire 						Clock; 
    wire 						Reset; 
    reg  						CmdInValid, DataInValid, ReturnDataReady;
    wire 						CmdInReady, DataInReady, ReturnDataValid;
    reg [1:0] 					CmdIn;
    reg [ORAMU-1:0] 			AddrIn;
	reg [DMWidth-1:0]			WMaskIn;
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
	
	wire						DDR3SDRAM_CommandValid, DDR3SDRAM_CommandReady;
	wire						DDR3SDRAM_WriteValid, DDR3SDRAM_WriteReady;
	wire						DDR3SDRAM_ReadValid;

	//--------------------------------------------------------------------------
	//	CUT
	//--------------------------------------------------------------------------
	
   TinyORAMASICWrap ORAM(	.Clock(					Clock),
                            .Reset(					Reset),
                            
                            // interface with network			
                            .Cmd(				    CmdIn),
                            .PAddr(					AddrIn),
							.WMask(					WMaskIn),
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
                            .DRAMWriteDataReady(	DDR3SDRAM_WriteReady),
							
							.Mode_TrafficGen(		1'b1));
					
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	DDR -> BRAM (to make simulation faster)
	//--------------------------------------------------------------------------
	
	// These FIFOs must be reversed; the stash assumes this.
	// It is cleaner and also makes more sense since IV/seed comes first now
   
	FIFOShiftRound #(		.IWidth(				DDRDWidth),
							.OWidth(				BEDWidth),
							.Reverse(				1))
				in_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DDR3SDRAM_ReadData_Wide),
							.InValid(				DDR3SDRAM_ReadValid_Wide),
							.InAccept(				DDR3SDRAM_ReadReady_Wide),
							.OutData(				DDR3SDRAM_ReadData),
							.OutValid(				DDR3SDRAM_ReadValid),
							.OutReady(				1'b1));
							
	FIFOShiftRound #(		.IWidth(				BEDWidth),
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

	always @(posedge Clock) begin
		if (DDR3SDRAM_Command == DDR3CMD_Write && DDR3SDRAM_CommandValid && DDR3SDRAM_CommandReady) begin
			//$display("[%m @ %t] Write DRAM[%x]", $time, DDR3SDRAM_Address);
		end
	
		if (DDR3SDRAM_WriteValid_Wide & DDR3SDRAM_WriteReady_Wide) begin
			//$display("[%m @ %t] Write DRAM:    		%x", $time, DDR3SDRAM_WriteData_Wide);
		end
		
		if (DDR3SDRAM_ReadValid_Wide & DDR3SDRAM_ReadReady_Wide) begin
			//$display("[%m @ %t] Read DRAM[%x]:     %x", $time, DRAMReadAddr, DDR3SDRAM_ReadData_Wide);
		end
		
		if (DDR3SDRAM_ReadValid_Wide_Pre && !DDR3SDRAM_ReadReady_Wide_Pre) begin
			$display("Lose DRAM read data");
			$finish;
		end
	end
	
	localparam				InBufDepth = 6,
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
                            .DataInMask(			8'h00), // TODO: this may get mis-aligned because of the shifters, but we won't change it anyway
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
							
	//--------------------------------------------------------------------------
	//	Stimulus
	//--------------------------------------------------------------------------
							
	`ifdef GATE_SIM_POWER
	localparam  				NN = 15; // so slow ... run for a few accesses only
	`else
	localparam  				NN = 200;
	`endif
	
	localparam					nn = 10;
	localparam					nn2 = nn * 50;
	localparam 					TestsPerMaskRound = 3;
	
	`ifdef GATE_SIM_POWER

	// WARNING: even with localparam real, clock freqs like 950MHz will cause Cycle to not be precise
	// Note: we only care about this high freq to better estimate power
	
	localparam  real 	Freq = 950_000_000;  

	`else 

	// TODO: known issue; design doesn't work with Freq = 1 GHz (why?)
	
	localparam  real 	Freq = 200_000_000;

	`endif
  
    localparam  real 	Cycle = 1000000000/Freq;
    ClockSource #(Freq) ClockGen(1'b1, Clock);

	localparam CWidth = 5;

    reg [64-1:0] CycleCount;

	
	
    always@(negedge Clock) begin
        CycleCount = CycleCount + 1;
    end

    assign Reset = CycleCount < 5;
  	
    reg [ORAML:0] GlobalPosMap [TotalNumBlock-1:0];
	reg [CWidth:0] GlobalAccessCountTrack [TotalNumBlock-1:0] [FEORAMBChunks:0]; // we use GlobalAccessCountTrack[...][FEORAMBChunks] to keep track of the access count for the block
	
    reg  [31:0] TestCount;
    reg [ORAMU-1:0] AddrRand;
		
	integer i, j;

	reg Checking_ProgData;
	reg [FEDWidth-1:0] ActualReadData, ExpectedReadData;
	
	initial begin
		TestCount = 0;
		CmdInValid = 0;
		DataInValid = 0;
		ReturnDataReady = 1;   
		AddrRand = 0;
		Checking_ProgData = 0;
        CycleCount = 0;
		
		`ifdef GATE_SIM_POWER $vcdpluson; `endif	
		
		for (i = 0; i < TotalNumBlock; i=i+1) begin
			GlobalPosMap[i][ORAML] <= 0;
			for (j = 0; j <= FEORAMBChunks; j=j+1) begin
				GlobalAccessCountTrack[i][j] <= 0;
			end
		end
	end	
	
    task Task_StartORAMAccess;
        input [1:0] cmd;
        input [ORAMU-1:0] addr;
		integer MaskNo;
        begin
            CmdInValid = 1;
            CmdIn = cmd;
            AddrIn = addr;
			
			MaskNo = GlobalAccessCountTrack[AddrIn][FEORAMBChunks] / TestsPerMaskRound;
			
			// test some interesting cases
			// note: to save time, we only test 0*1+0* patterns; further we only test FEDWidth chunks to save memory
			case (MaskNo)
				0 : WMaskIn = 64'hffffffffffffffff;
				1 : WMaskIn = 64'h0000000000000000;
				2 : WMaskIn = 64'h00000000000000ff;
				3 : WMaskIn = 64'h000000000000ff00;
				4 : WMaskIn = 64'h0000000000ffff00;
				5 : WMaskIn = 64'hff00000000000000;
				default : 
					WMaskIn = 64'hffffffffffffffff;
			endcase
			
            $display("[t = %d] UORAM Start Access %d: %s Block %d Mask 0x%x",
                CycleCount, TestCount,
                cmd == 0 ? "Update" : cmd == 1 ? "Append" : cmd == 2 ? "Read" : "ReadRmv",
                addr, 
				WMaskIn);
            #(Cycle) 
			CmdInValid = 0;
			if (CmdIn == BECMD_Append || CmdIn == BECMD_Update) Handle_ProgStore;
        end
    endtask

	task Handle_ProgStore;
		reg [FEDWidth/2 - 1:0] LowHalf, HighHalf;
		reg ElseTaken;
		reg [FEDWidth/8-1:0] MaskChunk;
		reg [DMWidth-1:0] WMaskInTemp;
		begin
			#(Cycle);
			DataInValid = 1;
			WMaskInTemp = WMaskIn;
			for (i = 0; i < FEORAMBChunks; i = i + 1) begin
				LowHalf = AddrIn + i;
				
				MaskChunk = WMaskInTemp[FEDWidth/8-1:0];
				WMaskInTemp = { {FEDWidth/8{1'bx}}, WMaskInTemp[DMWidth-1:FEDWidth/8] };
				
				if (&MaskChunk) begin
					GlobalAccessCountTrack[AddrIn][i] = GlobalAccessCountTrack[AddrIn][i] + 1;
					HighHalf = GlobalAccessCountTrack[AddrIn][i];
					ElseTaken = 1'b0;
				end else begin
					ElseTaken = 1'b1;
					HighHalf = $random; // put some bogus crap there
				end
				
				DataIn = {HighHalf, LowHalf};
				
				$display("[t = %d] UORAM store data 0x%x", CycleCount, DataIn);
				
				while (!DataInReady)  #(Cycle);
				#(Cycle);
			end
			DataInValid = 0;
		end
	endtask

	task Check_ProgData;
		reg [FEDWidth/2 - 1:0] LowHalf_Actual, HighHalf_Actual, LowHalf_Expected, HighHalf_Expected;
		
		begin
			Checking_ProgData <= 1;
			for (i = 0; i < FEORAMBChunks; i = i + 1) begin
				while (!ReturnDataReady || !ReturnDataValid)  #(Cycle);

				LowHalf_Actual = ReturnData[FEDWidth/2-1:0];
				HighHalf_Actual = ReturnData[FEDWidth-1:FEDWidth/2];
				ActualReadData = {HighHalf_Actual, LowHalf_Actual};

				LowHalf_Expected = AddrIn + i;
				HighHalf_Expected = GlobalAccessCountTrack[AddrIn][i];
				ExpectedReadData = {HighHalf_Expected, LowHalf_Expected};
				
				if (ExpectedReadData != ActualReadData) begin
					$display("Return data mismatch for addr %d, %x != %x (actual != expected)", AddrIn, ActualReadData, ExpectedReadData);
					$finish;
				end
				#(Cycle);
			end
			
			GlobalAccessCountTrack[AddrIn][FEORAMBChunks] = GlobalAccessCountTrack[AddrIn][FEORAMBChunks] + 1;
			Checking_ProgData <= 0;
		end
	endtask

	wire [1:0] Op;
	wire  Exist;

	assign Exist = GlobalPosMap[AddrRand][ORAML];
	assign Op = Exist ? {GlobalPosMap[AddrRand][0], 1'b0} : 2'b00;

    always @(negedge Clock) begin
        if (!Reset && CmdInReady) begin
            if (TestCount < 2 * NN) begin
                Task_StartORAMAccess(Op, AddrRand);
                #(Cycle);
				TestCount <= TestCount + 1;
				AddrRand <=  ((TestCount+1) / nn2) * nn + (TestCount+1) % nn;	    
				if (AddrRand > NumValidBlock)
					$finish;   
            end
            else begin
                $display("ALL TESTS PASSED!");
                $finish;
				`ifdef GATE_SIM_POWER $vcdplusclose; `endif
            end
        end
    end

	always @(negedge Clock) begin
		if (ReturnDataValid && ReturnDataReady && !Checking_ProgData) begin
		   Check_ProgData;
		end
	end
	
`ifndef GATE_SIM_POWER
	
    task Check_Leaf;
       begin
           $display("\t[t = %d] %s Block %d, \tLeaf %d --> %d",
		   CycleCount, 
                   ORAM.core.BEnd_Cmd == 0 ? "Update" : ORAM.core.BEnd_Cmd == 1 ? "Append" : ORAM.core.BEnd_Cmd == 2 ? "Read" : "ReadRmv",
                   ORAM.core.BEnd_PAddr, ORAM.core.BEnd_Cmd == 1 ? -1 : ORAM.core.CurrentLeaf, ORAM.core.RemappedLeaf);
               
           if (ORAM.core.BEnd_Cmd == BECMD_Append) begin
               if (GlobalPosMap[ORAM.core.BEnd_PAddr][ORAML]) begin
                   $display("Error: appending existing Block %d", ORAM.core.BEnd_PAddr);
                   $finish;
               end
           end
           else if (GlobalPosMap[ORAM.core.BEnd_PAddr][ORAML] == 0) begin
               $display("Error: requesting non-existing Block %d", ORAM.core.BEnd_PAddr);
               $finish;               
           end
           else if (GlobalPosMap[ORAM.core.BEnd_PAddr][ORAML-1:0] != ORAM.core.CurrentLeaf) begin
               $display("Error: leaf label does not match, should be %d, %d provided", GlobalPosMap[ORAM.core.BEnd_PAddr][ORAML-1:0], ORAM.core.CurrentLeaf);
               $finish;              
           end
              
           GlobalPosMap[ORAM.core.BEnd_PAddr] <= ORAM.core.BEnd_Cmd == BECMD_ReadRmv ? 0 : {1'b1, ORAM.core.RemappedLeaf};
       end 
    endtask    
	
	always @(posedge Clock) begin    
		if (ORAM.core.BEnd_CmdValid && ORAM.core.BEnd_CmdReady) begin
		   Check_Leaf;
		end
	end	
	
	`endif
		
endmodule