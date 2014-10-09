`ifdef PINIT_HEADER
	parameter				Recursion = 			-1;
	parameter				EnablePLB = 			-1,
			 				PLBCapacity = 			-1;     // in bits
	parameter				PRFPosMap = 			-1;
`else		
	parameter				EnablePLB = 			1,
			 				PLBCapacity = 			8192 << 3;     // in bits
	parameter				PRFPosMap = 			1;
	parameter				Recursion = 			`divceil(ORAML + 2 - 10, 4 - PRFPosMap) + 1;	// recursive until < 1024 entries in PosMap
`endif

	localparam				FakePattern =			32'h00af1234;