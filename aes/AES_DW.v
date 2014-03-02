
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

    // used for passthrough
    reg      [3:0]               AESCycleCount[D-1:0];
    reg      [W*AESWidth-1:0]    AESData[D-1:0];
    reg      [D-1:0]             AESDataValid;
    reg      [D-1:0]             AESDone;

    always @( posedge Clock ) begin
        if (Reset)
            Count <= 0;
        else if (DataInValid && DInReady && ~DOutValid)
            Count <= Count + 1;
        else if (DataInValid && ~DInReady && DOutValid)
            Count <= Count - 1;
    end

    // for passthrough
    always @( posedge Clock ) begin
        if (Reset) begin
            InTurn <= 0;
            for (integer i = 0; i < D; i = i + 1) begin
                AESDone[i] <= 0;
                AESData[i] <= {(W*AESWidth){1'b1}};
            end
        end
        else if (DataInValid) begin
            if (InTurn >= D-1)
                InTurn <= 0;
            else
                InTurn <= InTurn + 1;
        end
    end

    always @( posedge Clock ) begin
        if (Reset)
            AESDataValid <= 0;
        else if (DataInValid) begin
            AESData[InTurn] <= {(W*(AESWidth/IVEntropyWidth)){DataIn}}; //random val for
            if (InTurn != OutTurn || ~DOutValid) //hack for now
                AESDataValid[InTurn] <= 1;
        end
    end

    always @( posedge Clock ) begin
        if (Reset) begin
            for (integer i = 0; i < D; i = i + 1) begin: CycleReset
                AESCycleCount[i] <= 0;
            end
        end else begin
            for (integer i = 0; i < D; i = i + 1) begin: CycleInc
                if (AESDataValid[i] && (AESCycleCount[i] == 12)) begin
                    AESDone[i] <= 1;
                    AESCycleCount[OutTurn] <= 0;
                end else if (AESDataValid[i])
                    AESCycleCount[i] <= AESCycleCount[i] + 1;
            end
        end
    end

    always @( posedge Clock) begin
        if (Reset)
            OutTurn <= 0;
        else if (AESDone[OutTurn]) begin
            AESDataValid[OutTurn] <= 0;
            AESDone[OutTurn] <= 0;
            if (OutTurn >= D-1)
                OutTurn <= 0;
            else
                OutTurn <= OutTurn + 1;
        end
    end

    assign DInReady = Count < D;
    assign DOut = AESData[OutTurn];
    assign DOutValid = AESDone[OutTurn];

    //IO assignment
    assign DataInReady = DInReady;
    assign KeyReady = DInReady;
    assign DataOut = DOut;
    assign DataOutValid = DOutValid;


endmodule
//--------------------------------------------------------------------------

