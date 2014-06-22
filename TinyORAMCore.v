
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		TinyORAMCore
//	Desc:		{Unified} x {Basic, REW} ORAM core with encryption, integrity 
//				verification, & a FIFO DRAM interface. 
//==============================================================================
module TinyORAMCore(
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
	//	Parameters
	//--------------------------------------------------------------------------
	
	// Debugging
	
	/* 	
		SlowAESClock:			AES should use the same clock as the rest of the 
								design			
		DebugDRAMReadTiming: 	Don't send PathBuffer data to AES until the 
								PathBuffer has received an entire path.  This 
								eliminates differences in MIG vs. simulation 
								read timing. 
	*/
	parameter				SlowAESClock =			1; // NOTE: set to 0 for performance run
	parameter				DebugDRAMReadTiming =	0; // NOTE: set to 0 for performance run

	// Frontend-backend
	
	// TODO: for ASIC, re-enable AES.
	// TODO: for ASIC, re-enable IV.

	parameter				EnablePLB = 			1,
							EnableREW =				`ifdef ASIC 0 `else 1 `endif,
							EnableAES =				`ifdef ASIC 0 `else 1 `endif,
							EnableIV =				`ifdef ASIC 0 `else 0 `endif;
	
	// ORAM

	// TODO: for ASIC, we want ORAML up to 31 (dynamically change recursion). but use 13 for simulation

	parameter				ORAMB =					512,
							ORAMU =					32,
							ORAML =					10,
							ORAMZ =					`ifdef ORAMZ `ORAMZ `else (EnableREW) ? 5 : 3 `endif,
							ORAMC =					10,
							ORAME =					5;

	parameter				FEDWidth =				`ifdef ASIC 64 `else 512 `endif,
							BEDWidth =				`ifdef ASIC 64 `else 512 `endif;

    parameter				NumValidBlock = 		1 << ORAML,
							Recursion = 			3,
							PLBCapacity = 			8192 << 3; // 8KB PLB
		
	// Hardware

	parameter				Overclock =				1;
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	
	`include "SecurityLocal.vh"	
	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	`include "PLBLocal.vh"
	
	localparam				ORAMUValid =			`log2(NumValidBlock) + 1;
	
	localparam				DelayedWB =				EnableIV;
		
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	
	//--------------------------------------------------------------------------
	//	User interface
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
	//	DRAM interface
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

	wire					AESClock;
	
	// Frontend - Backend
	
	(* mark_debug = "TRUE" *)	wire					BEnd_CmdReady, BEnd_CmdValid;
	(* mark_debug = "TRUE" *)	wire	[BECMDWidth-1:0] BEnd_Cmd;
	(* mark_debug = "TRUE" *)	wire	[ORAMU-1:0]		BEnd_PAddr;
	(* mark_debug = "TRUE" *)	wire	[ORAML-1:0]		CurrentLeaf, RemappedLeaf;

	(* mark_debug = "TRUE" *)	wire	[FEDWidth-1:0]	LoadData, StoreData;
	(* mark_debug = "TRUE" *)	wire					LoadReady, LoadValid, StoreValid, StoreReady;

	// Path buffer

	wire					PathBuffer_InReady, PathBuffer_OutReady_Pre, PathBuffer_OutValid_Pre;	
	
	wire					PathBuffer_OutValid, PathBuffer_OutReady;
	wire	[DDRDWidth-1:0]	PathBuffer_OutData;

	//--------------------------------------------------------------------------
	//	Simulation checks
	//-------------------------------------------------------------------------- 		
	
	`ifdef SIMULATION
		initial begin	
			if (ORAML + 1 > 32) begin
				$display("[%m] WARNING: Designs with more than 32 levels will be slightly more expensive resource-wise, because path-deep FIFOs won't pack as efficiently into LUTRAM.");
			end	
		end

		always @(posedge Clock) begin
			if (DRAMReadDataValid && ~PathBuffer_InReady) begin
				$display("[%m @ %t] ERROR: Path buffer overflow", $time);
				$finish;
			end
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Clocking
	//-------------------------------------------------------------------------- 	
	
	generate if (SlowAESClock || `ifdef ASIC 1 `else 0 `endif) begin:SLOW_AES
		assign	AESClock =							Clock;
	end else begin:FAST_AES
		// Increases the clock by 50%
		aes_clock	ci15( 	.clk_in1(				Clock),
							.clk_out1(				AESClock),
							.reset(					Reset),
							.locked(				));
	end endgenerate
	
	//--------------------------------------------------------------------------
	//	Core modules
	//-------------------------------------------------------------------------- 	
	
	UORAMController #(  	.ORAMU(         		ORAMU), 
							.ORAML(         		ORAML), 
							.ORAMB(         		ORAMB), 
							.FEDWidth(				FEDWidth),
							.NumValidBlock( 		NumValidBlock), 
							.Recursion(     		Recursion),
							.EnablePLB(				EnablePLB),
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
							.DelayedWB(				DelayedWB),
							
							.FEDWidth(				FEDWidth),
							.BEDWidth(				BEDWidth),
							.ORAMUValid(			ORAMUValid))
				back_end (	.Clock(					Clock),
			                .AESClock(				AESClock),
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

							.DRAMReadData(			PathBuffer_OutData),
							.DRAMReadDataValid(		PathBuffer_OutValid),
							.DRAMReadDataReady(		PathBuffer_OutReady_Pre),
							
							.DRAMWriteData(			DRAMWriteData),
							.DRAMWriteDataValid(	DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMWriteDataReady));					
	
	//--------------------------------------------------------------------------
	//	DRAM Read Interface
	//--------------------------------------------------------------------------
	
	generate if (DebugDRAMReadTiming) begin:PRED_TIMING
		wire	[PthBSTWidth-1:0] PthCnt;
		wire				ReadStarted, ReadStopped;
		
		assign	ReadStopped =						ReadStarted & ~PathBuffer_OutValid_Pre;
		
		Register #(			.Width(					1))
				seen_first(	.Clock(					Clock),
							.Reset(					Reset | ReadStopped),
							.Set(					PathBuffer_OutValid_Pre),
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
								
		assign	PathBuffer_OutValid =				PthCnt == PathSize_DRBursts & PathBuffer_OutValid_Pre;
		assign	PathBuffer_OutReady =				PthCnt == PathSize_DRBursts & PathBuffer_OutReady_Pre;
	end else begin:NORMAL_TIMING
		assign	PathBuffer_OutValid =				PathBuffer_OutValid_Pre;
		assign	PathBuffer_OutReady =				PathBuffer_OutReady_Pre;	
	end endgenerate	
		
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				PathSize_DRBursts)
							`ifdef ASIC , .ASIC(1) `endif)
				in_P_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMReadData),
							.InValid(				DRAMReadDataValid),
							.InAccept(				PathBuffer_InReady),
							.OutData(				PathBuffer_OutData),
							.OutSend(				PathBuffer_OutValid_Pre),
							.OutReady(				PathBuffer_OutReady));

	//--------------------------------------------------------------------------
	//	DRAM Write Interface
	//--------------------------------------------------------------------------

	assign	DRAMWriteMask =							{DDRMWidth{1'b0}};
	
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
