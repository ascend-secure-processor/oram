
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		DummyGenASIC
//	Desc:		A simplified dumb traffic generator to test ORAM power 
//				consumption on ASIC.
//==============================================================================
module DummyGenASIC(
  	Clock, Reset,

	DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid
	);
	//--------------------------------------------------------------------------
	//	Constants
	//-------------------------------------------------------------------------- 

	`include "PathORAM.vh"

	`include "CommandsLocal.vh"
	`include "TrafficGenLocal.vh"	
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	
	localparam				Utilization =			4'b1100,  // 50% utilization
							InitialReadLatency =	30;
	
	localparam				OWidth =				`log2(ORAMZ * ORAML) + 2, // something smaller than NumValidBlocks by some margin
							BBWidth =				`log2(BktSize_BEDChunks);
							
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
	
  	input 					Clock;
	input					Reset;

	//--------------------------------------------------------------------------
	//	CUT (partial ORAM backend) interface
	//--------------------------------------------------------------------------
	
	input					DRAMCommandValid;
	output					DRAMCommandReady;

	output	[BEDWidth-1:0]	DRAMReadData;
	output					DRAMReadDataValid;
	
	//--------------------------------------------------------------------------
	// 	Wires & Regs
	//--------------------------------------------------------------------------
	
	wire	[BktSize_RndBits-1:0] Bucket;
	wire	[OWidth-1:0]	PAddrOffset;
	wire	[BBWidth-1:0]	BucketCount;
	wire					BurstDone, BucketDone;
	wire					DRAMCommandValid_Delayed;
	wire	[BEDWidth-1:0]	DRAMReadData_Pre, DataChunk_Pre, MaskChunk_Pre;

	//--------------------------------------------------------------------------
	// Simulation checks
	//--------------------------------------------------------------------------
	
	`ifdef SIMULATION
	initial begin
		if (ORAMZ != 4 || BktSize_DRBursts != 6 || ORAMB != DDRDWidth || EnableIV == 0 || AESEntropy != 64) begin
			$display("Illegal params");
			$finish;
		end
	end

	/*
	always @(posedge Clock) begin
		if (DRAMReadDataValid)
			$display("DummyGen giving data %x", DRAMReadData);
	end
	*/
	`endif
	
	//--------------------------------------------------------------------------
	// Masks & data
	//--------------------------------------------------------------------------
	
	localparam	Mask = {	
							512'h71d69c091ec12a8d78e5821f4203255c75ffd8ed92141451f7fcc30a2bb47812fa4905ec4d80d16b8cbd08bad66619e9f72c146a183f2dc90120c1d262897f37,
							512'hb2f0385fd6dc7b21cc5439da77684fff1ba45aec20e83414cf4d1d2fc5a0fedd0c19d3c172cbd9cbf595db4160610c186ec3ecd28963cfdf67e3a2526782d6f5,
							512'he80a96670b5246f9a30f2557b24d967b1441c6e62773688017c361a556be5a1030eb1581829516a134733a61a318c50f456d209d066a859a074bb95c9e1e7065,
							512'h44486ba698f75c977d196a83d5e63139797e5160f7681a6a4d850a44f875cbe356e7a7ddb20b72afa7dc193b6be9089de11f7b4c434e909c65699ae840bb6695,
							512'hc130ac9f680aff2ceb74310d385e6192f120c82d912a3cd8cd893a42fda425fb18c3b67bc5eb3b457b9b917d28b3dd712eee613bf2721c99a8b5cdb82c756348,
							512'h656bfd09592c0e6f9dff6481630836dd9e4f44cfbc575bf30dc636b16b2fa547b33903f13de7c6a0fd1e585309961db2bb0922597a149bf30000000000000000
						};
						
	// Totally random bits.  This will truly be an upper bound on power.
	localparam	Data = {
							512'hd4a752a25d45df130adbd2e658c2c141b7d033dbdc34e681543cdec3a9391df6d59cba78c6a717b0ce7fbf31a78f0586e3bd01258926a5e1e2a04c5944722a0a,
							512'h4a3efa4a53bf385437e96794a112e356ff78d35c1c9d6367d4594c11bc7d79eb861603b6181badac0215d4f888f7b6164dc377832520e16a4e337c7d61cc63d4,
							512'haf49d3ea2053acd33b380f2c743b8eac5257ba3116555e2f99440db872a58bf2acd6576232c6ec26130fb41b255bafa01dc7948ad9d03ad360a5090a41c0d74b,
							512'hedd6fb80650190a3d35a3e1eb3ddeab7d2630682379c080cc29c06b332c7785ee30a5a036f7c13a46df835899ebb5a4d4c6d9d55aaec4aabbc281d9a60d114c4
						};
						
	localparam	Hash = 		512'h6721cf25074d59782f96e56a88ab03a4ee0e335eafe09182db24e42c5146a845038f34a7ab577b437f837eb7feb9408487e8d03f4ca95a8f7162d0ba8deb335e;
	localparam	Slack =		512'h8d2616ba12880b6ca22c211f31527e19a02361e427ac02e9a891487c6c05aaf040deaac485d49f9d82eeee2922b95e9a2ff04738d90aa63873bed5f34f44d33f;

	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Path gen
	//--------------------------------------------------------------------------

	FIFOLinear	#(			.Width(					0),
							.Depth(					InitialReadLatency))
				cmd_v(		.Clock(					Clock),
							.Reset(					Reset),

							.InValid(				DRAMCommandValid),
							.InAccept(				DRAMCommandReady),

							.OutValid(				DRAMCommandValid_Delayed),
							.OutReady(				BurstDone));
	
	CountAlarm 	#(			.Threshold(				BstSize_BEDChunks))
				bst_cnt(	.Clock(					Clock),
							.Reset(					Reset), 
							.Enable(				DRAMCommandValid_Delayed),
							.Done(					BurstDone));
	
	CountAlarm 	#(			.Threshold(				BktSize_BEDChunks))
				bkt_cnt(	.Clock(					Clock),
							.Reset(					Reset), 
							.Enable(				DRAMCommandValid_Delayed),
							.Count(					BucketCount),
							.Done(					BucketDone));
							
	Counter		#(			.Width(					OWidth),
							.Factor(				ORAMZ))
				addr_cnt(	.Clock(					Clock),
							.Reset(					Reset),
							.Set(					1'b0),
							.Load(					1'b0),
							.Enable(				BucketDone),
							.In(					{OWidth{1'bx}}),
							.Count(					PAddrOffset));							
							
	genvar i;
	generate for (i = 0; i < ORAMZ; i = i + 1) begin:BKT_FILL
		assign	Bucket[AESEntropy-1:0] =								{{AESEntropy-1{1'b0}}, 1'b1};
		assign	Bucket[BktHVStart+i] = 									Utilization[i];
		assign	Bucket[BktHUStart+(i+1)*ORAMU-1:BktHUStart+i*ORAMU] = 	{{ORAMU-OWidth{1'b0}}, PAddrOffset + i}; // sequential blocks
		assign	Bucket[BktHLStart+(i+1)*ORAML-1:BktHLStart+i*ORAML] = 	DummyGenLeaf;
		assign	Bucket[BktHHStart+(i+1)*ORAMH-1:BktHHStart+i*ORAMH] = 	Hash[(i+1)*ORAMH-1:i*ORAMH];
		assign	Bucket[BktHSize_RndBits+(i+1)*ORAMB-1:BktHSize_RndBits+i*ORAMB] = Data[(i+1)*ORAMB-1:i*ORAMB];
	end endgenerate
	
	generate if (BktHWaste_ValidBits > 0) begin:HDR_VLD_FILL
		assign	Bucket[BktHUStart-1:BktHVStart+ORAMZ] =					{BktHWaste_ValidBits{1'b0}};
	end endgenerate
	
	generate if (BktHSize_RndBits > BktHSize_RawBits) begin:HDR_SLACK_FILL
		assign	Bucket[BktHSize_RndBits-1:BktHSize_RawBits] =			Slack[BktHSize_RndBits-BktHSize_RawBits-1:0];
	end endgenerate
	
	Mux	#(.Width(BEDWidth), .NPorts(BktSize_BEDChunks), .SelectCode(0)) dmux(BucketCount, Bucket, 	DataChunk_Pre);
	Mux	#(.Width(BEDWidth), .NPorts(BktSize_BEDChunks), .SelectCode(0)) mmux(BucketCount, Mask, 	MaskChunk_Pre);
	
	assign	DRAMReadData_Pre =						DataChunk_Pre ^ ((EnableAES) ? MaskChunk_Pre : {BEDWidth{1'b0}});
	
	Pipeline #(BEDWidth+1) opipe(Clock, Reset, 	{DRAMCommandValid_Delayed, 	DRAMReadData_Pre}, 
												{DRAMReadDataValid, 		DRAMReadData}); 
	
	//--------------------------------------------------------------------------
endmodule
//--------------------------------------------------------------------------
