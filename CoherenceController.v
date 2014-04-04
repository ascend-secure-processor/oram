
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		CoherenceController
//	Desc:		Create a coherent view of data in ORAM tree to backend & 
//				integrity verification.  Notation: REW accesses = RO, H, R, W
//
//				Schedule: [ R W (backend only) {E{RO H}} W (write to memory) ] repeat
//
//				Summary of jobs:
//
//				1 - R access:
//					- Store the path read during the access.  This path will be periodically read by IV unit to check R hashes.
//				2 - BACKEND completes W access:
//					- Store plaintext bits that will be written back.  These bits will be periodically read by the IV unit to re-create W hashes.
//					- IV unit will send new hashes back to CoherenceController, which will insert them in proper locations
//				3 - RO access: [coherence step]
//					- For each RO bucket received from AES (decrypted in certain cases), compare that bucket to the set of buckets stored from step 2.  For each aliasing bucket, forward W data to BE/IV unit.
//					- Invariant: all data forwarded to IV/BE must be freshest copy of the data.
//					- Store decrypted header sent from AES (after being coherence checked) internally.
//					- Send IV the bucket of interest to be hashed; send rest to BE
//					- When IV returns hash, merge hash & any modified valid bits back into W path and headers (stored internally) if the bucket of interest had a collision
//				4 - H access: 
//					- Push updated headers back to AES
//				5 - W access (writes to external memory)
//					- Push the fully up to date W path (stored internally and coherent) back to memory
//==============================================================================
module CoherenceController(
	Clock, Reset,

	AESDataIn, AESDataInValid, AESDataInReady,
	AESDataOut, AESDataOutValid, AESDataOutReady,
	
	IVRODataOut, IVRODataRequest, IVRODataOutValid,
	IVRODataIn, IVRODataInValid, IVRODataInReady,
	
	IVRDataOut, IVRDataRequest, IVRDataOutValid,
	IVWDataOut, IVWDataRequest, IVWDataOutValid,

	IVWDataIn, IVWDataInValid, IVWDataInReady,	
	
	BEDataOut, BEDataOutValid, BEDataOutReady,
	BEDataIn, BEDataInValid, BEDataInReady,	
	);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

	`include "DDR3SDRAM.vh";
	
	`include "DDR3SDRAMLocal.vh"
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	
	//--------------------------------------------------------------------------
	//	AES Interface
	//--------------------------------------------------------------------------
	
	// All read path data from AES
	input	[DDRDWidth-1:0]	AESDataIn;
	input					AESDataInValid;
	output					AESDataInReady;
	
	// All writeback path data to AES
	output	[DDRDWidth-1:0]	AESDataOut;
	output					AESDataOutValid;
	input					AESDataOutReady;
	
	//--------------------------------------------------------------------------
	//	Integrity Interface
	//--------------------------------------------------------------------------

	// RO accesses
	
	// Send bucket of interest (including decrypted hash) to IV on a RO access
	output	[DDRDWidth-1:0]	IVRODataOut;
	input					IVRODataRequest;
	output					IVRODataOutValid;
	
	// Receive the new hash for the RO bucket of interest
	input	[DDRDWidth-1:0]	IVRODataIn;
	input					IVRODataInValid;
	output					IVRODataInReady;
	
	// RW (Gentry background accesses)
	
	// Send read path data (along with decrypted hashes) to IV
	output	[DDRDWidth-1:0]	IVRDataOut;
	input					IVRDataRequest;
	output					IVRDataOutValid;
	
	// Send write path data (with no hashes) to IV
	output	[DDRDWidth-1:0]	IVWDataOut;
	input					IVWDataRequest;
	output					IVWDataOutValid;

	// Receive the new hash for the RO bucket of interest
	input	[DDRDWidth-1:0]	IVWDataIn;
	input					IVWDataInValid;
	output					IVWDataInReady;
	
	//--------------------------------------------------------------------------
	//	Backend Interface
	//--------------------------------------------------------------------------

	// Writeback data
	input	[DDRDWidth-1:0]	BEDataIn;
	input					BEDataInValid;
	output					BEDataInReady;
	
	// Read data
	output	[DDRDWidth-1:0]	BEDataOut;
	output					BEDataOutValid;
	input					BEDataOutReady;	
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 

	//--------------------------------------------------------------------------
	//	Passthrough logic
	//--------------------------------------------------------------------------

	assign	BEDataOut =								AESDataIn;
	assign	BEDataOutValid =						AESDataInValid; 
	assign	AESDataInReady = 						BEDataOutReady;

	assign	AESDataOut =							BEDataIn;
	assign	AESDataOutValid =						BEDataInValid;
	assign	BEDataInReady = 						AESDataOutReady;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
