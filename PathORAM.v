
//==============================================================================
//	Section:	Includes
//==============================================================================
`include "Const.vh"
//==============================================================================

//==============================================================================
//	Module:		PathORAM
//	Desc:		
//==============================================================================
module PathORAM #(	`include "PathORAM.vh", `include "DDR3SDRAM.vh",
					`include "AES.vh") (
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
	output	[DDRMWidth-1:0]		DRAMWriteMask,
	output						DRAMWriteDataValid,
	input						DRAMWriteDataReady
	);
		
	//------------------------------------------------------------------------------
	//	Constants
	//------------------------------------------------------------------------------ 

	`include "DDR3SDRAMLocal.vh"

	//------------------------------------------------------------------------------
	//	Wires & Regs
	//------------------------------------------------------------------------------ 

	//------------------------------------------------------------------------------
	//	Front end
	//------------------------------------------------------------------------------

	
	
	
	//------------------------------------------------------------------------------
	//	Back end
	//------------------------------------------------------------------------------

	/*
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
	*/
							
	DRAMInitializer #(		.ORAMB(					ORAMB),
							.ORAMU(					ORAMU),
							.ORAML(					ORAML),
							.ORAMZ(					ORAMZ),
							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
							.DDRDQWidth(			DDRDQWidth),
							.DDRCWidth(				DDRCWidth),
							.DDRAWidth(				DDRAWidth),
							.IVEntropyWidth(		IVEntropyWidth))
			dram_init(		.Clock(					Clock),
							.Reset(					Reset),
							// TODO generalize this to addr gen, etc
							.DRAMCommandAddress(	DRAMCommandAddress),
							.DRAMCommand(			DRAMCommand),
							.DRAMCommandValid(		DRAMCommandValid),
							.DRAMCommandReady(		DRAMCommandReady),
							.DRAMWriteData(			DRAMWriteData),
							.DRAMWriteMask(			DRAMWriteMask),
							.DRAMWriteDataValid(	DRAMWriteDataValid),
							.DRAMWriteDataReady(	DRAMWriteDataReady),
							.Done(					));					

	//------------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
