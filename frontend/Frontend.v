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
    CmdInReady, CmdInValid, CmdIn, ProgAddrIn,
    DataInReady, DataInValid, DataIn,
    ReturnDataReady, ReturnDataValid, ReturnData,
    CmdOutReady, CmdOutValid, CmdOut, AddrOut, OldLeaf, NewLeaf,
	StoreDataReady, StoreDataValid, StoreData,
    LoadDataReady, LoadDataValid, LoadData
);

	`include "PathORAM.vh"
	`include "UORAM.vh"

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
	
	wire [LeafOutWidth-1:0] OldLeaf_Pre, NewLeaf_Pre;
	
	UORAMController #(  	.ORAMU(         		ORAMU), 
							.ORAML(         		ORAML), 
							.ORAMB(         		ORAMB), 
							.FEDWidth(				FEDWidth),
							.NumValidBlock( 		NumValidBlock), 
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
							.DataInReady(			DataInReady), 
							.DataInValid(			DataInValid), 
							.DataIn(				DataIn),                                    
							.ReturnDataReady(		ReturnDataReady), 
							.ReturnDataValid(		ReturnDataValid), 
							.ReturnData(			ReturnData),
		                        
							.CmdOutReady(			CmdOutReady), 
							.CmdOutValid(			CmdOutValid), 
							.CmdOut(				CmdOut), 
							.AddrOut(				AddrOut), 
							.OldLeaf(				OldLeaf_Pre), 
							.NewLeaf(				NewLeaf_Pre), 
							.StoreDataReady(		StoreDataReady), 
							.StoreDataValid(		StoreDataValid), 
							.StoreData(				StoreData),
							.LoadDataReady(			LoadDataReady), 
							.LoadDataValid(			LoadDataValid), 
							.LoadData(				LoadData));
	
	assign	OldLeaf = OldLeaf_Pre;
	assign	NewLeaf = NewLeaf_Pre;
	
endmodule
