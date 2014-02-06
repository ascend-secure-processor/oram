
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		Stash
//	Desc:		The Path ORAM stash
//
//	General notes:
//		- Leaf orientation: least significant bit is root bucket
// 		- Writeback occurs in root -> leaf bucket order
//
//	Low level notes on PathORAMBackend operations:
//		Peak/ReadRmv/Read: As a path read occurs, the scan marks when it finds 
//		the block in question.  We can then perform update/read/remove on that 
//		block by interacting with StashCore.
//
//	TODO:
//		- return interface
//		- dummy/real accesses
//------------------------------------------------------------------------------
module Stash #(`include "PathORAM.vh", `include "Stash.vh") (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 						Clock, Reset,
	output						ResetDone,

	//--------------------------------------------------------------------------
	//	Commands
	//--------------------------------------------------------------------------
	
	input	[ORAML-1:0]			AccessLeaf,
	input	[ORAMU-1:0]			AccessPAddr,
	input						AccessIsDummy,

	/*
		Start scanning the contents of the stash.  This should be pulsed as soon 
		as the PosMap is read.  The level command signals must be valid at this 
		time.
	*/
	input						StartScan,
	
	/*
		Start dumping data to AES encrypt in the NEXT cycle.  This should be 
		pulsed as soon as the last dummy block is decrypted
	*/
	input						StartWriteback,		
		
	//--------------------------------------------------------------------------
	//	Data return interface (ORAM controller -> LLC)
	//--------------------------------------------------------------------------
	
	output	[BEDWidth-1:0]		ReturnData,
	output	[ORAMU-1:0]			ReturnPAddr,
	output	[ORAML-1:0]			ReturnLeaf,
	output						ReturnDataOutValid,
	input						ReturnDataOutReady,	
	output						BlockReturnComplete,
	
	//--------------------------------------------------------------------------
	//	Data eviction interface (LLC -> Stash)
	//--------------------------------------------------------------------------	
	
	input	[BEDWidth-1:0]		EvictData,
	input	[ORAMU-1:0]			EvictPAddr,
	input	[ORAML-1:0]			EvictLeaf,
	input						EvictDataInValid,
	output						EvictDataInReady,
	output						BlockEvictComplete,	
	
	//--------------------------------------------------------------------------
	//	ORAM write interface (external memory -> Decryption -> stash)
	//--------------------------------------------------------------------------

	input	[BEDWidth-1:0]		WriteData,
	input	[ORAMU-1:0]			WritePAddr,
	input	[ORAML-1:0]			WriteLeaf,
	input						WriteInValid,
	output						WriteInReady,	
	
	/* 
		Pulsed during the last cycle that a block is being written [this will be 
		read by albert to tick the next PAddr/Leaf.
	*/
	output						BlockWriteComplete,
	
	//--------------------------------------------------------------------------
	//	ORAM read interface (stash -> encryption -> external memory)
	//--------------------------------------------------------------------------

	output	[BEDWidth-1:0]		ReadData,
	/* Set to DummyBlockAddress (see StashCore.constants) for dummy block. */
	output	[ORAMU-1:0]			ReadPAddr,
	output	[ORAML-1:0]			ReadLeaf,
	output						ReadOutValid,
	/* 
		If de-asserted, the Stash will finish writing back the current block and 
		then wait to writeback the next block until it goes high.
	*/
	input						ReadOutReady,	
	output reg 					BlockReadComplete,
	/* Pulsed during last cycle that a block is being read */
	output						PathReadComplete,
	
	//--------------------------------------------------------------------------
	//	Status/Debugging interface
	//--------------------------------------------------------------------------

	output 						StashAlmostFull,
	output						StashOverflow,
	output	[StashEAWidth-1:0] 	StashOccupancy
	);

	//--------------------------------------------------------------------------
	//	Constants
	//-------------------------------------------------------------------------- 
	
	`include "StashLocal.vh"
	
	localparam					STWidth =				3,
								ST_Reset =				3'd0,
								ST_Idle = 				3'd1,
								ST_Scan1 =				3'd2,
								ST_PathRead =			3'd3,
								ST_Scan2 =				3'd4,
								ST_PathWriteback = 		3'd5,
								ST_Evict =				3'd6;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	wire						PerAccessReset;

	wire 						StateTransition;

	reg		[STWidth-1:0]		CS, NS;
	wire						CSIdle, CSPathRead, CSPathWriteback, CSScan1, CSScan2, CSEvict;
		
	wire						StartScan_pass, StartScan_set, StartScan_primed;
	wire						TimeInScan, PermitScanPreemption;
				
	wire	[BEDWidth-1:0]		StashCore_InData;
	wire	[ORAMU-1:0]			StashCore_InPAddr;
	wire	[ORAML-1:0]			StashCore_InLeaf;
	wire						StashCore_InValid, StashCore_InReady;			
		
	wire	[ORAMU-1:0]			ScanPAddr;
	wire	[ORAML-1:0]			ScanLeaf;
	wire	[StashEAWidth-1:0]	ScanSAddr;
	wire						ScanLeafValid;

	wire	[StashEAWidth-1:0]	ScannedSAddr;
	wire						ScannedLeafAccepted, ScannedLeafValid;
	
	wire						StopReading, StopReading_Hold;
	wire						BlockReadComplete_Pre;
	
	wire						PathWriteback_Waiting;
	wire	[ScanTableAWidth-1:0] BlocksRead;
		
	wire	[SCWidth-1:0]		ScanCount;
	wire						SentScanCommand, Scan2Complete_Conservative;
	wire 						ScanTableResetDone;
	
	wire						PrepNextPeak, Core_AccessComplete, Top_AccessComplete;
	
	wire						CoreResetDone;
	wire	[SCMDWidth-1:0]		CoreCommand;
	wire						CoreCommandValid, CoreCommandReady, CoreOutValid;

	wire	[ScanTableAWidth-1:0]BlocksReading;
	wire	[StashEAWidth-1:0]	OutDMAAddr;	
	wire						InDMAValid, OutDMAValid;
	wire						PathWriteback_Tick;

	//--------------------------------------------------------------------------
	//	Debugging interface
	//--------------------------------------------------------------------------
	
	`ifdef SIMULATION
		reg [STWidth-1:0] CS_Delayed;
		
		always @(posedge Clock) begin
			CS_Delayed <= CS;
			
			if (CS_Delayed != CS) begin
				if (CSScan1)
					$display("[%m @ %t] Stash: Scan1", $time);
				if (CSPathRead)
					$display("[%m @ %t] Stash: PathRead", $time);
				if (CSScan2)
					$display("[%m @ %t] Stash: Scan2", $time);
				if (CSPathWriteback)
					$display("[%m @ %t] Stash: PathWriteback", $time);
			end
			
			if (PerAccessReset)
				$display("[%m @ %t] *** Per-module reset *** (ORAM access should be complete)", $time);
				
			/* This is a nice sanity check, but we got rid of _actual ...
			if (~Scan2Complete_Actual & Scan2Complete_Conservative) begin
				$display("[%m @ %t] ERROR: scan took longer than worst-case time...", $time);
				$stop;
			end*/
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	State transitions & control logic
	//--------------------------------------------------------------------------

	assign	ResetDone =								CoreResetDone & ScanTableResetDone;
	assign	PerAccessReset =						Top_AccessComplete & Core_AccessComplete;
	
	assign	BlockEvictComplete =					CSEvict & CoreCommandReady;
	assign	BlockWriteComplete =					CSPathRead & CoreCommandReady;
	assign	BlockReadComplete_Pre =					CSPathWriteback & CoreCommandReady;
	assign	PathReadComplete =						PerAccessReset;
	
	assign	ReadOutValid =							CSPathWriteback & CoreOutValid;
	
	assign 	StateTransition =						NS != CS;
	assign	CSIdle =								CS == ST_Idle;
	assign	CSPathRead = 							CS == ST_PathRead; 
	assign	CSPathWriteback = 						CS == ST_PathWriteback; 
	assign	CSScan1 = 								CS == ST_Scan1; 
	assign	CSScan2 = 								CS == ST_Scan2;
	assign	CSEvict =								CS == ST_Evict;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Reset;
		else CS <= 									NS;
		
		BlockReadComplete <=						BlockReadComplete_Pre;
	end
	
	always @( * ) begin
		NS = 										CS;
		case (CS)
			ST_Reset : 
				if (CoreResetDone) NS =				ST_Idle;
			ST_Idle :
				if (AccessLeafValid) 
					NS =							ST_Scan1;
				else if (EvictDataInValid)
					NS =							ST_Evict;
			ST_Scan1 :
				if (WriteInValid & PermitScanPreemption) 
					NS =			 				ST_PathRead;
				else if (StartWriteback) 
					NS = 							ST_Scan2;
			ST_PathRead :
				if (StartWriteback) 
					NS =							ST_Scan2;
			ST_Scan2 : 
				if (Scan2Complete_Conservative & ReadOutReady) 
					NS = 							ST_PathWriteback;
			ST_PathWriteback :
				if (Top_AccessComplete) 
					NS =							ST_Idle;
			ST_Evict :
				if (CoreCommandReady)
					NS =							ST_Idle;
		endcase
	end
	
	//--------------------------------------------------------------------------
	//	Input control & timing
	//--------------------------------------------------------------------------
	
	// Don't start the access until we are back in the Idle state; this ensures 
	// AccessLeaf is valid when the scan starts
	Register	#(				.Width(				1))
				scan_hold(		.Clock(				Clock),
								.Reset(				Reset | PerAccessReset),
								.Set(				StartScan),
								.Enable(			1'b0),
								.In(				1'bx),
								.Out(				StartScan_primed));
	assign	StartScan_pass = 						CSIdle & (StartScan | StartScan_primed);

	// Generate valid signals for this access
	Register	#(				.Width(				1))
				access_start(	.Clock(				Clock),
								.Reset(				Reset | PerAccessReset),
								.Set(				StartScan_pass),
								.Enable(			1'b0),
								.In(				1'bx),
								.Out(				StartScan_set));
	assign	AccessLeafValid =						StartScan_set | StartScan_pass;
		
	// We need to wait an implementation-dependent # of cycles in Scan before 
	// transitioning to PathRead
	Counter		#(			.Width(					1))
				scan_time(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSScan1 & ~PermitScanPreemption),
							.In(					1'bx),
							.Count(					TimeInScan));
	assign	PermitScanPreemption =					TimeInScan == 1; // 1 = implementation dependent
	
	//--------------------------------------------------------------------------
	//	Inner modules
	//--------------------------------------------------------------------------
	
	assign	CoreCommand =							(CSScan1 | CSScan2) ? 	SCMD_Dump :
													(CSPathRead | CSEvict) ? SCMD_Push :
													(CSPathWriteback) ? 	SCMD_Peak : 
																			{SCMDWidth{1'bx}};
	
	assign 	CoreCommandValid =						CSPathRead | CSEvict |
													(CSScan1 & ~SentScanCommand) | 
													(CSScan2 & ~SentScanCommand) | 
													(CSPathWriteback & OutDMAValid & ~PathWriteback_Waiting);
	
	// Write/Evict arbitration
	assign	StashCore_InData = 						(CSEvict) ? EvictData 			: WriteData;
	assign	StashCore_InPAddr = 					(CSEvict) ? EvictPAddr 			: WritePAddr;
	assign	StashCore_InLeaf = 						(CSEvict) ? EvictLeaf			: WriteLeaf;
	assign	StashCore_InValid =						(CSEvict) ? EvictDataInValid 	: WriteInValid;
	assign	EvictDataInReady =						CSEvict & StashCore_InReady;
	assign	WriteInReady =							~CSEvict & StashCore_InReady;
													
	StashCore	#(			.StashCapacity(			StashCapacity),
							.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
							
				stash_core(	.Clock(					Clock), 
							.Reset(					Reset),
							.PerAccessReset(		PerAccessReset),
							.ResetDone(				CoreResetDone),
						
							.InData(				StashCore_InData),
							.InPAddr(				StashCore_InPAddr),
							.InLeaf(				StashCore_InLeaf),
							.InValid(				StashCore_InValid),
							.InReady(				StashCore_InReady),

							.OutData(				ReadData),
							.OutPAddr(				ReadPAddr),
							.OutLeaf(				ReadLeaf),
							.OutValid(				CoreOutValid),

							.InSAddr(				OutDMAAddr),
							.InCommand(				CoreCommand),
							.InCommandValid(		CoreCommandValid),
							.InCommandReady(		CoreCommandReady),
											
							.OutScanPAddr(			ScanPAddr),
							.OutScanLeaf(			ScanLeaf),
							.OutScanSAddr(			ScanSAddr),
							.OutScanValid(			ScanLeafValid),

							.InScanSAddr(			ScannedSAddr),
							.InScanAccepted(		ScannedLeafAccepted),
							.InScanValid(			ScannedLeafValid),
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		StashOccupancy),
							
							.PrepNextPeak(			PrepNextPeak),
							.SyncComplete(			Core_AccessComplete));

	StashScanTable #(		.StashCapacity(			StashCapacity),
							.BEDWidth(				BEDWidth),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ)) 
							
				scan_table(	.Clock(					Clock),
							.Reset(					Reset),
							.PerAccessReset(		PerAccessReset),
							.ResetDone(				ScanTableResetDone),
							
							.CurrentLeaf(			AccessLeaf),
							.CurrentLeafValid(		AccessLeafValid),
							
							.InScanLeaf(			ScanLeaf),
							.InScanPAddr(			ScanPAddr),
							.InScanSAddr(			ScanSAddr),
							.InScanValid(			ScanLeafValid),
							.OutScanSAddr(			ScannedSAddr),
							.OutScanAccepted(		ScannedLeafAccepted),
							.OutScanValid(			ScannedLeafValid),
						
							.InDMAAddr(				BlocksReading),
							.InDMAValid(			InDMAValid),
							.InDMAReset(			PathWriteback_Tick),
							.OutDMAAddr(			OutDMAAddr),
							.OutDMAValid(			OutDMAValid));	

	//--------------------------------------------------------------------------
	//	Scan control
	//--------------------------------------------------------------------------

	// count the worst-case scan latency (for security)
	Counter		#(			.Width(					SCWidth),
							.Limited(				1),
							.Limit(					ScanDelay))
				ScanCounter(.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSScan1 | CSScan2),
							.In(					{SCWidth{1'bx}}),
							.Count(					ScanCount));
	
	Register	#(			.Width(					1))
				SentCmd(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset | StateTransition),
							.Set(					CoreCommandValid & CoreCommandReady & (CSScan1 | CSScan2)),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					SentScanCommand));
	
	assign	Scan2Complete_Conservative =			CSScan2 & ScanCount == ScanDelay;
	
	//--------------------------------------------------------------------------
	//	Read interface
	//--------------------------------------------------------------------------
	
	assign	PathWriteback_Tick =					CSPathWriteback & PrepNextPeak;
	assign	ReadingLastBlock = 						BlocksReading == (BlocksOnPath - 1); // -1 because this is the address into the scan table
	assign	StopReading =							CSPathWriteback & ReadingLastBlock & PrepNextPeak;
	
	// ticks at start of block read
	Counter		#(			.Width(					ScanTableAWidth),
							.Limited(				1),
							.Limit(					BlocksOnPath - 1))
				RdStartCnt(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				PathWriteback_Tick),
							.In(					{ScanTableAWidth{1'bx}}),
							.Count(					BlocksReading));

	Register	#(			.Width(					1))
				StopRdReg(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					StopReading),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					StopReading_Hold));	
					
	assign	InDMAValid =							CSPathWriteback & ~StopReading & ~StopReading_Hold;
					
	// ticks at end of block read
	Counter		#(			.Width(					ScanTableAWidth))
				RdReturnCnt(.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSPathWriteback & BlockReadComplete),
							.In(					{ScanTableAWidth{1'bx}}),
							.Count(					BlocksRead));
							
	// Block-level backpressure for reads (due to random DRAM delays)
	Register	#(			.Width(					1))
				ReadWait(	.Clock(					Clock),
							.Reset(					Reset | ReadOutReady),
							.Set(					PathWriteback_Tick & ~ReadOutReady),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					PathWriteback_Waiting));
							
	assign	Top_AccessComplete =					BlocksRead == BlocksOnPath;

	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

