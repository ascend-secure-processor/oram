//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Core/GateCore/Hardware/State/RAM.v $
//	Version:	$Revision: 26904 $
//	Author:		Greg Gibeling (http://www.gdgib.com/)
//				Chris Fletcher (http://cwfletcher.net)
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
//	Module:		RAM
//	Desc:		...
//	Params:		DWidth:	Data width
//				AWidth:	Address width
//				RLatency: Number of clock cycles between Address and DOut.
//						Can be 0 for asynchronous read.
//				WLatency: Number of clock cycles between Write and the change.
//						Can be 0 for asynchronous write.
//				NPorts:	Every signal gets its own set of ports.
//				WriteMask: A NPorts-bit wide signal, with a 1'b1 for each port
//						which can write, and a 1'b0 for each port which cannot.
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//				<a href="http://www.cwfletcher.net/">Chris Fletcher</a>
//	Version:	$Revision: 26904 $
//------------------------------------------------------------------------------
module	RAM(Clock, Reset, Enable, Write, Address, DIn, DOut);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				DWidth = 				32,
							AWidth =				10,
							RLatency =				1,
							WLatency =				1,
							NPorts =				1,
							WriteMask =				{NPorts{1'b1}},
							ReadMask =				{NPorts{1'b1}},
							EnableInitial =			0,
							Initial =				0,	// Must be set to a (MaxAddress * DWidth) width vector
							EnableHexInitFile =		0,
							HexInitFile =			"",
							AsyncReset =			0;

	parameter 				ASIC = 					0;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	`ifdef MACROSAFE
	localparam				MaxAddress =			`pow2(AWidth);
	`endif
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	I/O
	//--------------------------------------------------------------------------
	input	[NPorts-1:0]	Clock, Reset, Enable, Write;
	input	[(AWidth*NPorts)-1:0] Address;
	input	[(DWidth*NPorts)-1:0] DIn;
	output	[(DWidth*NPorts)-1:0] DOut;
	//--------------------------------------------------------------------------

	generate if (ASIC == 1 && NPorts == 1) begin:ASIC_SRAM1D
		SRAM1D_WRAP #(		.DWidth(				DWidth), 
							.AWidth(				AWidth))
				sram_wrap(	.Clock(					Clock), 
							.Reset(					Reset),
							.Enable(				Enable), 
							.Write(					Write),
							.Address(				Address),
							.DIn(					DIn),
							.DOut(					DOut));
	end else if (ASIC == 1 && NPorts == 2) begin:ASIC_SRAM2S
		initial begin
			// Note: if you want a simple dual-ported RAM, instantiate SDPRAM
			$display("TODO");
			$finish;
		end
	end else begin:BEHAVIORAL
		//----------------------------------------------------------------------
		//	Wires & Regs
		//----------------------------------------------------------------------
		reg		[DWidth-1:0]	Mem[0:MaxAddress-1];
		// attribute ram_style of Mem is block
		// TODO: remove this ... is it forcing FIFORAM to block ram?
		
		genvar					i, j, k;
		wire					Write_DELAY[NPorts-1:0];
		reg		[AWidth-1:0]	ReadAddress_DELAY[NPorts-1:0];
		wire	[AWidth-1:0]	WriteAddress_DELAY[NPorts-1:0];
		wire	[DWidth-1:0]	DIn_DELAY[NPorts-1:0];
		reg		[DWidth-1:0]	DOut_DELAY[NPorts-1:0];
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//	Initialization
		//----------------------------------------------------------------------
		if (EnableInitial) begin:ENINITVECTOR
			for (k = 0; k < MaxAddress; k = k + 1) begin:INIT
				initial	Mem[k] =						Initial[(k*DWidth)+DWidth-1:(k*DWidth)];
			end
		end 
		if (EnableHexInitFile) begin:ENINITFILE
			initial $readmemh(HexInitFile, Mem);
		end 
		//----------------------------------------------------------------------

		//----------------------------------------------------------------------
		//	Read Logic
		//----------------------------------------------------------------------
		for (i = 0; i < NPorts; i = i + 1) begin:PORTS_READ
			if (ReadMask[i]) begin:READABLE
				if (RLatency < 1) begin:ASYNC_READ
					//----------------------------------------------------------
					//	Asynchronous Read Logic
					//----------------------------------------------------------
					assign	DOut[(DWidth*i)+DWidth-1:(DWidth*i)] = Mem[Address[(AWidth*i)+AWidth-1:(AWidth*i)]];
					//----------------------------------------------------------
				end else begin:SYNC_READ
					//----------------------------------------------------------
					//	Read Address Delay
					//----------------------------------------------------------
					if (WLatency < 1) begin:ASYNC_WRITE
						always @ (posedge Clock[i]) begin
							if (Reset[i]) DOut_DELAY[i] <= 0;
							else if (Enable[i]) DOut_DELAY[i] <= Mem[Address[(AWidth*i)+AWidth-1:(AWidth*i)]];
						end
					end
					//----------------------------------------------------------
					if (RLatency == 1) begin:ONESYNC_READ
						//------------------------------------------------------
						//	Memory Read
						//------------------------------------------------------
						assign DOut[(DWidth*i)+DWidth-1:(DWidth*i)] = DOut_DELAY[i];
						//------------------------------------------------------
					end else begin:MULTISYNC_READ
						//------------------------------------------------------
						//	Synchronous Read Logic
						//------------------------------------------------------
						ShiftRegister #(.PWidth(			DWidth * (RLatency-1)),
										.SWidth(			DWidth),
										.AsyncReset(		AsyncReset))
									RDDelay(.Clock(			Clock[i]),
										.Reset(				Reset[i]),
										.Load(				1'b0),
										.Enable(			Enable[i]),
										.PIn(				{DWidth * (RLatency-1){1'bx}}),
										.SIn(				DOut_DELAY[i]),
										.POut(				),
										.SOut(				DOut[(DWidth*i)+DWidth-1:(DWidth*i)]));
						//------------------------------------------------------
					end
				end
				if (WLatency && RLatency) begin
					always @ (posedge Clock[i]) begin
						if (Enable[i]) begin
							DOut_DELAY[i] <= Mem[Address[(AWidth*i)+AWidth-1:(AWidth*i)]];
						end
					end
				end
			end
		end 
		//----------------------------------------------------------------------

		//----------------------------------------------------------------------
		//	Write Logic
		//----------------------------------------------------------------------
		for (j = 0; j < NPorts; j = j + 1) begin:PORTS_WRITE
			if (WriteMask[j]) begin:WRITABLE
				if (WLatency < 1) begin:ASYNC_WRITE
					//----------------------------------------------------------
					//	Asynchronous Write Logic
					//----------------------------------------------------------
					always @ (posedge Write[j] or posedge Enable[j]) if (Write[j] & Enable[j]) Mem[Address[(AWidth*j)+AWidth-1:(AWidth*j)]] <= DIn[(DWidth*j)+DWidth-1:(DWidth*j)];
					//----------------------------------------------------------
				end else if (WLatency == 1) begin:SYNC_WRITE_1
					//----------------------------------------------------------
					//	Latency 1 Write Logic
					//----------------------------------------------------------
					if (RLatency < 1) begin:ONESYNC_READ
						always @ (posedge Clock[j]) begin
							if (Enable[j] & Write[j]) Mem[Address[(AWidth*j)+AWidth-1:(AWidth*j)]] <= DIn[(DWidth*j)+DWidth-1:(DWidth*j)];
						end
					end else begin:MULTISYNC_READ
						always @ (posedge Clock[j]) begin
							if (Enable[j]) begin
								if (Write[j]) Mem[Address[(AWidth*j)+AWidth-1:(AWidth*j)]] <= DIn[(DWidth*j)+DWidth-1:(DWidth*j)];
							end
						end
					end
					//----------------------------------------------------------
				end else begin:SYNC_WRITE_MORE
					//----------------------------------------------------------
					//	Synchronous Write Logic
					//----------------------------------------------------------
					if (RLatency < 1) begin:ONESYNC_READ
						always @ (posedge Clock[j]) begin
							if (Enable[j] & Write_DELAY[j]) Mem[WriteAddress_DELAY[j]] <= DIn_DELAY[j];
						end
					end else begin:MULTISYNC_READ
						always @ (posedge Clock[j]) begin
							if (Enable[j]) begin
								if (Write_DELAY[j]) Mem[WriteAddress_DELAY[j]] <= DIn_DELAY[j];
							end
						end
					end
		
					ShiftRegister #(.PWidth(			(DWidth+AWidth+1) * (WLatency - 1)),
									.SWidth(			DWidth+AWidth+1),
									.AsyncReset(		AsyncReset))
								WDelay(.Clock(			Clock[j]),
									.Reset(				Reset[j]),
									.Load(				1'b0),
									.Enable(			Enable[j]),
									.PIn(				{(DWidth+AWidth+1) * (WLatency - 1){1'bx}}),
									.SIn(				{DIn[(DWidth*j)+DWidth-1:(DWidth*j)], Address[(AWidth*j)+AWidth-1:(AWidth*j)], Write[j] & Enable[j]}),
									.POut(				),
									.SOut(				{DIn_DELAY[j], WriteAddress_DELAY[j], Write_DELAY[j]}));
					//----------------------------------------------------------
				end
			end
		end
	end endgenerate
endmodule
//------------------------------------------------------------------------------

// A simple dual-port RAM abstraction that we use everywhere.  
// This module will correctly infer SDP RAM as of Vivado 2013.4.
module	SDPRAM(Clock, Reset, Write, WriteAddress, WriteData, Read, ReadAddress, ReadData);
	parameter				DWidth = 				32,
							AWidth =				10,
							RLatency =				1,
							WLatency =				1,
							EnableInitial =			0,
							Initial =				0,
							ASIC = 					0;
							
	input					Clock, Reset, Write, Read;
	input	[AWidth-1:0]	WriteAddress, ReadAddress;						
	input	[DWidth-1:0]	WriteData;
	output	[DWidth-1:0]	ReadData;
	
	wire	[DWidth-1:0]	DummyReadData;

	generate if (ASIC == 1) begin:SRAM2D
		SRAM2D_WRAP #(      .DWidth(				DWidth),
                            .AWidth(            	AWidth))
                sram_wrap(  .Clock(             	Clock),
                            .Reset(             	Reset),
                            .Read(              	Read),
                            .Write(             	Write),
                            .ReadAddress(       	ReadAddress),
                            .WriteAddress(      	WriteAddress),
                            .DIn(               	WriteData),
                            .DOut(              	ReadData));
	end else begin:BEHAVIORAL
		RAM			#(		.DWidth(				DWidth),
							.AWidth(				AWidth),
							.RLatency(				RLatency),
							.WLatency(				WLatency),
							.NPorts(				2),
							.WriteMask(				2'b01),
							.ReadMask(				2'b10))
				core(		.Clock(					{2{Clock}}),
							.Reset(					{2{Reset}}),
							.Enable(				{Read, Write}),
							.Write(					{1'b0, Write}),
							.Address(				{ReadAddress, WriteAddress}),
							.DIn(					{{DWidth{1'bx}}, WriteData}),
							.DOut(					{ReadData, DummyReadData}));
	end endgenerate
endmodule

