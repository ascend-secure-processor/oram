//==============================================================================
//	Module:		UORAMController
//	Desc:		Unified ORAM control logic.
//				Interface with outside: (op, addr, data)
//				Interface with backend: (op, addr, leaf, leaf', data)		
//				Separate ready-valid interface for cmd and data
//				Currently support Read/Write/Append/Read_Rmv.
//				Append/Read_Rmv are for PosMap blocks; Append is also used to initialize a block
//
//				Two major phases in this module: Prepare and Accessing
//				Prepare: keep looking up PPP until a hit
//				Access: in the reserve order, issue accesses and refill PLB
//==============================================================================

`include "Const.vh"

module UORAMController
(
    Clock, Reset,
    CmdInReady, CmdInValid, CmdIn, ProgAddrIn, WMaskIn,
    DataInReady, DataInValid, DataIn,
    ReturnDataReady, ReturnDataValid, ReturnData,
    CmdOutReady, CmdOutValid, CmdOut, AddrOut, WMaskOut, OldLeaf, NewLeaf,
	StoreDataReady, StoreDataValid, StoreData,
    LoadDataReady, LoadDataValid, LoadData,
	
	JTAG_UORAM
);

	`include "PathORAM.vh"
	`include "UORAM.vh"
	
	`include "DMLocal.vh"
    `include "CommandsLocal.vh"
    `include "CacheCmdLocal.vh"
    `include "PLBLocal.vh"
	`include "JTAG.vh"
	
    localparam MaxLogRecursion = 4;

    input Clock, Reset;

    // receive command from network
    output CmdInReady;
    input CmdInValid;
    input [BECMDWidth-1:0] CmdIn;
    input [ORAMU-1:0] ProgAddrIn;
	input [DMWidth-1:0] WMaskIn;

    // receive data from network
    output DataInReady;
    input DataInValid;
    input [FEDWidth-1:0] DataIn;

    // return data to network
    input  ReturnDataReady;
    output ReturnDataValid;
    output [FEDWidth-1:0] ReturnData;

    // send request to backend
    input  CmdOutReady;
    output CmdOutValid;
    output [BECMDWidth-1:0] CmdOut;
    output [ORAMU-1:0] AddrOut;
	output [DMWidth-1:0] WMaskOut;
    output [LeafOutWidth-1:0] OldLeaf, NewLeaf;

    // send data to backend
    input  StoreDataReady;
    output StoreDataValid;
    output [FEDWidth-1:0] StoreData;

    // receive response from backend
    output LoadDataReady;
    input  LoadDataValid;
    input  [FEDWidth-1:0] LoadData;
	
	output	[JTWidth_UORAM-1:0] JTAG_UORAM;
	
	// Save the input data in case the client really needs to send data before command
	wire 	[FEDWidth-1:0] 	DataIn_Internal;
	(* mark_debug = "TRUE" *) wire					DataInValid_Internal, DataInReady_Internal;

	localparam				BlkSize_FEDChunks =		`divceil(ORAMB, FEDWidth);	

/*	
	FIFORAM	#(				.Width(					FEDWidth),
							.Buffering(				BlkSize_FEDChunks))
				in_D_buf(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				DataIn),
							.InValid(				DataInValid),
							.InAccept(				DataInReady),
							.OutData(				DataIn_Internal),
							.OutSend(				DataInValid_Internal),
							.OutReady(				DataInReady_Internal));
*/
	assign	DataIn_Internal = DataIn;
	assign	DataInValid_Internal = DataInValid;
	assign	DataInReady = DataInReady_Internal;

	// check whether input is valid
	(* mark_debug = "TRUE" *) wire	AddrOutofRange;
	(* mark_debug = "FALSE" *) wire	[ORAMU-1:0] AddrOutofRangeAddr;
	(* mark_debug = "TRUE" *) wire	ERROR_OutOfRange;
	assign	AddrOutofRange = ProgAddrIn >= NumValidBlock;
			
	FIFORegister #(			.Width(					ORAMU))
		addr_outof_rage(	.Clock(					Clock),
							.Reset(					Reset),
							.InData(				ProgAddrIn),
							.InValid(				CmdInReady && CmdInValid && AddrOutofRange),
							.OutData(				AddrOutofRangeAddr),
							.OutSend(				ERROR_OutOfRange),
							.OutReady(				1'b0));
							
	assign	JTAG_UORAM =							ERROR_OutOfRange;
							
`ifdef SIMULATION		
	always @ (posedge Clock) begin
		if (CmdInReady && CmdInValid) begin
			if (AddrOutofRange) begin
				$display("Error: Address Out of Range");
				$finish;
			end
		end
	end
