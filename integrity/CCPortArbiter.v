//==============================================================================
//	Module:		CCPortArbiter
//	Desc:		Arbitrate the port to path buffer between Dec, Enc, Stash, headers, etc.
//==============================================================================

`include "Const.vh"

module CCPortArbiter (
	Clock, Reset,
	ROAccess, RWAccess, PathRead, PathWriteback,

	FromDecDataTransfer, FromStashDataTransfer, 
	FromDecData, HeaderDataIn, FromStashData,
	
	BufReg_EmptyCount, PathDone_IV, BOIDone_IV,
	
	Enable, Write, 
	Address,
	DIn,
	
	BlkOnPthCtr, 
	HdOnPthCtr
	
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

	input 	FromDecDataTransfer, FromStashDataTransfer;
	input	[1:0] BufReg_EmptyCount;
	input	PathDone_IV, BOIDone_IV;
	
	input	[DWidth-1:0]	FromDecData, HeaderDataIn, FromStashData;
		
	output 					Enable, Write;
	output 	[AWidth-1:0] 	Address;
	output 	[DWidth-1:0] 	DIn;
	
	output [PthBSTWidth-1:0]	BlkOnPthCtr;
	output [`log2(ORAML+1)-1:0] HdOnPthCtr;
	
	reg  PthRW, HdRW;
	wire PthCtrEnable, HdCtrEnable;
	wire HdRW_Transition, BktOfInterest;	
	wire [`log2(BktSize_DRBursts)-1:0]	BktOfInterestCtr;
	
	
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
						.Count(					BktOfInterestCtr)
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
											: PathDone_IV && BufReg_EmptyCount > 1)			// Send data to AES							
					: ROAccess ? 
								(	PathRead ? FromDecDataTransfer 						// header and BktOfI from Dec
									: !HdRW && BOIDone_IV && BufReg_EmptyCount > 1)		// Send headers to AES
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


/*
	wire 	ROAccess, RWAccess, PathRead, PathWriteback;
	localparam  ORAME = 5;
	localparam	RW_R_Chunk = PathSize_DRBursts,
				RW_W_Chunk = PathSize_DRBursts,
				RO_R_Chunk = (ORAML+1) * 1 + BktSize_DRBursts,
				RO_W_Chunk = (ORAML+1) * 1;
	
	wire	[`log2(RW_R_Chunk)-1:0]		RW_R_Ctr;
	wire	[`log2(RW_W_Chunk)-1:0]		RW_W_Ctr;
	wire	[`log2(RO_R_Chunk)-1:0]		RO_R_Ctr;
	wire	[`log2(RO_W_Chunk)-1:0]		RO_W_Ctr;
	
	REWStatCtr	#(			.ORAME(					ORAME),
							.RW_R_Chunk(			RW_R_Chunk),
							.RW_W_Chunk(			RW_W_Chunk),
							.RO_R_Chunk(			RO_R_Chunk),
							.RO_W_Chunk(			RO_W_Chunk))
							
		cc_buf_addr		(	.Clock(					Clock),
							.Reset(					Reset),
							
							.RW_R_Transfer(			RWAccess && PathRead && Enable),
							.RW_W_Transfer(			RWAccess && PathWriteback && Enable),
							.RO_R_Transfer(			ROAccess && PathRead && Enable),
							.RO_W_Transfer(			ROAccess && PathWriteback && Enable),
											
							.RW_R_Ctr(				RW_R_Ctr),
							.RW_W_Ctr(				RW_W_Ctr),
							.RO_R_Ctr(				RO_R_Ctr),
							.RO_W_Ctr(				RO_W_Ctr)													
						);
*/
							