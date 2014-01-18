
//==============================================================================
//	Includes
//==============================================================================

`include "Const.v"

`timescale		1 ns/1 ps		// Display things in ns, compute them in ps

//------------------------------------------------------------------------------
//	Module:		StashCoreTestbench
//	Author:		Chris F.
//------------------------------------------------------------------------------
module	StashTestbench;

	`include "StashCore.constants"

	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	localparam					Freq =				100_000_000,
								Cycle = 			1000000000/Freq;	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire 						Clock;
	reg							Reset; 
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
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				WriteInValid & WriteInReady),
							.In(					{DataWidth{1'bx}}),
							.Count(					WriteData));
		
	/* 
		Writes a cache line to the stash 
	*/
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
		
	/*
		Verify that a stash read has the data we expect
	*/
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
				if (ReadPAddr != DummyBlockAddress) begin
					if (ReadOutValid & ReadOutReady) begin
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
				end
				#(Cycle);
			end
			$display("PASS: Test %d (read)", TestID);
			TestID = TestID + 1;
		end
	endtask
	
	task TASK_CheckOccupancy;
		input	[StashEAWidth-1:0] Occupancy;
		begin
			if (Occupancy != StashOccupancy) begin
				$display("FAIL: Stash occupancy %d, expected %d", StashOccupancy, Occupancy);
				$stop;
			end
			$display("PASS: Test %d (occupancy expected = %d)", TestID, Occupancy);
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

	initial begin
		Reset = 1'b1;
		
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

		// ---------------------------------------------------------------------
		// Test 3: write the rest back
		// ---------------------------------------------------------------------

		AccessLeaf = 32'h0000fff1;
		
		TASK_StartScan();
		TASK_StartWriteback();
		
		TASK_WaitForAccess();
		
		#(Cycle*1000);

	end

	//--------------------------------------------------------------------------
	//	Verification
	//--------------------------------------------------------------------------

	initial begin
		TestID = 0;

		while (~ResetDone) #(Cycle);
		#(Cycle);
		
		// big test 1
		TASK_CheckRead(16, 32'hf0000002, 32'h0000ffff);
		TASK_CheckRead(24, 32'hf0000003, 32'h0000ffff);
		TASK_CheckRead(0, 32'hf0000000, 32'h0000ffff);
		TASK_CheckRead(8, 32'hf0000001, 32'h0000ffff);
		TASK_CheckOccupancy(0);
		
		// big test 2
		TASK_CheckRead(32, 32'hf0000004, 32'hffff0000);
		TASK_CheckRead(40, 32'hf0000005, 32'hffff0000);
		TASK_CheckOccupancy(2);
		
		// big test 3
		TASK_CheckRead(48, 32'hf0000006, 32'hffff0000);
		TASK_CheckRead(56, 32'hf0000007, 32'hffff0000);
		TASK_CheckOccupancy(0);
		
		// 
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
							.StartWritebackOperation(	StartWritebackOperation),
										
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
