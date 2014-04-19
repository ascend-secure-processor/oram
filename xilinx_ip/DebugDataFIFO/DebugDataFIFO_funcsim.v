// Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
// Date        : Sat Mar 22 16:05:43 2014
// Host        : running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               C:/chip/ascend_vc707/ascend_vc707.srcs/sources_1/ip/DebugDataFIFO/DebugDataFIFO_funcsim.v
// Design      : DebugDataFIFO
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "fifo_generator_v11_0,Vivado 2013.4" *) (* CHECK_LICENSE_TYPE = "DebugDataFIFO,fifo_generator_v11_0,{}" *) 
(* core_generation_info = "DebugDataFIFO,fifo_generator_v11_0,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=fifo_generator,x_ipVersion=11.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,C_COMMON_CLOCK=0,C_COUNT_TYPE=0,C_DATA_COUNT_WIDTH=8,C_DEFAULT_VALUE=BlankString,C_DIN_WIDTH=512,C_DOUT_RST_VAL=0,C_DOUT_WIDTH=512,C_ENABLE_RLOCS=0,C_FAMILY=virtex7,C_FULL_FLAGS_RST_VAL=1,C_HAS_ALMOST_EMPTY=0,C_HAS_ALMOST_FULL=0,C_HAS_BACKUP=0,C_HAS_DATA_COUNT=0,C_HAS_INT_CLK=0,C_HAS_MEMINIT_FILE=0,C_HAS_OVERFLOW=0,C_HAS_RD_DATA_COUNT=0,C_HAS_RD_RST=0,C_HAS_RST=1,C_HAS_SRST=0,C_HAS_UNDERFLOW=0,C_HAS_VALID=1,C_HAS_WR_ACK=0,C_HAS_WR_DATA_COUNT=0,C_HAS_WR_RST=0,C_IMPLEMENTATION_TYPE=2,C_INIT_WR_PNTR_VAL=0,C_MEMORY_TYPE=1,C_MIF_FILE_NAME=BlankString,C_OPTIMIZATION_MODE=0,C_OVERFLOW_LOW=0,C_PRELOAD_LATENCY=0,C_PRELOAD_REGS=1,C_PRIM_FIFO_TYPE=512x72,C_PROG_EMPTY_THRESH_ASSERT_VAL=4,C_PROG_EMPTY_THRESH_NEGATE_VAL=5,C_PROG_EMPTY_TYPE=0,C_PROG_FULL_THRESH_ASSERT_VAL=255,C_PROG_FULL_THRESH_NEGATE_VAL=254,C_PROG_FULL_TYPE=0,C_RD_DATA_COUNT_WIDTH=8,C_RD_DEPTH=256,C_RD_FREQ=1,C_RD_PNTR_WIDTH=8,C_UNDERFLOW_LOW=0,C_USE_DOUT_RST=1,C_USE_ECC=0,C_USE_EMBEDDED_REG=0,C_USE_FIFO16_FLAGS=0,C_USE_FWFT_DATA_COUNT=0,C_VALID_LOW=0,C_WR_ACK_LOW=0,C_WR_DATA_COUNT_WIDTH=8,C_WR_DEPTH=256,C_WR_FREQ=1,C_WR_PNTR_WIDTH=8,C_WR_RESPONSE_LATENCY=1,C_MSGON_VAL=1,C_ENABLE_RST_SYNC=1,C_ERROR_INJECTION_TYPE=0,C_SYNCHRONIZER_STAGE=2,C_INTERFACE_TYPE=0,C_AXI_TYPE=1,C_HAS_AXI_WR_CHANNEL=1,C_HAS_AXI_RD_CHANNEL=1,C_HAS_SLAVE_CE=0,C_HAS_MASTER_CE=0,C_ADD_NGC_CONSTRAINT=0,C_USE_COMMON_OVERFLOW=0,C_USE_COMMON_UNDERFLOW=0,C_USE_DEFAULT_SETTINGS=0,C_AXI_ID_WIDTH=1,C_AXI_ADDR_WIDTH=32,C_AXI_DATA_WIDTH=64,C_HAS_AXI_AWUSER=0,C_HAS_AXI_WUSER=0,C_HAS_AXI_BUSER=0,C_HAS_AXI_ARUSER=0,C_HAS_AXI_RUSER=0,C_AXI_ARUSER_WIDTH=1,C_AXI_AWUSER_WIDTH=1,C_AXI_WUSER_WIDTH=1,C_AXI_BUSER_WIDTH=1,C_AXI_RUSER_WIDTH=1,C_HAS_AXI_ID=0,C_HAS_AXIS_TDATA=1,C_HAS_AXIS_TID=0,C_HAS_AXIS_TDEST=0,C_HAS_AXIS_TUSER=1,C_HAS_AXIS_TREADY=1,C_HAS_AXIS_TLAST=0,C_HAS_AXIS_TSTRB=0,C_HAS_AXIS_TKEEP=0,C_AXIS_TDATA_WIDTH=8,C_AXIS_TID_WIDTH=1,C_AXIS_TDEST_WIDTH=1,C_AXIS_TUSER_WIDTH=4,C_AXIS_TSTRB_WIDTH=1,C_AXIS_TKEEP_WIDTH=1,C_WACH_TYPE=0,C_WDCH_TYPE=0,C_WRCH_TYPE=0,C_RACH_TYPE=0,C_RDCH_TYPE=0,C_AXIS_TYPE=0,C_IMPLEMENTATION_TYPE_WACH=1,C_IMPLEMENTATION_TYPE_WDCH=1,C_IMPLEMENTATION_TYPE_WRCH=1,C_IMPLEMENTATION_TYPE_RACH=1,C_IMPLEMENTATION_TYPE_RDCH=1,C_IMPLEMENTATION_TYPE_AXIS=1,C_APPLICATION_TYPE_WACH=0,C_APPLICATION_TYPE_WDCH=0,C_APPLICATION_TYPE_WRCH=0,C_APPLICATION_TYPE_RACH=0,C_APPLICATION_TYPE_RDCH=0,C_APPLICATION_TYPE_AXIS=0,C_PRIM_FIFO_TYPE_WACH=512x36,C_PRIM_FIFO_TYPE_WDCH=1kx36,C_PRIM_FIFO_TYPE_WRCH=512x36,C_PRIM_FIFO_TYPE_RACH=512x36,C_PRIM_FIFO_TYPE_RDCH=1kx36,C_PRIM_FIFO_TYPE_AXIS=1kx18,C_USE_ECC_WACH=0,C_USE_ECC_WDCH=0,C_USE_ECC_WRCH=0,C_USE_ECC_RACH=0,C_USE_ECC_RDCH=0,C_USE_ECC_AXIS=0,C_ERROR_INJECTION_TYPE_WACH=0,C_ERROR_INJECTION_TYPE_WDCH=0,C_ERROR_INJECTION_TYPE_WRCH=0,C_ERROR_INJECTION_TYPE_RACH=0,C_ERROR_INJECTION_TYPE_RDCH=0,C_ERROR_INJECTION_TYPE_AXIS=0,C_DIN_WIDTH_WACH=32,C_DIN_WIDTH_WDCH=64,C_DIN_WIDTH_WRCH=2,C_DIN_WIDTH_RACH=32,C_DIN_WIDTH_RDCH=64,C_DIN_WIDTH_AXIS=1,C_WR_DEPTH_WACH=16,C_WR_DEPTH_WDCH=1024,C_WR_DEPTH_WRCH=16,C_WR_DEPTH_RACH=16,C_WR_DEPTH_RDCH=1024,C_WR_DEPTH_AXIS=1024,C_WR_PNTR_WIDTH_WACH=4,C_WR_PNTR_WIDTH_WDCH=10,C_WR_PNTR_WIDTH_WRCH=4,C_WR_PNTR_WIDTH_RACH=4,C_WR_PNTR_WIDTH_RDCH=10,C_WR_PNTR_WIDTH_AXIS=10,C_HAS_DATA_COUNTS_WACH=0,C_HAS_DATA_COUNTS_WDCH=0,C_HAS_DATA_COUNTS_WRCH=0,C_HAS_DATA_COUNTS_RACH=0,C_HAS_DATA_COUNTS_RDCH=0,C_HAS_DATA_COUNTS_AXIS=0,C_HAS_PROG_FLAGS_WACH=0,C_HAS_PROG_FLAGS_WDCH=0,C_HAS_PROG_FLAGS_WRCH=0,C_HAS_PROG_FLAGS_RACH=0,C_HAS_PROG_FLAGS_RDCH=0,C_HAS_PROG_FLAGS_AXIS=0,C_PROG_FULL_TYPE_WACH=0,C_PROG_FULL_TYPE_WDCH=0,C_PROG_FULL_TYPE_WRCH=0,C_PROG_FULL_TYPE_RACH=0,C_PROG_FULL_TYPE_RDCH=0,C_PROG_FULL_TYPE_AXIS=0,C_PROG_FULL_THRESH_ASSERT_VAL_WACH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_WDCH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_WRCH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_RACH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_RDCH=1023,C_PROG_FULL_THRESH_ASSERT_VAL_AXIS=1023,C_PROG_EMPTY_TYPE_WACH=0,C_PROG_EMPTY_TYPE_WDCH=0,C_PROG_EMPTY_TYPE_WRCH=0,C_PROG_EMPTY_TYPE_RACH=0,C_PROG_EMPTY_TYPE_RDCH=0,C_PROG_EMPTY_TYPE_AXIS=0,C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH=1022,C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS=1022,C_REG_SLICE_MODE_WACH=0,C_REG_SLICE_MODE_WDCH=0,C_REG_SLICE_MODE_WRCH=0,C_REG_SLICE_MODE_RACH=0,C_REG_SLICE_MODE_RDCH=0,C_REG_SLICE_MODE_AXIS=0,C_AXI_LEN_WIDTH=8,C_AXI_LOCK_WIDTH=1}" *) 
(* NotValidForBitStream *)
module DebugDataFIFO
   (rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en,
    dout,
    full,
    empty,
    valid);
  input rst;
  input wr_clk;
  input rd_clk;
  input [511:0]din;
  input wr_en;
  input rd_en;
  output [511:0]dout;
  output full;
  output empty;
  output valid;

  wire \<const0> ;
  wire [511:0]din;
  wire [511:0]dout;
  wire empty;
  wire full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire valid;
  wire wr_clk;
  wire wr_en;
  wire NLW_U0_almost_empty_UNCONNECTED;
  wire NLW_U0_almost_full_UNCONNECTED;
  wire NLW_U0_axi_ar_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_overflow_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_full_UNCONNECTED;
  wire NLW_U0_axi_ar_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_underflow_UNCONNECTED;
  wire NLW_U0_axi_aw_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_overflow_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_full_UNCONNECTED;
  wire NLW_U0_axi_aw_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_underflow_UNCONNECTED;
  wire NLW_U0_axi_b_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_overflow_UNCONNECTED;
  wire NLW_U0_axi_b_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_b_prog_full_UNCONNECTED;
  wire NLW_U0_axi_b_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_underflow_UNCONNECTED;
  wire NLW_U0_axi_r_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_overflow_UNCONNECTED;
  wire NLW_U0_axi_r_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_r_prog_full_UNCONNECTED;
  wire NLW_U0_axi_r_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_underflow_UNCONNECTED;
  wire NLW_U0_axi_w_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_overflow_UNCONNECTED;
  wire NLW_U0_axi_w_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_w_prog_full_UNCONNECTED;
  wire NLW_U0_axi_w_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_underflow_UNCONNECTED;
  wire NLW_U0_axis_dbiterr_UNCONNECTED;
  wire NLW_U0_axis_overflow_UNCONNECTED;
  wire NLW_U0_axis_prog_empty_UNCONNECTED;
  wire NLW_U0_axis_prog_full_UNCONNECTED;
  wire NLW_U0_axis_sbiterr_UNCONNECTED;
  wire NLW_U0_axis_underflow_UNCONNECTED;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_m_axi_arvalid_UNCONNECTED;
  wire NLW_U0_m_axi_awvalid_UNCONNECTED;
  wire NLW_U0_m_axi_bready_UNCONNECTED;
  wire NLW_U0_m_axi_rready_UNCONNECTED;
  wire NLW_U0_m_axi_wlast_UNCONNECTED;
  wire NLW_U0_m_axi_wvalid_UNCONNECTED;
  wire NLW_U0_m_axis_tlast_UNCONNECTED;
  wire NLW_U0_m_axis_tvalid_UNCONNECTED;
  wire NLW_U0_overflow_UNCONNECTED;
  wire NLW_U0_prog_empty_UNCONNECTED;
  wire NLW_U0_prog_full_UNCONNECTED;
  wire NLW_U0_rd_rst_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_s_axis_tready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire NLW_U0_underflow_UNCONNECTED;
  wire NLW_U0_wr_ack_UNCONNECTED;
  wire NLW_U0_wr_rst_busy_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_wr_data_count_UNCONNECTED;
  wire [7:0]NLW_U0_data_count_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_araddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_arburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_arlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_aruser_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_awaddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_awburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_awlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awuser_UNCONNECTED;
  wire [63:0]NLW_U0_m_axi_wdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_wstrb_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wuser_UNCONNECTED;
  wire [7:0]NLW_U0_m_axis_tdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tdest_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tid_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tkeep_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tstrb_UNCONNECTED;
  wire [3:0]NLW_U0_m_axis_tuser_UNCONNECTED;
  wire [7:0]NLW_U0_rd_data_count_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_buser_UNCONNECTED;
  wire [63:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_ruser_UNCONNECTED;
  wire [7:0]NLW_U0_wr_data_count_UNCONNECTED;

GND GND
       (.G(\<const0> ));
(* C_ADD_NGC_CONSTRAINT = "0" *) 
   (* C_APPLICATION_TYPE_AXIS = "0" *) 
   (* C_APPLICATION_TYPE_RACH = "0" *) 
   (* C_APPLICATION_TYPE_RDCH = "0" *) 
   (* C_APPLICATION_TYPE_WACH = "0" *) 
   (* C_APPLICATION_TYPE_WDCH = "0" *) 
   (* C_APPLICATION_TYPE_WRCH = "0" *) 
   (* C_AXIS_TDATA_WIDTH = "8" *) 
   (* C_AXIS_TDEST_WIDTH = "1" *) 
   (* C_AXIS_TID_WIDTH = "1" *) 
   (* C_AXIS_TKEEP_WIDTH = "1" *) 
   (* C_AXIS_TSTRB_WIDTH = "1" *) 
   (* C_AXIS_TUSER_WIDTH = "4" *) 
   (* C_AXIS_TYPE = "0" *) 
   (* C_AXI_ADDR_WIDTH = "32" *) 
   (* C_AXI_ARUSER_WIDTH = "1" *) 
   (* C_AXI_AWUSER_WIDTH = "1" *) 
   (* C_AXI_BUSER_WIDTH = "1" *) 
   (* C_AXI_DATA_WIDTH = "64" *) 
   (* C_AXI_ID_WIDTH = "1" *) 
   (* C_AXI_LEN_WIDTH = "8" *) 
   (* C_AXI_LOCK_WIDTH = "1" *) 
   (* C_AXI_RUSER_WIDTH = "1" *) 
   (* C_AXI_TYPE = "1" *) 
   (* C_AXI_WUSER_WIDTH = "1" *) 
   (* C_COMMON_CLOCK = "0" *) 
   (* C_COUNT_TYPE = "0" *) 
   (* C_DATA_COUNT_WIDTH = "8" *) 
   (* C_DEFAULT_VALUE = "BlankString" *) 
   (* C_DIN_WIDTH = "512" *) 
   (* C_DIN_WIDTH_AXIS = "1" *) 
   (* C_DIN_WIDTH_RACH = "32" *) 
   (* C_DIN_WIDTH_RDCH = "64" *) 
   (* C_DIN_WIDTH_WACH = "32" *) 
   (* C_DIN_WIDTH_WDCH = "64" *) 
   (* C_DIN_WIDTH_WRCH = "2" *) 
   (* C_DOUT_RST_VAL = "0" *) 
   (* C_DOUT_WIDTH = "512" *) 
   (* C_ENABLE_RLOCS = "0" *) 
   (* C_ENABLE_RST_SYNC = "1" *) 
   (* C_ERROR_INJECTION_TYPE = "0" *) 
   (* C_ERROR_INJECTION_TYPE_AXIS = "0" *) 
   (* C_ERROR_INJECTION_TYPE_RACH = "0" *) 
   (* C_ERROR_INJECTION_TYPE_RDCH = "0" *) 
   (* C_ERROR_INJECTION_TYPE_WACH = "0" *) 
   (* C_ERROR_INJECTION_TYPE_WDCH = "0" *) 
   (* C_ERROR_INJECTION_TYPE_WRCH = "0" *) 
   (* C_FAMILY = "virtex7" *) 
   (* C_FULL_FLAGS_RST_VAL = "1" *) 
   (* C_HAS_ALMOST_EMPTY = "0" *) 
   (* C_HAS_ALMOST_FULL = "0" *) 
   (* C_HAS_AXIS_TDATA = "1" *) 
   (* C_HAS_AXIS_TDEST = "0" *) 
   (* C_HAS_AXIS_TID = "0" *) 
   (* C_HAS_AXIS_TKEEP = "0" *) 
   (* C_HAS_AXIS_TLAST = "0" *) 
   (* C_HAS_AXIS_TREADY = "1" *) 
   (* C_HAS_AXIS_TSTRB = "0" *) 
   (* C_HAS_AXIS_TUSER = "1" *) 
   (* C_HAS_AXI_ARUSER = "0" *) 
   (* C_HAS_AXI_AWUSER = "0" *) 
   (* C_HAS_AXI_BUSER = "0" *) 
   (* C_HAS_AXI_ID = "0" *) 
   (* C_HAS_AXI_RD_CHANNEL = "1" *) 
   (* C_HAS_AXI_RUSER = "0" *) 
   (* C_HAS_AXI_WR_CHANNEL = "1" *) 
   (* C_HAS_AXI_WUSER = "0" *) 
   (* C_HAS_BACKUP = "0" *) 
   (* C_HAS_DATA_COUNT = "0" *) 
   (* C_HAS_DATA_COUNTS_AXIS = "0" *) 
   (* C_HAS_DATA_COUNTS_RACH = "0" *) 
   (* C_HAS_DATA_COUNTS_RDCH = "0" *) 
   (* C_HAS_DATA_COUNTS_WACH = "0" *) 
   (* C_HAS_DATA_COUNTS_WDCH = "0" *) 
   (* C_HAS_DATA_COUNTS_WRCH = "0" *) 
   (* C_HAS_INT_CLK = "0" *) 
   (* C_HAS_MASTER_CE = "0" *) 
   (* C_HAS_MEMINIT_FILE = "0" *) 
   (* C_HAS_OVERFLOW = "0" *) 
   (* C_HAS_PROG_FLAGS_AXIS = "0" *) 
   (* C_HAS_PROG_FLAGS_RACH = "0" *) 
   (* C_HAS_PROG_FLAGS_RDCH = "0" *) 
   (* C_HAS_PROG_FLAGS_WACH = "0" *) 
   (* C_HAS_PROG_FLAGS_WDCH = "0" *) 
   (* C_HAS_PROG_FLAGS_WRCH = "0" *) 
   (* C_HAS_RD_DATA_COUNT = "0" *) 
   (* C_HAS_RD_RST = "0" *) 
   (* C_HAS_RST = "1" *) 
   (* C_HAS_SLAVE_CE = "0" *) 
   (* C_HAS_SRST = "0" *) 
   (* C_HAS_UNDERFLOW = "0" *) 
   (* C_HAS_VALID = "1" *) 
   (* C_HAS_WR_ACK = "0" *) 
   (* C_HAS_WR_DATA_COUNT = "0" *) 
   (* C_HAS_WR_RST = "0" *) 
   (* C_IMPLEMENTATION_TYPE = "2" *) 
   (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) 
   (* C_IMPLEMENTATION_TYPE_RACH = "1" *) 
   (* C_IMPLEMENTATION_TYPE_RDCH = "1" *) 
   (* C_IMPLEMENTATION_TYPE_WACH = "1" *) 
   (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) 
   (* C_IMPLEMENTATION_TYPE_WRCH = "1" *) 
   (* C_INIT_WR_PNTR_VAL = "0" *) 
   (* C_INTERFACE_TYPE = "0" *) 
   (* C_MEMORY_TYPE = "1" *) 
   (* C_MIF_FILE_NAME = "BlankString" *) 
   (* C_MSGON_VAL = "1" *) 
   (* C_OPTIMIZATION_MODE = "0" *) 
   (* C_OVERFLOW_LOW = "0" *) 
   (* C_PRELOAD_LATENCY = "0" *) 
   (* C_PRELOAD_REGS = "1" *) 
   (* C_PRIM_FIFO_TYPE = "512x72" *) 
   (* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) 
   (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) 
   (* C_PRIM_FIFO_TYPE_RDCH = "1kx36" *) 
   (* C_PRIM_FIFO_TYPE_WACH = "512x36" *) 
   (* C_PRIM_FIFO_TYPE_WDCH = "1kx36" *) 
   (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL = "4" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
   (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) 
   (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "5" *) 
   (* C_PROG_EMPTY_TYPE = "0" *) 
   (* C_PROG_EMPTY_TYPE_AXIS = "0" *) 
   (* C_PROG_EMPTY_TYPE_RACH = "0" *) 
   (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
   (* C_PROG_EMPTY_TYPE_WACH = "0" *) 
   (* C_PROG_EMPTY_TYPE_WDCH = "0" *) 
   (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL = "255" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
   (* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) 
   (* C_PROG_FULL_THRESH_NEGATE_VAL = "254" *) 
   (* C_PROG_FULL_TYPE = "0" *) 
   (* C_PROG_FULL_TYPE_AXIS = "0" *) 
   (* C_PROG_FULL_TYPE_RACH = "0" *) 
   (* C_PROG_FULL_TYPE_RDCH = "0" *) 
   (* C_PROG_FULL_TYPE_WACH = "0" *) 
   (* C_PROG_FULL_TYPE_WDCH = "0" *) 
   (* C_PROG_FULL_TYPE_WRCH = "0" *) 
   (* C_RACH_TYPE = "0" *) 
   (* C_RDCH_TYPE = "0" *) 
   (* C_RD_DATA_COUNT_WIDTH = "8" *) 
   (* C_RD_DEPTH = "256" *) 
   (* C_RD_FREQ = "1" *) 
   (* C_RD_PNTR_WIDTH = "8" *) 
   (* C_REG_SLICE_MODE_AXIS = "0" *) 
   (* C_REG_SLICE_MODE_RACH = "0" *) 
   (* C_REG_SLICE_MODE_RDCH = "0" *) 
   (* C_REG_SLICE_MODE_WACH = "0" *) 
   (* C_REG_SLICE_MODE_WDCH = "0" *) 
   (* C_REG_SLICE_MODE_WRCH = "0" *) 
   (* C_SYNCHRONIZER_STAGE = "2" *) 
   (* C_UNDERFLOW_LOW = "0" *) 
   (* C_USE_COMMON_OVERFLOW = "0" *) 
   (* C_USE_COMMON_UNDERFLOW = "0" *) 
   (* C_USE_DEFAULT_SETTINGS = "0" *) 
   (* C_USE_DOUT_RST = "1" *) 
   (* C_USE_ECC = "0" *) 
   (* C_USE_ECC_AXIS = "0" *) 
   (* C_USE_ECC_RACH = "0" *) 
   (* C_USE_ECC_RDCH = "0" *) 
   (* C_USE_ECC_WACH = "0" *) 
   (* C_USE_ECC_WDCH = "0" *) 
   (* C_USE_ECC_WRCH = "0" *) 
   (* C_USE_EMBEDDED_REG = "0" *) 
   (* C_USE_FIFO16_FLAGS = "0" *) 
   (* C_USE_FWFT_DATA_COUNT = "0" *) 
   (* C_VALID_LOW = "0" *) 
   (* C_WACH_TYPE = "0" *) 
   (* C_WDCH_TYPE = "0" *) 
   (* C_WRCH_TYPE = "0" *) 
   (* C_WR_ACK_LOW = "0" *) 
   (* C_WR_DATA_COUNT_WIDTH = "8" *) 
   (* C_WR_DEPTH = "256" *) 
   (* C_WR_DEPTH_AXIS = "1024" *) 
   (* C_WR_DEPTH_RACH = "16" *) 
   (* C_WR_DEPTH_RDCH = "1024" *) 
   (* C_WR_DEPTH_WACH = "16" *) 
   (* C_WR_DEPTH_WDCH = "1024" *) 
   (* C_WR_DEPTH_WRCH = "16" *) 
   (* C_WR_FREQ = "1" *) 
   (* C_WR_PNTR_WIDTH = "8" *) 
   (* C_WR_PNTR_WIDTH_AXIS = "10" *) 
   (* C_WR_PNTR_WIDTH_RACH = "4" *) 
   (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
   (* C_WR_PNTR_WIDTH_WACH = "4" *) 
   (* C_WR_PNTR_WIDTH_WDCH = "10" *) 
   (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
   (* C_WR_RESPONSE_LATENCY = "1" *) 
   DebugDataFIFOfifo_generator_v11_0__parameterized0 U0
       (.almost_empty(NLW_U0_almost_empty_UNCONNECTED),
        .almost_full(NLW_U0_almost_full_UNCONNECTED),
        .axi_ar_data_count(NLW_U0_axi_ar_data_count_UNCONNECTED[4:0]),
        .axi_ar_dbiterr(NLW_U0_axi_ar_dbiterr_UNCONNECTED),
        .axi_ar_injectdbiterr(\<const0> ),
        .axi_ar_injectsbiterr(\<const0> ),
        .axi_ar_overflow(NLW_U0_axi_ar_overflow_UNCONNECTED),
        .axi_ar_prog_empty(NLW_U0_axi_ar_prog_empty_UNCONNECTED),
        .axi_ar_prog_empty_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axi_ar_prog_full(NLW_U0_axi_ar_prog_full_UNCONNECTED),
        .axi_ar_prog_full_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axi_ar_rd_data_count(NLW_U0_axi_ar_rd_data_count_UNCONNECTED[4:0]),
        .axi_ar_sbiterr(NLW_U0_axi_ar_sbiterr_UNCONNECTED),
        .axi_ar_underflow(NLW_U0_axi_ar_underflow_UNCONNECTED),
        .axi_ar_wr_data_count(NLW_U0_axi_ar_wr_data_count_UNCONNECTED[4:0]),
        .axi_aw_data_count(NLW_U0_axi_aw_data_count_UNCONNECTED[4:0]),
        .axi_aw_dbiterr(NLW_U0_axi_aw_dbiterr_UNCONNECTED),
        .axi_aw_injectdbiterr(\<const0> ),
        .axi_aw_injectsbiterr(\<const0> ),
        .axi_aw_overflow(NLW_U0_axi_aw_overflow_UNCONNECTED),
        .axi_aw_prog_empty(NLW_U0_axi_aw_prog_empty_UNCONNECTED),
        .axi_aw_prog_empty_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axi_aw_prog_full(NLW_U0_axi_aw_prog_full_UNCONNECTED),
        .axi_aw_prog_full_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axi_aw_rd_data_count(NLW_U0_axi_aw_rd_data_count_UNCONNECTED[4:0]),
        .axi_aw_sbiterr(NLW_U0_axi_aw_sbiterr_UNCONNECTED),
        .axi_aw_underflow(NLW_U0_axi_aw_underflow_UNCONNECTED),
        .axi_aw_wr_data_count(NLW_U0_axi_aw_wr_data_count_UNCONNECTED[4:0]),
        .axi_b_data_count(NLW_U0_axi_b_data_count_UNCONNECTED[4:0]),
        .axi_b_dbiterr(NLW_U0_axi_b_dbiterr_UNCONNECTED),
        .axi_b_injectdbiterr(\<const0> ),
        .axi_b_injectsbiterr(\<const0> ),
        .axi_b_overflow(NLW_U0_axi_b_overflow_UNCONNECTED),
        .axi_b_prog_empty(NLW_U0_axi_b_prog_empty_UNCONNECTED),
        .axi_b_prog_empty_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axi_b_prog_full(NLW_U0_axi_b_prog_full_UNCONNECTED),
        .axi_b_prog_full_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axi_b_rd_data_count(NLW_U0_axi_b_rd_data_count_UNCONNECTED[4:0]),
        .axi_b_sbiterr(NLW_U0_axi_b_sbiterr_UNCONNECTED),
        .axi_b_underflow(NLW_U0_axi_b_underflow_UNCONNECTED),
        .axi_b_wr_data_count(NLW_U0_axi_b_wr_data_count_UNCONNECTED[4:0]),
        .axi_r_data_count(NLW_U0_axi_r_data_count_UNCONNECTED[10:0]),
        .axi_r_dbiterr(NLW_U0_axi_r_dbiterr_UNCONNECTED),
        .axi_r_injectdbiterr(\<const0> ),
        .axi_r_injectsbiterr(\<const0> ),
        .axi_r_overflow(NLW_U0_axi_r_overflow_UNCONNECTED),
        .axi_r_prog_empty(NLW_U0_axi_r_prog_empty_UNCONNECTED),
        .axi_r_prog_empty_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axi_r_prog_full(NLW_U0_axi_r_prog_full_UNCONNECTED),
        .axi_r_prog_full_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axi_r_rd_data_count(NLW_U0_axi_r_rd_data_count_UNCONNECTED[10:0]),
        .axi_r_sbiterr(NLW_U0_axi_r_sbiterr_UNCONNECTED),
        .axi_r_underflow(NLW_U0_axi_r_underflow_UNCONNECTED),
        .axi_r_wr_data_count(NLW_U0_axi_r_wr_data_count_UNCONNECTED[10:0]),
        .axi_w_data_count(NLW_U0_axi_w_data_count_UNCONNECTED[10:0]),
        .axi_w_dbiterr(NLW_U0_axi_w_dbiterr_UNCONNECTED),
        .axi_w_injectdbiterr(\<const0> ),
        .axi_w_injectsbiterr(\<const0> ),
        .axi_w_overflow(NLW_U0_axi_w_overflow_UNCONNECTED),
        .axi_w_prog_empty(NLW_U0_axi_w_prog_empty_UNCONNECTED),
        .axi_w_prog_empty_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axi_w_prog_full(NLW_U0_axi_w_prog_full_UNCONNECTED),
        .axi_w_prog_full_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axi_w_rd_data_count(NLW_U0_axi_w_rd_data_count_UNCONNECTED[10:0]),
        .axi_w_sbiterr(NLW_U0_axi_w_sbiterr_UNCONNECTED),
        .axi_w_underflow(NLW_U0_axi_w_underflow_UNCONNECTED),
        .axi_w_wr_data_count(NLW_U0_axi_w_wr_data_count_UNCONNECTED[10:0]),
        .axis_data_count(NLW_U0_axis_data_count_UNCONNECTED[10:0]),
        .axis_dbiterr(NLW_U0_axis_dbiterr_UNCONNECTED),
        .axis_injectdbiterr(\<const0> ),
        .axis_injectsbiterr(\<const0> ),
        .axis_overflow(NLW_U0_axis_overflow_UNCONNECTED),
        .axis_prog_empty(NLW_U0_axis_prog_empty_UNCONNECTED),
        .axis_prog_empty_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axis_prog_full(NLW_U0_axis_prog_full_UNCONNECTED),
        .axis_prog_full_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .axis_rd_data_count(NLW_U0_axis_rd_data_count_UNCONNECTED[10:0]),
        .axis_sbiterr(NLW_U0_axis_sbiterr_UNCONNECTED),
        .axis_underflow(NLW_U0_axis_underflow_UNCONNECTED),
        .axis_wr_data_count(NLW_U0_axis_wr_data_count_UNCONNECTED[10:0]),
        .backup(\<const0> ),
        .backup_marker(\<const0> ),
        .clk(\<const0> ),
        .data_count(NLW_U0_data_count_UNCONNECTED[7:0]),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .injectdbiterr(\<const0> ),
        .injectsbiterr(\<const0> ),
        .int_clk(\<const0> ),
        .m_aclk(\<const0> ),
        .m_aclk_en(\<const0> ),
        .m_axi_araddr(NLW_U0_m_axi_araddr_UNCONNECTED[31:0]),
        .m_axi_arburst(NLW_U0_m_axi_arburst_UNCONNECTED[1:0]),
        .m_axi_arcache(NLW_U0_m_axi_arcache_UNCONNECTED[3:0]),
        .m_axi_arid(NLW_U0_m_axi_arid_UNCONNECTED[0]),
        .m_axi_arlen(NLW_U0_m_axi_arlen_UNCONNECTED[7:0]),
        .m_axi_arlock(NLW_U0_m_axi_arlock_UNCONNECTED[0]),
        .m_axi_arprot(NLW_U0_m_axi_arprot_UNCONNECTED[2:0]),
        .m_axi_arqos(NLW_U0_m_axi_arqos_UNCONNECTED[3:0]),
        .m_axi_arready(\<const0> ),
        .m_axi_arregion(NLW_U0_m_axi_arregion_UNCONNECTED[3:0]),
        .m_axi_arsize(NLW_U0_m_axi_arsize_UNCONNECTED[2:0]),
        .m_axi_aruser(NLW_U0_m_axi_aruser_UNCONNECTED[0]),
        .m_axi_arvalid(NLW_U0_m_axi_arvalid_UNCONNECTED),
        .m_axi_awaddr(NLW_U0_m_axi_awaddr_UNCONNECTED[31:0]),
        .m_axi_awburst(NLW_U0_m_axi_awburst_UNCONNECTED[1:0]),
        .m_axi_awcache(NLW_U0_m_axi_awcache_UNCONNECTED[3:0]),
        .m_axi_awid(NLW_U0_m_axi_awid_UNCONNECTED[0]),
        .m_axi_awlen(NLW_U0_m_axi_awlen_UNCONNECTED[7:0]),
        .m_axi_awlock(NLW_U0_m_axi_awlock_UNCONNECTED[0]),
        .m_axi_awprot(NLW_U0_m_axi_awprot_UNCONNECTED[2:0]),
        .m_axi_awqos(NLW_U0_m_axi_awqos_UNCONNECTED[3:0]),
        .m_axi_awready(\<const0> ),
        .m_axi_awregion(NLW_U0_m_axi_awregion_UNCONNECTED[3:0]),
        .m_axi_awsize(NLW_U0_m_axi_awsize_UNCONNECTED[2:0]),
        .m_axi_awuser(NLW_U0_m_axi_awuser_UNCONNECTED[0]),
        .m_axi_awvalid(NLW_U0_m_axi_awvalid_UNCONNECTED),
        .m_axi_bid(\<const0> ),
        .m_axi_bready(NLW_U0_m_axi_bready_UNCONNECTED),
        .m_axi_bresp({\<const0> ,\<const0> }),
        .m_axi_buser(\<const0> ),
        .m_axi_bvalid(\<const0> ),
        .m_axi_rdata({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .m_axi_rid(\<const0> ),
        .m_axi_rlast(\<const0> ),
        .m_axi_rready(NLW_U0_m_axi_rready_UNCONNECTED),
        .m_axi_rresp({\<const0> ,\<const0> }),
        .m_axi_ruser(\<const0> ),
        .m_axi_rvalid(\<const0> ),
        .m_axi_wdata(NLW_U0_m_axi_wdata_UNCONNECTED[63:0]),
        .m_axi_wid(NLW_U0_m_axi_wid_UNCONNECTED[0]),
        .m_axi_wlast(NLW_U0_m_axi_wlast_UNCONNECTED),
        .m_axi_wready(\<const0> ),
        .m_axi_wstrb(NLW_U0_m_axi_wstrb_UNCONNECTED[7:0]),
        .m_axi_wuser(NLW_U0_m_axi_wuser_UNCONNECTED[0]),
        .m_axi_wvalid(NLW_U0_m_axi_wvalid_UNCONNECTED),
        .m_axis_tdata(NLW_U0_m_axis_tdata_UNCONNECTED[7:0]),
        .m_axis_tdest(NLW_U0_m_axis_tdest_UNCONNECTED[0]),
        .m_axis_tid(NLW_U0_m_axis_tid_UNCONNECTED[0]),
        .m_axis_tkeep(NLW_U0_m_axis_tkeep_UNCONNECTED[0]),
        .m_axis_tlast(NLW_U0_m_axis_tlast_UNCONNECTED),
        .m_axis_tready(\<const0> ),
        .m_axis_tstrb(NLW_U0_m_axis_tstrb_UNCONNECTED[0]),
        .m_axis_tuser(NLW_U0_m_axis_tuser_UNCONNECTED[3:0]),
        .m_axis_tvalid(NLW_U0_m_axis_tvalid_UNCONNECTED),
        .overflow(NLW_U0_overflow_UNCONNECTED),
        .prog_empty(NLW_U0_prog_empty_UNCONNECTED),
        .prog_empty_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .prog_empty_thresh_assert({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .prog_empty_thresh_negate({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .prog_full(NLW_U0_prog_full_UNCONNECTED),
        .prog_full_thresh({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .prog_full_thresh_assert({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .prog_full_thresh_negate({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .rd_clk(rd_clk),
        .rd_data_count(NLW_U0_rd_data_count_UNCONNECTED[7:0]),
        .rd_en(rd_en),
        .rd_rst(\<const0> ),
        .rd_rst_busy(NLW_U0_rd_rst_busy_UNCONNECTED),
        .rst(rst),
        .s_aclk(\<const0> ),
        .s_aclk_en(\<const0> ),
        .s_aresetn(\<const0> ),
        .s_axi_araddr({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_arburst({\<const0> ,\<const0> }),
        .s_axi_arcache({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_arid(\<const0> ),
        .s_axi_arlen({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_arlock(\<const0> ),
        .s_axi_arprot({\<const0> ,\<const0> ,\<const0> }),
        .s_axi_arqos({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arregion({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_arsize({\<const0> ,\<const0> ,\<const0> }),
        .s_axi_aruser(\<const0> ),
        .s_axi_arvalid(\<const0> ),
        .s_axi_awaddr({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_awburst({\<const0> ,\<const0> }),
        .s_axi_awcache({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_awid(\<const0> ),
        .s_axi_awlen({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_awlock(\<const0> ),
        .s_axi_awprot({\<const0> ,\<const0> ,\<const0> }),
        .s_axi_awqos({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awregion({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_awsize({\<const0> ,\<const0> ,\<const0> }),
        .s_axi_awuser(\<const0> ),
        .s_axi_awvalid(\<const0> ),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[0]),
        .s_axi_bready(\<const0> ),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_buser(NLW_U0_s_axi_buser_UNCONNECTED[0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[63:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(\<const0> ),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_ruser(NLW_U0_s_axi_ruser_UNCONNECTED[0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_wdata({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_wid(\<const0> ),
        .s_axi_wlast(\<const0> ),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axi_wuser(\<const0> ),
        .s_axi_wvalid(\<const0> ),
        .s_axis_tdata({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axis_tdest(\<const0> ),
        .s_axis_tid(\<const0> ),
        .s_axis_tkeep(\<const0> ),
        .s_axis_tlast(\<const0> ),
        .s_axis_tready(NLW_U0_s_axis_tready_UNCONNECTED),
        .s_axis_tstrb(\<const0> ),
        .s_axis_tuser({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .s_axis_tvalid(\<const0> ),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .srst(\<const0> ),
        .underflow(NLW_U0_underflow_UNCONNECTED),
        .valid(valid),
        .wr_ack(NLW_U0_wr_ack_UNCONNECTED),
        .wr_clk(wr_clk),
        .wr_data_count(NLW_U0_wr_data_count_UNCONNECTED[7:0]),
        .wr_en(wr_en),
        .wr_rst(\<const0> ),
        .wr_rst_busy(NLW_U0_wr_rst_busy_UNCONNECTED));
endmodule

module DebugDataFIFOblk_mem_gen_generic_cstr
   (DOUTB,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    I1,
    Q,
    O2,
    I2,
    din);
  output [511:0]DOUTB;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input I1;
  input [0:0]Q;
  input [7:0]O2;
  input [7:0]I2;
  input [511:0]din;

  wire [511:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [511:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_prim_width \ramloop[0].ram.r 
       (.DOUTB(DOUTB[35:0]),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din[35:0]),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
DebugDataFIFOblk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.DOUTB(DOUTB[107:36]),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din[107:36]),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
DebugDataFIFOblk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
       (.DOUTB(DOUTB[179:108]),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din[179:108]),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
DebugDataFIFOblk_mem_gen_prim_width__parameterized2 \ramloop[3].ram.r 
       (.DOUTB(DOUTB[251:180]),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din[251:180]),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
DebugDataFIFOblk_mem_gen_prim_width__parameterized3 \ramloop[4].ram.r 
       (.DOUTB(DOUTB[323:252]),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din[323:252]),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
DebugDataFIFOblk_mem_gen_prim_width__parameterized4 \ramloop[5].ram.r 
       (.DOUTB(DOUTB[395:324]),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din[395:324]),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
DebugDataFIFOblk_mem_gen_prim_width__parameterized5 \ramloop[6].ram.r 
       (.DOUTB(DOUTB[467:396]),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din[467:396]),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
DebugDataFIFOblk_mem_gen_prim_width__parameterized6 \ramloop[7].ram.r 
       (.DOUTB(DOUTB[511:468]),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din[511:468]),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

module DebugDataFIFOblk_mem_gen_prim_width
   (DOUTB,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    I1,
    Q,
    O2,
    I2,
    din);
  output [35:0]DOUTB;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input I1;
  input [0:0]Q;
  input [7:0]O2;
  input [7:0]I2;
  input [35:0]din;

  wire [35:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [35:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_prim_wrapper \prim_noinit.ram 
       (.DOUTB(DOUTB),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module DebugDataFIFOblk_mem_gen_prim_width__parameterized0
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized0 \prim_noinit.ram 
       (.DOUTB(DOUTB),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module DebugDataFIFOblk_mem_gen_prim_width__parameterized1
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized1 \prim_noinit.ram 
       (.DOUTB(DOUTB),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module DebugDataFIFOblk_mem_gen_prim_width__parameterized2
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized2 \prim_noinit.ram 
       (.DOUTB(DOUTB),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module DebugDataFIFOblk_mem_gen_prim_width__parameterized3
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized3 \prim_noinit.ram 
       (.DOUTB(DOUTB),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module DebugDataFIFOblk_mem_gen_prim_width__parameterized4
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized4 \prim_noinit.ram 
       (.DOUTB(DOUTB),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module DebugDataFIFOblk_mem_gen_prim_width__parameterized5
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized5 \prim_noinit.ram 
       (.DOUTB(DOUTB),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module DebugDataFIFOblk_mem_gen_prim_width__parameterized6
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [43:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [43:0]din;

  wire [43:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [43:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized6 \prim_noinit.ram 
       (.DOUTB(DOUTB),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

module DebugDataFIFOblk_mem_gen_prim_wrapper
   (DOUTB,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    I1,
    Q,
    O2,
    I2,
    din);
  output [35:0]DOUTB;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input I1;
  input [0:0]Q;
  input [7:0]O2;
  input [7:0]I2;
  input [35:0]din;

  wire \<const0> ;
  wire [35:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [35:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

(* box_type = "PRIMITIVE" *) 
   RAMB18E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(36),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(36)) 
     \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram 
       (.ADDRARDADDR({\<const0> ,O2,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .ADDRBWRADDR({\<const0> ,I2,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DIADI({din[16:9],din[7:0]}),
        .DIBDI({din[34:27],din[25:18]}),
        .DIPADIP({din[17],din[8]}),
        .DIPBDIP({din[35],din[26]}),
        .DOADO({DOUTB[16:9],DOUTB[7:0]}),
        .DOBDO({DOUTB[34:27],DOUTB[25:18]}),
        .DOPADOP({DOUTB[17],DOUTB[8]}),
        .DOPBDOP({DOUTB[35],DOUTB[26]}),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(I1),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(Q),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({\<const0> ,\<const0> }),
        .WEBWE({I1,I1,I1,I1}));
GND GND
       (.G(\<const0> ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized0
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire \<const0> ;
  wire \<const1> ;
  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

(* box_type = "PRIMITIVE" *) 
   RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
     \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram 
       (.ADDRARDADDR({\<const1> ,\<const0> ,O2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({\<const1> ,\<const0> ,I2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CASCADEINA(\<const0> ),
        .CASCADEINB(\<const0> ),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({din[34:27],din[25:18],din[16:9],din[7:0]}),
        .DIBDI({din[70:63],din[61:54],din[52:45],din[43:36]}),
        .DIPADIP({din[35],din[26],din[17],din[8]}),
        .DIPBDIP({din[71],din[62],din[53],din[44]}),
        .DOADO({DOUTB[34:27],DOUTB[25:18],DOUTB[16:9],DOUTB[7:0]}),
        .DOBDO({DOUTB[70:63],DOUTB[61:54],DOUTB[52:45],DOUTB[43:36]}),
        .DOPADOP({DOUTB[35],DOUTB[26],DOUTB[17],DOUTB[8]}),
        .DOPBDOP({DOUTB[71],DOUTB[62],DOUTB[53],DOUTB[44]}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(I1),
        .INJECTDBITERR(\<const0> ),
        .INJECTSBITERR(\<const0> ),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .WEBWE({I1,I1,I1,I1,I1,I1,I1,I1}));
GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized1
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire \<const0> ;
  wire \<const1> ;
  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

(* box_type = "PRIMITIVE" *) 
   RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
     \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram 
       (.ADDRARDADDR({\<const1> ,\<const0> ,O2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({\<const1> ,\<const0> ,I2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CASCADEINA(\<const0> ),
        .CASCADEINB(\<const0> ),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({din[34:27],din[25:18],din[16:9],din[7:0]}),
        .DIBDI({din[70:63],din[61:54],din[52:45],din[43:36]}),
        .DIPADIP({din[35],din[26],din[17],din[8]}),
        .DIPBDIP({din[71],din[62],din[53],din[44]}),
        .DOADO({DOUTB[34:27],DOUTB[25:18],DOUTB[16:9],DOUTB[7:0]}),
        .DOBDO({DOUTB[70:63],DOUTB[61:54],DOUTB[52:45],DOUTB[43:36]}),
        .DOPADOP({DOUTB[35],DOUTB[26],DOUTB[17],DOUTB[8]}),
        .DOPBDOP({DOUTB[71],DOUTB[62],DOUTB[53],DOUTB[44]}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(I1),
        .INJECTDBITERR(\<const0> ),
        .INJECTSBITERR(\<const0> ),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .WEBWE({I1,I1,I1,I1,I1,I1,I1,I1}));
GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized2
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire \<const0> ;
  wire \<const1> ;
  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

(* box_type = "PRIMITIVE" *) 
   RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
     \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram 
       (.ADDRARDADDR({\<const1> ,\<const0> ,O2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({\<const1> ,\<const0> ,I2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CASCADEINA(\<const0> ),
        .CASCADEINB(\<const0> ),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({din[34:27],din[25:18],din[16:9],din[7:0]}),
        .DIBDI({din[70:63],din[61:54],din[52:45],din[43:36]}),
        .DIPADIP({din[35],din[26],din[17],din[8]}),
        .DIPBDIP({din[71],din[62],din[53],din[44]}),
        .DOADO({DOUTB[34:27],DOUTB[25:18],DOUTB[16:9],DOUTB[7:0]}),
        .DOBDO({DOUTB[70:63],DOUTB[61:54],DOUTB[52:45],DOUTB[43:36]}),
        .DOPADOP({DOUTB[35],DOUTB[26],DOUTB[17],DOUTB[8]}),
        .DOPBDOP({DOUTB[71],DOUTB[62],DOUTB[53],DOUTB[44]}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(I1),
        .INJECTDBITERR(\<const0> ),
        .INJECTSBITERR(\<const0> ),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .WEBWE({I1,I1,I1,I1,I1,I1,I1,I1}));
GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized3
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire \<const0> ;
  wire \<const1> ;
  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

(* box_type = "PRIMITIVE" *) 
   RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
     \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram 
       (.ADDRARDADDR({\<const1> ,\<const0> ,O2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({\<const1> ,\<const0> ,I2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CASCADEINA(\<const0> ),
        .CASCADEINB(\<const0> ),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({din[34:27],din[25:18],din[16:9],din[7:0]}),
        .DIBDI({din[70:63],din[61:54],din[52:45],din[43:36]}),
        .DIPADIP({din[35],din[26],din[17],din[8]}),
        .DIPBDIP({din[71],din[62],din[53],din[44]}),
        .DOADO({DOUTB[34:27],DOUTB[25:18],DOUTB[16:9],DOUTB[7:0]}),
        .DOBDO({DOUTB[70:63],DOUTB[61:54],DOUTB[52:45],DOUTB[43:36]}),
        .DOPADOP({DOUTB[35],DOUTB[26],DOUTB[17],DOUTB[8]}),
        .DOPBDOP({DOUTB[71],DOUTB[62],DOUTB[53],DOUTB[44]}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(I1),
        .INJECTDBITERR(\<const0> ),
        .INJECTSBITERR(\<const0> ),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .WEBWE({I1,I1,I1,I1,I1,I1,I1,I1}));
GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized4
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire \<const0> ;
  wire \<const1> ;
  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

(* box_type = "PRIMITIVE" *) 
   RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
     \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram 
       (.ADDRARDADDR({\<const1> ,\<const0> ,O2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({\<const1> ,\<const0> ,I2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CASCADEINA(\<const0> ),
        .CASCADEINB(\<const0> ),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({din[34:27],din[25:18],din[16:9],din[7:0]}),
        .DIBDI({din[70:63],din[61:54],din[52:45],din[43:36]}),
        .DIPADIP({din[35],din[26],din[17],din[8]}),
        .DIPBDIP({din[71],din[62],din[53],din[44]}),
        .DOADO({DOUTB[34:27],DOUTB[25:18],DOUTB[16:9],DOUTB[7:0]}),
        .DOBDO({DOUTB[70:63],DOUTB[61:54],DOUTB[52:45],DOUTB[43:36]}),
        .DOPADOP({DOUTB[35],DOUTB[26],DOUTB[17],DOUTB[8]}),
        .DOPBDOP({DOUTB[71],DOUTB[62],DOUTB[53],DOUTB[44]}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(I1),
        .INJECTDBITERR(\<const0> ),
        .INJECTSBITERR(\<const0> ),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .WEBWE({I1,I1,I1,I1,I1,I1,I1,I1}));
GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized5
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [71:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [71:0]din;

  wire \<const0> ;
  wire \<const1> ;
  wire [71:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [71:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

(* box_type = "PRIMITIVE" *) 
   RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
     \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram 
       (.ADDRARDADDR({\<const1> ,\<const0> ,O2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({\<const1> ,\<const0> ,I2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CASCADEINA(\<const0> ),
        .CASCADEINB(\<const0> ),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({din[34:27],din[25:18],din[16:9],din[7:0]}),
        .DIBDI({din[70:63],din[61:54],din[52:45],din[43:36]}),
        .DIPADIP({din[35],din[26],din[17],din[8]}),
        .DIPBDIP({din[71],din[62],din[53],din[44]}),
        .DOADO({DOUTB[34:27],DOUTB[25:18],DOUTB[16:9],DOUTB[7:0]}),
        .DOBDO({DOUTB[70:63],DOUTB[61:54],DOUTB[52:45],DOUTB[43:36]}),
        .DOPADOP({DOUTB[35],DOUTB[26],DOUTB[17],DOUTB[8]}),
        .DOPBDOP({DOUTB[71],DOUTB[62],DOUTB[53],DOUTB[44]}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(I1),
        .INJECTDBITERR(\<const0> ),
        .INJECTSBITERR(\<const0> ),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .WEBWE({I1,I1,I1,I1,I1,I1,I1,I1}));
GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module DebugDataFIFOblk_mem_gen_prim_wrapper__parameterized6
   (DOUTB,
    tmp_ram_rd_en,
    rd_clk,
    Q,
    I1,
    wr_clk,
    O2,
    I2,
    din);
  output [43:0]DOUTB;
  input tmp_ram_rd_en;
  input rd_clk;
  input [0:0]Q;
  input I1;
  input wr_clk;
  input [7:0]O2;
  input [7:0]I2;
  input [43:0]din;

  wire \<const0> ;
  wire \<const1> ;
  wire [43:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [43:0]din;
  wire \n_12_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_13_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_20_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_21_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_22_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_28_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_29_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_36_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_37_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_38_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_44_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_45_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_4_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_52_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_53_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_54_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_5_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_60_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_61_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_68_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_69_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_6_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_70_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_71_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_72_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_73_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_74_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire \n_75_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

(* box_type = "PRIMITIVE" *) 
   RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
     \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram 
       (.ADDRARDADDR({\<const1> ,\<const0> ,O2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({\<const1> ,\<const0> ,I2,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CASCADEINA(\<const0> ),
        .CASCADEINB(\<const0> ),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(rd_clk),
        .CLKBWRCLK(wr_clk),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,din[21:17],\<const0> ,\<const0> ,din[16:11],\<const0> ,\<const0> ,\<const0> ,din[10:6],\<const0> ,\<const0> ,din[5:0]}),
        .DIBDI({\<const0> ,\<const0> ,\<const0> ,din[43:39],\<const0> ,\<const0> ,din[38:33],\<const0> ,\<const0> ,\<const0> ,din[32:28],\<const0> ,\<const0> ,din[27:22]}),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .DIPBDIP({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .DOADO({\n_4_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_5_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_6_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,DOUTB[21:17],\n_12_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_13_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,DOUTB[16:11],\n_20_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_21_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_22_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,DOUTB[10:6],\n_28_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_29_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,DOUTB[5:0]}),
        .DOBDO({\n_36_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_37_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_38_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,DOUTB[43:39],\n_44_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_45_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,DOUTB[38:33],\n_52_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_53_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_54_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,DOUTB[32:28],\n_60_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_61_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,DOUTB[27:22]}),
        .DOPADOP({\n_68_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_69_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_70_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_71_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram }),
        .DOPBDOP({\n_72_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_73_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_74_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram ,\n_75_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram }),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(tmp_ram_rd_en),
        .ENBWREN(I1),
        .INJECTDBITERR(\<const0> ),
        .INJECTSBITERR(\<const0> ),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(Q),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .WEBWE({I1,I1,I1,I1,I1,I1,I1,I1}));
GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
endmodule

module DebugDataFIFOblk_mem_gen_top
   (DOUTB,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    I1,
    Q,
    O2,
    I2,
    din);
  output [511:0]DOUTB;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input I1;
  input [0:0]Q;
  input [7:0]O2;
  input [7:0]I2;
  input [511:0]din;

  wire [511:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [511:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_generic_cstr \valid.cstr 
       (.DOUTB(DOUTB),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_1" *) 
module DebugDataFIFOblk_mem_gen_v8_1__parameterized0
   (DOUTB,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    I1,
    Q,
    O2,
    I2,
    din);
  output [511:0]DOUTB;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input I1;
  input [0:0]Q;
  input [7:0]O2;
  input [7:0]I2;
  input [511:0]din;

  wire [511:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [511:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_v8_1_synth inst_blk_mem_gen
       (.DOUTB(DOUTB),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

module DebugDataFIFOblk_mem_gen_v8_1_synth
   (DOUTB,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    I1,
    Q,
    O2,
    I2,
    din);
  output [511:0]DOUTB;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input I1;
  input [0:0]Q;
  input [7:0]O2;
  input [7:0]I2;
  input [511:0]din;

  wire [511:0]DOUTB;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [511:0]din;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_top \gnativebmg.native_blk_mem_gen 
       (.DOUTB(DOUTB),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
endmodule

module DebugDataFIFOclk_x_pntrs
   (O1,
    Q,
    O2,
    ram_full_i,
    D,
    I1,
    I2,
    rst_full_gen_i,
    I3,
    I4,
    I5,
    rd_clk,
    I6,
    wr_clk,
    I7);
  output O1;
  output [7:0]Q;
  output [1:0]O2;
  output ram_full_i;
  input [1:0]D;
  input [5:0]I1;
  input [7:0]I2;
  input rst_full_gen_i;
  input I3;
  input [7:0]I4;
  input [7:0]I5;
  input rd_clk;
  input [0:0]I6;
  input wr_clk;
  input [0:0]I7;

  wire \<const1> ;
  wire [1:0]D;
  wire [5:0]I1;
  wire [7:0]I2;
  wire I3;
  wire [7:0]I4;
  wire [7:0]I5;
  wire [0:0]I6;
  wire [0:0]I7;
  wire O1;
  wire [1:0]O2;
  wire [7:0]Q;
  wire [7:0]Q_0;
  wire \gntv_or_sync_fifo.gl0.wr/gwas.wsts/comp1 ;
  wire \n_0_gsync_stage[1].wr_stg_inst ;
  wire \n_0_gsync_stage[2].wr_stg_inst ;
  wire n_0_ram_full_i_i_2;
  wire n_0_ram_full_i_i_4;
  wire n_0_ram_full_i_i_6;
  wire n_0_ram_full_i_i_7;
  wire \n_0_rd_pntr_gc[0]_i_1 ;
  wire \n_0_rd_pntr_gc[1]_i_1 ;
  wire \n_0_rd_pntr_gc[2]_i_1 ;
  wire \n_0_rd_pntr_gc[3]_i_1 ;
  wire \n_0_rd_pntr_gc[4]_i_1 ;
  wire \n_0_rd_pntr_gc[5]_i_1 ;
  wire \n_0_rd_pntr_gc[6]_i_1 ;
  wire \n_1_gsync_stage[1].wr_stg_inst ;
  wire \n_1_gsync_stage[2].wr_stg_inst ;
  wire \n_2_gsync_stage[1].wr_stg_inst ;
  wire \n_2_gsync_stage[2].wr_stg_inst ;
  wire \n_3_gsync_stage[1].wr_stg_inst ;
  wire \n_3_gsync_stage[2].wr_stg_inst ;
  wire \n_4_gsync_stage[1].wr_stg_inst ;
  wire \n_4_gsync_stage[2].wr_stg_inst ;
  wire \n_5_gsync_stage[1].wr_stg_inst ;
  wire \n_5_gsync_stage[2].wr_stg_inst ;
  wire \n_6_gsync_stage[1].wr_stg_inst ;
  wire \n_6_gsync_stage[2].wr_stg_inst ;
  wire \n_7_gsync_stage[1].wr_stg_inst ;
  wire \n_7_gsync_stage[2].wr_stg_inst ;
  wire [7:0]p_0_in;
  wire [6:0]p_0_in5_out;
  wire [7:2]p_0_out;
  wire ram_full_i;
  wire rd_clk;
  wire [7:0]rd_pntr_gc;
  wire rst_full_gen_i;
  wire wr_clk;
  wire [7:0]wr_pntr_gc;

VCC VCC
       (.P(\<const1> ));
DebugDataFIFOsynchronizer_ff \gsync_stage[1].rd_stg_inst 
       (.I1(wr_pntr_gc),
        .I6(I6),
        .Q(Q_0),
        .rd_clk(rd_clk));
DebugDataFIFOsynchronizer_ff_0 \gsync_stage[1].wr_stg_inst 
       (.I1(rd_pntr_gc),
        .I7(I7),
        .Q({\n_0_gsync_stage[1].wr_stg_inst ,\n_1_gsync_stage[1].wr_stg_inst ,\n_2_gsync_stage[1].wr_stg_inst ,\n_3_gsync_stage[1].wr_stg_inst ,\n_4_gsync_stage[1].wr_stg_inst ,\n_5_gsync_stage[1].wr_stg_inst ,\n_6_gsync_stage[1].wr_stg_inst ,\n_7_gsync_stage[1].wr_stg_inst }),
        .wr_clk(wr_clk));
DebugDataFIFOsynchronizer_ff_1 \gsync_stage[2].rd_stg_inst 
       (.D(Q_0),
        .I6(I6),
        .p_0_in(p_0_in),
        .rd_clk(rd_clk));
DebugDataFIFOsynchronizer_ff_2 \gsync_stage[2].wr_stg_inst 
       (.D({\n_0_gsync_stage[1].wr_stg_inst ,\n_1_gsync_stage[1].wr_stg_inst ,\n_2_gsync_stage[1].wr_stg_inst ,\n_3_gsync_stage[1].wr_stg_inst ,\n_4_gsync_stage[1].wr_stg_inst ,\n_5_gsync_stage[1].wr_stg_inst ,\n_6_gsync_stage[1].wr_stg_inst ,\n_7_gsync_stage[1].wr_stg_inst }),
        .I7(I7),
        .O1({\n_1_gsync_stage[2].wr_stg_inst ,\n_2_gsync_stage[2].wr_stg_inst ,\n_3_gsync_stage[2].wr_stg_inst ,\n_4_gsync_stage[2].wr_stg_inst ,\n_5_gsync_stage[2].wr_stg_inst ,\n_6_gsync_stage[2].wr_stg_inst ,\n_7_gsync_stage[2].wr_stg_inst }),
        .Q(\n_0_gsync_stage[2].wr_stg_inst ),
        .wr_clk(wr_clk));
LUT4 #(
    .INIT(16'h9009)) 
     ram_empty_fb_i_i_8
       (.I0(Q[2]),
        .I1(D[1]),
        .I2(Q[1]),
        .I3(D[0]),
        .O(O1));
LUT5 #(
    .INIT(32'h55554000)) 
     ram_full_i_i_1
       (.I0(rst_full_gen_i),
        .I1(n_0_ram_full_i_i_2),
        .I2(I3),
        .I3(n_0_ram_full_i_i_4),
        .I4(\gntv_or_sync_fifo.gl0.wr/gwas.wsts/comp1 ),
        .O(ram_full_i));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_full_i_i_2
       (.I0(p_0_out[5]),
        .I1(I1[3]),
        .I2(p_0_out[7]),
        .I3(I1[5]),
        .I4(I1[4]),
        .I5(p_0_out[6]),
        .O(n_0_ram_full_i_i_2));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_full_i_i_4
       (.I0(p_0_out[2]),
        .I1(I1[0]),
        .I2(p_0_out[3]),
        .I3(I1[1]),
        .I4(I1[2]),
        .I5(p_0_out[4]),
        .O(n_0_ram_full_i_i_4));
LUT6 #(
    .INIT(64'h9009000000000000)) 
     ram_full_i_i_5
       (.I0(p_0_out[7]),
        .I1(I2[7]),
        .I2(p_0_out[6]),
        .I3(I2[6]),
        .I4(n_0_ram_full_i_i_6),
        .I5(n_0_ram_full_i_i_7),
        .O(\gntv_or_sync_fifo.gl0.wr/gwas.wsts/comp1 ));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_full_i_i_6
       (.I0(O2[0]),
        .I1(I2[0]),
        .I2(O2[1]),
        .I3(I2[1]),
        .I4(I2[2]),
        .I5(p_0_out[2]),
        .O(n_0_ram_full_i_i_6));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_full_i_i_7
       (.I0(p_0_out[3]),
        .I1(I2[3]),
        .I2(p_0_out[4]),
        .I3(I2[4]),
        .I4(I2[5]),
        .I5(p_0_out[5]),
        .O(n_0_ram_full_i_i_7));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[0] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(\n_7_gsync_stage[2].wr_stg_inst ),
        .Q(O2[0]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[1] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(\n_6_gsync_stage[2].wr_stg_inst ),
        .Q(O2[1]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[2] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(\n_5_gsync_stage[2].wr_stg_inst ),
        .Q(p_0_out[2]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[3] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(\n_4_gsync_stage[2].wr_stg_inst ),
        .Q(p_0_out[3]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[4] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(\n_3_gsync_stage[2].wr_stg_inst ),
        .Q(p_0_out[4]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[5] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(\n_2_gsync_stage[2].wr_stg_inst ),
        .Q(p_0_out[5]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[6] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(\n_1_gsync_stage[2].wr_stg_inst ),
        .Q(p_0_out[6]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_bin_reg[7] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(\n_0_gsync_stage[2].wr_stg_inst ),
        .Q(p_0_out[7]));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[0]_i_1 
       (.I0(I5[0]),
        .I1(I5[1]),
        .O(\n_0_rd_pntr_gc[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[1]_i_1 
       (.I0(I5[1]),
        .I1(I5[2]),
        .O(\n_0_rd_pntr_gc[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[2]_i_1 
       (.I0(I5[2]),
        .I1(I5[3]),
        .O(\n_0_rd_pntr_gc[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[3]_i_1 
       (.I0(I5[3]),
        .I1(I5[4]),
        .O(\n_0_rd_pntr_gc[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[4]_i_1 
       (.I0(I5[4]),
        .I1(I5[5]),
        .O(\n_0_rd_pntr_gc[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[5]_i_1 
       (.I0(I5[5]),
        .I1(I5[6]),
        .O(\n_0_rd_pntr_gc[5]_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_gc[6]_i_1 
       (.I0(I5[6]),
        .I1(I5[7]),
        .O(\n_0_rd_pntr_gc[6]_i_1 ));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[0] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[0]_i_1 ),
        .Q(rd_pntr_gc[0]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[1] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[1]_i_1 ),
        .Q(rd_pntr_gc[1]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[2] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[2]_i_1 ),
        .Q(rd_pntr_gc[2]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[3] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[3]_i_1 ),
        .Q(rd_pntr_gc[3]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[4] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[4]_i_1 ),
        .Q(rd_pntr_gc[4]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[5] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[5]_i_1 ),
        .Q(rd_pntr_gc[5]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[6] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(\n_0_rd_pntr_gc[6]_i_1 ),
        .Q(rd_pntr_gc[6]));
FDCE #(
    .INIT(1'b0)) 
     \rd_pntr_gc_reg[7] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(I5[7]),
        .Q(rd_pntr_gc[7]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[0] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(p_0_in[0]),
        .Q(Q[0]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[1] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(p_0_in[1]),
        .Q(Q[1]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[2] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(p_0_in[2]),
        .Q(Q[2]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[3] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(p_0_in[3]),
        .Q(Q[3]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[4] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(p_0_in[4]),
        .Q(Q[4]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[5] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(p_0_in[5]),
        .Q(Q[5]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[6] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(p_0_in[6]),
        .Q(Q[6]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_bin_reg[7] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(p_0_in[7]),
        .Q(Q[7]));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[0]_i_1 
       (.I0(I4[0]),
        .I1(I4[1]),
        .O(p_0_in5_out[0]));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[1]_i_1 
       (.I0(I4[1]),
        .I1(I4[2]),
        .O(p_0_in5_out[1]));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[2]_i_1 
       (.I0(I4[2]),
        .I1(I4[3]),
        .O(p_0_in5_out[2]));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[3]_i_1 
       (.I0(I4[3]),
        .I1(I4[4]),
        .O(p_0_in5_out[3]));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[4]_i_1 
       (.I0(I4[4]),
        .I1(I4[5]),
        .O(p_0_in5_out[4]));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[5]_i_1 
       (.I0(I4[5]),
        .I1(I4[6]),
        .O(p_0_in5_out[5]));
LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_gc[6]_i_1 
       (.I0(I4[6]),
        .I1(I4[7]),
        .O(p_0_in5_out[6]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[0] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(p_0_in5_out[0]),
        .Q(wr_pntr_gc[0]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[1] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(p_0_in5_out[1]),
        .Q(wr_pntr_gc[1]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[2] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(p_0_in5_out[2]),
        .Q(wr_pntr_gc[2]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[3] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(p_0_in5_out[3]),
        .Q(wr_pntr_gc[3]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[4] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(p_0_in5_out[4]),
        .Q(wr_pntr_gc[4]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[5] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(p_0_in5_out[5]),
        .Q(wr_pntr_gc[5]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[6] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(p_0_in5_out[6]),
        .Q(wr_pntr_gc[6]));
FDCE #(
    .INIT(1'b0)) 
     \wr_pntr_gc_reg[7] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(I4[7]),
        .Q(wr_pntr_gc[7]));
endmodule

module DebugDataFIFOfifo_generator_ramfifo
   (dout,
    empty,
    valid,
    full,
    rd_en,
    wr_en,
    rd_clk,
    wr_clk,
    din,
    rst);
  output [511:0]dout;
  output empty;
  output valid;
  output full;
  input rd_en;
  input wr_en;
  input rd_clk;
  input wr_clk;
  input [511:0]din;
  input rst;

  wire RD_RST;
  wire RST;
  wire [511:0]din;
  wire [511:0]dout;
  wire empty;
  wire full;
  wire \gwas.wsts/ram_full_i ;
  wire \n_0_gntv_or_sync_fifo.gcx.clkx ;
  wire \n_1_gntv_or_sync_fifo.gl0.wr ;
  wire \n_8_gntv_or_sync_fifo.gl0.wr ;
  wire [1:0]p_0_out;
  wire p_14_out;
  wire [7:0]p_19_out;
  wire [7:0]p_1_out;
  wire [7:0]p_8_out;
  wire rd_clk;
  wire rd_en;
  wire [2:1]rd_pntr_plus1;
  wire [1:0]rd_rst_i;
  wire rst;
  wire rst_d2;
  wire rst_full_gen_i;
  wire tmp_ram_rd_en;
  wire valid;
  wire wr_clk;
  wire wr_en;
  wire [7:0]wr_pntr_plus1;
  wire [7:2]wr_pntr_plus2;
  wire [0:0]wr_rst_i;

DebugDataFIFOclk_x_pntrs \gntv_or_sync_fifo.gcx.clkx 
       (.D(rd_pntr_plus1),
        .I1(wr_pntr_plus2),
        .I2(wr_pntr_plus1),
        .I3(\n_1_gntv_or_sync_fifo.gl0.wr ),
        .I4(p_8_out),
        .I5(p_19_out),
        .I6(rd_rst_i[1]),
        .I7(wr_rst_i),
        .O1(\n_0_gntv_or_sync_fifo.gcx.clkx ),
        .O2(p_0_out),
        .Q(p_1_out),
        .ram_full_i(\gwas.wsts/ram_full_i ),
        .rd_clk(rd_clk),
        .rst_full_gen_i(rst_full_gen_i),
        .wr_clk(wr_clk));
DebugDataFIFOrd_logic \gntv_or_sync_fifo.gl0.rd 
       (.E(p_14_out),
        .I1(p_1_out),
        .I2(\n_0_gntv_or_sync_fifo.gcx.clkx ),
        .O1(rd_pntr_plus1),
        .O2(p_19_out),
        .Q({RD_RST,rd_rst_i[0]}),
        .empty(empty),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .valid(valid));
DebugDataFIFOwr_logic \gntv_or_sync_fifo.gl0.wr 
       (.E(\n_8_gntv_or_sync_fifo.gl0.wr ),
        .I1(RST),
        .O1(\n_1_gntv_or_sync_fifo.gl0.wr ),
        .O2(p_0_out),
        .O3(wr_pntr_plus1),
        .O4(p_8_out),
        .Q(wr_pntr_plus2),
        .full(full),
        .ram_full_i(\gwas.wsts/ram_full_i ),
        .rst_d2(rst_d2),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
DebugDataFIFOmemory \gntv_or_sync_fifo.mem 
       (.E(p_14_out),
        .I1(\n_8_gntv_or_sync_fifo.gl0.wr ),
        .I2(p_8_out),
        .O2(p_19_out),
        .Q(rd_rst_i[0]),
        .din(din),
        .dout(dout),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
DebugDataFIFOreset_blk_ramfifo rstblk
       (.O1({RD_RST,rd_rst_i}),
        .Q({RST,wr_rst_i}),
        .rd_clk(rd_clk),
        .rst(rst),
        .rst_d2(rst_d2),
        .rst_full_gen_i(rst_full_gen_i),
        .wr_clk(wr_clk));
endmodule

module DebugDataFIFOfifo_generator_top
   (dout,
    empty,
    valid,
    full,
    rd_en,
    wr_en,
    rd_clk,
    wr_clk,
    din,
    rst);
  output [511:0]dout;
  output empty;
  output valid;
  output full;
  input rd_en;
  input wr_en;
  input rd_clk;
  input wr_clk;
  input [511:0]din;
  input rst;

  wire [511:0]din;
  wire [511:0]dout;
  wire empty;
  wire full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire valid;
  wire wr_clk;
  wire wr_en;

DebugDataFIFOfifo_generator_ramfifo \grf.rf 
       (.din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .valid(valid),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "fifo_generator_v11_0" *) (* C_COMMON_CLOCK = "0" *) (* C_COUNT_TYPE = "0" *) 
(* C_DATA_COUNT_WIDTH = "8" *) (* C_DEFAULT_VALUE = "BlankString" *) (* C_DIN_WIDTH = "512" *) 
(* C_DOUT_RST_VAL = "0" *) (* C_DOUT_WIDTH = "512" *) (* C_ENABLE_RLOCS = "0" *) 
(* C_FAMILY = "virtex7" *) (* C_FULL_FLAGS_RST_VAL = "1" *) (* C_HAS_ALMOST_EMPTY = "0" *) 
(* C_HAS_ALMOST_FULL = "0" *) (* C_HAS_BACKUP = "0" *) (* C_HAS_DATA_COUNT = "0" *) 
(* C_HAS_INT_CLK = "0" *) (* C_HAS_MEMINIT_FILE = "0" *) (* C_HAS_OVERFLOW = "0" *) 
(* C_HAS_RD_DATA_COUNT = "0" *) (* C_HAS_RD_RST = "0" *) (* C_HAS_RST = "1" *) 
(* C_HAS_SRST = "0" *) (* C_HAS_UNDERFLOW = "0" *) (* C_HAS_VALID = "1" *) 
(* C_HAS_WR_ACK = "0" *) (* C_HAS_WR_DATA_COUNT = "0" *) (* C_HAS_WR_RST = "0" *) 
(* C_IMPLEMENTATION_TYPE = "2" *) (* C_INIT_WR_PNTR_VAL = "0" *) (* C_MEMORY_TYPE = "1" *) 
(* C_MIF_FILE_NAME = "BlankString" *) (* C_OPTIMIZATION_MODE = "0" *) (* C_OVERFLOW_LOW = "0" *) 
(* C_PRELOAD_LATENCY = "0" *) (* C_PRELOAD_REGS = "1" *) (* C_PRIM_FIFO_TYPE = "512x72" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL = "4" *) (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "5" *) (* C_PROG_EMPTY_TYPE = "0" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL = "255" *) (* C_PROG_FULL_THRESH_NEGATE_VAL = "254" *) (* C_PROG_FULL_TYPE = "0" *) 
(* C_RD_DATA_COUNT_WIDTH = "8" *) (* C_RD_DEPTH = "256" *) (* C_RD_FREQ = "1" *) 
(* C_RD_PNTR_WIDTH = "8" *) (* C_UNDERFLOW_LOW = "0" *) (* C_USE_DOUT_RST = "1" *) 
(* C_USE_ECC = "0" *) (* C_USE_EMBEDDED_REG = "0" *) (* C_USE_FIFO16_FLAGS = "0" *) 
(* C_USE_FWFT_DATA_COUNT = "0" *) (* C_VALID_LOW = "0" *) (* C_WR_ACK_LOW = "0" *) 
(* C_WR_DATA_COUNT_WIDTH = "8" *) (* C_WR_DEPTH = "256" *) (* C_WR_FREQ = "1" *) 
(* C_WR_PNTR_WIDTH = "8" *) (* C_WR_RESPONSE_LATENCY = "1" *) (* C_MSGON_VAL = "1" *) 
(* C_ENABLE_RST_SYNC = "1" *) (* C_ERROR_INJECTION_TYPE = "0" *) (* C_SYNCHRONIZER_STAGE = "2" *) 
(* C_INTERFACE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) (* C_HAS_AXI_WR_CHANNEL = "1" *) 
(* C_HAS_AXI_RD_CHANNEL = "1" *) (* C_HAS_SLAVE_CE = "0" *) (* C_HAS_MASTER_CE = "0" *) 
(* C_ADD_NGC_CONSTRAINT = "0" *) (* C_USE_COMMON_OVERFLOW = "0" *) (* C_USE_COMMON_UNDERFLOW = "0" *) 
(* C_USE_DEFAULT_SETTINGS = "0" *) (* C_AXI_ID_WIDTH = "1" *) (* C_AXI_ADDR_WIDTH = "32" *) 
(* C_AXI_DATA_WIDTH = "64" *) (* C_AXI_LEN_WIDTH = "8" *) (* C_AXI_LOCK_WIDTH = "1" *) 
(* C_HAS_AXI_ID = "0" *) (* C_HAS_AXI_AWUSER = "0" *) (* C_HAS_AXI_WUSER = "0" *) 
(* C_HAS_AXI_BUSER = "0" *) (* C_HAS_AXI_ARUSER = "0" *) (* C_HAS_AXI_RUSER = "0" *) 
(* C_AXI_ARUSER_WIDTH = "1" *) (* C_AXI_AWUSER_WIDTH = "1" *) (* C_AXI_WUSER_WIDTH = "1" *) 
(* C_AXI_BUSER_WIDTH = "1" *) (* C_AXI_RUSER_WIDTH = "1" *) (* C_HAS_AXIS_TDATA = "1" *) 
(* C_HAS_AXIS_TID = "0" *) (* C_HAS_AXIS_TDEST = "0" *) (* C_HAS_AXIS_TUSER = "1" *) 
(* C_HAS_AXIS_TREADY = "1" *) (* C_HAS_AXIS_TLAST = "0" *) (* C_HAS_AXIS_TSTRB = "0" *) 
(* C_HAS_AXIS_TKEEP = "0" *) (* C_AXIS_TDATA_WIDTH = "8" *) (* C_AXIS_TID_WIDTH = "1" *) 
(* C_AXIS_TDEST_WIDTH = "1" *) (* C_AXIS_TUSER_WIDTH = "4" *) (* C_AXIS_TSTRB_WIDTH = "1" *) 
(* C_AXIS_TKEEP_WIDTH = "1" *) (* C_WACH_TYPE = "0" *) (* C_WDCH_TYPE = "0" *) 
(* C_WRCH_TYPE = "0" *) (* C_RACH_TYPE = "0" *) (* C_RDCH_TYPE = "0" *) 
(* C_AXIS_TYPE = "0" *) (* C_IMPLEMENTATION_TYPE_WACH = "1" *) (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) 
(* C_IMPLEMENTATION_TYPE_WRCH = "1" *) (* C_IMPLEMENTATION_TYPE_RACH = "1" *) (* C_IMPLEMENTATION_TYPE_RDCH = "1" *) 
(* C_IMPLEMENTATION_TYPE_AXIS = "1" *) (* C_APPLICATION_TYPE_WACH = "0" *) (* C_APPLICATION_TYPE_WDCH = "0" *) 
(* C_APPLICATION_TYPE_WRCH = "0" *) (* C_APPLICATION_TYPE_RACH = "0" *) (* C_APPLICATION_TYPE_RDCH = "0" *) 
(* C_APPLICATION_TYPE_AXIS = "0" *) (* C_PRIM_FIFO_TYPE_WACH = "512x36" *) (* C_PRIM_FIFO_TYPE_WDCH = "1kx36" *) 
(* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) (* C_PRIM_FIFO_TYPE_RDCH = "1kx36" *) 
(* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) (* C_USE_ECC_WACH = "0" *) (* C_USE_ECC_WDCH = "0" *) 
(* C_USE_ECC_WRCH = "0" *) (* C_USE_ECC_RACH = "0" *) (* C_USE_ECC_RDCH = "0" *) 
(* C_USE_ECC_AXIS = "0" *) (* C_ERROR_INJECTION_TYPE_WACH = "0" *) (* C_ERROR_INJECTION_TYPE_WDCH = "0" *) 
(* C_ERROR_INJECTION_TYPE_WRCH = "0" *) (* C_ERROR_INJECTION_TYPE_RACH = "0" *) (* C_ERROR_INJECTION_TYPE_RDCH = "0" *) 
(* C_ERROR_INJECTION_TYPE_AXIS = "0" *) (* C_DIN_WIDTH_WACH = "32" *) (* C_DIN_WIDTH_WDCH = "64" *) 
(* C_DIN_WIDTH_WRCH = "2" *) (* C_DIN_WIDTH_RACH = "32" *) (* C_DIN_WIDTH_RDCH = "64" *) 
(* C_DIN_WIDTH_AXIS = "1" *) (* C_WR_DEPTH_WACH = "16" *) (* C_WR_DEPTH_WDCH = "1024" *) 
(* C_WR_DEPTH_WRCH = "16" *) (* C_WR_DEPTH_RACH = "16" *) (* C_WR_DEPTH_RDCH = "1024" *) 
(* C_WR_DEPTH_AXIS = "1024" *) (* C_WR_PNTR_WIDTH_WACH = "4" *) (* C_WR_PNTR_WIDTH_WDCH = "10" *) 
(* C_WR_PNTR_WIDTH_WRCH = "4" *) (* C_WR_PNTR_WIDTH_RACH = "4" *) (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
(* C_WR_PNTR_WIDTH_AXIS = "10" *) (* C_HAS_DATA_COUNTS_WACH = "0" *) (* C_HAS_DATA_COUNTS_WDCH = "0" *) 
(* C_HAS_DATA_COUNTS_WRCH = "0" *) (* C_HAS_DATA_COUNTS_RACH = "0" *) (* C_HAS_DATA_COUNTS_RDCH = "0" *) 
(* C_HAS_DATA_COUNTS_AXIS = "0" *) (* C_HAS_PROG_FLAGS_WACH = "0" *) (* C_HAS_PROG_FLAGS_WDCH = "0" *) 
(* C_HAS_PROG_FLAGS_WRCH = "0" *) (* C_HAS_PROG_FLAGS_RACH = "0" *) (* C_HAS_PROG_FLAGS_RDCH = "0" *) 
(* C_HAS_PROG_FLAGS_AXIS = "0" *) (* C_PROG_FULL_TYPE_WACH = "0" *) (* C_PROG_FULL_TYPE_WDCH = "0" *) 
(* C_PROG_FULL_TYPE_WRCH = "0" *) (* C_PROG_FULL_TYPE_RACH = "0" *) (* C_PROG_FULL_TYPE_RDCH = "0" *) 
(* C_PROG_FULL_TYPE_AXIS = "0" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) (* C_PROG_EMPTY_TYPE_WACH = "0" *) (* C_PROG_EMPTY_TYPE_WDCH = "0" *) 
(* C_PROG_EMPTY_TYPE_WRCH = "0" *) (* C_PROG_EMPTY_TYPE_RACH = "0" *) (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
(* C_PROG_EMPTY_TYPE_AXIS = "0" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) (* C_REG_SLICE_MODE_WACH = "0" *) (* C_REG_SLICE_MODE_WDCH = "0" *) 
(* C_REG_SLICE_MODE_WRCH = "0" *) (* C_REG_SLICE_MODE_RACH = "0" *) (* C_REG_SLICE_MODE_RDCH = "0" *) 
(* C_REG_SLICE_MODE_AXIS = "0" *) 
module DebugDataFIFOfifo_generator_v11_0__parameterized0
   (backup,
    backup_marker,
    clk,
    rst,
    srst,
    wr_clk,
    wr_rst,
    rd_clk,
    rd_rst,
    din,
    wr_en,
    rd_en,
    prog_empty_thresh,
    prog_empty_thresh_assert,
    prog_empty_thresh_negate,
    prog_full_thresh,
    prog_full_thresh_assert,
    prog_full_thresh_negate,
    int_clk,
    injectdbiterr,
    injectsbiterr,
    dout,
    full,
    almost_full,
    wr_ack,
    overflow,
    empty,
    almost_empty,
    valid,
    underflow,
    data_count,
    rd_data_count,
    wr_data_count,
    prog_full,
    prog_empty,
    sbiterr,
    dbiterr,
    wr_rst_busy,
    rd_rst_busy,
    m_aclk,
    s_aclk,
    s_aresetn,
    m_aclk_en,
    s_aclk_en,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awlock,
    s_axi_awcache,
    s_axi_awprot,
    s_axi_awqos,
    s_axi_awregion,
    s_axi_awuser,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wid,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wuser,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_buser,
    s_axi_bvalid,
    s_axi_bready,
    m_axi_awid,
    m_axi_awaddr,
    m_axi_awlen,
    m_axi_awsize,
    m_axi_awburst,
    m_axi_awlock,
    m_axi_awcache,
    m_axi_awprot,
    m_axi_awqos,
    m_axi_awregion,
    m_axi_awuser,
    m_axi_awvalid,
    m_axi_awready,
    m_axi_wid,
    m_axi_wdata,
    m_axi_wstrb,
    m_axi_wlast,
    m_axi_wuser,
    m_axi_wvalid,
    m_axi_wready,
    m_axi_bid,
    m_axi_bresp,
    m_axi_buser,
    m_axi_bvalid,
    m_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arlock,
    s_axi_arcache,
    s_axi_arprot,
    s_axi_arqos,
    s_axi_arregion,
    s_axi_aruser,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_ruser,
    s_axi_rvalid,
    s_axi_rready,
    m_axi_arid,
    m_axi_araddr,
    m_axi_arlen,
    m_axi_arsize,
    m_axi_arburst,
    m_axi_arlock,
    m_axi_arcache,
    m_axi_arprot,
    m_axi_arqos,
    m_axi_arregion,
    m_axi_aruser,
    m_axi_arvalid,
    m_axi_arready,
    m_axi_rid,
    m_axi_rdata,
    m_axi_rresp,
    m_axi_rlast,
    m_axi_ruser,
    m_axi_rvalid,
    m_axi_rready,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tdata,
    s_axis_tstrb,
    s_axis_tkeep,
    s_axis_tlast,
    s_axis_tid,
    s_axis_tdest,
    s_axis_tuser,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tdata,
    m_axis_tstrb,
    m_axis_tkeep,
    m_axis_tlast,
    m_axis_tid,
    m_axis_tdest,
    m_axis_tuser,
    axi_aw_injectsbiterr,
    axi_aw_injectdbiterr,
    axi_aw_prog_full_thresh,
    axi_aw_prog_empty_thresh,
    axi_aw_data_count,
    axi_aw_wr_data_count,
    axi_aw_rd_data_count,
    axi_aw_sbiterr,
    axi_aw_dbiterr,
    axi_aw_overflow,
    axi_aw_underflow,
    axi_aw_prog_full,
    axi_aw_prog_empty,
    axi_w_injectsbiterr,
    axi_w_injectdbiterr,
    axi_w_prog_full_thresh,
    axi_w_prog_empty_thresh,
    axi_w_data_count,
    axi_w_wr_data_count,
    axi_w_rd_data_count,
    axi_w_sbiterr,
    axi_w_dbiterr,
    axi_w_overflow,
    axi_w_underflow,
    axi_w_prog_full,
    axi_w_prog_empty,
    axi_b_injectsbiterr,
    axi_b_injectdbiterr,
    axi_b_prog_full_thresh,
    axi_b_prog_empty_thresh,
    axi_b_data_count,
    axi_b_wr_data_count,
    axi_b_rd_data_count,
    axi_b_sbiterr,
    axi_b_dbiterr,
    axi_b_overflow,
    axi_b_underflow,
    axi_b_prog_full,
    axi_b_prog_empty,
    axi_ar_injectsbiterr,
    axi_ar_injectdbiterr,
    axi_ar_prog_full_thresh,
    axi_ar_prog_empty_thresh,
    axi_ar_data_count,
    axi_ar_wr_data_count,
    axi_ar_rd_data_count,
    axi_ar_sbiterr,
    axi_ar_dbiterr,
    axi_ar_overflow,
    axi_ar_underflow,
    axi_ar_prog_full,
    axi_ar_prog_empty,
    axi_r_injectsbiterr,
    axi_r_injectdbiterr,
    axi_r_prog_full_thresh,
    axi_r_prog_empty_thresh,
    axi_r_data_count,
    axi_r_wr_data_count,
    axi_r_rd_data_count,
    axi_r_sbiterr,
    axi_r_dbiterr,
    axi_r_overflow,
    axi_r_underflow,
    axi_r_prog_full,
    axi_r_prog_empty,
    axis_injectsbiterr,
    axis_injectdbiterr,
    axis_prog_full_thresh,
    axis_prog_empty_thresh,
    axis_data_count,
    axis_wr_data_count,
    axis_rd_data_count,
    axis_sbiterr,
    axis_dbiterr,
    axis_overflow,
    axis_underflow,
    axis_prog_full,
    axis_prog_empty);
  input backup;
  input backup_marker;
  input clk;
  input rst;
  input srst;
  input wr_clk;
  input wr_rst;
  input rd_clk;
  input rd_rst;
  input [511:0]din;
  input wr_en;
  input rd_en;
  input [7:0]prog_empty_thresh;
  input [7:0]prog_empty_thresh_assert;
  input [7:0]prog_empty_thresh_negate;
  input [7:0]prog_full_thresh;
  input [7:0]prog_full_thresh_assert;
  input [7:0]prog_full_thresh_negate;
  input int_clk;
  input injectdbiterr;
  input injectsbiterr;
  output [511:0]dout;
  output full;
  output almost_full;
  output wr_ack;
  output overflow;
  output empty;
  output almost_empty;
  output valid;
  output underflow;
  output [7:0]data_count;
  output [7:0]rd_data_count;
  output [7:0]wr_data_count;
  output prog_full;
  output prog_empty;
  output sbiterr;
  output dbiterr;
  output wr_rst_busy;
  output rd_rst_busy;
  input m_aclk;
  input s_aclk;
  input s_aresetn;
  input m_aclk_en;
  input s_aclk_en;
  input [0:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input [0:0]s_axi_awlock;
  input [3:0]s_axi_awcache;
  input [2:0]s_axi_awprot;
  input [3:0]s_axi_awqos;
  input [3:0]s_axi_awregion;
  input [0:0]s_axi_awuser;
  input s_axi_awvalid;
  output s_axi_awready;
  input [0:0]s_axi_wid;
  input [63:0]s_axi_wdata;
  input [7:0]s_axi_wstrb;
  input s_axi_wlast;
  input [0:0]s_axi_wuser;
  input s_axi_wvalid;
  output s_axi_wready;
  output [0:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output [0:0]s_axi_buser;
  output s_axi_bvalid;
  input s_axi_bready;
  output [0:0]m_axi_awid;
  output [31:0]m_axi_awaddr;
  output [7:0]m_axi_awlen;
  output [2:0]m_axi_awsize;
  output [1:0]m_axi_awburst;
  output [0:0]m_axi_awlock;
  output [3:0]m_axi_awcache;
  output [2:0]m_axi_awprot;
  output [3:0]m_axi_awqos;
  output [3:0]m_axi_awregion;
  output [0:0]m_axi_awuser;
  output m_axi_awvalid;
  input m_axi_awready;
  output [0:0]m_axi_wid;
  output [63:0]m_axi_wdata;
  output [7:0]m_axi_wstrb;
  output m_axi_wlast;
  output [0:0]m_axi_wuser;
  output m_axi_wvalid;
  input m_axi_wready;
  input [0:0]m_axi_bid;
  input [1:0]m_axi_bresp;
  input [0:0]m_axi_buser;
  input m_axi_bvalid;
  output m_axi_bready;
  input [0:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input [0:0]s_axi_arlock;
  input [3:0]s_axi_arcache;
  input [2:0]s_axi_arprot;
  input [3:0]s_axi_arqos;
  input [3:0]s_axi_arregion;
  input [0:0]s_axi_aruser;
  input s_axi_arvalid;
  output s_axi_arready;
  output [0:0]s_axi_rid;
  output [63:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output [0:0]s_axi_ruser;
  output s_axi_rvalid;
  input s_axi_rready;
  output [0:0]m_axi_arid;
  output [31:0]m_axi_araddr;
  output [7:0]m_axi_arlen;
  output [2:0]m_axi_arsize;
  output [1:0]m_axi_arburst;
  output [0:0]m_axi_arlock;
  output [3:0]m_axi_arcache;
  output [2:0]m_axi_arprot;
  output [3:0]m_axi_arqos;
  output [3:0]m_axi_arregion;
  output [0:0]m_axi_aruser;
  output m_axi_arvalid;
  input m_axi_arready;
  input [0:0]m_axi_rid;
  input [63:0]m_axi_rdata;
  input [1:0]m_axi_rresp;
  input m_axi_rlast;
  input [0:0]m_axi_ruser;
  input m_axi_rvalid;
  output m_axi_rready;
  input s_axis_tvalid;
  output s_axis_tready;
  input [7:0]s_axis_tdata;
  input [0:0]s_axis_tstrb;
  input [0:0]s_axis_tkeep;
  input s_axis_tlast;
  input [0:0]s_axis_tid;
  input [0:0]s_axis_tdest;
  input [3:0]s_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output [7:0]m_axis_tdata;
  output [0:0]m_axis_tstrb;
  output [0:0]m_axis_tkeep;
  output m_axis_tlast;
  output [0:0]m_axis_tid;
  output [0:0]m_axis_tdest;
  output [3:0]m_axis_tuser;
  input axi_aw_injectsbiterr;
  input axi_aw_injectdbiterr;
  input [3:0]axi_aw_prog_full_thresh;
  input [3:0]axi_aw_prog_empty_thresh;
  output [4:0]axi_aw_data_count;
  output [4:0]axi_aw_wr_data_count;
  output [4:0]axi_aw_rd_data_count;
  output axi_aw_sbiterr;
  output axi_aw_dbiterr;
  output axi_aw_overflow;
  output axi_aw_underflow;
  output axi_aw_prog_full;
  output axi_aw_prog_empty;
  input axi_w_injectsbiterr;
  input axi_w_injectdbiterr;
  input [9:0]axi_w_prog_full_thresh;
  input [9:0]axi_w_prog_empty_thresh;
  output [10:0]axi_w_data_count;
  output [10:0]axi_w_wr_data_count;
  output [10:0]axi_w_rd_data_count;
  output axi_w_sbiterr;
  output axi_w_dbiterr;
  output axi_w_overflow;
  output axi_w_underflow;
  output axi_w_prog_full;
  output axi_w_prog_empty;
  input axi_b_injectsbiterr;
  input axi_b_injectdbiterr;
  input [3:0]axi_b_prog_full_thresh;
  input [3:0]axi_b_prog_empty_thresh;
  output [4:0]axi_b_data_count;
  output [4:0]axi_b_wr_data_count;
  output [4:0]axi_b_rd_data_count;
  output axi_b_sbiterr;
  output axi_b_dbiterr;
  output axi_b_overflow;
  output axi_b_underflow;
  output axi_b_prog_full;
  output axi_b_prog_empty;
  input axi_ar_injectsbiterr;
  input axi_ar_injectdbiterr;
  input [3:0]axi_ar_prog_full_thresh;
  input [3:0]axi_ar_prog_empty_thresh;
  output [4:0]axi_ar_data_count;
  output [4:0]axi_ar_wr_data_count;
  output [4:0]axi_ar_rd_data_count;
  output axi_ar_sbiterr;
  output axi_ar_dbiterr;
  output axi_ar_overflow;
  output axi_ar_underflow;
  output axi_ar_prog_full;
  output axi_ar_prog_empty;
  input axi_r_injectsbiterr;
  input axi_r_injectdbiterr;
  input [9:0]axi_r_prog_full_thresh;
  input [9:0]axi_r_prog_empty_thresh;
  output [10:0]axi_r_data_count;
  output [10:0]axi_r_wr_data_count;
  output [10:0]axi_r_rd_data_count;
  output axi_r_sbiterr;
  output axi_r_dbiterr;
  output axi_r_overflow;
  output axi_r_underflow;
  output axi_r_prog_full;
  output axi_r_prog_empty;
  input axis_injectsbiterr;
  input axis_injectdbiterr;
  input [9:0]axis_prog_full_thresh;
  input [9:0]axis_prog_empty_thresh;
  output [10:0]axis_data_count;
  output [10:0]axis_wr_data_count;
  output [10:0]axis_rd_data_count;
  output axis_sbiterr;
  output axis_dbiterr;
  output axis_overflow;
  output axis_underflow;
  output axis_prog_full;
  output axis_prog_empty;

  wire \<const0> ;
  wire \<const1> ;
  wire axi_ar_injectdbiterr;
  wire axi_ar_injectsbiterr;
  wire [3:0]axi_ar_prog_empty_thresh;
  wire [3:0]axi_ar_prog_full_thresh;
  wire axi_aw_injectdbiterr;
  wire axi_aw_injectsbiterr;
  wire [3:0]axi_aw_prog_empty_thresh;
  wire [3:0]axi_aw_prog_full_thresh;
  wire axi_b_injectdbiterr;
  wire axi_b_injectsbiterr;
  wire [3:0]axi_b_prog_empty_thresh;
  wire [3:0]axi_b_prog_full_thresh;
  wire axi_r_injectdbiterr;
  wire axi_r_injectsbiterr;
  wire [9:0]axi_r_prog_empty_thresh;
  wire [9:0]axi_r_prog_full_thresh;
  wire axi_w_injectdbiterr;
  wire axi_w_injectsbiterr;
  wire [9:0]axi_w_prog_empty_thresh;
  wire [9:0]axi_w_prog_full_thresh;
  wire axis_injectdbiterr;
  wire axis_injectsbiterr;
  wire [9:0]axis_prog_empty_thresh;
  wire [9:0]axis_prog_full_thresh;
  wire backup;
  wire backup_marker;
  wire clk;
  wire [511:0]din;
  wire [511:0]dout;
  wire empty;
  wire full;
  wire injectdbiterr;
  wire injectsbiterr;
  wire int_clk;
  wire m_aclk;
  wire m_aclk_en;
  wire m_axi_arready;
  wire m_axi_awready;
  wire [0:0]m_axi_bid;
  wire [1:0]m_axi_bresp;
  wire [0:0]m_axi_buser;
  wire m_axi_bvalid;
  wire [63:0]m_axi_rdata;
  wire [0:0]m_axi_rid;
  wire m_axi_rlast;
  wire [1:0]m_axi_rresp;
  wire [0:0]m_axi_ruser;
  wire m_axi_rvalid;
  wire m_axi_wready;
  wire m_axis_tready;
  wire [7:0]prog_empty_thresh;
  wire [7:0]prog_empty_thresh_assert;
  wire [7:0]prog_empty_thresh_negate;
  wire [7:0]prog_full_thresh;
  wire [7:0]prog_full_thresh_assert;
  wire [7:0]prog_full_thresh_negate;
  wire rd_clk;
  wire rd_en;
  wire rd_rst;
  wire rst;
  wire s_aclk;
  wire s_aclk_en;
  wire s_aresetn;
  wire [31:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arcache;
  wire [0:0]s_axi_arid;
  wire [7:0]s_axi_arlen;
  wire [0:0]s_axi_arlock;
  wire [2:0]s_axi_arprot;
  wire [3:0]s_axi_arqos;
  wire [3:0]s_axi_arregion;
  wire [2:0]s_axi_arsize;
  wire [0:0]s_axi_aruser;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awcache;
  wire [0:0]s_axi_awid;
  wire [7:0]s_axi_awlen;
  wire [0:0]s_axi_awlock;
  wire [2:0]s_axi_awprot;
  wire [3:0]s_axi_awqos;
  wire [3:0]s_axi_awregion;
  wire [2:0]s_axi_awsize;
  wire [0:0]s_axi_awuser;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_rready;
  wire [63:0]s_axi_wdata;
  wire [0:0]s_axi_wid;
  wire s_axi_wlast;
  wire [7:0]s_axi_wstrb;
  wire [0:0]s_axi_wuser;
  wire s_axi_wvalid;
  wire [7:0]s_axis_tdata;
  wire [0:0]s_axis_tdest;
  wire [0:0]s_axis_tid;
  wire [0:0]s_axis_tkeep;
  wire s_axis_tlast;
  wire [0:0]s_axis_tstrb;
  wire [3:0]s_axis_tuser;
  wire s_axis_tvalid;
  wire srst;
  wire valid;
  wire wr_clk;
  wire wr_en;
  wire wr_rst;

  assign almost_empty = \<const0> ;
  assign almost_full = \<const0> ;
  assign axi_ar_data_count[4] = \<const0> ;
  assign axi_ar_data_count[3] = \<const0> ;
  assign axi_ar_data_count[2] = \<const0> ;
  assign axi_ar_data_count[1] = \<const0> ;
  assign axi_ar_data_count[0] = \<const0> ;
  assign axi_ar_dbiterr = \<const0> ;
  assign axi_ar_overflow = \<const0> ;
  assign axi_ar_prog_empty = \<const1> ;
  assign axi_ar_prog_full = \<const0> ;
  assign axi_ar_rd_data_count[4] = \<const0> ;
  assign axi_ar_rd_data_count[3] = \<const0> ;
  assign axi_ar_rd_data_count[2] = \<const0> ;
  assign axi_ar_rd_data_count[1] = \<const0> ;
  assign axi_ar_rd_data_count[0] = \<const0> ;
  assign axi_ar_sbiterr = \<const0> ;
  assign axi_ar_underflow = \<const0> ;
  assign axi_ar_wr_data_count[4] = \<const0> ;
  assign axi_ar_wr_data_count[3] = \<const0> ;
  assign axi_ar_wr_data_count[2] = \<const0> ;
  assign axi_ar_wr_data_count[1] = \<const0> ;
  assign axi_ar_wr_data_count[0] = \<const0> ;
  assign axi_aw_data_count[4] = \<const0> ;
  assign axi_aw_data_count[3] = \<const0> ;
  assign axi_aw_data_count[2] = \<const0> ;
  assign axi_aw_data_count[1] = \<const0> ;
  assign axi_aw_data_count[0] = \<const0> ;
  assign axi_aw_dbiterr = \<const0> ;
  assign axi_aw_overflow = \<const0> ;
  assign axi_aw_prog_empty = \<const1> ;
  assign axi_aw_prog_full = \<const0> ;
  assign axi_aw_rd_data_count[4] = \<const0> ;
  assign axi_aw_rd_data_count[3] = \<const0> ;
  assign axi_aw_rd_data_count[2] = \<const0> ;
  assign axi_aw_rd_data_count[1] = \<const0> ;
  assign axi_aw_rd_data_count[0] = \<const0> ;
  assign axi_aw_sbiterr = \<const0> ;
  assign axi_aw_underflow = \<const0> ;
  assign axi_aw_wr_data_count[4] = \<const0> ;
  assign axi_aw_wr_data_count[3] = \<const0> ;
  assign axi_aw_wr_data_count[2] = \<const0> ;
  assign axi_aw_wr_data_count[1] = \<const0> ;
  assign axi_aw_wr_data_count[0] = \<const0> ;
  assign axi_b_data_count[4] = \<const0> ;
  assign axi_b_data_count[3] = \<const0> ;
  assign axi_b_data_count[2] = \<const0> ;
  assign axi_b_data_count[1] = \<const0> ;
  assign axi_b_data_count[0] = \<const0> ;
  assign axi_b_dbiterr = \<const0> ;
  assign axi_b_overflow = \<const0> ;
  assign axi_b_prog_empty = \<const1> ;
  assign axi_b_prog_full = \<const0> ;
  assign axi_b_rd_data_count[4] = \<const0> ;
  assign axi_b_rd_data_count[3] = \<const0> ;
  assign axi_b_rd_data_count[2] = \<const0> ;
  assign axi_b_rd_data_count[1] = \<const0> ;
  assign axi_b_rd_data_count[0] = \<const0> ;
  assign axi_b_sbiterr = \<const0> ;
  assign axi_b_underflow = \<const0> ;
  assign axi_b_wr_data_count[4] = \<const0> ;
  assign axi_b_wr_data_count[3] = \<const0> ;
  assign axi_b_wr_data_count[2] = \<const0> ;
  assign axi_b_wr_data_count[1] = \<const0> ;
  assign axi_b_wr_data_count[0] = \<const0> ;
  assign axi_r_data_count[10] = \<const0> ;
  assign axi_r_data_count[9] = \<const0> ;
  assign axi_r_data_count[8] = \<const0> ;
  assign axi_r_data_count[7] = \<const0> ;
  assign axi_r_data_count[6] = \<const0> ;
  assign axi_r_data_count[5] = \<const0> ;
  assign axi_r_data_count[4] = \<const0> ;
  assign axi_r_data_count[3] = \<const0> ;
  assign axi_r_data_count[2] = \<const0> ;
  assign axi_r_data_count[1] = \<const0> ;
  assign axi_r_data_count[0] = \<const0> ;
  assign axi_r_dbiterr = \<const0> ;
  assign axi_r_overflow = \<const0> ;
  assign axi_r_prog_empty = \<const1> ;
  assign axi_r_prog_full = \<const0> ;
  assign axi_r_rd_data_count[10] = \<const0> ;
  assign axi_r_rd_data_count[9] = \<const0> ;
  assign axi_r_rd_data_count[8] = \<const0> ;
  assign axi_r_rd_data_count[7] = \<const0> ;
  assign axi_r_rd_data_count[6] = \<const0> ;
  assign axi_r_rd_data_count[5] = \<const0> ;
  assign axi_r_rd_data_count[4] = \<const0> ;
  assign axi_r_rd_data_count[3] = \<const0> ;
  assign axi_r_rd_data_count[2] = \<const0> ;
  assign axi_r_rd_data_count[1] = \<const0> ;
  assign axi_r_rd_data_count[0] = \<const0> ;
  assign axi_r_sbiterr = \<const0> ;
  assign axi_r_underflow = \<const0> ;
  assign axi_r_wr_data_count[10] = \<const0> ;
  assign axi_r_wr_data_count[9] = \<const0> ;
  assign axi_r_wr_data_count[8] = \<const0> ;
  assign axi_r_wr_data_count[7] = \<const0> ;
  assign axi_r_wr_data_count[6] = \<const0> ;
  assign axi_r_wr_data_count[5] = \<const0> ;
  assign axi_r_wr_data_count[4] = \<const0> ;
  assign axi_r_wr_data_count[3] = \<const0> ;
  assign axi_r_wr_data_count[2] = \<const0> ;
  assign axi_r_wr_data_count[1] = \<const0> ;
  assign axi_r_wr_data_count[0] = \<const0> ;
  assign axi_w_data_count[10] = \<const0> ;
  assign axi_w_data_count[9] = \<const0> ;
  assign axi_w_data_count[8] = \<const0> ;
  assign axi_w_data_count[7] = \<const0> ;
  assign axi_w_data_count[6] = \<const0> ;
  assign axi_w_data_count[5] = \<const0> ;
  assign axi_w_data_count[4] = \<const0> ;
  assign axi_w_data_count[3] = \<const0> ;
  assign axi_w_data_count[2] = \<const0> ;
  assign axi_w_data_count[1] = \<const0> ;
  assign axi_w_data_count[0] = \<const0> ;
  assign axi_w_dbiterr = \<const0> ;
  assign axi_w_overflow = \<const0> ;
  assign axi_w_prog_empty = \<const1> ;
  assign axi_w_prog_full = \<const0> ;
  assign axi_w_rd_data_count[10] = \<const0> ;
  assign axi_w_rd_data_count[9] = \<const0> ;
  assign axi_w_rd_data_count[8] = \<const0> ;
  assign axi_w_rd_data_count[7] = \<const0> ;
  assign axi_w_rd_data_count[6] = \<const0> ;
  assign axi_w_rd_data_count[5] = \<const0> ;
  assign axi_w_rd_data_count[4] = \<const0> ;
  assign axi_w_rd_data_count[3] = \<const0> ;
  assign axi_w_rd_data_count[2] = \<const0> ;
  assign axi_w_rd_data_count[1] = \<const0> ;
  assign axi_w_rd_data_count[0] = \<const0> ;
  assign axi_w_sbiterr = \<const0> ;
  assign axi_w_underflow = \<const0> ;
  assign axi_w_wr_data_count[10] = \<const0> ;
  assign axi_w_wr_data_count[9] = \<const0> ;
  assign axi_w_wr_data_count[8] = \<const0> ;
  assign axi_w_wr_data_count[7] = \<const0> ;
  assign axi_w_wr_data_count[6] = \<const0> ;
  assign axi_w_wr_data_count[5] = \<const0> ;
  assign axi_w_wr_data_count[4] = \<const0> ;
  assign axi_w_wr_data_count[3] = \<const0> ;
  assign axi_w_wr_data_count[2] = \<const0> ;
  assign axi_w_wr_data_count[1] = \<const0> ;
  assign axi_w_wr_data_count[0] = \<const0> ;
  assign axis_data_count[10] = \<const0> ;
  assign axis_data_count[9] = \<const0> ;
  assign axis_data_count[8] = \<const0> ;
  assign axis_data_count[7] = \<const0> ;
  assign axis_data_count[6] = \<const0> ;
  assign axis_data_count[5] = \<const0> ;
  assign axis_data_count[4] = \<const0> ;
  assign axis_data_count[3] = \<const0> ;
  assign axis_data_count[2] = \<const0> ;
  assign axis_data_count[1] = \<const0> ;
  assign axis_data_count[0] = \<const0> ;
  assign axis_dbiterr = \<const0> ;
  assign axis_overflow = \<const0> ;
  assign axis_prog_empty = \<const1> ;
  assign axis_prog_full = \<const0> ;
  assign axis_rd_data_count[10] = \<const0> ;
  assign axis_rd_data_count[9] = \<const0> ;
  assign axis_rd_data_count[8] = \<const0> ;
  assign axis_rd_data_count[7] = \<const0> ;
  assign axis_rd_data_count[6] = \<const0> ;
  assign axis_rd_data_count[5] = \<const0> ;
  assign axis_rd_data_count[4] = \<const0> ;
  assign axis_rd_data_count[3] = \<const0> ;
  assign axis_rd_data_count[2] = \<const0> ;
  assign axis_rd_data_count[1] = \<const0> ;
  assign axis_rd_data_count[0] = \<const0> ;
  assign axis_sbiterr = \<const0> ;
  assign axis_underflow = \<const0> ;
  assign axis_wr_data_count[10] = \<const0> ;
  assign axis_wr_data_count[9] = \<const0> ;
  assign axis_wr_data_count[8] = \<const0> ;
  assign axis_wr_data_count[7] = \<const0> ;
  assign axis_wr_data_count[6] = \<const0> ;
  assign axis_wr_data_count[5] = \<const0> ;
  assign axis_wr_data_count[4] = \<const0> ;
  assign axis_wr_data_count[3] = \<const0> ;
  assign axis_wr_data_count[2] = \<const0> ;
  assign axis_wr_data_count[1] = \<const0> ;
  assign axis_wr_data_count[0] = \<const0> ;
  assign data_count[7] = \<const0> ;
  assign data_count[6] = \<const0> ;
  assign data_count[5] = \<const0> ;
  assign data_count[4] = \<const0> ;
  assign data_count[3] = \<const0> ;
  assign data_count[2] = \<const0> ;
  assign data_count[1] = \<const0> ;
  assign data_count[0] = \<const0> ;
  assign dbiterr = \<const0> ;
  assign m_axi_araddr[31] = \<const0> ;
  assign m_axi_araddr[30] = \<const0> ;
  assign m_axi_araddr[29] = \<const0> ;
  assign m_axi_araddr[28] = \<const0> ;
  assign m_axi_araddr[27] = \<const0> ;
  assign m_axi_araddr[26] = \<const0> ;
  assign m_axi_araddr[25] = \<const0> ;
  assign m_axi_araddr[24] = \<const0> ;
  assign m_axi_araddr[23] = \<const0> ;
  assign m_axi_araddr[22] = \<const0> ;
  assign m_axi_araddr[21] = \<const0> ;
  assign m_axi_araddr[20] = \<const0> ;
  assign m_axi_araddr[19] = \<const0> ;
  assign m_axi_araddr[18] = \<const0> ;
  assign m_axi_araddr[17] = \<const0> ;
  assign m_axi_araddr[16] = \<const0> ;
  assign m_axi_araddr[15] = \<const0> ;
  assign m_axi_araddr[14] = \<const0> ;
  assign m_axi_araddr[13] = \<const0> ;
  assign m_axi_araddr[12] = \<const0> ;
  assign m_axi_araddr[11] = \<const0> ;
  assign m_axi_araddr[10] = \<const0> ;
  assign m_axi_araddr[9] = \<const0> ;
  assign m_axi_araddr[8] = \<const0> ;
  assign m_axi_araddr[7] = \<const0> ;
  assign m_axi_araddr[6] = \<const0> ;
  assign m_axi_araddr[5] = \<const0> ;
  assign m_axi_araddr[4] = \<const0> ;
  assign m_axi_araddr[3] = \<const0> ;
  assign m_axi_araddr[2] = \<const0> ;
  assign m_axi_araddr[1] = \<const0> ;
  assign m_axi_araddr[0] = \<const0> ;
  assign m_axi_arburst[1] = \<const0> ;
  assign m_axi_arburst[0] = \<const0> ;
  assign m_axi_arcache[3] = \<const0> ;
  assign m_axi_arcache[2] = \<const0> ;
  assign m_axi_arcache[1] = \<const0> ;
  assign m_axi_arcache[0] = \<const0> ;
  assign m_axi_arid[0] = \<const0> ;
  assign m_axi_arlen[7] = \<const0> ;
  assign m_axi_arlen[6] = \<const0> ;
  assign m_axi_arlen[5] = \<const0> ;
  assign m_axi_arlen[4] = \<const0> ;
  assign m_axi_arlen[3] = \<const0> ;
  assign m_axi_arlen[2] = \<const0> ;
  assign m_axi_arlen[1] = \<const0> ;
  assign m_axi_arlen[0] = \<const0> ;
  assign m_axi_arlock[0] = \<const0> ;
  assign m_axi_arprot[2] = \<const0> ;
  assign m_axi_arprot[1] = \<const0> ;
  assign m_axi_arprot[0] = \<const0> ;
  assign m_axi_arqos[3] = \<const0> ;
  assign m_axi_arqos[2] = \<const0> ;
  assign m_axi_arqos[1] = \<const0> ;
  assign m_axi_arqos[0] = \<const0> ;
  assign m_axi_arregion[3] = \<const0> ;
  assign m_axi_arregion[2] = \<const0> ;
  assign m_axi_arregion[1] = \<const0> ;
  assign m_axi_arregion[0] = \<const0> ;
  assign m_axi_arsize[2] = \<const0> ;
  assign m_axi_arsize[1] = \<const0> ;
  assign m_axi_arsize[0] = \<const0> ;
  assign m_axi_aruser[0] = \<const0> ;
  assign m_axi_arvalid = \<const0> ;
  assign m_axi_awaddr[31] = \<const0> ;
  assign m_axi_awaddr[30] = \<const0> ;
  assign m_axi_awaddr[29] = \<const0> ;
  assign m_axi_awaddr[28] = \<const0> ;
  assign m_axi_awaddr[27] = \<const0> ;
  assign m_axi_awaddr[26] = \<const0> ;
  assign m_axi_awaddr[25] = \<const0> ;
  assign m_axi_awaddr[24] = \<const0> ;
  assign m_axi_awaddr[23] = \<const0> ;
  assign m_axi_awaddr[22] = \<const0> ;
  assign m_axi_awaddr[21] = \<const0> ;
  assign m_axi_awaddr[20] = \<const0> ;
  assign m_axi_awaddr[19] = \<const0> ;
  assign m_axi_awaddr[18] = \<const0> ;
  assign m_axi_awaddr[17] = \<const0> ;
  assign m_axi_awaddr[16] = \<const0> ;
  assign m_axi_awaddr[15] = \<const0> ;
  assign m_axi_awaddr[14] = \<const0> ;
  assign m_axi_awaddr[13] = \<const0> ;
  assign m_axi_awaddr[12] = \<const0> ;
  assign m_axi_awaddr[11] = \<const0> ;
  assign m_axi_awaddr[10] = \<const0> ;
  assign m_axi_awaddr[9] = \<const0> ;
  assign m_axi_awaddr[8] = \<const0> ;
  assign m_axi_awaddr[7] = \<const0> ;
  assign m_axi_awaddr[6] = \<const0> ;
  assign m_axi_awaddr[5] = \<const0> ;
  assign m_axi_awaddr[4] = \<const0> ;
  assign m_axi_awaddr[3] = \<const0> ;
  assign m_axi_awaddr[2] = \<const0> ;
  assign m_axi_awaddr[1] = \<const0> ;
  assign m_axi_awaddr[0] = \<const0> ;
  assign m_axi_awburst[1] = \<const0> ;
  assign m_axi_awburst[0] = \<const0> ;
  assign m_axi_awcache[3] = \<const0> ;
  assign m_axi_awcache[2] = \<const0> ;
  assign m_axi_awcache[1] = \<const0> ;
  assign m_axi_awcache[0] = \<const0> ;
  assign m_axi_awid[0] = \<const0> ;
  assign m_axi_awlen[7] = \<const0> ;
  assign m_axi_awlen[6] = \<const0> ;
  assign m_axi_awlen[5] = \<const0> ;
  assign m_axi_awlen[4] = \<const0> ;
  assign m_axi_awlen[3] = \<const0> ;
  assign m_axi_awlen[2] = \<const0> ;
  assign m_axi_awlen[1] = \<const0> ;
  assign m_axi_awlen[0] = \<const0> ;
  assign m_axi_awlock[0] = \<const0> ;
  assign m_axi_awprot[2] = \<const0> ;
  assign m_axi_awprot[1] = \<const0> ;
  assign m_axi_awprot[0] = \<const0> ;
  assign m_axi_awqos[3] = \<const0> ;
  assign m_axi_awqos[2] = \<const0> ;
  assign m_axi_awqos[1] = \<const0> ;
  assign m_axi_awqos[0] = \<const0> ;
  assign m_axi_awregion[3] = \<const0> ;
  assign m_axi_awregion[2] = \<const0> ;
  assign m_axi_awregion[1] = \<const0> ;
  assign m_axi_awregion[0] = \<const0> ;
  assign m_axi_awsize[2] = \<const0> ;
  assign m_axi_awsize[1] = \<const0> ;
  assign m_axi_awsize[0] = \<const0> ;
  assign m_axi_awuser[0] = \<const0> ;
  assign m_axi_awvalid = \<const0> ;
  assign m_axi_bready = \<const0> ;
  assign m_axi_rready = \<const0> ;
  assign m_axi_wdata[63] = \<const0> ;
  assign m_axi_wdata[62] = \<const0> ;
  assign m_axi_wdata[61] = \<const0> ;
  assign m_axi_wdata[60] = \<const0> ;
  assign m_axi_wdata[59] = \<const0> ;
  assign m_axi_wdata[58] = \<const0> ;
  assign m_axi_wdata[57] = \<const0> ;
  assign m_axi_wdata[56] = \<const0> ;
  assign m_axi_wdata[55] = \<const0> ;
  assign m_axi_wdata[54] = \<const0> ;
  assign m_axi_wdata[53] = \<const0> ;
  assign m_axi_wdata[52] = \<const0> ;
  assign m_axi_wdata[51] = \<const0> ;
  assign m_axi_wdata[50] = \<const0> ;
  assign m_axi_wdata[49] = \<const0> ;
  assign m_axi_wdata[48] = \<const0> ;
  assign m_axi_wdata[47] = \<const0> ;
  assign m_axi_wdata[46] = \<const0> ;
  assign m_axi_wdata[45] = \<const0> ;
  assign m_axi_wdata[44] = \<const0> ;
  assign m_axi_wdata[43] = \<const0> ;
  assign m_axi_wdata[42] = \<const0> ;
  assign m_axi_wdata[41] = \<const0> ;
  assign m_axi_wdata[40] = \<const0> ;
  assign m_axi_wdata[39] = \<const0> ;
  assign m_axi_wdata[38] = \<const0> ;
  assign m_axi_wdata[37] = \<const0> ;
  assign m_axi_wdata[36] = \<const0> ;
  assign m_axi_wdata[35] = \<const0> ;
  assign m_axi_wdata[34] = \<const0> ;
  assign m_axi_wdata[33] = \<const0> ;
  assign m_axi_wdata[32] = \<const0> ;
  assign m_axi_wdata[31] = \<const0> ;
  assign m_axi_wdata[30] = \<const0> ;
  assign m_axi_wdata[29] = \<const0> ;
  assign m_axi_wdata[28] = \<const0> ;
  assign m_axi_wdata[27] = \<const0> ;
  assign m_axi_wdata[26] = \<const0> ;
  assign m_axi_wdata[25] = \<const0> ;
  assign m_axi_wdata[24] = \<const0> ;
  assign m_axi_wdata[23] = \<const0> ;
  assign m_axi_wdata[22] = \<const0> ;
  assign m_axi_wdata[21] = \<const0> ;
  assign m_axi_wdata[20] = \<const0> ;
  assign m_axi_wdata[19] = \<const0> ;
  assign m_axi_wdata[18] = \<const0> ;
  assign m_axi_wdata[17] = \<const0> ;
  assign m_axi_wdata[16] = \<const0> ;
  assign m_axi_wdata[15] = \<const0> ;
  assign m_axi_wdata[14] = \<const0> ;
  assign m_axi_wdata[13] = \<const0> ;
  assign m_axi_wdata[12] = \<const0> ;
  assign m_axi_wdata[11] = \<const0> ;
  assign m_axi_wdata[10] = \<const0> ;
  assign m_axi_wdata[9] = \<const0> ;
  assign m_axi_wdata[8] = \<const0> ;
  assign m_axi_wdata[7] = \<const0> ;
  assign m_axi_wdata[6] = \<const0> ;
  assign m_axi_wdata[5] = \<const0> ;
  assign m_axi_wdata[4] = \<const0> ;
  assign m_axi_wdata[3] = \<const0> ;
  assign m_axi_wdata[2] = \<const0> ;
  assign m_axi_wdata[1] = \<const0> ;
  assign m_axi_wdata[0] = \<const0> ;
  assign m_axi_wid[0] = \<const0> ;
  assign m_axi_wlast = \<const0> ;
  assign m_axi_wstrb[7] = \<const0> ;
  assign m_axi_wstrb[6] = \<const0> ;
  assign m_axi_wstrb[5] = \<const0> ;
  assign m_axi_wstrb[4] = \<const0> ;
  assign m_axi_wstrb[3] = \<const0> ;
  assign m_axi_wstrb[2] = \<const0> ;
  assign m_axi_wstrb[1] = \<const0> ;
  assign m_axi_wstrb[0] = \<const0> ;
  assign m_axi_wuser[0] = \<const0> ;
  assign m_axi_wvalid = \<const0> ;
  assign m_axis_tdata[7] = \<const0> ;
  assign m_axis_tdata[6] = \<const0> ;
  assign m_axis_tdata[5] = \<const0> ;
  assign m_axis_tdata[4] = \<const0> ;
  assign m_axis_tdata[3] = \<const0> ;
  assign m_axis_tdata[2] = \<const0> ;
  assign m_axis_tdata[1] = \<const0> ;
  assign m_axis_tdata[0] = \<const0> ;
  assign m_axis_tdest[0] = \<const0> ;
  assign m_axis_tid[0] = \<const0> ;
  assign m_axis_tkeep[0] = \<const0> ;
  assign m_axis_tlast = \<const0> ;
  assign m_axis_tstrb[0] = \<const0> ;
  assign m_axis_tuser[3] = \<const0> ;
  assign m_axis_tuser[2] = \<const0> ;
  assign m_axis_tuser[1] = \<const0> ;
  assign m_axis_tuser[0] = \<const0> ;
  assign m_axis_tvalid = \<const0> ;
  assign overflow = \<const0> ;
  assign prog_empty = \<const0> ;
  assign prog_full = \<const0> ;
  assign rd_data_count[7] = \<const0> ;
  assign rd_data_count[6] = \<const0> ;
  assign rd_data_count[5] = \<const0> ;
  assign rd_data_count[4] = \<const0> ;
  assign rd_data_count[3] = \<const0> ;
  assign rd_data_count[2] = \<const0> ;
  assign rd_data_count[1] = \<const0> ;
  assign rd_data_count[0] = \<const0> ;
  assign rd_rst_busy = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_buser[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_rdata[63] = \<const0> ;
  assign s_axi_rdata[62] = \<const0> ;
  assign s_axi_rdata[61] = \<const0> ;
  assign s_axi_rdata[60] = \<const0> ;
  assign s_axi_rdata[59] = \<const0> ;
  assign s_axi_rdata[58] = \<const0> ;
  assign s_axi_rdata[57] = \<const0> ;
  assign s_axi_rdata[56] = \<const0> ;
  assign s_axi_rdata[55] = \<const0> ;
  assign s_axi_rdata[54] = \<const0> ;
  assign s_axi_rdata[53] = \<const0> ;
  assign s_axi_rdata[52] = \<const0> ;
  assign s_axi_rdata[51] = \<const0> ;
  assign s_axi_rdata[50] = \<const0> ;
  assign s_axi_rdata[49] = \<const0> ;
  assign s_axi_rdata[48] = \<const0> ;
  assign s_axi_rdata[47] = \<const0> ;
  assign s_axi_rdata[46] = \<const0> ;
  assign s_axi_rdata[45] = \<const0> ;
  assign s_axi_rdata[44] = \<const0> ;
  assign s_axi_rdata[43] = \<const0> ;
  assign s_axi_rdata[42] = \<const0> ;
  assign s_axi_rdata[41] = \<const0> ;
  assign s_axi_rdata[40] = \<const0> ;
  assign s_axi_rdata[39] = \<const0> ;
  assign s_axi_rdata[38] = \<const0> ;
  assign s_axi_rdata[37] = \<const0> ;
  assign s_axi_rdata[36] = \<const0> ;
  assign s_axi_rdata[35] = \<const0> ;
  assign s_axi_rdata[34] = \<const0> ;
  assign s_axi_rdata[33] = \<const0> ;
  assign s_axi_rdata[32] = \<const0> ;
  assign s_axi_rdata[31] = \<const0> ;
  assign s_axi_rdata[30] = \<const0> ;
  assign s_axi_rdata[29] = \<const0> ;
  assign s_axi_rdata[28] = \<const0> ;
  assign s_axi_rdata[27] = \<const0> ;
  assign s_axi_rdata[26] = \<const0> ;
  assign s_axi_rdata[25] = \<const0> ;
  assign s_axi_rdata[24] = \<const0> ;
  assign s_axi_rdata[23] = \<const0> ;
  assign s_axi_rdata[22] = \<const0> ;
  assign s_axi_rdata[21] = \<const0> ;
  assign s_axi_rdata[20] = \<const0> ;
  assign s_axi_rdata[19] = \<const0> ;
  assign s_axi_rdata[18] = \<const0> ;
  assign s_axi_rdata[17] = \<const0> ;
  assign s_axi_rdata[16] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7] = \<const0> ;
  assign s_axi_rdata[6] = \<const0> ;
  assign s_axi_rdata[5] = \<const0> ;
  assign s_axi_rdata[4] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_ruser[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_wready = \<const0> ;
  assign s_axis_tready = \<const0> ;
  assign sbiterr = \<const0> ;
  assign underflow = \<const0> ;
  assign wr_ack = \<const0> ;
  assign wr_data_count[7] = \<const0> ;
  assign wr_data_count[6] = \<const0> ;
  assign wr_data_count[5] = \<const0> ;
  assign wr_data_count[4] = \<const0> ;
  assign wr_data_count[3] = \<const0> ;
  assign wr_data_count[2] = \<const0> ;
  assign wr_data_count[1] = \<const0> ;
  assign wr_data_count[0] = \<const0> ;
  assign wr_rst_busy = \<const0> ;
GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
DebugDataFIFOfifo_generator_v11_0_synth inst_fifo_gen
       (.din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .valid(valid),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

module DebugDataFIFOfifo_generator_v11_0_synth
   (dout,
    empty,
    valid,
    full,
    rd_en,
    wr_en,
    rd_clk,
    wr_clk,
    din,
    rst);
  output [511:0]dout;
  output empty;
  output valid;
  output full;
  input rd_en;
  input wr_en;
  input rd_clk;
  input wr_clk;
  input [511:0]din;
  input rst;

  wire [511:0]din;
  wire [511:0]dout;
  wire empty;
  wire full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire valid;
  wire wr_clk;
  wire wr_en;

DebugDataFIFOfifo_generator_top \gconvfifo.rf 
       (.din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .valid(valid),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

module DebugDataFIFOmemory
   (dout,
    rd_clk,
    wr_clk,
    tmp_ram_rd_en,
    I1,
    Q,
    O2,
    I2,
    din,
    E);
  output [511:0]dout;
  input rd_clk;
  input wr_clk;
  input tmp_ram_rd_en;
  input I1;
  input [0:0]Q;
  input [7:0]O2;
  input [7:0]I2;
  input [511:0]din;
  input [0:0]E;

  wire [0:0]E;
  wire I1;
  wire [7:0]I2;
  wire [7:0]O2;
  wire [0:0]Q;
  wire [511:0]din;
  wire [511:0]dout;
  wire [511:0]doutb;
  wire rd_clk;
  wire tmp_ram_rd_en;
  wire wr_clk;

DebugDataFIFOblk_mem_gen_v8_1__parameterized0 \gbm.gbmg.gbmga.ngecc.bmg 
       (.DOUTB(doutb),
        .I1(I1),
        .I2(I2),
        .O2(O2),
        .Q(Q),
        .din(din),
        .rd_clk(rd_clk),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .wr_clk(wr_clk));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[0]),
        .Q(dout[0]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[100] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[100]),
        .Q(dout[100]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[101] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[101]),
        .Q(dout[101]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[102] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[102]),
        .Q(dout[102]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[103] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[103]),
        .Q(dout[103]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[104] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[104]),
        .Q(dout[104]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[105] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[105]),
        .Q(dout[105]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[106] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[106]),
        .Q(dout[106]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[107] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[107]),
        .Q(dout[107]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[108] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[108]),
        .Q(dout[108]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[109] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[109]),
        .Q(dout[109]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[10] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[10]),
        .Q(dout[10]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[110] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[110]),
        .Q(dout[110]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[111] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[111]),
        .Q(dout[111]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[112] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[112]),
        .Q(dout[112]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[113] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[113]),
        .Q(dout[113]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[114] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[114]),
        .Q(dout[114]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[115] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[115]),
        .Q(dout[115]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[116] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[116]),
        .Q(dout[116]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[117] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[117]),
        .Q(dout[117]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[118] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[118]),
        .Q(dout[118]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[119] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[119]),
        .Q(dout[119]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[11] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[11]),
        .Q(dout[11]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[120] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[120]),
        .Q(dout[120]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[121] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[121]),
        .Q(dout[121]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[122] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[122]),
        .Q(dout[122]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[123] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[123]),
        .Q(dout[123]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[124] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[124]),
        .Q(dout[124]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[125] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[125]),
        .Q(dout[125]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[126] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[126]),
        .Q(dout[126]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[127] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[127]),
        .Q(dout[127]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[128] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[128]),
        .Q(dout[128]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[129] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[129]),
        .Q(dout[129]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[12] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[12]),
        .Q(dout[12]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[130] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[130]),
        .Q(dout[130]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[131] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[131]),
        .Q(dout[131]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[132] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[132]),
        .Q(dout[132]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[133] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[133]),
        .Q(dout[133]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[134] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[134]),
        .Q(dout[134]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[135] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[135]),
        .Q(dout[135]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[136] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[136]),
        .Q(dout[136]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[137] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[137]),
        .Q(dout[137]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[138] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[138]),
        .Q(dout[138]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[139] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[139]),
        .Q(dout[139]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[13] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[13]),
        .Q(dout[13]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[140] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[140]),
        .Q(dout[140]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[141] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[141]),
        .Q(dout[141]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[142] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[142]),
        .Q(dout[142]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[143] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[143]),
        .Q(dout[143]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[144] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[144]),
        .Q(dout[144]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[145] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[145]),
        .Q(dout[145]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[146] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[146]),
        .Q(dout[146]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[147] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[147]),
        .Q(dout[147]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[148] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[148]),
        .Q(dout[148]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[149] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[149]),
        .Q(dout[149]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[14] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[14]),
        .Q(dout[14]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[150] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[150]),
        .Q(dout[150]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[151] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[151]),
        .Q(dout[151]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[152] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[152]),
        .Q(dout[152]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[153] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[153]),
        .Q(dout[153]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[154] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[154]),
        .Q(dout[154]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[155] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[155]),
        .Q(dout[155]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[156] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[156]),
        .Q(dout[156]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[157] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[157]),
        .Q(dout[157]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[158] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[158]),
        .Q(dout[158]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[159] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[159]),
        .Q(dout[159]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[15] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[15]),
        .Q(dout[15]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[160] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[160]),
        .Q(dout[160]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[161] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[161]),
        .Q(dout[161]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[162] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[162]),
        .Q(dout[162]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[163] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[163]),
        .Q(dout[163]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[164] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[164]),
        .Q(dout[164]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[165] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[165]),
        .Q(dout[165]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[166] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[166]),
        .Q(dout[166]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[167] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[167]),
        .Q(dout[167]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[168] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[168]),
        .Q(dout[168]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[169] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[169]),
        .Q(dout[169]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[16] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[16]),
        .Q(dout[16]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[170] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[170]),
        .Q(dout[170]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[171] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[171]),
        .Q(dout[171]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[172] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[172]),
        .Q(dout[172]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[173] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[173]),
        .Q(dout[173]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[174] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[174]),
        .Q(dout[174]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[175] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[175]),
        .Q(dout[175]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[176] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[176]),
        .Q(dout[176]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[177] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[177]),
        .Q(dout[177]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[178] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[178]),
        .Q(dout[178]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[179] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[179]),
        .Q(dout[179]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[17] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[17]),
        .Q(dout[17]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[180] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[180]),
        .Q(dout[180]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[181] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[181]),
        .Q(dout[181]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[182] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[182]),
        .Q(dout[182]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[183] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[183]),
        .Q(dout[183]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[184] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[184]),
        .Q(dout[184]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[185] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[185]),
        .Q(dout[185]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[186] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[186]),
        .Q(dout[186]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[187] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[187]),
        .Q(dout[187]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[188] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[188]),
        .Q(dout[188]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[189] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[189]),
        .Q(dout[189]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[18] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[18]),
        .Q(dout[18]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[190] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[190]),
        .Q(dout[190]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[191] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[191]),
        .Q(dout[191]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[192] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[192]),
        .Q(dout[192]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[193] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[193]),
        .Q(dout[193]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[194] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[194]),
        .Q(dout[194]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[195] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[195]),
        .Q(dout[195]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[196] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[196]),
        .Q(dout[196]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[197] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[197]),
        .Q(dout[197]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[198] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[198]),
        .Q(dout[198]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[199] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[199]),
        .Q(dout[199]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[19] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[19]),
        .Q(dout[19]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[1]),
        .Q(dout[1]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[200] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[200]),
        .Q(dout[200]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[201] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[201]),
        .Q(dout[201]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[202] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[202]),
        .Q(dout[202]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[203] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[203]),
        .Q(dout[203]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[204] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[204]),
        .Q(dout[204]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[205] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[205]),
        .Q(dout[205]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[206] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[206]),
        .Q(dout[206]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[207] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[207]),
        .Q(dout[207]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[208] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[208]),
        .Q(dout[208]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[209] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[209]),
        .Q(dout[209]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[20] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[20]),
        .Q(dout[20]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[210] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[210]),
        .Q(dout[210]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[211] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[211]),
        .Q(dout[211]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[212] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[212]),
        .Q(dout[212]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[213] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[213]),
        .Q(dout[213]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[214] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[214]),
        .Q(dout[214]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[215] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[215]),
        .Q(dout[215]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[216] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[216]),
        .Q(dout[216]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[217] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[217]),
        .Q(dout[217]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[218] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[218]),
        .Q(dout[218]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[219] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[219]),
        .Q(dout[219]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[21] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[21]),
        .Q(dout[21]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[220] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[220]),
        .Q(dout[220]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[221] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[221]),
        .Q(dout[221]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[222] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[222]),
        .Q(dout[222]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[223] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[223]),
        .Q(dout[223]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[224] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[224]),
        .Q(dout[224]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[225] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[225]),
        .Q(dout[225]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[226] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[226]),
        .Q(dout[226]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[227] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[227]),
        .Q(dout[227]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[228] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[228]),
        .Q(dout[228]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[229] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[229]),
        .Q(dout[229]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[22] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[22]),
        .Q(dout[22]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[230] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[230]),
        .Q(dout[230]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[231] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[231]),
        .Q(dout[231]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[232] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[232]),
        .Q(dout[232]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[233] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[233]),
        .Q(dout[233]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[234] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[234]),
        .Q(dout[234]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[235] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[235]),
        .Q(dout[235]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[236] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[236]),
        .Q(dout[236]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[237] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[237]),
        .Q(dout[237]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[238] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[238]),
        .Q(dout[238]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[239] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[239]),
        .Q(dout[239]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[23] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[23]),
        .Q(dout[23]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[240] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[240]),
        .Q(dout[240]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[241] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[241]),
        .Q(dout[241]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[242] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[242]),
        .Q(dout[242]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[243] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[243]),
        .Q(dout[243]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[244] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[244]),
        .Q(dout[244]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[245] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[245]),
        .Q(dout[245]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[246] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[246]),
        .Q(dout[246]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[247] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[247]),
        .Q(dout[247]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[248] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[248]),
        .Q(dout[248]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[249] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[249]),
        .Q(dout[249]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[24] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[24]),
        .Q(dout[24]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[250] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[250]),
        .Q(dout[250]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[251] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[251]),
        .Q(dout[251]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[252] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[252]),
        .Q(dout[252]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[253] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[253]),
        .Q(dout[253]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[254] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[254]),
        .Q(dout[254]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[255] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[255]),
        .Q(dout[255]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[256] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[256]),
        .Q(dout[256]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[257] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[257]),
        .Q(dout[257]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[258] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[258]),
        .Q(dout[258]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[259] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[259]),
        .Q(dout[259]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[25] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[25]),
        .Q(dout[25]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[260] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[260]),
        .Q(dout[260]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[261] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[261]),
        .Q(dout[261]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[262] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[262]),
        .Q(dout[262]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[263] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[263]),
        .Q(dout[263]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[264] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[264]),
        .Q(dout[264]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[265] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[265]),
        .Q(dout[265]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[266] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[266]),
        .Q(dout[266]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[267] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[267]),
        .Q(dout[267]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[268] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[268]),
        .Q(dout[268]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[269] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[269]),
        .Q(dout[269]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[26] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[26]),
        .Q(dout[26]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[270] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[270]),
        .Q(dout[270]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[271] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[271]),
        .Q(dout[271]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[272] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[272]),
        .Q(dout[272]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[273] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[273]),
        .Q(dout[273]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[274] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[274]),
        .Q(dout[274]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[275] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[275]),
        .Q(dout[275]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[276] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[276]),
        .Q(dout[276]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[277] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[277]),
        .Q(dout[277]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[278] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[278]),
        .Q(dout[278]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[279] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[279]),
        .Q(dout[279]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[27] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[27]),
        .Q(dout[27]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[280] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[280]),
        .Q(dout[280]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[281] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[281]),
        .Q(dout[281]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[282] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[282]),
        .Q(dout[282]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[283] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[283]),
        .Q(dout[283]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[284] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[284]),
        .Q(dout[284]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[285] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[285]),
        .Q(dout[285]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[286] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[286]),
        .Q(dout[286]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[287] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[287]),
        .Q(dout[287]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[288] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[288]),
        .Q(dout[288]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[289] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[289]),
        .Q(dout[289]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[28] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[28]),
        .Q(dout[28]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[290] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[290]),
        .Q(dout[290]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[291] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[291]),
        .Q(dout[291]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[292] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[292]),
        .Q(dout[292]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[293] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[293]),
        .Q(dout[293]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[294] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[294]),
        .Q(dout[294]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[295] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[295]),
        .Q(dout[295]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[296] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[296]),
        .Q(dout[296]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[297] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[297]),
        .Q(dout[297]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[298] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[298]),
        .Q(dout[298]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[299] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[299]),
        .Q(dout[299]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[29] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[29]),
        .Q(dout[29]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[2]),
        .Q(dout[2]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[300] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[300]),
        .Q(dout[300]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[301] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[301]),
        .Q(dout[301]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[302] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[302]),
        .Q(dout[302]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[303] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[303]),
        .Q(dout[303]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[304] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[304]),
        .Q(dout[304]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[305] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[305]),
        .Q(dout[305]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[306] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[306]),
        .Q(dout[306]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[307] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[307]),
        .Q(dout[307]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[308] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[308]),
        .Q(dout[308]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[309] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[309]),
        .Q(dout[309]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[30] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[30]),
        .Q(dout[30]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[310] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[310]),
        .Q(dout[310]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[311] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[311]),
        .Q(dout[311]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[312] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[312]),
        .Q(dout[312]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[313] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[313]),
        .Q(dout[313]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[314] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[314]),
        .Q(dout[314]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[315] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[315]),
        .Q(dout[315]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[316] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[316]),
        .Q(dout[316]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[317] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[317]),
        .Q(dout[317]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[318] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[318]),
        .Q(dout[318]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[319] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[319]),
        .Q(dout[319]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[31] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[31]),
        .Q(dout[31]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[320] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[320]),
        .Q(dout[320]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[321] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[321]),
        .Q(dout[321]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[322] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[322]),
        .Q(dout[322]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[323] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[323]),
        .Q(dout[323]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[324] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[324]),
        .Q(dout[324]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[325] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[325]),
        .Q(dout[325]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[326] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[326]),
        .Q(dout[326]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[327] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[327]),
        .Q(dout[327]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[328] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[328]),
        .Q(dout[328]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[329] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[329]),
        .Q(dout[329]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[32] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[32]),
        .Q(dout[32]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[330] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[330]),
        .Q(dout[330]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[331] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[331]),
        .Q(dout[331]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[332] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[332]),
        .Q(dout[332]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[333] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[333]),
        .Q(dout[333]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[334] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[334]),
        .Q(dout[334]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[335] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[335]),
        .Q(dout[335]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[336] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[336]),
        .Q(dout[336]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[337] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[337]),
        .Q(dout[337]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[338] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[338]),
        .Q(dout[338]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[339] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[339]),
        .Q(dout[339]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[33] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[33]),
        .Q(dout[33]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[340] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[340]),
        .Q(dout[340]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[341] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[341]),
        .Q(dout[341]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[342] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[342]),
        .Q(dout[342]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[343] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[343]),
        .Q(dout[343]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[344] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[344]),
        .Q(dout[344]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[345] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[345]),
        .Q(dout[345]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[346] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[346]),
        .Q(dout[346]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[347] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[347]),
        .Q(dout[347]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[348] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[348]),
        .Q(dout[348]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[349] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[349]),
        .Q(dout[349]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[34] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[34]),
        .Q(dout[34]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[350] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[350]),
        .Q(dout[350]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[351] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[351]),
        .Q(dout[351]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[352] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[352]),
        .Q(dout[352]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[353] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[353]),
        .Q(dout[353]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[354] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[354]),
        .Q(dout[354]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[355] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[355]),
        .Q(dout[355]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[356] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[356]),
        .Q(dout[356]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[357] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[357]),
        .Q(dout[357]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[358] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[358]),
        .Q(dout[358]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[359] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[359]),
        .Q(dout[359]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[35] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[35]),
        .Q(dout[35]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[360] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[360]),
        .Q(dout[360]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[361] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[361]),
        .Q(dout[361]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[362] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[362]),
        .Q(dout[362]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[363] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[363]),
        .Q(dout[363]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[364] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[364]),
        .Q(dout[364]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[365] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[365]),
        .Q(dout[365]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[366] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[366]),
        .Q(dout[366]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[367] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[367]),
        .Q(dout[367]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[368] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[368]),
        .Q(dout[368]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[369] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[369]),
        .Q(dout[369]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[36] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[36]),
        .Q(dout[36]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[370] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[370]),
        .Q(dout[370]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[371] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[371]),
        .Q(dout[371]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[372] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[372]),
        .Q(dout[372]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[373] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[373]),
        .Q(dout[373]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[374] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[374]),
        .Q(dout[374]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[375] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[375]),
        .Q(dout[375]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[376] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[376]),
        .Q(dout[376]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[377] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[377]),
        .Q(dout[377]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[378] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[378]),
        .Q(dout[378]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[379] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[379]),
        .Q(dout[379]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[37] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[37]),
        .Q(dout[37]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[380] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[380]),
        .Q(dout[380]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[381] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[381]),
        .Q(dout[381]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[382] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[382]),
        .Q(dout[382]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[383] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[383]),
        .Q(dout[383]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[384] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[384]),
        .Q(dout[384]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[385] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[385]),
        .Q(dout[385]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[386] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[386]),
        .Q(dout[386]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[387] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[387]),
        .Q(dout[387]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[388] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[388]),
        .Q(dout[388]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[389] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[389]),
        .Q(dout[389]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[38] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[38]),
        .Q(dout[38]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[390] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[390]),
        .Q(dout[390]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[391] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[391]),
        .Q(dout[391]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[392] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[392]),
        .Q(dout[392]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[393] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[393]),
        .Q(dout[393]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[394] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[394]),
        .Q(dout[394]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[395] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[395]),
        .Q(dout[395]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[396] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[396]),
        .Q(dout[396]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[397] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[397]),
        .Q(dout[397]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[398] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[398]),
        .Q(dout[398]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[399] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[399]),
        .Q(dout[399]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[39] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[39]),
        .Q(dout[39]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[3]),
        .Q(dout[3]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[400] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[400]),
        .Q(dout[400]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[401] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[401]),
        .Q(dout[401]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[402] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[402]),
        .Q(dout[402]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[403] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[403]),
        .Q(dout[403]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[404] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[404]),
        .Q(dout[404]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[405] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[405]),
        .Q(dout[405]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[406] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[406]),
        .Q(dout[406]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[407] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[407]),
        .Q(dout[407]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[408] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[408]),
        .Q(dout[408]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[409] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[409]),
        .Q(dout[409]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[40] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[40]),
        .Q(dout[40]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[410] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[410]),
        .Q(dout[410]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[411] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[411]),
        .Q(dout[411]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[412] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[412]),
        .Q(dout[412]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[413] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[413]),
        .Q(dout[413]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[414] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[414]),
        .Q(dout[414]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[415] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[415]),
        .Q(dout[415]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[416] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[416]),
        .Q(dout[416]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[417] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[417]),
        .Q(dout[417]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[418] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[418]),
        .Q(dout[418]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[419] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[419]),
        .Q(dout[419]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[41] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[41]),
        .Q(dout[41]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[420] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[420]),
        .Q(dout[420]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[421] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[421]),
        .Q(dout[421]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[422] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[422]),
        .Q(dout[422]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[423] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[423]),
        .Q(dout[423]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[424] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[424]),
        .Q(dout[424]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[425] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[425]),
        .Q(dout[425]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[426] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[426]),
        .Q(dout[426]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[427] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[427]),
        .Q(dout[427]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[428] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[428]),
        .Q(dout[428]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[429] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[429]),
        .Q(dout[429]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[42] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[42]),
        .Q(dout[42]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[430] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[430]),
        .Q(dout[430]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[431] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[431]),
        .Q(dout[431]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[432] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[432]),
        .Q(dout[432]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[433] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[433]),
        .Q(dout[433]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[434] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[434]),
        .Q(dout[434]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[435] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[435]),
        .Q(dout[435]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[436] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[436]),
        .Q(dout[436]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[437] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[437]),
        .Q(dout[437]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[438] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[438]),
        .Q(dout[438]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[439] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[439]),
        .Q(dout[439]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[43] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[43]),
        .Q(dout[43]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[440] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[440]),
        .Q(dout[440]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[441] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[441]),
        .Q(dout[441]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[442] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[442]),
        .Q(dout[442]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[443] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[443]),
        .Q(dout[443]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[444] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[444]),
        .Q(dout[444]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[445] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[445]),
        .Q(dout[445]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[446] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[446]),
        .Q(dout[446]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[447] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[447]),
        .Q(dout[447]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[448] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[448]),
        .Q(dout[448]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[449] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[449]),
        .Q(dout[449]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[44] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[44]),
        .Q(dout[44]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[450] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[450]),
        .Q(dout[450]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[451] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[451]),
        .Q(dout[451]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[452] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[452]),
        .Q(dout[452]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[453] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[453]),
        .Q(dout[453]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[454] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[454]),
        .Q(dout[454]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[455] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[455]),
        .Q(dout[455]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[456] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[456]),
        .Q(dout[456]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[457] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[457]),
        .Q(dout[457]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[458] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[458]),
        .Q(dout[458]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[459] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[459]),
        .Q(dout[459]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[45] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[45]),
        .Q(dout[45]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[460] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[460]),
        .Q(dout[460]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[461] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[461]),
        .Q(dout[461]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[462] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[462]),
        .Q(dout[462]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[463] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[463]),
        .Q(dout[463]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[464] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[464]),
        .Q(dout[464]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[465] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[465]),
        .Q(dout[465]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[466] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[466]),
        .Q(dout[466]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[467] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[467]),
        .Q(dout[467]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[468] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[468]),
        .Q(dout[468]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[469] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[469]),
        .Q(dout[469]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[46] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[46]),
        .Q(dout[46]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[470] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[470]),
        .Q(dout[470]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[471] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[471]),
        .Q(dout[471]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[472] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[472]),
        .Q(dout[472]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[473] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[473]),
        .Q(dout[473]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[474] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[474]),
        .Q(dout[474]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[475] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[475]),
        .Q(dout[475]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[476] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[476]),
        .Q(dout[476]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[477] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[477]),
        .Q(dout[477]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[478] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[478]),
        .Q(dout[478]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[479] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[479]),
        .Q(dout[479]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[47] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[47]),
        .Q(dout[47]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[480] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[480]),
        .Q(dout[480]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[481] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[481]),
        .Q(dout[481]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[482] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[482]),
        .Q(dout[482]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[483] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[483]),
        .Q(dout[483]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[484] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[484]),
        .Q(dout[484]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[485] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[485]),
        .Q(dout[485]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[486] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[486]),
        .Q(dout[486]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[487] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[487]),
        .Q(dout[487]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[488] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[488]),
        .Q(dout[488]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[489] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[489]),
        .Q(dout[489]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[48] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[48]),
        .Q(dout[48]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[490] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[490]),
        .Q(dout[490]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[491] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[491]),
        .Q(dout[491]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[492] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[492]),
        .Q(dout[492]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[493] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[493]),
        .Q(dout[493]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[494] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[494]),
        .Q(dout[494]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[495] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[495]),
        .Q(dout[495]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[496] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[496]),
        .Q(dout[496]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[497] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[497]),
        .Q(dout[497]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[498] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[498]),
        .Q(dout[498]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[499] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[499]),
        .Q(dout[499]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[49] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[49]),
        .Q(dout[49]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[4]),
        .Q(dout[4]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[500] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[500]),
        .Q(dout[500]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[501] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[501]),
        .Q(dout[501]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[502] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[502]),
        .Q(dout[502]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[503] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[503]),
        .Q(dout[503]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[504] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[504]),
        .Q(dout[504]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[505] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[505]),
        .Q(dout[505]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[506] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[506]),
        .Q(dout[506]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[507] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[507]),
        .Q(dout[507]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[508] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[508]),
        .Q(dout[508]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[509] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[509]),
        .Q(dout[509]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[50] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[50]),
        .Q(dout[50]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[510] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[510]),
        .Q(dout[510]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[511] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[511]),
        .Q(dout[511]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[51] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[51]),
        .Q(dout[51]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[52] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[52]),
        .Q(dout[52]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[53] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[53]),
        .Q(dout[53]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[54] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[54]),
        .Q(dout[54]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[55] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[55]),
        .Q(dout[55]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[56] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[56]),
        .Q(dout[56]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[57] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[57]),
        .Q(dout[57]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[58] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[58]),
        .Q(dout[58]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[59] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[59]),
        .Q(dout[59]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[5] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[5]),
        .Q(dout[5]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[60] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[60]),
        .Q(dout[60]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[61] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[61]),
        .Q(dout[61]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[62] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[62]),
        .Q(dout[62]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[63] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[63]),
        .Q(dout[63]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[64] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[64]),
        .Q(dout[64]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[65] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[65]),
        .Q(dout[65]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[66] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[66]),
        .Q(dout[66]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[67] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[67]),
        .Q(dout[67]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[68] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[68]),
        .Q(dout[68]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[69] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[69]),
        .Q(dout[69]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[6] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[6]),
        .Q(dout[6]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[70] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[70]),
        .Q(dout[70]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[71] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[71]),
        .Q(dout[71]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[72] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[72]),
        .Q(dout[72]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[73] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[73]),
        .Q(dout[73]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[74] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[74]),
        .Q(dout[74]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[75] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[75]),
        .Q(dout[75]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[76] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[76]),
        .Q(dout[76]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[77] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[77]),
        .Q(dout[77]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[78] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[78]),
        .Q(dout[78]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[79] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[79]),
        .Q(dout[79]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[7] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[7]),
        .Q(dout[7]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[80] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[80]),
        .Q(dout[80]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[81] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[81]),
        .Q(dout[81]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[82] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[82]),
        .Q(dout[82]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[83] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[83]),
        .Q(dout[83]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[84] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[84]),
        .Q(dout[84]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[85] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[85]),
        .Q(dout[85]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[86] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[86]),
        .Q(dout[86]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[87] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[87]),
        .Q(dout[87]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[88] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[88]),
        .Q(dout[88]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[89] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[89]),
        .Q(dout[89]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[8] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[8]),
        .Q(dout[8]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[90] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[90]),
        .Q(dout[90]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[91] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[91]),
        .Q(dout[91]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[92] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[92]),
        .Q(dout[92]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[93] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[93]),
        .Q(dout[93]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[94] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[94]),
        .Q(dout[94]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[95] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[95]),
        .Q(dout[95]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[96] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[96]),
        .Q(dout[96]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[97] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[97]),
        .Q(dout[97]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[98] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[98]),
        .Q(dout[98]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[99] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[99]),
        .Q(dout[99]),
        .R(Q));
FDRE #(
    .INIT(1'b0)) 
     \goreg_bm.dout_i_reg[9] 
       (.C(rd_clk),
        .CE(E),
        .D(doutb[9]),
        .Q(dout[9]),
        .R(Q));
endmodule

module DebugDataFIFOrd_bin_cntr
   (Q,
    O2,
    O1,
    I1,
    I2,
    I3,
    E,
    rd_clk,
    I4);
  output [2:0]Q;
  output [7:0]O2;
  output O1;
  input [7:0]I1;
  input I2;
  input I3;
  input [0:0]E;
  input rd_clk;
  input [0:0]I4;

  wire [0:0]E;
  wire [7:0]I1;
  wire I2;
  wire I3;
  wire [0:0]I4;
  wire O1;
  wire [7:0]O2;
  wire [2:0]Q;
  wire \gras.rsts/comp0 ;
  wire \n_0_gc0.count[7]_i_2 ;
  wire n_0_ram_empty_fb_i_i_3;
  wire n_0_ram_empty_fb_i_i_4;
  wire n_0_ram_empty_fb_i_i_5;
  wire n_0_ram_empty_fb_i_i_6;
  wire [7:0]plusOp;
  wire rd_clk;
  wire [7:3]rd_pntr_plus1;

LUT1 #(
    .INIT(2'h1)) 
     \gc0.count[0]_i_1 
       (.I0(Q[0]),
        .O(plusOp[0]));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \gc0.count[1]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(plusOp[1]));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \gc0.count[2]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .O(plusOp[2]));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \gc0.count[3]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(rd_pntr_plus1[3]),
        .O(plusOp[3]));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT5 #(
    .INIT(32'h7FFF8000)) 
     \gc0.count[4]_i_1 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(rd_pntr_plus1[3]),
        .I4(rd_pntr_plus1[4]),
        .O(plusOp[4]));
LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
     \gc0.count[5]_i_1 
       (.I0(rd_pntr_plus1[3]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[2]),
        .I4(rd_pntr_plus1[4]),
        .I5(rd_pntr_plus1[5]),
        .O(plusOp[5]));
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \gc0.count[6]_i_1 
       (.I0(\n_0_gc0.count[7]_i_2 ),
        .I1(rd_pntr_plus1[6]),
        .O(plusOp[6]));
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \gc0.count[7]_i_1 
       (.I0(\n_0_gc0.count[7]_i_2 ),
        .I1(rd_pntr_plus1[6]),
        .I2(rd_pntr_plus1[7]),
        .O(plusOp[7]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \gc0.count[7]_i_2 
       (.I0(rd_pntr_plus1[5]),
        .I1(rd_pntr_plus1[3]),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(Q[2]),
        .I5(rd_pntr_plus1[4]),
        .O(\n_0_gc0.count[7]_i_2 ));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(Q[0]),
        .Q(O2[0]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(Q[1]),
        .Q(O2[1]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(Q[2]),
        .Q(O2[2]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(rd_pntr_plus1[3]),
        .Q(O2[3]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(rd_pntr_plus1[4]),
        .Q(O2[4]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[5] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(rd_pntr_plus1[5]),
        .Q(O2[5]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[6] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(rd_pntr_plus1[6]),
        .Q(O2[6]));
FDCE #(
    .INIT(1'b0)) 
     \gc0.count_d1_reg[7] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(rd_pntr_plus1[7]),
        .Q(O2[7]));
(* counter = "2" *) 
   FDPE #(
    .INIT(1'b1)) 
     \gc0.count_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .D(plusOp[0]),
        .PRE(I4),
        .Q(Q[0]));
(* counter = "2" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(plusOp[1]),
        .Q(Q[1]));
(* counter = "2" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(plusOp[2]),
        .Q(Q[2]));
(* counter = "2" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(plusOp[3]),
        .Q(rd_pntr_plus1[3]));
(* counter = "2" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(plusOp[4]),
        .Q(rd_pntr_plus1[4]));
(* counter = "2" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[5] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(plusOp[5]),
        .Q(rd_pntr_plus1[5]));
(* counter = "2" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[6] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(plusOp[6]),
        .Q(rd_pntr_plus1[6]));
(* counter = "2" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gc0.count_reg[7] 
       (.C(rd_clk),
        .CE(E),
        .CLR(I4),
        .D(plusOp[7]),
        .Q(rd_pntr_plus1[7]));
LUT3 #(
    .INIT(8'hEA)) 
     ram_empty_fb_i_i_1
       (.I0(\gras.rsts/comp0 ),
        .I1(n_0_ram_empty_fb_i_i_3),
        .I2(n_0_ram_empty_fb_i_i_4),
        .O(O1));
LUT6 #(
    .INIT(64'h9009000000000000)) 
     ram_empty_fb_i_i_2
       (.I0(O2[7]),
        .I1(I1[7]),
        .I2(O2[6]),
        .I3(I1[6]),
        .I4(n_0_ram_empty_fb_i_i_5),
        .I5(n_0_ram_empty_fb_i_i_6),
        .O(\gras.rsts/comp0 ));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_empty_fb_i_i_3
       (.I0(rd_pntr_plus1[5]),
        .I1(I1[5]),
        .I2(rd_pntr_plus1[7]),
        .I3(I1[7]),
        .I4(I1[6]),
        .I5(rd_pntr_plus1[6]),
        .O(n_0_ram_empty_fb_i_i_3));
LUT6 #(
    .INIT(64'h9009000000000000)) 
     ram_empty_fb_i_i_4
       (.I0(rd_pntr_plus1[3]),
        .I1(I1[3]),
        .I2(rd_pntr_plus1[4]),
        .I3(I1[4]),
        .I4(I2),
        .I5(I3),
        .O(n_0_ram_empty_fb_i_i_4));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_empty_fb_i_i_5
       (.I0(O2[0]),
        .I1(I1[0]),
        .I2(O2[1]),
        .I3(I1[1]),
        .I4(I1[2]),
        .I5(O2[2]),
        .O(n_0_ram_empty_fb_i_i_5));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     ram_empty_fb_i_i_6
       (.I0(O2[3]),
        .I1(I1[3]),
        .I2(O2[4]),
        .I3(I1[4]),
        .I4(I1[5]),
        .I5(O2[5]),
        .O(n_0_ram_empty_fb_i_i_6));
endmodule

module DebugDataFIFOrd_fwft
   (empty,
    valid,
    O1,
    tmp_ram_rd_en,
    E,
    O2,
    rd_clk,
    Q,
    p_17_out,
    rd_en,
    I1,
    I2);
  output empty;
  output valid;
  output O1;
  output tmp_ram_rd_en;
  output [0:0]E;
  output [0:0]O2;
  input rd_clk;
  input [1:0]Q;
  input p_17_out;
  input rd_en;
  input [0:0]I1;
  input [0:0]I2;

  wire \<const1> ;
  wire [0:0]E;
  wire [0:0]I1;
  wire [0:0]I2;
  wire O1;
  wire [0:0]O2;
  wire [1:0]Q;
  wire [0:0]curr_fwft_state;
  wire empty;
  wire empty_fwft_fb;
  wire empty_fwft_i0;
  wire \n_0_gpregsm1.curr_fwft_state_reg[1] ;
  wire [1:0]next_fwft_state;
  wire p_17_out;
  wire rd_clk;
  wire rd_en;
  wire tmp_ram_rd_en;
  wire valid;

LUT5 #(
    .INIT(32'hBABBBBBB)) 
     \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram_i_1 
       (.I0(Q[0]),
        .I1(p_17_out),
        .I2(rd_en),
        .I3(curr_fwft_state),
        .I4(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .O(tmp_ram_rd_en));
VCC VCC
       (.P(\<const1> ));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     empty_fwft_fb_reg
       (.C(rd_clk),
        .CE(\<const1> ),
        .D(empty_fwft_i0),
        .PRE(Q[1]),
        .Q(empty_fwft_fb));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT4 #(
    .INIT(16'hBA22)) 
     empty_fwft_i_i_1
       (.I0(empty_fwft_fb),
        .I1(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I2(rd_en),
        .I3(curr_fwft_state),
        .O(empty_fwft_i0));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     empty_fwft_i_reg
       (.C(rd_clk),
        .CE(\<const1> ),
        .D(empty_fwft_i0),
        .PRE(Q[1]),
        .Q(empty));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT4 #(
    .INIT(16'h00BF)) 
     \gc0.count_d1[7]_i_1 
       (.I0(rd_en),
        .I1(curr_fwft_state),
        .I2(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I3(p_17_out),
        .O(E));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT3 #(
    .INIT(8'hA2)) 
     \goreg_bm.dout_i[511]_i_1 
       (.I0(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I1(curr_fwft_state),
        .I2(rd_en),
        .O(O2));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT4 #(
    .INIT(16'h40FF)) 
     \gpregsm1.curr_fwft_state[1]_i_1 
       (.I0(rd_en),
        .I1(curr_fwft_state),
        .I2(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I3(p_17_out),
        .O(next_fwft_state[1]));
(* equivalent_register_removal = "no" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gpregsm1.curr_fwft_state_reg[0] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(Q[1]),
        .D(next_fwft_state[0]),
        .Q(curr_fwft_state));
(* equivalent_register_removal = "no" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gpregsm1.curr_fwft_state_reg[1] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(Q[1]),
        .D(next_fwft_state[1]),
        .Q(\n_0_gpregsm1.curr_fwft_state_reg[1] ));
LUT3 #(
    .INIT(8'hBA)) 
     \gpregsm1.user_valid_i_1 
       (.I0(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I1(rd_en),
        .I2(curr_fwft_state),
        .O(next_fwft_state[0]));
(* equivalent_register_removal = "no" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gpregsm1.user_valid_reg 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(Q[1]),
        .D(next_fwft_state[0]),
        .Q(valid));
LUT6 #(
    .INIT(64'h5515000000005515)) 
     ram_empty_fb_i_i_7
       (.I0(p_17_out),
        .I1(\n_0_gpregsm1.curr_fwft_state_reg[1] ),
        .I2(curr_fwft_state),
        .I3(rd_en),
        .I4(I1),
        .I5(I2),
        .O(O1));
endmodule

module DebugDataFIFOrd_logic
   (empty,
    valid,
    O1,
    O2,
    tmp_ram_rd_en,
    E,
    rd_clk,
    Q,
    I1,
    I2,
    rd_en);
  output empty;
  output valid;
  output [1:0]O1;
  output [7:0]O2;
  output tmp_ram_rd_en;
  output [0:0]E;
  input rd_clk;
  input [1:0]Q;
  input [7:0]I1;
  input I2;
  input rd_en;

  wire [0:0]E;
  wire [7:0]I1;
  wire I2;
  wire [1:0]O1;
  wire [7:0]O2;
  wire [1:0]Q;
  wire empty;
  wire n_11_rpntr;
  wire \n_2_gr1.rfwft ;
  wire p_13_out;
  wire p_17_out;
  wire rd_clk;
  wire rd_en;
  wire [0:0]rd_pntr_plus1;
  wire tmp_ram_rd_en;
  wire valid;

DebugDataFIFOrd_fwft \gr1.rfwft 
       (.E(p_13_out),
        .I1(I1[0]),
        .I2(rd_pntr_plus1),
        .O1(\n_2_gr1.rfwft ),
        .O2(E),
        .Q(Q),
        .empty(empty),
        .p_17_out(p_17_out),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .tmp_ram_rd_en(tmp_ram_rd_en),
        .valid(valid));
DebugDataFIFOrd_status_flags_as \gras.rsts 
       (.I1(n_11_rpntr),
        .Q(Q[1]),
        .p_17_out(p_17_out),
        .rd_clk(rd_clk));
DebugDataFIFOrd_bin_cntr rpntr
       (.E(p_13_out),
        .I1(I1),
        .I2(\n_2_gr1.rfwft ),
        .I3(I2),
        .I4(Q[1]),
        .O1(n_11_rpntr),
        .O2(O2),
        .Q({O1,rd_pntr_plus1}),
        .rd_clk(rd_clk));
endmodule

module DebugDataFIFOrd_status_flags_as
   (p_17_out,
    I1,
    rd_clk,
    Q);
  output p_17_out;
  input I1;
  input rd_clk;
  input [0:0]Q;

  wire \<const1> ;
  wire I1;
  wire [0:0]Q;
  wire p_17_out;
  wire rd_clk;

VCC VCC
       (.P(\<const1> ));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     ram_empty_fb_i_reg
       (.C(rd_clk),
        .CE(\<const1> ),
        .D(I1),
        .PRE(Q),
        .Q(p_17_out));
endmodule

module DebugDataFIFOreset_blk_ramfifo
   (rst_full_gen_i,
    rst_d2,
    Q,
    O1,
    wr_clk,
    rd_clk,
    rst);
  output rst_full_gen_i;
  output rst_d2;
  output [1:0]Q;
  output [2:0]O1;
  input wr_clk;
  input rd_clk;
  input rst;

  wire \<const0> ;
  wire \<const1> ;
  wire [2:0]O1;
  wire [1:0]Q;
  wire \n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1 ;
  wire \n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ;
  wire \n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1 ;
  wire \n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 ;
  wire rd_clk;
  wire rd_rst_asreg;
  wire rd_rst_asreg_d1;
  wire rd_rst_asreg_d2;
  wire rst;
  wire rst_d1;
  wire rst_d2;
  wire rst_d3;
  wire rst_full_gen_i;
  wire wr_clk;
  wire wr_rst_asreg;
  wire wr_rst_asreg_d1;
  wire wr_rst_asreg_d2;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
FDCE #(
    .INIT(1'b0)) 
     \grstd1.grst_full.grst_f.RST_FULL_GEN_reg 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(rst),
        .D(rst_d3),
        .Q(rst_full_gen_i));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE #(
    .INIT(1'b1)) 
     \grstd1.grst_full.grst_f.rst_d1_reg 
       (.C(wr_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .PRE(rst),
        .Q(rst_d1));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE #(
    .INIT(1'b1)) 
     \grstd1.grst_full.grst_f.rst_d2_reg 
       (.C(wr_clk),
        .CE(\<const1> ),
        .D(rst_d1),
        .PRE(rst),
        .Q(rst_d2));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE #(
    .INIT(1'b1)) 
     \grstd1.grst_full.grst_f.rst_d3_reg 
       (.C(wr_clk),
        .CE(\<const1> ),
        .D(rst_d2),
        .PRE(rst),
        .Q(rst_d3));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.rd_rst_asreg_d1_reg 
       (.C(rd_clk),
        .CE(\<const1> ),
        .D(rd_rst_asreg),
        .Q(rd_rst_asreg_d1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.rd_rst_asreg_d2_reg 
       (.C(rd_clk),
        .CE(\<const1> ),
        .D(rd_rst_asreg_d1),
        .Q(rd_rst_asreg_d2),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'h2)) 
     \ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1 
       (.I0(rd_rst_asreg),
        .I1(rd_rst_asreg_d1),
        .O(\n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1 ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE \ngwrdrst.grst.g7serrst.rd_rst_asreg_reg 
       (.C(rd_clk),
        .CE(\<const1> ),
        .D(\n_0_ngwrdrst.grst.g7serrst.rd_rst_asreg_i_1 ),
        .PRE(rst),
        .Q(rd_rst_asreg));
LUT2 #(
    .INIT(4'h2)) 
     \ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 
       (.I0(rd_rst_asreg),
        .I1(rd_rst_asreg_d2),
        .O(\n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[0] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ),
        .Q(O1[0]));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[1] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ),
        .Q(O1[1]));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     \ngwrdrst.grst.g7serrst.rd_rst_reg_reg[2] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.rd_rst_reg[2]_i_1 ),
        .Q(O1[2]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.wr_rst_asreg_d1_reg 
       (.C(wr_clk),
        .CE(\<const1> ),
        .D(wr_rst_asreg),
        .Q(wr_rst_asreg_d1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDRE #(
    .INIT(1'b0)) 
     \ngwrdrst.grst.g7serrst.wr_rst_asreg_d2_reg 
       (.C(wr_clk),
        .CE(\<const1> ),
        .D(wr_rst_asreg_d1),
        .Q(wr_rst_asreg_d2),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'h2)) 
     \ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1 
       (.I0(wr_rst_asreg),
        .I1(wr_rst_asreg_d1),
        .O(\n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1 ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDPE \ngwrdrst.grst.g7serrst.wr_rst_asreg_reg 
       (.C(wr_clk),
        .CE(\<const1> ),
        .D(\n_0_ngwrdrst.grst.g7serrst.wr_rst_asreg_i_1 ),
        .PRE(rst),
        .Q(wr_rst_asreg));
LUT2 #(
    .INIT(4'h2)) 
     \ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 
       (.I0(wr_rst_asreg),
        .I1(wr_rst_asreg_d2),
        .O(\n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 ));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[0] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 ),
        .Q(Q[0]));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     \ngwrdrst.grst.g7serrst.wr_rst_reg_reg[1] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .PRE(\n_0_ngwrdrst.grst.g7serrst.wr_rst_reg[1]_i_1 ),
        .Q(Q[1]));
endmodule

module DebugDataFIFOsynchronizer_ff
   (Q,
    I1,
    rd_clk,
    I6);
  output [7:0]Q;
  input [7:0]I1;
  input rd_clk;
  input [0:0]I6;

  wire \<const1> ;
  wire [7:0]I1;
  wire [0:0]I6;
  wire [7:0]Q;
  wire rd_clk;

(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[0] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(I1[0]),
        .Q(Q[0]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[1] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(I1[1]),
        .Q(Q[1]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[2] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(I1[2]),
        .Q(Q[2]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[3] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(I1[3]),
        .Q(Q[3]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[4] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(I1[4]),
        .Q(Q[4]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[5] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(I1[5]),
        .Q(Q[5]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[6] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(I1[6]),
        .Q(Q[6]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[7] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(I1[7]),
        .Q(Q[7]));
VCC VCC
       (.P(\<const1> ));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module DebugDataFIFOsynchronizer_ff_0
   (Q,
    I1,
    wr_clk,
    I7);
  output [7:0]Q;
  input [7:0]I1;
  input wr_clk;
  input [0:0]I7;

  wire \<const1> ;
  wire [7:0]I1;
  wire [0:0]I7;
  wire [7:0]Q;
  wire wr_clk;

(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[0] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(I1[0]),
        .Q(Q[0]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[1] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(I1[1]),
        .Q(Q[1]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[2] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(I1[2]),
        .Q(Q[2]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[3] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(I1[3]),
        .Q(Q[3]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[4] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(I1[4]),
        .Q(Q[4]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[5] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(I1[5]),
        .Q(Q[5]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[6] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(I1[6]),
        .Q(Q[6]));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[7] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(I1[7]),
        .Q(Q[7]));
VCC VCC
       (.P(\<const1> ));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module DebugDataFIFOsynchronizer_ff_1
   (p_0_in,
    D,
    rd_clk,
    I6);
  output [7:0]p_0_in;
  input [7:0]D;
  input rd_clk;
  input [0:0]I6;

  wire \<const1> ;
  wire [7:0]D;
  wire [0:0]I6;
  wire \n_0_Q_reg_reg[0] ;
  wire \n_0_Q_reg_reg[1] ;
  wire \n_0_Q_reg_reg[2] ;
  wire \n_0_Q_reg_reg[3] ;
  wire \n_0_Q_reg_reg[4] ;
  wire \n_0_Q_reg_reg[5] ;
  wire \n_0_Q_reg_reg[6] ;
  wire [7:0]p_0_in;
  wire rd_clk;

(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[0] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(D[0]),
        .Q(\n_0_Q_reg_reg[0] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[1] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(D[1]),
        .Q(\n_0_Q_reg_reg[1] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[2] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(D[2]),
        .Q(\n_0_Q_reg_reg[2] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[3] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(D[3]),
        .Q(\n_0_Q_reg_reg[3] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[4] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(D[4]),
        .Q(\n_0_Q_reg_reg[4] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[5] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(D[5]),
        .Q(\n_0_Q_reg_reg[5] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[6] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(D[6]),
        .Q(\n_0_Q_reg_reg[6] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[7] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(I6),
        .D(D[7]),
        .Q(p_0_in[7]));
VCC VCC
       (.P(\<const1> ));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \wr_pntr_bin[0]_i_1 
       (.I0(\n_0_Q_reg_reg[2] ),
        .I1(\n_0_Q_reg_reg[1] ),
        .I2(\n_0_Q_reg_reg[0] ),
        .I3(p_0_in[3]),
        .O(p_0_in[0]));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT3 #(
    .INIT(8'h96)) 
     \wr_pntr_bin[1]_i_1 
       (.I0(\n_0_Q_reg_reg[1] ),
        .I1(\n_0_Q_reg_reg[2] ),
        .I2(p_0_in[3]),
        .O(p_0_in[1]));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \wr_pntr_bin[2]_i_1 
       (.I0(\n_0_Q_reg_reg[3] ),
        .I1(p_0_in[7]),
        .I2(\n_0_Q_reg_reg[5] ),
        .I3(\n_0_Q_reg_reg[6] ),
        .I4(\n_0_Q_reg_reg[4] ),
        .I5(\n_0_Q_reg_reg[2] ),
        .O(p_0_in[2]));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT5 #(
    .INIT(32'h96696996)) 
     \wr_pntr_bin[3]_i_1 
       (.I0(\n_0_Q_reg_reg[4] ),
        .I1(\n_0_Q_reg_reg[6] ),
        .I2(\n_0_Q_reg_reg[5] ),
        .I3(p_0_in[7]),
        .I4(\n_0_Q_reg_reg[3] ),
        .O(p_0_in[3]));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \wr_pntr_bin[4]_i_1 
       (.I0(p_0_in[7]),
        .I1(\n_0_Q_reg_reg[5] ),
        .I2(\n_0_Q_reg_reg[6] ),
        .I3(\n_0_Q_reg_reg[4] ),
        .O(p_0_in[4]));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT3 #(
    .INIT(8'h96)) 
     \wr_pntr_bin[5]_i_1 
       (.I0(\n_0_Q_reg_reg[6] ),
        .I1(\n_0_Q_reg_reg[5] ),
        .I2(p_0_in[7]),
        .O(p_0_in[5]));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \wr_pntr_bin[6]_i_1 
       (.I0(\n_0_Q_reg_reg[6] ),
        .I1(p_0_in[7]),
        .O(p_0_in[6]));
endmodule

(* ORIG_REF_NAME = "synchronizer_ff" *) 
module DebugDataFIFOsynchronizer_ff_2
   (Q,
    O1,
    D,
    wr_clk,
    I7);
  output [0:0]Q;
  output [6:0]O1;
  input [7:0]D;
  input wr_clk;
  input [0:0]I7;

  wire \<const1> ;
  wire [7:0]D;
  wire [0:0]I7;
  wire [6:0]O1;
  wire [0:0]Q;
  wire \n_0_Q_reg_reg[0] ;
  wire \n_0_Q_reg_reg[1] ;
  wire \n_0_Q_reg_reg[2] ;
  wire \n_0_Q_reg_reg[3] ;
  wire \n_0_Q_reg_reg[4] ;
  wire \n_0_Q_reg_reg[5] ;
  wire \n_0_Q_reg_reg[6] ;
  wire wr_clk;

(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[0] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(D[0]),
        .Q(\n_0_Q_reg_reg[0] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[1] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(D[1]),
        .Q(\n_0_Q_reg_reg[1] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[2] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(D[2]),
        .Q(\n_0_Q_reg_reg[2] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[3] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(D[3]),
        .Q(\n_0_Q_reg_reg[3] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[4] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(D[4]),
        .Q(\n_0_Q_reg_reg[4] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[5] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(D[5]),
        .Q(\n_0_Q_reg_reg[5] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[6] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(D[6]),
        .Q(\n_0_Q_reg_reg[6] ));
(* ASYNC_REG *) 
   (* msgon = "true" *) 
   FDCE #(
    .INIT(1'b0)) 
     \Q_reg_reg[7] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(I7),
        .D(D[7]),
        .Q(Q));
VCC VCC
       (.P(\<const1> ));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \rd_pntr_bin[0]_i_1 
       (.I0(\n_0_Q_reg_reg[2] ),
        .I1(\n_0_Q_reg_reg[1] ),
        .I2(\n_0_Q_reg_reg[0] ),
        .I3(O1[3]),
        .O(O1[0]));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT3 #(
    .INIT(8'h96)) 
     \rd_pntr_bin[1]_i_1 
       (.I0(\n_0_Q_reg_reg[1] ),
        .I1(\n_0_Q_reg_reg[2] ),
        .I2(O1[3]),
        .O(O1[1]));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \rd_pntr_bin[2]_i_1 
       (.I0(\n_0_Q_reg_reg[3] ),
        .I1(Q),
        .I2(\n_0_Q_reg_reg[5] ),
        .I3(\n_0_Q_reg_reg[6] ),
        .I4(\n_0_Q_reg_reg[4] ),
        .I5(\n_0_Q_reg_reg[2] ),
        .O(O1[2]));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT5 #(
    .INIT(32'h96696996)) 
     \rd_pntr_bin[3]_i_1 
       (.I0(\n_0_Q_reg_reg[4] ),
        .I1(\n_0_Q_reg_reg[6] ),
        .I2(\n_0_Q_reg_reg[5] ),
        .I3(Q),
        .I4(\n_0_Q_reg_reg[3] ),
        .O(O1[3]));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \rd_pntr_bin[4]_i_1 
       (.I0(Q),
        .I1(\n_0_Q_reg_reg[5] ),
        .I2(\n_0_Q_reg_reg[6] ),
        .I3(\n_0_Q_reg_reg[4] ),
        .O(O1[4]));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT3 #(
    .INIT(8'h96)) 
     \rd_pntr_bin[5]_i_1 
       (.I0(\n_0_Q_reg_reg[6] ),
        .I1(\n_0_Q_reg_reg[5] ),
        .I2(Q),
        .O(O1[5]));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \rd_pntr_bin[6]_i_1 
       (.I0(\n_0_Q_reg_reg[6] ),
        .I1(Q),
        .O(O1[6]));
endmodule

module DebugDataFIFOwr_bin_cntr
   (O1,
    Q,
    O3,
    O4,
    O2,
    wr_en,
    p_0_out,
    E,
    wr_clk,
    I1);
  output O1;
  output [5:0]Q;
  output [7:0]O3;
  output [7:0]O4;
  input [1:0]O2;
  input wr_en;
  input p_0_out;
  input [0:0]E;
  input wr_clk;
  input [0:0]I1;

  wire [0:0]E;
  wire [0:0]I1;
  wire O1;
  wire [1:0]O2;
  wire [7:0]O3;
  wire [7:0]O4;
  wire [5:0]Q;
  wire \n_0_gic0.gc0.count[7]_i_2 ;
  wire p_0_out;
  wire [7:0]plusOp__0;
  wire wr_clk;
  wire wr_en;
  wire [1:0]wr_pntr_plus2;

(* RETAIN_INVERTER *) 
   (* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \gic0.gc0.count[0]_i_1 
       (.I0(wr_pntr_plus2[0]),
        .O(plusOp__0[0]));
LUT2 #(
    .INIT(4'h6)) 
     \gic0.gc0.count[1]_i_1 
       (.I0(wr_pntr_plus2[0]),
        .I1(wr_pntr_plus2[1]),
        .O(plusOp__0[1]));
(* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \gic0.gc0.count[2]_i_1 
       (.I0(wr_pntr_plus2[0]),
        .I1(wr_pntr_plus2[1]),
        .I2(Q[0]),
        .O(plusOp__0[2]));
(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \gic0.gc0.count[3]_i_1 
       (.I0(wr_pntr_plus2[1]),
        .I1(wr_pntr_plus2[0]),
        .I2(Q[0]),
        .I3(Q[1]),
        .O(plusOp__0[3]));
(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT5 #(
    .INIT(32'h7FFF8000)) 
     \gic0.gc0.count[4]_i_1 
       (.I0(Q[0]),
        .I1(wr_pntr_plus2[0]),
        .I2(wr_pntr_plus2[1]),
        .I3(Q[1]),
        .I4(Q[2]),
        .O(plusOp__0[4]));
LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
     \gic0.gc0.count[5]_i_1 
       (.I0(Q[1]),
        .I1(wr_pntr_plus2[1]),
        .I2(wr_pntr_plus2[0]),
        .I3(Q[0]),
        .I4(Q[2]),
        .I5(Q[3]),
        .O(plusOp__0[5]));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \gic0.gc0.count[6]_i_1 
       (.I0(\n_0_gic0.gc0.count[7]_i_2 ),
        .I1(Q[4]),
        .O(plusOp__0[6]));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \gic0.gc0.count[7]_i_1 
       (.I0(\n_0_gic0.gc0.count[7]_i_2 ),
        .I1(Q[4]),
        .I2(Q[5]),
        .O(plusOp__0[7]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \gic0.gc0.count[7]_i_2 
       (.I0(Q[3]),
        .I1(Q[1]),
        .I2(wr_pntr_plus2[1]),
        .I3(wr_pntr_plus2[0]),
        .I4(Q[0]),
        .I5(Q[2]),
        .O(\n_0_gic0.gc0.count[7]_i_2 ));
FDPE #(
    .INIT(1'b1)) 
     \gic0.gc0.count_d1_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .D(wr_pntr_plus2[0]),
        .PRE(I1),
        .Q(O3[0]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(wr_pntr_plus2[1]),
        .Q(O3[1]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(Q[0]),
        .Q(O3[2]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(Q[1]),
        .Q(O3[3]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(Q[2]),
        .Q(O3[4]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[5] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(Q[3]),
        .Q(O3[5]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[6] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(Q[4]),
        .Q(O3[6]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d1_reg[7] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(Q[5]),
        .Q(O3[7]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O3[0]),
        .Q(O4[0]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O3[1]),
        .Q(O4[1]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O3[2]),
        .Q(O4[2]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O3[3]),
        .Q(O4[3]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O3[4]),
        .Q(O4[4]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[5] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O3[5]),
        .Q(O4[5]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[6] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O3[6]),
        .Q(O4[6]));
FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_d2_reg[7] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(O3[7]),
        .Q(O4[7]));
(* counter = "3" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__0[0]),
        .Q(wr_pntr_plus2[0]));
(* counter = "3" *) 
   FDPE #(
    .INIT(1'b1)) 
     \gic0.gc0.count_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .D(plusOp__0[1]),
        .PRE(I1),
        .Q(wr_pntr_plus2[1]));
(* counter = "3" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__0[2]),
        .Q(Q[0]));
(* counter = "3" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__0[3]),
        .Q(Q[1]));
(* counter = "3" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[4] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__0[4]),
        .Q(Q[2]));
(* counter = "3" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[5] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__0[5]),
        .Q(Q[3]));
(* counter = "3" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[6] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__0[6]),
        .Q(Q[4]));
(* counter = "3" *) 
   FDCE #(
    .INIT(1'b0)) 
     \gic0.gc0.count_reg[7] 
       (.C(wr_clk),
        .CE(E),
        .CLR(I1),
        .D(plusOp__0[7]),
        .Q(Q[5]));
LUT6 #(
    .INIT(64'h0090000000000090)) 
     ram_full_i_i_3
       (.I0(O2[0]),
        .I1(wr_pntr_plus2[0]),
        .I2(wr_en),
        .I3(p_0_out),
        .I4(wr_pntr_plus2[1]),
        .I5(O2[1]),
        .O(O1));
endmodule

module DebugDataFIFOwr_logic
   (full,
    O1,
    Q,
    E,
    O3,
    O4,
    ram_full_i,
    wr_clk,
    rst_d2,
    O2,
    wr_en,
    I1);
  output full;
  output O1;
  output [5:0]Q;
  output [0:0]E;
  output [7:0]O3;
  output [7:0]O4;
  input ram_full_i;
  input wr_clk;
  input rst_d2;
  input [1:0]O2;
  input wr_en;
  input [0:0]I1;

  wire [0:0]E;
  wire [0:0]I1;
  wire O1;
  wire [1:0]O2;
  wire [7:0]O3;
  wire [7:0]O4;
  wire [5:0]Q;
  wire full;
  wire p_0_out;
  wire ram_full_i;
  wire rst_d2;
  wire wr_clk;
  wire wr_en;

DebugDataFIFOwr_status_flags_as \gwas.wsts 
       (.E(E),
        .full(full),
        .p_0_out(p_0_out),
        .ram_full_i(ram_full_i),
        .rst_d2(rst_d2),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
DebugDataFIFOwr_bin_cntr wpntr
       (.E(E),
        .I1(I1),
        .O1(O1),
        .O2(O2),
        .O3(O3),
        .O4(O4),
        .Q(Q),
        .p_0_out(p_0_out),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

module DebugDataFIFOwr_status_flags_as
   (full,
    p_0_out,
    E,
    ram_full_i,
    wr_clk,
    rst_d2,
    wr_en);
  output full;
  output p_0_out;
  output [0:0]E;
  input ram_full_i;
  input wr_clk;
  input rst_d2;
  input wr_en;

  wire \<const1> ;
  wire [0:0]E;
  wire full;
  wire p_0_out;
  wire ram_full_i;
  wire rst_d2;
  wire wr_clk;
  wire wr_en;

LUT2 #(
    .INIT(4'h2)) 
     \DEVICE_7SERIES.NO_BMM_INFO.SDP.WIDE_PRIM18.ram_i_2 
       (.I0(wr_en),
        .I1(p_0_out),
        .O(E));
VCC VCC
       (.P(\<const1> ));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     ram_full_fb_i_reg
       (.C(wr_clk),
        .CE(\<const1> ),
        .D(ram_full_i),
        .PRE(rst_d2),
        .Q(p_0_out));
(* equivalent_register_removal = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     ram_full_i_reg
       (.C(wr_clk),
        .CE(\<const1> ),
        .D(ram_full_i),
        .PRE(rst_d2),
        .Q(full));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
