//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Core/GateCore/Hardware/Simulation/ClockSource.v $
//	Version:	$Revision: 27051 $
//	Author:		Greg Gibeling (http://www.gdgib.com/)
//	Copyright:	Copyright 2003-2010 UC Berkeley
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
//	Section:	Defines and Constants
//==============================================================================
`timescale		1 ps/1 ps		// Display things in ps, compute them in ps
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		ClockSource
//	Desc:		This module will use behavioral verilog to generate a properly
//				gated clock source at any frequency you desire.
//	Params:		ClockFreq:	Desired output clock frequency
//				SyncDisable: Will cause this generator to wait for a low value
//							on the clock before disabling it when Enable
//							transitions to low.
//				Phase:
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//	Version:	$Revision: 27051 $
//------------------------------------------------------------------------------
module ClockSource(Enable, Clock);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter real			ClockFreq =				100000000,
							SyncDisable =			1,
							Phase =					0;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	localparam real			Delay =					500000000/(ClockFreq/1000),
							PhaseDelay =			Delay * Phase / 180;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	I/O
	//--------------------------------------------------------------------------
	input					Enable;
	output					Clock;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Wires & Reg
	//--------------------------------------------------------------------------
	reg						Clock =					1'b0;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Gated Clock Source
	//--------------------------------------------------------------------------
	always @ (posedge Enable) begin
		#(Delay);
		#(PhaseDelay);
		while (Enable) begin
			Clock =									~Clock;
			#(Delay);
		end
		if (Clock && SyncDisable) Clock =			1'b0;
	end
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
