
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMSimulator
//	Desc:		Produces a DRAM traffic pattern that is indistinguishable from 
//				Path ORAM, but doesn't do any real work.
//				This module was written to stress test the FPGA DRAM and find 
//				broken boards.
//==============================================================================
module PathORAMSimulator(
  	Clock, Reset,
	
	DRAMAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid,
	DRAMWriteData, DRAMWriteMask, DRAMWriteDataValid, DRAMWriteDataReady,
	
	Error, Error_DataMismatch
	);
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	`include "UORAM.vh" 
	`include "PLB.vh"
	
	`include "SecurityLocal.vh"	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	
	localparam				 BktSize_AESChunks = 	BktSize_DRBursts * (DDRDWidth / AESWidth);
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	
	//--------------------------------------------------------------------------
	//	Interface to DRAM
	//--------------------------------------------------------------------------

	output	[DDRAWidth-1:0]	DRAMAddress;
	output	[DDRCWidth-1:0]	DRAMCommand;
	output					DRAMCommandValid;
	input					DRAMCommandReady;
	
	input	[DDRDWidth-1:0]	DRAMReadData;
	input					DRAMReadDataValid;
	
	output	[DDRDWidth-1:0]	DRAMWriteData;
	output	[DDRMWidth-1:0]	DRAMWriteMask;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;

	//--------------------------------------------------------------------------
	//	Status interface
	//-------------------------------------------------------------------------- 

	output					Error, Error_DataMismatch; 
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
		
	// DRAM initializer
	
	(* mark_debug = "FALSE" *)	wire	[DDRAWidth-1:0]	DRAMInit_DRAMCommandAddress;
	(* mark_debug = "FALSE" *)	wire	[DDRCWidth-1:0]	DRAMInit_DRAMCommand;
	(* mark_debug = "FALSE" *)	wire					DRAMInit_DRAMCommandValid, DRAMInit_DRAMCommandReady;

	(* mark_debug = "FALSE" *)	wire	[DDRDWidth-1:0]	DRAMInit_DRAMWriteData;
	(* mark_debug = "FALSE" *)	wire					DRAMInit_DRAMWriteDataValid, DRAMInit_DRAMWriteDataReady;

	(* mark_debug = "FALSE" *)	wire					DRAMInitializing;

	// Address generator

	reg		[STAWidth-1:0]	CS_A, NS_A;	
	wire					CSAStartRead, CSAStartWrite;
	
	wire					Reading_Addr;
	wire					PRNG_OutReady, PRNG_OutValid, AddrGen_InValid, AddrGen_InReady;
				
	wire	[ORAML-1:0]		AddrGen_Leaf;	
	
	(* mark_debug = "FALSE" *)	wire	[DDRAWidth-1:0]	AddrGen_DRAMCommandAddress;
	(* mark_debug = "FALSE" *)	wire	[DDRCWidth-1:0]	AddrGen_DRAMCommand;
	(* mark_debug = "FALSE" *)	wire					AddrGen_DRAMCommandValid, AddrGen_DRAMCommandReady;

	// Data paths

	wire					PathBuffer_Full;	
	
	wire					PathBuffer_OutValid, PathBuffer_OutReady;
	wire	[DDRDWidth-1:0]	PathBuffer_OutData;

	//--------------------------------------------------------------------------
	//	DRAM Command Interface
	//--------------------------------------------------------------------------
		
	localparam				STAWidth =				2,
							ST_A_Initializing =		2'd0,
							ST_A_Idle =				2'd1,
							ST_A_StartRead =		2'd2;
	
	assign	CSAStartRead =							CS_A == ST_A_StartRead;
	assign	CSAStartWrite =							CS_A == ST_A_StartWrite;
	
	assign	Reading_Addr =							CSAStartRead;
	
	assign	PRNG_OutReady =							CSAStartWrite && AddrGen_InReady;
	assign	AddrGen_InValid	=						CSAStartRead | CSAStartWrite;
	
	always @(posedge Clock) begin
		if (Reset) CS_A <= 							ST_A_Initializing;
		else CS_A <= 								NS_A;
	end

	always @( * ) begin
		NS_A = 										CS_A;
		case (CS_A)
			ST_A_Initializing : 
				if (DRAMInitComplete)
					NS_A =							ST_A_Idle;
			ST_A_Idle :
				if (~Error && PRNG_OutValid)
					NS_A =							ST_A_StartRead;
			ST_A_StartRead :						
				if (AddrGen_InReady)
					NS_A =							ST_A_StartWrite;
			ST_A_StartWrite :
				if (AddrGen_InReady)
					NS_A =							ST_A_Idle;
		endcase
	end

	PRNG 		#(			.RandWidth(				32)) 
				leaf_gen(	.Clock(					Clock),
							.Reset(					Reset),
							.RandOutReady(			PRNG_OutReady),
							.RandOutValid(			PRNG_OutValid),
							.RandOut(				AddrGen_Leaf),
							.SecretKey(				128'hd8_40_e1_a8_dc_ca_e7_ec_d9_1f_61_48_7a_f2_cb_73)); // TODO: should we make this dynamic?
							
    AddrGen #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
				addr_gen(	.Clock(					Clock),
							.Reset(					Reset),
							.Start(					AddrGen_InValid),
							.Ready(					AddrGen_InReady),
							.RWIn(					Reading_Addr),
							.BHIn(					1'b0),
							.leaf(					AddrGen_Leaf),
							.CmdReady(				AddrGen_DRAMCommandReady),
							.CmdValid(				AddrGen_DRAMCommandValid),
							.Cmd(					AddrGen_DRAMCommand),
							.Addr(					AddrGen_DRAMCommandAddress));						

		DRAMInitializer #(	.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.IV						{AESEntropy{1'b0}}))
				dram_init(	.Clock(					Clock),
							.Reset(					Reset),
							.DRAMCommandAddress(	DRAMInit_DRAMCommandAddress),
							.DRAMCommand(			DRAMInit_DRAMCommand),
							.DRAMCommandValid(		DRAMInit_DRAMCommandValid),
							.DRAMCommandReady(		DRAMInit_DRAMCommandReady),
							.DRAMWriteData(			DRAMInit_DRAMWriteData),
							.DRAMWriteDataValid(	DRAMInit_DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMInit_DRAMWriteDataReady),
							.Done(					DRAMInitComplete));
							
	assign	DRAMAddress =							(DRAMInitializing) ? 	DRAMInit_DRAMCommandAddress : 	AddrGen_DRAMCommandAddress;
	assign	DRAMCommand =							(DRAMInitializing) ? 	DRAMInit_DRAMCommand : 			AddrGen_DRAMCommand;
	assign	DRAMCommandValid =						(DRAMInitializing) ? 	DRAMInit_DRAMCommandValid : 	AddrGen_DRAMCommandValid;
	assign	AddrGen_DRAMCommandReady =				DRAMCommandReady &	   ~DRAMInitializing;
	assign	DRAMInit_DRAMCommandReady =				DRAMCommandReady & 		DRAMInitializing;

	assign	DRAMWriteData =							(DRAMInitializing) ? 	DRAMInit_DRAMWriteData : 		DataPath_DRAMWriteData;
	assign	DRAMWriteDataValid =					(DRAMInitializing) ? 	DRAMInit_DRAMWriteDataValid : 	DataPath_DRAMWriteDataValid;

	assign	DRAMInit_DRAMWriteDataReady =			DRAMWriteDataReady &	DRAMInitializing;
	assign	DataPath_DRAMWriteDataReady =			DRAMWriteDataReady &	~DRAMInitializing;							
		
	//--------------------------------------------------------------------------
	//	Read/write state
	//--------------------------------------------------------------------------		

	ReadingData_Pre
	MaskIsHeader_Pre
	BucketTransition_Pre
	MaskIsHeader_Post
	BucketTransition_Post
	PathTransition_Pre	
			
	ReadingData_Post
	PathTransition_Post
	
	Register1b 	I_state(	.Clock(					Clock),
							.Reset(					ReadingData_Pre & PathTransition_Pre), 
							.Set(					Reset | (~ReadingData_Pre & PathTransition_Pre)),
							.Out(					ReadingData_Pre));
	
	CountAlarm #(			.Threshold(				BktSize_DRBursts),
							.IThreshold(			0))
				bkt_I_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				(ReadingData_Pre & PathBuffer_OutValid) | ~ReadingData_Pre),
							.Intermediate(			MaskIsHeader_Pre),
							.Done(					BucketTransition_Pre));							
	CountAlarm #(			.Threshold(				ORAML + 1))
				pth_I_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				BucketTransition_Pre),
							.Done(					PathTransition_Pre));			
	
	Register1b 	O_state(	.Clock(					Clock),
							.Reset(					ReadingData_Post & PathTransition_Post), 
							.Set(					Reset | (~ReadingData_Post & PathTransition_Post)),
							.Out(					ReadingData_Post));	
	
	CountAlarm #(			.Threshold(				BktSize_DRBursts),
							.IThreshold(			0))
				bkt_O_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				MaskOutValidBuf),
							.Intermediate(			MaskIsHeader_Post),
							.Done(					BucketTransition_Post));	
	
	CountAlarm 	#(			.Threshold(				ORAML + 1))
				pth_O_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				BucketTransition_Post),
							.Done(					PathTransition_Post));					
		
	//--------------------------------------------------------------------------
	//	DRAM read interface
	//--------------------------------------------------------------------------
		
	PathBuffer in_P_buf(	.clk(					Clock),
							.din(					DRAMReadData), 
							.wr_en(					DRAMReadDataValid), 
							.rd_en(					1'b1), 
							.dout(					PathBuffer_OutData), 
							.full(					PathBuffer_Full), 
							.valid(					PathBuffer_OutValid));
	
	//--------------------------------------------------------------------------
	//	AES input (reads)
	//--------------------------------------------------------------------------
	
	
	
	AESDataIn
	AESDataOut
	
	AESDataInRead
	
	AESInValid	
	AESOutValid
	
	AESReadInValid
	
	OutMask
	MaskOutValid
	

	
	DataBase
	DataOutPreMask						
	DataOutPre
	DataOut

	NextReadIV
	NextWriteIV
	NextBaseWriteIV
	
	ChunkID
	
	NextReadIVValid
	NextReadIVReady
	
	ReadData
	ReadDataValid
	CommitRead
	

	
	PathBuffer in_I_buf(	.clk(					Clock),
							.din(					PathBuffer_OutData), 
							.wr_en(					PathBuffer_OutValid), 
							.rd_en(					CommitRead), 
							.dout(					ReadData), 
							.full(					), 
							.valid(					ReadDataValid));
							
	FIFORAM		#(			.Width(					AESWidth),
							.Buffering(				ORAML+1))
				in_iv_fifo(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				PathBuffer_OutData[AESWidth-1:0]),
							.InValid(				PathBuffer_OutValid && MaskIsHeader_Pre),
							.InAccept(				),
							.OutData(				NextReadIV),
							.OutSend(				NextReadIVValid),
							.OutReady(				NextReadIVReady));							
	
	CountAlarm #(			.Threshold(				BktSize_AESChunks))
				chnt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				NextReadIVValid),
							.Count(					ChunkID));
	
	assign	AESDataInRead =							NextReadIV + ChunkID;
	assign 	AESReadInValid =						NextReadIVValid;
	
	//--------------------------------------------------------------------------
	//	AES input (writes)
	//--------------------------------------------------------------------------		

	AESDataInWrite
	AESWriteInValid		
			
	Counter		#(			.Width(					AESWidth))
				next_iv_wr(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				BucketTransition_Pre),
							.In(					{AESWidth{1'bx}}),
							.Count(					NextWriteIV));
	
	assign	AESDataInWrite =						NextWriteIV;
	assign	AESWriteInValid =						~ReadingData_Pre;
	
	//--------------------------------------------------------------------------
	//	AES
	//--------------------------------------------------------------------------			
			
	assign	AESDataIn =								(ReadingData_Pre) ? AESDataInRead : AESDataInWrite;
	assign	AESInValid =							(ReadingData_Pre) ? AESReadInValid : AESWriteInValid;
	
	aes_128 tiny_aes(		.clk(					Clock), 
							.state(					AESDataIn), 
							.key(					{AESWidth{1'b1}}), 
							.out(					AESDataOut));

	ShiftRegister #(		.PWidth(				21), // 21 based on tiny AES
							.SWidth(				1))
				V_shift(	.Clock(					Clock), 
							.Reset(					1'b0), 
							.Load(					1'b0), 
							.Enable(				1'b1),
							.SIn(					AESInValid),
							.SOut(					AESOutValid));		

	//--------------------------------------------------------------------------
	//	AES output (reads & writes)
	//--------------------------------------------------------------------------									
				
	FIFOShiftRound #(		.IWidth(				AESWidth),
							.OWidth(				DDRDWidth)) // some of these bits should get pruned by the tools
			aes_shift(		.Clock(					Clock),
							.Reset(					1'b0),
							.InData(				AESDataOut),
							.InValid(				AESOutValid),
							.InAccept(				),
							.OutData(				OutMask),
							.OutValid(				MaskOutValid),
							.OutReady(				1'b1));
		
	OutMaskBuf	
	MaskOutValidBuf
	 
	PathBuffer m_buf(		.clk(					Clock),
							.din(					OutMask), 
							.wr_en(					MaskOutValid), 
							.rd_en(					CommitRead | CommitWrite), 
							.dout(					OutMaskBuf), 
							.full(					), 
							.valid(					MaskOutValidBuf));		
		
	assign	DataBase =								{DDRDWidth{1'b0}};
	assign	DataOutPre = 							(ReadingData_Pre) ? PathBuffer_OutData : 
													(MaskIsHeader_Post) ? { DataBase[DDRDWidth-1:AESWidth], NextBaseWriteIV } : DataBase;
	assign	MaskOutPre =							(MaskIsHeader_Post) ? { OutMaskBuf[DDRDWidth-1:AESWidth], {AESWidth{1'b0}} } : OutMaskBuf;
	assign	DataOut =								DataOutPre ^ MaskOutPre;
	
	assign	CommitRead =							ReadingData_Post && MaskOutValidBuf && ReadDataValid;		
	assign	CommitWrite =							~ReadingData_Post && MaskOutValidBuf;

	//--------------------------------------------------------------------------
	//	DRAM write interface
	//--------------------------------------------------------------------------
	
	DataPath_DRAMWriteData
	DataPath_DRAMWriteDataReady
	DataPath_DRAMWriteDataValid
	
	Counter		#(			.Width(					AESWidth),
							.Factor(				BktSize_AESChunks))
				next_iv_wb(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				),
							.In(					{AESWidth{1'bx}}),
							.Count(					NextBaseWriteIV));	
	
	PathBuffer 	out_P_buf(	.clk(					Clock),
							.din(					DataOut),
							.wr_en(					CommitWrite), 
							.rd_en(					DataPath_DRAMWriteDataReady), 
							.dout(					DataPath_DRAMWriteData), 
							.full(					), 
							.valid(					DataPath_DRAMWriteDataValid));		
	
	//--------------------------------------------------------------------------
	//	Error checking
	//--------------------------------------------------------------------------
	
	Register1b 	errno1(Clock, Reset, 	ReadingData_Pre && 
										MaskOutReady && MaskOutValid && 
										PathBuffer_OutValid && PathBuffer_OutReady &&
										~MaskIsHeader_Post && 
										DataBase != DataOut, 
										Error_DataMismatch);
	
	Register1b 	errANY(Clock, Reset, 	Error_DataMismatch, Error);	
	
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
