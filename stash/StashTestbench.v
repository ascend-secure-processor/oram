
//==============================================================================
//	Includes
//==============================================================================

`include "Const.v"

`timescale		1 ns/1 ps		// Display things in ns, compute them in ps

//------------------------------------------------------------------------------
//	Module:		StashCoreTestbench
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
	reg							StartReadOperation;		

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
	wire						BlockReadComplete;
	
	wire 						StashAlmostFull;
	wire						StashOverflow;
	
	//--------------------------------------------------------------------------
	//	Clock Source
	//--------------------------------------------------------------------------
	
	ClockSource #(Freq) ClockF100Gen(.Enable(1'b1), .Clock(Clock));

	//--------------------------------------------------------------------------
	//	Tasks	
	//--------------------------------------------------------------------------


	
	//--------------------------------------------------------------------------
	//	Test Stimulus	
	//--------------------------------------------------------------------------

	Counter		#(			.Width(					DataWidth))
				DataGen(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				InValid & InReady),
							.In(					{DataWidth{1'bx}}),
							.Count(					WriteData));

	initial begin
		Reset = 1'b1;
		StartScanOperation = 1'b0;
		StartReadOperation = 1'b0;
		
		#(Cycle);
	
		Reset = 1'b0;

		AccessLeaf = 32'h0000ffff;
		AccessPAddr = 32'hdeadbeef;
		
		$display("\n[%m @ %t] Test 1\n", $time);
		
		StartScanOperation = 1'b1;
		#(Cycle);
		StartScanOperation = 1'b0;
		
		#(Cycle*1000);
	
		$stop;
	end

	//--------------------------------------------------------------------------
	//	CUT
	//--------------------------------------------------------------------------

	Stash	CUT(			.Clock(					Clock),
							.Reset(					Reset),
							.ResetDone(				ResetDone),
							
							.AccessLeaf(			AccessLeaf),
							.AccessPAddr(			AccessPAddr),
							.AccessIsDummy(			AccessIsDummy),
							
							.StartScanOperation(	StartScanOperation),  
							.StartReadOperation(	StartReadOperation),
										
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

							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow));

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
