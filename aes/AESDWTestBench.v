
//==============================================================================
//      Section:        Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

`timescale              1 ns/1 ps               // Display things in ns, compute them in ps

//==============================================================================
//      Module:         AESDWTestBench
//      Desc:           Test bench for the AES wrapper module
//==============================================================================
module  AESDWTestbench;

`ifndef SIMULATION
    initial begin
        $display("[%m @ %t] ERROR: set SIMULATION macro", $time);
        $stop;
    end
`endif

    //--------------------------------------------------------------------------
    //      Constants & overrides
    //--------------------------------------------------------------------------

    parameter                                       IVEntropyWidth = 64;
    parameter                                       AESWidth = 128;

    parameter W = 4;
    parameter D = 12;
    parameter DataFIFODepth = 1024;

    localparam                                      Freq = 100_000_000,
                                                    Cycle = 1000000000/Freq;


    //--------------------------------------------------------------------------
    //      Wires & Regs
    //--------------------------------------------------------------------------

    wire                                            Clock;
    reg                                             Reset;

    wire [IVEntropyWidth-1:0]                       AESDataIn;
    wire                                            AESDataInValid;
    wire                                            AESDataInReady;

    wire [AESWidth-1:0]                             AESKey;
    wire                                            AESKeyValid;
    wire                                            AESKeyReady;

    wire [W*AESWidth-1:0]                           AESDataOut;
    wire                                            AESDataOutValid;

    //fifo wires
    wire [W*AESWidth-1:0]                           OrigDataIn;
    wire                                            OrigDataInValid;
    wire                                            OrigDataInAccept;
    wire [W*AESWidth-1:0]                           OrigDataOut;
    wire                                            OrigDataOutValid;
    wire                                            OrigDataOutReady;

    wire [W*AESWidth-1:0]                           DataIn;
    wire                                            DataInValid;
    wire                                            DataInAccept;
    wire [W*AESWidth-1:0]                           DataOut;
    wire                                            DataOutValid;
    wire                                            DataOutReady;

    wire [W*AESWidth-1:0]                           EncDataIn;
    wire                                            EncDataInValid;
    wire                                            EncDataInAccept;
    wire [W*AESWidth-1:0]                           EncDataOut;
    wire                                            EncDataOutValid;
    wire                                            EncDataOutReady;

    wire [W*AESWidth-1:0]                           DecDataIn;
    wire                                            DecDataInValid;
    wire                                            DecDataInAccept;
    wire [W*AESWidth-1:0]                           DecDataOut;
    wire                                            DecDataOutValid;
    wire                                            DecDataOutReady;

    wire [IVEntropyWidth-1:0]                       IVEncDataIn;
    wire                                            IVEncDataInValid;
    wire                                            IVEncDataInAccept;
    wire [IVEntropyWidth-1:0]                       IVEncDataOut;
    wire                                            IVEncDataOutValid;
    wire                                            IVEncDataOutReady;

    wire [IVEntropyWidth-1:0]                       IVDecDataIn;
    wire                                            IVDecDataInValid;
    wire                                            IVDecDataInAccept;
    wire [IVEntropyWidth-1:0]                       IVDecDataOut;
    wire                                            IVDecDataOutValid;
    wire                                            IVDecDataOutReady;



    //--------------------------------------------------------------------------
    //      Clock Source
    //--------------------------------------------------------------------------

    ClockSource #(Freq) ClockF200Gen(.Enable(1'b1), .Clock(Clock));

    //--------------------------------------------------------------------------
    //      Tasks
    //--------------------------------------------------------------------------

    FIFOLinear#(.Width(W*AESWidth),
                .Depth(DataFIFODepth))
    origdata_fifo (.Clock(Clock),
		   .Reset(Reset),
		   .InData(OrigDataIn),
		   .InValid(OrigDataInValid),
                   .InAccept(OrigDataInAccept),
		   .OutData(OrigDataOut),
                   .OutValid(OrigDataOutValid),
		   .OutReady(OrigDataOutReady)
                   );

    FIFOLinear#(.Width(W*AESWidth),
                .Depth(DataFIFODepth))
    datain_fifo (.Clock(Clock),
		 .Reset(Reset),
		 .InData(DataIn),
		 .InValid(DataInValid),
                 .InAccept(DataInAccept),
		 .OutData(DataOut),
                 .OutValid(DataOutValid),
		 .OutReady(DataOutReady)
                 );

    FIFOLinear#(.Width(W*AESWidth),
                .Depth(DataFIFODepth))
    dataenc_fifo (.Clock(Clock),
		  .Reset(Reset),
		  .InEncData(EncDataIn),
		  .InValid(EncDataInValid),
                  .InAccept(EncDataInAccept),
		  .OutEncData(EncDataOut),
                  .OutValid(EncDataOutValid),
		  .OutReady(EncDataOutReady)
                  );

    FIFOLinear#(.Width(W*AESWidth),
                .Depth(DataFIFODepth))
    datadec_fifo (.Clock(Clock),
		  .Reset(Reset),
		  .InDecData(DecDataIn),
		  .InValid(DecDataInValid),
                  .InAccept(DecDataInAccept),
		  .OutDecData(DecDataOut),
                  .OutValid(DecDataOutValid),
		  .OutReady(DecDataOutReady)
                  );


    FIFOLinear#(.Width(IVEntropyWidth),
                .Depth(DataFIFODepth))
    ivenc_fifo (.Clock(Clock),
	        .Reset(Reset),
	        .InData(IVEncDataIn),
	        .InValid(IVEncDataInValid),
                .InAccept(IVEncDataInAccept),
	        .OutData(IVEncDataOut),
                .OutValid(IVEncDataOutValid),
	        .OutReady(IVEncDataOutReady)
                );

    FIFOLinear#(.Width(IVEntropyWidth),
                .Depth(DataFIFODepth))
    ivdec_fifo (.Clock(Clock),
	        .Reset(Reset),
	        .InData(IVDecDataIn),
	        .InValid(IVDecDataInValid),
                .InAccept(IVDecDataInAccept),
	        .OutData(IVDecDataOut),
                .OutValid(IVDecDataOutValid),
	        .OutReady(IVDecDataOutReady)
                );


    task TASK_EnqData;
        input [W*AESWidth-1:0]  Data;
        input [IVEntropyWidth-1:0] IV;

        OrigDataIn = Data;
        DataIn = Data;
        IVEncDataIn = IV;
        IVDecDataIn = IV;

        OrigDataInValid = 1'b1;
        DataInValid = 1'b1;
        IVEncDataInValid = 1'b1;
        IVDecDataInValid = 1'b1;

        while (~OrigDataInAccept  || ~DataInAccept ||
               ~IVEncDataInAccept || ~IVDecDataInAccept) #(Cycle);
        #(Cycle);

        OrigDataInValid = 1'b0;
        DataInValid = 1'b0;
        IVEncDataInValid = 1'b0;
        IVDecDataInValid = 1'b0;
    endtask // TASK_EnqData

    task TASK_QueueAES;
        input [W*AESWidth-1:0] Data;
        input                  DataValid;
        input                  Enc;

        AESDataIn = Data;
        AESDataInValid = DataValid;
        if (Enc)
            IVEncOutReady = AESDataInReady;
        else
            IVDecOutReady = AESDataInReady;

        if (Enc)
            while (~IVEncDataOutValid || ~AESDataInReady) #(Cycle);
        else
            while (~IVDecDataOutValid || ~AESDataInReady) #(Cycle);
    endtask // TASK_QueueAES

    task TASK_AES;
        input Enc;
        if (Enc)
            while (~AESDataOutValid || ~DataOutReady) #(Cycle);
        else
            while (~AESDataOutValid || ~EncDataOutReady) #(Cycle);

        if (Enc) begin
            EncDataIn = AESDataOut ^ DataOut;
            EndDataInValid = 1'b1;

            while (~EncDataInAccept) #(Cycle);
            EncDataInValid = 1'b0;
        end else begin
            DecDataIn = AESDataOut ^ EncDataOut;
            DecDataInValid = 1'b1;
            while (~DecDataInAccept) #(Cycle);
            DecDataInValid = 1'b0;
        end
    endtask // TASK_AESEnc




    //--------------------------------------------------------------------------
    //      Test Stimulus
    //--------------------------------------------------------------------------

    integer i;

    initial begin

        //--------------------------------------------------------------------------
        //      Test 1: Filled fifo
        //--------------------------------------------------------------------------

        i = 0;
        // enq data till filled
        while (i < DataFIFODepth) begin
            TASK_EnqData($random(0), $random(1));
        end

        TASK_QueueAES(IVEncData, IVEncDataOutValid, 1'b1);
        TASK_AES(1);

        #(Cycle * 100);

        TASK_QueueAES(IVDecData, IVDecDataOutValid, 1'b0);
        TASK_AES(0);  //done encrypting and decrypting
    end

    //--------------------------------------------------------------------------
    //      Test checks
    //--------------------------------------------------------------------------



    //--------------------------------------------------------------------------
    //      CUT
    //--------------------------------------------------------------------------


    AES_DW #(.W(4),
             .D(12),
             .IVEntropyWidth(IVEntropyWidth),
             .AESWidth(AESWidth))
    aes_dw (.Clock(Clock),
            .Reset(Reset),
            .DataIn(AESDataIn),
            .DataInValid(AESDataInValid),
            .DataInReady(AESDataInReady),
            .Key(AESKey),
            .KeyValid(AESKeyValid),
            .KeyReady(AESKeyReady),
            .DataOut(AESDataOut),
            .DataOutValid(AESDataOutValid)
            );



endmodule
//------------------------------------------------------------------------------
