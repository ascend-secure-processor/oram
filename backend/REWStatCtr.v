//==============================================================================
//	Module:		REWStatCtr
//	Desc:		Keep track of REW status, RW vs. RO, read vs. write back
//==============================================================================
`include "Const.vh"

module REWStatCtr(
	Clock, Reset,
	RW_R_Transfer, RW_W_Transfer, RO_R_Transfer, RO_W_Transfer,
	
	RW_R_DoneAlarm, RW_W_DoneAlarm, RO_R_DoneAlarm, RO_W_DoneAlarm,
	
	ROAccess, RWAccess, Read, Writeback,
	RW_R_Ctr, RW_W_Ctr, RO_R_Ctr, RO_W_Ctr
	);

	parameter	USE_REW = 1;
	parameter	ORAME = -1;
	
	// Most of these alarms aren't performance critical, so we can delay them by 1 (helps timing)
	parameter	LatchOutput = 1; 
	
	// whether we allow two phases to make progress simultaneously 
	parameter	Overlap = 0;
	
	// As it says
	parameter	DelayedWB = 0;
	
	// chunks to be transferred at each stage
	parameter	RW_R_Chunk = 0,
				RW_W_Chunk = 0,
				RO_R_Chunk = 0,
				RO_W_Chunk = 0;
	
	localparam	ROWWidth = (RO_W_Chunk > 0) ? `log2(RO_W_Chunk) : 0,
				RWWWidth = (RW_W_Chunk > 0) ? `log2(RW_W_Chunk) : 0;
	
	`ifdef SIMULATION
		initial begin
			if (ORAME == -1) begin
				$display("Error: illegal parameter setting.");
				$finish;
			end
		
			if ( !(ORAME && RW_R_Chunk > 1 && RO_R_Chunk > 1) ) begin
				// TODO: CountAlarm cannot handle chunk <= 1
				$display("Error: parameter uninitialized or unsupported.");
				$finish;
			end
		end
	`endif	
	
	input	Clock, Reset;		
	output 	ROAccess, RWAccess, Read, Writeback;
	output	RW_R_DoneAlarm, RW_W_DoneAlarm, RO_R_DoneAlarm, RO_W_DoneAlarm;
	input	RW_R_Transfer, RW_W_Transfer, RO_R_Transfer, RO_W_Transfer;
	
	output	[`log2(RW_R_Chunk)-1:0]		RW_R_Ctr;
	output	[RWWWidth-1:0]				RW_W_Ctr;
	output	[`log2(RO_R_Chunk)-1:0]		RO_R_Ctr;
	output	[ROWWidth-1:0]				RO_W_Ctr;
	
	
	// count the number of chunks transferred
	wire	RW_R_Enable, RW_W_Enable, RO_R_Enable, RO_W_Enable;	
	assign	RW_R_Enable = Overlap ? RW_R_Transfer : RWAccess && Read 		&& RW_R_Transfer;
	assign	RW_W_Enable = Overlap ? RW_W_Transfer : RWAccess && Writeback 	&& RW_W_Transfer;
	assign	RO_R_Enable = Overlap ? RO_R_Transfer : ROAccess && Read 		&& RO_R_Transfer;
	assign	RO_W_Enable = Overlap ? RO_W_Transfer : ROAccess && Writeback 	&& RO_W_Transfer;
				
	wire 	RW_R_Done, RW_W_Done, RO_R_Done, RO_W_Done;
	wire	E_RO_Accesses;
		
	CountAlarm #(		.Threshold(				RW_R_Chunk))
		rw_r_ctr (		.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				RW_R_Enable),
						.Count(					RW_R_Ctr),
						.Done(					RW_R_Done)
			);	
	
	CountAlarm #(		.Threshold(				RO_R_Chunk))
		ro_r_ctr (		.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				RO_R_Enable),
						.Count(					RO_R_Ctr),
						.Done(					RO_R_Done)
			);
			
	generate if (ROWWidth > 0) begin:CNT_RO
		CountAlarm #(	.Threshold(				RO_W_Chunk))
			ro_w_ctr (	.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				RO_W_Enable),
						.Count(					RO_W_Ctr),
						.Done(					RO_W_Done));		
	end else begin:PASS_RO
		assign	RO_W_Ctr =						0;
		assign	RO_W_Done =						1'b1;
	end endgenerate
	
	generate if (RWWWidth > 0) begin:CNT_RW
		CountAlarm #(	.Threshold(				RW_W_Chunk))
			rw_w_ctr (	.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				RW_W_Enable),
						.Count(					RW_W_Ctr),
						.Done(					RW_W_Done));		
	end else begin:PASS_RW
		assign	RW_W_Ctr =						0;
		assign	RW_W_Done =						1'b1;
	end endgenerate	
	
	CountAlarm #(		.Threshold(				ORAME))
		oram_e_ctr (	.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				ROAccess && Writeback && RO_W_Done),
						.Done(					E_RO_Accesses)
					);
	
	// State transition based on CountAlarms
	//		0	  1		0		1
	reg 	RW_or_RO,	
			Read_or_Write;
	reg 	Reset_Post,
			RW_or_RO_Post,
			Read_or_Write_Post;
		
	localparam	rw_access = 0,
				ro_access = 1,
				path_read = 0,
				path_writeback = 1;
		
	task	State_Trans;
		input	rw_or_ro, read_or_write;	
		begin
			RW_or_RO <= rw_or_ro;	
			Read_or_Write <= read_or_write;
		end	
	endtask
	
	task Task_Init; 
		State_Trans(rw_access, path_read);	// Start from RW_R
    endtask
	
	`ifdef FPGA
		initial begin
			Task_Init;
			Reset_Post = 1'b1;
		end
	`endif	
	
	generate if (LatchOutput) begin:LATCH
		Register #(		.Width(					4))
				latch(	.Clock(					Clock),
						.Reset(					Reset),						
						.Set(					1'b0),
						.Enable(				1'b1),
						.In(					{RW_R_Done, 		RW_W_Done, 		RO_R_Done, 		RO_W_Done}),
						.Out(					{RW_R_DoneAlarm, 	RW_W_DoneAlarm, RO_R_DoneAlarm, RO_W_DoneAlarm}));
						
		always @(posedge Clock) begin
			RW_or_RO_Post <=					RW_or_RO;
			Read_or_Write_Post <=				Read_or_Write;
			Reset_Post <=						Reset;
		end
	end else begin:PASS
		assign	{RW_R_DoneAlarm, RW_W_DoneAlarm, RO_R_DoneAlarm, RO_W_DoneAlarm} = {RW_R_Done, RW_W_Done, RO_R_Done, RO_W_Done};
		
		always @( * ) begin
			RW_or_RO_Post =						RW_or_RO;
			Read_or_Write_Post =				Read_or_Write;
			Reset_Post =						Reset;
		end		
	end endgenerate
		
	always @ (posedge Clock) begin
		if (Reset) begin
			Task_Init;
		end
		
		// RW_R -->	RW_W / RW_W
		else if (RWAccess && Read && RW_R_Done) begin
			if (USE_REW) begin
				if (DelayedWB)
					State_Trans(ro_access, path_read);
				else
					State_Trans(rw_access, path_writeback);
			end
			else 
				State_Trans(rw_access, path_writeback);
		end
		
		// RW_W --> RO_R
		else if (RWAccess && Writeback && RW_W_Done) begin
			if (USE_REW) begin
				if (DelayedWB)
					State_Trans(rw_access, path_read);
				else
					State_Trans(ro_access, path_read);
			end
			else 
				State_Trans(rw_access, path_read);
		end	
		
		// RO_R --> RO_W
		else if (ROAccess && Read && RO_R_Done) begin
			State_Trans(ro_access, path_writeback);
		end	
		
		// RO_W --> E_RO_Accesses ? RW_R : RO_R
		else if (ROAccess && Writeback && RO_W_Done) begin
			if (E_RO_Accesses)
				if (DelayedWB)
					State_Trans(rw_access, path_writeback);
				else
					State_Trans(rw_access, path_read);
			else
				State_Trans(ro_access, path_read);
		end
	end
	
	assign RWAccess = 	!Reset_Post && !RW_or_RO_Post;
	assign ROAccess = 	!Reset_Post && RW_or_RO_Post;
	
	assign Read = 		!Reset_Post && !Read_or_Write_Post;
	assign Writeback =  !Reset_Post && Read_or_Write_Post;
	
endmodule
