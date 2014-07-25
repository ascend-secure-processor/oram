//==============================================================================
//	Module: PRNG
//	Desc: pseudo random number generator using AES(counter), ready-valid interface
//			This module assumes very low output bandwidth
//			Use it for leaf generation. Do not use it for encryption.

//==============================================================================

module PRNG (Clock, Reset, RandOutReady, RandOutValid, RandOut, SecretKey);

	parameter RandWidth = 32;

	`include "PathORAM.vh"

	input  Clock, Reset;
	input  RandOutReady;
	output RandOutValid;
	output [RandWidth-1:0] RandOut;
	input	[AESWidth-1:0] SecretKey;

	wire  SeedValid, SeedReady;
	wire  [AESEntropy-1:0] Seed;

    Counter #(.Width(AESEntropy))
        SeedCounter (Clock, Reset, 1'b0, 1'b0, (SeedValid && SeedReady), {AESEntropy{1'bx}}, Seed); // load = set = 0, in= x
        	// TODO: if reset, seed goes back to 0, not secure any more.

    wire [AESWidth-1:0]			AESKey;
    wire                       	AESKeyValid;
    wire                        AESKeyReady;

    assign AESKey = SecretKey;
        // We should renew the key on every reset, but currently not doing it.
    assign AESKeyValid = 1;

    wire [AESWidth-1:0]         AESDataIn, AESDataOut;
    wire                        AESDataOutValid;

	assign		AESDataIn = {{(AESWidth-AESEntropy){1'b0}}, Seed};
/*
	Register1b 	aes_ready 	(Clock,	!Reset && SeedValid && SeedReady, Reset || AESDataOutValid, SeedReady);
	aes_cipher_top
		aes	(	.clk(		Clock),
				.rst(		~Reset),
				.ld(		SeedValid && AESKeyValid),
				.done(		AESDataOutValid),
				.key(		AESKey),
				.text_in(	AESDataIn),
				.text_out(	AESDataOut)
			);

	always @(posedge Clock) begin
		$display("Reset = %d, SeedValid = %d, SeedReady = %d, AESDataOutValid = %d", Reset, SeedValid, SeedReady, AESDataOutValid);
	end
*/

    AES_DW #(.W(1),
             .D(1))
    aes_dw (.Clock(Clock),
            .Reset(Reset),
            .DataIn(Seed),
            .DataInValid(SeedValid),
            .DataInReady(SeedReady),
            .Key(AESKey),
            .KeyValid(AESKeyValid),
            .KeyReady(AESKeyReady),
            .DataOut(AESDataOut),
            .DataOutValid(AESDataOutValid)
            );

    wire  					FunnelInReady;
    wire [RandWidth-1:0]    FunnelOut;
    wire                    FunnelOutReady, FunnelOutValid;

	FIFOShiftRound #(.IWidth(AESWidth), .OWidth(RandWidth))
    AESOutFunnel ( .Clock(			Clock),
                    .Reset(			Reset),
                    .InAccept(		FunnelInReady),
                    .InValid(		AESDataOutValid),
                    .InData(		AESDataOut),
                    .OutReady(		FunnelOutReady),
                    .OutValid(		FunnelOutValid),
                    .OutData(		FunnelOut)
                );


    FIFORegister #(	.Width(			RandWidth),
					.BWLatency(		1))
    RandOutReg (  	.Clock(			Clock),
                    .Reset(			Reset),
                    .InAccept(		FunnelOutReady),
                    .InValid(		FunnelOutValid),
                    .InData(		FunnelOut),
                    .OutReady(		RandOutReady),
                    .OutSend(		RandOutValid),
                    .OutData(		RandOut)
                );

    assign SeedValid = FunnelInReady && SeedReady && !AESDataOutValid;
    	// Generate new random bits if there's space in AESOutFunnel and no bits are on the fly;

	`ifdef SIMULATION
		always @(posedge Clock) begin
			// if (!Reset && RandOutReady && !RandOutValid) begin
			// 	$display("Error : Run out of random bits");
			// 	$finish;
			// end
		end
	`endif

endmodule