`endif	
	
    // FrontEnd state machines
    (* mark_debug = "TRUE" *) wire [BECMDWidth-1:0] LastCmd;
	wire [DMWidth-1:0] LastMask;
    Register #(.Width(BECMDWidth + DMWidth))
        CmdReg (Clock, Reset, 1'b0, CmdInReady && CmdInValid, {CmdIn, WMaskIn}, {LastCmd, LastMask});

    (* mark_debug = "TRUE" *) reg [MaxLogRecursion-1:0] QDepth;
    (* mark_debug = "TRUE" *) reg [ORAMU-1:0] AddrQ [Recursion-1:0];

    (* mark_debug = "TRUE" *) wire Preparing, Accessing;
    (* mark_debug = "TRUE" *) wire RefillStarted, ExpectingProgramData, FakeAccess;

    // ================================== PosMapPLB ============================
    (* mark_debug = "TRUE" *) wire PPPCmdReady, PPPCmdValid;
    (* mark_debug = "TRUE" *) wire [1:0] PPPCmd;
    (* mark_debug = "FALSE" *) wire [ORAMU-1:0] PPPAddrIn, PPPAddrOut;
    (* mark_debug = "TRUE" *) wire PPPRefill;
    (* mark_debug = "FALSE" *) wire [LeafWidth-1:0] PPPRefillData;
    (* mark_debug = "TRUE" *) wire PPPOutReady, PPPValid, PPPHit, PPPUnInit, PPPEvict;
    (* mark_debug = "TRUE" *) wire PPPEvictDataValid, PPPEvictDataEmpty, PPPRefillDataValid, PPPRefillDataReady;
    (* mark_debug = "FALSE" *) wire [LeafWidth-1:0] PPPEvictData;

    PosMapPLB #(.ORAMU(             ORAMU),
                .ORAML(             ORAML),
                .ORAMB(             ORAMB),
                .Recursion(         Recursion),
                .EnablePLB(			EnablePLB),
				.PLBCapacity(       PLBCapacity),
				.PRFPosMap(			PRFPosMap))
        PPP (   .Clock(             Clock),
                .Reset(             Reset),
                .CmdReady(          PPPCmdReady),
                .CmdValid(          PPPCmdValid),
                .Cmd(               PPPCmd),
                .AddrIn(            PPPAddrIn),
                .DInValid(          PPPRefill),
                .DIn(               PPPRefillData),
                .OutReady(          PPPOutReady),
                .Valid(             PPPValid),
                .Hit(               PPPHit),
                .UnInit(            PPPUnInit),
                .OldLeafOut(        OldLeaf),
                .NewLeafOut(        NewLeaf),
                .Evict(             PPPEvict),
                .AddrOut(           PPPAddrOut),
                .RefillDataReady(   PPPRefillDataReady),
                .EvictDataOutValid( PPPEvictDataValid),
                .EvictDataOut(      PPPEvictData));

    (* mark_debug = "TRUE" *) wire PPPMiss, PPPUnInitialized;
    (* mark_debug = "TRUE" *) wire PPPLookup, PPPInitRefill;

	(* mark_debug = "TRUE" *) wire FakePLBMiss;	// hack to mimic recursive ORAM
	localparam RecursionMinus1 = Recursion - 32'b1;
	assign FakePLBMiss = !EnablePLB && Preparing && PPPValid && QDepth < RecursionMinus1;

    assign PPPMiss = PPPValid && (!PPPHit || FakePLBMiss);
    assign PPPUnInitialized = PPPValid && PPPHit && PPPUnInit;

    assign PPPRefill = Accessing && (PPPRefillDataValid || PPPInitRefill);
    assign PPPCmdValid = PPPLookup || (PPPRefill && !RefillStarted);
    assign PPPCmd = PPPRefill ? (PPPInitRefill ? CacheInitRefill : CacheRefill)
						: (Preparing && !EnablePLB && QDepth < RecursionMinus1) ? CacheRead : CacheWrite;
						// The PosMap entry that hits needs a CacheWrite; When PLB enabled, every lookup can hit, so need to use CacheWrite
						// Ideally, PosMap entries that miss do not care about CacheRead vs. CacheWrite
						// But the hack we add to disable PLB require CacheRead to entries that should've missed but in fact hit
    assign PPPAddrIn = PPPRefill ? AddrQ[QDepth] : AddrQ[QDepth];

    assign CmdInReady = !Preparing && !Accessing && !ExpectingProgramData && PPPCmdReady && !FakeAccess;
			// The first four are straight-forward. !FakeAccess has to be there because it is the counterpart of ExpectingProgramData
    assign PPPOutReady = Preparing ? PPPMiss :
                            ((PPPMiss && !PPPEvict) || (PPPUnInitialized && QDepth > 0) || CmdOutReady);
            // four cases:
            // (1) PLB miss in the prepare stage,
            // (2) refill but no evict, must have PPPMiss there, or it will misfire on Hit & UnInit
            // (3) uninitialized PosMap block
            // (4) request sent to backend
    // =============================================================================

    // ============================== Cmd to Backend ==============================
    (* mark_debug = "TRUE" *) wire EvictionRequest, InitRequest, SwitchReq, DataBlockReq;
    assign DataBlockReq = QDepth == 0;
    assign EvictionRequest = PPPValid && PPPEvict;
    assign InitRequest = DataBlockReq && PPPUnInitialized;		// initialize data block
    assign CmdOutValid = Accessing && PPPValid && ~ERROR_OutOfRange && 
							((PPPHit && !PPPUnInit) || InitRequest || PPPEvict);

    // if EvictionRequest, write back a PosMap block; otherwise serve the next access in the queue
    assign CmdOut = (EvictionRequest || InitRequest) ? BECMD_Append
						: DataBlockReq ? LastCmd : BECMD_ReadRmv;
	assign WMaskOut = (EvictionRequest || InitRequest) ? {DMWidth{1'bx}}	
						: DataBlockReq ? LastMask : {DMWidth{1'bx}};
			// Note : this is because PosMap eviction is always append, and append does not need a mask (or PMMAC assumes mask is all 1 on an append)
			// 		Be very careful if we decide to go for an inclusive PosMap/PLB design, in which case we do not mask for PLB block eviction
    assign AddrOut = EvictionRequest ? NumValidBlock + PPPAddrOut / LeafInBlock : AddrQ[QDepth];
	
    assign SwitchReq = (CmdOutReady && CmdOutValid && !EvictionRequest) || (!DataBlockReq && PPPUnInitialized);
                    // transition to next access, after sending out or initializing the current one
    // =============================================================================


    // front end control states
	Register1b
		PreparingReg(  	.Clock(     Clock),
						.Reset(     Reset || PPPValid && !PPPMiss), 	// due to our hack, Hit is no longer !Miss
						.Set(       CmdInValid && CmdInReady),
						.Out(       Preparing));
	Register1b
		AccessingReg(  	.Clock(     Clock),
						.Reset(     Reset || (Accessing && SwitchReq && DataBlockReq)),
						.Set(       Preparing && PPPValid && !PPPMiss),
						.Out(       Accessing));
    Register #(	.Width(1))
        RefillStartReg (.Clock(     Clock),
                        .Reset(     Reset || SwitchReq),
                        .Set(       1'b0),
                        .Enable(    1'b1),
                        .In(        RefillStarted || (PPPRefill && PPPCmdReady)),
                        .Out(       RefillStarted));
    Register #(	.Width(1))
      PPPInitRefillReg (.Clock(     Clock),
                        .Reset(     Reset || (PPPInitRefill && PPPCmdReady)),
                        .Set(       1'b0),
                        .Enable(    1'b1),
                        .In(        SwitchReq && !DataBlockReq && PPPUnInitialized),
                        .Out(       PPPInitRefill));
    Register #(	.Width(1))
      PPPLookupReg (	.Clock(     Clock),
                        .Reset(     Reset || (Accessing && SwitchReq)),
                        .Set(       CmdInValid && CmdInReady),          // this sets up PLB lookup for the first access
                        .Enable(    1'b1),
                        .In(        Preparing ? PPPMiss : RefillStarted && PPPCmdReady && PPPEvictDataEmpty),
                                                                        // make the next query only after receiving the previous one
                        .Out(       PPPLookup));

    //(Preparing && PPPValid && PPPHit) ||

    always @(posedge Clock) begin
       if (CmdInValid && CmdInReady) begin
            QDepth <= 0;
            AddrQ[0] = ProgAddrIn;
        end

        else if (Preparing) begin
            if (PPPMiss) begin        // PPP (PLB) miss, look for the next PosMap block
                QDepth <= QDepth + 1;
                AddrQ[QDepth+1] = NumValidBlock + AddrQ[QDepth] / LeafInBlock;
		`ifdef SIMULATION
                $display("\t\tPosMap Miss in Block %d for Block %d", AddrQ[QDepth+1], AddrQ[QDepth]);
		`endif
            end
		`ifdef SIMULATION
			else if (PPPValid && PPPHit) begin       // PPP hit, done
                $display("\t\tPosMap Hit  in Block %d for Block %d", AddrQ[QDepth+1], AddrQ[QDepth]);
				if (!EnablePLB && QDepth < Recursion-1) begin
					$display("Error: PLB still does its job when disabled.");
					$finish;
				end
            end
		`endif
        end

        else if (Accessing) begin
            if (SwitchReq) begin	// sendint out or initializing the current one
				QDepth <= QDepth - 1;
		`ifdef SIMULATION
                if (!DataBlockReq && PPPUnInitialized)
                    $display("\t\tInitialize Block %d", AddrQ[QDepth]);
                else
                    $display("\t\tRequest Block %d", AddrQ[QDepth]);
		`endif
            end

		`ifdef SIMULATION
            else if (CmdOutReady && CmdOutValid && EvictionRequest)
                $display("\t\tEvict Block %d to leaf %d", AddrOut, NewLeaf);
		`endif
        end
    end

    // =================== data interface with network and backend ====================
    UORAMDataPath #(    .FEDWidth(          FEDWidth),
						.ORAMB(             ORAMB),
						.PRFPosMap(			PRFPosMap))
    DataScheduler (     .Clock(             Clock),
                        .Reset(             Reset),
                        .SwitchReq(         SwitchReq),
                        .DataBlockReq(      DataBlockReq),
                        .Cmd(               LastCmd),
						.DumbRequest(		InitRequest),		// stupid read before write
                        .ExpectingProgramData(  ExpectingProgramData),
						.FakeAccess(		FakeAccess),

                        // IO interface with network
                        .DataInReady(           DataInReady_Internal),
                        .DataInValid(           DataInValid_Internal),
                        .DataIn(                DataIn_Internal),
                        .ReturnDataReady(       ReturnDataReady),
                        .ReturnDataValid(       ReturnDataValid),
                        .ReturnData(            ReturnData),

                        // IO interface with PPP
                        .PPPEvictDataEmpty(     PPPEvictDataEmpty),	// is actually IsEvictBufferEmpty
                        .PPPEvictDataValid(     PPPEvictDataValid),
                        .PPPEvictData(          PPPEvictData),
                        .PPPRefillDataReady(    PPPRefillDataReady),
                        .PPPRefillDataValid(    PPPRefillDataValid),
                        .PPPRefillData(         PPPRefillData),

                        // IO interface with backend
                        .StoreDataReady(    StoreDataReady),
                        .StoreDataValid(    StoreDataValid),
                        .StoreData(         StoreData),
                        .LoadDataReady(     LoadDataReady),
                        .LoadDataValid(     LoadDataValid),
                        .LoadData(          LoadData)
                );
    // ================================================================================
endmodule
