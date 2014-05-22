
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
							GenHistogram =			1,
							
							NumValidBlock =			1 << ORAML;

	`include "SecurityLocal.vh"
	`include "PathORAMBackendLocal.vh"
	`include "TestHarnessLocal.vh"
	
	localparam				NVWidth =				`log2(NumValidBlock);
	
	localparam				OBUChunks = 			ORAMB / ORAMU;
	
	localparam				BlkSize_UARTChunks = 	ORAMB / UARTWidth;
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
	
	(* mark_debug = "FALSE" *)	wire				CrossBufOut_Full;

	(* mark_debug = "FALSE" *)	wire	[ORAMB-1:0] DataOutActual, DataOutExpected, DataOutExpectedPre, DataInWide;
	(* mark_debug = "FALSE" *)	wire				DataOutActualValid, DataOutExpectedValid;
	
	(* mark_debug = "TRUE" *)	wire				ERROR_MismatchReceivePattern;

	// UART
	
	(* mark_debug = "FALSE" *)	wire	[UARTWidth-1:0]	UARTDataIn;
	(* mark_debug = "FALSE" *)	wire				UARTDataInValid, UARTDataInReady;

	(* mark_debug = "FALSE" *)	wire	[UARTWidth-1:0] UARTDataOut;
	(* mark_debug = "FALSE" *)	wire				UARTDataOutValid, UARTDataOutReady;
	
	// Send pipeline
	
	wire	[THPWidth-1:0]	UARTDataOut_Wide;
	wire					UARTDataOutValid_Wide, UARTDataOutReady_Wide, UARTWide_Full;	
	
	(* mark_debug = "FALSE" *)	wire	[THPWidth-1:0] CrossBufIn_DataIn;
	(* mark_debug = "FALSE" *)	wire	[THPWidth-1:0] CrossBufIn_DataOut;
	(* mark_debug = "FALSE" *)	wire				CrossBufIn_DataInValid, CrossBufIn_DataInReady;	
	
	(* mark_debug = "FALSE" *)	wire				CrossBufIn_Full, CrossBufIn_DataOutValid;
	(* mark_debug = "FALSE" *)	wire				CrossBufIn_DataOutReady;
	
	(* mark_debug = "FALSE" *)	wire	[TCMDWidth-1:0]	FastCommand;
	(* mark_debug = "FALSE" *)	wire	[ORAMU-1:0]	FastPAddr;
	(* mark_debug = "FALSE" *)	wire	[DBaseWidth-1:0] FastDataBase;
	(* mark_debug = "FALSE" *)	wire	[TimeWidth-1:0]	FastTimeDelay;
	
	(* mark_debug = "FALSE" *)	wire				TimeGate;
	(* mark_debug = "FALSE" *)	wire	[TimeWidth-1:0]	PacketAge;
	
	(* mark_debug = "FALSE" *)	wire				StartGate, SlowStartSignal;
	(* mark_debug = "FALSE" *)	wire				FastStartSignal;
	(* mark_debug = "FALSE" *)	wire				FastStartSignal_Pre, StarCrossEmpty;
		
	(* mark_debug = "FALSE" *)	wire				BurstComplete;
	(* mark_debug = "FALSE" *)	wire				ORAMRegInValid, ORAMRegInReady;
	(* mark_debug = "FALSE" *)	wire				ORAMRegOutValid, ORAMRegOutReady;
	
	(* mark_debug = "FALSE" *)	wire				ORAMCommandTransfer, ORAMDataInFunnelReady;	
	
	(* mark_debug = "FALSE" *)	wire	[DBaseWidth-1:0] ORAMDataBase;
	(* mark_debug = "FALSE" *)	wire	[TimeWidth-1:0]	ORAMTimeDelay;
	
	(* mark_debug = "FALSE" *)	wire				WriteCommandValid;

	//
	
	(* mark_debug = "FALSE" *)	wire					StartCounting, AccessInProgress, StopCounting, StopCounting_Delay;
	(* mark_debug = "FALSE" *)	wire	[HGAWidth-1:0]	AccessLatency, HistogramAddress;
	(* mark_debug = "FALSE" *)	wire					HistogramWrite;
	
	(* mark_debug = "FALSE" *)	wire	[DBaseWidth-1:0] ReceiveCrossDataIn;
	(* mark_debug = "FALSE" *)	wire					ReceiveCrossDataInValid, ReceiveCrossDataInReady;
	
	(* mark_debug = "FALSE" *)	wire	[DBaseWidth-1:0] HistogramInData, HistogramOutData;
	(* mark_debug = "FALSE" *)	wire					HistogramOutValid, HistogramOutReady;
	
	(* mark_debug = "FALSE" *)	wire	[HGAWidth-1:0]	DumpAddress;
	(* mark_debug = "FALSE" *)	wire					DumpHistogram;
			
	(* mark_debug = "FALSE" *)	wire	[DBaseWidth-1:0] ReceiveCrossDataOut;
	(* mark_debug = "FALSE" *)	wire					ReceiveCrossDataOutValid, ReceiveCrossDataOutReady;

	// Traffic generator
	
	localparam				STWidth =					2,
							ST_Idle =					2'd0,		
							ST_PrepSeed =				2'd1,
							ST_Seed =					2'd2,
							ST_Access =					2'd3;
	
	(* mark_debug = "FALSE" *)	wire	[THPWidth-1:0]	CrossBufIn_DataInPre;
	(* mark_debug = "TRUE" *)	wire					CrossBufIn_DataInValidPre, CrossBufIn_DataInReadyPre;
	
	(* mark_debug = "TRUE" *)	reg		[STWidth-1:0]	CS, NS;	
	(* mark_debug = "FALSE" *)	wire					CSAccess, CSSeed;
	
	(* mark_debug = "FALSE" *)	wire	[TCMDWidth-1:0]	SlowCommand;
	(* mark_debug = "FALSE" *)	wire	[ORAMU-1:0]		SlowAddress; 
	(* mark_debug = "FALSE" *)	wire	[DBaseWidth-1:0] SlowDataBase;
	(* mark_debug = "FALSE" *)	wire	[TimeWidth-1:0]	SlowTime;
	
	(* mark_debug = "TRUE" *)	wire	[TCMDWidth-1:0]	SeedCommand;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]		SeedAddress;
	(* mark_debug = "TRUE" *)	wire	[DBaseWidth-1:0] SeedDataBase; 
	(* mark_debug = "TRUE" *)	wire	[TimeWidth-1:0]	SeedTime;
	
	(* mark_debug = "TRUE" *)	wire	[DBaseWidth-1:0] SeedAccessCount;
	
	(* mark_debug = "FALSE" *)	wire					ResetPRNG, PRNGOutValid;
	(* mark_debug = "FALSE" *)	wire	[ORAMU-1:0]		PRNGOutData;
	
	(* mark_debug = "FALSE" *)	wire	[ORAMU-1:0]		RandomAddress, ScanAddress, FillAddress;
	(* mark_debug = "FALSE" *)	wire	[TCMDWidth-1:0]	RandomCommand, ScanCommand, FillCommand;
	
	(* mark_debug = "TRUE" *)	wire					AccessHalfThresholdReached, AccessThresholdReached;
	
	(* mark_debug = "TRUE" *)	wire					CMD_RND, CMD_FILL;
	(* mark_debug = "TRUE" *)	wire					ADDR_RND, ADDR_FILL;	
	
	//------------------------------------------------------------------------------
	// 	Simulation command generation
	//------------------------------------------------------------------------------	

	`ifdef SIMULATION
		initial begin
			if (GenHistogram == 0) begin
				$display("Illegal mode");
				$finish;
			end
			
			if (ERROR_MismatchReceivePattern) begin
				$display("WARNING: Traffic gen data mismatch (%x != %x)", DataOutExpected, DataOutActual);
				if (DataOutActual != {(ORAMB/32){32'hdeaf1234}}) begin
					$finish;
				end
			end
		end
	`endif
	
	/*
	`ifdef SIMULATION
		localparam			Rounds = 				500,
							AccessesPerRound =		20,
							
							RandomRounds =			5000,
							
							SingleLocRounds =		20,

							WaitThreshold =			100000, // Set to 2000 or something for a performance bug run
							
							Cycle = 				1000000000/SlowClockFreq;
		
		reg		[THPWidth-1:0] CrossBufIn_DataIn_Reg;
		reg					CrossBufIn_DataInValid_Reg;	
		integer 			i, nr, total_expected;
		integer				FinishedInput;
		integer				NumSent, NumReceived;
		integer				Gap;
		
		wire	[31:0]		RandOut;
		wire				RandOutValid;
		
		task TASK_Command;
			input	[BECMDWidth-1:0] 	In_Command;
			input	[ORAMU-1:0]			In_PAddr;
			integer 					CyclesWaited;
			begin
				CrossBufIn_DataInValid_Reg = 		1'b1;
				CrossBufIn_DataIn_Reg =				{In_Command, { {ORAMU-NVWidth{1'b0}}, In_PAddr[NVWidth-1:0] }, {DBaseWidth{1'b0}}, {TimeWidth{1'b0}}};
				CyclesWaited =						0;
				
				while (~CrossBufIn_DataInReady) begin
					CyclesWaited = CyclesWaited + 1;
					if (CyclesWaited > WaitThreshold) begin
						$display("[%m] ERROR: ORAM has stalled.");
						$finish;
					end
					#(Cycle);
				end
				#(Cycle);
				
				NumSent = NumSent + 1;
				$display("[%m @ %t] Test harness sent (op=%d, addr=%x)", $time, In_Command, In_PAddr[NVWidth-1:0]);
				$display("(read #%d)", NumSent);
				
				CrossBufIn_DataInValid_Reg = 		1'b0;
			end
		endtask
		
		assign	UARTDataOutReady =					1'b1;
		assign	CrossBufIn_DataInValid =			CrossBufIn_DataInValid_Reg;
		assign	CrossBufIn_DataIn =					CrossBufIn_DataIn_Reg;
		
		PRNG 	#(			.RandWidth(				ORAMU)) // TODO make dynamic
				leaf_gen(	.Clock(					SlowClock),
							.Reset(					SlowReset),
							.RandOutReady(			CrossBufIn_DataInValid & CrossBufIn_DataInReady),
							.RandOutValid(			RandOutValid),
							.RandOut(				RandOut),
							.SecretKey(				128'hd8_40_e1_a8_dc_ca_e7_ec_d9_1f_61_48_7a_f2_cb_00));
		
		initial begin
			FinishedInput = 						0;
			NumSent =								0;
			NumReceived =							0;
									
			Gap = 									1;
			
			CrossBufIn_DataInValid_Reg = 			1'b0;
			
			#(Cycle*1000);
		
			while (1) begin
			
				//
				// Random accesses
				//
				i = 0;
				while (i < RandomRounds) begin
					while (~RandOutValid) #(Cycle);
					
					TASK_Command(BECMD_Read, RandOut);
					#(Cycle*Gap);
						
					while (~RandOutValid) #(Cycle);
					
					if (RandOut[0]) begin
						TASK_Command(BECMD_Update, RandOut);
						#(Cycle*Gap);
					end
					
					i = i + 1;
				end
				
				//
				// Mimic Albert's access pattern
				//
				i = 0;
				while (i < SingleLocRounds) begin
					nr = 0;
					while (nr < AccessesPerRound) begin
						TASK_Command(BECMD_Read, i);
						TASK_Command(BECMD_Update, i);
						nr = nr + 1;
						#(Cycle*Gap);
					end
					i = i + 1;
				end
				
				//
				// Write -> Read groups of incrementing addrs
				//
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
						nr = nr + 1;
						#(Cycle*Gap);
					end
					i = i + 1;
				end
				
				Gap = Gap * 64;
			end
			
			#(Cycle*WaitThreshold);
			FinishedInput =							1;
		end
		
		always @(posedge FastClock) begin
			if (HistogramWrite) begin
				NumReceived = NumReceived + 1;
				$display("[%m @ %t] Test harness received read response #%d.", $time, NumReceived);
			end
			
			if (FinishedInput && NumSent == NumReceived) begin
				$display("ALL TESTS PASSED!");
				$finish;
			end
		end
		
		assign	SlowStartSignal =					1'b0;
	`else
	
	*/
	
	//------------------------------------------------------------------------------
	// 	Hardware command generation
	//------------------------------------------------------------------------------
	
	initial begin
		CS = ST_Idle;
	end
	
	assign	AccessTransfer =						CrossBufIn_DataInValid & CrossBufIn_DataInReady;
	
	assign	CrossBufIn_DataInValid =				(CSAccess) ? 	CrossBufIn_DataInValidPre : 
													(CSSeed) ? 		PRNGOutValid : 1'b0;
	assign	CrossBufIn_DataInReadyPre =				(CSAccess) ? 	CrossBufIn_DataInReady : 
													(CSSeed) ? 		AccessThresholdReached : 1'b0;
	
	assign	ResetPRNG =								CS == ST_PrepSeed;
	
	assign	{SlowCommand, SlowAddress, SlowDataBase, SlowTime} = CrossBufIn_DataInPre;
		
	assign	CrossBufIn_DataIn =						(CSAccess) ? 	{SlowCommand, SlowAddress, SlowDataBase, SlowTime} : 
																	{SeedCommand, SeedAddress, SeedDataBase, SeedTime};

	assign	CSAccess =								CS == ST_Access;
	assign	CSSeed =								CS == ST_Seed;
	
	always @(posedge SlowClock) begin
		if (SlowReset) CS <= 						ST_Idle;
		else CS <= 									NS;
	end
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Idle : 
				if (CrossBufIn_DataInValidPre && (SlowCommand == TCMD_Update || SlowCommand == TCMD_Read || SlowCommand == TCMD_Start))
					NS =							ST_Access;
				else if (CrossBufIn_DataInValidPre)
					NS =							ST_PrepSeed;
			ST_PrepSeed :
				NS =								ST_Seed;
			ST_Seed :
				if (AccessThresholdReached)
					NS =							ST_Idle;
			ST_Access :
				if (AccessTransfer)
					NS =							ST_Idle;
		endcase
	end
	
	Counter		#(			.Width(					DBaseWidth))
				access_cnt(	.Clock(					SlowClock),
							.Reset(					SlowReset | AccessThresholdReached),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSSeed & AccessTransfer),
							.In(					{DBaseWidth{1'bx}}),
							.Count(					SeedAccessCount));					
	assign	AccessHalfThresholdReached =			SeedAccessCount >= (SlowDataBase >> 1);
	assign	AccessThresholdReached =				SeedAccessCount == SlowDataBase;

	PRNG 		#(			.RandWidth(				ORAMU))
				addr_gen(	.Clock(					SlowClock),
							.Reset(					SlowReset | ResetPRNG),
							.RandOutReady(			CSSeed & CrossBufIn_DataInReady),
							.RandOutValid(			PRNGOutValid),
							.RandOut(				PRNGOutData),
							.SecretKey(				{ {AESWidth-TimeWidth{1'b0}}, SlowAddress} ));

	assign	RandomAddress =							PRNGOutData + SlowTime;
	assign	ScanAddress =							((AccessHalfThresholdReached) ?  SeedAccessCount - (SlowDataBase >> 1) : SeedAccessCount) + SlowTime;
	assign	FillAddress =							SeedAccessCount;
	
	assign	RandomCommand =							(PRNGOutData[ORAMU-1]) ? TCMD_Update : TCMD_Read;
	assign	ScanCommand =							(AccessHalfThresholdReached) ? TCMD_Read : TCMD_Update;
	assign	FillCommand =							TCMD_Update;
	
	assign	CMD_RND =								SlowCommand == TCMD_CmdRnd_AddrLin || SlowCommand == TCMD_CmdRnd_AddrRnd;
	assign	CMD_FILL =								SlowCommand == TCMD_Fill;
	
	assign	ADDR_RND =								SlowCommand == TCMD_CmdLin_AddrRnd || SlowCommand == TCMD_CmdRnd_AddrRnd;
	assign	ADDR_FILL =								SlowCommand == TCMD_Fill;
	
	assign	SeedCommand =							(CMD_RND) ? 	RandomCommand : 
													(CMD_FILL) ? 	FillCommand :
																	ScanCommand;
																	
	assign	SeedAddress =							(ADDR_RND) ? 	RandomAddress[NVWidth-1:0] : 
													(ADDR_FILL) ? 	FillAddress[NVWidth-1:0] : 
																	ScanAddress[NVWidth-1:0]; 
	
	assign	SeedDataBase =							{DBaseWidth{1'b0}};
	assign	SeedTime =								{TimeWidth{1'b0}};
	
	assign	SlowStartSignal =						CSAccess && SlowCommand == TCMD_Start;			
	//`endif
	
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
	
	FIFOShiftRound #(		.IWidth(				UARTWidth),
							.OWidth(				THPWidth),
							.Reverse(				1))
			tst_shift(		.Clock(					SlowClock),
							.Reset(					SlowReset),
							.InData(				UARTDataOut),
							.InValid(				UARTDataOutValid),
							.InAccept(				UARTDataOutReady),
							.OutData(				UARTDataOut_Wide),
							.OutValid(				UARTDataOutValid_Wide),
							.OutReady(				UARTDataOutReady_Wide));
	
	assign	UARTDataOutReady_Wide =					~UARTWide_Full;
	THSendFIFO uart_fifo(	.rst(					SlowReset),
							.wr_clk(				SlowClock),
							.rd_clk(				SlowClock),
							.din(					UARTDataOut_Wide),
							.full(					UARTWide_Full),
							.wr_en(					UARTDataOutValid_Wide),
							.dout(					CrossBufIn_DataInPre),
							.valid(					CrossBufIn_DataInValidPre),
							.rd_en(					CrossBufIn_DataInReadyPre));	
	
	//------------------------------------------------------------------------------
	// 	[Send path] Clock crossing
	//------------------------------------------------------------------------------

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
		
	genvar i;
	generate for (i = 0; i < OBUChunks; i = i + 1) begin
		assign	DataInWide[(i+1)*ORAMU-1:i*ORAMU] = ORAMPAddr + i;
	end endgenerate			
		
	FIFOShiftRound #(		.IWidth(				ORAMB),
							.OWidth(				FEDWidth))
				I_dta_shft(	.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				DataInWide),
							.InValid(				ORAMCommandTransfer & WriteCommandValid),
							.InAccept(				ORAMDataInFunnelReady),
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
							
	assign	ORAMCommandValid =						TimeGate & ORAMDataInFunnelReady & ORAMRegOutValid & ~AccessInProgress;
	assign	ORAMRegOutReady =						TimeGate & ORAMDataInFunnelReady & ORAMCommandReady & ~AccessInProgress;
	
	assign	ORAMCommandTransfer =					ORAMCommandValid & ORAMCommandReady;
				
	//------------------------------------------------------------------------------
	// 	Histogram generation
	//------------------------------------------------------------------------------				
	
	assign	StopCounting =							DataOutActualValid;
	
	wire	[2-1:0]			Stopping;
	ShiftRegister #(		.PWidth(				2),
							.SWidth(				1))
				ro_L_shft(	.Clock(					FastClock), 
							.Reset(					FastReset), 
							.Load(					1'b0),
							.Enable(				1'b1), 
							.SIn(					StopCounting),
							.SOut(					StopCounting_Delay),
							.POut(					Stopping));
							
	assign	StartCounting = 						ORAMCommandTransfer & ORAMCommand == BECMD_Read;

	Register	#(			.Width(					1))
				lat_control(.Clock(					FastClock),
							.Reset(					FastReset | StopCounting_Delay),
							.Set(					StartCounting),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					AccessInProgress));
				
	Counter		#(			.Width(					DBaseWidth))
				latency(	.Clock(					FastClock),
							.Reset(					FastReset | StartCounting),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				AccessInProgress & ~|Stopping),
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

	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				ORAMB),
							.Register(				1))
				O_check(	.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				ORAMDataOut),
							.InValid(				ORAMDataOutValid),
							.InAccept(				ORAMDataOutReady),
							.OutData(				DataOutActual),
							.OutValid(				DataOutActualValid),
							.OutReady(				1'b1));
			
	generate for (i = 0; i < OBUChunks; i = i + 1) begin
		assign	DataOutExpectedPre[(i+1)*ORAMU-1:i*ORAMU] = ORAMPAddr + i;
	end endgenerate	
							
	FIFORegister #(			.Width(					ORAMB))
				I_check(	.Clock(					FastClock),
							.Reset(					FastReset),
							.InData(				DataOutExpectedPre),
							.InValid(				ORAMCommandTransfer & ~WriteCommandValid),
							.InAccept(				),
							.OutData(				DataOutExpected),
							.OutSend(				DataOutExpectedValid),
							.OutReady(				DataOutActualValid));								
			
	assign	ERROR_MismatchReceivePattern =			(DataOutActual != DataOutExpected) & DataOutActualValid; 
	
	//------------------------------------------------------------------------------
	// 	[Receive path] Funnels & crossing
	//------------------------------------------------------------------------------	
	
	assign	HistogramOutReady =						ReceiveCrossDataInReady;
	
	assign	ReceiveCrossDataIn =					HistogramOutData;
	assign	ReceiveCrossDataInValid =				HistogramOutValid; 
	
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

	FIFOShiftRound #(		.IWidth(				DBaseWidth),
							.OWidth(				UARTWidth))
				O_db_shft(	.Clock(					SlowClock),
							.Reset(					SlowReset),
							.InData(				ReceiveCrossDataOut),
							.InValid(				ReceiveCrossDataOutValid),
							.InAccept(				ReceiveCrossDataOutReady),
							.OutData(				UARTDataIn),
							.OutValid(				UARTDataInValid),
							.OutReady(				UARTDataInReady));				
				
	//------------------------------------------------------------------------------
	//	Error messages
	//------------------------------------------------------------------------------

	assign	ErrorReceiveOverflow =					1'b0;
	
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
							.Set(					ERROR_MismatchReceivePattern),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ErrorReceivePattern));	
	
	//------------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------