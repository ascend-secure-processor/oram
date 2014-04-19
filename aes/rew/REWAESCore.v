
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		REWAESCore
//	Desc:		Control wrapper for Tiny AES in an REW ORAM design.
//				Input: RO/RW mask commands (in separate buffers).
//
//				Input Notes:
//					- RO will always decrypt _bucket_ of interest instead of 
//					  just the block, regardless of EnableIV.  This simplifies 
//					  the HW a bit and also we have some spare bandwidth, might 
//					  as well use it.
//
//				Output: RO/RW masks (in order and in separate buffers).
//				
//				Output Notes:
//					- RW Output buffer: stores masks in DDRDWidth chunks; header 
//					  masks always come first
//
//				This module is meant to be clocked as fast as possible 
//				(e.g., 300+ Mhz).
//
//	TODO: Nix Initial -- we default the correct way now
//
//	Notes on getting clock up:
//		- No reset to any module
//		- Size FIFOs smaller to use smaller data counts (not implemented)
//		- Disable FIFO reset
//		- No backpressure
//==============================================================================
module REWAESCore(
	SlowClock, FastClock,

	ROIVIn, ROBIDIn, ROCommandIn, ROCommandInValid, ROCommandInReady,
	RWIVIn, RWBIDIn, RWCommandInValid, RWCommandInReady,
	
	RODataOut, ROCommandOut, RODataOutValid, RODataOutReady,
	RWDataOut, RWDataOutValid, RWDataOutReady
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh";
	`include "DDR3SDRAM.vh";
	`include "AES.vh";

	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "REWAESLocal.vh"
	
	localparam				BAWidth =				`max(`log2(RWHeader_AESChunks), `log2(Blk_AESChunks)) + 1;
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					SlowClock, FastClock;
	
	//--------------------------------------------------------------------------
	//	Input Interfaces
	//--------------------------------------------------------------------------

	input	[IVEntropyWidth-1:0] ROIVIn; 
	input	[BIDWidth-1:0]	ROBIDIn; 
	input	[PCCMDWidth-1:0] ROCommandIn; 
	input					ROCommandInValid;
	output					ROCommandInReady;

	input	[IVEntropyWidth-1:0] RWIVIn;
	input	[BIDWidth-1:0]	RWBIDIn;
	input					RWCommandInValid; 
	output					RWCommandInReady;
	
	//--------------------------------------------------------------------------
	//	Output Interfaces
	//--------------------------------------------------------------------------

	output	[AESWidth-1:0]	RODataOut; 
	output	[PCCMDWidth-1:0] ROCommandOut;
	output					RODataOutValid;
	input					RODataOutReady;
	
	output	[DDRDWidth-1:0]	RWDataOut;
	output					RWDataOutValid;
	input					RWDataOutReady;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	// RO input interface
	
	wire					ROCommandFull;
	
	wire	[IVEntropyWidth-1:0] ROIV_Fifo, ROIV; 
	wire	[BIDWidth-1:0]	ROBID_Fifo, ROBID; 
	wire	[PCCMDWidth-1:0] ROCommand_Fifo, ROCommand;
	wire					ROValid_Fifo, ROReady_Fifo, ROValid, ROReady;
	
	wire	[CIDWidth-1:0]	ROCID;
	
	wire					ROSend;
	wire					ROHeaderCID_Terminal, RODataCID_Terminal;
	
	wire					ROCommandIsHeader, RODataRestart, RODataRestarted;
	
	wire	[AESWidth-1:0]	ROSeed;	
	
	// RW input interface
	
	wire					RWCommandFull;
	
	wire	[IVEntropyWidth-1:0] RWIV_Fifo, RWIV; 
	wire	[BIDWidth-1:0]	RWBID_Fifo, RWBID; 
	wire					RWValid_Fifo, RWReady_Fifo, RWValid, RWReady;
		
	wire	[CIDWidth-1:0]	RWCID;	
		
	wire					RWSend;
	wire					RWDataCID_Terminal;	
	
	wire	[AESWidth-1:0]	RWSeed;
	
	// AES core
	
	wire	[AESWidth-1:0]	CoreKey;
		
	wire	[AESWidth-1:0]	CoreDataIn, CoreDataOut;
	wire					CoreDataInValid, CoreDataOutValid;
	
	wire	[ACCMDWidth-1:0] CoreCommandIn, CoreCommandOut;
	
	// Output interfaces
	
	wire					CommandOutIsRO, CommandOutIsRW;
	
	wire					RWHeaderWritten, RWBucketWritten;	
	wire	[BAWidth-1:0]	MaskShiftCount;
	wire 					MaskFIFODataMaskValid, MaskFIFOHeaderMaskValid;		
	
	wire	[DDRDWidth-1:0]	MaskFIFODataIn;
	wire					MaskFIFODataInValid, MaskFIFOFull;
	
	wire					ROFIFOFull;

	//--------------------------------------------------------------------------
	//	Simulation Checks
	//--------------------------------------------------------------------------
		
	`ifdef SIMULATION
		initial begin
			if ((IVEntropyWidth + BIDWidth + PCCMDWidth) > 108) begin
				$display("[%m @ %t] ERROR: Data is too wide for ro_I_fifo.", $time);
				$stop;
			end
			
			if ((AESWidth + PCCMDWidth) > 144) begin
				$display("[%m @ %t] ERROR: Data is too wide for ro_O_fifo.", $time);
				$stop;
			end
			
			if (AESWidth != 128) begin
				$display("[%m @ %t] ERROR: width not supported.", $time);
				$stop;
			end
			
			if (DDRDWidth != 512) begin
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
	assign	CoreKey =								{AESWidth{1'b1}}; 
	
	//--------------------------------------------------------------------------
	//	RO Input Interface
	//--------------------------------------------------------------------------

	// Note: We split the input buffers so RW commands don't head of line block
	// RO commands.  
	
	assign	ROCommandInReady =						~ROCommandFull;
	AESSeedFIFO ro_I_fifo(	.wr_clk(				SlowClock), 
							.rd_clk(				FastClock), 
							.din(					{ROIVIn, 	ROBIDIn, 	ROCommandIn}), 
							.wr_en(					ROCommandInValid),
							.full(					ROCommandFull), 							
							.dout(					{ROIV_Fifo, ROBID_Fifo, ROCommand_Fifo}), 
							.rd_en(					ROReady_Fifo), 
							.valid(					ROValid_Fifo));

	FIFORegister #(			.Width(					IVEntropyWidth + BIDWidth + PCCMDWidth),
							.Initial(				0),
							.InitialValid(			0))
				ro_state(	.Clock(					FastClock),
							.Reset(					1'b0),
							.InData(				{ROIV_Fifo, ROBID_Fifo, ROCommand_Fifo}),
							.InValid(				ROValid_Fifo),
							.InAccept(				ROReady_Fifo),
							.OutData(				{ROIV, ROBID, ROCommand}),
							.OutSend(				ROValid),
							.OutReady(				ROReady));
					
	assign	ROCommandIsHeader =						ROCommand == PCMD_ROHeader;
	assign	ROSend =								ROValid;
	assign	ROReady =								(ROCommandIsHeader) ? ROHeaderCID_Terminal : RODataCID_Terminal;
	
	Counter		#(			.Width(					CIDWidth),
							.Initial(				0))
				ro_cid(		.Clock(					FastClock),
							.Reset(					ROReady | (RODataRestart & ~RODataRestarted)),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				ROSend),
							.In(					{CIDWidth{1'bx}}),
							.Count(					ROCID));
	CountCompare #(			.Width(					CIDWidth),
							.Compare(				ROHeader_AESChunks - 1))
				ro_H_stop(	.Count(					ROCID),
							.TerminalCount(			ROHeaderCID_Terminal));
	CountCompare #(			.Width(					CIDWidth),
							.Compare(				RWBkt_AESChunks - 1))
				ro_D_stop(	.Count(					ROCID),
							.TerminalCount(			RODataCID_Terminal));			
	
	// We need to add a few AES chunks of padding to the output to correctly 
	// align the ROI masks with the RW masks
	CountAlarm #(			.Threshold(				ROIWaitSteps),
							.Initial(				0))
				roi_waste(	.Clock(					FastClock), 
							.Reset(					1'b0), 
							.Enable(				~ROCommandIsHeader & ROSend),
							.Done(					RODataRestart));
	Register #(				.Width(					1), // state machine to switch modes
							.Initial(				0))
				roi_hdr_chk(.Clock(					FastClock),
							.Reset(					ROReady),
							.Set(					~ROCommandIsHeader & RODataRestart),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					RODataRestarted));							
	
	assign	ROSeed =								{{SeedSpaceRemaining{1'b0}}, ROIV, ROBID, ROCID};
	
	//--------------------------------------------------------------------------
	//	RW Input Interface
	//--------------------------------------------------------------------------
	
	assign	RWCommandInReady =						~RWCommandFull;
	AESSeedFIFO rw_I_fifo(	.wr_clk(				SlowClock),
							.rd_clk(				FastClock),
							.din(					{RWIVIn, RWBIDIn}), 
							.wr_en(					RWCommandInValid),
							.full(					RWCommandFull),
							.dout(					{RWIV_Fifo, RWBID_Fifo}),
							.rd_en(					RWReady_Fifo),
							.valid(					RWValid_Fifo));
	
	FIFORegister #(			.Width(					IVEntropyWidth + BIDWidth),
							.Initial(				0),
							.InitialValid(			0))
				rw_state(	.Clock(					FastClock),
							.Reset(					1'b0),
							.InData(				{RWIV_Fifo, RWBID_Fifo}),
							.InValid(				RWValid_Fifo),
							.InAccept(				RWReady_Fifo),
							.OutData(				{RWIV, RWBID}),
							.OutSend(				RWValid),
							.OutReady(				RWReady));	
	
	assign	RWSend =								~ROValid & RWValid;
	assign	RWReady =								~ROValid & RWDataCID_Terminal;
	
	Counter		#(			.Width(					CIDWidth),
							.Initial(				0))
				rw_cid(		.Clock(					FastClock),
							.Reset(					RWReady),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				RWSend),
							.In(					{CIDWidth{1'bx}}),
							.Count(					RWCID));		
	CountCompare #(			.Width(					CIDWidth),
							.Compare(				RWBkt_AESChunks - 1))
				rw_stop(	.Count(					RWCID),
							.TerminalCount(			RWDataCID_Terminal));
	
	assign	RWSeed =								{{SeedSpaceRemaining{1'b0}}, RWIV, RWBID, RWCID};	
	
	//--------------------------------------------------------------------------
	//	Tiny AES Core
	//--------------------------------------------------------------------------
	
	assign	CoreDataIn =							(ROValid) ? ROSeed : RWSeed;
	assign	CoreDataInValid = 						ROValid | RWValid;
	assign	CoreCommandIn =							(ROValid) ? {1'b0, ROCommand} : CMD_RWData;
	
	aes_128 tiny_aes(		.clk(					FastClock),
							.state(					CoreDataIn), 
							.key(					CoreKey), 
							.out(					CoreDataOut));
							
	ShiftRegister #(		.PWidth(				AESLatency * (1 + ACCMDWidth)),
							.SWidth(				1 + ACCMDWidth),
							.Initial(				{AESLatency{1'b0}}))
				V_shift(	.Clock(					FastClock), 
							.Reset(					1'b0), 
							.Load(					1'b0), 
							.Enable(				1'b1),
							.SIn(					{CoreDataInValid, 	CoreCommandIn}),
							.SOut(					{CoreDataOutValid, 	CoreCommandOut}));						
	
	assign	CommandOutIsRW =						CoreDataOutValid & CoreCommandOut[ACMDRWBit] == CMD_RWData[ACMDRWBit];
	assign	CommandOutIsRO =						CoreDataOutValid & CoreCommandOut[ACMDRWBit] != CMD_RWData[ACMDRWBit];
	
	//--------------------------------------------------------------------------
	//	RO Output Interface
	//--------------------------------------------------------------------------
	
	// Note: we use a single FIFO for all RO stuff (header masks, data of 
	// interest) so save on the routing / area cost of a second FIFO.  Adding 
	// the command bit here adds 0 additional logic since we just use the BRAM 
	// ECC bits.

	// Note: we don't do backpressure on this FIFO so it must be deep enough
	AESROFIFO 	ro_O_fifo(	.wr_clk(				FastClock), 
							.rd_clk(				SlowClock), 
							.din(					{CoreDataOut,	CoreCommandOut[ACMDROBit]}), 
							.wr_en(					CommandOutIsRO),
							.full(					ROFIFOFull),
							.dout(					{RODataOut,		ROCommandOut}),
							.rd_en(					RODataOutReady),  
							.valid(					RODataOutValid));	
	
	//--------------------------------------------------------------------------
	//	RW Output Interface
	//--------------------------------------------------------------------------
	
	// Note: we need to shift this in the fast clock domain or there is no point 
	// in clocking this module fast.
	
	// This logic is more complicated because we need to shift H header chunks 
	// in, and then shift Z*P (P > H) payload chunks in.  So the shift counting 
	// is like 0 1 0 1 2 3 0 1 2 3, etc.  Annoying ...
	
	CountAlarm #(			.Threshold(				RWBkt_MaskChunks),
							.Initial(				0))
				rw_bkt_done(.Clock(					FastClock), 
							.Reset(					1'b0), 
							.Enable(				MaskFIFODataInValid),
							.Done(					RWBucketWritten));

	Counter		#(			.Width(					BAWidth),
							.Initial(				0))
				rw_O_cnt(	.Clock(					FastClock),
							.Reset(					MaskFIFODataInValid & ~CommandOutIsRW),
							.Set(					1'b0),
							.Load(					MaskFIFODataInValid & CommandOutIsRW),
							.Enable(				CommandOutIsRW),
							.In(					{{BAWidth-1{1'b0}}, 1'b1}),
							.Count(					MaskShiftCount));
	CountCompare #(			.Width(					BAWidth),
							.Compare(				RWHeader_AESChunks))
				rw_H_stop(	.Count(					MaskShiftCount),
							.TerminalCount(			MaskFIFOHeaderMaskValid));							
	CountCompare #(			.Width(					BAWidth),
							.Compare(				Blk_AESChunks))
				rw_D_stop(	.Count(					MaskShiftCount),
							.TerminalCount(			MaskFIFODataMaskValid));
	Register #(				.Width(					1), // state machine to switch modes
							.Initial(				0))
				rw_hdr_chk(	.Clock(					FastClock),
							.Reset(					RWBucketWritten),
							.Set(					MaskFIFOHeaderMaskValid),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					RWHeaderWritten));							

	assign	MaskFIFODataInValid =					(~RWHeaderWritten & MaskFIFOHeaderMaskValid) | MaskFIFODataMaskValid;
	
	ShiftRegister #(		.PWidth(				DDRDWidth),
							.SWidth(				AESWidth),
							.Initial(				{DDRDWidth{1'b0}}))
				rw_shift(	.Clock(					FastClock), 
							.Reset(					1'b0), 
							.Load(					1'b0), 
							.Enable(				CommandOutIsRW),
							.SIn(					CoreDataOut),
							.POut(					MaskFIFODataIn));
	
	// Note: we don't do backpressure on this FIFO so it must be deep enough
	REWMaskFIFO rw_O_fifo(	.wr_clk(				FastClock), 
							.rd_clk(				SlowClock), 
							.din(					MaskFIFODataIn), 
							.wr_en(					MaskFIFODataInValid), 
							.full(					MaskFIFOFull),
							.dout(					RWDataOut),
							.rd_en(					RWDataOutReady),
							.valid(					RWDataOutValid));

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
