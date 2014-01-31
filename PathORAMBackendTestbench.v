
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale		1 ns/1 ps		// Display things in ns, compute them in ps

//==============================================================================
//	Module:		PathORAMTestbench
//==============================================================================
module	PathORAMTestbench #(`include "PathORAM.vh", `include "DRAM.vh", 
							`include "AES.vh");

	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	localparam					Freq =				200_000_000,
								Cycle = 			1000000000/Freq;	
	
	localparam					Test_ORAML =		15;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire 						Clock;
	reg							Reset; 

	// Frontend interface
	
	wire	[BECMDWidth-1:0] 	Command;
	wire	[ORAMU-1:0]			PAddr;
	wire	[ORAML-1:0]			CurrentLeaf;
	wire	[ORAML-1:0]			RemappedLeaf;
	wire						CommandValid, CommandReady;
	wire	[StashDWidth-1:0]	LoadData;
	wire						LoadValid, LoadReady,
	wire	[StashDWidth-1:0]	StoreData;
	wire 						StoreValid, StoreReady;
	
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
		input	[ORAMU-1:0]			In_PAddr;
		input	[ORAML-1:0]			In_CurrentLeaf;
		input	[ORAML-1:0]			In_RemappedLeaf;
		
		begin
			CommandValid = 1'b1;
			Command = In_Command;
			PAddr = In_PAddr;
			CurrentLeaf = In_CurrentLeaf;
			RemappedLeaf = In_RemappedLeaf;
			
			while (~CommandReady) #(Cycle);
			#(Cycle);
			
			CommandValid = 1'b0;
		end
	endtask	
	
	task TASK_Data;
		begin
			CommandValid = 1'b1;
			
			while (~BlockWriteComplete) #(Cycle);
			#(Cycle); 

			CMD_Append
		end
	endtask

	FIFOShiftRound	#(		.IWidth(				),
							.OWidth(				))
				data_shift	.Clock(					),
							.Reset(					),
							.InData(				),
							.InValid(				),
							.InAccept(				),								
							.OutData(				),
							.OutValid(				),
							.OutReady(				));
	
	//--------------------------------------------------------------------------
	//	Test Stimulus	
	//--------------------------------------------------------------------------

	initial begin
	
		Reset = 1'b1;
		#(Cycle);
		Reset = 1'b0;
		
	end
	
	//--------------------------------------------------------------------------
	//	CUT
	//--------------------------------------------------------------------------
	
	PathORAMBackend #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					Test_ORAML),
							.ORAMZ(					ORAMZ),
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
							.AWidth(				DDRAWidth),
							.DWidth(				DDRDWidth),
							.BurstLen(				DDRBstLen),
							.EnableMask(			1),
							.Class1(				1),
							.RLatency(				1),
							.WLatency(				1)); 
				ddr3model(	.Clock(					Clock),
							.Reset(					Reset),

							.Initialized(			),
							.PoweredUp(				),

							.CommandAddress(		DRAM_Address),
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
