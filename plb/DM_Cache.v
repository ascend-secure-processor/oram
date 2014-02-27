`include "Const.vh"

module DM_Cache
#(parameter DataWidth = 32, LogLineSize = 4, Capacity = 32768, AddrWidth = 32, ExtraTagWidth = 32)
(
    input Clock, Reset,
    output Ready,
    input Enable,
    input [CacheCmdWidth-1:0] Cmd,        // 00 for write, 01 for read, 10 for refill, 11 for remove
    input [AddrWidth-1:0] AddrIn,
    input [DataWidth-1:0] DIn,
    input [ExtraTagWidth-1:0] ExtraTagIn,
 
    output OutValid,
    output Hit,   
    output [DataWidth-1:0] DOut,
    output Evicting,
    output [AddrWidth-1:0] AddrOut,
    output [ExtraTagWidth-1:0] ExtraTagOut
);
 
    `include "CacheLocal.vh";
    `include "CacheCmdLocal.vh";
 
    // Registers to hold input data
    wire [CacheCmdWidth-1:0] LastCmd;
    wire [AddrWidth-1:0] LastAddr;
    wire [DataWidth-1:0] LastDIn;
    wire [ExtraTagWidth-1:0] LastExtraTag;
    Register #(.Width(CacheCmdWidth))
        CmdReg (Clock, Reset, 1'b0, Ready && Enable, Cmd, LastCmd);
    Register #(.Width(AddrWidth))
        AddrReg (Clock, Reset, 1'b0, Ready && Enable, AddrIn, LastAddr);
    Register #(.Width(DataWidth))
        DInReg (Clock, Reset, 1'b0, Ready && Enable, DIn, LastDIn); 
    Register #(.Width(ExtraTagWidth))
        ExtraTagReg (Clock, Reset, 1'b0, Ready && Enable, ExtraTagIn, LastExtraTag);  
           
    // Cmd related states
    wire RefillStart, Refilling, RefillFinish;
    wire IsLastWrite, IsLastRefilling;
    Register #(.Width(1))
        WriteReg (  .Clock(Clock), .Reset(Reset), .Set(1'b0), .Enable(1'b1), 
                    .In(Enable && Ready && (Cmd == CacheWrite)), .Out(IsLastWrite));      
    Register #(.Width(1))
        RefillReg ( .Clock(Clock), .Reset(Reset), .Set(1'b0), .Enable(1'b1), 
                    .In(Refilling), .Out(IsLastRefilling)); 
    
    wire [LogLineSize-1:0] RefillOffset;
    Counter #(.Width(LogLineSize))
        RefillCounter (Clock, Reset, 1'b0, 1'b0, Refilling, {LogLineSize{1'bx}}, RefillOffset); // load = set = 0, in= x  

    assign RefillStart = Enable && Ready && (Cmd == CacheRefill);
    assign RefillFinish = (LastCmd == CacheRefill) && (RefillOffset == RefillLatency - 1);
    assign Refilling = RefillStart || (Enable && LastCmd == CacheRefill && RefillOffset > 0);
    
    // initialization
    wire TagInit;   
    wire InitEnd;
    wire [TArrayAddrWidth-1:0] InitTArrayAddr;
    Register #(.Width(1))
        TagInitReg (.Clock(Clock), .Reset(InitEnd), .Set(Reset), .Enable(1'b0), .Out(TagInit));
    Counter #(.Width(TArrayAddrWidth))
        TagInitCounter (Clock, Reset, 1'b0, 1'b0, TagInit, {TArrayAddrWidth{1'bx}}, InitTArrayAddr); // load = set = 0, in= x      
    CountCompare #(.Width(TArrayAddrWidth), .Compare((1 << TArrayAddrWidth) - 1))
        PosMapInitCountCmp(InitTArrayAddr, InitEnd);
        
    assign Ready = RefillOffset == 0 && !IsLastWrite && !TagInit;
    
    // control signals for data and tag arrays
    wire DataEnable, TagEnable, DataWrite, TagWrite;
    
    assign DataEnable = Enable || (IsLastWrite && Hit);
    assign DataWrite = DataEnable && (IsLastWrite || Refilling);
    assign TagEnable = TagInit || (Enable && (Ready || RefillFinish));
    assign TagWrite = TagInit || (TagEnable && RefillFinish);
    
    // addresses for data and tag arrays
    wire [AddrWidth-1:0] Addr;
    wire [TArrayAddrWidth-1:0] TArrayAddr; 
    wire [DArrayAddrWidth-1:0] DArrayAddr;
    wire [LogLineSize-1:0] Offset;
    
    assign Addr = Ready ? AddrIn : LastAddr;
    assign TArrayAddr = TagInit ? InitTArrayAddr : ((Addr >> LogLineSize) % NumLines);
    assign Offset = Addr[LogLineSize-1:0] + RefillOffset;
    assign DArrayAddr = (TArrayAddr << LogLineSize) + Offset;  
     
    // IO for data and tag arrays
    wire [DataWidth-1:0] DataIn;
    wire [TagWidth+ExtraTagWidth:0] TagIn, TagOut;
    
    assign TagIn = TagInit ? {1'b0, {TagWidth+ExtraTagWidth{1'bx}}} : {1'b1, LastExtraTag, Addr[AddrWidth-1:LogLineSize]};
    assign DataIn = IsLastWrite ? LastDIn : DIn;

    // data and tag array
    RAM #(.DWidth(DataWidth), .AWidth(DArrayAddrWidth)) 
        DataArray(Clock, Reset, DataEnable, DataWrite, DArrayAddr, DataIn, DOut);

    RAM #(.DWidth(TagWidth+1+ExtraTagWidth), .AWidth(TArrayAddrWidth)) 
        TagArray(Clock, Reset, TagEnable, TagWrite, TArrayAddr, TagIn, TagOut);  
 
    // output for cache outcome
    wire LineValid;
    assign LineValid = TagOut[TagWidth+ExtraTagWidth];

    Register #(.Width(1))
        OutValidReg (.Clock(Clock), .Reset(Reset), .Set(1'b0), .Enable(1'b1), .In(Enable && Ready), .Out(OutValid));
    assign Hit = (LastCmd == CacheWrite || LastCmd == CacheRead) && LineValid
                    && LastAddr[AddrWidth-1:LogLineSize] == TagOut[TagWidth-1:0];  // valid && tag match
    assign Evicting = IsLastRefilling && LineValid; // a valid line is there. danger: on refillFinish, cannot use new tag!
    assign AddrOut = TagOut[TagWidth-1:0] << LogLineSize;
    assign ExtraTagOut = TagOut[TagWidth+ExtraTagWidth-1:TagWidth];
        
    always@(posedge Clock) begin
        if (Ready && Enable) begin             
            if (Cmd == CacheRefill && Offset != 0) begin
                $display("Must provide an aligned address for refilling.");                       
                $finish;
            end       
        end
    end
endmodule
