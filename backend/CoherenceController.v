
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
	PathReady_IV, PathDone_IV, BOIReady_IV, BOIFromCC, BOIDone_IV
);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

    `include "PathORAM.vh"
    
	`include "SecurityLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "SHA3Local.vh"
	
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
	input						PathDone_IV, BOIDone_IV;
	
	wire 	ROAccess, RWAccess, PathRead, PathWriteback;
	
	wire 	RW_R_DoneAlarm, RW_W_DoneAlarm, RO_R_DoneAlarm, RO_W_DoneAlarm;
	
	//--------------------------------------------------------------------------
	// CC status control logic
	//-------------------------------------------------------------------------- 
	localparam	RW_R_Chunk = PathSize_DRBursts,
				RW_W_Chunk = PathSize_DRBursts,
				RO_R_Chunk = (ORAML+1) * BktHSize_DRBursts + BktSize_DRBursts,
				RO_W_Chunk = (ORAML+1) * BktHSize_DRBursts;
	
	wire	[`log2(RW_R_Chunk)-1:0]		RW_R_Ctr;
	wire	[`log2(RW_W_Chunk)-1:0]		RW_W_Ctr;
	wire	[`log2(RO_R_Chunk)-1:0]		RO_R_Ctr;
	wire	[`log2(RO_W_Chunk)-1:0]		RO_W_Ctr;
	
	
	REWStatCtr	#(			.ORAME(					ORAME),
							.Overlap(				0),
							.DelayedWB(				DelayedWB),
							.RW_R_Chunk(			RW_R_Chunk),
							.RW_W_Chunk(			RW_W_Chunk),
							.RO_R_Chunk(			RO_R_Chunk),
							.RO_W_Chunk(			RO_W_Chunk))
							
		rew_stat		(	.Clock(					Clock),
							.Reset(					Reset),
							
							.RW_R_Transfer(			FromDecDataValid && FromDecDataReady),
							.RW_W_Transfer(			ToEncDataValid && ToEncDataReady),
							.RO_R_Transfer(			FromDecDataValid && FromDecDataReady),
							.RO_W_Transfer(			ToEncDataValid && ToEncDataReady),
							
							.ROAccess(				ROAccess),
							.RWAccess(				RWAccess),
							.Read(					PathRead),
							.Writeback(				PathWriteback),
							
							.RW_R_Ctr(				RW_R_Ctr),
							.RW_W_Ctr(				RW_W_Ctr),
							.RO_R_Ctr(				RO_R_Ctr),
							.RO_W_Ctr(				RO_W_Ctr),

							.RW_R_DoneAlarm(		RW_R_DoneAlarm),
							.RW_W_DoneAlarm(		RW_W_DoneAlarm),
							.RO_R_DoneAlarm(		RO_R_DoneAlarm),
							.RO_W_DoneAlarm(		RO_W_DoneAlarm)							
						);
	
	
	//--------------------------------------------------------------------------
	// CC handles header write back
	//-------------------------------------------------------------------------- 	
	wire	Intersect;
	wire 	HeaderInValid, HeaderInBkfOfI, BktOfIInValid;	
	wire 	ConflictHeaderLookup, ConflictHeaderOutValid;
		
	assign 	HeaderInValid  = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr < RO_R_Chunk - BktSize_DRBursts;
	assign	HeaderInBkfOfI = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr == RO_R_Chunk - BktSize_DRBursts;	
	assign	BktOfIInValid  = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr >= RO_R_Chunk - BktSize_DRBursts; 
		
	// invalidate the bit for the target block
	wire HdOfIFound;
	wire [DDRDWidth-1:0]	CoherentData, HeaderIn;
	wire [ORAMZ-1:0]        ValidBitsIn, ValidBitsOfI, ValidBitsOut;
	
	genvar j;
	for (j = 0; j < ORAMZ; j = j + 1) begin: VALID_BIT
		assign 	ValidBitsIn[j] = CoherentData[AESEntropy+j];
		assign	ValidBitsOfI[j] = ValidBitsIn[j] && ROAccess && (!REWRoundDummy && ROPAddr == CoherentData[BktHUStart + (j+1)*ORAMU - 1: BktHUStart + j*ORAMU]);
			// one hot signal that if a block is of interest
	end 	
	assign ValidBitsOut = ValidBitsOfI ^ ValidBitsIn;    
	
	assign HdOfIFound = (Intersect ? ConflictHeaderOutValid : HeaderInValid) && !REWRoundDummy && (| ValidBitsOfI);
	assign HeaderIn = {CoherentData[DDRDWidth-1:AESEntropy+ORAMZ], ValidBitsOut, CoherentData[AESEntropy-1:0]};
	
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
		wire 					BufP1_Enable, BufP2_Enable, BufP1_Write, BufP2_Write;
		wire [PathBufAWidth-1:0] 	BufP1_Address, BufP2_Address;
		wire [DDRDWidth-1:0] 	BufP1_DIn, BufP2_DIn, BufP1_DOut, BufP2_DOut;
		
		RAM		#(          .DWidth(				DDRDWidth),     
                            .AWidth(				PathBufAWidth),
							.NPorts(				2))
							
            cc_path_buf  (	.Clock(					{2{Clock}}),
                            .Reset(					{2{Reset}}),
                            .Enable(				{BufP1_Enable, BufP2_Enable}),
                            .Write(					{BufP1_Write, BufP2_Write}),
                            .Address(				{BufP1_Address, BufP2_Address}),
                            .DIn(					{BufP1_DIn, BufP2_DIn}),
                            .DOut(					{BufP1_DOut, BufP2_DOut})
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
			
		localparam	ORAMLogL = `log2(ORAML+1);
		
		wire [ORAMLogL-1:0]		HdOnPthCtr, LastHdOnPthCtr, IntersectCtr;
		wire 					HdOfIUpdate, HdOfIWriteBack;
		wire 					PthCtrEnable, HdCtrEnable;
		
		wire					BktOfIAccessedByIV;
		
		reg	[DDRDWidth-1:0]		HdOfI;
		reg	[ORAMLogL-1:0]		BktOfIIdx;
		
		assign	BktOfIAccessedByIV = HdOfIStat < 3 && IVRequest && IVAddress == OBktOfIStartAddr;
		assign	HdOfIUpdate = BktOfIAccessedByIV && HdOfIStat == 2 && IVWrite;
				
		assign	LastHdOnPthCtr = (HdOnPthCtr + ORAML) % (ORAML+1);
		
		assign 	CoherentData = (ConflictHeaderOutValid || ConflictBktOfIOutValid)? BufP1_DOut : FromDecData;
				
		wire	[ORAML-1:0]		GentryLeaf;			
		Counter	#(				.Width(					ORAML))
			gentry_leaf(		.Clock(					Clock),
								.Reset(					Reset),
								.Set(					1'b0),
								.Load(					1'b0),
								.Enable(				RW_W_DoneAlarm),
								.In(					{ORAML{1'bx}}),
								.Count(					GentryLeaf)
							);
		
		ConflictTracker #(	.ORAML(ORAML))
			conf_tracker(	.Clock(			Clock),
							.Reset(			Reset),
							.ROStart(		ROStart),
							.ROLeaf(		ROLeaf),
							.GentryLeaf(	GentryLeaf),
							.IntersectInc(	ConflictHeaderOutValid),
							.Intersect(		Intersect),
							.IntersectCtr(	IntersectCtr)
						);
		
		wire	BktOfIIntersect, BktOfIUpdate_CC, ConflictBktOfILookup, ConflictBktOfIOutValid;		
		wire	BktOfIOutValid, BktOfIHdOutValid;
		
		assign	ConflictHeaderLookup = Intersect && HeaderInValid;
		assign	ConflictBktOfILookup = BktOfIIntersect && BktOfIInValid;
		Register #(		.Width(2)) 
			conf_out (	Clock, Reset, 1'b0, 1'b1, 
						{ConflictHeaderLookup, ConflictBktOfILookup},
						{ConflictHeaderOutValid, ConflictBktOfIOutValid} 
					);
		
		localparam	BktCtrAWidth = `log2(BktSize_DRBursts+1);
		wire	[BktCtrAWidth-1:0]		BktOfIOffset;			
		assign	BktOfIOffset = RO_R_Ctr - (ORAML+1) * BktHSize_DRBursts;
		
		Register #(.Width(1)) boi_intersect (Clock, ROStart, 1'b0, HdOfIFound, Intersect, BktOfIIntersect);
		Register #(.Width(1)) boi_update (Clock, Reset, 1'b0, 1'b1, BktOfIIntersect && BOIReady_IV, BktOfIUpdate_CC);	
			// update BktOfI header in CC rather late than early.
			// too early --> Stash receives no valid block
			// too late --> IV takes the old header data
		
		assign	BktOfIOutValid = BktOfIIntersect ? ConflictBktOfIOutValid : BktOfIInValid;
		assign	BktOfIHdOutValid = BktOfIOutValid && BktOfIOffset == BktOfIIntersect;
		
		//--------------------------------------------------------------------------
		// Port1 : written by Stash, read and written by AES, read and written by CC to resolve conflict
		//-------------------------------------------------------------------------- 	
		wire [DDRDWidth-1:0] 	BufP1Reg_DIn, BufP1Reg_DOut;
		wire 					BufP1Reg_DInValid, BufP1Reg_DInReady, BufP1Reg_DOutValid, BufP1Reg_DOutReady;
		wire [1:0]				BufP1Reg_EmptyCount;
		wire					BufP1Reg_DInValid_Pre;
			
		assign	HdOfIWriteBack = ROAccess && PathWriteback && HdOfIStat == 2 && LastHdOnPthCtr == BktOfIIdx;
		assign 	BufP1Reg_DIn =  LastHdOnPthCtr < IntersectCtr ?  {DDRDWidth{1'b0}}
								: HdOfIWriteBack ? {HdOfI[DigestStart-1:DigestEnd], BufP1_DOut[DigestEnd-1:0]} 
								: BufP1_DOut;
		
		FIFORAM #(			.Width(					DDRDWidth),
							.Buffering(				3))
			out_path_reg (	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BufP1Reg_DIn),
							.InValid(				BufP1Reg_DInValid),
							.InAccept(				BufP1Reg_DInReady),
							.InEmptyCount(			BufP1Reg_EmptyCount),
							.OutData(				BufP1Reg_DOut),
							.OutSend(				BufP1Reg_DOutValid),
							.OutReady(				BufP1Reg_DOutReady));
							
		assign	BufP1Reg_DInValid_Pre = PathWriteback && BufP1_Enable;
		Register #(	.Width(1))	// TODO: Read from P1 but not for AES? Yes, when delayed write back
			to_enc_valid ( Clock, Reset, 1'b0, 1'b1, 	BufP1Reg_DInValid_Pre,	BufP1Reg_DInValid);
		
		reg  PthRW, HdRW;
		wire [PthBSTWidth-1:0]	BlkOnPthCtr;
		wire HdRW_Transition, PthRW_Transition;			
		
		wire FromDecDataTransfer, FromStashDataTransfer;
		assign FromDecDataTransfer = FromDecDataReady && FromDecDataValid;
		assign FromStashDataTransfer = FromStashDataReady && FromStashDataValid;
		
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
		
		// 1 means write to buffer; 0 means read from buffer
		always @(posedge Clock) begin
			if (Reset) begin
				PthRW <= 1'b1;
				HdRW <= 1'b1;
			end
			else begin 
				if (RWAccessExtend && !RW_PathRead && PthRW_Transition) 
					PthRW <= !PthRW;				
				else if (ROAccess && HdRW_Transition) 
					HdRW <= !HdRW;			
			end
		end
	
		// TODO: How to clean up the following crap?
		
		wire RW_PathRead;
		assign	RW_PathRead = RWAccess && PathRead;
		
		assign BufP1_Enable = RWAccessExtend ? 
									(	RW_PathRead ? FromDecDataTransfer
										: PthRW ? FromStashDataTransfer 
												: PathDone_IV && BufP1Reg_EmptyCount > 1)			// Send data to AES							
							: ROAccess ? 
									(	PathRead ? (HeaderInValid || BktOfIInValid || BktOfIUpdate_CC )			// header and BktOfI from somewhere
																								// resolving conflict: read header and BktOfI
										: !HdRW && BOIDone_IV && BufP1Reg_EmptyCount > 1)		// Send headers to AES
							: 0;							
			
		assign BufP1_Write = 	RWAccessExtend ? 	(	RW_PathRead ? 1'b1 : PthRW )
								: ROAccess ? (	PathRead ? !ConflictHeaderLookup && !ConflictBktOfILookup : HdRW )
								: 0;
		
		wire	[PathBufAWidth-1:0]		BktOfIStartAddr;
		assign	BktOfIStartAddr = BktOfIIntersect ? OPthStartAddr + BktOfIIdx * BktSize_DRBursts : OBktOfIStartAddr;  // BktOfI from DRAM or from CC?
		
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
											: BktOfIUpdate_CC ? HdOfI
											: HeaderIn) 
							: 0;	
		
		//	AES --> Stash 
		assign	ToStashData =			BktOfIHdOutValid ? {CoherentData[DDRDWidth-1:AESEntropy+ORAMZ], ValidBitsOfI, CoherentData[AESEntropy-1:0]}
											: CoherentData;
											
		assign	ToStashDataValid = 		RWAccess ? FromDecDataValid : BktOfIOutValid;
											
		assign	FromDecDataReady = 		ToStashDataReady;

		// BufP1 --> buffer --> AES
		assign	ToEncData =				BufP1Reg_DOut;
		assign	ToEncDataValid = 		BufP1Reg_DOutValid;
		assign	BufP1Reg_DOutReady = 	ToEncDataReady;
		
		assign	FromStashDataReady = 	RWAccessExtend;
		assign	FromStashDataDone = 	!RWAccess && RWAccessExtend && !RW_PathRead && BlkOnPthCtr == PathSize_DRBursts - 1;
		
		//--------------------------------------------------------------------------
		// Port2 : read and written by IV
		//--------------------------------------------------------------------------

		reg  [ORAMZ-1:0]			ValidBitsReg;
		reg	 [2:0] 	HdOfIStat;
			
		assign 	PathReady_IV = RW_R_DoneAlarm;
		assign	BOIReady_IV = RO_R_DoneAlarm;
		assign	BOIFromCC = BktOfIIntersect;
		
		assign  BufP2_Enable = IVRequest;
		assign  BufP2_Write = IVWrite;
		assign  BufP2_Address = (IVAddress >= OBktOfIStartAddr && BktOfIIntersect) ? IVAddress - (ORAML+1-BktOfIIdx) * BktSize_DRBursts : IVAddress;
		assign  BufP2_DIn = DataFromIV;		
		
		assign  DataToIV = (HdOfIStat != 1) ? BufP2_DOut : {BufP2_DOut[DDRDWidth-1:AESEntropy+ORAMZ], ValidBitsReg, BufP2_DOut[AESEntropy-1:0]};;
		
		assign	ROIBID = 0;
		
		wire	[AESEntropy-1:0]	ROIBV_Pre, ROIBV_Next;
		wire	HeaderOutValid_CC;
		
		assign	HeaderOutValid_CC = Intersect ? ConflictHeaderOutValid : HeaderInValid;
		assign	ROIBV_Next = ROStart ? (GentryLeaf + 1) : ((ROIBV_Pre + 1 - RO_LeafNextDirection) / 2);
		
		Register	#(			.Width(					AESEntropy))
				ro_gentry(		.Clock(					Clock),
								.Reset(					1'b0),
								.Set(					1'b0),
								.Enable(				ROStart | HeaderOutValid_CC),
								.In(					ROIBV_Next),
								.Out(					ROIBV_Pre)
							);
								
		ShiftRegister #(		.PWidth(				ORAML),
								.Reverse(				1),
								.SWidth(				1))
				ro_L_shft(		.Clock(					Clock), 
								.Reset(					1'b0), 
								.Load(					ROStart),
								.Enable(				HeaderOutValid_CC), 
								.PIn(					ROLeaf),
								.SIn(					1'b0),
								.SOut(					RO_LeafNextDirection)
						);
		
		Register	#(			.Width(					AESEntropy))
			roi_v_out	(		.Clock(					Clock),
								.Reset(					ROStart),
								.Set(					1'b0),
								.Enable(				HdOfIFound),
								.In(					ROIBV_Pre),
								.Out(					ROIBV)
						);
		
		// hacky solution to pass the two versions of bucket of interest to IV	
		always @(posedge Clock) begin
		    if (Reset) begin
		        HdOfIStat <= 7;
		    end
					
			else if (HdOfIFound) begin
				HdOfIStat <= 0;
				BktOfIIdx <= Intersect ? LastHdOnPthCtr : HdOnPthCtr;
				HdOfI <= HeaderIn;
				ValidBitsReg  <=  ValidBitsOut;		// save new valid bits
			end
			
			// there should be 2 reads and 1 write
			// 0 - found; 1 - have read once; 2 - have read twice; 3 - all set.		
			else if (BktOfIAccessedByIV) begin	
				if (!IVWrite && HdOfIStat < 2)
					HdOfIStat <= HdOfIStat + 1;
				else
					HdOfI[DigestStart-1:DigestEnd] <= DataFromIV[DigestStart-1:DigestEnd];			
			end
			
			else if (HdOfIStat == 2 && PathRead)
				HdOfIStat <= 7;
		end
		
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
		assign Intersect = 1'b0;
		assign ConflictHeaderLookup = 1'b0;
		assign ConflictHeaderOutValid = 1'b0;
		assign CoherentData = FromDecData;
	
		//	AES --> Stash 	
		assign	ToStashData =			HeaderInBkfOfI ? {FromDecData[DDRDWidth-1:AESEntropy+ORAMZ], ValidBitsOfI, FromDecData[AESEntropy-1:0]}
											: FromDecData;
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
	
	wire	[ORAML:0]		IntersectionIn, IntersectionShift;	
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
							.POut(					IntersectionShift));
	
	assign	Intersect = !IntersectionShift[0];
			
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
	