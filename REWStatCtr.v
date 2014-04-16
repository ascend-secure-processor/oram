//==============================================================================
//	Module:		REWStatCtr
//	Desc:		Keep track of REW status, RW vs. RO, read vs. write back
//==============================================================================
`include "Const.vh"

module REWStatCtr(
	Clock, Reset,
	RW_R_Transfer, RW_W_Transfer, RO_R_Transfer, RO_W_Transfer,
	ROAccess, RWAccess, Read, Writeback,
	RW_R_Ctr, RW_W_Ctr, RO_R_Ctr, RO_W_Ctr,
);

	parameter	ORAME = 0;
	
	// chunks to be transferred at each stage
	parameter	RW_R_Chunk = 0,
				RW_W_Chunk = 0,
				RO_R_Chunk = 0,
				RO_W_Chunk = 0;
							
	input	Clock, Reset;
		
	output 	ROAccess, RWAccess, Read, Writeback;
	
	// count the number of chunks transferred
	input	RW_R_Transfer, RW_W_Transfer, RO_R_Transfer, RO_W_Transfer;
	
	output	[`log2(RW_R_Chunk)-1:0]		RW_R_Ctr;
	output	[`log2(RW_W_Chunk)-1:0]		RW_W_Ctr;
	output	[`log2(RO_R_Chunk)-1:0]		RO_R_Ctr;
	output	[`log2(RO_W_Chunk)-1:0]		RO_W_Ctr;
			
	wire 	RW_R_Done, RW_W_Done, RO_R_Done, RO_W_Done;
	wire	E_RO_Accesses;
		
	CountAlarm #(		.Threshold(				RW_R_Chunk))
		rw_r_ctr (		.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				RW_R_Transfer),
						.Count(					RW_R_Ctr),
						.Done(					RW_R_Done)
			);
			
	CountAlarm #(		.Threshold(				RW_W_Chunk))
		rw_w_ctr (		.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				RW_W_Transfer),
						.Count(					RW_W_Ctr),
						.Done(					RW_W_Done)
			);		
	
	CountAlarm #(		.Threshold(				RO_R_Chunk))
		ro_r_ctr (		.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				RO_R_Transfer),
						.Count(					RO_R_Ctr),
						.Done(					RO_R_Done)
			);
			
	CountAlarm #(		.Threshold(				RO_W_Chunk))
		ro_w_ctr (		.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				RO_W_Transfer),
						.Count(					RO_W_Ctr),
						.Done(					RO_W_Done)
			);		
	
	
	CountAlarm #(		.Threshold(				ORAME))
	oram_e_ctr (		.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				ROAccess && Writeback && RO_W_Done),
						.Done(					E_RO_Accesses)
			);
	
	// State transition based on CountAlarms
	//		0	  1		0		1
	reg 	RW_or_RO,	Read_or_Write;
		
	always @ (posedge Clock) begin
		if (Reset) begin
			RW_or_RO <= 1'b1;
			Read_or_Write <= 1'b0;
		end
		
		// RW_R --> RW_W
		else if (RWAccess && Read && RW_R_Done) begin	
			RW_or_RO <= 1'b0;
			Read_or_Write <= 1'b1;
		end
		
		// RW_W --> RO_R
		else if (RWAccess && Writeback && RW_W_Done) begin
			RW_or_RO <= 1'b1;
			Read_or_Write <= 1'b0;
		end	
		
		// RO_R --> RO_W
		else if (ROAccess && Read && RO_R_Done) begin
			RW_or_RO <= 1'b1;
			Read_or_Write <= 1'b1;
		end	
		
		// RO_W --> E_RO_Accesses ? RW_R : RO_R
		else if (ROAccess && Writeback && RO_W_Done) begin
			RW_or_RO <= E_RO_Accesses ? 1'b0 : 1'b1;
			Read_or_Write <= E_RO_Accesses ? 1'b0 : 1'b0;
		end			
	end
	
	assign RWAccess = !Reset && !RW_or_RO;
	assign ROAccess = !Reset && RW_or_RO;
	
	assign Read = 	!Reset && !Read_or_Write;
	assign Writeback =  !Reset && Read_or_Write;
		
	initial begin
		if ( !(ORAME && RW_R_Chunk && RW_W_Chunk && RO_R_Chunk && RO_W_Chunk) ) begin
			$display("Error: parameter uninitialized.");
			$finish;
		end	
	end
	
endmodule