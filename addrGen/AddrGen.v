module AddrGen
#(`include "PathORAM.vh", `include "DDR3SDRAM.vh")
(
  input Clock, 
  
  // interface with backend ORAM controller
  input Reset, Start, 
  input RWIn,              // 0 for write, 1 for read, 
  input BHIn,              // 0 for the entire bucket, 1 for the header
  input [ORAML-1:0] leaf,
  output Ready,
    
  // interface with DRAM controller
  input CmdReady,
  output CmdValid,
  output [DDRCWidth:0] Cmd,
  output [DDRAWidth-1:0] Addr,
  
  // tmp output for debugging
  output [ORAMLogL-1:0]  currentLevel, 
  output [ORAML-1:0] STIdx, BktIdx
);
  
  `include "PathORAMLocal.vh"
  `include "DDR3SDRAMLocal.vh"
  
  // controller for AddrGenBktHead
  wire Enable, SwitchLevel;
  reg RW, BH;
  //reg [ORAML-1:0] Leaf;
  reg [ORAMLogL-1:0] BktCounter;
  wire [DDRAWidth-1:0] BktStartAddr;
  
  AddrGenBktHead #(.ORAML(ORAML), .DDRAWidth(DDRAWidth)) addGenBktHead
  (Clock, Reset, Start && Ready, Enable, 
    leaf, 
    currentLevel, BktStartAddr,
    STIdx, BktIdx // tmp output for debugging
  );  
  
  localparam BktSize = (ORAMZ + 1) * DDRBstLen;
  assign SwitchLevel = BktCounter >= (BH ? 0 : ORAMZ + 1 - 1);
  assign Enable = !Ready && CmdReady && SwitchLevel;
  
  // output 
  assign Ready = currentLevel > ORAML;
  assign CmdValid = currentLevel <= ORAML;
  assign Cmd = RW ? DDR3CMD_Read : DDR3CMD_Write;          // 000 for write, 001 for read
  assign Addr = BktStartAddr + BktCounter * DDRBstLen;
  
  always@(posedge Clock) begin
    // accept inputs
    if (Start && Ready) begin
      RW <= RWIn;
      BH <= BHIn;
      BktCounter <= 0; 
    end
    
    if (!Ready && CmdReady) begin
      BktCounter = SwitchLevel ? 0 : BktCounter + 1;
    end      
  end
    
endmodule
