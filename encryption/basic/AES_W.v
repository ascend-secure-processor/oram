
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

// NOTE: assumes tab = 4 spaces

//==============================================================================
//	Module: AES_W
//	Desc: Instantiates W AES units for W*128b data path, and handles 21
//            different IVs (consequence of tiny_aes).
//==============================================================================
module AES_W
  (
   Clock, Reset,

   DataIn,
   DataInValid,
   DataInReady,

   Key,
   KeyValid,
   KeyReady,

   DataOut,
   DataOutValid
   );

    parameter W = 4;

`include "PathORAM.vh"

    //--------------------------------------------------------------------------
    //	System I/O
    //--------------------------------------------------------------------------

    input                       Clock, Reset;

    //--------------------------------------------------------------------------
    //	Interface 1
    //--------------------------------------------------------------------------

    input [AESEntropy-1:0]      DataIn;
    input                       DataInValid;
    output                      DataInReady;

    input [AESWidth-1:0]        Key;
    input                       KeyValid;
    output                      KeyReady;

    output [W*AESWidth-1:0]     DataOut;
    output                      DataOutValid;

    //--------------------------------------------------------------------------
    //	wires and regs
    //--------------------------------------------------------------------------

    localparam D = 21;

    wire                        ValidAccept;
    wire                        ValidOut;
    wire                        ValidOutValid;

    wire [W*AESWidth-1:0]       AESRes;

    //carry the valid signal from input for D cycles
    FIFOLinear#(.Width(1),
                .Depth(D))
    valid_fifo(.Clock(Clock),
               .Reset(Reset),
               .InData(DataInValid & KeyValid),
               .InValid(DataInValid & KeyValid),
               .InAccept(ValidAccept),
               .OutData(ValidOut),
               .OutValid(ValidOutValid),
               .OutReady(1));

    genvar k;
    generate
        for (k = 0; k < W; k = k + 1) begin: AES
            aes_128 aes(.clk(Clock),
                        .state({{(AESWidth-AESEntropy){1'b0}}, DataIn + k}),
                        .key(Key),
                        .out(AESRes[(k+1)*AESWidth - 1:k*AESWidth]));
        end
    endgenerate

    //IO assignment
    assign DataInReady = ValidAccept & KeyValid;
    assign KeyReady = ValidAccept & DataInValid;
    assign DataOut = AESRes;
    assign DataOutValid = ValidOut & ValidOutValid;


endmodule
//--------------------------------------------------------------------------

