
//==============================================================================
//	Module:		Integrity Verifier
//	Desc:		Use several SHA-3 units to verify buckets in Path ORAM
//				A RAM interface with Coherence Controller
//              h = Hash (v, u, l, block[0], block[1], ..., block[Z-1], BucketID, BucketCtr)
//==============================================================================

`include "Const.vh"

module IntegrityVerifier (
	Clock, Reset,
	Request, Write, Address, DataIn, DataOut,	// RAM interface
	PathReady, BOIReady, ROILevel, BOIFromCC, 
	PathDone, BOIDone, BucketOfITurn,
	ROIBV, ROIBID
);

	parameter	NUMSHA3 = 2;

	localparam	StallOnError = 0;
	localparam  LogNUMSHA3 = `max(1, `log2(NUMSHA3));
	
    `include "PathORAM.vh"
	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "SHA3Local.vh"
	`include "IVCCLocal.vh"
	
	parameter	BRAMLatency = 2;
	
	localparam	ORAMLogL = `log2(ORAML+1);
		
    localparam  AWidth = PathBufAWidth;
	localparam  BktAWidth = `log2(ORAML+2) + 1;
	localparam	BlkAWidth = `log2(BktSize_DRBursts + 1);
	localparam	BIDWidth = ORAML + 1;
	
	//------------------------------------------------------------------------------------
	// variables
	//------------------------------------------------------------------------------------ 	
	input  	Clock, Reset;

	output 	Request, Write;
	output 	[AWidth-1:0] Address;
	input  	[DDRDWidth-1:0]  DataIn;
	output 	[DDRDWidth-1:0]  DataOut;
	
	input  	PathReady, BOIReady, BOIFromCC;
	output 	PathDone, BOIDone, BucketOfITurn;
	
	input	[ORAMLogL-1:0]	 ROILevel;
	input	[AESEntropy-1:0] ROIBV;
	input	[BIDWidth-1:0]	 ROIBID;
	
	wire			ERROR_IVVIOLATION, ERROR_ISC1, ERROR_ISC2, ERROR_RWWVersion, ERROR_IV;	
	
	// status and meta data for hash engines	
	(* mark_debug = "TRUE" *)	wire [BktAWidth-1:0] 	BucketIDTurn;
	(* mark_debug = "TRUE" *) wire [BlkAWidth-1:0]	BucketOffsetTurn; 
	wire [DDRDWidth-1:0]	BucketHeaderOut;
	(* mark_debug = "TRUE" *) wire					BucketOfISIn;
	
	// hash IO internal variables
	localparam HashByteCount = (BktSize_RndBits + 0) / 8;    	
	wire HashDataReady [0:NUMSHA3-1];
			
	// Round robin scheduling for hash engines
	wire [LogNUMSHA3-1:0] Turn, LastTurn, NextTurn;
	CountAlarm #(		.Threshold(		NUMSHA3))
		turn_cnt (		.Clock(			Clock), 
						.Reset(			Reset), 
						.Enable(		1'b1),
						.Count(			Turn)
					);	
	assign	NextTurn = (Turn + 1) % NUMSHA3;
	assign	LastTurn = (Turn + NUMSHA3 - BRAMLatency) % NUMSHA3;
	
	(* mark_debug = "TRUE" *) wire DataInValid,	DataInValid_Pre;
	(* mark_debug = "TRUE" *) wire HeaderInValid, HeaderInValid_Pre;
	(* mark_debug = "TRUE" *) wire ROIHeader;
	wire [DDRDWidth-1:0] HashData;	
	
	//------------------------------------------------------------------------------------
	// Request and address generation
	//------------------------------------------------------------------------------------ 
	assign Address = BucketIDTurn * BktSize_DRBursts + (BucketOffsetTurn % BktSize_DRBursts);
		// address pattern, chunk 0, 1, 2, ... BktSize_DRBursts - 1, 0
	
	// when BRAMLatency >= NUMSHA3, it may break
	generate if (NUMSHA3 == 2)	
		assign Request = Write || (HashDataReady[Turn] && BucketOffsetTurn < BktSize_DRBursts && !DataInValid); 
	else
		assign Request = Write || (HashDataReady[Turn] && BucketOffsetTurn < BktSize_DRBursts); 
	endgenerate
	
	//------------------------------------------------------------------------------------
	// Process and save headers
	//------------------------------------------------------------------------------------ 	
	
	assign	DataInValid_Pre = !Reset &&  Request && !Write;
	assign	HeaderInValid_Pre = DataInValid_Pre && BucketOffsetTurn == 0;
	Pipeline #(.Width(3), .Stages(BRAMLatency))
		rd_valid_pipe	(	Clock, 1'b0, 
							{DataInValid_Pre, HeaderInValid_Pre, BucketOfITurn},
							{DataInValid, HeaderInValid, ROIHeader}
						);

	// Bucket ID and bucket version
	wire [AESEntropy-1:0] 	RWBV;
	wire [BIDWidth-1:0]   	RWBID;
	wire RWVIDValid, RWVIDReady; 
		
	GentrySeedGenerator	#(	.ORAML(					ORAML))				
			gentry_rw	(	.Clock(					Clock),
							.Reset(					Reset),
							.OutIV(					RWBV), 
							.OutBID(				RWBID), 
							.OutValid(				RWVIDValid), 
							.OutReady(				RWVIDReady)
						);
	assign RWVIDReady = HeaderInValid && !ROIHeader;
	always @(posedge Clock) begin
		if (HeaderInValid && !ROIHeader && !RWVIDValid) begin
			$display("GentrySeedGenerator not valid. Really unlucky ... ");
			$finish;
		end
	end
	
	(* mark_debug = "TRUE" *)	wire [AESEntropy-1:0] BktV;
	(* mark_debug = "TRUE" *)	wire [BIDWidth-1:0]   BktID;
	
	assign BktV = ROIHeader ? ROIBV : RWBV;
	assign BktID = ROIHeader ? ROIBID : RWBID;
	
//	assign HashData = HeaderInValid ? {  {TrancateDigestWidth{1'b0}}, DataIn[BktHSize_RawBits-1:AESEntropy], {AESEntropy{1'b0}}  }
	assign HashData = HeaderInValid ? {  {(TrancateDigestWidth-BIDWidth){1'b0}}, BktID, DataIn[BktHSize_RawBits-1:AESEntropy], BktV} 
						: DataIn;
		// cannot include digest itself, nor header IV (since they change for every bucket on RO access).
		
	//------------------------------------------------------------------------------------
	// Remaining work status
	//------------------------------------------------------------------------------------ 	
	(* mark_debug = "TRUE" *) wire 	[BktAWidth-1:0] 	BktOnPathStarted, BktOnPathDone;
	(* mark_debug = "TRUE" *) wire 	[1:0]				BktOfIStarted, BktOfIDone;
	(* mark_debug = "TRUE" *) wire						PendingWork, Idle, ConsumeHash;
	
	Counter	#(				.Width(					BktAWidth),
							.Initial(				TotalBucketD))
		path_started	(	.Clock(					Clock),
							.Reset(					PathReady),
							.Set(					Reset),
							.Load(					1'b0),
							.Enable(				PendingWork && Idle && !BucketOfISIn),
							.In(					{BktAWidth{1'bx}}),
							.Count(					BktOnPathStarted)
						);
	Counter	#(				.Width(					BktAWidth),
							.Initial(				TotalBucketD))
		path_done	(		.Clock(					Clock),
							.Reset(					PathReady),
							.Set(					Reset),
							.Load(					1'b0),
							.Enable(				ConsumeHash && !BucketOfITurn),
							.In(					{BktAWidth{1'bx}}),
							.Count(					BktOnPathDone)
						);	

	Counter	#(				.Width(					2),
							.Initial(				2))
		boi_started		(	.Clock(					Clock),
							.Reset(					BOIReady),
							.Set(					Reset),
							.Load(					1'b0),
							.Enable(				PendingWork && Idle && BucketOfISIn),
							.In(					{2{1'bx}}),
							.Count(					BktOfIStarted)
						);
	Counter	#(				.Width(					2),
							.Initial(				2))
		boi_done	(		.Clock(					Clock),
							.Reset(					BOIReady),
							.Set(					Reset),
							.Load(					1'b0),
							.Enable(				ConsumeHash && BucketOfITurn),
							.In(					{2{1'bx}}),
							.Count(					BktOfIDone)
						);							
	
	assign PendingWork = BktOnPathStarted < TotalBucketD || BktOfIStarted < 2;	
	
	assign PathDone = BktOnPathDone >= TotalBucketD && ((StallOnError) ? ~ERROR_IV : 1'b1);
	assign BOIDone = BktOfIDone >= 2 && ((StallOnError) ? ~ERROR_IV : 1'b1);
	
	//------------------------------------------------------------------------------------
	// Checking or updating hash
	//------------------------------------------------------------------------------------ 	
	wire HashOutValid 	[0:NUMSHA3-1];
	wire [FullDigestWidth-1:0] HashOut [0:NUMSHA3-1]; 	
	(* mark_debug = "TRUE" *) wire VersionNon0, Violation, CheckHash, UpdateHash; 	
	Pipeline #(.Width(1), .Stages(1))	consume_hash (Clock, 1'b0, HashOutValid[NextTurn], ConsumeHash);

	assign CheckHash = ConsumeHash && 
						(BucketIDTurn < TotalBucketD / 2 
						|| BktOfIDone == 1);		// first task is to update the hash, second is to check against the old hash
	
	assign UpdateHash = ConsumeHash && !CheckHash;	
	
	// checking hash for the input path
	assign Violation = ConsumeHash && CheckHash && !BOIFromCC && VersionNon0 &&
		BucketHeaderOut[TrancateDigestWidth+BktHSize_RawBits-1:BktHSize_RawBits] != HashOut[Turn][DigestStart-1:DigestEnd];
	
	assign Idle = BucketOffsetTurn == BktSize_DRBursts + 1;
		
	// updating hash for the output path
	assign Write = UpdateHash && VersionNon0;		
	assign DataOut = {HashOut[Turn][DigestStart-1:DigestEnd], BucketHeaderOut[BktHSize_RawBits-1:0]};
	
	//------------------------------------------------------------------------------------
	// maintain bucket information
	//------------------------------------------------------------------------------------ 	
	// BucketOffset shifts every cycle
	wire	[BlkAWidth-1:0]		BucketOffsetSIn;
	localparam [BlkAWidth-1:0]	BucketOffsetResetValue = BktSize_DRBursts + 1;							
	ShiftRegister #(		.PWidth(				NUMSHA3 * BlkAWidth),
							.SWidth(				BlkAWidth),
							.ResetValue(			{NUMSHA3{BucketOffsetResetValue}}))
		bkt_offset_turn	(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0),
							.Enable(				1'b1), 
							.SIn(					BucketOffsetSIn),
							.SOut(					BucketOffsetTurn)
					);
	assign	BucketOffsetSIn = (PendingWork && Idle) ? 0
								: (Request || ConsumeHash) ? BucketOffsetTurn + 1
								: BucketOffsetTurn;
					
	// BucketID shifts every cycle			
	wire	[BktAWidth-1:0]		BucketIDSIn;
	ShiftRegister #(		.PWidth(				NUMSHA3 * (BktAWidth+1)),
							.SWidth(				BktAWidth + 1))
		bkt_id_turn	(		.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0),
							.Enable(				1'b1), 
							.SIn(					{BucketOfISIn, BucketIDSIn}),
							.SOut(					{BucketOfITurn, BucketIDTurn})
					);	
	assign	BucketOfISIn = (PendingWork && Idle) ? BktOfIStarted < 2 : BucketOfITurn;
	assign	BucketIDSIn = (PendingWork && Idle) ? 
								(BucketOfISIn ? 
									(BOIFromCC ? TotalBucketD / 2 + ROILevel 
									: TotalBucketD)			 
								: BktOnPathStarted)
							: BucketIDTurn;
	
	// BucketHeader has to be a FIFO; it cannot be implemented with ShiftRegister
	wire	[DDRDWidth-1:0]		BucketHeaderIn;
	wire						VersionNon0In;
	FIFORAM	#(      	.Width(					DDRDWidth+1),     
						.Buffering(				NUMSHA3))
		bkt_hd_fifo  (	.Clock(					Clock),
						.Reset(					Reset),
						.InData(				{VersionNon0In, BucketHeaderIn}),
						.InValid(				HeaderInValid),
						.InAccept(				),
						.OutData(				{VersionNon0, BucketHeaderOut}),
						.OutSend(				),
						.OutReady(				ConsumeHash)
					); 
	assign	BucketHeaderIn = {DataIn[DDRDWidth-1:AESEntropy], BktV};
	assign	VersionNon0In = BktV > 0;
	
	Register1b 	errno1(Clock, Reset, ConsumeHash && CheckHash && Violation, 							ERROR_IVVIOLATION);
	Register1b 	errno2(Clock, Reset, BOIReady && !BOIDone, 												ERROR_ISC1);
	Register1b 	errno3(Clock, Reset, PathReady && !PathDone, 											ERROR_ISC2);
	Register1b 	errno4(Clock, Reset, ConsumeHash && UpdateHash && !VersionNon0 && !BucketOfITurn, 	ERROR_RWWVersion);
	
	Register1b 	errANY(Clock, Reset, ERROR_IVVIOLATION | ERROR_ISC1 | ERROR_ISC2 | ERROR_RWWVersion, 	ERROR_IV);
	
`ifdef SIMULATION		
	always @(posedge Clock) begin
		if (ConsumeHash && CheckHash) begin
			$display("Integrity verification results on Bucket %d, version %d", BucketIDTurn, BucketHeaderOut[AESEntropy-1:0]);
			if (Violation === 0) begin
				if (!VersionNon0)
					$display("\tVersion is 0, no need to check hash for Bucket %d", BucketIDTurn);
				else
					$display("\tPassed: %x", HashOut[Turn][DigestStart-1:DigestEnd]);
			end
		
			else if (Violation === 1) begin
				$display("\tViolation : %x != %x", BucketHeaderOut[TrancateDigestWidth+BktHSize_RawBits-1:BktHSize_RawBits], HashOut[Turn][DigestStart-1:DigestEnd]);
				$display("\t\t header = %x", BucketHeaderOut);
				$finish;
			end
			
			else if (Violation === 1'bx) begin
				$display("\tX bits in hash");
				$finish;
			end	
		end
		
		if (ConsumeHash && UpdateHash) begin
			if (!VersionNon0) begin
				$display("\tVersion is 0, no need to update hash for Bucket %d", BucketIDTurn);
				if (!BucketOfITurn) begin
					$display("\t Error: RW_W version 0 for Bucket %d", BucketIDTurn);
					$finish;
				end
			end
			else
				$display("Updating Bucket %d (with header %x) hash to \n\t\t %x", BucketIDTurn, BucketHeaderOut, HashOut[Turn][DigestStart-1:DigestEnd]);
		end
		
		if (ERROR_ISC1)
			$display("Error: RO bucket arrives so soon? Have not finished the last one");	
		if (ERROR_ISC2)
			$display("Error: Have not finished the last path");			
	end
`endif
	
	//------------------------------------------------------------------------------------
	// NUMSHA3 hash engines
	//------------------------------------------------------------------------------------ 	
	genvar k;
	generate for (k = 0; k < NUMSHA3; k = k + 1) begin: HashEngines
		
        Keccak_WF #(        .IWidth(            DDRDWidth),
                            .HashByteCount(     HashByteCount),
							.HashOutWidth(		FullDigestWidth),
							.KeyLength(			HashKeyLength),
							.Key(				128'h 5e_7a_2a_9d_43_35_74_5b_85_ce_e5_b3_c0_c1_23_a6))							
            HashEngine (    .Clock(             Clock),         
                            .Reset(             Reset),
                            .DataInReady(       HashDataReady[k]),
                            .DataInValid(       DataInValid && LastTurn == k),
                            .DataIn(            HashData),
                            .HashOutReady(      ConsumeHash && Turn == k),
                            .HashOutValid(      HashOutValid[k]),
                            .HashOut(           HashOut[k])
                    );
                    
	end endgenerate

endmodule
	
