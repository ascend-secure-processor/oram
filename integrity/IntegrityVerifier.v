
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
	
	BECommand, BEPAddr, BECurrentLeaf, BERemappedLeaf, BEMAC,
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
	
	localparam				HashByteCount =				`divceil(AESEntropy + ORAMU + ORAMB, 8),
							FullDigestWidth = 			224;
		
	localparam				STWidth =					,
							
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
	
	reg		[STWidth-1:0]	CS, NS;
	
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
	
	ERROR_IV
	Command_Int,
	PAddr_Int,	
	CurrentLeaf_Int,
	RemappedLeaf_Int,	
	FECurrentCounter_Int, 	
	FERemappedCounter_Int,
	Command_IntValid,
	Command_IntReady
							
	FIFORegister #(			.Width(					BECMDWidth + ORAMU + ORAML*2 + AESEntropy*2),
							.BWLatency(				1))
				cmd_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{FECommand,		FEPAddr, 	FECurrentLeaf, 	FERemappedLeaf,		FECurrentCounter, 		FERemappedCounter}),
							.InValid(				FECommandValid),
							.InAccept(				FECommandReady),
							.OutData(				{Command_Int,	PAddr_Int,	CurrentLeaf_Int,RemappedLeaf_Int,	FECurrentCounter_Int, 	FERemappedCounter_Int}),
							.OutSend(				Command_IntValid),
							.OutReady(				Command_IntReady));
		
	CSWriteMI
	CSWriteP
	CSWriteMO
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Idle;
		else CS <= 									NS;
	end

	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Reset : 
				if (ResetDone) 
					NS =						 	ST_Idle;
			ST_Idle :
				if (ERROR_IV)
					NS =							ST_Error;
				if (Command_IntValid && Command_Int == )
					NS =							ST_WriteMI;
				if (Command_IntValid && Command_Int == )
					NS =							ST_Read;
			ST_WriteMI :
				if (SMI_Terminal)
					NS =							ST_WriteP;
			ST_WriteP :
				if (SP_Terminal)
					NS =							ST_WriteMO;
			ST_WriteMO :
				if (SMO_Terminal)
					NS =							ST_Idle;
		endcase
	end
	
	//--------------------------------------------------------------------------
	//	Store Path
	//--------------------------------------------------------------------------

	
	localparam				BlkSize_FEDChunks = 	`divceil(ORAMB, FEDWidth),
							MIWidth =				ORAMU + AESEntropy,
							
							Mac_FEDChunks =			`divceil(AESEntropy, FEDWidth),
							MacHeader_FEDChunks =	`divceil(MIWidth, FEDWidth),
							
							MACPADWidth =			AESEntropy * Mac_FEDChunks,
							SMH_Padding =			MacHeader_FEDChunks * FEDWidth - MIWidth,
							BFHWidth =				`log2(MacHeader_FEDChunks),
							BFPWidth =				`log2(BlkSize_FEDChunks);
		
	
	StoreMACHeader_Wide
	StoreMACHeader
	InsertStoreMACHeader
	SMHCount
	
	FEStoreMAC
	
	FEStoreData
	
	StoreTransfer
	
	CSWriteMO
	
	assign	BEStoreData =							(CSWriteP) ? FEStoreData : FEStoreMAC;
	assign	BEStoreValid =							(CSWriteP && FEStoreValid && HashDataInReady) ||
													(CSWriteMO && HashOutValid);
	assign	FEStoreReady =							CSWriteP && BEStoreReady && HashDataInReady;
	
	assign	StoreTransfer =							BEStoreValid && BEStoreReady;
	
	SMI_Terminal
	SP_Terminal
	SMO_Terminal
	
	//
	// Phase 1: Write {PAddr,Count} to hash engine
	//
	
	assign	StoreMACHeader_Wide =					{SMH_Padding, PAddr_Int, FECurrentCounter_Int};
	
	CountAlarm  #(  		.Threshold(             MacHeader_FEDChunks))
				smh_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				CSWriteMI && HashTransfer),
							.Count(					SMHCount),
							.Done(					SMI_Terminal));		
	Mux	#(.Width(FEDWidth), .NPorts(MacHeader_FEDChunks), .SelectCode(0)) SMH_mux(SMHCount, StoreMACHeader_Wide, StoreMACHeader);	
		
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
	
	CountAlarm  #(  		.Threshold(             Mac_FEDChunks))
				smo_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				CSWriteMO && StoreTransfer),
							.Count(					SMOCount),
							.Done(					SMO_Terminal));	
	Mux	#(.Width(FEDWidth), .NPorts(Mac_FEDChunks), .SelectCode(0)) SMH_mux(SMOCount, MACOut_Padded, FEStoreMAC);							
							
	//--------------------------------------------------------------------------
	//	Load Path
	//--------------------------------------------------------------------------

	assign	FELoadData =							BELoadData;
	assign	FELoadValid	=							BELoadValid;
	assign	BELoadReady	=							FELoadReady;
	
	//--------------------------------------------------------------------------
	//	MAC core
	//--------------------------------------------------------------------------
	
	HashDataIn
	HashDataInReady
	HashDataInValid
	
	HashOut
	HashOutReady
	HashOutValid
	
	MACOut
	MACOut_Padded
	
	assign	HashDataIn =							StoreHashDataIn;
	assign	HashDataInValid =						(CSWriteMI) ||
													(CSWriteP && FEStoreValid && BEStoreReady);
	
	assign	HashTransfer =							HashDataInReady && HashDataInValid;
	
	Keccak_WF #(			.IWidth(				FEDWidth),
							.HashByteCount(			HashByteCount),
							.KeyLength(				HashKeyLength),
							.Key(					128'h 5e_7a_2a_9d_43_35_74_5b_85_ce_e5_b3_c0_c1_23_a6)
							.HashOutWidth(			FullDigestWidth))
				sha3(		.Clock(					Clock), 
							.Reset(					Reset), 
							.DataInReady(			HashDataInReady),
							.DataInValid(			HashDataInValid),
							.DataIn(				HashDataIn),
							.HashOutReady(			HashOutReady),
							.HashOutValid(			HashOutValid),
							.HashOut(				HashOut));
	assign	MACOut =								HashOut[HashPreimage-1:0];
	assign	MACOut_Padded =							{{MACPADWidth-AESEntropy{1'b0}} , MACOut};
	
	assign	HashOutReady =							SMO_Terminal;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
