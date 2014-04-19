
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
	`include "Stash.vh" 
	`include "UORAM.vh" 
	`include "PLB.vh"
	
	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	`include "PLBLocal.vh"

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
							.BEDWidth(				BEDWidth))
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
							.DRAMReadDataReady(		PathBuffer_OutReady),
							
							.DRAMWriteData(			DRAMWriteData),
							.DRAMWriteDataValid(	DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMWriteDataReady));					
	
	//--------------------------------------------------------------------------
	//	DRAM Read Interface
	//--------------------------------------------------------------------------

	generate if (Overclock) begin:INBUF_BRAM
		wire				PathBuffer_Full;
		
		assign	PathBuffer_InReady =				~PathBuffer_Full;
		PathBuffer in_P_buf(.clk(					Clock),
							.din(					DRAMReadData), 
							.wr_en(					DRAMReadDataValid), 
							.rd_en(					PathBuffer_OutReady), 
							.dout(					PathBuffer_OutData), 
							.full(					PathBuffer_Full), 
							.valid(					PathBuffer_OutValid));						
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

	assign	DRAMWriteMask =							{DDRMWidth{1'b0}};
	
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------