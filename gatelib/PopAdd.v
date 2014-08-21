//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Core/GateCore/Hardware/Math/PopAdd.v $
//	Version:	$Revision: 27051 $
//	Author:		Brandon Myers
//				Greg Gibeling (http://www.gdgib.com/)
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
//	Module:		PopAdd
//	Desc:		Counts the number of 1's in the input
//	Params:		Width:	Sets the bitwidth of input
//	Author:		Brandon Myers
//				<a href="http://www.gdgib.com/">Greg Gibeling</a>
//	Version:	$Revision: 27051 $
//------------------------------------------------------------------------------
module	PopAdd(In, Out);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				IWidth =				16;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	`ifdef MACROSAFE
	localparam				OWidth =				`log2(IWidth+1),
							LIWidth =				`log2(IWidth),
							XIWidth =				`pow2(LIWidth),
							XOWidth =				`log2(XIWidth+1);
	
	function automatic [31:0] upper(input [31:0] i, input [31:0] j); begin
		if (i == 0) upper = j;
		else upper = ((i*2*j)+i);
	end endfunction
	
	function automatic [31:0] lower(input [31:0] i, input [31:0] j); begin
		if (i == 0) lower = j;
		else lower = (i*2*j);
	end endfunction
	`endif
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Ports
	//--------------------------------------------------------------------------
	input 	[IWidth-1:0]	In;
	output 	[OWidth-1:0]	Out;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Wires
	//--------------------------------------------------------------------------
	wire	[XIWidth-1:0]	Intermediate[XOWidth-1:0];
	genvar					i, j;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Assigns
	//--------------------------------------------------------------------------
	assign	Intermediate[0] =			In;
	assign	Out =						Intermediate[XOWidth-1][OWidth-1:0];
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Generated Adder Tree
	//--------------------------------------------------------------------------
	generate for (i = 1; i < XOWidth; i = i + 1) begin:OUTTER
		for (j = 0; j < (XIWidth >> i); j = j + 1) begin:INNER
			assign	Intermediate[i][upper(i,j):lower(i,j)] = Intermediate[i-1][upper(i-1,j*2):lower(i-1,j*2)] + Intermediate[i-1][upper(i-1,(j*2)+1):lower(i-1,(j*2)+1)];
		end
	end endgenerate
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
