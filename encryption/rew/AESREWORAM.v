
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		AESREWORAM
//	Desc:		AES Unit for REW ORAM.  
//				ROHeader = valid bits + program addresses
//
//				- 	On an REW RO access (DRAM -> Backend): 
//						In: 	Encrypted path
//						Out: 	Decrypted RO headers, followed by a fully 
//								decrypted bucket of interest
//				-	On an REW H access (Backend -> DRAM): 
//						In:		Decrypted headers
//						Out:	Re-encrypted headers
//				-	On an REW R access (DRAM -> Backend):
//						In:		Encrypted path
//						Out:	Decrypted path
//				-	On an REW W access (Backend -> DRAM):
//						In:		Decrypted path
//						Out:	Encrypted path
//
//	TODO: encrypt/decrypt IV hashes
//	TODO: remove `ifdef for ASIC... and in AESCore; we won't implement REW for ASIC
//==============================================================================
module AESREWORAM(
	Clock, FastClock, 
	Reset,

	ROPAddr, ROLeaf,
	ROStartAESValid, ROStartAESReady,

	ROIBVOut, ROIBIDOut,
	
	BEDataOut, BEDataOutValid,
	BEDataIn, BEDataInValid, BEDataInReady,
	
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady
	);

	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "REWAESLocal.vh"
	`include "StashLocal.vh"
	
	parameter				DebugAES =				0;
	
	parameter				DebugAggressive =		0; // This is only a valid assertion under certain traffic generators.  Generally it should be disabled.
	
	localparam				ORAMUValid = 			ORAML + 3; // Note: +3 assumes 50% utilization at Z=4
	
	localparam				PathMaskBuffering =		2; // with ORAML = 31, ORAMZ = 5 & a 512 deep mask FIFO, we can fit 2 whole paths
	
	localparam				DUChunks =				DDRDWidth / ORAMU,
							DUWidth =				`log2(DUChunks);
	
	localparam				RW_R_Chunk = 			PathSize_DRBursts,
							RW_W_Chunk = 			PathSize_DRBursts,
							RO_R_Chunk = 			(ORAML+1) * BktHSize_DRBursts + BktSize_DRBursts,
							RO_W_Chunk = 			(ORAML+1) * BktHSize_DRBursts;
	
	localparam				AESHWidth =				ROHeader_AESChunks * AESWidth,
							BDWidth =				DDRDWidth + AESEntropy + BIDWidth + 1;
	
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

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, FastClock, Reset;

	//--------------------------------------------------------------------------
	//	Command Interface
	//--------------------------------------------------------------------------
	
	input	[ORAMU-1:0]		ROPAddr;
	input	[ORAML-1:0]		ROLeaf;
	
	input					ROStartAESValid;
	output 					ROStartAESReady;
	
	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------

	// These signals will be valid from when the bucket of interest is found to 
	// the end of the header writeback
	output	[AESEntropy-1:0] ROIBVOut;
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
	
	(* mark_debug = "TRUE" *)	wire					PathRead, ROAccess, RWAccess, PathWriteback;	
	
	wire	[ORAMU-1:0]		ROPAddr_Internal;
	wire	[ORAML-1:0]		ROLeaf_Internal;
	
	// AES Core
	
	(* mark_debug = "TRUE" *)	wire	[AESEntropy-1:0] Core_ROIVIn; 
	(* mark_debug = "TRUE" *)	wire	[BIDWidth-1:0] 	Core_ROBIDIn; 
	(* mark_debug = "TRUE" *)	wire	[PCCMDWidth-1:0] Core_ROCommandIn; 
	(* mark_debug = "TRUE" *)	wire					Core_ROCommandInValid;
	(* mark_debug = "TRUE" *)	wire					Core_ROCommandInReady;

	(* mark_debug = "TRUE" *)	wire	[AESEntropy-1:0] Core_RWIVIn;
	(* mark_debug = "TRUE" *)	wire	[BIDWidth-1:0] 	Core_RWBIDIn;
	(* mark_debug = "TRUE" *)	wire					Core_RWCommandInValid; 
	(* mark_debug = "TRUE" *)	wire					Core_RWCommandInReady;

	(* mark_debug = "TRUE" *)	wire	[AESWidth-1:0]	Core_RODataOut; 
	(* mark_debug = "TRUE" *)	wire	[PCCMDWidth-1:0] Core_ROCommandOut;
	(* mark_debug = "TRUE" *)	wire					Core_RODataOutValid;
	(* mark_debug = "TRUE" *)	wire					Core_RODataOutReady;
	
	(* mark_debug = "TRUE" *)	wire	[DDRDWidth-1:0]	Core_RWDataOut;
	(* mark_debug = "TRUE" *)	wire					Core_RWDataOutValid;	
	
	// RO header mask & bucket of interest seed generation

	(* mark_debug = "TRUE" *)	reg		[ROSWidth-1:0] 	CS_RO, NS_RO;
	
	(* mark_debug = "TRUE" *)	wire					DRAMReadTransfer, ROCommandTransfer;

	(* mark_debug = "TRUE" *)	wire	[AESEntropy-1:0] GentryCounter_MemoryConsistant;
	
	(* mark_debug = "TRUE" *)	wire					ROStarted;
	
	wire	[ORAML-1:0]		CurrentLeaf;
	
	wire	[BDWidth-1:0]	BufferedDataIn_Wide, BufferedDataOut_Wide;
	(* mark_debug = "TRUE" *)	wire					BufferedDataInValid, BufferedDataInReady;
	(* mark_debug = "TRUE" *)	wire					BufferedDataOutValid, BufferedDataOutReady;
	
	(* mark_debug = "TRUE" *)	wire					BufferedDataOutReady_Read, BufferedDataTransfer_Read;
	(* mark_debug = "TRUE" *)	wire					BufferedDataOutReady_Write, BufferedDataTransfer_Write;	
	
	wire	[DDRDWidth-1:0]	BufferedDataOut;
	(* mark_debug = "TRUE" *)	wire					BufferedDataTransfer;

	wire					MaskIsHeader_Pre, MaskIsHeader;
	wire					BufferedDataBucketTransition;

	wire	ROIDataInValid_Inner;
	wire	[DDRDWidth-1:0]	BufferedDataOut_Inner;	
	
	(* mark_debug = "TRUE" *)	wire					BucketNotYetWritten, BufferedIVNotValid;
	
	wire	[AESEntropy-1:0] BufferedROIVOutData;
	(* mark_debug = "TRUE" *)	wire					BufferedROIVInValid, BufferedROIVInReady;
	(* mark_debug = "TRUE" *)	wire					BufferedROIVOutValid, BufferedROIVOutReady;	
	
	wire	[AESEntropy-1:0] WritebackROIVInData;
	(* mark_debug = "TRUE" *)	wire					WritebackROIVInValid;
		
	wire	[AESEntropy-1:0] BufferedROIVOutData_DWB;
	(* mark_debug = "TRUE" *)	wire					BufferedROIVOutValid_DWB, BufferedROIVOutReady_DWB;	
	
	wire	[AESEntropy-1:0] WritebackROIVOutData;
	(* mark_debug = "TRUE" *)	wire					WritebackROIVInReady, WritebackROIVOutValid, WritebackROIVOutReady;
	
	(* mark_debug = "TRUE" *)	wire 					RO_BIDInReady, RO_BIDOutValid, RO_BIDOutReady;

	(* mark_debug = "TRUE" *)	wire 					RO_BIDOutValid_Needed;	
	
	(* mark_debug = "TRUE" *)	wire					RODRAMChunkIsHeader, ROBucketTransition, ROPathTransition;
	
	wire	[AESEntropy-1:0] RO_GentryIV, BufferedIV;
	wire	[BIDWidth-1:0] 	RO_BIDOut, BufferedBID;
	
	wire	[AESEntropy-1:0] ExternalIV, ExternalIVIncrement, UpdatedExternalIV;
	
	(* mark_debug = "TRUE" *)	wire					RO_LeafNextDirection;
	wire	[AESEntropy-1:0] RO_IVIncrement, RO_IVNext;
		
	wire					CSROIdle, CSROStartRead, CSROStartOp, CSRORead, CSROROIReadCommand, CSROROIRead, CSROWrite;
	
	(* mark_debug = "TRUE" *)	wire					FinishWBIn, HWBPathTransition, RWWBPathTransition;
	
	// RO mask shifting/buffering
	
	(* mark_debug = "TRUE" *)	wire					ROMaskShiftInValid, ROMaskShiftInReady;
	wire	[ROHeader_RawBits-1:0] ROMaskShiftOutData;
	(* mark_debug = "TRUE" *)	wire					ROMaskShiftOutValid, ROMaskShiftOutReady;
	
	wire	[ROHeader_RawBits-1:0] ROMaskBufOutData;
	(* mark_debug = "TRUE" *)	wire					ROMaskBufOutValid, ROMaskBufOutReady;

	(* mark_debug = "TRUE" *)	wire					ROIMaskShiftInValid, ROIMaskShiftInReady;
	wire	[DDRDWidth-1:0]	ROIMaskShiftOutData;
	wire					RMMaskReady;
	(* mark_debug = "TRUE" *)	wire					ROIMaskShiftOutValid, ROIMaskShiftOutReady;	
	
	// RW background mask generation
		
	(* mark_debug = "TRUE" *)	wire					RW_BIDOutValid, RW_BIDOutReady;
	(* mark_debug = "TRUE" *)	wire					RWSend, RWReceive;
	(* mark_debug = "TRUE" *)	wire					MaskFIFOReady;
	wire	[IFMWidth-1:0]	MasksInFlight;
	
	// ROI (Bucket of interest handling)
	
	genvar 					i;
	wire	[ORAMZ-1:0]		ROI_UMatches;
	
	(* mark_debug = "TRUE" *)	wire					ProcessingLastHeader;	
	wire					ROI_BufferBucket, ROI_HeaderValid, ROI_BucketLoad, ROI_BucketLoaded;
	(* mark_debug = "TRUE" *)	wire 					ROI_FoundBucket, ROI_NotFoundBucket, ROI_HeaderLoad;
	
	(* mark_debug = "TRUE" *)	wire	[BigVWidth-1:0] DataOutV;
	(* mark_debug = "TRUE" *)	wire	[BigUWidth-1:0] DataOutU;
	
	wire	[AESEntropy-1:0] ROI_GentryIV;
	wire	[BIDWidth-1:0]	ROI_BID;
	wire	[BigUWidth-1:0]	ROI_U;
	wire	[BigVWidth-1:0]	ROI_V;
	
	(* mark_debug = "TRUE" *)	wire					ROIInfoReset, ROIInfoEnable;
	
	wire	[DDRDWidth-1:0]	ROIData;
	(* mark_debug = "TRUE" *)	wire					ROIDataInValid, ROIDataInReady;	
	(* mark_debug = "TRUE" *)	wire					ROIDataValid, ROIDataReady;

	(* mark_debug = "TRUE" *)	wire					ROI_Rebuffer1Complete, ROI_Rebuffer2Complete;	
	
	// Output control

	(* mark_debug = "TRUE" *)	reg		[COSWidth-1:0]	CS_CO, NS_CO;
		
	wire					CSCOWrite, CSCOROI;
	wire					StartROI, FinishROI, FinishWBOut;

	(* mark_debug = "TRUE" *)	wire					HWBPathTransitionOut, RWWBPathTransitionOut;
	
	// Output Data/Mask mixing
	
	wire	[DDRDWidth-1:0]	ROHeaderMask;
	wire	[DDRDWidth-1:0]	RWBGHeaderMask, RWBGDataMask;
	wire	[DDRDWidth-1:0]	ROIHeaderMask, ROIDataMask;
	wire	[DDRDWidth-1:0]	GentryHeaderMask, GentryDataMask;
	wire	[DDRDWidth-1:0]	Mask;
	
	(* mark_debug = "TRUE" *)	wire					BDataValid_Needed, RMMaskValid_Needed, ROMaskValid_Needed;

	wire	[BktHSize_ValidBits-1:0] RecomputedValidBits;
	wire	[BigUWidth+BktHSize_ValidBits-1:0] RecomputedVU;
	wire	[AESEntropy-1:0] OutputExternalIV;
	
	wire	[DDRDWidth-1:0]	DataOut_Unmask, DataOut_Read1, DataOut_Read, DataOut_Write;
	(* mark_debug = "TRUE" *)	wire					DataOutValid, DataOutReady, DataOutTransfer;
	
	(* mark_debug = "TRUE" *)	wire					ROMask_Needed, ROIMask_Needed, RMMask_Needed;
	
	// Derived signals / timing related
	
	reg						RWWB_Delayed;

	wire 	[DDRDWidth-1:0]	BEDataIn_Inner;
	wire					BEDataInValid_Inner;

	wire	[DDRDWidth-1:0]	BEDataOut_Pre;
	wire					BEDataOutValid_Pre;
	
	wire	[DDRDWidth-1:0]	DRAMWriteData_Pre; 
	wire					DRAMWriteDataValid_Pre, DRAMWriteDataReady_Pre;

	// debugging
		
	(* mark_debug = "TRUE" *)	wire					FoundBOIThisAccess;	

	(* mark_debug = "TRUE" *)	wire	[ORAMZ-1:0]		BogusORAMU_Read;
	(* mark_debug = "TRUE" *)	wire	[DUChunks-1:0]	BogusORAMData;
	
	(* mark_debug = "TRUE" *)	wire					ERROR_UF1_DWB, ERROR_OF1_DWB, ERROR_ISC1_DWB;
	(* mark_debug = "TRUE" *)	wire					ERROR_OF1, ERROR_UF1, ERROR_OF2, ERROR_UF2, ERROR_OF3, ERROR_OF4, ERROR_UF3, ERROR_ISC1, ERROR_DUP1, ERROR_ISC2, ERROR_BOGUSU, ERROR_BOGUSDATA, ERROR_AES;

	//--------------------------------------------------------------------------
	//	Initial state
	//--------------------------------------------------------------------------	
	
	`ifdef FPGA
		initial begin
			CS_RO = ST_RO_Idle;
			CS_CO = ST_CO_Read;
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Simulation Checks
	//--------------------------------------------------------------------------
	
	Register1b 	chk1(Clock, Reset | FinishWBIn, ROI_FoundBucket, 									FoundBOIThisAccess);
	
	generate for (i = 0; i < ORAMZ; i = i + 1) begin:RO_BOGUS_U
		assign	BogusORAMU_Read[i] =				|DataOutU[ORAMU*(i+1)-1:ORAMU*i+ORAMUValid] && DataOutU[ORAMU*(i+1)-1:ORAMU*i] != DummyBlockAddress;
	end endgenerate
	
	generate if (DebugAggressive) begin:AGGRESSIVE 
		for (i = 0; i < DUChunks; i = i + 1) begin:AGGRESSIVE_Inner
			assign	BogusORAMData[i] =				|BEDataOut_Pre[(i+1)*ORAMU-1:i*ORAMU+24]; // check top 8 bits
		end
	end else begin
		assign	BogusORAMData =						{DUChunks{1'b0}};
	end endgenerate
	
	Register1b 	errno1(Clock, Reset, 	BufferedDataInValid & ~BufferedDataInReady & CSROROIRead, 	ERROR_OF1);	
	Register1b 	errno2(Clock, Reset, 	BufferedROIVOutReady & ~BufferedROIVOutValid, 				ERROR_UF1);	
	Register1b 	errno3(Clock, Reset, 	ROIDataInValid & ~ROIDataInReady, 							ERROR_OF2);	
	Register1b 	errno4(Clock, Reset, 	~ROIDataValid & ROIDataReady, 								ERROR_UF2);	
	Register1b 	errno5(Clock, Reset, 	BufferedROIVInValid & ~BufferedROIVInReady, 				ERROR_OF3);
	Register1b 	errno6(Clock, Reset, 	WritebackROIVInValid & ~WritebackROIVInReady, 				ERROR_OF4);
	Register1b 	errno7(Clock, Reset, 	WritebackROIVOutReady & ~WritebackROIVOutValid, 			ERROR_UF3);
	Register1b 	errno8(Clock, Reset, 	ROI_FoundBucket & ROI_NotFoundBucket, 						ERROR_ISC1);
	Register1b 	errno9(Clock, Reset, 	FinishWBIn & ROIDataValid, 									ERROR_ISC2);	
	Register1b 	errno10(Clock, Reset, 	FoundBOIThisAccess & ROI_FoundBucket, 						ERROR_DUP1);
	Register1b 	errno11(Clock, Reset, 	|BogusORAMU_Read && BufferedDataOutValid && ROMaskBufOutValid && MaskIsHeader && ~BufferedIVNotValid && ~CSCOWrite, ERROR_BOGUSU);
	Register1b 	errno12(Clock, Reset, 	|BogusORAMData && ~BufferedIVNotValid && ~MaskIsHeader && BEDataOutValid_Pre && (FoundBOIThisAccess || RWAccess), ERROR_BOGUSDATA);
	
	Register1b 	errANY(Clock, Reset, 	ERROR_UF1_DWB | ERROR_OF1_DWB | ERROR_ISC1_DWB | 
										ERROR_OF1 | ERROR_UF1 | ERROR_OF2 | ERROR_UF2 | ERROR_OF3 | ERROR_OF4 | ERROR_UF3 | ERROR_ISC1 | ERROR_ISC2 | ERROR_DUP1 | ERROR_BOGUSU | ERROR_BOGUSDATA, ERROR_AES);
	
	`ifdef SIMULATION
		initial begin
			if (BktHSize_DRBursts > 1) begin
				$display("[%m @ %t] ERROR: Not supported yet.", $time);
				$finish;
			end		
		end

	`ifdef SIMULATION_VERBOSE_AES
		wire	[AESEntropy-1:0] RWBVOut;
		wire	[BIDWidth-1:0] 	RWBIDOut;
		FIFORAM		#(		.Width(					AESEntropy + BIDWidth),
							.Buffering(				1000))
				rw_H_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{Core_RWIVIn, Core_RWBIDIn}),
							.InValid(				RWSend),
							.InAccept(				),
							.OutData(				{RWBVOut, RWBIDOut}),
							.OutSend(				),
							.OutReady(				RWReceive));	
	
		always @(posedge Clock) begin
			if (BEDataOutValid) begin
				$display("[%m @ %t] Sending Backend: %x (RO: %b, ROI: %b) ", $time, BEDataOut, ROAccess, CSCOROI);
			end
			if (DRAMWriteDataValid & DRAMWriteDataReady) begin
				$display("[%m @ %t] Writing DRAM:    %x (RO: %b) ", $time, DRAMWriteData, ROAccess);
			end
			
			if (RWReceive) begin
				$display("[%m @ %t] Releasing Gentry mask w/ IV = %d, BID = %d", $time, RWBVOut, RWBIDOut);
			end
			
			if (DRAMReadDataValid & DRAMReadDataReady) begin
				$display("[%m @ %t] Reading DRAM:    %x (ROAccess = %b) ", $time, DRAMReadData, ROAccess);
			end
			
			if (DataOutTransfer) begin
				$display("[%m @ %t] Outputting mask: %x (ROAccess = %b, BOI = %b, Writing = %b) ", $time, Mask, ROAccess, CSCOROI, CSCOWrite);
			end
			
			if (ROI_FoundBucket) begin
				$display("[%m @ %t] AES found bucket of interest: Gentry IV = %d, BID = %d, U = %x, V = %x", $time, BufferedIV, BufferedBID, DataOutU, DataOutV);
			end
		end		
	`endif
	
		always @(posedge Clock) begin
			if (ERROR_OF1) begin // "may" happen because data_buf has no backpressure in this state but should never happen
				$display("[%m @ %t] ERROR: Data buffer overflow.", $time);
				$finish;
			end
			
			if (ERROR_UF1) begin
				$display("[%m @ %t] ERROR: Header WB fifo didn't have data on a transfer.", $time);
				$finish;
			end
			
			if (BufferedDataInValid && ~BucketNotYetWritten && (	((EnableIV) ? ^DRAMReadData[DDRDWidth-1:BktHLStart+BigLWidth] === 1'bx : 1'b0) ||
																	^DRAMReadData[BktHLStart+BigLWidth-1:0] === 1'bx || 
																	^RO_GentryIV === 1'bx || 
																	^Core_ROBIDIn === 1'bx)) begin
				$display("[%m @ %t] ERROR: Header that has been written to memory before came back X.", $time);
				$finish;			
			end
			
			if (~CSROWrite & BufferedDataOutValid & MaskIsHeader & ^DataOutV === 1'bx) begin // TODO use better signal than CSROWrite
				$display("[%m @ %t] ERROR: Valid bit was X.", $time);
				$finish;	
			end

			if (ERROR_OF2) begin
				$display("[%m @ %t] ERROR: Bucket of interest FIFO overflow.", $time);
				$finish;
			end
			if (ERROR_UF2) begin
				$display("[%m @ %t] ERROR: Bucket of interest FIFO didn't have data.", $time);
				$finish;
			end
			
			if (ERROR_ISC2) begin
				$display("[%m @ %t] ERROR: Bucket of interest FIFO still had data in it after access completed.", $time);
				$finish;
			end			
			
			if (DataOutTransfer	& MaskIsHeader & |(ROHeaderMask & RWBGHeaderMask)) begin
				$display("[%m @ %t] ERROR: RO and RW masks overlapped on header flit.", $time);
				$finish;
			end
			
			if (ERROR_OF3) begin
				$display("[%m @ %t] ERROR: IV FIFO for header writebacks overflowed.", $time);
				$finish;
			end
			if (ERROR_OF4) begin
				$display("[%m @ %t] ERROR: External IV FIFO writebacks overflowed.", $time);
				$finish;
			end
			if (ERROR_UF3) begin
				$display("[%m @ %t] ERROR: External IV FIFO didn't have data on a transfer.", $time);
				$finish;
			end
			
			if (ERROR_ISC1) begin
				$display("[%m @ %t] ERROR: now this just doesn't make any goddamn sense does it?.", $time);
				$finish;
			end
			
			if (ERROR_DUP1) begin
				$display("[%m @ %t] ERROR: found 2 buckets of interest on 1 path.", $time);
				$finish;			
			end
			
			if (ERROR_BOGUSU) begin
				$display("[%m @ %t] ERROR: some U got decrypted to garbage.", $time);
				$finish;					
			end
			
			if (ERROR_BOGUSDATA) begin
				$display("[%m @ %t] ERROR: some data got decrypted to garbage.", $time);
				$finish;					
			end
		end
	`endif

	//--------------------------------------------------------------------------
	//	Control logic
	//--------------------------------------------------------------------------

	always @(posedge Clock) begin
		RWWB_Delayed <=								RWAccess & PathWriteback;
	end
	
	//--------------------------------------------------------------------------
	//	System Control Logic
	//--------------------------------------------------------------------------

	// TODO merge some of the other count alarms in with this module
	
	REWStatCtr	#(			.ORAME(					ORAME),
							.DelayedWB(				DelayedWB),
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
	assign	CSRORead =								CS_RO == ST_RO_Read;
	assign	CSROROIReadCommand =					CS_RO == ST_RO_ROIReadCommand;
	assign	CSROROIRead =							CS_RO == ST_RO_ROIRead;
	assign	CSROWrite =								CS_RO == ST_RO_Write;
	
	always @(posedge Clock) begin
		if (Reset) CS_RO <= 						ST_RO_Idle;
		else CS_RO <= 								NS_RO;
	end

	FIFORegister #(			.Width(					ORAMU + ORAML),
							.BWLatency(				1))
				ro_start(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{ROPAddr, 			ROLeaf}),
							.InValid(				ROStartAESValid),
							.InAccept(				ROStartAESReady),
							.OutData(				{ROPAddr_Internal, 	ROLeaf_Internal}),
							.OutSend(				ROStarted),
							.OutReady(				FinishWBIn));	
	
	always @( * ) begin
		NS_RO = 									CS_RO;
		case (CS_RO)
			ST_RO_Idle :
				if (~ERROR_AES)
					if (		DRAMReadDataValid & ROAccess & PathRead & ROStarted)
						NS_RO =							ST_RO_StartRead;
					else if (	DRAMReadDataValid & RWAccess & PathRead)
						NS_RO =							ST_RO_StartRead;
					else if (	RWAccess & PathWriteback & BEDataInValid & DelayedWB)
						NS_RO =							ST_RO_StartWrite;
			ST_RO_StartRead :
				if (RO_BIDInReady)
					NS_RO =							ST_RO_Read;
			ST_RO_Read :
				if (ROPathTransition & ROAccess)
					NS_RO =							ST_RO_ROIReadCommand;
				else if (ROPathTransition & RWAccess)
					if (DelayedWB)
						NS_RO =						ST_RO_Idle;
					else	
						NS_RO =						ST_RO_StartWrite;
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
							
	// Writeback counters TODO replace with the stat ctrs
	CountAlarm 	#(			.Threshold(				ORAML + 1))
				hwb_cnt(	.Clock(					Clock), 
							.Reset(					Reset | CSROStartOp), 
							.Enable(				BEDataInValid & BEDataInReady),
							.Done(					HWBPathTransition));
	CountAlarm 	#(			.Threshold(				PathSize_DRBursts))
				rwwb_cnt(	.Clock(					Clock), 
							.Reset(					Reset | CSROStartOp), 
							.Enable(				BEDataInValid & BEDataInReady),
							.Done(					RWWBPathTransition));							
	assign	FinishWBIn =							(ROAccess) ? HWBPathTransition : RWWBPathTransition;
	
	assign	ExternalIV = 							DRAMReadData[AESEntropy-1:0];
	
	// Represents the actual gentry counter of blocks stored in memory
	Counter		#(			.Width(					AESEntropy))
				gentry_mem(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				RWWB_Delayed & PathRead),
							.In(					{AESEntropy{1'bx}}),
							.Count(					GentryCounter_MemoryConsistant));	
	
	assign	CurrentLeaf =							(ROAccess) ? ROLeaf_Internal : GentryCounter_MemoryConsistant[ORAML-1:0];
	
	// Adjust the gentry counter for each bucket on the RO path (this is the floor/ceiling logic)
	assign	RO_IVIncrement =						RO_GentryIV + {{AESEntropy-1{1'b0}}, ~RO_LeafNextDirection};
	assign	RO_IVNext = 							(CSROStartRead) ? GentryCounter_MemoryConsistant : {1'b0, RO_IVIncrement[AESEntropy-1:1]};
	
	Register	#(			.Width(					AESEntropy))
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
							.PIn(					CurrentLeaf),
							.SIn(					1'b0),
							.SOut(					RO_LeafNextDirection));
											
    AddrGen 	#(			.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.BEDWidth(				BEDWidth))
				ro_bid(		.Clock(					Clock),
							.Reset(					Reset),
							.Start(					CSROStartOp),
							.Ready(					RO_BIDInReady),
							.RWIn(					1'b0), // don't care
							.BHIn(					1'b1), // only send one command per bucket
							.leaf(					CurrentLeaf),
							.CmdValid(				RO_BIDOutValid),
							.CmdReady(				RO_BIDOutReady),
							.BktIdx(				RO_BIDOut));


/*  // TODO Chris:
	// ideally BktIDGen should meet this purpose
	
	BktIDGen # 	(	.ORAML(		ORAML))
		bid 	(	.Clock(		Clock),
					.ReStart(	CSROStartOp),
					.leaf(		ROLeaf_Internal),
					.Enable(	RO_BIDOutReady),
					.BktIdx(	RO_BIDOut)			
				);
	assign	RO_BIDOutValid = ???  ;
*/	
							
	assign	RO_BIDOutValid_Needed =					(RODRAMChunkIsHeader) ? 	RO_BIDOutValid : 1'b1;
							
	assign	Core_ROCommandIn =						(CSROROIReadCommand) ? 		PCMD_ROData : 	PCMD_ROHeader;
	assign	Core_ROIVIn =							(CSRORead) ?				ExternalIV :
													(CSROROIReadCommand) ? 		ROI_GentryIV :
													(DelayedWB & RWAccess) ? 	BufferedROIVOutData_DWB : 
																				BufferedROIVOutData;
	assign	Core_ROBIDIn =							(CSROROIReadCommand) ? 		ROI_BID : 		RO_BIDOut;
	
	assign	Core_ROCommandInValid =					(CSROROIReadCommand) ? 		ROI_HeaderValid : 
													(CSROROIRead) ? 			1'b0 :
													(CSROWrite) ? 				RO_BIDOutValid :
																				DRAMReadDataValid & RO_BIDOutValid & 		BufferedDataInReady & 	RODRAMChunkIsHeader;
	assign	BufferedDataInValid =					(CSROROIReadCommand) ? 		1'b0 : 
													(CSROROIRead) ? 			1'b1 : 
													(CSROWrite) ?				BEDataInValid_Inner : 
																				DRAMReadDataValid &	RO_BIDOutValid_Needed & Core_ROCommandInReady;

	assign	RO_BIDOutReady =						(CSROWrite) ?				Core_ROCommandInReady :
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
																			{BEDataIn_Inner,{AESEntropy{1'bx}}, 	RO_BIDOut,		1'b0}; // header WB + RW writeback
	
	// Note: This buffer is only needed because the Path Buffer is a FIFO
	FIFORAM	#(			.Width(						BDWidth),
						.Buffering(					128)
						`ifndef FPGA_MEMORY , .SRAM(1) `endif) // really, this only needs to be ~AESLatencyPlus deep; but we get the extra depth for free if it is BRAM ...
			data_buf(	.Clock(						Clock),
						.Reset(						Reset),
						.InData(					BufferedDataIn_Wide),
						.InValid(					BufferedDataInValid),
						.InAccept(					BufferedDataInReady),
						.OutData(					BufferedDataOut_Wide),
						.OutSend(					BufferedDataOutValid),
						.OutReady(					BufferedDataOutReady));		
	
	assign	{BufferedDataOut, BufferedIV, BufferedBID, BufferedIVNotValid} = BufferedDataOut_Wide;
	
	//--------------------------------------------------------------------------
	//	Intermediate external IV buffers
	//--------------------------------------------------------------------------
	
	// If BucketNotYetWritten, ExternalIVIncrement is XX on ROAccess so to make 
	// thing simple, we always just increment it by the same amount.  On A 
	// RWAccess, we must set to something ...
	assign	ExternalIVIncrement =					ExternalIV + ROHeader_AESChunks;
	assign	UpdatedExternalIV =						(RWAccess & BucketNotYetWritten) ? {AESEntropy{1'b0}} : ExternalIVIncrement;
	
	assign	BufferedROIVInValid =					((DelayedWB) ? ROAccess : 1'b1) & Core_ROCommandInValid & CSRORead;
	assign	BufferedROIVOutReady =					((DelayedWB) ? ROAccess : 1'b1) & CSROWrite & ROCommandTransfer;
	
	FIFORAM		#(			.Width(					AESEntropy),
							.Buffering(				ORAML + 1))
				ro_hwb_ivc(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				UpdatedExternalIV),
							.InValid(				BufferedROIVInValid),
							.InAccept(				BufferedROIVInReady),
							.OutData(				BufferedROIVOutData),
							.OutSend(				BufferedROIVOutValid),
							.OutReady(				BufferedROIVOutReady));
	
	generate if (DelayedWB) begin:DELAYED_RW_WRITEBACK
		wire	[AESEntropy-1:0] ExternalIVIncrement_DWB, UpdatedExternalIV_DWB;
		wire				BufferedROIVInValid_DWB, BufferedROIVInReady_DWB;	

		Register1b 	errno20(Clock, Reset, 	BufferedROIVOutReady_DWB & ~BufferedROIVOutValid_DWB, 	ERROR_UF1_DWB);
		Register1b 	errno21(Clock, Reset, 	BufferedROIVInValid_DWB & ~BufferedROIVInReady_DWB, 	ERROR_OF1_DWB);
		Register1b 	errno22(Clock, Reset, 	BufferedROIVInValid & BufferedROIVInValid_DWB, 			ERROR_ISC1_DWB);
		
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (ERROR_UF1_DWB) begin
				$display("[%m @ %t] ERROR: IV FIFO for header (DELAYED) writebacks didn't have data on a transfer.", $time);
				$finish;
			end
			if (ERROR_OF1_DWB) begin
				$display("[%m @ %t] ERROR: IV FIFO for header (DELAYED) writebacks overflowed.", $time);
				$finish;
			end
			if (ERROR_ISC1_DWB) begin
				$display("[%m @ %t] ERROR: illegal signal combination.", $time);
				$finish;			
			end
		end
	`endif
		
		assign	ExternalIVIncrement_DWB =			ExternalIV + ((ORAME + 2) * ROHeader_AESChunks);
		assign	UpdatedExternalIV_DWB =				(BucketNotYetWritten) ? {AESEntropy{1'b0}} : ExternalIVIncrement_DWB;

		assign	BufferedROIVInValid_DWB =			RWAccess & Core_ROCommandInValid & CSRORead;
		assign	BufferedROIVOutReady_DWB =			RWAccess & CSROWrite & ROCommandTransfer;
		
		FIFORAM		#(		.Width(					AESEntropy),
							.Buffering(				ORAML + 1))
				rw_hwb_ivc(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				UpdatedExternalIV_DWB),
							.InValid(				BufferedROIVInValid_DWB),
							.InAccept(				BufferedROIVInReady_DWB),
							.OutData(				BufferedROIVOutData_DWB),
							.OutSend(				BufferedROIVOutValid_DWB),
							.OutReady(				BufferedROIVOutReady_DWB));
	end else begin:NORMAL_RW_WRITEBACKS
		assign	BufferedROIVOutData_DWB = 			{AESEntropy{1'bx}};
		assign	BufferedROIVOutValid_DWB =			1'b0;
		assign	BufferedROIVOutReady_DWB =			1'b0;
		
		assign	ERROR_UF1_DWB =						1'b0;
		assign	ERROR_OF1_DWB =						1'b0;
		assign	ERROR_ISC1_DWB =					1'b0;		
	end endgenerate
	
	/* This is a "lazy" design -- we could have made hwb_ivc_buf a RAM and gone 
	   through it twice.  Two comments to make us not care:
	   1.) This second FIFO is very cheap: 32dx64w bits of LUT RAM.
	   2.) The RAM alternative may actually add some cycles to the critical path 
	       when IV == 0.  Added delay = time in between AESCore generating the 
		   first mask & hwb_ivc_buf writing the last command (= about 10 cycles 
		   when L = 32). 
	   NOTE 2: [ASIC] we should implement as RAM for ASIC ... */

	assign	WritebackROIVInData =					(DelayedWB & RWAccess) ? BufferedROIVOutData_DWB : BufferedROIVOutData;
	assign	WritebackROIVInValid =					(BufferedROIVOutValid_DWB & BufferedROIVOutReady_DWB) | (BufferedROIVOutValid & BufferedROIVOutReady);
	   
	FIFORAM		#(			.Width(					AESEntropy),
							.Buffering(				ORAML + 1))
				hwb_ivo_buf(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				WritebackROIVInData),
							.InValid(				WritebackROIVInValid),
							.InAccept(				WritebackROIVInReady),
							.OutData(				WritebackROIVOutData),
							.OutSend(				WritebackROIVOutValid),
							.OutReady(				WritebackROIVOutReady));

	assign	WritebackROIVOutReady =					CSCOWrite & MaskIsHeader & DataOutTransfer;
	
	//--------------------------------------------------------------------------
	//	RW AES Input
	//--------------------------------------------------------------------------
	
	GentrySeedGenerator	#(	.ORAML(					ORAML))				
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
	
	REWAESCore	#(			.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.BEDWidth(				BEDWidth))
				core(		.SlowClock(				Clock),
							.FastClock(				FastClock),
				`ifndef FPGA
							.Reset(					Reset),
				`else
							.Reset(					1'b0),
				`endif
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
	
	assign	ROHeaderMask =							{	{BktHSize_RndBits-ROHeader_VUBits-AESEntropy{1'b0}},
														ROMaskBufOutData, 
														{AESEntropy{1'b0}}	};
	
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
				if (DelayedWB & RWAccess & PathWriteback)
					NS_CO =							ST_CO_Write; // TODO Hacky ... add an IDLE state
				else if (StartROI & ROAccess)
					NS_CO =							ST_CO_ROI;
				else if (StartROI & RWAccess)
					if (DelayedWB)
						NS_CO =						ST_CO_Read;
					else
						NS_CO =						ST_CO_Write;
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
		assign	ROI_UMatches[i] =					DataOutV[i] & (ROPAddr_Internal == DataOutU[ORAMU*(i+1)-1:ORAMU*i]);
	end endgenerate
					
	assign	ROI_FoundBucket =						BufferedDataOutValid & ROMaskBufOutValid & 	ROAccess & MaskIsHeader & ~CSCOWrite & |ROI_UMatches;
	assign	ROI_NotFoundBucket =					BufferedDataOutValid & ROMaskBufOutValid &	ROAccess & ProcessingLastHeader & ~ROI_HeaderValid & ~ROI_FoundBucket;
	
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
	
	generate if (Overclock) begin:INFO_ROIBUFF
		Register #(			.Width(					1),
							.Initial(				1'b1))
				roi_is_gate(.Clock(					Clock),
							.Reset(					ROI_HeaderLoad),
							.Set(					Reset |	FinishWBOut),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ROIInfoEnable));

		Register #(			.Width(					1))
				roi_ir_dly(	.Clock(					Clock),
							.Reset(					Reset),						
							.Set(					1'b0),
							.Enable(				1'b1),
							.In(					ROI_NotFoundBucket),
							.Out(					ROIInfoReset));							
	end else begin:INFO_ROIPASS
		assign	ROIInfoReset =						ROI_NotFoundBucket;
		assign	ROIInfoEnable =						ROI_HeaderLoad;
	end endgenerate
	
	Register	#(			.Width(					AESEntropy + BIDWidth + BigUWidth + BigVWidth))
				roi_info(	.Clock(					Clock),
							.Reset(					ROIInfoReset), // If we don't find the block of interest, we have to send a VersionNumber == 0
							.Set(					1'b0),
							.Enable(				ROIInfoEnable),
							.In(					{BufferedIV, 		BufferedBID,	DataOutU, 	DataOutV}),
							.Out(					{ROI_GentryIV, 		ROI_BID,		ROI_U,		ROI_V}));
						
	assign	ROIDataInValid =						BufferedDataTransfer_Read & ROI_BufferBucket;						
								
	// Note: This buffer is only needed because the Path Buffer is a FIFO						
	generate if (Overclock) begin:ROIBUFF_LATCH
		// NOTE: this register is VERY important to help meet timing
		Register #(			.Width(					DDRDWidth + 1))
				roi_dly(	.Clock(					Clock),
							.Reset(					1'b0),
							.Set(					1'b0),
							.Enable(				1'b1),
							.In(					{BufferedDataOut, 		ROIDataInValid}),
							.Out(					{BufferedDataOut_Inner, ROIDataInValid_Inner}));		
	end else begin:ROIBUFF_PASS
		assign	ROIDataInValid_Inner =				ROIDataInValid;
		assign	BufferedDataOut_Inner =				BufferedDataOut;
	end endgenerate
	
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				BktSize_DRBursts))
				roi_P_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BufferedDataOut_Inner),
							.InValid(				ROIDataInValid_Inner),
							.InAccept(				ROIDataInReady),
							.OutData(				ROIData),
							.OutSend(				ROIDataValid),
							.OutReady(				ROIDataReady));
	
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
		
	assign	GentryHeaderMask =						(ROAccess) ? ((ROIMask_Needed) ? ROIHeaderMask : {DDRDWidth{1'b0}}) : 		RWBGHeaderMask;
	assign	GentryDataMask =						(ROIMask_Needed) ? 	ROIDataMask : 											RWBGDataMask;
	assign	Mask =									(MaskIsHeader) ? 	ROHeaderMask | GentryHeaderMask : 						GentryDataMask;
	
	// This won't prune any AES logic; it will just disable mask generation
	generate if (DebugAES) begin
		assign	DataOut_Unmask =					BufferedDataOut; 
	end else begin
		assign	DataOut_Unmask =					BufferedDataOut ^ Mask;
	end endgenerate 
	
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
														DataOut_Unmask[AESEntropy-1:0]
													};
	
	// Writeback the IVs that we used to generate the new ROHeaderMasks to 
	// memory
	assign	OutputExternalIV =						(MaskIsHeader) ? WritebackROIVOutData : DataOut_Unmask[AESEntropy-1:0]; 
	assign	DataOut_Write =							{
														DataOut_Unmask[DDRDWidth-1:BktHVStart],
														OutputExternalIV
													};
	
	// Standard RV FIFO arbitration: 3 input sources -> 1 output source
	assign	DataOutValid =							 BDataValid_Needed & 		ROMaskValid_Needed & RMMaskValid_Needed & 	(RMMask_Needed | ROIMask_Needed | ROMask_Needed);

	// We split these signals apart to help meet timing (using DRAMWriteDataReady_Pre when you don't need to is DISASTROUS for timing)
	assign	BufferedDataOutReady_Read =				 							ROMaskValid_Needed & RMMaskValid_Needed;
	assign	BufferedDataOutReady_Write =			 DRAMWriteDataReady_Pre &	ROMaskValid_Needed & RMMaskValid_Needed;
	assign	BufferedDataOutReady =					 DataOutReady & 			ROMaskValid_Needed & RMMaskValid_Needed;
	
	assign	RMMaskReady =							(DataOutReady & 			ROMaskValid_Needed & BDataValid_Needed) & 	RMMask_Needed;
	assign	ROIMaskShiftOutReady =					(DataOutReady & 			ROMaskValid_Needed & BDataValid_Needed) & 	ROIMask_Needed;
	assign	ROMaskBufOutReady =						 DataOutReady & 			RMMaskValid_Needed & BDataValid_Needed & 	ROMask_Needed;
	
	assign	DataOutReady =							(PathRead) ? 1'b1 : DRAMWriteDataReady_Pre;
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
	
	// NOTE: The inner signals are here in case we want to pipeline it ...
	assign	BEDataIn_Inner =						BEDataIn;
	assign	BEDataInValid_Inner =					BEDataInValid;
	assign	BEDataInReady = 						CSROWrite & BufferedDataInReady;
	
	//--------------------------------------------------------------------------
	//	DRAM Write Interface
	//--------------------------------------------------------------------------
	
	assign	DRAMWriteData_Pre =						DataOut_Write;
	assign	DRAMWriteDataValid_Pre =				PathWriteback & DataOutValid;
	
	generate if (Overclock) begin:PIPE_DRAMOUT
		FIFORegister #(		.Width(					DDRDWidth))
				dramout_dly(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMWriteData_Pre),
							.InValid(				DRAMWriteDataValid_Pre),
							.InAccept(				DRAMWriteDataReady_Pre),
							.OutData(				DRAMWriteData),
							.OutSend(				DRAMWriteDataValid),
							.OutReady(				DRAMWriteDataReady));	
	end else begin:PASS_DRAMOUT
		assign	DRAMWriteData =						DRAMWriteData_Pre;
		assign	DRAMWriteDataValid =				DRAMWriteDataValid_Pre;
		assign	DRAMWriteDataReady_Pre =			DRAMWriteDataReady;
	end endgenerate
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
