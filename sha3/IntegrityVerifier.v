
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
	Request, Write, Address, DataIn, DataOut	// RAM interface
	// TODO: some states from CC
);

	parameter NUMSHA3 = 3;
	localparam  LogNUMSHA3 = `max(1, `log2(NUMSHA3));	
	
    `include "PathORAM.vh";
	`include "DDR3SDRAM.vh";
	`include "AES.vh";
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "SHA3Local.vh"

    localparam  AWidth = PathBufAWidth;
	localparam  BktAWidth = `log2(ORAML) + 1;

	input  Clock, Reset;
	output Done;
	output Request, Write;
	output [AWidth-1:0] Address;
	input  [DDRDWidth-1:0]  DataIn;
	output [DDRDWidth-1:0]  DataOut;

	// hash IO internal variables
	localparam HashByteCount = (BktSize_RawBits + 0) / 8;    	
	
	wire [DDRDWidth-1:0] HashData;
	wire HashDataReady [NUMSHA3-1:0];
	wire DataInValid, HeaderInValid;
	
	wire HashOutValid [NUMSHA3-1:0];
	wire [FullDigestWidth-1:0] HashOut [NUMSHA3-1:0]; 
	wire ConsumeHash, Violation;
	
	//------------------------------------------------------------------------------------
	// Round robin scheduling for hash engines
	//------------------------------------------------------------------------------------ 
		
	reg [LogNUMSHA3-1:0] InTurn, OutTurn; 
	always @(posedge Clock) begin
        if (Reset) begin
            InTurn <= 0;
            OutTurn <= 0;
        end
        else begin
            if (DataInValid)
                InTurn <= (InTurn + 1) % NUMSHA3;
            if (ConsumeHash)
                OutTurn <= (OutTurn + 1) % NUMSHA3;
        end
    end
	
	//------------------------------------------------------------------------------------
	// Request and address generation
	//------------------------------------------------------------------------------------ 
	reg [`log2(BktSize_DRBursts):0] DoneBlocks;
	
	always @(posedge Clock) begin
		if (Reset) begin
			DoneBlocks <= 0;
		end
		else if (DataInValid && !Done) begin					
			if (DoneBlocks == BktSize_DRBursts - 1) 	// all chunks for this bucket are streamed in
				BucketStream[InTurn] <= 0;
		
			if (InTurn == NUMSHA3 - 1) 	// next chunk in each bucket
				DoneBlocks <= (DoneBlocks + 1) % BktSize_DRBursts;
		end
	end
	
	assign Address = Write ? 
		BucketAddr[OutTurn] * BktSize_DRBursts : 		//	updating hash for the previous set of buckets
		BucketAddr[InTurn] * BktSize_DRBursts + DoneBlocks;		//  reading data from the current set of buckets
		
	assign Request = !Reset && (Write || (HashDataReady[InTurn] && !DataInValid && BucketStream[InTurn] ) );

	//------------------------------------------------------------------------------------
	// Pass data to hash engine (possibly modified) and save the headers 
	//------------------------------------------------------------------------------------

	Register #(.Width(1)) 	RdData (Clock, Reset, 1'b0, 1'b1, 	Request && !Write, 					DataInValid);
	Register #(.Width(1)) 	RdHash (Clock, Reset, 1'b0, 1'b1, 	Request && !Write && !DoneBlocks, 	HeaderInValid);

	reg 				BucketStream	[NUMSHA3-1:0];	
	reg [DDRDWidth-1:0] BucketHeader 	[NUMSHA3-1:0];
	reg [BktAWidth-1:0] BucketAddr		[NUMSHA3-1:0];
	
	reg [BktAWidth-1:0] BucketProgress;
	integer hashid = 0;
	
	always @(posedge Clock) begin
		if (Reset) begin
			BucketProgress <= NUMSHA3;
			for (hashid = 0; hashid < NUMSHA3; hashid = hashid + 1) begin
				BucketAddr[hashid] <= hashid;
				BucketStream[hashid] <= 1'b1;
			end
		end
		
		else begin
            if (HeaderInValid) begin
                BucketHeader[InTurn] <= DataIn;
            end            
            if (ConsumeHash) begin
				BucketAddr[OutTurn]	<= BucketProgress;
				BucketProgress <= BucketProgress + 1;
				BucketStream[OutTurn] <= 1'b1;				
            end
        end
	end
	
	assign HashData = HeaderInValid ? {{TrancateDigestWidth{1'b0}}, DataIn[BktHSize_RawBits-1:0]} : DataIn;
		// TODO: does not work if there are more than 1 head flits
	
	//------------------------------------------------------------------------------------
	// Check or fill in the hash
	//------------------------------------------------------------------------------------ 
	assign ConsumeHash = HashOutValid[OutTurn] && !DoneBlocks;	
	
	// checking hash for the input path
	assign Violation = ConsumeHash && (BucketAddr[OutTurn] < ORAML + 1)  &&	
		BucketHeader[OutTurn][TrancateDigestWidth+BktHSize_RawBits-1:BktHSize_RawBits] != HashOut[OutTurn][DigestStart-1:DigestEnd];

	assign Done = BucketProgress >= 2 * (ORAML + 1);
		
`ifdef SIMULATION		
	always @(posedge Clock) begin
		if (Violation === 1) begin
			$display("Integrity violation!");
			//$stop;
		end
		
		else if (Violation === 1'bx) begin
			$display("X bits in hash");
		end
	end
`endif
	
	// updating hash for the output path
	assign Write = !Done && ConsumeHash;		
	assign DataOut = {HashOut[OutTurn][DigestStart-1:DigestEnd], BucketHeader[OutTurn][BktHSize_RawBits-1:0]};
	
	//------------------------------------------------------------------------------------
	// NUMSHA3 hash engines
	//------------------------------------------------------------------------------------ 	
	genvar k;
	generate for (k = 0; k < NUMSHA3; k = k + 1) begin: HashEngines
		
        Keccak_WF #(        .IWidth(            DDRDWidth),
                            .HashByteCount(     HashByteCount))                         
            HashEngine (    .Clock(             Clock),         
                            .Reset(             Reset),
                            .DataInReady(       HashDataReady[k]),
                            .DataInValid(       DataInValid && InTurn == k),
                            .DataIn(            HashData),
                            .HashOutReady(      ConsumeHash && OutTurn == k),
                            .HashOutValid(      HashOutValid[k]),
                            .HashOut(           HashOut[k])
                    );
                    
	end endgenerate
endmodule
	