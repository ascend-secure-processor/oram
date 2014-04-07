
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		AESREWORAM
//	Desc:		AES Unit for REW ORAM.  This module acts as a filter which 
//				decrypts/re-encrypts the data that is sent to it.  **Crucially, 
//				if N bytes of data are input to this module, it will eventually 
//				output N bytes, and each byte's logical position in the stream 
//				will be unchanged.**
//				ROHeader = valid bits + program addresses
//				- 	On an REW RO access (DRAM -> Backend): 
//						In: 	Encrypted path
//						Out: 	Path with decrypted ROHeaders, 
//								encrypted payload except for bucket/block of 
//								interest
//				-	On an REW H access (Backend -> DRAM): 
//						In:		Decrypted headers
//						Out:	Re-encrypted headers
//				-	On an REW R access (DRAM -> Backend):
//						In:		Encrypted path
//						Out:	Decrypted path
//				-	On an REW W access (Backend -> DRAM):
//						In:		Decrypted path
//						Out:	Encrypted path
//==============================================================================
module AESREWORAM(
	Clock, FastClock, 
	Reset,

	ROPAddr, ROPAddrValid,
	
	BEDataOut, BEDataOutValid, BEDataOutReady,
	BEDataIn, BEDataInValid, BEDataInReady,	
	
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,
	
	InitDone
	);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	parameter				NPorts =				1;
	
	localparam				RWPIDWidth =			RWPath_AESChunks,
							;

	localparam				ACMDWidth =				2,
							CMD_RO =				2'd0, // ROHeader (valid bit or U)
							CMD_RW_CriticalPath =	2'd1, // Bucket/block of interest on RO access
							CMD_RW_Background =		2'd2; // RW mask (computed in the background)
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, FastClock, Reset;

	//--------------------------------------------------------------------------
	//	Command Interface
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	DRAM Interface
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------	
	
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	
	//--------------------------------------------------------------------------
	//	Simulation Checks
	//--------------------------------------------------------------------------
		
	`ifdef SIMULATION

	`endif

	//--------------------------------------------------------------------------
	//	Control logic
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	RO,H Seed Generation
	//--------------------------------------------------------------------------
	
	ServiceHeader
	
	ROIV
	ROBucketID
	ROChunkID
	ROSeed

	ReadTransfer

	ROSeedValid
	ROSeedTaken
	
	FlitIsHeader
	HeaderTransfer
	
	HeaderIV
	
	assign	ReadTransfer =							DRAMReadDataValid & DRAMReadDataReady;
	assign	HeaderTransfer =						ReadTransfer & FlitIsHeader;
	
	assign	HeaderIV = 								DRAMReadData[IVEntropyWidth-1:0];
	
	CountAlarm #(			.Threshold(				BktSize_DRBursts),
							.IThreshold(			0))
				bkt_cnt(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				ReadTransfer),
							.Intermediate(			FlitIsHeader),
							.Done(					BucketTransition));
	
	FIFORegister #(			.Width(					IVEntropyWidth))
				ro_state(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderIV),
							.InValid(				HeaderTransfer),
							.InAccept(				), // TODO check to never go low
							.OutData(				ROIV),
							.OutSend(				ROSeedValid),
							.OutReady(				ROSeedTaken));

							HIV
							HSeedValid
							HSeedTaken
							
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				ORAML + 1))
				ro_iv_rpeat(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderIV + BktSize_AESChunks),
							.InValid(				HeaderTransfer),
							.InAccept(				), // TODO check to never go low
							.OutData(				HIV),
							.OutSend(				HSeedValid),
							.OutReady(				HSeedTaken));
							
	assign	ROBucketID =							0; // TODO add AddrGen
							
	Counter		#(			.Width(					))
				ro_cid(		.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				ROSeedValid),
							.In(					{{1'bx}}),
							.Count(					ROChunkID));
	CountCompare #(			.Width(					),
							.Compare(				))
				ro_stop(	.Count(					),
							.TerminalCount(			));
	assign	
							
	assign	ROSeed =								{ {SeedSpaceRemaining{1'b0}}, ROIV, ROBucketID, ROChunkID };
	
	//--------------------------------------------------------------------------
	//	RW Seed Generation
	//--------------------------------------------------------------------------

	BuildingWritePath
	
	localparam				RWSTWidth =				2,
							RWST_Idle =				2'd0, // 
							RWST_ReadPath =			2'd1, // Generating R masks
							RWST_WritePath =		2'd2; // Generating W masks
							
	StartMaskGeneration
	
	RWIV
	RWBucketID
	RWChunkID

	RWBucketTransition
	RWPathTransition
	
	NSRW, CSRW
	
	always @(posedge Clock) begin
		if (Reset) CSRW <= 							RWST_Idle;
		else CSRW <= 								NSRW;
	end
	
	always @( * ) begin
		NSRW = 										CSRW;
		case (CSRW)
			RWST_Idle : 
				if (StartMaskGeneration) 
					NSRW =						 	RWST_ReadPath;
			RWST_ReadPath :
				if (RWPathTransition)
					NSRW =						 	RWST_WritePath;
			RWST_WritePath :
				if (RWPathTransition)
					NSRW =						 	RWST_Idle;			
		endcase
	end

	RWSeedTransfer
	RWMaskTransfer
	MaskCount
	
	assign	RWSeedTransfer =						RWSeedValid & RWSeedReady;
	
	UDCounter	#(			.Width(					RWMWidth))
				mask_count(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Up(					RWSeedTransfer),
							.Down(					RWMaskTransfer),
							.In(					{RWMWidth{1'bx}}),
							.Count(					MaskCount));	
	
	CountAlarm #(			.Threshold(				ORAML + 1),
							.IThreshold(			0))
				rw_lvl_cnt(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				RWBucketTransition),
							.Done(					RWPathTransition));
	
	assign	RWIV =									0; // TODO add Gentry seed calculation
	
	assign	RWBucketID =							0; // TODO add AddrGen
	
	Counter		#(			.Width(					RWCIDWidth))
				rw_cid(		.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				RWSeedTransfer),
							.In(					{RWCIDWidth{1'bx}}),
							.Count(					RWChunkID));
	CountCompare #(			.Width(					RWCIDWidth),
							.Compare(				ROHeader_AESChunks ... 1))
				rw_stop(	.Count(					RWChunkID),
							.TerminalCount(			RWBucketTransition));
	
	assign	RWSeed =								{ {SeedSpaceRemaining{1'b0}}, RWIV, RWBucketID, RWChunkID };
	assign	RWSeedValid =							MaskCount < RWMDepth;
	
	//--------------------------------------------------------------------------
	//	AES
	//--------------------------------------------------------------------------
	
	AESDataIn
	AESDataInValid
	AESDataInReady
	
	AESDataOut
	AESDataOutValid
	AESDataOutReady
	
	AESCommand
	
	ROSeedReady
	RWSeedReady
	
	assign	ROSeedReady =							AESDataInReady;
	assign	RWSeedReady =							~ROSeedValid & AESDataInReady;
	
	assign	AESDataIn =								(ROSeedValid) ? ROSeed : RWSeed;
	assign	AESDataInValid =						ROSeedValid | RWSeedValid;
	
	assign	AESCommand =							(ROSeedValid) ? CMD_RO : CMD_RW;
	
	TinyAESRV 	#(			.NPorts(				1),
							.AESWidth(				AESWidth))
				aes(		.SlowClock(				Clock), 		
							.FastClock(				FastClock),
							.SlowReset(				Reset),

							.DataIn(				AESDataIn), 
							.DataInValid(			AESDataInValid), 
							.DataInReady(			AESDataInReady),
							.DataOut(				AESDataOut), 
							.DataOutValid(			AESDataOutValid), 
							.DataOutReady(			AESDataOutReady));
							
	FIFORAM		#(			.Width(					ACMDWidth),
							.Buffering(				))
				cmd_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				),
							.InValid(				AESDataInValid),
							.InAccept(				),
							.OutData(				),
							.OutSend(				),
							.OutReady(				));
	
	OutMask
	OutMaskValid
	OutMaskReady
	
	//--------------------------------------------------------------------------
	//	RO Data storage
	//--------------------------------------------------------------------------
	
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				`max(AESLatency * 2, 64))) // latency of tiny_aes 2x
				int_D_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				),
							.InValid(				),
							.InAccept(				),
							.OutData(				),
							.OutSend(				),
							.OutReady(				));
							
	
							
	//--------------------------------------------------------------------------
	//	RW Mask storage
	//--------------------------------------------------------------------------

	RWMaskValid
	RWMaskReady
	
	assign	RWMaskTransfer =						RWMaskValid & RWMaskReady;
	
	RWDecrypted
	
	assign	RWDecrypted =							;
	
	//--------------------------------------------------------------------------
	//	To Backend
	//--------------------------------------------------------------------------

	assign	BEDataOut =	
	
	BEDataOutValid, BEDataOutReady,
	
	
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
