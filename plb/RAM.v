module RAM
#(parameter DataWidth = 32, AddrWidth = 10)
(
    input Clock, Reset, Enable, Write,
    input [AddrWidth-1:0] Addr,
    
    input [DataWidth-1:0] DIn,
    output [DataWidth-1:0] DOut
);
 
    localparam NumEntry = 1 << AddrWidth;
    
    reg [DataWidth-1:0] Memory [NumEntry-1:0];   
    reg [AddrWidth-1:0] Addr_reg;
        
    initial begin
        for (integer i = 0; i < NumEntry; i = i+1) begin
            Memory[i] = $random;
            Memory[i][DataWidth-1] = 0;
        end    
    end
    
    always@(posedge Clock) begin
        if (Enable) begin
            Addr_reg <= Addr;
            if (Write) begin
                Memory[Addr] <= DIn;  
            end 
        end      
    end
 
    assign DOut = Memory[Addr_reg];
 
endmodule
