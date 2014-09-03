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

	           BackendWData,	BackendWValid,	BackendWReady,

	           DRAMInitDone
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

    localparam BktSize_AESChunks = (BktSize_BEDChunks * BEDWidth) / AESWidth;
    localparam BktHSize_AESChunks = (BktHSize_BEDChunks * BEDWidth) / AESWidth;
    localparam BktSizeAESWidth = `log2(BktSize_AESChunks/W);
    localparam PathSize_AESChunks = (PathSize_BEDChunks * BEDWidth) / AESWidth;
    localparam PathSizeAESWidth = `log2(PathSize_AESChunks/W);

    localparam IDWidth = W * AESWidth;

	localparam BktEnd_LOC = DDRDWidth / IDWidth - 1;
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

    input                        DRAMInitDone;

    //------------------------------------------------------------------------------
    //	Wires & Regs
    //------------------------------------------------------------------------------

    reg                          RW = PATH_WRITE; //0: ORAM->MIG, 1: MIG->ORAM

    wire [AESEntropy-1:0]        IVDataIn;
    wire                         IVDataInValid;
    wire                         IVDataInAccept;
    wire [AESEntropy-1:0]        IVDataOut;
    wire                         IVDataOutValid;
    wire                         IVDataOutReady;

    wire [AESEntropy-1:0]        IVDupIn;
    wire                         IVDupInValid;
    wire                         IVDupInAccept;
    wire [AESEntropy-1:0]        IVDupOut;
    wire                         IVDupOutValid;
    wire                         IVDupOutReady;

    wire [AESWidth-1:0]          Key;
    wire                         KeyValid;
    wire                         KeyReady;

    wire [IDWidth-1:0]           AESDataIn;
    wire                         AESDataInValid;
    wire                         AESDataInAccept;
    wire [IDWidth-1:0]           AESDataOut;
    wire                         AESDataOutValid;
    wire                         AESDataOutReady;

    wire [AESEntropy-1:0]        AESDWDataIn;
    wire                         AESDWDataInValid;
    wire                         AESDWDataInAccept;

    wire [IDWidth-1:0]           AESResDataIn;
    wire                         AESResDataInValid;
    wire                         AESResDataInAccept;
    wire [IDWidth-1:0]           AESResDataOut;
    wire                         AESResDataOutValid;
    wire                         AESResDataOutReady;

    wire                         IsIV;
    reg                          IVDone = 0;

    wire [IDWidth-1:0]           DataIn;
    wire                         DataInValid;
    wire                         DataInReady;

    wire [BktSizeAESWidth-1:0]   BucketReadCtr;
    wire                         BucketReadCtr_Reset;
    wire                         ReadBucketTransition;

    wire [BktSizeAESWidth-1:0]   DWBucketReadCtr;
    wire                         DWBucketReadCtr_Reset;
    wire                         DWBucketTransition;

    wire [BktSizeAESWidth-1:0]   IVDeqCtr;
    wire                         IVDeqCtr_Reset;
    wire                         IVDeqTransition;

    wire [BktSizeAESWidth-1:0]   AESBucketReadCtr;
    wire                         AESBucketReadCtr_Reset;
    wire                         AESReadBucketTransition;

    wire [PathSizeAESWidth-1:0]  PathReadCtr;
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

    wire [`log2(FIFO_D)-1:0]     AESDataEmptyCount;
    reg                          InitDone = 0;

    reg [31:0]                   numinp;
    reg [31:0]                   numencdata;
    reg [31:0]                   numdata;
    reg [31:0]                   numaesin;
    reg [31:0]                   numaesout;

    //------------------------------------------------------------------------------
    //  Input and Output buffers
    //------------------------------------------------------------------------------
    //internal signals to buffer to AESchunks
    wire [IDWidth-1:0]       DRAMReadData_Int;
    wire                           DRAMReadDataValid_Int;
    wire                           DRAMReadDataReady_Int;

    wire [IDWidth-1:0]       BackendWData_Int;
    wire                           BackendWValid_Int;
    wire                           BackendWReady_Int;

    wire [IDWidth-1:0]       DRAMWriteData_Int;
    wire                           DRAMWriteDataValid_Int;
    wire                           DRAMWriteDataReady_Int;

    wire [IDWidth-1:0]       BackendRData_Int;
    wire                           BackendRValid_Int;
    wire                           BackendRReady_Int;

    generate if (BEDWidth < AESWidth) begin: IOBuffer
        FIFOShiftRound#(.IWidth(BEDWidth),
                        .OWidth(IDWidth),
						.Reverse(1))
        dramin_fifo(.Clock(Clock),
                    .Reset(Reset),
                    .InData(DRAMReadData),
                    .InValid(DRAMReadDataValid),
                    .InAccept(DRAMReadDataReady),
                    .OutData(DRAMReadData_Int),
                    .OutValid(DRAMReadDataValid_Int),
                    .OutReady(DRAMReadDataReady_Int));

        FIFOShiftRound#(.IWidth(BEDWidth),
                        .OWidth(IDWidth),
						.Reverse(1))
        bein_fifo(.Clock(Clock),
                  .Reset(Reset),
                  .InData(BackendWData),
                  .InValid(BackendWValid),
                  .InAccept(BackendWReady),
                  .OutData(BackendWData_Int),
                  .OutValid(BackendWValid_Int),
                  .OutReady(BackendWReady_Int));

        FIFOShiftRound#(.IWidth(IDWidth),
                        .OWidth(BEDWidth),
						.Reverse(1))
        dramout_fifo(.Clock(Clock),
                     .Reset(Reset),
                     .InData(DRAMWriteData_Int),
                     .InValid(DRAMWriteDataValid_Int),
                     .InAccept(DRAMWriteDataReady_Int),
                     .OutData(DRAMWriteData),
                     .OutValid(DRAMWriteDataValid),
                     .OutReady(DRAMWriteDataReady));

        FIFOShiftRound#(.IWidth(IDWidth),
                        .OWidth(BEDWidth),
						.Reverse(1))
        beout_fifo(.Clock(Clock),
                   .Reset(Reset),
                   .InData(BackendRData_Int),
                   .InValid(BackendRValid_Int),
                   .InAccept(BackendRReady_Int),
                   .OutData(BackendRData),
                   .OutValid(BackendRValid),
                   .OutReady(BackendRReady));
    end else begin: Passthrough
        assign DRAMReadData_Int = DRAMReadData;
        assign DRAMReadDataValid_Int = DRAMReadDataValid;
        assign DRAMReadDataReady = DRAMReadDataReady_Int;

        assign BackendWData_Int = BackendWData;
        assign BackendWValid_Int = BackendWValid;
        assign BackendWReady = BackendWReady_Int;

        assign DRAMWriteData = DRAMWriteData_Int;
        assign DRAMWriteDataValid = DRAMWriteDataValid_Int;
        assign DRAMWriteDataReady_Int = DRAMWriteDataReady;

        assign BackendRData = BackendRData_Int;
        assign BackendRValid = BackendRValid_Int;
        assign BackendRReady_Int = BackendRReady;
    end
    endgenerate


    //------------------------------------------------------------------------------
    //  Debug
    //------------------------------------------------------------------------------

    always @( posedge Clock ) begin
        if (Reset) begin
            numinp <= 0;
            numdata <= 0;
            numencdata <= 0;
            numaesin <= 0;
            numaesout <= 0;
        end else begin
            if (BackendWValid_Int & BackendWReady_Int)
              numinp <= numinp + 1;
            if (DataOutValid)
              numencdata <= numencdata + 1;
            if (DRAMReadDataValid_Int & DRAMReadDataReady_Int)
              numdata <= numdata + 1;
            if (AESResDataOutValid & AESResDataOutReady)
              numaesout <= numaesout + 1;
        end
    end

    //------------------------------------------------------------------------------
    //  Control logic
    //------------------------------------------------------------------------------

    assign Key = {(AESWidth){1'b1}};
    assign KeyValid = 1;

    assign PassThroughW = 0; //~DRAMInitDone;
    assign PassThroughR = 0; //~DRAMInitDone;

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

    //------------------------------------------------------------------------------
    //  Check bucket
    //------------------------------------------------------------------------------

	reg [AESEntropy-1:0] DebugCounter = 0;
	
	always @( posedge Clock ) begin
	    if (Reset) begin
		    DebugCounter <= 0;
		end
		else if (ReadBucketTransition) begin
		    DebugCounter <= DebugCounter + 1;
		end
	end
	
    wire ReadGood = DRAMReadDataValid_Int & DRAMReadDataReady_Int;
    wire WriteGood = BackendWValid_Int & AESDataInAccept;

    // Count where we are in a bucket (so we can determine when we are at a header)
    Counter#(.Width(BktSizeAESWidth))
    in_bkt_cnt(.Clock(Clock),
               .Reset(Reset | ReadBucketTransition),
               .Set(1'b0),
               .Load(1'b0),
               .Enable(ReadGood | WriteGood), //read | write
               .In({BktSizeAESWidth{1'bx}}),
               .Count(BucketReadCtr)
               );

    CountCompare#(.Width(BktSizeAESWidth),
                  .Compare((BktSize_AESChunks/W) - 1))
    in_bkt_cmp(.Count(BucketReadCtr),
               .TerminalCount(BucketReadCtr_Reset)
               );

    assign ReadBucketTransition = 	(		
									(BucketReadCtr_Reset & InitDone) |
									((BucketReadCtr == BktEnd_LOC) & ~InitDone)
									) &
									(ReadGood | WriteGood);

    // Count number of already processed ivs
    Counter#(.Width(BktSizeAESWidth))
    ivdeq_cnt(.Clock(Clock),
              .Reset(Reset | IVDeqTransition),
              .Set(1'b0),
              .Load(1'b0),
              .Enable(IVDataOutValid & AESDWDataInAccept),
              .In({BktSizeAESWidth{1'bx}}),
              .Count(IVDeqCtr)
              );

    CountCompare#(.Width(BktSizeAESWidth),
                  .Compare((BktSize_AESChunks/W) - 1))
    ivdeq_cmp(.Count(IVDeqCtr),
              .TerminalCount(IVDeqCtr_Reset)
              );

    assign IVDeqTransition = (IVDeqCtr_Reset |
                              (~InitDone & (IVDeqCtr == (BktHSize_AESChunks/W-1)))) & //only header
                             IVDataOutValid & AESDWDataInAccept;

    //------------------------------------------------------------------------------
    //  IV and Data FIFO
    //------------------------------------------------------------------------------

    assign DataIn = BackendWValid_Int ? BackendWData_Int : DRAMReadData_Int;
    //both should never be valid
    assign DataInValid = (DRAMReadDataValid_Int ^ BackendWValid_Int);
    //same for path read/write
    assign DataInReady = ((IsIV & IVDataInAccept) | ~IsIV) & AESDataInAccept;

    assign IsIV = (BucketReadCtr == IV_LOC);

    assign IVDataIn = DataIn[AESEntropy-1:0];
    assign IVDataInValid = IsIV & DataInValid & AESDataInAccept;

    assign IVDupIn = DataIn[AESEntropy-1:0];
    assign IVDupInValid = IsIV & DataInValid & AESDataInAccept;

    assign AESDataIn = DataIn;
    assign AESDataInValid = DataInValid;

    assign DRAMReadDataReady_Int = DataInReady & InitDone;

    //only remove IV when we are done with the bucket
    assign IVDataOutReady = IVDeqTransition;

    assign AESDataOutReady = AESResDataOutValid & DataOutReady;

    //only remove the duplicate IV when we output to MIG/Stash
    assign IVDupOutReady = IsAESIV & DataOutValid & DataOutReady;

    FIFORAM#(.Width(AESEntropy),
             .Buffering(FIFO_D)
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

    FIFORAM#(.Width(AESEntropy),
             .Buffering(FIFO_D)
			`ifdef ASIC , .ASIC(1) `endif)
    ivdup_fifo (.Clock(Clock),
                .Reset(Reset),
                .InData(IVDupIn),
                .InValid(IVDupInValid),
                .InAccept(IVDupInAccept),
                .OutData(IVDupOut),
                .OutSend(IVDupOutValid),
                .OutReady(IVDupOutReady)
                );

    FIFORAM#(.Width(IDWidth),
             .Buffering(FIFO_D + BktHSize_BEDChunks)	
					//what depth? Good question, should be D (21) + Stash delay (# Headers in BEDChunks + plus something)
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
		if ((IVDataInValid && !IVDataInAccept) || (IVDupInValid && !IVDupInAccept)) begin
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
                  .In({BktSizeAESWidth{1'bx}}),
                  .Count(DWBucketReadCtr)
                  );

    CountCompare#(.Width(BktSizeAESWidth),
                  .Compare((BktSize_AESChunks/W) - 1))
    dw_in_bkt_cmp(.Count(DWBucketReadCtr),
                  .TerminalCount(DWBucketReadCtr_Reset)
                  );

    assign DWBucketTransition = (DWBucketReadCtr_Reset |
                                 ((DWBucketReadCtr == (BktHSize_AESChunks/W-1)) & ~InitDone)) &
                                AESDWDataInValid & AESDWDataInAccept;

    assign AESDWDataIn = IVDataOut;
    assign AESDWDataInValid = IVDataOutValid;

    assign AESResDataOutReady = AESDataOutValid & DataOutReady;

    AES_W #(.W(W))
    aes_w (.Clock(Clock),
           .Reset(Reset),

           .DataIn(AESDWDataIn + (DWBucketReadCtr << `log2(W))), // TODO: add BucketID to seed or move to global counter scheme
           .DataInValid(AESDWDataInValid),
           .DataInReady(AESDWDataInAccept),

           .Key(Key),
           .KeyValid(KeyValid),
           .KeyReady(KeyReady),

           .DataOut(AESResDataIn),
           .DataOutValid(AESResDataInValid)
           );

    FIFORAM#(.Width(W*AESWidth),
             .Buffering(D+1)
			 `ifdef ASIC , .ASIC(1) `endif)
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
    Counter #(.Width(BktSizeAESWidth))
    in_bkt_aes_cnt(.Clock(Clock),
                   .Reset(Reset | AESReadBucketTransition),
                   .Set(1'b0),
                   .Load(1'b0),
                   .Enable(DataOutValid & DataOutReady),
                   .In({`log2(BktSize_AESChunks/W){1'bx}}),
                   .Count(AESBucketReadCtr)
                   );

    CountCompare #(.Width(BktSizeAESWidth),
                   .Compare((BktSize_AESChunks/W) - 1))
    in_bkt_aes_cmp(.Count(AESBucketReadCtr),
                   .TerminalCount(AESBucketReadCtr_Reset)
                   );

    assign AESReadBucketTransition = (AESBucketReadCtr_Reset |
                                      ((AESBucketReadCtr == BktEnd_LOC) & ~InitDone)) &
                                     DataOutValid & DataOutReady;

    assign IsAESIV = (AESBucketReadCtr == IV_LOC);// & ~AESIVDone;
    assign XorRes = AESDataOut ^ AESResDataOut;

    //replace the IV portion with actual IV
    //don't need to worry about IVDupOutValid, since it gets enq same time as IV
    assign DataOut[IDWidth-1:AESEntropy] = XorRes[IDWidth-1:AESEntropy];
    assign DataOut[AESEntropy-1:0] = IsAESIV & IVDupOutValid ? IVDupOut :
                                     XorRes[AESEntropy-1:0];

    assign DataOutValid = AESDataOutValid & AESResDataOutValid;
    assign DataOutReady = ((RW == PATH_READ) & BackendRReady_Int) | ((RW == PATH_WRITE) & DRAMWriteDataReady_Int);

    //------------------------------------------------------------------------------
    //  Path Counter
    //------------------------------------------------------------------------------

    //only count path after we are done init
    Counter#(.Width(PathSizeAESWidth))
    path_cnt(.Clock(Clock),
             .Reset(Reset | PathTransition),
             .Set(1'b0),
             .Load(1'b0),
             .Enable(InitDone & DataOutValid & DataOutReady),
             .In({`log2(PathSize_AESChunks/W){1'bx}}),
             .Count(PathReadCtr)
             );

    CountCompare#(.Width(PathSizeAESWidth),
                  .Compare((PathSize_AESChunks/W) - 1))
    path_cmp(.Count(PathReadCtr),
             .TerminalCount(PathReadCtr_Reset)
             );

    assign PathTransition = PathReadCtr_Reset & DataOutValid & DataOutReady;


    //BackendW related
    assign DRAMWriteData_Int = PassThroughW ? BackendWData : DataOut ;
    assign DRAMWriteDataValid_Int = PassThroughW ? BackendWValid_Int : (RW == PATH_WRITE) & DataOutValid;
    assign BackendWReady_Int = PassThroughW ? DRAMWriteDataReady_Int : DataInReady;

    //BackendR related
    assign BackendRData_Int = PassThroughR ? DRAMReadData_Int : DataOut;
    assign BackendRValid_Int = PassThroughR ? DRAMReadDataValid_Int :
                               (RW == PATH_READ) & DataOutValid;

endmodule
//--------------------------------------------------------------------------
