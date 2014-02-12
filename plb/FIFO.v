`include "Const.vh"

module FIFO
#(parameter Width = 32, Depth = 8)
(
    input Clock, Reset, 
    
    output InReady,
    input  InValid,
    input  [Width-1:0] DIn,
    
    input  OutReady,
    output OutValid,
    output [Width-1:0] DOut
);

    localparam AddrWidth = `log2(Depth) + 1;
    
    reg [AddrWidth-1:0] Head, Tail;
    reg [Width-1:0] FIFORAM [Depth:0]; 
    
    initial begin
        Head <= 0;
        Tail <= 0;
    end
    
    assign InReady = (Head + 1) % (Depth + 1) != Tail;
    assign OutValid = Tail != Head;
    assign DOut = FIFORAM[Tail];
    
    always @(posedge Clock) begin
        if (Reset) begin
            Head <= 0;
            Tail <= 0;
        end
        else begin
            if (InReady && InValid) begin
                FIFORAM[Head] <= DIn;
                Head <= (Head + 1) % (Depth + 1);
            end   
            if (OutReady && OutValid) begin
                Tail <= (Tail + 1) % (Depth + 1);
            end
        end
    end    
   
endmodule