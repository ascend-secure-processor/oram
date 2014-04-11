//==============================================================================
//	Module:		CCPortArbiter
//	Desc:		Arbitrate the port to path buffer between Dec, Enc, Stash, headers, etc.
//==============================================================================

`include "Const.vh"

module CCPortArbiter (
	Clock, Reset,
	ROAccess, RWAccess, CSPathRead, CSPathWriteback,
	FromDecDataTransfer, FromStashDataTransfer, 
	BufReg_InValid, BufReg_EmptyCount,
	FromDecData, FromStashData,
	
	Enable, Write, 
	Address,
	DIn,
	
	OPathRW_Transition, BlkOnPthCtr
);

	parameter 	DWidth = 1,
				PathSize_DRBursts = 6;
	
	localparam	AWidth = `log2(PathSize_DRBursts * 2 + 2);
	localparam	PthBSTWidth =	`log2(PathSize_DRBursts);

	input 	Clock, Reset;
	
	input	ROAccess, RWAccess;//, DRAMInitComplete;
	input 	CSPathRead, CSPathWriteback;
	input	FromDecDataTransfer, FromStashDataTransfer;
	input	[1:0] BufReg_EmptyCount;
	
	input	[DWidth-1:0]	FromDecData, FromStashData;
	
	
	output 					Enable, Write;
	output 	[AWidth-1:0] 	Address;
	output 	[DWidth-1:0] 	DIn;
	
	output BufReg_InValid; 
	
	output  OPathRW_Transition;
	output [PthBSTWidth-1:0]	BlkOnPthCtr;
	
	reg  OPathRW;
	wire Transfer;
	
	
	Register #(	.Width(1))
			to_enc_valid ( Clock, Reset, 1'b0, 1'b1, 	Transfer && !OPathRW,	BufReg_InValid);
		
	//assign Transfer = RWAccess && CSPathWriteback && (OPathRW ? FromStashDataTransfer : BufP1_Enable);
	assign Transfer = RWAccess && Enable;
	
	
	CountAlarm #(		.Threshold(				PathSize_DRBursts))
	out_blk_ctr (		.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				Transfer),
						.Count(					BlkOnPthCtr),
						.Done(					OPathRW_Transition)
				);
	
	always @(posedge Clock) begin
		if (Reset)
			OPathRW <= 1;
		else if (CSPathWriteback && OPathRW_Transition)
			OPathRW = !OPathRW;
	end
	
	assign Enable = RWAccess ? 
								(	CSPathRead ? FromDecDataTransfer : 
									OPathRW ? FromStashDataTransfer : 
									BufReg_EmptyCount > BufReg_InValid)	// Dump data to AES for encryption								
								: ROAccess ? 0 : 0;							
													
	assign Write = RWAccess ? 	(	CSPathRead ? 1'b1 : OPathRW )
							: ROAccess ? 0 : 0;

	assign Address = RWAccess ? 	(	CSPathRead ? BlkOnPthCtr : BlkOnPthCtr + PathSize_DRBursts )
							: ROAccess ? 0 : 0;
							
	assign DIn = RWAccess ? 	
							(	CSPathRead ? FromDecData : FromStashData)
							: ROAccess ? 0 : 0;	
							
endmodule
							