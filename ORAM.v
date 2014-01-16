module ORAM#
  (
   parameter MAX_ORAM_L = 32,
   parameter MAX_LOG_L = 5,
   parameter DRAM_ADDR_WIDTH = 30,
   parameter DRAM_DATA_WIDTH = 128,
   parameter APP_ADDR_WIDTH = 64,
   parameter APP_DATA_WIDTH = 64
   )

    (
     Clock,
     Reset,

     MIGRdy,
     MIGEn, // enable memory controller
     MIGInstr, // 0 for write, 1 for read
     MIGAddr, // ORAM memory address

     AppInstr, // application instruction
     AppAddr, // addr from core
     AppData, // data from core

     // write to memory
     WrEn, // write enable
     WrData, // write data
     WrDataEnd, // indicate end of write
     WrFull, // write fifo full

     // read from memory
     RdEn, // read enable
     RdData, // read data
     RdEmpty, // read fifo empty

     ORAMLevels,
     L_st,
     BktSize,
     STSize,
     NumCompST,
     STSize_bot
     );

    localparam AES_WIDTH = 128;

    input                           Clock, Reset;

    input                           MIGRdy;

    input                           AppInstr;
    input [APP_ADDR_WIDTH-1:0]      AppAddr;
    input [APP_DATA_WIDTH-1:0]      AppData;

    output                          MIGEn;
    output [2:0]                    MIGInstr;
    output [DRAM_ADDR_WIDTH-1:0]    MIGAddr;

    output                          WrEn;
    output [APP_DATA_WIDTH-1:0]     WrData;
    output                          WrDataEnd;

    input                           WrFull;

    output                          RdEn;
    input                           RdData;
    input                           RdEmpty;

    input [MAX_LOG_L-1:0]           ORAMLevels;
    input [MAX_LOG_L-1:0]           L_st;
    input [MAX_ORAM_L-1:0]          BktSize;
    input [MAX_ORAM_L-1:0]          STSize;
    input [MAX_ORAM_L-1:0]          NumCompST;
    input [MAX_ORAM_L-1:0]          STSize_bot;


    wire [MAX_ORAM_L-1:0]           Leaf; // comes from POSMAP
    wire                            LeafValid;

    wire                            SymKey; // from key exchange

    wire                            OutLd; // indicate load
    wire [APP_DATA_WIDTH-1:0]       PlainIn; // plain text to AES
    wire [APP_DATA_WIDTH-1:0]       CipherOut; // data from AES
    wire [APP_DATA_WIDTH/AES_WIDTH-1:0] AESOutDone; // done encrypt

    wire                                InKld; // indicate key load
    wire                                InLd; //indicate load
    wire [APP_DATA_WIDTH-1:0]           CipherIn; // plain text to AES
    wire [APP_DATA_WIDTH-1:0]           PlainOut; // data from AES
    wire [APP_DATA_WIDTH/AES_WIDTH-1:0] AESInDone;  // done decrypt

    wire [DRAM_ADDR_WIDTH-1:0]        PAddr;

    wire                            AddrGenEn;

    assign AddrGenEn = MIGRdy & LeafValid;

    assign MIGAddr = PAddr;


    PosMap#(.MAX_ORAM_L (MAX_ORAM_L),
            .APP_ADDR_WIDTH (APP_ADDR_WIDTH))
    posMap (.Clock(Clock),
            .Reset(Reset),
            .AppAddr(AppAddr),
            .AppAddrValid(),
            .Leaf(Leaf),
            .LeafValid(LeafValid)
            );


    Stash (.Clock(Clock),
           .Reset(Reset),
           .ResetDone(),

           .AccessLeaf(Leaf),
           .AccessPAddr(PAddr),
           .AccessIsDummy(), //need to figure out what's dummy

           .StartScanOperation(LeafValid),
           .StartReadOperation(),

           .ReturnData(),
           .ReturnPAddr(),
           .ReturnLeaf(),
           .ReturnDataOutValid(),
           .ReturnDataOutReady(),
           .BlockReturnComplete(),

           .EvictData(),
           .EvictPAddr(),
           .EvictLeaf(),
           .EvictDataInValid(),
           .EvictDataInReady(),
           .BlockEvictComplete(),

           .WriteData(),
           .WriteInValid(),
           .WriteInReady(),
           .WritePAddr(),
           .WriteLeaf(),
           .BlockWriteComplete(),

           .ReadData(),
           .ReadPAddr(),
           .ReadLeaf(),
           .ReadOutValid(),
           .ReadOutReady(),
           .BlockReadComplete(),

           .StashAlmostFull(),
           .StashOverflow()
        );

    AddrGen#(.DRAM_ADDR_WIDTH (DRAM_ADDR_WIDTH),
             .MAX_ORAM_L (MAX_ORAM_L),
             .MAX_LOG_L (MAX_LOG_L))
    addrGen (.Clock(Clock),
             .Reset(Reset),
             .Enable(AddrGenEn),
             .leaf(Leaf),
             .ORAMLevels(ORAMLevels),
             .L_st(L_st),
             .BktSize(BktSize),
             .STSize(STSize),
             .NumCompST(NumCompST),
             .STSize_bot(STSize_bot),
             .CurrentLevel(),
             .PhyAddr(PAddr),
             .STIdx(),
             .BktIdx()
             );

    genvar                          i;
    generate
        for (i = 0; i < APP_DATA_WIDTH/AES_WIDTH; i = i + 1) begin: AES
            aes_cipher_top (.clk(Clock),
                            .rst(Reset),
                            .ld(OutLd),
                            .key(SymKey),
                            .text_in(PlainIn[i * AES_WIDTH - 1:0]),
                            .text_out(CipherOut[i * AES_WIDTH -1:0]),
                            .done(AESOutDone[i])
                            );

            aes_inv_cipher_top (.clk(Clock),
                                .rst(Reset),
                                .kld(InKld),
                                .ld(InLd),
                                .key(SymKey),
                                .text_in(CipherIn[i * AES_WIDTH - 1:0]),
                                .text_out(PlainOut[i * AES_WIDTH -1:0]),
                                .done(AESInDone[i])
                                );

        end
    endgenerate

endmodule
