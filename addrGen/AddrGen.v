`include "Const.vh"

module AddrGen
#(`include "PathORAM.vh", `include "DDR3SDRAM.vh")
(
  input Clock, 
  
  // interface with backend ORAM controller
  input Reset, Start, 
  input RWIn,		// if this is a read (0) or a write (1)
  input	BHIn,       // for the entire bucket (0) or the header (1)
  input [ORAML-1:0] leaf,
  output Ready,
    
  // interface with DRAM controller
  input CmdReady,
  output CmdValid,
  output [DDRCWidth-1:0] Cmd,
  output [DDRAWidth-1:0] Addr,
  
  // tmp output for debugging
  output [ORAMLogL-1:0]  currentLevel, 
  output [ORAML-1:0] STIdx, BktIdx
);

    `include "PathORAMLocal.vh"
  
  // controller for AddrGenBktHead
  wire Enable, SwitchLevel;
  reg RW, BH;
  //reg [ORAML-1:0] Leaf;
  reg [ORAMLogL-1:0] BktCounter;
  wire [DDRAWidth-1:0] BktStartAddr;
  
  // TODO add parameter passing
  AddrGenBktHead #(.ORAML(ORAML), .DDRAWidth(DDRAWidth))
  addGenBktHead (Clock, Reset, Start & Ready, Enable, 
    leaf, 
    currentLevel, BktStartAddr,
    STIdx, BktIdx // tmp output for debugging
  );  
  
  `include "DDR3SDRAMLocal.vh"
  
  localparam BktSize = (ORAMZ + 1) * DDRBstLen;
  assign SwitchLevel = BktCounter >= (BH ? 0 : ORAMZ + 1 - 1);
  assign Enable = SwitchLevel && CmdValid;
  
  assign Cmd = (RW) ? DDR3CMD_Write : DDR3CMD_Read;
  
  // output 
  assign Ready = currentLevel > ORAML;
  assign CmdValid = currentLevel <= ORAML;
  assign Addr = BktStartAddr + BktCounter * DDRBstLen;
  
  always@(posedge Clock) begin
    // accept inputs
    if (Start && Ready) begin
      RW <= RWIn;
      BH <= BHIn;
      BktCounter <= 0; 
    end
    
    if (CmdReady && !Ready) begin
      BktCounter = SwitchLevel ? 0 : BktCounter + 1;
    end      
  end
    
endmodule
