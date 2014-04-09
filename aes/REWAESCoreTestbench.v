
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
							FastFreq =					300_000_000,
							Cycle = 					1000000000/SlowFreq;	
	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "REWAESLocal.vh"
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire 					Clock, FastClock;
	reg						Reset;
	
	reg		[IVEntropyWidth-1:0] ROIVIn; 
	reg		[BIDWidth-1:0]	ROBIDIn; 
	reg		[PCCMDWidth-1:0]ROCommandIn; 
	reg						ROCommandInValid;
	wire					ROCommandInReady;

	reg		[IVEntropyWidth-1:0] RWIVIn;
	reg		[BIDWidth-1:0]	RWBIDIn;
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

	task TASK_QueueRWCommand;
		input		[IVEntropyWidth-1:0] RWIVIn_Param;
		input		[BIDWidth-1:0] RWBIDIn_Param;
		begin
			RWCommandInValid = 1'b1;
		
			RWIVIn = RWIVIn_Param;
			RWBIDIn = RWBIDIn_Param;
			
			while (~RWCommandInReady) #(Cycle);
			#(Cycle);

			RWCommandInValid = 1'b0;
		end
	endtask
	
	task TASK_QueueROCommand;
		input		[IVEntropyWidth-1:0] ROIVIn_Param;
		input		[BIDWidth-1:0] ROBIDIn_Param;
		input		[PCCMDWidth-1:0] ROCommandIn_Param;
		begin
			ROCommandInValid = 1'b1;
		
			ROIVIn = ROIVIn_Param;
			ROBIDIn = ROBIDIn_Param;
			ROCommandIn = ROCommandIn_Param;
			
			while (~ROCommandInReady) #(Cycle);
			#(Cycle);

			ROCommandInValid = 1'b0;
		end
	endtask	
	
	//--------------------------------------------------------------------------
	//	Test Stimulus
	//--------------------------------------------------------------------------

	initial begin
		RODataOutReady = 1'b1;
		RWDataOutReady = 1'b1;	
	
		Reset = 1'b1;
	
		ROCommandInValid = 1'b0;
		RWCommandInValid = 1'b0;
	
		#(Cycle);
	
		Reset = 1'b0;

		$display("\n[%m @ %t] Test 1\n", $time);
		
		// fill leaf bucket
		TASK_QueueRWCommand(64'hba5eba11deadbeef, 0);
		TASK_QueueRWCommand(64'heeeeeeeeffffffff, 10);
		TASK_QueueROCommand(64'h1234567812345678, 0, PCMD_ROHeader);
		TASK_QueueROCommand(64'h1234567812345678, 10, PCMD_ROData);
		
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
