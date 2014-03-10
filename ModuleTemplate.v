
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

// NOTE: assumes tab = 4 spaces

/*
	Paramter passing convention

	1.) Include all parameters, that will be needed by multiple files and 
	overridden between parent-child modules, in a *.vh header file.

	2.) Include all constants (derived parameters like ORAMLogL = `log(ORAML)) 
	either as localparams or *Local.vh header files (depending on how many 
	modules need them).

	3.) When _instantiating_ a child module, MANUALLY pass all parameters needed 
	by that child module using #(...).  Reason = we want to build 
	parameterizable test benches that sweep parameter spaces and cannot change 
	parameters if they are only defined in .vh files (and not passed when 
	children are instantiated).
*/

//==============================================================================
//	Module:		
//	Desc:		
//==============================================================================
module MyModule #(/* parameters; e.g., `include "PathORAM.vh" */) (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
	// col 5				// col 29
  	input 					Clock, Reset,

	//--------------------------------------------------------------------------
	//	Interface 1
	//--------------------------------------------------------------------------
		
	// col5 // col 13		// col 29
	input	[StashDWidth-1:0] InData,
	input	[ORAMU-1:0]		InPAddr,
	input	[ORAML-1:0]		InLeaf,
	input					InValid,
	output 					InReady,
	
	//--------------------------------------------------------------------------
	//	Interface 2
	//--------------------------------------------------------------------------
	
	);

	//--------------------------------------------------------------------------
	//	Constants
	//-------------------------------------------------------------------------- 
		
	// Local params; e.g., `include "DDR3SDRAMLocal.vh"	
	
	// col 5				// col 29				// col 53
	localparam				STWidth =				3,
							ST_Reset =				3'd0,
							ST_Idle = 				3'd1,
							ST_Pushing = 			3'd2,
							ST_Overwriting = 		3'd3, 
							ST_Peaking =			3'd4, 
							ST_Dumping =			3'd5; 
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	// col5 // col 13		// col 29
	reg		[STWidth-1:0]	CS, NS;
	wire	[StashEAWidth-1:0] StashC_Address;
	
	//--------------------------------------------------------------------------
	//	State machines
	//-------------------------------------------------------------------------- 
	
	// synchronous logic
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Reset;
		else CS <= 									NS;
	end
	
	// combinational logic
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Reset : 
				if (ResetDone) 
					NS =						 	ST_Idle;
			ST_Idle :
				// blah blah
		endcase
	end	
	
	//--------------------------------------------------------------------------
	//	Wire assignments
	//-------------------------------------------------------------------------- 
	
	// col 5										// col 53
	assign	myWire =								CoreResetDone & ScanTableResetDone;
	
	//--------------------------------------------------------------------------
	//	Module instantiations
	//-------------------------------------------------------------------------- 
	
	// col 5	// col 17	// col 29				// col 53
	Counter		#(			.Width(					ScanTableAWidth),
							.Limited(				1),
							.Limit(					BlocksOnPath - 1))
				// module instance name is lower case with _ separating words
				rd_start(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				PathWriteback_Tick),
							.In(					{ScanTableAWidth{1'bx}}),
							.Count(					BlocksReading));
	
	genvar					i;
	generate for(i = 0; i < PARAM; i = i + 1) begin:MY_GENERATE
		assign 	MyBus[i] = 							Foo[SomeParam*(i+1)-1:SomeParam*i] == SomeWire;
	end endgenerate
	
	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------