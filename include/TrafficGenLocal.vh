
	// Traffic Gen

	localparam				TCMDWidth =				8,
							DBaseWidth = 			32,
							TimeWidth =				32;
							
	localparam				THPWidth =				TCMDWidth + ORAMU + DBaseWidth + TimeWidth,
							TCMD_Update =			{{TCMDWidth - BECMDWidth{1'b0}}, BECMD_Update},
							TCMD_Append =			{{TCMDWidth - BECMDWidth{1'b0}}, BECMD_Append},
							TCMD_Read =				{{TCMDWidth - BECMDWidth{1'b0}}, BECMD_Read},
							TCMD_ReadRmv =			{{TCMDWidth - BECMDWidth{1'b0}}, BECMD_ReadRmv},
							TCMD_Fill =				8'haf,
							TCMD_CmdLin_AddrLin =	8'hbf,
							TCMD_CmdLin_AddrRnd =	8'hcf,
							TCMD_CmdRnd_AddrLin =	8'hdf,
							TCMD_CmdRnd_AddrRnd =	8'hef,
							TCMD_Start =			8'hff;
							
	// Dummy Gen
	
	localparam				DummyGenLeaf =			{ORAML{1'b0}};
	