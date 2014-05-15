
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		ProgramLoader
//	Desc:		
//==============================================================================
module ProgramLoader(
	Clock, Reset,

	UARTRX, UARTTX,
	
	ORAMCommand,
	ORAMPAddr,
	ORAMCommandValid,
	ORAMCommandReady,
	
	ORAMDataIn,
	ORAMDataInValid,
	ORAMDataInReady
	);
	//--------------------------------------------------------------------------
	//	IO
	//-------------------------------------------------------------------------- 

	parameter				ClockFreq =			100_000_000,
							ORAMU =				32,
							BECMDWidth =		2,
							FEDWidth =			512;
	
	input					Clock, Reset;
	
	output	[BECMDWidth-1:0] ORAMCommand;
	output	[ORAMU-1:0]		ORAMPAddr;
	output					ORAMCommandValid;
	input					ORAMCommandReady;
	
	output	[FEDWidth-1:0]	ORAMDataIn;
	output					ORAMDataInValid;
	input					ORAMDataInReady;

	//------------------------------------------------------------------------------
	// 	Wires & Regs
	//------------------------------------------------------------------------------

	wire	[UWidth-1:0]	UARTDataOut;
	wire					UARTDataOutValid, UARTDataOutReady;

	wire					DataTurn;
	
	wire					CommandInReady, DataInReady;
	
	//------------------------------------------------------------------------------
	// 	HW<->SW Bridge (UART)
	//------------------------------------------------------------------------------	
	
	UART		#(			.ClockFreq(				ClockFreq),
							.Baud(					UARTBaud),
							.Width(					UARTWidth))
				uart(		.Clock(					Clock), 
							.Reset(					Reset), 
							.DataIn(				), 
							.DataInValid(			1'b0), 
							.DataInReady(			), 
							.DataOut(				UARTDataOut), 
							.DataOutValid(			UARTDataOutValid), 
							.DataOutReady(			UARTDataOutReady & ((DataTurn) ? DataInReady : CommandInReady)), 
							.SIn(					UARTRX), 
							.SOut(					UARTTX));				
		
	Register1b 	turn(Clock, Reset | , , 			DataTurn);	
		
	FIFOShiftRound #(		.IWidth(				UWidth),
							.OWidth(				ORAMU + BECMDWidth))
				cmd_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				UARTDataOut),
							.InValid(				UARTDataOutValid & ~DataTurn),
							.InAccept(				CommandInReady),
							.OutData(				{ORAMCommand, ORAMPAddr}),
							.OutValid(				ORAMCommandValid),
							.OutReady(				ORAMCommandReady));
							
	FIFOShiftRound #(		.IWidth(				UWidth),
							.OWidth(				FEDWidth))
				data_shft(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				UARTDataOut),
							.InValid(				UARTDataOutValid & DataTurn),
							.InAccept(				DataInReady),
							.OutData(				ORAMDataIn),
							.OutValid(				ORAMDataInValid),
							.OutReady(				ORAMDataInReady));							
		
	//------------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------