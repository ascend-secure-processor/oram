`include "Const.vh"

module UORamDataPath
(	Clock, Reset, SwitchReq, DataBlockReq, Cmd, ExpectingProgramData,
	DataInReady, DataInValid, DataIn,
	ReturnDataReady, ReturnDataValid, ReturnData,
    PPPEvictDataReady, PPPEvictDataValid, PPPEvictData,
    PPPRefillDataReady, PPPRefillDataValid, PPPRefillData,
    StoreDataReady, StoreDataValid, StoreData,
    LoadDataReady, LoadDataValid, LoadData,

	DumbRequest // to satisfy microblaze
);

	`include "UORAM.vh";
	`include "PathORAM.vh";
	`include "PLB.vh";

    `include "PathORAMBackendLocal.vh"
    `include "CacheCmdLocal.vh"
    `include "PLBLocal.vh"

    input Clock, Reset;

    // input control state, output data state
    input SwitchReq;
    input DataBlockReq;
    input [BECMDWidth-1:0] Cmd;

    output ExpectingProgramData;

    // receive data from network
    output DataInReady;
    input DataInValid;
    input [FEDWidth-1:0] DataIn;

    // return data to network
    input  ReturnDataReady;
    output ReturnDataValid;
    output [FEDWidth-1:0] ReturnData;

    // receive data from PLB
    output PPPEvictDataReady;
    input  PPPEvictDataValid;
    input  [LeafWidth-1:0] PPPEvictData;

    // return data to PLB
    input  PPPRefillDataReady;
    output PPPRefillDataValid;
    output [LeafWidth-1:0] PPPRefillData;

    // send data to backend
    input  StoreDataReady;
    output StoreDataValid;
    output [FEDWidth-1:0] StoreData;

    // receive response from backend
    output LoadDataReady;
    input  LoadDataValid;
    input  [FEDWidth-1:0] LoadData;

    input   DumbRequest;

    // PPPEvictBuffer
	(* mark_debug = "TRUE" *) wire PPPEvictDataValid_Reg;
	(* mark_debug = "FALSE" *) wire [LeafWidth-1:0] PPPEvictData_Reg;

    (* mark_debug = "TRUE" *) wire EvictBufferOutReady, EvictBufferOutValid;
    (* mark_debug = "FALSE" *) wire [LeafWidth-1:0] EvictBufferDOut;

	Pipeline 	#(	.Width(LeafWidth+1), .Stages(1))
		EvictReg	(	Clock,	 1'b0,	{PPPEvictDataValid, PPPEvictData}, {PPPEvictDataValid_Reg, PPPEvictData_Reg});

    FIFORAM #(.Width(LeafWidth), .Buffering(LeafInBlock))
        EvictBuffer (   .Clock(Clock),
                        .Reset(Reset),
                        .InAccept(PPPEvictDataReady),
                        .InValid(PPPEvictDataValid_Reg),
                        .InData(PPPEvictData_Reg),
                        .OutReady(EvictBufferOutReady),
                        .OutSend(EvictBufferOutValid),
                        .OutData(EvictBufferDOut)
                    );


    // Funnel for PPPEvictBuffer --> BackEnd
    (* mark_debug = "TRUE" *) wire EvictFunnelOutValid;
    (* mark_debug = "FALSE" *) wire [FEDWidth-1:0] EvictFunnelDOut;

    FIFOShiftRound #(.IWidth(LeafWidth), .OWidth(FEDWidth))
        EvictFunnel (   .Clock(Clock),
                        .Reset(Reset),
                        .InAccept(EvictBufferOutReady),
                        .InValid(EvictBufferOutValid),
                        .InData(EvictBufferDOut),
                        .OutReady(StoreDataReady),
                        .OutValid(EvictFunnelOutValid),
                        .OutData(EvictFunnelDOut)
                    );

    // Funnel for LoadData --> PPPRefillData
    (* mark_debug = "TRUE" *) wire RefillFunnelReady, RefillFunnelValid;

    FIFOShiftRound #(.IWidth(FEDWidth), .OWidth(LeafWidth))
        RefillFunnel (  .Clock(Clock),
                        .Reset(Reset),
                        .InAccept(RefillFunnelReady),
                        .InValid(RefillFunnelValid),
                        .InData(LoadData),
                        .OutReady(PPPRefillDataReady),
                        .OutValid(PPPRefillDataValid),
                        .OutData(PPPRefillData)
                    );

    // control signal
    (* mark_debug = "TRUE" *) wire ExpectingPosMapBlock, ExpectingDataBlock, ExpectingProgStore;
    (* mark_debug = "FALSE" *) wire [LogFEORAMBChunks-1:0] ProgDataCounter;
    (* mark_debug = "TRUE" *) wire DataReturnTransfer, DataInTransfer, ProgCounterInc, DataTransferEnd;

    assign ExpectingProgramData =  ExpectingDataBlock || ExpectingProgStore;
    assign DataReturnTransfer = ReturnDataReady && ReturnDataValid;
    assign DataInTransfer = DataInValid && DataInReady;
    assign ProgCounterInc = DataReturnTransfer || DataInTransfer;

    Register #(.Width(1))
        ExpectingPosMapBlockReg (   .Clock(     Clock),
                                    .Reset(     Reset),
                                    .Set(       1'b0),
                                    .Enable(    SwitchReq),
                                    .In(        !DataBlockReq),
                                    .Out(       ExpectingPosMapBlock));
    Register #(.Width(1))
        ExpectingDataBlockReg (     .Clock(     Clock),
                                    .Reset(     Reset || DataTransferEnd),
                                    .Set(       1'b0),
                                    .Enable(    SwitchReq),
                                    .In(        DataBlockReq && (Cmd == BECMD_Read || Cmd == BECMD_ReadRmv)),
                                    .Out(       ExpectingDataBlock));
    Register #(.Width(1))
        ExpectingProgStoreReg (     .Clock(     Clock),
                                    .Reset(     Reset || DataTransferEnd),
                                    .Set(       1'b0),
                                    .Enable(    SwitchReq),
                                    .In(        DataBlockReq && (Cmd == BECMD_Append || Cmd == BECMD_Update)),
                                    .Out(       ExpectingProgStore));

	// -------------- read non-existent block ----------------
	(* mark_debug = "FALSE" *) wire	FakeAccess, FakeStoring, FakeLoading, FakeStoreEnd, FakeLoadEnd;
	Register #(.Width(1))
        FakeAccessReg 	(   .Clock(     Clock),
							.Reset(     Reset || (!FakeStoring && !FakeLoading)),
							.Set(       1'b0),
							.Enable(    SwitchReq),
							.In(        DataBlockReq && DumbRequest && (Cmd == BECMD_Read || Cmd == BECMD_ReadRmv)),
							.Out(       FakeAccess));

	CountAlarm #(		.Threshold(				FEORAMBChunks))
		FakeProgStCtr (	.Clock(					Clock),
						.Reset(					Reset),
						.Enable(				StoreDataReady && StoreDataValid),
						.Done(					FakeStoreEnd)
					);

	CountAlarm #(		.Threshold(				FEORAMBChunks))
		FakeProgLdCtr (	.Clock(					Clock),
						.Reset(					Reset),
						.Enable(				ReturnDataReady && ReturnDataValid),
						.Done(					FakeLoadEnd)
					);

	Register1b FakeStEndReg(   	.Clock(     Clock),
								.Reset(     Reset || FakeStoreEnd),
								.Set(       SwitchReq && DataBlockReq && DumbRequest && (Cmd == BECMD_Read || Cmd == BECMD_ReadRmv)),
								.Out(       FakeStoring));

	Register1b FakeLdEndReg(   	.Clock(     Clock),
								.Reset(     Reset || FakeLoadEnd),
								.Set(       SwitchReq && DataBlockReq && DumbRequest && (Cmd == BECMD_Read || Cmd == BECMD_ReadRmv)),
								.Out(       FakeLoading));

	localparam		FakeData = {(FEDWidth/32){32'h00af1234}};						
								
	// ---------------------------------------------------------

	CountAlarm #(		.Threshold(				FEORAMBChunks))
		ProgCounter (	.Clock(					Clock),
						.Reset(					Reset),
						.Enable(				ProgCounterInc),
						.Count(					ProgDataCounter),
						.Done(					DataTransferEnd)
					);

    // if ExpectingProgStore, network ==> backend; otherwise PLB ==> backend
    assign StoreDataValid = FakeStoring || (ExpectingProgStore ? DataInValid : EvictFunnelOutValid);
    assign StoreData = FakeStoring ? FakeData		// TODO: fake stuff
						: ExpectingProgStore ? DataIn : EvictFunnelDOut;
    assign DataInReady = ExpectingProgStore && StoreDataReady;

    // if ExpectingDataBlock, backend ==> network; if ExpectingPosMapBlock, backend ==> PLB
    assign LoadDataReady = ExpectingDataBlock ? ReturnDataReady : RefillFunnelReady;    // PLB refill is always ready
    assign RefillFunnelValid = ExpectingPosMapBlock && LoadDataValid;
    assign ReturnDataValid = FakeLoading || (ExpectingDataBlock && LoadDataValid);
    assign ReturnData = FakeLoading ? FakeData		// TODO: fake stuff
							: LoadData;

`ifdef SIMULATION
    always @(posedge Clock) begin
        if (!ExpectingDataBlock && !ExpectingPosMapBlock && LoadDataValid) begin
            $display("Error: unexpected backend response");
            $finish;
        end
        if (SwitchReq && ProgDataCounter) begin
            $display("Error: last packet transfer not finished");
            $finish;
        end
    end
`endif

endmodule
