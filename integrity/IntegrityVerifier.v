
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
							
	localparam				STWidth =				4,
							ST_Idle =				4'd0,
							ST_WriteMI =			4'd1,
							ST_WriteP =				4'd2,
							ST_WriteMO =			4'd3,
							ST_WriteCommand =		4'd4,
							ST_ReadCommand =		4'd5,
							ST_ReadMI =				4'd6,
							ST_ReadP =				4'd7,
							ST_ReadMO =				4'd8,
							ST_ReadCheck =			4'd9,
							ST_ReadFETransfer =		4'd10,
							ST_ReadTurnaround =		4'd11,
							ST_Error =				4'd12;
													
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

	wire	[BECMDWidth-1:0] FECommand_Final;
	wire	[ORAMU-1:0]		FEPAddr_Final, FEShadowPAddr;
	wire	[ORAML-1:0]		FECurrentLeaf_Final, FERemappedLeaf_Final, FEShadowLeaf;
	
	wire	[AESEntropy-1:0] FECurrentCounter_Int, FERemappedCounter_Int;
	wire					Command_IntValid, Command_IntReady;

	wire					CSIdle, CSMI, CSWriteP, CSWriteMO, CSWriteCommand, 
							CSReadCommand, CSReadP, CSReadMO, CSReadCheck, CSReadFETransfer, CSReadTurnaround;	
	
	wire					SMI_Terminal, SP_Terminal, SMO_Terminal;
	
	wire					CommandTransfer, FECommandTransfer, BELoadTransfer, FELoadTransfer;
	
	// Store Path	
		
	wire	[MIPADWidth-1:0] StoreMACHeader_Wide;
	wire	[FEDWidth-1:0]	StoreMACHeader;
	wire	[BFHWidth-1:0]	SMICount;
	
	wire	[FEDWidth-1:0]	FEStoreMAC;
	
	wire					StoreTransfer, HashTransfer;

	wire	[FEDWidth-1:0]	StoreSourceData;
	wire					StoreSourceValid;
	
	wire					CSMOTransfer, CSPTransfer;	
	
	// Load Path
	
	wire	[MACPADWidth-1:0] LoadMAC_Wide;
	
	wire	[ORAMH-1:0]		LoadMAC;
	wire					LoadMACValid, LoadMACInReady, MACCheckComplete;
	
	wire					LDD_WE;
	wire	[BFPWidth-1:0]	LDD_Addr;
	
	wire					StoringLoadMode;
	
	// Hash engine
	
	wire	[FEDWidth-1:0]	HashDataIn;
	wire					HashDataInReady, HashDataInValid;
	
	wire	[FullDigestWidth-1:0] HashOut;
	wire					HashOutReady, HashOutValid;
	
	wire	[ORAMH-1:0] 	MACOut;
	wire	[MACPADWidth-1:0] MACOut_Padded;	
	
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (ERROR_IV !== 1'b0) begin
				$display("ERROR: Integrity violation (expected,actual) : (%x:%x)", MACOut, LoadMAC);
				$finish;
			end
			
			if (HashDataInValid && HashDataInReady) begin
				$display("[IV] Hash in: %x", HashDataIn);
			end
			
			if (HashOutValid && HashOutReady) begin
				$display("[IV] Hash out: %x", HashOut);
			end
			
			if (Command_IntValid && Command_IntReady) begin
				$display("[IV] Command: %x %x %x %x", Command_Int, PAddr_Int, CurrentLeaf_Int, RemappedLeaf_Int);
			end

			if (BEStoreValid && BEStoreReady) begin
				$display("[IV] Store data: %x", BEStoreData);
			end
			
			if (BELoadValid && BELoadReady) begin
				$display("[IV] Load data: %x", BELoadData);
			end
		end
	`endif

	//--------------------------------------------------------------------------
	//	Control logic
	//--------------------------------------------------------------------------
	
	assign	FECommandValid_Final =					(CSIdle && FECommandValid) || CSReadTurnaround;
	assign	FECommandReady =						CSIdle && FECommandReady_Final;
	
	assign	FECommand_Final =						(FECommand == BECMD_Read) ? BECMD_ReadRmv : 
													(CSReadTurnaround) ? 		BECMD_Append : 
																				FECommand;
	assign	FEPAddr_Final =							(CSReadTurnaround) ? 		FEShadowPAddr :
																				FEPAddr;
	assign	FECurrentLeaf_Final =					(CSReadTurnaround) ? 		{ORAML{1'bx}} :
																				FECurrentLeaf;
	assign	FERemappedLeaf_Final =					(CSReadTurnaround) ? 		FEShadowLeaf : 
																				FERemappedLeaf;
		
	FIFORegister #(			.Width(					BECMDWidth + ORAMU + ORAML*2),
							.BWLatency(				1))
				cmd_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{FECommand_Final,	FEPAddr_Final, 	FECurrentLeaf_Final, 	FERemappedLeaf_Final}),
							.InValid(				FECommandValid_Final),
							.InAccept(				FECommandReady_Final),
							.OutData(				{Command_Int,		PAddr_Int,		CurrentLeaf_Int,		RemappedLeaf_Int}),
							.OutSend(				Command_IntValid),
							.OutReady(				Command_IntReady));

	Register #(				.Width(					ORAMU + ORAML + AESEntropy*2))
				shdw_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				FECommandValid_Final && FECommandReady_Final),
							.In(					{FEPAddr,		FERemappedLeaf,	FECurrentCounter,		FERemappedCounter}),
							.Out(					{FEShadowPAddr, FEShadowLeaf, 	FECurrentCounter_Int, 	FERemappedCounter_Int}));		
	
	assign	BECommand =								Command_Int;
	assign	BEPAddr =								PAddr_Int;
	assign	BECurrentLeaf =							CurrentLeaf_Int;
	assign	BERemappedLeaf =						RemappedLeaf_Int;
	
	assign	BECommandValid =						(CSWriteCommand || CSReadCommand) && Command_IntValid;
	assign	Command_IntReady =						(CSWriteCommand || CSReadCommand) && BECommandReady;
	
	assign	FECommandTransfer =						FECommandValid_Final && FECommandReady_Final;
	assign	CommandTransfer =						BECommandValid && BECommandReady;
	
	assign	StoreTransfer =							BEStoreValid && BEStoreReady;	
	assign	BELoadTransfer =						BELoadValid && BELoadReady;
	assign	FELoadTransfer =						FELoadValid && FELoadReady;
	
	assign	CSIdle =								CS == ST_Idle; 
	assign	CSMI =									CS == ST_WriteMI || CS == ST_ReadMI;
	assign	CSWriteP =								CS == ST_WriteP;
	assign	CSReadP =								CS == ST_ReadP;
	assign	CSReadMO =								CS == ST_ReadMO;
	assign	CSWriteMO =								CS == ST_WriteMO;
	assign	CSWriteCommand =						CS == ST_WriteCommand;
	assign	CSReadCommand =							CS == ST_ReadCommand;
	assign	CSReadCheck =							CS == ST_ReadCheck;
	assign	CSReadFETransfer =						CS == ST_ReadFETransfer;
	assign	CSReadTurnaround =						CS == ST_ReadTurnaround;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Idle;
		else CS <= 									NS;
	end

	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Idle :
				if (Command_IntValid && (	Command_Int == BECMD_Update || 
											Command_Int == BECMD_Append))
					NS =							ST_WriteMI;
				else if (Command_IntValid)
					NS =							ST_ReadMI;
			//
			// Write states
			//
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
			//
			// Read states
			//
			ST_ReadMI :
				if (SMI_Terminal)
					NS =							ST_ReadCommand;
			ST_ReadCommand :
				if (CommandTransfer)
					NS =							ST_ReadP;
			ST_ReadP :
				if (SP_Terminal)
					NS =							ST_ReadMO;
			ST_ReadMO :
				if (SMO_Terminal)
					NS =							ST_ReadCheck;
			ST_ReadCheck :
				if (ERROR_IV)
					NS =							ST_Error;
				else if (MACCheckComplete)
					NS =							ST_ReadFETransfer;
			ST_ReadFETransfer :
				if (SP_Terminal)
					NS =							ST_ReadTurnaround;
			ST_ReadTurnaround :
				if (FECommandTransfer)
					NS =							ST_WriteMI;
		endcase
	end
	
	//--------------------------------------------------------------------------
	//	Load U,C into hash engine
	//--------------------------------------------------------------------------

	assign	StoreMACHeader_Wide =					{
														{MIPADWidth - MIWidth{1'b0}}, 
														PAddr_Int, 
														(StoringLoadMode) ? FERemappedCounter_Int : FECurrentCounter_Int
													};
	
	CountAlarm  #(  		.Threshold(             MI_FEDChunks))
				smh_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				CSMI && HashTransfer),
							.Count(					SMICount),
							.Done(					SMI_Terminal));		
	Mux	#(.Width(FEDWidth), .NPorts(MI_FEDChunks), .SelectCode(0)) SMI_mux(SMICount, StoreMACHeader_Wide, StoreMACHeader);	

	//--------------------------------------------------------------------------
	//	Move Data from FE<->BE, load hash engine with data
	//--------------------------------------------------------------------------
	 
	assign	CSPTransfer =							(CSWriteP && StoreTransfer) || 
													(CSReadP && BELoadTransfer) ||
													(CSReadFETransfer && FELoadTransfer);
	
	CountAlarm  #(  		.Threshold(             BlkSize_FEDChunks))
				smp_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				CSPTransfer),
							.Count(					LDD_Addr),
							.Done(					SP_Terminal));
			
	//--------------------------------------------------------------------------
	//	Rd/Wr hash from/to data stream
	//--------------------------------------------------------------------------
	
	assign	CSMOTransfer =							(CSWriteMO && StoreTransfer) || 
													(CSReadMO && BELoadTransfer);	
			
	CountAlarm  #(  		.Threshold(             MAC_FEDChunks))
				smo_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				CSMOTransfer),
							.Count(					SMOCount),
							.Done(					SMO_Terminal));	
			
	//--------------------------------------------------------------------------
	//	Store Path
	//--------------------------------------------------------------------------
	
	assign	StoreSourceData =						(StoringLoadMode) ? FELoadData : FEStoreData;
	assign	StoreSourceValid = 						FEStoreValid || StoringLoadMode;
	
	assign	BEStoreData =							(CSWriteP) ? StoreSourceData : FEStoreMAC;
	assign	BEStoreValid =							(CSWriteP 	&& StoreSourceValid && HashDataInReady) ||
													(CSWriteMO 	&& HashOutValid);

	assign	FEStoreReady =							 CSWriteP 	&& BEStoreReady && HashDataInReady && ~StoringLoadMode;
	
	Mux	#(.Width(FEDWidth), .NPorts(MAC_FEDChunks), .SelectCode(0)) SMO_mux(SMOCount, MACOut_Padded, FEStoreMAC);
							
	//--------------------------------------------------------------------------
	//	Load Path
	//--------------------------------------------------------------------------

	assign	FELoadValid	=							CSReadFETransfer;
	assign	BELoadReady	=							(CSReadP  && HashDataInReady) ||
													(CSReadMO && LoadMACInReady);
	
	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				MACPADWidth),
							.Reverse(				1))
				st_m_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BELoadData),
							.InValid(				CSReadMO && BELoadTransfer),
							.InAccept(				LoadMACInReady),
							.OutData(				LoadMAC_Wide),
							.OutValid(				LoadMACValid),
							.OutReady(				MACCheckComplete));
	assign	LoadMAC =								LoadMAC_Wide[ORAMH-1:0];
	
	assign	MACCheckComplete =						CSReadCheck && LoadMACValid && HashOutValid;
	assign	ERROR_IV =								MACCheckComplete && (LoadMAC != MACOut);
	
	Register1b ld_m(Clock, Reset || CSIdle, CSReadP, StoringLoadMode);
	
	assign	LDD_WE =								CSReadP && BELoadTransfer;
	
	RAM			#(			.DWidth(				FEDWidth),
							.AWidth(				BFPWidth),
							.RLatency(				0)
							`ifdef ASIC , .ASIC(1) `endif)
				ld_d(		.Clock(					Clock),
							.Reset(					1'b0),
							.Enable(				1'b1),
							.Write(					LDD_WE),
							.Address(				LDD_Addr),
							.DIn(					BELoadData),
							.DOut(					FELoadData));
	
	//--------------------------------------------------------------------------
	//	MAC core
	//--------------------------------------------------------------------------
	
	assign	HashDataIn =							(CSMI) ? 			StoreMACHeader : 
													(CSReadP) ? 		BELoadData : // on load
													(StoringLoadMode) ? FELoadData : // on writeback
																		FEStoreData;
	assign	HashDataInValid =						CSMI ||
													(CSWriteP && StoreSourceValid && BEStoreReady) ||
													(CSReadP && BELoadValid);
	
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
	assign	MACOut_Padded =							{{MACPADWidth-ORAMH{1'b0}} , MACOut};
	
	assign	HashOutReady =							(CSWriteMO && SMO_Terminal) || MACCheckComplete;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
