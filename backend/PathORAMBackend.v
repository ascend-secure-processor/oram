
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMBackend
//	Desc:		The stash, AES, address generation, and throughput back-pressure 
//				logic (e.g., dummy access control, REW pattern control)
//==============================================================================
module PathORAMBackend(
	Clock, AESClock, Reset,

	Command, PAddr, CurrentLeaf, RemappedLeaf, 
	CommandValid, CommandReady,

	LoadData, 
	LoadValid, LoadReady,

	StoreData,
	StoreValid, StoreReady,
	
	DRAMCommandAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid,
	DRAMWriteData, DRAMWriteMask, DRAMWriteDataValid, DRAMWriteDataReady
	);
	
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh"
	
	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "ConstBucketHelpers.vh"
	`include "ConstCommands.vh"
	`include "SHA3Local.vh"
	
	parameter				ORAMUValid =			21;
	
	parameter				DebugDRAMReadTiming =	0;
	
	localparam				ORAMLogL = 				`log2(ORAML+1);
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
	input 					Clock, AESClock, Reset;
	
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
	
	output	[DDRDWidth-1:0]	DRAMWriteData;
	output	[DDRMWidth-1:0]	DRAMWriteMask;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	// Backend - CC

	wire 	[DDRDWidth-1:0]	BE_DRAMWriteData, BE_DRAMReadData;
	(* mark_debug = "TRUE" *)	wire					BE_DRAMWriteDataValid, BE_DRAMWriteDataReady;
	(* mark_debug = "TRUE" *)	wire					BE_DRAMReadDataValid, BE_DRAMReadDataReady;	

    (* mark_debug = "FALSE" *)	wire                    DRAMInitComplete;
	
	// CC - AES

    (* mark_debug = "TRUE" *)	wire 	[DDRDWidth-1:0]	AES_DRAMWriteData, AES_DRAMReadData;
    (* mark_debug = "TRUE" *)	wire					AES_DRAMWriteDataValid, AES_DRAMWriteDataReady;
	(* mark_debug = "TRUE" *)	wire					AES_DRAMReadDataValid, AES_DRAMReadDataReady;	

	// AES - PHY

	wire 	[DDRDWidth-1:0]	BED_DRAMReadData;
	wire					BED_DRAMReadDataValid, BED_DRAMReadDataReady;
	
	wire 	[DDRDWidth-1:0]	BED_DRAMWriteData;
	wire					BED_DRAMWriteDataValid, BED_DRAMWriteDataReady;
	
	// PHY - DRAM
	
	wire	[DDRDWidth-1:0]	PBF_DRAMReadData;
	wire					PBF_DRAMReadDataValid, PBF_DRAMReadDataReady, PathBuffer_InReady;	
	
	// REW

	wire    [ORAMU-1:0]		ROPAddr;
	wire	[ORAML-1:0]		ROLeaf;
	wire                    REWRoundDummy;

	(* mark_debug = "TRUE" *)	wire					ROStartCCValid, ROStartAESValid;
	(* mark_debug = "TRUE" *)	wire					ROStartCCReady, ROStartAESReady;
	
	// Integrity verification
		
	(* mark_debug = "TRUE" *)	wire 					PathReady_IV, PathDone_IV, BOIReady_IV, BOIDone_IV, BucketOfITurn, BOIFromCC;
	(* mark_debug = "TRUE" *)	wire 					IVRequest, IVWrite;
	wire 	[PathBufAWidth-1:0]	IVAddress;
	wire 	[DDRDWidth-1:0]  DataFromIV, DataToIV;

	wire	[AESEntropy-1:0] CC_ROIBV;
	wire	[ORAML:0]		 CC_ROIBID;
	
	wire	[ORAMLogL-1:0]	BktOfIIdx;

	wire					FromStashDataDone; // TODO remove?
	
	//--------------------------------------------------------------------------
	//	Simulation checks
	//--------------------------------------------------------------------------
	
	`ifdef SIMULATION
		always @(posedge Clock) begin
			if (DRAMReadDataValid && ~PathBuffer_InReady) begin
				$display("[%m @ %t] ERROR: Path buffer overflow", $time);
				$finish;
			end
		end
	`endif
		
	//--------------------------------------------------------------------------
	//	Address generation & the stash
	//--------------------------------------------------------------------------

	PathORAMBackendCore #(	.ORAMB(					ORAMB),
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
							.BEDWidth(				BEDWidth),
							
							.ORAMUValid(			ORAMUValid))
			bend_core(		.Clock(					Clock),
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
							.REWRoundDummy(			REWRoundDummy),
							
							.ROStartCCValid(		ROStartCCValid), 
							.ROStartAESValid(		ROStartAESValid),
							.ROStartCCReady(		ROStartCCReady), 
							.ROStartAESReady(		ROStartAESReady),
							
							.DRAMInitComplete(		DRAMInitComplete));							
	
	//----------------------------------------------------------------------
	//	Integrity Verification (REW ORAM only)
	//----------------------------------------------------------------------
	
	localparam	BRAMLatency = 2; // TODO clean up
	generate if (EnableREW) begin:CC
		CoherenceController #(.ORAMB(				ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.ORAME(					ORAME),
							.BEDWidth(				BEDWidth),
							
							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableREW(				EnableREW),
							.EnableIV(				EnableIV),
							.DelayedWB(				DelayedWB),
							.BRAMLatency(			BRAMLatency))
									
				cc(			.Clock(					Clock),
							.Reset(					Reset),
							
							.ROCmdValid(			ROStartCCValid),	
							.ROCmdReady(			ROStartCCReady),							
							.ROPAddrIn(             ROPAddr),
							.ROLeafIn(				ROLeaf),
							.RODummyIn(				REWRoundDummy),
							
							.FromDecData(			AES_DRAMReadData), 
							.FromDecDataValid(		AES_DRAMReadDataValid),
							
							.ToEncData(				AES_DRAMWriteData), 
							.ToEncDataValid(		AES_DRAMWriteDataValid), 
							.ToEncDataReady(		AES_DRAMWriteDataReady),	

							.ToStashData(			BE_DRAMReadData),
							.ToStashDataValid(		BE_DRAMReadDataValid), 
							.ToStashDataReady(		1'b1),

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
							.BktOfIIdx(				BktOfIIdx),
							.BOIDone_IV(			BOIDone_IV),
							.BucketOfITurn(			BucketOfITurn));		
			
		`ifdef SIMULATION
			always @(posedge Clock) begin
				if (BE_DRAMReadDataValid && !BE_DRAMReadDataReady) begin
					$display("Error: ToStashData Valid not Stash not ready");
					$finish;
				end
			end
		`endif	
					
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
								.ROILevel(			BktOfIIdx),
								.BOIDone(			BOIDone_IV),
								.BucketOfITurn(		BucketOfITurn),
								
								.ROIBV(				CC_ROIBV),
								.ROIBID(			CC_ROIBID));
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
		assign	ROStartCCReady = 					1'b1;
		assign	FromStashDataDone = 				1'b1;
		
		assign	BE_DRAMReadData = 					AES_DRAMReadData;
		assign	BE_DRAMReadDataValid = 				AES_DRAMReadDataValid;
		assign	AES_DRAMReadDataReady = 			BE_DRAMReadDataReady;
		
		assign	AES_DRAMWriteData = 				BE_DRAMWriteData;
		assign  AES_DRAMWriteDataValid = 			BE_DRAMWriteDataValid;
		assign	BE_DRAMWriteDataReady = 			AES_DRAMWriteDataReady;
	end endgenerate
	
	//--------------------------------------------------------------------------
	//	Symmetric Encryption
	//--------------------------------------------------------------------------

	generate if (EnableREW) begin:REW_AES
		AESREWORAM	#(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAME(					ORAME),
							.BEDWidth(				BEDWidth),
							.Overclock(				Overclock),
							.EnableAES(				EnableAES),
							.EnableIV(				EnableIV),
							.DelayedWB(				DelayedWB),
							.ORAMUValid(			ORAMUValid))
			aes(			.Clock(					Clock), 
							.FastClock(				AESClock),
			`ifdef ASIC
							.Reset(					Reset),
			`else	
							.Reset(					1'b0),
			`endif	
							.ROPAddr(				ROPAddr),
							.ROLeaf(				ROLeaf), 
							.ROStartAESValid(		ROStartAESValid),
							.ROStartAESReady(		ROStartAESReady),
							
							.BEDataOut(				AES_DRAMReadData), 
							.BEDataOutValid(		AES_DRAMReadDataValid), 					
	
							.BEDataIn(				AES_DRAMWriteData), 
							.BEDataInValid(			AES_DRAMWriteDataValid), 
							.BEDataInReady(			AES_DRAMWriteDataReady),	
							
							.DRAMReadData(			BED_DRAMReadData), 
							.DRAMReadDataValid(		BED_DRAMReadDataValid), 
							.DRAMReadDataReady(		BED_DRAMReadDataReady),
							
							.DRAMWriteData(			BED_DRAMWriteData), 
							.DRAMWriteDataValid(	BED_DRAMWriteDataValid), 
							.DRAMWriteDataReady(	BED_DRAMWriteDataReady));
	end else if (EnableAES) begin:BASIC_AES
		AESPathORAM #(		.ORAMB(					ORAMB), // TODO which of these params are really needed?
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.ORAMC(					ORAMC),
							.Overclock(				Overclock),
							.EnableREW(				EnableREW),
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth))
				aes(		.Clock(					Clock),
							.Reset(					Reset),
							
							.DRAMReadData(			BED_DRAMReadData), 
							.DRAMReadDataValid(		BED_DRAMReadDataValid), 
							.DRAMReadDataReady(		BED_DRAMReadDataReady),
							
							.DRAMWriteData(			BED_DRAMWriteData), 
							.DRAMWriteDataValid(	BED_DRAMWriteDataValid), 
							.DRAMWriteDataReady(	BED_DRAMWriteDataReady),
													
							.BackendRData(			AES_DRAMReadData),
							.BackendRValid(			AES_DRAMReadDataValid),
							.BackendRReady(			AES_DRAMReadDataReady),
							
							.BackendWData(			AES_DRAMWriteData),
							.BackendWValid(			AES_DRAMWriteDataValid),
							.BackendWReady(			AES_DRAMWriteDataReady),
	
							.DRAMInitDone(			DRAMInitComplete));
	end else begin:NO_AES
	`ifdef ASIC
	// TODO this is a hack: just because we don't care about "modeling" AES latency in ASIC
	assign	AES_DRAMReadData =						BED_DRAMReadData;
	assign	AES_DRAMReadDataValid =					BED_DRAMReadDataValid;
	assign	DRAMReadDataReady =						AES_DRAMReadDataReady;
	
	assign	DRAMWriteData =							AES_DRAMWriteData;
	assign	DRAMWriteDataValid =					AES_DRAMWriteDataValid;
	assign	AES_DRAMWriteDataReady =				BED_DRAMWriteDataReady;
	`else
	// These buffers are here so that we can model AES timing.  If you 
	// don't, comment them out ;-)

	localparam				AESLatency =			21 + 8; // assuming tiny_aes		
			
	FIFORAM	#(				.Width(					DDRDWidth),
							.Buffering(				PathSize_DRBursts),
							.FWLatency(				AESLatency))
		indelay(			.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BED_DRAMReadData),
							.InValid(				BED_DRAMReadDataValid),
							.InAccept(				BED_DRAMReadDataReady),
							.OutData(				AES_DRAMReadData),
							.OutSend(				AES_DRAMReadDataValid),
							.OutReady(				AES_DRAMReadDataReady));
							
	FIFORAM	#(				.Width(					DDRDWidth),
							.Buffering(				PathSize_DRBursts),
							.FWLatency(				AESLatency))
		outdelay(			.Clock(					Clock),
							.Reset(					Reset),
							.InData(				AES_DRAMWriteData),
							.InValid(				AES_DRAMWriteDataValid),
							.InAccept(				AES_DRAMWriteDataReady),
							.OutData(				BED_DRAMWriteData),
							.OutSend(				BED_DRAMWriteDataValid),
							.OutReady(				BED_DRAMWriteDataReady));
	`endif
	end endgenerate
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	DRAM->Backend width shifters
	//--------------------------------------------------------------------------
	
	FIFOShiftRound #(		.IWidth(				DDRDWidth), // TODO change to MEMWidth
							.OWidth(				BEDWidth))
				in_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				PBF_DRAMReadData),
							.InValid(				PBF_DRAMReadDataValid),
							.InAccept(				PBF_DRAMReadDataReady),
							.OutData(				BED_DRAMReadData),
							.OutValid(				BED_DRAMReadDataValid),
							.OutReady(				BED_DRAMReadDataReady));
							
	FIFOShiftRound #(		.IWidth(				DDRDWidth), // TODO change to MEMWidth
							.OWidth(				BEDWidth))
				out_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				BED_DRAMWriteData),
							.InValid(				BED_DRAMWriteDataValid),
							.InAccept(				BED_DRAMWriteDataReady),
							.OutData(				DRAMWriteData),
							.OutValid(				DRAMWriteDataValid),
							.OutReady(				DRAMWriteDataReady));								
	
	//--------------------------------------------------------------------------	
	//	DRAM Read Interface
	//--------------------------------------------------------------------------	
	
	/*
	generate if (DebugDRAMReadTiming) begin:PRED_TIMING
		wire	[PthBSTWidth-1:0] PthCnt;
		wire				ReadStarted, ReadStopped;
		
		assign	ReadStopped =						ReadStarted & ~PBF_DRAMReadDataValid;
		
		Register #(			.Width(					1))
				seen_first(	.Clock(					Clock),
							.Reset(					Reset | ReadStopped),
							.Set(					PBF_DRAMReadDataValid),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					ReadStarted));
		Counter	 #(			.Width(					PthBSTWidth))
				dbg_cnt(	.Clock(					Clock),
							.Reset(					Reset | ReadStopped),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				DRAMReadDataValid),
							.In(					{PthBSTWidth{1'bx}}),
							.Count(					PthCnt));
								
		assign	PathBuffer_OutValid =				PthCnt == PathSize_DRBursts & PBF_DRAMReadDataValid;
		assign	PathBuffer_OutReady =				PthCnt == PathSize_DRBursts & PathBuffer_OutReady_Pre;
	end else begin:NORMAL_TIMING
		assign	PathBuffer_OutValid =				PBF_DRAMReadDataValid;
		assign	PathBuffer_OutReady =				PathBuffer_OutReady_Pre;	
	end endgenerate
	*/
		
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				PathSize_DRBursts)
							`ifdef ASIC , .ASIC(1) `endif)
				in_P_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMReadData),
							.InValid(				DRAMReadDataValid),
							.InAccept(				PathBuffer_InReady),
							.OutData(				PBF_DRAMReadData),
							.OutSend(				PBF_DRAMReadDataValid),
							.OutReady(				PBF_DRAMReadDataReady));

	//--------------------------------------------------------------------------
	//	DRAM Write Interface
	//--------------------------------------------------------------------------

	assign	DRAMWriteMask =							{DDRMWidth{1'b0}};
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
