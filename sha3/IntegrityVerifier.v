
//==============================================================================
//	Module:		Integrity Verifier
//	Desc:		Use several SHA-3 units to verify buckets in Path ORAM
//				A RAM interface with Coherence Controller
//              h = Hash (v, u, l, block[0], block[1], ..., block[Z-1], BucketID, BucketCtr)
//==============================================================================

`include "Const.vh"

module IntegrityVerifier (
	Clock, Reset, 
	Done, PathSelect,
	Request, Write, Address, DataIn, DataOut	// RAM interface
	// TODO: some states from CC
);

	parameter NUMSHA3 = 3;

    `include "PathORAM.vh";
	`include "DDR3SDRAM.vh";
	`include "AES.vh";
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "SHA3Local.vh"

    localparam  AWidth = PthBSTWidth;

	input  Clock, Reset;
	output reg Done;
	output reg PathSelect;		// which path are we verifying now?	
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
	
	//------------------------------------------------------------------------------------
	// control logic: round robin scheduling for hash engines
	//------------------------------------------------------------------------------------ 
	localparam  LogNUMSHA3 = `max(1, `log2(NUMSHA3));	
	wire ReadData, ReadHeader;
	wire ConsumeHash, Violation;
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
	reg [AWidth-1:0] DoneBuckets;
	reg [`log2(BktSize_DRBursts):0] DoneBlocks;
	
	always @(posedge Clock) begin
		if (Reset) begin
			DoneBuckets <= 0;
			DoneBlocks <= 0;
			PathSelect <= 0;
			Done <= 0;
		end
		else if (DataInValid && !Done) begin
			if (InTurn == NUMSHA3 - 1) begin	// next chunk in each bucket
				DoneBlocks <= (DoneBlocks + 1) % BktSize_DRBursts;
				
				if (DoneBlocks == BktSize_DRBursts - 1) begin	// next set of buckets
					if (DoneBuckets + NUMSHA3 < ORAML + 1) 
						DoneBuckets <= DoneBuckets + NUMSHA3;	
						
					else begin	// entire path done
						DoneBuckets <= 0;
						PathSelect <= 1;
						Done <= PathSelect;
					end
				end
			end
		end
	end
	
	assign Address = Write ? 
		(DoneBuckets - NUMSHA3 + OutTurn) * BktSize_DRBursts : 		//	updating hash for the previous set of buckets
		(DoneBuckets + InTurn) * BktSize_DRBursts + DoneBlocks;		//  reading data from the current set of buckets
		
	assign Request = !Reset && (Write || (HashDataReady[InTurn] && !DataInValid && !(!DoneBlocks && HeadersFull[InTurn]) ) );

	//------------------------------------------------------------------------------------
	// Pass data to hash engine (possibly modified) and save the headers 
	//------------------------------------------------------------------------------------
	assign ReadData = Request && !Write; 
	assign ReadHeader = Request && !Write && (Address % BktSize_DRBursts == 0); // address of a header	
	Register #(.Width(1)) 	RdData (Clock, Reset, 1'b0, 1'b1, 	ReadData, 		DataInValid);
	Register #(.Width(1)) 	RdHash (Clock, Reset, 1'b0, 1'b1, 	ReadHeader, 	HeaderInValid);
	
	reg [DDRDWidth-1:0] Headers [NUMSHA3-1:0];
	reg HeadersFull [NUMSHA3-1:0];
	integer hashid = 0;
	
	always @(posedge Clock) begin
		if (Reset) begin
			for (hashid = 0; hashid < NUMSHA3; hashid = hashid + 1)
				HeadersFull[hashid] <= 0;
		end
		
		else begin
            if (HeaderInValid) begin
                Headers[InTurn] <= DataIn;
                HeadersFull[InTurn] <= 1;
            end            
            if (ConsumeHash) begin
                HeadersFull[OutTurn] <= 0;
            end
        end
	end
	
	assign HashData = HeaderInValid ? {{TrancateDigestWidth{1'b0}}, DataIn[BktHSize_RawBits-1:0]} : DataIn;
		// TODO: does not work when there are more than 1 head flits
	
	//------------------------------------------------------------------------------------
	// Check or fill in the hash
	//------------------------------------------------------------------------------------ 
	assign ConsumeHash = HashOutValid[OutTurn] && !DoneBlocks;	
	
	// checking hash for the input path
	assign Violation = ConsumeHash && !PathSelect &&	
		Headers[OutTurn][TrancateDigestWidth+BktHSize_RawBits-1:BktHSize_RawBits] != HashOut[OutTurn][DigestStart-1:DigestEnd];

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
	assign Write = !Done && ConsumeHash && PathSelect && DoneBuckets;		
	assign DataOut = {HashOut[OutTurn][DigestStart-1:DigestEnd], Headers[OutTurn][BktHSize_RawBits-1:0]};

		
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
	