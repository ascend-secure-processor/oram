
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMBackend
//	Desc:		The stash, AES, address generation, and throughput back-pressure 
//				logic (e.g., dummy access control, R^(E+1)W pattern control)
//==============================================================================
module PathORAMBackend(
	Clock, FastClock, Reset,

	Command, PAddr, CurrentLeaf, RemappedLeaf, 
	CommandValid, CommandReady,

	LoadData, 
	LoadValid, LoadReady,

	StoreData,
	StoreValid, StoreReady,
	
	DRAMCommandAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady
	);
	
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	
	`include "SecurityLocal.vh"	
	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	`include "SHA3Local.vh"
	
	parameter				DebugAES =				0;
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, FastClock, Reset;
	
	//--------------------------------------------------------------------------
	//	Frontend Interface
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] Command;
	input	[ORAMU-1:0]		PAddr;
	input	[ORAML-1:0]		CurrentLeaf; // If Command == Append, this is XX 
	input	[ORAML-1:0]		RemappedLeaf;
	input					CommandValid;
	output 					CommandReady;

	// TODO set CommandReady = 0 if LoadDataReady = 0 (i.e., the front end can't take our result!)
	
	output	[FEDWidth-1:0]	LoadData;
	output					LoadValid;
	input 					LoadReady;

	input	[FEDWidth-1:0]	StoreData;
	input 					StoreValid;
	output 					StoreReady;
	
	//--------------------------------------------------------------------------
	//	DRAM Interface
	//--------------------------------------------------------------------------

	output	[DDRAWidth-1:0]	DRAMCommandAddress;
	output	[DDRCWidth-1:0]	DRAMCommand;
	output					DRAMCommandValid;
	input					DRAMCommandReady;
	
	input	[DDRDWidth-1:0]	DRAMReadData;
	input					DRAMReadDataValid;
	output					DRAMReadDataReady;
	
	output	[DDRDWidth-1:0]	DRAMWriteData;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	// Backend - CC

	wire 	[DDRDWidth-1:0]	BE_DRAMWriteData, BE_DRAMReadData;
	(* mark_debug = "TRUE" *)	wire					BE_DRAMWriteDataValid, BE_DRAMWriteDataReady;
	(* mark_debug = "TRUE" *)	wire					BE_DRAMReadDataValid, BE_DRAMReadDataReady;	

    wire                    DRAMInitComplete;
	
	// CC - AES

    (* mark_debug = "TRUE" *)	wire 	[DDRDWidth-1:0]	AES_DRAMWriteData, AES_DRAMReadData;
    (* mark_debug = "TRUE" *)	wire					AES_DRAMWriteDataValid, AES_DRAMWriteDataReady;
	(* mark_debug = "TRUE" *)	wire					AES_DRAMReadDataValid, AES_DRAMReadDataReady;	

	// REW
	
	wire    [ORAMU-1:0]		ROPAddr;
	wire	[ORAML-1:0]		ROLeaf;
	wire                    REWRoundDummy;
	
	// integrity verification
		
	wire 					PathReady_IV, PathDone_IV, BOIReady_IV, BOIDone_IV;
	wire 					IVRequest, IVWrite;
	wire 	[PathBufAWidth-1:0]	IVAddress;
	wire 	[DDRDWidth-1:0]  DataFromIV, DataToIV;

	wire	[AESEntropy-1:0] CC_ROIBV;
	wire	[ORAML:0]		 CC_ROIBID;
	wire	[AESEntropy-1:0] AES_ROIBV;
	wire	[ORAML:0]		 AES_ROIBID;	

	wire					FromStashDataDone;
		
	//--------------------------------------------------------------------------
	//	Address generation & the stash
	//--------------------------------------------------------------------------

	PathORAMBackendInner #(	.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.ORAME(					ORAME),
							
							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							.DelayedWB(				DelayedWB),
							
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth))
			bend_inner (	.Clock(					Clock),
				`ifdef ASIC
							.Reset(					Reset),
				`else
							.Reset(					1'b0),
				`endif			
							.Command(				Command),
							.PAddr(					PAddr),
							.CurrentLeaf(			CurrentLeaf),
							.RemappedLeaf(			RemappedLeaf),
							.CommandValid(			CommandValid),
							.CommandReady(			CommandReady),
							.LoadData(				LoadData),
							.LoadValid(				LoadValid),
							.LoadReady(				LoadReady),
							.StoreData(				StoreData),
							.StoreValid(			StoreValid),
							.StoreReady(			StoreReady),
							
							.DRAMCommandAddress(	DRAMCommandAddress),
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
							.ROLeaf(				ROLeaf),
							.ROStart(				ROStart),
							.REWRoundDummy(			REWRoundDummy),
							.DRAMInitComplete(		DRAMInitComplete));							
	
	//----------------------------------------------------------------------
	//	Integrity Verification (REW ORAM only)
	//----------------------------------------------------------------------
	
	localparam	BRAMLatency = 2;
	generate if (EnableREW) begin:CC
		CoherenceController #(.ORAMB(				ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.ORAME(					ORAME),
							
							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							.DelayedWB(				DelayedWB),
							.BRAMLatency(			BRAMLatency))
									
				cc(			.Clock(					Clock),
							.Reset(					Reset),
									
							.ROPAddr(               ROPAddr),
							.ROLeaf(				ROLeaf),
							.ROStart(				ROStart),
							.REWRoundDummy(			REWRoundDummy),
							
							.FromDecData(			AES_DRAMReadData), 
							.FromDecDataValid(		AES_DRAMReadDataValid),
							
							.ToEncData(				AES_DRAMWriteData), 
							.ToEncDataValid(		AES_DRAMWriteDataValid), 
							.ToEncDataReady(		AES_DRAMWriteDataReady),	

							.ToStashData(			BE_DRAMReadData),
							.ToStashDataValid(		BE_DRAMReadDataValid), 
							.ToStashDataReady(		BE_DRAMReadDataReady),

							.FromStashData(			BE_DRAMWriteData), 
							.FromStashDataValid(	BE_DRAMWriteDataValid), 
							.FromStashDataReady(	BE_DRAMWriteDataReady),
							.FromStashDataDone(		FromStashDataDone),
							
							.PathReady_IV(			PathReady_IV),
							.PathDone_IV(			PathDone_IV),
							.IVRequest(				IVRequest),
							.IVWrite(				IVWrite),
							.IVAddress(				IVAddress),
							.DataFromIV(			DataFromIV),
							.DataToIV(				DataToIV),
							
							.ROIBV(					CC_ROIBV),
							.ROIBID(				CC_ROIBID),
							
							.BOIReady_IV(			BOIReady_IV),
							.BOIFromCC(				BOIFromCC),
							.BOIDone_IV(			BOIDone_IV)
						);
							
		 if (EnableIV) begin:INTEGRITY
			IntegrityVerifier #(.ORAMB(				ORAMB),
								.ORAMU(				ORAMU),
								.ORAML(				ORAML),
								.ORAMZ(				ORAMZ),
								.BRAMLatency(		BRAMLatency))
					
				iv(				.Clock(				Clock),
								.Reset(				Reset),
							
								.Request(			IVRequest),
								.Write(				IVWrite),
								.Address(			IVAddress),
								.DataIn(			DataToIV),
								.DataOut(			DataFromIV),
							
								.PathReady(			PathReady_IV),
								.PathDone(			PathDone_IV),
								.BOIReady(			BOIReady_IV),
								.BOIFromCC(			BOIFromCC),
								.BOIDone(			BOIDone_IV),
								
								.ROIBV(				CC_ROIBV),
								.ROIBID(			CC_ROIBID)
							);
									
			// TODO: debugging now
		
		end	else begin: NO_INTEGRITY		
			assign	IVRequest = 					1'b0;
			assign 	IVWrite = 						1'b0;
			assign 	IVAddress = 					0;
			assign	DataFromIV = 					0;
		
			// only the following two are important
			assign	PathDone_IV = 					1'b1;
			assign	BOIDone_IV = 					1'b1;
		end
		
	end else begin: NO_CC
		assign	BE_DRAMReadData = AES_DRAMReadData;
		assign	BE_DRAMReadDataValid = AES_DRAMReadDataValid;
		assign	AES_DRAMReadDataReady = BE_DRAMReadDataReady;
		
		assign	AES_DRAMWriteData = BE_DRAMWriteData;
		assign  AES_DRAMWriteDataValid = BE_DRAMWriteDataValid;
		assign	BE_DRAMWriteDataReady = AES_DRAMWriteDataReady;
		
		assign	FromStashDataDone = 1'b1;
	end endgenerate
	
	//--------------------------------------------------------------------------
	//	Symmetric Encryption
	//--------------------------------------------------------------------------
	
	generate if (EnableAES) begin:AES
		if (EnableREW) begin:REW_AES
			AESREWORAM	#(	.ORAMZ(					ORAMZ),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMB(					ORAMB),
							.ORAME(					ORAME),
							.Overclock(				Overclock),
							.EnableIV(				EnableIV),
							.DelayedWB(				DelayedWB),
							.DebugAES(				DebugAES))
							
				aes(		.Clock(					Clock), 
							.FastClock(				FastClock),
				`ifdef ASIC
							.Reset(					Reset),
				`else
							.Reset(					1'b0),
				`endif
							.ROPAddr(				ROPAddr),
							.ROLeaf(				ROLeaf), 
							
							.ROIBVOut(				AES_ROIBV),
							.ROIBIDOut(				AES_ROIBID),
														
							.BEDataOut(				AES_DRAMReadData), 
							.BEDataOutValid(		AES_DRAMReadDataValid), 					

							.BEDataIn(				AES_DRAMWriteData), 
							.BEDataInValid(			AES_DRAMWriteDataValid), 
							.BEDataInReady(			AES_DRAMWriteDataReady),	
							
							.DRAMReadData(			DRAMReadData), 
							.DRAMReadDataValid(		DRAMReadDataValid), 
							.DRAMReadDataReady(		DRAMReadDataReady),
							
							.DRAMWriteData(			DRAMWriteData), 
							.DRAMWriteDataValid(	DRAMWriteDataValid), 
							.DRAMWriteDataReady(	DRAMWriteDataReady));
							
		end else begin:BASIC_AES
			AESPathORAM #(	.ORAMB(					ORAMB), // TODO which of these params are really needed?
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.Overclock(				Overclock),
							.EnableREW(				EnableREW),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth))
					aes(	.Clock(					Clock),
							.Reset(					Reset),							
							
							.DRAMReadData(			DRAMReadData), 
							.DRAMReadDataValid(		DRAMReadDataValid), 
							.DRAMReadDataReady(		DRAMReadDataReady),
							
							.DRAMWriteData(			DRAMWriteData), 
							.DRAMWriteDataValid(	DRAMWriteDataValid), 
							.DRAMWriteDataReady(	DRAMWriteDataReady),
													
							.BackendRData(			AES_DRAMReadData),
							.BackendRValid(			AES_DRAMReadDataValid),
							.BackendRReady(			AES_DRAMReadDataReady),
							
							.BackendWData(			AES_DRAMWriteData),
							.BackendWValid(			AES_DRAMWriteDataValid),
							.BackendWReady(			AES_DRAMWriteDataReady),

							.DRAMInitDone(			DRAMInitComplete));
		end
	end else begin:NO_AES
		assign	DRAMWriteData = 					AES_DRAMWriteData;
		assign	DRAMWriteDataValid =				AES_DRAMWriteDataValid;
		assign	AES_DRAMWriteDataReady =			DRAMWriteDataReady;
	
		assign	AES_DRAMReadData =					DRAMReadData;
		assign	AES_DRAMReadDataValid =				DRAMReadDataValid;
		assign	DRAMReadDataReady = 				AES_DRAMReadDataReady;
	end endgenerate
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------