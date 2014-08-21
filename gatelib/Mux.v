//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Core/GateCore/Hardware/Datapath/Variable/Mux.v $
//	Version:	$Revision: 26904 $
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
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		Mux
//	Desc:		This is a parameterized size mux.  It is primarily meant for use
//				in places where the number of mux inputs is a parameter to
//				the module which instantiates this one, as the way one writes
//				Verilog to describe a mux can affect the whether a functional
//				simulation is accurate as of ModelSim 6.4a.
//	Params:		Width:	The width of the mux
//				NPorts:	The number of input ports to the mux
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//	Version:	$Revision: 26904 $
//------------------------------------------------------------------------------
module Mux(Select, Input, Output);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				Width =					32,
							NPorts =				2,
							SelectCode =			0; // 0 - Binary, 1 - One-Hot
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	`ifdef MACROSAFE
	localparam 				SWidth =				SelectCode ? NPorts : `max(1,`log2(NPorts));
	`endif
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	I/O Ports
	//--------------------------------------------------------------------------
	input	[SWidth-1:0]	Select;
	input	[(NPorts*Width)-1:0] Input;
	output	[Width-1:0]		Output;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	genvar					i;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Behavioral Mux
	//--------------------------------------------------------------------------
	generate if (NPorts > 1) begin:MANYIN
		if (SelectCode) begin:ONEHOT
			for (i = 0; i < NPorts; i = i + 1) begin:LOOP
				assign	Output =					Select[i] ? Input[(Width*i)+Width-1:(Width*i)] : {Width{1'bz}};
			end
		end else begin:BINARY
			for (i = 0; i < NPorts; i = i + 1) begin:LOOP
				assign	Output =					(Select == i) ? Input[(Width*i)+Width-1:(Width*i)] : {Width{1'bz}};
			end
		end
	end else begin:ONEIN
		assign	Output =							Input[Width-1:0];
	end endgenerate
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
