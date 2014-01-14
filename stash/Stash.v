
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.v"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		Stash
//	Desc:		The Path ORAM stash.
//
//	Interface specification:
//	
//	- 	Command interface: Before sending read requests to external memory, 
//		place current leaf and current request program address on command 
//		interface.  The Stash WILL NOT be ready to receive decrypted data until 
//		the command interface asserts CommandInReady
//
//	- Leaf orientation: least significant bit is root bucket
//
//	TODO:
//		- inclusive stash
//		- override all parameters
//
//
//------------------------------------------------------------------------------
module Stash(
			Clock, 
			Reset,

			// todo MAKE STASH INTERFACE 128

			// Commands for current access
			
			AccessLeaf,
			AccessPAddr,
			AccessIsDummy,
			
			// Data returned to LLC
			
			ReturnData,
			ReturnPAddr,
			ReturnLeaf,
			ReturnDataOutValid,
			ReturnDataOutReady,
			BlockReturnComplete,
			
			StartReadOperation, // start dumping data to AES encrypt

			// Write block to stash (LLC eviction or path "read")
			
			WriteData,
			WriteInValid,
			WriteInReady, /// TODO will this ever go low? GET RID OF THIS

			WritePAddr,
			WriteLeaf,
			BlockWriteComplete, // output, will be read by albert to tick the next PAddr/Leaf
			
			// Read blocks from stash (stash scan)
			
			ReadData,
			ReadPAddr, // set to 0 for dummy block [ask dave if programs will ever read paddr = 0]
			ReadLeaf,
			ReadOutValid, // redundant given StartReadOperation
			ReadOutReady, // necessary because of DRAM 
			BlockReadComplete, // TODO GET RID OF THIS SIGNAL
			
			// Status outputs
			
			StashAlmostFull,
			StashOverflow
		);
		
	//--------------------------------------------------------------------------
	//	Parameters & constants
	//--------------------------------------------------------------------------
					
	`include "StashCore.constants"

	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset; 

	//--------------------------------------------------------------------------
	//	Per access commands
	//--------------------------------------------------------------------------
			
	input	[ORAML-1:0]		AccessLeaf;
	input	[ORAMU-1:0]		AccessPAddr;
	input					AccessIsDummy;
		
	//--------------------------------------------------------------------------
	//	Data return interface (ORAM controller -> LLC)
	//--------------------------------------------------------------------------
	
	output	[DataWidth-1:0]	ReturnData;
	output	[ORAMU-1:0]		ReturnPAddr;
	output	[ORAML-1:0]		ReturnLeaf;
	output					ReturnDataOutValid;
	input					ReturnDataOutReady;	
	output					BlockReturnComplete;
	
	//--------------------------------------------------------------------------
	//	ORAM write interface (external memory -> Decryption -> stash)
	//--------------------------------------------------------------------------

	input	[DataWidth-1:0]	WriteData;
	input	[ORAMU-1:0]		WritePAddr;
	input	[LeafWidth-1:0]	WriteLeaf;
	input					WriteInValid;
	output					WriteInReady;	
	output					BlockWriteComplete;
	
	//--------------------------------------------------------------------------
	//	ORAM read interface (stash -> encryption -> external memory)
	//--------------------------------------------------------------------------

	output	[DataWidth-1:0]	ReadData;
	output	[ORAMU-1:0]		ReadPAddr;
	output	[LeafWidth-1:0]	ReadLeaf;
	output					ReadOutValid;
	input					ReadOutReady;	
	output					BlockReadComplete;
	
	//--------------------------------------------------------------------------
	//	Status interface
	//--------------------------------------------------------------------------

	output 					StashAlmostFull;
	output					StashOverflow;

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	wire 						Clock;
	reg							Reset; 
	
	wire	[DataWidth-1:0]		InData;
	reg							InValid;
	wire						InReady;

	wire	[ORAMU-1:0]			ScanPAddr;
	wire	[ORAML-1:0]			ScanLeaf;
	wire	[StashEAWidth-1:0]	ScanSAddr;
	wire						ScanLeafValid;

	wire	[StashEAWidth-1:0]	ScannedSAddr;
	wire						ScannedLeafAccepted, ScannedLeafValid;
	
	//--------------------------------------------------------------------------
	//	Inner modules
	//--------------------------------------------------------------------------
	
	input	[DataWidth-1:0]	WriteData;
	input	[ORAMU-1:0]		WritePAddr;
	input	[LeafWidth-1:0]	WriteLeaf;
	input					WriteInValid;
	output					WriteInReady;	
	output					BlockWriteComplete;	
	
	.InCommand(			Command),
						.InCommandValid(	CommandValid),
						.InCommandReady(	CommandReady),

	
	
	StashCore	
			Core(		.Clock(				Clock), 
						.Reset(				Reset),

						.InData(			WriteData),
						.InValid(			WriteInValid),
						.InReady(			WriteInReady),

						.InPAddr(			WritePAddr),
						.InLeaf(			WriteLeaf),
						.InSAddr(			),
						.InCommand(			Command),
						.InCommandValid(	CommandValid),
						.InCommandReady(	CommandReady),

						.OutData(			),
						.OutValid(			OutValid),

						.OutScanPAddr(		ScanPAddr),
						.OutScanLeaf(		ScanLeaf),
						.OutScanSAddr(		ScanSAddr),
						.OutScanValid(		ScanLeafValid),

						.InScanSAddr(		ScannedSAddr),
						.InScanAccepted(	ScannedLeafAccepted),
						.InScanValid(		ScannedLeafValid));

	StashScanTable 
			ScanTable(	.Clock(				Clock),
						.Reset(				Reset),

						.CurrentLeaf(		AccessLeaf),

						.InLeaf(			ScanLeaf),
						.InPAddr(			ScanPAddr),
						.InSAddr(			ScanSAddr),
						.InValid(			ScanLeafValid),
			
						.OutSAddr(			ScannedSAddr),
						.OutAccepted(		ScannedLeafAccepted),
						.OutValid(			ScannedLeafValid));	
	
	//--------------------------------------------------------------------------
	//	Debug interface
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Input gates
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Output gates
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	State transitions
	//--------------------------------------------------------------------------
	

	//--------------------------------------------------------------------------	
endmodule
//--------------------------------------------------------------------------

