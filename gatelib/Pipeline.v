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

//------------------------------------------------------------------------------
//	Module:		Pipeline
//	Desc:		A variable-stage shift register that is meant to explicitely add 
//				cycle delay to a wire.  This module is meant to be retimed by 
//				the synthesis tools.
//
//	NOTE (2/26/2014): added Reset to ensure no SRL inference ... we are using 
//				XST and the synplify directives will not work.
//	Author:		cwfletcher (http://cwfletcher.net)
//------------------------------------------------------------------------------
module	Pipeline(Clock, Reset, InData, OutData) /* synthesis syn_allow_retiming=1 */;
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------

	parameter				Width =					32,
							Stages =				1;
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	
	localparam				Length =				Width * (Stages + 1);
	
	//--------------------------------------------------------------------------
	//	System Inputs
	//--------------------------------------------------------------------------

	input					Clock;
	input					Reset;
	
	//--------------------------------------------------------------------------
	//	Input
	//--------------------------------------------------------------------------

	input	[Width-1:0]		InData;
	
	//--------------------------------------------------------------------------
	//	Output
	//--------------------------------------------------------------------------

	output	[Width-1:0]		OutData;
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//--------------------------------------------------------------------------
	
	genvar					i;
	
	//--------------------------------------------------------------------------
	//	Shift Register Core
	//--------------------------------------------------------------------------
	
	generate if (Stages > 0) begin:PIPELINE
		(* KEEP = "TRUE" *) wire	[Length-1:0]	Data_Wide; // NOTE: untested
		
		for (i = 0; i < Stages; i = i + 1) begin:STAGES						
			PipelinedRegister #(.Width(				Width))
					PLDelay(	.Clock(				Clock),
								.Reset(				Reset),
								.In(				(i == 0) ? InData : Data_Wide[i*Width+Width-1:i*Width]), 
								.Out(				Data_Wide[(i+1)*Width+Width-1:(i+1)*Width])) /* synthesis syn_allow_retiming=1 */;
		end
		
		assign	OutData =							Data_Wide[Stages*Width+Width-1:Stages*Width];
	end else begin:PASS 
		assign	OutData =							InData;
	end endgenerate
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//	Module:		PipelinedRegister
//	Desc:		A register that will not be turned in SRL primitives.
//------------------------------------------------------------------------------
module	PipelinedRegister(Clock, Reset, In, Out) /* synthesis syn_srlstyle="registers" */;
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	
	parameter				Width = 				32;	

	//--------------------------------------------------------------------------
	//	Inputs & Outputs
	//--------------------------------------------------------------------------
	
	input					Clock;
	input					Reset;
	input	[Width-1:0]		In;
	output reg [Width-1:0]	Out /* synthesis syn_srlstyle="registers" */;
	
	`ifdef FPGA
		initial begin
			Out = {Width{1'b0}};
		end
	`endif
	
	//--------------------------------------------------------------------------
	//	Behavioral Register
	//--------------------------------------------------------------------------
	
	always @ (posedge Clock) 
		if (Reset)			Out <=					{Width{1'b0}};
		else				Out <=					In;
	
endmodule
//------------------------------------------------------------------------------
