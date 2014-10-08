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

module Frontend
(
    Clock, Reset,
    CmdInReady, CmdInValid, CmdIn, ProgAddrIn, WMaskIn,
    DataInReady, DataInValid, DataIn,
    ReturnDataReady, ReturnDataValid, ReturnData,
    CmdOutReady, CmdOutValid, CmdOut, AddrOut, OldLeaf, NewLeaf,
	StoreDataReady, StoreDataValid, StoreData,
    LoadDataReady, LoadDataValid, LoadData
);

	`include "PathORAM.vh"
	`include "UORAM.vh"
	
	`include "DMLocal.vh"
    `include "CommandsLocal.vh"
    `include "CacheCmdLocal.vh"
    `include "PLBLocal.vh"

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
    output [ORAML-1:0] OldLeaf, NewLeaf;

    // send data to backend
    input  StoreDataReady;
    output StoreDataValid;
    output [FEDWidth-1:0] StoreData;

    // receive response from backend
    output LoadDataReady;
    input  LoadDataValid;
    input  [FEDWidth-1:0] LoadData;
	
	wire CmdOutReady_Pre;
    wire CmdOutValid_Pre;
    wire [BECMDWidth-1:0] CmdOut_Pre;
	wire [DMWidth-1:0] WMask_Int;
    wire [ORAMU-1:0] AddrOut_Pre;
    wire [LeafOutWidth-1:0] OldLeaf_Pre, NewLeaf_Pre;

    wire StoreDataReady_Pre;
    wire StoreDataValid_Pre;
    wire [FEDWidth-1:0] StoreData_Pre;

    wire LoadDataReady_Pre;
    wire LoadDataValid_Pre;
    wire [FEDWidth-1:0] LoadData_Pre;
	
	UORAMController #(  	.ORAMU(         		ORAMU), 
							.ORAML(         		ORAML), 
							.ORAMB(         		ORAMB), 
							.FEDWidth(				FEDWidth),
							.Recursion(     		Recursion),
							.EnablePLB(				EnablePLB),
							.PLBCapacity(   		PLBCapacity),
							.PRFPosMap(				PRFPosMap)) 
							
			uoram		(	.Clock(             	Clock), 
							.Reset(					Reset), 
							
							.CmdInReady(			CmdInReady), 
							.CmdInValid(			CmdInValid), 
							.CmdIn(					CmdIn), 
							.ProgAddrIn(			ProgAddrIn),
							.WMaskIn(				WMaskIn),
							.DataInReady(			DataInReady), 
							.DataInValid(			DataInValid), 
							.DataIn(				DataIn),                                    
							.ReturnDataReady(		ReturnDataReady), 
							.ReturnDataValid(		ReturnDataValid), 
							.ReturnData(			ReturnData),
							
							.CmdOutReady(			CmdOutReady_Pre), 
							.CmdOutValid(			CmdOutValid_Pre), 
							.CmdOut(				CmdOut_Pre), 
							.AddrOut(				AddrOut_Pre),
							.WMaskOut(				WMask_Int),
							.OldLeaf(				OldLeaf_Pre), 
							.NewLeaf(				NewLeaf_Pre), 
							.StoreDataReady(		StoreDataReady_Pre), 
							.StoreDataValid(		StoreDataValid_Pre), 
							.StoreData(				StoreData_Pre),
							.LoadDataReady(			LoadDataReady_Pre), 
							.LoadDataValid(			LoadDataValid_Pre), 
							.LoadData(				LoadData_Pre));
	
	generate if (EnableIV) begin:MAC
		IntegrityVerifier #(.ORAMU(         		ORAMU), 
							.ORAML(         		ORAML), 
							.ORAMB(         		ORAMB), 
							.FEDWidth(				FEDWidth))
				iv(			.Clock(					Clock), 
							.Reset(					Reset),

							.FECommand(				CmdOut_Pre), 
							.FEPAddr(				AddrOut_Pre),
							.FEWMask(				WMask_Int),
							.FECurrentCounter(		OldLeaf_Pre),
							.FERemappedCounter(		NewLeaf_Pre),
							.FECommandValid(		CmdOutValid_Pre), 
							.FECommandReady(		CmdOutReady_Pre),
							
							.FELoadData(			LoadData_Pre), 
							.FELoadValid(			LoadDataValid_Pre), 
							.FELoadReady(			LoadDataReady_Pre),
							
							.FEStoreData(			StoreData_Pre),
							.FEStoreValid(			StoreDataValid_Pre), 
							.FEStoreReady(			StoreDataReady_Pre),
							
							.BECommand(				CmdOut), 
							.BEPAddr(				AddrOut), 
							.BECurrentLeaf(			OldLeaf), 
							.BERemappedLeaf(		NewLeaf),
							.BECommandValid(		CmdOutValid),
							.BECommandReady(		CmdOutReady),
							
							.BELoadData(			LoadData), 
							.BELoadValid(			LoadDataValid), 
							.BELoadReady(			LoadDataReady),
							
							.BEStoreData(			StoreData),
							.BEStoreValid(			StoreDataValid), 
							.BEStoreReady(			StoreDataReady));	
	end else begin:NO_MAC	
		assign	CmdOut =							CmdOut_Pre;
		assign	CmdOutValid =						CmdOutValid_Pre;
		assign	CmdOutReady_Pre =					CmdOutReady;
		
		assign	AddrOut =							AddrOut_Pre;	
		assign	OldLeaf = 							OldLeaf_Pre;
		assign	NewLeaf = 							NewLeaf_Pre;
	
		assign	StoreData =							StoreData_Pre;
		assign	StoreDataValid =					StoreDataValid_Pre;
		assign	StoreDataReady_Pre =				StoreDataReady;
		
		assign	LoadData_Pre =						LoadData;
		assign	LoadDataValid_Pre =					LoadDataValid;
		assign	LoadDataReady =						LoadDataReady_Pre;
	end endgenerate
endmodule
