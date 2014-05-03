
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
  	Clock, FastClock, Reset,
	
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

	`include "PathORAM.vh"
	`include "UORAM.vh" 
	`include "PLB.vh"
	
	`include "SecurityLocal.vh"	
	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	`include "PLBLocal.vh"
	
	/* Debugging.
		DebugDRAMReadTiming: 	Don't send PathBuffer data to AES until PathBuffer 
								is full.  This eliminates differences in MIG vs. 
								simulation read timing.
		DebugAES:				Disable AES masks. */
	parameter				DebugDRAMReadTiming =	0; 
	parameter				DebugAES =				0; 
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, FastClock, Reset;
	
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

	// Path buffer

	wire					PathBuffer_OutReady_Pre, PathBuffer_OutValid_Pre;	
	
	wire					PathBuffer_OutValid, PathBuffer_OutReady;
	wire	[DDRDWidth-1:0]	PathBuffer_OutData;

	//--------------------------------------------------------------------------
	//	Simulation checks
	//-------------------------------------------------------------------------- 		
	
	`ifdef SIMULATION
		initial begin	
			if (ORAML + 1 > 32) begin
				$display("[%m @ %t] WARNING: Designs with more than 32 levels will be slightly more expensive resource-wise, because path-deep FIFOs won't pack as efficiently into LUTRAM.", $time);
			end
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Core modules
	//-------------------------------------------------------------------------- 	
	
	UORamController #(  	.ORAMU(         		ORAMU), 
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
							.DebugAES(				DebugAES))
				back_end (	.Clock(					Clock),
			                .FastClock(				FastClock),
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
		
		assign	ReadStopped =							ReadStarted & ~PathBuffer_OutValid_Pre;
		
		Register	#(			.Width(					1))
					seen_first(	.Clock(					Clock),
								.Reset(					Reset | ReadStopped),
								.Set(					PathBuffer_OutValid_Pre),
								.Enable(				1'b0),
								.In(					1'bx),
								.Out(					ReadStarted));
		Counter		#(			.Width(					PthBSTWidth))
					dbg_cnt(	.Clock(					Clock),
								.Reset(					Reset | ReadStopped),
								.Set(					1'b0),
								.Load(					1'b0),
								.Enable(				DRAMReadDataValid),
								.In(					{PthBSTWidth{1'bx}}),
								.Count(					PthCnt));
								
		assign	PathBuffer_OutValid =					PthCnt == PathSize_DRBursts & PathBuffer_OutValid_Pre;
		assign	PathBuffer_OutReady =					PthCnt == PathSize_DRBursts & PathBuffer_OutReady_Pre;
	end else begin:NORMAL_TIMING
		assign	PathBuffer_OutValid =					PathBuffer_OutValid_Pre;
		assign	PathBuffer_OutReady =					PathBuffer_OutReady_Pre;	
	end endgenerate	
		
	generate if (Overclock) begin:INBUF_BRAM
		wire				PathBuffer_Full;
		
		assign	PathBuffer_InReady =				~PathBuffer_Full;
		PathBuffer in_P_buf(.clk(					Clock),
							.din(					DRAMReadData), 
							.wr_en(					DRAMReadDataValid), 
							.rd_en(					PathBuffer_OutReady), 
							.dout(					PathBuffer_OutData), 
							.full(					PathBuffer_Full), 
							.valid(					PathBuffer_OutValid_Pre));						
	end else begin:INBUF_LUTRAM
		FIFORAM	#(			.Width(					DDRDWidth),
							.Buffering(				PathSize_DRBursts))
				in_P_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMReadData),
							.InValid(				DRAMReadDataValid),
							.InAccept(				PathBuffer_InReady),
							.OutData(				PathBuffer_OutData),
							.OutSend(				PathBuffer_OutValid_Pre),
							.OutReady(				PathBuffer_OutReady));
	end endgenerate

	//--------------------------------------------------------------------------
	//	DRAM Write Interface
	//--------------------------------------------------------------------------

	assign	DRAMWriteMask =							{DDRMWidth{1'b0}};
	
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------