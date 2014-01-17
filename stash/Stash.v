
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
//
//	TODO:
//		- override all parameters
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
			// [FRONTEND] Stash -> LLC interface
			//
			
			ReturnData,
			ReturnPAddr,
			ReturnLeaf,
			ReturnDataOutValid,
			ReturnDataOutReady,
			BlockReturnComplete,
			
			//
			// [FRONTEND] LLC -> Stash interface
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
			BlockWriteComplete, // Pulsed during the last cycle that a block is being written [this will be read by albert to tick the next PAddr/Leaf]
			
			//
			// [BACKEND] Stash -> AES encrypt interface (Stash scan and writeback)
			//
			
			ReadData,
			ReadPAddr, // set to 0 for dummy block [ask dave if programs will ever read paddr = 0]
			ReadLeaf,
			ReadOutValid, // redundant given StartReadOperation
			ReadOutReady, // necessary because of unpredictable/public DRAM backpressure 
			BlockReadComplete, // Pulsed during last cycle that a block is being read [TODO not needed by albert?]
			
			//
			// Status interface
			//
			
			StashAlmostFull,
			StashOverflow
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
	output						BlockReadComplete;
	
	//--------------------------------------------------------------------------
	//	Status interface
	//--------------------------------------------------------------------------

	output 						StashAlmostFull;
	output						StashOverflow;

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	
	wire	[DataWidth-1:0]		InData;
	reg							InValid;
	wire						InReady;

	wire	[ORAMU-1:0]			ScanPAddr;
	wire	[ORAML-1:0]			ScanLeaf;
	wire	[StashEAWidth-1:0]	ScanSAddr;
	wire						ScanLeafValid;

	wire	[StashEAWidth-1:0]	ScannedSAddr;
	wire						ScannedLeafAccepted, ScannedLeafValid;
	
	reg		[STWidth-1:0]		CS, NS;
	wire						CSPathRead, CSPathWriteback, CSScan1, CSScan2;
	
	wire	[SCWidth-1:0]		ScanCount;
	wire						Scan2Complete_Actual, Scan2Complete_Conservative;
		
	wire						WritebackDone;
	
	wire						CoreResetDone;
	wire	[CMDWidth-1:0]		CoreCommand;
	wire						CoreCommandValid, CoreCommandReady, CoreOutValid;

	wire	[ScanTableAWidth-1:0]InSTAddr;
	wire	[StashEAWidth-1:0]	OutSTAddr;	
	wire						InSTValid, OutSTValid;

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
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	State transitions & control logic
	//--------------------------------------------------------------------------

	assign	ResetDone =								CoreResetDone;

	assign	BlockWriteComplete =					CSPathRead & CoreCommandReady;
	assign	BlockReadComplete =						CSPathWriteback & CoreCommandReady;
	
	assign	ReadOutValid =							CSPathWriteback & CoreOutValid;
	
	assign	CSPathRead = 							CS == ST_PathRead; 
	assign	CSPathWriteback = 						CS == ST_PathWriteback; 
	assign	CSScan1 = 								CS == ST_Scan1; 
	assign	CSScan2 = 								CS == ST_Scan2;
	
	always @(posedge Clock) begin
		if (Reset) CS <= 							ST_Reset;
		else CS <= 									NS;
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
				if (Scan2Complete_Conservative) NS =ST_PathWriteback;
			ST_PathWriteback :
				if (WritebackDone) NS =				ST_Idle;
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
													(CSScan2 & ~Scan2Complete_Actual) | 
													(CSPathWriteback & OutSTValid);
													
	StashCore	
			Core(			.Clock(					Clock), 
							.Reset(					Reset),
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
							.InScanValid(			ScannedLeafValid));

	StashScanTable 
			ScanTable(		.Clock(					Clock),
							.Reset(					Reset),

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
							.InSTAddr(				InSTAddr),
							.InSTValid(				InSTValid),
							.OutSTAddr(				OutSTAddr),
							.OutSTValid(			OutSTValid));	

	//--------------------------------------------------------------------------
	//	Scan control
	//--------------------------------------------------------------------------

	Counter		#(			.Width(					SCWidth))
				ScanCounter(.Clock(					Clock),
							.Reset(					Reset | Scan2Complete_Conservative),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSScan1 | CSScan2),
							.In(					{SCWidth{1'bx}}),
							.Count(					ScanCount));
	
	Register	#(			.Width(					1))
				DumpStage(	.Clock(					Clock),
							.Reset(					Reset | Scan2Complete_Conservative),
							.Set(					CSScan2 & CoreCommandReady),
							.Enable(				1'b0),
							.In(					1'bx),
							.Out(					Scan2Complete_Actual));
	
	assign	Scan2Complete_Conservative =			CSScan2 & ScanCount == ScanDelay;
	
	//--------------------------------------------------------------------------
	//	Read interface
	//--------------------------------------------------------------------------

	Counter		#(			.Width(					ScanTableAWidth))
			RdCounter(		.Clock(					Clock),
							.Reset(					Reset | ~CSPathWriteback),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				CSPathWriteback & CoreCommandReady),
							.In(					{ScanTableAWidth{1'bx}}),
							.Count(					InSTAddr));

	assign	InSTValid =								CSPathWriteback;
	assign	WritebackDone =							InSTAddr == BlocksOnPath;
						
	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

