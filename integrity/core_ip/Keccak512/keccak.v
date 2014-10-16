/*
 * Copyright 2013, Homer Hsing <homer.hsing@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* "is_last" == 0 means byte number is 8, no matter what value "byte_num" is. */
/* if "in_ready" == 0, then "is_last" should be 0. */
/* the user switch to next "in" only if "ack" == 1. */

`define low_pos(w,b)      ((w)*64 + (b)*8)
`define low_pos2(w,b)     `low_pos(w,7-b)
`define high_pos(w,b)     (`low_pos(w,b) + 7)
`define high_pos2(w,b)    (`low_pos2(w,b) + 7)

module keccak(clk, reset, in, in_ready, is_last, byte_num, buffer_full, out, out_ready);
	parameter	f = 1600;
	parameter	c = 1024;
	
	localparam	r = f - c;
	localparam	c2 = c / 2;

	parameter	IW = 64;
//	localparam	BytesInChunk = IW / 8;
	localparam	ChunkInFIn = r / 64;		// this 64 has nothing to do with IW! Do not change!
	localparam	ChunkInFOut = f / 64;

`ifdef SIMULATION	
	initial begin
		if (r % IW != 0) begin
			$display("IW does not divide r. Don't know what to do");
			$finish;
		end
		if (f != 1600) begin
			$display("f != 1600, not supported");
			$finish;
		end
	end
`endif
	
    input              clk, reset;
    input      [IW-1:0]  in;
    input              in_ready, is_last;
    input      [3:0]   byte_num;
    output             buffer_full; 	// to "user" module
    output     [c2-1:0] out;
    output reg         out_ready;

    reg                state;     		// state == 1: user has sent all data
    wire       [r-1:0] padder_out,	padder_out_pre, 	f_in; 	// padder_out is padder_out_pre reordered 				   
    wire               padder_out_valid, padder_out_ready, f_in_valid;
    wire               f_ack;
    wire       [f-1:0] f_out,	f_out1;	// // f_out1 is f_out reordered 			
    wire               f_out_ready;
    reg        [10:0]  i;         /* gen "out_ready" */
    

    assign out = f_out1[f-1:f-c2];

    always @ (posedge clk)
      if (reset)
        i <= 0;
      else
        i <= {i[9:0], state & f_ack};

    always @ (posedge clk)
      if (reset)
        state <= 0;
      else if (is_last && in_ready && !buffer_full)
        state <= 1;

	// reorder byte ~ ~
	genvar w, b; 
    generate	
		for(w = 0; w < ChunkInFOut; w = w+1) begin:OUT_REORDER_1	
			for(b = 0; b < 8; b = b+1) begin:OUT_REORDER_2	
				assign f_out1[`high_pos(w,b):`low_pos(w,b)] = f_out[`high_pos2(w,b):`low_pos2(w,b)];
    		end
	end endgenerate

	generate
		for(w = 0; w < ChunkInFIn; w = w+1) begin:IN_REORDER_1	
			for(b = 0; b < 8; b = b+1) begin:IN_REORDER_2	
				assign padder_out[`high_pos(w,b):`low_pos(w,b)] = padder_out_pre[`high_pos2(w,b):`low_pos2(w,b)];
    		end
	end endgenerate

    always @ (posedge clk)
      if (reset)
        out_ready <= 0;
      else if (i[10])
        out_ready <= 1;

    padder	#(f, c, IW)
      padder_ (clk, reset, in, in_ready, is_last, byte_num, buffer_full, padder_out_pre, padder_out_valid, padder_out_ready);

	FIFORegister #(		.Width(			r), 
						.BWLatency(		1)) 
		padder_reg (	.Clock(			clk),
						.Reset(			reset),
						.InData(		padder_out),
						.InValid(		padder_out_valid),
						.InAccept(		padder_out_ready),
						.OutData(		f_in),
						.OutSend(		f_in_valid),
						.OutReady(		f_ack)  
					);
	  
    f_permutation #(f, c)
      f_permutation_ (clk, reset, f_in, f_in_valid, f_ack, f_out, f_out_ready);
endmodule

`undef low_pos
`undef low_pos2
`undef high_pos
`undef high_pos2
