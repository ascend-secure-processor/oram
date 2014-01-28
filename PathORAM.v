
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		PathORAM
//	Desc:		
//------------------------------------------------------------------------------
module PathORAM #(`include "PathORAM.vh", `include "DDR3SDRAM.vh") (
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------
		
  	input 						Clock, Reset,
	
	//--------------------------------------------------------------------------
	//	Processor Interface
	//--------------------------------------------------------------------------

	// TODO 
	
	//--------------------------------------------------------------------------
	//	DRAM Interface
	//--------------------------------------------------------------------------

	output	[DDRAWidth-1:0]		DRAMCommandAddress,
	output	[DDRCWidth-1:0]		DRAMCommand,
	output						DRAMCommandValid,
	input						DRAMCommandReady,
	
	input	[DDRDWidth-1:0]		DRAMReadData,
	input						DRAMReadDataValid,
	
	output	[DDRDWidth-1:0]		DRAMWriteData,
	output						DRAMWriteDataValid,
	input						DRAMWriteDataReady
	);
	
	//--------------------------------------------------------------------------
	//	Wires & Regs
	//-------------------------------------------------------------------------- 
	


    // Wires

    wire [MAX_ORAM_L-1:0]           Leaf; // comes from POSMAP
    wire                            LeafValid;

    wire                            SymKey; // from key exchange

    wire                            OutLd; // indicate load
    wire [APP_DATA_WIDTH-1:0]       PlainIn; // plain text to AES
    wire [APP_DATA_WIDTH-1:0]       CipherOut; // data from AES
    wire [APP_DATA_WIDTH/AES_WIDTH-1:0] AESOutDone; // done encrypt

    wire                                InKld; // indicate key load
    wire                                InLd; //indicate load
    wire [APP_DATA_WIDTH-1:0]           CipherIn; // plain text to AES
    wire [APP_DATA_WIDTH-1:0]           PlainOut; // data from AES
    wire [APP_DATA_WIDTH/AES_WIDTH-1:0] AESInDone;  // done decrypt

    wire [DRAM_ADDR_WIDTH-1:0]          PAddr;

    wire                                AddrGenEn;

    wire                                StashReturnRdy;

    wire                                StashEvictValid;
    wire                                StashEvictRdy;

	//------------------------------------------------------------------------------
	// Front end
	//------------------------------------------------------------------------------

	//------------------------------------------------------------------------------
	// Back end
	//------------------------------------------------------------------------------

	Stash	#(				.StashDWidth(			StashDWidth),
							.StashCapacity(			ORAMC),
							.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ))
							
			stash(			.Clock(					Clock),
							.Reset(					Reset),
							.ResetDone(				),
							
							.AccessLeaf(			),
							.AccessPAddr(			),
							.AccessIsDummy(			),
							
							.StartScanOperation(	),  
							.StartWritebackOperation(),
										
							.ReturnData(			),
							.ReturnPAddr(			),
							.ReturnLeaf(			),
							.ReturnDataOutValid(	),
							.ReturnDataOutReady(	1'b0),
							.BlockReturnComplete(	),
							
							.EvictData(				),
							.EvictPAddr(			),
							.EvictLeaf(				),
							.EvictDataInValid(		1'b0),
							.EvictDataInReady(		),
							.BlockEvictComplete(	),

							.WriteData(				WriteData),
							.WriteInValid(			WriteInValid),
							.WriteInReady(			WriteInReady), 
							.WritePAddr(			WritePAddr),
							.WriteLeaf(				WriteLeaf),
							.BlockWriteComplete(	BlockWriteComplete), 
							
							.ReadData(				ReadData),
							.ReadPAddr(				ReadPAddr),
							.ReadLeaf(				ReadLeaf),
							.ReadOutValid(			ReadOutValid), 
							.ReadOutReady(			ReadOutReady), 
							.BlockReadComplete(		BlockReadComplete),
							.PathReadComplete(		PathReadComplete),
							
							.StashAlmostFull(		StashAlmostFull),
							.StashOverflow(			StashOverflow),
							.StashOccupancy(		StashOccupancy));

    AddrGen #(				.DRAM_ADDR_WIDTH(		DRAM_ADDR_WIDTH),
							.MAX_ORAM_L(			MAX_ORAM_L),
							.MAX_LOG_L(				MAX_LOG_L))
							
			addr_gen(		.Clock(					Clock),
							.Reset(					Reset),
							.Enable(				AddrGenEn),
							.leaf(					Leaf),
							.ORAMLevels(			ORAMLevels),
							.L_st(					L_st),
							.BktSize(				BktSize),
							.STSize(				STSize),
							.NumCompST(				NumCompST),
							.STSize_bot(			STSize_bot),
							.CurrentLevel(			),
							.PhyAddr(				PAddr),
							.STIdx(					),
							.BktIdx(				));

	//------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
