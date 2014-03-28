
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAM
//	Desc:		{Unified} x {Basic, REW} Path ORAM with encryption, integrity 
//				verification, & a DRAM interface
//==============================================================================
module PathORamTop(
  	Clock, Reset,
	
	Cmd, PAddr, 
	CmdValid, CmdReady, 
	
	DataIn,
	DataInValid, DataInReady,

	DataOut,
	DataOutValid, DataOutReady,
	
	DRAMAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid,
	DRAMWriteData, DRAMWriteMask, DRAMWriteDataValid, DRAMWriteDataReady
	);	
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh";
	`include "DDR3SDRAM.vh";
	`include "AES.vh";
	`include "Stash.vh"; 
	`include "UORAM.vh"; 
	`include "PLB.vh";
	
	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
    	`include "PLBLocal.vh" 

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	
	//--------------------------------------------------------------------------
	//	Interface to network
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] Cmd;
	input	[ORAMU-1:0]		PAddr;
	input					CmdValid;
	output 					CmdReady;
	
	input	[FEDWidth-1:0]	DataIn;
	input					DataInValid;
	output 					DataInReady;

	output	[FEDWidth-1:0]	DataOut;
	output 					DataOutValid;
	input 					DataOutReady;
	
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
	//	Wires & Regs
	//-------------------------------------------------------------------------- 

	(* mark_debug = "TRUE" *)	wire					BEnd_CmdReady, BEnd_CmdValid;
	(* mark_debug = "TRUE" *)	wire	[BECMDWidth-1:0] BEnd_Cmd;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]		BEnd_PAddr;
	(* mark_debug = "TRUE" *)	wire	[ORAML-1:0]		CurrentLeaf, RemappedLeaf;

	(* mark_debug = "TRUE" *)	wire	[FEDWidth-1:0]	LoadData, StoreData;
	(* mark_debug = "TRUE" *)	wire					LoadReady, LoadValid, StoreValid, StoreReady;
	
    wire 	[DDRDWidth-1:0]	AES_DRAMWriteData, AES_DRAMReadData;
    wire 	[DDRMWidth-1:0]	AES_DRAMWriteMask;
    wire					AES_DRAMWriteDataValid, AES_DRAMWriteDataReady;
    wire					AES_DRAMReadDataValid, AES_DRAMReadDataReady;
	
	wire					DRAMInitComplete;
	
	wire					PathBuffer_OutValid, PathBuffer_OutReady;
	wire	[DDRDWidth-1:0]	PathBuffer_OutData;	
	
	//--------------------------------------------------------------------------
	//	Core modules
	//-------------------------------------------------------------------------- 	
	
	UORamController #(  	.ORAMU(         		ORAMU), 
							.ORAML(         		ORAML), 
							.ORAMB(         		ORAMB), 
							.FEDWidth(				FEDWidth),
							.NumValidBlock( 		NumValidBlock), 
							.Recursion(     		Recursion), 
							.LeafWidth(     		LeafWidth), 
							.PLBCapacity(   		PLBCapacity)) 
				front_end(	.Clock(             	Clock), 
							.Reset(					Reset), 
							
							.CmdInReady(			CmdReady), 
							.CmdInValid(			CmdValid), 
							.CmdIn(					Cmd), 
							.ProgAddrIn(			PAddr),
							.DataInReady(			DataInReady), 
							.DataInValid(			DataInValid), 
							.DataIn(				DataIn),                                    
							.ReturnDataReady(		DataOutReady), 
							.ReturnDataValid(		DataOutValid), 
							.ReturnData(			DataOut),
		                        
							.CmdOutReady(			BEnd_CmdReady), 
							.CmdOutValid(			BEnd_CmdValid), 
							.CmdOut(				BEnd_Cmd), 
							.AddrOut(				BEnd_PAddr), 
							.OldLeaf(				CurrentLeaf), 
							.NewLeaf(				RemappedLeaf), 
							.StoreDataReady(		StoreReady), 
							.StoreDataValid(		StoreValid), 
							.StoreData(				StoreData),
							.LoadDataReady(			LoadReady), 
							.LoadDataValid(			LoadValid), 
							.LoadData(				LoadData));
	
	PathORAMBackend #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.ORAME(					ORAME),
							.Overclock(				Overclock),
							.EnableREW(				EnableREW),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),							
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
				back_end (	.Clock(					Clock),
							.Reset(					Reset),
							
							.Command(				BEnd_Cmd),
							.PAddr(					BEnd_PAddr),
							.CurrentLeaf(			CurrentLeaf),
							.RemappedLeaf(			RemappedLeaf),
							.CommandValid(			BEnd_CmdValid),
							.CommandReady(			BEnd_CmdReady),
							.LoadData(				LoadData),
							.LoadValid(				LoadValid),
							.LoadReady(				LoadReady),
							.StoreData(				StoreData),
							.StoreValid(			StoreValid),
							.StoreReady(			StoreReady),
							
							.DRAMCommandAddress(	DRAMAddress),
							.DRAMCommand(			DRAMCommand),
							.DRAMCommandValid(		DRAMCommandValid),
							.DRAMCommandReady(		DRAMCommandReady),			

							.DRAMReadData(			AES_DRAMReadData),
							.DRAMReadDataValid(		AES_DRAMReadDataValid),
							.DRAMReadDataReady(		AES_DRAMReadDataReady),
							
							.DRAMWriteData(			AES_DRAMWriteData),
							.DRAMWriteDataValid(	AES_DRAMWriteDataValid),
							.DRAMWriteDataReady(	AES_DRAMWriteDataReady),
							.DRAMInitComplete(		DRAMInitComplete));							
							
	//--------------------------------------------------------------------------
	//	Symmetric Encryption
	//--------------------------------------------------------------------------
	
	// TODO don't comment this out entirely if EnableAES == 0
	// (we still need path buffer, REW invalidations, data write mask generation)
	
	// TODO don't pass address lines through AES
	
	assign	AES_DRAMWriteMask =						{DDRMWidth{1'b0}}; // TODO: have LowLevelBackend.v choose what to do with this
	
	generate if (EnableAES) begin:AES
							// TODO which of these params are really needed?
		AESPathORAM #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.Overclock(				Overclock),
							.EnableREW(				EnableREW),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
				aes(		.Clock(					Clock),
							.Reset(					Reset),

							.MIGOut(				DRAMWriteData),
							.MIGOutMask(			DRAMWriteMask),
							.MIGOutValid(			DRAMWriteDataValid),
							.MIGOutReady(			DRAMWriteDataReady),

							.MIGIn(					DRAMReadData),
							.MIGInValid(			DRAMReadDataValid),

							.BackendRData(			AES_DRAMReadData),
							.BackendRValid(			AES_DRAMReadDataValid),
							.BackendRReady(			AES_DRAMReadDataReady),
							
							.BackendWData(			AES_DRAMWriteData),
							.BackendWMask(			AES_DRAMWriteMask),
							.BackendWValid(			AES_DRAMWriteDataValid),
							.BackendWReady(			AES_DRAMWriteDataReady),

							.DRAMInitDone(			DRAMInitComplete));

	assign	PathBuffer_OutReady = 1'b1; // TODO remove when we take path buffer out of AES
							
	end else begin:NO_AES
		assign	DRAMWriteData = 					AES_DRAMWriteData;
		assign	DRAMWriteMask =						AES_DRAMWriteMask;
		assign	DRAMWriteDataValid =				AES_DRAMWriteDataValid;
		assign	AES_DRAMWriteDataReady =			DRAMWriteDataReady;
	
		assign	AES_DRAMReadData =					PathBuffer_OutData;
		assign	AES_DRAMReadDataValid =				PathBuffer_OutValid;
		assign	PathBuffer_OutReady = 				AES_DRAMReadDataReady;
	end endgenerate
	
	//--------------------------------------------------------------------------
	//	DRAM Interface
	//--------------------------------------------------------------------------

	generate if (Overclock) begin:INBUF_BRAM
		wire				PathBuffer_Full, PathBuffer_Empty;

		PathBuffer in_P_buf(.clk(					Clock),
							.srst(					Reset), 
							.din(					DRAMReadData), 
							.wr_en(					DRAMReadDataValid), 
							.rd_en(					PathBuffer_OutReady), 
							.dout(					PathBuffer_OutData), 
							.full(					PathBuffer_Full), 
							.empty(					PathBuffer_Empty));
							
		assign	PathBuffer_InReady =				~PathBuffer_Full;
		assign	PathBuffer_OutValid =				~PathBuffer_Empty;							
	end else begin:INBUF_LUTRAM
		FIFORAM	#(			.Width(					DDRDWidth),
							.Buffering(				PathSize_DRBursts))
				in_P_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMReadData),
							.InValid(				DRAMReadDataValid),
							.InAccept(				PathBuffer_InReady), // debugging
							.OutData(				PathBuffer_OutData),
							.OutSend(				PathBuffer_OutValid),
							.OutReady(				PathBuffer_OutReady));
	end endgenerate
	
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
