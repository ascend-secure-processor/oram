
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale		1 ns/1 ps		// Display things in ns, compute them in ps

//==============================================================================
//	Module:		PathORAMBackendTestbench
//	Desc:		If the tests all pass, the following should print out:
//
//				*** TESTBENCH COMPLETED & PASSED ***
//
//				If they don't, try running for longer (4000 us) before debugging
//==============================================================================
module	PathORAMBackendTestbench;

	`ifndef SIMULATION
	initial begin
		$display("[%m @ %t] ERROR: set SIMULATION macro", $time);
		$finish;
	end
	`endif

	//--------------------------------------------------------------------------
	//	Constants & overrides
	//--------------------------------------------------------------------------

	parameter				ORAMB =				512,
							ORAMU =				32,
							ORAML =				10,
							ORAMZ =				5,
							ORAMC =				10,
							ORAME =				5;

	parameter				FEDWidth =			64,
							BEDWidth =			512;

	parameter				Overclock =			1;
	parameter				EnableAES =			1;
	parameter				EnableREW =			0; // don't change this for this testbench
	
	parameter 				DDR_nCK_PER_CLK = 	4,
							DDRDQWidth =		64,
							DDRCWidth =			3,
							DDRAWidth =			`log2(ORAMB * (ORAMZ + 1)) + ORAML + 1;

	parameter				IVEntropyWidth =	64;
	
	`include "StashLocal.vh"
	`include "BucketLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	
	localparam				Freq =				100_000_000,
							Cycle = 			1000000000/Freq;
	
	localparam				UpdateINIT =		10000;
	
	localparam				NumTests =			25; // Set to 100 for a long test
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire 					Clock;
	reg						Reset; 

	reg						ResetDataCounter;
	reg						AllowBlockNotFound;
	reg						BoostStoreData;
	
	// Frontend interface
	
	reg		[BECMDWidth-1:0] Command;
	reg		[ORAMU-1:0]		PAddr;
	reg		[ORAML-1:0]		CurrentLeaf;
	reg		[ORAML-1:0]		RemappedLeaf;
	reg						CommandValid;
	wire					CommandReady;
	
	wire	[FEDWidth-1:0]	LoadData;
	wire					LoadValid;
	reg						LoadReady;
	wire	[FEDWidth-1:0]	StoreData_Pre, StoreData;
	reg 					StoreValid;
	wire					StoreReady;
	
	// AES

    wire 	[DDRDWidth-1:0]	AES_DRAMWriteData, AES_DRAMReadData;
    wire					AES_DRAMWriteDataValid, AES_DRAMWriteDataReady;
    wire					AES_DRAMReadDataValid, AES_DRAMReadDataReady;
	
	wire					DRAMInitComplete;
	
	// DRAM interface
	
	wire	[DDRCWidth-1:0]	DRAM_Command;
	wire	[DDRAWidth-1:0]	DRAM_Address;
	wire	[DDRDWidth-1:0]	DRAM_WriteData, DRAM_ReadData; 
	wire	[DDRMWidth-1:0]	DRAM_WriteMask;
	wire					DRAM_CommandValid, DRAM_CommandReady;
	wire					DRAM_WriteDataValid, DRAM_WriteDataReady;
	wire					DRAM_ReadDataValid;
	
	wire					PathBuffer_OutValid, PathBuffer_OutReady;
	wire	[DDRDWidth-1:0]	PathBuffer_OutData;		
	
	integer					TestID;
	
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
	
	task TASK_Test;
		input [31:0] num;
		begin
		$display("\n[%m @ %t] Starting task %d \n", $time, num);
		end
	endtask
	
	task TASK_WaitForRealAccess;
		input [31:0] num;
		begin
			while (RealAccessCount < num) #(Cycle);
			#(Cycle);	
		end
	endtask
	
	task TASK_ResetDataCounter;
		begin
			ResetDataCounter = 1'b1;
			#(Cycle);
			ResetDataCounter = 1'b0;
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
							.Reset(					Reset | ResetDataCounter),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				StoreValid & StoreReady),
							.In(					{FEDWidth{1'bx}}),
							.Count(					StoreData_Pre));
	
	assign	StoreData =								((BoostStoreData) ? UpdateINIT : 0) + StoreData_Pre;
	
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
						$finish;
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
	integer	RealAccessCount;
	
	initial begin
		TestLaunchLD = 0;
		
		TestsPASSED = 0;
		CommandsPASSED = 0;
	
		CurrentLeaf = {ORAML{1'b1}};
		CommandValid = 1'b0;
		StoreValid = 1'b0;
		LoadReady = 1'b1;
		ResetDataCounter = 1'b0;
		
		BoostStoreData = 0;
		AllowBlockNotFound = 0;
		
		Reset = 1'b1;
		#(Cycle);
		Reset = 1'b0;
		
		//----------------------------------------------------------------------
		//	Test 0: Append
		//----------------------------------------------------------------------	

		// Append until stash is full and force background evictions
		
		TASK_BigTest(0); // tasks 0-99
		
		i = 0;
		while (i < NumTests) begin
			TASK_Test(TestLaunchLD);
			TestLaunchLD = TestLaunchLD + 1;

			TASK_Command(BECMD_Append, i, {ORAML{1'bx}}, i);
			TASK_Data();
			i = i + 1;
		end
		
		// If it gets past this point, it means we didn't deadlock :-)
		
		//----------------------------------------------------------------------
		//	Test 1-2: Reads
		//----------------------------------------------------------------------
		
		TASK_BigTest(1); // tasks 100-199
		
		// Read all blocks previously appended and remap them to different leaves
		
		i = 0;
		while (i < NumTests) begin
			TASK_Test(TestLaunchLD);
			TestLaunchLD = TestLaunchLD + 1;
			//						 paddr	current leaf 	remap leaf
			TASK_Command(BECMD_Read, i, 	i, 				NumTests + i);
			i = i + 1;
		end
		
		TASK_BigTest(2); // tasks 200-299
		
		// Do the same test again to make sure
		// a.) the blocks got remapped correctly
		// b.) they are still in ORAM (i.e., not ReadRmv'ed)
		i = 0;
		while (i < NumTests) begin
			TASK_Test(TestLaunchLD);
			TestLaunchLD = TestLaunchLD + 1;
			//						 	paddr	current leaf 		remap leaf
			TASK_Command(BECMD_Read, 	i, 		NumTests + i, 	2 * NumTests + i);
			i = i + 1;
		end		
		
		//----------------------------------------------------------------------
		//	Test 3-4: Read/Remove
		//----------------------------------------------------------------------

		// Look for those same blocks again and remove them
		// Tests that blocks were correctly remapped during last test
		
		TASK_BigTest(3); // tasks 300-399
		
		i = 0;
		while (i < NumTests) begin
			TASK_Test(TestLaunchLD);
			TestLaunchLD = TestLaunchLD + 1;
			//						 	paddr	current leaf 			remap leaf
			// NOTE: remap leaf is really XX here, but we want to test a common bug 
			// in the next wave of read/rm
			TASK_Command(BECMD_ReadRmv, i, 		2 * NumTests + i, 	3 * NumTests + i);
			i = i + 1;
		end
		
		TASK_WaitForRealAccess(3 * NumTests);
		AllowBlockNotFound = 1;
	
		// Try removing the blocks again (we should get errors saying the blocks 
		// aren't there)
	
		TASK_BigTest(4); // tasks 400-499
			
		i = 0;
		while (i < NumTests) begin
			TASK_Test(TestLaunchLD);
			TestLaunchLD = TestLaunchLD + 1;
			//						 	paddr	current leaf 			remap leaf
			TASK_Command(BECMD_ReadRmv, i, 		3 * NumTests + i, 		{ORAML{1'bx}});
			i = i + 1;
		end
		
		TASK_WaitForRealAccess(4 * NumTests);
		AllowBlockNotFound = 0;
		
		//----------------------------------------------------------------------
		//	Test 5: Update test
		//----------------------------------------------------------------------	

		TASK_BigTest(5);
		TASK_ResetDataCounter();
		
		i = 0;
		while (i < 10) begin
			TASK_Test(TestLaunchLD);
			TestLaunchLD = TestLaunchLD + 1;

			TASK_Command(BECMD_Append, i, {ORAML{1'bx}}, i);
			TASK_Data();
			i = i + 1;
		end
		
		TASK_ResetDataCounter();
		BoostStoreData = 1;
		
		i = 0;
		while (i < 10) begin
			TASK_Test(TestLaunchLD);
			TestLaunchLD = TestLaunchLD + 1;
			//						 	paddr	current leaf 	remap leaf
			TASK_Command(BECMD_Update, 	i, 		i, 				NumTests + i);
			#(Cycle * (1 << i)); // wait a while to present the data --- we should stall
			TASK_Data();
			i = i + 1;
		end
		
		i = 0;
		while (i < 10) begin
			TASK_Test(TestLaunchLD);
			TestLaunchLD = TestLaunchLD + 1;
			//						 	paddr	current leaf 		remap leaf
			TASK_Command(BECMD_Read, 	i, 		NumTests + i, 	2 * NumTests + i);
			i = i + 1;
		end
		
		//----------------------------------------------------------------------
		//	Test 4: Combination test
		//----------------------------------------------------------------------	

		// do different types of accesses to random leaves/etc
		
		//----------------------------------------------------------------------
		//	Test: background eviction on normal access
		//	Test: make sure that writing the same data twice doesn't cause us to read stale data
		//----------------------------------------------------------------------	
		
		#(Cycle*1000);
		$display("** All commands completed **");
		CommandsPASSED = 1;
	end
	
	//--------------------------------------------------------------------------
	//	Test checks
	//--------------------------------------------------------------------------
	
	integer j;
	
	initial begin
		TestID = 0;
	
		// big test 2-3
		j = 0;
		while (j < NumTests) begin
			TASK_CheckLoad(j * BlkSize_FEDChunks);
			j = j + 1;
		end
		j = 0;
		while (j < NumTests) begin
			TASK_CheckLoad(j * BlkSize_FEDChunks);
			j = j + 1;
		end
		
		// big test 4-5
		j = 0;
		while (j < NumTests) begin
			TASK_CheckLoad(j * BlkSize_FEDChunks);
			j = j + 1;
		end
		
		// big test 6
		j = 0;
		while (j < 10) begin
			TASK_CheckLoad(UpdateINIT + j * BlkSize_FEDChunks);
			j = j + 1;
		end
		
		#(Cycle*1000);
		$display("** All tests passed **");
		TestsPASSED = 1;
	end
	
	always @(posedge Clock) begin
		if (Reset)
			RealAccessCount <= 0;
		else if (CUT.OperationComplete & ~CUT.AccessIsDummy)
			RealAccessCount <= RealAccessCount + 1;
			
		if ((AllowBlockNotFound == 1) & 
			~CUT.stash.BlockNotFound & CUT.stash.BlockNotFoundValid) begin
			$display("[%m @ %t] ERROR: we found a block (in the stash) when we shouldn't have", $time);
			$finish;
		end
		if ((AllowBlockNotFound != 1) & 
			CUT.stash.BlockNotFound & CUT.stash.BlockNotFoundValid) begin
			$display("[%m @ %t] ERROR: we didn't find the block (in the stash) that we were looking for", $time);
			$finish;
		end

		if ((TestsPASSED == 1) & (CommandsPASSED == 1)) begin
			#(Cycle*1000);
			$display("*** TESTBENCH COMPLETED & PASSED ***");
			$finish;
		end
	end
	
	//--------------------------------------------------------------------------
	//	CUT
	//--------------------------------------------------------------------------
	
	PathORAMBackend #(		.StopOnBlockNotFound(	0),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.Overclock(				Overclock),
							.EnableREW(				EnableREW),
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

							.DRAMReadData(			AES_DRAMReadData),
							.DRAMReadDataValid(		AES_DRAMReadDataValid),
							.DRAMReadDataReady(		AES_DRAMReadDataReady),						

							.DRAMWriteData(			AES_DRAMWriteData),
							.DRAMWriteDataValid(	AES_DRAMWriteDataValid),
							.DRAMWriteDataReady(	AES_DRAMWriteDataReady),
							
							.DRAMInitComplete(		DRAMInitComplete));
	
	//--------------------------------------------------------------------------
	// AES
	//--------------------------------------------------------------------------
	
	generate if (EnableAES) begin:AES
		AESPathORAM #(		.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.Overclock(				Overclock),
							.EnableREW(				EnableREW),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
				aes(		.Clock(					Clock),
							.Reset(					Reset),

							.MIGOut(				DRAM_WriteData),
							.MIGOutValid(			DRAM_WriteDataValid),
							.MIGOutReady(			DRAM_WriteDataReady),

							.MIGIn(					DRAM_ReadData),
							.MIGInValid(			DRAM_ReadDataValid),
							.MIGInReady(			PathBuffer_OutReady),
							
							.BackendRData(			AES_DRAMReadData),
							.BackendRValid(			AES_DRAMReadDataValid),
							.BackendRReady(			AES_DRAMReadDataReady),
							
							.BackendWData(			AES_DRAMWriteData),
							.BackendWValid(			AES_DRAMWriteDataValid),
							.BackendWReady(			AES_DRAMWriteDataReady),

							.DRAMInitDone(			DRAMInitComplete));
	end else begin:NO_AES
		assign	DRAM_WriteData = 					AES_DRAMWriteData;
		assign	DRAM_WriteDataValid =				AES_DRAMWriteDataValid;
		assign	AES_DRAMWriteDataReady =			DRAM_WriteDataReady;
	
		assign	AES_DRAMReadData =					PathBuffer_OutData;
		assign	AES_DRAMReadDataValid =				PathBuffer_OutValid;
		assign	PathBuffer_OutReady = 				AES_DRAMReadDataReady;
	end endgenerate
	
	assign	DRAM_WriteMask =						{DDRMWidth{1'b0}};

	//--------------------------------------------------------------------------
	//	Path Buffer
	//--------------------------------------------------------------------------
	
	FIFORAM	#(				.Width(					DDRDWidth),
							.Buffering(				PathSize_DRBursts))
				in_P_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAM_ReadData),
							.InValid(				DRAM_ReadDataValid),
							.OutData(				PathBuffer_OutData),
							.OutSend(				PathBuffer_OutValid),
							.OutReady(				PathBuffer_OutReady));	
	
	//--------------------------------------------------------------------------
	//	DDR -> BRAM (to make simulation faster)
	//--------------------------------------------------------------------------
	
	SynthesizedRandDRAM	#(	.InBufDepth(			36),
							.UWidth(				8),
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
