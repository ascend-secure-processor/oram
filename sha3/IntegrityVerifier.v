
//==============================================================================
//	Module:		Integrity Verifier
//	Desc:		Use several SHA-3 units to verify buckets in Path ORAM
//				A RAM interface with Coherence Controller
//              h = Hash (v, u, l, block[0], block[1], ..., block[Z-1], BucketID, BucketCtr)
//==============================================================================

`include "Const.vh"

module IntegrityVerifier (
	Clock, Reset, 
	Request, Write, Address, DataIn, DataOut	// RAM interface
	// TODO: some states from CC
);

	parameter NUMSHA3 = 3;

    `include "PathORAM.vh";
	`include "DDR3SDRAM.vh";
	`include "AES.vh";	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"

    localparam  AWidth = PthBSTWidth;

	input  Clock, Reset;
	output Request, Write;
	output [AWidth-1:0] Address;
	input  [DDRDWidth-1:0]  DataIn;
	output [DDRDWidth-1:0]  DataOut;

	// hash IO internal variables
	localparam  HashOutWidth = 512;
	localparam HashByteCount = (BktPSize_RawBits + 0) / 8;    	
	
	wire [DDRDWidth-1:0] HashData;
	wire HashDataReady [NUMSHA3-1:0];
	wire HashDataValid, HashInValid;
	
	wire HashOutValid [NUMSHA3-1:0];
	wire [HashOutWidth-1:0] HashOut [NUMSHA3-1:0]; 
	
	// control logic: round robin scheduling for hash engines
	localparam  LogNUMSHA3 = `max(1, `log2(NUMSHA3));	
	wire ReadData, ReadHash, ConsumeHash;
	reg [LogNUMSHA3-1:0] InTurn, OutTurn;
	
	assign ReadData = Request && !Write && 1; // certain address
	assign ReadHash = Request && !Write && 1; // certain address	
	Register #(.Width(1)) 	RdData (Clock, Reset, 1'b0, 1'b1, 	ReadData, 	HashDataValid);
	Register #(.Width(1)) 	RdHash (Clock, Reset, 1'b0, 1'b1, 	ReadHash, 	HashInValid);
	
	assign HashData = DataIn;
	
	assign ConsumeHash = HashOutValid[OutTurn];

	assign Request = !Reset && HashDataReady[InTurn] && !HashDataValid;
	assign Write = 0;

    always @(posedge Clock) begin
        if (Reset) begin
            InTurn <= 0;
            OutTurn <= 0;
        end
        else begin
            if (HashDataValid)
                InTurn <= (InTurn + 1) % NUMSHA3;
            if (ConsumeHash)
                OutTurn <= (OutTurn + 1) % NUMSHA3;
        end
    end
		
	genvar k;
	generate for (k = 0; k < NUMSHA3; k = k + 1) begin: HashEngines
		
        Keccak_WF #(        .IWidth(            DDRDWidth),
                            .HashByteCount(     HashByteCount))                         
            HashEngine (    .Clock(             Clock),         
                            .Reset(             Reset),
                            .DataInReady(       HashDataReady[k]),
                            .DataInValid(       HashDataValid && InTurn == k),
                            .DataIn(            HashData),
                            .HashOutReady(      ConsumeHash && OutTurn == k),
                            .HashOutValid(      HashOutValid[k]),
                            .HashOut(           HashOut[k])
                    );
                    
	end endgenerate
endmodule
	