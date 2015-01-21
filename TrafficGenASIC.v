
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		TrafficGenASIC
//	Desc:		A simplified dumb traffic generator to test ORAM functionality on
//				ASIC.
//==============================================================================
module TrafficGenASIC(
  	Clock, Reset,

	ORAMCommand, ORAMPAddr,
	ORAMCommandValid, ORAMCommandReady,
	
	ORAMDataIn, ORAMDataInValid, ORAMDataInReady,
	ORAMDataOut, ORAMDataOutValid, ORAMDataOutReady,
	
	JTAG_Traffic
	);
	
	//--------------------------------------------------------------------------
	//	Constants
	//-------------------------------------------------------------------------- 

	`include "PathORAM.vh"
	`include "UORAM.vh"
	`include "PLBLocal.vh"
	`include "CommandsLocal.vh"
	`include "TrafficGenLocal.vh"

	`include "DMLocal.vh"
	`include "JTAG.vh"
	
	parameter				
	`ifdef SIMULATION
							NumCommands =			3,
	`else
							NumCommands =			4,
	`endif
							AccessCount_Fixed =		32'd2048;
	
	localparam				StallThreshold =		20000; // astronomical? maybe not for these slow ass pins ;-)

	localparam				NVWidth =				`log2(NumValidBlock);	
	localparam				OBUChunks = 			ORAMB / ORAMU;

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
	
  	input 					Clock;
	input					Reset;

	//--------------------------------------------------------------------------
	//	CUT (ORAM frontend) interface
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
	//	Status interface
	//--------------------------------------------------------------------------
	
	output	[JTWidth_Traffic-1:0] JTAG_Traffic;
	
	//--------------------------------------------------------------------------
	// 	Wires & Regs
	//--------------------------------------------------------------------------
	
	// Receive pipeline

	wire	[ORAMB-1:0] 	DataOutActual, DataOutExpected, DataOutExpectedPre, DataInWide;
	wire					DataOutActualValid, DataOutExpectedValid;
	
	wire					ERROR_MismatchReceivePattern;
	
	// Send pipeline
	
	wire	[THPWidth-1:0] 	CrossBufIn_DataIn;
	wire					CrossBufIn_DataInValid, CrossBufIn_DataInReady;	
	
	wire	[TCMDWidth-1:0]	SendCommand;
	wire	[ORAMU-1:0]	SendPAddr;
	wire	[DBaseWidth-1:0] SendDataBase;
	wire	[TimeWidth-1:0]	SendTimeDelay;
	
	wire					SWHistogramDump;
		
	wire					ORAMRegInValid, ORAMRegInReady;
	wire					ORAMRegOutValid, ORAMRegOutReady;
	
	wire					ORAMCommandTransfer, ORAMDataInFunnelReady;	
	
	wire	[DBaseWidth-1:0] ORAMDataBase;
	wire	[TimeWidth-1:0]	ORAMTimeDelay;
	
	wire					WriteCommandValid;

	// Traffic generator
	
	wire	[TimeWidth-1:0]	CmdCount;
	
	localparam				STWidth =					2,
							ST_Idle =					2'd0,		
							ST_PrepSeed =				2'd1,
							ST_Seed =					2'd2,
							ST_Access =					2'd3;
	
	wire	[THPWidth-1:0]	CrossBufIn_DataInPre;
	wire					CrossBufIn_DataInValidPre, CrossBufIn_DataInReadyPre;
	
	reg		[STWidth-1:0]	CS, NS;	
	wire					CSAccess, CSSeed;
	
	wire	[TCMDWidth-1:0]	AccessCommand;
	wire	[ORAMU-1:0]		AccessEncSeed; 
	wire	[DBaseWidth-1:0] AccessCount;
	wire	[TimeWidth-1:0]	AccessAddrMask;
	
	wire	[TCMDWidth-1:0]	SeedCommand;
	wire	[ORAMU-1:0]		SeedAddress;
	wire	[DBaseWidth-1:0] SeedDataBase; 
	wire	[TimeWidth-1:0]	SeedTime;
	
	wire	[DBaseWidth-1:0] SeedAccessCount;
	
	wire					OutRandomBit, OutRandomBitValid, OutRandomBitReady;	
	
	wire					ResetPRNG, PRNGOutValid;
	wire	[ORAMU-1:0]		PRNGOutData;
	
	wire	[ORAMU-1:0]		RandomAddress, ScanAddress, FillAddress;
	wire	[TCMDWidth-1:0]	RandomCommand, ScanCommand, FillCommand;
	
	wire					AccessHalfThresholdReached, AccessThresholdReached;
	
	wire					CMD_RND, CMD_FILL;
	wire					ADDR_RND, ADDR_FILL;	
	
	//------------------------------------------------------------------------------
	// 	Simulation checks
	//------------------------------------------------------------------------------	

	integer					StallCount, NumWriteSent, NumReadSent, NumReadReceived, CheckForStalls, StopGapPeriod;
	
	`ifdef SIMULATION
		initial begin
			StallCount = 0;
			NumWriteSent = 0;
			NumReadSent = 0;
			NumReadReceived = 0;
			CheckForStalls = 0;
			StopGapPeriod = 0;
			
			if (ERROR_MismatchReceivePattern) begin
				$display("[%m] ERROR: Traffic gen data mismatch (%x != %x)", DataOutExpected, DataOutActual);	
				$finish;
			end
		end
		
		always @(posedge Clock) begin
			if (ORAMDataOutValid) CheckForStalls = 1;
			if (DataOutActualValid) NumReadReceived = NumReadReceived + 1;
		
			if (CS == ST_Idle && ~CrossBufIn_DataInValidPre) StopGapPeriod = StopGapPeriod + 1;
			if (StopGapPeriod == StallThreshold) begin
				if (NumReadSent == NumReadReceived) begin
					$display("TrafficGen: ALL TESTS PASSED");
					$finish;
				end else begin
					$display("[%m] ERROR: Test finished; received %d reads (expected %d)", NumReadReceived, NumReadSent);
					$finish;
				end
			end
		
			if (ORAMCommandValid && ORAMCommandReady) begin
				StallCount = 0;
				
				if (ORAMCommand == TCMD_Update) NumWriteSent = NumWriteSent + 1;
				else							NumReadSent = NumReadSent + 1;
				
				$display("[%m @ %t] Traffic gen sent request: command=%x, addr=0x%x :: num writes = %d, num reads = %d", $time, ORAMCommand, ORAMPAddr, NumWriteSent, NumReadSent);
			end 
			else if (~ORAMCommandReady && CheckForStalls) begin
				StallCount = StallCount + 1;
				if (StallCount >= StallThreshold) begin
					$display("[%m] ERROR: ORAM has stalled.", $time);
					$finish;					
				end
			end
		end
	`endif
	
	//------------------------------------------------------------------------------
	// 	Command generation
	//------------------------------------------------------------------------------	
	
	Counter		#(			.Width(					TimeWidth))
				rd_ret_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CrossBufIn_DataInValidPre & CrossBufIn_DataInReadyPre),
							.In(					{TimeWidth{1'bx}}),
							.Count(					CmdCount));
							
													// Seed Format:			Cmd						Seed			AccessCount			Mask
	assign	CrossBufIn_DataInPre =					(CmdCount == 0) ? 	{	TCMD_Fill,				32'd0,			AccessCount_Fixed,	32'd0} : // Fill with some data
													(CmdCount == 1) ? 	{	TCMD_CmdRnd_AddrLin,	32'd0,			AccessCount_Fixed,	32'd0} : // Sequential rd/wr to initialized region
													(CmdCount == 2) ? 	{	TCMD_CmdRnd_AddrRnd,	32'dx,			AccessCount_Fixed,	AccessCount_Fixed - 32'd1} : // Random rd/wr to initialized region
																		{	TCMD_CmdRnd_AddrRnd,	32'dx,			NumValidBlock,		NumValidBlock - 32'd1} ; // Random rd/wr to anywhere
																		
	assign	CrossBufIn_DataInValidPre =				CmdCount < NumCommands;
	
	//------------------------------------------------------------------------------
	// 	[Send path] Hardware command generation
	//------------------------------------------------------------------------------
	wire AccessTransfer;	
	assign	AccessTransfer =						CrossBufIn_DataInValid & CrossBufIn_DataInReady;
	
	assign	CrossBufIn_DataInValid =				(CSAccess) ? 	CrossBufIn_DataInValidPre : 
													(CSSeed) ? 		PRNGOutValid : 1'b0;
	assign	CrossBufIn_DataInReadyPre =				(CSAccess) ? 	CrossBufIn_DataInReady : 
													(CSSeed) ? 		AccessThresholdReached : 1'b0;
	
	assign	ResetPRNG =								CS == ST_PrepSeed;
	
	assign	{AccessCommand, AccessEncSeed, AccessCount, AccessAddrMask} = CrossBufIn_DataInPre;
		
	assign	CrossBufIn_DataIn =						(CSAccess) ? 	{AccessCommand, AccessEncSeed, AccessCount, AccessAddrMask} : 
																	{SeedCommand, SeedAddress, SeedDataBase, SeedTime};

	assign	CSAccess =								CS == ST_Access;
	assign	CSSeed =								CS == ST_Seed;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Idle;
		else CS <= 									NS;
	end
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Idle : 
				if (CrossBufIn_DataInValidPre)
					NS =							ST_PrepSeed;
			ST_PrepSeed :
				NS =								ST_Seed;
			ST_Seed :
				if (AccessThresholdReached)
					NS =							ST_Idle;
		endcase
	end
	
	Counter		#(			.Width(					DBaseWidth))
				access_cnt(	.Clock(					Clock),
							.Reset(					Reset | AccessThresholdReached),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSSeed & AccessTransfer),
							.In(					{DBaseWidth{1'bx}}),
							.Count(					SeedAccessCount));					
	assign	AccessHalfThresholdReached =			SeedAccessCount >= (AccessCount >> 1);
	assign	AccessThresholdReached =				SeedAccessCount == AccessCount;

	LFSR			#(		.PWidth(				32),
							.SWidth(				1),
							.Poly(					32'h04C11DB7))
					rnd_b(	.Clock(					Clock),
							.Reset(					1'b0),
							.Load(					Reset | ResetPRNG),
							.Enable(				OutRandomBitReady),
							.PIn(					32'hffffffff),
							.SIn(					1'b0),
							.SOut(					OutRandomBit));
	FIFOShiftRound #(		.IWidth(				1),
							.OWidth(				ORAMU))
				addr_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				OutRandomBit),
							.InValid(				1'b1),
							.InAccept(				OutRandomBitReady),
							.OutData(				PRNGOutData),
							.OutValid(				PRNGOutValid),
							.OutReady(				CSSeed & CrossBufIn_DataInReady));

	assign	RandomAddress =							PRNGOutData & AccessAddrMask;
	assign	ScanAddress =							((AccessHalfThresholdReached) ?  SeedAccessCount - (AccessCount >> 1) : SeedAccessCount);
	assign	FillAddress =							SeedAccessCount;
	
	assign	RandomCommand =							(PRNGOutData[ORAMU-1]) ? TCMD_Update : TCMD_Read;
	assign	ScanCommand =							(AccessHalfThresholdReached) ? TCMD_Read : TCMD_Update;
	assign	FillCommand =							TCMD_Update;
	
	assign	CMD_RND =								AccessCommand == TCMD_CmdRnd_AddrLin || AccessCommand == TCMD_CmdRnd_AddrRnd;
	assign	CMD_FILL =								AccessCommand == TCMD_Fill;
	
	assign	ADDR_RND =								AccessCommand == TCMD_CmdLin_AddrRnd || AccessCommand == TCMD_CmdRnd_AddrRnd;
	assign	ADDR_FILL =								AccessCommand == TCMD_Fill;
	
	assign	SeedCommand =							(CMD_RND) ? 	RandomCommand : 
													(CMD_FILL) ? 	FillCommand :
																	ScanCommand;
																	
	assign	SeedAddress =							(ADDR_RND) ? 	RandomAddress[NVWidth-1:0] : 
													(ADDR_FILL) ? 	FillAddress[NVWidth-1:0] : 
																	ScanAddress[NVWidth-1:0]; 
	
	assign	SeedDataBase =							{DBaseWidth{1'b0}};
	assign	SeedTime =								{TimeWidth{1'b0}};
	
	assign	SWHistogramDump =						CSAccess && AccessCommand == TCMD_Start && CrossBufIn_DataInValid & CrossBufIn_DataInReady;
	
	//------------------------------------------------------------------------------
	// 	[Send path] Next command staging
	//------------------------------------------------------------------------------

	assign	{SendCommand, SendPAddr, SendDataBase, SendTimeDelay} =	CrossBufIn_DataIn;
	
	assign	ORAMRegInValid =						CrossBufIn_DataInValid & SendCommand != TCMD_Start;
	assign	CrossBufIn_DataInReady =				ORAMRegInReady;	
	
	FIFORegister #(			.Width(					BECMDWidth + ORAMU + DBaseWidth + TimeWidth))
				oram_freg(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{SendCommand[BECMDWidth-1:0], 	SendPAddr, SendDataBase, SendTimeDelay}),
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
	generate for (i = 0; i < OBUChunks; i = i + 1) begin:SEND_PATTERN
		assign	DataInWide[(i+1)*ORAMU-1:i*ORAMU] = ORAMPAddr + i;
	end endgenerate			
		
	FIFOShiftRound #(		.IWidth(				ORAMB),
							.OWidth(				FEDWidth))
				I_dta_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DataInWide),
							.InValid(				ORAMCommandTransfer & WriteCommandValid),
							.InAccept(				ORAMDataInFunnelReady),
							.OutData(				ORAMDataIn),
							.OutValid(				ORAMDataInValid),
							.OutReady(				ORAMDataInReady));
							
	//------------------------------------------------------------------------------
	// 	[Send path] Time gating
	//------------------------------------------------------------------------------
					
	// TODO simplify				
					
	assign	ORAMCommandValid =						ORAMDataInFunnelReady & ORAMRegOutValid;
	assign	ORAMRegOutReady =						ORAMDataInFunnelReady & ORAMCommandReady;
	
	assign	ORAMCommandTransfer =					ORAMCommandValid & ORAMCommandReady;

	//------------------------------------------------------------------------------
	// 	[Receive path] Shifts & buffers
	//------------------------------------------------------------------------------

	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				ORAMB),
							.Register(				1))
				O_check(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				ORAMDataOut),
							.InValid(				ORAMDataOutValid),
							.InAccept(				ORAMDataOutReady),
							.OutData(				DataOutActual),
							.OutValid(				DataOutActualValid),
							.OutReady(				1'b1));
			
	generate for (i = 0; i < OBUChunks; i = i + 1) begin:RECV_PATTERN
		assign	DataOutExpectedPre[(i+1)*ORAMU-1:i*ORAMU] = ORAMPAddr + i;
	end endgenerate
							
	FIFORegister #(			.Width(					ORAMB))
				I_check(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DataOutExpectedPre),
							.InValid(				ORAMCommandTransfer & ~WriteCommandValid),
							.InAccept(				),
							.OutData(				DataOutExpected),
							.OutSend(				DataOutExpectedValid),
							.OutReady(				DataOutActualValid));								
	wire Error_ReceivePattern;			
	assign	ERROR_MismatchReceivePattern =			(DataOutActual != {(ORAMB/32){FakePattern}}) && (DataOutActual != DataOutExpected) && DataOutActualValid; 		
				
	//------------------------------------------------------------------------------
	//	Messages
	//------------------------------------------------------------------------------

	Register	#(			.Width(					1))
				error(		.Clock(					Clock),
							.Reset(					Reset),
							.Set(					ERROR_MismatchReceivePattern),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					Error_ReceivePattern));	
	
	assign	JTAG_Traffic =							Error_ReceivePattern;
	
	//------------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
