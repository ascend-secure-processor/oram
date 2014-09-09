//==============================================================================
//	File:		$URL$
//	Version:	$Revision$
//	Author:		Chris Fletcher (http://cwfletcher.net)
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
//	Module:		CountAlarm
//	Desc:		Wrapper around Counter+CountCompare, which we use all over the 
//				place.  This module saves us from defining CWidth/Internal 
//				counters.
//
//	TODO:		Make the number of Intermediate signals _parameterizable_
//				(maybe I'll do this when I see we need more than 1 ...)
//------------------------------------------------------------------------------
module	CountAlarm(Clock, Reset, Enable, Intermediate, Done, Count);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------

	parameter				Threshold =				16,
							IThreshold =			0,
							Initial =				1'b0;
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------

	localparam				CWidth =				`log2(Threshold);
		
	//--------------------------------------------------------------------------
	//	System Inputs
	//--------------------------------------------------------------------------
	
	input					Clock;
	input					Reset;

	//--------------------------------------------------------------------------
	//	User ports
	//--------------------------------------------------------------------------

	input					Enable;
	output					Intermediate, Done;
	
	output	[CWidth-1:0]	Count;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------

	wire					Alarm_Pre;
	
	//--------------------------------------------------------------------------
	//	Core
	//--------------------------------------------------------------------------
	
	Counter		#(			.Width(					CWidth),
							.Initial(				{CWidth{Initial}}))
				state(		.Clock(					Clock),
							.Reset(					Reset | Done),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				Enable),
							.In(					{CWidth{1'bx}}),
							.Count(					Count));
	CountCompare #(			.Width(					CWidth),
							.Compare(				Threshold - 1))
				threshold(	.Count(					Count), 
							.TerminalCount(			Alarm_Pre));
	assign	Done =									Alarm_Pre & Enable;	

	// Optional
	assign	Intermediate =							Count == IThreshold;
	
	//------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
