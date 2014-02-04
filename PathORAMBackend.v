
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAMBackend
//	Desc:		The stash, AES, address generation, and throughput back-pressure 
//				logic (e.g., dummy access control, R^(E+1)W pattern control)
//
//	TODO
//		- Append command
//		- Read command
//		- Read/remove command
//		- Update command
//==============================================================================
module PathORAMBackend #(	`include "PathORAM.vh", `include "DDR3SDRAM.vh",
							`include "AES.vh", `include "Stash.vh") (
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

	output	[FEDWidth-1:0]		LoadData,
	output						LoadValid,
	input 						LoadReady,

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

	`include "BucketLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "PathORAMBackendLocal.vh"
	
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
	wire						CSInitialize, CSIdle, CSStartRead, 
								CSStartWriteback, CSPathRead, CSPathWriteback;
	wire						AccessIsDummy;
	
	wire						PathReadComplete, PathWritebackComplete;
	
	// AES encrypt pipeline

	wire						PathBuffer_InReady;

	wire						PathBuffer_OutValid, PathBuffer_OutReady;
	wire	[DDRDWidth-1:0]		PathBuffer_OutData;
		
	wire						HeaderDownShift_InValid, HeaderDownShift_InReady;
	wire						DataDownShift_InValid, DataDownShift_InReady;
		
	wire	[BHBSTWidth-1:0]	BucketReadCtr;
	wire						ProcessingHeader;	
		
	wire	[BHULWidth-1:0]		HeaderDownShift_Template;
	wire	[ORAMZ*ORAMU-1:0]	HeaderDownShift_PAddrs;
	wire	[ORAMZ*ORAML-1:0]	HeaderDownShift_Leaves;
		
	wire						BlockIsValid;
	
	wire	[BEDWidth-1:0]		DataDownShift_OutData;
	wire						DataDownShift_OutValid, DataDownShift_OutReady;
	wire						DataDownShift_OutValid_Checked;
	
	wire	[ORAMU-1:0]			HeaderDownShift_OutPAddr; 
	wire	[ORAML-1:0]			HeaderDownShift_OutLeaf, HeaderDownShift_OutValid;		
	
	wire	[PBSTWidth-1:0]		PathReadCtr;
	wire						IncrementReadCtr;
	
	// AES encrypt pipeline
	
	// TODO
	
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
	wire						LockedCommandValid, LockedCommandReady;
	
	wire						Stash_BlockWriteComplete;
	
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
			if (BEDWidth > DDRDWidth) begin
				$display("[%m @ %t] ERROR: BEDWidth should never be > DDRDWidth", $time);
				$stop;
			end
		end
		
		always @(posedge Clock) begin
			if (StashOverflow) begin
				// This is checked in StashCore.v ...
			end
			
			if (~PathBuffer_InReady & DRAMReadDataValid) begin
				$display("[%m @ %t] ERROR: DRAM was sending data and we had no space", $time);
				$stop;
			end

		end
	`endif
	
	//------------------------------------------------------------------------------
	//	Control logic
	//------------------------------------------------------------------------------
	
	assign	CSInitialize =							CS == ST_Initialize;
	assign	CSIdle =								CS == ST_Idle;
	assign	CSStartRead =							CS == ST_StartRead;
	assign	CSStartWriteback =						CS == ST_StartWriteback;
	assign	CSPathRead =							CS == ST_PathRead;
	assign	CSPathWriteback =						CS == ST_PathWriteback;
	
	assign	AllResetsDone =							Stash_ResetDone & DRAMInit_Done;

	assign	Stash_StartScanOp =						CSStartRead;
	assign	Stash_StartWritebackOp =				CSStartWriteback;
	
	assign	LockedCommandReady =					CSPathWriteback & PathWritebackComplete & ~AccessIsDummy;
	
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
					NS =							ST_StartRead;
				else if (LockedCommandValid & Command_reg == BECMD_Append) // appends aren't much work --- do them first
					NS =							ST_Append;
				else if (LockedCommandValid & (	Command_reg == BECMD_Update | 
												Command_reg == BECMD_Read | 
												Command_reg == BECMD_ReadRmv))
					NS =							ST_StartRead;
			ST_Append :
				if (Stash_AppendComplete)
					NS = 							ST_Idle;
			ST_StartRead : 
				NS =								ST_PathRead;
			ST_PathRead : 							
				if (PathReadComplete)
					NS =							ST_StartWriteback;
			ST_StartWriteback :
				NS =								ST_PathWriteback;
			ST_PathWriteback : 
				if (PathWritebackComplete)
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
							.OutSend(				LockedCommandValid),
							.OutReady(				LockedCommandReady));
	
	// TODO we may not need these expensive shifts if we can incrementally write 
	// FEDWidth chunks to the stash; check: are they really that expensive?  If we 
	// can pack them into 2 SLICEM's each, then its no problem
	FIFOShiftRound #(		.IWidth(				FEDWidth),
							.OWidth(				BEDWidth))
				st_shift(	.Clock(					Clock),
							.Reset(					Reset),
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
							.InData(				StashFE_ReadData),
							.InValid(				StashFE_ReadDataValid),
							.InAccept(				StashFE_ReadDataReady),
							.OutData(				LoadData),
							.OutValid(				LoadData),
							.OutReady(				LoadReady));
	
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
	
	// Initializer / AES encrypt arbitration
	assign	DRAMWriteData =							DRAMInit_DRAMWriteData;
	assign	DRAMWriteMask =							DRAMInit_DRAMWriteMask;
	assign	DRAMWriteDataValid =					DRAMInit_DRAMWriteDataValid;
	assign	DRAMInit_DRAMWriteDataReady = 			DRAMWriteDataReady;
	
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
	//	AES decrypt pipeline [TODO: add AES itself]
	//------------------------------------------------------------------------------
	
	// Buffers the whole incoming path (... this is a lazy design)
	// TODO: 	We don't need a complete buffer if we add back pressure to the 
	//			AddrGen
	// NOTE: 	This buffer requires ~1% of the LUT RAM on the chip (so its not 
	//			a big deal?)
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				PathSize_DRBursts))
				path_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMReadData),
							.InValid(				DRAMReadDataValid),
							.InAccept(				PathBuffer_InReady), // debugging
							.InEmptyCount(			), // not connected
							.OutData(				PathBuffer_OutData),
							.OutSend(				PathBuffer_OutValid),
							.OutReady(				PathBuffer_OutReady),
							.OutFullCount(			)); // not connected	
	
	// Keep track of whether we are processing header or payload for each bucket
	Counter		#(			.Width(					BHBSTWidth))
				bkt_cnt(	.Clock(					Clock),
							.Reset(					Reset | BucketReadCtr_Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				PathBuffer_OutValid & PathBuffer_OutReady),
							.In(					{BHBSTWidth{1'bx}}),
							.Count(					BucketReadCtr));	
	CountCompare #(			.Width(					BHBSTWidth),
							.Compare(				BktSize_DRBursts))
				bkt_cmp(	.Count(					BucketReadCtr), 
							.TerminalCount(			BucketReadCtr_Reset));
	
	// Don't present dummy blocks to the stash
	ShiftRegister #(		.PWidth(				ORAMZ),
							.SWidth(				1),
							.Reverse(				0))
				valid_bits(	.Clock(					Clock), 
							.Reset(					Reset | BucketReadCtr_Reset), 
							.Load(					BucketReadCtr == 0), 
							.Enable(				Stash_BlockWriteComplete), 
							.PIn(					PathBuffer_OutData[IVEntropyWidth+ORAMZ-1:IVEntropyWidth]), 
							.SIn(					1'bx), 
							.POut(					), // not connected 
							.SOut(					BlockIsValid));
							
	// Per-bucket header/payload arbitration
	assign	ProcessingHeader =						BucketReadCtr < BktHSize_DRBursts;
	assign	HeaderDownShift_InValid =				PathBuffer_OutValid & ProcessingHeader;
	assign	DataDownShift_InValid =					PathBuffer_OutValid & ~ProcessingHeader;
	assign	PathBuffer_OutReady =					(ProcessingHeader) ? HeaderDownShift_InReady : DataDownShift_InReady;
	
	assign	HeaderDownShift_PAddrs =				PathBuffer_OutData[BktHULStart+ORAMZ*ORAMU-1:BktHULStart];
	assign	HeaderDownShift_Leaves =				PathBuffer_OutData[BktHULStart+BHULWidth-1:BktHULStart+ORAMZ*ORAMU];
	
	// Take the UUUULLLL bucket packing and translate it to ULULULUL to the stash
	InsertMask	#(			.OWidth(				BHULWidth),
							.Mask(					{ORAMZ {{ORAMU{1'b1}}, {ORAML{1'b0}}}} ))							
				im_paddr(	.In(					HeaderDownShift_PAddrs), 
							.Base(					{BHULWidth{1'b0}}), 
							.Out(					HeaderDownShift_Template));
	InsertMask	#(			.OWidth(				BHULWidth),
							.Mask(					{ORAMZ {{ORAMU{1'b0}}, {ORAML{1'b1}}}} ))							
				im_leaf(	.In(					HeaderDownShift_Leaves), 
							.Base(					HeaderDownShift_Template), 
							.Out(					HeaderDownShift_InData));
	
	// shift the bucket header into the stash
	FIFOShiftRound #(		.IWidth(				BHULWidth),
							.OWidth(				ORAML + ORAMU))
				hdr_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderDownShift_InData),
							.InValid(				HeaderDownShift_InValid),
							.InAccept(				HeaderDownShift_InReady),
							.OutData(			    {HeaderDownShift_OutPAddr, HeaderDownShift_OutLeaf}),
							.OutValid(				HeaderDownShift_OutValid),
							.OutReady(				Stash_BlockWriteComplete));		
	
	// shift the bucket data blocks into the stash
	generate if (BEDWidth != DDRDWidth) begin:DT_SHFT_DOWN
		FIFOShiftRound #(	.IWidth(				DDRDWidth),
							.OWidth(				BEDWidth))
				dta_shift(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				PathBuffer_OutData),
							.InValid(				DataDownShift_InValid),
							.InAccept(				DataDownShift_InReady),
							.OutData(				DataDownShift_OutData),
							.OutValid(				DataDownShift_OutValid),
							.OutReady(				DataDownShift_OutReady));
							
		assign	DataDownShift_OutValid_Checked =	DataDownShift_OutValid & 	HeaderDownShift_OutValid & BlockIsValid;
	end else begin:DT_PASS
		assign	DataDownShift_OutValid_Checked =	DataDownShift_InValid & 	HeaderDownShift_OutValid & BlockIsValid;
		assign	DataDownShift_InReady =				DataDownShift_OutReady;
		assign	DataDownShift_OutData =				PathBuffer_OutData;
	end endgenerate
	
	assign	IncrementReadCtr =						DataDownShift_OutValid & HeaderDownShift_OutValid & DataDownShift_OutReady;
	
	// count number of real/dummy blocks on path and signal the end of the path 
	// read when we read a whole path's worth 
	Counter		#(			.Width(					PBSTWidth))
				rd_cnt(		.Clock(					Clock),
							.Reset(					Reset | CSIdle),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				IncrementReadCtr & ~PathReadComplete),
							.In(					{PBSTWidth{1'bx}}),
							.Count(					PathReadCtr));
	CountCompare #(			.Width(					PBSTWidth),
							.Compare(				PathSize_DRBursts))
				rd_cmp(		.Count(					PathReadCtr), 
							.TerminalCount(			PathReadComplete));
	
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
							
							.AccessLeaf(			CurrentLeaf_reg),
							.AccessPAddr(			PAddr_reg),
							.AccessIsDummy(			AccessIsDummy),
							
							.StartScan(				Stash_StartScanOp),  
							.StartWriteback(		Stash_StartWritebackOp),
							
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
							.WriteInValid(			DataDownShift_OutValid_Checked),
							.WriteInReady(			DataDownShift_OutReady), 
							.WritePAddr(			HeaderDownShift_PAddr),
							.WriteLeaf(				HeaderDownShift_Leaf),
							.BlockWriteComplete(	Stash_BlockWriteComplete), 
							
							.ReadData(				),
							.ReadPAddr(				),
							.ReadLeaf(				),
							.ReadOutValid(			), 
							.ReadOutReady(			1'b0), 
							.BlockReadComplete(		),
							.PathReadComplete(		PathWritebackComplete),
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		)); // debugging	
	
	//------------------------------------------------------------------------------
	//	AES encrypt pipeline [TODO: add AES itself]
	//------------------------------------------------------------------------------
	
	//------------------------------------------------------------------------------	
endmodule
//------------------------------------------------------------------------------
