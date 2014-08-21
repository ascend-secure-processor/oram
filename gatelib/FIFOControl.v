//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/trunk/Gateware/FIFOs/Hardware/Control/FIFOControl.v $
//	Version:	$Revision: 27065 $
//	Author:		Greg Gibeling (http://www.gdgib.com)
//				Chris Fletcher (http://cwfletcher.net)
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
//	Module:		FIFOControl
//	Desc:		A class1 or class2 FIFO controller implementation suitable for
//				use as either a pure semaphore or a FIFO controller.  This
//				module provides full timing parameters (RDL channel CBFC<Width,
//				FWLatency, Buffering, BWLatency>).  It will be class1 iff
//				FWLatency > 0 and BWLatency > 0.
//	Params:		Asynchronous: Use a completely asynchronous design
//				FWLatency: Forward latency of count values.
//				Buffering: The maximum value of the semaphore counter.
//				BWLatency: Backward latency of count values.
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//				<a href="http://www.cwfletcher.net/">Chris Fletcher</a>
//	Version:	$Revision: 27065 $
//------------------------------------------------------------------------------
module	FIFOControl(
			//------------------------------------------------------------------
			//	System I/O
			//------------------------------------------------------------------
			Clock,
			Reset,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Input Interface
			//------------------------------------------------------------------
			InClock,
			InReset,
			
			InValid,
			InAccept,								// May actually be InReady, depending on the BWLatency parameter
			
			InWrite,
			InGate,
			InWriteAddress,
			InReadAddress,
			InEmptyCount,
			//------------------------------------------------------------------
			
			//------------------------------------------------------------------
			//	Output Interface
			//------------------------------------------------------------------
			OutClock,
			OutReset,
			
			OutSend,								// May actually be OutValid, depending on the FWLatency parameter
			OutReady,
			
			OutRead,
			OutGate,
			OutReadAddress,
			OutWriteAddress,
			OutFullCount
			//------------------------------------------------------------------
	);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	parameter				Asynchronous =			0,
							FWLatency =				1,
							Buffering =				16,
							BWLatency =				1;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Constants
	//--------------------------------------------------------------------------
	`ifdef MACROSAFE
	localparam				RawAWidth =				`log2(Buffering),
							AWidth =				`max(RawAWidth, 1),
							IOCWidth =				`log2(Buffering + 1),
							IOCDWidth =				RawAWidth + 1,
							Simple =				`popcount(Buffering) == 1,
							CWidth =				Simple ? IOCDWidth : IOCWidth,
							CTerminal =				(Simple ? (Buffering*2) : Buffering)-1;
	`endif
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
	input					Clock, Reset;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Input Interface
	//--------------------------------------------------------------------------
	input					InClock, InReset;
	
	input					InValid;
	output					InAccept;				// Must not be a function of InValid, may actually be InReady, depending on the BWLatency parameter
	
	output					InWrite, InGate;
	output	[AWidth-1:0]	InWriteAddress, InReadAddress;
	output	[IOCWidth-1:0]	InEmptyCount;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Output Interface
	//--------------------------------------------------------------------------
	input					OutClock, OutReset;
	
	output					OutSend;				// Must not be a function of OutReady, may actually be OutValid, depending on the FWLatency parameter
	input					OutReady;
	
	output					OutRead, OutGate;
	output	[AWidth-1:0]	OutReadAddress, OutWriteAddress;
	output	[IOCWidth-1:0]	OutFullCount;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Checks
	//--------------------------------------------------------------------------
	`ifdef MODELSIM
		initial if (Asynchronous && (FWLatency < 2)) $display("ERROR[%m @ %t]: Forwards latency must be at least 2 for an asynchronous FIFO control!", $time);
		initial if (Asynchronous && (BWLatency < 2)) $display("ERROR[%m @ %t]: Backwards latency must be at least 2 for an asynchronous FIFO control!", $time);
	`endif
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Wires
	//--------------------------------------------------------------------------
	wire					IntIClock, IntIReset;
	wire					IntOClock, IntOReset;
	
	wire	[AWidth-1:0] 	OutReadAddressInner;
	
	wire					InRead, OutWrite;
	wire	[CWidth-1:0]	InReadCount, OutReadCount, OutReadCountNext, InWriteCount, OutWriteCount;
	wire					InReadTerminal, OutReadTerminal, InWriteTerminal, OutWriteTerminal;
	
	wire	[CWidth-1:0]	InWriteGray, InReadGray, OutReadGray, OutWriteGray;
	wire	[IOCDWidth-1:0]	InCountDiff, OutCountDiff, CDBuffering;
	wire	[IOCDWidth-1:0]	CDInEmptyCount, CDOutFullCount;
	
	wire					InPrevWrite, OutPrevWrite;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Assign Statements
	//--------------------------------------------------------------------------
	generate if (Asynchronous) begin:ASYNCSYS
		assign	IntIClock =							InClock;
		assign	IntIReset =							InReset;
		assign	IntOClock =							OutClock;
		assign	IntOReset =							OutReset;
	end else begin:SYNCSYS
		assign	IntIClock =							Clock;
		assign	IntIReset =							Reset;
		assign	IntOClock =							Clock;
		assign	IntOReset =							Reset;
	end endgenerate
	
	generate if (RawAWidth < 1) begin:ADDRESSONE
		assign	InWriteAddress =					1'b0;
		assign	InReadAddress =						1'b0;
		assign	OutReadAddress =					1'b0;
		assign	OutReadAddressInner =				1'b0;
		assign	OutWriteAddress =					1'b0;
	end else begin:ADDRESSMANY
		assign	InWriteAddress =					InWriteCount[AWidth-1:0];
		assign	InReadAddress =						InReadCount[AWidth-1:0];
		assign	OutReadCountNext =					(CTerminal == OutReadCount) ? {CWidth{1'b0}} : OutReadCount + 1;
		assign	OutReadAddress =					(OutRead) ? OutReadCountNext[AWidth-1:0] : 	OutReadCount[AWidth-1:0]; // NOTE: this only works when the RdLatency to RAM.v is high
		assign	OutReadAddressInner =															OutReadCount[AWidth-1:0];
		assign	OutWriteAddress =					OutWriteCount[AWidth-1:0];
	end endgenerate
	
	assign	InWrite =								InValid & InAccept;
	assign	OutRead =								OutSend & OutReady;
	assign	InAccept =								~IntIReset & (InGate | ((BWLatency == 0) & (OutReady & OutGate)));
	assign	OutSend =								~IntOReset & (OutGate | ((FWLatency == 0) & (InValid & InGate)));
	
	generate if (Simple) begin:SIMPLEGATE
		if (Asynchronous) begin:ASYNCGATE
			if (RawAWidth < 1) begin:GRAYONE
				assign	InGate =					~InPrevWrite;
				assign	OutGate =					OutPrevWrite;
			end else begin:GRAYMANY
				assign	InGate =					({^InReadGray[AWidth:AWidth-1], InReadGray[AWidth-2:0]} != {^InWriteGray[AWidth:AWidth-1], InWriteGray[AWidth-2:0]}) | ~InPrevWrite;
				assign	OutGate =					({^OutReadGray[AWidth:AWidth-1], OutReadGray[AWidth-2:0]} != {^OutWriteGray[AWidth:AWidth-1], OutWriteGray[AWidth-2:0]}) | OutPrevWrite;
			end
			assign	InPrevWrite =					(InReadGray[RawAWidth] != InWriteGray[RawAWidth]);
			assign	OutPrevWrite =					(OutReadGray[RawAWidth] != OutWriteGray[RawAWidth]);
		end else begin:SYNCGATE
			assign	InGate =						(InReadAddress != InWriteAddress) | ~InPrevWrite;
			assign	OutGate =						(OutReadAddressInner != OutWriteAddress) | OutPrevWrite;
			assign	InPrevWrite =					(InReadCount[RawAWidth] != InWriteCount[RawAWidth]);
			assign	OutPrevWrite =					(OutReadCount[RawAWidth] != OutWriteCount[RawAWidth]);
		end
	end else begin:COMPLEXGATE
		assign	InGate =							(InReadCount != InWriteCount) | ~InPrevWrite;
		assign	OutGate =							(OutReadCount != OutWriteCount) | OutPrevWrite;
	end endgenerate
	
	assign	InCountDiff =							InReadAddress - InWriteAddress;
	assign	OutCountDiff =							OutWriteAddress - OutReadAddressInner;
	assign	CDBuffering =							Buffering;
	assign	CDInEmptyCount =						((InCountDiff[IOCDWidth-1] | ((~|InCountDiff[AWidth-1:0]) & ~InPrevWrite)) ? CDBuffering : {IOCDWidth{1'b0}}) + InCountDiff;
	assign	CDOutFullCount =						((OutCountDiff[IOCDWidth-1] | ((~|OutCountDiff[AWidth-1:0]) & OutPrevWrite)) ? CDBuffering : {IOCDWidth{1'b0}}) + OutCountDiff;
	assign	InEmptyCount =							CDInEmptyCount[IOCWidth-1:0];
	assign	OutFullCount =							CDOutFullCount[IOCWidth-1:0];
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Primary Counters
	//--------------------------------------------------------------------------
	Counter #(CWidth) PrimReadCnt(.Clock(IntOClock), .Reset(IntOReset | (OutRead & OutReadTerminal)), .Set(1'b0), .Load(1'b0), .Enable(OutRead), .In({CWidth{1'bx}}), .Count(OutReadCount));
	Counter #(CWidth) PrimWritCnt(.Clock(IntIClock), .Reset(IntIReset | (InWrite & InWriteTerminal)), .Set(1'b0), .Load(1'b0), .Enable(InWrite), .In({CWidth{1'bx}}), .Count(InWriteCount));
	CountCompare #(CWidth, CTerminal) PrimReadCmp(.Count(OutReadCount), .TerminalCount(OutReadTerminal));
	CountCompare #(CWidth, CTerminal) PrimWriteCmp(.Count(InWriteCount), .TerminalCount(InWriteTerminal));
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	PrevWrite Registers
	//--------------------------------------------------------------------------
	generate if (!Simple) begin:PREVOPS
		Register #(1) InPWR (.Clock(IntIClock), .Reset(IntIReset), .Set(1'b0), .Enable(InRead ^ InWrite), .In(InWrite), .Out(InPrevWrite));
		Register #(1) OutPWR(.Clock(IntOClock), .Reset(IntOReset), .Set(1'b0), .Enable(OutRead ^ OutWrite), .In(OutWrite), .Out(OutPrevWrite));
	end endgenerate
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Backward Latency (Secondary Counter)
	//--------------------------------------------------------------------------
	generate if (Asynchronous) begin:BW_ASYNC
		Bin2Gray #(CWidth) BWB2G(.Bin(OutReadCount), .Gray(OutReadGray));
		ShiftRegister #((CWidth*BWLatency), CWidth) ReadDelay(.Clock(IntIClock), .Reset(IntIReset), .Load(1'b0), .Enable(1'b1), .PIn({(CWidth*BWLatency){1'bx}}), .SIn(OutReadGray), .POut(), .SOut(InReadGray));
		Gray2Bin #(CWidth) BWG2B(.Gray(InReadGray), .Bin(InReadCount));
	end else begin:BW_SYNC
		if (BWLatency > 1) begin:BW_LARGE
			Counter #(CWidth) SecReadCnt(.Clock(Clock), .Reset(Reset | (InRead & InReadTerminal)), .Set(1'b0), .Load(1'b0), .Enable(InRead), .In({CWidth{1'bx}}), .Count(InReadCount));
			CountCompare #(CWidth, CTerminal) SecReadCmp(.Count(InReadCount), .TerminalCount(InReadTerminal));
			ShiftRegister #((BWLatency-1), 1) ReadDelay(.Clock(Clock), .Reset(Reset), .Load(1'b0), .Enable(1'b1), .PIn({(BWLatency-1){1'bx}}), .SIn(OutRead), .POut(), .SOut(InRead));
		end else begin:BW_ZERO
			assign	InReadCount =					OutReadCount;
			assign	InRead =						OutRead;
		end
	end endgenerate
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Forward Latency (Secondary Counter)
	//--------------------------------------------------------------------------
	generate if (Asynchronous) begin:FW_ASYNC
		Bin2Gray #(CWidth) FWB2G(.Bin(InWriteCount), .Gray(InWriteGray));
		ShiftRegister #((CWidth*FWLatency), CWidth) WriteDelay(.Clock(IntOClock), .Reset(IntOReset), .Load(1'b0), .Enable(1'b1), .PIn({(CWidth*FWLatency){1'bx}}), .SIn(InWriteGray), .POut(), .SOut(OutWriteGray));
		Gray2Bin #(CWidth) FWG2B(.Gray(OutWriteGray), .Bin(OutWriteCount));
	end else begin:FW_SYNC
		if (FWLatency > 1) begin:FW_LARGE
			Counter #(CWidth) SecWriteCnt(.Clock(Clock), .Reset(Reset | (OutWrite & OutWriteTerminal)), .Set(1'b0), .Load(1'b0), .Enable(OutWrite), .In({CWidth{1'bx}}), .Count(OutWriteCount));
			CountCompare #(CWidth, CTerminal) SecWriteCmp(.Count(OutWriteCount), .TerminalCount(OutWriteTerminal));
			ShiftRegister #((FWLatency-1), 1) WriteDelay(.Clock(Clock), .Reset(Reset), .Load(1'b0), .Enable(1'b1), .PIn({(FWLatency-1){1'bx}}), .SIn(InWrite), .POut(), .SOut(OutWrite));
		end else begin:FW_ZERO
			assign	OutWriteCount =					InWriteCount;
			assign	OutWrite =						InWrite;
		end
	end endgenerate
	//--------------------------------------------------------------------------
endmodule	
//------------------------------------------------------------------------------
