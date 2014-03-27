//==============================================================================
//      Section:        Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//      Module: AES
//      Desc: AES
//==============================================================================
module AESPathORAM
    (
     Clock, Reset,

     MIGAddr,
     MIGCmd,
     MIGCmdValid,
     MIGCmdReady,

     MIGOut,
     MIGOutMask,
     MIGOutValid,
     MIGOutReady,

     MIGIn,
     MIGInValid,

     BackendRData,
     BackendRValid,

     BackendWData,
     BackendWMask,
     BackendWValid,
     BackendWReady,

     DRAMCmdAddr,
     DRAMCmd,
     DRAMCmdValid,
     DRAMCmdReady,

     DRAMInitDone
     );

    //------------------------------------------------------------------------------
    //  Parameters & Constants
    //------------------------------------------------------------------------------

	`include "PathORAM.vh";
	`include "DDR3SDRAM.vh";
	`include "AES.vh";
	
    `include "DDR3SDRAMLocal.vh"
    `include "BucketDRAMLocal.vh"
    `include "BucketLocal.vh"
	
    localparam W = DDRDWidth / AESWidth;
    localparam D = AESDelay;

    localparam FIFO_D = D;

    localparam PATH_READ = 1;
    localparam PATH_WRITE = 0;

     //--------------------------------------------------------------------------
     // System I/O
     //--------------------------------------------------------------------------

     input                  Clock, Reset;

     //--------------------------------------------------------------------------
     // MIG <-> AES
     //--------------------------------------------------------------------------
	 
	 // TODO don't push MIGAddr through AES module
	 
     //AES -> MIG
     output [DDRAWidth-1:0] MIGAddr;
     output [DDRCWidth-1:0] MIGCmd;
     output                 MIGCmdValid;
     input                  MIGCmdReady;

     output [DDRDWidth-1:0] MIGOut;
     output [DDRMWidth-1:0] MIGOutMask;
     output                 MIGOutValid;
     input                  MIGOutReady;

     //MIG -> AES
     input [DDRDWidth-1:0]  MIGIn;
     input                  MIGInValid;

     //--------------------------------------------------------------------------
     // AES <-> BackEnd
     //--------------------------------------------------------------------------

     //AES -> Backend
     output [DDRDWidth-1:0] BackendRData;
     output                 BackendRValid;

     //BackEnd -> AES
     input [DDRDWidth-1:0]  BackendWData;
     input [DDRMWidth-1:0]  BackendWMask;
     input                  BackendWValid;
     output                 BackendWReady;

     input [DDRAWidth-1:0]  DRAMCmdAddr;
     input [DDRCWidth-1:0]  DRAMCmd;
     input                  DRAMCmdValid;
     output                 DRAMCmdReady;

     input                  DRAMInitDone;

    //------------------------------------------------------------------------------
    //	Wires & Regs
    //------------------------------------------------------------------------------

    reg                                            RW; //0: ORAM->MIG, 1: MIG->ORAM

    wire [IVEntropyWidth-1:0]                      IVDataIn;
    wire                                           IVDataInValid;
    wire                                           IVDataInAccept;
    wire [IVEntropyWidth-1:0]                      IVDataOut;
    wire                                           IVDataOutValid;
    wire                                           IVDataOutReady;

    wire [IVEntropyWidth-1:0]                      IVDupIn;
    wire                                           IVDupInValid;
    wire                                           IVDupInAccept;
    wire [IVEntropyWidth-1:0]                      IVDupOut;
    wire                                           IVDupOutValid;
    wire                                           IVDupOutReady;

    wire [AESWidth-1:0]                            Key;
    wire                                           KeyValid;
    wire                                           KeyReady;

    wire [W*AESWidth-1:0]                          AESDataIn;
    wire                                           AESDataInValid;
    wire                                           AESDataInAccept;
    wire [W*AESWidth-1:0]                          AESDataOut;
    wire                                           AESDataOutValid;
    wire                                           AESDataOutReady;

    wire [IVEntropyWidth-1:0]                      AESDWDataIn;
    wire                                           AESDWDataInValid;
    wire                                           AESDWDataInAccept;

    wire [W*AESWidth-1:0]                          AESResDataIn;
    wire                                           AESResDataInValid;
    wire                                           AESResDataInAccept;
    wire [W*AESWidth-1:0]                          AESResDataOut;
    wire                                           AESResDataOutValid;
    wire                                           AESResDataOutReady;

    wire                                           PathBuffer_InReady;
    wire [DDRDWidth-1:0]                           PathBuffer_OutData;
    wire                                           PathBuffer_OutValid;
    wire                                           PathBuffer_OutReady;

    wire                                           IsIV;
    reg                                            IVDone;

    wire [DDRDWidth-1:0]                           DataIn;
    wire                                           DataInValid;
    wire                                           DataInReady;

    wire [BktBSTWidth-1:0]                         BucketReadCtr;
    wire                                           BucketReadCtr_Reset;
    wire                                           ReadBucketTransition;

    wire [BktBSTWidth-1:0]                         DWBucketReadCtr;
    wire                                           DWBucketReadCtr_Reset;
    wire                                           DWBucketTransition;

    wire [BktBSTWidth-1:0]                         IVDeqCtr;
    wire                                           IVDeqCtr_Reset;
    wire                                           IVDeqTransition;

    wire [BktBSTWidth-1:0]                         AESBucketReadCtr;
    wire                                           AESBucketReadCtr_Reset;
    wire                                           AESReadBucketTransition;

    wire [`log2(PathSize_DRBursts)-1:0]            PathReadCtr;
    wire                                           PathReadCtr_Reset;
    wire                                           PathTransition;


    wire [DDRDWidth-1:0]                           DataOut;
    wire                                           DataOutValid;
    wire                                           DataOutReady;

    wire [DDRAWidth-1:0]                           MIGAddrOut;
    wire [DDRCWidth-1:0]                           MIGCmdOut;
    wire                                           MIGCmdOutValid;

    wire [DDRMWidth-1:0]                           MIGMaskOut;

    //used for enc/dec
    wire                                           IsAESIV;
    reg                                            AESIVDone;

    wire [DDRDWidth-1:0]                           XorRes;

    wire                                           DRAMCmdOutReady;
    wire                                           WriteMaskReady;
    wire                                           WriteMaskValid;

    wire                                           PassThroughCmd;
    wire                                           PassThroughW;
    wire                                           PassThroughR;

    wire [`log2(FIFO_D)-1:0]                       AESDataEmptyCount;
    reg                                            InitDone;

    reg [31:0]                                     numinp;
    reg [31:0]                                     numreadreq;
    reg [31:0]                                     numencdata;
    reg [31:0]                                     numdata;
    reg [31:0]                                     nummask;
    reg [31:0]                                     numaesin;
    reg [31:0]                                     numaesout;

    //------------------------------------------------------------------------------
    //  Debug
    //------------------------------------------------------------------------------

    always @( posedge Clock ) begin
        if (Reset) begin
            numinp <= 0;
            numdata <= 0;
            nummask <= 0;
            numreadreq <= 0;
            numencdata <= 0;
            numaesin <= 0;
            numaesout <= 0;
        end else begin
            if (BackendWValid & BackendWReady)
              numinp <= numinp + 1;
            if (DRAMCmdValid & DRAMCmdOutReady & (DRAMCmd == DDR3CMD_Read))
              numreadreq <= numreadreq + 1;
            if (DataOutValid)
              numencdata <= numencdata + 1;
            if (PathBuffer_OutValid & PathBuffer_OutReady)
              numdata <= numdata + 1;
            if (IVDataOutValid & AESDWDataInAccept)
              nummask <= nummask + 1;
            if (AESResDataOutValid & AESResDataOutReady)
              numaesout <= numaesout + 1;
        end
    end

    //------------------------------------------------------------------------------
    //  Control logic
    //------------------------------------------------------------------------------

    assign Key = {(AESWidth){1'b1}};
    assign KeyValid = 1;

    assign PassThroughCmd = 0; //~DRAMInitDone;//  |
                            // (DRAMInitDone & (DRAMCmd == DDR3CMD_Read));
    assign PassThroughW = 0; //~DRAMInitDone;
    assign PassThroughR = 0; //~DRAMInitDone;//  |
                          // ((DRAMCmd == DDR3CMD_Read) & DRAMCmdValid) |
                          // (RW == PATH_READ);

    always @( posedge Clock ) begin
        if (Reset) begin
            RW <= PATH_WRITE;
            InitDone <= 0;
        end
        else if (PathTransition)
          RW <= ~RW;
        else if (DRAMInitDone & (AESDataEmptyCount == FIFO_D) & ~InitDone) begin
            RW <= PATH_READ;
            InitDone <= 1;
        end
    end

    always @( posedge Clock ) begin
        if (Reset)
          IVDone <= 0;
        else if (~InitDone | ReadBucketTransition)
          IVDone <= 0;
        else if (IsIV & IVDataInValid & IVDataInAccept)
          IVDone <= 1;
    end

    always @( posedge Clock ) begin
        if (Reset)
          AESIVDone <= 0;
        else if (~InitDone | AESReadBucketTransition)
          AESIVDone <= 0;
        else if (IsAESIV & DataOutValid & DataOutReady)
          AESIVDone <= 1;
    end


    //------------------------------------------------------------------------------
    //  Check bucket
    //------------------------------------------------------------------------------

    wire ReadGood = DRAMInitDone & PathBuffer_OutValid & PathBuffer_OutReady;
    wire WriteGood = DRAMInitDone & BackendWValid & AESDataInAccept & WriteMaskReady;

    generate
        if (Overclock) begin:INBUF_BRAM
	    wire PathBuffer_Full, PathBuffer_Empty;

	    PathBuffer in_P_buf(.clk(Clock),
			        .srst(Reset),
			        .din(MIGIn),
			        .wr_en(MIGInValid),
			        .rd_en(PathBuffer_OutReady),
			        .dout(PathBuffer_OutData),
			        .full(PathBuffer_Full),
			        .empty(PathBuffer_Empty));
	    assign PathBuffer_InReady =	~PathBuffer_Full;
	    assign PathBuffer_OutValid = ~PathBuffer_Empty;
        end else begin:INBUF_LUTRAM
            FIFORAM#(.Width(DDRDWidth),
                     .Buffering(PathSize_DRBursts))
            in_P_buf(.Clock(Clock),
                     .Reset(Reset),
                     .InData(MIGIn),
                     .InValid(MIGInValid),
                     .InAccept(PathBuffer_InReady), //debugging
                     .OutData(PathBuffer_OutData),
                     .OutSend(PathBuffer_OutValid),
                     .OutReady(PathBuffer_OutReady));
        end // block: INBUF_LUTRAM
    endgenerate

    // Count where we are in a bucket (so we can determine when we are at a header)
    Counter#(.Width(BktBSTWidth))
    in_bkt_cnt(.Clock(Clock),
               .Reset(Reset | ReadBucketTransition),
               .Set(1'b0),
               .Load(1'b0),
               .Enable(DRAMInitDone & (ReadGood | WriteGood)), //read | write
               .In({BktBSTWidth{1'bx}}),
               .Count(BucketReadCtr)
               );

    CountCompare#(.Width(BktBSTWidth),
                  .Compare(BktSize_DRBursts - 1))
    in_bkt_cmp(.Count(BucketReadCtr),
               .TerminalCount(BucketReadCtr_Reset)
               );

    assign ReadBucketTransition = BucketReadCtr_Reset & (ReadGood | WriteGood);

    // Count number of already processed ivs
    Counter#(.Width(BktBSTWidth))
    ivdeq_cnt(.Clock(Clock),
              .Reset(Reset | IVDeqTransition),
              .Set(1'b0),
              .Load(1'b0),
              .Enable(IVDataOutValid & AESDWDataInAccept),
              .In({BktBSTWidth{1'bx}}),
              .Count(IVDeqCtr)
              );

    CountCompare#(.Width(BktBSTWidth),
                  .Compare(BktSize_DRBursts - 1))
    ivdeq_cmp(.Count(IVDeqCtr),
              .TerminalCount(IVDeqCtr_Reset)
              );

    assign IVDeqTransition = (IVDeqCtr_Reset & IVDataOutValid & AESDWDataInAccept) |
                             (~InitDone);


    //------------------------------------------------------------------------------
    //	MIG CMD FIFO and MASK
    //------------------------------------------------------------------------------

	// TODO [C F] why are command FIFOs necessary?
    FIFORAM#(.Width(DDRAWidth + DDRCWidth),
             .Buffering(FIFO_D)) //[AK]: what depth?
    cmd_fifo (.Clock(Clock),
              .Reset(Reset),
              .InData({DRAMCmdAddr, DRAMCmd}),
              .InValid(DRAMCmdValid),
              .InAccept(DRAMCmdOutReady),
              .OutData({MIGAddrOut, MIGCmdOut}),
              .OutSend(MIGCmdOutValid),
              .OutReady(MIGCmdReady)
              );

    //used only for write
    FIFORAM#(.Width(DDRMWidth),
             .Buffering(FIFO_D))
    mask_fifo (.Clock(Clock),
               .Reset(Reset),
               .InData(BackendWMask),
               .InValid(BackendWValid),
               .InAccept(WriteMaskReady),
               .OutData(MIGMaskOut),
               .OutSend(WriteMaskValid),
               .OutReady(MIGOutReady & (RW == PATH_WRITE) & DataOutValid)
               );


    //------------------------------------------------------------------------------
    //  IV and Data FIFO
    //------------------------------------------------------------------------------

    assign DataIn = BackendWValid ? BackendWData : PathBuffer_OutData;
    //both should never be valid
    assign DataInValid = (PathBuffer_OutValid  ^ (BackendWValid & BackendWReady));
    //same for path read/write
    assign DataInReady = ((IsIV & IVDataInAccept) | ~IsIV) & AESDataInAccept;

    assign IsIV = (BucketReadCtr == 0) & ~IVDone;

    assign IVDataIn = DataIn[IVEntropyWidth-1:0];
    assign IVDataInValid = IsIV & DataInValid;

    assign IVDupIn = DataIn[IVEntropyWidth-1:0];
    assign IVDupInValid = IsIV & DataInValid;

    assign AESDataIn = DataIn;
    assign AESDataInValid = DataInValid;

    assign PathBuffer_OutReady = DataInReady;

    //only remove IV when we are done with the bucket
    assign IVDataOutReady = IVDeqTransition;

    assign AESDataOutReady = AESResDataOutValid & DataOutReady;

    //only remove the duplicate IV when we output to MIG/Stash
    assign IVDupOutReady = IsAESIV & DataOutValid & DataOutReady;

    FIFORAM#(.Width(IVEntropyWidth),
             .Buffering(FIFO_D))
    iv_fifo (.Clock(Clock),
             .Reset(Reset),
             .InData(IVDataIn),
             .InValid(IVDataInValid),
             .InAccept(IVDataInAccept),
             .OutData(IVDataOut),
             .OutSend(IVDataOutValid),
             .OutReady(IVDataOutReady)
             );

    FIFORAM#(.Width(IVEntropyWidth),
             .Buffering(FIFO_D))
    ivdup_fifo (.Clock(Clock),
                .Reset(Reset),
                .InData(IVDupIn),
                .InValid(IVDupInValid),
                .InAccept(IVDupInAccept),
                .OutData(IVDupOut),
                .OutSend(IVDupOutValid),
                .OutReady(IVDupOutReady)
                );

    FIFORAM#(.Width(DDRDWidth),
             .Buffering(FIFO_D)) //what depth?
    data_fifo (.Clock(Clock),
               .Reset(Reset),
               .InData(AESDataIn),
               .InValid(AESDataInValid),
               .InAccept(AESDataInAccept),
               .InEmptyCount(AESDataEmptyCount),
               .OutData(AESDataOut),
               .OutSend(AESDataOutValid),
               .OutReady(AESDataOutReady)
               );


    //------------------------------------------------------------------------------
    //  AES_DW and result FIFO
    //------------------------------------------------------------------------------

    // Count where we are in a bucket (so we can determine when we are at a header)
    Counter#(.Width(BktBSTWidth))
    dw_in_bkt_cnt(.Clock(Clock),
                  .Reset(Reset | DWBucketTransition),
                  .Set(1'b0),
                  .Load(1'b0),
                  .Enable(InitDone & AESDWDataInValid & AESDWDataInAccept),
                  .In({BktBSTWidth{1'bx}}),
                  .Count(DWBucketReadCtr)
                  );

    CountCompare#(.Width(BktBSTWidth),
                  .Compare(BktSize_DRBursts - 1))
    dw_in_bkt_cmp(.Count(DWBucketReadCtr),
               .TerminalCount(DWBucketReadCtr_Reset)
               );

    assign DWBucketTransition = DWBucketReadCtr_Reset;

    assign AESDWDataIn = IVDataOut;
    assign AESDWDataInValid = IVDataOutValid;

    assign AESResDataOutReady = AESDataOutValid & DataOutReady;

    //[AK]: Need a ready signal?
    AES_DW #(.W(W),
             .D(D+1)) //+1 so you can enq/deq same cycle for D things
    aes_dw (.Clock(Clock),
            .Reset(Reset),

            //multiply is slow; shift instead?
            .DataIn(AESDWDataIn + (DWBucketReadCtr << `log2(W))),
            .DataInValid(AESDWDataInValid),
            .DataInReady(AESDWDataInAccept),

            .Key(Key),
            .KeyValid(KeyValid),
            .KeyReady(KeyReady),

            .DataOut(AESResDataIn),
            .DataOutValid(AESResDataInValid)
            );

    FIFORAM#(.Width(W*AESWidth),
             .Buffering(D+1))
    aesres_fifo (.Clock(Clock),
                 .Reset(Reset),
                 .InData(AESResDataIn),
                 .InValid(AESResDataInValid),
                 .InAccept(AESResDataInAccept),
                 .OutData(AESResDataOut),
                 .OutSend(AESResDataOutValid),
                 .OutReady(AESResDataOutReady)
                 );


    //------------------------------------------------------------------------------
    //  Enc/Dec
    //------------------------------------------------------------------------------

    //counts how many things we've encrypted
    Counter #(.Width(BktBSTWidth))
    in_bkt_aes_cnt(.Clock(Clock),
                   .Reset(Reset | AESReadBucketTransition),
                   .Set(1'b0),
                   .Load(1'b0),
                   .Enable(InitDone & DataOutValid & DataOutReady),
                   .In({BktBSTWidth{1'bx}}),
                   .Count(AESBucketReadCtr)
                   );

    CountCompare #(.Width(BktBSTWidth),
                   .Compare(BktSize_DRBursts - 1))
    in_bkt_aes_cmp(.Count(AESBucketReadCtr),
                   .TerminalCount(AESBucketReadCtr_Reset)
                   );

    assign AESReadBucketTransition = AESBucketReadCtr_Reset &
                                     DataOutValid & DataOutReady;

    assign IsAESIV = (AESBucketReadCtr == 0) & ~AESIVDone;
    assign XorRes = AESDataOut ^ AESResDataOut;

    //replace the IV portion with actual IV
    //don't need to worry about IVDupOutValid, since it gets enq same time as IV
    assign DataOut[DDRDWidth-1:IVEntropyWidth] = XorRes[DDRDWidth-1:IVEntropyWidth];
    assign DataOut[IVEntropyWidth-1:0] = IsAESIV & IVDupOutValid ? IVDupOut :
                                         XorRes[IVEntropyWidth-1:0];

    assign DataOutValid = AESDataOutValid & AESResDataOutValid;
    assign DataOutReady = (RW == PATH_READ) | ((RW == PATH_WRITE) & MIGOutReady);

    //------------------------------------------------------------------------------
    //  Path Counter
    //------------------------------------------------------------------------------

    Counter#(.Width(`log2(PathSize_DRBursts)))
    path_cnt(.Clock(Clock),
             .Reset(Reset | PathTransition),
             .Set(1'b0),
             .Load(1'b0),
             .Enable(InitDone & DataOutValid & DataOutReady),
             .In({`log2(PathSize_DRBursts){1'bx}}),
             .Count(PathReadCtr)
             );

    CountCompare#(.Width(`log2(PathSize_DRBursts)),
                  .Compare(PathSize_DRBursts - 1))
    path_cmp(.Count(PathReadCtr),
             .TerminalCount(PathReadCtr_Reset)
             );

    assign PathTransition = PathReadCtr_Reset & DataOutValid & DataOutReady;

    //------------------------------------------------------------------------------
    //  I/O assignment
    //------------------------------------------------------------------------------

    //Cmd related
    assign MIGAddr = PassThroughCmd ? DRAMCmdAddr : MIGAddrOut;
    assign MIGCmd = PassThroughCmd ? DRAMCmd : MIGCmdOut;
    assign MIGCmdValid = PassThroughCmd ? DRAMCmdValid : MIGCmdOutValid;
    assign DRAMCmdReady = PassThroughCmd ? MIGCmdReady : DRAMCmdOutReady;

    //BackendW related
    assign MIGOut = PassThroughW ? BackendWData : DataOut ;
    assign MIGOutMask = PassThroughW ? BackendWMask : MIGMaskOut;
    assign MIGOutValid = PassThroughW ? BackendWValid :
                         (RW == PATH_WRITE) & DataOutValid & WriteMaskValid;
    assign BackendWReady = PassThroughW ? MIGOutReady :
                           DataInReady & WriteMaskReady;

    //BackendR related
    assign BackendRData = PassThroughR ? MIGIn : DataOut;
    assign BackendRValid = PassThroughR ? MIGInValid :
                           (RW == PATH_READ) & DataOutValid;

endmodule
//--------------------------------------------------------------------------
