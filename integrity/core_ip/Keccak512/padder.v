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

module padder(clk, reset, in, in_ready, is_last, byte_num, buffer_full, out, out_ready, f_ack);

	parameter	f = 1600;
	parameter	c = 1024;
	
	localparam	r = f - c;
	localparam	c2 = c / 2;
	
	parameter	IW = 64;
	localparam	ChunkInFIn = r / IW;

    input              clk, reset;
    input      [IW-1:0]  in;
    input              in_ready, is_last;
    input      [3:0]   byte_num;
    output             buffer_full; /* to "user" module */
    output reg [r-1:0] out;         /* to "f_permutation" module */
    output             out_ready;   /* to "f_permutation" module */
    input              f_ack;       /* from "f_permutation" module */
    
    reg                state;       /* state == 0: user will send more input data
                                     * state == 1: user will not send any data */
    reg                done;        /* == 1: out_ready should be 0 */
    reg        [ChunkInFIn-1:0]   i;           /* length of "out" buffer */
    wire       [IW-1:0]  v0;          /* output of module "padder1" */
    reg        [IW-1:0]  v1;          /* to be shifted into register "out" */
    wire               update;      
    
    assign buffer_full = i[ChunkInFIn-1];
    assign out_ready = buffer_full;
	assign	update =  (in_ready | state) & (~ buffer_full) & (~ done);

    always @ (posedge clk)
	if (update)
		out <= {out[r-1-IW:0], v1};

    always @ (posedge clk)
		if (reset || (f_ack && out_ready))
			i <= {ChunkInFIn{1'b0}};
		else if (update) 
			i <= {i[ChunkInFIn-2:0], 1'b1};
			
    always @ (posedge clk)
		if (reset)
			state <= 0;
		else if (in_ready && is_last && !buffer_full)
			state <= 1;

    always @ (posedge clk)
		if (reset)
			done <= 0;
		else if (state & out_ready)
			done <= 1;

	localparam	USE_10Pad = 0;
	generate if (USE_10Pad)	begin:TENP
		padder1 #(IW) 
			p0 (in, byte_num, v0);
    end else begin:TENPASS
		assign	v0 = {IW{1'b0}};
	end endgenerate
	
	
    always @ (*)  
		if (state || is_last)	begin	
			v1 = state ? {IW{1'b0}} : v0;
			v1[7] = v1[7] | i[ChunkInFIn-2]; /* "v1[7]" is the MSB of its last byte */
		end
		else	
			v1 = in;
				
endmodule
