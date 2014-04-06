
//==============================================================================
//	Module:		Integrity Verifier
//	Desc:		Use several SHA-3 units to verify buckets in Path ORAM
//				A RAM interface with Coherence Controller
//==============================================================================

module IntegrityVerifier (
	Clock, Reset, 
	Request, Write, Address, DataIn, DataOut	// RAM interface
	// TODO: some states from CC
);

	parameter NUMSHA3 = 1;

	`include "DDR3SDRAM.vh";	
	`include "DDR3SDRAMLocal.vh"

	input  Clock, Reset;
	output Request, Write;
	output [8:0] Address;		// TODO
	input  [DDRDWidth-1:0]  DataIn;
	output [DDRDWidth-1:0]  DataOut;

	// input size to hash
	localparam ByteInLastChunk = 0;
	localparam HashInChunkCount = 10;		
	
	// hash in and out data path
	localparam  HashInWith = 64;
	localparam  HashOutWidth = 512;
	
	wire FunnelInReady [NUMSHA3-1:0];
	
	wire HashInValid [NUMSHA3-1:0];
	wire HashInReady [NUMSHA3-1:0];
	wire [HashInWith-1:0] HashIn [NUMSHA3-1:0];
	wire HashBufFull  [NUMSHA3-1:0];
	wire LastChunk [NUMSHA3-1:0];
	wire HashBusy  [NUMSHA3-1:0];
	wire HashReset  [NUMSHA3-1:0];
	
	
	wire HashOutValid [NUMSHA3-1:0];
	wire [HashOutWith-1:0] HashOut [NUMSHA3-1:0]; 
	
	// control logic: round robin scheduling for hash engines
	localparam  LogNUMSHA3 = `max(1, `log2(NUMSHA3));
		
	wire DataInValid, FunnelInValid, ConsumeHash;	
	Register #(.Width(1)) 	DInValid (Clock, 1'b0, 1'b0, 1'b1, 	Request && !Write, 	DataInValid);
	assign FunnelInValid = DataInValid;
	assign ConsumeHash = HashOutValid[OutTurn];
	
	wire [LogNUMSHA3-1:0] InTurn;
	wire [LogNUMSHA3-1:0] OutTurn;
	
	Counter		#(			.Width(					LogNUMSHA3))
		in_cnt	(			.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DataInValid),
							.In(					{LogNUMSHA3{1'bx}}),
							.Count(					InTurn)); 
	
	Counter		#(			.Width(					LogNUMSHA3))
		out_cnt	(			.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				ConsumeHash),
							.In(					{LogNUMSHA3{1'bx}}),
							.Count(					OutTurn)); 
	
	genvar k;
	generate for (k = 0; k < NUMSHA3; k = k + 1) begin
		
		FIFOShiftRound #(	.IWidth(				DDRDWidth),
							.OWidth(				HashInWith))
			HashInFunnel(	.Clock(					Clock),
							.Reset(					Reset || LastChunk[k]),
							.InData(				DataIn),
							.InValid(				FunnelInValid && InTurn == k),
							.InAccept(				FunnelInReady[k]),
							.OutData(			    HashIn[k]),
							.OutValid(				HashInValid[k]),
							.OutReady(				HashInReady[k])
						);
		
		CountAlarm #	(	.Threshold(HashInChunkCount))
			ChunkCtr	(	.Clock(		Clock),
							.Reset(		Reset),
							.Enable(	HashInValid[k] && HashInReady[k]),
							.Done(		LastChunk[k])
						);
		
		keccak	
			HashEngine	(	.clk(			Clock), 
							.reset(			HashReset[k]), 
							.in(			HashIn[k]), 
							.in_ready(		HashInValid[k]), 
							.is_last(		LastChunk[k]), 
							.byte_num(		ByteInLastChunk), 
							.buffer_full(	HashBufFull[k]), 
							.out(			HashOut[k]), 
							.out_ready(		HashOutValid[k])
						);
		
		assign HashReset[k] = ConsumeHash && OutTurn == k;			
		assign HashInReady[k] = !HashBufFull[k] && !HashBusy[k];		
		Register #(.Width(1)) Hash (Clock, HashReset[k], LastChunk[k], 1'b0, 1'bx, HashBusy[k]);
		
	end
endmodule
	