//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Core/GateCore/Hardware/Counting/UDCounter.v $
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
//	Module:		UDCounter
//	Desc:		This is an up/down counter with an option to be hard limited at
//				the max/min values.
//	Params:		Width:		Sets the bitwidth of the counter
//				Limited:	Should the counter saturate?
//	Ex:			(8,1)		creates an 8-bit saturating counter
//				(32,1) creates a 32-bit saturating counter
//				(4,0) creates a 4-bit rollover counter
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//	Version:	$Revision: 26904 $
//------------------------------------------------------------------------------
module	UDCounter(Clock, Reset, Set, Load, Up, Down, In, Count);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				Width = 				32,
							Limited =				0,
							Initial =				{Width{1'b0}},
							AsyncReset =			0,
							AsyncSet =				0,
							ResetValue =			{Width{1'b0}},
							SetValue =				{Width{1'b1}};
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	I/O
	//--------------------------------------------------------------------------
	input					Clock, Reset, Set, Load;
	input					Up, Down;
	input	[Width-1:0]		In;
	output	[Width-1:0]		Count;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Wires
	//--------------------------------------------------------------------------
	wire					NoLimit;
	wire	[Width-1:0]		NextCount;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Assigns
	//--------------------------------------------------------------------------
	assign	NoLimit =								!Limited;
	assign	NextCount =								(Up) ? (Count + 1) : (Count - 1);
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Behavioral Up/Down Counter (With Set/Reset and Limiting)
	//--------------------------------------------------------------------------
	Register		#(			.Width(				Width),
								.Initial(			Initial),
								.AsyncReset(		AsyncReset),
								.AsyncSet(			AsyncSet),
								.ResetValue(		ResetValue),
								.SetValue(			SetValue))
					Register(	.Clock(				Clock),
								.Reset(				Reset),
								.Set(				Set),
								.Enable(			Load | ((Up ^ Down) & (Up ? (NoLimit | ~&Count) : (NoLimit | (|Count))))),
								.In(				Load ? In : NextCount),
								.Out(				Count));
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
