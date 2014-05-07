
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		AESPathORAMDelayModel
//	Desc:		A performance model for AES-Basic path ORAM.
//				This module exists because we need a Block RAM FIFORAM w/ 
//				arbitrary FWLatency.
//==============================================================================
module AESPathORAMDelayModel(
  	Clock, Reset,

	DataIn,
	DataInValid, DataInReady,

	DataOut,
	DataOutValid, DataOutReady
	);	
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	parameter				Width =					512,
							FWLatency =				30;
							
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	
	//--------------------------------------------------------------------------
	//	Interface to network
	//--------------------------------------------------------------------------

	input	[Width-1:0]		DataIn;
	input					DataInValid;
	output 					DataInReady;

	output	[Width-1:0]		DataOut;
	output 					DataOutValid;
	input 					DataOutReady;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 

	wire					Full;

	wire					BufOutValid;
	wire					InTransfer, OutTransfer;

	//--------------------------------------------------------------------------
	//	Simulation checks
	//-------------------------------------------------------------------------- 		
	
	`ifdef SIMULATION
		initial begin	
			if (Width > 512) begin
				$display("[%m @ %t] ERROR: You will need to regenerate the path buffer.", $time);
				$finish;
			end
			
			if (InTransfer & Full) begin
				$display("[%m @ %t] ERROR.", $time);
				$finish;			
			end
			
			if (OutTransfer & ~BufOutValid) begin
				$display("[%m @ %t] ERROR.", $time);
				$finish;			
			end
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Core modules
	//--------------------------------------------------------------------------
	
	assign	InTransfer =							DataInValid & DataInReady;
	
	PathBuffer buf_core(	.clk(					Clock),
							.din(					DataIn), 
							.wr_en(					InTransfer), 
							.rd_en(					OutTransfer), 
							.dout(					DataOut), 
							.full(					Full), 
							.valid(					BufOutValid));						

    FIFORAM 	#(			.Width(					1),
							.FWLatency(				FWLatency),
							.Buffering(				512)) // as deep as the path buffer
                latency(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				1'bx),
							.InValid(				DataInValid),
							.InAccept(				DataInReady),
							.OutSend(				DataOutValid),
							.OutReady(				DataOutReady));							

	assign	OutTransfer =							DataOutValid & DataOutReady;
						
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------