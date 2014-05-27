
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMSimulator
//	Desc:		Produces a DRAM traffic pattern that is indistinguishable from 
//				Path ORAM, but doesn't do any real work.
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

	wire					AddrGen_InValid, AddrGen_InReady
				
	wire	[ORAML-1:0]		AddrGen_Leaf;
	wire					StartRead, Reading;	
	
	(* mark_debug = "FALSE" *)	wire	[DDRAWidth-1:0]	AddrGen_DRAMCommandAddress;
	(* mark_debug = "FALSE" *)	wire	[DDRCWidth-1:0]	AddrGen_DRAMCommand;
	(* mark_debug = "FALSE" *)	wire					AddrGen_DRAMCommandValid, AddrGen_DRAMCommandReady;

	// Path buffer

	wire					PathBuffer_Full;	
	
	wire					PathBuffer_OutValid, PathBuffer_OutReady;
	wire	[DDRDWidth-1:0]	PathBuffer_OutData;

	//--------------------------------------------------------------------------
	//	DRAM Command Interface
	//--------------------------------------------------------------------------
	
	Writing
	
	Register1b	start(		.Clock(					Clock),
							.Reset(					AddrGen_InReady & AddrGen_InValid & StartRead),				
							.Set(					Reset | (AddrGen_InReady & AddrGen_InValid & ~StartRead)),
							.Out(					StartRead));					
				
	Register	state(		.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				AddrGen_InReady & AddrGen_InValid),
							.In(					~Reading),
							.Out(					Reading));			
	assign	Writing =								~Reading;
				
	PRNG 		#(			.RandWidth(				32)) 
				leaf_gen(	.Clock(					Clock),
							.Reset(					Reset),
							.RandOutReady(			AddrGen_InReady & StartRead),
							.RandOutValid(			AddrGen_InValid),
							.RandOut(				AddrGen_Leaf),
							.SecretKey(				128'hd8_40_e1_a8_dc_ca_e7_ec_d9_1f_61_48_7a_f2_cb_73));		
							
    AddrGen #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
				addr_gen(	.Clock(					Clock),
							.Reset(					Reset),
							.Start(					AddrGen_InValid & ~Error),
							.Ready(					AddrGen_InReady),
							.RWIn(					StartRead),
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

	assign	DRAMWriteData =							(DRAMInitializing) ? 	DRAMInit_DRAMWriteData : 		Stash_DRAMWriteData;
	assign	DRAMWriteDataValid =					(DRAMInitializing) ? 	DRAMInit_DRAMWriteDataValid : 	Stash_DRAMWriteDataValid;

	assign	DRAMInit_DRAMWriteDataReady =			DRAMWriteDataReady &	DRAMInitializing;
	assign	Stash_DRAMWriteDataReady =				DRAMWriteDataReady &	~DRAMInitializing;							
							
	//--------------------------------------------------------------------------
	//	AES input (reads)
	//--------------------------------------------------------------------------
	
	AESDataIn
	AESDataOut
	
	AESInValid	
	AESOutValid
	
	OutMask
	MaskOutValid
	
	MaskIsHeader_Pre
	BucketTransition_Pre
	MaskIsHeader_Post
	BucketTransition_Post
	
	DataBase
	DataOutPreMask						
	DataOutPre
	DataOut

	NextReadIV
	NextWriteIV
	NextBaseWriteIV
	
	ChunkID
	
	CountAlarm #(			.Threshold(				BktSize_DRBursts),
							.IThreshold(			0))
				hdr_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				),
							.Intermediate(			MaskIsHeader_Pre),
							.Done(					BucketTransition_Pre));	
	
	Register1b	read_latch(	.Clock(					Clock),
							.Reset(					MaskIsHeader_Pre & ReadIVGate & PathBuffer_OutValid),				
							.Set(					BucketTransition_Pre),
							.Out(					ReadIVGate));
	Counter		#(			.Width(					AESWidth))
				next_iv_rd(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					MaskIsHeader_Pre & ReadIVGate & PathBuffer_OutValid),
							.Enable(				~ReadIVGate),
							.In(					PathBuffer_OutData[AESWidth-1:0]),
							.Count(					NextReadIV));	
	
	//--------------------------------------------------------------------------
	//	AES input (writes)
	//--------------------------------------------------------------------------		
			
	Counter		#(			.Width(					AESWidth))
				next_iv_wr(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				),
							.In(					{AESWidth{1'bx}}),
							.Count(					NextWriteIV));
							
	Counter		#(			.Width(					AESWidth),
							.Factor(				BktSize_AESChunks))
				next_iv_wb(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				Writing & BucketTransition_Post),
							.In(					{AESWidth{1'bx}}),
							.Count(					NextBaseWriteIV));
	
	//--------------------------------------------------------------------------
	//	AES core
	//--------------------------------------------------------------------------			
			
	assign	AESDataIn =								(Reading) ? NextReadIV : NextWriteIV;
	assign	AESInValid =							;
	
	aes_128 tiny_aes(		.clk(					Clock), 
							.state(					AESDataIn), 
							.key(					{AESWidth{1'b1}}), 
							.out(					AESDataOut));

	ShiftRegister #(		.PWidth(				21),
							.SWidth(				1))
				V_shift(	.Clock(					Clock), 
							.Reset(					1'b0), 
							.Load(					1'b0), 
							.Enable(				1'b1),
							.SIn(					AESInValid),
							.SOut(					AESOutValid));		

	//--------------------------------------------------------------------------
	//	AES output
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
		
	assign	DataBase =								{DDRDWidth{1'b0}};
	assign	DataOutPre = 							(Reading) ? PathBuffer_OutData : 
													(MaskIsHeader_Post) ? { DataBase[DDRDWidth-1:AESWidth], NextBaseWriteIV } : DataBase;
	assign	MaskOutPre =							(MaskIsHeader_Post) ? { OutMask[DDRDWidth-1:AESWidth], {AESWidth{1'b0}} } : OutMask;
	assign	DataOut =								DataOutPre ^ MaskOutPre;
	
	PathTransition_Post
	
	CountAlarm 	#(			.Threshold(				ORAML + 1))
				pth_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				BucketTransition_Post),
							.Done(					PathTransition_Post));
	
	CountAlarm #(			.Threshold(				BktSize_DRBursts),
							.IThreshold(			0))
				bkt_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				MaskOutValid),
							.Intermediate(			MaskIsHeader_Post),
							.Done(					BucketTransition_Post));
		
	//--------------------------------------------------------------------------
	//	DRAM Read Interface
	//--------------------------------------------------------------------------
			
	assign	PathBuffer_InReady =					~PathBuffer_Full;
	PathBuffer in_P_buf(	.clk(					Clock),
							.din(					DRAMReadData), 
							.wr_en(					DRAMReadDataValid), 
							.rd_en(					PathBuffer_OutReady), 
							.dout(					PathBuffer_OutData), 
							.full(					PathBuffer_Full), 
							.valid(					PathBuffer_OutValid));

	//--------------------------------------------------------------------------
	//	DRAM Write Interface
	//--------------------------------------------------------------------------

	PathBuffer out_P_buf(	.clk(					Clock),
							.din(					DataOut), 
							.wr_en(					MaskOutValid & DataWriting), 
							.rd_en(					DRAMWriteDataReady), 
							.dout(					DRAMWriteData), 
							.full(					), 
							.valid(					DRAMWriteDataValid));	
	
	assign	DRAMWriteMask =							{DDRMWidth{1'b0}};
	
	//--------------------------------------------------------------------------
	//	Error checking
	//--------------------------------------------------------------------------
	
	Register1b 	errno1(Clock, Reset, 	Reading && 
										MaskOutReady && MaskOutValid && 
										PathBuffer_OutValid && PathBuffer_OutReady &&
										~MaskIsHeader_Post && 
										DataBase != DataOut, 
										Error_DataMismatch);
	
	Register1b 	errANY(Clock, Reset, 	Error_DataMismatch, Error);	
	
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
