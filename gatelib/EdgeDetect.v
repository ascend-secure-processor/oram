//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Core/GateCore/Hardware/Sequence/EdgeDetect.v $
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

//------------------------------------------------------------------------------
//	Module:		EdgeDetect
//	Desc:		A simple parameterized, shift-register based edge detector.
//				Note this module is fully moore-tyle, the output is isolated
//				from the input by a single flip-flop.
//	Params:		Width:		The number of previous samples of the input signal
//							to examine.  Also the width of the internal shift
//							register.
//				UpWidth:	The number of consecutive high samples which must
//							appear before the edge is signaled (assuming
//							posedge detection).
//				Type:	number	type
//						0	posedge
//						1	negedge
//						2	both
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//	Version:	$Revision: 26904 $
//------------------------------------------------------------------------------
module EdgeDetect(Clock, Reset, Enable, In, Out);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				Width = 				3,
							UpWidth = 				2,
							Type =					0,
							AsyncReset =			0,
							AsyncInput =			0;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	I/O
	//--------------------------------------------------------------------------
	input					Clock, Reset, Enable;
	input					In;
	output reg				Out;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	wire	[Width-1:0]		Q;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Output Decoder
	//--------------------------------------------------------------------------
	always @ (Q) begin
		case (Type)
			0:	Out =								(~|Q[Width-1:UpWidth]) & (&Q[UpWidth-1:0]);
			1:	Out =								(&Q[Width-1:UpWidth]) & (~|Q[UpWidth-1:0]);
			2:	Out =								((~|Q[Width-1:UpWidth]) | (&Q[Width-1:UpWidth])) & ((~|Q[UpWidth-1:0]) | (&Q[UpWidth-1:0])) & (Q[Width-1] ^ Q[UpWidth-1]);
			default: Out =							1'bx;
		endcase
	end
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Shift Register
	//--------------------------------------------------------------------------
	generate if (AsyncInput) begin:ASYNCIN
		ShiftRegister #(		.PWidth(			Width - 1),
								.SWidth(			1),
								.AsyncReset(		AsyncReset))
					ShftReg(	.Clock(				Clock),
								.Reset(				Reset),
								.Load(				1'b0),
								.Enable(			Enable),
								.PIn(				{Width-1{1'bx}}),
								.SIn(				In),
								.POut(				Q[Width-1:1]),
								.SOut(				/* Unconnected */));
		assign	Q[0] =								In;
	end else begin:SYNCIN
		ShiftRegister #(		.PWidth(			Width),
								.SWidth(			1),
								.AsyncReset(		AsyncReset))
					ShftReg(	.Clock(				Clock),
								.Reset(				Reset),
								.Load(				1'b0),
								.Enable(			Enable),
								.PIn(				{Width{1'bx}}),
								.SIn(				In),
								.POut(				Q),
								.SOut(				/* Unconnected */));
	end endgenerate
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
