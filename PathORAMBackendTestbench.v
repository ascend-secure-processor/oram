
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale		1 ns/1 ps		// Display things in ns, compute them in ps

//==============================================================================
//	Module:		PathORAMBackendTestbench
//==============================================================================
module	PathORAMBackendTestbench;

	//--------------------------------------------------------------------------
	//	Constants & overrides
	//--------------------------------------------------------------------------

	parameter					ORAMB =				512,
								ORAMU =				32,
								ORAML =				10,
								ORAMZ =				5;

	parameter					FEDWidth =			64,
								BEDWidth =			128;										
								
	parameter 					DDR_nCK_PER_CLK = 	4,
								DDRDQWidth =		64,
								DDRCWidth =			3,
								DDRAWidth =			`log2(ORAMB * (ORAMZ + 1)) + ORAML + 1;
								
	parameter					StashCapacity =		100;
	
	parameter					IVEntropyWidth =	64;
	
	`include "BucketLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	
	localparam					Freq =				100_000_000,
								Cycle = 			1000000000/Freq;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire 						Clock;
	reg							Reset; 

	// Frontend interface
	
	reg		[BECMDWidth-1:0] 	Command;
	reg		[ORAMU-1:0]			PAddr;
	reg		[ORAML-1:0]			CurrentLeaf;
	reg		[ORAML-1:0]			RemappedLeaf;
	reg							CommandValid;
	wire						CommandReady;
	
	wire	[FEDWidth-1:0]		LoadData;
	wire						LoadValid;
	reg							LoadReady;
	wire	[FEDWidth-1:0]		StoreData;
	reg 						StoreValid;
	wire						StoreReady;
	
	// DRAM interface
	
	wire	[DDRCWidth-1:0]		DRAM_Command;
	wire	[DDRAWidth-1:0]		DRAM_Address;
	wire	[DDRDWidth-1:0]		DRAM_WriteData, DRAM_ReadData; 
	wire	[DDRMWidth-1:0]		DRAM_WriteMask;
	wire						DRAM_CommandValid, DRAM_CommandReady;
	wire						DRAM_WriteDataValid, DRAM_WriteDataReady;
	wire						DRAM_ReadDataValid;	
	
	integer						TestID;
	
	//--------------------------------------------------------------------------
	//	Clock Source
	//--------------------------------------------------------------------------
	
	ClockSource #(Freq) ClockF200Gen(.Enable(1'b1), .Clock(Clock));

	//--------------------------------------------------------------------------
	//	Tasks
	//--------------------------------------------------------------------------	

	task TASK_BigTest;
		input [31:0] num;
		begin
		$display("\n\n[%m @ %t] Starting big test %d \n\n", $time, num);
		end
	endtask
	
	task TASK_Command;
		input	[BECMDWidth-1:0] 	In_Command;
		input	[ORAMU-1:0]			In_PAddr;
		input	[ORAML-1:0]			In_CurrentLeaf;
		input	[ORAML-1:0]			In_RemappedLeaf;
		
		begin
			CommandValid = 1'b1;
			Command = In_Command;
			CurrentLeaf = In_CurrentLeaf;
			RemappedLeaf = In_RemappedLeaf;
			PAddr = In_PAddr;
			
			while (~CommandReady) #(Cycle);
			#(Cycle);
			
			CommandValid = 1'b0;
		end
	endtask	
	
	task TASK_Data;
		integer i;
		begin
			i = 0;
			StoreValid = 1'b1;
			
			while (i < (FEORAMBChunks - 1)) begin
				#(Cycle);
				if (StoreValid & StoreReady) begin
					i = i + 1;
				end
			end
			#(Cycle);
			
			StoreValid = 1'b0;
		end
	endtask

	Counter		#(			.Width(					FEDWidth))
				DataGen(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				StoreValid & StoreReady),
							.In(					{FEDWidth{1'bx}}),
							.Count(					StoreData));
	
	task TASK_CheckLoad;
		input	[BEDWidth-1:0] BaseData;

		reg		[BEDWidth-1:0] Data;
		integer Done;
		integer Chunks;
		begin
			Done = 0;
			Chunks = 0;
			Data = BaseData;
			while (Done == 0) begin
				if (LoadValid & LoadReady) begin
					if (LoadData !== Data) begin
						$display("FAIL: Load data %d, expected %d", LoadData, Data);
						$stop;
					end
					Chunks = Chunks + 1;
					if (Chunks == BlkSize_FEDChunks) begin
						Done = 1;
					end
					Data = Data + 1;
				end
				#(Cycle);
			end
			$display("PASS: Test %d (load, data start=%d)", TestID, BaseData);
			TestID = TestID + 1;
		end
	endtask	
	
	//--------------------------------------------------------------------------
	//	Test Stimulus	
	//--------------------------------------------------------------------------

	integer i;
	integer TestLaunchLD;
	integer TestsPASSED, CommandsPASSED;
	
	initial begin
		TestLaunchLD = 0;
		TestsPASSED = 0;
		CommandsPASSED = 0;
	
		CurrentLeaf = {ORAML{1'b1}};
		CommandValid = 1'b0;
		StoreValid = 1'b0;
		LoadReady = 1'b1;
		
		Reset = 1'b1;
		#(Cycle);
		Reset = 1'b0;
		
		//----------------------------------------------------------------------
		//	Test 1: Append
		//----------------------------------------------------------------------	

		// Append until stash is full and force background evictions
		
		TASK_BigTest(0);
		
		i = 0;
		while (i < StashCapacity) begin
			TASK_Command(BECMD_Append, i, {ORAML{1'bx}}, i);
			TASK_Data();
			i = i + 1;
		end
		
		// If it gets past this point, it means we didn't deadlock :-)
		
		//----------------------------------------------------------------------
		//	Test 2: Read
		//----------------------------------------------------------------------
		
		// Read all blocks previously appended and remap them to different leaves
		
		i = 0;
		while (i < StashCapacity) begin
			TASK_BigTest(1 + TestLaunchLD);
			TestLaunchLD = TestLaunchLD + 1;
			//						 paddr	current leaf 	remap leaf
			TASK_Command(BECMD_Read, i, 	i, 				StashCapacity + i);
			i = i + 1;
		end
		
		//----------------------------------------------------------------------
		//	Test 3: Read/Remove
		//----------------------------------------------------------------------

		//----------------------------------------------------------------------
		//	Test 4: Update
		//----------------------------------------------------------------------	

		#(Cycle*1000);
		$display("*** ALL COMMANDS COMPLETED ***");
		CommandsPASSED = 1;
	end
	
	//--------------------------------------------------------------------------
	//	Test checks
	//--------------------------------------------------------------------------
	
	integer j;
	
	initial begin
		TestID = 0;
	
		// big test 2
		j = 0;
		while (j < StashCapacity) begin
			TASK_CheckLoad(j * BlkSize_FEDChunks);
			j = j + 1;
		end
		
		#(Cycle*1000);
		$display("*** ALL TESTS PASSED ***");
		TestsPASSED = 1;
	end
	
	always @(posedge Clock) begin
		if ((TestsPASSED == 1) & (CommandsPASSED == 1)) begin
			#(Cycle*1000);
			$display("*** TESTBENCH COMPLETED & PASSED ***");
			$stop;
		end
	end
	
	//--------------------------------------------------------------------------
	//	CUT
	//--------------------------------------------------------------------------
	
	PathORAMBackend #(		.StashCapacity(			StashCapacity),					
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
				CUT(		.Clock(					Clock),
							.Reset(					Reset),			
							.Command(				Command),
							.PAddr(					PAddr),
							.CurrentLeaf(			CurrentLeaf),
							.RemappedLeaf(			RemappedLeaf),
							.CommandValid(			CommandValid),
							.CommandReady(			CommandReady),
							.LoadData(				LoadData),
							.LoadValid(				LoadValid),
							.LoadReady(				LoadReady),
							.StoreData(				StoreData),
							.StoreValid(			StoreValid),
							.StoreReady(			StoreReady),
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
		
	//--------------------------------------------------------------------------
	
endmodule
//------------------------------------------------------------------------------
