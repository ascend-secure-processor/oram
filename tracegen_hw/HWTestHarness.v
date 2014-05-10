
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
//==============================================================================
module HWTestHarness(
  	SlowClock, FastClock,
	SlowReset, FastReset,

	ORAMCommand, ORAMPAddr,
	ORAMCommandValid, ORAMCommandReady,
	
	ORAMDataIn, ORAMDataInValid, ORAMDataInReady,
	ORAMDataOut, ORAMDataOutValid, ORAMDataOutReady,
	
	UARTRX, UARTTX,
	
	ForceHistogramDump,
	
	ErrorReceiveOverflow, ErrorReceivePattern, ErrorSendOverflow
	);
	//--------------------------------------------------------------------------
	//	Constants
	//-------------------------------------------------------------------------- 

	`include "PathORAM.vh"

	parameter				SlowClockFreq =			100_000_000,
	
							// the number of cache lines that can be buffered 
							// before the first is sent NOTE: you should 
							// regenerate THSendFIFO/THReceiveFIFO if Buffering,
							// ORAMB,DBaseWidth changes
							Buffering =				1024,
							
							// Should the test harness return confirmations that 
							// accesses completed (=0), or should it generate a 
							// histogram of access latencies (=1)?
							GenHistogram =			1;

	`include "PathORAMBackendLocal.vh"
	`include "TestHarnessLocal.vh"
	
	localparam				BlkSize_DBaseChunks = 	ORAMB / DBaseWidth;
	localparam				BlkDBaseWidth =			`log2(BlkSize_DBaseChunks);
	
	localparam				BlkSize_UARTChunks = 	ORAMB / UARTWidth;
	localparam				DBSize_UARTChunks = 	DBaseWidth / UARTWidth;
	localparam				BlkUARTWidth =			`log2(BlkSize_UARTChunks);	
							
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
	
  	input 					SlowClock, FastClock;
	input					SlowReset, FastReset;

	//--------------------------------------------------------------------------
	//	CUT (ORAM) interface
	//--------------------------------------------------------------------------

	output	[BECMDWidth-1:0] ORAMCommand;
	output	[ORAMU-1:0]		ORAMPAddr;
	output					ORAMCommandValid;
	input					ORAMCommandReady;
	
	output	[FEDWidth-1:0]	ORAMDataIn;
	output					ORAMDataInValid;
	input					ORAMDataInReady;
	
	input	[FEDWidth-1:0]	ORAMDataOut;
	input					ORAMDataOutValid;
	output					ORAMDataOutReady;
	
	//--------------------------------------------------------------------------
	//	HW<->SW interface
	//--------------------------------------------------------------------------

	input					UARTRX;
	output					UARTTX;
	
	//--------------------------------------------------------------------------
	//	Status interface
	//--------------------------------------------------------------------------
	
	input					ForceHistogramDump;
	
	output					ErrorReceiveOverflow;
	output					ErrorReceivePattern;
	output					ErrorSendOverflow;
	
	//------------------------------------------------------------------------------
	// 	Wires & Regs
	//------------------------------------------------------------------------------
	
	// Receive pipeline
	
	(* mark_debug = "TRUE" *)	wire	[UARTWidth-1:0]	CrossBufOut_DataIn;
	(* mark_debug = "TRUE" *)	wire				CrossBufOut_DataInValid_Pre, CrossBufOut_DataInValid, CrossBufOut_DataInReady, CrossBufOut_Full;
	
	(* mark_debug = "TRUE" *)	wire	[BlkUARTWidth-1:0] BlkKeepCount;
	(* mark_debug = "TRUE" *)	wire				BlkKeepTerminal, BlkKeepTerminal_Pre;
	
	(* mark_debug = "TRUE" *)	wire	[DBaseWidth-1:0] DataOutActual, DataOutExpected;
	(* mark_debug = "TRUE" *)	wire				DataOutActualValid;

	(* mark_debug = "TRUE" *)	wire	[DBaseWidth-1:0] DataOutActual_Base;
	(* mark_debug = "TRUE" *)	wire				DataOutActual_BaseValid;	
	
	(* mark_debug = "TRUE" *)	wire				MismatchReceivePattern;
		
	(* mark_debug = "TRUE" *)	wire	[BlkDBaseWidth-1:0] ReceiveChunkID;
	(* mark_debug = "TRUE" *)	wire				ReceiveBlockComplete_Pre, ReceiveBlockComplete;

	// UART
	
	(* mark_debug = "TRUE" *)	wire	[UARTWidth-1:0]	UARTDataIn;
	(* mark_debug = "TRUE" *)	wire				UARTDataInValid, UARTDataInReady;

	(* mark_debug = "TRUE" *)	wire	[UARTWidth-1:0] UARTDataOut;
	(* mark_debug = "TRUE" *)	wire				UARTDataOutValid, UARTDataOutReady;
	
	// Send pipeline
	
	(* mark_debug = "TRUE" *)	wire	[THPWidth-1:0] CrossBufIn_DataIn;
	(* mark_debug = "TRUE" *)	wire	[THPWidth-1:0] CrossBufIn_DataOut;
	(* mark_debug = "TRUE" *)	wire				CrossBufIn_DataInValid, CrossBufIn_DataInReady;	
	
	(* mark_debug = "TRUE" *)	wire				CrossBufIn_Full, CrossBufIn_DataOutValid;
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

	// Histogram generation
	
	(* mark_debug = "TRUE" *)	wire	[FEDWidth-1:0]	ORAMDataOut_Post;
	(* mark_debug = "TRUE" *)	wire					ORAMDataOutValid_Post, ORAMDataOutReady_Post;
	
	(* mark_debug = "TRUE" *)	wire					StartCounting, AccessInProgress, StopCounting, StopCounting_Delay;
	(* mark_debug = "TRUE" *)	wire	[HGAWidth-1:0]	AccessLatency, HistogramAddress;
	(* mark_debug = "TRUE" *)	wire					HistogramWrite;
	
	(* mark_debug = "TRUE" *)	wire	[DBaseWidth-1:0] ReceiveCrossDataIn;
	(* mark_debug = "TRUE" *)	wire					ReceiveCrossDataInValid, ReceiveCrossDataInReady;
	
	(* mark_debug = "TRUE" *)	wire	[DBaseWidth-1:0] HistogramInData, HistogramOutData;
	(* mark_debug = "TRUE" *)	wire					HistogramOutValid, HistogramOutReady;
	
	(* mark_debug = "TRUE" *)	wire	[HGAWidth-1:0]	DumpAddress;
	(* mark_debug = "TRUE" *)	wire					DumpHistogram;
			
	(* mark_debug = "TRUE" *)	wire	[DBaseWidth-1:0] ReceiveCrossDataOut;
	(* mark_debug = "TRUE" *)	wire					ReceiveCrossDataOutValid, ReceiveCrossDataOutReady;

	//------------------------------------------------------------------------------
	// 	Input stimulus
	//------------------------------------------------------------------------------	

	`ifdef SIMULATION
		localparam			Rounds = 				500,
							AccessesPerRound =		20,
							
							RandomRounds =			5000,
							
							SingleLocRounds =		17,
							
							Gap = 					0,
							Cycle = 				1000000000/SlowClockFreq;
		
		reg		[THPWidth-1:0] CrossBufIn_DataIn_Reg;
		reg					CrossBufIn_DataInValid_Reg;	
		integer 			i, nr, total_expected;
		integer				FinishedInput;
		integer				NumSent, NumReceived;
		
		wire	[31:0]		RandOut;
		wire				RandOutValid;
		
		task TASK_Command;
			input	[BECMDWidth-1:0] 	In_Command;
			input	[ORAMU-1:0]			In_PAddr;
			
			begin
				CrossBufIn_DataInValid_Reg = 		1'b1;
				CrossBufIn_DataIn_Reg =				{In_Command, In_PAddr, {DBaseWidth{1'b0}}, {TimeWidth{1'b0}}};
				
				while (~CrossBufIn_DataInReady) #(Cycle);
				#(Cycle);
				
				CrossBufIn_DataInValid_Reg = 		1'b0;
			end
		endtask
		
		assign	UARTDataOutReady =					1'b1;
		assign	CrossBufIn_DataInValid =			CrossBufIn_DataInValid_Reg;
		assign	CrossBufIn_DataIn =					CrossBufIn_DataIn_Reg;
		
		PRNG 	#(			.RandWidth(				32),
							.SecretKey(				128'hd8_40_e1_a8_dc_ca_e7_ec_d9_1f_61_48_7a_f2_cb_00)) // TODO make dynamic
				leaf_gen(	.Clock(					SlowClock),
							.Reset(					SlowReset),
							.RandOutReady(			CrossBufIn_DataInValid & CrossBufIn_DataInReady),
							.RandOutValid(			RandOutValid),
							.RandOut(				RandOut));
		
		initial begin
			FinishedInput = 						0;
			NumSent =								0;
			NumReceived =							0;
			
			CrossBufIn_DataInValid_Reg = 			1'b0;
			
			#(Cycle*1000);
		
			// Random accesses
			i = 0;
			while (i < RandomRounds) begin
				if (RandOutValid) begin
					TASK_Command(BECMD_Read, RandOut[ORAML-1:0]);
					NumSent = NumSent + 1;
					#(Cycle*Gap);
					if (RandOut[0]) begin
						TASK_Command(BECMD_Update, RandOut[ORAML-1:0]);
						#(Cycle*Gap);
					end
					i = i + 1;
				end
				#(Cycle);
			end
			
			// Mimic Albert's access pattern
			i = 0;
			while (i < SingleLocRounds) begin
				nr = 0;
				while (nr < AccessesPerRound) begin
					TASK_Command(BECMD_Read, i);
					NumSent = NumSent + 1;
					TASK_Command(BECMD_Update, i);
					nr = nr + 1;
					#(Cycle*Gap);
				end
				i = i + 1;
			end
			
			// Write -> Read groups of incrementing addrs
			i = 0;
			while (i < Rounds) begin
				nr = 0;
				while (nr < AccessesPerRound) begin
					TASK_Command(BECMD_Update, i * AccessesPerRound + nr);
					nr = nr + 1;
					#(Cycle*Gap);
				end
				
				nr = 0;
				while (nr < AccessesPerRound) begin
					TASK_Command(BECMD_Read, i * AccessesPerRound + nr);
					NumSent = NumSent + 1;
					nr = nr + 1;
					#(Cycle*Gap);
				end
				i = i + 1;
			end
			
			FinishedInput =							1;
		end
		
		always @(posedge FastClock) begin
			if (HistogramWrite) begin
				NumReceived = NumReceived + 1;
			end
			
			if (FinishedInput && NumSent == NumReceived) begin
				$display("ALL TESTS PASSED!");
				$finish;
			end
		end
	`else
		FIFOShiftRound #(	.IWidth(				UARTWidth),
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
	`endif	
	
	//------------------------------------------------------------------------------
	// 	[Receive path] Shifts & buffers
	//------------------------------------------------------------------------------	

	`ifdef SIMULATION
		initial begin
			if ( (UARTWidth > DBaseWidth) | (DBaseWidth > FEDWidth) ) begin
				$display("[%m @ %t] Illegal parameter settings", $time);
				$finish;
			end
			
			if (GenHistogram & HGAWidth > 12) begin
				$display("[%m @ %t] recv_fifo may overflow --- make it deeper.", $time);
				$finish;
			end			
		end
	`endif
	
	// NOTE: all logic in this block is disconnected from the UART when GenHistogram == 1

	// When GenHistogram is 1, we want to pull in data as fast as possible
	FIFORAM		#(			.Width(					FEDWidth),
							.Buffering(				FEORAMBChunks))
				in_buf(		.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				ORAMDataOut),
							.InValid(				ORAMDataOutValid),
							.InAccept(				ORAMDataOutReady),
							.OutData(				ORAMDataOut_Post),
							.OutSend(				ORAMDataOutValid_Post),
							.OutReady(				ORAMDataOutReady_Post));

	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				UARTWidth))
				O_down_shft(.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				ORAMDataOut_Post),
							.InValid(				ORAMDataOutValid_Post),
							.InAccept(				ORAMDataOutReady_Post),
							.OutData(				CrossBufOut_DataIn),
							.OutValid(				CrossBufOut_DataInValid_Pre),
							.OutReady(				CrossBufOut_DataInReady));
	
	assign	CrossBufOut_DataInValid =				CrossBufOut_DataInValid_Pre & (BlkKeepCount < DBSize_UARTChunks);
	
	// Only send the base seed back to SW
	Counter		#(			.Width(					BlkUARTWidth))
				O_keep_cnt(	.Clock(					FastClock),
							.Reset(					FastReset | BlkKeepTerminal),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CrossBufOut_DataInValid_Pre & CrossBufOut_DataInReady),
							.In(					{BlkUARTWidth{1'bx}}),
							.Count(					BlkKeepCount));
	CountCompare #(			.Width(					BlkUARTWidth),
							.Compare(				BlkSize_UARTChunks - 1))
				O_keep_term(.Count(					BlkKeepCount), 
							.TerminalCount(			BlkKeepTerminal_Pre));	
	assign	BlkKeepTerminal =						BlkKeepTerminal_Pre & CrossBufOut_DataInValid_Pre & CrossBufOut_DataInReady;
	
	//------------------------------------------------------------------------------
	// 	[Receive path] Data checker
	//------------------------------------------------------------------------------	

	// Check that the data in the cache line matches the seed + its generated data
	
	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				DBaseWidth))
				O_db_shft(	.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				ORAMDataOut),
							.InValid(				ORAMDataOutValid_Post & ORAMDataOutReady_Post),
							.InAccept(				),
							.OutData(				DataOutActual),
							.OutValid(				DataOutActualValid),
							.OutReady(				1'b1));

	FIFORegister #(			.Width(					DBaseWidth))
				base_reg(	.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				DataOutActual + 1),
							.InValid(				DataOutActualValid),
							.InAccept(				),
							.OutData(				DataOutActual_Base),
							.OutSend(				DataOutActual_BaseValid),
							.OutReady(				ReceiveBlockComplete));						
							
	Counter		#(			.Width(					BlkDBaseWidth))
				O_chnk_cnt(	.Clock(					FastClock),
							.Reset(					FastReset | ReceiveBlockComplete),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DataOutActualValid & DataOutActual_BaseValid),
							.In(					{BlkDBaseWidth{1'bx}}),
							.Count(					ReceiveChunkID));
	assign	DataOutExpected =						DataOutActual_Base + ReceiveChunkID;
	
	CountCompare #(			.Width(					BlkDBaseWidth),
							.Compare(				BlkSize_DBaseChunks - 1))
				O_chnk_term(.Count(					ReceiveChunkID), 
							.TerminalCount(			ReceiveBlockComplete_Pre));
	assign	ReceiveBlockComplete = 					ReceiveBlockComplete_Pre & DataOutActualValid;	
	
	assign	MismatchReceivePattern =				(DataOutActual != DataOutExpected) & ~ReceiveBlockComplete_Pre &
													DataOutActualValid & DataOutActual_BaseValid; 
	
	//------------------------------------------------------------------------------
	// 	[Receive path] Funnels & crossing
	//------------------------------------------------------------------------------	
	
	assign	CrossBufOut_DataInReady =				(GenHistogram) ? 1'b1 : 					ReceiveCrossDataInReady;
	assign	HistogramOutReady =						(GenHistogram) ? ReceiveCrossDataInReady : 	1'b0;
	
	assign	ReceiveCrossDataIn =					(GenHistogram) ? HistogramOutData : 		CrossBufOut_DataIn;
	assign	ReceiveCrossDataInValid =				(GenHistogram) ? HistogramOutValid : 		CrossBufOut_DataInValid; 
	
	// Clock crossing; we should never have to change the depth of this module
	assign	ReceiveCrossDataInReady =				~CrossBufOut_Full;
	THReceiveFIFO recv_fifo(.rst(					FastReset), 
							.wr_clk(				FastClock), 
							.rd_clk(				SlowClock), 
							.din(					ReceiveCrossDataIn), 
							.wr_en(					ReceiveCrossDataInValid),
							.full(					CrossBufOut_Full),  
							.dout(					ReceiveCrossDataOut), 
							.valid(					ReceiveCrossDataOutValid),
							.rd_en(					ReceiveCrossDataOutReady));

	generate if (GenHistogram) begin:HIST_SHIFT
		FIFOShiftRound #(	.IWidth(				DBaseWidth),
							.OWidth(				UARTWidth))
				O_db_shft(	.Clock(					SlowClock),
							.Reset(					SlowReset),
							.InData(				ReceiveCrossDataOut),
							.InValid(				ReceiveCrossDataOutValid),
							.InAccept(				ReceiveCrossDataOutReady),
							.OutData(				UARTDataIn),
							.OutValid(				UARTDataInValid),
							.OutReady(				UARTDataInReady));
	end else begin:NO_HIST_SHIFT
		assign	UARTDataIn =						ReceiveCrossDataOut[UARTWidth-1:0];	
		assign	UARTDataInValid =					ReceiveCrossDataOutValid;
		assign	ReceiveCrossDataOutReady =			UARTDataInReady;
	end endgenerate
	
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
							
	assign	SlowCommand =							CrossBufIn_DataIn[THPWidth-1:THPWidth-TCMDWidth];
	assign	SlowStartSignal =						SlowCommand == TCMD_Start;
	
	assign	CrossBufIn_DataInReady =				~CrossBufIn_Full;

	// TODO there will be a bug if 2 start signals appear before the first is finished emptying its buffer ...
	
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
	
	THSendFIFO send_fifo(	.rst(					SlowReset),
							.wr_clk(				SlowClock),
							.rd_clk(				FastClock),
							.din(					CrossBufIn_DataIn),
							.full(					CrossBufIn_Full),
							.wr_en(					CrossBufIn_DataInValid),
							.dout(					CrossBufIn_DataOut),
							.valid(					CrossBufIn_DataOutValid),
							.rd_en(					CrossBufIn_DataOutReady));

	assign	{FastCommand, FastPAddr, FastDataBase, FastTimeDelay} =	CrossBufIn_DataOut;
	assign	ORAMRegInValid =						StartGate & CrossBufIn_DataOutValid & FastCommand != TCMD_Start;
	assign	CrossBufIn_DataOutReady =				StartGate & ORAMRegInReady;
	
	//------------------------------------------------------------------------------
	// 	[Send path] Start command gating
	//------------------------------------------------------------------------------

	assign	BurstComplete =							StartGate & ~CrossBufIn_DataOutValid;
	
	generate if (GenHistogram) begin:ALWAYS_SEND
		assign	StartGate =							1'b1;
		
		Register	#(		.Width(					1))
				stop_reg(	.Clock(					FastClock),
							.Reset(					FastReset),
							.Set(					FastStartSignal | ForceHistogramDump),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					DumpHistogram));		
	end else begin:GATED_SEND
		Register	#(		.Width(					1))
				start_reg(	.Clock(					FastClock),
							.Reset(					FastReset | BurstComplete),
							.Set(					FastStartSignal),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					StartGate));
							
		assign	DumpHistogram =						1'b0;
	end endgenerate
	
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
	assign	TimeGate =								(GenHistogram) ? 1'b1 : PacketAge >= ORAMTimeDelay;							
							
	assign	ORAMCommandValid =						TimeGate & WriteGate & ORAMRegOutValid & ((GenHistogram) ? ~AccessInProgress : 1'b1);
	assign	ORAMRegOutReady =						TimeGate & WriteGate & ORAMCommandReady;
	
	assign	ORAMCommandTransfer =					ORAMCommandValid & ORAMCommandReady;
				
	//------------------------------------------------------------------------------
	// 	Histogram generation
	//------------------------------------------------------------------------------				
	
	CountAlarm #(			.Threshold(				FEORAMBChunks))
				lat_term(	.Clock(					FastClock), 
							.Reset(					FastReset), 
							.Enable(				ORAMDataOutValid & ORAMDataOutReady),
							.Done(					StopCounting));
	ShiftRegister #(		.PWidth(				2),
							.SWidth(				1))
				ro_L_shft(	.Clock(					FastClock), 
							.Reset(					FastReset), 
							.Load(					1'b0),
							.Enable(				1'b1), 
							.SIn(					StopCounting),
							.SOut(					StopCounting_Delay));
							
	assign	StartCounting = 						ORAMCommandTransfer & ORAMCommand == BECMD_Read;

	Register	#(			.Width(					1))
				lat_control(.Clock(					FastClock),
							.Reset(					FastReset | StopCounting),
							.Set(					StartCounting),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					AccessInProgress));
				
	Counter		#(			.Width(					DBaseWidth))
				latency(	.Clock(					FastClock),
							.Reset(					FastReset | StartCounting),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				AccessInProgress),
							.In(					{DBaseWidth{1'bx}}),
							.Count(					AccessLatency));
	
	assign	HistogramAddress =						(DumpHistogram) ? DumpAddress : AccessLatency;			
	assign	HistogramWrite =						StopCounting_Delay; // Wait for HistogramOutData to become accurate
	assign	HistogramInData =						HistogramOutData + 1;
	
	RAM			#(			.DWidth(				DBaseWidth),
							.AWidth(				HGAWidth),
							.EnableInitial(			1),
							.Initial(				{1 << HGAWidth{{DBaseWidth{1'b0}}}}))
				histogram(	.Clock(					FastClock),
							.Reset(					1'b0),
							.Enable(				1'b1),
							.Write(					HistogramWrite),
							.Address(				HistogramAddress),
							.DIn(					HistogramInData),
							.DOut(					HistogramOutData));

	Counter		#(			.Width(					HGAWidth),
							.Limited(				1))
				dump_addr(	.Clock(					FastClock),
							.Reset(					FastReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DumpHistogram),
							.In(					{HGAWidth{1'bx}}),
							.Count(					DumpAddress));	
	
	Register	#(			.Width(					1))
				h_O_valid(	.Clock(					FastClock),
							.Reset(					FastReset),
							.Set(					1'b0),
							.Enable(				1'b1),
							.In(					DumpHistogram & ~&DumpAddress),
							.Out(					HistogramOutValid));
				
	//------------------------------------------------------------------------------
	//	Error messages
	//------------------------------------------------------------------------------

	Register	#(			.Width(					1))
				recv_ovflw(	.Clock(					FastClock),
							.Reset(					FastReset),
							.Set(					CrossBufOut_Full & CrossBufOut_DataInValid),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ErrorReceiveOverflow));
	
	Register	#(			.Width(					1))
				send_ovflw(	.Clock(					SlowClock),
							.Reset(					SlowReset),
							.Set(					CrossBufIn_Full & CrossBufIn_DataInValid),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ErrorSendOverflow));	

	Register	#(			.Width(					1))
				error(		.Clock(					FastClock),
							.Reset(					FastReset),
							.Set(					MismatchReceivePattern),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ErrorReceivePattern));	
	
	//------------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------