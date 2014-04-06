
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		AESREWORAM
//	Desc:		AES Unit for REW ORAM
//==============================================================================
module TinyAESRV(
	Clock, FastClock, 
	Reset,

	ROPAddr, ROPAddrValid,
	
	BEDataOut, BEDataOutValid, BEDataOutReady,
	BEDataIn, BEDataInValid, BEDataInReady,	
	
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,
	);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	parameter				NPorts =				1;
	
	localparam				BktSize_AESChunks =		BktSize_DRBursts * `divceil(DDRDWidth, AESWidth),
							CIDWidth =				`log2(BktSize_AESChunks),
							BIDWidth =				ORAML + 2, // matching AddrGen
							SeedSpaceRemaining =	AESWidth - IVEntropyWidth - BIDWidth - CIDWidth;
	
	localparam				ACMDWidth =				1,
							CMD_RO =				1'b0,
							CMD_RW =				1'b1;
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, FastClock, Reset;
	
	//--------------------------------------------------------------------------
	//	Backend Interface
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
	
	ServiceRO
	
	FIFORegister #(			.Width(					IVEntropyWidth))
				ro_state(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				),
							.InValid(				),
							.InAccept(				),
							.OutData(				),
							.OutSend(				),
							.OutReady(				));	
	
	Counter		#(			.Width(					))
				ro_cid(		.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				),
							.In(					{{1'bx}}),
							.Count(					ROChunkID));
	
	ROIV
	ROBucketID
	ROChunkID
	ROSeed

	assign	ROSeed =								{ {SeedSpaceRemaining{1'b0}}, ROIV, ROBucketID, ROChunkID };
	
	//--------------------------------------------------------------------------
	//	RW Seed Generation
	//--------------------------------------------------------------------------

	RWSeed
	
	//--------------------------------------------------------------------------
	//	AES
	//--------------------------------------------------------------------------
	
	AESDataIn
	AESDataInValid
	AESDataInReady
	
	AESCommand =
	
	assign	AESDataIn =								(ServiceRO) ? ROSeed : RWSeed;
	assign	AESDataInValid =						;
	
	assign	AESCommand =							(ServiceRO) ? CMD_RO : CMD_RW;
	
	TinyAESRV 	#(			.NPorts(				1),
							.AESWidth(				AESWidth))
				aes(		.SlowClock(				Clock), 		
							.FastClock(				FastClock),
							.SlowReset(				Reset),

							.DataIn(				), 
							.DataInValid(			), 
							.DataInReady(			),
							.DataOut(				), 
							.DataOutValid(			), 
							.DataOutReady(			));
							
	FIFORAM		#(			.Width(					1),
							.Buffering(				))
				cmd_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				),
							.InValid(				AESDataInValid),
							.InAccept(				),
							.OutData(				),
							.OutSend(				),
							.OutReady(				));
	
	//--------------------------------------------------------------------------
	//	RW Mask storage
	//--------------------------------------------------------------------------

	FIFOShiftRound #(		.IWidth(				),
							.OWidth(				DDRDWidth))
				mask_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				),
							.InValid(				),
							.InAccept(				),
							.OutData(				),
							.OutValid(				),
							.OutReady(				));
							
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				PathSize_DRBursts * 2)) // enough for a R + W path
				mask_fifo(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				),
							.InValid(				),
							.InAccept(				),
							.OutData(				),
							.OutSend(				),
							.OutReady(				));
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
