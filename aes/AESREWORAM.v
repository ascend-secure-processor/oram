
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

	ROPAddr, ROAccess,
	
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
	//	Wires & Regs
	//--------------------------------------------------------------------------

	// AES Core
	
	wire		[IVEntropyWidth-1:0] ROIVIn; 
	wire		[BIDWidth-1:0] ROBIDIn; 
	wire		[PCCMDWidth-1:0]ROCommandIn; 
	wire					ROCommandInValid;
	wire					ROCommandInReady;

	wire		[IVEntropyWidth-1:0] RWIVIn;
	wire		[BIDWidth-1:0] RWBIDIn;
	wire					RWCommandInValid; 
	wire					RWCommandInReady;

	wire	[AESWidth-1:0]	RODataOut; 
	wire	[PCCMDWidth-1:0] ROCommandOut;
	wire					RODataOutValid;
	wire					RODataOutReady;
	
	wire	[DDRDWidth-1:0]	RWDataOut;
	wire					RWDataOutValid;
	wire					RWDataOutReady;	
	
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
	//	RW Seed/Command Generation
	//--------------------------------------------------------------------------

	// TODO move
	wire	BuildingWritePath, RWPathTransition;
	wire	RWCommandTransfer;
	
	Register	#(			.Width(					1))
				rw_state(	.Clock(					Clock),
							.Reset(					Reset | (BuildingWritePath & RWPathTransition)),
							.Set(					~BuildingWritePath & RWPathTransition),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					BuildingWritePath));	
	
	CountAlarm #(			.Threshold(				ORAML + 1))
				rw_lvl_cnt(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				RWCommandTransfer),
							.Done(					RWPathTransition));
	
	assign	Core_RWIVIn =							0; // TODO add Gentry seed calculation
	
	assign	Core_RWBIDIn =							0; // TODO add AddrGen
	
	assign	RWCommandTransfer =						Core_RWCommandInValid & Core_RWCommandInReady
	
	//--------------------------------------------------------------------------
	//	AES Core
	//--------------------------------------------------------------------------
	
	REWAESCore	#(			.ORAMZ(					ORAMZ),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMB(					ORAMB),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.IVEntropyWidth(		IVEntropyWidth),
							.AESWidth(				AESWidth))
				CUT(		.SlowClock(				Clock),
							.FastClock(				FastClock), 
							.SlowReset(				Reset),

							.ROIVIn(				Core_ROIVIn), 
							.ROBIDIn(				Core_ROBIDIn), 
							.ROCommandIn(			Core_ROCommandIn), 
							.ROCommandInValid(		Core_ROCommandInValid), 
							.ROCommandInReady(		Core_ROCommandInReady),
							
							.RWIVIn(				Core_RWIVIn), 
							.RWBIDIn(				Core_RWBIDIn), 
							.RWCommandInValid(		Core_RWCommandInValid), 
							.RWCommandInReady(		Core_RWCommandInReady),
							
							.RODataOut(				Core_RODataOut), 
							.ROCommandOut(			Core_ROCommandOut), 
							.RODataOutValid(		Core_RODataOutValid), 
							.RODataOutReady(		Core_RODataOutReady),
							
							.RWDataOut(				Core_RWDataOut), 
							.RWDataOutValid(		Core_RWDataOutValid),
							.RWDataOutReady(		Core_RWDataOutReady));
	
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
	//	To Backend
	//--------------------------------------------------------------------------

	assign	BEDataOut =	
	
	BEDataOutValid, BEDataOutReady,
	
	
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
