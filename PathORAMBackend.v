
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMBackend
//	Desc:		
//==============================================================================
module PathORAMBackend #(	`include "PathORAM.vh", `include "DDR3SDRAM.vh",
							`include "AES.vh") (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 						Clock, Reset,
	
	//--------------------------------------------------------------------------
	//	Frontend Interface
	//--------------------------------------------------------------------------

	input	[BECMDWidth-1:0] 	InCommand,
	input	[ORAMU-1:0]			LoadPAddr,
	input	[ORAML-1:0]			LoadLeaf,
	input						InCommandValid,
	output 						InCommandReady,

	input	[StashDWidth-1:0]	LoadData,
	input						LoadValid,
	output 						LoadReady,

	output	[StashDWidth-1:0]	StoreData,
	output	[ORAMU-1:0]			StorePAddr,
	output	[ORAML-1:0]			StoreLeaf,
	output 						StoreValid,
	input 						StoreReady,
	
	//--------------------------------------------------------------------------
	//	DRAM Interface
	//--------------------------------------------------------------------------

	output	[DDRAWidth-1:0]		DRAMCommandAddress,
	output	[DDRCWidth-1:0]		DRAMCommand,
	output						DRAMCommandValid,
	input						DRAMCommandReady,
	
	input	[DDRDWidth-1:0]		DRAMReadData,
	input						DRAMReadDataValid,
	
	output	[DDRDWidth-1:0]		DRAMWriteData,
	output	[DDRMWidth-1:0]		DRAMWriteMask,
	output						DRAMWriteDataValid,
	input						DRAMWriteDataReady
	);
		
	//------------------------------------------------------------------------------
	//	Constants
	//------------------------------------------------------------------------------ 

	`include "DDR3SDRAMLocal.vh"

	localparam					STWidth =			2,
								ST_Initialize =		2'd0,
								ST_Normal =			2'd1;
								
	//------------------------------------------------------------------------------
	//	Wires & Regs
	//------------------------------------------------------------------------------ 

	// Control logic
	
	wire						AllResetsDone;
	reg		[STWidth-1:0]		CS, NS;
	wire						CSInitialize;
	
	// Stash
	
	wire						Stash_ResetDone;
	
	// ORAM initialization
	
	wire	[DDRAWidth-1:0]		DRAMInit_DRAMCommandAddress;
	wire	[DDRCWidth-1:0]		DRAMInit_DRAMCommand;
	wire						DRAMInit_DRAMCommandValid, DRAMInit_DRAMCommandReady;

	wire	[DDRDWidth-1:0]		DRAMInit_DRAMWriteData;
	wire	[DDRMWidth-1:0]		DRAMInit_DRAMWriteMask;
	wire						DRAMInit_DRAMWriteDataValid, DRAMInit_DRAMWriteDataReady;
	
	wire						DRAMInit_Done;
	
	// Address generator
	
	wire	[DDRAWidth-1:0]		AddrGen_DRAMCommandAddress;
	wire	[DDRCWidth-1:0]		AddrGen_DRAMCommand;
	wire						AddrGen_DRAMCommandValid, AddrGen_DRAMCommandReady;
	
	wire	[ORAML-1:0]			AddrGen_Leaf;
	wire						AddrGen_InReady, AddrGen_InValid;
	
	//------------------------------------------------------------------------------
	//	Control logic
	//------------------------------------------------------------------------------

	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Initialize;
		else CS <= 									NS;
	end
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Initialize : 
				if (AllResetsDone) 
					NS =						 	ST_Normal;
		endcase
	end		
	
	assign	CSInitialize =							CS == ST_Initialize;
	assign	AllResetsDone =							Stash_ResetDone & DRAMInit_Done;
	
	//------------------------------------------------------------------------------
	//	Stash
	//------------------------------------------------------------------------------
	
	assign	Stash_ResetDone =						1'b1;
	
	/*
	Stash	#(				.StashDWidth(			StashDWidth),
							.StashCapacity(			ORAMC),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
							
			stash(			.Clock(					Clock),
							.Reset(					Reset),
							.ResetDone(				),
							
							.AccessLeaf(			),
							.AccessPAddr(			),
							.AccessIsDummy(			),
							
							.StartScanOperation(	),  
							.StartWritebackOperation(),
										
							.ReturnData(			),
							.ReturnPAddr(			),
							.ReturnLeaf(			),
							.ReturnDataOutValid(	),
							.ReturnDataOutReady(	1'b0),
							.BlockReturnComplete(	),
							
							.EvictData(				),
							.EvictPAddr(			),
							.EvictLeaf(				),
							.EvictDataInValid(		1'b0),
							.EvictDataInReady(		),
							.BlockEvictComplete(	),

							.WriteData(				WriteData),
							.WriteInValid(			WriteInValid),
							.WriteInReady(			WriteInReady), 
							.WritePAddr(			WritePAddr),
							.WriteLeaf(				WriteLeaf),
							.BlockWriteComplete(	BlockWriteComplete), 
							
							.ReadData(				ReadData),
							.ReadPAddr(				ReadPAddr),
							.ReadLeaf(				ReadLeaf),
							.ReadOutValid(			ReadOutValid), 
							.ReadOutReady(			ReadOutReady), 
							.BlockReadComplete(		BlockReadComplete),
							.PathReadComplete(		PathReadComplete),
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		StashOccupancy));
	*/	
	
	//------------------------------------------------------------------------------	
	
	//------------------------------------------------------------------------------
	//	Address generation & initialization
	//------------------------------------------------------------------------------

	// Initializer / AddrGen arbitration
	assign	DRAMCommandAddress =					(CSInitialize) ? DRAMInit_DRAMCommandAddress 	: AddrGen_DRAMCommandAddress;
	assign	DRAMCommand =							(CSInitialize) ? DRAMInit_DRAMCommand 			: AddrGen_DRAMCommand;
	assign	DRAMCommandValid =						(CSInitialize) ? DRAMInit_DRAMCommandValid 		: AddrGen_DRAMCommandValid; 
	assign	AddrGen_DRAMCommandReady =				DRAMCommandReady & ~CSInitialize;
	assign	DRAMInit_DRAMCommandReady =				DRAMCommandReady & CSInitialize;
	assign	DRAMInit_DRAMWriteDataReady =			DRAMWriteDataReady & CSInitialize;
	
	// TODO for debugging
	assign	AddrGen_InValid =						1'b1;
	assign	AddrGen_Leaf =							15'hffff;
	
    AddrGen #(				.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth))
			addr_gen(		.Clock(					Clock),
							.Reset(					Reset | CSInitialize),
							.Start(					AddrGen_InValid), 
							.Ready(					AddrGen_InReady),
							.RWIn(					1'b1), // TODO for debugging 
							.BHIn(					1'b0), // TODO change when we do REW ORAM
							.leaf(					AddrGen_Leaf),
							.CmdReady(				AddrGen_DRAMCommandReady),
							.CmdValid(				AddrGen_DRAMCommandValid),
							.Cmd(					AddrGen_DRAMCommand),
							.Addr(					AddrGen_DRAMCommandAddress));
							
	DRAMInitializer #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
			dram_init(		.Clock(					Clock),
							.Reset(					Reset),
							// TODO generalize this to addr gen, etc
							.DRAMCommandAddress(	DRAMInit_DRAMCommandAddress),
							.DRAMCommand(			DRAMInit_DRAMCommand),
							.DRAMCommandValid(		DRAMInit_DRAMCommandValid),
							.DRAMCommandReady(		DRAMInit_DRAMCommandReady),
							.DRAMWriteData(			DRAMInit_DRAMWriteData),
							.DRAMWriteMask(			DRAMInit_DRAMWriteMask),
							.DRAMWriteDataValid(	DRAMInit_DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMInit_DRAMWriteDataReady),
							.Done(					DRAMInit_Done));					

endmodule
//------------------------------------------------------------------------------
