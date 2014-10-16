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

module padder1(in, byte_num, out);
	parameter	IW = 64;
	
    input      [IW-1:0] in;
    input      [3:0]  byte_num;
    output reg [IW-1:0] out;
    
	generate if (IW == 64) begin:IW64
	
		always @ (*)
		  case (byte_num)
			0: 		out = {						8'h01, 	{(IW-8*1){1'b0}}}; 
			1: 		out = {in[IW-1:IW-8*1], 	8'h01, 	{(IW-8*2){1'b0}}};
			2: 		out = {in[IW-1:IW-8*2], 	8'h01, 	{(IW-8*3){1'b0}}};
			3: 		out = {in[IW-1:IW-8*3], 	8'h01, 	{(IW-8*4){1'b0}}};
			4: 		out = {in[IW-1:IW-8*4], 	8'h01, 	{(IW-8*5){1'b0}}};
			5: 		out = {in[IW-1:IW-8*5], 	8'h01, 	{(IW-8*6){1'b0}}};
			6: 		out = {in[IW-1:IW-8*6], 	8'h01, 	{(IW-8*7){1'b0}}};
			7: 		out = {in[IW-1:IW-8*7], 	8'h01, 	{(IW-8*8){1'b0}}};
		  endcase
		  
	end else if (IW == 128) begin:IW128
	
		always @ (*)
		  case (byte_num)
			0: 		out = {						8'h01, 	{(IW-8*1){1'b0}}}; 
			1: 		out = {in[IW-1:IW-8*1], 	8'h01, 	{(IW-8*2){1'b0}}};
			2: 		out = {in[IW-1:IW-8*2], 	8'h01, 	{(IW-8*3){1'b0}}};
			3: 		out = {in[IW-1:IW-8*3], 	8'h01, 	{(IW-8*4){1'b0}}};
			4: 		out = {in[IW-1:IW-8*4], 	8'h01, 	{(IW-8*5){1'b0}}};
			5: 		out = {in[IW-1:IW-8*5], 	8'h01, 	{(IW-8*6){1'b0}}};
			6: 		out = {in[IW-1:IW-8*6], 	8'h01, 	{(IW-8*7){1'b0}}};
			7: 		out = {in[IW-1:IW-8*7], 	8'h01, 	{(IW-8*8){1'b0}}};
			8: 		out = {in[IW-1:IW-8*8], 	8'h01, 	{(IW-8*9){1'b0}}};
			9: 		out = {in[IW-1:IW-8*9], 	8'h01, 	{(IW-8*10){1'b0}}};
			10: 	out = {in[IW-1:IW-8*10], 	8'h01, 	{(IW-8*11){1'b0}}};
			11: 	out = {in[IW-1:IW-8*11], 	8'h01, 	{(IW-8*12){1'b0}}};
			12: 	out = {in[IW-1:IW-8*12], 	8'h01, 	{(IW-8*13){1'b0}}};
			13: 	out = {in[IW-1:IW-8*13], 	8'h01, 	{(IW-8*14){1'b0}}};
			14: 	out = {in[IW-1:IW-8*14], 	8'h01, 	{(IW-8*15){1'b0}}};
			15: 	out = {in[IW-1:IW-8*15], 	8'h01, 	{(IW-8*16){1'b0}}};		
		  endcase
		  
	end else begin:PASS
`ifdef SIMULATION
		initial begin
			$display("IW not 64 or 128, not supported");
			$finish;
		end
`endif
	end endgenerate	  
endmodule
