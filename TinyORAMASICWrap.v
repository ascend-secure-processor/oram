
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		TinyORAMASICWrap
//	Desc:		TinyORAMCore augmented with modules to test functionality and 
//				power for the chip tapeout.
//
//				Modes explanation:
//				Mode_TrafficGen: 	Are we using the traffic gen to test ORAM 
//									*functionality*
//				Mode_DummyGen:		Are we doing dummy requests forever to test 
//									*backend power*
//
//				Modes encoding:
//				Mode_TrafficGen	Mode_DummyGen
//				0				0	Takes requests from L2 w/ normal DRAM backend
//				0				1	Self-contained dummy gen test
//				1				0	Traffic gen with normal DRAM backend
//				1				1	Self-contained dummy gen test
//==============================================================================
module TinyORAMASICWrap(
  	Clock, Reset,

	Cmd, PAddr, WMask,
	CmdValid, CmdReady,

	DataIn,
	DataInValid, DataInReady,

	DataOut,
	DataOutValid, DataOutReady,

	DRAMAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid,
	DRAMWriteData, DRAMWriteMask, DRAMWriteDataValid, DRAMWriteDataReady,
	
	Mode_TrafficGen, 
	Mode_DummyGen,
	
	
	);
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	
	parameter				NetworkWidth =		64; // Princeton's network
	
	`include "PathORAM.vh"
	
	`include "DMLocal.vh"
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
	input	[DMWidth-1:0]	WMask;
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
	//	Mode interface
	//--------------------------------------------------------------------------

	input					Mode_TrafficGen, Mode_DummyGen;	

	//--------------------------------------------------------------------------
	//	JTAG interface
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	wire	[BECMDWidth-1:0] Cmd_ORAM;
	wire	[ORAMU-1:0]		PAddr_ORAM;
	wire	[DMWidth-1:0]	WMask_ORAM;
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
	
	wire	[DDRAWidth-1:0]	DRAMAddress_ORAM;
	wire	[DDRCWidth-1:0]	DRAMCommand_ORAM;
	wire					DRAMCommandValid_ORAM, DRAMCommandReady_ORAM;

	wire	[BEDWidth-1:0]	DRAMReadData_ORAM;
	wire					DRAMReadDataValid_ORAM;

	wire	[BEDWidth-1:0]	DRAMWriteData_ORAM;
	wire	[DDRMWidth-1:0]	DRAMWriteMask_ORAM;
	wire					DRAMWriteDataValid_ORAM, DRAMWriteDataReady_ORAM;							

	wire	[BEDWidth-1:0] 	DRAMReadData_DGen;
	wire					DRAMCommandValid_DGen, DRAMCommandReady_DGen, DRAMReadDataValid_DGen;
	
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
	assign	WMask_ORAM =							(Mode_TrafficGen) ? {DMWidth{1'b1}} :	WMask; 
	assign	CmdValid_ORAM =						(	(Mode_TrafficGen) ? CmdValid_TGen : 	CmdValid		) 	&& ~Mode_DummyGen;
	assign	CmdReady_TGen =						(	(Mode_TrafficGen) ? CmdReady_ORAM : 	1'b0			) 	&& ~Mode_DummyGen;
	assign	CmdReady =							(	(Mode_TrafficGen) ? 1'b0 : 				CmdReady_ORAM	) 	&& ~Mode_DummyGen;
	
	assign	DataIn_ORAM =							(Mode_TrafficGen) ? DataIn_TGen : 		DataIn;
	assign	DataInValid_ORAM =					(	(Mode_TrafficGen) ? DataInValid_TGen : 	DataInValid		) 	&& ~Mode_DummyGen;
	assign	DataInReady_TGen =					(	(Mode_TrafficGen) ? DataInReady_ORAM : 	1'b0			) 	&& ~Mode_DummyGen;
	assign	DataInReady =						(	(Mode_TrafficGen) ? 1'b0 : 				DataInReady_ORAM) 	&& ~Mode_DummyGen;
	
	assign	DataOut_TGen =							DataOut_ORAM;
	assign	DataOut =								DataOut_ORAM;
	assign	DataOutValid_TGen =					(	(Mode_TrafficGen) ? DataOutValid_ORAM :	1'b0			) 	&& ~Mode_DummyGen;
	assign	DataOutValid =						(	(Mode_TrafficGen) ? 1'b0 : 				DataOutValid_ORAM) 	&& ~Mode_DummyGen;	
	assign	DataOutReady_ORAM =					(	(Mode_TrafficGen) ? DataOutReady_TGen : DataOutReady) 		&& ~Mode_DummyGen;

	TinyORAMCore core(		.Clock(					Clock),
							.Reset(					Reset),

							.Cmd(					Cmd_ORAM), 
							.PAddr(					PAddr_ORAM),
							.WMask(					WMask_ORAM),
							.CmdValid(				CmdValid_ORAM), 
							.CmdReady(				CmdReady_ORAM),
                            
							.DataIn(				DataIn_ORAM),
							.DataInValid(			DataInValid_ORAM), 
							.DataInReady(			DataInReady_ORAM),
                            
							.DataOut(				DataOut_ORAM),
							.DataOutValid(			DataOutValid_ORAM), 
							.DataOutReady(			DataOutReady_ORAM),
                            
							.DRAMAddress(			DRAMAddress_ORAM),
							.DRAMCommand(			DRAMCommand_ORAM), 
							.DRAMCommandValid(		DRAMCommandValid_ORAM), 
							.DRAMCommandReady(		DRAMCommandReady_ORAM),
							
							.DRAMReadData(			DRAMReadData_ORAM), 
							.DRAMReadDataValid(		DRAMReadDataValid_ORAM),
							
							.DRAMWriteData(			DRAMWriteData_ORAM), 
							.DRAMWriteMask(			DRAMWriteMask_ORAM), 
							.DRAMWriteDataValid(	DRAMWriteDataValid_ORAM), 
							.DRAMWriteDataReady(	DRAMWriteDataReady_ORAM),
							
							.Mode_DummyGen(			Mode_DummyGen));
	
	always @(posedge Clock) begin
		if (DRAMReadDataValid_ORAM && Mode_DummyGen)
			$display("DummyGen giving data %x", DRAMReadData_ORAM);
		if (DRAMWriteDataValid_ORAM && Mode_DummyGen)
			$display("DummyGen getting data %x", DRAMWriteData_ORAM);
	end
	
	assign	DRAMAddress =							DRAMAddress_ORAM;
	assign	DRAMCommand =							DRAMCommand_ORAM;
	assign	DRAMCommandValid =						(Mode_DummyGen) ? 1'b0 : 					DRAMCommandValid_ORAM;
	assign	DRAMCommandValid_DGen =					(Mode_DummyGen) ? DRAMCommandValid_ORAM && DRAMCommand_ORAM == DDR3CMD_Read : 1'b0;
	assign	DRAMCommandReady_ORAM =					(Mode_DummyGen) ? DRAMCommandReady_DGen : 	DRAMCommandReady;
	
	assign	DRAMReadData_ORAM =						(Mode_DummyGen) ? DRAMReadData_DGen : 		DRAMReadData;
	assign	DRAMReadDataValid_ORAM =				(Mode_DummyGen) ? DRAMReadDataValid_DGen : 	DRAMReadDataValid;
	
	assign	DRAMWriteData =							DRAMWriteData_ORAM;
	assign	DRAMWriteMask =							DRAMWriteMask_ORAM;
	assign	DRAMWriteDataValid = 					(Mode_DummyGen) ? 1'b0 : 					DRAMWriteDataValid_ORAM;
	assign	DRAMWriteDataReady_ORAM = 				(Mode_DummyGen) ? 1'b1 : 					DRAMWriteDataReady;	
	
	DummyGenASIC 	dgen(	.Clock(					Clock),
							.Reset(					Reset),

							.DRAMCommandValid(		DRAMCommandValid_DGen), 
							.DRAMCommandReady(		DRAMCommandReady_DGen),
							
							.DRAMReadData(			DRAMReadData_DGen),
							.DRAMReadDataValid(		DRAMReadDataValid_DGen));						

	//--------------------------------------------------------------------------
	//	Funnels to Princeton network width
	//--------------------------------------------------------------------------
							
							
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
