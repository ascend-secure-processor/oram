//==============================================================================
//	Module:		CCPortArbiter
//	Desc:		Arbitrate the port to path buffer between Dec, Enc, Stash, headers, etc.
//==============================================================================

`include "Const.vh"

module CCPortArbiter (
	Clock, Reset,
	ROAccess, RWAccess, PathRead, PathWriteback,
//	HeaderInValid, HdOfInterest,
	FromDecDataTransfer, FromStashDataTransfer, 
	FromDecData, HeaderDataIn, FromStashData,
	
	BufReg_InValid, BufReg_EmptyCount, PathDone_IV, BOIDone_IV,
	
	Enable, Write, 
	Address,
	DIn,
	
	PthRW_Transition, BlkOnPthCtr, 
	HdOnPthCtr, BktOfI_Transition
);

	parameter 	DWidth = 1,
				ORAML = 1,
				BktSize_DRBursts = 6;
	
	localparam	AWidth = `log2(PathSize_DRBursts * 2 + 2);
	localparam  PathSize_DRBursts = BktSize_DRBursts * (ORAML + 1);
	localparam	PthBSTWidth =	`log2(PathSize_DRBursts);

	`include "IVCCLocal.vh"
	
	input 	Clock, Reset;
	
	input	ROAccess, RWAccess;
	input 	PathRead, PathWriteback;
//	input	HeaderInValid, HdOfInterest;
	input 	FromDecDataTransfer, FromStashDataTransfer;
	input	[1:0] BufReg_EmptyCount;
	input	PathDone_IV, BOIDone_IV;
	
	input	[DWidth-1:0]	FromDecData, HeaderDataIn, FromStashData;
		
	output 					Enable, Write;
	output 	[AWidth-1:0] 	Address;
	output 	[DWidth-1:0] 	DIn;
	
	output BufReg_InValid; 
	
	output  PthRW_Transition;
	output [PthBSTWidth-1:0]	BlkOnPthCtr;
	output [`log2(ORAML+1)-1:0] HdOnPthCtr;
	output BktOfI_Transition;
	
	reg  PthRW, HdRW;
	wire PthCtrEnable, HdCtrEnable;
	wire BufReg_InValid_Pre;
	wire HdRW_Transition, BktOfInterest;	
	wire [`log2(BktSize_DRBursts)-1:0]	BktOfInterestCtr;
	
	Register #(	.Width(1))
		to_enc_valid ( Clock, Reset, 1'b0, 1'b1, 	BufReg_InValid_Pre,	BufReg_InValid);
	
	assign BufReg_InValid_Pre = Enable && !Write;	// TODO: is there any case read but not for AES
	
	assign PthCtrEnable = RWAccess && Enable;
	CountAlarm #(		.Threshold(				PathSize_DRBursts))
		blk_ctr (		.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				PthCtrEnable),
						.Count(					BlkOnPthCtr),
						.Done(					PthRW_Transition)
				);
	
	assign HdCtrEnable = ROAccess && Enable && !BktOfInterest;
	CountAlarm #(		.Threshold(				ORAML + 1))
		hd_ctr (		.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				HdCtrEnable),
						.Count(					HdOnPthCtr),
						.Done(					HdRW_Transition)
				);
	
	CountAlarm #(		.Threshold(				BktSize_DRBursts))
		bkt_of_i_ctr (	.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				FromDecDataTransfer && BktOfInterest),
						.Count(					BktOfInterestCtr),
						.Done(					BktOfI_Transition)
			);

	assign BktOfInterest = ROAccess && PathRead && !HdRW;
	
	// 1 means read from DRAM,  write to buffer; 0 means write to DRAM, read from buffer
	always @(posedge Clock) begin
		if (Reset) begin
			PthRW <= 1'b1;
			HdRW <= 1'b1;
		end
		else begin 
			if (RWAccess && PathWriteback && PthRW_Transition) 
				PthRW = !PthRW;				
			else if (ROAccess && HdRW_Transition) 
				HdRW <= !HdRW;			
		end
	end
		
	assign Enable = RWAccess ? 
								(	PathRead ? FromDecDataTransfer
									: PthRW ? FromStashDataTransfer 
											: PathDone_IV && BufReg_EmptyCount > BufReg_InValid)			// Send data to AES							
					: ROAccess ? 
								(	PathRead ? FromDecDataTransfer 									// header and BktOfI from Dec
									: !HdRW && BOIDone_IV && BufReg_EmptyCount > BufReg_InValid)		// Send headers to AES
					: 0;							
		
	assign Write = 	RWAccess ? 	(	PathRead ? 1'b1 : PthRW )
					: ROAccess ? (	PathRead ? 1'b1 : HdRW )
					: 0;
					
	assign Address = RWAccess ?  (	PathRead ? IPthStartAddr + BlkOnPthCtr : OPthStartAddr + BlkOnPthCtr )
					: ROAccess ? (	PathRead ? 
										(	BktOfInterest ? OBktOfIStartAddr + BktOfInterestCtr	// payload of interest										     										  																								 		
											: HdStartAddr + HdOnPthCtr)		// save header										
									: HdStartAddr + HdOnPthCtr)				// header write back								
					: 0;
							
	assign DIn = 	RWAccess ? 	(	PathRead ? FromDecData : FromStashData)							
					: ROAccess ? 	(	BktOfInterest ? FromDecData : HeaderDataIn) 
					: 0;	
							
endmodule
							