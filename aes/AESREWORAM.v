
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		AESREWORAM
//	Desc:		AES Unit for REW ORAM.  This module acts as a filter which 
//				decrypts/re-encrypts the data that is sent to it.  **Crucially, 
//				if N bytes of data are input to this module, it will eventually 
//				output N bytes, and each byte's logical position in the stream 
//				will be unchanged.**
//				ROHeader = valid bits + program addresses
//
//				TODO update this description
//
//				- 	On an REW RO access (DRAM -> Backend): 
//						In: 	Encrypted path
//						Out: 	Path with decrypted ROHeaders, 
//								encrypted payload except for bucket/block of 
//								interest
//				-	On an REW H access (Backend -> DRAM): 
//						In:		Decrypted headers
//						Out:	Re-encrypted headers
//				-	On an REW R access (DRAM -> Backend):
//						In:		Encrypted path
//						Out:	Decrypted path
//				-	On an REW W access (Backend -> DRAM):
//						In:		Decrypted path
//						Out:	Encrypted path
//==============================================================================
module AESREWORAM(
	Clock, FastClock, 
	Reset,

	ROPAddr, ROLeaf, ROAccess,
	
	BEDataOut, BEBVOut, BEBIDOut, BEDataOutValid, BEDataOutReady,
	BEDataIn, BEDataInValid, BEDataInReady,	
	
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,
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
	
	localparam				PathMaskBuffering =		2; // with ORAML = 31, ORAMZ = 5 & a 512 deep mask FIFO, we can fit 2 whole paths
	
	localparam				RWSWidth =				2,
							ST_RW_StartRead =		2'd0,
							ST_RW_Read =			2'd1,
							ST_RW_StartWrite =		2'd2,
							ST_RW_Write =			2'd3;
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, FastClock, Reset;

	//--------------------------------------------------------------------------
	//	Command Interface
	//--------------------------------------------------------------------------
	
	input	[ORAMU-1:0]		ROPAddr;
	input	[ORAML-1:0]		ROLeaf;
	input					ROAccess;
	
	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------

	output	[DDRDWidth-1:0] BEDataOut;
	output	[IVEntropyWidth-1:0] BEBVOut;
	output	[BIDWidth-1:0]	BEBIDOut;
	output					BEDataOutValid; 
	input					BEDataOutReady;
	
	input	[DDRDWidth-1:0]	BEDataIn;
	input					BEDataInValid;
	output					BEDataInReady;	
	
	//--------------------------------------------------------------------------
	//	DRAM Interface
	//--------------------------------------------------------------------------	
	
	input	[DDRDWidth-1:0]	DRAMReadData;
	input					DRAMReadDataValid; 
	output					DRAMReadDataReady;
	
	output	[DDRDWidth-1:0]	DRAMWriteData;
	output					DRAMWriteDataValid; 
	input					DRAMWriteDataReady;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	// RW related
	
	reg		[RWSWidth-1:0] 	CS_RW, NS_RW;
	wire					CSRWStartOp, CSRWWrite;
	
	wire					RWPathTransition;
	wire					RWCommandTransfer, RWMaskTransfer;

	wire	[IVEntropyWidth-1:0] GentryCounter, GentryCounterShifted, RWBVOut;

	wire	[BIDWidth-1:0] 	RWBIDOut;
	
	wire	[ORAML-1:0]		GentryLeaf;

	wire	[DDRDWidth-1:0]	RWMaskOut;
	
	wire					RWAuxInValid, RWAuxInReady;
	wire					RWAuxOutValid;		
	
	wire					RW_BIDInReady, RW_BIDOutValid, RW_BIDOutReady;	
	
	wire					RWMaskIsHeader, RWMaskBucketTransition;	
	
	// AES Core
	
	wire	[IVEntropyWidth-1:0] Core_ROIVIn; 
	wire	[BIDWidth-1:0] 	Core_ROBIDIn; 
	wire	[PCCMDWidth-1:0] Core_ROCommandIn; 
	wire					Core_ROCommandInValid;
	wire					Core_ROCommandInReady;

	wire	[IVEntropyWidth-1:0] Core_RWIVIn;
	wire	[BIDWidth-1:0] 	Core_RWBIDIn;
	wire					Core_RWCommandInValid; 
	wire					Core_RWCommandInReady;

	wire	[AESWidth-1:0]	Core_RODataOut; 
	wire	[PCCMDWidth-1:0] Core_ROCommandOut;
	wire					Core_RODataOutValid;
	wire					Core_RODataOutReady;
	
	wire	[DDRDWidth-1:0]	Core_RWDataOut;
	wire					Core_RWDataOutValid;	
	
	//--------------------------------------------------------------------------
	//	Simulation Checks
	//--------------------------------------------------------------------------
		
	`ifdef SIMULATION
		initial begin	
			if ((PathMaskBuffering * RWPath_MaskChunks) > 512) begin
				$display("[%m @ %t] ERROR: The mask header FIFO is too shallow for the Mask data FIFO (sized @ 512x512).", $time);
				$stop;
			end
		end
		
		always @(posedge Clock) begin
			if (RWMaskTransfer & ~RWAuxOutValid) begin
				$display("[%m @ %t] ERROR: Mask fifo didn't have data on a transfer.", $time);
				$stop;
			end
			
			if (ROIntDataInValid & ~ROIntDataInReady) begin
				$display("[%m @ %t] ERROR: ROInt FIFO overflow.", $time);
				$stop;
			end
		end
	`endif

	//--------------------------------------------------------------------------
	//	Control logic
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	RO AES Input
	//--------------------------------------------------------------------------

	DRAMReadTransfer
	RODRAMChunkIsHeader
	
	RO_BIDOutValid
	RO_BIDOutReady
	
	RO_DRAMReadDataReady
	
	ROIntDataInValid
	ROIntDataInReady
	
		ROBucketTransition
	ROPathTransition
	
	assign	DRAMReadTransfer =						DRAMReadDataValid & RO_DRAMReadDataReady;
	
	localparam				RWSWidth =				2,
							ST_RO_StartRead =		2'd0,
							ST_RO_HeaderRead =		2'd1, // Masks for RO headers
							ST_RO_PayloadRead =		2'd2, // Masks for bucket of interest
							ST_RO_StartWrite =		3'd3, 
							ST_RO_HeaderWrite =		2'd4; // Masks for header writebacks
	
	always @(posedge Clock) begin
		if (Reset) CS_RO <= 						ST_RO_Idle;
		else CS_RO <= 								NS_RO;
	end
	
	CSROStartOp, CSROPayloadRead
	RO_BIDInReady
	
	assign	CSROStartOp =							CS_RO == ST_RO_StartRead | CS_RO == ST_RO_StartWrite;
	assign	CSROPayloadRead =						CS_RO == ST_RO_PayloadRead;
	
	always @( * ) begin
		NS_RO = 									CS_RO;
		case (CS_RO)
			ST_RO_StartRead :
				if (RO_BIDInReady)
					NS_RO =							ST_RO_HeaderRead;
			ST_RO_HeaderRead :
				if (ROPathTransition)
					NS_RO =							ST_RO_PayloadRead;
			ST_RO_PayloadRead : 
				if ()
					NS_RO =							ST_RO_StartWrite;
			ST_RO_StartWrite :
				if (RO_BIDInReady)
					NS_RO =							ST_RO_HeaderWrite;
			ST_RO_HeaderWrite :
				if ()
					
		endcase
	end	
	
	CountAlarm 	#(			.Threshold(				BktSize_DRBursts),
							.IThreshold(			0))
				ro_hdr_cnt(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				DRAMReadTransfer),
							.Intermediate(			RODRAMChunkIsHeader),
							.Done(					ROBucketTransition));
	CountAlarm 	#(			.Threshold(				ORAML + 1))
				ro_pth_cnt(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				ROBucketTransition),
							.Done(					ROPathTransition));							
	
	assign	Core_ROIVIn =							;
							
    AddrGen #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
				ro_bid(		.Clock(					Clock),
							.Reset(					Reset),
							.Start(					CSROStartOp),
							.Ready(					RO_BIDInReady),
							.RWIn(					1'b0), // don't care
							.BHIn(					1'b1), // only send one command per bucket
							.leaf(					ROLeaf),
							.CmdValid(				RO_BIDOutValid),
							.CmdReady(				RO_BIDOutReady),
							.BktIdx(				Core_ROBIDIn));
							
	assign	Core_ROCommandIn =						(CSROPayloadRead) ? PCMD_ROData : PCMD_ROHeader;
	
	assign	Core_ROCommandInValid =					RODRAMChunkIsHeader & 	DRAMReadDataValid & RO_BIDOutValid & ROIntDataInReady;
	assign	ROIntDataInValid =												DRAMReadDataValid & RO_BIDOutValid & Core_ROCommandInReady;
	
	assign	RO_BIDOutReady =						Core_ROCommandInReady & ROIntDataInReady & DRAMReadDataValid;
	assign	RO_DRAMReadDataReady =					Core_ROCommandInReady & ROIntDataInReady & RO_BIDOutValid;
	
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				AESLatencyPlus))
				ro_int_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMReadData),
							.InValid(				ROIntDataInValid),
							.InAccept(				ROIntDataInReady),
							.OutData(				),
							.OutSend(				),
							.OutReady(				));
	
	//--------------------------------------------------------------------------
	//	H AES Input
	//--------------------------------------------------------------------------
	
	FIFORAM		#(			.Width(					IVEntropyWidth),
							.Buffering(				ORAML + 1))
				ro_IVp_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				),
							.InValid(				),
							.InAccept(				),
							.OutData(				),
							.OutSend(				),
							.OutReady(				));
	
	//--------------------------------------------------------------------------
	//	RW AES Input
	//--------------------------------------------------------------------------

	assign	CSRWStartOp =							CS_RW == ST_RW_StartRead | CS_RW == ST_RW_StartWrite;
	assign	CSRWWrite =								CS_RW == ST_RW_Write;
	
	always @(posedge Clock) begin
		if (Reset) CS_RW <= 						ST_RW_StartRead;
		else CS_RW <= 								NS_RW;
	end
	
	always @( * ) begin
		NS_RW = 									CS_RW;
		case (CS_RW)
			ST_RW_StartRead :
				if (RW_BIDInReady)
					NS_RW =							ST_RW_Read;
			ST_RW_Read : 
				if (RWPathTransition)
					NS_RW =							ST_RW_StartWrite;
			ST_RW_StartWrite : 
				if (RW_BIDInReady)
					NS_RW =							ST_RW_Write;
			ST_RW_Write : 
				if (RWPathTransition)
					NS_RW =							ST_RW_StartRead;
		endcase
	end
	
	CountAlarm #(			.Threshold(				ORAML + 1))
				rw_lvl_cnt(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				RWCommandTransfer),
							.Done(					RWPathTransition));
	
	Counter		#(			.Width(					IVEntropyWidth))
				gentry_leaf(.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				RWPathTransition & CSRWWrite),
							.In(					{IVEntropyWidth{1'bx}}),
							.Count(					GentryCounter));
							
	// RW seed generation scheme for bucket @ level L (L = 0...):
	//	decrypt(GentryCounter >> L)
	//	encrypt((GentryCounter >> L) + 1)
	ShiftRegister #(		.PWidth(				IVEntropyWidth),
							.Reverse(				1),
							.SWidth(				1))
				gentry_shft(.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					CSRWStartOp),
							.Enable(				RWCommandTransfer), 
							.PIn(					GentryCounter),
							.SIn(					1'b0),
							.POut(					GentryCounterShifted));
	assign	Core_RWIVIn =							(CSRWWrite) ? GentryCounterShifted + 1 : GentryCounterShifted;
	
	assign	GentryLeaf =							GentryCounter[ORAML-1:0];
	
    AddrGen #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
				rw_bid(		.Clock(					Clock),
							.Reset(					Reset),
							.Start(					CSRWStartOp), 
							.Ready(					RW_BIDInReady),
							.RWIn(					1'b0), // don't care
							.BHIn(					1'b1), // only send one command per bucket
							.leaf(					GentryLeaf),
							.CmdValid(				RW_BIDOutValid),
							.CmdReady(				RW_BIDOutReady),
							.BktIdx(				Core_RWBIDIn));
	
	assign	Core_RWCommandInValid =					RW_BIDOutValid & 		RWAuxInReady;
	assign	RWAuxInValid =							RW_BIDOutValid & 		Core_RWCommandInReady;
	assign	RW_BIDOutReady =						RWAuxInReady & 			Core_RWCommandInReady;
	
	assign	RWCommandTransfer =						Core_RWCommandInValid & Core_RWCommandInReady;
	
	// Store Gentry seeds for CC/IV unit
	// Invariant: Core_RWDataOutValid -> RWAuxOutValid
	FIFORAM		#(			.Width(					IVEntropyWidth + BIDWidth),
							.Buffering(				PathMaskBuffering * (ORAML + 1)))
				rw_H_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{Core_RWIVIn, Core_RWBIDIn}),
							.InValid(				RWAuxInValid),
							.InAccept(				RWAuxInReady),
							.OutData(				{RWBVOut, RWBIDOut),
							.OutSend(				RWAuxOutValid),
							.OutReady(				RWMaskBucketTransition));
	
	//--------------------------------------------------------------------------
	//	AES Core
	//--------------------------------------------------------------------------
	
	REWAESCore	#(			.ORAMZ(					ORAMZ),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMB(					ORAMB),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.IVEntropyWidth(		IVEntropyWidth),
							.AESWidth(				AESWidth))
				core(		.SlowClock(				Clock),
							.FastClock(				FastClock), 
							.SlowReset(				Reset),

							.ROIVIn(				Core_ROIVIn), 
							.ROBIDIn(				Core_ROBIDIn), 
							.ROCommandIn(			Core_ROCommandIn), 
							.ROCommandInValid(		Core_ROCommandInValid), 
							.ROCommandInReady(		Core_ROCommandInReady),
							
							.RWIVIn(				Core_RWIVIn), 
							.RWBIDIn(				Core_RWBIDIn), 
							.RWCommandInValid(		Core_RWCommandInValid), 
							.RWCommandInReady(		Core_RWCommandInReady),
							
							.RODataOut(				Core_RODataOut), 
							.ROCommandOut(			Core_ROCommandOut), 
							.RODataOutValid(		Core_RODataOutValid), 
							.RODataOutReady(		Core_RODataOutReady),
							
							.RWDataOut(				Core_RWDataOut), 
							.RWDataOutValid(		Core_RWDataOutValid),
							.RWDataOutReady(		RWMaskTransfer));
	
	//--------------------------------------------------------------------------
	//	RO AES Output
	//--------------------------------------------------------------------------

	ROHeaderMask
	ROHeaderMaskInValid
	ROHeaderMaskOutValid
	
	ROHeaderMaskInReady
	
	assign	Core_RODataOutReady = 					ROHeaderMaskInReady;
	
	AESHWidth =	ROHeader_AESChunks * AESWidth
	
	assign	ROHeaderMaskInValid = 					Core_ROCommandOut == PCMD_ROHeader & Core_RODataOutValid;
	
	
	
	Core_ROCommandOut
	
	FIFOShiftRound #(		.IWidth(				AESWidth),
							.OWidth(				AESHWidth))
				ro_hdr_shft(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				Core_RODataOut),
							.InValid(				ROHeaderMaskInValid),
							.InAccept(				ROHeaderMaskInReady),
							.OutData(				ROHeaderMask),
							.OutValid(				ROHeaderMaskOutValid),
							.OutReady(				));
	
	assign	ROHeader
	
	//--------------------------------------------------------------------------
	//	RW AES Output
	//--------------------------------------------------------------------------
	
	CountAlarm #(			.Threshold(				RWBkt_MaskChunks),
							.IThreshold(			0))
				rw_hdr_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				RWMaskTransfer),
							.Intermediate(			RWMaskIsHeader),
							.Done(					RWMaskBucketTransition));
	
	assign	RWMaskOut =								(RWMaskIsHeader) ? 	{	{DDRDWidth-RWHeader_RawBits-BktHLStart{1'b0}},
																			Core_RWDataOut[RWHeader_RawBits-1:0],
																			{BktHLStart{1'b0}}	} : 
																		Core_RWDataOut;
	
	assign	RWMaskTransfer =						~ROAccess & ( (BEDataOutValid & DRAMReadDataReady) | (DRAMWriteDataValid & BEDataInReady) );
	
	//--------------------------------------------------------------------------
	//	To Backend
	//--------------------------------------------------------------------------
	
	assign	BEDataOut =								(ROAccess) ? 0 : DRAMReadData ^ RWMaskOut;
	assign	BEBVOut =								(ROAccess) ? 0 : RWBVOut;
	assign	BEBIDOut =								(ROAccess) ? 0 : RWBIDOut;
	
	assign	BEDataOutValid =						(ROAccess) ? 0 : DRAMReadDataValid 	& Core_RWDataOutValid;

	assign	DRAMReadDataReady =						(ROAccess) ?  : BEDataOutReady 	& Core_RWDataOutValid;

	//--------------------------------------------------------------------------
	//	To DRAM
	//--------------------------------------------------------------------------

	assign	DRAMWriteData =							(ROAccess) ? 0 : BEDataIn ^ Core_RWDataOut;
	assign	DRAMWriteDataValid = 					(ROAccess) ? 0 : BEDataInValid 		& Core_RWDataOutValid;

	assign	BEDataInReady = 						(ROAccess) ? 0 : DRAMWriteDataReady & Core_RWDataOutValid;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
