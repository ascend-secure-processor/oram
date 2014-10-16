
//==============================================================================
//	Module:		Keccak_WF
//	Desc:		A Keccak unit wrapped with ready-valid interface on both input and output 			
//				Input has a funnel. Hash input has a fixed amount of chunks
//==============================================================================
`include "Const.vh"

module Keccak_WF (
	Clock, Reset, 
	DataInReady, DataInValid, DataIn,
	HashOutReady, HashOutValid, HashOut
);

	parameter IWidth = 512;
	parameter HashByteCount = 1;
	parameter HashOutWidth = 512;
	
	parameter KeyLength = 0;
	parameter Key = 0;
	
	localparam HashInWidth = 128;	
	
	localparam NumKeyChunk = `divceil(KeyLength, HashInWidth);
	localparam LogNumKeyChunk = `log2(NumKeyChunk+1);
	
	input  Clock, Reset;
	
	output DataInReady;
	input  DataInValid;
	input  [IWidth-1:0] DataIn;
	
	input  HashOutReady;
	output HashOutValid;
	output [HashOutWidth-1:0] HashOut;
	
	// hash size param
	localparam HashChunkInByte = HashInWidth / 8;
    localparam HashChunkCount = HashByteCount / HashChunkInByte + 1;                         
    localparam BytesInLastChunk = HashByteCount % HashChunkInByte;
        // if a multiple of chunks, need to add one more empty chunk
	
	// hash in and out data path
	wire HashFunnelOutValid, HashFunnelOutReady, HashInValid, HashInReady;
	wire [HashInWidth-1:0] HashFunnelOut, HashIn; 
	
	wire PrependingKey;
	wire [HashInWidth-1:0] KeyChunk;
	
	
	wire LastChunk, HashBufFull, HashBusy, HashReset;
	wire LastBut2Chunk, LastEmptyChunk;
	
	// Funnel --> HashEngine, controlled by a CounterAlarm
	
	FIFOShiftRound #(		.IWidth(			IWidth),
							.OWidth(			HashInWidth),
							.Class1(			1))				// Hopefully this serves as a input Register
        HashInFunnel(	    .Clock(				Clock),
							.Reset(				Reset),
							.InData(			DataIn),
							.InValid(			DataInValid),
							.InAccept(			DataInReady),
							.OutData(			HashFunnelOut),
							.OutValid(			HashFunnelOutValid),
							.OutReady(			HashFunnelOutReady)
						);
	
	// register at in/out to improve timing
	wire	HashOutValid_pre;
	wire	[HashOutWidth-1:0]	HashOut_pre;	
	Pipeline	#(.Width(HashOutWidth), .Stages(1))
		hash_out_pipe	(Clock,	1'b0, HashOut_pre, HashOut);
	Pipeline	#(.Width(1), .Stages(1))
		hash_out_valid_reg	(Clock, HashReset, HashOutValid_pre, HashOutValid);

	// instantiate the hash engine
    keccak	#(1600, 2 * HashOutWidth, HashInWidth)
        HashEngine	(	    .clk(			Clock), 
							.reset(			HashReset), 
							.in(			HashIn), 
							.in_ready(		HashInValid), 
							.is_last(		LastChunk), 
							.byte_num(		BytesInLastChunk[3:0]), 
							.buffer_full(	HashBufFull), 
							.out(			HashOut_pre), 
							.out_ready(		HashOutValid_pre)
						);
/*
	// unsuccessful attemp in mixing with VHDL
    wire [1:0] hashinreadytemp;
	wire hashoutreadytemp;
	wire [63:0]	hashouttmp;

	wrapper_impl
		HashEngine_test (	.clk(			Clock),
							.rst(			HashReset),
							.ext_din(			HashIn),
							.ext_src_ready(		{HashInValid, HashInValid}),
							.ext_src_read(		hashinreadytemp),
							.ext_dout(			hashouttmp),
							.ext_dst_write(		hashoutreadytemp),
							.ext_dst_ready(		HashOutValid_pre)					
						);					
*/						
    CountAlarm #	(	    .Threshold(HashChunkCount),
                            .IThreshold(HashChunkCount - 1))
        ChunkCtr	(	    .Clock(		    Clock),
							.Reset(		    Reset),
							.Enable(	    HashInValid && HashInReady),
							.Intermediate(  LastBut2Chunk),
							.Done(		    LastChunk)
						);
	
	generate if (NumKeyChunk > 0) begin: HMAC		
		wire [LogNumKeyChunk-1:0] KeyChunkIdx;
	
		Counter		#(		.Width(			LogNumKeyChunk))
		KeyChunkCtr		(	.Clock(			Clock),
							.Reset(			HashReset),									
							.Enable(		PrependingKey && HashInReady),
							.Count(			KeyChunkIdx),							
												.Set(1'b0),	.Load(1'b0), .In({LogNumKeyChunk{1'bx}})
						);
		
		assign PrependingKey = KeyChunkIdx < NumKeyChunk;
		assign KeyChunk = Key >> ( KeyChunkIdx * HashInWidth );
	end	
	else begin : NO_HMAC
		assign PrependingKey = 0;		
	end endgenerate
		
	// TODO this is needed to satisfy Keccak padding
	// Do something about it
	assign LastEmptyChunk = 1'b0;//LastBut2Chunk && !BytesInLastChunk;
	
	assign HashIn = PrependingKey ? KeyChunk : HashFunnelOut;
	assign HashInReady = !HashBusy && !HashBufFull;
	assign HashInValid = HashFunnelOutValid || LastEmptyChunk || PrependingKey;	
	assign HashFunnelOutReady = HashInReady && !LastEmptyChunk && !PrependingKey;	
	
	Register #(.Width(1)) Hash (Clock, HashReset, LastChunk, 1'b0, 1'bx, HashBusy);
	assign HashReset = Reset || (HashOutValid && HashOutReady);
	
endmodule
	
