
//==============================================================================
//	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale		1 ns/1 ps		// Display things in ns, compute them in ps

//------------------------------------------------------------------------------
//	Module:		REWAESCoreTestbench
//------------------------------------------------------------------------------
module	REWAESCoreTestbench;
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	parameter				ORAMZ =						5;
	parameter				ORAMU =						32;
	parameter				ORAML =						31;
	parameter				ORAMB =						512;
	parameter				DDR_nCK_PER_CLK =			4;
	parameter				DDRDQWidth =				64;
	parameter				IVEntropyWidth =			64;
	parameter				AESWidth =					128;
	
	localparam				SlowFreq =					200_000_000,
							FlowFreq =					300_000_000,
							Cycle = 					1000000000/SlowFreq;	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire 					Clock, FastClock;
	reg						Reset;
	
	reg	[IVEntropyWidth-1:0] ROIVIn; 
	reg	[BIDWidth-1:0]		ROBIDIn; 
	reg	[PCCMDWidth-1:0]	ROCommandIn; 
	reg						ROCommandInValid;
	wire					ROCommandInReady;

	reg	[IVEntropyWidth-1:0] RWIVIn;
	reg	[BIDWidth-1:0]		RWBIDIn;
	reg						RWCommandInValid; 
	wire					RWCommandInReady;

	wire	[AESWidth-1:0]	RODataOut; 
	wire	[PCCMDWidth-1:0] ROCommandOut;
	wire					RODataOutValid;
	reg						RODataOutReady;
	
	wire	[DDRDWidth-1:0]	RWDataOut;
	wire					RWDataOutValid;
	reg						RWDataOutReady;	

	//--------------------------------------------------------------------------
	//	Clock Source
	//--------------------------------------------------------------------------
	
	ClockSource #(SlowFreq) ClockF200Gen(.Enable(1'b1), .Clock(Clock));
	ClockSource #(FastFreq) ClockF300Gen(.Enable(1'b1), .Clock(FastClock));

	//--------------------------------------------------------------------------
	//	Tasks	
	//--------------------------------------------------------------------------
/*
	task TASK_QueueROCommand;

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
	*/
	//--------------------------------------------------------------------------
	//	Test Stimulus	
	//--------------------------------------------------------------------------

	initial begin
		SlowReset = 1'b1;
	
		ROCommandInValid = 1'b0;
		RWCommandInValid = 1'b0;
	
		#(Cycle);
	
		Reset = 1'b0;

		$display("\n[%m @ %t] Test 1\n", $time);
		
		// fill leaf bucket
		//TASK_QueueCommand(32'hf0000000, 32'h0000ffff, 1'bx, CMD_Push);

		#(Cycle*1000); // whatever
	
		$stop;
	end

	//--------------------------------------------------------------------------
	//	CUT
	//--------------------------------------------------------------------------
	
	REWAESCore	#(			.ORAMZ(					ORAMZ),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMB(					ORAMB),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.IVEntropyWidth(		IVEntropyWidth),
							.AESWidth(				AESWidth))
							.EnableIV(				EnableIV))
				CUT(		.SlowClock(				Clock),
							.FastClock(				FastClock), 
							.SlowReset(				Reset),

							.ROIVIn(				ROIVIn), 
							.ROBIDIn(				ROBIDIn), 
							.ROCommandIn(			ROCommandIn), 
							.ROCommandInValid(		ROCommandInValid), 
							.ROCommandInReady(		ROCommandInReady),
							
							.RWIVIn(				RWIVIn), 
							.RWBIDIn(				RWBIDIn), 
							.RWCommandInValid(		RWCommandInValid), 
							.RWCommandInReady(		RWCommandInReady),
							
							.RODataOut(				RODataOut), 
							.ROCommandOut(			ROCommandOut), 
							.RODataOutValid(		RODataOutValid), 
							.RODataOutReady(		RODataOutReady),
							
							.RWDataOut(				RWDataOut), 
							.RWDataOutValid(		RWDataOutValid),
							.RWDataOutReady(		RWDataOutReady));

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
