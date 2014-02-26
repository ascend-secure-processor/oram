
//==============================================================================
//	Includes
//==============================================================================

	NOTE: THIS TESTBENCH IS OBSOLETE.  THE STASH SHOULD BE TESTED USING 
	StashTestbench.v.

`include "Const.vh"

`timescale		1 ns/1 ps		// Display things in ns, compute them in ps

//------------------------------------------------------------------------------
//	Module:		StashCoreTestbench
//------------------------------------------------------------------------------
module	StashCoreTestbench;

	`include "Stash.vh";
	`include "StashLocal.vh"

	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	localparam				Freq =					100_000_000,
							Cycle = 				1000000000/Freq;	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire 						Clock;
	reg							Reset; 
	
	wire	[DataWidth-1:0]		InData;
	reg							InValid;
	wire						InReady;

	reg		[CMDWidth-1:0] 		InCommand;
	reg		[ORAMU-1:0]			InPAddr;
	reg		[ORAML-1:0]			InLeaf;
	reg		[StashEAWidth-1:0]	InSAddr;
	reg							InCommandValid;
	wire						InCommandReady;

	reg		[ORAML-1:0]			CurrentLeaf;

	wire	[ORAMU-1:0]			ScanPAddr;
	wire	[ORAML-1:0]			ScanLeaf;
	wire	[StashEAWidth-1:0]	ScanSAddr;
	wire						ScanLeafValid;

	wire	[StashEAWidth-1:0]	ScannedSAddr;
	wire						ScannedLeafAccepted, ScannedLeafValid;

	//--------------------------------------------------------------------------
	//	Clock Source
	//--------------------------------------------------------------------------
	
	ClockSource #(Freq) ClockF100Gen(.Enable(1'b1), .Clock(Clock));

	//--------------------------------------------------------------------------
	//	Tasks	
	//--------------------------------------------------------------------------

	task TASK_QueueCommand;
		input	[ORAMU-1:0] PAddr;
		input	[ORAML-1:0] Leaf;
		input	[StashEAWidth-1:0] SAddr;
		input	[CMDWidth-1:0] Command;
		begin
			if (Command == CMD_Push | Command == CMD_Overwrite)
				InValid = 1'b1;
			else
				InValid = 1'b0;

			InCommandValid = 1'b1;

			InPAddr = PAddr;
			InLeaf = Leaf;
			InSAddr = SAddr;
			InCommand = Command;
		
			while (~InCommandReady) #(Cycle);
			#(Cycle);

			InValid = 1'b0;
			InCommandValid = 1'b0;
		end
	endtask
	
	//--------------------------------------------------------------------------
	//	Test Stimulus	
	//--------------------------------------------------------------------------

	Counter		#(			.Width(			DataWidth))
				DataGen(	.Clock(			Clock),
							.Reset(			Reset),
							.Set(			1'b0),
							.Load(			1'b0),
							.Enable(		InValid & InReady),
							.In(			{DataWidth{1'bx}}),
							.Count(			InData));

	initial begin
		Reset = 1'b1;
		InValid = 1'b0;
		InCommandValid = 1'b0;
	
		#(Cycle);
	
		Reset = 1'b0;

		CurrentLeaf = 32'h0000ffff;

		$display("\n[%m @ %t] Test 1\n", $time);
		
		// fill leaf bucket
		TASK_QueueCommand(32'hf0000000, 32'h0000ffff, 1'bx, CMD_Push);
		TASK_QueueCommand(32'hf0000001, 32'h0000ffff, 1'bx, CMD_Push);
		TASK_QueueCommand(32'hf0000002, 32'h0000ffff, 1'bx, CMD_Push);
		TASK_QueueCommand(32'hf0000003, 32'h0000ffff, 1'bx, CMD_Push);

		// fill some other bucket
		TASK_QueueCommand(32'hf0000004, 32'h0001ffff, 1'bx, CMD_Push);
		TASK_QueueCommand(32'hf0000005, 32'h0001ffff, 1'bx, CMD_Push);
		TASK_QueueCommand(32'hf0000006, 32'h0001ffff, 1'bx, CMD_Push);
		TASK_QueueCommand(32'hf0000007, 32'h0001ffff, 1'bx, CMD_Push);

		// Read out two non-contig elements
		
		TASK_QueueCommand(1'hx, 1'hx, 0, CMD_Peak);
		TASK_QueueCommand(1'hx, 1'hx, 1, CMD_Peak);
		TASK_QueueCommand(1'hx, 1'hx, 2, CMD_Peak);
		TASK_QueueCommand(1'hx, 1'hx, 3, CMD_Peak);
		
		// Overwrite and try to read again
		
		TASK_QueueCommand(32'hba5eba11, 32'h0000ff0f, 1, CMD_Overwrite);
		TASK_QueueCommand(1'hx, 1'hx, 0, CMD_Peak);
		TASK_QueueCommand(1'hx, 1'hx, 1, CMD_Peak);
		TASK_QueueCommand(1'hx, 1'hx, 2, CMD_Peak);
		TASK_QueueCommand(1'hx, 1'hx, 3, CMD_Peak);
		
		// Other operations

		TASK_QueueCommand(1'hx, 1'hx, 1'hx, CMD_Dump);
		TASK_QueueCommand(1'hx, 1'hx, 1'hx, CMD_Sync);

		$display("\n[%m @ %t] Test 2\n", $time);
		
		// Fill the root bucket
		TASK_QueueCommand(32'hf0000009, 32'h0001fff0, 1'bx, CMD_Push);
		TASK_QueueCommand(32'hf000000a, 32'h0001fff0, 1'bx, CMD_Push);
		TASK_QueueCommand(32'hf000000b, 32'h0001fff0, 1'bx, CMD_Push);
		TASK_QueueCommand(32'hf000000c, 32'h0001fff0, 1'bx, CMD_Push);
		
		// This block won't be written back to the tree
		TASK_QueueCommand(32'hf000000d, 32'h0001fff0, 1'bx, CMD_Push);

		TASK_QueueCommand(1'hx, 1'hx, 1'hx, CMD_Dump);
		TASK_QueueCommand(1'hx, 1'hx, 1'hx, CMD_Sync);

		#(Cycle*1000); // whatever
	
		$stop;
	end

	//--------------------------------------------------------------------------
	//	CUTs
	//--------------------------------------------------------------------------

	StashCore	CUT(	.Clock(				Clock), 
						.Reset(				Reset),

						.InData(			InData),
						.InValid(			InValid),
						.InReady(			InReady),

						.InPAddr(			InPAddr),
						.InLeaf(			InLeaf),
						.InSAddr(			InSAddr),
						.InCommand(			InCommand),
						.InCommandValid(	InCommandValid),
						.InCommandReady(	InCommandReady),

						.OutData(			),
						.OutValid(			OutValid),

						.OutScanPAddr(		ScanPAddr),
						.OutScanLeaf(		ScanLeaf),
						.OutScanSAddr(		ScanSAddr),
						.OutScanValid(		ScanLeafValid),

						.InScanSAddr(		ScannedSAddr),
						.InScanAccepted(	ScannedLeafAccepted),
						.InScanValid(		ScannedLeafValid));

	StashScanTable CUT2(.Clock(				Clock), 
						.Reset(				Reset),

						.CurrentLeaf(		CurrentLeaf),

						.InLeaf(			ScanLeaf),
						.InPAddr(			ScanPAddr),
						.InSAddr(			ScanSAddr),
						.InValid(			ScanLeafValid),
			
						.OutSAddr(			ScannedSAddr),
						.OutAccepted(		ScannedLeafAccepted),
						.OutValid(			ScannedLeafValid));

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
