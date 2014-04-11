
//==============================================================================
//	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale		1 ns/1 ps		// Display things in ns, compute them in ps

//------------------------------------------------------------------------------
//	Module:		AESREWORAMTestbench
//------------------------------------------------------------------------------
module	AESREWORAMTestbench;
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

	reg		[ORAMU-1:0]		ROPAddr;
	reg		[ORAML-1:0]		ROLeaf;
	reg						ROAccess;
	
	wire	[DDRDWidth-1:0] BEDataOut;
	wire	[IVEntropyWidth-1:0] BEIVOut; 
	wire					BEDataOutValid; 
	reg						BEDataOutReady;
	
	reg		[DDRDWidth-1:0]	BEDataIn;
	reg						BEDataInValid;
	wire					BEDataInReady;	
	
	reg		[DDRDWidth-1:0]	DRAMReadData;
	reg						DRAMReadDataValid; 
	wire					DRAMReadDataReady;
	
	wire	[DDRDWidth-1:0]	DRAMWriteData;
	wire					DRAMWriteDataValid; 
	reg						DRAMWriteDataReady;	
	
	//--------------------------------------------------------------------------
	//	Clock Source
	//--------------------------------------------------------------------------
	
	ClockSource #(SlowFreq) ClockF200Gen(.Enable(1'b1), .Clock(Clock));
	ClockSource #(FastFreq) ClockF300Gen(.Enable(1'b1), .Clock(FastClock));

	//--------------------------------------------------------------------------
	//	Tasks
	//--------------------------------------------------------------------------

	/*
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
	endtask	*/
	
	//--------------------------------------------------------------------------
	//	Test Stimulus
	//--------------------------------------------------------------------------

	integer i, Continue;
	
	initial begin
		Reset = 1'b1;
	
		ROAccess = 1'b1;
		BEDataOutReady = 1'b1;
		BEDataInValid = 1'b0;
		DRAMReadDataValid = 1'b0;
		DRAMWriteDataReady = 1'b1;
	
		#(Cycle);
	
		Reset = 1'b0;

		$display("\n[%m @ %t] Test 1\n", $time);
		
		// fill leaf bucket

		#(Cycle*10000); // whatever
	
		ROAccess = 1'b0;
		DRAMReadDataValid = 1'b1;
		DRAMReadData = 0;
		
		Continue = 1;
		i = 0;
		while (Continue) begin
			if (BEDataOutReady & BEDataOutValid) i = i + 1;
			if (i == PathSize_DRBursts) Continue = 0;
			#(Cycle);
		end
		#(Cycle);
	end

	//--------------------------------------------------------------------------
	//	CUT
	//--------------------------------------------------------------------------
	
	AESREWORAM	#(			.ORAMZ(					ORAMZ),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMB(					ORAMB),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.IVEntropyWidth(		IVEntropyWidth),
							.AESWidth(				AESWidth))
							
				CUT(		.Clock(					Clock), 
							.FastClock(				FastClock), 
							.Reset(					Reset),

							.ROPAddr(				ROPAddr),
							.ROLeaf(				ROLeaf), 
							.ROAccess(				ROAccess),
							
							.BEDataOut(				BEDataOut), 
							.BEIVOut(				BEIVOut), 
							.BEDataOutValid(		BEDataOutValid), 
							.BEDataOutReady(		BEDataOutReady),
							
							.BEDataIn(				BEDataIn), 
							.BEDataInValid(			BEDataInValid), 
							.BEDataInReady(			BEDataInReady),	
							
							.DRAMReadData(			DRAMReadData), 
							.DRAMReadDataValid(		DRAMReadDataValid), 
							.DRAMReadDataReady(		DRAMReadDataReady),
							
							.DRAMWriteData(			DRAMWriteData), 
							.DRAMWriteDataValid(	DRAMWriteDataValid), 
							.DRAMWriteDataReady(	DRAMWriteDataReady));

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
