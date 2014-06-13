
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale 1ns/1ns

//==============================================================================
//	Module:		TinyORAM
//	Desc: 		This wrapper sets ORAM specific clocks and declares all ORAM 
//				parameters.  It is meant to be a convenient way to use 
//				TinyORAMCore.
//==============================================================================
module TinyORAM(
  	Clock, Reset,
	
	Cmd, PAddr, 
	CmdValid, CmdReady, 
	
	DataIn,
	DataInValid, DataInReady,

	DataOut,
	DataOutValid, DataOutReady,
	
	DRAMAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid,
	DRAMWriteData, DRAMWriteMask, DRAMWriteDataValid, DRAMWriteDataReady
	);
	
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	
	// Debugging

	parameter				SlowAESClock =			1; // NOTE: set to 0 for performance run
	parameter				DebugDRAMReadTiming =	0; // NOTE: set to 0 for performance run
	
	// Frontend-backend
	
	parameter				EnablePLB = 			1,
							EnableREW =				1,
							EnableAES =				1,
							EnableIV =				`ifdef EnableIV `EnableIV `else 0 `endif;
	
	// ORAM
	
	parameter				ORAMB =					512,
							ORAMU =					32,
							ORAML =					`ifdef ORAML 	`ORAML 
													`else			(EnableREW || `ifdef SIMULATION 0 `else 1 `endif) ? 20 : 10 `endif,
							ORAMZ =					`ifdef ORAMZ `ORAMZ `else (EnableREW) ? 5 : 4 `endif,
							ORAMC =					10,
							ORAME =					5;

	parameter				FEDWidth =				512,
							BEDWidth =				512;

    parameter				NumValidBlock = 		1 << ORAML,
							Recursion = 			3,
							PLBCapacity = 			`ifdef PLBCapacity `PLBCapacity `else 8192 << 3 `endif; // 8KB PLB
		
	// Hardware

	parameter				Overclock =				1;
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	
	localparam				DelayedWB =				EnableIV;
		
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	
	//--------------------------------------------------------------------------
	//	User interface
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] Cmd;
	input	[ORAMU-1:0]		PAddr;
	input					CmdValid;
	output 					CmdReady;
	
	input	[FEDWidth-1:0]	DataIn;
	input					DataInValid;
	output 					DataInReady;

	output	[FEDWidth-1:0]	DataOut;
	output 					DataOutValid;
	input 					DataOutReady;
	
	//--------------------------------------------------------------------------
	//	DRAM interface
	//--------------------------------------------------------------------------

	output	[DDRAWidth-1:0]	DRAMAddress;
	output	[DDRCWidth-1:0]	DRAMCommand;
	output					DRAMCommandValid;
	input					DRAMCommandReady;
	
	input	[DDRDWidth-1:0]	DRAMReadData;
	input					DRAMReadDataValid;
	
	output	[DDRDWidth-1:0]	DRAMWriteData;
	output	[DDRMWidth-1:0]	DRAMWriteMask;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;

	//------------------------------------------------------------------------------
	// 	Wires & Regs
	//------------------------------------------------------------------------------
		
	wire					AESClock;

	//------------------------------------------------------------------------------
	// 	Clocking
	//------------------------------------------------------------------------------
	
	generate if (SlowAESClock) begin:SLOW_AES
		assign	AESClock =							Clock;
	end else begin:FAST_AES
		// Increases the clock by 50%
		aes_clock	ci15( 	.clk_in1(				Clock),
							.clk_out1(				AESClock),
							.reset(					Reset),
							.locked(				));
	end endgenerate
	
	//------------------------------------------------------------------------------
	// 	ORAM Controller
	//------------------------------------------------------------------------------

    TinyORAMCore #(			.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.ORAME(					ORAME),

							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),

							.NumValidBlock(         NumValidBlock), 
							.Recursion(             Recursion),
							.EnablePLB(				EnablePLB),
							.PLBCapacity(           PLBCapacity),

							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							.DelayedWB(				DelayedWB),

							.DebugDRAMReadTiming(	DebugDRAMReadTiming))
                core(		.Clock(					Clock),
							.AESClock(				AESClock),
							.Reset(					Reset),
		
							.Cmd(				    Cmd),
							.PAddr(					PAddr),
							.CmdValid(			    CmdValid),
							.CmdReady(			    CmdReady),
							
							.DataIn(                DataIn),
							.DataInValid(			DataInValid),
							.DataInReady(           DataInReady), 
							
							.DataOut(           	DataOut),
							.DataOutValid(      	DataOutValid),
							.DataOutReady(      	DataOutReady), 
							
							.DRAMCommand(			DRAMCommand),
							.DRAMAddress(           DRAMAddress),
							.DRAMCommandValid(		DRAMCommandValid),
							.DRAMCommandReady(		DRAMCommandReady),
							
							.DRAMReadData(			DRAMReadData),
							.DRAMReadDataValid(		DRAMReadDataValid),
							
							.DRAMWriteData(			DRAMWriteData),
							.DRAMWriteMask(			DRAMWriteMask),
							.DRAMWriteDataValid(	DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMWriteDataReady));

	//------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
