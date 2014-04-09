
	// Suffix meanings:
	// 	RawBits = what it sounds like ...
	// 	RndBits = bits rounded to some value (usually a DDR3 burst)
	// 	DRBursts = in terms of DDR3 bursts
	// 	DRWords = in terms of DDR3 DQ bus width (typically 64b)
	
	`ifdef SIMULATION
	localparam					IVINITValue =			{{IVEntropyWidth-32{1'b0}}, 32'hdeadbeef};
	`else
	localparam					IVINITValue =			{IVEntropyWidth{1'bx}};
	`endif
	
	`include "AES.vh";
	
	`include "SHA3Local.vh"
	
	localparam					BktHSize_ValidBits =	`divceil(ORAMZ,8) * 8; // = 8 bits for Z < 9
	localparam					BktHWaste_ValidBits =	BktHSize_ValidBits - ORAMZ;
	localparam					BktHULStart =			IVEntropyWidth + BktHSize_ValidBits; 	// at what position do the U/Ls start?
	localparam					BktHSize_RawBits = 	BktHULStart + ORAMZ * (ORAMU + ORAML);		// valid bits, addresses, leaf labels	
	localparam					BktHSize_DRBursts = 	`divceil(BktHSize_RawBits, DDRDWidth);
	localparam					BktHSize_RndBits =		BktHSize_DRBursts * DDRDWidth; 			// = 512 for all configs we care about
	
	localparam					BktHHSize_RawBits =     BktHSize_RndBits + EnableIV * HashDigestWidth;	// header plus hash
	localparam					BktHHSize_DRBursts = 	`divceil(BktHHSize_RawBits, DDRDWidth);
	localparam					BktHHSize_RndBits =		BktHHSize_DRBursts * DDRDWidth; 		// = 1024 for all configs we care about
	// TODO: unless we can throw away some bits in SHA. Can we?
	
	localparam					BlkSize_DRBursts =		`divceil(ORAMB, DDRDWidth);	
	
	localparam					BktPSize_RawBits =		ORAMZ * ORAMB;
	localparam					BktPSize_DRBursts =		`divceil(BktPSize_RawBits, DDRDWidth);
	localparam					BktSize_RawBits =		BktHHSize_RndBits + BktPSize_RawBits;
	localparam					BktSize_DRBursts =		`divceil(BktSize_RawBits, DDRDWidth);
	localparam					BktSize_RndBits =		BktSize_DRBursts * DDRDWidth;
	localparam					BktSize_DRWords =		BktSize_RndBits / DDRDQWidth; // = E.g., for Z = 5, BktSize_TotalRnd = 3072 and BktSize_DDRWords = 48

	localparam					PathSize_DRBursts =		(ORAML + 1) * BktSize_DRBursts;	
	
	// Width of a counter for the # of DDR3 bursts in a bucket/path
	localparam					BktBSTWidth =			`log2(BktSize_DRBursts);
	localparam					PthBSTWidth =			`log2(PathSize_DRBursts);