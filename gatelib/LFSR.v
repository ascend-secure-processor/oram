//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Core/GateCore/Hardware/Counting/LFSR.v $
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

//------------------------------------------------------------------------------
//	Module:		LFSRPoly
//	Desc:		This module computes multiple iterations of an LFSR polynomial.
//				It can be used to build an LFSR or simply to calculate a magic
//				number.
//	Params:		PWidth:	Sets the bitwidth of the parallel data (both in and out
//				of the module)
//				SWidth:	Sets the bitwidth of the serial input
//				Poly:	Sets the LFSR polynomial to use.  Defaults to Ethernet
//						CRC32.  This should be the galois field representation
//						of the polynomial.  The highest degree polynomial term
//						(x^PWidth) is always implied, and the second highest
//						(x^(PWidth-1)) is represent by the 0th bit of the poly.
//						The lowest degree term (1) is always implied and the
//						second lowest (x) is represented by the PWidth-1 bit of
//						the poly.
//				GateXnor: Use Xnor gates instead of Xor gates.
//	Ex:			(32,1) will generate a 32bit CRC using the 802.3 CRC32
//				polynomial one bit at a time
//				(16,8,1'6h1021) will generate a 16bit CRC using the CRC-CCIT
//				polynomial, a byte at a time
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//	Version:	$Revision: 26904 $
//------------------------------------------------------------------------------
module	LFSRPoly(PIn, SIn, POut);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				PWidth =				32,				// The parallel width
							SWidth =				1,				// The serial width
							Poly =					32'h04C11DB7,	// Standard 802.3 CRC32 polynomial
							GateXnor =				0;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Parallel and Serial I/O
	//--------------------------------------------------------------------------
	input	[PWidth-1:0]	PIn;
	input	[SWidth-1:0]	SIn;
	output	[PWidth-1:0]	POut;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Wires
	//--------------------------------------------------------------------------
	wire	[PWidth-1:0]	Intermediate[SWidth:0], Polynomial, IPoly[SWidth:1];
	genvar					i;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Generate Loop Setup and Termination
	//--------------------------------------------------------------------------
	assign	Polynomial =							Poly;
	assign	Intermediate[0] =						PIn;
	assign	POut =									Intermediate[SWidth];
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Generate Loop (Each iteration processes one bit of SIn)
	//--------------------------------------------------------------------------
	generate for (i = 1; i < SWidth + 1; i = i + 1) begin:Shift
			assign	IPoly[i] =						Polynomial & {PWidth{Intermediate[i-1][PWidth-1] ^ SIn[i-1]}};
			assign	Intermediate[i] =				GateXnor ? ~({Intermediate[i-1][PWidth-2:0], 1'b0} ^ IPoly[i]) : ({Intermediate[i-1][PWidth-2:0], 1'b0} ^ IPoly[i]);
		end
	endgenerate
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//	Module:		LFSR
//	Desc:		This module is an actual LFSR with a variable serial input,
//				parallel width and polynomial it uses the LFSRPoly module to do
//				the actual calculations.
//	Params:		pwidth:	Sets the bitwidth of the parallel data (both in and out
//						of the module).
//				swidth:	Sets the bitwidth of the serial input
//				poly:	Sets the LFSR polynomial to use.  Defaults to Ethernet
//						CRC32.  See the LFSRPoly module for more information.
//				GateXnor: Use Xnor gates instead of Xor gates.
//	Ex:			(32,1) will generate a 32bit CRC using the 802.3 CRC32
//				polynomial one bit at a time
//				(16,8,1'6h1021) will generate a 16bit CRC using the CRC-CCIT
//				polynomial, a byte at a time
//------------------------------------------------------------------------------
module	LFSR(Clock, Reset, Load, Enable, PIn, SIn, POut, SOut);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				PWidth =				32,				// The parallel width
							SWidth =				1,				// The serial width
							Poly =					32'h04C11DB7,	// Standard 802.3 CRC32 polynomial
							GateXnor =				0,
							AsyncReset =			0;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Control Inputs
	//--------------------------------------------------------------------------
	input					Clock, Reset;
	input					Load, Enable;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Parallel and Serial I/O
	//--------------------------------------------------------------------------
	input	[PWidth-1:0]	PIn;
	input	[SWidth-1:0]	SIn;
	output	[PWidth-1:0]	POut;
	output	[SWidth-1:0]	SOut;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Wires
	//--------------------------------------------------------------------------
	wire	[PWidth-1:0]	POutNext;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Assigns
	//--------------------------------------------------------------------------
	assign	SOut =									POut[PWidth-1:PWidth-SWidth];
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	LFSR Polynomial Calculation
	//--------------------------------------------------------------------------
	LFSRPoly		PONGen(		.PIn(				POut),
								.SIn(				SIn),
								.POut(				POutNext));
	defparam		PONGen.PWidth =					PWidth;
	defparam		PONGen.SWidth =					SWidth;
	defparam		PONGen.Poly =					Poly;
	defparam		PONGen.GateXnor =				GateXnor;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Behavioral Register Core
	//--------------------------------------------------------------------------
	Register		#(			.Width(				PWidth),
								.AsyncSet(			AsyncReset))
					Register(	.Clock(				Clock),
								.Reset(				1'b0),
								.Set(				Reset),
								.Enable(			Load | Enable),
								.In(				Load ? PIn : POutNext),
								.Out(				POut));
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
