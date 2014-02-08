
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
//		- Read command
//		- Read/remove command
//		- Update command
//		- Timing obfuscation
//		- Integrity verification
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

	// TODO set CommandReady = 0 if LoadDataReady = 0 (i.e., the front end can't take our result!)
	
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
	
	localparam					BigUWidth =			ORAMU * ORAMZ,
								BigLWidth =			ORAML * ORAMZ;
	
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
	
	wire						AppendComplete, PathReadComplete, PathWritebackComplete;
	
	wire	[ORAML-1:0]			DummyLeaf;
	
	// AES encrypt pipeline

	wire						PathBuffer_InReady;

	wire						PathBuffer_OutValid, PathBuffer_OutReady;
	wire	[DDRDWidth-1:0]		PathBuffer_OutData;
		
	wire						HeaderDownShift_InValid, HeaderDownShift_InReady;
	wire						DataDownShift_InValid, DataDownShift_InReady;
		
	wire	[BBSTWidth-1:0]		BucketReadCtr;
	wire						LoadHeader, ProcessingHeader;	
		
	wire	[BigUWidth-1:0]		HeaderDownShift_PAddrs;
	wire	[BigLWidth-1:0]		HeaderDownShift_Leaves;
		
	wire						BlockIsValid;
	
	wire	[BEDWidth-1:0]		DataDownShift_OutData;
	wire						DataDownShift_OutValid, DataDownShift_OutReady;
	wire						DataDownShift_OutValid_Checked;
	
	wire	[ORAMU-1:0]			HeaderDownShift_OutPAddr; 
	wire	[ORAML-1:0]			HeaderDownShift_OutLeaf;
	wire						HeaderDownShift_OutValid;		
	
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
	
	wire	[BECMDWidth-1:0] 	FEStash_Command;
	wire	[ORAMU-1:0]			FEStash_PAddr;
	wire	[ORAML-1:0]			FEStash_CurrentLeaf, FEStash_RemappedLeaf;
	wire						FEStash_CommandValid, FEStash_CommandReady;
	
	wire						FEStash_EvictBlockValid, FEStash_EvictBlockReady;

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
	
	wire						AddrGen_Reading;
	
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
	
	assign	FEStash_CommandReady =					AppendComplete | 
													(CSPathWriteback & PathWritebackComplete & ~AccessIsDummy);

	// Don't allow evictions when we only have space for a path
	assign	FEStash_WriteDataReady = 				FEStash_EvictBlockReady & 	FEStash_CommandValid & ~StashAlmostFull;
	assign	FEStash_EvictBlockValid = 				FEStash_WriteDataValid & 	FEStash_CommandValid & ~StashAlmostFull;
	
	assign	AddrGen_InValid =						CSStartRead | CSStartWriteback; 
	
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
				else if (FEStash_CommandValid & 	FEStash_Command == BECMD_Append) // appends aren't much work --- do them first
					NS =							ST_Append;
				else if (FEStash_CommandValid & (	FEStash_Command == BECMD_Update | 
													FEStash_Command == BECMD_Read | 
													FEStash_Command == BECMD_ReadRmv))
					NS =							ST_StartRead;
			ST_Append :
				if (AppendComplete)
					NS = 							ST_Idle;
			ST_StartRead : 
				if (AddrGen_InReady)
					NS =							ST_PathRead;
			ST_PathRead : 							
				if (PathReadComplete)
					NS =							ST_StartWriteback;
			ST_StartWriteback :
				if (AddrGen_InReady)
					NS =							ST_PathWriteback;
			ST_PathWriteback : 
				if (PathWritebackComplete)
					NS =							ST_Idle;
		endcase
	end
	
	Register	#(			.Width(					1))
				dummy_reg(	.Clock(					Clock),
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
							.InData(				{Command,			PAddr, 			CurrentLeaf, 		RemappedLeaf}),
							.InValid(				CommandValid),
							.InAccept(				CommandReady),
							.OutData(				{FEStash_Command,	FEStash_PAddr,	FEStash_CurrentLeaf,FEStash_RemappedLeaf}),
							.OutSend(				FEStash_CommandValid),
							.OutReady(				FEStash_CommandReady));
	
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
	//	Random leaf generator
	//------------------------------------------------------------------------------ 
	
	// TODO use AES for this
	
	/*
	Counter		#(			.Width(					ORAML))
				SyncCounter(.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSStartRead),
							.In(					{ORAML{1'bx}}),
							.Count(					DummyLeaf));
	*/
	
	assign	DummyLeaf = 							0;
	
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
	
	assign	AddrGen_Reading = 						CSStartRead;
	assign	AddrGen_Leaf =							(AccessIsDummy) ? DummyLeaf : FEStash_CurrentLeaf;
	
	// Initializer / AES encrypt arbitration
	// TODO this will change when we have the AES encrypt path
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
							.RWIn(					AddrGen_Reading),
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
	
	// Buffers the whole incoming path (... this is a lazy design?)
	// NOTE: This buffer requires ~1% of the LUT RAM on the chip (so its not a big 
	// deal?)
	FIFORAM		#(			.Width(					DDRDWidth),
							.Buffering(				PathSize_DRBursts))
				in_path_buf(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DRAMReadData),
							.InValid(				DRAMReadDataValid),
							.InAccept(				PathBuffer_InReady), // debugging
							.OutData(				PathBuffer_OutData),
							.OutSend(				PathBuffer_OutValid),
							.OutReady(				PathBuffer_OutReady));
	
	// Count where we are in a bucket (so we can determine when we are at a header)
	Counter		#(			.Width(					BBSTWidth))
				in_bkt_cnt(	.Clock(					Clock),
							.Reset(					Reset | BucketReadCtr_Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				PathBuffer_OutValid & PathBuffer_OutReady),
							.In(					{BBSTWidth{1'bx}}),
							.Count(					BucketReadCtr));	
	CountCompare #(			.Width(					BBSTWidth),
							.Compare(				BktSize_DRBursts))
				in_bkt_cmp(	.Count(					BucketReadCtr), 
							.TerminalCount(			BucketReadCtr_Reset));
	
	// Don't present dummy blocks to the stash
	ShiftRegister #(		.PWidth(				ORAMZ),
							.SWidth(				1),
							.Reverse(				0))
				in_vld_bits(.Clock(					Clock), 
							.Reset(					Reset | BucketReadCtr_Reset), 
							.Load(					LoadHeader), 
							.Enable(				Stash_BlockWriteComplete), 
							.PIn(					PathBuffer_OutData[IVEntropyWidth+ORAMZ-1:IVEntropyWidth]), 
							.SIn(					1'bx), 
							.POut(					), // not connected 
							.SOut(					BlockIsValid));
							
	// Per-bucket header/payload arbitration
	assign	LoadHeader =							BucketReadCtr == 0;
	assign	ProcessingHeader =						BucketReadCtr < BktHSize_DRBursts;
	assign	HeaderDownShift_InValid =				PathBuffer_OutValid & ProcessingHeader;
	assign	DataDownShift_InValid =					PathBuffer_OutValid & ~ProcessingHeader;
	assign	PathBuffer_OutReady =					(ProcessingHeader) ? HeaderDownShift_InReady : DataDownShift_InReady;
	
	assign	HeaderDownShift_PAddrs =				PathBuffer_OutData[BktHULStart+ORAMZ*ORAMU-1:BktHULStart];
	assign	HeaderDownShift_Leaves =				PathBuffer_OutData[BktHULStart+BHULWidth-1:BktHULStart+ORAMZ*ORAMU];
	
	FIFOShiftRound #(		.IWidth(				BigUWidth),
							.OWidth(				ORAMU))
				in_U_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderDownShift_PAddrs),
							.InValid(				HeaderDownShift_InValid),
							.InAccept(				HeaderDownShift_InReady),
							.OutData(			    HeaderDownShift_OutPAddr),
							.OutValid(				HeaderDownShift_OutValid),
							.OutReady(				Stash_BlockWriteComplete));
	FIFOShiftRound #(		.IWidth(				BigLWidth),
							.OWidth(				ORAML))
				in_L_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderDownShift_Leaves),
							.InValid(				HeaderDownShift_InValid),
							.InAccept(				), // will be the same as in_L_shft
							.OutData(			    HeaderDownShift_OutLeaf),
							.OutValid(				), // will be the same as in_L_shft
							.OutReady(				Stash_BlockWriteComplete));	

	FIFOShiftRound #(		.IWidth(				DDRDWidth),
							.OWidth(				BEDWidth))
				in_dat_shft(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				PathBuffer_OutData),
							.InValid(				DataDownShift_InValid),
							.InAccept(				DataDownShift_InReady),
							.OutData(				DataDownShift_OutData),
							.OutValid(				DataDownShift_OutValid),
							.OutReady(				DataDownShift_OutReady));
	assign	DataDownShift_OutValid_Checked =		DataDownShift_OutValid & HeaderDownShift_OutValid & BlockIsValid;

	assign	IncrementReadCtr =						DataDownShift_OutValid & HeaderDownShift_OutValid & DataDownShift_OutReady;
	
	// count number of real/dummy blocks on path and signal the end of the path 
	// read when we read a whole path's worth 
	Counter		#(			.Width(					PBSTWidth))
				in_stash_cnt(.Clock(				Clock),
							.Reset(					Reset | CSIdle),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				IncrementReadCtr & ~PathReadComplete),
							.In(					{PBSTWidth{1'bx}}),
							.Count(					PathReadCtr));
	CountCompare #(			.Width(					PBSTWidth),
							.Compare(				PathSize_DRBursts))
				in_stash_cmp(.Count(				PathReadCtr), 
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
							
							.AccessLeaf(			FEStash_CurrentLeaf),
							.AccessPAddr(			FEStash_PAddr),
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
							.EvictPAddr(			FEStash_PAddr),
							.EvictLeaf(				FEStash_RemappedLeaf),
							.EvictDataInValid(		FEStash_EvictBlockValid),
							.EvictDataInReady(		FEStash_EvictBlockReady),
							.BlockEvictComplete(	AppendComplete),

							.WriteData(				DataDownShift_OutData),
							.WriteInValid(			DataDownShift_OutValid_Checked),
							.WriteInReady(			DataDownShift_OutReady), 
							.WritePAddr(			HeaderDownShift_PAddr),
							.WriteLeaf(				HeaderDownShift_Leaf),
							.BlockWriteComplete(	Stash_BlockWriteComplete), 
							
							.ReadData(				DataUpShift_InData),
							.ReadPAddr(				HeaderUpShift_InPAddr),
							.ReadLeaf(				HeaderUpShift_InLeaf),
							.ReadOutValid(			DataInShift_Valid), 
							.ReadOutReady(			DataInShift_Ready), 
							.BlockReadComplete(		Stash_BlockReadComplete),
							.PathReadComplete(		PathWritebackComplete),
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		)); // debugging	
	
	//------------------------------------------------------------------------------
	//	AES encrypt pipeline [TODO: add AES itself]
	//------------------------------------------------------------------------------

	/*
	wire						Stash_BlockReadComplete;
	
	wire	[ORAMU-1:0]			HeaderUpShift_InPAddr; 
	wire	[ORAML-1:0]			HeaderUpShift_InLeaf;
	wire						HeaderUpShift_OutValid;
	
	wire	[BigUWidth-1:0]		HeaderUpShift_PAddrs;
	wire	[BigLWidth-1:0]		HeaderUpShift_Leaves;
	
	wire	[BEDWidth-1:0]		DataUpShift_InData;
	wire						DataInShift_Valid, DataInShift_Ready;
	
	FIFOShiftRound #(		.IWidth(				ORAMU),
							.OWidth(				BigUWidth))
				out_U_shift(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderUpShift_InPAddr),
							.InValid(				Stash_BlockReadComplete),
							.InAccept(				),
							.OutData(			    HeaderUpShift_PAddrs),
							.OutValid(				),
							.OutReady(				));
							
	FIFOShiftRound #(		.IWidth(				ORAML),
							.OWidth(				BigLWidth))
				out_L_shift(.Clock(					Clock),
							.Reset(					Reset),
							.InData(				HeaderUpShift_InLeaf),
							.InValid(				Stash_BlockReadComplete),
							.InAccept(				),
							.OutData(			    HeaderUpShift_Leaves),
							.OutValid(				),
							.OutReady(				));

	FIFOShiftRound #(		.IWidth(				BEDWidth),
							.OWidth(				DDRDWidth))
				out_dat_shft(.Clock(				Clock),
							.Reset(					Reset),
							.InData(				DataUpShift_InData),
							.InValid(				DataInShift_Valid),
							.InAccept(				DataInShift_Ready),
							.OutData(			    ),
							.OutValid(				),
							.OutReady(				));	
	*/
	
	
	//------------------------------------------------------------------------------	
endmodule
//------------------------------------------------------------------------------
