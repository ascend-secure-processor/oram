`include "Const.vh"

`timescale 1ps/100fs

module testFullORam;
						
	parameter 					DDR_nCK_PER_CLK = 	4,
								DDRDQWidth =		64,
								DDRCWidth =			3,
								DDRAWidth =			`log2(ORAMB * (ORAMZ + 1)) + ORAML + 1;
								
	parameter					IVEntropyWidth =	64;

    `include "PathORAM.vh";
    `include "UORAM.vh";
    `include "PLB.vh";
    `include "PathORAMBackendLocal.vh";
    `include "PLBLocal.vh"; 
    `include "BucketLocal.vh"
    `include "DDR3SDRAMLocal.vh"

    wire Clock, Reset; 
    reg  CmdInValid, DataInValid, ReturnDataReady;
    wire CmdInReady, DataInReady, ReturnDataValid;
    reg [1:0] CmdIn;
    reg [ORAMU-1:0] AddrIn;
    wire [FEDWidth-1:0] DataIn, ReturnData;


    // DRAM interface
	wire	[DDRCWidth-1:0]		DRAM_Command;
	wire	[DDRAWidth-1:0]		DRAM_Address;
	wire	[DDRDWidth-1:0]		DRAM_WriteData, DRAM_ReadData; 
	wire	[DDRMWidth-1:0]		DRAM_WriteMask;
	wire						DRAM_CommandValid, DRAM_CommandReady;
	wire						DRAM_WriteDataValid, DRAM_WriteDataReady;
	wire						DRAM_ReadDataValid;	


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
							.DRAMAddress(           DRAM_Address),
							.DRAMCommand(			DRAM_Command),
							.DRAMCommandValid(		DRAM_CommandValid),
							.DRAMCommandReady(		DRAM_CommandReady),			
							.DRAMReadData(			DRAM_ReadData),
							.DRAMReadDataValid(		DRAM_ReadDataValid),			
							.DRAMWriteData(			DRAM_WriteData),
							.DRAMWriteMask(			DRAM_WriteMask),
							.DRAMWriteDataValid(	DRAM_WriteDataValid),
							.DRAMWriteDataReady(	DRAM_WriteDataReady));
	
							
	//--------------------------------------------------------------------------    
    localparam   Freq =	200_000_000;
    localparam   Cycle = (64'd1_000_000_000_000)/Freq;	

generate if (MIG_DRAM == 1) begin:USE_MIG_DRAM

    initial begin
        $display("Using MIG");
    end
    
     //***************************************************************************
     // Traffic Gen related parameters
     //***************************************************************************
     parameter SIMULATION            = "TRUE";
    //   parameter BL_WIDTH              = 10;
     parameter PORT_MODE             = "BI_MODE";
     parameter DATA_MODE             = 4'b0010;
     parameter TST_MEM_INSTR_MODE    = "R_W_INSTR_MODE";
     parameter EYE_TEST              = "FALSE";
                                       // set EYE_TEST = "TRUE" to probe memory
                                       // signals. Traffic Generator will only
                                       // write to one single location and no
                                       // read transactions will be generated.
     parameter DATA_PATTERN          = "DGEN_ALL";
                                        // For small devices, choose one only.
                                        // For large device, choose "DGEN_ALL"
                                        // "DGEN_HAMMER", "DGEN_WALKING1",
                                        // "DGEN_WALKING0","DGEN_ADDR","
                                        // "DGEN_NEIGHBOR","DGEN_PRBS","DGEN_ALL"
     parameter CMD_PATTERN           = "CGEN_ALL";
                                        // "CGEN_PRBS","CGEN_FIXED","CGEN_BRAM",
                                        // "CGEN_SEQUENTIAL", "CGEN_ALL"
    //   parameter SEL_VICTIM_LINE       = 11;
    //   parameter ADDR_MODE             = 4'b0011;
     parameter BEGIN_ADDRESS         = 32'h00000000;
     parameter END_ADDRESS           = 32'h00000fff;
     parameter PRBS_EADDR_MASK_POS   = 32'hff000000;
    
     //***************************************************************************
     // The following parameters refer to width of various ports
     //***************************************************************************
    //   parameter BANK_WIDTH            = 3;
                                       // # of memory Bank Address bits.
    //   parameter CK_WIDTH              = 1;
                                       // # of CK/CK# outputs to memory.
     parameter COL_WIDTH             = 10;
                                       // # of memory Column Address bits.
     parameter CS_WIDTH              = 1;
                                       // # of unique CS outputs to memory.
    //   parameter nCS_PER_RANK          = 1;
                                       // # of unique CS outputs per rank for phy
    //   parameter CKE_WIDTH             = 1;
                                       // # of CKE outputs to memory.
    //   parameter DATA_BUF_ADDR_WIDTH   = 5;
    //   parameter DQ_CNT_WIDTH          = 6;
                                       // = ceil(log2(DQ_WIDTH))
    //   parameter DQ_PER_DM             = 8;
     parameter DM_WIDTH              = 8;
                                       // # of DM (data mask)
     parameter DQ_WIDTH              = 64;
                                       // # of DQ (data)
     parameter DQS_WIDTH             = 8;
     parameter DQS_CNT_WIDTH         = 3;
                                       // = ceil(log2(DQS_WIDTH))
     parameter DRAM_WIDTH            = 8;
                                       // # of DQ per DQS
     parameter ECC                   = "OFF";
    //   parameter nBANK_MACHS           = 4;
     parameter RANKS                 = 1;
                                       // # of Ranks.
     parameter ODT_WIDTH             = 1;
                                       // # of ODT outputs to memory.
     parameter ROW_WIDTH             = 14;
                                   // # of memory Row Address bits.
    parameter ADDR_WIDTH            = 28;


 //***************************************************************************
 // The following parameters are mode register settings
 //***************************************************************************

    parameter BURST_MODE            = "8";

    parameter CA_MIRROR             = "OFF";
                                       // C/A mirror opt for DDR3 dual rank
     
     //***************************************************************************
     // The following parameters are multiplier and divisor factors for PLLE2.
     // Based on the selected design frequency these parameters vary.
     //***************************************************************************
    parameter CLKIN_PERIOD          = 5000;
                               
    
    //***************************************************************************
    // Simulation parameters
    //***************************************************************************
    parameter SIM_BYPASS_INIT_CAL   = "FAST";
                                   // # = "SIM_INIT_CAL_FULL" -  Complete
                                   //              memory init &
                                   //              calibration sequence
                                   // # = "SKIP" - Not supported
                                   // # = "FAST" - Complete memory init & use
                                   //              abbreviated calib sequence
    
    parameter TCQ                   = 100;
    //***************************************************************************
    // IODELAY and PHY related parameters
    //***************************************************************************
    
    parameter RST_ACT_LOW           = 0;
                                   // =1 for active low reset,
                                   // =0 for active high.
    //   parameter CAL_WIDTH             = "HALF";
    //   parameter STARVE_LIMIT          = 2;
                                   // # = 2,3,4.
    
     //***************************************************************************
     // Referece clock frequency parameters
     //***************************************************************************
     parameter REFCLK_FREQ           = 200.0;
                                       // IODELAYCTRL reference clock frequency
     //***************************************************************************
     // System clock frequency parameters
     //***************************************************************************
     parameter tCK                   = 1250;
                                       // memory tCK paramter.
                       // # = Clock Period in pS.
     parameter nCK_PER_CLK           = 4;
                                       // # of memory CKs per fabric CLK
    
     
    
     //***************************************************************************
     // Debug and Internal parameters
     //***************************************************************************
     parameter DEBUG_PORT            = "OFF";
                                       // # = "ON" Enable debug signals/controls.
                                       //   = "OFF" Disable debug signals/controls.
     //***************************************************************************
     // Debug and Internal parameters
     //***************************************************************************
     parameter DRAM_TYPE             = "DDR3";
    
      
    
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
    localparam ECC_TEST 		   	= "OFF" ;
    localparam ERR_INSERT = (ECC_TEST == "ON") ? "OFF" : ECC ;
    
    
    localparam real REFCLK_PERIOD = (1000000.0/(2*REFCLK_FREQ));
    localparam RESET_PERIOD = 200000; //in pSec  
    localparam real SYSCLK_PERIOD = tCK;
  
  

    //**************************************************************************//
    // Wire Declarations
    //**************************************************************************//
    reg                                sys_rst_n;
    wire                               sys_rst;
    
    
    reg                     sys_clk_i;
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
    wire                               tg_compare_error;
    wire [(CS_WIDTH*1)-1:0] ddr3_cs_n_fpga;
      
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
  //generate
    for (dqwd = 1;dqwd < DQ_WIDTH;dqwd = dqwd+1) begin : dq_delay
      WireDelay #
       (
        .Delay_g    (TPROP_PCB_DATA),
        .Delay_rd   (TPROP_PCB_DATA_RD),
        .ERR_INSERT ("OFF")
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
        .Delay_rd   (TPROP_PCB_DATA_RD),
        .ERR_INSERT (ERR_INSERT)
       )
      u_delay_dq_0
       (
        .A             (ddr3_dq_fpga[0]),
        .B             (ddr3_dq_sdram[0]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
  //endgenerate


  genvar dqswd;
  //generate
    for (dqswd = 0;dqswd < DQS_WIDTH;dqswd = dqswd+1) begin : dqs_delay
      WireDelay #
       (
        .Delay_g    (TPROP_DQS),
        .Delay_rd   (TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
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
        .Delay_rd   (TPROP_DQS_RD),
        .ERR_INSERT ("OFF")
       )
      u_delay_dqs_n
       (
        .A             (ddr3_dqs_n_fpga[dqswd]),
        .B             (ddr3_dqs_n_sdram[dqswd]),
        .reset         (sys_rst_n),
        .phy_init_done (init_calib_complete)
       );
    end
  //endgenerate
  

//**************************************************************************//
// Memory Models instantiations
//**************************************************************************//
    DDR3SDRAM 	DDR3SDRAMController(
                // System interface
                .sys_clk_p(				sys_clk_p),
                .sys_clk_n(				sys_clk_n),
                .sys_rst(				sys_rst),
                .ui_clk(				Clock),
                .ui_clk_sync_rst(		Reset),
                //.init_calib_complete(	DDR3SDRAM_ResetDone), // TODO not needed?
                                            
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
                .app_addr(				DRAM_Address),
                .app_cmd(				DRAM_Command),
                .app_en(				DRAM_CommandValid),
                .app_rdy(				DRAM_CommandReady),

                .app_rd_data(			DRAM_ReadData),
                .app_rd_data_end(		), // useless?
                .app_rd_data_valid(		DRAM_ReadDataValid),
                                            
                .app_wdf_data(			DRAM_WriteData),
                .app_wdf_mask(			DRAM_WriteMask), // this is synchronous to data interface
                .app_wdf_end(			DRAM_WriteDataValid), // since DDR3 BL = 8, each 512b data chunk is the "end" of that burst
                .app_wdf_wren(			DRAM_WriteDataValid),
                .app_wdf_rdy(			DRAM_WriteDataReady),

                .app_sr_req(			1'b0),
                .app_ref_req(			1'b0),
                .app_zq_req(			1'b0),
                .app_sr_active(			), // not connected
                .app_ref_ack(			), // not connected
                .app_zq_ack(			)); // not connected
                
    genvar r,i;
    //generate
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
    //endgenerate
end

else begin:SynDRAM

    initial begin
        $display("Using Synthesized DRAM");
    end

	//--------------------------------------------------------------------------
	//	DDR -> BRAM (to make simulation faster)
	//--------------------------------------------------------------------------
	
	SynthesizedDRAM	#(		.UWidth(				8),
							.AWidth(				DDRAWidth + 6),
							.DWidth(				DDRDWidth),
							.BurstLen(				1), // just for this module ...
							.EnableMask(			1),
							.Class1(				1),
							.RLatency(				1),
							.WLatency(				1)) 
				ddr3model(	.Clock(					Clock),
							.Reset(					Reset),

							.Initialized(			),
							.PoweredUp(				),

							.CommandAddress(		{DRAM_Address, 6'b000000}),
							.Command(				DRAM_Command),
							.CommandValid(			DRAM_CommandValid),
							.CommandReady(			DRAM_CommandReady),

							.DataIn(				DRAM_WriteData),
							.DataInMask(			DRAM_WriteMask),
							.DataInValid(			DRAM_WriteDataValid),
							.DataInReady(			DRAM_WriteDataReady),

							.DataOut(				DRAM_ReadData),
							.DataOutErrorChecked(	),
							.DataOutErrorCorrected(	),
							.DataOutValid(			DRAM_ReadDataValid),
							.DataOutReady(			1'b1));

    ClockSource #(Freq) ClockF200Gen(1'b1, Clock);
    reg [64-1:0] CycleCount;
    initial begin
        CycleCount = 0;
    end
    always@(posedge Clock) begin
        CycleCount = CycleCount + 1;
    end

    assign Reset = CycleCount < 30;

end
endgenerate

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
            #(Cycle) CmdInValid <= 0;
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
   
   always @(negedge Clock) begin
       if (CmdInReady) begin
           if (TestCount < 200) begin
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
   
   always @(negedge Clock) begin
       if (CmdInValid && CmdInReady && WriteCmd) begin
           Handle_ProgStore;
       end
   end
   
    always @(negedge Clock) begin    
       if (ORAM.BEnd_CmdValid && ORAM.BEnd_CmdReady) begin
           Check_Leaf;
       end
   end
    
endmodule
