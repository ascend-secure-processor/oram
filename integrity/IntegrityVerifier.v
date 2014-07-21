
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		IntegrityVerifier
//	Desc:		The O(1) integrity verification scheme.
//==============================================================================
module IntegrityVerifier(
	Clock, Reset,

	FECommand, FEPAddr, FECurrentLeaf, FERemappedLeaf, FECurrentCounter, FERemappedCounter,
	FECommandValid, FECommandReady,
	FELoadData, 
	FELoadValid, FELoadReady,
	FEStoreData,
	FEStoreValid, FEStoreReady,
	
	BECommand, BEPAddr, BECurrentLeaf, BERemappedLeaf,
	BECommandValid, BECommandReady,
	BELoadData, 
	BELoadValid, BELoadReady,
	BEStoreData,
	BEStoreValid, BEStoreReady
	);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	`include "CommandsLocal.vh"
	`include "IVLocal.vh"
	
	localparam				HashByteCount =			`divceil(AESEntropy + ORAMU + ORAMB, FEDWidth) * `divceil(FEDWidth, 8),
							FullDigestWidth = 		224;
							
	localparam				STWidth =				3,
							ST_Idle =				3'd0,
							ST_WriteMI =			3'd1,
							ST_WriteP =				3'd2,
							ST_WriteMO =			3'd3,
							ST_WriteCommand =		3'd4,
							ST_ReadCommand =		3'd5,
							ST_ReadCheck =			3'd6,
							ST_Error =				3'd7;
							
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
	input 					Clock, Reset;
	
	//--------------------------------------------------------------------------
	//	Frontend Interface
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] FECommand;
	input	[ORAMU-1:0]		FEPAddr;
	input	[ORAML-1:0]		FECurrentLeaf;
	input	[ORAML-1:0]		FERemappedLeaf;
	input	[AESEntropy-1:0] FECurrentCounter;
	input	[AESEntropy-1:0] FERemappedCounter;
	input					FECommandValid;
	output 					FECommandReady;

	output	[FEDWidth-1:0]	FELoadData;
	output					FELoadValid;
	input 					FELoadReady;

	input	[FEDWidth-1:0]	FEStoreData;
	input 					FEStoreValid;
	output 					FEStoreReady;
	
	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------

	output	[BECMDWidth-1:0] BECommand;
	output	[ORAMU-1:0]		BEPAddr;
	output	[ORAML-1:0]		BECurrentLeaf;
	output	[ORAML-1:0]		BERemappedLeaf;
	output					BECommandValid;
	input 					BECommandReady;

	input	[FEDWidth-1:0]	BELoadData;
	input					BELoadValid;
	output 					BELoadReady;

	output	[FEDWidth-1:0]	BEStoreData;
	output 					BEStoreValid;
	input 					BEStoreReady;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	// Control logic
	
	reg		[STWidth-1:0]	CS, NS;
	
	wire					ERROR_IV;
	
	wire					FECommandValid_Final, FECommandReady_Final;
	
	wire	[BECMDWidth-1:0] Command_Int;
	wire	[ORAMU-1:0]		PAddr_Int;
	wire	[ORAML-1:0]		CurrentLeaf_Int, RemappedLeaf_Int;

	wire	[AESEntropy-1:0] FECurrentCounter_Int, FERemappedCounter_Int;
	wire					Command_IntValid, Command_IntReady;

	wire					CSIdle, CSWriteMI, CSWriteP, CSWriteMO, CSWriteCommand, CSReadCommand;	
	
	wire					SMI_Terminal, SP_Terminal, SMO_Terminal, LD_Terminal;
	
	wire					CommandTransfer;
	
	// Store Path	
		
	wire	[MACHPADWidth-1:0] StoreMACHeader_Wide;
	wire	[FEDWidth-1:0]	StoreMACHeader;
	wire	[BFHWidth-1:0]	SMICount;
	
	wire	[FEDWidth-1:0]	FEStoreMAC;
	
	wire					StoreTransfer, HashTransfer;
	
	// Load Path
	
	wire					BlockLoaded, LoadingMAC;
	
	// Hash engine
	
	wire	[FEDWidth-1:0]	HashDataIn;
	wire					HashDataInReady, HashDataInValid;
	
	wire	[FullDigestWidth-1:0] HashOut;
	wire					HashOutReady, HashOutValid;
	
	wire	[ORAMH-1:0] MACOut;
	wire	[MACPADWidth-1:0] MACOut_Padded;	
	
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------
	
	`ifdef SIMULATION
		always @(posedge Clock) begin

		end
	`endif

	//--------------------------------------------------------------------------
	//	Control logic
	//--------------------------------------------------------------------------
	
	assign	ERROR_IV =								1'b0; // TODO set to IV violation						
	
	assign	FECommandValid_Final =					CSIdle && FECommandValid;	
	assign	FECommandReady =						CSIdle && FECommandReady_Final;
		
	FIFORegister #(			.Width(					BECMDWidth + ORAMU + ORAML*2),
							.BWLatency(				1))
				cmd_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{FECommand,		FEPAddr, 	FECurrentLeaf, 	FERemappedLeaf}),
							.InValid(				FECommandValid_Final),
							.InAccept(				FECommandReady_Final),
							.OutData(				{Command_Int,	PAddr_Int,	CurrentLeaf_Int,RemappedLeaf_Int}),
							.OutSend(				Command_IntValid),
							.OutReady(				Command_IntReady));

	Register #(				.Width(					AESEntropy*2))
				cnt_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				FECommandValid_Final && FECommandReady_Final),
							.In(					{FECurrentCounter, 		FERemappedCounter}),
							.Out(					{FECurrentCounter_Int, 	FERemappedCounter_Int}));		
	
	assign	BECommand =								Command_Int;
	assign	BEPAddr =								PAddr_Int;
	assign	BECurrentLeaf =							CurrentLeaf_Int;
	assign	BERemappedLeaf =						RemappedLeaf_Int;
	
	assign	BECommandValid =						(CSWriteCommand || CSReadCommand) && Command_IntValid;
	assign	Command_IntReady =						(CSWriteCommand || CSReadCommand) && BECommandReady;
	
	assign	CommandTransfer =						BECommandValid && BECommandReady;
	
	assign	CSIdle =								CS == ST_Idle; 
	assign	CSWriteMI =								CS == ST_WriteMI;
	assign	CSWriteP =								CS == ST_WriteP;
	assign	CSWriteMO =								CS == ST_WriteMO;
	assign	CSWriteCommand =						CS == ST_WriteCommand;
	assign	CSReadCommand =							CS == ST_ReadCommand;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Idle;
		else CS <= 									NS;
	end

	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Idle :
				if (ERROR_IV)
					NS =							ST_Error;
				else if (Command_IntValid && (	Command_Int == BECMD_Update || 
												Command_Int == BECMD_Append))
					NS =							ST_WriteMI;
				else if (Command_IntValid)
					NS =							ST_ReadCommand;
			ST_WriteMI :
				if (SMI_Terminal)
					NS =							ST_WriteP;
			ST_WriteP :
				if (SP_Terminal)
					NS =							ST_WriteMO;
			ST_WriteMO :
				if (SMO_Terminal)
					NS =							ST_WriteCommand;
			ST_WriteCommand :
				if (CommandTransfer)
					NS =							ST_Idle;
			ST_ReadCommand :
				if (CommandTransfer)
					NS =							ST_ReadCheck;
			ST_ReadCheck :
				if (LD_Terminal)
					NS =							ST_Idle;
		endcase
	end
	
	//--------------------------------------------------------------------------
	//	Store Path
	//--------------------------------------------------------------------------

	assign	BEStoreData =							(CSWriteP) ? FEStoreData : FEStoreMAC;
	assign	BEStoreValid =							(CSWriteP && FEStoreValid && HashDataInReady) ||
													(CSWriteMO && HashOutValid);
	assign	FEStoreReady =							CSWriteP && BEStoreReady && HashDataInReady;
	
	assign	StoreTransfer =							BEStoreValid && BEStoreReady;	
	
	//
	// Phase 1: Write {PAddr,Count} to hash engine
	//
	
	assign	StoreMACHeader_Wide =					{SMH_Padding, PAddr_Int, FECurrentCounter_Int};
	
	CountAlarm  #(  		.Threshold(             MACHeader_FEDChunks))
				smh_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				CSWriteMI && HashTransfer),
							.Count(					SMICount),
							.Done(					SMI_Terminal));		
	Mux	#(.Width(FEDWidth), .NPorts(MACHeader_FEDChunks), .SelectCode(0)) SMI_mux(SMICount, StoreMACHeader_Wide, StoreMACHeader);	
		
	assign	StoreHashDataIn =						(CSWriteMI) ? StoreMACHeader : FEStoreData;
	
	//
	// Phase 2: Write block to backend & hash engine
	//
	
	CountAlarm  #(  		.Threshold(             BlkSize_FEDChunks))
				smp_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				CSWriteP && StoreTransfer),
							.Done(					SP_Terminal));
							 
	//
	// Phase 3: Write MAC to backend
	//
	
	CountAlarm  #(  		.Threshold(             MAC_FEDChunks))
				smo_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				CSWriteMO && StoreTransfer),
							.Count(					SMOCount),
							.Done(					SMO_Terminal));	
	Mux	#(.Width(FEDWidth), .NPorts(MAC_FEDChunks), .SelectCode(0)) SMO_mux(SMOCount, MACOut_Padded, FEStoreMAC);							
							
	//--------------------------------------------------------------------------
	//	Load Path
	//--------------------------------------------------------------------------

	CountAlarm  #(  		.IThreshold(			BlkSize_FEDChunks),
							.Threshold(             BlkSize_FEDChunks + MAC_FEDChunks))
				MAC_lc(		.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				BELoadValid && FELoadReady),
							.Intermediate(			BlockLoaded),
							.Done(					LD_Terminal));	
		
	Register1b ldm_m(Clock, Reset || LD_Terminal, BlockLoaded, LoadingMAC);
		
	assign	FELoadData =							BELoadData;
	assign	FELoadValid	=							BELoadValid && !LoadingMAC;
	assign	BELoadReady	=							FELoadReady;
	
	//--------------------------------------------------------------------------
	//	MAC core
	//--------------------------------------------------------------------------
	
	assign	HashDataIn =							StoreHashDataIn;
	assign	HashDataInValid =						(CSWriteMI) ||
													(CSWriteP && FEStoreValid && BEStoreReady);
	
	assign	HashTransfer =							HashDataInReady && HashDataInValid;
	
	Keccak_WF #(			.IWidth(				FEDWidth),
							.HashByteCount(			HashByteCount),
							.KeyLength(				HashKeyLength),
							.Key(					128'h 5e_7a_2a_9d_43_35_74_5b_85_ce_e5_b3_c0_c1_23_a6),
							.HashOutWidth(			FullDigestWidth))
				sha3(		.Clock(					Clock), 
							.Reset(					Reset), 
							.DataInReady(			HashDataInReady),
							.DataInValid(			HashDataInValid),
							.DataIn(				HashDataIn),
							.HashOutReady(			HashOutReady),
							.HashOutValid(			HashOutValid),
							.HashOut(				HashOut));
	assign	MACOut =								HashOut[ORAMH-1:0];
	assign	MACOut_Padded =							{{MACPADWidth-AESEntropy{1'b0}} , MACOut};
	
	assign	HashOutReady =							SMO_Terminal;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
