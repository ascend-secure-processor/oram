
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
module PathORamSimulator(
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
	
	`include "SecurityLocal.vh"	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	
	localparam				 BktSize_AESChunks = 	BktSize_DRBursts * (DDRDWidth / AESWidth);
	
	localparam				STAWidth =				3,
							ST_A_Initializing =		3'd0,
							ST_A_Idle =				3'd1,
							ST_A_StartRead =		3'd2,
							ST_A_StartWrite =		3'd3,
							ST_A_Writing =			3'd4;
	
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
	
	(* mark_debug = "TRUE" *)	wire	[DDRAWidth-1:0]	DRAMInit_DRAMCommandAddress;
	(* mark_debug = "TRUE" *)	wire	[DDRCWidth-1:0]	DRAMInit_DRAMCommand;
	(* mark_debug = "TRUE" *)	wire					DRAMInit_DRAMCommandValid, DRAMInit_DRAMCommandReady;

	(* mark_debug = "FALSE" *)	wire	[DDRDWidth-1:0]	DRAMInit_DRAMWriteData;
	(* mark_debug = "TRUE" *)	wire					DRAMInit_DRAMWriteDataValid, DRAMInit_DRAMWriteDataReady;

	(* mark_debug = "TRUE" *)	wire					DRAMInitializing;

	// Address generator

	(* mark_debug = "TRUE" *)	reg		[STAWidth-1:0]	CS_A, NS_A;	
	(* mark_debug = "TRUE" *)	wire					CSAStartRead, CSAStartWrite;
	
	(* mark_debug = "TRUE" *)	wire					Reading_Addr;
	(* mark_debug = "TRUE" *)	wire					PRNG_OutReady, PRNG_OutValid, AddrGen_InValid, AddrGen_InReady;
				
	(* mark_debug = "TRUE" *)	wire	[ORAML-1:0]		AddrGen_Leaf;	
	
	(* mark_debug = "TRUE" *)	wire	[DDRAWidth-1:0]	AddrGen_DRAMCommandAddress;
	(* mark_debug = "TRUE" *)	wire	[DDRCWidth-1:0]	AddrGen_DRAMCommand;
	(* mark_debug = "TRUE" *)	wire					AddrGen_DRAMCommandValid, AddrGen_DRAMCommandReady;

	// Data paths

	(* mark_debug = "TRUE" *)	wire					ReadingData_Pre, MaskIsHeader_Pre, PathTransition_Pre;
	(* mark_debug = "TRUE" *)	wire					ReadingData_Post, MaskIsHeader_Post, BucketTransition_Post, PathTransition_Post;
	
	wire	[AESWidth-1:0]	AESDataIn, AESDataOut;
	(* mark_debug = "TRUE" *)	wire					AESInValid, AESOutValid;
	
	wire	[AESWidth-1:0]	AESDataInRead, AESDataInWrite;
	(* mark_debug = "TRUE" *)	wire					AESReadInValid, AESWriteInValid;		
	
	wire	[DDRDWidth-1:0]	OutMask;
	(* mark_debug = "TRUE" *)	wire					MaskOutValid;
	
	wire	[DDRDWidth-1:0]	ReadData;
	(* mark_debug = "TRUE" *)	wire					ReadDataValid;
	
	(* mark_debug = "TRUE" *)	wire					IFIFOHeaderValid;
	(* mark_debug = "TRUE" *)	wire					CheckReadBucketIn, CheckReadBucketOut, IVCheckValid, IVCheckReady;
	
	wire	[AESWidth-1:0]	NextReadIV, NextWriteIV_Pre;
	(* mark_debug = "TRUE" *)	wire	[AESWidth-1:0]	NextWriteIV_Post;
	
	(* mark_debug = "TRUE" *)	wire	[`log2(BktSize_AESChunks)-1:0] ChunkID;
	
	(* mark_debug = "TRUE" *)	wire					NextReadIVValid, NextReadIVReady;
		
	(* mark_debug = "TRUE" *)	wire					CommitRead, CommitWrite;
	
	wire	[DDRDWidth-1:0]	WriteData, OutMaskBuf, MaskOutPre, DataOutPre;
	(* mark_debug = "TRUE" *)	wire	[DDRDWidth-1:0]	DataOut;
	(* mark_debug = "TRUE" *)	wire					MaskOutValidBuf;
	
	(* mark_debug = "TRUE" *)	wire					PathBuffer_OutValid;
	wire	[DDRDWidth-1:0]	PathBuffer_OutData;
	
	wire	[DDRDWidth-1:0]	DataPath_DRAMWriteData;
	(* mark_debug = "TRUE" *)	wire					DataPath_DRAMWriteDataReady, DataPath_DRAMWriteDataValid;
	
	// Debugging
	
	(* mark_debug = "TRUE" *)	wire	[63:0]			BurstsChecked; // Warning: this will probably get pruned
	(* mark_debug = "TRUE" *)	wire					DataMismatch;
	
	//--------------------------------------------------------------------------
	//	Error checking
	//--------------------------------------------------------------------------
	
	Counter		#(			.Width(					64))
				burst_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CommitRead && CheckReadBucketOut),
							.In(					{64{1'bx}}),
							.Count(					BurstsChecked));	
	
	assign	DataMismatch =							CommitRead && CheckReadBucketOut && WriteData != DataOut;
	
	Register1b 	errno1(Clock, Reset, 	DataMismatch, Error_DataMismatch);
	Register1b 	errANY(Clock, Reset, 	Error_DataMismatch, Error);
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (DataMismatch) begin
				$display("ERROR: data mismatch expected = %x, actual = %x.", WriteData, DataOut);
				$finish;
			end
			
			if (CommitRead && CheckReadBucketOut && ^DataOut === 1'bx) begin
				$display("ERROR: compare data is X.");
				$finish;			
			end
			
			if (PathBuffer_OutValid && MaskIsHeader_Pre && ^PathBuffer_OutData[AESWidth-1:0] === 1'bx) begin
				$display("ERROR: IV is X.");
				$finish;
			end
			
			if (AESReadInValid && AESWriteInValid) begin
				$display("ERROR: illegal signal combination.");
				$finish;			
			end
			
			if (~IVCheckValid && IVCheckReady) begin
				$display("ERROR: illegal signal combination.");
				$finish;						
			end
			
			if (CheckReadBucketIn === 1'bx && IFIFOHeaderValid) begin
				$display("ERROR: illegal signal combination.");
				$finish;
			end
		end
	`endif	
	
	//--------------------------------------------------------------------------
	//	DRAM Command Interface
	//--------------------------------------------------------------------------
	
	assign	DRAMInitializing =						CS_A == ST_A_Initializing;
	
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
					NS_A =							ST_A_Writing;
			ST_A_Writing :
				if (~ReadingData_Post && PathTransition_Post)
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
							.IV(					{AESEntropy{1'b0}}))
				dram_init(	.Clock(					Clock),
							.Reset(					Reset),
							.DRAMCommandAddress(	DRAMInit_DRAMCommandAddress),
							.DRAMCommand(			DRAMInit_DRAMCommand),
							.DRAMCommandValid(		DRAMInit_DRAMCommandValid),
							.DRAMCommandReady(		DRAMInit_DRAMCommandReady),
							.DRAMWriteData(			),
							.DRAMWriteDataValid(	DRAMInit_DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMInit_DRAMWriteDataReady),
							.Done(					DRAMInitComplete));
							
	assign	DRAMAddress =							(DRAMInitializing) ? 	DRAMInit_DRAMCommandAddress : 	AddrGen_DRAMCommandAddress;
	assign	DRAMCommand =							(DRAMInitializing) ? 	DRAMInit_DRAMCommand : 			AddrGen_DRAMCommand;
	assign	DRAMCommandValid =						(DRAMInitializing) ? 	DRAMInit_DRAMCommandValid : 	AddrGen_DRAMCommandValid;
	assign	AddrGen_DRAMCommandReady =				DRAMCommandReady &	   ~DRAMInitializing;
	assign	DRAMInit_DRAMCommandReady =				DRAMCommandReady & 		DRAMInitializing;

	assign	DRAMInit_DRAMWriteData =				{DDRDWidth{1'b0}};
	assign	DRAMWriteData =							(DRAMInitializing) ? 	DRAMInit_DRAMWriteData : 		DataPath_DRAMWriteData;
	assign	DRAMWriteDataValid =					(DRAMInitializing) ? 	DRAMInit_DRAMWriteDataValid : 	DataPath_DRAMWriteDataValid;

	assign	DRAMWriteMask =							{DDRMWidth{1'b0}};
	
	assign	DRAMInit_DRAMWriteDataReady =			DRAMWriteDataReady &	DRAMInitializing;
	assign	DataPath_DRAMWriteDataReady =			DRAMWriteDataReady &	~DRAMInitializing;							
		
	//--------------------------------------------------------------------------
	//	Read/write state
	//--------------------------------------------------------------------------		

	Register1b 	#(			.Initial(				1'b1))
				I_state(	.Clock(					Clock),
							.Reset(					ReadingData_Pre & PathTransition_Pre), 
							.Set(					Reset | (~ReadingData_Pre & PathTransition_Pre)),
							.Out(					ReadingData_Pre));
	
	CountAlarm #(			.Threshold(				(ORAML + 1) * BktSize_AESChunks))
				pth_I_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				AESInValid),
							.Done(					PathTransition_Pre));			
	
	Register1b 	#(			.Initial(				1'b1))
				O_state(	.Clock(					Clock),
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
		
	PathBufferRst in_P_buf(	.rst(					Reset),
							.clk(					Clock),
							.din(					DRAMReadData), 
							.wr_en(					DRAMReadDataValid), 
							.rd_en(					1'b1), 
							.dout(					PathBuffer_OutData), 
							.full(					), 
							.valid(					PathBuffer_OutValid));
	
	//--------------------------------------------------------------------------
	//	AES input (reads)
	//--------------------------------------------------------------------------
	
	PathBufferRst in_I_buf(	.rst(					Reset),
							.clk(					Clock),
							.din(					PathBuffer_OutData), 
							.wr_en(					PathBuffer_OutValid), 
							.rd_en(					CommitRead), 
							.dout(					ReadData), 
							.full(					), 
							.valid(					ReadDataValid));
	
	CountAlarm #(			.Threshold(				BktSize_DRBursts),
							.IThreshold(			0))
				bkt_H_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				ReadingData_Pre & PathBuffer_OutValid),
							.Intermediate(			MaskIsHeader_Pre));
	
	assign	IFIFOHeaderValid =						PathBuffer_OutValid && MaskIsHeader_Pre;
	FIFORAM		#(			.Width(					AESWidth),
							.Buffering(				ORAML+1))
				in_iv_fifo(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				PathBuffer_OutData[AESWidth-1:0]),
							.InValid(				IFIFOHeaderValid),
							.InAccept(				),
							.OutData(				NextReadIV),
							.OutSend(				NextReadIVValid),
							.OutReady(				NextReadIVReady));
	
	assign	CheckReadBucketIn =						PathBuffer_OutData[AESWidth-1:0] > 0;
	FIFORAM		#(			.Width(					1),
							.Buffering(				ORAML+1))
				in_iv_vld(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				CheckReadBucketIn),
							.InValid(				IFIFOHeaderValid),
							.InAccept(				),
							.OutData(				CheckReadBucketOut),
							.OutSend(				IVCheckValid),
							.OutReady(				IVCheckReady));
	assign	IVCheckReady =							CommitRead && BucketTransition_Post;
							
	CountAlarm #(			.Threshold(				BktSize_AESChunks))
				chnt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				NextReadIVValid),
							.Count(					ChunkID),
							.Done(					NextReadIVReady));
	
	assign	AESDataInRead =							NextReadIV + ChunkID;
	assign 	AESReadInValid =						NextReadIVValid;

	//--------------------------------------------------------------------------
	//	AES input (writes)
	//--------------------------------------------------------------------------		
		
	Counter		#(			.Width(					AESWidth),
							.ResetValue(			BktSize_AESChunks))
				next_iv_wr(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				~ReadingData_Pre),
							.In(					{AESWidth{1'bx}}),
							.Count(					NextWriteIV_Pre));
	
	assign	AESDataInWrite =						NextWriteIV_Pre;
	assign	AESWriteInValid =						~ReadingData_Pre;
	
	//--------------------------------------------------------------------------
	//	AES
	//--------------------------------------------------------------------------			
			
	assign	AESDataIn =								(ReadingData_Pre) ? AESDataInRead : AESDataInWrite;
	assign	AESInValid =							AESReadInValid | AESWriteInValid;
	
	aes_128 tiny_aes(		.clk(					Clock), 
							.state(					AESDataIn), 
							.key(					{AESWidth{1'b1}}), 
							.out(					AESDataOut));
	
	ShiftRegister #(		.PWidth(				21), // 21 based on tiny AES
							.SWidth(				1),
							.Initial(				{21{1'b0}}))
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
							.OWidth(				DDRDWidth))
			aes_shift(		.Clock(					Clock),
							.Reset(					1'b0),
							.InData(				AESDataOut),
							.InValid(				AESOutValid),
							.InAccept(				),
							.OutData(				OutMask),
							.OutValid(				MaskOutValid),
							.OutReady(				1'b1));
	
	PathBufferRst m_buf(	.rst(					Reset),
							.clk(					Clock),
							.din(					OutMask), 
							.wr_en(					MaskOutValid), 
							.rd_en(					CommitRead | CommitWrite), 
							.dout(					OutMaskBuf), 
							.full(					), 
							.valid(					MaskOutValidBuf));		
		
	assign	WriteData =								{DDRDWidth{1'b0}};
	assign	DataOutPre = 							(ReadingData_Post && MaskIsHeader_Post) ? 	{ 	ReadData[DDRDWidth-1:AESWidth], 	{AESWidth{1'b0}} } :
													(ReadingData_Post) ?  							ReadData :
													(~ReadingData_Post && MaskIsHeader_Post) ? 	{ 	WriteData[DDRDWidth-1:AESWidth], 	NextWriteIV_Post } : 
																									WriteData;	
	assign	MaskOutPre =							(MaskIsHeader_Post) ? 						{ 	OutMaskBuf[DDRDWidth-1:AESWidth], 	{AESWidth{1'b0}} } : 
																									OutMaskBuf;
	assign	DataOut =								DataOutPre ^ MaskOutPre;
	
	assign	CommitRead =							ReadingData_Post && MaskOutValidBuf && ReadDataValid;		
	assign	CommitWrite =							~ReadingData_Post && MaskOutValidBuf;

	//--------------------------------------------------------------------------
	//	DRAM write interface
	//--------------------------------------------------------------------------
	
	Counter		#(			.Width(					AESWidth),
							.Factor(				BktSize_AESChunks),
							.ResetValue(			BktSize_AESChunks))
				next_iv_wb(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CommitWrite && MaskIsHeader_Post),
							.In(					{AESWidth{1'bx}}),
							.Count(					NextWriteIV_Post));	
	
	PathBufferRst out_P_buf(.rst(					Reset),
							.clk(					Clock),
							.din(					DataOut),
							.wr_en(					CommitWrite), 
							.full(					),
							.rd_en(					DataPath_DRAMWriteDataReady), 
							.dout(					DataPath_DRAMWriteData), 
							.valid(					DataPath_DRAMWriteDataValid));
	
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
