//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Core/GateCore/Hardware/Sequence/Pulse/PulseExpander.v $
//	Version:	$Revision: 26904 $
//	Author:		Greg Gibeling (http://www.gdgib.com/)
//	Copyright:	Copyright 2003-2010 UC Berkeley
//==============================================================================

//==============================================================================
//	Section:	License
//==============================================================================
//	Copyright (c) 2003-2010, Regents of the University of California
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
//	Module:		PulseExpander
//	Desc:		This module is designed to take a pulse signal in and widen it
//				to the specified number of cycles.  This is very useful in
//				clock crossings and reset generation.
//	Params:		Width:	Sets the width (in cycles) of the output
//				pulse
//------------------------------------------------------------------------------
module	PulseExpander(Clock, Reset, In, Out);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				Width =					2,
							Async =					0,
							AsyncReset =			0;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	localparam				IWidth =				Async ? (Width - 1) : Width,
	`ifdef MACROSAFE
							I1Width =				`max(IWidth, 1);
	`else
							I1Width =				IWidth;
	`endif
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	I/O
	//--------------------------------------------------------------------------
	input					Clock, Reset, In;
	output					Out;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Wires
	//--------------------------------------------------------------------------
	wire	[I1Width-1:0]	Next;
	wire	[I1Width-1:0]	Internal;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Assigns
	//--------------------------------------------------------------------------
	generate if (IWidth > 0) begin:IW0PLUS
		assign	Out =								Internal[IWidth-1] | (Async ? In : 1'b0);
	end else begin:IW0
		assign	Out =								(Async ? In : 1'b0);
	end endgenerate
	
	generate if (IWidth > 1) begin:IW1PLUS
		assign	Next =								{Internal[IWidth-2:0], 1'b0};
	end else begin:IW1
		assign	Next =								1'b0;
	end endgenerate
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Behavioral Shift Register Core
	//--------------------------------------------------------------------------
	generate if (IWidth > 0) begin:SHIFT
		Register	#(			.Width(				I1Width),
								.AsyncReset(		AsyncReset))
					Register(	.Clock(				Clock),
								.Reset(				Reset),
								.Set(				In),
								.Enable(			1'b1),
								.In(				Next),
								.Out(				Internal));
	end endgenerate
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
