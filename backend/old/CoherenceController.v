//==============================================================================
//	Module:		CoherenceController
//	Desc:		Create a coherent view of data in ORAM tree to backend & integrity verifier (IV)
//				Notation: REW accesses = RO, H, R, W
//
//				Schedule: [ R W (backend only) {E{RO H}} W (write to memory) ] repeat
//
//				Summary of jobs:
//				1 - R access:
//					- Buffer the path read during the access.  This path will be periodically read by IV to check the hashes.
//				2 - Stash completes W access:
//					- Buffer outgoing access in plaintext.  These bits will be periodically read by IV to re-create the hashes.
//					- IV will insert new hashes in proper locations
//				3 - RO access: [coherence step]
//					- Take the most recent version of each bucket, either from AES or in outgoing buffer
//					- Forward the bucket of interest to Stash and IV
//					- Buffer decrypted header from AES.
//					- When IV rehash the bucket of interest, update its headers and start H access
//				4 - H access: 
//					- Send updated headers back to AES
//				5 - W access (writes to external memory)
//					- Send the fully up-to-date and hashed W path back to memory
//==============================================================================

`include "Const.vh"

module CoherenceController(
	Clock, Reset,
	ROCmdValid, ROCmdReady, 
    ROPAddrIn, ROLeafIn, RODummyIn,

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
    
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "SHA3Local.vh"
	
	parameter	BRAMLatency = 2;
			
	localparam	ORAMLogL = `log2(ORAML+1);
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	input					ROCmdValid;
	output					ROCmdReady;
	input	[ORAMU-1:0]		ROPAddrIn;
	input	[ORAML-1:0]		ROLeafIn;
    input					RODummyIn;
	
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
	
	(* mark_debug = "TRUE" *) wire 	ROAccess, RWAccess, PathRead, PathWriteback, RWAccessExtend;
	
	(* mark_debug = "TRUE" *) wire 	RW_R_DoneAlarm, RW_W_DoneAlarm, RO_R_DoneAlarm, RO_W_DoneAlarm;
	
	//--------------------------------------------------------------------------
	// CC status control logic
	//-------------------------------------------------------------------------- 
	(* mark_debug = "TRUE" *) wire					ROStart;
	(* mark_debug = "TRUE" *) wire	[ORAMU-1:0]		ROPAddr;
	(* mark_debug = "TRUE" *) wire	[ORAML-1:0]		ROLeaf;
    (* mark_debug = "TRUE" *) wire					RODummy;
	
	FIFORegister #(		.Width(			ORAMU+ORAML+1), 
						.BWLatency(		1)) 
		cmd_reg (		.Clock(			Clock),
						.Reset(			Reset),
						.InData(		{ROPAddrIn,	ROLeafIn, RODummyIn}),
						.InValid(		ROCmdValid),
						.InAccept(		ROCmdReady),
						.OutData(		{ROPAddr,	ROLeaf, RODummy}),
						.OutReady(		RO_W_DoneAlarm)
				);				
	Pipeline #(.Width(1), .Stages(1))	
		ro_start (Clock, 	Reset, 	ROCmdReady && ROCmdValid,		ROStart);
	
	localparam	RW_R_Chunk = PathSize_DRBursts,
				RW_W_Chunk = PathSize_DRBursts,
				RO_R_Chunk = (ORAML+1) * BktHSize_DRBursts + BktSize_DRBursts,
				RO_W_Chunk = (ORAML+1) * BktHSize_DRBursts;
	
	wire		RW_R_Enable,
				RW_W_Enable,
				RO_R_Enable,
				RO_W_Enable;
				
	assign      RW_R_Enable = ToStashDataReady && ToStashDataValid;
	assign      RW_W_Enable = ToEncDataValid && ToEncDataReady;
	assign      RO_R_Enable = FromDecDataValid && FromDecDataReady;
	assign	    RO_W_Enable = ToEncDataValid && ToEncDataReady;
			
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
	
