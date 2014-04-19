
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

	ROPAddr, ROLeaf,

	ROIBVOut, ROIBIDOut,
	
	BEDataOut, BEDataOutValid,
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
	
	localparam				RW_R_Chunk = 			PathSize_DRBursts,
							RW_W_Chunk = 			PathSize_DRBursts,
							RO_R_Chunk = 			(ORAML+1) * BktHSize_DRBursts + BktSize_DRBursts,
							RO_W_Chunk = 			(ORAML+1) * BktHSize_DRBursts;
		
	localparam				ROSWidth =				3,
							ST_RO_Idle =			3'd0,
							ST_RO_StartRead =		3'd1,
							ST_RO_Read =			3'd2, // Masks for RO headers
							ST_RO_ROIReadCommand =	3'd3,
							ST_RO_ROIReadLocked =	3'd4,
							ST_RO_ROIRead =			3'd5, // Masks for bucket of interest
							ST_RO_StartWrite =		3'd6, 
							ST_RO_Write =			3'd7; // Masks for header writebacks

	localparam				COSWidth =				2,
							ST_CO_Read =			2'd0,
							ST_CO_ROI =				2'd1,
							ST_CO_Write =			2'd2;	
	
	localparam				AESHWidth =				ROHeader_AESChunks * AESWidth,
							BDWidth =				DDRDWidth + IVEntropyWidth + BIDWidth + 1;
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, FastClock, Reset;

	//--------------------------------------------------------------------------
	//	Command Interface
	//--------------------------------------------------------------------------
	
	input	[ORAMU-1:0]		ROPAddr;
	input	[ORAML-1:0]		ROLeaf;
	
	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------

	// These signals will be valid from when the bucket of interest is found to 
	// the end of the header writeback
	output	[IVEntropyWidth-1:0] ROIBVOut;
	output	[BIDWidth-1:0]	ROIBIDOut;
	
	output	[DDRDWidth-1:0] BEDataOut;	
	output					BEDataOutValid;
	
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
	
	// Global control
	
	wire					PathRead, ROAccess, RWAccess, PathWriteback;	
	
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

	wire	[IVEntropyWidth-1:0] GentryCounter_MemoryConsistant;
	
	wire	[BDWidth-1:0]	BufferedDataIn_Wide, BufferedDataOut_Wide;
	wire					BufferedDataInValid, BufferedDataInReady;
	wire					BufferedDataOutValid, BufferedDataOutReady;
	
	wire					BufferedDataOutReady_Read, BufferedDataTransfer_Read;
	wire					BufferedDataOutReady_Write, BufferedDataTransfer_Write;	
	
	wire	[DDRDWidth-1:0]	BufferedDataOut;
	wire					BufferedDataTransfer;
	
	wire					BucketNotYetWritten, BufferedIVNotValid;
	
	wire	[IVEntropyWidth-1:0] BufferedROIVOutData;
	wire					BufferedROIVInValid, BufferedROIVInReady;
	wire					BufferedROIVOutValid, BufferedROIVOutReady;	
	
	wire	[IVEntropyWidth-1:0] WritebackROIVOutData;
	wire					WritebackROIVInReady, WritebackROIVOutValid, WritebackROIVOutReady;
	
	wire 					RO_BIDInReady, RO_BIDOutValid, RO_BIDOutReady;

	wire 					RO_BIDOutValid_Needed;	
	
	wire					RODRAMChunkIsHeader, ROBucketTransition, ROPathTransition;
	
	wire	[IVEntropyWidth-1:0] RO_GentryIV, BufferedIV;
	wire	[BIDWidth-1:0] 	RO_BIDOut, BufferedBID;
	
	wire	[IVEntropyWidth-1:0] RO_ExternalIV, RO_UpdatedExternalIV, RW_UpdatedExternalIV;
	
	wire					RO_LeafNextDirection;
	wire	[IVEntropyWidth-1:0] RO_IVIncrement, RO_IVNext;
		
	wire					CSROIdle, CSROStartRead, CSROStartOp, CSRORead, CSROROIReadCommand, CSROROIRead, CSROWrite;
	
	wire					FinishWBIn, HWBPathTransition, RWWBPathTransition;
	
	// RO mask shifting/buffering
	
	wire					ROMaskShiftInValid, ROMaskShiftInReady;
	wire	[ROHeader_RawBits-1:0] ROMaskShiftOutData;
	wire					ROMaskShiftOutValid, ROMaskShiftOutReady;
	
	wire	[ROHeader_RawBits-1:0] ROMaskBufOutData;
	wire					ROMaskBufOutValid, ROMaskBufOutReady;

	wire					ROIMaskShiftInValid, ROIMaskShiftInReady;
	wire	[DDRDWidth-1:0]	ROIMaskShiftOutData;
	wire					ROIMaskShiftOutValid, ROIMaskShiftOutReady;	
	
	// RW background mask generation
		
	wire					RW_BIDOutValid, RW_BIDOutReady;
	wire					RWSend, RWReceive;
	wire					MaskFIFOReady;
	wire	[IFMWidth-1:0]	MasksInFlight;
	
	// ROI (Bucket of interest handling)
	
	genvar 					i;
	wire	[ORAMZ-1:0]		ROI_UMatches;
	
	wire					ProcessingLastHeader;	
	wire					ROI_BufferBucket, ROI_HeaderValid, ROI_BucketLoad, ROI_BucketLoaded;
	wire 					ROI_FoundBucket, ROI_NotFoundBucket, ROI_HeaderLoad;
	
	wire	[BigVWidth-1:0] DataOutV;
	wire	[BigUWidth-1:0] DataOutU;
	
	wire	[IVEntropyWidth-1:0] ROI_GentryIV;
	wire	[BIDWidth-1:0]	ROI_BID;
	wire	[BigUWidth-1:0]	ROI_U;
	wire	[BigVWidth-1:0]	ROI_V;
	
	wire	[DDRDWidth-1:0]	ROIData;
	wire					ROIDataInValid, ROIDataInReady;	
	wire					ROIDataValid, ROIDataReady;

	wire					ROI_Rebuffer1Complete, ROI_Rebuffer2Complete;	
	
	// Output control

	reg		[COSWidth-1:0]	CS_CO, NS_CO;
		
	wire					CSCOWrite, CSCOROI;
	wire					StartROI, FinishROI, FinishWBOut;

	wire					HWBPathTransitionOut, RWWBPathTransitionOut;
	
	// Output Data/Mask mixing
	
	wire	[DDRDWidth-1:0]	ROHeaderMask;
	wire	[DDRDWidth-1:0]	RWBGHeaderMask, RWBGDataMask;
	wire	[DDRDWidth-1:0]	ROIHeaderMask, ROIDataMask;
	wire	[DDRDWidth-1:0]	GentryHeaderMask, GentryDataMask;
	wire	[DDRDWidth-1:0]	Mask;
	
	wire					BDataValid_Needed, RMMaskValid_Needed, ROMaskValid_Needed;

	wire	[BktHSize_ValidBits-1:0] RecomputedValidBits;
	wire	[BigUWidth+BktHSize_ValidBits-1:0] RecomputedVU;
	wire	[IVEntropyWidth-1:0] UpdatedExternalIV;
	
	wire	[DDRDWidth-1:0]	DataOut_Unmask, DataOut_Read1, DataOut_Read, DataOut_Write;
	wire					DataOutValid, DataOutReady;
	
	wire					ROMask_Needed, ROIMask_Needed, RMMask_Needed;
	
	// Derived signals / timing related
	
	reg						RWAccess_Delayed;

	wire 	[DDRDWidth-1:0]	BEDataIn_Inner;
	wire					BEDataInValid_Inner;

	wire	[DDRDWidth-1:0]	BEDataOut_Pre;
	wire					BEDataOutValid_Pre;
	
	//--------------------------------------------------------------------------
	//	Initial state
	//--------------------------------------------------------------------------	
	
	`ifndef ASIC
		initial begin
			CS_RO = ST_RO_Idle;
			CS_CO = ST_CO_Read;
		end
	`endif
	
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
				//$stop;
			end
		end
		
		always @(posedge Clock) begin
			if (BEDataOutValid) begin
				$display("[%m @ %t] Sending Backend: %x (RO: %b, ROI: %b) ", $time, BEDataOut, ROAccess, CSCOROI);
			end
			if (DRAMWriteDataValid & DRAMWriteDataReady) begin
				$display("[%m @ %t] Writing DRAM:    %x (RO: %b) ", $time, DRAMWriteData, ROAccess);
			end
			
			
			if (DRAMReadDataValid & DRAMReadDataReady) begin
				$display("[%m @ %t] Reading DRAM:    %x (ROAccess = %b) ", $time, DRAMReadData, ROAccess);
			end
			
			if (DataOutTransfer) begin
				$display("[%m @ %t] Outputting mask: %x (ROAccess = %b, BOI = %b, Writing = %b) ", $time, Mask, ROAccess, CSCOROI, CSCOWrite);
			end
			
		end
		
		always @(posedge Clock) begin
			if (BufferedDataInValid & ~BufferedDataInReady) begin
				$display("[%m @ %t] WARNING: Data buffer is full; you may want to make it a bit larger.", $time);
			end
			if (BufferedDataInValid & ~BufferedDataInReady & CSROROIRead) begin // "may" happen because data_buf has no backpressure in this state but should never happen
				$display("[%m @ %t] ERROR: Data buffer overflow.", $time);
			end
			
			if (BufferedROIVOutReady & ~BufferedROIVOutValid) begin
				$display("[%m @ %t] ERROR: Header WB fifo didn't have data on a transfer.", $time);
				$stop;
			end
			
			if (~CSROWrite & BufferedDataOutValid & MaskIsHeader & ^DataOutV === 1'bx) begin // TODO use better signal than CSROWrite
				$display("[%m @ %t] ERROR: Valid bit was X.", $time);
				$stop;	
			end

			if (ROIDataInValid & ~ROIDataInReady) begin
				$display("[%m @ %t] ERROR: Bucket of interest FIFO overflow.", $time);
				$stop;
			end
			if (~ROIDataValid & ROIDataReady) begin
				$display("[%m @ %t] ERROR: Bucket of interest FIFO didn't have data.", $time);
				$stop;
			end			
			
			if (DataOutTransfer	& MaskIsHeader & |(ROHeaderMask & RWBGHeaderMask)) begin
				$display("[%m @ %t] ERROR: RO and RW masks overlapped on header flit.", $time);
				$stop;			
			end
			
			if (BufferedROIVInValid & ~BufferedROIVInReady) begin
				$display("[%m @ %t] ERROR: IV FIFO for header writebacks overflowed.", $time);
				$stop;
			end
			if (BufferedROIVInValid & ~WritebackROIVInReady) begin
				$display("[%m @ %t] ERROR: External IV FIFO writebacks overflowed.", $time);
				$stop;
			end
			if (WritebackROIVOutReady & ~WritebackROIVOutValid) begin
				$display("[%m @ %t] ERROR: External IV FIFO didn't have data on a transfer.", $time);
				$stop;
			end			
		end
	`endif

	//--------------------------------------------------------------------------
	//	Control logic
	//--------------------------------------------------------------------------

	always @(posedge Clock) begin
		RWAccess_Delayed <=							RWAccess;
	end
	
	//--------------------------------------------------------------------------
	//	System Control Logic
	//--------------------------------------------------------------------------

	// TODO merge some of the other count alarms in with this module
	
	REWStatCtr	#(			.ORAME(					ORAME),
							.RW_R_Chunk(			RW_R_Chunk),
							.RW_W_Chunk(			RW_W_Chunk),
							.RO_R_Chunk(			RO_R_Chunk),
							.RO_W_Chunk(			RO_W_Chunk),
							.LatchOutput(			1))
				rw_stat(	.Clock(					Clock),
							.Reset(					Reset),
							
							.RW_R_Transfer(			RWAccess & PathRead & 		BEDataOutValid),
							.RW_W_Transfer(			RWAccess & PathWriteback & 	DRAMWriteDataValid & 	DRAMWriteDataReady),
							.RO_R_Transfer(			ROAccess & PathRead & 		BEDataOutValid),
							.RO_W_Transfer(			ROAccess & PathWriteback & 	DRAMWriteDataValid & 	DRAMWriteDataReady),
							
							.ROAccess(				ROAccess),
							.RWAccess(				RWAccess),
							.Read(					PathRead),
							.Writeback(				PathWriteback),
							
							.RW_R_DoneAlarm(		), 
							.RW_W_DoneAlarm(		RWWBPathTransitionOut), 
							.RO_R_DoneAlarm(		), 
							.RO_W_DoneAlarm(		HWBPathTransitionOut),
							
							.RW_R_Ctr(				RW_R_Ctr), // TODO maybe do something with these signals?
							.RW_W_Ctr(				RW_W_Ctr),
							.RO_R_Ctr(				RO_R_Ctr),
							.RO_W_Ctr(				RO_W_Ctr));
	
	//--------------------------------------------------------------------------
	//	RO AES Input
	//--------------------------------------------------------------------------

	// Generate the masks for RO headers and ROI buckets of interest
	
	assign	DRAMReadTransfer =						DRAMReadDataValid & DRAMReadDataReady;
	
	assign	CSROIdle =								CS_RO == ST_RO_Idle;
	assign	CSROStartRead =							CS_RO == ST_RO_StartRead;
	assign	CSROStartOp =							CSROStartRead | CS_RO == ST_RO_StartWrite;
	assign	CSRORead =								CS_RO == ST_RO_Read; // TODO make name more general
	assign	CSROROIReadCommand =					CS_RO == ST_RO_ROIReadCommand;
	assign	CSROROIRead =							CS_RO == ST_RO_ROIRead;
	assign	CSROWrite =								CS_RO == ST_RO_Write;
	
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
					NS_RO =							ST_RO_Read;
			ST_RO_Read :
				if (ROPathTransition & ROAccess)
					NS_RO =							ST_RO_ROIReadCommand;
				else if (ROPathTransition & RWAccess)
					NS_RO =							ST_RO_StartWrite;
			ST_RO_ROIReadCommand : 
				if (ROCommandTransfer)
					NS_RO =							ST_RO_ROIReadLocked;
			ST_RO_ROIReadLocked : 
				if (ROI_BucketLoaded)
					NS_RO =							ST_RO_ROIRead;
			ST_RO_ROIRead : 
				if (ROI_Rebuffer2Complete)
					NS_RO =							ST_RO_StartWrite;
			ST_RO_StartWrite :
				if (RO_BIDInReady)
					NS_RO =							ST_RO_Write;
			ST_RO_Write :
				if (FinishWBIn)
					NS_RO =							ST_RO_Idle;
		endcase
	end	
	
	// Read counters
	CountAlarm 	#(			.Threshold(				BktSize_DRBursts),
							.IThreshold(			0))
				ro_hdr_cnt(	.Clock(					Clock),
							.Reset(					Reset | CSROStartOp), 
							.Enable(				DRAMReadTransfer),
							.Intermediate(			RODRAMChunkIsHeader),
							.Done(					ROBucketTransition));
	CountAlarm 	#(			.Threshold(				ORAML + 1))
				ro_pth_cnt(	.Clock(					Clock), 
							.Reset(					Reset | CSROStartOp), 
							.Enable(				ROBucketTransition),
							.Done(					ROPathTransition));
	CountAlarm 	#(			.Threshold(				BktSize_DRBursts))
				roi_rd(		.Clock(					Clock),
							.Reset(					Reset | CSROStartOp), 
							.Enable(				CSROROIRead & BufferedDataInValid & BufferedDataInReady),
							.Done(					ROI_Rebuffer2Complete));		
							
	// Writeback counters
	CountAlarm 	#(			.Threshold(				ORAML + 1))
				hwb_cnt(	.Clock(					Clock), 
							.Reset(					Reset | CSROStartOp), 
							.Enable(				DRAMWriteDataValid & DRAMWriteDataReady),
							.Done(					HWBPathTransition));
	CountAlarm 	#(			.Threshold(				PathSize_DRBursts))
				rwwb_cnt(	.Clock(					Clock), 
							.Reset(					Reset | CSROStartOp), 
							.Enable(				DRAMWriteDataValid & DRAMWriteDataReady),
							.Done(					RWWBPathTransition));							
	assign	FinishWBIn =							(ROAccess) ? HWBPathTransition : RWWBPathTransition;

	assign	RO_ExternalIV = 						DRAMReadData[IVEntropyWidth-1:0];
	
	// Represents the actual gentry counter of blocks stored in memory
	Counter		#(			.Width(					IVEntropyWidth))
				gentry_mem(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				RWAccess_Delayed & ROAccess),
							.In(					{IVEntropyWidth{1'bx}}),
							.Count(					GentryCounter_MemoryConsistant));	
	
	// Adjust the gentry counter for each bucket on the RO path (this is the floor/ceiling logic)
	assign	RO_IVIncrement =						RO_GentryIV + {{IVEntropyWidth-1{1'b0}}, ~RO_LeafNextDirection};
	assign	RO_IVNext = 							(CSROStartRead) ? GentryCounter_MemoryConsistant : {1'b0, RO_IVIncrement[IVEntropyWidth-1:1]};
	
	Register	#(			.Width(					IVEntropyWidth))
				ro_gentry(	.Clock(					Clock),
							.Reset(					1'b0),
							.Set(					1'b0),
							.Enable(				CSROStartRead | (CSRORead & ROCommandTransfer)),
							.In(					RO_IVNext),
							.Out(					RO_GentryIV));
	ShiftRegister #(		.PWidth(				ORAML),
							.Reverse(				1),
							.SWidth(				1))
				ro_L_shft(	.Clock(					Clock), 
							.Reset(					1'b0), 
							.Load(					CSROStartRead),
							.Enable(				CSRORead & ROCommandTransfer), 
							.PIn(					ROLeaf),
							.SIn(					1'b0),
							.SOut(					RO_LeafNextDirection));
							
    AddrGen 	#(			.ORAMB(					ORAMB),
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
							
	assign	Core_ROCommandIn =						(CSROROIReadCommand) ? 	PCMD_ROData : 	PCMD_ROHeader;
	assign	Core_ROIVIn =							(CSRORead) ?			RO_ExternalIV :
													(CSROROIReadCommand) ? 	ROI_GentryIV :
																			BufferedROIVOutData;
	assign	Core_ROBIDIn =							(CSROROIReadCommand) ? 	ROI_BID : 		RO_BIDOut;
	
	assign	Core_ROCommandInValid =					(CSROROIReadCommand) ? 	ROI_HeaderValid : 
													(CSROROIRead) ? 		1'b0 :
													(CSROWrite) ? 			RO_BIDOutValid :
																			DRAMReadDataValid & RO_BIDOutValid & 		BufferedDataInReady & 	RODRAMChunkIsHeader;
	assign	BufferedDataInValid =					(CSROROIReadCommand) ? 	1'b0 : 
													(CSROROIRead) ? 		1'b1 : 
													(CSROWrite) ?			BEDataInValid_Inner : 
																			DRAMReadDataValid &	RO_BIDOutValid_Needed & Core_ROCommandInReady;

	assign	RO_BIDOutReady =						(CSROWrite) ?			Core_ROCommandInReady :
																			DRAMReadDataValid & Core_ROCommandInReady & BufferedDataInReady &	RODRAMChunkIsHeader;
	
	assign	DRAMReadDataReady =						CSRORead & Core_ROCommandInReady & BufferedDataInReady & RO_BIDOutValid_Needed;
	
	assign	ROCommandTransfer =						Core_ROCommandInValid & Core_ROCommandInReady;
	
	//--------------------------------------------------------------------------
	//	Intermediate data buffer
	//--------------------------------------------------------------------------
	
	// Use the Gentry version # to determine if we have ever written to this 
	// bucket before.  If not, treat the whole bucket as invalid.
	assign	BucketNotYetWritten =					RO_GentryIV == 0;
	
	assign	BufferedDataIn_Wide =					(CSRORead) ?			{DRAMReadData, 	RO_GentryIV, 			Core_ROBIDIn,	BucketNotYetWritten} : 
													(CSROROIRead) ?			{ROIData,		ROI_GentryIV, 			ROI_BID,		BucketNotYetWritten} : 
																			{BEDataIn_Inner,{IVEntropyWidth{1'bx}}, RO_BIDOut,		1'b0}; // header WB + RW writeback
	
	// Note: This buffer is only needed because the Path Buffer is a FIFO
	generate if (Overclock) begin:BRAM_DATABUFF
		wire	BufferedDataFull;
		
		assign	BufferedDataInReady =				~BufferedDataFull;
		AESIntDataBuff data_buf(.clk(				Clock), 
							.din(					BufferedDataIn_Wide), 
							.wr_en(					BufferedDataInValid), 
							.full(					BufferedDataFull), 
							.dout(					BufferedDataOut_Wide), 
							.valid(					BufferedDataOutValid),
							.rd_en(					BufferedDataOutReady));
	end else begin:LUTRAM_DATABUFF
		FIFORAM	#(			.Width(					BDWidth),
							.Buffering(				AESLatencyPlus))
				data_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BufferedDataIn_Wide),
							.InValid(				BufferedDataInValid),
							.InAccept(				BufferedDataInReady),
							.OutData(				BufferedDataOut_Wide),
							.OutSend(				BufferedDataOutValid),
							.OutReady(				BufferedDataOutReady));		
	end endgenerate
	
	assign	{BufferedDataOut, BufferedIV, BufferedBID, BufferedIVNotValid} = BufferedDataOut_Wide;
	assign	BufferedROIVInValid =					Core_ROCommandInValid & CSRORead;
	
	//--------------------------------------------------------------------------
	//	Intermediate external IV buffers
	//--------------------------------------------------------------------------	
	
	// If BucketNotYetWritten, RO_UpdatedExternalIV is XX on ROAccess so to make 
	// thing simple, we always just increment it by the same amount.  On A 
	// RWAccess, we must set to something ...
	assign	RO_UpdatedExternalIV =					RO_ExternalIV + ROHeader_AESChunks;
	assign	RW_UpdatedExternalIV =					(RWAccess & BucketNotYetWritten) ? {IVEntropyWidth{1'b0}} : RO_UpdatedExternalIV;
	
	FIFORAM		#(			.Width(					IVEntropyWidth),
							.Buffering(				ORAML + 1))
				hwb_ivc_buf(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				RW_UpdatedExternalIV),
							.InValid(				BufferedROIVInValid),
							.InAccept(				BufferedROIVInReady),
							.OutData(				BufferedROIVOutData),
							.OutSend(				BufferedROIVOutValid),
							.OutReady(				BufferedROIVOutReady));
	
	assign	BufferedROIVOutReady =					CSROWrite & ROCommandTransfer;
	
	/* This is a "lazy" design -- we could have made hwb_ivc_buf a RAM and gone 
	   through it twice.  Two comments to make us not care:
	   1.) This second FIFO is very cheap: 32dx64w bits of LUT RAM.
	   2.) The RAM alternative may actually add some cycles to the critical path 
	       when IV == 0.  Added delay = time in between AESCore generating the 
		   first mask & hwb_ivc_buf writing the last command (= about 10 cycles 
		   when L = 32). 
	   NOTE 2: [ASIC] we should implement as RAM for ASIC ... */
	FIFORAM		#(			.Width(					IVEntropyWidth),
							.Buffering(				ORAML + 1))
				hwb_ivo_buf(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BufferedROIVOutData),
							.InValid(				BufferedROIVOutValid & BufferedROIVOutReady),
							.InAccept(				WritebackROIVInReady),
							.OutData(				WritebackROIVOutData),
							.OutSend(				WritebackROIVOutValid),
							.OutReady(				WritebackROIVOutReady));

	assign	WritebackROIVOutReady =					CSCOWrite & MaskIsHeader & DataOutTransfer;
	
	//--------------------------------------------------------------------------
	//	RW AES Input
	//--------------------------------------------------------------------------
	
	GentrySeedGenerator	#(	.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
				gentry_rw(	.Clock(					Clock),
							.Reset(					Reset),
							.OutIV(					Core_RWIVIn), 
							.OutBID(				Core_RWBIDIn), 
							.OutValid(				RW_BIDOutValid), 
							.OutReady(				RW_BIDOutReady));
	
	assign	Core_RWCommandInValid =					RW_BIDOutValid & 		MaskFIFOReady;
	assign	RW_BIDOutReady =						Core_RWCommandInReady &	MaskFIFOReady;
	
	assign	RWSend =								Core_RWCommandInValid & Core_RWCommandInReady;
	assign	MaskFIFOReady =							MasksInFlight != InFlightMaskLimit;
	
	UDCounter	#(			.Width(					IFMWidth),
							.Initial(				{IFMWidth{1'b0}}))
				mask_count(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Up(					RWSend),
							.Down(					RWReceive),
							.In(					{IFMWidth{1'bx}}),
							.Count(					MasksInFlight));
	
	assign	RWReceive =								RWAccess & MaskIsHeader & BufferedDataTransfer;
	
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
	//	RO Mask Assembly (Shifts and Buffers)
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
	//	Output Data Arbitration
	//--------------------------------------------------------------------------
	
	/* 	Mask chart
	
		RO path read:
								RO header masks		RO payload masks	RW masks
			Bucket headers: 	X
			Bucket payloads:	
			BOI header:								X (for leaves)
			BOI payload:							X
			* After BOI is read out, V & U are mixed back into header
			
		RO header writeback:	
								RO header masks		RO payload masks	RW masks
			Bucket headers: 	X
			
		RW path read/writeback:
								RO header masks		RO payload masks	RW masks
			Bucket headers: 	X										X
			Bucket payloads:											X
	*/

	assign	BufferedDataTransfer =					BufferedDataOutValid & BufferedDataOutReady;
	assign	BufferedDataTransfer_Write =			BufferedDataOutValid & BufferedDataOutReady_Write;
	assign	BufferedDataTransfer_Read =				BufferedDataOutValid & BufferedDataOutReady_Read;
	
	assign	CSCOROI =								CS_CO == ST_CO_ROI;	
	assign	CSCOWrite =								CS_CO == ST_CO_Write;
		
	always @(posedge Clock) begin
		if (Reset) CS_CO <= 						ST_CO_Read;
		else CS_CO <= 								NS_CO;
	end
	
	always @( * ) begin
		NS_CO = 									CS_CO;
		case (CS_CO)
			ST_CO_Read :
				if (StartROI & ROAccess)
					NS_CO =							ST_CO_ROI;
				else if (StartROI & RWAccess)
					NS_CO =							ST_CO_Write;
			ST_CO_ROI :
				if (FinishROI)
					NS_CO =							ST_CO_Write;
			ST_CO_Write :
				if (FinishWBOut)
					NS_CO =							ST_CO_Read;
		endcase
	end
	
	CountAlarm 	#(			.Threshold(				PathSize_DRBursts - BktSize_DRBursts + 1))
				roi_dmy_cnt(.Clock(					Clock), 
							.Reset(					Reset | FinishWBOut), 
							.Enable(				ROAccess & BufferedDataTransfer_Read),
							.Done(					ProcessingLastHeader));	
	CountAlarm 	#(			.Threshold(				ORAML + 1))
				roi_pth_cnt(.Clock(					Clock), 
							.Reset(					Reset | FinishWBOut), 
							.Enable(				BufferedDataBucketTransition),
							.Done(					StartROI));
							
	assign	FinishROI =								~StartROI & CSCOROI & BufferedDataBucketTransition; // after one more bucket
	assign	FinishWBOut =							(ROAccess) ? HWBPathTransitionOut : RWWBPathTransitionOut;
	
	CountAlarm #(			.Threshold(				RWBkt_MaskChunks),
							.IThreshold(			0))
				rw_hdr_cnt(	.Clock(					Clock),
							.Reset(					Reset | FinishWBOut),
							.Enable(				BufferedDataTransfer),
							.Intermediate(			MaskIsHeader_Pre),
							.Done(					BufferedDataBucketTransition));
	assign	MaskIsHeader =							(ROAccess) ? MaskIsHeader_Pre | CSCOWrite : MaskIsHeader_Pre;	
		
	//--------------------------------------------------------------------------
	//	RO Identify Bucket of Interest
	//--------------------------------------------------------------------------
	
	// Note: if we don't find the bucket of interest (i.e., on a dummy access or 
	// if it was in the stash), this logic will still rebuffer/decrypt something 
	// to hide timing variations

	assign	DataOutV =								DataOut_Read1[BigVWidth+BktHVStart-1:BktHVStart];
	assign	DataOutU =								DataOut_Read1[BigUWidth+BktHUStart-1:BktHUStart];
	
	generate for (i = 0; i < ORAMZ; i = i + 1) begin:RO_BUCKET_OF_INTEREST
		assign	ROI_UMatches[i] =					DataOutV[i] & (ROPAddr == DataOutU[ORAMU*(i+1)-1:ORAMU*i]);
	end endgenerate
					
	assign	ROI_FoundBucket =						BufferedDataOutValid & (ROAccess & MaskIsHeader & ~CSCOWrite & |ROI_UMatches);
	assign	ROI_NotFoundBucket =					BufferedDataOutValid & (ROAccess & ProcessingLastHeader & ~ROI_HeaderValid);

	assign	ROI_HeaderLoad =						ROI_FoundBucket | ROI_NotFoundBucket;
	
	Register	#(			.Width(					1))
				roi_found(	.Clock(					Clock),
							.Reset(					Reset |	FinishWBOut),				
							.Set(					ROI_HeaderLoad),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ROI_HeaderValid));	
	Register	#(			.Width(					1))
				roi_load(	.Clock(					Clock),
							.Reset(					Reset |	ROI_Rebuffer1Complete),						
							.Set(					ROI_HeaderLoad),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ROI_BucketLoad));
	assign	ROI_BufferBucket =						ROI_HeaderLoad | ROI_BucketLoad;
							
	CountAlarm #(			.Threshold(				BktSize_DRBursts))
				roi_load_cnt(.Clock(				Clock), 
							.Reset(					Reset), 
							.Enable(				ROIDataInValid),
							.Done(					ROI_Rebuffer1Complete));
	Register	#(			.Width(					1))
				roi_loaded(	.Clock(					Clock),
							.Reset(					Reset |	FinishWBOut),						
							.Set(					ROI_Rebuffer1Complete),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ROI_BucketLoaded));
	
	Register	#(			.Width(					IVEntropyWidth + BIDWidth + BigUWidth + BigVWidth))
				roi_info(	.Clock(					Clock),
							.Reset(					1'b0),
							.Set(					1'b0),
							.Enable(				ROI_HeaderLoad),
							.In(					{BufferedIV, 		BufferedBID,	DataOutU, 	DataOutV}),
							.Out(					{ROI_GentryIV, 		ROI_BID,		ROI_U,		ROI_V}));
						
	assign	ROIDataInValid =						BufferedDataTransfer_Read & ROI_BufferBucket;						
							
	// Note: This buffer is only needed because the Path Buffer is a FIFO						
	generate if (Overclock) begin:BRAM_ROIBUFF
		wire	ROIDataFull;
		
		wire	ROIDataInValid_Inner;
		wire	[DDRDWidth-1:0]	BufferedDataOut_Inner;
		
		// NOTE: this register is VERY important to help meet timing
		Register #(			.Width(					DDRDWidth + 1))
				roi_dly(	.Clock(					Clock),
							.Reset(					1'b0),
							.Set(					1'b0),
							.Enable(				1'b1),
							.In(					{BufferedDataOut, 		ROIDataInValid}),
							.Out(					{BufferedDataOut_Inner, ROIDataInValid_Inner}));		

		assign	ROIDataInReady =					~ROIDataFull;
		AESROIBuff roi_P_buf(.clk(					Clock), 
							.din(					BufferedDataOut_Inner), 
							.wr_en(					ROIDataInValid_Inner), 
							.full(					ROIDataFull), 
							.dout(					ROIData), 
							.valid(					ROIDataValid),
							.rd_en(					ROIDataReady));
	end else begin:LUTRAM_DATABUFF
		FIFORAM	#(			.Width(					DDRDWidth),
							.Buffering(				BktSize_DRBursts))
				roi_P_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BufferedDataOut),
							.InValid(				ROIDataInValid),
							.InAccept(				ROIDataInReady),
							.OutData(				ROIData),
							.OutSend(				ROIDataValid),
							.OutReady(				ROIDataReady));
	end endgenerate							

	// Note: We don't check BufferedDataOutReady because we know 100% for sure 
	// that data_buf will have space by the time the bucket of interest is 
	// stored in roi_P_buf
	assign	ROIDataReady =							CSROROIRead;		
		
	//--------------------------------------------------------------------------
	//	Data/Mask Mixing
	//--------------------------------------------------------------------------	
	
	assign	ROMask_Needed =							(ROAccess) ? MaskIsHeader & ~CSCOROI : MaskIsHeader;
	assign	ROIMask_Needed =						CSCOROI;
	assign	RMMask_Needed =							RWAccess;
	assign	BDataValid_Needed =						BufferedDataOutValid;
	assign	RMMaskValid_Needed =					(RMMask_Needed) ? 	Core_RWDataOutValid : (ROIMask_Needed) ? ROIMaskShiftOutValid : 1'b1;
	assign	ROMaskValid_Needed =					(ROMask_Needed) ? 	ROMaskBufOutValid : 1'b1;
		
	assign	GentryHeaderMask =						(ROIMask_Needed) ? 	ROIHeaderMask :	 					RWBGHeaderMask;
	assign	GentryDataMask =						(ROIMask_Needed) ? 	ROIDataMask : 						RWBGDataMask;
	assign	Mask =									(MaskIsHeader) ? 	ROHeaderMask | GentryHeaderMask : 	GentryDataMask;
	assign	DataOut_Unmask =						BufferedDataOut ^ Mask; 
	
	//--------------------------------------------------------------------------
	//	Output Arbitration
	//--------------------------------------------------------------------------	
	
	// When we detect a read bucket has never been written, mark its valid bits 
	// as invalid
	assign	RecomputedValidBits =					(MaskIsHeader & BufferedIVNotValid) ? {BktHSize_ValidBits{1'b0}} : DataOut_Unmask[BktHUStart-1:BktHVStart]; 
	assign	DataOut_Read1 =							{	
														DataOut_Unmask[DDRDWidth-1:BktHUStart],
														RecomputedValidBits,
														DataOut_Unmask[BktHVStart-1:0]	
													};

	// To keep the interface "clean", and to make the CoherenceController 
	// simpler, we give a completely decrypted header for the bucket of 
	// interest
	assign	RecomputedVU =							(MaskIsHeader & CSCOROI) ? {ROI_U, {BktHWaste_ValidBits{1'b0}}, ROI_V} : DataOut_Read1[BktHLStart-1:BktHVStart];
	assign	DataOut_Read =							{	
														DataOut_Read1[DDRDWidth-1:BktHLStart],
														RecomputedVU,
														DataOut_Unmask[IVEntropyWidth-1:0]
													};
	
	// Writeback the IVs that we used to generate the new ROHeaderMasks to 
	// memory
	assign	UpdatedExternalIV =						(MaskIsHeader) ? WritebackROIVOutData : DataOut_Unmask[IVEntropyWidth-1:0]; 
	assign	DataOut_Write =							{
														DataOut_Unmask[DDRDWidth-1:BktHVStart],
														UpdatedExternalIV
													};
	
	// Standard RV FIFO arbitration: 3 input sources -> 1 output source
	assign	DataOutValid =							 BDataValid_Needed & 	ROMaskValid_Needed & RMMaskValid_Needed & 	(RMMask_Needed | ROIMask_Needed | ROMask_Needed);

	// We split these signals apart to help meet timing (using DRAMWriteDataReady when you don't need to is DISASTROUS for timing)
	assign	BufferedDataOutReady_Read =				 						ROMaskValid_Needed & RMMaskValid_Needed;
	assign	BufferedDataOutReady_Write =			 DRAMWriteDataReady &	ROMaskValid_Needed & RMMaskValid_Needed;
	assign	BufferedDataOutReady =					 DataOutReady & 		ROMaskValid_Needed & RMMaskValid_Needed;
	
	assign	RMMaskReady =							(DataOutReady & 		ROMaskValid_Needed & BDataValid_Needed) & 	RMMask_Needed;
	assign	ROIMaskShiftOutReady =					(DataOutReady & 		ROMaskValid_Needed & BDataValid_Needed) & 	ROIMask_Needed;
	assign	ROMaskBufOutReady =						 DataOutReady & 		RMMaskValid_Needed & BDataValid_Needed & 	ROMask_Needed;
	
	assign	DataOutReady =							(PathRead) ? 1'b1 : DRAMWriteDataReady;
	assign	DataOutTransfer =						DataOutValid & DataOutReady;
	
	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------
	
	assign	BEDataOut_Pre =							DataOut_Read;
	assign	BEDataOutValid_Pre =					PathRead & DataOutValid;
	
	generate if (Overclock) begin:PIPE_BENDOUT
		Register	#(		.Width(					DDRDWidth + 1))
				beout_dly(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				1'b1),
							.In(					{BEDataOut_Pre,	BEDataOutValid_Pre}),
							.Out(					{BEDataOut, 	BEDataOutValid}));
	end else begin:PASS_BENDOUT
		assign	BEDataOutValid =					BEDataOutValid_Pre;
		assign	BEDataOut =							BEDataOut_Pre;
	end endgenerate

	// State signals on RO accesses
	assign	ROIBVOut =								ROI_GentryIV;
	assign	ROIBIDOut =								ROI_BID;

	/*
	Register	#(			.Width(					DDRDWidth + 1))
				bein_dly(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				1'b1),
							.In(					{BEDataIn, 			BEDataInValid}),
							.Out(					{BEDataIn_Inner, 	BEDataInValid_Inner}));
	*/
	
	assign	BEDataIn_Inner =						BEDataIn;
	assign	BEDataInValid_Inner =					BEDataInValid;
	
	assign	BEDataInReady = 						CSROWrite & BufferedDataInReady;
	
	//--------------------------------------------------------------------------
	//	Path Writeback Interface
	//--------------------------------------------------------------------------

	assign	DRAMWriteData =							DataOut_Write;
	assign	DRAMWriteDataValid = 					PathWriteback & DataOutValid;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------