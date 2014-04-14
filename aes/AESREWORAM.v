
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
	CSPathRead,
	
	BEDataOut, BEBVOut, BEBIDOut, BEDataOutValid, BEDataOutReady,
	BEDataIn, BEDataInValid, BEDataInReady,
	
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady
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
	
	localparam				ROSWidth =				3,
							ST_RO_Idle =			3'd0,
							ST_RO_StartRead =		3'd1,
							ST_RO_HeaderRead =		3'd2, // Masks for RO headers
							ST_RO_StartROIRead =	3'd3,
							ST_RO_ROIRead =			3'd4, // Masks for bucket of interest
							ST_RO_StartWrite =		3'd5, 
							ST_RO_HeaderWrite =		3'd6; // Masks for header writebacks	
	
	localparam				RWSWidth =				2,
							ST_RW_StartRead =		2'd0,
							ST_RW_Read =			2'd1,
							ST_RW_StartWrite =		2'd2,
							ST_RW_Write =			2'd3;
	
	localparam				AESHWidth =				ROHeader_AESChunks * AESWidth;
	
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
	
	input					CSPathRead;	
	
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
	
	// RO header mask & bucket of interest seed generation

	reg		[ROSWidth-1:0] 	CS_RO, NS_RO;
	
	wire					DRAMReadTransfer, ROCommandTransfer;
	
	wire	[DDRDWidth-1:0]	BufferedDataIn;
	wire					BufferedDataInValid, BufferedDataInReady;

	wire	[DDRDWidth-1:0]	BufferedDataOut;
	wire					BufferedDataOutValid, BufferedDataOutReady;
	wire					BufferedDataTransfer;
	
	wire 					RO_BIDInReady, RO_BIDOutValid, RO_BIDOutReady;

	wire 					RO_BIDOutValid_Needed;	
	
	wire					RODRAMChunkIsHeader, ROBucketTransition, ROPathTransition;
	
	wire	[IVEntropyWidth-1:0] RO_IVOut, BufferedIV;
	wire	[BIDWidth-1:0] 	RO_BIDOut, BufferedBID;
		
	wire					RO_LeafNextDirection;
	wire	[IVEntropyWidth-1:0] RO_IVIncrement, RO_IVNext;
		
	wire					CSROStartRead, CSROStartOp, CSROHeaderRead, CSROStartROIRead, CSROROIRead;
	
	// RW background seed generation
	
	reg		[RWSWidth-1:0] 	CS_RW, NS_RW;
	wire					CSRWStartOp, CSRWWrite;
	
	wire					RWPathTransition;
	wire					RWCommandTransfer, RMMaskReady, DataOutTransfer;

	wire	[IVEntropyWidth-1:0] GentryCounter, GentryCounterShifted, RWBVOut;

	wire	[BIDWidth-1:0] 	RWBIDOut;
	
	wire	[ORAML-1:0]		GentryLeaf;

	wire					RWAuxInValid, RWAuxInReady;
	wire					RWAuxOutValid;		
	
	wire					RW_BIDInReady, RW_BIDOutValid, RW_BIDOutReady;	
	
	wire					MaskIsHeader, DataOutBucketTransition;	
	
	// RO mask shifting/buffering
	
	wire					ROMaskShiftInValid, ROMaskShiftInReady;
	wire	[ROHeader_RawBits-1:0] ROMaskShiftOutData;
	wire					ROMaskShiftOutValid, ROMaskShiftOutReady;
	
	wire	[ROHeader_RawBits-1:0] ROMaskBufOutData;
	wire					ROMaskBufOutValid, ROMaskBufOutReady;

	wire					ROIMaskShiftInValid, ROIMaskShiftInReady;
	wire	[DDRDWidth-1:0]	ROIMaskShiftOutData;
	wire					ROIMaskShiftOutValid, ROIMaskShiftOutReady;	
	
	// ROI (Bucket of interest handling)
	
	genvar 					i;
	wire	[ORAMZ-1:0]		ROI_UMatches;
	
	wire					ProcessingLastHeader;	
	wire					ROI_ProcessBucket, ROI_BucketWasFound;
	wire 					ROI_FoundBucket, ROI_NotFoundBucket;
	
	wire	[BigVWidth-1:0] DataOutV;
	wire	[BigUWidth-1:0] DataOutU;
	
	wire	[IVEntropyWidth-1:0] ROI_IV;
	wire	[BIDWidth-1:0]	ROI_BID;
	wire	[BigUWidth-1:0]	ROI_U;
	wire	[BigVWidth-1:0]	ROI_V;
	
	wire	[DDRDWidth-1:0]	ROIData;
	wire					ROIDataInValid, ROIDataInReady;	
	wire					ROIDataValid, ROIDataReady;

	wire					ROI_Rebuffer1Complete, ROI_Rebuffer2Complete;	
	
	// Output Data/Mask mixing
	
	wire	[DDRDWidth-1:0]	ROHeaderMask;
	wire	[DDRDWidth-1:0]	RWBGHeaderMask, RWBGDataMask;
	wire	[DDRDWidth-1:0]	ROIHeaderMask, ROIDataMask;
	wire	[DDRDWidth-1:0]	RWHeaderMask, RWDataMask;
	wire	[DDRDWidth-1:0]	Mask;
	
	wire					BDataValid_Needed, RMMaskValid_Needed, ROMaskValid_Needed;

	wire	[BktHSize_ValidBits-1:0] RecomputedValidBits;
	wire	[BigUWidth+BktHSize_ValidBits-1:0] RecomputedVU;
	
	wire	[DDRDWidth-1:0]	DataOut_Unmask, DataOut_Process1, DataOut_Process2, DataOut;
	wire					DataOutValid, DataOutReady;
	
	wire					ROMask_Needed, ROIMask_Needed, RMMask_Needed;
	
	wire					ServingROI;
	
	//--------------------------------------------------------------------------
	//	Simulation Checks
	//--------------------------------------------------------------------------
		
	`ifdef SIMULATION
		initial begin	
			if ((PathMaskBuffering * RWPath_MaskChunks) > 512) begin
				$display("[%m @ %t] ERROR: The mask header FIFO is too shallow for the Mask data FIFO (sized @ 512x512).", $time);
				$stop;
			end
		
			if (BktHSize_DRBursts > 1) begin
				$display("[%m @ %t] ERROR: Not supported yet.", $time);
				$stop;
			end		
			
			if (EnableIV) begin
				$display("[%m @ %t] ERROR: Not supported yet.", $time);
				$stop;
			end
		end
		
		always @(posedge Clock) begin
			if (DataOutTransfer & ~RWAuxOutValid) begin
				$display("[%m @ %t] ERROR: Mask fifo didn't have data on a transfer.", $time);
				$stop;
			end
			
			if (ROIDataInValid & ~ROIDataInReady) begin
				$display("[%m @ %t] ERROR: Bucket of interest FIFO overflow.", $time);
				$stop;
			end
			
			if (DataOutTransfer	& MaskIsHeader & |(ROHeaderMask & RWBGHeaderMask)) begin
				$display("[%m @ %t] ERROR: RO and RW masks overlapped on header flit.", $time);
				$stop;			
			end
		end
	`endif

	//--------------------------------------------------------------------------
	//	Control logic
	//--------------------------------------------------------------------------

	reg	ROAccess_Delayed;
	
	always @(posedge Clock) begin
		ROAccess_Delayed <=							ROAccess;
	end
	
	//--------------------------------------------------------------------------
	//	RO AES Input
	//--------------------------------------------------------------------------

	// Generate the masks for RO headers and ROI buckets of interest
	
	assign	DRAMReadTransfer =						DRAMReadDataValid & DRAMReadDataReady;
	
	assign	CSROStartRead =							CS_RO == ST_RO_StartRead;
	assign	CSROStartOp =							CSROStartRead | CS_RO == ST_RO_StartWrite;
	assign	CSROHeaderRead =						CS_RO == ST_RO_HeaderRead;
	assign	CSROStartROIRead =						CS_RO == ST_RO_StartROIRead;
	assign	CSROROIRead =							CS_RO == ST_RO_ROIRead;
	
	always @(posedge Clock) begin
		if (Reset) CS_RO <= 						ST_RO_Idle;
		else CS_RO <= 								NS_RO;
	end

	always @( * ) begin
		NS_RO = 									CS_RO;
		case (CS_RO)
			ST_RO_Idle :
				if (DRAMReadDataValid)
					NS_RO =							ST_RO_StartRead;
			ST_RO_StartRead :
				if (RO_BIDInReady)
					NS_RO =							ST_RO_HeaderRead;
			ST_RO_HeaderRead :
				if (ROPathTransition)
					NS_RO =							ST_RO_StartROIRead;
			ST_RO_StartROIRead : 
				if (ROCommandTransfer)
					NS_RO =							ST_RO_ROIRead;
			ST_RO_ROIRead : 
				if (ROI_Rebuffer2Complete)
					NS_RO =							ST_RO_StartWrite;
			ST_RO_StartWrite :
				if (RO_BIDInReady)
					NS_RO =							ST_RO_HeaderWrite;
			//ST_RO_HeaderWrite :
			//	if ()
			//
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
							
	CountAlarm 	#(			.Threshold(				BktSize_DRBursts))
				roi_rd(		.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				CSROROIRead & BufferedDataInValid & BufferedDataInReady),
							.Done(					ROI_Rebuffer2Complete));							

	// Adjust the gentry counter for each bucket on the RO path (this is the floor/ceiling logic)
	assign	RO_IVIncrement =						RO_IVOut + {{IVEntropyWidth-1{1'b0}}, ~RO_LeafNextDirection};
	assign	RO_IVNext = 							(CSROStartRead) ? 	GentryCounter_MemoryConsistant : 
																		{1'b0, RO_IVIncrement[IVEntropyWidth-1:1]};
	
	Register	#(			.Width(					IVEntropyWidth))
				ro_gentry(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				CSROStartRead | (CSROHeaderRead & DRAMReadTransfer)),
							.In(					RO_IVNext),
							.Out(					RO_IVOut));
	ShiftRegister #(		.PWidth(				ORAML),
							.Reverse(				1),
							.SWidth(				1))
				ro_L_shft(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					CSROStartRead),
							.Enable(				CSROHeaderRead & DRAMReadTransfer), 
							.PIn(					ROLeaf),
							.SIn(					1'b0),
							.SOut(					RO_LeafNextDirection));
							
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
							.BktIdx(				RO_BIDOut));
							
	assign	RO_BIDOutValid_Needed =					(RODRAMChunkIsHeader) ? RO_BIDOutValid : 1'b1;				
							
	assign	Core_ROCommandIn =						(CSROStartROIRead) ? 	PCMD_ROData : 	PCMD_ROHeader;
	assign	Core_ROIVIn =							(CSROROIRead) ? 		ROI_IV : 		RO_IVOut;
	assign	Core_ROBIDIn =							(CSROROIRead) ? 		ROI_BID : 		RO_BIDOut;	
	
	assign	Core_ROCommandInValid =					(CSROStartROIRead) ? 	1'b1 : 
													(CSROROIRead) ? 		1'b0 :		
																			DRAMReadDataValid & RO_BIDOutValid & 		BufferedDataInReady & 	RODRAMChunkIsHeader;
	assign	BufferedDataInValid =					(CSROStartROIRead) ? 	1'b0 : 
													(CSROROIRead) ? 		ROIDataValid : 
																			DRAMReadDataValid &	RO_BIDOutValid_Needed & Core_ROCommandInReady;

	assign	RO_BIDOutReady =						Core_ROCommandInReady & BufferedDataInReady & DRAMReadDataValid & 	RODRAMChunkIsHeader;
	assign	DRAMReadDataReady =						Core_ROCommandInReady & BufferedDataInReady & RO_BIDOutValid_Needed;
	
	assign	ROCommandTransfer =						Core_ROCommandInValid & Core_ROCommandInReady;
	
	//--------------------------------------------------------------------------
	//	Intermediate data buffers
	//--------------------------------------------------------------------------
	
	assign	BufferedDataIn =						(CSROHeaderRead) ?		{DRAMReadData, 	Core_ROIVIn, Core_ROBIDIn} : 
													(CSROROIRead) ?			{ROIData,		ROI_IV, ROI_BID} : 
													{DDRDWidth{1'bx}}; // TODO add support for header writebacks and RW writebacks
	
	// Note: This buffer is only needed because the Path Buffer is a FIFO
	FIFORAM		#(			.Width(					DDRDWidth + IVEntropyWidth + BIDWidth),
							.Buffering(				AESLatencyPlus))
				ro_int_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BufferedDataIn),
							.InValid(				BufferedDataInValid),
							.InAccept(				BufferedDataInReady),
							.OutData(				{BufferedDataOut, BufferedIV, 	BufferedBID}),
							.OutSend(				BufferedDataOutValid),
							.OutReady(				BufferedDataOutReady));	
	
	/* TODO add support for header writebacks
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
	*/
	
	//--------------------------------------------------------------------------
	//	RW AES Input
	//--------------------------------------------------------------------------
	
	// This logic generates RW masks in the background & keeps track of gentry 
	// counters
	
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
	
	// Gentry counter used to generate RW masks (at as fast a rate as possible)
	Counter		#(			.Width(					IVEntropyWidth))
				gentry_bg(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				RWPathTransition & CSRWWrite),
							.In(					{IVEntropyWidth{1'bx}}),
							.Count(					GentryCounter));
							
	// Represents the actual gentry counter of blocks stored in memory
	Counter		#(			.Width(					IVEntropyWidth))
				gentry_mem(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				~ROAccess_Delayed & ROAccess),
							.In(					{IVEntropyWidth{1'bx}}),
							.Count(					GentryCounter_MemoryConsistant));							
							
	// RW seed generation scheme for bucket @ level L (L = 0...):
	//	decrypt( GentryCounter >> L)
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
							.OutData(				{RWBVOut, RWBIDOut}),
							.OutSend(				RWAuxOutValid),
							.OutReady(				RWBucketTransition));
	
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
							.RWDataOutReady(		RMMaskReady));

	//--------------------------------------------------------------------------
	//	RO Mask Formation
	//--------------------------------------------------------------------------

	// This is technically not correct (i.e., it should depend on Core_ROCommandOut) -- but should work
	assign	Core_RODataOutReady = 					ROMaskShiftInReady & ROIMaskShiftInReady;
	
	assign	ROMaskShiftInValid = 					Core_ROCommandOut == PCMD_ROHeader & 	Core_RODataOutValid;
	assign	ROIMaskShiftInValid = 					Core_ROCommandOut == PCMD_ROData & 		Core_RODataOutValid;
	
	FIFOShiftRound #(		.IWidth(				AESWidth),
							.OWidth(				AESHWidth)) // some of these bits should get pruned by the tools
				ro_H_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				Core_RODataOut),
							.InValid(				ROMaskShiftInValid),
							.InAccept(				ROMaskShiftInReady),
							.OutData(				ROMaskShiftOutData),
							.OutValid(				ROMaskShiftOutValid),
							.OutReady(				ROMaskShiftOutReady));

	// NOTE: This is only here for throughput.  We need header writeback masks 
	// to "pile up" on a RO header writeback.  We can generate this out if 
	// needed.
	FIFORAM		#(			.Width(					ROHeader_RawBits),
							.Buffering(				ORAML + 1))
				ro_HM_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				ROMaskShiftOutData),
							.InValid(				ROMaskShiftOutValid),
							.InAccept(				ROMaskShiftOutReady),
							.OutData(				ROMaskBufOutData),
							.OutSend(				ROMaskBufOutValid),
							.OutReady(				ROMaskBufOutReady));
	
	assign	ROHeaderMask =							{	{BktHSize_RndBits-ROHeader_VUBits-IVEntropyWidth{1'b0}},
														ROMaskBufOutData, 
														{IVEntropyWidth{1'b0}}	};
	
	//--------------------------------------------------------------------------
	//	RO Identify Bucket of Interest
	//--------------------------------------------------------------------------
	
	// Note: if we don't find the bucket of interest (i.e., on a dummy access or 
	// if it was in the stash), this logic will still rebuffer/decrypt something 
	// to hide timing variations
	
	assign	DataOutV =								DataOut_Process1[BigVWidth+BktHVStart-1:BktHVStart];
	assign	DataOutU =								DataOut_Process1[BigUWidth+BktHUStart-1:BktHUStart];
	
	generate for (i = 0; i < ORAMZ; i = i + 1) begin:RO_BUCKET_OF_INTEREST
		assign	ROI_UMatches[i] =					DataOutV[i] & (ROPAddr == DataOutU[ORAMU*(i+1)-1:ORAMU*i]);
	end endgenerate
					
	CountAlarm 	#(			.Threshold(				PathSize_DRBursts - BktSize_DRBursts + 1))
				roi_dmy_cnt(.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				ROAccess & BufferedDataTransfer),
							.Done(					ProcessingLastHeader));
					
	assign	ROI_FoundBucket =						BufferedDataOutValid & (ROAccess & MaskIsHeader & |ROI_UMatches);
	assign	ROI_NotFoundBucket =					ProcessingLastHeader & ~ROI_BucketWasFound;
			
	Register	#(			.Width(					1))
				roi_found(	.Clock(					Clock),
							.Reset(					Reset |	ROI_Rebuffer1Complete),
							.Set(					ROI_FoundBucket | ROI_NotFoundBucket),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ROI_BucketWasFound));
	assign	ROI_ProcessBucket =						ROI_FoundBucket | ROI_NotFoundBucket | ROI_BucketWasFound;
							
	CountAlarm #(			.Threshold(				BktSize_DRBursts))
				roi_wr(		.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				ROIDataInValid),
							.Done(					ROI_Rebuffer1Complete));
	
	Register	#(			.Width(					IVEntropyWidth + BIDWidth + BigUWidth + BigVWidth))
				roi_info(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				ROI_FoundBucket | ROI_NotFoundBucket),
							.In(					{BufferedIV, 	BufferedBID,	DataOutU, 	DataOutV}),
							.Out(					{ROI_IV, 		ROI_BID,		ROI_U,		ROI_V}));
						
	assign	ROIDataInValid =						BufferedDataTransfer & ROI_ProcessBucket;						
							
	// Note: This buffer is only needed because the Path Buffer is a FIFO
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				BktSize_DRBursts))
				roi_P_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BufferedDataOut),
							.InValid(				ROIDataInValid),
							.InAccept(				ROIDataInReady),
							.OutData(				ROIData),
							.OutSend(				ROIDataValid),
							.OutReady(				ROIDataReady));

	assign	ROIDataReady =							CSROROIRead & BufferedDataInReady;
	
	//--------------------------------------------------------------------------
	//	RW Mask Formation
	//--------------------------------------------------------------------------
	
	FIFOShiftRound #(		.IWidth(				AESWidth),
							.OWidth(				DDRDWidth))
				roi_D_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				Core_RODataOut),
							.InValid(				ROIMaskShiftInValid),
							.InAccept(				ROIMaskShiftInReady),
							.OutData(				ROIMaskShiftOutData),
							.OutValid(				ROIMaskShiftOutValid),
							.OutReady(				ROIMaskShiftOutReady));
							
	// Masks for RW data that will only be consumed on a RW access
	assign	RWBGHeaderMask =						{	{DDRDWidth-BigLWidth-BktHLStart{1'b0}},
														Core_RWDataOut[BigLWidth-1:0],
														{BktHLStart{1'b0}}	};
	assign	RWBGDataMask =							Core_RWDataOut;
	
	// Masks for the RO bucket of interest that will be consumed on RO accesses
	assign	ROIHeaderMask =							{	{DDRDWidth-BigLWidth-BktHLStart{1'b0}},
														ROIMaskShiftOutData[BigLWidth-1:0],
														{BktHLStart{1'b0}}	};
	assign	ROIDataMask =							ROIMaskShiftOutData;
	
	//--------------------------------------------------------------------------
	//	Mask / Data Mixing & Mask Source Arbitration
	//--------------------------------------------------------------------------
	
	/* 	Mask chart
	
		RO path read:
								RO header masks		RO payload masks	RW masks
			Bucket headers: 	X
			Bucket payloads:	
			BOI header:								X (for leaves)
			BOI payload:							X
			* After BOI is read out, V & U are mixed back into header
			
		RW path read/writeback:
								RO header masks		RO payload masks	RW masks
			Bucket headers: 	X										X
			Bucket payloads:											X
	*/
	
	assign	BufferedDataTransfer =					BufferedDataOutValid & BufferedDataOutReady;

	CountAlarm 	#(			.Threshold(				ORAML + 1))
				roi_pth_cnt(.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				ROAccess & DataOutBucketTransition),
							.Done(					ROIPathTransition));
	Register #(				.Width(					1))
				roi_payload(.Clock(					Clock),
							.Reset(					Reset | (~ROIPathTransition & DataOutBucketTransition)),
							.Set(					ROIPathTransition),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ServingROI));
							
	CountAlarm #(			.Threshold(				RWBkt_MaskChunks),
							.IThreshold(			0))
				rw_hdr_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				BufferedDataTransfer),
							.Intermediate(			MaskIsHeader),
							.Done(					DataOutBucketTransition));
		
	assign	ROMask_Needed =							MaskIsHeader & ~ServingROI;
	assign	ROIMask_Needed =						ServingROI;
	assign	RMMask_Needed =							~ROAccess;
	assign	BDataValid_Needed =						BufferedDataOutValid;
	assign	RMMaskValid_Needed =					(RMMask_Needed) ? 	Core_RWDataOutValid : (ROIMask_Needed) ? ROIMaskShiftOutValid : 1'b1;
	assign	ROMaskValid_Needed =					(ROMask_Needed) ? 	ROMaskBufOutValid : 1'b1;
	
	assign	RWHeaderMask =							(ROIMask_Needed) ? 	ROIHeaderMask :	 	RWBGHeaderMask;
	assign	RWDataMask =							(ROIMask_Needed) ? 	ROIDataMask : 		RWBGDataMask;

	assign	Mask =									(MaskIsHeader) ? ROHeaderMask | RWHeaderMask : RWDataMask;

	assign	DataOut_Unmask =						BufferedDataOut ^ Mask;
	
	//--------------------------------------------------------------------------
	//	Output Arbitration
	//--------------------------------------------------------------------------	
	
	// When we detect a read bucket has never been written, mark its valid bits as invalid
	assign	RecomputedValidBits =					(MaskIsHeader & BufferedIV == 0) ? {{BktHWaste_ValidBits{1'b0}}, {BigVWidth{1'b0}}} : DataOut_Unmask[BktHUStart-1:BktHVStart]; 
	assign	DataOut_Process1 =						{	
														DataOut_Unmask[DDRDWidth-1:BktHUStart],
														RecomputedValidBits,
														DataOut_Unmask[BktHVStart-1:0]	
													};

	// To keep the interface "clean", and to make the CoherenceController 
	// simpler, we give a completely decrypted header for the bucket of 
	// interest
	assign	RecomputedVU =							(MaskIsHeader & ServingROI) ? {ROI_U, {BktHWaste_ValidBits{1'b0}}, ROI_V} :	DataOut_Process1[BktHLStart-1:BktHVStart];
	assign	DataOut_Process2 =						{	
														DataOut_Process1[DDRDWidth-1:BktHLStart],
														RecomputedVU,
														DataOut_Unmask[BktHVStart-1:0]
													};

	// Finally, we're done
	assign	DataOut =								DataOut_Process2;
	
	// Standard RV FIFO arbitration: 3 input sources -> 1 output source
	assign	DataOutValid =							 BDataValid_Needed & 	ROMaskValid_Needed & RMMaskValid_Needed & 	(RMMask_Needed | ROIMask_Needed | ROMask_Needed);
	assign	BufferedDataOutReady =					 DataOutReady & 		ROMaskValid_Needed & RMMaskValid_Needed;
	assign	RMMaskReady =							(DataOutReady & 		ROMaskValid_Needed & BDataValid_Needed) & 	RMMask_Needed;
	assign	ROIMaskShiftOutReady =					(DataOutReady & 		ROMaskValid_Needed & BDataValid_Needed) & 	ROIMask_Needed;
	assign	ROMaskBufOutReady =						 DataOutReady & 		RMMaskValid_Needed & BDataValid_Needed & 	ROMask_Needed;
	
	assign	DataOutReady =							(CSPathRead) ? BEDataOutReady : DRAMWriteDataReady;
	assign	DataOutTransfer =						DataOutValid & DataOutReady;
	
	assign	RWBucketTransition =					ROMask_Needed & DataOutBucketTransition;		
	
	//--------------------------------------------------------------------------
	//	Path Read Interface
	//--------------------------------------------------------------------------
	
	assign	BEDataOut =								DataOut;
	assign	BEBVOut =								(ROAccess) ? 0 : RWBVOut;
	assign	BEBIDOut =								(ROAccess) ? 0 : RWBIDOut;
	assign	BEDataOutValid =						CSPathRead & DataOutValid;
	
	//--------------------------------------------------------------------------
	//	Path Writeback Interface
	//--------------------------------------------------------------------------

	assign	DRAMWriteData =							DataOut;
	assign	DRAMWriteDataValid = 					CSPathRead & DataOutValid;

	assign	BEDataInReady = 						1'b0;//(ROAccess) ? 0 : DRAMWriteDataReady & Core_RWDataOutValid;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
