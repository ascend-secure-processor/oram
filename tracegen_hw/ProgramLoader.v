
//==============================================================================
//      Section:        Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//      Module:         ProgramLoader
//      Desc:
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
        //      IO
        //--------------------------------------------------------------------------

        localparam UWidth = 8;

        parameter                               ClockFreq =                     100_000_000,
                                                ORAMU =                         32,
                                                BECMDWidth =            2,
                                                FEDWidth =                      512,
                                                UARTBaud = 9600;

        input                                   Clock, Reset;
        input                                   UARTRX, UARTTX;

        output  [BECMDWidth-1:0] ORAMCommand;
        output  [ORAMU-1:0]             ORAMPAddr;
        output                                  ORAMCommandValid;
        input                                   ORAMCommandReady;


        output  [FEDWidth-1:0]  ORAMDataIn;
        output                                  ORAMDataInValid;
        input                                   ORAMDataInReady;

        //------------------------------------------------------------------------------
        //      Wires & Regs
        //------------------------------------------------------------------------------

        (* mark_debug = "TRUE" *) wire    [UWidth-1:0]    UARTDataOut;
        (* mark_debug = "TRUE" *) wire                                    UARTDataOutValid;

        (* mark_debug = "TRUE" *) wire                                    DataTurn;

        (* mark_debug = "TRUE" *) wire                                    CommandInReady, DataInReady;

        wire [8-BECMDWidth-1:0]                           Dummy;

        //------------------------------------------------------------------------------
        //      HW<->SW Bridge (UART)
        //------------------------------------------------------------------------------

        UART            #(                      .ClockFreq(                             ClockFreq),
                                                        .Baud(                                  UARTBaud),
                                                        .Width(                                 UWidth))
                                uart(           .Clock(                                 Clock),
                                                        .Reset(                                 Reset),
                                                        .DataIn(                                ),
                                                        .DataInValid(                   1'b0),
                                                        .DataInReady(                   ),
                                                        .DataOut(                               UARTDataOut),
                                                        .DataOutValid(                  UARTDataOutValid),
                                                        .DataOutReady(                  (DataTurn) ? DataInReady : CommandInReady),
                                                        .SIn(                                   UARTRX),
                                                        .SOut(                                  UARTTX));

        Register1b      turn(Clock, Reset | (ORAMDataInValid & ORAMDataInReady), ORAMCommandValid & ORAMCommandReady, DataTurn);

        FIFOShiftRound #(               .IWidth(                                UWidth),
                                                        .OWidth(                                ORAMU + 8))
                                cmd_shft(       .Clock(                                 Clock),
                                                        .Reset(                                 Reset),
                                                        .InData(                                UARTDataOut),
                                                        .InValid(                               UARTDataOutValid & ~DataTurn),
                                                        .InAccept(                              CommandInReady),
                                                        .OutData(                               {Dummy, ORAMCommand, ORAMPAddr}),
                                                        .OutValid(                              ORAMCommandValid),
                                                        .OutReady(                              ORAMCommandReady));

        FIFOShiftRound #(               .IWidth(                                UWidth),
                                                        .OWidth(                                FEDWidth))
                                data_shft(      .Clock(                                 Clock),
                                                        .Reset(                                 Reset),
                                                        .InData(                                UARTDataOut),
                                                        .InValid(                               UARTDataOutValid & DataTurn),
                                                        .InAccept(                              DataInReady),
                                                        .OutData(                               ORAMDataIn),
                                                        .OutValid(                              ORAMDataInValid),
                                                        .OutReady(                              ORAMDataInReady));

        //------------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------