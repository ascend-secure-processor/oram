
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMTop
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
	`include "SHA3Local.vh"
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

	// Frontend - Backend
	
	(* mark_debug = "TRUE" *)	wire					BEnd_CmdReady, BEnd_CmdValid;
	(* mark_debug = "TRUE" *)	wire	[BECMDWidth-1:0] BEnd_Cmd;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]		BEnd_PAddr;
	(* mark_debug = "TRUE" *)	wire	[ORAML-1:0]		CurrentLeaf, RemappedLeaf;

	(* mark_debug = "TRUE" *)	wire	[FEDWidth-1:0]	LoadData, StoreData;
	(* mark_debug = "TRUE" *)	wire					LoadReady, LoadValid, StoreValid, StoreReady;

	// Backend - CC

	wire 	[DDRDWidth-1:0]	BE_DRAMWriteData, BE_DRAMReadData;
	wire					BE_DRAMWriteDataValid, BE_DRAMWriteDataReady;
	wire					BE_DRAMReadDataValid, BE_DRAMReadDataReady;	

	// CC - AES

    wire 	[DDRDWidth-1:0]	AES_DRAMWriteData, AES_DRAMReadData;
    wire 	[DDRMWidth-1:0]	AES_DRAMWriteMask;
    wire					AES_DRAMWriteDataValid, AES_DRAMWriteDataReady;
    wire					AES_DRAMReadDataValid, AES_DRAMReadDataReady;	
	
	// Path buffer

	wire					PathBuffer_OutValid, PathBuffer_OutReady;
	wire	[DDRDWidth-1:0]	PathBuffer_OutData;	
	
	// REW
	
	wire    [ORAMU-1:0]		ROPAddr;
	wire                    ROAccess, REWRoundDummy;
	wire					CSPathRead, CSPathWriteback;
    wire                    DRAMInitComplete;
	
	// integrity verification
	
	wire 						IVStart, IVDone, IVRequest, IVWrite;
	wire 	[PathBufAWidth-1:0] 	IVAddress;
	wire 	[DDRDWidth-1:0]  	DataFromIV, DataToIV;
	
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
							.EnableAES(				EnableAES),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							
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

							.DRAMReadData(			BE_DRAMReadData),
							.DRAMReadDataValid(		BE_DRAMReadDataValid),
							.DRAMReadDataReady(		BE_DRAMReadDataReady),
							
							.DRAMWriteData(			BE_DRAMWriteData),
							.DRAMWriteDataValid(	BE_DRAMWriteDataValid),
							.DRAMWriteDataReady(	BE_DRAMWriteDataReady),
							
                            .ROPAddr(               ROPAddr),
                            .ROAccess(          	ROAccess),
							.REWRoundDummy(			REWRoundDummy),
							.CSPathRead(			CSPathRead),
							.CSPathWriteback(		CSPathWriteback),			
							.DRAMInitComplete(		DRAMInitComplete));							
							
	//--------------------------------------------------------------------------
	//	Coherence Controller
	//--------------------------------------------------------------------------

	CoherenceController #(	.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.ORAME(					ORAME),
							
							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV))
							
				cc(			.Clock(					Clock),
							.Reset(					Reset),
									
                            .ROPAddr(               ROPAddr),
                            .ROAccess(          	ROAccess),
							.REWRoundDummy(			REWRoundDummy),
							.CSPathRead(			CSPathRead),
							.CSPathWriteback(		CSPathWriteback),
                            .DRAMInitComplete(		DRAMInitComplete),
							
							.FromDecData(			AES_DRAMReadData), 
							.FromDecDataValid(		AES_DRAMReadDataValid), 
							.FromDecDataReady(		AES_DRAMReadDataReady),
							
							.ToEncData(				AES_DRAMWriteData), 
							.ToEncDataValid(		AES_DRAMWriteDataValid), 
							.ToEncDataReady(		AES_DRAMWriteDataReady),

							.ToStashData(			BE_DRAMReadData),
							.ToStashDataValid(		BE_DRAMReadDataValid), 
							.ToStashDataReady(		BE_DRAMReadDataReady),

							.FromStashData(			BE_DRAMWriteData), 
							.FromStashDataValid(	BE_DRAMWriteDataValid), 
							.FromStashDataReady(	BE_DRAMWriteDataReady),
							
							.IVStart(				IVStart),
							.IVDone(				IVDone),
							.IVRequest(				IVRequest),
							.IVWrite(				IVWrite),
							.IVAddress(				IVAddress),
							.DataFromIV(			DataFromIV),
							.DataToIV(				DataToIV)						
					);
							
	//--------------------------------------------------------------------------
	//	Integrity Verification
	//--------------------------------------------------------------------------
	generate if (EnableIV) begin: INTEGRITY
		IntegrityVerifier #(	.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
								.DDRDQWidth(			DDRDQWidth),
								.DDRCWidth(				DDRCWidth),
								.DDRAWidth(				DDRAWidth),
								
								.ORAMB(					ORAMB),
								.ORAMU(					ORAMU),
								.ORAML(					ORAML),
								.ORAMZ(					ORAMZ),
								.ORAMC(					ORAMC),
								.ORAME(					ORAME))
				
			int_verifier	(	.Clock(					Clock),
								.Reset(					Reset || IVStart),
								
								.Request(				IVRequest),
								.Write(					IVWrite),
								.Address(				IVAddress),
								.DataIn(				DataToIV),
								.DataOut(				DataFromIV),
								
								.Done(					IVDone)
							);			
	end	else begin: NO_INTEGRITY		
		assign IVDone = 1;	
	end endgenerate
	//--------------------------------------------------------------------------
	//	Symmetric Encryption
	//--------------------------------------------------------------------------
	
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
							.MIGInReady(			PathBuffer_OutReady),
							
							.BackendRData(			AES_DRAMReadData),
							.BackendRValid(			AES_DRAMReadDataValid),
							.BackendRReady(			AES_DRAMReadDataReady),
							
							.BackendWData(			AES_DRAMWriteData),
							.BackendWMask(			AES_DRAMWriteMask),
							.BackendWValid(			AES_DRAMWriteDataValid),
							.BackendWReady(			AES_DRAMWriteDataReady),

							.DRAMInitDone(			DRAMInitComplete));
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
	//	DRAM Read Interface
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
							.InAccept(				PathBuffer_InReady),
							.OutData(				PathBuffer_OutData),
							.OutSend(				PathBuffer_OutValid),
							.OutReady(				PathBuffer_OutReady));
	end endgenerate

	//--------------------------------------------------------------------------
	//	DRAM Write Interface
	//--------------------------------------------------------------------------

	// TODO put write mask generation here
	
	assign	AES_DRAMWriteMask =						{DDRMWidth{1'b0}}; // TODO: have LowLevelBackend.v choose what to do with this
	
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
