module ORAMOut#
  (
   parameter MAX_ORAM_L = 34,
   parameter DRAM_ADDR_WIDTH = 32,
   parameter DRAM_DATA_WIDTH = 64,
   parameter APP_ADDR_WIDTH = 33,
   parameter APP_DATA_WIDTH = 512,
   parameter AES_WIDTH = 128,
   parameter BUCKET_SIZE = 3,
   parameter LOG_BUCKET_SIZE = 3
   )

    (
     Clock,
     Reset,

     AESKey,

     IVInValid,
     IVIn,

     DataInValid,
     DataIn,
     AddrIn,
     LeafIn,

     DataOutValid,
     DataOut
     );

    localparam META_WIDTH = APP_ADDR_WIDTH + MAX_ORAM_L;

    input                                 Clock, Reset;

    input [AES_WIDTH-1:0]                 AESKey;

    input                                 IVInValid;
    input [AES_WIDTH-1:0]                 IVIn;

    input                                 DataInValid;
    input [APP_DATA_WIDTH-1:0]            DataIn;
    input [APP_ADDR_WIDTH-1:0]            AddrIn;
    input [MAX_ORAM_L-1:0]                LeafIn;

    output                                DataOutValid;
    output [DRAM_DATA_WIDTH-1:0]          DataOut;

    //wires related to data
    wire [APP_DATA_WIDTH-1:0]             BufferedData[0:BUCKET_SIZE-1];
    wire [BUCKET_SIZE-1:0]                BufferedDataRdy;
    wire [BUCKET_SIZE-1:0]                DataAccept;
    wire [APP_DATA_WIDTH-1:0]             AESOut[0:BUCKET_SIZE-1];
    wire [APP_DATA_WIDTH/AES_WIDTH-1:0]   AESDataDone[0:BUCKET_SIZE-1];

    wire [APP_DATA_WIDTH-1:0]             CipherData[0:BUCKET_SIZE-1];

    //wires related to all ULs
    wire                                  ULAccept;
    wire [META_WIDTH*BUCKET_SIZE-1:0]     ULs; //all the ULs combined
    wire [AES_WIDTH-1:0]                  ExtendedULs;
    wire [AES_WIDTH-1:0]                  AESULs;
    wire                                  AESULsDone;

    wire [AES_WIDTH-1:0]                  CipherULs;

    wire [2*AES_WIDTH+APP_DATA_WIDTH*BUCKET_SIZE-1:0] CipherBucket;
    wire                                              CipherBucketDone;

    reg [AES_WIDTH-1:0]                   IV;
    reg [LOG_BUCKET_SIZE-1:0]             CurrentBlock;

    always @ (posedge Clock)
      if (Reset) begin
          IV <= 0;
      end else if (IVInValid) begin
          IV <= IVIn;
      end

    always @ (posedge Clock)
      if (Reset) begin
          CurrentBlock <= 0;
      end else if ((CurrentBlock < BUCKET_SIZE) && DataInValid) begin
          CurrentBlock <= CurrentBlock + 1;
      end else if (DataInValid) begin
          CurrentBlock <= 0;
      end

    wire [AES_WIDTH-BUCKET_SIZE*(APP_ADDR_WIDTH+MAX_ORAM_L)-1:0] zeros = 0;
    assign ExtendedULs = {zeros, ULs}; //need to do for different AES units required


    FIFOShiftRound#(.IWidth(META_WIDTH),
                    .OWidth(META_WIDTH * BUCKET_SIZE))
    fifoShiftULs (.Clock(Clock),
                  .Reset(Reset),
                  .RepeatLimit(),
                  .RepeatMin(),
	          .RepeatPreMax(),
	          .RepeatMax(),
                  .InData({AddrIn, LeafIn}),
                  .InValid(DataInValid),
                  .InAccept(ULAccept), //should check to make sure
                  .OutData(ULs),
                  .OutValid(ULsValid),
                  .OutReady(CurrentBlock == BUCKET_SIZE)
                  );

    genvar f;
    generate
        for (f = 0; f < BUCKET_SIZE; f = f + 1) begin: DataFIFO
            FIFORAM#(.Width(APP_DATA_WIDTH),
                     .FWLatency(0),
                     .Buffering(1),
                     .BWLatency(0))
            dataFIFO (.Clock(Clock),
                      .Reset(Reset),
                      .InData(DataIn),
                      .InValid(DataInValid && (CurrnetBlock == f)),
                      .InAccept(DataAccept[f]),
                      .InEmptyCount(),
                      .OutData(BufferedData[f]),
                      .OutSend(BufferedDataRdy[f]),
                      .OutReady(CurrentBlock == BUCKET_SIZE),
                      .OutFullCount()
                      );
        end // block: DataFIFO
    endgenerate


    genvar i;
    generate
        for (i = 0; i < BUCKET_SIZE; i = i + 1) begin: OutterDataAESs
            genvar j;
            for (j = 0; j < APP_DATA_WIDTH/AES_WIDTH; j = j + 1) begin: DataAESs
                aes_cipher_top (.clk(Clock),
                                .rst(Reset),
                                .ld(CurrentBlock == BUCKET_SIZE),
                                .key(AESKey),
                                .text_in(IV+i+1),
                                .text_out(AESOut[i][(j+1)*AES_WIDTH - 1:j*AES_WIDTH]),
                                .done(AESDataDone[i][j])
                                );
            end // block: DataAESs
        end // block: OutterDataAESs
    endgenerate

    aes_cipher_top (.clk(Clock),
                    .rst(Reset),
                    .ld(CurrentBlock == BUCKET_SIZE),
                    .key(AESKey),
                    .text_in(IV),
                    .text_out(AESULs),
                    .done(AESULsDone)
                    );



    genvar k;
    generate
        for (k = 0; k < BUCKET_SIZE; k = k + 1)
            assign CipherData[k] = AESOut[k] ^ BufferedData[k];
    endgenerate

    assign CipherULs = AESULs ^ ExtendedULs;


    //should make it generic enough to handle Z=4,5 as well
    //right now: IV + ULs (in one AES) + data
    assign CipherBucket[AES_WIDTH-1:0] = IV;
    assign CipherBucket[2*AES_WIDTH-1:AES_WIDTH] = CipherULs;
    genvar l;
    generate
        for (l = 0; l < BUCKET_SIZE; l = l + 1)
            assign CipherBucket[2*AES_WIDTH + (l+1)*APP_DATA_WIDTH -1:
                                2*AES_WIDTH + l*APP_DATA_WIDTH] = CipherData[l];
    endgenerate


    FIFOShiftRound#(.IWidth(AES_WIDTH + AES_WIDTH + (APP_DATA_WIDTH*BUCKET_SIZE)),
                    .OWidth(DRAM_DATA_WIDTH))
    fifoShiftOut (.Clock(Clock),
                  .Reset(Reset),
                  .RepeatLimit(),
                  .RepeatMin(),
	          .RepeatPreMax(),
	          .RepeatMax(),
                  .InData(CipherBucket),
                  .InValid(),
                  .InAccept(),
                  .OutData(),
                  .OutValid(),
                  .OutReady()
                  );


endmodule