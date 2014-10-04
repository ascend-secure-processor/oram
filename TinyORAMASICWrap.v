
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		TinyORAMASICWrap
//	Desc:		
//==============================================================================
module TinyORAMASICWrap(
  	Clock, Reset,

	Cmd, PAddr,
	CmdValid, CmdReady,

	DataIn,
	DataInValid, DataInReady,

	DataOut,
	DataOutValid, DataOutReady,

	DRAMAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid,
	DRAMWriteData, DRAMWriteMask, DRAMWriteDataValid, DRAMWriteDataReady,
	
	Mode_TrafficGen, // Are we using the traffic gen to test ORAM *functionality*
	Mode_DummyGen // Are we doing dummy requests forever to test *backend power*
	);

	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	
	`include "PathORAM.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "CommandsLocal.vh"

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

	input	[BEDWidth-1:0]	DRAMReadData;
	input					DRAMReadDataValid;

	output	[BEDWidth-1:0]	DRAMWriteData;
	output	[DDRMWidth-1:0]	DRAMWriteMask;
	output					DRAMWriteDataValid;
	input					DRAMWriteDataReady;

	//--------------------------------------------------------------------------
	//	Status interface
	//--------------------------------------------------------------------------

	input					Mode_TrafficGen, Mode_DummyGen;	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	wire	[BECMDWidth-1:0] Cmd_ORAM;
	wire	[ORAMU-1:0]		PAddr_ORAM;
	wire					CmdValid_ORAM, CmdReady_ORAM;
	
	wire	[FEDWidth-1:0]	DataIn_ORAM;
	wire					DataInValid_ORAM, DataInReady_ORAM;

	wire	[FEDWidth-1:0]	DataOut_ORAM;
	wire					DataOutValid_ORAM, DataOutReady_ORAM;

	wire	[BECMDWidth-1:0] Cmd_TGen;
	wire	[ORAMU-1:0]		PAddr_TGen;
	wire					CmdValid_TGen, CmdReady_TGen;
		
	wire	[FEDWidth-1:0]	DataIn_TGen;
	wire					DataInValid_TGen, DataInReady_TGen;
	
	wire	[FEDWidth-1:0]	DataOut_TGen;
	wire					DataOutValid_TGen, DataOutReady_TGen;

	//--------------------------------------------------------------------------
	//	Core modules
	//--------------------------------------------------------------------------

	TrafficGenASIC	tgen(	.Clock(					Clock), 
							.Reset(					Reset),

							.ORAMCommand(			Cmd_TGen), 
							.ORAMPAddr(				PAddr_TGen),
							.ORAMCommandValid(		CmdValid_TGen), 
							.ORAMCommandReady(		CmdReady_TGen),
							
							.ORAMDataIn(			DataIn_TGen), 
							.ORAMDataInValid(		DataInValid_TGen), 
							.ORAMDataInReady(		DataInReady_TGen),
							
							.ORAMDataOut(			DataOut_TGen), 
							.ORAMDataOutValid(		DataOutValid_TGen), 
							.ORAMDataOutReady(		DataOutReady_TGen),
							
							.Error_ReceivePattern(	));	

	assign	Cmd_ORAM =								(Mode_TrafficGen) ? Cmd_TGen : 			Cmd;
	assign	PAddr_ORAM = 							(Mode_TrafficGen) ? PAddr_TGen : 		PAddr;
	assign	CmdValid_ORAM =							(Mode_TrafficGen) ? CmdValid_TGen : 	CmdValid;
	assign	CmdReady_TGen =							(Mode_TrafficGen) ? CmdReady_ORAM : 	1'b0;
	assign	CmdReady =								(Mode_TrafficGen) ? 1'b0 : 				CmdReady_ORAM;
	
	assign	DataIn_ORAM =							(Mode_TrafficGen) ? DataIn_TGen : 		DataIn;
	assign	DataInValid_ORAM =						(Mode_TrafficGen) ? DataInValid_TGen : 	DataInValid;
	assign	DataInReady_TGen =						(Mode_TrafficGen) ? DataInReady_ORAM : 	1'b0;
	assign	DataInReady =							(Mode_TrafficGen) ? 1'b0 : 				DataInReady_ORAM;
	
	assign	DataOut_TGen =							DataOut_ORAM;
	assign	DataOut =								DataOut_ORAM;
	assign	DataOutValid_TGen =						(Mode_TrafficGen) ? DataOutValid_ORAM :	1'b0;
	assign	DataOutValid =							(Mode_TrafficGen) ? 1'b0 : 				DataOutValid_ORAM;	
	assign	DataOutReady_ORAM =						(Mode_TrafficGen) ? DataOutReady_TGen : DataOutReady;

	TinyORAMCore core(		.Clock(					Clock),
							.Reset(					Reset),

							.Cmd(					Cmd_ORAM), 
							.PAddr(					PAddr_ORAM),
							.CmdValid(				CmdValid_ORAM), 
							.CmdReady(				CmdReady_ORAM),
                            
							.DataIn(				DataIn_ORAM),
							.DataInValid(			DataInValid_ORAM), 
							.DataInReady(			DataInReady_ORAM),
                            
							.DataOut(				DataOut_ORAM),
							.DataOutValid(			DataOutValid_ORAM), 
							.DataOutReady(			DataOutReady_ORAM),
                            
							.DRAMAddress(			DRAMAddress),
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
//------------------------------------------------------------------------------
