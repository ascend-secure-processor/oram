
//==============================================================================
//	Includes
//==============================================================================

`include "Const.vh"

`timescale		1 ns/1 ps		// Display things in ns, compute them in ps

//------------------------------------------------------------------------------
//	Module:		StashCoreTestbench
//	Author:		Chris F.
//------------------------------------------------------------------------------
module	StashTestbench;

	`include "Stash.vh";
    `include "StashLocal.vh"
    
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	localparam					Freq =				100_000_000,
								Cycle = 			1000000000/Freq;	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire 						Clock;
	reg							Reset, ResetDataCounter; 
	wire						ResetDone;
	
	reg		[ORAML-1:0]			AccessLeaf;
	reg		[ORAMU-1:0]			AccessPAddr;
	reg							AccessIsDummy;	
	
	reg							StartScanOperation;
	reg							StartWritebackOperation;		

	wire	[DataWidth-1:0]		ReturnData;
	wire	[ORAMU-1:0]			ReturnPAddr;
	wire	[ORAML-1:0]			ReturnLeaf;
	wire						ReturnDataOutValid;
	reg							ReturnDataOutReady;	
	wire						BlockReturnComplete;
	
	reg		[DataWidth-1:0]		EvictData;
	reg		[ORAMU-1:0]			EvictPAddr;
	reg		[ORAML-1:0]			EvictLeaf;
	reg							EvictDataInValid;
	wire						EvictDataInReady;
	wire						BlockEvictComplete;	
	
	wire 	[DataWidth-1:0]		WriteData;
	reg		[ORAMU-1:0]			WritePAddr;
	reg		[ORAML-1:0]			WriteLeaf;
	reg							WriteInValid;
	wire						WriteInReady;	
	wire						BlockWriteComplete;
	
	wire	[DataWidth-1:0]		ReadData;
	wire	[ORAMU-1:0]			ReadPAddr;
	wire	[ORAML-1:0]			ReadLeaf;
	wire						ReadOutValid;
	reg							ReadOutReady;	
	wire						BlockReadComplete, PathReadComplete;
	
	wire 						StashAlmostFull;
	wire						StashOverflow;
	wire	[StashEAWidth-1:0]	StashOccupancy;
	
	integer						TestID;
	
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
		
	task TASK_BigTest;
		input [31:0] num;
		begin
		$display("\n\n[%m @ %t] Starting big test %d \n\n", $time, num);
		end
	endtask
	
	task TASK_StartScan;
		begin
			StartScanOperation = 1'b1;
			#(Cycle);
			StartScanOperation = 1'b0;
			#(Cycle); // needed so that Scan can re-enter idle state (see Stash.v interface)
		end
	endtask

	task TASK_StartWriteback;
		begin
			StartWritebackOperation = 1'b1;
			#(Cycle);
			StartWritebackOperation = 1'b0;
		end
	endtask
	
	Counter		#(			.Width(					DataWidth))
				DataGen(	.Clock(					Clock),
							.Reset(					Reset | ResetDataCounter),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				WriteInValid & WriteInReady),
							.In(					{DataWidth{1'bx}}),
							.Count(					WriteData));
		
	task TASK_QueueWrite;
		input	[ORAMU-1:0] PAddr;
		input	[ORAML-1:0] Leaf;
		begin
			WriteInValid = 1'b1;
			WritePAddr = PAddr;
			WriteLeaf = Leaf;
		
			while (~BlockWriteComplete) #(Cycle);
			#(Cycle);

			WriteInValid = 1'b0;
		end
	endtask
	
	task TASK_CheckRead;
		input	[DataWidth-1:0] BaseData;
		input	[ORAMU-1:0] PAddr;
		input	[ORAML-1:0] Leaf;
		
		reg		[DataWidth-1:0] Data;
		integer done;
		begin
			done = 0;
			Data = BaseData;
			while (done == 0) begin
				if (ReadOutValid /*& ReadOutReady*/) begin // NOTE: ReadOutReady is _block_ not chunk synchronous
					if (ReadData != Data) begin
						$display("FAIL: Stash read data %d, expected %d", ReadData, Data);
						$stop;
					end
					//$display("OK: Stash read data %d, expected %d", ReadData, Data);
					if (BlockReadComplete) begin
						if (ReadPAddr != PAddr || ReadLeaf != Leaf) begin
							$display("FAIL: Stash read {PAddr,Leaf} = {%x,%x} expected {%x,%x}", ReadPAddr, ReadLeaf, PAddr, Leaf);
							$stop;
						end
						//$display("OK: Stash read {PAddr,Leaf} = {%x,%x} expected {%x,%x}", ReadPAddr, ReadLeaf, PAddr, Leaf);
						done = 1;
					end
					Data = Data + 1;
				end
				#(Cycle);
			end
			$display("PASS: Test %d (read)", TestID);
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
				if (ReadOutValid /*& ReadOutReady*/) begin
					chunks = chunks + 1;
					if (BlockReadComplete) begin
						if (ReadPAddr != DummyBlockAddress) begin
							$display("FAIL: Stash read PAddr = %x, expected dummy block (saw %d out of %d)", ReadPAddr, sofar, Count);
							$stop;
						end
						if (chunks != NumChunks) begin
							$display("FAIL: Stash read dummy block, wrong block size");
							$stop;
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
				if (ReadOutValid /*& ReadOutReady*/ & BlockReadComplete) begin
					sofar = sofar + 1;
				end
				#(Cycle);
			end
			$display("PASS: Test %d (skipped %d / %d)", TestID, sofar, Count);
		end
	endtask
	
	task TASK_CheckOccupancy;
		input	[StashEAWidth-1:0] Occupancy;
		begin
			if (Occupancy != StashOccupancy) begin
				$display("FAIL: Stash occupancy %d, expected %d", StashOccupancy, Occupancy);
				$stop;
			end
			if ( ((StashOccupancy + BlocksOnPath) >= StashCapacity) != StashAlmostFull ) begin
				$display("FAIL: StashAlmostFull = %b (%d >= %d)", StashAlmostFull, StashOccupancy + BlocksOnPath, StashCapacity);
				$stop;
			end
			$display("PASS: Test %d (occupancy expected = %d, Almost full? %b)", TestID, Occupancy, StashAlmostFull);
			TestID = TestID + 1;
		end
	endtask
	
	//--------------------------------------------------------------------------
	//	Test Stimulus	
	//--------------------------------------------------------------------------

	/*
		Cases to test:
	
		1.) Scan finishes before, after, during write data arrives
		2.) Stash is initially empty/not empty
		3.) Dummy blocks in path, only real blocks in path
	*/						

	integer i;
	
	initial begin
		Reset = 1'b1;
		ResetDataCounter = 1'b0;
		
		StartScanOperation = 1'b0;
		StartWritebackOperation = 1'b0;

		WriteInValid = 1'b0;
		EvictDataInValid = 1'b0;
		
		ReturnDataOutReady = 1'b1;
		ReadOutReady = 1'b1;
		
		#(Cycle);
	
		Reset = 1'b0;

		AccessLeaf = 32'h0000ffff;
		AccessPAddr = 32'hdeadbeef;
		AccessIsDummy = 1'b0;
		
		while (~ResetDone) #(Cycle);
		#(Cycle);

		// ---------------------------------------------------------------------
		// Test 1: Basic backend test; all blocks written back
		// ---------------------------------------------------------------------
		
		TASK_BigTest(1);
		TASK_StartScan();
		
		#(Cycle*10); // will be > 10, (probably) < 100 in practice

		TASK_QueueWrite(32'hf0000000, 32'h0000ffff);
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
		TASK_StartScan();

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

		AccessLeaf = 32'h0000fff1;
		
		TASK_BigTest(3);
		TASK_StartScan();

		TASK_StartWriteback();		
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);		

		// ---------------------------------------------------------------------
		// Test 4: Access with partial writeback, discontiguous dummy/real blocks 
		// ---------------------------------------------------------------------

		AccessLeaf = 32'h00000000;
		
		TASK_BigTest(4);
		TASK_StartScan();
		
		TASK_QueueWrite(32'hf000000a, 32'h00000002); // level 1
		TASK_QueueWrite(32'hf000000b, 32'h00000002); // level 1

		#(Cycle*10); // some random delay
		
		TASK_QueueWrite(32'hf000000c, 32'h00000000); // level 33
		TASK_QueueWrite(32'hf000000d, 32'h80000000); // level 32
		
		TASK_QueueWrite(32'hf0000008, 32'h00000001); // level 0
		TASK_QueueWrite(32'hf0000009, 32'h00000001); // level 0
		
		TASK_StartWriteback();		
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);

		// ---------------------------------------------------------------------
		// Test 5:  Load up stash and make sure the AlmostFull signal goes high
		// ---------------------------------------------------------------------

		AccessLeaf = 32'h00000000;
		
		TASK_BigTest(5);
		TASK_StartScan();
		
		i = 0;
		
		while (i < BlocksOnPath) begin
			// This is technically illegal (no path intersection) --- whatever
			TASK_QueueWrite(32'hf000000e, 32'hffffffff);
			i = i + 1;
		end

		TASK_StartWriteback();		
		TASK_WaitForAccess();
		TASK_CheckOccupancy(BlocksOnPath-ORAMZ); // for root bucket

		// ---------------------------------------------------------------------
		// Test 6:  Drain the stash
		// ---------------------------------------------------------------------

		AccessLeaf = 32'hffffffff;
		
		TASK_BigTest(6);
		TASK_StartScan();
		TASK_StartWriteback();
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);
		
		// ---------------------------------------------------------------------
		// Test 7:  Backpressure on ReadOutReady
		// ---------------------------------------------------------------------

		AccessLeaf = 32'hffffffff;
		
		ResetDataCounter = 1'b1;
		#(Cycle);
		ResetDataCounter = 1'b0;
		
		TASK_BigTest(7);
		TASK_StartScan();

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
		i = 1;
		while (i < 512) begin
			ReadOutReady = 1'b0;
			#(Cycle*i);
			ReadOutReady = 1'b1;
			#(Cycle*i);
			i = i << 1;
		end
		
		TASK_WaitForAccess();
		TASK_CheckOccupancy(0);		
	end

	//--------------------------------------------------------------------------
	//	Read stream verification
	//--------------------------------------------------------------------------

	initial begin
		TestID = 0;

		while (~ResetDone) #(Cycle);
		#(Cycle);
		
		// big test 1
		TASK_CheckReadDummy(BlocksOnPath - 4);
		TASK_CheckRead(NumChunks * 2, 32'hf0000002, 32'h0000ffff);
		TASK_CheckRead(NumChunks * 3, 32'hf0000003, 32'h0000ffff);
		TASK_CheckRead(0, 32'hf0000000, 32'h0000ffff);
		TASK_CheckRead(NumChunks * 1, 32'hf0000001, 32'h0000ffff);
		
		// big test 2
		TASK_CheckRead(NumChunks * 4, 32'hf0000004, 32'hffff0000);
		TASK_CheckRead(NumChunks * 5, 32'hf0000005, 32'hffff0000);
		TASK_CheckReadDummy(BlocksOnPath - 2);
		
		// big test 3
		TASK_CheckRead(NumChunks * 6, 32'hf0000006, 32'hffff0000);
		TASK_CheckRead(NumChunks * 7, 32'hf0000007, 32'hffff0000);
		TASK_CheckReadDummy(BlocksOnPath - 2);
		
		// big test 4
		TASK_CheckRead(NumChunks * 12, 32'hf0000008, 32'h00000001);
		TASK_CheckRead(NumChunks * 13, 32'hf0000009, 32'h00000001);
		TASK_CheckReadDummy(ORAMZ - 2);
		TASK_CheckRead(NumChunks * 8, 32'hf000000a, 32'h00000002);
		TASK_CheckRead(NumChunks * 9, 32'hf000000b, 32'h00000002);
		TASK_CheckReadDummy(ORAMZ - 2);
		TASK_CheckReadDummy(ORAMZ * 29);
		TASK_CheckRead(NumChunks * 11, 32'hf000000d, 32'h80000000);
		TASK_CheckReadDummy(ORAMZ - 1);
		TASK_CheckRead(NumChunks * 10, 32'hf000000c, 32'h00000000);
		TASK_CheckReadDummy(ORAMZ - 1);
		
		// big test 5
		TASK_CheckRead(NumChunks * 14, 32'hf000000e, 32'hffffffff);
		TASK_CheckRead(NumChunks * 15, 32'hf000000e, 32'hffffffff);
		TASK_CheckReadDummy(BlocksOnPath);

		// big test 6
		TASK_SkipRead(64);
		
		// big test 7
		TASK_CheckRead(NumChunks * 2, 32'hf0000011, 32'h00000000);
		TASK_CheckRead(NumChunks * 3, 32'hf0000012, 32'h00000000);
		TASK_CheckReadDummy(ORAMZ * 15);
		TASK_CheckRead(NumChunks * 4, 32'hf0000013, 32'h0000ffff);
		TASK_CheckRead(NumChunks * 5, 32'hf0000014, 32'h0000ffff);
		TASK_CheckReadDummy(ORAMZ * 15);
		TASK_CheckRead(0, 32'hf000000f, 32'hffffffff);
		TASK_CheckRead(NumChunks * 1, 32'hf0000010, 32'hffffffff);
		
		#(Cycle*1000);
		$display("*** ALL TESTS PASSED ***");		
	end	
	
	//--------------------------------------------------------------------------
	//	CUT
	//--------------------------------------------------------------------------

	Stash	#(				.DataWidth(				DataWidth),
							.StashCapacity(			StashCapacity),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
							
			CUT(			.Clock(					Clock),
							.Reset(					Reset),
							.ResetDone(				ResetDone),
							
							.AccessLeaf(			AccessLeaf),
							.AccessPAddr(			AccessPAddr),
							.AccessIsDummy(			AccessIsDummy),
							
							.StartScanOperation(	StartScanOperation),  
							.StartWritebackOperation(StartWritebackOperation),
										
							.ReturnData(			ReturnData),
							.ReturnPAddr(			ReturnPAddr),
							.ReturnLeaf(			ReturnLeaf),
							.ReturnDataOutValid(	ReturnDataOutValid),
							.ReturnDataOutReady(	ReturnDataOutReady),
							.BlockReturnComplete(	BlockReturnComplete),
							
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
