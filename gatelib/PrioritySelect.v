//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Core/GateCore/Hardware/Arbiter/PrioritySelect.v $
//	Version:	$Revision: 27051 $
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
//	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		PrioritySelect
//	Desc:		This module provides straight priority select implementation.
//				It is encapsulated so that language and synthesis tool changes
//				can be isolated from major designs.  Takes a many-hot input
//				and generates a one-hot (or none-hot) output, where the output
//				which is hot will be the lowest index input which was asserted.
//	Params:		Width:	The number of ports on this selector's input.
//				LUTWidth:The width of the FPGA LUTs for the device to which this
//						instance will be synthesized.  If 0 the synthesis tool
//						is fed a purely behavioral construct, but if non-0, this
//						module will (hopefully) be highly optimized.  Note that
//						the optimal value for an FPGA may be slightly more or
//						less than the LUTWidth on that FPGA thanks to retiming
//						and general synthesis optimizations.
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//	Version:	$Revision: 27051 $
//------------------------------------------------------------------------------
module	PrioritySelect(Valid, Select);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				Width =		 		2,
							LUTWidth =			0;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	localparam				LUTWidth1 =			`max(LUTWidth, 1),	// Avoid div by 0, parameters aren't used with LUTWidth == 0 anyway
							FullGroups =		Width / LUTWidth1,
							LastGroup =			Width % LUTWidth1,
							Groups =			`divceil(Width, LUTWidth1);
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	I/O
	//--------------------------------------------------------------------------
	input	[Width-1:0]		Valid;
	output	[Width-1:0]		Select;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Wires and Regs
	//--------------------------------------------------------------------------
	reg						Found;
	reg		[Width-1:0]		SelectReg;
	integer					i;
	genvar					j;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Priority Selection
	//--------------------------------------------------------------------------
	generate if ((LUTWidth == 0) || (LUTWidth >= Width)) begin:BEHAV
		always @ (*) begin
			Found =									0;
			for (i = 0; i < Width; i = i + 1) begin
				if (~Found) begin
					SelectReg[i] =					Valid[i];
					Found =							Valid[i];
				end
				else SelectReg[i] =					1'b0;
			end
		end

		assign	Select =							SelectReg;
	end else begin:OPT
		wire	[Width-1:0]	Intermediate;
		wire	[Groups-1:0]GroupHot, GroupSelect;

		for (j = 0; j < FullGroups; j = j + 1) begin:FULLGROUP
			PrioritySelect #(LUTWidth, LUTWidth) PS(.Valid(Valid[(j*LUTWidth)+LUTWidth-1:j*LUTWidth]), .Select(Intermediate[(j*LUTWidth)+LUTWidth-1:j*LUTWidth]));
			assign Select[(j*LUTWidth)+LUTWidth-1:j*LUTWidth] = Intermediate[(j*LUTWidth)+LUTWidth-1:j*LUTWidth] & {LUTWidth{GroupSelect[j]}};
			assign GroupHot[j] = |Valid[(j*LUTWidth)+LUTWidth-1:j*LUTWidth];
		end

		if (LastGroup > 0) begin:LASTGROUP
			PrioritySelect(.Valid(Valid[(FullGroups*LUTWidth)+LastGroup-1:FullGroups*LUTWidth]), .Select(Intermediate[(FullGroups*LUTWidth)+LastGroup-1:FullGroups*LUTWidth]));
			assign Select[(FullGroups*LUTWidth)+LastGroup-1:FullGroups*LUTWidth] = Intermediate[(FullGroups*LUTWidth)+LastGroup-1:FullGroups*LUTWidth] & {LastGroup{GroupSelect[FullGroups]}};
			assign GroupHot[FullGroups] = |Valid[(FullGroups*LUTWidth)+LastGroup-1:FullGroups*LUTWidth];
		end

		PrioritySelect #(Groups, LUTWidth) PS(.Valid(GroupHot), .Select(GroupSelect));
	end endgenerate
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
