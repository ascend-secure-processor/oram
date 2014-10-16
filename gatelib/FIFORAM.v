//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Gateware/FIFOs/Hardware/Buffer/FIFORAM.v $
//	Version:	$Revision: 27065 $
//	Author:		Greg Gibeling (http://www.gdgib.com/)
//				Chris Fletcher (http://cwfletcher.net)
//	Copyright:	Copyright 2005-2010 UC Berkeley
//==============================================================================

//==============================================================================
//	Section:	License
//==============================================================================
//	Copyright (c) 2005-2010, Regents of the University of California
//	All rights reserved.
//
//	Redistribution and use in source and binary forms, with or without modification,
//	are permitted provided that the following conditions are met:
//
//		- Redistributions of source code must retain the above copyright notice,
//			this list of conditions and the following disclaimer.
//		- Redistributions in binary form must reproduce the above copyright
//			notice, this list of conditions and the following disclaimer
//			in the documentation and/or other materials provided with the
//			distribution.
//		- Neither the name of the University of California, Berkeley nor the
//			names of its contributors may be used to endorse or promote
//			products derived from this software without specific prior
//			written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//	ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//	ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//==============================================================================

//==============================================================================
//	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		FIFORAM
//	Desc:		A class1 or class2 FIFO implementation based on a circular
//				buffer stored in dual port RAM.  This module provides full
//				timing parameters (RDL channel CBFC<Width, FWLatency, Buffering,
//				BWLatency>).  It will be class1 iff FWLatency > 0 and
//				BWLatency > 0.
//
//				NOTE: 	this version has Rdlatency == 1 so that the tools can
//						infer BRAM.  To lazily get things to work, we make the
//						effective FWLatency' = FWLatency + 1
//
//	Params:		Width:	The width of the data through this FIFO.
//				FWLatency: Forward latency of data.
//				Buffering: The number of data items which can be buffered.
//				BWLatency: Backward latency of empties.
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//				<a href="http://www.cwfletcher.net/">Chris Fletcher</a>
//	Version:	$Revision: 27065 $
//------------------------------------------------------------------------------
module	FIFORAM(
			//------------------------------------------------------------------
			//	System I/O
			//------------------------------------------------------------------
			Clock,
			Reset,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Input Interface
			//------------------------------------------------------------------
			InData,
			InValid,
			InAccept,								// May actually be InReady, depending on the BWLatency parameter
			InEmptyCount,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Output Interface
			//------------------------------------------------------------------
			OutData,
			OutSend,								// May actually be OutValid, depending on the FWLatency parameter
			OutReady,
			OutFullCount
			//------------------------------------------------------------------
	);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				Width =					32,
							FWLatency =				1,
							Buffering =				16,
							BWLatency =				1;
	
	parameter				SRAM =					0;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	`ifdef MACROSAFE
	localparam				AWidth =				`max(`log2(Buffering), 1),
							CWidth =				`log2(Buffering + 1);
	`endif
	
	`ifdef SIMULATION
	initial begin
		if (FWLatency < 1) begin
			$display("ERROR: this version of FIFORAM needs some read latency to infer block RAM.");
			$finish;
		end
	end
	`endif
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
	input					Clock, Reset;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Input Interface
	//--------------------------------------------------------------------------
	input	[Width-1:0]		InData;					// Transfered when Valid & Ready are both asserted
	input					InValid;
	output					InAccept;				// Must not be a function of InValid, may actually be InReady, depending on the BWLatency parameter
	output	[CWidth-1:0]	InEmptyCount;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Output Interface
	//--------------------------------------------------------------------------
	output	[Width-1:0]		OutData;				// Transfered when Valid & Ready are both asserted
	output					OutSend;				// Must not be a function of OutReady, may actually be OutValid, depending on the FWLatency parameter
	input					OutReady;
	output	[CWidth-1:0]	OutFullCount;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Wires
	//--------------------------------------------------------------------------
	wire					InWrite, OutRead, OutGate;
	wire	[AWidth-1:0]	InWriteAddress, OutReadAddress;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	FIFO Controller
	//--------------------------------------------------------------------------
	FIFOControl		#(			.Asynchronous(		0),
								.FWLatency(			FWLatency + 1),
								.Buffering(			Buffering),
								.BWLatency(			BWLatency))
					Control(	.Clock(				Clock),
								.Reset(				Reset),
								
								.InClock(			),
								.InReset(			),
								.InValid(			InValid),
								.InAccept(			InAccept),
								.InWrite(			InWrite),
								.InGate(			),
								.InWriteAddress(	InWriteAddress),
								.InReadAddress(		),
								.InEmptyCount(		InEmptyCount),
								
								.OutClock(			),
								.OutReset(			),
								.OutSend(			OutSend),
								.OutReady(			OutReady),
								.OutRead(			OutRead),
								.OutGate(			OutGate),
								.OutReadAddress(	OutReadAddress),
								.OutWriteAddress(	),
								.OutFullCount(		OutFullCount));
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	RAM
	//--------------------------------------------------------------------------
	SDPRAM			 #(			.DWidth(			Width),
								.AWidth(			AWidth),
								.RLatency(			1),
								.WLatency(			1)
								`ifndef FPGA_MEMORY , .SRAM(SRAM) `endif)
					RAM(		.Clock(				Clock),
								.Reset(				Reset),
								.Write(				InWrite),								
								.WriteAddress(		InWriteAddress),
								.WriteData(			InData),
								.Read(				1'b1),
								.ReadAddress(		OutReadAddress), 
								.ReadData(			OutData));
	//--------------------------------------------------------------------------
endmodule	
//------------------------------------------------------------------------------
