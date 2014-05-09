
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		CoherenceController
//	Desc:		Create a coherent view of data in ORAM tree to backend & 
//				integrity verification.  Notation: REW accesses = RO, H, R, W
//
//				Schedule: [ R W (backend only) {E{RO H}} W (write to memory) ] repeat
//
//				Summary of jobs:
//
//				1 - R access:
//					- Store the path read during the access.  This path will be periodically read by IV unit to check R hashes.
//				2 - BACKEND completes W access:
//					- Store plaintext bits that will be written back.  These bits will be periodically read by the IV unit to re-create W hashes.
//					- IV unit will send new hashes back to CoherenceController, which will insert them in proper locations
//				3 - RO access: [coherence step]
//					- For each RO bucket received from AES (decrypted in certain cases), compare that bucket to the set of buckets stored from step 2.  For each aliasing bucket, forward W data to BE/IV unit.
//					- Invariant: all data forwarded to IV/BE must be freshest copy of the data.
//					- Store decrypted header sent from AES (after being coherence checked) internally.
//					- Send IV the bucket of interest to be hashed; send rest to BE
//					- When IV returns hash, merge hash & any modified valid bits back into W path and headers (stored internally) if the bucket of interest had a collision
//				4 - H access: 
//					- Push updated headers back to AES
//				5 - W access (writes to external memory)
//					- Push the fully up to date W path (stored internally and coherent) back to memory
//==============================================================================
module CoherenceController(
	Clock, Reset,
	
    ROPAddr, ROLeaf, ROStart, REWRoundDummy,

	FromDecData, FromDecDataValid, FromDecDataReady,
	ToEncData, ToEncDataValid, ToEncDataReady,
	
	ToStashData, ToStashDataValid, ToStashDataReady,
	FromStashData, FromStashDataValid, FromStashDataReady, FromStashDataDone,
	
	IVRequest, IVWrite, IVAddress, DataFromIV, DataToIV, ROIBV, ROIBID,
	PathReady_IV, PathDone_IV, BOIReady_IV, BktOfIIdx, BOIFromCC, BOIDone_IV, BucketOfITurn
);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

    `include "PathORAM.vh"
    
	`include "SecurityLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "SHA3Local.vh"
	
	parameter	BRAMLatency = 2;
			
	localparam	ORAMLogL = `log2(ORAML+1);
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	input	[ORAMU-1:0]		ROPAddr;
	input	[ORAML-1:0]		ROLeaf;
    input					ROStart, REWRoundDummy;
	
	//--------------------------------------------------------------------------
	//	AES Interface
	//--------------------------------------------------------------------------
	
	// All read path data from AES
	input	[DDRDWidth-1:0]	FromDecData;
	input					FromDecDataValid;
	output					FromDecDataReady, FromStashDataDone;
	
	// All writeback path data to AES
	output	[DDRDWidth-1:0]	ToEncData;
	output					ToEncDataValid;
	input					ToEncDataReady;

	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------

	// Writeback data
	input	[DDRDWidth-1:0]	FromStashData;
	input					FromStashDataValid;
	output					FromStashDataReady;
	
	// Read data
	output	[DDRDWidth-1:0]	ToStashData;
	output					ToStashDataValid;
	input					ToStashDataReady;	
		
	//--------------------------------------------------------------------------
	//	Integrity Interface
	//--------------------------------------------------------------------------

	input 						IVRequest, IVWrite;
	input 	[PathBufAWidth-1:0] 	IVAddress;
	input 	[DDRDWidth-1:0]  	DataFromIV;
	output 	[DDRDWidth-1:0]  	DataToIV;
	
	output	[AESEntropy-1:0] 	ROIBV;
	output	[ORAML:0]			ROIBID;
	
	output  					PathReady_IV, BOIReady_IV, BOIFromCC;
	output	[ORAMLogL-1:0]		BktOfIIdx;
	input						PathDone_IV, BOIDone_IV, BucketOfITurn;
	
	wire 	ROAccess, RWAccess, PathRead, PathWriteback;
	
	wire 	RW_R_DoneAlarm, RW_W_DoneAlarm, RO_R_DoneAlarm, RO_W_DoneAlarm;
	
	//--------------------------------------------------------------------------
	// CC status control logic
	//-------------------------------------------------------------------------- 
	localparam	RW_R_Chunk = PathSize_DRBursts,
				RW_W_Chunk = PathSize_DRBursts,
				RO_R_Chunk = (ORAML+1) * BktHSize_DRBursts + BktSize_DRBursts,
				RO_W_Chunk = (ORAML+1) * BktHSize_DRBursts;
	
	wire	[`log2(RO_R_Chunk)-1:0]		RO_R_Ctr;
	
	REWStatCtr	#(			.ORAME(					ORAME),
							.Overlap(				0),
							.DelayedWB(				DelayedWB),
							.RW_R_Chunk(			RW_R_Chunk),
							.RW_W_Chunk(			RW_W_Chunk),
							.RO_R_Chunk(			RO_R_Chunk),
							.RO_W_Chunk(			RO_W_Chunk))
							
		rew_stat		(	.Clock(					Clock),
							.Reset(					Reset),
							
							.RW_R_Transfer(			ToStashDataReady && ToStashDataValid),
							.RW_W_Transfer(			ToEncDataValid && ToEncDataReady),
							.RO_R_Transfer(			FromDecDataValid && FromDecDataReady),
							.RO_W_Transfer(			ToEncDataValid && ToEncDataReady),
							
							.ROAccess(				ROAccess),
							.RWAccess(				RWAccess),
							.Read(					PathRead),
							.Writeback(				PathWriteback),
							
							.RO_R_Ctr(				RO_R_Ctr),

							.RW_R_DoneAlarm(		RW_R_DoneAlarm),
							.RW_W_DoneAlarm(		RW_W_DoneAlarm),
							.RO_R_DoneAlarm(		RO_R_DoneAlarm),
							.RO_W_DoneAlarm(		RO_W_DoneAlarm)							
						);
	
	
	//--------------------------------------------------------------------------
	// CC handles header write back
	//-------------------------------------------------------------------------- 	
	wire	HeaderCmpValid;
	wire 	HeaderInValid, HeaderInBkfOfI, BktOfIInValid;	
		
	assign 	HeaderInValid  = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr < RO_R_Chunk - BktSize_DRBursts;
	assign	HeaderInBkfOfI = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr == RO_R_Chunk - BktSize_DRBursts;	
	assign	BktOfIInValid  = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr >= RO_R_Chunk - BktSize_DRBursts; 
		
	// invalidate the bit for the target block
	wire HdOfIDetect, HdOfIFound, HdOfIFound_Pre, HdOfIHasBeenFound;
	wire [DDRDWidth-1:0]	CoherentData, CoherentDataOfI, HeaderIn;

	BkfOfIDetector	#(		.DWidth(		DDRDWidth),
							.ValidBitStart(	AESEntropy),
							.ValidBitEnd(	AESEntropy+ORAMZ),
							.AddrStart(		BktHUStart),
							.AWidth(		ORAMU))
		vb_update_1	(		.Enable(		ROAccess && !REWRoundDummy),
							.AddrOfI(		ROPAddr),
							.DataIn(		CoherentData),
							.DataOut(		HeaderIn),
							.DataOfI(		CoherentDataOfI),
							.Detect(		HdOfIDetect)
					);
		
	assign HdOfIFound_Pre = HeaderCmpValid && HdOfIDetect;
	Register1Pipe	hoi_found	(Clock,	HdOfIFound_Pre, HdOfIFound);
	Register1b bkt_ofi_found	(Clock,	ROStart, HdOfIFound_Pre, HdOfIHasBeenFound);
	
	//--------------------------------------------------------------------------
	// Integrity Verification needs a dual-port path buffer and requires delaying path and header write back
	//-------------------------------------------------------------------------- 
    generate if (EnableIV) begin: FULL_BUF
		
		initial begin
			if (!EnableREW) begin
				$display("Integrity verification without REW ORAM? Not supported.");
				$finish;
			end
		end
	
		`include "IVCCLocal.vh"
		
		//------------------------------------------------------------------------------------------------------
		// in and out path buffer. 
		// 		port1 written by Stash, read and written by AES
		//		port2 read and written by integrity verifier
		//------------------------------------------------------------------------------------------------------
		wire 					BufP1_Enable, BufP1_Write;
		wire [PathBufAWidth-1:0] 	BufP1_Address;
		wire [DDRDWidth-1:0] 	BufP1_DIn, BufP1_DOut_Pre, BufP1_DOut;

		wire 					BufP2_Enable, BufP2_Write;
		wire [PathBufAWidth-1:0] 	BufP2_Address;
		wire [DDRDWidth-1:0] 	BufP2_DIn, BufP2_DOut_Pre, BufP2_DOut;
		
		RAM		#(          .DWidth(				DDRDWidth),     
                            .AWidth(				PathBufAWidth),
							.NPorts(				2))
							
            cc_path_buf  (	.Clock(					{2{Clock}}),
                            .Reset(					{2{Reset}}),
                            .Enable(				{BufP1_Enable, BufP2_Enable}),
                            .Write(					{BufP1_Write, BufP2_Write}),
                            .Address(				{BufP1_Address, BufP2_Address}),
                            .DIn(					{BufP1_DIn, BufP2_DIn}),
                            .DOut(					{BufP1_DOut_Pre, BufP2_DOut_Pre})
                        );     

		//--------------------------------------------------------------------------
		// Resolve conflict and produce coherent data
		//-------------------------------------------------------------------------- 
		wire 	HeaderInValid_dl, HeaderInBkfOfI_dl, BktOfIInValid_dl;
		wire	[DDRDWidth-1:0]		FromDecData_dl;
		
		// delay these 3 signals by 1 cycle to match the case where CC resolves conflict
		Register #(			.Width(		DDRDWidth + 3))
			from_dec_dl (	.Clock(		Clock),
							.Reset(		1'b0),
							.Set(		1'b0),
							.Enable(	1'b1),
							.In(		{HeaderInValid, 	HeaderInBkfOfI, 	BktOfIInValid,		FromDecData}),
							.Out(		{HeaderInValid_dl, 	HeaderInBkfOfI_dl, 	BktOfIInValid_dl,	FromDecData_dl})
						); 
		
		wire 	Intersect, Intersect_Pre; 
		wire	BktOfIUpdate_CC, BktOfIUpdate_CC_Pre;
		wire	ConflictHeaderLookup, ConflictHeaderOutValid, ConflictHeaderOutValid_Pre;
		wire	ConflictBktOfILookup, ConflictBktOfIOutValid, ConflictBktOfIOutValid_Pre;			
		wire 	[ORAMLogL-1:0]	IntersectCtr;
		
		wire	[AESEntropy-1:0]	GentryVersion;	
		wire	[ORAML-1:0]			GentryLeaf;			
		Counter	#(				.Width(					AESEntropy))
			gentry_leaf(		.Clock(					Clock),
								.Reset(					Reset),
								.Set(					1'b0),
								.Load(					1'b0),
								.Enable(				RW_W_DoneAlarm),
								.In(					{AESEntropy{1'bx}}),
								.Count(					GentryVersion)
							);
		assign	GentryLeaf = GentryVersion[ORAML-1:0];
		
		ConflictTracker #(	.ORAML(ORAML))
			conf_tracker(	.Clock(			Clock),
							.Reset(			Reset),
							.ROStart(		ROStart),
							.ROLeaf(		ROLeaf),
							.GentryLeaf(	GentryLeaf),
							.IntersectInc(	ConflictHeaderOutValid),
							.Intersect(		Intersect_Pre),
							.IntersectCtr(	IntersectCtr)
						);

		Register1Pipe #(1)	intersect_dl	(Clock,	Intersect_Pre, Intersect);					
		Register1b 			boi_intersect 	(Clock, ROStart, HdOfIFound && Intersect, BOIFromCC);
		
		assign	ConflictHeaderLookup = Intersect && HeaderInValid;
		assign	ConflictBktOfILookup = BOIFromCC && BktOfIInValid;
		Register1Pipe #(	.Width(2))	
			conf_out (	Clock,	  {ConflictHeaderLookup, ConflictBktOfILookup}, 	
						          {ConflictHeaderOutValid_Pre, ConflictBktOfIOutValid_Pre});
		
		wire	BufP1Reg_DInValid, BufP1Reg_DInValid_Pre;
		wire	DontCareHd, DontCareHd_Pre;
		wire	HdOfIWriteBack, HdOfIWriteBack_Pre;
		if (BRAMLatency == 1) begin
			assign	BufP1_DOut = BufP1_DOut_Pre;
			assign	{ConflictHeaderOutValid, ConflictBktOfIOutValid, BufP1Reg_DInValid, DontCareHd, BktOfIUpdate_CC, HdOfIWriteBack} 
					= {ConflictHeaderOutValid_Pre, ConflictBktOfIOutValid_Pre, BufP1Reg_DInValid_Pre, DontCareHd_Pre, BktOfIUpdate_CC_Pre, HdOfIWriteBack_Pre};
		end else if (BRAMLatency == 2) begin
			Register1Pipe #(DDRDWidth)	
				bufP1_out_reg	(Clock,	BufP1_DOut_Pre, BufP1_DOut);
										
			Register1Pipe #(6)							
				conf_out_reg	(Clock,	{ConflictHeaderOutValid_Pre, ConflictBktOfIOutValid_Pre, BufP1Reg_DInValid_Pre, DontCareHd_Pre, BktOfIUpdate_CC_Pre, HdOfIWriteBack_Pre},
										{ConflictHeaderOutValid, ConflictBktOfIOutValid, BufP1Reg_DInValid, DontCareHd, BktOfIUpdate_CC, HdOfIWriteBack});
		end else begin
			initial $finish;
		end
	
		assign 	CoherentData = (ConflictHeaderOutValid || ConflictBktOfIOutValid)? BufP1_DOut : FromDecData;
						
		localparam	BktCtrAWidth = `log2(BktSize_DRBursts+1);
		wire	[BktCtrAWidth-1:0]		BktOfIOffset;			
		assign	BktOfIOffset = RO_R_Ctr - (ORAML+1) * BktHSize_DRBursts;
				
		Register1Pipe #(.Width(1)) boi_update (Clock, BOIFromCC && HeaderInBkfOfI, BktOfIUpdate_CC_Pre);
	`ifdef SIMULATION		
		always @(posedge Clock) begin
			if (BktOfIUpdate_CC && HeaderInBkfOfI) begin
				$display("Error: CC needs one idle cycle after header of bucket of interest!");
				$stop;
			end
		end
	`endif
			// update BktOfI header in CC rather late than early.
			// too early --> Stash receives no valid block
			// too late --> IV takes the old header data
		
		//--------------------------------------------------------------------------
		// Port1 : written by Stash, read and written by AES, read and written by CC to resolve conflict
		//-------------------------------------------------------------------------- 	
	
		// Port control signals
		wire  					PthRW, HdRW;
		wire [ORAMLogL-1:0]		HdOnPthCtr, LastHdOnPthCtr;
		wire [PthBSTWidth-1:0]	BlkOnPthCtr;
		wire 					PthCtrEnable, HdCtrEnable;
		wire 					HdRW_Transition, PthRW_Transition;			
					
		// RWAccessExtend: a hack to accept stash RW_W data
		wire RWAccessExtend;
		Register1b stash_wb (Clock, RWStashWB && PthRW_Transition, RW_R_DoneAlarm, RWStashWB);			
		assign RWAccessExtend = RWAccess || RWStashWB;
		
		assign PthCtrEnable = RWAccessExtend && BufP1_Enable;
		CountAlarm #(		.Threshold(				PathSize_DRBursts))
			blk_ctr (		.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				PthCtrEnable),
							.Count(					BlkOnPthCtr),
							.Done(					PthRW_Transition)
					);
		
		assign HdCtrEnable = ROAccess && !RWAccessExtend && BufP1_Enable && !BktOfIUpdate_CC && !BktOfIInValid;
		CountAlarm #(		.Threshold(				ORAML + 1))
			hd_ctr (		.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				HdCtrEnable),
							.Count(					HdOnPthCtr),
							.Done(					HdRW_Transition)
					);
					
		assign	LastHdOnPthCtr = (HdOnPthCtr + ORAML) % (ORAML+1);
		
		wire RW_PathRead;
		assign	RW_PathRead = RWAccess && PathRead;		
		// 1 means write to buffer; 0 means read from buffer	// Note initial value is 1'b1 !!
		Register #(.Width(1)) pth_rw (Clock, 1'b0, Reset, RWAccessExtend && !RW_PathRead && PthRW_Transition, !PthRW, PthRW);
		Register #(.Width(1)) hd_rw  (Clock, 1'b0, Reset, ROAccess && HdRW_Transition, !HdRW, HdRW);
		
		Register #(.Width(ORAMLogL))
			boi_id_reg (Clock, 1'b0, 1'b0, HdOfIFound, 		LastHdOnPthCtr,		BktOfIIdx);
			
		assign	HdOfIWriteBack_Pre = ROAccess && PathWriteback && HdOfIHasBeenFound && LastHdOnPthCtr == BktOfIIdx;
		
		// output buffer to tolerate random delay and ensure full bandwidth
		wire	[DDRDWidth-1:0]		HdOfI;
		wire [DDRDWidth-1:0] 	BufP1Reg_DIn, BufP1Reg_DOut;
		wire 					BufP1Reg_DInReady, BufP1Reg_DOutValid, BufP1Reg_DOutReady;
		
		localparam				EmptyCWidth = `log2(2 + BRAMLatency + 1);
		wire [EmptyCWidth-1:0]				BufP1Reg_EmptyCount;		
		
		assign	DontCareHd_Pre = LastHdOnPthCtr < IntersectCtr;
		assign 	BufP1Reg_DIn =  DontCareHd ?  {DDRDWidth{1'b0}}
								: HdOfIWriteBack ? {HdOfI[DigestStart-1:DigestEnd], BufP1_DOut[DigestEnd-1:0]} 
								: BufP1_DOut;
								
		Register1Pipe #(	.Width(1))	to_enc_valid (Clock, PathWriteback && BufP1_Enable,	BufP1Reg_DInValid_Pre);
		
		FIFORAM #(			.Width(					DDRDWidth),
							.Buffering(				2 + BRAMLatency))
			out_path_reg (	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BufP1Reg_DIn),
							.InValid(				BufP1Reg_DInValid),
							.InAccept(				BufP1Reg_DInReady),
							.InEmptyCount(			BufP1Reg_EmptyCount),
							.OutData(				BufP1Reg_DOut),
							.OutSend(				BufP1Reg_DOutValid),
							.OutReady(				BufP1Reg_DOutReady));

		// TODO: How to clean up the following crap?		
		wire FromDecDataTransfer, FromStashDataTransfer;
		assign FromDecDataTransfer = FromDecDataReady && FromDecDataValid;
		assign FromStashDataTransfer = FromStashDataReady && FromStashDataValid;
		
		assign BufP1_Enable = RWAccessExtend ? 
									(	RW_PathRead ? FromDecDataTransfer
										: PthRW ? FromStashDataTransfer 
												: PathDone_IV && BufP1Reg_EmptyCount > BRAMLatency)			// Send data to AES							
							: ROAccess ? 
									(	PathRead ? (HeaderInValid || BktOfIInValid || BktOfIUpdate_CC )			// header and BktOfI from somewhere
																										// resolving conflict: read header and BktOfI
										: !HdRW && BOIDone_IV && BufP1Reg_EmptyCount > BRAMLatency)		// Send headers to AES
							: 0;							
			
		assign BufP1_Write = 	RWAccessExtend ? 	(	RW_PathRead ? 1'b1 : PthRW )
								: ROAccess ? (	PathRead ? !ConflictHeaderLookup && !ConflictBktOfILookup : HdRW )
								: 0;
		
		wire	[PathBufAWidth-1:0]		BktOfIStartAddr;
		Register #(			.Width(		PathBufAWidth),
							.ResetValue(OBktOfIStartAddr))			// default: boi from DRAM
			bkt_ofI_loc (	.Clock(		Clock),
							.Reset(		ROStart),
							.Set(		1'b0),
							.Enable(	HdOfIHasBeenFound && BOIFromCC),				// only update if boi is found on CC path
							.In(		OPthStartAddr + BktOfIIdx * BktSize_DRBursts),	// Location of BktOfI in CC buffer
							.Out(		BktOfIStartAddr)
						);
		
		assign BufP1_Address = RWAccessExtend ?  (	RW_PathRead ? IPthStartAddr + BlkOnPthCtr : OPthStartAddr + BlkOnPthCtr )
								: ROAccess ? (	PathRead ? 
											(	ConflictHeaderLookup ? OPthStartAddr + HdOnPthCtr * BktSize_DRBursts	// read header to resolve conflict	
												: BktOfIUpdate_CC ? BktOfIStartAddr
												: BktOfIInValid ? BktOfIStartAddr + BktOfIOffset		// bucket of interest								
												: HdStartAddr + HdOnPthCtr)		// save header										
										: HdStartAddr + HdOnPthCtr)				// header write back								
								: 0;
								
		assign BufP1_DIn = 	RWAccessExtend ? 	(	RW_PathRead ? FromDecData : FromStashData)							
							: ROAccess ? (	BktOfIInValid ? FromDecData
											: BktOfIUpdate_CC ? HeaderIn : HeaderIn) 
							: 0;	
		
		//	AES --> Stash
		wire	BktOfIOutValid [0:BRAMLatency], BktOfIHdOutValid;
		wire	[DDRDWidth-1:0]		ToStashData_Pre	[0:BRAMLatency];
		
		assign	BktOfIOutValid[0] = BOIFromCC ? ConflictBktOfIOutValid : BktOfIInValid;
		assign	BktOfIHdOutValid = BktOfIOutValid[0] && BktOfIOffset == BOIFromCC;
		assign	ToStashData_Pre[0] = 	BktOfIHdOutValid ? CoherentDataOfI : CoherentData;
		
		Register1Pipe #(1)	to_stash_valid1	(Clock,	BktOfIOutValid[0], BktOfIOutValid[1]);		
		Register1Pipe #(DDRDWidth)	to_stash_data1	(Clock,	ToStashData_Pre[0], ToStashData_Pre[1]);	
		if (BRAMLatency == 2) begin
			Register1Pipe #(1)	to_stash_valid2	(Clock,	BktOfIOutValid[1], BktOfIOutValid[2]);
			Register1Pipe #(DDRDWidth)	to_stash_data2	(Clock,	ToStashData_Pre[1], ToStashData_Pre[2]);
		end
		
		assign	ToStashData =			RW_PathRead ? FromDecData
											: BOIFromCC ? ToStashData_Pre[0] : ToStashData_Pre[BRAMLatency];
																					
		assign	ToStashDataValid = 		RW_PathRead ? FromDecDataValid 
											: BOIFromCC ? ConflictBktOfIOutValid : BktOfIOutValid[BRAMLatency];
											
		assign	FromDecDataReady = 		ToStashDataReady;

		// BufP1 --> buffer --> AES
		assign	ToEncData =				BufP1Reg_DOut;
		assign	ToEncDataValid = 		BufP1Reg_DOutValid;
		assign	BufP1Reg_DOutReady = 	ToEncDataReady;
		
		assign	FromStashDataReady = 	1'b1;	//RWAccessExtend; Note: CC is always ready to accept Stash data
		assign	FromStashDataDone = 	!RWAccess && RWAccessExtend && !RW_PathRead && BlkOnPthCtr == PathSize_DRBursts - 1;
		
		//--------------------------------------------------------------------------
		// Port2 : read and written by IV
		//--------------------------------------------------------------------------				
		assign 	PathReady_IV = RW_R_DoneAlarm;
		assign	BOIReady_IV = RO_R_DoneAlarm;
	
		assign  BufP2_Enable = IVRequest;
		assign  BufP2_Write = IVWrite;
		assign	BufP2_Address = IVAddress;
		assign  BufP2_DIn = DataFromIV;		
		
		wire 	BktOfIAccessedByIV, BktOfIAccessedByIV_1st_Pre, BktOfIAccessedByIV_1st;
		assign	BktOfIAccessedByIV = HdOfIHasBeenFound && BucketOfITurn && IVRequest && IVAddress == BktOfIStartAddr;		
		CountAlarm #(		.Threshold(				3),
							.IThreshold(			1))
			boi_by_IV (		.Clock(					Clock), 
							.Reset(					ROStart), 
							.Enable(				BktOfIAccessedByIV),
							.Intermediate(			BktOfIAccessedByIV_1st_Pre)
					);	
		
		Register #(.Width(DDRDWidth))
			hash_out_reg (Clock, 1'b0, 1'b0, BktOfIAccessedByIV && IVWrite, 		DataFromIV,		HdOfI);
		
		if (BRAMLatency == 1) begin
			assign	{BktOfIAccessedByIV_1st, BufP2_DOut} = {BktOfIAccessedByIV_1st_Pre, BufP2_DOut_Pre};
		end else if (BRAMLatency == 2) begin
			Register1Pipe #(DDRDWidth+1)	
				bufP2_out_reg	(Clock,	{BktOfIAccessedByIV_1st_Pre, BufP2_DOut_Pre}, 
										{BktOfIAccessedByIV_1st, BufP2_DOut});
		end else begin
			initial $finish;
		end
		
		BkfOfIDetector	#(		.DWidth(		DDRDWidth),
								.ValidBitStart(	AESEntropy),
								.ValidBitEnd(	AESEntropy+ORAMZ),
								.AddrStart(		BktHUStart),
								.AWidth(		ORAMU))
			vb_update_2	(		.Enable(		BktOfIAccessedByIV_1st),
								.AddrOfI(		ROPAddr),
								.DataIn(		BufP2_DOut),
								.DataOut(		DataToIV)
						);
		assign	HeaderCmpValid = Intersect ? ConflictHeaderOutValid : HeaderInValid;		
		
		wire	HeaderCmpValid_dl;
		wire	ROIVID_Enable;
		wire	[AESEntropy-1:0]	ROIBV_Pre;
		
		Register1Pipe #(1)	hd_cmp_dl	(Clock,	HeaderCmpValid, HeaderCmpValid_dl);
		assign	ROIVID_Enable = 	HeaderCmpValid_dl && !HdOfIHasBeenFound;	
		ROISeedGenerator	#(	.ORAML(			ORAML))				
				roi_vid	(		.Clock(			Clock),
								.ROStart(		ROStart),
								.ROLeaf(		ROLeaf),
								.GentryVersion(	GentryVersion + 1),
								.Enable(		ROIVID_Enable),	
								.ROIBV(			ROIBV_Pre), 
								.ROIBID(		ROIBID)
							);
		assign	ROIBV = HdOfIHasBeenFound ? ROIBV_Pre : {AESEntropy{1'b0}};
		
	end else begin: NO_BUF
	
		wire HeaderInReady, HeaderOutValid, HeaderOutReady;
		wire [DDRDWidth-1:0]	HeaderOut;
			 
		always @ (posedge Clock) begin		
			if (!Reset && HeaderInValid && !HeaderInReady) begin
				$display("Error: Header Buffer Overflow!");
				$finish;
			end
		end
	
		// save the headers and write them back later     
		FIFORAM	#(      .Width(					DDRDWidth),     
						.Buffering(				(ORAML+1) * BktHSize_DRBursts ))
		in_hd_buf  (	.Clock(					Clock),
						.Reset(					Reset),
						.InData(				HeaderIn),
						.InValid(				HeaderInValid),
						.InAccept(				HeaderInReady),
						.OutData(				HeaderOut),
						.OutSend(				HeaderOutValid),
						.OutReady(				HeaderOutReady)
					);     
	
		// no coherent problem
		assign HeaderCmpValid = HeaderInValid;
		assign CoherentData = FromDecData;
	
		//	AES --> Stash 	
		assign	ToStashData =			HeaderInBkfOfI ? CoherentDataOfI : CoherentData;

		assign	ToStashDataValid =		RWAccess ? FromDecDataValid : BktOfIInValid;
											
		assign	FromDecDataReady = 		ToStashDataReady;

		//	ROAccess: header write back CC --> AES. RWAccess: Stash --> AES
		assign	ToEncData =				ROAccess ? HeaderOut: FromStashData;
		assign	ToEncDataValid =		ROAccess ? HeaderOutValid  && PathWriteback:	FromStashDataValid;
		assign  HeaderOutReady = 		ROAccess && PathWriteback && ToEncDataReady;
		
		assign	FromStashDataReady = 	!ROAccess && ToEncDataReady;
		assign	FromStashDataDone = 	RW_W_DoneAlarm;
		
	end endgenerate

endmodule
//------------------------------------------------------------------------------


//==============================================================================
//	Helper module:		ConflictTracker
//	Desc:		determine what data should come from path buffer			
//==============================================================================

module ConflictTracker (
	Clock, Reset, 
	ROStart, ROLeaf, GentryLeaf,
	IntersectInc,
	Intersect, IntersectCtr
);
	parameter	ORAML = 0;
	localparam	ORAMLogL = `log2(ORAML+1);
	
	input 	Clock, Reset, ROStart, IntersectInc;
	input 	[ORAML-1:0]		ROLeaf, GentryLeaf;
	
	output	Intersect;	
	output	[ORAMLogL-1:0]	IntersectCtr;	
	
	wire					IntersectionShift;
	wire	[ORAML:0]		IntersectionIn;	
	assign	IntersectionIn = {GentryLeaf ^ ROLeaf, 1'b0};
	
	ShiftRegister #(		.PWidth(				ORAML+1),
							.Reverse(				1),
							.SWidth(				1))
			inter_shift(	.Clock(					Clock), 
							.Reset(					1'b0), 
							.Load(					ROStart),
							.Enable(				Intersect && IntersectInc), 
							.PIn(					IntersectionIn),
							.SIn(					1'b0),
							.SOut(					IntersectionShift));
	
	assign	Intersect = ~IntersectionShift;
			
	Counter	#(				.Width(					ORAMLogL))
		intersect_ctr(		.Clock(					Clock),
							.Reset(					ROStart),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				Intersect && IntersectInc),
							.In(					{ORAMLogL{1'bx}}),
							.Count(					IntersectCtr)
						);
endmodule

//==============================================================================
//	Helper module:		BkfOfIDetector
//	Desc:		determine BktOfI and manipulate valid bits			
//==============================================================================

module	BkfOfIDetector (Enable, AddrOfI, DataIn, DataOut, DataOfI, Detect);

	parameter	DWidth = 512;
	parameter	ValidBitStart = 1, ValidBitEnd = 5;
	parameter	AddrStart = 0;
	parameter	AWidth = 0;
	
	localparam	NumValidBits = ValidBitEnd - ValidBitStart;
	
	input					Enable;
	input	[AWidth-1:0]	AddrOfI;
	input	[DWidth-1:0]	DataIn;
	output					Detect;
	output	[DWidth-1:0]	DataOut, DataOfI;
		
	wire [NumValidBits-1:0]		ValidBitsIn, ValidBitsOfI, ValidBitsOut;
	
	genvar j;
	generate for (j = 0; j < NumValidBits; j = j + 1) begin: VALIB_BIT
		assign 	ValidBitsIn[j] = DataIn[ValidBitStart+j];
		assign	ValidBitsOfI[j] = ValidBitsIn[j] && Enable && AddrOfI == DataIn[AddrStart + (j+1)*AWidth - 1: AddrStart + j*AWidth];
			// one hot signal that if a block is of interest
	end endgenerate
	
	assign ValidBitsOut = ValidBitsOfI ^ ValidBitsIn;    
	
	assign DataOut = {DataIn[DWidth-1:ValidBitEnd], ValidBitsOut, DataIn[ValidBitStart-1:0]};
	assign DataOfI = {DataIn[DWidth-1:ValidBitEnd], ValidBitsOfI, DataIn[ValidBitStart-1:0]};

	assign Detect = Enable && (| ValidBitsOfI);
endmodule
