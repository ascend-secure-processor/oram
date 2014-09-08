//==============================================================================
//      Section:        Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//      Module: AES
//      Desc: AES
//==============================================================================
module AESPathORAM(
	           Clock, Reset,

	           DRAMReadData, DRAMReadDataValid, DRAMReadDataReady,
	           DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,

	           BackendRData,	BackendRValid,	BackendRReady,

	           BackendWData,	BackendWValid,	BackendWReady
	           );

    //------------------------------------------------------------------------------
    //  Parameters & Constants
    //------------------------------------------------------------------------------

`include "PathORAM.vh";

`include "DDR3SDRAMLocal.vh"
`include "BucketLocal.vh"

    localparam W = (BEDWidth / AESWidth) == 0 ? 1 : BEDWidth / AESWidth;
    localparam D = 21;

    localparam FIFO_D = D;

    localparam BktSizeBED_Width = `log2(BktSize_BEDChunks);
    localparam PathSizeBED_Width = `log2(PathSize_BEDChunks);

    localparam IDWidth = W * AESWidth;

    localparam BktSize_AESChunks = (BktSize_BEDChunks * BEDWidth) / IDWidth;
    localparam BktHSize_AESChunks = (BktHSize_BEDChunks * BEDWidth) / IDWidth;
    localparam BktSizeAESWidth = `log2(BktSize_AESChunks);


    localparam IV_Delay = IDWidth/BEDWidth;

    localparam AESDataDepth = IV_Delay + 3;

    localparam BktHEnd_LOC = DDRDWidth/BEDWidth;
    localparam BktHEnd_LOC_AES = DDRDWidth/IDWidth;
    localparam IV_LOC = 0;	// or BktEnd_LOC, depending on whether FIFOShiftRound is reversed or not

    localparam PATH_READ = 1;
    localparam PATH_WRITE = 0;

    //--------------------------------------------------------------------------
    // System I/O
    //--------------------------------------------------------------------------

    input                        Clock, Reset;

    //--------------------------------------------------------------------------
    // MIG <-> AES
    //--------------------------------------------------------------------------

    output [BEDWidth-1:0]        DRAMWriteData;
    output                       DRAMWriteDataValid;
    input                        DRAMWriteDataReady;

    //MIG -> AES
    input [BEDWidth-1:0]         DRAMReadData;
    input                        DRAMReadDataValid;
    output                       DRAMReadDataReady;

    //--------------------------------------------------------------------------
    // AES <-> BackEnd
    //--------------------------------------------------------------------------

    //AES -> Backend
    output [BEDWidth-1:0]        BackendRData;
    output                       BackendRValid;
    input                        BackendRReady;

    //BackEnd -> AES
    input [BEDWidth-1:0]         BackendWData;
    input                        BackendWValid;
    output                       BackendWReady;

    //------------------------------------------------------------------------------
    //	Wires & Regs
    //------------------------------------------------------------------------------

    reg                          RW = PATH_WRITE; //0: ORAM->MIG, 1: MIG->ORAM
    wire [AESEntropy-1:0]        GlobalCounter;
    wire [AESEntropy-1:0]        GlobalCounter_Int;

    wire [AESEntropy-1:0]        IVDataIn;
    wire                         IVDataInValid;
    wire                         IVDataInAccept;
    wire [AESEntropy-1:0]        IVDataOut;
    wire                         IVDataOutValid;
    wire                         IVDataOutReady;

    wire [AESWidth-1:0]          Key;
    wire                         KeyValid;
    wire                         KeyReady;

    wire [BEDWidth-1:0]          AESDataIn;
    wire                         AESDataInValid;
    wire                         AESDataInAccept;
    wire [BEDWidth-1:0]          AESDataOut;
    wire                         AESDataOutValid;
    wire                         AESDataOutReady;

    wire [AESEntropy-1:0]        AESDWDataIn;
    wire                         AESDWDataInValid;
    wire                         AESDWDataInAccept;

    wire [IDWidth-1:0]           AESMaskIn;
    wire                         AESMaskInValid;
    wire                         AESMaskInAccept;
    wire [BEDWidth-1:0]          AESMaskOut;
    wire                         AESMaskOutValid;
    wire                         AESMaskOutReady;

    wire [BEDWidth-1:0]          AESMaskIn_BED;
    wire                         AESMaskInValid_BED;
    wire                         AESMaskInAccept_BED;

    wire                         IsIV;
    reg                          IVDone = 0;

    wire [IDWidth-1:0]           DataIn;
    wire                         DataInValid;
    wire                         DataInReady;

    wire [BktSizeBED_Width-1:0]  IVDeqCtr;
    wire                         IVDeqCtr_Reset;
    wire                         IVDeqTransition;

    wire [BktSizeBED_Width-1:0]  IVDelayCtr;
    wire                         IVDelayCtr_Reset;
    wire                         IVDelayTransition;
    // indicates when to load;
    // for bed<128, need to load every 128/bed cycles
    wire                         IVDelay_En;

    wire [BktSizeBED_Width-1:0]  BucketReadCtr;
    wire                         BucketReadCtr_Reset;
    wire                         ReadBucketTransition;

    wire [BktSizeAESWidth-1:0]   DWBucketReadCtr;
    wire                         DWBucketReadCtr_Reset;
    wire                         DWBucketTransition;

    wire [BktSizeBED_Width-1:0]  AESBucketReadCtr;
    wire                         AESBucketReadCtr_Reset;
    wire                         AESReadBucketTransition;

    wire [PathSizeBED_Width-1:0] PathReadCtr;
    wire                         PathReadCtr_Reset;
    wire                         PathTransition;

    wire [IDWidth-1:0]           DataOut;
    wire                         DataOutValid;
    wire                         DataOutReady;

    //used for enc/dec
    wire                         IsAESIV;
    reg                          AESIVDone = 0;

    wire [IDWidth-1:0]           XorRes;

    wire                         PassThroughW;
    wire                         PassThroughR;

    wire [`log2(AESDataDepth)-1:0] AESDataEmptyCount;
    reg                          InitDone = 0;

    //------------------------------------------------------------------------------
    //  Control logic
    //------------------------------------------------------------------------------

    assign Key = {(AESWidth){1'b1}};
    assign KeyValid = 1;

    assign PassThroughW = 0;
    assign PassThroughR = 0;

    always @( posedge Clock ) begin
        if (Reset) begin
            RW <= PATH_WRITE;
            InitDone <= 0;
        end
        else if (PathTransition)
          RW <= ~RW;
        else if ((AESDataEmptyCount == AESDataDepth) & ~InitDone) begin
            RW <= PATH_READ;
            InitDone <= 1;
        end
    end
    //------------------------------------------------------------------------------
    //  Keep global counter for AES
    //------------------------------------------------------------------------------
    Counter#(.Width(AESEntropy))
    glob_cnt(.Clock(Clock),
             .Reset(Reset),
             .Set(1'b0),
             .Load(1'b0),
             //update immediately after enq
             .Enable((RW == PATH_WRITE) &
                     IVDataInValid & IVDataInAccept),
             .In({AESEntropy{1'bx}}),
             .Count(GlobalCounter_Int)
             );
    assign GlobalCounter = GlobalCounter_Int + 1; //0 indicates invalid block now

    //------------------------------------------------------------------------------
    //  Check bucket
    //------------------------------------------------------------------------------

    wire ReadGood = DRAMReadDataValid & DRAMReadDataReady;
    wire WriteGood = BackendWValid & AESDataInAccept;

    // Count where we are in a bucket (so we can determine when we are at a header)
    Counter#(.Width(BktSizeBED_Width))
    in_bkt_cnt(.Clock(Clock),
               .Reset(Reset | ReadBucketTransition),
               .Set(1'b0),
               .Load(1'b0),
               .Enable(ReadGood | WriteGood), //read | write
               .In({BktSizeBED_Width{1'bx}}),
               .Count(BucketReadCtr)
               );

    CountCompare#(.Width(BktSizeBED_Width),
                  .Compare(BktSize_BEDChunks - 1))
    in_bkt_cmp(.Count(BucketReadCtr),
               .TerminalCount(BucketReadCtr_Reset)
               );

    assign ReadBucketTransition = ((BucketReadCtr_Reset & InitDone) |
				   ((BucketReadCtr == (BktHEnd_LOC - 1)) & ~InitDone)) &
				  (ReadGood | WriteGood);

    // Count number of already processed ivs
    Counter#(.Width(BktSizeBED_Width))
    ivdelay_cnt(.Clock(Clock),
                .Reset(Reset | IVDelayTransition),
                .Set(1'b0),
                .Load(1'b0),
                .Enable(IVDataOutValid & AESDWDataInAccept),
                .In({BktSizeBED_Width{1'bx}}),
                .Count(IVDelayCtr)
                );

    CountCompare#(.Width(BktSizeBED_Width),
                  .Compare(IV_Delay - 1))
    ivdelay_cmp(.Count(IVDelayCtr),
                .TerminalCount(IVDelayCtr_Reset)
                );

    assign IVDelayTransition = IVDelayCtr_Reset;
    assign IVDelay_En = IVDelayCtr == 0;

    // Count number of already processed ivs
    Counter#(.Width(BktSizeBED_Width))
    ivdeq_cnt(.Clock(Clock),
              .Reset(Reset | IVDeqTransition),
              .Set(1'b0),
              .Load(1'b0),
              .Enable(IVDataOutValid & AESDWDataInAccept),
              .In({BktSizeBED_Width{1'bx}}),
              .Count(IVDeqCtr)
              );

    CountCompare#(.Width(BktSizeBED_Width),
                  .Compare((BktSize_BEDChunks/IV_Delay) - 1))
    ivdeq_cmp(.Count(IVDeqCtr),
              .TerminalCount(IVDeqCtr_Reset)
              );

    //TODO: set this bkthend_loc to right number
    assign IVDeqTransition = (IVDeqCtr_Reset |
                              ((IVDeqCtr == (BktHEnd_LOC/IV_Delay-1)) & ~InitDone)) & //only header
                             IVDataOutValid & AESDWDataInAccept;

    //------------------------------------------------------------------------------
    //  IV and Data FIFO
    //------------------------------------------------------------------------------

    assign DataIn = BackendWValid ? BackendWData : DRAMReadData;
    //both should never be valid
    assign DataInValid = (DRAMReadDataValid ^ BackendWValid);
    //same for path read/write
    assign DataInReady = ((IsIV & IVDataInAccept) | ~IsIV) & AESDataInAccept;

    assign IsIV = (BucketReadCtr == IV_LOC);

    assign IVDataIn = (RW == PATH_READ) ? DataIn[AESEntropy-1:0] :
                      GlobalCounter;
    assign IVDataInValid = IsIV & DataInValid & AESDataInAccept;

    generate if (BEDWidth > AESEntropy) begin: BED_LARGER_AES
        assign AESDataIn[AESEntropy-1:0] = IsIV & (RW == PATH_WRITE) ?
                                           GlobalCounter :
                                           DataIn[AESEntropy-1:0];
        assign AESDataIn[BEDWidth-1:AESEntropy] = DataIn[BEDWidth-1:AESEntropy];
    end else if (BEDWidth == AESEntropy) begin: BED_LESS_AES
        assign AESDataIn = IsIV & (RW == PATH_WRITE) ? GlobalCounter : DataIn;
    end
    endgenerate
    assign AESDataInValid = DataInValid;

    assign DRAMReadDataReady = DataInReady & InitDone;

    //only remove IV when we are done with the bucket
    assign IVDataOutReady = IVDeqTransition;

    assign AESDataOutReady = AESMaskOutValid & DataOutReady;

    FIFORegister#(.Width(AESEntropy),
                  .Buffering(1+1)
                  `ifdef ASIC , .ASIC(1) `endif)
    iv_fifo (.Clock(Clock),
             .Reset(Reset),
             .InData(IVDataIn),
             .InValid(IVDataInValid),
             .InAccept(IVDataInAccept),
             .OutData(IVDataOut),
             .OutSend(IVDataOutValid),
             .OutReady(IVDataOutReady)
             );

    FIFORAM#(.Width(BEDWidth),
             .Buffering(AESDataDepth)
	     `ifdef ASIC , .ASIC(1) `endif)
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

    always @ (posedge Clock) begin
	if (AESDataInValid && !AESDataInAccept) begin
	    $display("Lose ciphertexts!");
	    $finish;
	end
	if ((IVDataInValid && !IVDataInAccept)) begin
	    $display("Lose ciphertexts!");
	    $finish;
	end
	if (AESDataInValid && !AESDataInAccept) begin
	    $display("Lose initial vectors!");
	    $finish;
	end
    end

    //------------------------------------------------------------------------------
    //  AES_W and result FIFO
    //------------------------------------------------------------------------------

    // Count where we are in a bucket (so we can determine when we are at a header)
    // Only count to header for init
    Counter#(.Width(BktSizeAESWidth))
    dw_in_bkt_cnt(.Clock(Clock),
                  .Reset(Reset | DWBucketTransition),
                  .Set(1'b0),
                  .Load(1'b0),
                  .Enable(AESDWDataInValid & AESDWDataInAccept),
                  .In({BktSizeBED_Width{1'bx}}),
                  .Count(DWBucketReadCtr)
                  );

    CountCompare#(.Width(BktSizeAESWidth),
                  .Compare(BktSize_AESChunks - 1))
    dw_in_bkt_cmp(.Count(DWBucketReadCtr),
                  .TerminalCount(DWBucketReadCtr_Reset)
                  );

    assign DWBucketTransition = (DWBucketReadCtr_Reset |
                                 ((DWBucketReadCtr == (BktHEnd_LOC_AES-1)) & ~InitDone)) &
                                AESDWDataInValid & AESDWDataInAccept;

    assign AESDWDataIn = IVDataOut;
    assign AESDWDataInValid = IVDataOutValid & IVDelay_En;

    assign AESMaskOutReady = AESDataOutValid & DataOutReady;

    AES_W #(.W(W),
            .AESWIn_Width(AESEntropy + BktSizeAESWidth))
    aes_w (.Clock(Clock),
           .Reset(Reset),

           .DataIn({AESDWDataIn, DWBucketReadCtr}),
           .DataInValid(AESDWDataInValid),
           .DataInReady(AESDWDataInAccept),

           .Key(Key),
           .KeyValid(KeyValid),
           .KeyReady(KeyReady),

           .DataOut(AESMaskIn),
           .DataOutValid(AESMaskInValid)
           );

    FIFOShiftRound#(.IWidth(IDWidth),
                    .OWidth(BEDWidth),
		    .Reverse(1))
    widemask_fifo(.Clock(Clock),
                  .Reset(Reset),
                  .InData(AESMaskIn),
                  .InValid(AESMaskInValid),
                  .InAccept(AESMaskInAccept),
                  .OutData(AESMaskIn_BED),
                  .OutValid(AESMaskInValid_BED),
                  .OutReady(AESMaskInAccept_BED)
                  );

    FIFORAM#(.Width(BEDWidth),
             .Buffering(BktSize_BEDChunks+1)
	     `ifdef ASIC , .ASIC(1) `endif)
    aesmask_fifo (.Clock(Clock),
                  .Reset(Reset),
                  .InData(AESMaskIn_BED),
                  .InValid(AESMaskInValid_BED),
                  .InAccept(AESMaskInAccept_BED),
                  .OutData(AESMaskOut),
                  .OutSend(AESMaskOutValid),
                  .OutReady(AESMaskOutReady)
                  );


    //------------------------------------------------------------------------------
    //  Enc/Dec
    //------------------------------------------------------------------------------

    //counts how many things we've encrypted
    Counter #(.Width(BktSizeBED_Width))
    in_bkt_aes_cnt(.Clock(Clock),
                   .Reset(Reset | AESReadBucketTransition),
                   .Set(1'b0),
                   .Load(1'b0),
                   .Enable(DataOutValid & DataOutReady),
                   .In({`log2(BktSize_AESChunks/W){1'bx}}),
                   .Count(AESBucketReadCtr)
                   );

    CountCompare #(.Width(BktSizeBED_Width),
                   .Compare(BktSize_BEDChunks - 1))
    in_bkt_aes_cmp(.Count(AESBucketReadCtr),
                   .TerminalCount(AESBucketReadCtr_Reset)
                   );

    assign AESReadBucketTransition = (AESBucketReadCtr_Reset |
                                      ((AESBucketReadCtr == (BktHEnd_LOC_AES - 1)) & ~InitDone)) &
                                     DataOutValid & DataOutReady;

    assign IsAESIV = (AESBucketReadCtr == IV_LOC);// & ~AESIVDone;
    assign XorRes = AESDataOut ^ AESMaskOut;

    //on read: IV passthrough
    //on write: replace with the global counter
    assign DataOut[IDWidth-1:AESEntropy] = XorRes[IDWidth-1:AESEntropy];
    assign DataOut[AESEntropy-1:0] = IsAESIV & (RW == PATH_WRITE) ?
                                     AESDataOut[AESEntropy-1:0] : //iv stored in aesdata
                                     XorRes[AESEntropy-1:0];

    assign DataOutValid = AESDataOutValid & AESMaskOutValid;
    assign DataOutReady = ((RW == PATH_READ) & BackendRReady) |
                          ((RW == PATH_WRITE) & DRAMWriteDataReady);

    //------------------------------------------------------------------------------
    //  Path Counter
    //------------------------------------------------------------------------------

    //only count path after we are done init
    Counter#(.Width(PathSizeBED_Width))
    path_cnt(.Clock(Clock),
             .Reset(Reset | PathTransition),
             .Set(1'b0),
             .Load(1'b0),
             .Enable(InitDone & DataOutValid & DataOutReady),
             .In({PathSizeBED_Width{1'bx}}),
             .Count(PathReadCtr)
             );

    CountCompare#(.Width(PathSizeBED_Width),
                  .Compare(PathSize_BEDChunks - 1))
    path_cmp(.Count(PathReadCtr),
             .TerminalCount(PathReadCtr_Reset)
             );

    assign PathTransition = PathReadCtr_Reset & DataOutValid & DataOutReady;


    //BackendW related
    assign DRAMWriteData = PassThroughW ? BackendWData : DataOut ;
    assign DRAMWriteDataValid = PassThroughW ? BackendWValid : (RW == PATH_WRITE) & DataOutValid;
    assign BackendWReady = PassThroughW ? DRAMWriteDataReady : DataInReady;

    //BackendR related
    assign BackendRData = PassThroughR ? DRAMReadData : DataOut;
    assign BackendRValid = PassThroughR ? DRAMReadDataValid :
                               (RW == PATH_READ) & DataOutValid;

endmodule
//--------------------------------------------------------------------------
