//==============================================================================
//	Section: Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//  Module: 	AESPathORAM
//	Desc:
//==============================================================================
module AESPathORAM(
	Clock, Reset,

	MIGOut, MIGOutValid, MIGOutReady,
	MIGIn, MIGInValid, MIGInReady,

	BackendRData, BackendRValid, BackendRReady,
	BackendWData, BackendWValid, BackendWReady,

	DRAMInitDone
	);

	//--------------------------------------------------------------------------
	//  Parameters & Constants
	//--------------------------------------------------------------------------

	`include "PathORAM.vh";
	`include "DDR3SDRAM.vh";
	`include "AES.vh";

	`include "DDR3SDRAMLocal.vh"
	`include "BucketDRAMLocal.vh"
	`include "BucketLocal.vh"

	localparam				W = 					DDRDWidth / AESWidth;
	localparam 				D = 					AESDelay;

	localparam 				FIFO_D = 				D;

	localparam 				PATH_READ = 			1;
	localparam 				PATH_WRITE = 			0;

	//--------------------------------------------------------------------------
	// System I/O
	//--------------------------------------------------------------------------

	input                  Clock, Reset;

	//--------------------------------------------------------------------------
	// MIG <-> AES
	//--------------------------------------------------------------------------

	output [DDRDWidth-1:0]	MIGOut;
	output                 	MIGOutValid;
	input					MIGOutReady;

	input [DDRDWidth-1:0]	MIGIn;
	input					MIGInValid;
	output					MIGInReady;

	//--------------------------------------------------------------------------
	// AES <-> BackEnd
	//--------------------------------------------------------------------------

	output [DDRDWidth-1:0] 	BackendRData;
	output					BackendRValid;
	input					BackendRReady;

	input [DDRDWidth-1:0]	BackendWData;
	input                  	BackendWValid;
	output                 	BackendWReady;

	input                  	DRAMInitDone;

    //------------------------------------------------------------------------------
    //	Wires & Regs
    //------------------------------------------------------------------------------

	// TODO go through all signals and kill the ones that aren't used
	
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

    wire [DDRMWidth-1:0]                           MIGMaskOut;

    //used for enc/dec
    wire                                           IsAESIV;
    reg                                            AESIVDone;

    wire [DDRDWidth-1:0]                           XorRes;

    wire [`log2(FIFO_D)-1:0]                       AESDataEmptyCount;
    reg                                            InitDone;

    reg [31:0]                                     numinp;
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
            numencdata <= 0;
            numaesin <= 0;
            numaesout <= 0;
        end else begin
            if (BackendWValid & BackendWReady)
              numinp <= numinp + 1;
            if (DataOutValid)
              numencdata <= numencdata + 1;
            if (MIGInValid & MIGInReady)
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

    wire	ReadGood = 								DRAMInitDone & MIGInValid & MIGInReady;
    wire	WriteGood =  							DRAMInitDone & BackendWValid & AESDataInAccept;

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
    //  IV and Data FIFO
    //------------------------------------------------------------------------------

    assign DataIn = BackendWValid ? BackendWData : MIGIn;
    //both should never be valid
    assign DataInValid = (MIGInValid  ^ (BackendWValid & BackendWReady));
    //same for path read/write
    assign DataInReady = ((IsIV & IVDataInAccept) | ~IsIV) & AESDataInAccept;

    assign IsIV = (BucketReadCtr == 0) & ~IVDone;

    assign IVDataIn = DataIn[IVEntropyWidth-1:0];
    assign IVDataInValid = IsIV & DataInValid;

    assign IVDupIn = DataIn[IVEntropyWidth-1:0];
    assign IVDupInValid = IsIV & DataInValid;

    assign AESDataIn = DataIn;
    assign AESDataInValid = DataInValid;

    assign MIGInReady = DataInReady;

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

	wire ProcessingHeader;
	
	CountAlarm #(			.Threshold(				BktSize_DRBursts),
							.IThreshold(			0))
				bkt_cnt(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				InitDone & DataOutValid & DataOutReady),
							.Intermediate(			ProcessingHeader),
							.Done(					AESReadBucketTransition));	
								
    assign IsAESIV = ProcessingHeader & ~AESIVDone;
    assign XorRes = AESDataOut ^ AESResDataOut;

    //replace the IV portion with actual IV
    //don't need to worry about IVDupOutValid, since it gets enq same time as IV
    assign DataOut[DDRDWidth-1:IVEntropyWidth] = XorRes[DDRDWidth-1:IVEntropyWidth];
    assign DataOut[IVEntropyWidth-1:0] = IsAESIV & IVDupOutValid ? IVDupOut :
                                         XorRes[IVEntropyWidth-1:0];

    assign DataOutValid = AESDataOutValid & AESResDataOutValid;
    assign DataOutReady = ((RW == PATH_READ) & BackendRReady) | ((RW == PATH_WRITE) & MIGOutReady);

    //------------------------------------------------------------------------------
    //  Path Counter
    //------------------------------------------------------------------------------

	CountAlarm #(			.Threshold(				PathSize_DRBursts))
				pth_cnt(	.Clock(					Clock), 
							.Reset(					Reset), 
							.Enable(				InitDone & DataOutValid & DataOutReady),
							.Done(					PathTransition));
	
    //------------------------------------------------------------------------------
    //  I/O assignment
    //------------------------------------------------------------------------------

    assign 	MIGOut = 								DataOut;
    assign 	MIGOutValid = 							(RW == PATH_WRITE) & DataOutValid;
    assign 	BackendWReady = 						DataInReady;

    assign	BackendRData = 							DataOut;
    assign	BackendRValid = 						(RW == PATH_READ) & DataOutValid;

	//------------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
