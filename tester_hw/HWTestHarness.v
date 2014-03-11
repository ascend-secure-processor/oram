
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		HWTestHarness
//	Desc:		Connect PathORAMTop directly to a software routine, running on a 
//				host machine, which can send address requests directly to 
//				PathORAMTop
//
//==============================================================================
module HWTestHarness #(		`include "PathORAM.vh",

	parameter				SlowClockFreq =			100_000_000,
							Buffering =				1024 // the number of cache lines that can be buffered before the first is sent
	) (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
	
  	input 					SlowClock, FastClock,
	input					SlowReset, FastReset,

	//--------------------------------------------------------------------------
	//	CUT (ORAM) interface
	//--------------------------------------------------------------------------

	output	[BECMDWidth-1:0] ORAMCommand,
	output	[ORAMU-1:0]		ORAMPAddr,
	output					ORAMCommandValid,
	input					ORAMCommandReady,
	
	output	[FEDWidth-1:0]	ORAMDataIn,
	output					ORAMDataInValid,
	input					ORAMDataInReady,
	
	input	[FEDWidth-1:0]	ORAMDataOut,
	input					ORAMDataOutValid,
	output					ORAMDataOutReady,
	
	//--------------------------------------------------------------------------
	//	HW<->SW interface
	//--------------------------------------------------------------------------

	input					UARTRX,
	output					UARTTX,
	
	//--------------------------------------------------------------------------
	//	Status interface
	//--------------------------------------------------------------------------
	
	output					ErrorReceivePattern
	);

	//--------------------------------------------------------------------------
	//	Constants
	//-------------------------------------------------------------------------- 
		
	`include "PathORAMBackendLocal.vh"
	`include "TestHarnessLocal.vh"
	
	localparam				BlkSize_DBaseChunks = 	ORAMB / DBaseWidth;
	localparam				BlkDBaseWidth =			`log2(BlkSize_DBaseChunks);	
	
	//------------------------------------------------------------------------------
	// 	Wires & Regs
	//------------------------------------------------------------------------------
	
	// Receive pipeline
	
	// UART
	
	(* mark_debug = "TRUE" *)	wire	[UARTWidth-1:0]	UARTDataIn;
	(* mark_debug = "TRUE" *)	wire				UARTDataInValid, UARTDataInReady;

	(* mark_debug = "TRUE" *)	wire	[UARTWidth-1:0] UARTDataOut;
	(* mark_debug = "TRUE" *)	wire				UARTDataOutValid, UARTDataOutReady;
	
	// Send pipeline
	
	(* mark_debug = "TRUE" *)	wire	[THPWidth-1:0] CrossBufIn_DataIn;
	(* mark_debug = "TRUE" *)	wire	[THPWidth-1:0] CrossBufIn_DataOut;
	(* mark_debug = "TRUE" *)	wire				CrossBufIn_DataInValid, CrossBufIn_DataInReady;	
	
	(* mark_debug = "TRUE" *)	wire				CrossBufIn_Full, CrossBufIn_Empty;
	(* mark_debug = "TRUE" *)	wire				CrossBufIn_DataOutReady;
	
	(* mark_debug = "TRUE" *)	wire	[TCMDWidth-1:0]	SlowCommand, FastCommand;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]	FastPAddr;
	(* mark_debug = "TRUE" *)	wire	[DBaseWidth-1:0] FastDataBase;
	(* mark_debug = "TRUE" *)	wire	[TimeWidth-1:0]	FastTimeDelay;
	
	(* mark_debug = "TRUE" *)	wire				TimeGate;
	(* mark_debug = "TRUE" *)	wire	[TimeWidth-1:0]	PacketAge;
	
	(* mark_debug = "TRUE" *)	wire				StartGate, SlowStartSignal;
	(* mark_debug = "TRUE" *)	wire				FastStartSignal;
	(* mark_debug = "TRUE" *)	wire				FastStartSignal_Pre, StarCrossEmpty;
		
	(* mark_debug = "TRUE" *)	wire				BurstComplete;
	(* mark_debug = "TRUE" *)	wire				ORAMRegInValid, ORAMRegInReady;
	(* mark_debug = "TRUE" *)	wire				ORAMRegOutValid, ORAMRegOutReady;
	
	(* mark_debug = "TRUE" *)	wire				ORAMCommandTransfer;	
	
	(* mark_debug = "TRUE" *)	wire	[DBaseWidth-1:0] ORAMDataBase;
	(* mark_debug = "TRUE" *)	wire	[TimeWidth-1:0]	ORAMTimeDelay;
	
	(* mark_debug = "TRUE" *)	wire				WriteCommandValid;
	(* mark_debug = "TRUE" *)	wire				ORAMDataSendValid, ORAMDataSendReady;
	(* mark_debug = "TRUE" *)	wire				WriteGate_Pre, WriteGate;
	
	(* mark_debug = "TRUE" *)	wire				SendBlockComplete;
	(* mark_debug = "TRUE" *)	wire	[BlkDBaseWidth-1:0] SendChunkID;
		
	//------------------------------------------------------------------------------
	// 	[Receive path] Shifts & buffers
	//------------------------------------------------------------------------------	
	
	// This requires that UARTWidth <= DBaseWidth <= FEDWidth
	
	/*
	DataOutCheck
	DataOutCheckValid
	
	CrossBufOut_DataIn
	CrossBufOut_DataInValid
	CrossBufOut_DataInReady
	CrossBufOut_Full	
	
	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				UARTWidth))
				O_fast_shft(.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				ORAMDataOut),
							.InValid(				ORAMDataOutValid),
							.InAccept(				ORAMDataOutReady),
							.OutData(				CrossBufOut_DataIn),
							.OutValid(				CrossBufOut_DataInValid),
							.OutReady(				CrossBufOut_DataInReady));
	
	assign	CrossBufOut_DataInReady =				~CrossBufOut_Full;
	
	// Clock crossing; we should never have to change the depth of this module
	RAMB18Crossing	O_cross(.rst(					FastReset), 
							.wr_clk(				FastClock), 
							.rd_clk(				SlowClock), 
							.din(					CrossBufOut_DataIn), 
							.wr_en(					CrossBufOut_DataInValid), 
							.full(					CrossBufOut_Full), 
							.rd_en(					UARTDataIn), 
							.dout(					UARTDataInValid), 
							.valid(					UARTDataInReady));

	*/						
							
	//------------------------------------------------------------------------------
	// 	[Receive path] Data checker
	//------------------------------------------------------------------------------	

	/*
	
							MismatchReceivePattern
							
							DataOutCheck_Base
							DataOutCheck_BaseValid
							
							ReceiveChunkID
							ReceiveBlockComplete
							
							ReceiveBlockComplete_Pre 
							
	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				DBaseWidth))
				O_db_shft(	.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				ORAMDataOut),
							.InValid(				ORAMDataOutValid & ORAMDataOutReady),
							.InAccept(				),
							.OutData(				DataOutCheck),
							.OutValid(				DataOutCheckValid),
							.OutReady(				1'b1));
	Counter		#(			.Width(					BlkDBaseWidth))
				O_chnk_cnt(	.Clock(					FastClock),
							.Reset(					FastReset | ReceiveBlockComplete)),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DataOutCheckValid),
							.In(					{{1'bx}}),
							.Count(					ReceiveChunkID));
	CountCompare #(			.Width(					BlkDBaseWidth),
							.Compare(				BlkSize_DBaseChunks - 1))
				O_chnk_term(.Count(					ReceiveChunkID), 
							.TerminalCount(			ReceiveBlockComplete_Pre));
	assign	ReceiveBlockComplete = 					ReceiveBlockComplete_Pre & DataOutCheckValid;
	
	FIFORegister #(			.Width(					DBaseWidth))
				base_reg(	.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				DataOutCheck),
							.InValid(				(ReceiveChunkID == 0) & DataOutCheckValid),
							.InAccept(				),
							.OutData(				DataOutCheck_Base),
							.OutSend(				DataOutCheck_BaseValid),
							.OutReady(				ReceiveBlockComplete));			
	
	assign	MismatchReceivePattern =				(DataOutCheck_Base != (DataOutCheck + ReceiveChunkID)) & 
													DataOutCheckValid & DataOutCheck_BaseValid; 
	
	Register	#(			.Width(					1))
				error(		.Clock(					FastClock),
							.Reset(					FastReset),
							.Set(					MismatchReceivePattern),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ErrorReceivePattern));	
	
	*/
	
	//------------------------------------------------------------------------------
	// 	HW<->SW Bridge (UART)
	//------------------------------------------------------------------------------	
	
	UART		#(			.ClockFreq(				SlowClockFreq),
							.Baud(					UARTBaud),
							.Width(					UARTWidth))
				uart(		.Clock(					SlowClock), 
							.Reset(					SlowReset), 
							.DataIn(				UARTDataIn), 
							.DataInValid(			UARTDataInValid), 
							.DataInReady(			UARTDataInReady), 
							.DataOut(				UARTDataOut), 
							.DataOutValid(			UARTDataOutValid), 
							.DataOutReady(			UARTDataOutReady), 
							.SIn(					UARTRX), 
							.SOut(					UARTTX));
						
	//------------------------------------------------------------------------------
	// 	[Send path] Clock crossing
	//------------------------------------------------------------------------------
						
	FIFOShiftRound #(		.IWidth(				UARTWidth),
							.OWidth(				THPWidth),
							.Reverse(				1))
				tst_shift(	.Clock(					SlowClock),
							.Reset(					SlowReset),
							.InData(				UARTDataOut),
							.InValid(				UARTDataOutValid),
							.InAccept(				UARTDataOutReady),
							.OutData(				CrossBufIn_DataIn),
							.OutValid(				CrossBufIn_DataInValid),
							.OutReady(				CrossBufIn_DataInReady));

	assign	SlowCommand =							CrossBufIn_DataIn[THPWidth-1:THPWidth-TCMDWidth];
	assign	SlowStartSignal =						SlowCommand == TCMD_Start;
	
	assign	CrossBufIn_DataInReady =				~CrossBufIn_Full;

	CmdCross start_cross(	.rst(					SlowReset),
							.wr_clk(				SlowClock),
							.rd_clk(				FastClock),
							.din(					SlowStartSignal),
							.full(					),
							.wr_en(					CrossBufIn_DataInValid & CrossBufIn_DataInReady),
							.dout(					FastStartSignal_Pre),
							.empty(					StarCrossEmpty),
							.rd_en(					1'b1));	
	assign	FastStartSignal =						FastStartSignal_Pre & ~StarCrossEmpty;
	
	// 1024x104b FIFO
	HWTestBuffer tst_fifo(	.rst(					SlowReset),
							.wr_clk(				SlowClock),
							.rd_clk(				FastClock),
							.din(					CrossBufIn_DataIn),
							.full(					CrossBufIn_Full),
							.wr_en(					CrossBufIn_DataInValid),
							.dout(					CrossBufIn_DataOut),
							.empty(					CrossBufIn_Empty),
							.rd_en(					CrossBufIn_DataOutReady));

	assign	{FastCommand, FastPAddr, FastDataBase, FastTimeDelay} =	CrossBufIn_DataOut;
	assign	ORAMRegInValid =						StartGate & ~CrossBufIn_Empty & FastCommand != TCMD_Start;
	assign	CrossBufIn_DataOutReady =				StartGate & ORAMRegInReady;
	
	//------------------------------------------------------------------------------
	// 	[Send path] Start command gating
	//------------------------------------------------------------------------------

	assign	BurstComplete =							StartGate & CrossBufIn_Empty;
	
	Register	#(			.Width(					1))
				start_reg(	.Clock(					FastClock),
							.Reset(					FastReset | BurstComplete),
							.Set(					FastStartSignal),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					StartGate));
							
	FIFORegister #(			.Width(					BECMDWidth + ORAMU + DBaseWidth + TimeWidth))
				oram_freg(	.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				{FastCommand[BECMDWidth-1:0], 	FastPAddr, FastDataBase, FastTimeDelay}),
							.InValid(				ORAMRegInValid),
							.InAccept(				ORAMRegInReady),
							.OutData(				{ORAMCommand, 					ORAMPAddr, ORAMDataBase, ORAMTimeDelay}),
							.OutSend(				ORAMRegOutValid),
							.OutReady(				ORAMRegOutReady));

	//------------------------------------------------------------------------------
	// 	[Send path] Data generation & write gating
	//------------------------------------------------------------------------------		

	assign	WriteCommandValid =						ORAMRegOutValid & ((ORAMCommand == BECMD_Update) | (ORAMCommand == BECMD_Append));
	
	Register	#(			.Width(					1))
				I_data_done(.Clock(					FastClock),
							.Reset(					FastReset | ORAMCommandTransfer),
							.Set(					SendBlockComplete),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					WriteGate_Pre));
							
	assign	WriteGate =								WriteGate_Pre == WriteCommandValid;
							
	// Just write i, i + 1, i + 2, ... in the cache line
	Counter		#(			.Width(					BlkDBaseWidth))
				I_chnk_cnt(	.Clock(					FastClock),
							.Reset(					FastReset | ORAMCommandTransfer),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				WriteCommandValid & ORAMDataSendValid & ORAMDataSendReady),
							.In(					{{1'bx}}),
							.Count(					SendChunkID));
	CountCompare #(			.Width(					BlkDBaseWidth),
							.Compare(				BlkSize_DBaseChunks - 1))
				I_chnk_term(.Count(					SendChunkID), 
							.TerminalCount(			SendBlockComplete_Pre));

	assign	SendBlockComplete = 					SendBlockComplete_Pre & WriteCommandValid & ORAMDataSendReady;		
	assign	ORAMDataSendValid = 					WriteCommandValid & ~WriteGate_Pre;
		
	FIFOShiftRound #(		.IWidth(				DBaseWidth),
							.OWidth(				FEDWidth))
				I_dta_shft(	.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				ORAMDataBase + SendChunkID),
							.InValid(				ORAMDataSendValid),
							.InAccept(				ORAMDataSendReady),
							.OutData(				ORAMDataIn),
							.OutValid(				ORAMDataInValid),
							.OutReady(				ORAMDataInReady));
							
	//------------------------------------------------------------------------------
	// 	[Send path] Time gating
	//------------------------------------------------------------------------------
					
	Counter		#(			.Width(					TimeWidth))
				time_cnt(	.Clock(					FastClock),
							.Reset(					FastReset | (TimeGate & ORAMCommandValid & ORAMCommandReady)),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				ORAMRegOutValid & ~TimeGate),
							.In(					{TimeWidth{1'bx}}),
							.Count(					PacketAge));
	assign	TimeGate =								PacketAge >= ORAMTimeDelay;							
							
	assign	ORAMCommandValid =						TimeGate & WriteGate & ORAMRegOutValid;
	assign	ORAMRegOutReady =						TimeGate & WriteGate & ORAMCommandReady;
	
	assign	ORAMCommandTransfer =					ORAMCommandValid & ORAMCommandReady;
				
	//------------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------