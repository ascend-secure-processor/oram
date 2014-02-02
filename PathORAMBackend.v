
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

	localparam					STWidth =			3,
								ST_Initialize =		3'd0,
								ST_Idle =			3'd1,
								ST_Append =			3'd2,
								ST_StartRead =		3'd3,
								ST_PathRead =		3'd4,
								ST_StartWriteback =	3'd5,
								ST_PathWriteback =	3'd6;
								
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
	
	wire	[BECMDWidth-1:0] 	Command_reg;
	wire	[ORAMU-1:0]			PAddr_reg;
	wire	[ORAML-1:0]			CurrentLeaf_reg, RemappedLeaf_reg;
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
	
	wire						AddrGen_Writing;
	
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
			
			if (PathBuffer_InReady & DRAMReadDataValid) begin
				$display("[%m @ %t] DRAM was sending data and we had no space", $time);
				$stop;
			end

		end
	`endif
	
	//------------------------------------------------------------------------------
	//	Control logic
	//------------------------------------------------------------------------------

	CSIdle
	AccessIsDummy
	
	CSStartRead
	CSStartWriteback
	CSPathRead
	CSPathWriteback
	
	assign	CSInitialize =							CS == ST_Initialize;
	assign	CSStartRead =							CS == ST_StartRead;
	assign	CSStartWriteback =						CS == ST_StartWriteback;
	assign	CSPathRead =							CS == ST_PathRead;
	assign	CSPathWriteback =						CS == ST_PathWriteback;
	
	assign	AllResetsDone =							Stash_ResetDone & DRAMInit_Done;

	assign	Stash_StartScanOp =						CSStartRead;
	assign	Stash_StartWritebackOp =				CSStartWriteback;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Initialize;
		else CS <= 									NS;
	end

	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Initialize : 
				if (AllResetsDone) 
					NS =						 	ST_Idle;
			ST_Idle :
				if (StashAlmostFull) // highest priority
					NS =							ST_StartAccess;
				else if (LockedValid & Command_reg == CMD_Append)
					NS =							ST_Append;
				else if (LockedValid & (Command_reg == CMD_Update | 
										Command_reg == CMD_Read | 
										Command_reg == CMD_ReadRmv))
					NS =							ST_StartAccess;
			ST_Append :
				if (Stash_AppendComplete)
					NS = 							ST_Idle;
			ST_StartRead : 
				NS =								ST_PathRead;
			ST_PathRead : 							
				if ()
					NS =							ST_StartWriteback;
			ST_StartWriteback :
				NS =								ST_PathWriteback
			ST_PathWriteback : 
				if ()
					NS =							ST_Idle;
		endcase
	end
	
	Register	#(			.Width(					1))
				DummyReg(	.Clock(					Clock),
							.Reset(					Reset | (CSIdle & ~StashAlmostFull)),
							.Set(							 CSIdle & StashAlmostFull),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					AccessIsDummy));
	
	//------------------------------------------------------------------------------
	//	Frontend interface
	//------------------------------------------------------------------------------	

	FIFORegister #(			.Width(					BECMDWidth + ORAMU + ORAML*2))
				cmd_reg(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				{Command, 		PAddr, 		CurrentLeaf, 	RemappedLeaf}),
							.InValid(				CommandValid),
							.InAccept(				CommandReady),
							.OutData(				{Command_reg,	PAddr_reg,	CurrentLeaf_reg,RemappedLeaf_reg}),
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
	
	Stash_BlockWriteComplete
	
	Stash	#(				.StashCapacity(			StashCapacity),
							.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
							
			stash(			.Clock(					Clock),
							.Reset(					Reset),
							.ResetDone(				Stash_ResetDone),
							
							.AccessLeaf(			CurrentLeaf_reg),
							.AccessPAddr(			PAddr_reg),
							.AccessIsDummy(			AccessIsDummy),
							
							.StartScanOperation(	Stash_StartScanOp),  
							.StartWritebackOperation(Stash_StartWritebackOp),
							
							.ReturnData(			StashFE_ReadData),
							.ReturnPAddr(			), // not connected
							.ReturnLeaf(			), // not connected
							.ReturnDataOutValid(	StashFE_ReadDataValid),
							.ReturnDataOutReady(	StashFE_ReadDataReady),
							.BlockReturnComplete(	), // not connected
							
							// TODO add flag to indicate append?
							.EvictData(				FEStash_WriteData),
							.EvictPAddr(			PAddr_reg),
							.EvictLeaf(				RemappedLeaf_reg),
							.EvictDataInValid(		FEStash_WriteDataValid),
							.EvictDataInReady(		StashFE_ReadDataReady),
							.BlockEvictComplete(	Stash_AppendComplete), // not connected

							.WriteData(				DataDownShift_OutData),
							.WriteInValid(			DataDownShift_OutValid),
							.WriteInReady(			DataDownShift_OutReady), 
							.WritePAddr(			),
							.WriteLeaf(				),
							.BlockWriteComplete(	Stash_BlockWriteComplete), 
							
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
	
	assign	AddrGen_Writing = 						CSStartWriteback | CSPathWriteback;
	
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
							.RWIn(					AddrGen_Writing),
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
	//	AES pipeline counters
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
	CountCompare(Count, TerminalCount)

	//------------------------------------------------------------------------------
	//	AES pipelines
	//------------------------------------------------------------------------------
	
	PathBuffer_InReady
	PathBuffer_OutValid
	PathBuffer_OutData
	PathBuffer_OutReady	
	
	HeaderDownShift_InData
	HeaderDownShift_InValid
	HeaderDownShift_InReady

	
	DataDownShift_InValid
	DataDownShift_InReady
	DataDownShift_OutValid
	DataDownShift_OutReady
	DataDownShift_OutData
	
	ShiftingData
	
	DataDownShift_InValid
	DataDownShift_InReady
	DataDownShift_OutValid
	DataDownShift_OutReady
	DataDownShift_OutData
	
	
	
	Counter		#(			.Width(					))
				hdr_cnt(	.Clock(					Clock),
							.Reset(					Reset | ),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				),
							.In(					{{1'bx}}),
							.Count(					));
	CountCompare #(			.Width(					), 
							.Compare(				))
				hdr_stop(	.Count(					), 
							.TerminalCount(			ShiftingData));
	
	Counter		#(			.Width(					))
				dta_cnt(	.Clock(					Clock),
							.Reset(					Reset | ),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				),
							.In(					{{1'bx}}),
							.Count(					));
	CountCompare #(			.Width(					), 
							.Compare(				))
				dta_stop(	.Count(					), 
							.TerminalCount(			));
	
	// interleaves
	FIFOShiftRound #(		.IWidth(				DDRDWidth),
							.OWidth(				ORAML + ORAMU))
				hdr_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.RepeatLimit(			), // not connected
							.RepeatMin(				), // not connected
							.RepeatPreMax(			), // not connected
							.RepeatMax(				), // not connected
							.InData(				HeaderDownShift_InData),
							.InValid(				HeaderDownShift_InValid),
							.InAccept(				HeaderDownShift_InReady),
							.OutData(				),
							.OutValid(				DataDownShift_OutValid),
							.OutReady(				Stash_BlockWriteComplete));		
	
	generate if (BEDWidth != DDRDWidth) begin:DT_SHFT_DOWN
		FIFOShiftRound #(	.IWidth(				DDRDWidth),
							.OWidth(				BEDWidth))
				dta_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.RepeatLimit(			), // not connected
							.RepeatMin(				), // not connected
							.RepeatPreMax(			), // not connected
							.RepeatMax(				), // not connected
							.InData(				PathBuffer_OutData),
							.InValid(				DataDownShift_InValid),
							.InAccept(				DataDownShift_InReady),
							.OutData(				DataDownShift_OutData),
							.OutValid(				DataDownShift_OutValid),
							.OutReady(				DataDownShift_OutReady));
	end endgenerate
	
	// TODO we don't need a complete buffer if we add back pressure to the AddrGen 
	// This buffer requires ~1% of the LUT RAM on the chip
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				PathLen_BEDWords))
				path_buffer(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMReadData),
							.InValid(				DRAMReadDataValid),
							.InAccept(				PathBuffer_InReady),
							.InEmptyCount(			),
							.OutData(				PathBuffer_OutData),
							.OutSend(				PathBuffer_OutValid),
							.OutReady(				PathBuffer_OutReady),
							.OutFullCount(			));	
	
	//------------------------------------------------------------------------------	
endmodule
//------------------------------------------------------------------------------
