
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
    parameter DataFIFODepth = 16;

    localparam                                      Freq = 100_000_000,
                                                    Cycle = 1000000000/Freq;


    //--------------------------------------------------------------------------
    //      Wires & Regs
    //--------------------------------------------------------------------------

    wire                                           Clock;
    wire                                           Clock_N;
    reg                                            Reset;

    reg [63:0]                                     CycleCount;

    reg                                            Enc;

    wire [IVEntropyWidth-1:0]                      AESDataIn;
    wire                                           AESDataInValid;
    wire                                           AESDataInReady;

    wire [AESWidth-1:0]                            AESKey;
    wire                                           AESKeyValid;
    wire                                           AESKeyReady;

    wire [W*AESWidth-1:0]                          AESDataOut;
    wire                                           AESDataOutValid;

    //fifo i/o
    wire [W*AESWidth-1:0]                          OrigDataIn;
    wire                                           OrigDataInValid;
    wire                                           OrigDataInAccept;
    wire [W*AESWidth-1:0]                          OrigDataOut;
    wire                                           OrigDataOutValid;
    wire                                           OrigDataOutReady;

    wire [W*AESWidth-1:0]                          DataIn;
    wire                                           DataInValid;
    wire                                           DataInAccept;
    wire [W*AESWidth-1:0]                          DataOut;
    wire                                           DataOutValid;
    wire                                           DataOutReady;

    wire [W*AESWidth-1:0]                          EncDataIn;
    wire                                           EncDataInValid;
    wire                                           EncDataInAccept;
    wire [W*AESWidth-1:0]                          EncDataOut;
    wire                                           EncDataOutValid;
    wire                                           EncDataOutReady;

    wire [W*AESWidth-1:0]                          DecDataIn;
    wire                                           DecDataInValid;
    wire                                           DecDataInAccept;
    wire [W*AESWidth-1:0]                          DecDataOut;
    wire                                           DecDataOutValid;
    wire                                           DecDataOutReady;

    wire [IVEntropyWidth-1:0]                      IVEncDataIn;
    wire                                           IVEncDataInValid;
    wire                                           IVEncDataInAccept;
    wire [IVEntropyWidth-1:0]                      IVEncDataOut;
    wire                                           IVEncDataOutValid;
    wire                                           IVEncDataOutReady;

    wire [IVEntropyWidth-1:0]                      IVDecDataIn;
    wire                                           IVDecDataInValid;
    wire                                           IVDecDataInAccept;
    wire [IVEntropyWidth-1:0]                      IVDecDataOut;
    wire                                           IVDecDataOutValid;
    wire                                           IVDecDataOutReady;

    wire [W*AESWidth-1:0]                          AESResDataIn;
    wire                                           AESResDataInValid;
    wire                                           AESResDataInAccept;
    wire [W*AESWidth-1:0]                          AESResDataOut;
    wire                                           AESResDataOutValid;
    wire                                           AESResDataOutReady;


    reg [W*AESWidth-1:0]                           CurData;
    reg [IVEntropyWidth-1:0]                       CurIV;
    reg                                            Loading;

    reg [1:0]                                      Stage;

    reg                                            Test1Ready;

    assign Clock = ~Clock_N;

    //TODO: replace with random key
    assign AESKey = {(AESWidth){1'b1}};
    assign AESKeyValid = 1;

    //original inputs
    assign OrigDataIn = CurData;
    assign OrigDataInValid = Loading;
    assign DataIn = CurData;
    assign DataInValid = Loading;
    assign IVEncDataIn = CurIV;
    assign IVEncDataInValid = Loading;
    assign IVDecDataIn = CurIV;
    assign IVDecDataInValid = Loading;

    assign OrigDataOutReady = Test1Ready;
    assign DecDataOutReady = Test1Ready;

    //IVenc -> AES or IVdec -> AES
    assign AESDataIn = Enc ? IVEncDataOut: IVDecDataOut;
    assign AESDataInValid = (Enc & IVEncDataOutValid) ||
                            (~Enc & IVDecDataOutValid);
    assign IVEncDataOutReady = Enc & AESDataInReady;
    assign IVDecDataOutReady = ~Enc & AESDataInReady;

    //AES -> AES FIFO
    assign AESResDataIn = AESDataOut;
    assign AESResDataInValid = AESDataOutValid;
    //ignoring input ready signal right now

    //AES FIFO ^ Data FIFO -> Enc FIFO
    assign EncDataIn = DataOut ^ AESResDataOut;
    assign EncDataInValid = Enc & DataOutValid & AESResDataOutValid;
    assign DataOutReady = Enc & EncDataInAccept & AESResDataOutValid;

    //special, since shared between enc and dec
    assign AESResDataOutReady = (Enc & EncDataInAccept & DataOutValid) ||
                                (~Enc & DecDataInAccept & EncDataOutValid);

    //AES FIFO ^ Enc FIFO -> Dec FIFO
    assign DecDataIn = EncDataOut ^ AESResDataOut;
    assign DecDataInValid = ~Enc & EncDataOutValid & AESResDataOutValid;
    assign EncDataOutReady = ~Enc & DecDataInAccept & AESResDataOutValid;


    always @( posedge Clock) begin
        if (Reset) begin
            CycleCount <= 0;
            Stage <= 0;
            Enc <= 1;
            Test1Ready <= 0;
            Loading <= 0;
        end else
            CycleCount <= CycleCount + 1;
    end

    always @( posedge Clock) begin
        if (Reset) begin
            CurData <= 0;
            CurIV <= 0;
        end else begin
            CurData <= {(W*AESWidth/32){$random}};
            CurIV <= {(IVEntropyWidth/32){$random}};
        end
    end

    //--------------------------------------------------------------------------
    //      Clock Source
    //--------------------------------------------------------------------------

    ClockSource #(Freq) ClockF200Gen(.Enable(1'b1), .Clock(Clock_N));

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
                  .InData(EncDataIn),
                  .InValid(EncDataInValid),
                  .InAccept(EncDataInAccept),
                  .OutData(EncDataOut),
                  .OutValid(EncDataOutValid),
                  .OutReady(EncDataOutReady)
                  );

    FIFOLinear#(.Width(W*AESWidth),
                .Depth(DataFIFODepth))
    datadec_fifo (.Clock(Clock),
                  .Reset(Reset),
                  .InData(DecDataIn),
                  .InValid(DecDataInValid),
                  .InAccept(DecDataInAccept),
                  .OutData(DecDataOut),
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


    FIFOLinear#(.Width(W*AESWidth),
                .Depth(DataFIFODepth*2))
    aesres_fifo (.Clock(Clock),
                 .Reset(Reset),
                 .InData(AESResDataIn),
                 .InValid(AESResDataInValid),
                 .InAccept(AESResDataInAccept),
                 .OutData(AESResDataOut),
                 .OutValid(AESResDataOutValid),
                 .OutReady(AESResDataOutReady)
                 );


    //--------------------------------------------------------------------------
    //      Test
    //--------------------------------------------------------------------------

    integer i;

    initial begin


        Reset = 1'b1;
        #(Cycle * 2); //must assert for more than 1 due to AES
        Reset = 1'b0;

        Enc = 1;
        Loading = 1;

        // enq data till filled
        for (i = 0; i < DataFIFODepth*2; i = i + 1) #(Cycle);

        Loading = 0;
        #(Cycle * DataFIFODepth * 30);

        Enc = 0;
        #(Cycle * DataFIFODepth * 30);


        //verify
        Test1Ready = 1;
        for (i = 0; i < DataFIFODepth; i = i + 1) begin
            if (OrigDataOutValid && DecDataOutValid &&
                (OrigDataOut != DecDataOut)) begin
                $display("Different values after enc/dec. TEST FAILED");
                $display("%dth value: (%x, %x)", i, OrigDataOut, DecDataOut);
                $finish;
            end else
                #(Cycle);
        end
        $display ("TEST PASSED");
        $finish;
    end


    //--------------------------------------------------------------------------
    //      Module
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
