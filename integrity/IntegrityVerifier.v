
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
	PathReady, PathDone, BOIReady, BOIDone,
	ROIBV, ROIBID
);

	parameter NUMSHA3 = 3;
	localparam  LogNUMSHA3 = `max(1, `log2(NUMSHA3));	
	
    `include "PathORAM.vh"
	
	`include "SecurityLocal.vh"	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "SHA3Local.vh"
	`include "IVCCLocal.vh"

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
	
	input  	PathReady, BOIReady;
	output 	PathDone, BOIDone;
	
	input	[AESEntropy-1:0] ROIBV;
	input	[BIDWidth-1:0]	 ROIBID;
	
	// status and meta dat for hash engines
	reg [BktAWidth-1:0] 	BucketID		[0:NUMSHA3-1];	
	reg [BlkAWidth-1:0] 	BucketOffset	[0:NUMSHA3-1];
	reg [DDRDWidth-1:0] 	BucketHeader 	[0:NUMSHA3-1];
	
	// hash IO internal variables
	localparam HashByteCount = (BktSize_RawBits + 0) / 8;    	
	
	wire HashDataReady [0:NUMSHA3-1];
		
	// select one hash engine
	reg  [LogNUMSHA3-1:0] Turn;
	wire [LogNUMSHA3-1:0] LastTurn;
	
	//------------------------------------------------------------------------------------
	// Request and address generation
	//------------------------------------------------------------------------------------ 
	assign Address = Write ? 
		BucketID[Turn] * BktSize_DRBursts : 						//	updating hash for the previous set of buckets
		BucketID[Turn] * BktSize_DRBursts + BucketOffset[Turn];		//  reading data from the current set of buckets
		
	assign Request = !Reset && (Write || (HashDataReady[Turn] && BucketOffset[Turn] < BktSize_DRBursts )); 
																											// can remove !DataInValid if we make Gentry always valid
	//------------------------------------------------------------------------------------
	// Process and save headers
	//------------------------------------------------------------------------------------ 	
	wire DataInValid, HeaderInValid;
	wire [DDRDWidth-1:0] HashData;
	
	Register #(.Width(1)) 	RdData (Clock, Reset, 1'b0, 1'b1, 	Request && !Write, 	DataInValid);
	assign  HeaderInValid = DataInValid && BucketOffset[LastTurn] == 1;		// TODO: do not work for  header > 1

	// Bucket ID and bucket version
	wire [AESEntropy-1:0] 	RWBV;
	wire [BIDWidth-1:0]   	RWBID;
	wire RWVIDValid, RWVIDReady, ROIHeaderInValid; 
	
	wire [AESEntropy-1:0] BktV;
	wire [BIDWidth-1:0]   BktID;
	
	GentrySeedGenerator	#(	.ORAML(					ORAML))				
			gentry_rw	(	.Clock(					Clock),
							.Reset(					Reset),
							.OutIV(					RWBV), 
							.OutBID(				RWBID), 
							.OutValid(				RWVIDValid), 
							.OutReady(				RWVIDReady)
						);
	
	always @(posedge Clock) begin
		if (HeaderInValid && !ROIHeaderInValid && !RWVIDValid) begin
			$display("GentrySeedGenerator not valid. Really unlucky ... ");
			$stop;
		end
	end
	
	assign RWVIDReady = HeaderInValid && !ROIHeaderInValid;
	
	assign ROIHeaderInValid = HeaderInValid && BucketID[LastTurn] == TotalBucketD;	
	assign BktV = ROIHeaderInValid ? ROIBV : RWBV;
	assign BktID = 0;//ROIHeaderInValid ? ROIBID : RWBID;
	
//	assign HashData = HeaderInValid ? {  {TrancateDigestWidth{1'b0}}, DataIn[BktHSize_RawBits-1:AESEntropy], {AESEntropy{1'b0}}  }
	assign HashData = HeaderInValid ? {  {(TrancateDigestWidth-BIDWidth){1'b0}}, BktID, DataIn[BktHSize_RawBits-1:AESEntropy], BktV} 
						: DataIn;
		// cannot include digest itself, nor header IV (since they change for every bucket on RO access).
		
	always @(posedge Clock) begin
		if (!Reset && HeaderInValid)
			BucketHeader[LastTurn] <= {DataIn[DDRDWidth-1:AESEntropy], BktV};					
	end
	
	//------------------------------------------------------------------------------------
	// Checking or updating hash
	//------------------------------------------------------------------------------------ 	
	wire HashOutValid 	[0:NUMSHA3-1];
	wire [FullDigestWidth-1:0] HashOut [0:NUMSHA3-1]; 	
	wire ConsumeHash, VersionNonzero, Violation, CheckHash, UpdateHash; 
	wire Idle;
	
	assign ConsumeHash = HashOutValid[Turn];
	assign CheckHash = ConsumeHash && 
						(BktOnPathDone < TotalBucketD / 2 
						|| BktOfIDone == 1);		// first task is to update the hash, second is to check against the old hash
	
	assign UpdateHash = ConsumeHash && !CheckHash;
	
	assign VersionNonzero = (BucketHeader[Turn][AESEntropy-1:0] > 64'b0);
	
	// checking hash for the input path
	assign Violation = ConsumeHash && CheckHash && VersionNonzero &&
		BucketHeader[Turn][TrancateDigestWidth+BktHSize_RawBits-1:BktHSize_RawBits] != HashOut[Turn][DigestStart-1:DigestEnd];
	
	assign Idle = BucketOffset[Turn] == BktSize_DRBursts + 1;
	
`ifdef SIMULATION		
	always @(posedge Clock) begin
		if (ConsumeHash && CheckHash) begin
			$display("Integrity verification results on Bucket %d, version %d", BucketID[Turn], BucketHeader[Turn][AESEntropy-1:0]);
			if (Violation === 0) begin
				if (!VersionNonzero)
					$display("\tVersion is 0, no need to check hash for Bucket %d", BucketID[Turn]);
				else
					$display("\tPassed: %x", HashOut[Turn][DigestStart-1:DigestEnd]);
			end
		
			else if (Violation === 1) begin
				$display("\tViolation : %x != %x", BucketHeader[Turn][TrancateDigestWidth+BktHSize_RawBits-1:BktHSize_RawBits], HashOut[Turn][DigestStart-1:DigestEnd]);
				$display("\t\t header = %x", BucketHeader[Turn]);
				$stop;
			end
			
			else if (Violation === 1'bx) begin
				$display("\tX bits in hash");
				$stop;
			end	
		end
		
		if (ConsumeHash && UpdateHash) begin
			if (!VersionNonzero) begin
				$display("\tVersion is 0, no need to update hash for Bucket %d", BucketID[Turn]);
				if (BucketID[Turn] != TotalBucketD) begin
					$display("\t Error: RW_W version 0 for Bucket %d", BucketID[Turn]);
					$stop;
				end
			end
			else
				$display("Updating Bucket %d (with header %x) hash to \n\t\t %x", BucketID[Turn], BucketHeader[Turn], HashOut[Turn][DigestStart-1:DigestEnd]);
		end
				
	end
`endif
	
	// updating hash for the output path
	assign Write = ConsumeHash && UpdateHash && VersionNonzero;		
	assign DataOut = {HashOut[Turn][DigestStart-1:DigestEnd], BucketHeader[Turn][BktHSize_RawBits-1:0]};
		
	//------------------------------------------------------------------------------------
	// Remaining work status
	//------------------------------------------------------------------------------------ 	
	reg [BktAWidth-1:0] BktOnPathStarted, BktOnPathDone;
	reg [1:0]			BktOfIStarted, BktOfIDone;
	
	wire				PendingWork;
	
	assign PendingWork = BktOnPathStarted < TotalBucketD || BktOfIStarted < 2;	
	
	assign PathDone = BktOnPathDone == TotalBucketD;
	assign BOIDone = BktOfIDone == 2;
		
	//------------------------------------------------------------------------------------
	// Round robin scheduling for hash engines
	//------------------------------------------------------------------------------------ 	
	integer hashid = 0;
	always @(posedge Clock) begin
        if (Reset) begin
            Turn <= 0;
			BktOnPathStarted <= TotalBucketD;
			BktOnPathDone <= TotalBucketD;
			BktOfIStarted <= 2;
			BktOfIDone <= 2;
			
            for (hashid = 0; hashid < NUMSHA3; hashid = hashid + 1)
                BucketOffset[hashid] <= BktSize_DRBursts + 1;			
        end
		else begin
			Turn <= (Turn + 1) % NUMSHA3;
			
			// asking for more input				
			if (Request && !Write) begin							
				BucketOffset[Turn] <= BucketOffset[Turn] + 1;			
			end
			
			// dispatch work if there's any
			if (PendingWork && Idle) begin	
				BucketOffset[Turn] <= 0;
				
				if (BktOfIStarted < 2) begin			// prioritize RO bucket of interest
					BucketID[Turn] <= TotalBucketD;
					BktOfIStarted <= BktOfIStarted + 1;
				end
				else begin	
					BucketID[Turn] <= BktOnPathStarted;
					BktOnPathStarted <= BktOnPathStarted + 1;
				end
			end
			
			// mark idle and tick *Done
			if (ConsumeHash) begin								
				BucketOffset[Turn] <= BucketOffset[Turn] + 1;	// mark idle
				
				if (BucketID[Turn] == TotalBucketD)
					BktOfIDone <= BktOfIDone + 1;
				else
					BktOnPathDone <= BktOnPathDone + 1;
			end
			
			// bucket of ready done
			if (BOIReady) begin
				BktOfIStarted <= 0;
				BktOfIDone <= 0;
			end
			
			if (PathReady) begin
				BktOnPathStarted <= 0;
				BktOnPathDone <= 0;			
			end
			
			`ifdef SIMULATION
			if (BOIReady && !BOIDone)
				$display("Error: RO bucket arrives so soon? Have not finished the last one");	
			if (PathReady && !PathDone)
				$display("Error: Have not finished the last path");	
			`endif	
			
		end
    end
	
	assign LastTurn = (Turn + NUMSHA3 - 1) % NUMSHA3;
	
	//------------------------------------------------------------------------------------
	// NUMSHA3 hash engines
	//------------------------------------------------------------------------------------ 	
	genvar k;
	generate for (k = 0; k < NUMSHA3; k = k + 1) begin: HashEngines
		
        Keccak_WF #(        .IWidth(            DDRDWidth),
                            .HashByteCount(     HashByteCount),
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
	