`ifdef SIMULATION
	always @(posedge Clock) begin
		if (ROStart && !(ROAccess && PathRead)) begin
			$display("Error: ROStart comes but not in the mood of RO_R");
			$finish;
		end		
		
		if (FromDecDataValid && !PathRead) begin
			$display("Error: AES giving data but not in PathRead stage");
			$finish;
		end
		//if (ToStashDataValid && !PathRead) begin
		//	$display("Error: Giving Stash data but not in PathRead stage");
		//	$finish;	This one does not hold
		//end			
		if (ToEncDataValid && !PathWriteback) begin
			$display("Error: Giving AES data but not in PathWriteback stage");
			$finish;
		end
		if (FromStashDataValid && !(DelayedWB ? RWAccessExtend && !RWAccess 
												: RWAccess && PathWriteback)) begin
			$display("Error: Stash giving data but not in PathWriteback stage");
			$finish;
		end
		
		if (RO_W_Enable && !BOIDone_IV) begin
			$display("Error: Header write back starts before Integrity is done");
			$finish;
		end
		
		if (ToEncDataValid) begin
			if (^ToEncData === 1'bx && RWAccess && PathWriteback)	begin
				$display("Error: xxx bits in ToEncData on RW_W");
				$finish;
			end
		end		
		if (FromStashDataValid) begin
			if (^FromStashData === 1'bx)	begin
				$display("Error: xxx bits in FromStashData");
				$finish;
			end
		end
		
	end
`endif	

	(* mark_debug = "TRUE" *)  wire	[0:8] error;
	(* mark_debug = "TRUE" *)  wire	ERROR;
	assign	error[0] = ROStart && !(ROAccess && PathRead);
	assign	error[1] = FromDecDataValid && !PathRead;
    assign	error[2] = ToEncDataValid && !PathWriteback;
	assign	error[3] = FromStashDataValid && !(DelayedWB ? RWAccessExtend && !RWAccess : RWAccess && PathWriteback);
	assign	error[4] = RO_W_Enable && !BOIDone_IV;	
	
	Register1b err (Clock, Reset, |error, ERROR);
	
	//--------------------------------------------------------------------------
	// CC handles header write back
	//-------------------------------------------------------------------------- 	
	(* mark_debug = "TRUE" *)  wire	HeaderCmpValid;
	(* mark_debug = "TRUE" *) wire 	HeaderInValid, HeaderInBkfOfI, BktOfIInValid;	
		
	assign 	HeaderInValid  = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr < RO_R_Chunk - BktSize_DRBursts;
	assign	HeaderInBkfOfI = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr == RO_R_Chunk - BktSize_DRBursts;	
	assign	BktOfIInValid  = ROAccess && PathRead && FromDecDataValid && RO_R_Ctr >= RO_R_Chunk - BktSize_DRBursts; 
		
	// invalidate the bit for the target block
	(* mark_debug = "TRUE" *) wire HdOfIDetect, HdOfIFound, HdOfIFound_Pre, HdOfIHasBeenFound;
	wire [DDRDWidth-1:0]	CoherentData, CoherentDataOfI, HeaderIn;

	BkfOfIDetector	#(		.DWidth(		DDRDWidth),
							.ValidBitStart(	AESEntropy),
							.ValidBitEnd(	AESEntropy+ORAMZ),
							.AddrStart(		BktHUStart),
							.AWidth(		ORAMU))
		vb_update_1	(		.Enable(		ROAccess && !RODummy),	// TODO: HeaderCmpValid && !RODummy
							.AddrOfI(		ROPAddr),
							.DataIn(		CoherentData),
							.DataOut(		HeaderIn),
							.DataOfI(		CoherentDataOfI),
							.Detect(		HdOfIDetect)
					);
		
	assign HdOfIFound_Pre = HeaderCmpValid && HdOfIDetect;
	Pipeline #(.Width(1), .Stages(1))	hoi_found	(Clock,	1'b0, HdOfIFound_Pre, HdOfIFound);
	Register1b bkt_ofi_found	(Clock,	ROStart, HdOfIFound_Pre, HdOfIHasBeenFound);
	
