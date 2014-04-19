
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		GentrySeedGenerator
//	Desc:		
//==============================================================================
module GentrySeedGenerator(
  	Clock, Reset,
	
	OutIV, OutBID, 
	OutValid, OutReady
	);
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	
	`include "SecurityLocal.vh"
	// TODO We only need these includes because we need BIDWidth in REWAESLocal.vh
	// Clean up param system to avoid the crazy includes ...
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	
	`include "REWAESLocal.vh"
	
	localparam				RWSWidth =				2,
							ST_RW_StartRead =		2'd0,
							ST_RW_Read =			2'd1,
							ST_RW_StartWrite =		2'd2,
							ST_RW_Write =			2'd3;
							
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	
	//--------------------------------------------------------------------------
	//	Output Interface
	//--------------------------------------------------------------------------

	output	[AESEntropy-1:0] OutIV;
	output	[BIDWidth-1:0] 	OutBID;

	output					OutValid;
	input					OutReady;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 

	reg		[RWSWidth-1:0] 	CS_RW, NS_RW;
	wire					CSRWStartOp, CSRWWrite;
	
	wire					RWPathTransition;
	wire					Transfer;

	wire	[AESEntropy-1:0] GentryCounter, GentryCounterShifted, RWBVOut;

	wire	[ORAML-1:0]		GentryLeaf;
	
	`ifndef ASIC
		initial begin	
			CS_RW = ST_RW_StartRead;
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Logic
	//-------------------------------------------------------------------------- 	
	
	assign	CSRWStartOp =							CS_RW == ST_RW_StartRead | CS_RW == ST_RW_StartWrite;
	assign	CSRWWrite =								CS_RW == ST_RW_Write;
	
	always @(posedge Clock) begin
		if (Reset) CS_RW <= 						ST_RW_StartRead;
		else CS_RW <= 								NS_RW;
	end
	
	always @( * ) begin
		NS_RW = 									CS_RW;
		case (CS_RW)
			ST_RW_StartRead :
					NS_RW =							ST_RW_Read;
			ST_RW_Read : 
				if (RWPathTransition)
					NS_RW =							ST_RW_StartWrite;
			ST_RW_StartWrite : 
					NS_RW =							ST_RW_Write;
			ST_RW_Write : 
				if (RWPathTransition)
					NS_RW =							ST_RW_StartRead;
		endcase
	end
	
	CountAlarm #(			.Threshold(				ORAML + 1))
				rw_lvl_cnt(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				Transfer),
							.Done(					RWPathTransition));
	
	Counter		#(			.Width(					AESEntropy))
				gentry_bg(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				RWPathTransition & CSRWWrite),
							.In(					{AESEntropy{1'bx}}),
							.Count(					GentryCounter));						
							
	// RW seed generation scheme for bucket @ level L (L = 0...):
	//	decrypt( GentryCounter >> L)
	//	encrypt((GentryCounter >> L) + 1)
	ShiftRegister #(		.PWidth(				AESEntropy),
							.Reverse(				1),
							.SWidth(				1))
				gentry_shft(.Clock(					Clock), 
							.Reset(					1'b0), 
							.Load(					CSRWStartOp),
							.Enable(				Transfer), 
							.PIn(					GentryCounter),
							.SIn(					1'b0),
							.POut(					GentryCounterShifted));
	assign	OutIV =									(CSRWWrite) ? GentryCounterShifted + 1 : GentryCounterShifted;
	
	assign	GentryLeaf =							GentryCounter[ORAML-1:0];

	BktIDGen # 	(	.ORAML(		ORAML))
		rw_bid 	(	.Clock(		Clock),
					.ReStart(	CSRWStartOp),
					.leaf(		GentryLeaf),
					.Enable(	Transfer),
					.BktIdx(	OutBID)			
				);

	assign	OutValid = !CSRWStartOp;					
	assign	Transfer = OutValid && OutReady;
	
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
