
	localparam				TCMDWidth =				8,
							DBaseWidth = 			32,
							TimeWidth =				32;
							
	localparam				UARTWidth = 			8;

	`ifdef SIMULATION
	localparam				UARTBaud =				1152000; // unrealistically high
	`else
	localparam				UARTBaud =				115200;
	`endif
	
	localparam				PcktWidth =				TCMDWidth + ORAMU + DBaseWidth + TimeWidth,
							TCMD_Update =			{{TCMDWidth - BECMDWidth{1'b0}}, BECMD_Update},
							TCMD_Append =			{{TCMDWidth - BECMDWidth{1'b0}}, BECMD_Append},
							TCMD_Read =				{{TCMDWidth - BECMDWidth{1'b0}}, BECMD_Read},
							TCMD_ReadRmv =			{{TCMDWidth - BECMDWidth{1'b0}}, BECMD_ReadRmv},
							TCMD_Start =			{TCMDWidth{1'b1}};
	