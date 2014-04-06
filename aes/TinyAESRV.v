
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		TinyAESRV
//	Desc:		FIFO wrapper for Tiny AES
//==============================================================================
module TinyAESRV(
	SlowClock, FastClock, 
	SlowReset,

	DataIn, DataInValid, DataInReady,
	DataOut, DataOutValid, DataOutReady
	);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	parameter				NPorts =				1,
							AESWidth =				128;
	
	localparam				AESLat =				21,
							DWidth =				NPorts * AESUWidth;
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					SlowClock, FastClock, SlowReset;
	
	//--------------------------------------------------------------------------
	//	Data Interfaces
	//--------------------------------------------------------------------------

	input	[DWidth-1:0] 	DataIn;
	input					DataInValid;
	output					DataInReady;
	
	output	[DWidth-1:0] 	DataOut;
	output					DataOutValid;
	input					DataOutReady;
	
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire					DataInFull, DataOutFull;
	wire					CoreDataInValid, CoreDataOutValid;
	
	wire	[DWidth-1:0]	CoreDataIn, CoreDataOut;
	
	wire	[AESUWidth-1:0]	CoreKey;
	
	//--------------------------------------------------------------------------
	//	Simulation Checks
	//--------------------------------------------------------------------------
		
	`ifdef SIMULATION
	
		// TODO check for AES larger than 128
	
		initial begin
			if (NPorts != 1) begin
				$display("[%m @ %t] ERROR: NPorts != 1 not supported yet.", $time);
				$stop;
			end
		end
		
		always @(posedge FastClock) begin
			if (~DataOutFull & CoreDataOutValid) begin
				$display("[%m @ %t] ERROR: AES out fifo overflow.", $time);
				$stop;
			end
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Core
	//--------------------------------------------------------------------------
	
	assign	CoreKey =								{AESUWidth{1'b1}}; // TODO: Set it to something dynamic
	
	assign	DataInReady =							~DataInFull;
	AESFIFO in_fifo(		.rst(					SlowReset),
							.wr_clk(				SlowClock), 
							.rd_clk(				FastClock), 
							.din(					DataIn), 
							.wr_en(					DataInValid),
							.full(					DataInFull), 							
							.rd_en(					1'b1), 
							.dout(					CoreDataIn), 
							.valid(					CoreDataInValid));
							
	aes_128 tiny_aes(		.clk(					FastClock),
							.state(					CoreDataIn), 
							.key(					CoreKey), 
							.out(					CoreDataOut));
							
	ShiftRegister #(		.PWidth(				AESLat),
							.SWidth(				1),
							.Initial(				{AESLat{1'b0}})
				V_shift(	.Clock(					FastClock), 
							.Reset(					1'b0), 
							.Load(					1'b0), 
							.Enable(				1'b1),
							.SIn(					CoreDataInValid),
							.SOut(					CoreDataOutValid));							
							
	AESFIFO in_fifo(		.rst(					SlowReset),
							.wr_clk(				FastClock), 
							.rd_clk(				SlowClock), 
							.din(					CoreDataOut), 
							.wr_en(					CoreDataOutValid),
							.full(					DataOutFull),						
							.rd_en(					DataOutReady), 
							.dout(					DataOut), 
							.valid(					DataOutValid));							
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
