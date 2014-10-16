//==============================================================================
//	Module:		ROISeedGenerator
//	Desc:
//==============================================================================
module ROISeedGenerator(
  	Clock, ROStart, Enable,
	ROLeaf, GentryVersion,
	ROIBV, ROIBID
);

	`include "PathORAM.vh"

	input						Clock, ROStart, Enable;
	input	[ORAML-1:0]			ROLeaf;
	input	[AESEntropy-1:0]	GentryVersion;
	
	output	[AESEntropy-1:0]	ROIBV;	
	output	[ORAML:0]			ROIBID;		
	
	wire						RO_LeafNextDirection;
	wire	[AESEntropy-1:0] 	ROIBV_Next;
	
	Register	#(		.Width(					AESEntropy))
			ro_gentry(	.Clock(					Clock),
						.Reset(					1'b0),
						.Set(					1'b0),
						.Enable(				ROStart | Enable),
						.In(					ROIBV_Next),
						.Out(					ROIBV)
					);
								
	ShiftRegister #(	.PWidth(				ORAML),
						.Reverse(				1),
						.SWidth(				1))
			ro_L_shft(	.Clock(					Clock), 
						.Reset(					1'b0), 
						.Load(					ROStart),
						.Enable(				Enable), 
						.PIn(					ROLeaf),
						.SIn(					1'b0),
						.SOut(					RO_LeafNextDirection)
					);
					
	assign	ROIBV_Next = ROStart ? GentryVersion : ((ROIBV + !RO_LeafNextDirection) / 2);

	BktIDGen # 	(		.ORAML(		ORAML))
		rw_bid 	(		.Clock(		Clock),
						.ReStart(	ROStart),
						.leaf(		ROLeaf),
						.Enable(	Enable),
						.BktIdx(	ROIBID)
				);
endmodule
//--------------------------------------------------------------------------
