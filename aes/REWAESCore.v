
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		REWAESCore
//	Desc:		Control wrapper for Tiny AES in an REW ORAM design.
//				Input: RO/RW mask commands (in separate buffers).
//				Output: RO/RW masks (in order and in separate buffers).
//				
//				We split the input buffers so RW commands don't head of line 
//				block RO commands.  We split the output buffers because RW masks 
//				are on a different datapath relative to RO headers.
//				This module is meant to be clocked as fast as possible 
//				(e.g., 300 Mhz).
//
//	Notes on getting clock up:
//		- No reset to any module
//		- Size FIFOs smaller to use smaller data counts
//		- Disable FIFO reset
//==============================================================================
module REWAESCore(
	SlowClock, FastClock, 
	SlowReset,

	ROCommandIn, ROCommandInValid, ROCommandInReady,
	RWCommandIn, RWCommandInValid, RWCommandInReady,
	
	RODataOut, ROCommandOut, RODataOutValid, RODataOutReady,
	RWDataOut, RWDataOutValid, RWDataOutReady
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "REWAES.vh";

	`include "REWAESLocal.vh"
	
	parameter				ROWidth =				128, // Width of RO input/output interface
							RWWidth =				512, // "" RW interface (should match DDRDWidth)
							BIDWidth =				34, // BucketID field width
							CIDWidth =				5, // ChunkID field width
							AESWidth =				128;	
	
	localparam				AESLat =				21; // based on tiny_aes + external buffer we add
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					SlowClock, FastClock, SlowReset;
	
	//--------------------------------------------------------------------------
	//	Data Interfaces
	//--------------------------------------------------------------------------


	
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire					CoreDataInValid, CoreDataOutValid;
	
	wire	[DWidth-1:0]	CoreDataIn, CoreDataOut;
	
	wire	[AESUWidth-1:0]	CoreKey;
	
	// Output interfaces
	
	wire	[RWWidth-1:0]	MaskFIFODataIn;
	wire					MaskFIFODataInValid, MaskFIFOFull;
	
	wire					ROFIFOFull;

	//--------------------------------------------------------------------------
	//	Simulation Checks
	//--------------------------------------------------------------------------
		
	`ifdef SIMULATION
	
		initial begin
			if (AESWidth != 128) begin
				$display("[%m @ %t] ERROR: width not supported.", $time);
				$stop;
			end
			if (RWWidth != 512) begin
				$display("[%m @ %t] ERROR: you need to re-generate the REWMaskFIFO to change this width.", $time);
				$stop;
			end
		end
		
		always @(posedge FastClock) begin
			if (ROFIFOFull & CommandOutIsRO) begin
				$display("[%m @ %t] ERROR: AES RO out fifo overflow.", $time);
				$stop;
			end
			 
			if (MaskFIFOFull & MaskFIFODataInValid) begin
				$display("[%m @ %t] ERROR: AES RW out fifo overflow.", $time);
				$stop;
			end			

		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Key Management
	//--------------------------------------------------------------------------
	
	// TODO: Set it to something dynamic [this is actually important to get correct area numbers ...]
	assign	CoreKey =								{AESUWidth{1'b1}}; 
	
	//--------------------------------------------------------------------------
	//	RO Input Interface
	//--------------------------------------------------------------------------

	ROCommandFull
	
	assign	ROCommandInReady =						~ROCommandFull;
	AESFIFO ro_I_fifo(		.rst(					SlowReset),
							.wr_clk(				SlowClock), 
							.rd_clk(				FastClock), 
							.din(					ROCommandIn), 
							.wr_en(					ROCommandInValid),
							.full(					ROCommandFull), 							
							.rd_en(					), 
							.dout(					), 
							.valid(					));

	//--------------------------------------------------------------------------
	//	RW Input Interface
	//--------------------------------------------------------------------------
	
	RWCommandFull
	
	assign	RWCommandInReady =						~RWCommandFull;
	AESFIFO rw_I_fifo(		.rst(					SlowReset),
							.wr_clk(				SlowClock), 
							.rd_clk(				FastClock), 
							.din(					RWCommandIn), 
							.wr_en(					RWCommandInValid),
							.full(					RWCommandFull), 							
							.rd_en(					), 
							.dout(					), 
							.valid(					));							
	
	Counter		#(			.Width(					))
				rw_cid(		.Clock(					),
							.Reset(					),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				),
							.In(					{{1'bx}}),
							.Count(					));
	CountCompare #(			.Width(					),
							.Compare(				))
				rw_stop(	.Count(					),
							.TerminalCount(			));
	
	//--------------------------------------------------------------------------
	//	Tiny AES Core
	//--------------------------------------------------------------------------
	
	CoreCommandIn, CoreCommandOut
	
	CommandOutIsRO
	CommandOutIsRW
	
	assign	CoreDataIn
	assign	CoreDataInValid = 
	assign	CoreCommandIn =
	
	aes_128 tiny_aes(		.clk(					FastClock),
							.state(					CoreDataIn), 
							.key(					CoreKey), 
							.out(					CoreDataOut));
							
	ShiftRegister #(		.PWidth(				AESLat),
							.SWidth(				1 + ACCMDWidth),
							.Initial(				{AESLat{1'b0}})
				V_shift(	.Clock(					FastClock), 
							.Reset(					1'b0), 
							.Load(					1'b0), 
							.Enable(				1'b1),
							.SIn(					{CoreDataInValid, 	CoreCommandIn}),
							.SOut(					{CoreDataOutValid, 	CoreCommandOut}));						
	
	assign	CommandOutIsRW =						CoreDataOutValid & CoreCommandOut[ACMDRWBit] == CMD_RWData[ACMDRWBit]; // not optimal given our encoding, but whatever it's 2 bits
	assign	CommandOutIsRO =						CoreDataOutValid & CoreCommandOut[ACMDRWBit] != CMD_RWData[ACMDRWBit];
	
	//--------------------------------------------------------------------------
	//	RW Output Interface
	//--------------------------------------------------------------------------
	
	// Note: we need to shift this in the fast clock domain or there is no point 
	// in clocking this fast.
	
	CountAlarm #(			.Threshold(				BlkSize_AESChunks),
							.Initial(				0))
				rw_shft_cnt(.Clock(					FastClock), 
							.Reset(					1'b0), 
							.Enable(				CommandOutIsRW),
							.Done(					MaskFIFODataInValid));	
	
	ShiftRegister #(		.PWidth(				RWWidth),
							.SWidth(				AESWidth),
							.Initial(				{RWWidth{1'b0}})
				rw_shift(	.Clock(					FastClock), 
							.Reset(					1'b0), 
							.Load(					1'b0), 
							.Enable(				CommandOutIsRW),
							.SIn(					CoreDataOut),
							.POut(					MaskFIFODataIn));
	
	REWMaskFIFO rw_O_fifo(	.rst(					SlowReset), 
							.wr_clk(				FastClock), 
							.rd_clk(				SlowClock), 
							.din(					MaskFIFODataIn), 
							.wr_en(					MaskFIFODataInValid), 
							.full(					MaskFIFOFull),
							.dout(					RWDataOut),
							.rd_en(					RWDataOutReady),
							.valid(					RWDataOutValid))
	
	//--------------------------------------------------------------------------
	//	RO Output Interface
	//--------------------------------------------------------------------------
	
	// Note: we use a single FIFO for all RO stuff (header masks, data of 
	// interest) so save on the routing / area cost of a second FIFO.  Adding 
	// the command bit here adds 0 additional logic since we just use the BRAM 
	// ECC bits.

	AESROFIFO 	ro_O_fifo(	.rst(					SlowReset),
							.wr_clk(				FastClock), 
							.rd_clk(				SlowClock), 
							.din(					{CoreDataOut,	CoreCommandOut[ACMDROBit]}), 
							.wr_en(					CommandOutIsRO),
							.full(					ROFIFOFull),
							.dout(					{RODataOut,		ROCommandOut}),
							.rd_en(					RODataOutReady),  
							.valid(					RODataOutValid));

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
