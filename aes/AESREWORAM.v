
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
//
//				TODO update this description
//
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
	
	BEDataOut, BEIVOut, BEDataOutValid, BEDataOutReady,
	BEDataIn, BEDataInValid, BEDataInReady,	
	
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,
	);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

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

	// RW related
	
	// AES Core
	
	wire		[IVEntropyWidth-1:0] Core_ROIVIn; 
	wire		[BIDWidth-1:0] Core_ROBIDIn; 
	wire		[PCCMDWidth-1:0] Core_ROCommandIn; 
	wire					Core_ROCommandInValid;
	wire					Core_ROCommandInReady;

	wire		[IVEntropyWidth-1:0] Core_RWIVIn;
	wire		[BIDWidth-1:0] Core_RWBIDIn;
	wire					Core_RWCommandInValid; 
	wire					Core_RWCommandInReady;

	wire	[AESWidth-1:0]	Core_RODataOut; 
	wire	[PCCMDWidth-1:0] Core_ROCommandOut;
	wire					Core_RODataOutValid;
	wire					Core_RODataOutReady;
	
	wire	[DDRDWidth-1:0]	Core_RWDataOut;
	wire					Core_RWDataOutValid;
	wire					Core_RWDataOutReady;	
	
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
	
	/*
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
	*/
	
	//--------------------------------------------------------------------------
	//	RW AES Input
	//--------------------------------------------------------------------------

	localparam				RWSWidth =				3,
							ST_RW_Idle =			3'd0,
							ST_RW_StartRead =		3'd1,
							ST_RW_Read =			3'd2,
							ST_RW_StartWrite =		3'd3,
							ST_RW_Write =			3'd4;
	
	reg	[RWSWidth-1:0] 		CS_RW, NS_RW;
	wire					CSRWStartOp, CSRWWrite;
	
	wire					PathTransition;
	wire					RWCommandTransfer, RWMaskTransfer;

	wire	[IVEntropyWidth-1:0] GentryCounter, GentryCounterShifted, RWIVOut;

	wire					RWIVInValid, RWIVInReady;
	wire					RWIVOutValid, RWIVOutReady;		
	
	wire					RW_BIDInReady, RW_BIDOutValid, RW_BIDOutReady;	
	
	wire	[ORAML-1:0]		GentryLeaf;	
	
	assign	CSRWStartOp =							CS_RW == ST_RW_StartRead | CS_RW == ST_RW_StartWrite;
	assign	CSRWWrite =								CS_RW == ST_RW_Write;
	
	always @(posedge Clock) begin
		if (Reset) CS_RW <= 						ST_RW_Idle;
		else CS_RW <= 								NS_RW;
	end
	
	always @( * ) begin
		NS_RW = 									CS_RW;
		case (CS_RW)
			ST_RW_Idle : 
				NS_RW =								ST_RW_StartRead;
			ST_RW_StartRead :
				if (RW_BIDInReady)
					NS_RW =							ST_RW_Read;
			ST_RW_Read : 
				if (PathTransition)
					NS_RW =							ST_RW_StartWrite;
			ST_RW_StartWrite : 
				if (RW_BIDInReady)
					NS_RW =							ST_RW_Write;
			ST_RW_Write : 
				if (PathTransition)
					NS_RW =							ST_RW_Idle;
		endcase
	end
	
	CountAlarm #(			.Threshold(				ORAML + 1))
				rw_lvl_cnt(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				RWCommandTransfer),
							.Done(					PathTransition));	
	
	Counter		#(			.Width(					IVEntropyWidth))
				gentry_leaf(.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				PathTransition & CSRWWrite),
							.In(					{IVEntropyWidth{1'bx}}),
							.Count(					GentryCounter));
							
	// RW seed generation scheme for bucket @ level L (L = 0...):
	// decrypt(M >> L)
	// encrypt((M >> L) + 1)
	ShiftRegister #(		.PWidth(				IVEntropyWidth),
							.SWidth(				1))
				gentry_shft(.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					CSRWStartOp),
							.Enable(				RWCommandTransfer), 
							.PIn(					GentryCounter),
							.POut(					GentryCounterShifted));
	assign	Core_RWIVIn =							(CSRWWrite) ? GentryCounterShifted + 1 : GentryCounterShifted;
	
	assign	GentryLeaf =							GentryCounter[ORAML-1:0];
	
    AddrGen #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
				rw_bid(		.Clock(					Clock),
							.Reset(					Reset),
							.Start(					CSRWStartOp), 
							.Ready(					RW_BIDInReady),
							.RWIn(					1'b0),
							.BHIn(					1'b0),
							.leaf(					GentryLeaf),
							.CmdValid(				RW_BIDOutValid),
							.CmdReady(				RW_BIDOutReady),
							.BktIdx(				Core_RWBIDIn));
	
	assign	Core_RWCommandInValid =					RW_BIDOutValid & 		RWIVInReady;
	assign	RWIVInValid =							RW_BIDOutValid & 		Core_RWCommandInReady;
	assign	RW_BIDOutReady =						RWIVInReady & 			Core_RWCommandInReady;
	
	assign	RWCommandTransfer =						Core_RWCommandInValid & Core_RWCommandInReady;
	
	// Store Gentry seeds for CC
	// Invariant: Core_RWDataOutValid -> RWIVOutValid
	FIFORAM		#(			.Width(					IVEntropyWidth),
							.Buffering(				3 * (L + 1))) // we can let it run ahead
				rw_M_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				Core_RWIVIn),
							.InValid(				RWIVInValid),
							.InAccept(				RWIVInReady),
							.OutData(				RWIVOut),
							.OutSend(				RWIVOutValid), // TODO add assertion to enforce invariant
							.OutReady(				RWMaskTransfer));
	
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
	//	RO AES Output
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	RW AES Output
	//--------------------------------------------------------------------------
	
	assign	RWMaskTransfer =						~ROAccess & ( (BEDataOutValid & DRAMReadDataReady) | (DRAMWriteDataValid & BEDataInReady) );
	
	//--------------------------------------------------------------------------
	//	To Backend
	//--------------------------------------------------------------------------
	
	assign	BEDataOut =								(ROAccess) ? 0 : DRAMReadData ^ Core_RWDataOut;
	assign	BEIVOut =								(ROAccess) ? 0 : RWIVOut;
	assign	BEDataOutValid =						(ROAccess) ? 0 : DRAMReadDataValid 	& Core_RWDataOutValid;

	assign	DRAMReadDataReady =						(ROAccess) ? 0 : BEDataOutReady 		& Core_RWDataOutValid;

	//--------------------------------------------------------------------------
	//	To DRAM
	//--------------------------------------------------------------------------

	assign	DRAMWriteData =							(ROAccess) ? 0 : BEDataIn ^ Core_RWDataOut;
	assign	DRAMWriteDataValid = 					(ROAccess) ? 0 : BEDataInValid 		& Core_RWDataOutValid;

	assign	BEDataInReady = 						(ROAccess) ? 0 : DRAMWriteDataReady 	& Core_RWDataOutValid;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
