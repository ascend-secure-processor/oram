`include "Const.vh"

module testFullORam;

`timescale 1ps/100fs

   //***************************************************************************
   // Traffic Gen related parameters
   //***************************************************************************
    parameter SIMULATION            = "TRUE";

    //***************************************************************************
    // The following parameters refer to width of various ports
    //***************************************************************************
    parameter COL_WIDTH             = 10;
                                     // # of memory Column Address bits.
    parameter CS_WIDTH              = 1;
    
    parameter DM_WIDTH              = 8;
                                     // # of DM (data mask)
    parameter DQ_WIDTH              = 64;
                                     // # of DQ (data)
    parameter DQS_WIDTH             = 8;
    
    parameter ODT_WIDTH             = 1;
                                     // # of ODT outputs to memory.
    parameter ROW_WIDTH             = 14;
                                     // # of memory Row Address bits.
    
    parameter CA_MIRROR             = "OFF"; // C/A mirror opt for DDR3 dual rank
    
    //***************************************************************************
    // The following parameters are multiplier and divisor factors for PLLE2.
    // Based on the selected design frequency these parameters vary.
    //***************************************************************************
    parameter CLKIN_PERIOD          = 5000;
    
    
    //***************************************************************************
    // IODELAY and PHY related parameters
    //***************************************************************************
    parameter RST_ACT_LOW           = 0;
                                     // =1 for active low reset,
                                     // =0 for active high.
    
    
    //***************************************************************************
    // Referece clock frequency parameters
    //***************************************************************************
    parameter REFCLK_FREQ           = 200.0;
                                     // IODELAYCTRL reference clock frequency
    //***************************************************************************
    // System clock frequency parameters
    //***************************************************************************
    parameter tCK                   = 1250;
                                     // memory tCK paramter in pS.
                     
    parameter nCK_PER_CLK           = 4;
                                     // # of memory CKs per fabric CLK



    //**************************************************************************//
    // Local parameters Declarations
    //**************************************************************************//
    
    localparam real TPROP_DQS          = 0.00;
                       // Delay for DQS signal during Write Operation
    localparam real TPROP_DQS_RD       = 0.00;
                       // Delay for DQS signal during Read Operation
    localparam real TPROP_PCB_CTRL     = 0.00;
                       // Delay for Address and Ctrl signals
    localparam real TPROP_PCB_DATA     = 0.00;
                       // Delay for data signal during Write operation
    localparam real TPROP_PCB_DATA_RD  = 0.00;
                       // Delay for data signal during Read operation
    
    localparam MEMORY_WIDTH            = 8;
    localparam NUM_COMP                = DQ_WIDTH/MEMORY_WIDTH;
    
    localparam real REFCLK_PERIOD = (1000000.0/(2*REFCLK_FREQ));
    localparam RESET_PERIOD = 200000; //in pSec  

    
    //**************************************************************************//
    // Wire Declarations
    //**************************************************************************//
    reg                                sys_rst_n;
    wire                               sys_rst;
    
    
    reg                                sys_clk_i;
    wire                               sys_clk_p;
    wire                               sys_clk_n;
    
    reg clk_ref_i;
    
    wire                               ddr3_reset_n;
    wire [DQ_WIDTH-1:0]                ddr3_dq_fpga;
    wire [DQS_WIDTH-1:0]               ddr3_dqs_p_fpga;
    wire [DQS_WIDTH-1:0]               ddr3_dqs_n_fpga;
    wire [ROW_WIDTH-1:0]               ddr3_addr_fpga;
    wire [3-1:0]              ddr3_ba_fpga;
    wire                               ddr3_ras_n_fpga;
    wire                               ddr3_cas_n_fpga;
    wire                               ddr3_we_n_fpga;
    wire [1-1:0]               ddr3_cke_fpga;
    wire [1-1:0]                ddr3_ck_p_fpga;
    wire [1-1:0]                ddr3_ck_n_fpga;
    
    
    wire                               init_calib_complete;
    wire [(CS_WIDTH*1)-1:0]         ddr3_cs_n_fpga;
    
    wire [DM_WIDTH-1:0]                ddr3_dm_fpga;
    
    wire [ODT_WIDTH-1:0]               ddr3_odt_fpga;
    
    
    reg [(CS_WIDTH*1)-1:0] ddr3_cs_n_sdram_tmp;
    
    reg [DM_WIDTH-1:0]                 ddr3_dm_sdram_tmp;
    
    reg [ODT_WIDTH-1:0]                ddr3_odt_sdram_tmp;
    
    
    
    wire [DQ_WIDTH-1:0]                ddr3_dq_sdram;
    reg [ROW_WIDTH-1:0]                ddr3_addr_sdram [0:1];
    reg [3-1:0]               ddr3_ba_sdram [0:1];
    reg                                ddr3_ras_n_sdram;
    reg                                ddr3_cas_n_sdram;
    reg                                ddr3_we_n_sdram;
    wire [(CS_WIDTH*1)-1:0] ddr3_cs_n_sdram;
    wire [ODT_WIDTH-1:0]               ddr3_odt_sdram;
    reg [1-1:0]                ddr3_cke_sdram;
    wire [DM_WIDTH-1:0]                ddr3_dm_sdram;
    wire [DQS_WIDTH-1:0]               ddr3_dqs_p_sdram;
    wire [DQS_WIDTH-1:0]               ddr3_dqs_n_sdram;
    reg [1-1:0]                 ddr3_ck_p_sdram;
    reg [1-1:0]                 ddr3_ck_n_sdram;


    //**************************************************************************//

    //**************************************************************************//
    // Reset Generation
    //**************************************************************************//
    initial begin
        sys_rst_n = 1'b0;
        #RESET_PERIOD
        sys_rst_n = 1'b1;
    end

    assign sys_rst = RST_ACT_LOW ? sys_rst_n : ~sys_rst_n;

    //**************************************************************************//
    // Clock Generation
    //**************************************************************************//
    
    initial
        sys_clk_i = 1'b0;
    always
        sys_clk_i = #(CLKIN_PERIOD/2.0) ~sys_clk_i;
    
    assign sys_clk_p = sys_clk_i;
    assign sys_clk_n = ~sys_clk_i;

    initial
        clk_ref_i = 1'b0;
    always
        clk_ref_i = #REFCLK_PERIOD ~clk_ref_i;


  always @( * ) begin
    ddr3_ck_p_sdram      <=  #(TPROP_PCB_CTRL) ddr3_ck_p_fpga;
    ddr3_ck_n_sdram      <=  #(TPROP_PCB_CTRL) ddr3_ck_n_fpga;
    ddr3_addr_sdram[0]   <=  #(TPROP_PCB_CTRL) ddr3_addr_fpga;
    ddr3_addr_sdram[1]   <=  #(TPROP_PCB_CTRL) (CA_MIRROR == "ON") ?
                                                 {ddr3_addr_fpga[ROW_WIDTH-1:9],
                                                  ddr3_addr_fpga[7], ddr3_addr_fpga[8],
                                                  ddr3_addr_fpga[5], ddr3_addr_fpga[6],
                                                  ddr3_addr_fpga[3], ddr3_addr_fpga[4],
                                                  ddr3_addr_fpga[2:0]} :
                                                 ddr3_addr_fpga;
    ddr3_ba_sdram[0]     <=  #(TPROP_PCB_CTRL) ddr3_ba_fpga;
    ddr3_ba_sdram[1]     <=  #(TPROP_PCB_CTRL) (CA_MIRROR == "ON") ?
                                                 {ddr3_ba_fpga[3-1:2],
                                                  ddr3_ba_fpga[0],
                                                  ddr3_ba_fpga[1]} :
                                                 ddr3_ba_fpga;
    ddr3_ras_n_sdram     <=  #(TPROP_PCB_CTRL) ddr3_ras_n_fpga;
    ddr3_cas_n_sdram     <=  #(TPROP_PCB_CTRL) ddr3_cas_n_fpga;
    ddr3_we_n_sdram      <=  #(TPROP_PCB_CTRL) ddr3_we_n_fpga;
    ddr3_cke_sdram       <=  #(TPROP_PCB_CTRL) ddr3_cke_fpga;
  end
    

  always @( * )
    ddr3_cs_n_sdram_tmp   <=  #(TPROP_PCB_CTRL) ddr3_cs_n_fpga;
  assign ddr3_cs_n_sdram =  ddr3_cs_n_sdram_tmp;
    

  always @( * )
    ddr3_dm_sdram_tmp <=  #(TPROP_PCB_DATA) ddr3_dm_fpga;//DM signal generation
  assign ddr3_dm_sdram = ddr3_dm_sdram_tmp;
    

  always @( * )
    ddr3_odt_sdram_tmp  <=  #(TPROP_PCB_CTRL) ddr3_odt_fpga;
  assign ddr3_odt_sdram =  ddr3_odt_sdram_tmp;
    

