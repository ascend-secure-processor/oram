//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Gateware/FIFOs/Hardware/Shift/FIFOShiftRound.v $
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

//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		FIFOShiftRound
//	Desc:		A shift register with class1 or class2 FIFO interfaces for both
//				parallel and serial data.  This module is designed for skew
//				conversion on FIFO connections.
//				
//				Note that this module does not perform complete realignment.
//				In particular if IWidth%OWidth!=0 and OWidth%IWidth!=0 then the
//				module will drop some of the input bits.  For example it can
//				convert 32b to 8b or 8b to 32b both without loss, but if asked
//				to go from 32b to 9b, it will unpack 3 9b values from the 32b
//				word and throw out the remaining 5b.  See FIFOShiftFixedExact
//				for a module which does lossless conversions. 
//
//				This module is basically a way to convert from a narrow FIFO
//				interface to a wide one and vice versa.  It supports any width
//				of input and output, and has parameters to control its behavior
//				with respect to alignment and excess bits.
//				
//	Params:		IWidth:	Sets the bitwidth of the input.
//				OWidth:	Sets the bitwidth of the output.
//				Reverse:Shift MSb to LSb instead of the normal LSb to MSb
//				Bottom:	If (Max(IWidth,OWidth) % Min(IWidth,OWitdh)) != 0, use
//						the least significant bits of the big bus (whether in
//						or out)
//				Class1:	Should this implementation be class1?
//				Variable: Determine whether the repeat count can be varied
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//	Version:	$Revision: 27065 $
//------------------------------------------------------------------------------
module	FIFOShiftRound(
			//------------------------------------------------------------------
			//	System I/O
			//------------------------------------------------------------------
			Clock,
			Reset,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Control & Status
			//------------------------------------------------------------------
			RepeatLimit,
			RepeatMin,
			RepeatPreMax,
			RepeatMax,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Input Interface
			//------------------------------------------------------------------
			InData,
			InValid,
			InAccept,								// May actually be InReady, depending on the Class1 parameter
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
	parameter				IWidth =				8,	// Input width
							OWidth =				32,	// Output width
							Reverse =				0,
							Bottom =				0,
							Class1 =				0,
							Variable =				0,
							Register =				0;	// Put a FIFO register between the input and output when their widths are equal 
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	localparam				BWidth =				`max(IWidth, OWidth),	// The big width
							SWidth =				`min(IWidth, OWidth),	// The small width
							Max =					`divceil(BWidth, SWidth),
							RWidth =				`log2(Max+1),
							PWidth =				Max * SWidth,
							CWidth =				`log2(Max + 1);
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
	input					Clock, Reset;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Control & Status
	//--------------------------------------------------------------------------
	input	[RWidth-1:0]	RepeatLimit;
	output					RepeatMin, RepeatPreMax, RepeatMax;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Input Interface
	//--------------------------------------------------------------------------
	input	[IWidth-1:0]	InData;					// Transfered when Valid & Ready are both asserted
	input					InValid;
	output					InAccept;				// Must not be a function of InValid, may actually be InReady, depending on the Class1 parameter
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Output Interface
	//--------------------------------------------------------------------------
	output	[OWidth-1:0]	OutData;				// Transfered when Valid & Ready are both asserted
	output					OutValid;				// Must not be a function of OutReady
	input					OutReady;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Wires
	//--------------------------------------------------------------------------
	wire	[CWidth-1:0]	RepeatCount;
	wire					RepeatCountReset, RepeatCountEnable;
	
	wire	[PWidth-1:0]	Parallel;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Conditional Logic Generation
	//--------------------------------------------------------------------------
	generate if (IWidth == OWidth) begin:SAME
		if (Register) begin:REGISTER
			FIFORegister #(		.Width(				IWidth),
								.FWLatency(			1),
								.BWLatency(			Class1))
					Pass(		.Clock(				Clock),
								.Reset(				Reset),
								.InData(			InData),
								.InValid(			InValid),
								.InAccept(			InAccept),
								.OutData(			OutData),
								.OutSend(			OutValid),
								.OutReady(			OutReady));
		end else begin:PASSTHROUGH
			assign	OutData =						InData;
			assign	OutValid =						InValid;
			assign	InAccept =						OutReady;
		end
	end else if (IWidth > OWidth) begin:DOWN
		assign	InAccept =							RepeatMax | ((Class1 ? 1'b0 : 1'b1) & OutReady & RepeatPreMax);
		assign	OutValid =							~RepeatMax;
		assign	RepeatCountReset =					InValid & InAccept;
		assign	RepeatCountEnable =					OutValid & OutReady;
		
		if (IWidth < PWidth) begin:PAR_C
			assign	Parallel =						Bottom ? {{(PWidth-IWidth){1'bx}}, InData} : {InData, {(PWidth-IWidth){1'bx}}};
		end else begin:PAR_S
			assign	Parallel =						InData;
		end
	
		ShiftRegister #(		.PWidth(			PWidth),
								.SWidth(			SWidth),
								.Reverse(			Reverse))
					Shift(		.Clock(				Clock),
								.Reset(				1'b0),
								.Load(				InAccept),
								.Enable(			OutReady),
								.PIn(				Parallel),
								.SIn(				{SWidth{1'bx}}),
								.POut(				/* Unconnected */),
								.SOut(				OutData));
								
		Counter 	#(			.Width(				CWidth),
								.Initial(			{CWidth{1'b1}})) // The initial state should be OutValid = 0
					Cnt(		.Clock(				Clock),
								.Reset(				1'b0),
								.Set(				Reset),
								.Load(				RepeatCountReset),
								.Enable(			RepeatCountEnable),
								.In(				{CWidth{1'b0}}),
								.Count(				RepeatCount));
	end else begin:UP
		assign	InAccept =							~RepeatMax | ((Class1 ? 1'b0 : 1'b1) & OutReady & RepeatMax);
		assign	OutValid =							RepeatMax;
		assign	RepeatCountReset =					OutValid & OutReady;
		assign	RepeatCountEnable =					InValid & InAccept;
		
		if (OWidth < PWidth) begin:PAR_C
			assign	OutData =						Bottom ? Parallel[OWidth-1:0] : Parallel[PWidth-1:PWidth-OWidth];
		end else begin:PAR_S
			assign	OutData =						Parallel;
		end
	
		ShiftRegister #(		.PWidth(			PWidth),
								.SWidth(			SWidth),
								.Reverse(			Reverse))
					Shift(		.Clock(				Clock),
								.Reset(				1'b0),
								.Load(				1'b0),
								.Enable(			InValid & InAccept),
								.PIn(				{PWidth{1'bx}}),
								.SIn(				InData),
								.POut(				Parallel),
								.SOut(				/* Unconnected */));
		
		Counter 	#(			.Width(				CWidth))
					Cnt(		.Clock(				Clock),
								.Reset(				(RepeatCountReset & ~RepeatCountEnable) | Reset),
								.Set(				1'b0),
								.Load(				RepeatCountReset & RepeatCountEnable),
								.Enable(			RepeatCountEnable),
								.In(				{{CWidth-1{1'b0}}, 1'b1}),
								.Count(				RepeatCount));
	end endgenerate
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Count Comparsion
	//--------------------------------------------------------------------------
	generate if (IWidth == OWidth) begin:SAMELIMITS
		assign	RepeatMin =							1'b1;
		assign	RepeatPreMax =						1'b1;
		assign	RepeatMax =							1'b1;
	end else begin:DIFFLIMITS
		if (Variable) begin:VARIABLE
			assign	RepeatMax =						RepeatCount == RepeatLimit;
			assign	RepeatPreMax =					RepeatCount == (RepeatLimit - 32'd1);
		end else begin:FIXED
			CountCompare #(		.Width(				CWidth),
								.Compare(			Max))
					Cmp(		.Count(				RepeatCount),
								.TerminalCount(		RepeatMax));
			assign	RepeatPreMax =					RepeatCount == (Max - 32'd1);
		end
		
		assign	RepeatMin =							~|RepeatCount;
	end endgenerate
	//--------------------------------------------------------------------------
endmodule	
//------------------------------------------------------------------------------
