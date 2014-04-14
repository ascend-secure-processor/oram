
//==============================================================================
//	Module:		Integrity Verifier
//	Desc:		Use several SHA-3 units to verify buckets in Path ORAM
//				A RAM interface with Coherence Controller
//              h = Hash (v, u, l, block[0], block[1], ..., block[Z-1], BucketID, BucketCtr)
//==============================================================================

`include "Const.vh"

module IntegrityVerifier (
	Clock, Reset,
	Done,
	Request, Write, Address, DataIn, DataOut,	// RAM interface
	IVReady_BktOfI, IVDone_BktOfI
);

	parameter NUMSHA3 = 3;
	localparam  LogNUMSHA3 = `max(1, `log2(NUMSHA3));	
	
    `include "PathORAM.vh";
	`include "DDR3SDRAM.vh";
	`include "AES.vh";
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "SHA3Local.vh"
	`include "IVCCLocal.vh"

    localparam  AWidth = PathBufAWidth;
	localparam  BktAWidth = `log2(ORAML) + 1;
	localparam	BlkAWidth = `log2(BktSize_DRBursts + 1);
	
	//------------------------------------------------------------------------------------
	// variables
	//------------------------------------------------------------------------------------ 	
	input  	Clock, Reset;
	output 	Done;
	output 	Request, Write;
	output 	[AWidth-1:0] Address;
	input  	[DDRDWidth-1:0]  DataIn;
	output 	[DDRDWidth-1:0]  DataOut;
	
	input  	IVReady_BktOfI;
	output 	IVDone_BktOfI;

	// status and meta dat for hash engines
	reg [BktAWidth-1:0] 	BucketID		[0:NUMSHA3-1];	
	reg [BlkAWidth-1:0] 	BucketOffset	[0:NUMSHA3-1];
	reg [DDRDWidth-1:0] 	BucketHeader 	[0:NUMSHA3-1];
	
	// hash IO internal variables
	localparam HashByteCount = (BktSize_RawBits + 0) / 8;    	
	
	wire [DDRDWidth-1:0] HashData;
	wire HashDataReady [0:NUMSHA3-1];
	wire DataInValid, HeaderInValid;
	
	wire HashOutValid 	[0:NUMSHA3-1];
	wire [FullDigestWidth-1:0] HashOut [0:NUMSHA3-1]; 	
	wire ConsumeHash, Violation, CheckHash; 
	wire [0:NUMSHA3-1]   Idle;
	
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
	
	Register #(.Width(1)) 	RdData (Clock, Reset, 1'b0, 1'b1, 	Request && !Write, 	DataInValid);
	assign  HeaderInValid = DataInValid && BucketOffset[LastTurn] == 1;		// TODO: do not work for  header > 1
	
	// saving header
	always @(posedge Clock) begin
		if (!Reset && HeaderInValid)
			BucketHeader[LastTurn] <= DataIn;					
	end
	
	// data passed to SHA engines
	assign HashData = HeaderInValid ? {{TrancateDigestWidth{1'b0}}, DataIn[BktHSize_RawBits-1:0]} : DataIn;
	
	//------------------------------------------------------------------------------------
	// Checking or updating hash
	//------------------------------------------------------------------------------------ 	
	assign ConsumeHash = HashOutValid[Turn];
	assign CheckHash = (BucketID[Turn] < TotalBucketD / 2) || (BucketID[Turn] == TotalBucketD && BktOfIStat == 1);
	
	// checking hash for the input path
	assign Violation = ConsumeHash && CheckHash &&	
		BucketHeader[Turn][TrancateDigestWidth+BktHSize_RawBits-1:BktHSize_RawBits] != HashOut[Turn][DigestStart-1:DigestEnd];
	
`ifdef SIMULATION		
	always @(posedge Clock) begin
		if (Violation === 1) begin
			$display("Integrity violation!");
			$stop;
		end
		
		else if (Violation === 1'bx) begin
			$display("X bits in hash");
		end
	end
`endif
	
	// updating hash for the output path
	assign Write = ConsumeHash && !CheckHash;		
	assign DataOut = {HashOut[Turn][DigestStart-1:DigestEnd], BucketHeader[Turn][BktHSize_RawBits-1:0]};
		
	//------------------------------------------------------------------------------------
	// Remaining work status
	//------------------------------------------------------------------------------------ 	
	reg [BktAWidth-1:0] BucketProgress;
	reg [2:0]			BktOfIStat;
	wire				PendingWork;
	
	assign Done = BucketProgress >= TotalBucketD && (& Idle);
	
	assign PendingWork = BucketProgress < TotalBucketD || BktOfIStat > 2;	
	
	assign IVDone_BktOfI = BktOfIStat == 0;
		// hacky solution to dispatch the task of verifying the two versions of bucket of interest
	
	//------------------------------------------------------------------------------------
	// Round robin scheduling for hash engines
	//------------------------------------------------------------------------------------ 	
	integer hashid = 0;
	always @(posedge Clock) begin
        if (Reset) begin
            Turn <= 0;
			BucketProgress <= 0;
			BktOfIStat <= 0;
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
			else if (PendingWork && (ConsumeHash || Idle[Turn])) begin	
				BucketOffset[Turn] <= 0;
				
				if (BktOfIStat > 2) begin			// prioritize RO bucket of interest
					BucketID[Turn] <= TotalBucketD;
					BktOfIStat <= BktOfIStat - 1;
				end
				else begin	
					BucketID[Turn] <= BucketProgress;
					BucketProgress <= BucketProgress + 1;
				end
			end
			
			else if (ConsumeHash)									// mark idle
				BucketOffset[Turn] <= BucketOffset[Turn] + 1;
						
			// bucket of interest done
			if (IVReady_BktOfI)
				BktOfIStat <= 4;				
			else if (ConsumeHash && BucketID[Turn] == TotalBucketD)		
				BktOfIStat <= BktOfIStat - 1;			
		end
    end
	
	assign LastTurn = (Turn + NUMSHA3 - 1) % NUMSHA3;
	
	//------------------------------------------------------------------------------------
	// NUMSHA3 hash engines
	//------------------------------------------------------------------------------------ 	
	genvar k;
	generate for (k = 0; k < NUMSHA3; k = k + 1) begin: HashEngines
	
		assign Idle[k] = BucketOffset[k] == BktSize_DRBursts + 1;
		
        Keccak_WF #(        .IWidth(            DDRDWidth),
                            .HashByteCount(     HashByteCount))                         
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
	