// Controlling the bi-directional BUS

  genvar dqwd;
  generate
    for (dqwd = 1;dqwd < DQ_WIDTH;dqwd = dqwd+1) begin : dq_delay
      WireDelay #
       (
        .Delay_g    (TPROP_PCB_DATA),
        .Delay_rd   (TPROP_PCB_DATA_RD)
       )
      u_delay_dq
       (
        .A             (ddr3_dq_fpga[dqwd]),
        .B             (ddr3_dq_sdram[dqwd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
    end
    // For ECC ON case error is inserted on LSB bit from DRAM to FPGA
          WireDelay #
       (
        .Delay_g    (TPROP_PCB_DATA),
        .Delay_rd   (TPROP_PCB_DATA_RD)
       )
      u_delay_dq_0
       (
        .A             (ddr3_dq_fpga[0]),
        .B             (ddr3_dq_sdram[0]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
  endgenerate

  genvar dqswd;
  generate
    for (dqswd = 0;dqswd < DQS_WIDTH;dqswd = dqswd+1) begin : dqs_delay
      WireDelay #
       (
        .Delay_g    (TPROP_DQS),
        .Delay_rd   (TPROP_DQS_RD)
       )
      u_delay_dqs_p
       (
        .A             (ddr3_dqs_p_fpga[dqswd]),
        .B             (ddr3_dqs_p_sdram[dqswd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );

      WireDelay #
       (
        .Delay_g    (TPROP_DQS),
        .Delay_rd   (TPROP_DQS_RD)
       )
      u_delay_dqs_n
       (
        .A             (ddr3_dqs_n_fpga[dqswd]),
        .B             (ddr3_dqs_n_sdram[dqswd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
    end
  endgenerate
    
  //===========================================================================
  //                         FPGA Memory Controller
  //===========================================================================

	`include "DDR3SDRAMLocal.vh"
	
    wire                        Clock, Reset; 
	wire						DDR3SDRAM_ResetDone;	
	
	wire	[DDRCWidth-1:0]		DDR3SDRAM_Command;
	wire	[DDRAWidth-1:0]		DDR3SDRAM_Address;
	wire	[DDRDWidth-1:0]		DDR3SDRAM_WriteData, DDR3SDRAM_ReadData; 
	wire	[DDRMWidth-1:0]		DDR3SDRAM_WriteMask;
	
	wire						DDR3SDRAM_CommandValid, DDR3SDRAM_CommandReady;
	wire						DDR3SDRAM_WriteValid, DDR3SDRAM_WriteReady;
	wire						DDR3SDRAM_ReadValid;

    DDR3SDRAM 	DDR3SDRAMController(
            // System interface
            .sys_clk_p(				sys_clk_p),
            .sys_clk_n(				sys_clk_n),
            .sys_rst(				sys_rst),
            .ui_clk(				Clock),
            .ui_clk_sync_rst(		Reset),
            .init_calib_complete(	DDR3SDRAM_ResetDone), // TODO not needed?
                                        
            // DDR3 interface
            .ddr3_addr(				ddr3_addr_fpga),
            .ddr3_ba(				ddr3_ba_fpga),
            .ddr3_cas_n(			ddr3_cas_n_fpga),
            .ddr3_ck_n(				ddr3_ck_n_fpga),
            .ddr3_ck_p(				ddr3_ck_p_fpga),
            .ddr3_cke(				ddr3_cke_fpga),
            .ddr3_ras_n(			ddr3_ras_n_fpga),
            .ddr3_reset_n(			ddr3_reset_n),
            .ddr3_we_n(				ddr3_we_n_fpga),
            .ddr3_dq(				ddr3_dq_fpga),
            .ddr3_dqs_n(			ddr3_dqs_n_fpga),
            .ddr3_dqs_p(			ddr3_dqs_p_fpga),
            .ddr3_cs_n(				ddr3_cs_n_fpga),
            .ddr3_dm(				ddr3_dm_fpga),
            .ddr3_odt(				ddr3_odt_fpga),
            
            // DRAM Controller <-> ORAM Controller 
            .app_addr(				DDR3SDRAM_Address),
            .app_cmd(				DDR3SDRAM_Command),
            .app_en(				DDR3SDRAM_CommandValid),
            .app_rdy(				DDR3SDRAM_CommandReady),

            .app_rd_data(			DDR3SDRAM_ReadData),
            .app_rd_data_end(		), // useless?
            .app_rd_data_valid(		DDR3SDRAM_ReadValid),
                                        
            .app_wdf_data(			DDR3SDRAM_WriteData),
            .app_wdf_mask(			DDR3SDRAM_WriteMask), // this is synchronous to data interface
            .app_wdf_end(			DDR3SDRAM_WriteValid), // since DDR3 BL = 8, each 512b data chunk is the "end" of that burst
            .app_wdf_wren(			DDR3SDRAM_WriteValid),
            .app_wdf_rdy(			DDR3SDRAM_WriteReady),

            .app_sr_req(			1'b0),
            .app_ref_req(			1'b0),
            .app_zq_req(			1'b0),
            .app_sr_active(			), // not connected
            .app_ref_ack(			), // not connected
            .app_zq_ack(			)); // not connected

  //**************************************************************************//
  // Memory Models instantiations
  //**************************************************************************//

  genvar r,i;
  generate
    for (r = 0; r < CS_WIDTH; r = r + 1) begin: mem_rnk
      for (i = 0; i < NUM_COMP; i = i + 1) begin: gen_mem
        ddr3_model u_comp_ddr3
          (
           .rst_n   (ddr3_reset_n),
           .ck      (ddr3_ck_p_sdram[(i*MEMORY_WIDTH)/72]),
           .ck_n    (ddr3_ck_n_sdram[(i*MEMORY_WIDTH)/72]),
           .cke     (ddr3_cke_sdram[((i*MEMORY_WIDTH)/72)+(1*r)]),
           .cs_n    (ddr3_cs_n_sdram[((i*MEMORY_WIDTH)/72)+(1*r)]),
           .ras_n   (ddr3_ras_n_sdram),
           .cas_n   (ddr3_cas_n_sdram),
           .we_n    (ddr3_we_n_sdram),
           .dm_tdqs (ddr3_dm_sdram[i]),
           .ba      (ddr3_ba_sdram[r]),
           .addr    (ddr3_addr_sdram[r]),
           .dq      (ddr3_dq_sdram[MEMORY_WIDTH*(i+1)-1:MEMORY_WIDTH*(i)]),
           .dqs     (ddr3_dqs_p_sdram[i]),
           .dqs_n   (ddr3_dqs_n_sdram[i]),
           .tdqs_n  (),
           .odt     (ddr3_odt_sdram[((i*MEMORY_WIDTH)/72)+(1*r)])
           );
      end
    end
  endgenerate

    //**************************************************************************//
    // Path ORAM
    //**************************************************************************//

    `include "PathORAM.vh";
    `include "UORAM.vh";
    `include "PLB.vh";
    `include "PLBLocal.vh";
    `include "BucketLocal.vh";
	`include "PathORAMBackendLocal.vh";

    localparam   Freq =	200_000_000;
    localparam   Cycle = (64'd1_000_000_000_000)/Freq;	

    reg  CmdInValid, DataInValid, ReturnDataReady;
    wire CmdInReady, DataInReady, ReturnDataValid;
    reg [1:0] CmdIn;
    reg [ORAMU-1:0] AddrIn;
    wire [FEDWidth-1:0] DataIn, ReturnData;
    
    PathORamTop        #(	.StopOnBlockNotFound(	0),
    							.ORAMB(					ORAMB),
    							.ORAMU(					ORAMU),
    							.ORAML(					ORAML),
    							.ORAMZ(					ORAMZ),
    							.FEDWidth(				FEDWidth),
    							.BEDWidth(				BEDWidth),							
    							.DDR_nCK_PER_CLK(		DDR_nCK_PER_CLK),
    							.DDRDQWidth(			DDRDQWidth),
    							.DDRCWidth(				DDRCWidth),
    							.DDRAWidth(				DDRAWidth),
    							.IVEntropyWidth(		IVEntropyWidth),
                                .NumValidBlock(         NumValidBlock), 
                                .Recursion(             Recursion), 
                                .LeafWidth(             LeafWidth), 
                                .PLBCapacity(           PLBCapacity))
                ORAM    (		.Clock(					Clock),
    							.Reset(					Reset),
    							
    							// interface with network			
    							.Cmd(				    CmdIn),
    							.PAddr(					AddrIn),
    							.CmdValid(			    CmdInValid),
    							.CmdReady(			    CmdInReady),
                                .DataInReady(           DataInReady), 
                                .DataInValid(           DataInValid), 
                                .DataIn(                DataIn),                                    
                                .ReturnDataReady(       ReturnDataReady), 
                                .ReturnDataValid(       ReturnDataValid), 
                                .ReturnData(            ReturnData),
    							
    							// interface with DRAM		
    							.DRAMAddress(           DDR3SDRAM_Address),
    							.DRAMCommand(			DDR3SDRAM_Command),
    							.DRAMCommandValid(		DDR3SDRAM_CommandValid),
    							.DRAMCommandReady(		DDR3SDRAM_CommandReady),			
    							.DRAMReadData(			DDR3SDRAM_ReadData),
    							.DRAMReadDataValid(		DDR3SDRAM_ReadValid),			
    							.DRAMWriteData(			DDR3SDRAM_WriteData),
    							.DRAMWriteMask(			DDR3SDRAM_WriteMask),
    							.DRAMWriteDataValid(	DDR3SDRAM_WriteValid),
    							.DRAMWriteDataReady(	DDR3SDRAM_WriteReady));
    
    assign DataIn = 1;    

    reg [ORAML:0] GlobalPosMap [TotalNumBlock-1:0];
    reg  [31:0] TestCount;
    
    task Task_StartORAMAccess;
        input [1:0] cmd;
        input [ORAMU-1:0] addr;
        begin   
            CmdInValid <= 1;
            CmdIn <= cmd;
            AddrIn <= addr;
            $display("Start Access %d: %s Block %d",
                TestCount,
                cmd == 0 ? "Update" : cmd == 1 ? "Append" : cmd == 2 ? "Read" : "ReadRmv",
                addr);
            #(Cycle + Cycle / 2) CmdInValid <= 0;
        end
    endtask
    
    task Check_Leaf;
       begin
           $display("\t%s Block %d, \tLeaf %d --> %d", 
                   ORAM.BEnd_Cmd == 0 ? "Update" : ORAM.BEnd_Cmd == 1 ? "Append" : ORAM.BEnd_Cmd == 2 ? "Read" : "ReadRmv",
                   ORAM.BEnd_PAddr, ORAM.BEnd_Cmd == 1 ? -1 : ORAM.CurrentLeaf, ORAM.RemappedLeaf);
               
               if (ORAM.BEnd_Cmd == BECMD_Append) begin
                   if (GlobalPosMap[ORAM.BEnd_PAddr][ORAML]) begin
                       $display("Error: appending existing Block %d", ORAM.BEnd_PAddr);
                       $finish;
                   end
               end
               else if (GlobalPosMap[ORAM.BEnd_PAddr][ORAML] == 0) begin
                   $display("Error: requesting non-existing Block %d", ORAM.BEnd_PAddr);
                   $finish;               
               end
               else if (GlobalPosMap[ORAM.BEnd_PAddr][ORAML-1:0] != ORAM.CurrentLeaf) begin
                   $display("Error: leaf label does not match, should be %d, %d provided", GlobalPosMap[ORAM.BEnd_PAddr][ORAML-1:0], ORAM.CurrentLeaf);
                   $finish;              
               end
                  
               GlobalPosMap[ORAM.BEnd_PAddr] <= ORAM.BEnd_Cmd == BECMD_ReadRmv ? 0 : {1'b1, ORAM.RemappedLeaf};
       end 
    endtask    
   
   task Handle_ProgStore;
       begin
          #(Cycle);
          DataInValid <= 1;
          #(Cycle / 2)
          for (integer i = 0; i < FEORAMBChunks; i = i + 1) begin
              while (!DataInReady)  #(Cycle);        
              #(Cycle);
          end
          DataInValid <= 0;
       end
   endtask
    
   reg  [ORAMU-1:0] AddrRand;
   wire [1:0] Op;
   wire  Exist;
   
   assign Exist = GlobalPosMap[AddrRand][ORAML];
   assign Op = Exist ? {GlobalPosMap[AddrRand][0], 1'b0} : 2'b00;
   
   initial begin
       TestCount <= 0;
       CmdInValid <= 0;
       DataInValid <= 0;
       ReturnDataReady <= 1;   
       AddrRand <= 0;
         
       for (integer i = 0; i < TotalNumBlock; i=i+1) begin
           GlobalPosMap[i][ORAML] <= 0;
       end         
   end
   
   wire WriteCmd;
   assign WriteCmd = CmdIn == BECMD_Append || CmdIn == BECMD_Update;
   
   always @(posedge Clock) begin
       if (CmdInReady) begin
           if (TestCount < 2000) begin
               Task_StartORAMAccess(Op, AddrRand);
               #(Cycle);       
               AddrRand <= ($random % (NumValidBlock / 2)) + NumValidBlock / 2;
               TestCount <= TestCount + 1;
           end
           else begin
               $display("FULL ORAM TESTS PASSED!");
               $finish;  
           end
       end
   end
   
   always @(posedge Clock) begin
       if (CmdInValid && CmdInReady && WriteCmd) begin
           Handle_ProgStore;
       end
   end
   
    always @(posedge Clock) begin    
       if (ORAM.BEnd_CmdValid && ORAM.BEnd_CmdReady) begin
           Check_Leaf;
       end
   end
    
endmodule