/*
 * Copyright 2012, Homer Hsing <homer.hsing@gmail.com>
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

module aes_128(clk, state, key, out);
    input          clk;
    input  [127:0] state, key;
    output [127:0] out;
    reg    [127:0] s0, k0;
    wire   [127:0] s1, s2, s3, s4, s5, s6, s7, s8, s9,
                   k1, k2, k3, k4, k5, k6, k7, k8, k9, k9b;

    always @ (posedge clk)
      begin
        s0 <= state ^ key;
        k0 <= key;
      end

	one_round 
		r1 (clk, k0, s0, 8'h1,  k1, s1),
        r2 (clk, k1, s1, 8'h2,  k2, s2),
        r3 (clk, k2, s2, 8'h4,  k3, s3),
        r4 (clk, k3, s3, 8'h8,  k4, s4),
        r5 (clk, k4, s4, 8'h10, k5, s5),
        r6 (clk, k5, s5, 8'h20, k6, s6),
        r7 (clk, k6, s6, 8'h40, k7, s7),
        r8 (clk, k7, s7, 8'h80, k8, s8),
        r9 (clk, k8, s8, 8'h1b, k9, s9);
	
	final_round
		rf (clk, k9, s9, 8'h36, out);
		
endmodule