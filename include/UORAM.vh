`ifdef PINIT_HEADER
	parameter		Recursion = 		-1;
	parameter		EnablePLB = 		-1,
					PLBCapacity = 		-1;     // in bits
	parameter		PRFPosMap = 		-1;
`else		
	parameter		Recursion = 		6;
	parameter		EnablePLB = 		1,
					PLBCapacity = 		8192 << 3;     // in bits
	parameter		PRFPosMap = 		1;
`endif