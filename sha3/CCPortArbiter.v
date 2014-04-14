//==============================================================================
//	Module:		CCPortArbiter
//	Desc:		Arbitrate the port to path buffer between Dec, Enc, Stash, headers, etc.
//==============================================================================

`include "Const.vh"

module CCPortArbiter (
	Clock, Reset,
	ROAccess, RWAccess, CSPathRead, CSPathWriteback,
	HeaderInValid, HdOfInterest,
	FromDecDataTransfer, FromStashDataTransfer, 
	FromDecData, HeaderDataIn, FromStashData,
	
	BufReg_InValid, BufReg_EmptyCount, IVDone, IVDone_BktOfI,
	
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
	input 	CSPathRead, CSPathWriteback;
	input	HeaderInValid, HdOfInterest;
	input 	FromDecDataTransfer, FromStashDataTransfer;
	input	[1:0] BufReg_EmptyCount;
	input	IVDone, IVDone_BktOfI;
	
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
	
	assign HdCtrEnable = ROAccess && Enable;
	CountAlarm #(		.Threshold(				ORAML + 1))
		hd_ctr (		.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				HdCtrEnable),
						.Count(					HdOnPthCtr),
						.Done(					HdRW_Transition)
				);
/*	
	Register #(.Width(1))
		bkt_of_interest (Clock, Reset || BktOfI_Transition, FromDecDataTransfer && HdOfInterest, 1'b0, 1'bx, BktOfInterest);
*/	
	CountAlarm #(		.Threshold(				BktSize_DRBursts))
		bkt_of_i_ctr (	.Clock(					Clock), 
						.Reset(					Reset), 
						.Enable(				FromDecDataTransfer && BktOfInterest),
						.Count(					BktOfInterestCtr),
						.Done(					BktOfI_Transition)
			);

	assign BktOfInterest = ROAccess && CSPathRead && !HdRW;
	
	// 1 means read from DRAM, write to buffer; 0 means write to DRAM and read from buffer
	always @(posedge Clock) begin
		if (Reset) begin
			PthRW <= 1'b1;
			HdRW <= 1'b1;
		end
		else begin 
			if (RWAccess && CSPathWriteback && PthRW_Transition) 
				PthRW = !PthRW;				
			else if (ROAccess && HdRW_Transition) 
				HdRW <= !HdRW;			
		end
	end
		
	assign Enable = RWAccess ? 
								(	CSPathRead ? FromDecDataTransfer
									: PthRW ? FromStashDataTransfer 
									: !PthRW && IVDone && BufReg_EmptyCount > BufReg_InValid)			// Send data to AES							
					: ROAccess ? 
								(	CSPathRead ? HeaderInValid 								// header from Dec
									: !HdRW && IVDone_BktOfI && BufReg_EmptyCount > BufReg_InValid)			// Send headers to AES
					: 0;							
		
	assign Write = 	RWAccess ? 	(	CSPathRead ? 1'b1 : PthRW )
					: ROAccess ? (	CSPathRead ? 1'b1 : HdRW )
					: 0;
					
	assign Address = RWAccess ?  (	CSPathRead ? IPthStartAddr + BlkOnPthCtr : OPthStartAddr + BlkOnPthCtr )
					: ROAccess ? (	CSPathRead ? 
										(	BktOfInterest ? OBktOfIStartAddr + BktOfInterestCtr	// payload of interest										     										  																								 		
											: HdStartAddr + HdOnPthCtr)	// save header										
									: HdStartAddr + HdOnPthCtr)			// header write back								
					: 0;
							
	assign DIn = 	RWAccess ? 	(	CSPathRead ? FromDecData : FromStashData)							
					: ROAccess ? 	(	HeaderDataIn) 
					: 0;	
							
endmodule
							