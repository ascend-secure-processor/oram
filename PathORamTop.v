
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAM
//	Desc:		Unified Front + basic PathORAM Backend
//==============================================================================
module PathORamTop #(	`include "PathORAM.vh", `include "DDR3SDRAM.vh",
						`include "AES.vh", `include "Stash.vh", 
						`include "UORAM.vh", `include "PLB.vh") (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset,
	
	//--------------------------------------------------------------------------
	//	Interface to network
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] Cmd,
	input					CmdValid,
	output 					CmdReady,
	input	[ORAMU-1:0]		PAddr,

	// TODO set CommandReady = 0 if LoadDataReady = 0 (i.e., the front end can't take our result!)
	
	input	[FEDWidth-1:0]	DataIn,
	input					DataInValid,
	output 					DataInReady,

	output	[FEDWidth-1:0]	ReturnData,
	output 					ReturnDataValid,
	input 					ReturnDataReady,
	
	//--------------------------------------------------------------------------
	//	Interface to DRAM
	//--------------------------------------------------------------------------

	output	[DDRAWidth-1:0]	DRAMAddress,
	output	[DDRCWidth-1:0]	DRAMCommand,
	output					DRAMCommandValid,
	input					DRAMCommandReady,
	
	input	[DDRDWidth-1:0]	DRAMReadData,
	input					DRAMReadDataValid,
	
	output	[DDRDWidth-1:0]	DRAMWriteData,
	output	[DDRMWidth-1:0]	DRAMWriteMask,
	output					DRAMWriteDataValid,
	input					DRAMWriteDataReady
	);	
	
	//------------------------------------------------------------------------------
	//	Constants
	//------------------------------------------------------------------------------ 

	`include "StashLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
    `include "PLBLocal.vh"; 

	//------------------------------------------------------------------------------
	//	Wires & Regs
	//------------------------------------------------------------------------------ 

	wire					BEnd_CmdReady, BEnd_CmdValid;
	wire	[BECMDWidth-1:0] BEnd_Cmd;
	wire	[ORAMU-1:0]		BEnd_PAddr;
	wire	[ORAML-1:0]		CurrentLeaf, RemappedLeaf;

	wire	[FEDWidth-1:0]	LoadData, StoreData;
	wire					LoadReady, LoadValid, StoreValid, StoreReady;
	
	//------------------------------------------------------------------------------
	//	Core modules
	//------------------------------------------------------------------------------ 	
	
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
							.ReturnDataReady(		ReturnDataReady), 
							.ReturnDataValid(		ReturnDataValid), 
							.ReturnData(			ReturnData),
		                        
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
							.Overclock(				Overclock),
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
							.DRAMReadData(			DRAMReadData),
							.DRAMReadDataValid(		DRAMReadDataValid),			
							.DRAMWriteData(			DRAMWriteData),
							.DRAMWriteMask(			DRAMWriteMask),
							.DRAMWriteDataValid(	DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMWriteDataReady));
							
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------