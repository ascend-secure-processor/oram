
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale		1 ns/1 ps		// Display things in ns, compute them in ps

//==============================================================================
//	Module:		PathORAMBackendTestbench
//	Desc:		If the tests all pass, the following should print out:
//
//				*** TESTBENCH COMPLETED & PASSED ***
//
//				If they don't, try running for longer (4000 us) before debugging
//==============================================================================
module	testAddrGen;

    parameter					ORAMB =				512;
	parameter				    ORAMU =				32; 
	parameter                   ORAML = `ifdef ORAML `ORAML `else 20 `endif;
	parameter                   ORAMZ = `ifdef ORAMZ `ORAMZ `else 5 `endif;
	parameter					ORAMC =				10; 
	parameter					ORAME =				5;
	
	parameter                   FEDWidth = `ifdef FEDWidth `FEDWidth `else 32 `endif;
	parameter                   BEDWidth = `ifdef BEDWidth `BEDWidth `else 512 `endif;
	
    parameter                   NumValidBlock = 	1 << (ORAML - 1);
    parameter                   Recursion = 		3;
                   
    parameter                   PLBCapacity = 		8192 << 3; // in bits

	parameter					Overclock = 		1;
	parameter					EnableAES =			1;
	parameter					EnableREW =			1;
    parameter					EnableIV =          1;
	
	    `include "PathORAMBackendLocal.vh"
    `include "PLBLocal.vh" 
    `include "BucketLocal.vh"
    `include "DDR3SDRAMLocal.vh"
	
	wire	Clock;
	
	localparam  Freq =	200_000_000;
	
	ClockSource #(Freq) ClockF200Gen(.Enable(1'b1), .Clock(Clock));

	wire	[DDRAWidth-1:0]	AddrGen_DRAMCommandAddress;
	wire	[DDRCWidth-1:0]	AddrGen_DRAMCommand;
	wire					AddrGen_DRAMCommandValid, AddrGen_DRAMCommandReady;

	wire 					AddrGen_HeaderWriteback;	
	wire					AddrGen_Reading;
	
	wire	[ORAML-1:0]		AddrGen_Leaf;
	wire					AddrGen_InReady, AddrGen_InValid;
		
	wire	[DDRAWidth-1:0]	AddrGen_DRAMCommandAddress_Internal;
	wire	[DDRCWidth-1:0]	AddrGen_DRAMCommand_Internal;
	wire					AddrGen_DRAMCommandValid_Internal, AddrGen_DRAMCommandReady_Internal;											
		
    AddrGen #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
				addr_gen(	.Clock(					Clock),
							.Reset(					1'b0),
							.Start(					1'b1), 
							.Ready(					AddrGen_InReady),
							.RWIn(					1'b0),
							.BHIn(					1'b0),
							.leaf(					20'h4be34),
							.CmdReady(				1'b1),
							.CmdValid(				AddrGen_DRAMCommandValid_Internal),
							.Cmd(					AddrGen_DRAMCommand_Internal), 
							.Addr(					AddrGen_DRAMCommandAddress_Internal));	

	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
