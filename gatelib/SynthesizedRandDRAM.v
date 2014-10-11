
`include "Const.vh"

module	SynthesizedRandDRAM(
			//------------------------------------------------------------------
			//	System I/O
			//------------------------------------------------------------------
			Clock,
			Reset,
			//------------------------------------------------------------------
	
			//------------------------------------------------------------------
			//	Status Outputs
			//------------------------------------------------------------------
			Initialized,
			PoweredUp,
			//------------------------------------------------------------------
	
			//------------------------------------------------------------------
			//	Command Interface
			//------------------------------------------------------------------
			CommandAddress,
			Command,
			CommandValid,
			CommandReady,
			//------------------------------------------------------------------
	
			//------------------------------------------------------------------
			//	Data Input (Write) Interface
			//------------------------------------------------------------------
			DataIn,
			DataInMask,
			DataInValid,
			DataInReady,
			//------------------------------------------------------------------
	
			//------------------------------------------------------------------
			//	Data Output (Read) Interface
			//------------------------------------------------------------------
			DataOut,
			DataOutErrorChecked,
			DataOutErrorCorrected,
			DataOutValid,
			DataOutReady
			//------------------------------------------------------------------
		);
	//--------------------------------------------------------------------------
	//	Per-Instance Constants
	//--------------------------------------------------------------------------
	parameter		    InBufDepth =            6,
						InDataBufDepth =		16,
	                    OutInitLat =            30,    // model dram latency
	                    OutBandWidth =          79,    // percent
	                    InBandWidth =			50,
						
                        UWidth =				9, // 9b units matches XCV5 BRAM
                        AWidth =				12,	// 36Kb
                        DWidth =				UWidth, // 9b transfers
                        BurstLen =				1,	// 9b total burst
                        EnableMask =			1,
                        Class1 =				1,
                        RLatency =				1,
                        WLatency =				1;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Fixed Constants
	//--------------------------------------------------------------------------
	`ifdef MACROSAFE
	localparam				UCount =				DWidth / UWidth,
							MWidth =				EnableMask ? UCount : 0, // Per-unit (byte) masks
							CommandMask =			7'b0000011, // Read & Write only
							ECheck =				0,	// No error checking
							ECorrect =				0,	// No error correction
							EHWidth =				`max(`log2(ECheck+1), 1),
							ERWidth =				`max(`log2(ECorrect+1), 1);
	`endif
	`include "DRAM.constants"
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Internal Constants
	//--------------------------------------------------------------------------
	`ifdef MACROSAFE
		localparam			UAWidth =				`log2(UCount-1), // Unused lower address bits
							BCWidth =				`log2(BurstLen),
	`else
		localparam			UAWidth =				UCount,
							BCWidth =				BurstLen,
	`endif
							RAWidth =				AWidth-UAWidth;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
	input					Clock, Reset;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Status Outputs
	//--------------------------------------------------------------------------
	output					Initialized;
	output					PoweredUp;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Command Interface
	//--------------------------------------------------------------------------
	input	[AWidth-1:0]	CommandAddress;
	input	[DRAMCMD_CWidth-1:0] Command;
	input					CommandValid;
	output					CommandReady;
	
	//--------------------------------------------------------------------------
	//	Data Input (Write) Interface
	//--------------------------------------------------------------------------
	input	[DWidth-1:0]	DataIn;
	input	[MWidth-1:0]	DataInMask;
	input					DataInValid;
	output					DataInReady;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Data Output (Read) Interface
	//--------------------------------------------------------------------------
	output	[DWidth-1:0]	DataOut;
	output	[EHWidth-1:0]	DataOutErrorChecked;
	output	[ERWidth-1:0]	DataOutErrorCorrected;
	output					DataOutValid;
	input					DataOutReady;
	//--------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------
    //	Internal signals
    //--------------------------------------------------------------------------
	
    wire	[AWidth-1:0]	CommandAddress_Internal;
    wire	[DRAMCMD_CWidth-1:0] Command_Internal;
    wire					CommandValid_Internal;
    wire					CommandReady_Internal;
    
    wire	[DWidth-1:0]	DataIn_Internal;
    wire	[MWidth-1:0]	DataInMask_Internal;
    wire					DataInValid_Internal;
    wire					DataInReady_Internal;
    
    wire	[DWidth-1:0]	DataOut_Internal;
    wire	[EHWidth-1:0]	DataOutErrorChecked_Internal;
    wire	[ERWidth-1:0]	DataOutErrorCorrected_Internal;
    wire					DataOutValid_Internal;
    wire					DataOutReady_Internal;
	
	wire					DataInValid_Pre, DataInReady_Pre;
		
    FIFORAM	#(				.Width(					DRAMCMD_CWidth + AWidth),
                            .Buffering(				InBufDepth))
                cmd_buf(	.Clock(					Clock),
                            .Reset(					Reset),
                            .InData(				{Command, CommandAddress}),
                            .InValid(				CommandValid),
                            .InAccept(				CommandReady),
                            .OutData(				{Command_Internal, CommandAddress_Internal}),
                            .OutSend(				CommandValid_Internal),
                            .OutReady(				CommandReady_Internal));	

    FIFORAM	#(				.Width(					DWidth + MWidth),
                            .Buffering(				InDataBufDepth))
                din_buf(	.Clock(					Clock),
                            .Reset(					Reset),
                            .InData(				{DataIn, DataInMask}),
                            .InValid(				DataInValid_Pre),
                            .InAccept(				DataInReady_Pre),
                            .OutData(				{DataIn_Internal, DataInMask_Internal}),
                            .OutSend(				DataInValid_Internal),
                            .OutReady(				DataInReady_Internal));	

    SynthesizedDRAM	#(		.UWidth(				UWidth),
                            .AWidth(				AWidth),
                            .DWidth(				DWidth),
                            .BurstLen(				BurstLen), 
                            .EnableMask(			EnableMask),
                            .Class1(				Class1),
                            .RLatency(				RLatency),
                            .WLatency(				WLatency)) 
             synth_dram(	.Clock(					Clock),
                            .Reset(					Reset),

                            .Initialized(			Initialized),
                            .PoweredUp(				PoweredUp),

                            .CommandAddress(		CommandAddress_Internal),
                            .Command(				Command_Internal),
                            .CommandValid(			CommandValid_Internal),
                            .CommandReady(			CommandReady_Internal),

                            .DataIn(				DataIn_Internal),
                            .DataInMask(			DataInMask_Internal),
                            .DataInValid(			DataInValid_Internal),
                            .DataInReady(			DataInReady_Internal),

                            .DataOut(				DataOut_Internal),
                            .DataOutErrorChecked(	DataOutErrorChecked_Internal),
                            .DataOutErrorCorrected(	DataOutErrorCorrected_Internal),
                            .DataOutValid(			DataOutValid_Internal),
                            .DataOutReady(			DataOutReady_Internal)
                );
	
    wire        Stall, Stall2, DataOutValid_Rand, DataOutReady_Rand;
    reg [6:0]   RandModulator, RandModulator2;
	
    FIFORAM #(				.Width(					DWidth + EHWidth + ERWidth),
							.FWLatency(				OutInitLat),
							.Buffering(				2 * OutInitLat))
                dout_buf(	.Clock(					Clock),
                			.Reset(					Reset),
                			.InData(				{DataOut_Internal, 	DataOutErrorChecked_Internal, 	DataOutErrorCorrected_Internal}),
                			.InValid(				DataOutValid_Internal),
                			.InAccept(				DataOutReady_Internal),
                			.OutData(				{DataOut, 			DataOutErrorChecked, 			DataOutErrorCorrected}),
                			.OutSend(				DataOutValid_Rand),
                			.OutReady(				DataOutReady_Rand));
    
	reg [6:0] rand1, rand2; // convert random to unsigned
	
    always @ (posedge Clock) begin
		rand1 = $random;
		rand2 = $random;
        RandModulator = rand1 % 100;
		RandModulator2 = rand2 % 100;
	end
	
	assign Stall = RandModulator > OutBandWidth;
	assign DataOutValid = DataOutValid_Rand && !Stall;
	assign DataOutReady_Rand = DataOutReady && !Stall;
	
	assign Stall2 = RandModulator2 > InBandWidth;
	assign DataInValid_Pre = !Stall2 & DataInValid;
	assign DataInReady = !Stall2 & DataInReady_Pre;
	
endmodule
//------------------------------------------------------------------------------
