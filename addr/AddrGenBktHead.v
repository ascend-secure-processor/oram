//==============================================================================
//	Module:		AddrGenBktHead
//	Desc:		Output STARTING physical addresses of buckets along a path, 
//				using subtree locality trick from ISCA'13
//==============================================================================

`include "Const.vh"

module AddrGenBktHead 
(
	Clock, Reset, Start, Enable, 
	leaf,                    
	currentLevel, 
	BktIdx,     

	STIdx, BktIdxInST  // output for debugging
);

	`include "PathORAM.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"

	localparam ORAMLogL = `log2(ORAML) + 1;

	localparam LogSTSize = L_st;    // subtree size (in buckets), it could be (1 << numST) - 1; this is optimal for Z=3 
	localparam LogSTSizeBottom = (ORAML+1) % L_st;            // short trees' size (in buckets) at the bottom

	input Clock, Reset, Start, Enable;
	input [ORAML-1:0] leaf;                     // the input leaf label
	output reg [ORAMLogL-1:0]  currentLevel; 
	output [ORAML+1:0] BktIdx;           // A tree of depth L needs L+1 bits to denote the node. 
                                         // And we waste several spots due to subtree, requiring L+2 bits
	output [ORAML:0] STIdx, BktIdxInST;  // tmp output for debugging
  
	
`ifdef FPGA	
	initial begin	// don't delete, REWAES needs this to get rid of Reset
		currentLevel = ORAML+1;
	end
`endif
  
	// One PathGen module walks the subtrees and the other inside a subtree
	reg [ORAML-1:0] leaf_shift; 
	wire switchST;
	// wire [ORAML-1:0] STIdx, BktIdxInST;
	PathGen #(ORAML) STGen(Clock, Start, Enable, switchST, leaf_shift[0], STIdx); 
	PathGen #(ORAML) BktGen(Clock, Start || (Enable && switchST), Enable, 1'b1, leaf_shift[0], BktIdxInST);

	// control logic for STGen and BktGen
	reg [ORAMLogL-1:0] currentLvlinST;
	assign switchST = currentLvlinST >= L_st - 32'd1;

	always@(posedge Clock) begin
		if (Reset) begin
			currentLevel <= ORAML + 32'd1;
		end
		else if (Start) begin
			currentLevel <= 0;
			currentLvlinST <= 0;
			leaf_shift <= leaf;
		end 
		else if (Enable) begin
			currentLevel <= currentLevel + 1;
			currentLvlinST <= switchST ? 0 : currentLvlinST + 1;
			leaf_shift <= leaf_shift >> 1;    
		end
	end
  
	// adjust for the (possibly) shorter subtrees at the bottom 
	localparam L_Padded = numST * L_st;
	wire shortTreeAtBottom;
	assign shortTreeAtBottom = L_Padded != ORAML + 32'd1 && currentLevel + L_st >= L_Padded;
	// short tree exists, iff ORAML+1 != multiple of numST * L_st 

	assign BktIdx = BktIdxInST + 
				(
					shortTreeAtBottom ? 
					(numTallST << LogSTSize) + ((STIdx-numTallST) << LogSTSizeBottom) :
					(STIdx << LogSTSize)
				);

endmodule
