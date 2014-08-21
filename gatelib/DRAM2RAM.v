//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/branches/dev/Firmware/DRAM/Hardware/SynthesizedDRAM/DRAM2RAM.v $
//	Version:	$Revision: 26904 $
//	Author:		Greg Gibeling (http://www.gdgib.com)
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
//	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		DRAM2RAM
//	Desc:		This module will convert a DRAM interface to an standard RAM
//				interface by handling the handshaking and burst addressing.  It
//				is used by SynthesizedDRAM to do just this, but is provided
//				independently for those users with custom RAM implementations or
//				needs.
//
//	Params:		UWidth:	The maskabale and addressable unit of memory.  Typically
//						this would be 8b for normal DRAM based designs, but it is
//						variable for this module.
//				AWidth:	The width of the CommandAddress input, which determines
//						the amount of addressable memory.  There are
//						(2^AWidth) * UWidth total bits of memory.
//				DWidth:	The width of the data input and output.  Note that
//						this may be smaller than a single burst transfer.
//				BurstLen: The number of DWidth wide words per DRAM operation.
//				Class1:	Should this implementation use class1 FIFO interfaces?
//						This will reduce the memory bandwidth to 50% when
//						reading, as the inputs must be registered in a FIFO to
//						accomplish this.
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//	Version:	$Revision: 26904 $
//------------------------------------------------------------------------------
module	DRAM2RAM(
			//------------------------------------------------------------------
			//	System I/O
			//------------------------------------------------------------------
			Clock,
			Reset,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Status Outputs
			//------------------------------------------------------------------
			Initialized,
			PoweredUp,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Command Interface
			//------------------------------------------------------------------
			CommandAddress,
			Command,
			CommandValid,
			CommandReady,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Data Input (Write) Interface
			//------------------------------------------------------------------
			DataIn,
			DataInMask,
			DataInValid,
			DataInReady,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Data Output (Read) Interface
			//------------------------------------------------------------------
			DataOut,
			DataOutErrorChecked,
			DataOutErrorCorrected,
			DataOutValid,
			DataOutReady,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	RAM Interface
			//------------------------------------------------------------------
			RAMAddress,
			RAMDataIn,
			RAMDataOut,
			RAMEnable,
			RAMWrite,
			RAMRead
			//------------------------------------------------------------------
		);
	//--------------------------------------------------------------------------
	//	Per-Instance Constants
	//--------------------------------------------------------------------------
	parameter				UWidth =				9,
							AWidth =				12,
							DWidth =				UWidth,
							BurstLen =				1,
							EnableMask =			1,
							Class1 =				1,
							RLatency =				1,	// Inform this module of the RLatency of the RAM it is using
							WLatency =				1;	// Inform this module of the WLatency of the RAM it is using
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Fixed Constants
	//--------------------------------------------------------------------------
	`ifdef MACROSAFE
	localparam				UCount =				DWidth / UWidth,
							MWidth =				EnableMask ? UCount : 0, // Per-unit (byte) masks
							CommandMask =			7'b0000011, // Read & Write only
							ECheck =				0,	// No error checking
							ECorrect =				0,	// No error correction
							EHWidth =				`max(`log2(ECheck+1), 1),
							ERWidth =				`max(`log2(ECorrect+1), 1);
	`endif
	`include "DRAM.constants"
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Internal Constants
	//--------------------------------------------------------------------------
	`ifdef MACROSAFE
		localparam			UAWidth =				`log2(UCount-1), // Unused lower address bits
							BCWidth =				`log2(BurstLen),
							XMWidth =				`max(MWidth, 1),
	`else
		localparam			UAWidth =				UCount,
							BCWidth =				BurstLen,
							XMWidth =				MWidth,
	`endif
							RAWidth =				AWidth-UAWidth;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Checks
	//--------------------------------------------------------------------------	
	`ifdef MODELSIM
		initial if (RLatency < WLatency) $display("%s[%m @ %t]: Read latency (%d) should be larger than or equal to write latency (%d) to avoid RAW hazard issues!", (RLatency+1) < WLatency ? "ERROR" : "WARNING", $time, RLatency, WLatency);
	`endif
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
	input					Clock, Reset;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Status Outputs
	//--------------------------------------------------------------------------
	output					Initialized;
	output					PoweredUp;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Command Interface
	//--------------------------------------------------------------------------
	input	[AWidth-1:0]	CommandAddress;
	input	[DRAMCMD_CWidth-1:0] Command;
	input					CommandValid;
	output					CommandReady;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Data Input (Write) Interface
	//--------------------------------------------------------------------------
	input	[DWidth-1:0]	DataIn;
	input	[XMWidth-1:0]	DataInMask;
	input					DataInValid;
	output					DataInReady;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Data Output (Read) Interface
	//--------------------------------------------------------------------------
	output	[DWidth-1:0]	DataOut;
	output	[EHWidth-1:0]	DataOutErrorChecked;
	output	[ERWidth-1:0]	DataOutErrorCorrected;
	output					DataOutValid;
	input					DataOutReady;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	RAM Interface
	//--------------------------------------------------------------------------
	output	[RAWidth-1:0]	RAMAddress;
	output	[DWidth-1:0]	RAMDataIn;
	input	[DWidth-1:0]	RAMDataOut;
	output	[UCount-1:0]	RAMEnable, RAMWrite, RAMRead;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Checks
	//--------------------------------------------------------------------------
	`ifdef MODELSIM
		initial if ((UAWidth+BCWidth) >= AWidth) $display("ERROR[%m @ %t]: Burst address bits (%d) and unused address bits %d together are too large for addresses of width %d", $time, BCWidth, UAWidth, AWidth);
		initial if ((1 << BCWidth) != BurstLen) $display("ERROR[%m @ %t]: Burst length must be a power of 2, not %d", $time, BurstLen);
		initial if ((DWidth % UWidth) != 0) $display("ERROR[%m @ %t]: Data transfer width (%d) must be a multiple of the unit width (%d)", $time, DWidth, UWidth);
		always @ (posedge Clock) begin
			if (CommandReady & CommandValid & ~((CommandMask >> Command) & 1'b1)) $display("ERROR[%m @ %t]: Unsupported memory command 0x%h", $time, Command);
		end
	`endif
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Wires
	//--------------------------------------------------------------------------
	wire	[AWidth-1:0]	Internal_CommandAddress;
	wire	[DRAMCMD_CWidth-1:0] Internal_Command;
	wire					Internal_CommandValid;
	wire					Internal_CommandReady;
	
	wire	[DWidth-1:0]	Internal_DataIn;
	wire	[XMWidth-1:0]	Internal_DataInMask;
	wire					Internal_DataInValid;
	wire					Internal_DataInReady;
	
	wire	[MWidth+DWidth-1:0] DataInWide, Internal_DataInWide;
	
	wire					Ready, Execute, Write, Read;
	
	wire	[BCWidth-1:0]	BurstCount, BurstAddress;
	wire					BurstMax;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Mask Connections
	//--------------------------------------------------------------------------
	generate if (EnableMask) begin:MASK
		assign	DataInWide =						{DataInMask, DataIn};
		assign	{Internal_DataInMask, Internal_DataIn} = Internal_DataInWide;
	end else begin:NOMASK
		assign	DataInWide =						DataIn;
		assign	Internal_DataIn =					Internal_DataInWide;
	end endgenerate
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Input FIFOs to ensure class1 status
	//--------------------------------------------------------------------------
	generate if (Class1 != 0) begin:CLASS1
		FIFORegister #(			.Width(				DRAMCMD_CWidth+AWidth),
								.FWLatency(			1),
								.BWLatency(			1))
					CFR(		.Clock(				Clock),
								.Reset(				Reset),
								.InData(			{Command, CommandAddress}),
								.InValid(			CommandValid),
								.InAccept(			CommandReady),
								.OutData(			{Internal_Command, Internal_CommandAddress}),
								.OutSend(			Internal_CommandValid),
								.OutReady(			Internal_CommandReady));
		FIFORegister #(			.Width(				MWidth+DWidth),
								.FWLatency(			1),
								.BWLatency(			1))
					DIFR(		.Clock(				Clock),
								.Reset(				Reset),
								.InData(			DataInWide),
								.InValid(			DataInValid),
								.InAccept(			DataInReady),
								.OutData(			Internal_DataInWide),
								.OutSend(			Internal_DataInValid),
								.OutReady(			Internal_DataInReady));
	end else begin:CLASS3
		assign	Internal_CommandAddress =			CommandAddress;
		assign	Internal_Command =					Command;
		assign	Internal_CommandValid =				CommandValid;
		assign	CommandReady =						Internal_CommandReady;
	
		assign	Internal_DataIn =					DataIn;
		assign	Internal_DataInMask =				DataInMask;
		assign	Internal_DataInValid =				DataInValid;
		assign	DataInReady =						Internal_DataInReady;
	end endgenerate
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Assigns
	//--------------------------------------------------------------------------
	assign	Initialized =							1'b1;
	assign	PoweredUp =								1'b1;
	assign	DataOutErrorChecked =					1'b0;
	assign	DataOutErrorCorrected =					1'b0;
	
	assign	Internal_CommandReady =					Ready & (Internal_DataInValid | Read) & ((BurstLen < 2) | BurstMax);
	assign	Internal_DataInReady =					Ready & Internal_CommandValid & Write;
	
	assign	Ready =									((RLatency < 1) ? Write : ~DataOutValid) | DataOutReady;
	assign	Execute =								Ready & Internal_CommandValid & (Internal_DataInValid | Read);
	assign	Write =									Internal_Command[0] === 1'b0;
	assign	Read =									Internal_Command[0] === 1'b1;
	
	generate if (BurstLen > 1) begin:BURSTADDR
		assign	BurstAddress =						BurstCount + Internal_CommandAddress[UAWidth+BCWidth-1:UAWidth];
		assign	RAMAddress =						{Internal_CommandAddress[AWidth-1:UAWidth+BCWidth], BurstAddress};
	end else begin:PLAINADDR
		assign	RAMAddress =						Internal_CommandAddress[AWidth-1:UAWidth];
	end endgenerate
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	RAM Interface
	//--------------------------------------------------------------------------
	assign	RAMDataIn =								Internal_DataIn;
	assign	DataOut =								RAMDataOut;
	assign	RAMEnable =								{UCount{Ready}};
	assign	RAMWrite =								{UCount{Execute & Write}} & (EnableMask ? ~Internal_DataInMask : {UCount{1'b1}});
	assign	RAMRead =								{UCount{Execute & Read}};
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Burst Counter
	//--------------------------------------------------------------------------
	generate if (BurstLen > 1) begin:BC
		Counter		#(			.Width(				BCWidth))
					BurstCnt(	.Clock(				Clock),
								.Reset(				Reset | (BurstMax & Execute)),
								.Set(				1'b0),
								.Load(				1'b0),
								.Enable(			Execute),
								.In(				{BCWidth{1'bx}}),
								.Count(				BurstCount));
		CountCompare #(			.Width(				BCWidth),
								.Compare(			BurstLen-1))
					BurstCmp(	.Count(				BurstCount),
								.TerminalCount(		BurstMax));
	end endgenerate
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Last Read State Register
	//--------------------------------------------------------------------------
	generate if (RLatency > 0) begin:RDELAY
		ShiftRegister #(		.PWidth(			RLatency),
								.SWidth(			1))
					RDelay(		.Clock(				Clock),
								.Reset(				Reset),
								.Load(				1'b0),
								.Enable(			Ready),
								.PIn(				{RLatency{1'bx}}),
								.SIn(				Execute & Read),
								.POut(				),
								.SOut(				DataOutValid));
	end else begin:NORDELAY
		assign	DataOutValid =						Execute & Read;
	end endgenerate
	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------