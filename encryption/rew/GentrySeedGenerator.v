
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

	localparam				BIDWidth = ORAML + 1;

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
	wire					RWPathTransition;
	wire					Transfer;

	wire	[AESEntropy-1:0] GentryCounter, GentryCounterShifted, GentryCounterIn;

	wire	[ORAML-1:0]		GentryLeaf;

	//--------------------------------------------------------------------------
	//	Logic
	//--------------------------------------------------------------------------

	reg CSRWWrite, CSStartOp;

	`ifdef FPGA
		initial begin
			CSStartOp <= 1;
			CSRWWrite <= 0;	// read first
		end
	`endif

	always @(posedge Clock) begin
		if (Reset) begin
			CSStartOp <= 1;
			CSRWWrite <= 0;	// read first
		end
		else begin
			if (CSStartOp)
				CSStartOp <= 0;
			if (RWPathTransition)
				CSRWWrite <= ~CSRWWrite;
		end
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
							.Load(					RWPathTransition || CSStartOp),
							.Enable(				Transfer),
							.PIn(					GentryCounterIn),
							.SIn(					1'b0),
							.POut(					GentryCounterShifted));

	assign  GentryCounterIn = 						GentryCounter + (RWPathTransition & CSRWWrite);

	assign	OutIV =									GentryCounterShifted + CSRWWrite;

	assign	GentryLeaf =							GentryCounterIn[ORAML-1:0];

	BktIDGen 	#(			.ORAML(					ORAML))
				rw_bid(		.Clock(					Clock),
							.ReStart(				CSStartOp || RWPathTransition),
							.leaf(					GentryLeaf),
							.Enable(				Transfer),
							.BktIdx(				OutBID));

	assign	OutValid = !CSStartOp;
	assign	Transfer = OutValid && OutReady;

	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
