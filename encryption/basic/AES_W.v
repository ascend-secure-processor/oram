
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

   DataOut,
   DataOutValid
   );


`include "PathORAM.vh"

    parameter W = 1;
    parameter AESWIn_Width = AESEntropy;

    //--------------------------------------------------------------------------
    //	System I/O
    //--------------------------------------------------------------------------

    input                       Clock, Reset;

    //--------------------------------------------------------------------------
    //	Interface 1
    //--------------------------------------------------------------------------

    input [AESWIn_Width-1:0]    DataIn;
    input                       DataInValid;
    output                      DataInReady;

    input [AESWidth-1:0]        Key;

    output [W*AESWidth-1:0]     DataOut;
    output                      DataOutValid;

    //--------------------------------------------------------------------------
    //	wires and regs
    //--------------------------------------------------------------------------

    localparam D = 21;

    wire                        ValidOut;

    wire [W*AESWidth-1:0]       AESRes;

    //carry the valid signal from input for D cycles
	ShiftRegister #(		.PWidth(				D),
							.SWidth(				1))
				V_shift(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Load(					1'b0), 
							.Enable(				1'b1),
							.SIn(					DataInValid),
							.SOut(					ValidOut));					   
			   
    genvar k;
    generate
        for (k = 0; k < W; k = k + 1) begin: AES
            aes_128 aes(.clk(Clock),
                        .state({{(AESWidth-AESWIn_Width){1'b0}}, DataIn}), // TODO: 1'b0, the padding, should really be unique for each k
                        .key(Key),
                        .out(AESRes[(k+1)*AESWidth - 1:k*AESWidth]));
        end
    endgenerate

    //IO assignment
    assign DataInReady = 1'b1;
    assign DataOut = AESRes;
    assign DataOutValid = ValidOut;


endmodule
//--------------------------------------------------------------------------
