
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale		1 ns/1 ps		// Display things in ns, compute them in ps

//==============================================================================
//	Module:		PathORAMTestbench
//==============================================================================
module	PathORAMTestbench #(`include "PathORAM.vh", `include "DDR3SDRAM.vh", 
							`include "AES.vh");

	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	localparam					Freq =				200_000_000,
								Cycle = 			1000000000/Freq;	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire 						Clock;
	reg							Reset; 

	//--------------------------------------------------------------------------
	//	Clock Source
	//--------------------------------------------------------------------------
	
	ClockSource #(Freq) ClockF200Gen(.Enable(1'b1), .Clock(Clock));
	
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

	PathORAM #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					15),
							.ORAMZ(					ORAMZ),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
				CUT(		.Clock(					Clock),
							.Reset(					Reset),
							// TODO LLC interface //
							.DRAMCommandAddress(	),
							.DRAMCommand(			),
							.DRAMCommandValid(		),
							.DRAMCommandReady(		1'b1),			
							.DRAMReadData(			),
							.DRAMReadDataValid(		1'b0),			
							.DRAMWriteData(			),
							.DRAMWriteMask(			),
							.DRAMWriteDataValid(	),
							.DRAMWriteDataReady(	1'b1));		
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