`ifdef SIMULATION
	always @(posedge Clock) begin
		if (HdOfIHasBeenFound && HdOfIFound_Pre) begin
			$display("Error: found another bucket of interest");
			$finish;
		end
	end
`endif	
	assign	error[5] = HdOfIHasBeenFound && HdOfIFound_Pre;
	
	//--------------------------------------------------------------------------
	// Integrity Verification needs a dual-port path buffer and requires delaying path and header write back
	//-------------------------------------------------------------------------- 
    generate if (EnableIV) begin: FULL_BUF
	
	`ifdef SIMULATION	
		initial begin
			if (!EnableREW) begin
				$display("Error: Integrity verification without REW ORAM NOT supported");
				$finish;
			end
		end
	
		always @(posedge Clock) begin
			if (ROAccess && PathWriteback && RO_W_Enable && !BOIDone_IV) begin
				$display("Error: Header write back starts before Integrity is done");
				$finish;
			end
			if (RWAccess && PathWriteback && RW_W_Enable && !PathDone_IV) begin
				$display("Error: RW_W write back starts before Integrity is done");
				$finish;
			end			
		end
	`endif	
		assign	error[6] = ROAccess && PathWriteback && RO_W_Enable && !BOIDone_IV;
		assign	error[7] = RWAccess && PathWriteback && RW_W_Enable && !PathDone_IV;

		`include "IVCCLocal.vh"
		
		//------------------------------------------------------------------------------------------------------
		// in and out path buffer. 
		// 		port1 written by Stash, read and written by AES
		//		port2 read and written by integrity verifier
		//------------------------------------------------------------------------------------------------------
		(* mark_debug = "TRUE" *)	wire 						BufP1_Enable, BufP1_Write;
		(* mark_debug = "TRUE" *)	wire [PathBufAWidth-1:0] 	BufP1_Address;
		(* mark_debug = "TRUE" *)	wire [DDRDWidth-1:0] 		BufP1_DIn;
		wire [DDRDWidth-1:0] 		BufP1_DOut_Pre, BufP1_DOut;

		(* mark_debug = "TRUE" *)	wire 						BufP2_Enable, BufP2_Write;
		(* mark_debug = "TRUE" *)	wire [PathBufAWidth-1:0] 	BufP2_Address;
		wire [DDRDWidth-1:0] 		BufP2_DIn, BufP2_DOut_Pre, BufP2_DOut;
		
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
		(* mark_debug = "TRUE" *) wire 	BktOfIOutValid;
		wire	[DDRDWidth-1:0]		FromDecData_dl;
		
		// delay these 3 signals by 1 cycle to match the case where CC resolves conflict
		Pipeline #(		.Width(		DDRDWidth + 2),
						.Stages(	BRAMLatency))
			from_dec_dl (	Clock, 1'b0,
							{HeaderInValid, 	BktOfIInValid,		FromDecData},
							{HeaderCmpValid, 	BktOfIOutValid,		FromDecData_dl}
						); 
		
		(* mark_debug = "TRUE" *) wire 	Intersect, Intersect_Pre; 
		(* mark_debug = "TRUE" *) wire	BktOfIUpdate_CC;
		(* mark_debug = "TRUE" *) wire	ConflictHeaderLookup, ConflictHeaderOutValid;
		(* mark_debug = "TRUE" *) wire	ConflictBktOfILookup, ConflictBktOfIOutValid;			
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

		Pipeline #(.Width(1), .Stages(1))	
			intersect_dl	(Clock,	1'b0, Intersect_Pre, Intersect);					
		Register1b 		boi_intersect 	(Clock, ROStart, HdOfIFound && Intersect, BOIFromCC);
		
		assign	ConflictHeaderLookup = Intersect && HeaderInValid;
		assign	ConflictBktOfILookup = BOIFromCC && BktOfIInValid;
		Pipeline #(	.Width(2), .Stages(BRAMLatency))	
			conf_out_pipe (	Clock,	1'b0,
						{ConflictHeaderLookup, ConflictBktOfILookup}, 			  
						{ConflictHeaderOutValid, ConflictBktOfIOutValid}
					);
		
		(* mark_debug = "TRUE" *) wire	HdOfIWriteBack, HdOfIWriteBack_Pre;
		Pipeline #(.Width(DDRDWidth), .Stages(BRAMLatency-1))
			bufP1_out_pipe	(	Clock, 1'b0, BufP1_DOut_Pre, BufP1_DOut);
		Pipeline #(.Width(1), .Stages(BRAMLatency-1))
			hd_wb_pipe		(	Clock, 1'b0, HdOfIWriteBack_Pre,	HdOfIWriteBack);	
									
		assign 	CoherentData = (ConflictHeaderOutValid || ConflictBktOfIOutValid)? BufP1_DOut : FromDecData_dl;
						
		localparam	BktCtrAWidth = `log2(BktSize_DRBursts);
		wire	[BktCtrAWidth-1:0]		BktOfIOffset;
		CountAlarm #(		.Threshold(				BktSize_DRBursts))
			boi_ctr (		.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				BktOfIInValid),
							.Count(					BktOfIOffset)
					);
		
		Pipeline #(.Width(1), .Stages(BRAMLatency))
			boi_update_pipe	(	Clock, 1'b0, BOIFromCC && HeaderInBkfOfI, BktOfIUpdate_CC);
						
	`ifdef SIMULATION		
		always @(posedge Clock) begin
			if (BktOfIUpdate_CC && HeaderInBkfOfI) begin
				$display("Error: CC needs one idle cycle after header of bucket of interest!");
				$finish;
			end
		end
	`endif
		assign	error[8] = BktOfIUpdate_CC && HeaderInBkfOfI;		
	
		// update BktOfI header in CC rather late than early.
		// too early --> Stash receives no valid block
		// too late --> IV takes the old header data
		
		//--------------------------------------------------------------------------
		// Port1 : written by Stash, read and written by AES, read and written by CC to resolve conflict
		//-------------------------------------------------------------------------- 	
	
		// Port control signals
		(* mark_debug = "TRUE" *) wire  					PthRW, HdRW;
		(* mark_debug = "TRUE" *) wire [ORAMLogL-1:0]		HdOnPthCtr, LastHdOnPthCtr;
		wire [PBSTWidth-1:0]	BlkOnPthCtr;
		wire 					PthCtrEnable, HdCtrEnable;
		wire 					HdRW_Transition, PthRW_Transition;			
					
		Register1b stash_wb (Clock, RWStashWB && PthRW_Transition, RW_R_DoneAlarm, RWStashWB);			
		assign RWAccessExtend = RWAccess || RWStashWB;	// a hack to accept stash RW_W data
		
		assign PthCtrEnable = RWAccessExtend && BufP1_Enable;
		CountAlarm #(		.Threshold(				PathSize_DRBursts))
			blk_ctr (		.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				PthCtrEnable),
							.Count(					BlkOnPthCtr),
							.Done(					PthRW_Transition)
					);
		
		assign HdCtrEnable = ROAccess && !RWAccessExtend && (HeaderCmpValid || (BufP1_Enable && PathWriteback));// BufP1_Enable && !BktOfIUpdate_CC && !BktOfIInValid && !ConflictHeaderLookup;
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
		Register #(.Width(1), .Initial(1'b1)) 
			pth_rw (Clock, 1'b0, Reset, RWAccessExtend && !RW_PathRead && PthRW_Transition, !PthRW, PthRW);
		Register #(.Width(1), .Initial(1'b1)) 
			hd_rw  (Clock, 1'b0, Reset, ROAccess && HdRW_Transition, !HdRW, HdRW);
		
		Register #(.Width(ORAMLogL))
			boi_id_reg (Clock, 1'b0, 1'b0, HdOfIFound, 		LastHdOnPthCtr,		BktOfIIdx);
			
		assign	HdOfIWriteBack_Pre = ROAccess && PathWriteback && HdOfIHasBeenFound && LastHdOnPthCtr == BktOfIIdx;
		
		// output buffer to tolerate random delay and ensure full bandwidth
		wire	[DDRDWidth-1:0]		HdOfI;
		wire 	[DDRDWidth-1:0] 	BufP1Reg_DIn, BufP1Reg_DOut;
		wire 						BufP1Reg_DInReady, BufP1Reg_DOutValid, BufP1Reg_DOutReady;
		
		localparam				EmptyCWidth = `log2(2 + BRAMLatency + 1);
		wire [EmptyCWidth-1:0]				BufP1Reg_EmptyCount;		
		
		assign 	BufP1Reg_DIn =  HdOfIWriteBack ? {HdOfI[DDRDWidth-1:BktHSize_RawBits], BufP1_DOut[BktHSize_RawBits-1:0]} 
								: BufP1_DOut;
		
		(* mark_debug = "TRUE" *) wire	BufP1Reg_DInValid;		
		Pipeline #(	.Width(1), .Stages(BRAMLatency))	
			to_enc_valid (Clock, 1'b0, PathWriteback && BufP1_Enable,	BufP1Reg_DInValid);
		
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
									(	PathRead ? (	ConflictHeaderLookup || HeaderCmpValid		// header lookup or save
											||  BktOfIInValid || BktOfIUpdate_CC )						// BktOfI update or save
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
											: (HeaderCmpValid && Intersect) ? FromDecData_dl 	// save stale header from AES
											: HeaderIn) 										// save fresh header (vb_updated) from AES
							: 0;	
		
		//	AES --> Stash
		(* mark_debug = "TRUE" *) wire	BktOfIHdOutValid;		
		assign	BktOfIHdOutValid = 	BktOfIOutValid && BktOfIOffset == 1;

		assign	ToStashData =			RW_PathRead ? FromDecData
											:	!HdOfIHasBeenFound ? {DDRDWidth{1'b0}}	
											:	BktOfIHdOutValid ? CoherentDataOfI : CoherentData;
											
		assign	ToStashDataValid = 		RW_PathRead ? FromDecDataValid : BktOfIOutValid; 
											
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
		
		(* mark_debug = "TRUE" *) wire 	BktOfIAccessedByIV, BktOfIAccessedByIV_1st_hold, BktOfIAccessedByIV_1st;
		assign	BktOfIAccessedByIV = HdOfIHasBeenFound && BucketOfITurn && IVRequest;
		
		Register1b boi_by_iv_1st_pre (Clock, ROStart, BktOfIAccessedByIV, BktOfIAccessedByIV_1st_hold);
		Pipeline #(.Width(1), .Stages(BRAMLatency))
			boi_by_iv_1st 	(Clock, ROStart, BktOfIAccessedByIV && !BktOfIAccessedByIV_1st_hold, BktOfIAccessedByIV_1st);			
		Pipeline #(.Width(DDRDWidth), .Stages(BRAMLatency-1))
			bufP2_out_pipe	(	Clock, 1'b0, BufP2_DOut_Pre, BufP2_DOut);
		
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
						
		Register #(.Width(DDRDWidth))
			hash_out_reg (Clock, 1'b0, 1'b0, BktOfIAccessedByIV && IVWrite, 		DataFromIV,		HdOfI);	
		
		
		(* mark_debug = "TRUE" *) wire	HeaderCmpValid_dl, ROIVID_Enable;
		wire	[AESEntropy-1:0]	ROIBV_Pre;	
		Pipeline #(.Width(1), .Stages(1))	hd_cmp_dl	(Clock,	1'b0, HeaderCmpValid, HeaderCmpValid_dl);
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
		assign	ToEncDataValid =		ROAccess ? (HeaderOutValid  && PathWriteback):	FromStashDataValid;
		assign  HeaderOutReady = 		ROAccess && PathWriteback && ToEncDataReady;
		
		assign	FromStashDataReady = 	!ROAccess && ToEncDataReady;
		assign	FromStashDataDone = 	RW_W_DoneAlarm;
		
		assign	RWAccessExtend = RWAccess;
		
		// No IV
		assign	PathReady_IV = 1'bx;
		assign	BOIReady_IV = 1'bx;
		assign	BOIFromCC = 1'bx;
		assign	DataToIV = {DDRDWidth{1'bx}};
		assign	ROIBV = {AESEntropy{1'bx}}; 
		assign	ROIBID = {(ORAML+1){1'bx}}; 
		
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
