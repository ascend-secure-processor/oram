//==============================================================================
//      Section:        Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//      Module: AES
//      Desc: AES
//==============================================================================
module AESPathORAM #(`include "PathORAM.vh",
                     `include "DDR3SDRAM.vh",
                     `include "AES.vh")
    (
     //--------------------------------------------------------------------------
     // System I/O
     //--------------------------------------------------------------------------

     input                  Clock, Reset,

     //--------------------------------------------------------------------------
     // MIG <-> AES
     //--------------------------------------------------------------------------
     //AES -> MIG
     output [DDRAWidth-1:0] MIGAddr,
     output [DDRCWidth-1:0] MIGCmd,
     output                 MIGCmdValid,
     input                  MIGCmdReady,

     output [DDRDWidth-1:0] MIGOut,
     output [DDRMWidth-1:0] MIGOutMask,
     output                 MIGOutValid,
     input                  MIGOutReady,

     //MIG -> AES
     input [DDRDWidth-1:0]  MIGIn,
     input                  MIGInValid,


     //--------------------------------------------------------------------------
     // AES <-> BackEnd
     //--------------------------------------------------------------------------

     //AES -> Backend
     output [DDRDWidth-1:0] BackendRData,
     output                 BackendRValid,

     //BackEnd -> AES
     input [DDRDWidth-1:0]  BackendWData,
     input [DDRMWidth-1:0]  BackendWMask,
     input                  BackendWValid,
     output                 BackendWReady,

     input [DDRAWidth-1:0]  DRAMCmdAddr,
     input [DDRCWidth-1:0]  DRAMCmd,
     input                  DRAMCmdValid,
     output                 DRAMCmdReady
     );

    //------------------------------------------------------------------------------
    //  Constants
    //------------------------------------------------------------------------------

    `include "DDR3SDRAMLocal.vh"
    `include "BucketDRAMLocal.vh"
    `include "BucketLocal.vh"
    localparam W = DDRDWidth / AESWidth;
    localparam D = AESDelay;

    localparam PATH_READ = 1;
    localparam PATH_WRITE = 0;

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

    wire                                           Key;
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

    wire [DDRDWidth-1:0]                           DataIn;
    wire                                           DataInValid;
    wire                                           DataInReady;

    wire [BktBSTWidth-1:0]                         BucketReadCtr;
    wire                                           BucketReadCtr_Reset;
    wire                                           ReadBucketTransition;

    wire [BktBSTWidth-1:0]                         AESBucketReadCtr;
    wire                                           AESBucketReadCtr_Reset;
    wire                                           AESReadBucketTransition;

    wire [DDRDWidth-1:0]                           DataOut;
    wire                                           DataOutValid;
    wire                                           DataOutReady;

    wire [DDRAWidth-1:0]                           MIGAddrOut;
    wire [DDRCWidth-1:0]                           MIGCmdOut;
    wire                                           MIGCmdOutValid;

    //used for enc/dec
    wire                                           IsAESIV;
    wire [DDRDWidth-1:0]                           XorRes;

    wire [`log2(PathSize_DRBursts)-1:0]            PathCtr;
    wire                                           PathComplete;

    wire                                           WriteMaskReady;
    wire                                           WriteMaskValid;

    //------------------------------------------------------------------------------
    //  Control logic
    //------------------------------------------------------------------------------

    assign Key = 1;
    assign KeyValid = 1;

    //------------------------------------------------------------------------------
    //  Check bucket
    //------------------------------------------------------------------------------

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

    // Count where we are in a bucket (so we can determine when we are at a header)
    Counter#(.Width(BktBSTWidth))
    in_bkt_cnt(.Clock(Clock),
               .Reset(Reset | ReadBucketTransition),
               .Set(1'b0),
               .Load(1'b0),
               .Enable(PathBuffer_OutValid && PathBuffer_OutReady),
               .In({BktBSTWidth{1'bx}}),
               .Count(BucketReadCtr)
               );

    CountCompare#(.Width(BktBSTWidth),
                   .Compare(BktSize_DRBursts - 1))
    in_bkt_cmp(.Count(BucketReadCtr),
               .TerminalCount(BucketReadCtr_Reset)
               );

    assign ReadBucketTransition = AESResDataInAccept & BucketReadCtr_Reset &
                                  PathBuffer_OutValid & PathBuffer_OutReady;


    //------------------------------------------------------------------------------
    //	MIG CMD FIFO and MASK
    //------------------------------------------------------------------------------

    FIFOLinear#(.Width(DDRAWidth + DDRCWidth),
                .Depth(1024)) //[AK]: what depth?
    cmd_fifo (.Clock(Clock),
              .Reset(Reset),
              .InData({DRAMCmdAddr, DRAMCmd}),
              .InValid(DRAMCmdValid),
              .InAccept(DRAMCmdReady),
              .OutData({MIGAddrOut, MIGCmdOut}),
              .OutValid(MIGCmdOutValid),
              .OutReady(MIGCmdReady & DataOutReady)
              );

    FIFOLinear#(.Width(DDRMWidth),
                .Depth(1024)) //[AK]: what depth?
    mask_fifo (.Clock(Clock),
               .Reset(Reset),
               .InData(BackendWMask),
               .InValid(BackendWValid),
               .InAccept(WriteMaskReady),
               .OutData(MIGOutMask),
               .OutValid(WriteMaskValid),
               .OutReady(MIGCmdReady & DataOutReady)
               );


    //------------------------------------------------------------------------------
    //	Path counters (R/W)
    //------------------------------------------------------------------------------

    Counter#(.Width(`log2(PathSize_DRBursts)))
    in_path_cnt(.Clock(Clock),
                .Reset(Reset | PathComplete),
                .Set(1'b0),
                .Load(1'b0),
                .Enable(DataInValid),
                .In({(`log2(PathSize_DRBursts)){1'bx}}),
                .Count(PathCtr));

    CountCompare#(.Width(`log2(PathSize_DRBursts)),
                  .Compare(PathSize_DRBursts))
    in_path_cmp(.Count(PathCtr),
                .TerminalCount(PathComplete));

    always @( posedge Clock ) begin
        if (Reset)
            RW <= PATH_READ;
        else if (PathComplete)
            RW <= ~RW;
    end

    //------------------------------------------------------------------------------
    //  IV and Data FIFO
    //------------------------------------------------------------------------------

    assign DataIn = (RW == PATH_READ) ? PathBuffer_OutData : BackendWData;
    assign DataInValid = (RW == PATH_READ) ? PathBuffer_OutValid :
                         BackendWValid;
    //same for path read/write
    assign DataInReady = ((IsIV & IVDataInAccept) | ~IsIV) & AESDataInAccept;

    assign IsIV = BucketReadCtr == 0;

    assign IVDataIn = DataIn[IVEntropyWidth-1:0];
    assign IVDataInValid = IsIV & DataInValid;

    assign IVDupIn = DataIn[IVEntropyWidth-1:0];
    assign IVDupInValid = IsIV & DataInValid;

    assign AESDataIn = DataIn;
    assign AESDataInValid = DataInValid;

    assign PathBuffer_OutReady = DataInReady;

    //only remove IV when we are done with the bucket
    assign IVDataOutReady = ReadBucketTransition;

    assign AESDataOutReady = AESResDataOutValid && DataOutReady;

    //only remove the duplicate IV when we output to MIG/Stash
    assign IVDupOutReady = IsAESIV & DataOutValid & DataOutReady;

    FIFOLinear#(.Width(IVEntropyWidth),
                .Depth(D))
    iv_fifo (.Clock(Clock),
             .Reset(Reset),
             .InData(IVDataIn),
             .InValid(IVDataInValid),
             .InAccept(IVDataInAccept),
             .OutData(IVDataOut),
             .OutValid(IVDataOutValid),
             .OutReady(IVDataOutReady)
             );

    FIFOLinear#(.Width(IVEntropyWidth),
                .Depth(D))
    ivdup_fifo (.Clock(Clock),
                .Reset(Reset),
                .InData(IVDupIn),
                .InValid(IVDupInValid),
                .InAccept(IVDupInAccept),
                .OutData(IVDupOut),
                .OutValid(IVDupOutValid),
                .OutReady(IVDupOutReady)
                );

    FIFOLinear#(.Width(DDRDWidth),
                .Depth(1024)) //what depth?
    data_fifo (.Clock(Clock),
               .Reset(Reset),
               .InData(AESDataIn),
               .InValid(AESDataInValid),
               .InAccept(AESDataInAccept),
               .OutData(AESDataOut),
               .OutValid(AESDataOutValid),
               .OutReady(AESDataOutReady)
               );


    //------------------------------------------------------------------------------
    //  AES_DW and result FIFO
    //------------------------------------------------------------------------------

    assign AESDWDataIn = IVDataOut;
    assign AESDWDataInValid = IVDataOutValid;

    assign AESResDataOutReady = AESDataOutValid & DataOutReady;

    //[AK]: Need a ready signal?
    AES_DW #(.W(W),
             .D(D))
    aes_dw (.Clock(Clock),
            .Reset(Reset),

            //multiply is slow; shift instead?
            .DataIn(AESDWDataIn + (BucketReadCtr * W)),
            .DataInValid(AESDWDataInValid),
            .DataInReady(AESDWDataInReady),

            .Key(Key),
            .KeyValid(KeyValid),
            .KeyReady(KeyReady),

            .DataOut(AESResDataIn),
            .DataOutValid(AESResDataInValid)
            );

    FIFOLinear#(.Width(W*AESWidth),
                .Depth(D))
    aesres_fifo (.Clock(Clock),
                 .Reset(Reset),
                 .InData(AESResDataIn),
                 .InValid(AESResDataInValid),
                 .InAccept(AESResDataInAccept),
                 .OutData(AESResDataOut),
                 .OutValid(AESResDataOutValid),
                 .OutReady(AESResDataOutReady)
                 );

    //------------------------------------------------------------------------------
    //  Enc/Dec
    //------------------------------------------------------------------------------

    Counter #(.Width(BktBSTWidth))
    in_bkt_aes_cnt(.Clock(Clock),
                   .Reset(Reset || AESReadBucketTransition),
                   .Set(1'b0),
                   .Load(1'b0),
                   .Enable(AESResDataOutValid && AESDataOutValid),
                   .In({BktBSTWidth{1'bx}}),
                   .Count(AESBucketReadCtr)
                   );

    CountCompare #(.Width(BktBSTWidth),
                   .Compare(BktSize_DRBursts - 1))
    in_bkt_aes_cmp(.Count(AESBucketReadCtr),
                   .TerminalCount(AESBucketReadCtr_Reset)
                   );

    assign AESReadBucketTransition = AESBucketReadCtr_Reset &
                                     AESResDataOutValid & AESDataOutValid;

    assign IsAESIV = AESBucketReadCtr == 0;
    assign XorRes = AESDataOut ^ AESResDataOut;

    //replace the IV portion with actual IV
    //don't need to worry about IVDupOutValid, since it gets enq same time as IV
    assign DataOut[DDRDWidth-1:IVEntropyWidth] = XorRes[DDRDWidth-1:IVEntropyWidth];
    assign DataOut[IVEntropyWidth-1:0] = IsAESIV & IVDupOutValid ? IVDupOut :
                                         XorRes[IVEntropyWidth-1:0];

    assign DataOutValid = AESDataOutValid & AESResDataOutValid;
    assign DataOutReady = (RW == PATH_READ) | ((RW == PATH_WRITE) & MIGOutReady);


    //------------------------------------------------------------------------------
    //  I/O assignment
    //------------------------------------------------------------------------------

    assign MIGAddr = MIGAddrOut;
    assign MIGCmd = MIGCmdOut;
    assign MIGCmdValid = MIGCmdOutValid;

    assign MIGOut = DataOut;
    assign MIGOutValid = (RW == PATH_WRITE) & DataOutValid & WriteMaskValid;

    assign BackendRData = DataOut;
    assign BackEndRValid = (RW == PATH_READ) & DataOutValid;

    //probably can do better..
    assign BackendWReady = MIGOutReady & AESDataInAccept & WriteMaskReady;

endmodule
//--------------------------------------------------------------------------
