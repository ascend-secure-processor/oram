
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

// NOTE: assumes tab = 4 spaces

//==============================================================================
//	Module: AES_DW
//	Desc: Instantiates W AES units for W*128b data path, and handles D
//            different IVs. Currently, is just holding data for 12 cycles, then
//            passes it on.
//==============================================================================
module AES_DW #(parameter W = 4, parameter D = 12,
                `include "AES.vh")
    (
     //--------------------------------------------------------------------------
     //	System I/O
     //--------------------------------------------------------------------------

     input                       Clock, Reset,

     //--------------------------------------------------------------------------
     //	Interface 1
     //--------------------------------------------------------------------------

     input  [IVEntropyWidth-1:0] DataIn,
     input                       DataInValid,
     output                      DataInReady,

     input   [AESWidth-1:0]      Key,
     input                       KeyValid,
     output                      KeyReady,

     output  [W*AESWidth-1:0]    DataOut,
     output                      DataOutValid
     );


    localparam LOGD = `log2(D);

    reg      [LOGD-1:0]      Count;
    reg      [LOGD-1:0]      InTurn;
    reg      [LOGD-1:0]      OutTurn;
    wire                         DInReady;
    wire                         DOutValid;
    wire     [W*AESWidth-1:0]    DOut;

    wire     [W*AESWidth-1:0]    AESRes[D-1:0];
    wire     [W-1:0]             AESResValid[D-1:0];

    assign DInReady = Count < D;
    assign DOut = AESRes[OutTurn];
    assign DOutValid = |(AESResValid[OutTurn]);

    always @( posedge Clock ) begin
        if (Reset)
            Count <= 0;
        else if (DataInValid && DInReady && ~DOutValid)
            Count <= Count + 1;
        else if (DataInValid && ~DInReady && DOutValid)
            Count <= Count - 1;
    end

    always @( posedge Clock ) begin
        if (Reset)
            InTurn <= 0;
        else if (DataInValid && DInReady) begin
            if (InTurn >= D-1)
                InTurn <= 0;
            else
                InTurn <= InTurn + 1;
        end
    end

    always @( posedge Clock ) begin
        if (Reset)
            OutTurn <= 0;
        else if (DOutValid) begin
            if (OutTurn >= D-1)
                OutTurn <= 0;
            else
                OutTurn <= OutTurn + 1;
        end
    end


    genvar i, j;
    generate
        for (i = 0; i < D; i = i + 1) begin: OuterAES
            for (j = 0; j < W; j = j + 1) begin: InnerAES
                aes_cipher_top aes(.clk(Clock),
                                   .rst(~Reset),
                                   .ld(DataInValid && KeyValid && (InTurn == i)),
                                   .done(AESResValid[i][j]),
                                   .key(Key),
                                   .text_in({{(AESWidth-IVEntropyWidth){1'b0}}, DataIn + j}),
                                   .text_out(AESRes[i][(j+1)*AESWidth - 1:j*AESWidth]));
            end
        end
    endgenerate

    //IO assignment
    assign DataInReady = DInReady;
    assign KeyReady = DInReady;
    assign DataOut = DOut;
    assign DataOutValid = DOutValid;


endmodule
//--------------------------------------------------------------------------

