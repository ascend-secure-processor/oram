
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		IntegrityVerifier
//	Desc:		The O(1) integrity verification / PMMAC scheme.  This module 
//				also implements write masks.  From UORAMController, this module 
//				performs the following conversion for commands:
//
//				From UORAM:		To Backend:			Notes:
//				Update			ReadRmv + Append	ReadRmv merges write data with mask
//				Append			Append
//				Read			ReadRmv + Append	ReadRmv checks & updates hash
//				ReadRmv			ReadRmv
//==============================================================================
module IntegrityVerifier(
	Clock, Reset,

	FECommand, FEPAddr, FEWMask, FECurrentCounter, FERemappedCounter,
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
	BEStoreValid, BEStoreReady,
	
	JTAG_PMMAC
	);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	`include "CommandsLocal.vh"
	`include "DMLocal.vh"
	`include "IVLocal.vh"
	`include "JTAG.vh"
	
	localparam				HashByteCount =			`divceil(AESEntropy + ORAMU + ORAMB, FEDWidth) * `divceil(FEDWidth, 8),
							FullDigestWidth = 		224,
							MFWidth =				`log2(MAC_FEDChunks),
							DMSWidth = 				`divceil(FEDWidth, 8);
		
	localparam				STWidth =				4,
							ST_Idle =				4'd0,
							ST_WriteMI =			4'd1,
							ST_WriteP =				4'd2,
							ST_WriteMO =			4'd3,
							ST_WriteLWait =			4'd4,
							ST_WriteCommand =		4'd5,
							ST_ConvertLeafWait =	4'd6,
							ST_PreStoreWriteData =	4'd7,
							ST_ReadCommand =		4'd8,
							ST_ReadMI =				4'd9,
							ST_ReadP =				4'd10,
							ST_ReadMO =				4'd11,
							ST_ReadCheck =			4'd12,
							ST_ReadFETransfer =		4'd13,
							ST_ReadTurnaround =		4'd14,
							ST_Error =				4'd15;
	
	localparam				STAESWidth =			3,
							ST_AES_Idle =			3'd0,
							ST_AES_Start1 =			3'd1,
							ST_AES_Wait1 =			3'd2,
							ST_AES_Start2 =			3'd3,
							ST_AES_Wait2 =			3'd4,
							ST_AES_Done =			3'd5;
			
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
	input 					Clock, Reset;
	
	//--------------------------------------------------------------------------
	//	Frontend Interface
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] FECommand;
	input	[ORAMU-1:0]		FEPAddr;
	input	[DMWidth-1:0]	FEWMask;
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
	//	Status/Debugging Interface
	//--------------------------------------------------------------------------
	
	output	[JTWidth_PMMAC-1:0] JTAG_PMMAC;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	// Control logic
	
	reg		[STWidth-1:0]	CS, NS;
	
	wire					IVViolation;
	
	wire					RdRmv_Terminal, CommandIsReadRmv;
	wire					CommandIsUpdate, Update_Terminal;
	
	wire					FECommandValid_Final, FECommandReady_Final;
	
	wire	[DMSWidth-1:0]	FEWMask_Chunk;
	wire	[FEDWidth-1:0]	FEWMask_ChunkWide;
	
	wire	[BECMDWidth-1:0] Command_Int;
	wire	[ORAMU-1:0]		PAddr_Int;
	wire	[ORAML-1:0]		CurrentLeaf_Int, RemappedLeaf_Int;

	wire	[BECMDWidth-1:0] FECommand_Final;
	wire	[ORAMU-1:0]		FEPAddr_Final, FEShadowPAddr;
	
	wire	[AESEntropy-1:0] FECurrentCounter_Int, FERemappedCounter_Int;
	wire					Command_IntValid, Command_IntReady;

	wire					CSIdle, CSReadMI, CSMI, CSWriteP, CSWriteMO, CSWriteCommand, CSPreStoreUpdate,
							CSReadCommand, CSReadP, CSReadMO, CSReadCheck, CSReadFETransfer, CSReadTurnaround;	
	
	wire					SMI_Terminal, SP_Terminal, SMO_Terminal;
	
	wire					CommandTransfer, FECommandTransfer, BELoadTransfer, FELoadTransfer;
	
	wire					BEPayloadWriting, BEPayloadReading;
	
	// PRF logic
	
	reg		[STAESWidth-1:0] NS_AES, CS_AES;
	
	wire					AESStart, AESDone;
	
	wire	[AESWidth-1:0]	AESDataIn, AESDataOut;
	wire	[ORAML-1:0]		AESLeafOut;
	
	wire					CSAESDone, CSAESStart1, CSAESWait1, CSAESWait2;
	
	// Store Path	
		
	wire	[MIPADWidth-1:0] StoreMACHeader_Wide;
	wire	[FEDWidth-1:0]	StoreMACHeader;
	wire	[BFHWidth-1:0]	SMICount;
	
	wire	[FEDWidth-1:0]	FEStoreMAC;
	wire	[MFWidth-1:0]	SMOCount;
	
	wire					FEStoreTransfer, BEStoreTransfer, HashTransfer;

	wire	[FEDWidth-1:0]	StoreSourceData;
	wire					StoreSourceValid;
	
	wire					CSMOTransfer, CSPTransfer;	
	
	// Load Path
	
	wire	[MACPADWidth-1:0] LoadMAC_Wide;
	
	wire	[ORAMH-1:0]		LoadMAC;
	wire					LoadMACValid, LoadMACInReady, MACCheckComplete;
	
	wire					LDD_WE;
	wire	[BFPWidth-1:0]	LDD_Addr;
	
	wire	[FEDWidth-1:0]	MaskedData, LDD_WData;
	
	wire					ReStoringLoadData;
	
	// Hash engine
	
	wire	[FEDWidth-1:0]	HashDataIn;
	wire					HashDataInReady, HashDataInValid;
	
	wire	[FullDigestWidth-1:0] HashOut;
	wire					HashOutReady, HashOutValid;
	
	wire	[ORAMH-1:0] 	MACOut;
	wire	[MACPADWidth-1:0] MACOut_Padded;	
	
	// Debugging
	
	wire					ERROR_IV;
	
	//--------------------------------------------------------------------------
	//	Initial state
	//--------------------------------------------------------------------------

	`ifdef FPGA
		initial begin
			CS = ST_Idle;
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------
	
	Register1b 	errno1(Clock, Reset, IVViolation, ERROR_IV);
	
	assign	JTAG_PMMAC =							ERROR_IV;
	
	`ifdef SIMULATION
	   reg ResetPulsed;
	
	   initial begin
	       ResetPulsed = 0;
	   end
	
		always @(posedge Clock) begin
		    if (Reset) 
				ResetPulsed = 1;
		
			if (ResetPulsed && !Reset && IVViolation !== 1'b0) begin
				$display("ERROR: Integrity violation (expected,actual) : (%x:%x)", MACOut, LoadMAC);
				$finish;
			end
			
			if (HashDataInValid && ^HashDataIn === 1'bx) begin
				$display("ERROR: X bits in hash");
				$finish;
			end
			
			/*
			if (HashDataInValid && HashDataInReady) begin
				$display("[IV] Hash in: %x", HashDataIn);
			end
			
			if (HashOutValid && HashOutReady) begin
				$display("[IV] Hash out: %x", HashOut);
			end
			
			if (Command_IntValid && Command_IntReady) begin
				$display("[IV] Command: %x (true readrmv? %b) addr=%x c=%d c'=%d", Command_Int, CommandIsReadRmv, PAddr_Int, FECurrentCounter_Int, FERemappedCounter_Int);
			end

			if (BEStoreValid && BEStoreReady) begin
				$display("[IV] Store data: %x", BEStoreData);
			end
			
			if (BELoadValid && BELoadReady) begin
				$display("[IV] Load data: %x", BELoadData);
			end
			*/
		end
	`endif

	//--------------------------------------------------------------------------
	//	Control logic
	//--------------------------------------------------------------------------
	
	assign	FECommandValid_Final =					(CSIdle && FECommandValid) || CSReadTurnaround;
	assign	FECommandReady =						 CSIdle && FECommandReady_Final;
	
	assign	FECommand_Final =						(	CSIdle && 
														(	FECommand == BECMD_Read ||
															FECommand == BECMD_Update)) ? 	BECMD_ReadRmv : 
													(	CSReadTurnaround) ? 				BECMD_Append : 
																							FECommand; // Append -> Append, ReadRmv -> ReadRmv
	assign	FEPAddr_Final =							(	CSReadTurnaround) ? 				FEShadowPAddr :
																							FEPAddr;
							
	FIFORegister #(			.Width(					BECMDWidth + ORAMU),
							.BWLatency(				1))
				cmd_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{FECommand_Final,	FEPAddr_Final}),
							.InValid(				FECommandValid_Final),
							.InAccept(				FECommandReady_Final),
							.OutData(				{Command_Int,		PAddr_Int}),
							.OutSend(				Command_IntValid),
							.OutReady(				Command_IntReady));
	
	ShiftRegister #(		.PWidth(				DMWidth),
							.Reverse(				1),
							.SWidth(				DMSWidth))
				mask_shift(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					CSIdle && FECommandValid_Final && FECommandReady_Final),
							.Enable(				CommandIsUpdate && BEPayloadReading), 
							.PIn(					FEWMask),
							.SIn(					{DMSWidth{1'bx}}),
							.SOut(					FEWMask_Chunk));
							
	// We support byte write masks
	genvar i;
	generate for (i = 0; i < DMSWidth; i = i + 1) begin:MaskSplit
		assign	FEWMask_ChunkWide[(i+1)*8-1:i*8] = (FEWMask_Chunk[i]) ? 8'hff : 8'h00;
	end endgenerate
							
	Register #(				.Width(					ORAMU + AESEntropy*2))
				shdw_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				CSIdle && FECommandValid_Final && FECommandReady_Final),
							.In(					{FEPAddr,		FECurrentCounter,		FERemappedCounter}),
							.Out(					{FEShadowPAddr, FECurrentCounter_Int, 	FERemappedCounter_Int}));		
	
	assign	RdRmv_Terminal =						CSReadFETransfer && SP_Terminal && 		CommandIsReadRmv;
	assign	Update_Terminal =						CSReadCheck && 		MACCheckComplete && CommandIsUpdate;
	Register1b rdr_r(	Clock, Reset || RdRmv_Terminal, FECommandValid && FECommandReady && FECommand == BECMD_ReadRmv, CommandIsReadRmv);
	Register1b u_r(		Clock, Reset || Update_Terminal, FECommandValid && FECommandReady && FECommand == BECMD_Update, CommandIsUpdate);
	
	assign	BECommand =								Command_Int;
	assign	BEPAddr =								PAddr_Int;
	assign	BECurrentLeaf =							CurrentLeaf_Int;
	assign	BERemappedLeaf =						RemappedLeaf_Int;
	
	assign	BECommandValid =						(CSWriteCommand || CSReadCommand) && Command_IntValid;
	assign	Command_IntReady =						(CSWriteCommand || CSReadCommand) && BECommandReady;
	
	assign	FECommandTransfer =						FECommandValid_Final && FECommandReady_Final;
	assign	CommandTransfer =						BECommandValid && BECommandReady;
	
	assign	FEStoreTransfer =						FEStoreValid && FEStoreReady;
	assign	BEStoreTransfer =						BEStoreValid && BEStoreReady;	
	
	assign	FELoadTransfer =						FELoadValid && FELoadReady;
	assign	BELoadTransfer =						BELoadValid && BELoadReady;
	
	assign	BEPayloadWriting =						CSWriteP && BEStoreTransfer;
	assign	BEPayloadReading =						CSReadP && BELoadTransfer;
	
	assign	CSIdle =								CS == ST_Idle; 
	assign	CSReadMI =								CS == ST_ReadMI;
	assign	CSMI =									CS == ST_WriteMI || CSReadMI;
	assign	CSWriteP =								CS == ST_WriteP;
	assign	CSPreStoreUpdate =						CS == ST_PreStoreWriteData;
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
				if (		Command_IntValid && Command_Int == BECMD_Append)
					NS =							ST_WriteMI;
				else if (	Command_IntValid)
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
					NS =							ST_WriteLWait;
			ST_WriteLWait :
				if (CSAESDone)
					NS =							ST_WriteCommand;
			ST_WriteCommand :
				if (CommandTransfer)
					NS =							ST_Idle;
			//
			// Read states
			//
			ST_ReadMI :
				if (SMI_Terminal)
					NS =							ST_ConvertLeafWait;
			ST_ConvertLeafWait :
				if (CSAESDone)
					NS =							ST_ReadCommand;		
			ST_ReadCommand :
				if (		CommandTransfer && CommandIsUpdate)
					NS =							ST_PreStoreWriteData;
				else if (	CommandTransfer)
					NS =							ST_ReadP;
			ST_PreStoreWriteData :
				if (SP_Terminal)
					NS =							ST_ReadP;
			ST_ReadP :
				if (SP_Terminal)
					NS =							ST_ReadMO;
			ST_ReadMO :
				if (SMO_Terminal)
					NS =							ST_ReadCheck;
			ST_ReadCheck : // check the MAC
				if (IVViolation)
					NS =							ST_Error;
				else if (MACCheckComplete && CommandIsUpdate)
					NS =							ST_ReadTurnaround;
				else if (MACCheckComplete)
					NS =							ST_ReadFETransfer;
			ST_ReadFETransfer :
				if (RdRmv_Terminal)
					NS =							ST_Idle;
				else if (SP_Terminal)
					NS =							ST_ReadTurnaround;
			ST_ReadTurnaround :
				if (FECommandTransfer)
					NS =							ST_WriteMI;
		endcase
	end
	
	//--------------------------------------------------------------------------
	//	l = PRF_K(a || c)
	//--------------------------------------------------------------------------	

	// Do the simple thing ... two AES ops back to back.  Adds 2x12 cycles to 
	// critical path.  NOTE: some of this latency will be hidden by writing the 
	// payload/generating any hashes
	
	assign	CSAESDone =								CS_AES == ST_AES_Done;

	assign	CSAESStart1 =							CS_AES == ST_AES_Start1;
	assign	CSAESWait1 =							CS_AES == ST_AES_Wait1;
	assign	CSAESWait2 =							CS_AES == ST_AES_Wait2;

	assign	AESStart =								CSAESStart1 || CS_AES == ST_AES_Start2;
		
	always @(posedge Clock) begin
		if (Reset) CS_AES <= 						ST_AES_Idle;
		else CS_AES <= 								NS_AES;
	end
	
	always @( * ) begin
		NS_AES = 									CS_AES;
		case (CS_AES)
			ST_AES_Idle :
				if (Command_IntValid) 
					NS_AES = 						ST_AES_Start1;
			ST_AES_Start1 : 
				NS_AES = 							ST_AES_Wait1; 
			ST_AES_Wait1 : 
				if (AESDone)
					NS_AES = 						ST_AES_Start2;
			ST_AES_Start2 :
				NS_AES = 							ST_AES_Wait2;
			ST_AES_Wait2 : 
				if (AESDone)
					NS_AES = 						ST_AES_Done;
			ST_AES_Done : 
				if (CSIdle)
					NS_AES =						ST_AES_Idle;
		endcase
	end
	
	assign	AESDataIn =								{
														{AESWidth-ORAMU-AESEntropy{1'b0}},
														PAddr_Int,
														(CSAESStart1) ? FECurrentCounter_Int : FERemappedCounter_Int
													};
	
	aes_cipher_top	aes(	.clk(					Clock),
							.rst(					~Reset),
							.ld(					AESStart),
							.done(					AESDone),
							.key(					128'h5e_7a_2a_9d_43_35_74_5b_85_ce_e5_b3_c0_c1_23_a6),
							.text_in(				AESDataIn),
							.text_out(				AESDataOut));
	assign	AESLeafOut =							AESDataOut[ORAML-1:0];
	
	Register #(				.Width(					ORAML))
				cleaf(		.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				AESDone && CSAESWait1),
							.In(					AESLeafOut),
							.Out(					CurrentLeaf_Int));
							
	Register #(				.Width(					ORAML))
				rleaf(		.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Enable(				AESDone && CSAESWait2),
							.In(					AESLeafOut),
							.Out(					RemappedLeaf_Int));
	
	//--------------------------------------------------------------------------
	//	Load U,C into hash engine
	//--------------------------------------------------------------------------

	assign	StoreMACHeader_Wide =					{
														{MIPADWidth - MIWidth{1'b0}}, 
														PAddr_Int, 
														(CSReadMI) ? FECurrentCounter_Int : FERemappedCounter_Int
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

	assign	CSPTransfer =							(CSPreStoreUpdate && FEStoreTransfer) ||
													BEPayloadWriting || 
													BEPayloadReading ||
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
	
	assign	CSMOTransfer =							(CSWriteMO && BEStoreTransfer) || 
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
	
	assign	StoreSourceData =						(ReStoringLoadData) ? FELoadData : FEStoreData;
	assign	StoreSourceValid = 						FEStoreValid || ReStoringLoadData;
	
	assign	BEStoreData =							(CSWriteP) ? StoreSourceData : FEStoreMAC;
	assign	BEStoreValid =							(CSWriteP 	&& StoreSourceValid && HashDataInReady) ||
													(CSWriteMO 	&& HashOutValid);

	assign	FEStoreReady =							 CSPreStoreUpdate || // update case
													(CSWriteP && BEStoreReady && HashDataInReady && ~ReStoringLoadData); // append case
	
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
	assign	IVViolation =								MACCheckComplete && (LoadMAC != MACOut);
	
	Register1b ld_m(Clock, Reset || CSIdle, CSReadP, ReStoringLoadData);
	
	assign	LDD_WE =								(CSPreStoreUpdate && FEStoreTransfer) || // update case
													BEPayloadReading; // read rmv case
	
	assign	MaskedData =							(~FEWMask_ChunkWide & BELoadData) | (FEWMask_ChunkWide & FELoadData); // a bunch of 1b muxxes for the mask
	
	assign	LDD_WData = 							(CSPreStoreUpdate) 	? 	FEStoreData : 
													(CommandIsUpdate)	?	MaskedData : // apply the mask
																			BELoadData;

	SDPRAM			 #(			.DWidth(			FEDWidth),
								.AWidth(			BFPWidth),
								.RLatency(			0))
					RAM(		.Clock(				Clock),
								.Reset(				Reset),
								.Write(				LDD_WE),								
								.WriteAddress(		LDD_Addr),
								.WriteData(			LDD_WData),
								.Read(				1'b1),
								.ReadAddress(		LDD_Addr), 
								.ReadData(			FELoadData));
	
	//--------------------------------------------------------------------------
	//	MAC core
	//--------------------------------------------------------------------------
	
	assign	HashDataIn =							(CSMI) ? 				StoreMACHeader : 
													(CSReadP) ? 			BELoadData : // on load
													(ReStoringLoadData) ? 	FELoadData : // on writeback
																			FEStoreData;
	assign	HashDataInValid =						CSMI ||
													(CSWriteP && StoreSourceValid && BEStoreReady) ||
													(CSReadP && BELoadValid);
	
	assign	HashTransfer =							HashDataInReady && HashDataInValid;
	
	Keccak_WF #(			.IWidth(				FEDWidth),
							.HashByteCount(			HashByteCount),
							.KeyLength(				HashKeyLength),
							.Key(					128'h5e_7a_2a_9d_43_35_74_5b_85_ce_e5_b3_c0_c1_23_a6),
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
	generate if (MACPADWidth != ORAMH) begin:MWIDE
		assign	MACOut_Padded =						{{MACPADWidth-ORAMH{1'b0}}, MACOut};
	end else begin:MNARROW
		assign	MACOut_Padded =						MACOut;
	end endgenerate

	assign	HashOutReady =							(CSWriteMO && SMO_Terminal) || MACCheckComplete;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
