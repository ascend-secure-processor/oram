
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
	
    ROPAddr, ROAccess, REWRoundDummy,

	AESDataIn, AESDataInValid, AESDataInReady,
	AESDataOut, AESDataOutValid, AESDataOutReady,
	
	BEDataOut, BEDataOutValid, BEDataOutReady,
	BEDataIn, BEDataInValid, BEDataInReady,	
	);
		
	//--------------------------------------------------------------------------
	//	Parameters & Constants
	//--------------------------------------------------------------------------

    `include "PathORAM.vh";
	`include "DDR3SDRAM.vh";
	`include "AES.vh";
	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 					Clock, Reset;
	input	[ORAMU-1:0]		ROPAddr;
    input					ROAccess, REWRoundDummy;
	
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
    wire HeaderInReady, HeaderInValid, HeaderOutReady, HeaderOutValid, ProcessingHeader;
    wire [DDRDWidth-1:0]	HeaderOut;
    
    // distinguish headers from payloads
    reg  [`log2(BktSize_DRBursts)-1:0] BlkCtr;    
    assign ProcessingHeader = BlkCtr < BktHSize_DRBursts;
    assign HeaderInValid = ROAccess && AESDataInValid && ProcessingHeader;
         
    always @ (posedge Clock) begin
        if (Reset) begin
            BlkCtr <= 0;
        end
        else if (AESDataInValid && AESDataInReady) begin
            BlkCtr <= (BlkCtr + 1) % BktSize_DRBursts;
            if (HeaderInValid && !HeaderInReady) begin
                $display("Error: Header Buffer Overflow!");
                $finish;
            end
        end
    end

    generate if (EnableIV) begin: FULL_BUF
        RAM xxxx(); // Use a RAM
    end 
    else begin: HEAD_BUF
        
        // invalidate bit for the target block       
        wire [DDRDWidth-1:0]	HeaderIn;
        wire [ORAMZ-1:0]        ValidBitsIn, ValidBitsOut;
        
        genvar j;
        for (j = 0; j < ORAMZ; j = j + 1) begin: VALID_BIT
            assign ValidBitsIn[j] = AESDataIn[IVEntropyWidth+j];
            assign ValidBitsOut[j] = (ValidBitsIn[j] && ROAccess && !REWRoundDummy && ROPAddr == AESDataIn[BktHULStart + (j+1)*ORAMU - 1: BktHULStart + j*ORAMU]) ? 0 : ValidBitsIn[j];                  
        end 
             
        assign HeaderIn = {AESDataIn[DDRDWidth-1:IVEntropyWidth+ORAMZ], ValidBitsOut, AESDataIn[IVEntropyWidth-1:0]};
        
        // save the headers and write them back later     
        FIFORAM	#(          .Width(					DDRDWidth),     
                            .Buffering(				(ORAML+1) * BktHSize_DRBursts ))
            in_hd_buf  (	.Clock(					Clock),
                            .Reset(					Reset),
                            .InData(				HeaderIn),
                            .InValid(				HeaderInValid),
                            .InAccept(				HeaderInReady),
                            .OutData(				HeaderOut),
                            .OutSend(				HeaderOutValid),
                            .OutReady(				AESDataOutReady)
                        );     
    end endgenerate
    

	//--------------------------------------------------------------------------
	//	Passthrough logic
	//--------------------------------------------------------------------------

	assign	BEDataOut =					AESDataIn;
	assign	BEDataOutValid =		    AESDataInValid; 
	assign	AESDataInReady = 			BEDataOutReady;

    //--------------------------------------------------------------------------
	//	Path writeback or header write back?
	//--------------------------------------------------------------------------

	assign	AESDataOut =			ROAccess ? HeaderOut : BEDataIn;
	assign	AESDataOutValid =		ROAccess ? HeaderOutValid :	BEDataInValid;
	
    assign	BEDataInReady =         !ROAccess && AESDataOutReady;
	
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
