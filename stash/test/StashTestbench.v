
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale		1 ns/1 ps

//==============================================================================
//	Module:		StashTestbench
//	Desc:		If the tests all pass, the following should print out:
//
//				*** TESTBENCH COMPLETED & PASSED ***
//
//				If they don't, try running for longer (100 us) before debugging
//==============================================================================
module	StashTestbench;

	`ifndef SIMULATION
	initial begin
		$display("[%m @ %t] ERROR: set SIMULATION macro", $time);
		$finish;
	end
	`endif

	//--------------------------------------------------------------------------
	//	Constants & overrides
	//--------------------------------------------------------------------------

	parameter				ORAMB =					512,
							ORAMU =					32,
							ORAML =					32,
							ORAMZ =					2,
							ORAMC =					10;

	parameter				FEDWidth =				64,
							BEDWidth =				256;
		
	parameter				Overclock =				1;
							
	parameter				StashOutBuffering = 	4;
	
	`include "BucketLocal.vh"
    `include "StashLocal.vh"
    `include "PathORAMBackendLocal.vh"
	
	localparam				Freq =					100_000_000,
							Cycle = 				1_000_000_000/Freq;	
	
	localparam				UpdateINIT =			255;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire 					Clock;
	reg						Reset, ResetDataCounter; 
	wire					ResetDone;
	
	reg		[ORAML-1:0]		RemapLeaf, AccessLeaf;
	reg		[ORAMU-1:0]		AccessPAddr;
	reg						AccessIsDummy;	
	reg		[BECMDWidth-1:0]AccessCommand;
	
	reg						StartScan;
	reg						StartWriteback;		

	wire	[BEDWidth-1:0]	ReturnData;
	wire	[ORAMU-1:0]		ReturnPAddr;
	wire	[ORAML-1:0]		ReturnLeaf;
	wire					ReturnDataOutValid;
	wire					BlockReturnComplete;
	
	wire	[BEDWidth-1:0]	UpdateData, UpdateData_Pre;
	reg						UpdateDataInValid;
	wire					UpdateDataInReady;
	wire					BlockUpdateComplete;
	
	wire	[BEDWidth-1:0]	EvictData;
	wire	[ORAMU-1:0]		EvictPAddr;
	wire	[ORAML-1:0]		EvictLeaf;
	wire					EvictDataInValid;
	wire					EvictDataInReady;
	wire					BlockEvictComplete;	
	
	wire 					EvictData_HeaderValid;
	reg						EvictInValid_Reg, EvictInValidCommand_Reg;
	wire	[BEDWidth-1:0]	EvictData_Reg;
	reg		[ORAMU-1:0] 	EvictPAddr_Reg;
	reg		[ORAML-1:0] 	EvictLeaf_Reg;	

	wire 	[BEDWidth-1:0]	WriteData;
	wire	[ORAMU-1:0]		WritePAddr;
	wire	[ORAML-1:0]		WriteLeaf;
	wire					WriteInValid;
	wire					WriteInReady;	
	wire					BlockWriteComplete;
	
	wire 					WriteData_HeaderValid;
	reg						WriteInValid_Reg, WriteInValidCommand_Reg;
	wire	[BEDWidth-1:0]	WriteData_Reg;
	reg		[ORAMU-1:0] 	WritePAddr_Reg;
	reg		[ORAML-1:0] 	WriteLeaf_Reg;		
	
	wire	[BEDWidth-1:0]	ReadData;
	wire	[ORAMU-1:0]		ReadPAddr;
	wire	[ORAML-1:0]		ReadLeaf;
	wire					ReadOutValid;
	reg						ReadOutReady;	
	wire					BlockReadComplete, PathReadComplete;
	
	wire 					StashAlmostFull;
	wire					StashOverflow;
	wire	[SEAWidth-1:0]	StashOccupancy;
	
	integer					TestID;
	
	//--------------------------------------------------------------------------
	//	Clock Source
	//--------------------------------------------------------------------------
	
	ClockSource #(Freq) ClockF100Gen(.Enable(1'b1), .Clock(Clock));

	//--------------------------------------------------------------------------
	//	Tasks	
	//--------------------------------------------------------------------------

	task TASK_WaitForAccess;
		begin
			while (~PathReadComplete) #(Cycle);
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
		
	task TASK_BigTest;
		input [31:0] num;
		begin
		$display("\n\n[%m @ %t] Starting big test %d \n\n", $time, num);
		end
	endtask
	
	task TASK_TestPoint;
		input [31:0] num;
		begin
		$display("[%m @ %t] Reached tests for big test %d", $time, num);
		end
	endtask	
	
	task TASK_StartScan;
		input	[ORAML-1:0] Leaf;
		input [BECMDWidth-1:0] Cmd;
		begin
			AccessLeaf = Leaf;
			AccessCommand = Cmd;
			StartScan = 1'b1;
			#(Cycle);
			StartScan = 1'b0;
		end
	endtask
	
	task TASK_StartWriteback;
		begin
			while (WriteData_HeaderValid) #(Cycle);
			
			StartWriteback = 1'b1;
			#(Cycle);
			StartWriteback = 1'b0;
		end
	endtask
	
	Counter		#(			.Width(					BEDWidth))
				UpdateGen(	.Clock(					Clock),
							.Reset(					Reset | ResetDataCounter),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				UpdateDataInValid & UpdateDataInReady),
							.In(					{BEDWidth{1'bx}}),
							.Count(					UpdateData_Pre));
							
	assign	UpdateData =		UpdateData_Pre + UpdateINIT;						
	
	task TASK_QueueEvict;
		input	[ORAMU-1:0] PAddr;
		input	[ORAML-1:0] Leaf;
		
		integer i;
		begin
			i = 0;
			EvictInValid_Reg = 1'b1;
			EvictInValidCommand_Reg = 1'b1;
			EvictPAddr_Reg = PAddr;
			EvictLeaf_Reg = Leaf;
			while (i < BlkSize_BEDChunks) begin
				i = i + 1;
				#(Cycle);
				
				EvictInValidCommand_Reg = 1'b0;
			end
			EvictInValid_Reg = 1'b0;
			
			while (~BlockEvictComplete) #(Cycle);
			#(Cycle);
		end
	endtask
	
	Counter		#(			.Width(					BEDWidth))
				EvictGen(	.Clock(					Clock),
							.Reset(					Reset | ResetDataCounter),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				EvictInValid_Reg),
							.In(					{BEDWidth{1'bx}}),
							.Count(					EvictData_Reg));
	FIFORAM	#(				.Width(					ORAMU + ORAML),
							.Buffering(				99))
				ev_HW_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{EvictPAddr_Reg, EvictLeaf_Reg}),
							.InValid(				EvictInValidCommand_Reg),
							.OutData(				{EvictPAddr, EvictLeaf}),
							.OutSend(				EvictData_HeaderValid),
							.OutReady(				BlockEvictComplete));
	FIFORAM	#(				.Width(					BEDWidth),
							.Buffering(				99))
				ev_DW_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				EvictData_Reg),
							.InValid(				EvictInValid_Reg),
							.OutData(				EvictData),
							.OutSend(				EvictDataInValid),
							.OutReady(				EvictDataInReady));						

	task TASK_QueueWrite;
		input	[ORAMU-1:0] PAddr;
		input	[ORAML-1:0] Leaf;
		
		integer i;
		begin
			i = 0;
			WriteInValid_Reg = 1'b1;
			WriteInValidCommand_Reg = 1'b1;
			WritePAddr_Reg = PAddr;
			WriteLeaf_Reg = Leaf;
			while (i < BlkSize_BEDChunks) begin
				i = i + 1;
				#(Cycle);
				
				WriteInValidCommand_Reg = 1'b0;
			end
			WriteInValid_Reg = 1'b0;
		end
	endtask							
							
	Counter		#(			.Width(					BEDWidth))
				DataGen(	.Clock(					Clock),
							.Reset(					Reset | ResetDataCounter),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				WriteInValid_Reg),
							.In(					{BEDWidth{1'bx}}),
							.Count(					WriteData_Reg));
	FIFORAM	#(				.Width(					ORAMU + ORAML),
							.Buffering(				99))
				in_HW_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{WritePAddr_Reg, WriteLeaf_Reg}),
							.InValid(				WriteInValidCommand_Reg),
							.OutData(				{WritePAddr, WriteLeaf}),
							.OutSend(				WriteData_HeaderValid),
							.OutReady(				BlockWriteComplete));
	FIFORAM	#(				.Width(					BEDWidth),
							.Buffering(				99))
				in_DW_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				WriteData_Reg),
							.InValid(				WriteInValid_Reg),
							.OutData(				WriteData),
							.OutSend(				WriteInValid),
							.OutReady(				WriteInReady));
		
	task TASK_QueueUpdate;
		begin
			UpdateDataInValid = 1'b1;
		
			while (~BlockUpdateComplete) #(Cycle);
			#(Cycle);

			UpdateDataInValid = 1'b0;
		end
	endtask

	task TASK_CheckRead;
		input	[BEDWidth-1:0] BaseData;
		input	[ORAMU-1:0] PAddr;
		input	[ORAML-1:0] Leaf;
		
		reg		[BEDWidth-1:0] Data;
		integer done;
		begin
			done = 0;
			Data = BaseData;
			while (done == 0) begin
				if (ReadOutValid & ReadOutReady) begin
					if (ReadData !== Data) begin
						$display("FAIL: Stash read data %d, expected %d", ReadData[31:0], Data[31:0]);
						#(Cycle*4); // helps us see where the problem actually occurs ...
						$finish;
					end
					//$display("OK: Stash read data %d, expected %d", ReadData, Data);
					if (BlockReadComplete) begin
						if (ReadPAddr !== PAddr || ReadLeaf !== Leaf) begin
							$display("FAIL: Stash read {PAddr,Leaf} = {%x,%x} expected {%x,%x}", ReadPAddr, ReadLeaf, PAddr, Leaf);
							$finish;
						end
						//$display("OK: Stash read {PAddr,Leaf} = {%x,%x} expected {%x,%x}", ReadPAddr, ReadLeaf, PAddr, Leaf);
						done = 1;
					end
					Data = Data + 1;
				end
				#(Cycle);
			end
			$display("PASS: Test %d (read @ addr=%x leaf=%x, base=%d)", TestID, PAddr, Leaf, BaseData[31:0]);
			TestID = TestID + 1;
		end
	endtask	
	
	// Same as TASK_CheckRead task except for return interface
	task TASK_CheckReturn;
		input	[BEDWidth-1:0] BaseData;
		input	[ORAMU-1:0] PAddr;
		input	[ORAML-1:0] Leaf;
		
		reg		[BEDWidth-1:0] Data;
		integer done;
		begin
			done = 0;
			Data = BaseData;
			while (done == 0) begin
				if (ReturnDataOutValid /* & ReturnDataOutReady */) begin
					if (ReturnData !== Data) begin
						$display("FAIL: Stash return data %d, expected %d [expected leaf/paddr = %x,%x]", ReturnData[31:0], Data[31:0], Leaf, PAddr);
						$finish;
					end
					//$display("OK: Stash return data %d, expected %d", ReturnData, Data);
					if (BlockReturnComplete) begin
						if (ReturnPAddr !== PAddr || ReturnLeaf !== Leaf) begin
							$display("FAIL: Stash return {PAddr,Leaf} = {%x,%x} expected {%x,%x}", ReturnPAddr, ReturnLeaf, PAddr, Leaf);
							$finish;
						end
						//$display("OK: Stash return {PAddr,Leaf} = {%x,%x} expected {%x,%x}", ReturnPAddr, ReturnLeaf, PAddr, Leaf);
						done = 1;
					end
					Data = Data + 1;
				end
				#(Cycle);
			end
			$display("PASS: Test %d (return @ addr=%x leaf=%x, base=%d)", TestID, PAddr, Leaf, BaseData[31:0]);
			TestID = TestID + 1;
		end
	endtask	
	
	task TASK_CheckReadDummy;
		input	[31:0] Count;

		integer sofar;
		integer chunks;
		begin
			sofar = 0;
			chunks = 0;
			while (sofar != Count) begin
				if (ReadOutValid & ReadOutReady) begin
					chunks = chunks + 1;
					if (BlockReadComplete) begin
						if (ReadPAddr !== DummyBlockAddress) begin
							$display("FAIL: Stash read PAddr = %x, expected dummy block (saw %d out of %d)", ReadPAddr, sofar, Count);
							$finish;
						end
						if (chunks != NumChunks) begin
							$display("FAIL: Stash read dummy block, wrong block size");
							$finish;
						end
						sofar = sofar + 1;
						chunks = 0;
						//$display("OK: Test %d (seen %d dummy blocks out of %d)", TestID, sofar, Count);
					end
				end
				#(Cycle);
			end
			$display("PASS: Test %d (%d dummy reads)", TestID, Count);
			TestID = TestID + 1;
		end
	endtask	
	
	task TASK_SkipRead;
		input	[31:0] Count;

		integer sofar;
		begin
			sofar = 0;
			while (sofar != Count) begin
				if (ReadOutValid & ReadOutReady & BlockReadComplete) begin
					sofar = sofar + 1;
				end
				#(Cycle);
			end
			$display("PASS: Test %d (skipped %d / %d)", TestID, sofar, Count);
		end
	endtask
	
	task TASK_CheckOccupancy;
		input	[SEAWidth-1:0] Occupancy;
		
		begin
			if (Occupancy != StashOccupancy) begin
				$display("FAIL: Stash occupancy %d, expected %d", StashOccupancy, Occupancy);
				$finish;
			end
			if ( ((StashOccupancy + BlocksOnPath) >= StashCapacity) != StashAlmostFull ) begin
				$display("FAIL: StashAlmostFull = %b (%d >= %d)", StashAlmostFull, StashOccupancy + BlocksOnPath, StashCapacity);
				$finish;
			end
			$display("PASS: Test %d (occupancy expected = %d, Almost full? %b)", TestID, Occupancy, StashAlmostFull);
			TestID = TestID + 1;
		end
	endtask
	
	//--------------------------------------------------------------------------
	//	Test Stimulus	
	//--------------------------------------------------------------------------
	
	integer i, j;
	integer TestsPASSED, CommandsPASSED;
	integer ActivateBurstReady = 0;	
	
	always @(posedge Clock) begin
		if ((TestsPASSED == 1) & (CommandsPASSED == 1)) begin
			#(Cycle*1000);
			$display("*** TESTBENCH COMPLETED & PASSED ***");
			$finish;
		end
	end
	
	initial begin
		TestsPASSED = 0;
		CommandsPASSED = 0;
	
		Reset = 1'b1;
		ResetDataCounter = 1'b0;
		
		StartScan = 1'b0;
		StartWriteback = 1'b0;

		WriteInValid_Reg = 1'b0;
		WriteInValidCommand_Reg = 1'b0;
		
		EvictInValid_Reg = 1'b0;
		EvictInValidCommand_Reg = 1'b0;
		UpdateDataInValid = 1'b0;
		
		ReadOutReady = 1'b1;
		
		#(Cycle);
	
		Reset = 1'b0;

		AccessPAddr = 32'hdeadbeef;
		RemapLeaf = {ORAML{1'bx}};
		AccessIsDummy = 1'b1;
		AccessCommand = {BECMDWidth{1'bx}};
		
		while (~ResetDone) #(Cycle);
		#(Cycle);

		// ---------------------------------------------------------------------
		// Test 1: Basic backend test; all blocks written back
		// ---------------------------------------------------------------------
		
		TASK_BigTest(1);
		TASK_StartScan(32'h0000ffff, {BECMDWidth{1'bx}});
		
		#(Cycle*10); // will be > 10, (probably) < 100 in practice

		TASK_QueueWrite(32'hf0000000, 32'hffff0000);
		TASK_QueueWrite(32'hf0000001, 32'h0000ffff);
		TASK_QueueWrite(32'hf0000002, 32'h0000ffff);
		TASK_QueueWrite(32'hf0000003, 32'h0000ffff);
		
		TASK_StartWriteback();
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);

		// ---------------------------------------------------------------------		
		// Test 2: ""; no blocks written back
		// ---------------------------------------------------------------------

		TASK_BigTest(2);
		TASK_StartScan(32'h0000ffff, {BECMDWidth{1'bx}});

		// will be written back
		TASK_QueueWrite(32'hf0000004, 32'hffff0000);
		TASK_QueueWrite(32'hf0000005, 32'hffff0000);
		
		// won't be written back
		TASK_QueueWrite(32'hf0000006, 32'hffff0000);
		TASK_QueueWrite(32'hf0000007, 32'hffff0000);
		
		TASK_StartWriteback();
		TASK_WaitForAccess();
		TASK_CheckOccupancy(2);
				
		// ---------------------------------------------------------------------
		// Test 3: write the rest back
		// ---------------------------------------------------------------------

		TASK_BigTest(3);
		TASK_StartScan(32'h0000fff1, {BECMDWidth{1'bx}});

		TASK_StartWriteback();		
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);		

		// ---------------------------------------------------------------------
		// Test 4: Access with partial writeback, discontiguous dummy/real blocks 
		// ---------------------------------------------------------------------

		TASK_BigTest(4);
		TASK_StartScan(32'h00000000, {BECMDWidth{1'bx}});
		
		TASK_QueueWrite(32'hf000000a, 32'h00000002); // level 1
		TASK_QueueWrite(32'hf000000b, 32'h00000002); // level 1

		#(Cycle*10); // some random delay
		
		TASK_QueueWrite(32'hf000000c, 32'h00000000); // level 33
		TASK_QueueWrite(32'hf000000d, 32'h80000000); // level 32
		
		TASK_QueueWrite(32'hf0000008, 32'h00000001); // level 0
		TASK_QueueWrite(32'hf0000009, 32'h00000001); // level 0
		
		#(Cycle*20); // some random delay
		
		TASK_StartWriteback();		
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);

		// ---------------------------------------------------------------------
		// Test 5:  Load up stash and make sure the AlmostFull signal goes high
		// ---------------------------------------------------------------------

		TASK_BigTest(5);
		TASK_StartScan(32'h00000000, {BECMDWidth{1'bx}});
		
		i = 0;
		
		while (i < BlocksOnPath) begin
			// This is technically illegal (no path intersection) --- whatever
			TASK_QueueWrite(32'hf000000e + i, 32'hffffffff);
			i = i + 1;
		end

		TASK_StartWriteback();
		TASK_WaitForAccess();
		TASK_CheckOccupancy(BlocksOnPath-ORAMZ); // for root bucket

		// ---------------------------------------------------------------------
		// Test 6:  Drain the stash
		// ---------------------------------------------------------------------

		TASK_BigTest(6);
		TASK_StartScan(32'hffffffff, {BECMDWidth{1'bx}});
		TASK_StartWriteback();
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);
		
		// ---------------------------------------------------------------------
		// Test 7:  Backpressure on ReadOutReady
		// ---------------------------------------------------------------------

		TASK_ResetDataCounter();
		
		TASK_BigTest(7);
		TASK_StartScan(32'hffffffff, {BECMDWidth{1'bx}});

		TASK_QueueWrite(32'hf000000f, 32'hffffffff); // level 33
		TASK_QueueWrite(32'hf0000010, 32'hffffffff); // level 33

		TASK_QueueWrite(32'hf0000011, 32'h00000000); // level 0
		TASK_QueueWrite(32'hf0000012, 32'h00000000); // level 0
		
		TASK_QueueWrite(32'hf0000013, 32'h0000ffff); // level 16ish
		TASK_QueueWrite(32'hf0000014, 32'h0000ffff); // level 16ish
		
		ReadOutReady = 1'b0;
		TASK_StartWriteback();
		
		#(Cycle*128);
		
		// let one block go
		ReadOutReady = 1'b1;
		#(Cycle);
		ReadOutReady = 1'b0;
		
		// wreck some havoc
		ActivateBurstReady = 1;
		
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);
		
		// ---------------------------------------------------------------------
		// Test 8:  Append command (eviction interface)
		// ---------------------------------------------------------------------

		// Note: this test starts at data chunk 6 for writes
		
		TASK_BigTest(8);
		AccessCommand = BECMD_Append;
		
		TASK_QueueEvict(32'hf00000ff, 32'h00000000); // level 33
		TASK_QueueEvict(32'hf00005ff, 32'h00000002); // level 1	
		TASK_CheckOccupancy(2);
		
		TASK_StartScan(32'h00000000, {BECMDWidth{1'bx}});
		
		TASK_QueueWrite(32'hf00002ff, 32'h80000000); // level 32, data chunk 6
		TASK_QueueWrite(32'hf00003ff, 32'hffffffff); // level 0, data chunk 7
		TASK_QueueWrite(32'hf00004ff, 32'hfffffffc); // level 2, data chunk 8

		TASK_StartWriteback();
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);		
		
		// ---------------------------------------------------------------------
		// Test 9:  Read/remove command
		// ---------------------------------------------------------------------
		
		// evict block and read that block back immediately
		
		TASK_BigTest(9);
		
		TASK_ResetDataCounter();
		
		AccessPAddr = 32'hf0000000;
		AccessCommand = BECMD_Append;
		TASK_QueueEvict(AccessPAddr, 32'h00000000);
		TASK_QueueEvict(32'hf0000001, 32'hffffffff);
		TASK_QueueEvict(32'hf0000002, 32'hffffffff);
		
		AccessIsDummy = 1'b0;
		TASK_StartScan(32'h00000000, BECMD_ReadRmv);
		
		TASK_StartWriteback();
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);
		
		// ---------------------------------------------------------------------
		// Test 10:  Read/remove command (2)
		// ---------------------------------------------------------------------
				
		// evict some unrelated blocks; read a path in containing the block of 
		// interest; the block of interest _should_ get written back to ORAM if 
		// it is not removed
		
		TASK_BigTest(10);
		
		TASK_ResetDataCounter();
		
		AccessPAddr = 32'hba5eba11;
		AccessCommand = BECMD_Append;
		TASK_QueueEvict(32'hf0000000, 	32'hffffffff);
		TASK_QueueEvict(32'hf0000001, 	32'hffffffff);
		
		TASK_StartScan(	32'h00000000, 	BECMD_ReadRmv);

		TASK_QueueWrite(32'hf0000002, 	32'h00000000);
		TASK_QueueWrite(AccessPAddr, 	32'h00000000);
		TASK_QueueWrite(32'hf0000003, 	32'h00000000);
		
		TASK_StartWriteback();
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);		

		// ---------------------------------------------------------------------
		// Test 11:  Read command
		// ---------------------------------------------------------------------
						
		// evict block with leaf A into stash; read path from/to leaf A; remap 
		// block to leaf B such that leaf A & B have bad intersection.
		
		TASK_BigTest(11);
		
		TASK_ResetDataCounter();

		AccessPAddr = 32'hba5eba11;
		AccessCommand = BECMD_Append;
		// evicting this many blocks gives a good likelyhood that SOME OTHER 
		// block will be written back to root bucket
		TASK_QueueEvict(32'hf0000001, 	32'hffffffff);
		TASK_QueueEvict(32'hf0000002, 	32'hffffffff);
		TASK_QueueEvict(AccessPAddr, 	32'h00000000);
		TASK_QueueEvict(32'hf0000003, 	32'hffffffff);		
		TASK_QueueEvict(32'hf0000004, 	32'hffffffff);
		TASK_QueueEvict(32'hf0000005, 	32'hffffffff);
		
		RemapLeaf = 32'hffffffff;
		TASK_StartScan(	32'h00000000, 	BECMD_Read);
		
		TASK_QueueWrite(32'hf0000006, 	32'h00000000);
		TASK_QueueWrite(32'hf0000007, 	32'h00000000);
		
		TASK_StartWriteback();
		TASK_WaitForAccess();
		TASK_CheckOccupancy(4);	
		
		// Now drain the stash
		AccessIsDummy = 1'b1;
		TASK_StartScan(32'hffffffff, {BECMDWidth{1'bx}});
		TASK_StartWriteback();
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);
		
		// ---------------------------------------------------------------------
		// Test 12:  Write command
		// ---------------------------------------------------------------------
		
		// Test basic overwriting
		
		TASK_BigTest(12);
		
		TASK_ResetDataCounter();

		AccessPAddr = 32'hba5eba11;
		AccessCommand = BECMD_Append;
		TASK_QueueEvict(AccessPAddr, 	32'h00000000);
		
		AccessIsDummy = 1'b0;
		RemapLeaf = 32'hffffffff;
		TASK_StartScan(32'h00000000, BECMD_Update);
		TASK_StartWriteback();
		TASK_QueueUpdate();
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);
		
		// ---------------------------------------------------------------------
		
		#(Cycle*1000);
		$display("** All commands completed **");
		CommandsPASSED = 1;
	end

	//--------------------------------------------------------------------------
	//	Concurrent test stimuli
	//--------------------------------------------------------------------------

	// Irregular ReadOutReady
	// This will keep happening for future tests as well
	initial begin
		while (ActivateBurstReady == 0) #(Cycle);
		#(Cycle);
		
		// TODO put in infinite loop
		//while (1) begin
			j = 1;
			while (j < 512) begin
				ReadOutReady = 1'b0;
				#(Cycle*j);
				ReadOutReady = 1'b1;
				#(Cycle*j);
				j = j << 1;
			end
		//end
	end
	
	//--------------------------------------------------------------------------
	//	Test checks
	//--------------------------------------------------------------------------

	initial begin
		TestID = 0;

		while (~ResetDone) #(Cycle);
		#(Cycle);
		
		// big test 1
		TASK_TestPoint(1);
		TASK_CheckRead(0, 32'hf0000000, 32'hffff0000);
		TASK_CheckReadDummy(BlocksOnPath - 5);
		TASK_CheckRead(NumChunks * 3, 	32'hf0000003, 32'h0000ffff);
		TASK_CheckReadDummy(1);
		TASK_CheckRead(NumChunks * 1, 	32'hf0000001, 32'h0000ffff);
		TASK_CheckRead(NumChunks * 2, 	32'hf0000002, 32'h0000ffff);
		
		// big test 2
		TASK_TestPoint(2);
		TASK_CheckRead(NumChunks * 4, 	32'hf0000004, 32'hffff0000);
		TASK_CheckRead(NumChunks * 5, 	32'hf0000005, 32'hffff0000);
		TASK_CheckReadDummy(BlocksOnPath - 2);
		
		// big test 3
		TASK_TestPoint(3);
		TASK_CheckRead(NumChunks * 6, 	32'hf0000006, 32'hffff0000);
		TASK_CheckRead(NumChunks * 7, 	32'hf0000007, 32'hffff0000);
		TASK_CheckReadDummy(BlocksOnPath - 2);
		
		// big test 4
		TASK_TestPoint(4);
		TASK_CheckRead(NumChunks * 12, 	32'hf0000008, 32'h00000001);
		TASK_CheckRead(NumChunks * 13, 	32'hf0000009, 32'h00000001);
		TASK_CheckReadDummy(ORAMZ - 2);
		TASK_CheckRead(NumChunks * 8, 	32'hf000000a, 32'h00000002);
		TASK_CheckRead(NumChunks * 9, 	32'hf000000b, 32'h00000002);
		TASK_CheckReadDummy(ORAMZ - 2);
		TASK_CheckReadDummy(ORAMZ * 29);
		TASK_CheckRead(NumChunks * 11, 	32'hf000000d, 32'h80000000);
		TASK_CheckReadDummy(ORAMZ - 1);
		TASK_CheckRead(NumChunks * 10, 	32'hf000000c, 32'h00000000);
		TASK_CheckReadDummy(ORAMZ - 1);
		
		// big test 5
		TASK_TestPoint(5);
		TASK_CheckRead(NumChunks * 14, 	32'hf000000e, 32'hffffffff);
		TASK_CheckRead(NumChunks * 15, 	32'hf000000f, 32'hffffffff);
		TASK_CheckReadDummy(BlocksOnPath-ORAMZ);

		// big test 6
		TASK_TestPoint(6);
		TASK_CheckReadDummy(ORAMZ);
		TASK_SkipRead(BlocksOnPath-ORAMZ);
		
		// big test 7
		TASK_TestPoint(7);
		TASK_CheckRead(NumChunks * 2, 	32'hf0000011, 32'h00000000);
		TASK_CheckRead(NumChunks * 3, 	32'hf0000012, 32'h00000000);
		TASK_CheckReadDummy(ORAMZ * 15);
		TASK_CheckRead(NumChunks * 4, 	32'hf0000013, 32'h0000ffff);
		TASK_CheckRead(NumChunks * 5, 	32'hf0000014, 32'h0000ffff);
		TASK_CheckReadDummy(ORAMZ * 15);
		TASK_CheckRead(0, 32'hf000000f, 32'hffffffff);
		TASK_CheckRead(NumChunks * 1, 	32'hf0000010, 32'hffffffff);
		
		// big test 8
		TASK_TestPoint(8);
		TASK_CheckRead(NumChunks * 7, 	32'hf00003ff, 32'hffffffff);
		TASK_CheckReadDummy(ORAMZ - 1);
		TASK_CheckRead(NumChunks,		32'hf00005ff, 32'h00000002);
		TASK_CheckReadDummy(ORAMZ - 1);
		TASK_CheckRead(NumChunks * 8, 	32'hf00004ff, 32'hfffffffc);
		TASK_CheckReadDummy(ORAMZ - 1);
		TASK_CheckReadDummy(ORAMZ * 28);
		TASK_CheckRead(NumChunks * 6,	32'hf00002ff, 32'h80000000);
		TASK_CheckReadDummy(ORAMZ - 1);
		TASK_CheckRead(0, 				32'hf00000ff, 32'h00000000);
		TASK_CheckReadDummy(ORAMZ - 1);
		
		// big test 9
		TASK_TestPoint(9);
		TASK_CheckReturn(0, 			32'hf0000000, 32'h00000000);
		TASK_CheckRead(NumChunks * 2,	32'hf0000002, 32'hffffffff);
		TASK_CheckRead(NumChunks, 		32'hf0000001, 32'hffffffff);
		TASK_CheckReadDummy(BlocksOnPath-ORAMZ);
		
		// big test 10
		TASK_TestPoint(10);
		TASK_CheckReturn(NumChunks,		32'hba5eba11, 32'h00000000);
		TASK_CheckRead(NumChunks,		32'hf0000001, 32'hffffffff);
		TASK_CheckRead(0, 				32'hf0000000, 32'hffffffff);		
		TASK_CheckReadDummy(BlocksOnPath-2*ORAMZ);
		TASK_CheckRead(0,				32'hf0000002, 32'h00000000);
		TASK_CheckRead(NumChunks * 2,	32'hf0000003, 32'h00000000);
		
		// big test 11
		TASK_TestPoint(11);
		TASK_CheckReturn(NumChunks * 2,	32'hba5eba11, 32'h00000000);
		TASK_CheckRead(NumChunks * 5,	32'hf0000005, 32'hffffffff);
		TASK_CheckRead(NumChunks * 4,	32'hf0000004, 32'hffffffff);	
		TASK_CheckReadDummy(BlocksOnPath-2*ORAMZ);
		TASK_CheckRead(0,				32'hf0000006, 32'h00000000);
		TASK_CheckRead(NumChunks,		32'hf0000007, 32'h00000000);
		
		// Stash drain step:
		TASK_CheckReadDummy(BlocksOnPath-2*ORAMZ);
		TASK_CheckRead(NumChunks * 2,	32'hba5eba11, 32'hffffffff);
		TASK_CheckRead(NumChunks * 3,	32'hf0000003, 32'hffffffff);
		TASK_CheckRead(0,				32'hf0000001, 32'hffffffff);
		TASK_CheckRead(NumChunks,		32'hf0000002, 32'hffffffff);
		
		// big test 12
		TASK_TestPoint(12);
		TASK_CheckRead(UpdateINIT,	32'hba5eba11, 32'hffffffff);
		TASK_CheckReadDummy(BlocksOnPath-1);
		
		#(Cycle*1000);
		$display("** All tests passed **");
		TestsPASSED = 1;
	end	
	
	//--------------------------------------------------------------------------
	//	CUT
	//--------------------------------------------------------------------------

	Stash	#(				.StashOutBuffering(		StashOutBuffering),
							.Overclock(				Overclock),
							.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC))
							
			CUT(			.Clock(					Clock),
							.Reset(					Reset),
							.ResetDone(				ResetDone),
							
							.RemapLeaf(				RemapLeaf),
							.AccessLeaf(			AccessLeaf),
							.AccessPAddr(			AccessPAddr),
							.AccessIsDummy(			AccessIsDummy),
							.AccessCommand(			AccessCommand),
							
							.StartScan(				StartScan),
							.SkipWriteback(			1'b0),
							.StartWriteback(		StartWriteback),
							
							.ReturnData(			ReturnData),
							.ReturnPAddr(			ReturnPAddr),
							.ReturnLeaf(			ReturnLeaf),
							.ReturnDataOutValid(	ReturnDataOutValid),
							.BlockReturnComplete(	BlockReturnComplete),
							
							.UpdateData(			UpdateData),
							.UpdateDataInValid(		UpdateDataInValid),
							.UpdateDataInReady(		UpdateDataInReady),
							.BlockUpdateComplete(	BlockUpdateComplete),
							
							.EvictData(				EvictData),
							.EvictPAddr(			EvictPAddr),
							.EvictLeaf(				EvictLeaf),
							.EvictDataInValid(		EvictDataInValid),
							.EvictDataInReady(		EvictDataInReady),
							.BlockEvictComplete(	BlockEvictComplete),

							.WriteData(				WriteData),
							.WriteInValid(			WriteInValid),
							.WriteInReady(			WriteInReady), 
							.WritePAddr(			WritePAddr),
							.WriteLeaf(				WriteLeaf),
							.BlockWriteComplete(	BlockWriteComplete), 
							
							.ReadData(				ReadData),
							.ReadPAddr(				ReadPAddr),
							.ReadLeaf(				ReadLeaf),
							.ReadOutValid(			ReadOutValid), 
							.ReadOutReady(			ReadOutReady), 
							.BlockReadComplete(		BlockReadComplete),
							.PathReadComplete(		PathReadComplete),
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		StashOccupancy));

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
