
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.v"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		Stash
//	Desc:		The Path ORAM stash.
//
//	- Leaf orientation: least significant bit is root bucket
// 	- Writeback occurs in root -> leaf bucket order
//
//	TODO:
//		- eviction interface
//		- return interface
//		- dummy accesses
//------------------------------------------------------------------------------
module Stash(
			Clock, 
			Reset,
			ResetDone,
			
			//
			// Level signals for current ORAM access
			//
			
			AccessLeaf,
			AccessPAddr,
			AccessIsDummy,
			
			//
			// External pulse commands 
			//
			
			StartScanOperation, // Start scanning the contents of the stash
								// This should be pulsed as soon as the PosMap is read
								// The level command signals must be valid at this time 
			StartReadOperation, // Start dumping data to AES encrypt in the NEXT cycle
								// This should be pulsed as soon as the last dummy block is decrypted
								
			//
			// [FRONTEND] Stash -> LLC interface [TODO not implemented yet]
			//
			
			ReturnData,
			ReturnPAddr,
			ReturnLeaf,
			ReturnDataOutValid,
			ReturnDataOutReady,
			BlockReturnComplete,
			
			//
			// [FRONTEND] LLC -> Stash interface [TODO not implemented yet]
			//

			EvictData,
			EvictPAddr,
			EvictLeaf,
			EvictDataInValid,
			EvictDataInReady,
			BlockEvictComplete,
			
			//
			// [BACKEND] (LLC eviction, AES decrypt) -> Stash interface
			//
			
			WriteData,
			WriteInValid,
			WriteInReady,
			WritePAddr,
			WriteLeaf,
			BlockWriteComplete, // Pulsed during the last cycle that a block is 
								// being written [this will be read by albert to 
								// tick the next PAddr/Leaf]
			
			//
			// [BACKEND] Stash -> AES encrypt interface (Stash scan and writeback)
			//
			
			ReadData,
			ReadPAddr, 			// set to DummyBlockAddress (see StashCore.constants) 
								// for dummy block
			ReadLeaf,
			ReadOutValid, 		
			ReadOutReady, 		// If de-asserted, the Stash will finish writing 
								// back the current block and then wait to 
								// writeback the next block until it goes high
			BlockReadComplete, 	// Pulsed during last cycle that a block is 
								// being read
			
			//
			// Status interface
			//
			
			StashAlmostFull,
			StashOverflow,
			StashOccupancy
	);
		
	//--------------------------------------------------------------------------
	//	Parameters & constants
	//--------------------------------------------------------------------------

	`include "StashCore.constants"

	localparam					STWidth =				3,
								ST_Reset =				3'd0,
								ST_Idle = 				3'd1,
								ST_Scan1 =				3'd2,
								ST_PathRead =			3'd3,
								ST_Scan2 =				3'd4,
								ST_PathWriteback = 		3'd5;	
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 						Clock, Reset;
	output						ResetDone; 

	//--------------------------------------------------------------------------
	//	Commands
	//--------------------------------------------------------------------------
			
	input	[ORAML-1:0]			AccessLeaf;
	input	[ORAMU-1:0]			AccessPAddr;
	input						AccessIsDummy;

	input						StartScanOperation;
	input						StartReadOperation;		
		
	//--------------------------------------------------------------------------
	//	Data return interface (ORAM controller -> LLC)
	//--------------------------------------------------------------------------
	
	output	[DataWidth-1:0]		ReturnData;
	output	[ORAMU-1:0]			ReturnPAddr;
	output	[ORAML-1:0]			ReturnLeaf;
	output						ReturnDataOutValid;
	input						ReturnDataOutReady;	
	output						BlockReturnComplete;
	
	//--------------------------------------------------------------------------
	//	Data return interface (LLC -> Stash)
	//--------------------------------------------------------------------------	
	
	input	[DataWidth-1:0]		EvictData;
	input	[ORAMU-1:0]			EvictPAddr;
	input	[ORAML-1:0]			EvictLeaf;
	input						EvictDataInValid;
	output						EvictDataInReady;
	output						BlockEvictComplete;	
	
	//--------------------------------------------------------------------------
	//	ORAM write interface (external memory -> Decryption -> stash)
	//--------------------------------------------------------------------------

	input	[DataWidth-1:0]		WriteData;
	input	[ORAMU-1:0]			WritePAddr;
	input	[ORAML-1:0]			WriteLeaf;
	input						WriteInValid;
	output						WriteInReady;	
	output						BlockWriteComplete;
	
	//--------------------------------------------------------------------------
	//	ORAM read interface (stash -> encryption -> external memory)
	//--------------------------------------------------------------------------

	output	[DataWidth-1:0]		ReadData;
	output	[ORAMU-1:0]			ReadPAddr;
	output	[ORAML-1:0]			ReadLeaf;
	output						ReadOutValid;
	input						ReadOutReady;	
	output reg 					BlockReadComplete;
	
	//--------------------------------------------------------------------------
	//	Status interface
	//--------------------------------------------------------------------------

	output 						StashAlmostFull;
	output						StashOverflow;
	output	[StashEAWidth-1:0] 	StashOccupancy;

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	wire						PerAccessReset;

	reg		[STWidth-1:0]		CS, NS;
	wire						CSPathRead, CSPathWriteback, CSScan1, CSScan2;
		
	wire	[ORAMU-1:0]			ScanPAddr;
	wire	[ORAML-1:0]			ScanLeaf;
	wire	[StashEAWidth-1:0]	ScanSAddr;
	wire						ScanLeafValid;

	wire	[StashEAWidth-1:0]	ScannedSAddr;
	wire						ScannedLeafAccepted, ScannedLeafValid;
	
	wire 						StillReadingPath;	
	wire						BlockReadComplete_Pre;
	
	wire						PathWriteback_Waiting;
	wire	[ScanTableAWidth-1:0] BlocksRead;
		
	wire	[SCWidth-1:0]		ScanCount;
	wire						Scan2Complete_Actual, Scan2Complete_Conservative;
	wire 						ScanTableResetDone;
	
	wire						PrepNextPeak, Core_AccessComplete, Top_AccessComplete;
	
	wire						CoreResetDone;
	wire	[CMDWidth-1:0]		CoreCommand;
	wire						CoreCommandValid, CoreCommandReady, CoreOutValid;

	wire	[ScanTableAWidth-1:0]BlocksReading;
	wire	[StashEAWidth-1:0]	OutSTAddr;	
	wire						InSTValid, OutSTValid;
	wire						PathWriteback_Tick;

	//--------------------------------------------------------------------------
	//	Debugging interface
	//--------------------------------------------------------------------------
	
	`ifdef MODELSIM
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
				
			if (~Scan2Complete_Actual & Scan2Complete_Conservative) begin
				$display("[%m @ %t] ERROR: scan took longer than worst-case time...", $time);
				$stop;
			end
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	State transitions & control logic
	//--------------------------------------------------------------------------

	assign	ResetDone =								CoreResetDone & ScanTableResetDone;
	assign	PerAccessReset =						Top_AccessComplete & Core_AccessComplete;
	
	assign	BlockWriteComplete =					CSPathRead & CoreCommandReady;
	assign	BlockReadComplete_Pre =					CSPathWriteback & CoreCommandReady;
	
	assign	ReadOutValid =							CSPathWriteback & CoreOutValid;
	
	assign	CSPathRead = 							CS == ST_PathRead; 
	assign	CSPathWriteback = 						CS == ST_PathWriteback; 
	assign	CSScan1 = 								CS == ST_Scan1; 
	assign	CSScan2 = 								CS == ST_Scan2;
	
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
				if (StartScanOperation) NS =		ST_Scan1;
				else if (WriteInValid) NS = 		ST_PathRead;
			ST_Scan1 :
				if (WriteInValid) NS = 				ST_PathRead;
				else if (CoreCommandReady) NS =		ST_Idle; // if the scan finished first
			ST_PathRead :
				if (StartReadOperation) NS =		ST_Scan2;
			ST_Scan2 : 
				if (Scan2Complete_Conservative & ReadOutReady) 
					NS = 							ST_PathWriteback;
			ST_PathWriteback :
				if (Top_AccessComplete) NS =		ST_Idle;
		endcase
	end
	
	//--------------------------------------------------------------------------
	//	Inner modules
	//--------------------------------------------------------------------------
	
	assign	CoreCommand =							(CSScan1 | CSScan2) ? CMD_Dump :
													(CSPathRead) ? CMD_Push :
													(CSPathWriteback) ? CMD_Peak : {CMDWidth{1'bx}};
	
	assign 	CoreCommandValid =						CSPathRead | 
													CSScan1 | 
													// we could also just let the stash loop between idle->dump ...
													(CSScan2 & ~Scan2Complete_Actual) | 
													(CSPathWriteback & OutSTValid);
													
	StashCore	#(			.DataWidth(				DataWidth),
							.StashCapacity(			StashCapacity),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
							
				Core(		.Clock(					Clock), 
							.Reset(					Reset),
							.PerAccessReset(		PerAccessReset),
							.ResetDone(				CoreResetDone),
						
							.InData(				WriteData),
							.InPAddr(				WritePAddr),
							.InLeaf(				WriteLeaf),
							.InValid(				WriteInValid),
							.InReady(				WriteInReady),

							.OutData(				ReadData),
							.OutPAddr(				ReadPAddr),
							.OutLeaf(				ReadLeaf),
							.OutValid(				CoreOutValid),

							.InSAddr(				OutSTAddr),
							.InCommand(				CoreCommand),
							.InCommandValid(		CoreCommandValid),
							.InCommandReady(		CoreCommandReady),
												
							// to scan table
							.OutScanPAddr(			ScanPAddr),
							.OutScanLeaf(			ScanLeaf),
							.OutScanSAddr(			ScanSAddr),
							.OutScanValid(			ScanLeafValid),

							// from scan table
							.InScanSAddr(			ScannedSAddr),
							.InScanAccepted(		ScannedLeafAccepted),
							.InScanValid(			ScannedLeafValid),
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		StashOccupancy),
							
							.PrepNextPeak(			PrepNextPeak),
							.SyncComplete(			Core_AccessComplete));

	StashScanTable #(		.DataWidth(				DataWidth),
							.StashCapacity(			StashCapacity),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ)) 
							
			ScanTable(		.Clock(					Clock),
							.Reset(					Reset),
							.PerAccessReset(		PerAccessReset),
							.ResetDone(				ScanTableResetDone),
							
							.CurrentLeaf(			AccessLeaf),

							// from core
							.InLeaf(				ScanLeaf),
							.InPAddr(				ScanPAddr),
							.InSAddr(				ScanSAddr),
							.InValid(				ScanLeafValid),
			
							// to core
							.OutSAddr(				ScannedSAddr),
							.OutAccepted(			ScannedLeafAccepted),
							.OutValid(				ScannedLeafValid),
						
							// writeback control logic
							.InSTAddr(				BlocksReading),
							.InSTValid(				InSTValid),
							.InSTReset(				PathWriteback_Tick),
							.OutSTAddr(				OutSTAddr),
							.OutSTValid(			OutSTValid));	

	//--------------------------------------------------------------------------
	//	Scan control
	//--------------------------------------------------------------------------

	// count the worst-case scan latency (for security)
	Counter		#(			.Width(					SCWidth))
				ScanCounter(.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSScan1 | CSScan2),
							.In(					{SCWidth{1'bx}}),
							.Count(					ScanCount));
	
	// marks when we _actually_ finish the scan (must be < worse-case time)
	Register	#(			.Width(					1))
				DumpStage(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					CSScan2 & CoreCommandReady),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					Scan2Complete_Actual));
	
	assign	Scan2Complete_Conservative =			CSScan2 & ScanCount == ScanDelay;
	
	//--------------------------------------------------------------------------
	//	Read interface
	//--------------------------------------------------------------------------
	
	assign	PathWriteback_Tick =					CSPathWriteback & PrepNextPeak;
	assign	StillReadingPath = 						BlocksReading != (BlocksOnPath - 1);
	
	// ticks at start of block read
	Counter		#(			.Width(					ScanTableAWidth))
				RdStartCnt(	.Clock(					Clock),
							.Reset(					Reset | PerAccessReset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				PathWriteback_Tick & StillReadingPath),
							.In(					{ScanTableAWidth{1'bx}}),
							.Count(					BlocksReading));

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
							
	assign	InSTValid =								CSPathWriteback & StillReadingPath & ~PathWriteback_Waiting;
	assign	Top_AccessComplete =					BlocksRead == BlocksOnPath;

	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

