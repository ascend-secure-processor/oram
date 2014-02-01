
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMBackend
//	Desc:		The stash, AES, address generation, and throughput backpressure 
//				logic (e.g., dummy access control, R^(E+1)W pattern control)
//
//	TODO
//		- Append command
//		- Read command
//		- Read/remove command
//		- Update command
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

	input	[BECMDWidth-1:0] 	Command,
	input	[ORAMU-1:0]			PAddr,
	input	[ORAML-1:0]			CurrentLeaf, // If Command == Append, this is XX 
	input	[ORAML-1:0]			RemappedLeaf,
	input						CommandValid,
	output 						CommandReady,

	input	[FEDWidth-1:0]		LoadData,
	input						LoadValid,
	output 						LoadReady,

	input	[FEDWidth-1:0]		StoreData,
	input 						StoreValid,
	output 						StoreReady,
	
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
								ST_Idle =			2'd1,
								ST_Append =			3'd2,
								ST_AccessStart =	2'd2,
								ST_DummyAccess =	2'd3;
								
	//------------------------------------------------------------------------------
	//	Wires & Regs
	//------------------------------------------------------------------------------ 

	// Control logic
	
	wire						AllResetsDone;
	reg		[STWidth-1:0]		CS, NS;
	wire						CSInitialize;
	
	// Stash & frontend
	
	wire						Stash_StartScanOp, Stash_StartWritebackOp;
	
	wire	[FEDWidth-1:0]		FEStash_WriteData;						
	wire						FEStash_WriteDataValid, FEStash_WriteDataReady;
	
	wire	[BEDWidth-1:0]		StashFE_ReadData;
	wire						StashFE_ReadDataValid, StashFE_ReadDataReady;
	
	wire						Stash_ResetDone;
	
	wire	[BECMDWidth-1:0] 	Command_c;
	wire	[ORAMU-1:0]			PAddr_c;
	wire	[ORAML-1:0]			CurrentLeaf_c, RemappedLeaf_c;
	wire						LockedValid, LockedReady;
	
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
	//	Simulation checks
	//------------------------------------------------------------------------------

	`ifdef SIMULATION
		initial begin
			if (BEDWidth != DDRDWidth) begin
				$display("[%m @ %t] BEDWidth != DDRDWidth not supported yet", $time);
				$stop;
			end
			if (BEDWidth > DDRDWidth) begin
				$display("[%m @ %t] BEDWidth should never be > DDRDWidth", $time);
				$stop;
			end
		end
		
		always @(posedge Clock) begin
			if (StashOverflow) begin
				// This is checked in StashCore.v ...
			end

		end
	`endif
	
	//------------------------------------------------------------------------------
	//	Control logic
	//------------------------------------------------------------------------------

	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Initialize;
		else CS <= 									NS;
	end
	
	SetDummy
	CSIdle
	AccessIsDummy
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Initialize : 
				if (AllResetsDone) 
					NS =						 	ST_Idle;
			ST_Idle :
				if (StashAlmostFull) // highest priority
					NS =							ST_StartAccess;
				else if (LockedValid & Command_c == CMD_Append)
					NS =							ST_Append;
				else if (LockedValid & (Command_c == CMD_Update | 
										Command_c == CMD_Read | 
										Command_c == CMD_ReadRmv))
					NS =							ST_StartAccess;
			ST_Append :
				if (Stash_AppendComplete)
					NS = 							ST_Idle;
			ST_StartRead : 
				NS =								ST_PathRead;
			ST_PathRead : 							
				if ()
			ST_StartWriteback :
			ST_PathWriteback
		endcase
	end
	
	Register	#(			.Width(					1))
				DummyReg(	.Clock(					Clock),
							.Reset(					Reset | CSIdle),
							.Set(					SetDummy),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					AccessIsDummy));	
	
	assign	CSInitialize =							CS == ST_Initialize;
	assign	AllResetsDone =							Stash_ResetDone & DRAMInit_Done;
	
	//------------------------------------------------------------------------------
	//	Frontend interface
	//------------------------------------------------------------------------------	

	FIFORegister #(			.Width(					BECMDWidth + ORAMU + ORAML*2))
				cmd_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{Command, 	PAddr, 	CurrentLeaf, 	RemappedLeaf}),
							.InValid(				CommandValid),
							.InAccept(				CommandReady),
							.OutData(				{Command_c,	PAddr_c,CurrentLeaf_c, 	RemappedLeaf_c}),
							.OutSend(				LockedValid),
							.OutReady(				LockedReady));
	
	// TODO we may not need these expensive shifts if we can incrementally write 
	// FEDWidth chunks to the stash; check: are they really that expensive?  If we 
	// can pack them into 2 SLICEM's each, then its no problem
	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				BEDWidth))
				st_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.RepeatLimit(			), // not connected
							.RepeatMin(				), // not connected
							.RepeatPreMax(			), // not connected
							.RepeatMax(				), // not connected
							.InData(				StoreData),
							.InValid(				StoreValid),
							.InAccept(				StoreReady),
							.OutData(				FEStash_WriteData),
							.OutValid(				FEStash_WriteDataValid),
							.OutReady(				FEStash_WriteDataReady));
	
	FIFOShiftRound #(		.IWidth(				BEDWidth),
							.OWidth(				FEDWidth))
				ld_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.RepeatLimit(			), // not connected
							.RepeatMin(				), // not connected
							.RepeatPreMax(			), // not connected
							.RepeatMax(				), // not connected
							.InData(				StashFE_ReadData),
							.InValid(				StashFE_ReadDataValid),
							.InAccept(				StashFE_ReadDataReady),
							.OutData(				LoadData),
							.OutValid(				LoadData),
							.OutReady(				LoadReady));
	
	//------------------------------------------------------------------------------
	//	Stash
	//------------------------------------------------------------------------------
	
	Stash	#(				.StashCapacity(			StashCapacity),
							.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
							
			stash(			.Clock(					Clock),
							.Reset(					Reset),
							.ResetDone(				Stash_ResetDone),
							
							.AccessLeaf(			),
							.AccessPAddr(			),
							.AccessIsDummy(			AccessIsDummy),
							
							.StartScanOperation(	Stash_StartScanOp),  
							.StartWritebackOperation(Stash_StartWritebackOp),
							
							.ReturnData(			StashFE_ReadData),
							.ReturnPAddr(			),
							.ReturnLeaf(			),
							.ReturnDataOutValid(	StashFE_ReadDataValid),
							.ReturnDataOutReady(	StashFE_ReadDataReady),
							.BlockReturnComplete(	), // not connected
							
							// TODO add flag to indicate append?
							.EvictData(				FEStash_WriteData),
							.EvictPAddr(			PAddr_c),
							.EvictLeaf(				RemappedLeaf_c),
							.EvictDataInValid(		FEStash_WriteDataValid),
							.EvictDataInReady(		StashFE_ReadDataReady),
							.BlockEvictComplete(	Stash_AppendComplete), // not connected

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
							.StashOccupancy(		)); // debugging
	
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
	
	//------------------------------------------------------------------------------
	//	AES pipelines
	//------------------------------------------------------------------------------
	
	PathReadCtr
	
	// count number of blocks on path and 
	Counter		#(			.Width(					ScanTableAWidth),
							.Limited(				1),
							.Limit(					BlocksOnPath - 1))
				rd_cnt(		.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				PathWriteback_Tick),
							.In(					{ScanTableAWidth{1'bx}}),
							.Count(					PathReadCtr));	
	
	
	//------------------------------------------------------------------------------	
endmodule
//------------------------------------------------------------------------------
