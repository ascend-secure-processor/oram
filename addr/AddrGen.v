//==============================================================================
//	Module:		AddrGen
//	Desc:		Send requests to DRAM to read/write buckets/headers along a path
//==============================================================================

`include "Const.vh"

module AddrGen
(
	Clock, Reset, 
	Start, RWIn, BHIn, leaf, Ready, CmdReady, CmdValid, Cmd, 
	Addr, currentLevel, BktIdx,
	
	// output for debugging
	STIdx, BktIdxInST
);

	`include "PathORAM.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "CommandsLocal.vh"
	
	localparam ORAMLogL = `log2(ORAML) + 1; // TODO need +1 for Ready signal corner case (e.g., ORAML = 31); find a better solution?
	
	// =========================== Ports =========================
	input Clock; 

	// interface with backend controller
	input Reset, Start; 
	input RWIn;              // 0 for write, 1 for read, 
	input BHIn;              // 0 for the entire bucket, 1 for the header
	input [ORAML-1:0] leaf;
	output Ready;

	// interface with DRAM controller
	input CmdReady;
	output CmdValid;
	output [DDRCWidth-1:0] Cmd;
	output [DDRAWidth-1:0] Addr;
	output [ORAML:0] BktIdx;	// logic bucket ID (no subtree)
	
	// output for debugging
	output [ORAMLogL-1:0]  currentLevel; 
	output [ORAML:0] STIdx, BktIdxInST;
	
	// ====================================================

	wire [ORAML+1:0] BktIdx_Padded;
	
	// control logic for AddrGenBktHead
	wire Enable, SwitchLevel;
	reg RW, BH;
	reg [BBSTWidth-1:0] BktCounter;

`ifndef FPGA
	AddrGenBktHead
	abt 	(  	.Clock(		Clock),
						.Reset(		Reset),
						.Start(		Start && Ready),
						.Enable(	Enable),
						.leaf(		leaf),
						.currentLevel(	currentLevel),
						.BktIdx(	BktIdx_Padded),
						
						// output for debugging
						.STIdx(		STIdx),
						.BktIdxInST(BktIdxInST)
					);  
`else
    
	AddrGenBktHead #( 	.ORAMB(					ORAMB),
						.ORAMU(					ORAMU),
						.ORAML(					ORAML),
						.ORAMZ(					ORAMZ),
						.BEDWidth(				BEDWidth),
						.EnableIV(				EnableIV)
					) 
	abt 	(  	.Clock(		Clock),
						.Reset(		Reset),
						.Start(		Start && Ready),
						.Enable(	Enable),
						.leaf(		leaf),
						.currentLevel(	currentLevel),
						.BktIdx(	BktIdx_Padded),
						
						// output for debugging
						.STIdx(		STIdx),
						.BktIdxInST(BktIdxInST)
					);  
`endif
					
	assign SwitchLevel = BktCounter >= (BH ? BktHSize_DRBursts : BktSize_DRBursts) - 32'd1; // TODO this may still result in signed-unsigned warning, but careful to test things if you change it
	assign Enable = !Ready && CmdReady && SwitchLevel;

	// output 
	assign Ready = currentLevel > ORAML;
	assign CmdValid = currentLevel <= ORAML;
	assign Cmd = RW ? DDR3CMD_Read : DDR3CMD_Write;
	assign Addr = (BktIdx_Padded * BktSize_DRBursts + BktCounter) * DDRBstLen;

	always@(posedge Clock) begin
		if (Start && Ready) begin
			RW <= RWIn;
			BH <= BHIn;
			BktCounter <= 0;
		end

		if (!Ready && CmdReady) begin
			BktCounter <= SwitchLevel ? 0 : BktCounter + 1;
		end      
	end
	
	BktIDGen # 	(	.ORAML(		ORAML))
		bid 	(	.Clock(		Clock),
					.ReStart(	Start && Ready),
					.leaf(		leaf),
					.Enable(	Enable),
					.BktIdx(	BktIdx)			
				);
	
`ifdef SIMULATION

	/*always @(posedge Clock) begin
		if (CmdValid && CmdReady && BktCounter == 0)
			$display("Accessing DRAM address [%x], Bucket %x, ST = %x, Bkt=%d", Addr, BktIdx_Padded, STIdx, BktIdxInST);
	end*/
	
	// Check that AddrGen is not mapping two different buckets to the same physical address
	localparam 	CheckAddrGen = 1;
	integer bkt_i;
	generate if (CheckAddrGen) begin:Check_Addr
		localparam	NumBuckets = 1 << (ORAML+1);
		
		reg [ORAML+1:0]	AddrMap [0:NumBuckets-1];
		reg AddrMapValid [0:NumBuckets-1];
		
		always @(posedge Clock) begin
			if (Reset) begin
				for (bkt_i = 0; bkt_i < NumBuckets; bkt_i = bkt_i + 1)
					AddrMapValid[bkt_i] <= 1'b0;
			end
			
			else if (!BktCounter && CmdValid) begin
				if (AddrMapValid[Addr/DDRBstLen/BktSize_DRBursts])
					if (AddrMap[Addr/DDRBstLen/BktSize_DRBursts] != BktIdx_Padded) begin
						$display("Wrong mapping for bucket %d, %x != %x", BktIdx, AddrMap[BktIdx], Addr);
					end
				else begin
					AddrMap[Addr/DDRBstLen/BktSize_DRBursts] <= BktIdx_Padded;
					AddrMapValid[Addr/DDRBstLen/BktSize_DRBursts] <= 1'b1;
				end
			end		
		end
		
	end endgenerate

`endif

endmodule
