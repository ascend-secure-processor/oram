//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Gateware/FIFOs/Hardware/Buffer/FIFOLinear.v $
//	Version:	$Revision: 27065 $
//	Author:		Greg Gibeling (http://www.gdgib.com)
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

//------------------------------------------------------------------------------
//	Module:		FIFOLinear
//	Desc:		A class1 or class2 FIFO implementation which is Depth deep,
//				built out of individual registers.  Has Depth cycle forward
//				latency, Depth fragments of buffering, and zero
//				(class2) or Depth/Divisor (class1) cycle backwards latency
//				(RDL channel CBFC<Width, Depth, Depth, Depth/Divisor>)
//	Params:		Width:	The width of the data through this FIFO.
//				Depth:	The number of elements to build this FIFO from.
//				Divisor:The number of stages between class1 FIFO register
//						elements.  1 to make all elements class1, and Depth+1
//						to make them all class2.
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//	Version:	$Revision: 27065 $
//------------------------------------------------------------------------------
module	FIFOLinear(
			//------------------------------------------------------------------
			//	Clock & Reset Inputs
			//------------------------------------------------------------------
			Clock,
			Reset,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Input Interface
			//------------------------------------------------------------------
			InData,
			InValid,
			InAccept,								// May actually be InReady, depending on the Divisor parameter
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Output Interface
			//------------------------------------------------------------------
			OutData,
			OutValid,
			OutReady
			//------------------------------------------------------------------
	);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				Width =					32,
							Depth =					1,
							Divisor =				1;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Clock & Reset Inputs
	//--------------------------------------------------------------------------
	input					Clock, Reset;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Input Interface
	//--------------------------------------------------------------------------
	input	[Width-1:0]		InData;					// Transfered when Valid & Ready are both asserted
	input					InValid;
	output					InAccept;				// Must not be a function of InValid, may actually be InReady, depending on the Class1 parameter
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Output Interface
	//--------------------------------------------------------------------------
	output	[Width-1:0]		OutData;				// Transfered when Valid & Ready are both asserted
	output 					OutValid;				// Must not be a function of OutReady
	input					OutReady;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Wires
	//--------------------------------------------------------------------------
	genvar					i;
	wire	[Width-1:0]		Data[Depth:0];
	wire					Valid[Depth:0];
	wire					Accept[Depth:0];
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Assigns
	//--------------------------------------------------------------------------
	assign	Data[0] =								InData;
	assign	Valid[0] =								InValid;
	assign	InAccept =								Accept[0];
	
	assign	OutData =								Data[Depth];
	assign	OutValid =								Valid[Depth];
	assign	Accept[Depth] =							OutReady;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	FIFO Stages
	//--------------------------------------------------------------------------
	generate for (i = 0; i < Depth; i = i + 1) begin:STAGE
		FIFORegister #(			.Width(				Width),
								.FWLatency(			1),
								.BWLatency(			((i + 1) % Divisor) == 0))	// Use i+1 to ensure that Divisor = Depth+1 means all elements are class2.
					Element(	.Clock(				Clock),
								.Reset(				Reset),
								.InData(			Data[i]),
								.InValid(			Valid[i]),
								.InAccept(			Accept[i]),
								.OutData(			Data[i+1]),
								.OutSend(			Valid[i+1]),
								.OutReady(			Accept[i+1]));
	end endgenerate
	//--------------------------------------------------------------------------
endmodule	
//------------------------------------------------------------------------------