//==============================================================================
//	Module:		BktIDGen
//	Desc:		Return logical bucket IDs on a path
//==============================================================================

module BktIDGen ( Clock, ReStart, Enable, leaf, BktIdx );

	parameter ORAML = 10;
	
	input Clock, ReStart, Enable;
	input [ORAML-1:0] leaf;    
	output [ORAML:0] BktIdx;            // A tree of depth L needs L+1 bits to denote the node. 
                                        // If we waste several spots due to subtree, we need L+2 bits
										// This module outputs the unwasted version, thus L+1
    
	reg [ORAML-1:0] leaf_shift;

	PathGen #(ORAML) 	BktGen(Clock, ReStart, Enable, 1'b1, leaf_shift[0], BktIdx);

	always@(posedge Clock) begin
		if (ReStart)
			leaf_shift <= leaf;	 
		else if (Enable) 
			leaf_shift <= leaf_shift >> 1;    	
	end
  
endmodule
