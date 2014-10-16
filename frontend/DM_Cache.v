//==============================================================================
//	Module:		DM_Cache
//	Desc:		Direct mapped cache, specifically designed for PLB
//				Ready-valid interface for input command. 
//				Currently support Read/Write/Refill.
//==============================================================================

`include "Const.vh"

module DM_Cache
(	Clock, Reset, Ready, Enable, Cmd, AddrIn, DIn, ExtraTagIn, 
	OutValid, Hit, DOut, RefillDataReady, Evicting, AddrOut, ExtraTagOut
);
 
	parameter 	DataWidth = 32, 
				LogLineSize = 1, 
				Capacity = 64, 
				AddrWidth = 2, 
				ExtraTagWidth = 32;
	parameter   WriteLate = 0;
 
    `include "CacheLocal.vh"
    `include "CacheCmdLocal.vh"
 
    input Clock, Reset;
    output Ready;
    input Enable;
    input [CacheCmdWidth-1:0] Cmd;        // 00 for update, 01 for read, 10 for refill, 11 reserved (possibly for remove)
    input [AddrWidth-1:0] AddrIn;
    input [DataWidth-1:0] DIn;
    input [ExtraTagWidth-1:0] ExtraTagIn;
 
    output OutValid;
    output Hit;  
    output [DataWidth-1:0] DOut;
    output RefillDataReady;
    output Evicting;
    output [AddrWidth-1:0] AddrOut;
    output [ExtraTagWidth-1:0] ExtraTagOut;

    // Registers to hold input data
	wire CmdTransfer;
    wire [CacheCmdWidth-1:0] LastCmd;
    wire [AddrWidth-1:0] LastAddr;
    wire [DataWidth-1:0] LastDIn;
    wire [ExtraTagWidth-1:0] LastExtraTag;
	assign CmdTransfer = Ready && Enable;
    Register #(			.Width(		CacheCmdWidth + AddrWidth + DataWidth + ExtraTagWidth))
		InputReg	(	.Clock(		Clock),
						.Reset(		1'b0),	.Set(		1'b0),
						.Enable(	CmdTransfer),
						.In(		{Cmd, AddrIn, DIn, ExtraTagIn}),
						.Out(		{LastCmd, LastAddr, LastDIn, LastExtraTag})
					);	

    // Refill and write related states
	// Write needs to first lookup, and write only if it hits; blindly writing will correct some other cachelines
    wire RefillStart, Refilling, RefillFinish, RefillWriting;
    wire IsLastWrite, IsLastRefilling;
    Pipeline #(.Width(1), .Stages(1))
        WriteReg  (	Clock,	Reset,	CmdTransfer && (Cmd == CacheWrite),	IsLastWrite);  
    Pipeline #(.Width(1), .Stages(1))
        RefillReg (	Clock,	Reset,	Refilling,	IsLastRefilling);
    
    wire [LogLineSize:0] RefillOffset; 	// RefillOffset[LogLineSize:1] is the addr offset, the last bit is evict/refill
    Counter #(.Width(LogLineSize+1))
        RefillCounter (Clock, Reset, 1'b0, 1'b0, Refilling, {(LogLineSize+1){1'bx}}, RefillOffset); // load = set = 0, in= x  

    assign RefillStart = CmdTransfer && (Cmd == CacheRefill);
    assign RefillFinish = (LastCmd == CacheRefill) && (RefillOffset + 32'd1 == 32'd1 << LogLineSize);
    assign Refilling = RefillStart || (LastCmd == CacheRefill && RefillOffset > 0);
    assign RefillWriting = Refilling && RefillOffset[0];
    
    assign RefillDataReady = RefillWriting;
    
    // initialization
    wire TagInit;   
    wire InitEnd;
    wire [TArrayAddrWidth-1:0] InitTArrayAddr;
    Register1b TagInitReg	( Clock, InitEnd, Reset, TagInit);
	CountAlarm #(			.Threshold(				1 << TArrayAddrWidth))
		TagInitCounter (	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				TagInit),
							.Count(					InitTArrayAddr),
							.Done(					InitEnd)
						);
        
    assign Ready = RefillOffset == 0 && !IsLastWrite && !TagInit;
    
    // control signals for data and tag arrays
    wire DataEnable, TagEnable, DataWrite, TagWrite;
    
    assign DataEnable = Enable || (IsLastWrite && Hit) || Refilling;
    assign DataWrite = IsLastWrite || RefillWriting;
    assign TagEnable = TagInit || RefillFinish || CmdTransfer;
    assign TagWrite = TagInit || RefillFinish;
    
    // addresses for data and tag arrays
    wire [AddrWidth-1:0] Addr;
    wire [TArrayAddrWidth-1:0] TArrayAddr; 
    wire [DArrayAddrWidth-1:0] DArrayAddr;
    wire [LogLineSize-1:0] Offset;
    
    assign Addr = Ready ? AddrIn : LastAddr;
    assign TArrayAddr = TagInit ? InitTArrayAddr : ((Addr >> LogLineSize) % NumLines);
    assign Offset = Addr[LogLineSize-1:0] + (RefillOffset >> 1);
    assign DArrayAddr = (TArrayAddr << LogLineSize) + Offset;  
     
    // IO for data and tag arrays
    wire [DataWidth-1:0] DataIn;
    wire [TagWidth+ExtraTagWidth:0] TagIn, TagOut;
    
    assign TagIn = TagInit ? {1'b0, {TagWidth+ExtraTagWidth{1'bx}}} : {1'b1, LastExtraTag, Addr[AddrWidth-1:LogLineSize]};
    assign DataIn = (IsLastWrite && !WriteLate) ? LastDIn : DIn;

    // data and tag array
    RAM #(.DWidth(DataWidth), .AWidth(DArrayAddrWidth)  `ifndef FPGA_MEMORY , .SRAM(1) `endif ) 
        DataArray(Clock, Reset, DataEnable, DataWrite, DArrayAddr, DataIn, DOut);

    RAM #(.DWidth(TagWidth+1+ExtraTagWidth), .AWidth(TArrayAddrWidth) `ifndef FPGA_MEMORY , .SRAM(1) `endif ) 
        TagArray(Clock, Reset, TagEnable, TagWrite, TArrayAddr, TagIn, TagOut);  
 
    // output for cache outcome
	Pipeline #(.Width(1), .Stages(1))
        OutValidReg (	Clock,	Reset,	CmdTransfer,	OutValid);
		
    wire LineValid;
    assign LineValid = TagOut[TagWidth+ExtraTagWidth];	
    assign Hit = (LastCmd == CacheWrite || LastCmd == CacheRead) && LineValid
                    && LastAddr[AddrWidth-1:LogLineSize] == TagOut[TagWidth-1:0];  // valid && tag match
    assign Evicting = IsLastRefilling && LineValid && RefillWriting; 
            // a valid line is there, and we read in last cycle. Danger: on refillFinish, cannot use new tag!
    assign AddrOut = TagOut[TagWidth-1:0] << LogLineSize;
    assign ExtraTagOut = TagOut[TagWidth+ExtraTagWidth-1:TagWidth];
     
`ifdef SIMULATION   
    always@(posedge Clock) begin
        if (Ready && Enable) begin             
            if (Cmd == CacheRefill && Offset != 0) begin
                $display("Must provide an aligned address for refilling.");                       
                $finish;
            end       
        end
    end
`endif
endmodule
