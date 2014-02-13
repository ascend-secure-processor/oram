
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
	wire	[ORAMU-1:0]			PAddr;
	reg		[ORAML-1:0]			CurrentLeaf;
	wire	[ORAML-1:0]			RemappedLeaf;
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
	
	//--------------------------------------------------------------------------
	//	Clock Source
	//--------------------------------------------------------------------------
	
	ClockSource #(Freq) ClockF200Gen(.Enable(1'b1), .Clock(Clock));

	//--------------------------------------------------------------------------
	//	Tasks
	//--------------------------------------------------------------------------	

	task TASK_Command;
		input	[BECMDWidth-1:0] 	In_Command;
		
		begin
			CommandValid = 1'b1;
			Command = In_Command;
			
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

	Counter		#(			.Width(					ORAML))
				LeafGen(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CommandValid & CommandReady),
							.In(					{ORAML{1'bx}}),
							.Count(					RemappedLeaf));
	
	Counter		#(			.Width(					ORAMU))
				PAddrGen(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CommandValid & CommandReady),
							.In(					{ORAMU{1'bx}}),
							.Count(					PAddr));	
	
	Counter		#(			.Width(					FEDWidth))
				DataGen(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				StoreValid & StoreReady),
							.In(					{FEDWidth{1'bx}}),
							.Count(					StoreData));
	
	//--------------------------------------------------------------------------
	//	Test Stimulus	
	//--------------------------------------------------------------------------

	integer i, j;
	
	initial begin
		CurrentLeaf = {ORAML{1'b1}};
		CommandValid = 1'b0;
		StoreValid = 1'b0;
		LoadReady = 1'b1;
		
		Reset = 1'b1;
		#(Cycle);
		Reset = 1'b0;
		
		//----------------------------------------------------------------------
		//	Test 1: Append until stash is full and force background evictions
		//----------------------------------------------------------------------	

		i = 0;
		while (i < StashCapacity) begin
			TASK_Command(BECMD_Append);
			i = i + 1;
		end
		
		//----------------------------------------------------------------------
		//	Test 2: ReadRmv
		//----------------------------------------------------------------------

		//----------------------------------------------------------------------
		//	Test : Read
		//----------------------------------------------------------------------

		//----------------------------------------------------------------------
		//	Test : Update
		//----------------------------------------------------------------------		
	end
	
	initial begin
		#(Cycle*25);
	
		j = 0;
	
		//----------------------------------------------------------------------
		//	Test 1
		//----------------------------------------------------------------------	

		while (j < StashCapacity) begin
			TASK_Data();
			j = j + 1;
		end	
	
		//----------------------------------------------------------------------
		//	Test 2
		//----------------------------------------------------------------------			
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
