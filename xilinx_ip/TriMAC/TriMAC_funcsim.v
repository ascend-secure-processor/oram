// Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
// Date        : Sat May 10 09:55:44 2014
// Host        : sinister running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               c:/chip/vc707_newproj/vc707_newproj.srcs/sources_1/ip/TriMAC/TriMAC_funcsim.v
// Design      : TriMAC
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "TriMAC,tri_mode_ethernet_mac_v8_1,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=tri_mode_ethernet_mac,x_ipVersion=8.1,x_ipCoreRevision=0,x_ipLanguage=VERILOG,x_ipLicense=tri_mode_eth_mac@2013.12(design_linking),x_ipLicense=10_100_mb_eth_mac@2013.12(design_linking),x_ipLicense=eth_avb_endpoint@2013.12(design_linking),c_component_name=TriMAC,c_physical_interface=RGMII,c_half_duplex=false,c_has_host=false,c_add_filter=true,c_at_entries=0,c_family=virtex7,c_mac_speed=TRI_SPEED,c_has_stats=false,c_num_stats=34,c_cntr_rst=true,c_stats_width=64,c_avb=false,c_1588=0,c_tx_tuser_width=1,c_rx_vec_width=79,c_tx_vec_width=79,c_addr_width=12,c_pfc=false}" *) (* X_CORE_INFO = "TriMAC_block,Vivado 2013.3.0" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* NotValidForBitStream *)
module TriMAC
   (gtx_clk,
    glbl_rstn,
    rx_axi_rstn,
    tx_axi_rstn,
    rx_enable,
    rx_statistics_vector,
    rx_statistics_valid,
    rx_mac_aclk,
    rx_reset,
    rx_axis_mac_tdata,
    rx_axis_mac_tvalid,
    rx_axis_mac_tlast,
    rx_axis_mac_tuser,
    tx_enable,
    tx_ifg_delay,
    tx_statistics_vector,
    tx_statistics_valid,
    tx_mac_aclk,
    tx_reset,
    tx_axis_mac_tdata,
    tx_axis_mac_tvalid,
    tx_axis_mac_tlast,
    tx_axis_mac_tuser,
    tx_axis_mac_tready,
    pause_req,
    pause_val,
    speedis100,
    speedis10100,
    rgmii_txd,
    rgmii_tx_ctl,
    rgmii_txc,
    rgmii_rxd,
    rgmii_rx_ctl,
    rgmii_rxc,
    inband_link_status,
    inband_clock_speed,
    inband_duplex_status,
    rx_configuration_vector,
    tx_configuration_vector);
  input gtx_clk;
  input glbl_rstn;
  input rx_axi_rstn;
  input tx_axi_rstn;
  output rx_enable;
  output [27:0]rx_statistics_vector;
  output rx_statistics_valid;
  output rx_mac_aclk;
  output rx_reset;
  output [7:0]rx_axis_mac_tdata;
  output rx_axis_mac_tvalid;
  output rx_axis_mac_tlast;
  output rx_axis_mac_tuser;
  output tx_enable;
  input [7:0]tx_ifg_delay;
  output [31:0]tx_statistics_vector;
  output tx_statistics_valid;
  output tx_mac_aclk;
  output tx_reset;
  input [7:0]tx_axis_mac_tdata;
  input tx_axis_mac_tvalid;
  input tx_axis_mac_tlast;
  input tx_axis_mac_tuser;
  output tx_axis_mac_tready;
  input pause_req;
  input [15:0]pause_val;
  output speedis100;
  output speedis10100;
  output [3:0]rgmii_txd;
  output rgmii_tx_ctl;
  output rgmii_txc;
  input [3:0]rgmii_rxd;
  input rgmii_rx_ctl;
  input rgmii_rxc;
  output inband_link_status;
  output [1:0]inband_clock_speed;
  output inband_duplex_status;
  input [79:0]rx_configuration_vector;
  input [79:0]tx_configuration_vector;

  wire glbl_rstn;
  wire gtx_clk;
  wire [1:0]inband_clock_speed;
  wire inband_duplex_status;
  wire inband_link_status;
  wire pause_req;
  wire [15:0]pause_val;
(* IBUF_LOW_PWR *)   wire rgmii_rx_ctl;
(* IBUF_LOW_PWR *)   wire rgmii_rxc;
(* IBUF_LOW_PWR *)   wire [3:0]rgmii_rxd;
(* DRIVE = "12" *)   wire rgmii_tx_ctl;
(* DRIVE = "12" *)   wire rgmii_txc;
(* DRIVE = "12" *)   wire [3:0]rgmii_txd;
  wire rx_axi_rstn;
  wire [7:0]rx_axis_mac_tdata;
  wire rx_axis_mac_tlast;
  wire rx_axis_mac_tuser;
  wire rx_axis_mac_tvalid;
  wire [79:0]rx_configuration_vector;
  wire rx_enable;
  wire rx_mac_aclk;
  wire rx_reset;
  wire rx_statistics_valid;
  wire [27:0]rx_statistics_vector;
  wire speedis100;
  wire speedis10100;
  wire tx_axi_rstn;
  wire [7:0]tx_axis_mac_tdata;
  wire tx_axis_mac_tlast;
  wire tx_axis_mac_tready;
  wire tx_axis_mac_tuser;
  wire tx_axis_mac_tvalid;
  wire [79:0]tx_configuration_vector;
  wire tx_enable;
  wire [7:0]tx_ifg_delay;
  wire tx_mac_aclk;
  wire tx_reset;
  wire tx_statistics_valid;
  wire [31:0]tx_statistics_vector;

TriMACTriMAC_block inst
       (.glbl_rstn(glbl_rstn),
        .gtx_clk(gtx_clk),
        .inband_clock_speed(inband_clock_speed),
        .inband_duplex_status(inband_duplex_status),
        .inband_link_status(inband_link_status),
        .pause_req(pause_req),
        .pause_val(pause_val),
        .rgmii_rx_ctl(rgmii_rx_ctl),
        .rgmii_rxc(rgmii_rxc),
        .rgmii_rxd(rgmii_rxd),
        .rgmii_tx_ctl(rgmii_tx_ctl),
        .rgmii_txc(rgmii_txc),
        .rgmii_txd(rgmii_txd),
        .rx_axi_rstn(rx_axi_rstn),
        .rx_axis_mac_tdata(rx_axis_mac_tdata),
        .rx_axis_mac_tlast(rx_axis_mac_tlast),
        .rx_axis_mac_tuser(rx_axis_mac_tuser),
        .rx_axis_mac_tvalid(rx_axis_mac_tvalid),
        .rx_configuration_vector(rx_configuration_vector),
        .rx_enable(rx_enable),
        .rx_mac_aclk(rx_mac_aclk),
        .rx_reset(rx_reset),
        .rx_statistics_valid(rx_statistics_valid),
        .rx_statistics_vector(rx_statistics_vector),
        .speedis100(speedis100),
        .speedis10100(speedis10100),
        .tx_axi_rstn(tx_axi_rstn),
        .tx_axis_mac_tdata(tx_axis_mac_tdata),
        .tx_axis_mac_tlast(tx_axis_mac_tlast),
        .tx_axis_mac_tready(tx_axis_mac_tready),
        .tx_axis_mac_tuser(tx_axis_mac_tuser),
        .tx_axis_mac_tvalid(tx_axis_mac_tvalid),
        .tx_configuration_vector(tx_configuration_vector),
        .tx_enable(tx_enable),
        .tx_ifg_delay(tx_ifg_delay),
        .tx_mac_aclk(tx_mac_aclk),
        .tx_reset(tx_reset),
        .tx_statistics_valid(tx_statistics_valid),
        .tx_statistics_vector(tx_statistics_vector));
endmodule

module TriMACCC2CE
   (CEO,
    CE,
    I1);
  output CEO;
  input CE;
  input I1;

  wire \<const0> ;
  wire C0;
  wire C1;
  wire CE;
  wire CEO;
  wire I1;
  wire TQ0;
  wire TQ1;
  wire X36_1N12;
  wire lopt;
  wire n_0_X36_1I298;
  wire n_0_X36_1I35;
  wire n_0_X36_1I36;
  wire [3:2]NLW_X36_1I4_CARRY4_CO_UNCONNECTED;
  wire [3:2]NLW_X36_1I4_CARRY4_DI_UNCONNECTED;
  wire [3:2]NLW_X36_1I4_CARRY4_O_UNCONNECTED;
  wire [3:2]NLW_X36_1I4_CARRY4_S_UNCONNECTED;

GND GND
       (.G(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I35
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ1),
        .Q(n_0_X36_1I35));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ0),
        .Q(n_0_X36_1I36));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({NLW_X36_1I4_CARRY4_CO_UNCONNECTED[3:2],n_0_X36_1I298,C1}),
        .CYINIT(C0),
        .DI({NLW_X36_1I4_CARRY4_DI_UNCONNECTED[3:2],X36_1N12,X36_1N12}),
        .O({NLW_X36_1I4_CARRY4_O_UNCONNECTED[3:2],TQ1,TQ0}),
        .S({NLW_X36_1I4_CARRY4_S_UNCONNECTED[3:2],n_0_X36_1I35,n_0_X36_1I36}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   GND X36_1I886
       (.G(X36_1N12));
(* BOX_TYPE = "PRIMITIVE" *) 
   VCC X36_1I923
       (.P(C0));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(CE),
        .I1(n_0_X36_1I298),
        .O(CEO));
endmodule

(* ORIG_REF_NAME = "CC2CE" *) 
module TriMACCC2CE_20
   (CEO,
    CE,
    gtx_clk);
  output CEO;
  input CE;
  input gtx_clk;

  wire \<const0> ;
  wire C0;
  wire C1;
  wire CE;
  wire CEO;
  wire TQ0;
  wire TQ1;
  wire X36_1N12;
  wire gtx_clk;
  wire lopt;
  wire n_0_X36_1I298;
  wire n_0_X36_1I35;
  wire n_0_X36_1I36;
  wire [3:2]NLW_X36_1I4_CARRY4_CO_UNCONNECTED;
  wire [3:2]NLW_X36_1I4_CARRY4_DI_UNCONNECTED;
  wire [3:2]NLW_X36_1I4_CARRY4_O_UNCONNECTED;
  wire [3:2]NLW_X36_1I4_CARRY4_S_UNCONNECTED;

GND GND
       (.G(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I35
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ1),
        .Q(n_0_X36_1I35));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ0),
        .Q(n_0_X36_1I36));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({NLW_X36_1I4_CARRY4_CO_UNCONNECTED[3:2],n_0_X36_1I298,C1}),
        .CYINIT(C0),
        .DI({NLW_X36_1I4_CARRY4_DI_UNCONNECTED[3:2],X36_1N12,X36_1N12}),
        .O({NLW_X36_1I4_CARRY4_O_UNCONNECTED[3:2],TQ1,TQ0}),
        .S({NLW_X36_1I4_CARRY4_S_UNCONNECTED[3:2],n_0_X36_1I35,n_0_X36_1I36}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   GND X36_1I886
       (.G(X36_1N12));
(* BOX_TYPE = "PRIMITIVE" *) 
   VCC X36_1I923
       (.P(C0));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(CE),
        .I1(n_0_X36_1I298),
        .O(CEO));
endmodule

module TriMACCC8CE
   (CEO,
    CRC1000_EN,
    SPEED_1_RESYNC_REG,
    CRC50_EN,
    SPEED_0_RESYNC_REG,
    I2,
    I1);
  output CEO;
  input CRC1000_EN;
  input SPEED_1_RESYNC_REG;
  input CRC50_EN;
  input SPEED_0_RESYNC_REG;
  input I2;
  input I1;

  wire \<const0> ;
  wire C0;
  wire C1;
  wire C2;
  wire C3;
  wire C4;
  wire C5;
  wire C6;
  wire C7;
  wire CEO;
  wire CRC1000_EN;
  wire CRC50_EN;
  wire I1;
  wire I2;
  wire SPEED_0_RESYNC_REG;
  wire SPEED_1_RESYNC_REG;
  wire TQ0;
  wire TQ1;
  wire TQ2;
  wire TQ3;
  wire TQ4;
  wire TQ5;
  wire TQ6;
  wire TQ7;
  wire X36_1N12;
  wire lopt;
  wire lopt_1;
  wire n_0_X36_1I224;
  wire n_0_X36_1I237;
  wire n_0_X36_1I250;
  wire n_0_X36_1I263;
  wire n_0_X36_1I263_i_1__0;
  wire n_0_X36_1I276;
  wire n_0_X36_1I289;
  wire n_0_X36_1I298;
  wire n_0_X36_1I35;
  wire n_0_X36_1I36;

GND GND
       (.G(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I224
       (.C(I1),
        .CE(n_0_X36_1I263_i_1__0),
        .CLR(\<const0> ),
        .D(TQ2),
        .Q(n_0_X36_1I224));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I237
       (.C(I1),
        .CE(n_0_X36_1I263_i_1__0),
        .CLR(\<const0> ),
        .D(TQ3),
        .Q(n_0_X36_1I237));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I250
       (.C(I1),
        .CE(n_0_X36_1I263_i_1__0),
        .CLR(\<const0> ),
        .D(TQ4),
        .Q(n_0_X36_1I250));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I259_CARRY4
       (.CI(C4),
        .CO({n_0_X36_1I298,C7,C6,C5}),
        .CYINIT(lopt_1),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ7,TQ6,TQ5,TQ4}),
        .S({n_0_X36_1I289,n_0_X36_1I276,n_0_X36_1I263,n_0_X36_1I250}));
GND X36_1I259_CARRY4_GND
       (.G(lopt_1));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I263
       (.C(I1),
        .CE(n_0_X36_1I263_i_1__0),
        .CLR(\<const0> ),
        .D(TQ5),
        .Q(n_0_X36_1I263));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     X36_1I263_i_1__0
       (.I0(CRC1000_EN),
        .I1(SPEED_1_RESYNC_REG),
        .I2(CRC50_EN),
        .I3(SPEED_0_RESYNC_REG),
        .I4(I2),
        .O(n_0_X36_1I263_i_1__0));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I276
       (.C(I1),
        .CE(n_0_X36_1I263_i_1__0),
        .CLR(\<const0> ),
        .D(TQ6),
        .Q(n_0_X36_1I276));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I289
       (.C(I1),
        .CE(n_0_X36_1I263_i_1__0),
        .CLR(\<const0> ),
        .D(TQ7),
        .Q(n_0_X36_1I289));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I35
       (.C(I1),
        .CE(n_0_X36_1I263_i_1__0),
        .CLR(\<const0> ),
        .D(TQ1),
        .Q(n_0_X36_1I35));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(I1),
        .CE(n_0_X36_1I263_i_1__0),
        .CLR(\<const0> ),
        .D(TQ0),
        .Q(n_0_X36_1I36));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({C4,C3,C2,C1}),
        .CYINIT(C0),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ3,TQ2,TQ1,TQ0}),
        .S({n_0_X36_1I237,n_0_X36_1I224,n_0_X36_1I35,n_0_X36_1I36}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   GND X36_1I886
       (.G(X36_1N12));
(* BOX_TYPE = "PRIMITIVE" *) 
   VCC X36_1I923
       (.P(C0));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(n_0_X36_1I263_i_1__0),
        .I1(n_0_X36_1I298),
        .O(CEO));
endmodule

(* ORIG_REF_NAME = "CC8CE" *) 
module TriMACCC8CE_10
   (CEO,
    CE,
    I1);
  output CEO;
  input CE;
  input I1;

  wire \<const0> ;
  wire C0;
  wire C1;
  wire C2;
  wire C3;
  wire C4;
  wire C5;
  wire C6;
  wire C7;
  wire CE;
  wire CEO;
  wire I1;
  wire TQ0;
  wire TQ1;
  wire TQ2;
  wire TQ3;
  wire TQ4;
  wire TQ5;
  wire TQ6;
  wire TQ7;
  wire X36_1N12;
  wire lopt;
  wire lopt_1;
  wire n_0_X36_1I224;
  wire n_0_X36_1I237;
  wire n_0_X36_1I250;
  wire n_0_X36_1I263;
  wire n_0_X36_1I276;
  wire n_0_X36_1I289;
  wire n_0_X36_1I298;
  wire n_0_X36_1I35;
  wire n_0_X36_1I36;

GND GND
       (.G(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I224
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ2),
        .Q(n_0_X36_1I224));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I237
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ3),
        .Q(n_0_X36_1I237));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I250
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ4),
        .Q(n_0_X36_1I250));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I259_CARRY4
       (.CI(C4),
        .CO({n_0_X36_1I298,C7,C6,C5}),
        .CYINIT(lopt_1),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ7,TQ6,TQ5,TQ4}),
        .S({n_0_X36_1I289,n_0_X36_1I276,n_0_X36_1I263,n_0_X36_1I250}));
GND X36_1I259_CARRY4_GND
       (.G(lopt_1));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I263
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ5),
        .Q(n_0_X36_1I263));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I276
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ6),
        .Q(n_0_X36_1I276));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I289
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ7),
        .Q(n_0_X36_1I289));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I35
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ1),
        .Q(n_0_X36_1I35));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ0),
        .Q(n_0_X36_1I36));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({C4,C3,C2,C1}),
        .CYINIT(C0),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ3,TQ2,TQ1,TQ0}),
        .S({n_0_X36_1I237,n_0_X36_1I224,n_0_X36_1I35,n_0_X36_1I36}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   GND X36_1I886
       (.G(X36_1N12));
(* BOX_TYPE = "PRIMITIVE" *) 
   VCC X36_1I923
       (.P(C0));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(CE),
        .I1(n_0_X36_1I298),
        .O(CEO));
endmodule

(* ORIG_REF_NAME = "CC8CE" *) 
module TriMACCC8CE_16
   (CEO,
    CRC1000_EN,
    SPEED_1_RESYNC_REG,
    CRC50_EN,
    SPEED_0_RESYNC_REG,
    tx_ce_sample,
    gtx_clk);
  output CEO;
  input CRC1000_EN;
  input SPEED_1_RESYNC_REG;
  input CRC50_EN;
  input SPEED_0_RESYNC_REG;
  input tx_ce_sample;
  input gtx_clk;

  wire \<const0> ;
  wire C0;
  wire C1;
  wire C2;
  wire C3;
  wire C4;
  wire C5;
  wire C6;
  wire C7;
  wire CEO;
  wire CRC1000_EN;
  wire CRC50_EN;
  wire SPEED_0_RESYNC_REG;
  wire SPEED_1_RESYNC_REG;
  wire TQ0;
  wire TQ1;
  wire TQ2;
  wire TQ3;
  wire TQ4;
  wire TQ5;
  wire TQ6;
  wire TQ7;
  wire X36_1N12;
  wire gtx_clk;
  wire lopt;
  wire lopt_1;
  wire n_0_X36_1I224;
  wire n_0_X36_1I237;
  wire n_0_X36_1I250;
  wire n_0_X36_1I263;
  wire n_0_X36_1I263_i_1;
  wire n_0_X36_1I276;
  wire n_0_X36_1I289;
  wire n_0_X36_1I298;
  wire n_0_X36_1I35;
  wire n_0_X36_1I36;
  wire tx_ce_sample;

GND GND
       (.G(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I224
       (.C(gtx_clk),
        .CE(n_0_X36_1I263_i_1),
        .CLR(\<const0> ),
        .D(TQ2),
        .Q(n_0_X36_1I224));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I237
       (.C(gtx_clk),
        .CE(n_0_X36_1I263_i_1),
        .CLR(\<const0> ),
        .D(TQ3),
        .Q(n_0_X36_1I237));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I250
       (.C(gtx_clk),
        .CE(n_0_X36_1I263_i_1),
        .CLR(\<const0> ),
        .D(TQ4),
        .Q(n_0_X36_1I250));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I259_CARRY4
       (.CI(C4),
        .CO({n_0_X36_1I298,C7,C6,C5}),
        .CYINIT(lopt_1),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ7,TQ6,TQ5,TQ4}),
        .S({n_0_X36_1I289,n_0_X36_1I276,n_0_X36_1I263,n_0_X36_1I250}));
GND X36_1I259_CARRY4_GND
       (.G(lopt_1));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I263
       (.C(gtx_clk),
        .CE(n_0_X36_1I263_i_1),
        .CLR(\<const0> ),
        .D(TQ5),
        .Q(n_0_X36_1I263));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     X36_1I263_i_1
       (.I0(CRC1000_EN),
        .I1(SPEED_1_RESYNC_REG),
        .I2(CRC50_EN),
        .I3(SPEED_0_RESYNC_REG),
        .I4(tx_ce_sample),
        .O(n_0_X36_1I263_i_1));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I276
       (.C(gtx_clk),
        .CE(n_0_X36_1I263_i_1),
        .CLR(\<const0> ),
        .D(TQ6),
        .Q(n_0_X36_1I276));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I289
       (.C(gtx_clk),
        .CE(n_0_X36_1I263_i_1),
        .CLR(\<const0> ),
        .D(TQ7),
        .Q(n_0_X36_1I289));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I35
       (.C(gtx_clk),
        .CE(n_0_X36_1I263_i_1),
        .CLR(\<const0> ),
        .D(TQ1),
        .Q(n_0_X36_1I35));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(gtx_clk),
        .CE(n_0_X36_1I263_i_1),
        .CLR(\<const0> ),
        .D(TQ0),
        .Q(n_0_X36_1I36));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({C4,C3,C2,C1}),
        .CYINIT(C0),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ3,TQ2,TQ1,TQ0}),
        .S({n_0_X36_1I237,n_0_X36_1I224,n_0_X36_1I35,n_0_X36_1I36}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   GND X36_1I886
       (.G(X36_1N12));
(* BOX_TYPE = "PRIMITIVE" *) 
   VCC X36_1I923
       (.P(C0));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(n_0_X36_1I263_i_1),
        .I1(n_0_X36_1I298),
        .O(CEO));
endmodule

(* ORIG_REF_NAME = "CC8CE" *) 
module TriMACCC8CE_17
   (CEO,
    CE,
    gtx_clk);
  output CEO;
  input CE;
  input gtx_clk;

  wire \<const0> ;
  wire C0;
  wire C1;
  wire C2;
  wire C3;
  wire C4;
  wire C5;
  wire C6;
  wire C7;
  wire CE;
  wire CEO;
  wire TQ0;
  wire TQ1;
  wire TQ2;
  wire TQ3;
  wire TQ4;
  wire TQ5;
  wire TQ6;
  wire TQ7;
  wire X36_1N12;
  wire gtx_clk;
  wire lopt;
  wire lopt_1;
  wire n_0_X36_1I224;
  wire n_0_X36_1I237;
  wire n_0_X36_1I250;
  wire n_0_X36_1I263;
  wire n_0_X36_1I276;
  wire n_0_X36_1I289;
  wire n_0_X36_1I298;
  wire n_0_X36_1I35;
  wire n_0_X36_1I36;

GND GND
       (.G(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I224
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ2),
        .Q(n_0_X36_1I224));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I237
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ3),
        .Q(n_0_X36_1I237));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I250
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ4),
        .Q(n_0_X36_1I250));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I259_CARRY4
       (.CI(C4),
        .CO({n_0_X36_1I298,C7,C6,C5}),
        .CYINIT(lopt_1),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ7,TQ6,TQ5,TQ4}),
        .S({n_0_X36_1I289,n_0_X36_1I276,n_0_X36_1I263,n_0_X36_1I250}));
GND X36_1I259_CARRY4_GND
       (.G(lopt_1));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I263
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ5),
        .Q(n_0_X36_1I263));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I276
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ6),
        .Q(n_0_X36_1I276));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I289
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ7),
        .Q(n_0_X36_1I289));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I35
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ1),
        .Q(n_0_X36_1I35));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ0),
        .Q(n_0_X36_1I36));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({C4,C3,C2,C1}),
        .CYINIT(C0),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ3,TQ2,TQ1,TQ0}),
        .S({n_0_X36_1I237,n_0_X36_1I224,n_0_X36_1I35,n_0_X36_1I36}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   GND X36_1I886
       (.G(X36_1N12));
(* BOX_TYPE = "PRIMITIVE" *) 
   VCC X36_1I923
       (.P(C0));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(CE),
        .I1(n_0_X36_1I298),
        .O(CEO));
endmodule

(* ORIG_REF_NAME = "CC8CE" *) 
module TriMACCC8CE_18
   (CEO,
    CE,
    gtx_clk);
  output CEO;
  input CE;
  input gtx_clk;

  wire \<const0> ;
  wire C0;
  wire C1;
  wire C2;
  wire C3;
  wire C4;
  wire C5;
  wire C6;
  wire C7;
  wire CE;
  wire CEO;
  wire TQ0;
  wire TQ1;
  wire TQ2;
  wire TQ3;
  wire TQ4;
  wire TQ5;
  wire TQ6;
  wire TQ7;
  wire X36_1N12;
  wire gtx_clk;
  wire lopt;
  wire lopt_1;
  wire n_0_X36_1I224;
  wire n_0_X36_1I237;
  wire n_0_X36_1I250;
  wire n_0_X36_1I263;
  wire n_0_X36_1I276;
  wire n_0_X36_1I289;
  wire n_0_X36_1I298;
  wire n_0_X36_1I35;
  wire n_0_X36_1I36;

GND GND
       (.G(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I224
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ2),
        .Q(n_0_X36_1I224));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I237
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ3),
        .Q(n_0_X36_1I237));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I250
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ4),
        .Q(n_0_X36_1I250));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I259_CARRY4
       (.CI(C4),
        .CO({n_0_X36_1I298,C7,C6,C5}),
        .CYINIT(lopt_1),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ7,TQ6,TQ5,TQ4}),
        .S({n_0_X36_1I289,n_0_X36_1I276,n_0_X36_1I263,n_0_X36_1I250}));
GND X36_1I259_CARRY4_GND
       (.G(lopt_1));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I263
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ5),
        .Q(n_0_X36_1I263));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I276
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ6),
        .Q(n_0_X36_1I276));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I289
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ7),
        .Q(n_0_X36_1I289));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I35
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ1),
        .Q(n_0_X36_1I35));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ0),
        .Q(n_0_X36_1I36));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({C4,C3,C2,C1}),
        .CYINIT(C0),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ3,TQ2,TQ1,TQ0}),
        .S({n_0_X36_1I237,n_0_X36_1I224,n_0_X36_1I35,n_0_X36_1I36}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   GND X36_1I886
       (.G(X36_1N12));
(* BOX_TYPE = "PRIMITIVE" *) 
   VCC X36_1I923
       (.P(C0));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(CE),
        .I1(n_0_X36_1I298),
        .O(CEO));
endmodule

(* ORIG_REF_NAME = "CC8CE" *) 
module TriMACCC8CE_19
   (CEO,
    CE,
    gtx_clk);
  output CEO;
  input CE;
  input gtx_clk;

  wire \<const0> ;
  wire C0;
  wire C1;
  wire C2;
  wire C3;
  wire C4;
  wire C5;
  wire C6;
  wire C7;
  wire CE;
  wire CEO;
  wire TQ0;
  wire TQ1;
  wire TQ2;
  wire TQ3;
  wire TQ4;
  wire TQ5;
  wire TQ6;
  wire TQ7;
  wire X36_1N12;
  wire gtx_clk;
  wire lopt;
  wire lopt_1;
  wire n_0_X36_1I224;
  wire n_0_X36_1I237;
  wire n_0_X36_1I250;
  wire n_0_X36_1I263;
  wire n_0_X36_1I276;
  wire n_0_X36_1I289;
  wire n_0_X36_1I298;
  wire n_0_X36_1I35;
  wire n_0_X36_1I36;

GND GND
       (.G(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I224
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ2),
        .Q(n_0_X36_1I224));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I237
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ3),
        .Q(n_0_X36_1I237));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I250
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ4),
        .Q(n_0_X36_1I250));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I259_CARRY4
       (.CI(C4),
        .CO({n_0_X36_1I298,C7,C6,C5}),
        .CYINIT(lopt_1),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ7,TQ6,TQ5,TQ4}),
        .S({n_0_X36_1I289,n_0_X36_1I276,n_0_X36_1I263,n_0_X36_1I250}));
GND X36_1I259_CARRY4_GND
       (.G(lopt_1));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I263
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ5),
        .Q(n_0_X36_1I263));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I276
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ6),
        .Q(n_0_X36_1I276));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I289
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ7),
        .Q(n_0_X36_1I289));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I35
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ1),
        .Q(n_0_X36_1I35));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(gtx_clk),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ0),
        .Q(n_0_X36_1I36));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({C4,C3,C2,C1}),
        .CYINIT(C0),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ3,TQ2,TQ1,TQ0}),
        .S({n_0_X36_1I237,n_0_X36_1I224,n_0_X36_1I35,n_0_X36_1I36}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   GND X36_1I886
       (.G(X36_1N12));
(* BOX_TYPE = "PRIMITIVE" *) 
   VCC X36_1I923
       (.P(C0));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(CE),
        .I1(n_0_X36_1I298),
        .O(CEO));
endmodule

(* ORIG_REF_NAME = "CC8CE" *) 
module TriMACCC8CE_8
   (CEO,
    CE,
    I1);
  output CEO;
  input CE;
  input I1;

  wire \<const0> ;
  wire C0;
  wire C1;
  wire C2;
  wire C3;
  wire C4;
  wire C5;
  wire C6;
  wire C7;
  wire CE;
  wire CEO;
  wire I1;
  wire TQ0;
  wire TQ1;
  wire TQ2;
  wire TQ3;
  wire TQ4;
  wire TQ5;
  wire TQ6;
  wire TQ7;
  wire X36_1N12;
  wire lopt;
  wire lopt_1;
  wire n_0_X36_1I224;
  wire n_0_X36_1I237;
  wire n_0_X36_1I250;
  wire n_0_X36_1I263;
  wire n_0_X36_1I276;
  wire n_0_X36_1I289;
  wire n_0_X36_1I298;
  wire n_0_X36_1I35;
  wire n_0_X36_1I36;

GND GND
       (.G(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I224
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ2),
        .Q(n_0_X36_1I224));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I237
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ3),
        .Q(n_0_X36_1I237));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I250
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ4),
        .Q(n_0_X36_1I250));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I259_CARRY4
       (.CI(C4),
        .CO({n_0_X36_1I298,C7,C6,C5}),
        .CYINIT(lopt_1),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ7,TQ6,TQ5,TQ4}),
        .S({n_0_X36_1I289,n_0_X36_1I276,n_0_X36_1I263,n_0_X36_1I250}));
GND X36_1I259_CARRY4_GND
       (.G(lopt_1));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I263
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ5),
        .Q(n_0_X36_1I263));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I276
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ6),
        .Q(n_0_X36_1I276));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I289
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ7),
        .Q(n_0_X36_1I289));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I35
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ1),
        .Q(n_0_X36_1I35));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ0),
        .Q(n_0_X36_1I36));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({C4,C3,C2,C1}),
        .CYINIT(C0),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ3,TQ2,TQ1,TQ0}),
        .S({n_0_X36_1I237,n_0_X36_1I224,n_0_X36_1I35,n_0_X36_1I36}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   GND X36_1I886
       (.G(X36_1N12));
(* BOX_TYPE = "PRIMITIVE" *) 
   VCC X36_1I923
       (.P(C0));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(CE),
        .I1(n_0_X36_1I298),
        .O(CEO));
endmodule

(* ORIG_REF_NAME = "CC8CE" *) 
module TriMACCC8CE_9
   (CEO,
    CE,
    I1);
  output CEO;
  input CE;
  input I1;

  wire \<const0> ;
  wire C0;
  wire C1;
  wire C2;
  wire C3;
  wire C4;
  wire C5;
  wire C6;
  wire C7;
  wire CE;
  wire CEO;
  wire I1;
  wire TQ0;
  wire TQ1;
  wire TQ2;
  wire TQ3;
  wire TQ4;
  wire TQ5;
  wire TQ6;
  wire TQ7;
  wire X36_1N12;
  wire lopt;
  wire lopt_1;
  wire n_0_X36_1I224;
  wire n_0_X36_1I237;
  wire n_0_X36_1I250;
  wire n_0_X36_1I263;
  wire n_0_X36_1I276;
  wire n_0_X36_1I289;
  wire n_0_X36_1I298;
  wire n_0_X36_1I35;
  wire n_0_X36_1I36;

GND GND
       (.G(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I224
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ2),
        .Q(n_0_X36_1I224));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I237
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ3),
        .Q(n_0_X36_1I237));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I250
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ4),
        .Q(n_0_X36_1I250));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I259_CARRY4
       (.CI(C4),
        .CO({n_0_X36_1I298,C7,C6,C5}),
        .CYINIT(lopt_1),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ7,TQ6,TQ5,TQ4}),
        .S({n_0_X36_1I289,n_0_X36_1I276,n_0_X36_1I263,n_0_X36_1I250}));
GND X36_1I259_CARRY4_GND
       (.G(lopt_1));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I263
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ5),
        .Q(n_0_X36_1I263));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I276
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ6),
        .Q(n_0_X36_1I276));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I289
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ7),
        .Q(n_0_X36_1I289));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I35
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ1),
        .Q(n_0_X36_1I35));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(I1),
        .CE(CE),
        .CLR(\<const0> ),
        .D(TQ0),
        .Q(n_0_X36_1I36));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({C4,C3,C2,C1}),
        .CYINIT(C0),
        .DI({X36_1N12,X36_1N12,X36_1N12,X36_1N12}),
        .O({TQ3,TQ2,TQ1,TQ0}),
        .S({n_0_X36_1I237,n_0_X36_1I224,n_0_X36_1I35,n_0_X36_1I36}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   GND X36_1I886
       (.G(X36_1N12));
(* BOX_TYPE = "PRIMITIVE" *) 
   VCC X36_1I923
       (.P(C0));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(CE),
        .I1(n_0_X36_1I298),
        .O(CEO));
endmodule

module TriMACCRC32_8
   (CRC_ENGINE_ERR0,
    I1,
    COMPUTE,
    Q,
    SFD_FLAG,
    PREAMBLE_FIELD,
    FCS_FIELD,
    I2,
    I3);
  output CRC_ENGINE_ERR0;
  input I1;
  input COMPUTE;
  input [7:0]Q;
  input SFD_FLAG;
  input PREAMBLE_FIELD;
  input FCS_FIELD;
  input I2;
  input I3;

  wire \<const0> ;
  wire COMPUTE;
  wire [7:3]CRC_CODE;
  wire [2:0]CRC_CODE__0;
  wire CRC_ENGINE_ERR0;
  wire FCS_FIELD;
  wire I1;
  wire I2;
  wire I3;
  wire PREAMBLE_FIELD;
  wire [7:0]Q;
  wire SFD_FLAG;
  wire \n_0_CALC[0]_i_1 ;
  wire \n_0_CALC[0]_i_2 ;
  wire \n_0_CALC[10]_i_1 ;
  wire \n_0_CALC[10]_i_2 ;
  wire \n_0_CALC[10]_i_3 ;
  wire \n_0_CALC[10]_i_4__0 ;
  wire \n_0_CALC[11]_i_1__0 ;
  wire \n_0_CALC[12]_i_1__0 ;
  wire \n_0_CALC[12]_i_2 ;
  wire \n_0_CALC[13]_i_1 ;
  wire \n_0_CALC[13]_i_2__0 ;
  wire \n_0_CALC[14]_i_1 ;
  wire \n_0_CALC[14]_i_2 ;
  wire \n_0_CALC[15]_i_1 ;
  wire \n_0_CALC[16]_i_1 ;
  wire \n_0_CALC[16]_i_2 ;
  wire \n_0_CALC[17]_i_1 ;
  wire \n_0_CALC[18]_i_1 ;
  wire \n_0_CALC[19]_i_1 ;
  wire \n_0_CALC[19]_i_2 ;
  wire \n_0_CALC[1]_i_1 ;
  wire \n_0_CALC[1]_i_2__0 ;
  wire \n_0_CALC[20]_i_1 ;
  wire \n_0_CALC[21]_i_1 ;
  wire \n_0_CALC[22]_i_1 ;
  wire \n_0_CALC[23]_i_1 ;
  wire \n_0_CALC[24]_i_1 ;
  wire \n_0_CALC[24]_i_2__0 ;
  wire \n_0_CALC[25]_i_1 ;
  wire \n_0_CALC[26]_i_1 ;
  wire \n_0_CALC[26]_i_2 ;
  wire \n_0_CALC[27]_i_1__0 ;
  wire \n_0_CALC[27]_i_2 ;
  wire \n_0_CALC[27]_i_3 ;
  wire \n_0_CALC[28]_i_1 ;
  wire \n_0_CALC[28]_i_2 ;
  wire \n_0_CALC[29]_i_2 ;
  wire \n_0_CALC[29]_i_3 ;
  wire \n_0_CALC[2]_i_1 ;
  wire \n_0_CALC[2]_i_2 ;
  wire \n_0_CALC[30]_i_1 ;
  wire \n_0_CALC[30]_i_2 ;
  wire \n_0_CALC[31]_i_1 ;
  wire \n_0_CALC[31]_i_2 ;
  wire \n_0_CALC[3]_i_1 ;
  wire \n_0_CALC[3]_i_2 ;
  wire \n_0_CALC[3]_i_3__0 ;
  wire \n_0_CALC[4]_i_1 ;
  wire \n_0_CALC[4]_i_2 ;
  wire \n_0_CALC[4]_i_3 ;
  wire \n_0_CALC[5]_i_1 ;
  wire \n_0_CALC[5]_i_2__0 ;
  wire \n_0_CALC[6]_i_1 ;
  wire \n_0_CALC[7]_i_1 ;
  wire \n_0_CALC[8]_i_1 ;
  wire \n_0_CALC[8]_i_2 ;
  wire \n_0_CALC[9]_i_1 ;
  wire \n_0_CALC[9]_i_2 ;
  wire \n_0_CALC_reg[0] ;
  wire \n_0_CALC_reg[10] ;
  wire \n_0_CALC_reg[11] ;
  wire \n_0_CALC_reg[12] ;
  wire \n_0_CALC_reg[13] ;
  wire \n_0_CALC_reg[14] ;
  wire \n_0_CALC_reg[15] ;
  wire \n_0_CALC_reg[16] ;
  wire \n_0_CALC_reg[17] ;
  wire \n_0_CALC_reg[18] ;
  wire \n_0_CALC_reg[19] ;
  wire \n_0_CALC_reg[1] ;
  wire \n_0_CALC_reg[20] ;
  wire \n_0_CALC_reg[21] ;
  wire \n_0_CALC_reg[22] ;
  wire \n_0_CALC_reg[23] ;
  wire \n_0_CALC_reg[2] ;
  wire \n_0_CALC_reg[3] ;
  wire \n_0_CALC_reg[4] ;
  wire \n_0_CALC_reg[5] ;
  wire \n_0_CALC_reg[6] ;
  wire \n_0_CALC_reg[7] ;
  wire \n_0_CALC_reg[8] ;
  wire \n_0_CALC_reg[9] ;
  wire n_0_CRC_ENGINE_ERR_i_2;
  wire n_0_CRC_ENGINE_ERR_i_3;
  wire n_0_CRC_ENGINE_ERR_i_4;

LUT6 #(
    .INIT(64'h000000006969FF00)) 
     \CALC[0]_i_1 
       (.I0(CRC_CODE[7]),
        .I1(Q[7]),
        .I2(\n_0_CALC[0]_i_2 ),
        .I3(Q[0]),
        .I4(COMPUTE),
        .I5(I1),
        .O(\n_0_CALC[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair73" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[0]_i_2 
       (.I0(Q[1]),
        .I1(CRC_CODE__0[1]),
        .O(\n_0_CALC[0]_i_2 ));
LUT6 #(
    .INIT(64'h0000000096FF6900)) 
     \CALC[10]_i_1 
       (.I0(\n_0_CALC[10]_i_2 ),
        .I1(\n_0_CALC[10]_i_3 ),
        .I2(\n_0_CALC[10]_i_4__0 ),
        .I3(COMPUTE),
        .I4(\n_0_CALC_reg[2] ),
        .I5(I1),
        .O(\n_0_CALC[10]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair81" *) 
   LUT4 #(
    .INIT(16'h9669)) 
     \CALC[10]_i_2 
       (.I0(CRC_CODE__0[2]),
        .I1(Q[2]),
        .I2(Q[4]),
        .I3(Q[7]),
        .O(\n_0_CALC[10]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair77" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[10]_i_3 
       (.I0(Q[5]),
        .I1(CRC_CODE[5]),
        .O(\n_0_CALC[10]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair82" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[10]_i_4__0 
       (.I0(CRC_CODE[7]),
        .I1(CRC_CODE[4]),
        .O(\n_0_CALC[10]_i_4__0 ));
LUT3 #(
    .INIT(8'hA6)) 
     \CALC[11]_i_1__0 
       (.I0(\n_0_CALC_reg[3] ),
        .I1(COMPUTE),
        .I2(\n_0_CALC[8]_i_2 ),
        .O(\n_0_CALC[11]_i_1__0 ));
LUT6 #(
    .INIT(64'h96696996FFFF0000)) 
     \CALC[12]_i_1__0 
       (.I0(\n_0_CALC[12]_i_2 ),
        .I1(\n_0_CALC[0]_i_2 ),
        .I2(Q[2]),
        .I3(CRC_CODE__0[2]),
        .I4(\n_0_CALC_reg[4] ),
        .I5(COMPUTE),
        .O(\n_0_CALC[12]_i_1__0 ));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \CALC[12]_i_2 
       (.I0(Q[7]),
        .I1(CRC_CODE[7]),
        .I2(Q[6]),
        .I3(CRC_CODE[6]),
        .I4(\n_0_CALC[4]_i_3 ),
        .I5(\n_0_CALC[10]_i_3 ),
        .O(\n_0_CALC[12]_i_2 ));
LUT6 #(
    .INIT(64'h9669FFFF96690000)) 
     \CALC[13]_i_1 
       (.I0(\n_0_CALC[13]_i_2__0 ),
        .I1(CRC_CODE[4]),
        .I2(\n_0_CALC[19]_i_2 ),
        .I3(\n_0_CALC[28]_i_2 ),
        .I4(COMPUTE),
        .I5(\n_0_CALC_reg[5] ),
        .O(\n_0_CALC[13]_i_1 ));
LUT6 #(
    .INIT(64'h9669699669969669)) 
     \CALC[13]_i_2__0 
       (.I0(Q[6]),
        .I1(CRC_CODE[5]),
        .I2(\n_0_CALC_reg[5] ),
        .I3(Q[5]),
        .I4(Q[4]),
        .I5(CRC_CODE[6]),
        .O(\n_0_CALC[13]_i_2__0 ));
LUT6 #(
    .INIT(64'h6996FFFF96690000)) 
     \CALC[14]_i_1 
       (.I0(CRC_CODE[5]),
        .I1(CRC_CODE[4]),
        .I2(\n_0_CALC[19]_i_2 ),
        .I3(\n_0_CALC[14]_i_2 ),
        .I4(COMPUTE),
        .I5(\n_0_CALC_reg[6] ),
        .O(\n_0_CALC[14]_i_1 ));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \CALC[14]_i_2 
       (.I0(Q[3]),
        .I1(CRC_CODE[3]),
        .I2(Q[1]),
        .I3(CRC_CODE__0[1]),
        .I4(Q[4]),
        .I5(Q[5]),
        .O(\n_0_CALC[14]_i_2 ));
LUT6 #(
    .INIT(64'hA66A6AA66AA6A66A)) 
     \CALC[15]_i_1 
       (.I0(\n_0_CALC_reg[7] ),
        .I1(COMPUTE),
        .I2(\n_0_CALC[19]_i_2 ),
        .I3(CRC_CODE[4]),
        .I4(Q[4]),
        .I5(\n_0_CALC[16]_i_2 ),
        .O(\n_0_CALC[15]_i_1 ));
LUT6 #(
    .INIT(64'h0000000096FF6900)) 
     \CALC[16]_i_1 
       (.I0(\n_0_CALC[16]_i_2 ),
        .I1(Q[7]),
        .I2(CRC_CODE[7]),
        .I3(COMPUTE),
        .I4(\n_0_CALC_reg[8] ),
        .I5(I1),
        .O(\n_0_CALC[16]_i_1 ));
LUT4 #(
    .INIT(16'h6996)) 
     \CALC[16]_i_2 
       (.I0(CRC_CODE[3]),
        .I1(Q[3]),
        .I2(CRC_CODE__0[2]),
        .I3(Q[2]),
        .O(\n_0_CALC[16]_i_2 ));
LUT6 #(
    .INIT(64'hA66A6AA66AA6A66A)) 
     \CALC[17]_i_1 
       (.I0(\n_0_CALC_reg[9] ),
        .I1(COMPUTE),
        .I2(\n_0_CALC[24]_i_2__0 ),
        .I3(\n_0_CALC[0]_i_2 ),
        .I4(CRC_CODE__0[2]),
        .I5(Q[2]),
        .O(\n_0_CALC[17]_i_1 ));
LUT6 #(
    .INIT(64'h000000009669AAAA)) 
     \CALC[18]_i_1 
       (.I0(\n_0_CALC_reg[10] ),
        .I1(CRC_CODE[5]),
        .I2(Q[5]),
        .I3(\n_0_CALC[29]_i_3 ),
        .I4(COMPUTE),
        .I5(I1),
        .O(\n_0_CALC[18]_i_1 ));
LUT6 #(
    .INIT(64'h1551511540040440)) 
     \CALC[19]_i_1 
       (.I0(I1),
        .I1(COMPUTE),
        .I2(\n_0_CALC[19]_i_2 ),
        .I3(CRC_CODE[4]),
        .I4(Q[4]),
        .I5(\n_0_CALC_reg[11] ),
        .O(\n_0_CALC[19]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair78" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[19]_i_2 
       (.I0(Q[0]),
        .I1(CRC_CODE__0[0]),
        .O(\n_0_CALC[19]_i_2 ));
LUT6 #(
    .INIT(64'h000000009669FF00)) 
     \CALC[1]_i_1 
       (.I0(\n_0_CALC[19]_i_2 ),
        .I1(CRC_CODE__0[1]),
        .I2(\n_0_CALC[1]_i_2__0 ),
        .I3(Q[1]),
        .I4(COMPUTE),
        .I5(I1),
        .O(\n_0_CALC[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair79" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[1]_i_2__0 
       (.I0(CRC_CODE[6]),
        .I1(Q[6]),
        .I2(CRC_CODE[7]),
        .I3(Q[7]),
        .O(\n_0_CALC[1]_i_2__0 ));
LUT4 #(
    .INIT(16'h69F0)) 
     \CALC[20]_i_1 
       (.I0(CRC_CODE[3]),
        .I1(Q[3]),
        .I2(\n_0_CALC_reg[12] ),
        .I3(COMPUTE),
        .O(\n_0_CALC[20]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair74" *) 
   LUT4 #(
    .INIT(16'h69AA)) 
     \CALC[21]_i_1 
       (.I0(\n_0_CALC_reg[13] ),
        .I1(Q[2]),
        .I2(CRC_CODE__0[2]),
        .I3(COMPUTE),
        .O(\n_0_CALC[21]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair80" *) 
   LUT4 #(
    .INIT(16'h69F0)) 
     \CALC[22]_i_1 
       (.I0(CRC_CODE[7]),
        .I1(Q[7]),
        .I2(\n_0_CALC_reg[14] ),
        .I3(COMPUTE),
        .O(\n_0_CALC[22]_i_1 ));
LUT6 #(
    .INIT(64'h96696996FFFF0000)) 
     \CALC[23]_i_1 
       (.I0(Q[7]),
        .I1(CRC_CODE[7]),
        .I2(\n_0_CALC[24]_i_2__0 ),
        .I3(\n_0_CALC[0]_i_2 ),
        .I4(\n_0_CALC_reg[15] ),
        .I5(COMPUTE),
        .O(\n_0_CALC[23]_i_1 ));
LUT6 #(
    .INIT(64'h9669FFFF69960000)) 
     \CALC[24]_i_1 
       (.I0(CRC_CODE__0[0]),
        .I1(Q[0]),
        .I2(\n_0_CALC[10]_i_3 ),
        .I3(\n_0_CALC[24]_i_2__0 ),
        .I4(COMPUTE),
        .I5(\n_0_CALC_reg[16] ),
        .O(\n_0_CALC[24]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair79" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \CALC[24]_i_2__0 
       (.I0(Q[6]),
        .I1(CRC_CODE[6]),
        .O(\n_0_CALC[24]_i_2__0 ));
LUT6 #(
    .INIT(64'hA66A6AA66AA6A66A)) 
     \CALC[25]_i_1 
       (.I0(\n_0_CALC_reg[17] ),
        .I1(COMPUTE),
        .I2(Q[4]),
        .I3(CRC_CODE[4]),
        .I4(Q[5]),
        .I5(CRC_CODE[5]),
        .O(\n_0_CALC[25]_i_1 ));
LUT6 #(
    .INIT(64'hA66A6AA66AA6A66A)) 
     \CALC[26]_i_1 
       (.I0(\n_0_CALC_reg[18] ),
        .I1(COMPUTE),
        .I2(\n_0_CALC[26]_i_2 ),
        .I3(\n_0_CALC[10]_i_4__0 ),
        .I4(Q[7]),
        .I5(Q[4]),
        .O(\n_0_CALC[26]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair76" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[26]_i_2 
       (.I0(CRC_CODE__0[1]),
        .I1(Q[1]),
        .I2(CRC_CODE[3]),
        .I3(Q[3]),
        .O(\n_0_CALC[26]_i_2 ));
LUT6 #(
    .INIT(64'h96696996FFFF0000)) 
     \CALC[27]_i_1__0 
       (.I0(\n_0_CALC[27]_i_2 ),
        .I1(CRC_CODE[6]),
        .I2(Q[6]),
        .I3(\n_0_CALC[27]_i_3 ),
        .I4(\n_0_CALC_reg[19] ),
        .I5(COMPUTE),
        .O(\n_0_CALC[27]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair75" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[27]_i_2 
       (.I0(Q[2]),
        .I1(CRC_CODE__0[2]),
        .O(\n_0_CALC[27]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair78" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[27]_i_3 
       (.I0(CRC_CODE__0[0]),
        .I1(Q[0]),
        .I2(CRC_CODE[3]),
        .I3(Q[3]),
        .O(\n_0_CALC[27]_i_3 ));
LUT6 #(
    .INIT(64'h0000000096FF6900)) 
     \CALC[28]_i_1 
       (.I0(\n_0_CALC[28]_i_2 ),
        .I1(Q[5]),
        .I2(CRC_CODE[5]),
        .I3(COMPUTE),
        .I4(\n_0_CALC_reg[20] ),
        .I5(I1),
        .O(\n_0_CALC[28]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair75" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[28]_i_2 
       (.I0(CRC_CODE__0[1]),
        .I1(Q[1]),
        .I2(CRC_CODE__0[2]),
        .I3(Q[2]),
        .O(\n_0_CALC[28]_i_2 ));
LUT6 #(
    .INIT(64'h0000000096FF6900)) 
     \CALC[29]_i_2 
       (.I0(\n_0_CALC[29]_i_3 ),
        .I1(CRC_CODE[4]),
        .I2(Q[4]),
        .I3(COMPUTE),
        .I4(\n_0_CALC_reg[21] ),
        .I5(I1),
        .O(\n_0_CALC[29]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair73" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[29]_i_3 
       (.I0(CRC_CODE__0[1]),
        .I1(Q[1]),
        .I2(CRC_CODE__0[0]),
        .I3(Q[0]),
        .O(\n_0_CALC[29]_i_3 ));
LUT6 #(
    .INIT(64'h6996FFFF69960000)) 
     \CALC[2]_i_1 
       (.I0(\n_0_CALC[2]_i_2 ),
        .I1(Q[6]),
        .I2(CRC_CODE[6]),
        .I3(Q[7]),
        .I4(COMPUTE),
        .I5(Q[2]),
        .O(\n_0_CALC[2]_i_1 ));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \CALC[2]_i_2 
       (.I0(Q[0]),
        .I1(CRC_CODE__0[0]),
        .I2(Q[1]),
        .I3(CRC_CODE__0[1]),
        .I4(\n_0_CALC[10]_i_3 ),
        .I5(CRC_CODE[7]),
        .O(\n_0_CALC[2]_i_2 ));
LUT2 #(
    .INIT(4'h8)) 
     \CALC[30]_i_1 
       (.I0(SFD_FLAG),
        .I1(PREAMBLE_FIELD),
        .O(\n_0_CALC[30]_i_1 ));
LUT6 #(
    .INIT(64'h96696996AAAAAAAA)) 
     \CALC[30]_i_2 
       (.I0(\n_0_CALC_reg[22] ),
        .I1(CRC_CODE__0[0]),
        .I2(Q[0]),
        .I3(CRC_CODE[3]),
        .I4(Q[3]),
        .I5(COMPUTE),
        .O(\n_0_CALC[30]_i_2 ));
LUT2 #(
    .INIT(4'h8)) 
     \CALC[31]_i_1 
       (.I0(SFD_FLAG),
        .I1(PREAMBLE_FIELD),
        .O(\n_0_CALC[31]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair74" *) 
   LUT4 #(
    .INIT(16'h69AA)) 
     \CALC[31]_i_2 
       (.I0(\n_0_CALC_reg[23] ),
        .I1(Q[2]),
        .I2(CRC_CODE__0[2]),
        .I3(COMPUTE),
        .O(\n_0_CALC[31]_i_2 ));
LUT5 #(
    .INIT(32'h005C5C5C)) 
     \CALC[3]_i_1 
       (.I0(\n_0_CALC[3]_i_2 ),
        .I1(Q[3]),
        .I2(COMPUTE),
        .I3(SFD_FLAG),
        .I4(PREAMBLE_FIELD),
        .O(\n_0_CALC[3]_i_1 ));
LUT6 #(
    .INIT(64'h9669699669969669)) 
     \CALC[3]_i_2 
       (.I0(CRC_CODE[6]),
        .I1(Q[4]),
        .I2(Q[6]),
        .I3(CRC_CODE[5]),
        .I4(\n_0_CALC[3]_i_3__0 ),
        .I5(Q[5]),
        .O(\n_0_CALC[3]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair82" *) 
   LUT3 #(
    .INIT(8'h69)) 
     \CALC[3]_i_3__0 
       (.I0(CRC_CODE[4]),
        .I1(CRC_CODE__0[0]),
        .I2(Q[0]),
        .O(\n_0_CALC[3]_i_3__0 ));
LUT6 #(
    .INIT(64'h96696996FFFF0000)) 
     \CALC[4]_i_1 
       (.I0(Q[7]),
        .I1(\n_0_CALC[0]_i_2 ),
        .I2(\n_0_CALC[4]_i_2 ),
        .I3(\n_0_CALC[4]_i_3 ),
        .I4(Q[4]),
        .I5(COMPUTE),
        .O(\n_0_CALC[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair77" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[4]_i_2 
       (.I0(CRC_CODE[5]),
        .I1(Q[5]),
        .I2(CRC_CODE[4]),
        .I3(CRC_CODE[7]),
        .O(\n_0_CALC[4]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair76" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[4]_i_3 
       (.I0(Q[3]),
        .I1(CRC_CODE[3]),
        .O(\n_0_CALC[4]_i_3 ));
LUT5 #(
    .INIT(32'h2EE2E22E)) 
     \CALC[5]_i_1 
       (.I0(Q[5]),
        .I1(COMPUTE),
        .I2(\n_0_CALC[5]_i_2__0 ),
        .I3(\n_0_CALC[29]_i_3 ),
        .I4(\n_0_CALC[16]_i_2 ),
        .O(\n_0_CALC[5]_i_1 ));
LUT6 #(
    .INIT(64'h9669699669969669)) 
     \CALC[5]_i_2__0 
       (.I0(Q[6]),
        .I1(Q[7]),
        .I2(CRC_CODE[6]),
        .I3(Q[4]),
        .I4(CRC_CODE[7]),
        .I5(CRC_CODE[4]),
        .O(\n_0_CALC[5]_i_2__0 ));
LUT6 #(
    .INIT(64'h6AA6A66AA66A6AA6)) 
     \CALC[6]_i_1 
       (.I0(Q[6]),
        .I1(COMPUTE),
        .I2(\n_0_CALC[29]_i_3 ),
        .I3(\n_0_CALC[16]_i_2 ),
        .I4(CRC_CODE[6]),
        .I5(\n_0_CALC[10]_i_3 ),
        .O(\n_0_CALC[6]_i_1 ));
LUT6 #(
    .INIT(64'hE22E2EE22EE2E22E)) 
     \CALC[7]_i_1 
       (.I0(Q[7]),
        .I1(COMPUTE),
        .I2(\n_0_CALC[10]_i_3 ),
        .I3(\n_0_CALC[10]_i_4__0 ),
        .I4(\n_0_CALC[19]_i_2 ),
        .I5(\n_0_CALC[10]_i_2 ),
        .O(\n_0_CALC[7]_i_1 ));
LUT3 #(
    .INIT(8'h9A)) 
     \CALC[8]_i_1 
       (.I0(\n_0_CALC_reg[0] ),
        .I1(\n_0_CALC[8]_i_2 ),
        .I2(COMPUTE),
        .O(\n_0_CALC[8]_i_1 ));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \CALC[8]_i_2 
       (.I0(CRC_CODE[4]),
        .I1(CRC_CODE[7]),
        .I2(\n_0_CALC[24]_i_2__0 ),
        .I3(\n_0_CALC[4]_i_3 ),
        .I4(Q[7]),
        .I5(Q[4]),
        .O(\n_0_CALC[8]_i_2 ));
LUT5 #(
    .INIT(32'h00747474)) 
     \CALC[9]_i_1 
       (.I0(\n_0_CALC[9]_i_2 ),
        .I1(COMPUTE),
        .I2(\n_0_CALC_reg[1] ),
        .I3(SFD_FLAG),
        .I4(PREAMBLE_FIELD),
        .O(\n_0_CALC[9]_i_1 ));
LUT6 #(
    .INIT(64'h9669699669969669)) 
     \CALC[9]_i_2 
       (.I0(CRC_CODE[5]),
        .I1(\n_0_CALC_reg[1] ),
        .I2(Q[6]),
        .I3(Q[5]),
        .I4(\n_0_CALC[16]_i_2 ),
        .I5(CRC_CODE[6]),
        .O(\n_0_CALC[9]_i_2 ));
FDRE \CALC_reg[0] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[0]_i_1 ),
        .Q(\n_0_CALC_reg[0] ),
        .R(\<const0> ));
FDRE \CALC_reg[10] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[10]_i_1 ),
        .Q(\n_0_CALC_reg[10] ),
        .R(\<const0> ));
FDRE \CALC_reg[11] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[11]_i_1__0 ),
        .Q(\n_0_CALC_reg[11] ),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[12] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[12]_i_1__0 ),
        .Q(\n_0_CALC_reg[12] ),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[13] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[13]_i_1 ),
        .Q(\n_0_CALC_reg[13] ),
        .R(\n_0_CALC[31]_i_1 ));
FDRE \CALC_reg[14] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[14]_i_1 ),
        .Q(\n_0_CALC_reg[14] ),
        .R(\n_0_CALC[31]_i_1 ));
FDRE \CALC_reg[15] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[15]_i_1 ),
        .Q(\n_0_CALC_reg[15] ),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[16] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[16]_i_1 ),
        .Q(\n_0_CALC_reg[16] ),
        .R(\<const0> ));
FDRE \CALC_reg[17] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[17]_i_1 ),
        .Q(\n_0_CALC_reg[17] ),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[18] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[18]_i_1 ),
        .Q(\n_0_CALC_reg[18] ),
        .R(\<const0> ));
FDRE \CALC_reg[19] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[19]_i_1 ),
        .Q(\n_0_CALC_reg[19] ),
        .R(\<const0> ));
FDRE \CALC_reg[1] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[1]_i_1 ),
        .Q(\n_0_CALC_reg[1] ),
        .R(\<const0> ));
FDRE \CALC_reg[20] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[20]_i_1 ),
        .Q(\n_0_CALC_reg[20] ),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[21] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[21]_i_1 ),
        .Q(\n_0_CALC_reg[21] ),
        .R(\n_0_CALC[31]_i_1 ));
FDRE \CALC_reg[22] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[22]_i_1 ),
        .Q(\n_0_CALC_reg[22] ),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[23] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[23]_i_1 ),
        .Q(\n_0_CALC_reg[23] ),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[24] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[24]_i_1 ),
        .Q(CRC_CODE[7]),
        .R(\n_0_CALC[31]_i_1 ));
FDRE \CALC_reg[25] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[25]_i_1 ),
        .Q(CRC_CODE[6]),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[26] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[26]_i_1 ),
        .Q(CRC_CODE[5]),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[27] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[27]_i_1__0 ),
        .Q(CRC_CODE[4]),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[28] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[28]_i_1 ),
        .Q(CRC_CODE[3]),
        .R(\<const0> ));
FDRE \CALC_reg[29] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[29]_i_2 ),
        .Q(CRC_CODE__0[2]),
        .R(\<const0> ));
FDRE \CALC_reg[2] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[2]_i_1 ),
        .Q(\n_0_CALC_reg[2] ),
        .R(\n_0_CALC[31]_i_1 ));
FDRE \CALC_reg[30] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[30]_i_2 ),
        .Q(CRC_CODE__0[1]),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[31] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[31]_i_2 ),
        .Q(CRC_CODE__0[0]),
        .R(\n_0_CALC[31]_i_1 ));
FDRE \CALC_reg[3] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[3]_i_1 ),
        .Q(\n_0_CALC_reg[3] ),
        .R(\<const0> ));
FDRE \CALC_reg[4] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[4]_i_1 ),
        .Q(\n_0_CALC_reg[4] ),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[5] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[5]_i_1 ),
        .Q(\n_0_CALC_reg[5] ),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[6] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[6]_i_1 ),
        .Q(\n_0_CALC_reg[6] ),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[7] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[7]_i_1 ),
        .Q(\n_0_CALC_reg[7] ),
        .R(\n_0_CALC[30]_i_1 ));
FDRE \CALC_reg[8] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[8]_i_1 ),
        .Q(\n_0_CALC_reg[8] ),
        .R(\n_0_CALC[31]_i_1 ));
FDRE \CALC_reg[9] 
       (.C(I3),
        .CE(I2),
        .D(\n_0_CALC[9]_i_1 ),
        .Q(\n_0_CALC_reg[9] ),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h2AA2AAAAAAAA2AA2)) 
     CRC_ENGINE_ERR_i_1
       (.I0(FCS_FIELD),
        .I1(n_0_CRC_ENGINE_ERR_i_2),
        .I2(CRC_CODE[6]),
        .I3(Q[6]),
        .I4(CRC_CODE[3]),
        .I5(Q[3]),
        .O(CRC_ENGINE_ERR0));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     CRC_ENGINE_ERR_i_2
       (.I0(n_0_CRC_ENGINE_ERR_i_3),
        .I1(\n_0_CALC[27]_i_2 ),
        .I2(\n_0_CALC[10]_i_3 ),
        .I3(\n_0_CALC[0]_i_2 ),
        .I4(\n_0_CALC[19]_i_2 ),
        .I5(n_0_CRC_ENGINE_ERR_i_4),
        .O(n_0_CRC_ENGINE_ERR_i_2));
(* SOFT_HLUTNM = "soft_lutpair80" *) 
   LUT2 #(
    .INIT(4'h6)) 
     CRC_ENGINE_ERR_i_3
       (.I0(Q[7]),
        .I1(CRC_CODE[7]),
        .O(n_0_CRC_ENGINE_ERR_i_3));
(* SOFT_HLUTNM = "soft_lutpair81" *) 
   LUT2 #(
    .INIT(4'h6)) 
     CRC_ENGINE_ERR_i_4
       (.I0(CRC_CODE[4]),
        .I1(Q[4]),
        .O(n_0_CRC_ENGINE_ERR_i_4));
GND GND
       (.G(\<const0> ));
endmodule

(* ORIG_REF_NAME = "CRC32_8" *) 
module TriMACCRC32_8_21
   (D,
    CRC,
    Q,
    COMPUTE,
    I1,
    I18,
    gtx_clk);
  output [7:0]D;
  input CRC;
  input [7:0]Q;
  input COMPUTE;
  input [0:0]I1;
  input I18;
  input gtx_clk;

  wire \<const0> ;
  wire COMPUTE;
  wire CRC;
  wire [7:0]D;
  wire DATA_OUT0;
  wire [0:0]I1;
  wire I18;
  wire [7:0]Q;
  wire gtx_clk;
  wire \n_0_CALC[0]_i_1__0 ;
  wire \n_0_CALC[0]_i_2__0 ;
  wire \n_0_CALC[10]_i_1__0 ;
  wire \n_0_CALC[10]_i_2__0 ;
  wire \n_0_CALC[10]_i_3__0 ;
  wire \n_0_CALC[10]_i_4 ;
  wire \n_0_CALC[11]_i_1 ;
  wire \n_0_CALC[11]_i_2 ;
  wire \n_0_CALC[11]_i_3 ;
  wire \n_0_CALC[12]_i_1 ;
  wire \n_0_CALC[12]_i_2__0 ;
  wire \n_0_CALC[13]_i_1__0 ;
  wire \n_0_CALC[13]_i_2 ;
  wire \n_0_CALC[13]_i_3 ;
  wire \n_0_CALC[14]_i_1__0 ;
  wire \n_0_CALC[14]_i_2__0 ;
  wire \n_0_CALC[15]_i_1__0 ;
  wire \n_0_CALC[16]_i_1__0 ;
  wire \n_0_CALC[16]_i_2__0 ;
  wire \n_0_CALC[17]_i_1__0 ;
  wire \n_0_CALC[18]_i_1__0 ;
  wire \n_0_CALC[19]_i_1__0 ;
  wire \n_0_CALC[1]_i_1__0 ;
  wire \n_0_CALC[1]_i_2 ;
  wire \n_0_CALC[1]_i_3 ;
  wire \n_0_CALC[20]_i_1__0 ;
  wire \n_0_CALC[21]_i_1__0 ;
  wire \n_0_CALC[22]_i_1__0 ;
  wire \n_0_CALC[23]_i_1__0 ;
  wire \n_0_CALC[24]_i_1__0 ;
  wire \n_0_CALC[24]_i_2 ;
  wire \n_0_CALC[25]_i_1__0 ;
  wire \n_0_CALC[26]_i_1__0 ;
  wire \n_0_CALC[26]_i_2__0 ;
  wire \n_0_CALC[26]_i_3 ;
  wire \n_0_CALC[27]_i_1 ;
  wire \n_0_CALC[27]_i_2__0 ;
  wire \n_0_CALC[28]_i_1__0 ;
  wire \n_0_CALC[28]_i_2__0 ;
  wire \n_0_CALC[29]_i_2__0 ;
  wire \n_0_CALC[29]_i_3__0 ;
  wire \n_0_CALC[2]_i_1__0 ;
  wire \n_0_CALC[2]_i_2__0 ;
  wire \n_0_CALC[30]_i_1 ;
  wire \n_0_CALC[31]_i_1 ;
  wire \n_0_CALC[3]_i_1__0 ;
  wire \n_0_CALC[3]_i_2__0 ;
  wire \n_0_CALC[3]_i_3 ;
  wire \n_0_CALC[4]_i_1__0 ;
  wire \n_0_CALC[4]_i_2__0 ;
  wire \n_0_CALC[5]_i_1__0 ;
  wire \n_0_CALC[5]_i_2 ;
  wire \n_0_CALC[6]_i_1__0 ;
  wire \n_0_CALC[6]_i_2 ;
  wire \n_0_CALC[7]_i_1__0 ;
  wire \n_0_CALC[8]_i_1__0 ;
  wire \n_0_CALC[9]_i_1__0 ;
  wire \n_0_CALC[9]_i_2__0 ;
  wire \n_0_CALC_reg[0] ;
  wire \n_0_CALC_reg[10] ;
  wire \n_0_CALC_reg[11] ;
  wire \n_0_CALC_reg[12] ;
  wire \n_0_CALC_reg[13] ;
  wire \n_0_CALC_reg[14] ;
  wire \n_0_CALC_reg[15] ;
  wire \n_0_CALC_reg[16] ;
  wire \n_0_CALC_reg[17] ;
  wire \n_0_CALC_reg[18] ;
  wire \n_0_CALC_reg[19] ;
  wire \n_0_CALC_reg[1] ;
  wire \n_0_CALC_reg[20] ;
  wire \n_0_CALC_reg[21] ;
  wire \n_0_CALC_reg[22] ;
  wire \n_0_CALC_reg[23] ;
  wire \n_0_CALC_reg[25] ;
  wire \n_0_CALC_reg[26] ;
  wire \n_0_CALC_reg[27] ;
  wire \n_0_CALC_reg[28] ;
  wire \n_0_CALC_reg[29] ;
  wire \n_0_CALC_reg[2] ;
  wire \n_0_CALC_reg[30] ;
  wire \n_0_CALC_reg[31] ;
  wire \n_0_CALC_reg[3] ;
  wire \n_0_CALC_reg[4] ;
  wire \n_0_CALC_reg[5] ;
  wire \n_0_CALC_reg[6] ;
  wire \n_0_CALC_reg[7] ;
  wire \n_0_CALC_reg[8] ;
  wire \n_0_CALC_reg[9] ;

LUT6 #(
    .INIT(64'h000000006969FF00)) 
     \CALC[0]_i_1__0 
       (.I0(\n_0_CALC[0]_i_2__0 ),
        .I1(DATA_OUT0),
        .I2(Q[7]),
        .I3(Q[0]),
        .I4(COMPUTE),
        .I5(I1),
        .O(\n_0_CALC[0]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair30" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[0]_i_2__0 
       (.I0(\n_0_CALC_reg[30] ),
        .I1(Q[1]),
        .O(\n_0_CALC[0]_i_2__0 ));
LUT6 #(
    .INIT(64'h000000009669FF00)) 
     \CALC[10]_i_1__0 
       (.I0(\n_0_CALC[10]_i_2__0 ),
        .I1(\n_0_CALC[10]_i_3__0 ),
        .I2(\n_0_CALC[10]_i_4 ),
        .I3(\n_0_CALC_reg[2] ),
        .I4(COMPUTE),
        .I5(I1),
        .O(\n_0_CALC[10]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair44" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \CALC[10]_i_2__0 
       (.I0(Q[7]),
        .I1(Q[4]),
        .O(\n_0_CALC[10]_i_2__0 ));
(* SOFT_HLUTNM = "soft_lutpair32" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[10]_i_3__0 
       (.I0(Q[2]),
        .I1(\n_0_CALC_reg[29] ),
        .O(\n_0_CALC[10]_i_3__0 ));
(* SOFT_HLUTNM = "soft_lutpair40" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[10]_i_4 
       (.I0(\n_0_CALC_reg[26] ),
        .I1(Q[5]),
        .I2(\n_0_CALC_reg[27] ),
        .I3(DATA_OUT0),
        .O(\n_0_CALC[10]_i_4 ));
LUT3 #(
    .INIT(8'h06)) 
     \CALC[11]_i_1 
       (.I0(\n_0_CALC_reg[3] ),
        .I1(\n_0_CALC[11]_i_2 ),
        .I2(I1),
        .O(\n_0_CALC[11]_i_1 ));
LUT6 #(
    .INIT(64'h2882822882282882)) 
     \CALC[11]_i_2 
       (.I0(COMPUTE),
        .I1(Q[4]),
        .I2(Q[7]),
        .I3(\n_0_CALC[11]_i_3 ),
        .I4(\n_0_CALC[4]_i_2__0 ),
        .I5(\n_0_CALC[26]_i_3 ),
        .O(\n_0_CALC[11]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair43" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \CALC[11]_i_3 
       (.I0(Q[6]),
        .I1(\n_0_CALC_reg[25] ),
        .O(\n_0_CALC[11]_i_3 ));
LUT6 #(
    .INIT(64'hA66A6AA66AA6A66A)) 
     \CALC[12]_i_1 
       (.I0(\n_0_CALC_reg[4] ),
        .I1(COMPUTE),
        .I2(\n_0_CALC_reg[29] ),
        .I3(Q[2]),
        .I4(\n_0_CALC[0]_i_2__0 ),
        .I5(\n_0_CALC[12]_i_2__0 ),
        .O(\n_0_CALC[12]_i_1 ));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \CALC[12]_i_2__0 
       (.I0(Q[7]),
        .I1(DATA_OUT0),
        .I2(Q[6]),
        .I3(\n_0_CALC_reg[25] ),
        .I4(\n_0_CALC[24]_i_2 ),
        .I5(\n_0_CALC[4]_i_2__0 ),
        .O(\n_0_CALC[12]_i_2__0 ));
LUT6 #(
    .INIT(64'h9669FFFF96690000)) 
     \CALC[13]_i_1__0 
       (.I0(\n_0_CALC_reg[25] ),
        .I1(\n_0_CALC[13]_i_2 ),
        .I2(\n_0_CALC[28]_i_2__0 ),
        .I3(\n_0_CALC[13]_i_3 ),
        .I4(COMPUTE),
        .I5(\n_0_CALC_reg[5] ),
        .O(\n_0_CALC[13]_i_1__0 ));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \CALC[13]_i_2 
       (.I0(\n_0_CALC_reg[31] ),
        .I1(Q[0]),
        .I2(\n_0_CALC_reg[27] ),
        .I3(Q[6]),
        .I4(\n_0_CALC_reg[26] ),
        .I5(\n_0_CALC_reg[5] ),
        .O(\n_0_CALC[13]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair44" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \CALC[13]_i_3 
       (.I0(Q[5]),
        .I1(Q[4]),
        .O(\n_0_CALC[13]_i_3 ));
LUT6 #(
    .INIT(64'h6996FFFF96690000)) 
     \CALC[14]_i_1__0 
       (.I0(Q[5]),
        .I1(Q[4]),
        .I2(\n_0_CALC_reg[26] ),
        .I3(\n_0_CALC[14]_i_2__0 ),
        .I4(COMPUTE),
        .I5(\n_0_CALC_reg[6] ),
        .O(\n_0_CALC[14]_i_1__0 ));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \CALC[14]_i_2__0 
       (.I0(\n_0_CALC_reg[30] ),
        .I1(Q[1]),
        .I2(Q[3]),
        .I3(\n_0_CALC_reg[28] ),
        .I4(\n_0_CALC[1]_i_2 ),
        .I5(\n_0_CALC_reg[27] ),
        .O(\n_0_CALC[14]_i_2__0 ));
LUT6 #(
    .INIT(64'hA66A6AA66AA6A66A)) 
     \CALC[15]_i_1__0 
       (.I0(\n_0_CALC_reg[7] ),
        .I1(COMPUTE),
        .I2(\n_0_CALC_reg[27] ),
        .I3(Q[4]),
        .I4(\n_0_CALC[1]_i_2 ),
        .I5(\n_0_CALC[16]_i_2__0 ),
        .O(\n_0_CALC[15]_i_1__0 ));
LUT6 #(
    .INIT(64'h000000009669FF00)) 
     \CALC[16]_i_1__0 
       (.I0(Q[7]),
        .I1(DATA_OUT0),
        .I2(\n_0_CALC[16]_i_2__0 ),
        .I3(\n_0_CALC_reg[8] ),
        .I4(COMPUTE),
        .I5(I1),
        .O(\n_0_CALC[16]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair31" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[16]_i_2__0 
       (.I0(\n_0_CALC_reg[29] ),
        .I1(Q[2]),
        .I2(\n_0_CALC_reg[28] ),
        .I3(Q[3]),
        .O(\n_0_CALC[16]_i_2__0 ));
LUT6 #(
    .INIT(64'h6AA6A66AA66A6AA6)) 
     \CALC[17]_i_1__0 
       (.I0(\n_0_CALC_reg[9] ),
        .I1(COMPUTE),
        .I2(\n_0_CALC_reg[25] ),
        .I3(Q[6]),
        .I4(\n_0_CALC[10]_i_3__0 ),
        .I5(\n_0_CALC[0]_i_2__0 ),
        .O(\n_0_CALC[17]_i_1__0 ));
LUT6 #(
    .INIT(64'h4114144144444444)) 
     \CALC[18]_i_1__0 
       (.I0(I1),
        .I1(\n_0_CALC_reg[10] ),
        .I2(Q[5]),
        .I3(\n_0_CALC_reg[26] ),
        .I4(\n_0_CALC[29]_i_3__0 ),
        .I5(COMPUTE),
        .O(\n_0_CALC[18]_i_1__0 ));
LUT6 #(
    .INIT(64'hA66A6AA66AA6A66A)) 
     \CALC[19]_i_1__0 
       (.I0(\n_0_CALC_reg[11] ),
        .I1(COMPUTE),
        .I2(Q[4]),
        .I3(Q[0]),
        .I4(\n_0_CALC_reg[31] ),
        .I5(\n_0_CALC_reg[27] ),
        .O(\n_0_CALC[19]_i_1__0 ));
LUT6 #(
    .INIT(64'h000000009669FF00)) 
     \CALC[1]_i_1__0 
       (.I0(\n_0_CALC_reg[30] ),
        .I1(\n_0_CALC[1]_i_2 ),
        .I2(\n_0_CALC[1]_i_3 ),
        .I3(Q[1]),
        .I4(COMPUTE),
        .I5(I1),
        .O(\n_0_CALC[1]_i_1__0 ));
LUT2 #(
    .INIT(4'h6)) 
     \CALC[1]_i_2 
       (.I0(\n_0_CALC_reg[31] ),
        .I1(Q[0]),
        .O(\n_0_CALC[1]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair34" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[1]_i_3 
       (.I0(\n_0_CALC_reg[25] ),
        .I1(Q[6]),
        .I2(DATA_OUT0),
        .I3(Q[7]),
        .O(\n_0_CALC[1]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair38" *) 
   LUT4 #(
    .INIT(16'h69F0)) 
     \CALC[20]_i_1__0 
       (.I0(\n_0_CALC_reg[28] ),
        .I1(Q[3]),
        .I2(\n_0_CALC_reg[12] ),
        .I3(COMPUTE),
        .O(\n_0_CALC[20]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair35" *) 
   LUT4 #(
    .INIT(16'h69AA)) 
     \CALC[21]_i_1__0 
       (.I0(\n_0_CALC_reg[13] ),
        .I1(Q[2]),
        .I2(\n_0_CALC_reg[29] ),
        .I3(COMPUTE),
        .O(\n_0_CALC[21]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair33" *) 
   LUT4 #(
    .INIT(16'h69F0)) 
     \CALC[22]_i_1__0 
       (.I0(DATA_OUT0),
        .I1(Q[7]),
        .I2(\n_0_CALC_reg[14] ),
        .I3(COMPUTE),
        .O(\n_0_CALC[22]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair30" *) 
   LUT5 #(
    .INIT(32'h9669FF00)) 
     \CALC[23]_i_1__0 
       (.I0(\n_0_CALC[1]_i_3 ),
        .I1(\n_0_CALC_reg[30] ),
        .I2(Q[1]),
        .I3(\n_0_CALC_reg[15] ),
        .I4(COMPUTE),
        .O(\n_0_CALC[23]_i_1__0 ));
LUT6 #(
    .INIT(64'h6996FFFF96690000)) 
     \CALC[24]_i_1__0 
       (.I0(\n_0_CALC[1]_i_2 ),
        .I1(\n_0_CALC[24]_i_2 ),
        .I2(Q[6]),
        .I3(\n_0_CALC_reg[25] ),
        .I4(COMPUTE),
        .I5(\n_0_CALC_reg[16] ),
        .O(\n_0_CALC[24]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair41" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[24]_i_2 
       (.I0(Q[5]),
        .I1(\n_0_CALC_reg[26] ),
        .O(\n_0_CALC[24]_i_2 ));
LUT6 #(
    .INIT(64'hA66A6AA66AA6A66A)) 
     \CALC[25]_i_1__0 
       (.I0(\n_0_CALC_reg[17] ),
        .I1(COMPUTE),
        .I2(Q[4]),
        .I3(\n_0_CALC_reg[27] ),
        .I4(Q[5]),
        .I5(\n_0_CALC_reg[26] ),
        .O(\n_0_CALC[25]_i_1__0 ));
LUT6 #(
    .INIT(64'hA66A6AA66AA6A66A)) 
     \CALC[26]_i_1__0 
       (.I0(\n_0_CALC_reg[18] ),
        .I1(COMPUTE),
        .I2(\n_0_CALC[26]_i_2__0 ),
        .I3(\n_0_CALC[26]_i_3 ),
        .I4(Q[7]),
        .I5(Q[4]),
        .O(\n_0_CALC[26]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair39" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[26]_i_2__0 
       (.I0(\n_0_CALC_reg[28] ),
        .I1(Q[3]),
        .I2(Q[1]),
        .I3(\n_0_CALC_reg[30] ),
        .O(\n_0_CALC[26]_i_2__0 ));
(* SOFT_HLUTNM = "soft_lutpair42" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[26]_i_3 
       (.I0(DATA_OUT0),
        .I1(\n_0_CALC_reg[27] ),
        .O(\n_0_CALC[26]_i_3 ));
LUT5 #(
    .INIT(32'h000096F0)) 
     \CALC[27]_i_1 
       (.I0(Q[6]),
        .I1(\n_0_CALC[27]_i_2__0 ),
        .I2(\n_0_CALC_reg[19] ),
        .I3(COMPUTE),
        .I4(I1),
        .O(\n_0_CALC[27]_i_1 ));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \CALC[27]_i_2__0 
       (.I0(Q[3]),
        .I1(\n_0_CALC_reg[28] ),
        .I2(\n_0_CALC[1]_i_2 ),
        .I3(Q[2]),
        .I4(\n_0_CALC_reg[29] ),
        .I5(\n_0_CALC_reg[25] ),
        .O(\n_0_CALC[27]_i_2__0 ));
LUT6 #(
    .INIT(64'h000000009669FF00)) 
     \CALC[28]_i_1__0 
       (.I0(\n_0_CALC[28]_i_2__0 ),
        .I1(Q[5]),
        .I2(\n_0_CALC_reg[26] ),
        .I3(\n_0_CALC_reg[20] ),
        .I4(COMPUTE),
        .I5(I1),
        .O(\n_0_CALC[28]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair32" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[28]_i_2__0 
       (.I0(\n_0_CALC_reg[29] ),
        .I1(Q[2]),
        .I2(Q[1]),
        .I3(\n_0_CALC_reg[30] ),
        .O(\n_0_CALC[28]_i_2__0 ));
LUT6 #(
    .INIT(64'h000000009669FF00)) 
     \CALC[29]_i_2__0 
       (.I0(\n_0_CALC[29]_i_3__0 ),
        .I1(\n_0_CALC_reg[27] ),
        .I2(Q[4]),
        .I3(\n_0_CALC_reg[21] ),
        .I4(COMPUTE),
        .I5(I1),
        .O(\n_0_CALC[29]_i_2__0 ));
(* SOFT_HLUTNM = "soft_lutpair36" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[29]_i_3__0 
       (.I0(Q[0]),
        .I1(\n_0_CALC_reg[31] ),
        .I2(Q[1]),
        .I3(\n_0_CALC_reg[30] ),
        .O(\n_0_CALC[29]_i_3__0 ));
LUT4 #(
    .INIT(16'h005C)) 
     \CALC[2]_i_1__0 
       (.I0(\n_0_CALC[2]_i_2__0 ),
        .I1(Q[2]),
        .I2(COMPUTE),
        .I3(I1),
        .O(\n_0_CALC[2]_i_1__0 ));
LUT6 #(
    .INIT(64'h9669699669969669)) 
     \CALC[2]_i_2__0 
       (.I0(Q[7]),
        .I1(Q[6]),
        .I2(\n_0_CALC_reg[25] ),
        .I3(DATA_OUT0),
        .I4(\n_0_CALC[24]_i_2 ),
        .I5(\n_0_CALC[29]_i_3__0 ),
        .O(\n_0_CALC[2]_i_2__0 ));
LUT6 #(
    .INIT(64'h9669FFFF69960000)) 
     \CALC[30]_i_1 
       (.I0(\n_0_CALC_reg[28] ),
        .I1(Q[3]),
        .I2(\n_0_CALC_reg[31] ),
        .I3(Q[0]),
        .I4(COMPUTE),
        .I5(\n_0_CALC_reg[22] ),
        .O(\n_0_CALC[30]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair35" *) 
   LUT4 #(
    .INIT(16'h69AA)) 
     \CALC[31]_i_1 
       (.I0(\n_0_CALC_reg[23] ),
        .I1(Q[2]),
        .I2(\n_0_CALC_reg[29] ),
        .I3(COMPUTE),
        .O(\n_0_CALC[31]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair37" *) 
   LUT4 #(
    .INIT(16'h005C)) 
     \CALC[3]_i_1__0 
       (.I0(\n_0_CALC[3]_i_2__0 ),
        .I1(Q[3]),
        .I2(COMPUTE),
        .I3(I1),
        .O(\n_0_CALC[3]_i_1__0 ));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \CALC[3]_i_2__0 
       (.I0(Q[5]),
        .I1(\n_0_CALC_reg[27] ),
        .I2(\n_0_CALC[1]_i_2 ),
        .I3(\n_0_CALC[3]_i_3 ),
        .I4(Q[6]),
        .I5(\n_0_CALC_reg[26] ),
        .O(\n_0_CALC[3]_i_2__0 ));
(* SOFT_HLUTNM = "soft_lutpair43" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[3]_i_3 
       (.I0(\n_0_CALC_reg[25] ),
        .I1(Q[4]),
        .O(\n_0_CALC[3]_i_3 ));
LUT6 #(
    .INIT(64'h96696996FFFF0000)) 
     \CALC[4]_i_1__0 
       (.I0(Q[7]),
        .I1(\n_0_CALC[0]_i_2__0 ),
        .I2(\n_0_CALC[10]_i_4 ),
        .I3(\n_0_CALC[4]_i_2__0 ),
        .I4(Q[4]),
        .I5(COMPUTE),
        .O(\n_0_CALC[4]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair37" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CALC[4]_i_2__0 
       (.I0(Q[3]),
        .I1(\n_0_CALC_reg[28] ),
        .O(\n_0_CALC[4]_i_2__0 ));
LUT6 #(
    .INIT(64'hE22E2EE22EE2E22E)) 
     \CALC[5]_i_1__0 
       (.I0(Q[5]),
        .I1(COMPUTE),
        .I2(\n_0_CALC[5]_i_2 ),
        .I3(\n_0_CALC[26]_i_2__0 ),
        .I4(\n_0_CALC[1]_i_2 ),
        .I5(\n_0_CALC[10]_i_3__0 ),
        .O(\n_0_CALC[5]_i_1__0 ));
LUT6 #(
    .INIT(64'h9669699669969669)) 
     \CALC[5]_i_2 
       (.I0(Q[4]),
        .I1(\n_0_CALC_reg[25] ),
        .I2(Q[7]),
        .I3(Q[6]),
        .I4(DATA_OUT0),
        .I5(\n_0_CALC_reg[27] ),
        .O(\n_0_CALC[5]_i_2 ));
LUT6 #(
    .INIT(64'h6AA6A66AA66A6AA6)) 
     \CALC[6]_i_1__0 
       (.I0(Q[6]),
        .I1(COMPUTE),
        .I2(\n_0_CALC[6]_i_2 ),
        .I3(\n_0_CALC_reg[26] ),
        .I4(Q[5]),
        .I5(\n_0_CALC_reg[25] ),
        .O(\n_0_CALC[6]_i_1__0 ));
LUT6 #(
    .INIT(64'h6996966996696996)) 
     \CALC[6]_i_2 
       (.I0(\n_0_CALC_reg[30] ),
        .I1(Q[1]),
        .I2(\n_0_CALC[4]_i_2__0 ),
        .I3(\n_0_CALC[1]_i_2 ),
        .I4(Q[2]),
        .I5(\n_0_CALC_reg[29] ),
        .O(\n_0_CALC[6]_i_2 ));
LUT6 #(
    .INIT(64'hA66A6AA66AA6A66A)) 
     \CALC[7]_i_1__0 
       (.I0(Q[7]),
        .I1(COMPUTE),
        .I2(\n_0_CALC[1]_i_2 ),
        .I3(\n_0_CALC[10]_i_4 ),
        .I4(\n_0_CALC[10]_i_3__0 ),
        .I5(Q[4]),
        .O(\n_0_CALC[7]_i_1__0 ));
LUT2 #(
    .INIT(4'h6)) 
     \CALC[8]_i_1__0 
       (.I0(\n_0_CALC_reg[0] ),
        .I1(\n_0_CALC[11]_i_2 ),
        .O(\n_0_CALC[8]_i_1__0 ));
LUT6 #(
    .INIT(64'h000000009696FF00)) 
     \CALC[9]_i_1__0 
       (.I0(\n_0_CALC[9]_i_2__0 ),
        .I1(\n_0_CALC[16]_i_2__0 ),
        .I2(\n_0_CALC_reg[25] ),
        .I3(\n_0_CALC_reg[1] ),
        .I4(COMPUTE),
        .I5(I1),
        .O(\n_0_CALC[9]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair41" *) 
   LUT4 #(
    .INIT(16'h6996)) 
     \CALC[9]_i_2__0 
       (.I0(\n_0_CALC_reg[1] ),
        .I1(\n_0_CALC_reg[26] ),
        .I2(Q[5]),
        .I3(Q[6]),
        .O(\n_0_CALC[9]_i_2__0 ));
FDRE \CALC_reg[0] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[0]_i_1__0 ),
        .Q(\n_0_CALC_reg[0] ),
        .R(\<const0> ));
FDRE \CALC_reg[10] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[10]_i_1__0 ),
        .Q(\n_0_CALC_reg[10] ),
        .R(\<const0> ));
FDRE \CALC_reg[11] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[11]_i_1 ),
        .Q(\n_0_CALC_reg[11] ),
        .R(\<const0> ));
FDRE \CALC_reg[12] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[12]_i_1 ),
        .Q(\n_0_CALC_reg[12] ),
        .R(I1));
FDRE \CALC_reg[13] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[13]_i_1__0 ),
        .Q(\n_0_CALC_reg[13] ),
        .R(I1));
FDRE \CALC_reg[14] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[14]_i_1__0 ),
        .Q(\n_0_CALC_reg[14] ),
        .R(I1));
FDRE \CALC_reg[15] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[15]_i_1__0 ),
        .Q(\n_0_CALC_reg[15] ),
        .R(I1));
FDRE \CALC_reg[16] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[16]_i_1__0 ),
        .Q(\n_0_CALC_reg[16] ),
        .R(\<const0> ));
FDRE \CALC_reg[17] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[17]_i_1__0 ),
        .Q(\n_0_CALC_reg[17] ),
        .R(I1));
FDRE \CALC_reg[18] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[18]_i_1__0 ),
        .Q(\n_0_CALC_reg[18] ),
        .R(\<const0> ));
FDRE \CALC_reg[19] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[19]_i_1__0 ),
        .Q(\n_0_CALC_reg[19] ),
        .R(I1));
FDRE \CALC_reg[1] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[1]_i_1__0 ),
        .Q(\n_0_CALC_reg[1] ),
        .R(\<const0> ));
FDRE \CALC_reg[20] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[20]_i_1__0 ),
        .Q(\n_0_CALC_reg[20] ),
        .R(I1));
FDRE \CALC_reg[21] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[21]_i_1__0 ),
        .Q(\n_0_CALC_reg[21] ),
        .R(I1));
FDRE \CALC_reg[22] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[22]_i_1__0 ),
        .Q(\n_0_CALC_reg[22] ),
        .R(I1));
FDRE \CALC_reg[23] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[23]_i_1__0 ),
        .Q(\n_0_CALC_reg[23] ),
        .R(I1));
FDRE \CALC_reg[24] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[24]_i_1__0 ),
        .Q(DATA_OUT0),
        .R(I1));
FDRE \CALC_reg[25] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[25]_i_1__0 ),
        .Q(\n_0_CALC_reg[25] ),
        .R(I1));
FDRE \CALC_reg[26] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[26]_i_1__0 ),
        .Q(\n_0_CALC_reg[26] ),
        .R(I1));
FDRE \CALC_reg[27] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[27]_i_1 ),
        .Q(\n_0_CALC_reg[27] ),
        .R(\<const0> ));
FDRE \CALC_reg[28] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[28]_i_1__0 ),
        .Q(\n_0_CALC_reg[28] ),
        .R(\<const0> ));
FDRE \CALC_reg[29] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[29]_i_2__0 ),
        .Q(\n_0_CALC_reg[29] ),
        .R(\<const0> ));
FDRE \CALC_reg[2] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[2]_i_1__0 ),
        .Q(\n_0_CALC_reg[2] ),
        .R(\<const0> ));
FDRE \CALC_reg[30] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[30]_i_1 ),
        .Q(\n_0_CALC_reg[30] ),
        .R(I1));
FDRE \CALC_reg[31] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[31]_i_1 ),
        .Q(\n_0_CALC_reg[31] ),
        .R(I1));
FDRE \CALC_reg[3] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[3]_i_1__0 ),
        .Q(\n_0_CALC_reg[3] ),
        .R(\<const0> ));
FDRE \CALC_reg[4] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[4]_i_1__0 ),
        .Q(\n_0_CALC_reg[4] ),
        .R(I1));
FDRE \CALC_reg[5] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[5]_i_1__0 ),
        .Q(\n_0_CALC_reg[5] ),
        .R(I1));
FDRE \CALC_reg[6] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[6]_i_1__0 ),
        .Q(\n_0_CALC_reg[6] ),
        .R(I1));
FDRE \CALC_reg[7] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[7]_i_1__0 ),
        .Q(\n_0_CALC_reg[7] ),
        .R(I1));
FDRE \CALC_reg[8] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[8]_i_1__0 ),
        .Q(\n_0_CALC_reg[8] ),
        .R(I1));
FDRE \CALC_reg[9] 
       (.C(gtx_clk),
        .CE(I18),
        .D(\n_0_CALC[9]_i_1__0 ),
        .Q(\n_0_CALC_reg[9] ),
        .R(\<const0> ));
GND GND
       (.G(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair36" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txd_reg1[0]_i_1 
       (.I0(\n_0_CALC_reg[31] ),
        .I1(CRC),
        .I2(Q[0]),
        .O(D[0]));
(* SOFT_HLUTNM = "soft_lutpair39" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txd_reg1[1]_i_1 
       (.I0(\n_0_CALC_reg[30] ),
        .I1(CRC),
        .I2(Q[1]),
        .O(D[1]));
(* SOFT_HLUTNM = "soft_lutpair31" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txd_reg1[2]_i_1 
       (.I0(\n_0_CALC_reg[29] ),
        .I1(CRC),
        .I2(Q[2]),
        .O(D[2]));
(* SOFT_HLUTNM = "soft_lutpair38" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txd_reg1[3]_i_1 
       (.I0(\n_0_CALC_reg[28] ),
        .I1(CRC),
        .I2(Q[3]),
        .O(D[3]));
(* SOFT_HLUTNM = "soft_lutpair42" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txd_reg1[4]_i_1 
       (.I0(\n_0_CALC_reg[27] ),
        .I1(CRC),
        .I2(Q[4]),
        .O(D[4]));
(* SOFT_HLUTNM = "soft_lutpair40" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txd_reg1[5]_i_1 
       (.I0(\n_0_CALC_reg[26] ),
        .I1(CRC),
        .I2(Q[5]),
        .O(D[5]));
(* SOFT_HLUTNM = "soft_lutpair34" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txd_reg1[6]_i_1 
       (.I0(\n_0_CALC_reg[25] ),
        .I1(CRC),
        .I2(Q[6]),
        .O(D[6]));
(* SOFT_HLUTNM = "soft_lutpair33" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txd_reg1[7]_i_1 
       (.I0(DATA_OUT0),
        .I1(CRC),
        .I2(Q[7]),
        .O(D[7]));
endmodule

module TriMACCRC_64_32
   (O1,
    I1,
    CRC1000_EN,
    SPEED_1_RESYNC_REG,
    CRC50_EN,
    SPEED_0_RESYNC_REG,
    I2,
    rx_configuration_vector);
  output O1;
  input I1;
  input CRC1000_EN;
  input SPEED_1_RESYNC_REG;
  input CRC50_EN;
  input SPEED_0_RESYNC_REG;
  input I2;
  input [0:0]rx_configuration_vector;

  wire \<const0> ;
  wire \<const1> ;
  wire CE;
  wire CRC1000_EN;
  wire CRC50_EN;
  wire CRC_OK;
  wire D;
  wire I1;
  wire I1_0;
  wire I2;
  wire O1;
  wire Q;
  wire SPEED_0_RESYNC_REG;
  wire SPEED_1_RESYNC_REG;
  wire lopt;
  wire n_0_CRC2;
  wire n_0_CRC3;
  wire n_0_CRC4;
  wire n_0_CRC5;
  wire n_0_FF2;
  wire n_0_FF3;
  wire n_0_FF4;
  wire n_0_FF5;
  wire n_0_X36_1I6;
  wire n_0_X36_1I956;
  wire [0:0]rx_configuration_vector;
  wire [3:1]NLW_X36_1I4_CARRY4_CO_UNCONNECTED;
  wire [3:1]NLW_X36_1I4_CARRY4_DI_UNCONNECTED;
  wire [3:1]NLW_X36_1I4_CARRY4_O_UNCONNECTED;
  wire [3:1]NLW_X36_1I4_CARRY4_S_UNCONNECTED;

TriMACCC8CE CRC1
       (.CEO(D),
        .CRC1000_EN(CRC1000_EN),
        .CRC50_EN(CRC50_EN),
        .I1(I1),
        .I2(I2),
        .SPEED_0_RESYNC_REG(SPEED_0_RESYNC_REG),
        .SPEED_1_RESYNC_REG(SPEED_1_RESYNC_REG));
TriMACCC8CE_8 CRC2
       (.CE(CE),
        .CEO(n_0_CRC2),
        .I1(I1));
TriMACCC8CE_9 CRC3
       (.CE(n_0_FF2),
        .CEO(n_0_CRC3),
        .I1(I1));
TriMACCC8CE_10 CRC4
       (.CE(n_0_FF3),
        .CEO(n_0_CRC4),
        .I1(I1));
TriMACCC2CE CRC5
       (.CE(n_0_FF4),
        .CEO(n_0_CRC5),
        .I1(I1));
LUT2 #(
    .INIT(4'h2)) 
     ENABLE_REG_i_1
       (.I0(rx_configuration_vector),
        .I1(CRC_OK),
        .O(O1));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF1
       (.C(I1),
        .CE(\<const1> ),
        .CLR(\<const0> ),
        .D(D),
        .Q(CE));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF2
       (.C(I1),
        .CE(\<const1> ),
        .CLR(\<const0> ),
        .D(n_0_CRC2),
        .Q(n_0_FF2));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF3
       (.C(I1),
        .CE(\<const1> ),
        .CLR(\<const0> ),
        .D(n_0_CRC3),
        .Q(n_0_FF3));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF4
       (.C(I1),
        .CE(\<const1> ),
        .CLR(\<const0> ),
        .D(n_0_CRC4),
        .Q(n_0_FF4));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF5
       (.C(I1),
        .CE(\<const1> ),
        .CLR(\<const0> ),
        .D(n_0_CRC5),
        .Q(n_0_FF5));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF6
       (.C(I1),
        .CE(n_0_X36_1I956),
        .CLR(\<const0> ),
        .D(\<const1> ),
        .Q(CRC_OK));
GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(I1),
        .CE(n_0_FF5),
        .CLR(\<const0> ),
        .D(n_0_X36_1I6),
        .Q(Q));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({NLW_X36_1I4_CARRY4_CO_UNCONNECTED[3:1],I1_0}),
        .CYINIT(\<const1> ),
        .DI({NLW_X36_1I4_CARRY4_DI_UNCONNECTED[3:1],\<const0> }),
        .O({NLW_X36_1I4_CARRY4_O_UNCONNECTED[3:1],n_0_X36_1I6}),
        .S({NLW_X36_1I4_CARRY4_S_UNCONNECTED[3:1],Q}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(n_0_FF5),
        .I1(I1_0),
        .O(n_0_X36_1I956));
endmodule

(* ORIG_REF_NAME = "CRC_64_32" *) 
module TriMACCRC_64_32_15
   (CRC_OK,
    SR,
    gtx_clk,
    I1,
    CRC1000_EN,
    SPEED_1_RESYNC_REG,
    CRC50_EN,
    SPEED_0_RESYNC_REG,
    tx_ce_sample);
  output CRC_OK;
  output [0:0]SR;
  input gtx_clk;
  input I1;
  input CRC1000_EN;
  input SPEED_1_RESYNC_REG;
  input CRC50_EN;
  input SPEED_0_RESYNC_REG;
  input tx_ce_sample;

  wire \<const0> ;
  wire \<const1> ;
  wire CE;
  wire CRC1000_EN;
  wire CRC50_EN;
  wire CRC_OK;
  wire D;
  wire I1;
  wire I1_0;
  wire Q;
  wire SPEED_0_RESYNC_REG;
  wire SPEED_1_RESYNC_REG;
  wire [0:0]SR;
  wire gtx_clk;
  wire lopt;
  wire n_0_CRC2;
  wire n_0_CRC3;
  wire n_0_CRC4;
  wire n_0_CRC5;
  wire n_0_FF2;
  wire n_0_FF3;
  wire n_0_FF4;
  wire n_0_FF5;
  wire n_0_X36_1I6;
  wire n_0_X36_1I956;
  wire tx_ce_sample;
  wire [3:1]NLW_X36_1I4_CARRY4_CO_UNCONNECTED;
  wire [3:1]NLW_X36_1I4_CARRY4_DI_UNCONNECTED;
  wire [3:1]NLW_X36_1I4_CARRY4_O_UNCONNECTED;
  wire [3:1]NLW_X36_1I4_CARRY4_S_UNCONNECTED;

TriMACCC8CE_16 CRC1
       (.CEO(D),
        .CRC1000_EN(CRC1000_EN),
        .CRC50_EN(CRC50_EN),
        .SPEED_0_RESYNC_REG(SPEED_0_RESYNC_REG),
        .SPEED_1_RESYNC_REG(SPEED_1_RESYNC_REG),
        .gtx_clk(gtx_clk),
        .tx_ce_sample(tx_ce_sample));
TriMACCC8CE_17 CRC2
       (.CE(CE),
        .CEO(n_0_CRC2),
        .gtx_clk(gtx_clk));
TriMACCC8CE_18 CRC3
       (.CE(n_0_FF2),
        .CEO(n_0_CRC3),
        .gtx_clk(gtx_clk));
TriMACCC8CE_19 CRC4
       (.CE(n_0_FF3),
        .CEO(n_0_CRC4),
        .gtx_clk(gtx_clk));
TriMACCC2CE_20 CRC5
       (.CE(n_0_FF4),
        .CEO(n_0_CRC5),
        .gtx_clk(gtx_clk));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF1
       (.C(gtx_clk),
        .CE(\<const1> ),
        .CLR(\<const0> ),
        .D(D),
        .Q(CE));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF2
       (.C(gtx_clk),
        .CE(\<const1> ),
        .CLR(\<const0> ),
        .D(n_0_CRC2),
        .Q(n_0_FF2));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF3
       (.C(gtx_clk),
        .CE(\<const1> ),
        .CLR(\<const0> ),
        .D(n_0_CRC3),
        .Q(n_0_FF3));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF4
       (.C(gtx_clk),
        .CE(\<const1> ),
        .CLR(\<const0> ),
        .D(n_0_CRC4),
        .Q(n_0_FF4));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF5
       (.C(gtx_clk),
        .CE(\<const1> ),
        .CLR(\<const0> ),
        .D(n_0_CRC5),
        .Q(n_0_FF5));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     FF6
       (.C(gtx_clk),
        .CE(n_0_X36_1I956),
        .CLR(\<const0> ),
        .D(\<const1> ),
        .Q(CRC_OK));
GND GND
       (.G(\<const0> ));
LUT2 #(
    .INIT(4'hE)) 
     STATUS_VALID_i_1
       (.I0(CRC_OK),
        .I1(I1),
        .O(SR));
VCC VCC
       (.P(\<const1> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   FDCE #(
    .INIT(1'b0),
    .IS_CLR_INVERTED(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0)) 
     X36_1I36
       (.C(gtx_clk),
        .CE(n_0_FF5),
        .CLR(\<const0> ),
        .D(n_0_X36_1I6),
        .Q(Q));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   CARRY4 X36_1I4_CARRY4
       (.CI(lopt),
        .CO({NLW_X36_1I4_CARRY4_CO_UNCONNECTED[3:1],I1_0}),
        .CYINIT(\<const1> ),
        .DI({NLW_X36_1I4_CARRY4_DI_UNCONNECTED[3:1],\<const0> }),
        .O({NLW_X36_1I4_CARRY4_O_UNCONNECTED[3:1],n_0_X36_1I6}),
        .S({NLW_X36_1I4_CARRY4_S_UNCONNECTED[3:1],Q}));
GND X36_1I4_CARRY4_GND
       (.G(lopt));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT2 #(
    .INIT(4'h8)) 
     X36_1I956
       (.I0(n_0_FF5),
        .I1(I1_0),
        .O(n_0_X36_1I956));
endmodule

module TriMACDECODE_FRAME
   (DATA_WITH_FCS,
    D,
    LESS_THAN_256,
    LENGTH_ONE,
    LENGTH_ZERO,
    DATA_NO_FCS,
    COMPUTE,
    CONTROL_MATCH,
    CONTROL_FRAME_INT,
    int_rx_control_frame,
    MULTICAST_MATCH,
    LENGTH_FIELD_MATCH,
    TYPE_FRAME,
    rx_statistics_vector,
    O1,
    O2,
    O3,
    O4,
    DATA_VALID_FINAL0,
    O5,
    E,
    O6,
    MAX_LENGTH_ERR3_out,
    O7,
    SR,
    I2,
    DATA_WITH_FCS0,
    I1,
    LESS_THAN_2560,
    RX_DV_REG7,
    LENGTH_ONE0,
    LENGTH_ZERO0,
    DATA_NO_FCS0,
    CRC_COMPUTE0,
    CONTROL_MATCH0,
    I3,
    I4,
    I5,
    I6,
    I7,
    I8,
    Q,
    I9,
    EXTENSION_FIELD,
    I10,
    I11,
    I12,
    LT_CHECK_HELD,
    PAUSE_LT_CHECK_HELD,
    EXCEEDED_MIN_LEN,
    I13,
    address_valid_early,
    VALIDATE_REQUIRED,
    DATA_FIELD,
    I14,
    pauseaddressmatch,
    specialpauseaddressmatch,
    I15,
    rx_enable_reg,
    I16,
    END_OF_DATA,
    I17,
    I18,
    FIELD_COUNTER,
    LENGTH_FIELD,
    I19,
    TYPE_PACKET10_out,
    I20,
    I21,
    I22);
  output DATA_WITH_FCS;
  output [17:0]D;
  output LESS_THAN_256;
  output LENGTH_ONE;
  output LENGTH_ZERO;
  output DATA_NO_FCS;
  output COMPUTE;
  output CONTROL_MATCH;
  output CONTROL_FRAME_INT;
  output int_rx_control_frame;
  output MULTICAST_MATCH;
  output LENGTH_FIELD_MATCH;
  output TYPE_FRAME;
  output [0:0]rx_statistics_vector;
  output O1;
  output O2;
  output O3;
  output O4;
  output DATA_VALID_FINAL0;
  output O5;
  output [0:0]E;
  output O6;
  output MAX_LENGTH_ERR3_out;
  output O7;
  input [0:0]SR;
  input I2;
  input DATA_WITH_FCS0;
  input I1;
  input LESS_THAN_2560;
  input RX_DV_REG7;
  input LENGTH_ONE0;
  input LENGTH_ZERO0;
  input DATA_NO_FCS0;
  input CRC_COMPUTE0;
  input CONTROL_MATCH0;
  input I3;
  input I4;
  input I5;
  input I6;
  input I7;
  input I8;
  input [7:0]Q;
  input I9;
  input EXTENSION_FIELD;
  input I10;
  input [14:0]I11;
  input I12;
  input LT_CHECK_HELD;
  input PAUSE_LT_CHECK_HELD;
  input EXCEEDED_MIN_LEN;
  input I13;
  input address_valid_early;
  input VALIDATE_REQUIRED;
  input DATA_FIELD;
  input I14;
  input pauseaddressmatch;
  input specialpauseaddressmatch;
  input I15;
  input rx_enable_reg;
  input I16;
  input END_OF_DATA;
  input I17;
  input [0:0]I18;
  input [0:0]FIELD_COUNTER;
  input LENGTH_FIELD;
  input I19;
  input TYPE_PACKET10_out;
  input I20;
  input [0:0]I21;
  input [0:0]I22;

  wire \<const0> ;
  wire \<const1> ;
  wire ADD_CONTROL_ENABLE;
  wire ADD_CONTROL_FRAME_INT;
  wire COMPUTE;
  wire CONTROL_FRAME_INT;
  wire CONTROL_MATCH;
  wire CONTROL_MATCH0;
  wire CRC_COMPUTE0;
  wire [17:0]D;
  wire [10:0]DATA_COUNTER_reg__0;
  wire DATA_FIELD;
  wire DATA_NO_FCS;
  wire DATA_NO_FCS0;
  wire DATA_VALID_FINAL0;
  wire DATA_WITH_FCS;
  wire DATA_WITH_FCS0;
  wire [0:0]E;
  wire END_OF_DATA;
  wire EQUAL;
  wire EXCEEDED_MIN_LEN;
  wire EXTENSION_FIELD;
  wire [0:0]FIELD_COUNTER;
  wire \FRAME_CHECKER/MAX_LENGTH_ERR21_in ;
  wire [14:14]FRAME_COUNTER;
  wire [7:0]FRAME_COUNTER__0;
  wire [13:8]FRAME_COUNTER_reg;
  wire I1;
  wire I10;
  wire [14:0]I11;
  wire I12;
  wire I13;
  wire I14;
  wire I15;
  wire I16;
  wire I17;
  wire [0:0]I18;
  wire I19;
  wire I2;
  wire I20;
  wire [0:0]I21;
  wire [0:0]I22;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire LENGTH_FIELD;
  wire LENGTH_FIELD_MATCH;
  wire LENGTH_ONE;
  wire LENGTH_ONE0;
  wire [10:0]LENGTH_TYPE;
  wire LENGTH_ZERO;
  wire LENGTH_ZERO0;
  wire LESS_THAN_256;
  wire LESS_THAN_2560;
  wire LT_CHECK_HELD;
  wire MAX_LENGTH_ERR3_out;
  wire MULTICAST_MATCH;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire O5;
  wire O6;
  wire O7;
  wire PADDED_FRAME;
  wire PAUSE_LT_CHECK_HELD;
  wire [7:0]Q;
  wire RX_DV_REG;
  wire RX_DV_REG7;
  wire [0:0]SR;
  wire TYPE_FRAME;
  wire TYPE_PACKET10_out;
  wire VALIDATE_REQUIRED;
  wire [0:0]VLAN_MATCH;
  wire address_valid_early;
  wire int_rx_control_frame;
  wire n_0_ADD_CONTROL_ENABLE_i_1;
  wire n_0_ADD_CONTROL_ENABLE_i_2;
  wire \n_0_DATA_COUNTER[10]_i_4 ;
  wire n_0_DATA_VALID_i_1;
  wire n_0_DATA_VALID_reg;
  wire \n_0_FRAME_COUNTER[0]_i_3 ;
  wire \n_0_FRAME_COUNTER[0]_i_4 ;
  wire \n_0_FRAME_COUNTER[0]_i_5 ;
  wire \n_0_FRAME_COUNTER[0]_i_6 ;
  wire \n_0_FRAME_COUNTER[12]_i_2 ;
  wire \n_0_FRAME_COUNTER[12]_i_3 ;
  wire \n_0_FRAME_COUNTER[12]_i_4 ;
  wire \n_0_FRAME_COUNTER[4]_i_2 ;
  wire \n_0_FRAME_COUNTER[4]_i_3 ;
  wire \n_0_FRAME_COUNTER[4]_i_4 ;
  wire \n_0_FRAME_COUNTER[4]_i_5 ;
  wire \n_0_FRAME_COUNTER[8]_i_2 ;
  wire \n_0_FRAME_COUNTER[8]_i_3 ;
  wire \n_0_FRAME_COUNTER[8]_i_4 ;
  wire \n_0_FRAME_COUNTER[8]_i_5 ;
  wire \n_0_FRAME_COUNTER_reg[0]_i_2 ;
  wire \n_0_FRAME_COUNTER_reg[4]_i_1 ;
  wire \n_0_FRAME_COUNTER_reg[8]_i_1 ;
  wire n_0_FRAME_LEN_ERR_i_3;
  wire n_0_LENGTH_MATCH_i_1;
  wire n_0_LENGTH_MATCH_i_3;
  wire n_0_LENGTH_MATCH_i_4;
  wire n_0_LENGTH_MATCH_i_5;
  wire n_0_LENGTH_MATCH_i_6;
  wire \n_0_LENGTH_TYPE[0]_i_1 ;
  wire \n_0_LENGTH_TYPE[10]_i_1 ;
  wire \n_0_LENGTH_TYPE[1]_i_1 ;
  wire \n_0_LENGTH_TYPE[2]_i_1 ;
  wire \n_0_LENGTH_TYPE[3]_i_1 ;
  wire \n_0_LENGTH_TYPE[4]_i_1 ;
  wire \n_0_LENGTH_TYPE[5]_i_1 ;
  wire \n_0_LENGTH_TYPE[6]_i_1 ;
  wire \n_0_LENGTH_TYPE[7]_i_1 ;
  wire \n_0_LENGTH_TYPE[8]_i_1 ;
  wire \n_0_LENGTH_TYPE[9]_i_1 ;
  wire n_0_MAX_LENGTH_ERR_i_10;
  wire n_0_MAX_LENGTH_ERR_i_4;
  wire n_0_MAX_LENGTH_ERR_i_5;
  wire n_0_MAX_LENGTH_ERR_i_6;
  wire n_0_MAX_LENGTH_ERR_i_7;
  wire n_0_MAX_LENGTH_ERR_i_8;
  wire n_0_MAX_LENGTH_ERR_i_9;
  wire n_0_MIN_LENGTH_MATCH_i_2;
  wire n_0_PADDED_FRAME_i_1;
  wire n_0_PADDED_FRAME_i_2;
  wire n_0_PADDED_FRAME_i_3;
  wire \n_0_STATISTICS_LENGTH[13]_i_1 ;
  wire \n_0_VLAN_MATCH[1]_i_1 ;
  wire \n_0_VLAN_MATCH[1]_i_2 ;
  wire \n_0_VLAN_MATCH_reg[1] ;
  wire \n_1_FRAME_COUNTER_reg[0]_i_2 ;
  wire \n_1_FRAME_COUNTER_reg[4]_i_1 ;
  wire \n_1_FRAME_COUNTER_reg[8]_i_1 ;
  wire n_1_LENGTH_MATCH_reg_i_2;
  wire n_1_MAX_LENGTH_ERR_reg_i_3;
  wire \n_2_FRAME_COUNTER_reg[0]_i_2 ;
  wire \n_2_FRAME_COUNTER_reg[12]_i_1 ;
  wire \n_2_FRAME_COUNTER_reg[4]_i_1 ;
  wire \n_2_FRAME_COUNTER_reg[8]_i_1 ;
  wire n_2_LENGTH_MATCH_reg_i_2;
  wire n_2_MAX_LENGTH_ERR_reg_i_3;
  wire \n_3_FRAME_COUNTER_reg[0]_i_2 ;
  wire \n_3_FRAME_COUNTER_reg[12]_i_1 ;
  wire \n_3_FRAME_COUNTER_reg[4]_i_1 ;
  wire \n_3_FRAME_COUNTER_reg[8]_i_1 ;
  wire n_3_LENGTH_MATCH_reg_i_2;
  wire n_3_MAX_LENGTH_ERR_reg_i_3;
  wire \n_4_FRAME_COUNTER_reg[0]_i_2 ;
  wire \n_4_FRAME_COUNTER_reg[4]_i_1 ;
  wire \n_4_FRAME_COUNTER_reg[8]_i_1 ;
  wire \n_5_FRAME_COUNTER_reg[0]_i_2 ;
  wire \n_5_FRAME_COUNTER_reg[12]_i_1 ;
  wire \n_5_FRAME_COUNTER_reg[4]_i_1 ;
  wire \n_5_FRAME_COUNTER_reg[8]_i_1 ;
  wire \n_6_FRAME_COUNTER_reg[0]_i_2 ;
  wire \n_6_FRAME_COUNTER_reg[12]_i_1 ;
  wire \n_6_FRAME_COUNTER_reg[4]_i_1 ;
  wire \n_6_FRAME_COUNTER_reg[8]_i_1 ;
  wire \n_7_FRAME_COUNTER_reg[0]_i_2 ;
  wire \n_7_FRAME_COUNTER_reg[12]_i_1 ;
  wire \n_7_FRAME_COUNTER_reg[4]_i_1 ;
  wire \n_7_FRAME_COUNTER_reg[8]_i_1 ;
  wire [10:0]p_0_in__1;
  wire pauseaddressmatch;
  wire rx_enable_reg;
  wire [0:0]rx_statistics_vector;
  wire specialpauseaddressmatch;
  wire [3:2]\NLW_FRAME_COUNTER_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_FRAME_COUNTER_reg[12]_i_1_O_UNCONNECTED ;
  wire [3:0]NLW_LENGTH_MATCH_reg_i_2_O_UNCONNECTED;
  wire [3:0]NLW_MAX_LENGTH_ERR_reg_i_3_O_UNCONNECTED;

LUT5 #(
    .INIT(32'h080A0A0A)) 
     ADD_CONTROL_ENABLE_i_1
       (.I0(n_0_ADD_CONTROL_ENABLE_i_2),
        .I1(CONTROL_MATCH),
        .I2(SR),
        .I3(I10),
        .I4(I2),
        .O(n_0_ADD_CONTROL_ENABLE_i_1));
LUT6 #(
    .INIT(64'hA8FFFFFFA8000000)) 
     ADD_CONTROL_ENABLE_i_2
       (.I0(O4),
        .I1(pauseaddressmatch),
        .I2(specialpauseaddressmatch),
        .I3(I2),
        .I4(CONTROL_MATCH),
        .I5(ADD_CONTROL_ENABLE),
        .O(n_0_ADD_CONTROL_ENABLE_i_2));
FDRE ADD_CONTROL_ENABLE_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_ADD_CONTROL_ENABLE_i_1),
        .Q(ADD_CONTROL_ENABLE),
        .R(\<const0> ));
FDRE ADD_CONTROL_FRAME_INT_reg
       (.C(I1),
        .CE(I2),
        .D(ADD_CONTROL_ENABLE),
        .Q(ADD_CONTROL_FRAME_INT),
        .R(SR));
FDRE ADD_CONTROL_FRAME_reg
       (.C(I1),
        .CE(I2),
        .D(ADD_CONTROL_FRAME_INT),
        .Q(int_rx_control_frame),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair86" *) 
   LUT5 #(
    .INIT(32'h00000010)) 
     CONTROL_FRAME_INT_i_2
       (.I0(O3),
        .I1(Q[1]),
        .I2(Q[3]),
        .I3(Q[0]),
        .I4(Q[2]),
        .O(O4));
FDRE CONTROL_FRAME_INT_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(I4),
        .Q(CONTROL_FRAME_INT),
        .R(\<const0> ));
FDRE CONTROL_FRAME_reg
       (.C(I1),
        .CE(I2),
        .D(CONTROL_FRAME_INT),
        .Q(D[15]),
        .R(SR));
FDRE CONTROL_MATCH_reg
       (.C(I1),
        .CE(I2),
        .D(CONTROL_MATCH0),
        .Q(CONTROL_MATCH),
        .R(SR));
FDRE COUNT_THIS_BYTE_reg
       (.C(I1),
        .CE(I2),
        .D(DATA_WITH_FCS),
        .Q(D[17]),
        .R(\<const0> ));
FDRE CRC_COMPUTE_reg
       (.C(I1),
        .CE(I2),
        .D(CRC_COMPUTE0),
        .Q(COMPUTE),
        .R(SR));
LUT1 #(
    .INIT(2'h1)) 
     \DATA_COUNTER[0]_i_1 
       (.I0(DATA_COUNTER_reg__0[0]),
        .O(p_0_in__1[0]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \DATA_COUNTER[10]_i_3 
       (.I0(DATA_COUNTER_reg__0[10]),
        .I1(DATA_COUNTER_reg__0[6]),
        .I2(\n_0_DATA_COUNTER[10]_i_4 ),
        .I3(DATA_COUNTER_reg__0[7]),
        .I4(DATA_COUNTER_reg__0[8]),
        .I5(DATA_COUNTER_reg__0[9]),
        .O(p_0_in__1[10]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \DATA_COUNTER[10]_i_4 
       (.I0(DATA_COUNTER_reg__0[3]),
        .I1(DATA_COUNTER_reg__0[0]),
        .I2(DATA_COUNTER_reg__0[1]),
        .I3(DATA_COUNTER_reg__0[2]),
        .I4(DATA_COUNTER_reg__0[4]),
        .I5(DATA_COUNTER_reg__0[5]),
        .O(\n_0_DATA_COUNTER[10]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair88" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \DATA_COUNTER[1]_i_1 
       (.I0(DATA_COUNTER_reg__0[0]),
        .I1(DATA_COUNTER_reg__0[1]),
        .O(p_0_in__1[1]));
(* SOFT_HLUTNM = "soft_lutpair88" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \DATA_COUNTER[2]_i_1 
       (.I0(DATA_COUNTER_reg__0[2]),
        .I1(DATA_COUNTER_reg__0[1]),
        .I2(DATA_COUNTER_reg__0[0]),
        .O(p_0_in__1[2]));
(* SOFT_HLUTNM = "soft_lutpair83" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \DATA_COUNTER[3]_i_1 
       (.I0(DATA_COUNTER_reg__0[3]),
        .I1(DATA_COUNTER_reg__0[0]),
        .I2(DATA_COUNTER_reg__0[1]),
        .I3(DATA_COUNTER_reg__0[2]),
        .O(p_0_in__1[3]));
(* SOFT_HLUTNM = "soft_lutpair83" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \DATA_COUNTER[4]_i_1 
       (.I0(DATA_COUNTER_reg__0[4]),
        .I1(DATA_COUNTER_reg__0[2]),
        .I2(DATA_COUNTER_reg__0[1]),
        .I3(DATA_COUNTER_reg__0[0]),
        .I4(DATA_COUNTER_reg__0[3]),
        .O(p_0_in__1[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \DATA_COUNTER[5]_i_1 
       (.I0(DATA_COUNTER_reg__0[5]),
        .I1(DATA_COUNTER_reg__0[3]),
        .I2(DATA_COUNTER_reg__0[0]),
        .I3(DATA_COUNTER_reg__0[1]),
        .I4(DATA_COUNTER_reg__0[2]),
        .I5(DATA_COUNTER_reg__0[4]),
        .O(p_0_in__1[5]));
(* SOFT_HLUTNM = "soft_lutpair89" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \DATA_COUNTER[6]_i_1 
       (.I0(DATA_COUNTER_reg__0[6]),
        .I1(\n_0_DATA_COUNTER[10]_i_4 ),
        .O(p_0_in__1[6]));
(* SOFT_HLUTNM = "soft_lutpair89" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \DATA_COUNTER[7]_i_1 
       (.I0(DATA_COUNTER_reg__0[7]),
        .I1(\n_0_DATA_COUNTER[10]_i_4 ),
        .I2(DATA_COUNTER_reg__0[6]),
        .O(p_0_in__1[7]));
(* SOFT_HLUTNM = "soft_lutpair84" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \DATA_COUNTER[8]_i_1 
       (.I0(DATA_COUNTER_reg__0[8]),
        .I1(DATA_COUNTER_reg__0[6]),
        .I2(\n_0_DATA_COUNTER[10]_i_4 ),
        .I3(DATA_COUNTER_reg__0[7]),
        .O(p_0_in__1[8]));
(* SOFT_HLUTNM = "soft_lutpair84" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \DATA_COUNTER[9]_i_1 
       (.I0(DATA_COUNTER_reg__0[9]),
        .I1(DATA_COUNTER_reg__0[8]),
        .I2(DATA_COUNTER_reg__0[7]),
        .I3(\n_0_DATA_COUNTER[10]_i_4 ),
        .I4(DATA_COUNTER_reg__0[6]),
        .O(p_0_in__1[9]));
(* counter = "11" *) 
   FDRE \DATA_COUNTER_reg[0] 
       (.C(I1),
        .CE(I22),
        .D(p_0_in__1[0]),
        .Q(DATA_COUNTER_reg__0[0]),
        .R(I21));
(* counter = "11" *) 
   FDRE \DATA_COUNTER_reg[10] 
       (.C(I1),
        .CE(I22),
        .D(p_0_in__1[10]),
        .Q(DATA_COUNTER_reg__0[10]),
        .R(I21));
(* counter = "11" *) 
   FDRE \DATA_COUNTER_reg[1] 
       (.C(I1),
        .CE(I22),
        .D(p_0_in__1[1]),
        .Q(DATA_COUNTER_reg__0[1]),
        .R(I21));
(* counter = "11" *) 
   FDRE \DATA_COUNTER_reg[2] 
       (.C(I1),
        .CE(I22),
        .D(p_0_in__1[2]),
        .Q(DATA_COUNTER_reg__0[2]),
        .R(I21));
(* counter = "11" *) 
   FDRE \DATA_COUNTER_reg[3] 
       (.C(I1),
        .CE(I22),
        .D(p_0_in__1[3]),
        .Q(DATA_COUNTER_reg__0[3]),
        .R(I21));
(* counter = "11" *) 
   FDRE \DATA_COUNTER_reg[4] 
       (.C(I1),
        .CE(I22),
        .D(p_0_in__1[4]),
        .Q(DATA_COUNTER_reg__0[4]),
        .R(I21));
(* counter = "11" *) 
   FDRE \DATA_COUNTER_reg[5] 
       (.C(I1),
        .CE(I22),
        .D(p_0_in__1[5]),
        .Q(DATA_COUNTER_reg__0[5]),
        .R(I21));
(* counter = "11" *) 
   FDRE \DATA_COUNTER_reg[6] 
       (.C(I1),
        .CE(I22),
        .D(p_0_in__1[6]),
        .Q(DATA_COUNTER_reg__0[6]),
        .R(I21));
(* counter = "11" *) 
   FDRE \DATA_COUNTER_reg[7] 
       (.C(I1),
        .CE(I22),
        .D(p_0_in__1[7]),
        .Q(DATA_COUNTER_reg__0[7]),
        .R(I21));
(* counter = "11" *) 
   FDRE \DATA_COUNTER_reg[8] 
       (.C(I1),
        .CE(I22),
        .D(p_0_in__1[8]),
        .Q(DATA_COUNTER_reg__0[8]),
        .R(I21));
(* counter = "11" *) 
   FDRE \DATA_COUNTER_reg[9] 
       (.C(I1),
        .CE(I22),
        .D(p_0_in__1[9]),
        .Q(DATA_COUNTER_reg__0[9]),
        .R(I21));
FDRE DATA_NO_FCS_reg
       (.C(I1),
        .CE(I2),
        .D(DATA_NO_FCS0),
        .Q(DATA_NO_FCS),
        .R(SR));
LUT3 #(
    .INIT(8'hA8)) 
     DATA_VALID_FINAL_i_1
       (.I0(n_0_DATA_VALID_reg),
        .I1(address_valid_early),
        .I2(VALIDATE_REQUIRED),
        .O(DATA_VALID_FINAL0));
LUT6 #(
    .INIT(64'h8888888B88888888)) 
     DATA_VALID_i_1
       (.I0(DATA_WITH_FCS),
        .I1(I9),
        .I2(EXTENSION_FIELD),
        .I3(I10),
        .I4(LENGTH_ZERO),
        .I5(DATA_NO_FCS),
        .O(n_0_DATA_VALID_i_1));
FDRE DATA_VALID_reg
       (.C(I1),
        .CE(I2),
        .D(n_0_DATA_VALID_i_1),
        .Q(n_0_DATA_VALID_reg),
        .R(SR));
FDRE DATA_WITH_FCS_reg
       (.C(I1),
        .CE(I2),
        .D(DATA_WITH_FCS0),
        .Q(DATA_WITH_FCS),
        .R(SR));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[0]_i_3 
       (.I0(FRAME_COUNTER__0[3]),
        .O(\n_0_FRAME_COUNTER[0]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[0]_i_4 
       (.I0(FRAME_COUNTER__0[2]),
        .O(\n_0_FRAME_COUNTER[0]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[0]_i_5 
       (.I0(FRAME_COUNTER__0[1]),
        .O(\n_0_FRAME_COUNTER[0]_i_5 ));
LUT1 #(
    .INIT(2'h1)) 
     \FRAME_COUNTER[0]_i_6 
       (.I0(FRAME_COUNTER__0[0]),
        .O(\n_0_FRAME_COUNTER[0]_i_6 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[12]_i_2 
       (.I0(FRAME_COUNTER),
        .O(\n_0_FRAME_COUNTER[12]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[12]_i_3 
       (.I0(FRAME_COUNTER_reg[13]),
        .O(\n_0_FRAME_COUNTER[12]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[12]_i_4 
       (.I0(FRAME_COUNTER_reg[12]),
        .O(\n_0_FRAME_COUNTER[12]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[4]_i_2 
       (.I0(FRAME_COUNTER__0[7]),
        .O(\n_0_FRAME_COUNTER[4]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[4]_i_3 
       (.I0(FRAME_COUNTER__0[6]),
        .O(\n_0_FRAME_COUNTER[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[4]_i_4 
       (.I0(FRAME_COUNTER__0[5]),
        .O(\n_0_FRAME_COUNTER[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[4]_i_5 
       (.I0(FRAME_COUNTER__0[4]),
        .O(\n_0_FRAME_COUNTER[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[8]_i_2 
       (.I0(FRAME_COUNTER_reg[11]),
        .O(\n_0_FRAME_COUNTER[8]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[8]_i_3 
       (.I0(FRAME_COUNTER_reg[10]),
        .O(\n_0_FRAME_COUNTER[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[8]_i_4 
       (.I0(FRAME_COUNTER_reg[9]),
        .O(\n_0_FRAME_COUNTER[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNTER[8]_i_5 
       (.I0(FRAME_COUNTER_reg[8]),
        .O(\n_0_FRAME_COUNTER[8]_i_5 ));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[0] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_7_FRAME_COUNTER_reg[0]_i_2 ),
        .Q(FRAME_COUNTER__0[0]),
        .R(I20));
CARRY4 \FRAME_COUNTER_reg[0]_i_2 
       (.CI(\<const0> ),
        .CO({\n_0_FRAME_COUNTER_reg[0]_i_2 ,\n_1_FRAME_COUNTER_reg[0]_i_2 ,\n_2_FRAME_COUNTER_reg[0]_i_2 ,\n_3_FRAME_COUNTER_reg[0]_i_2 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const1> }),
        .O({\n_4_FRAME_COUNTER_reg[0]_i_2 ,\n_5_FRAME_COUNTER_reg[0]_i_2 ,\n_6_FRAME_COUNTER_reg[0]_i_2 ,\n_7_FRAME_COUNTER_reg[0]_i_2 }),
        .S({\n_0_FRAME_COUNTER[0]_i_3 ,\n_0_FRAME_COUNTER[0]_i_4 ,\n_0_FRAME_COUNTER[0]_i_5 ,\n_0_FRAME_COUNTER[0]_i_6 }));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[10] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_5_FRAME_COUNTER_reg[8]_i_1 ),
        .Q(FRAME_COUNTER_reg[10]),
        .R(I20));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[11] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_4_FRAME_COUNTER_reg[8]_i_1 ),
        .Q(FRAME_COUNTER_reg[11]),
        .R(I20));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[12] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_7_FRAME_COUNTER_reg[12]_i_1 ),
        .Q(FRAME_COUNTER_reg[12]),
        .R(I20));
CARRY4 \FRAME_COUNTER_reg[12]_i_1 
       (.CI(\n_0_FRAME_COUNTER_reg[8]_i_1 ),
        .CO({\NLW_FRAME_COUNTER_reg[12]_i_1_CO_UNCONNECTED [3:2],\n_2_FRAME_COUNTER_reg[12]_i_1 ,\n_3_FRAME_COUNTER_reg[12]_i_1 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\NLW_FRAME_COUNTER_reg[12]_i_1_O_UNCONNECTED [3],\n_5_FRAME_COUNTER_reg[12]_i_1 ,\n_6_FRAME_COUNTER_reg[12]_i_1 ,\n_7_FRAME_COUNTER_reg[12]_i_1 }),
        .S({\<const0> ,\n_0_FRAME_COUNTER[12]_i_2 ,\n_0_FRAME_COUNTER[12]_i_3 ,\n_0_FRAME_COUNTER[12]_i_4 }));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[13] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_6_FRAME_COUNTER_reg[12]_i_1 ),
        .Q(FRAME_COUNTER_reg[13]),
        .R(I20));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[14] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_5_FRAME_COUNTER_reg[12]_i_1 ),
        .Q(FRAME_COUNTER),
        .R(I20));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[1] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_6_FRAME_COUNTER_reg[0]_i_2 ),
        .Q(FRAME_COUNTER__0[1]),
        .R(I20));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[2] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_5_FRAME_COUNTER_reg[0]_i_2 ),
        .Q(FRAME_COUNTER__0[2]),
        .R(I20));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[3] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_4_FRAME_COUNTER_reg[0]_i_2 ),
        .Q(FRAME_COUNTER__0[3]),
        .R(I20));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[4] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_7_FRAME_COUNTER_reg[4]_i_1 ),
        .Q(FRAME_COUNTER__0[4]),
        .R(I20));
CARRY4 \FRAME_COUNTER_reg[4]_i_1 
       (.CI(\n_0_FRAME_COUNTER_reg[0]_i_2 ),
        .CO({\n_0_FRAME_COUNTER_reg[4]_i_1 ,\n_1_FRAME_COUNTER_reg[4]_i_1 ,\n_2_FRAME_COUNTER_reg[4]_i_1 ,\n_3_FRAME_COUNTER_reg[4]_i_1 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\n_4_FRAME_COUNTER_reg[4]_i_1 ,\n_5_FRAME_COUNTER_reg[4]_i_1 ,\n_6_FRAME_COUNTER_reg[4]_i_1 ,\n_7_FRAME_COUNTER_reg[4]_i_1 }),
        .S({\n_0_FRAME_COUNTER[4]_i_2 ,\n_0_FRAME_COUNTER[4]_i_3 ,\n_0_FRAME_COUNTER[4]_i_4 ,\n_0_FRAME_COUNTER[4]_i_5 }));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[5] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_6_FRAME_COUNTER_reg[4]_i_1 ),
        .Q(FRAME_COUNTER__0[5]),
        .R(I20));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[6] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_5_FRAME_COUNTER_reg[4]_i_1 ),
        .Q(FRAME_COUNTER__0[6]),
        .R(I20));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[7] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_4_FRAME_COUNTER_reg[4]_i_1 ),
        .Q(FRAME_COUNTER__0[7]),
        .R(I20));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[8] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_7_FRAME_COUNTER_reg[8]_i_1 ),
        .Q(FRAME_COUNTER_reg[8]),
        .R(I20));
CARRY4 \FRAME_COUNTER_reg[8]_i_1 
       (.CI(\n_0_FRAME_COUNTER_reg[4]_i_1 ),
        .CO({\n_0_FRAME_COUNTER_reg[8]_i_1 ,\n_1_FRAME_COUNTER_reg[8]_i_1 ,\n_2_FRAME_COUNTER_reg[8]_i_1 ,\n_3_FRAME_COUNTER_reg[8]_i_1 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\n_4_FRAME_COUNTER_reg[8]_i_1 ,\n_5_FRAME_COUNTER_reg[8]_i_1 ,\n_6_FRAME_COUNTER_reg[8]_i_1 ,\n_7_FRAME_COUNTER_reg[8]_i_1 }),
        .S({\n_0_FRAME_COUNTER[8]_i_2 ,\n_0_FRAME_COUNTER[8]_i_3 ,\n_0_FRAME_COUNTER[8]_i_4 ,\n_0_FRAME_COUNTER[8]_i_5 }));
(* counter = "10" *) 
   FDRE \FRAME_COUNTER_reg[9] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(\n_6_FRAME_COUNTER_reg[8]_i_1 ),
        .Q(FRAME_COUNTER_reg[9]),
        .R(I20));
LUT6 #(
    .INIT(64'hFFFE0000FFFFFFFF)) 
     FRAME_LEN_ERR_i_2
       (.I0(TYPE_FRAME),
        .I1(LT_CHECK_HELD),
        .I2(PADDED_FRAME),
        .I3(LENGTH_FIELD_MATCH),
        .I4(n_0_FRAME_LEN_ERR_i_3),
        .I5(END_OF_DATA),
        .O(O6));
LUT6 #(
    .INIT(64'hD0DDFFFFD0DDD0DD)) 
     FRAME_LEN_ERR_i_3
       (.I0(PADDED_FRAME),
        .I1(LT_CHECK_HELD),
        .I2(PAUSE_LT_CHECK_HELD),
        .I3(D[15]),
        .I4(EXCEEDED_MIN_LEN),
        .I5(I13),
        .O(n_0_FRAME_LEN_ERR_i_3));
GND GND
       (.G(\<const0> ));
LUT6 #(
    .INIT(64'h0000000000AAE2AA)) 
     LENGTH_MATCH_i_1
       (.I0(LENGTH_FIELD_MATCH),
        .I1(DATA_FIELD),
        .I2(EQUAL),
        .I3(I2),
        .I4(I10),
        .I5(SR),
        .O(n_0_LENGTH_MATCH_i_1));
LUT4 #(
    .INIT(16'h9009)) 
     LENGTH_MATCH_i_3
       (.I0(LENGTH_TYPE[9]),
        .I1(DATA_COUNTER_reg__0[9]),
        .I2(LENGTH_TYPE[10]),
        .I3(DATA_COUNTER_reg__0[10]),
        .O(n_0_LENGTH_MATCH_i_3));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     LENGTH_MATCH_i_4
       (.I0(LENGTH_TYPE[8]),
        .I1(DATA_COUNTER_reg__0[8]),
        .I2(DATA_COUNTER_reg__0[6]),
        .I3(LENGTH_TYPE[6]),
        .I4(DATA_COUNTER_reg__0[7]),
        .I5(LENGTH_TYPE[7]),
        .O(n_0_LENGTH_MATCH_i_4));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     LENGTH_MATCH_i_5
       (.I0(LENGTH_TYPE[5]),
        .I1(DATA_COUNTER_reg__0[5]),
        .I2(DATA_COUNTER_reg__0[3]),
        .I3(LENGTH_TYPE[3]),
        .I4(DATA_COUNTER_reg__0[4]),
        .I5(LENGTH_TYPE[4]),
        .O(n_0_LENGTH_MATCH_i_5));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     LENGTH_MATCH_i_6
       (.I0(LENGTH_TYPE[0]),
        .I1(DATA_COUNTER_reg__0[0]),
        .I2(DATA_COUNTER_reg__0[1]),
        .I3(LENGTH_TYPE[1]),
        .I4(DATA_COUNTER_reg__0[2]),
        .I5(LENGTH_TYPE[2]),
        .O(n_0_LENGTH_MATCH_i_6));
FDRE LENGTH_MATCH_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_LENGTH_MATCH_i_1),
        .Q(LENGTH_FIELD_MATCH),
        .R(\<const0> ));
CARRY4 LENGTH_MATCH_reg_i_2
       (.CI(\<const0> ),
        .CO({EQUAL,n_1_LENGTH_MATCH_reg_i_2,n_2_LENGTH_MATCH_reg_i_2,n_3_LENGTH_MATCH_reg_i_2}),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(NLW_LENGTH_MATCH_reg_i_2_O_UNCONNECTED[3:0]),
        .S({n_0_LENGTH_MATCH_i_3,n_0_LENGTH_MATCH_i_4,n_0_LENGTH_MATCH_i_5,n_0_LENGTH_MATCH_i_6}));
(* SOFT_HLUTNM = "soft_lutpair87" *) 
   LUT4 #(
    .INIT(16'hFFEF)) 
     LENGTH_ONE_i_2
       (.I0(Q[1]),
        .I1(Q[3]),
        .I2(Q[0]),
        .I3(Q[2]),
        .O(O1));
(* SOFT_HLUTNM = "soft_lutpair85" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     LENGTH_ONE_i_3
       (.I0(Q[4]),
        .I1(Q[5]),
        .I2(Q[6]),
        .I3(Q[7]),
        .O(O3));
FDRE LENGTH_ONE_reg
       (.C(I1),
        .CE(I2),
        .D(LENGTH_ONE0),
        .Q(LENGTH_ONE),
        .R(SR));
LUT6 #(
    .INIT(64'hFFFBFFFBFFF8FCF8)) 
     \LENGTH_TYPE[0]_i_1 
       (.I0(Q[0]),
        .I1(I16),
        .I2(SR),
        .I3(I19),
        .I4(I2),
        .I5(LENGTH_TYPE[0]),
        .O(\n_0_LENGTH_TYPE[0]_i_1 ));
LUT6 #(
    .INIT(64'hFEFEFFFFFEFEFCCC)) 
     \LENGTH_TYPE[10]_i_1 
       (.I0(Q[2]),
        .I1(SR),
        .I2(I19),
        .I3(I2),
        .I4(TYPE_PACKET10_out),
        .I5(LENGTH_TYPE[10]),
        .O(\n_0_LENGTH_TYPE[10]_i_1 ));
LUT6 #(
    .INIT(64'hFFFBFFFBFFF8FCF8)) 
     \LENGTH_TYPE[1]_i_1 
       (.I0(Q[1]),
        .I1(I16),
        .I2(SR),
        .I3(I19),
        .I4(I2),
        .I5(LENGTH_TYPE[1]),
        .O(\n_0_LENGTH_TYPE[1]_i_1 ));
LUT6 #(
    .INIT(64'hFFFBFFFBFFF8FCF8)) 
     \LENGTH_TYPE[2]_i_1 
       (.I0(Q[2]),
        .I1(I16),
        .I2(SR),
        .I3(I19),
        .I4(I2),
        .I5(LENGTH_TYPE[2]),
        .O(\n_0_LENGTH_TYPE[2]_i_1 ));
LUT6 #(
    .INIT(64'hFFFBFFFBFFF8FCF8)) 
     \LENGTH_TYPE[3]_i_1 
       (.I0(Q[3]),
        .I1(I16),
        .I2(SR),
        .I3(I19),
        .I4(I2),
        .I5(LENGTH_TYPE[3]),
        .O(\n_0_LENGTH_TYPE[3]_i_1 ));
LUT6 #(
    .INIT(64'hFFFBFFFBFFF8FCF8)) 
     \LENGTH_TYPE[4]_i_1 
       (.I0(Q[4]),
        .I1(I16),
        .I2(SR),
        .I3(I19),
        .I4(I2),
        .I5(LENGTH_TYPE[4]),
        .O(\n_0_LENGTH_TYPE[4]_i_1 ));
LUT6 #(
    .INIT(64'hFFFBFFFBFFF8FCF8)) 
     \LENGTH_TYPE[5]_i_1 
       (.I0(Q[5]),
        .I1(I16),
        .I2(SR),
        .I3(I19),
        .I4(I2),
        .I5(LENGTH_TYPE[5]),
        .O(\n_0_LENGTH_TYPE[5]_i_1 ));
LUT6 #(
    .INIT(64'hFFFBFFFBFFF8FCF8)) 
     \LENGTH_TYPE[6]_i_1 
       (.I0(Q[6]),
        .I1(I16),
        .I2(SR),
        .I3(I19),
        .I4(I2),
        .I5(LENGTH_TYPE[6]),
        .O(\n_0_LENGTH_TYPE[6]_i_1 ));
LUT6 #(
    .INIT(64'hFFFBFFFBFFF8FCF8)) 
     \LENGTH_TYPE[7]_i_1 
       (.I0(Q[7]),
        .I1(I16),
        .I2(SR),
        .I3(I19),
        .I4(I2),
        .I5(LENGTH_TYPE[7]),
        .O(\n_0_LENGTH_TYPE[7]_i_1 ));
LUT6 #(
    .INIT(64'hFEFEFFFFFEFEFCCC)) 
     \LENGTH_TYPE[8]_i_1 
       (.I0(Q[0]),
        .I1(SR),
        .I2(I19),
        .I3(I2),
        .I4(TYPE_PACKET10_out),
        .I5(LENGTH_TYPE[8]),
        .O(\n_0_LENGTH_TYPE[8]_i_1 ));
LUT6 #(
    .INIT(64'hFEFEFFFFFEFEFCCC)) 
     \LENGTH_TYPE[9]_i_1 
       (.I0(Q[1]),
        .I1(SR),
        .I2(I19),
        .I3(I2),
        .I4(TYPE_PACKET10_out),
        .I5(LENGTH_TYPE[9]),
        .O(\n_0_LENGTH_TYPE[9]_i_1 ));
FDRE \LENGTH_TYPE_reg[0] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_LENGTH_TYPE[0]_i_1 ),
        .Q(LENGTH_TYPE[0]),
        .R(\<const0> ));
FDRE \LENGTH_TYPE_reg[10] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_LENGTH_TYPE[10]_i_1 ),
        .Q(LENGTH_TYPE[10]),
        .R(\<const0> ));
FDRE \LENGTH_TYPE_reg[1] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_LENGTH_TYPE[1]_i_1 ),
        .Q(LENGTH_TYPE[1]),
        .R(\<const0> ));
FDRE \LENGTH_TYPE_reg[2] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_LENGTH_TYPE[2]_i_1 ),
        .Q(LENGTH_TYPE[2]),
        .R(\<const0> ));
FDRE \LENGTH_TYPE_reg[3] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_LENGTH_TYPE[3]_i_1 ),
        .Q(LENGTH_TYPE[3]),
        .R(\<const0> ));
FDRE \LENGTH_TYPE_reg[4] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_LENGTH_TYPE[4]_i_1 ),
        .Q(LENGTH_TYPE[4]),
        .R(\<const0> ));
FDRE \LENGTH_TYPE_reg[5] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_LENGTH_TYPE[5]_i_1 ),
        .Q(LENGTH_TYPE[5]),
        .R(\<const0> ));
FDRE \LENGTH_TYPE_reg[6] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_LENGTH_TYPE[6]_i_1 ),
        .Q(LENGTH_TYPE[6]),
        .R(\<const0> ));
FDRE \LENGTH_TYPE_reg[7] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_LENGTH_TYPE[7]_i_1 ),
        .Q(LENGTH_TYPE[7]),
        .R(\<const0> ));
FDRE \LENGTH_TYPE_reg[8] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_LENGTH_TYPE[8]_i_1 ),
        .Q(LENGTH_TYPE[8]),
        .R(\<const0> ));
FDRE \LENGTH_TYPE_reg[9] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_LENGTH_TYPE[9]_i_1 ),
        .Q(LENGTH_TYPE[9]),
        .R(\<const0> ));
FDRE LENGTH_ZERO_reg
       (.C(I1),
        .CE(I2),
        .D(LENGTH_ZERO0),
        .Q(LENGTH_ZERO),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair86" *) 
   LUT5 #(
    .INIT(32'h00000001)) 
     LESS_THAN_256_i_2
       (.I0(O3),
        .I1(Q[3]),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(Q[2]),
        .O(O2));
FDRE LESS_THAN_256_reg
       (.C(I1),
        .CE(I2),
        .D(LESS_THAN_2560),
        .Q(LESS_THAN_256),
        .R(SR));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     MAX_LENGTH_ERR_i_10
       (.I0(FRAME_COUNTER__0[4]),
        .I1(I11[4]),
        .I2(FRAME_COUNTER__0[3]),
        .I3(I11[3]),
        .I4(I11[2]),
        .I5(FRAME_COUNTER__0[2]),
        .O(n_0_MAX_LENGTH_ERR_i_10));
LUT4 #(
    .INIT(16'h2000)) 
     MAX_LENGTH_ERR_i_2
       (.I0(\FRAME_CHECKER/MAX_LENGTH_ERR21_in ),
        .I1(EXTENSION_FIELD),
        .I2(n_0_MAX_LENGTH_ERR_i_4),
        .I3(n_0_MAX_LENGTH_ERR_i_5),
        .O(MAX_LENGTH_ERR3_out));
LUT6 #(
    .INIT(64'hFFFF04FF00000400)) 
     MAX_LENGTH_ERR_i_4
       (.I0(FRAME_COUNTER__0[2]),
        .I1(FRAME_COUNTER__0[4]),
        .I2(FRAME_COUNTER__0[3]),
        .I3(D[16]),
        .I4(I12),
        .I5(n_0_MAX_LENGTH_ERR_i_10),
        .O(n_0_MAX_LENGTH_ERR_i_4));
LUT5 #(
    .INIT(32'h82000082)) 
     MAX_LENGTH_ERR_i_5
       (.I0(I2),
        .I1(FRAME_COUNTER__0[1]),
        .I2(I11[1]),
        .I3(FRAME_COUNTER__0[0]),
        .I4(I11[0]),
        .O(n_0_MAX_LENGTH_ERR_i_5));
LUT2 #(
    .INIT(4'h9)) 
     MAX_LENGTH_ERR_i_6
       (.I0(FRAME_COUNTER),
        .I1(I11[14]),
        .O(n_0_MAX_LENGTH_ERR_i_6));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     MAX_LENGTH_ERR_i_7
       (.I0(FRAME_COUNTER_reg[12]),
        .I1(I11[12]),
        .I2(FRAME_COUNTER_reg[13]),
        .I3(I11[13]),
        .I4(I11[11]),
        .I5(FRAME_COUNTER_reg[11]),
        .O(n_0_MAX_LENGTH_ERR_i_7));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     MAX_LENGTH_ERR_i_8
       (.I0(FRAME_COUNTER_reg[8]),
        .I1(I11[8]),
        .I2(FRAME_COUNTER_reg[9]),
        .I3(I11[9]),
        .I4(I11[10]),
        .I5(FRAME_COUNTER_reg[10]),
        .O(n_0_MAX_LENGTH_ERR_i_8));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     MAX_LENGTH_ERR_i_9
       (.I0(FRAME_COUNTER__0[5]),
        .I1(I11[5]),
        .I2(FRAME_COUNTER__0[6]),
        .I3(I11[6]),
        .I4(I11[7]),
        .I5(FRAME_COUNTER__0[7]),
        .O(n_0_MAX_LENGTH_ERR_i_9));
CARRY4 MAX_LENGTH_ERR_reg_i_3
       (.CI(\<const0> ),
        .CO({\FRAME_CHECKER/MAX_LENGTH_ERR21_in ,n_1_MAX_LENGTH_ERR_reg_i_3,n_2_MAX_LENGTH_ERR_reg_i_3,n_3_MAX_LENGTH_ERR_reg_i_3}),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(NLW_MAX_LENGTH_ERR_reg_i_3_O_UNCONNECTED[3:0]),
        .S({n_0_MAX_LENGTH_ERR_i_6,n_0_MAX_LENGTH_ERR_i_7,n_0_MAX_LENGTH_ERR_i_8,n_0_MAX_LENGTH_ERR_i_9}));
LUT6 #(
    .INIT(64'h0400FFFF04000000)) 
     MIN_LENGTH_MATCH_i_1
       (.I0(FRAME_COUNTER__0[0]),
        .I1(FRAME_COUNTER__0[1]),
        .I2(FRAME_COUNTER__0[2]),
        .I3(n_0_MIN_LENGTH_MATCH_i_2),
        .I4(I14),
        .I5(I13),
        .O(O5));
LUT6 #(
    .INIT(64'h0000000000080000)) 
     MIN_LENGTH_MATCH_i_2
       (.I0(FRAME_COUNTER__0[4]),
        .I1(FRAME_COUNTER__0[3]),
        .I2(FRAME_COUNTER__0[7]),
        .I3(SR),
        .I4(FRAME_COUNTER__0[5]),
        .I5(FRAME_COUNTER__0[6]),
        .O(n_0_MIN_LENGTH_MATCH_i_2));
FDRE MULTICAST_FRAME_reg
       (.C(I1),
        .CE(I2),
        .D(MULTICAST_MATCH),
        .Q(D[0]),
        .R(SR));
FDRE MULTICAST_MATCH_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(I5),
        .Q(MULTICAST_MATCH),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h007FFFFF007F0000)) 
     PADDED_FRAME_i_1
       (.I0(Q[5]),
        .I1(Q[3]),
        .I2(n_0_PADDED_FRAME_i_2),
        .I3(n_0_PADDED_FRAME_i_3),
        .I4(I16),
        .I5(PADDED_FRAME),
        .O(n_0_PADDED_FRAME_i_1));
(* SOFT_HLUTNM = "soft_lutpair87" *) 
   LUT2 #(
    .INIT(4'h8)) 
     PADDED_FRAME_i_2
       (.I0(Q[1]),
        .I1(Q[2]),
        .O(n_0_PADDED_FRAME_i_2));
(* SOFT_HLUTNM = "soft_lutpair85" *) 
   LUT5 #(
    .INIT(32'hFEEEFFFF)) 
     PADDED_FRAME_i_3
       (.I0(Q[6]),
        .I1(Q[7]),
        .I2(Q[5]),
        .I3(Q[4]),
        .I4(LESS_THAN_256),
        .O(n_0_PADDED_FRAME_i_3));
FDRE PADDED_FRAME_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_PADDED_FRAME_i_1),
        .Q(PADDED_FRAME),
        .R(SR));
FDRE RX_DV_REG_reg
       (.C(I1),
        .CE(I2),
        .D(RX_DV_REG7),
        .Q(RX_DV_REG),
        .R(SR));
LUT3 #(
    .INIT(8'h08)) 
     \STATISTICS_LENGTH[13]_i_1 
       (.I0(RX_DV_REG),
        .I1(I2),
        .I2(FRAME_COUNTER),
        .O(\n_0_STATISTICS_LENGTH[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[0] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER__0[0]),
        .Q(D[1]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[10] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER_reg[10]),
        .Q(D[11]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[11] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER_reg[11]),
        .Q(D[12]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[12] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER_reg[12]),
        .Q(D[13]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[13] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER_reg[13]),
        .Q(D[14]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[1] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER__0[1]),
        .Q(D[2]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[2] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER__0[2]),
        .Q(D[3]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[3] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER__0[3]),
        .Q(D[4]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[4] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER__0[4]),
        .Q(D[5]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[5] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER__0[5]),
        .Q(D[6]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[6] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER__0[6]),
        .Q(D[7]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[7] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER__0[7]),
        .Q(D[8]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[8] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER_reg[8]),
        .Q(D[9]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_LENGTH_reg[9] 
       (.C(I1),
        .CE(\n_0_STATISTICS_LENGTH[13]_i_1 ),
        .D(FRAME_COUNTER_reg[9]),
        .Q(D[10]),
        .R(\<const0> ));
FDRE TYPE_PACKET_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(I3),
        .Q(TYPE_FRAME),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h00000000EAAA00AA)) 
     VALIDATE_REQUIRED_i_1
       (.I0(VALIDATE_REQUIRED),
        .I1(address_valid_early),
        .I2(n_0_DATA_VALID_reg),
        .I3(I2),
        .I4(I17),
        .I5(SR),
        .O(O7));
VCC VCC
       (.P(\<const1> ));
FDRE VLAN_FRAME_reg
       (.C(I1),
        .CE(I2),
        .D(\n_0_VLAN_MATCH_reg[1] ),
        .Q(D[16]),
        .R(SR));
LUT6 #(
    .INIT(64'h008000AA00AA00AA)) 
     \VLAN_MATCH[1]_i_1 
       (.I0(\n_0_VLAN_MATCH[1]_i_2 ),
        .I1(FIELD_COUNTER),
        .I2(LENGTH_FIELD),
        .I3(SR),
        .I4(I10),
        .I5(I2),
        .O(\n_0_VLAN_MATCH[1]_i_1 ));
LUT6 #(
    .INIT(64'h8FFFFFFF80000000)) 
     \VLAN_MATCH[1]_i_2 
       (.I0(VLAN_MATCH),
        .I1(O2),
        .I2(FIELD_COUNTER),
        .I3(LENGTH_FIELD),
        .I4(I2),
        .I5(\n_0_VLAN_MATCH_reg[1] ),
        .O(\n_0_VLAN_MATCH[1]_i_2 ));
FDRE \VLAN_MATCH_reg[0] 
       (.C(I1),
        .CE(I2),
        .D(I18),
        .Q(VLAN_MATCH),
        .R(SR));
FDRE \VLAN_MATCH_reg[1] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_VLAN_MATCH[1]_i_1 ),
        .Q(\n_0_VLAN_MATCH_reg[1] ),
        .R(\<const0> ));
LUT5 #(
    .INIT(32'h80000000)) 
     \pause_value_to_tx[15]_i_1 
       (.I0(I6),
        .I1(I15),
        .I2(int_rx_control_frame),
        .I3(rx_enable_reg),
        .I4(I2),
        .O(E));
LUT4 #(
    .INIT(16'h8000)) 
     \rx_statistics_vector[24]_INST_0 
       (.I0(D[15]),
        .I1(I6),
        .I2(I7),
        .I3(I8),
        .O(rx_statistics_vector));
endmodule

(* ORIG_REF_NAME = "PARAM_CHECK" *) 
module TriMACPARAM_CHECK__parameterized0
   (INHIBIT_FRAME,
    O1,
    D,
    EXCEEDED_MIN_LEN,
    FRAME_LEN_ERR,
    ALIGNMENT_ERR,
    O2,
    O3,
    BAD_FRAME_INT0_out,
    O4,
    GOOD_FRAME_INT,
    SR,
    I2,
    INHIBIT_FRAME0,
    I1,
    I3,
    CRC_ENGINE_ERR0,
    I4,
    I5,
    I6,
    p_8_in,
    I7,
    I8,
    TYPE_FRAME,
    MATCH_FRAME_INT,
    VALIDATE_REQUIRED,
    ALIGNMENT_ERR_REG,
    MAX_LENGTH_ERR3_out,
    I9,
    PREAMBLE_FIELD);
  output INHIBIT_FRAME;
  output O1;
  output [5:0]D;
  output EXCEEDED_MIN_LEN;
  output FRAME_LEN_ERR;
  output ALIGNMENT_ERR;
  output O2;
  output O3;
  output BAD_FRAME_INT0_out;
  output O4;
  output GOOD_FRAME_INT;
  input [0:0]SR;
  input I2;
  input INHIBIT_FRAME0;
  input I1;
  input I3;
  input CRC_ENGINE_ERR0;
  input I4;
  input I5;
  input I6;
  input p_8_in;
  input I7;
  input I8;
  input TYPE_FRAME;
  input MATCH_FRAME_INT;
  input VALIDATE_REQUIRED;
  input ALIGNMENT_ERR_REG;
  input MAX_LENGTH_ERR3_out;
  input I9;
  input PREAMBLE_FIELD;

  wire \<const0> ;
  wire \<const1> ;
  wire ALIGNMENT_ERR;
  wire ALIGNMENT_ERR_REG;
  wire BAD_FRAME0;
  wire BAD_FRAME_INT0_out;
  wire CRC_ENGINE_ERR;
  wire CRC_ENGINE_ERR0;
  wire CRC_ERR;
  wire [5:0]D;
  wire EXCEEDED_MIN_LEN;
  wire FCS_ERR;
  wire FRAME_LEN_ERR;
  wire GOOD_FRAME0;
  wire GOOD_FRAME_INT;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire INHIBIT_FRAME;
  wire INHIBIT_FRAME0;
  wire LENGTH_TYPE_ERR0;
  wire MATCH_FRAME_INT;
  wire MAX_LENGTH_ERR3_out;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire PREAMBLE_FIELD;
  wire [0:0]SR;
  wire TYPE_FRAME;
  wire VALIDATE_REQUIRED;
  wire n_0_MAX_LENGTH_ERR_i_1;
  wire n_0_MAX_LENGTH_ERR_reg;
  wire p_8_in;

FDRE ALIGNMENT_ERR_INT_reg
       (.C(I1),
        .CE(I2),
        .D(I6),
        .Q(ALIGNMENT_ERR),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair90" *) 
   LUT4 #(
    .INIT(16'hCC40)) 
     BAD_FRAME_INT_i_1
       (.I0(MATCH_FRAME_INT),
        .I1(VALIDATE_REQUIRED),
        .I2(D[0]),
        .I3(D[1]),
        .O(BAD_FRAME_INT0_out));
LUT6 #(
    .INIT(64'h5050505050505010)) 
     BAD_FRAME_i_1
       (.I0(INHIBIT_FRAME),
        .I1(EXCEEDED_MIN_LEN),
        .I2(I8),
        .I3(n_0_MAX_LENGTH_ERR_reg),
        .I4(FRAME_LEN_ERR),
        .I5(O1),
        .O(BAD_FRAME0));
FDRE BAD_FRAME_reg
       (.C(I1),
        .CE(I2),
        .D(BAD_FRAME0),
        .Q(D[1]),
        .R(SR));
FDRE CRC_ENGINE_ERR_reg
       (.C(I1),
        .CE(I2),
        .D(CRC_ENGINE_ERR0),
        .Q(CRC_ENGINE_ERR),
        .R(SR));
LUT2 #(
    .INIT(4'hE)) 
     CRC_ERR_i_1
       (.I0(FCS_ERR),
        .I1(CRC_ENGINE_ERR),
        .O(O1));
FDRE CRC_ERR_reg
       (.C(I1),
        .CE(I2),
        .D(O1),
        .Q(CRC_ERR),
        .R(SR));
FDRE EXCEEDED_MIN_LEN_reg
       (.C(I1),
        .CE(I2),
        .D(I4),
        .Q(EXCEEDED_MIN_LEN),
        .R(SR));
FDRE FCS_ERR_reg
       (.C(I1),
        .CE(I2),
        .D(I3),
        .Q(FCS_ERR),
        .R(SR));
FDRE FRAME_LEN_ERR_reg
       (.C(I1),
        .CE(I2),
        .D(I5),
        .Q(FRAME_LEN_ERR),
        .R(SR));
GND GND
       (.G(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair90" *) 
   LUT3 #(
    .INIT(8'h80)) 
     GOOD_FRAME_INT_i_1
       (.I0(VALIDATE_REQUIRED),
        .I1(MATCH_FRAME_INT),
        .I2(D[0]),
        .O(GOOD_FRAME_INT));
LUT6 #(
    .INIT(64'h0000000200000000)) 
     GOOD_FRAME_i_1
       (.I0(EXCEEDED_MIN_LEN),
        .I1(n_0_MAX_LENGTH_ERR_reg),
        .I2(FRAME_LEN_ERR),
        .I3(O1),
        .I4(INHIBIT_FRAME),
        .I5(I8),
        .O(GOOD_FRAME0));
FDRE GOOD_FRAME_reg
       (.C(I1),
        .CE(I2),
        .D(GOOD_FRAME0),
        .Q(D[0]),
        .R(SR));
FDSE INHIBIT_FRAME_reg
       (.C(I1),
        .CE(I2),
        .D(INHIBIT_FRAME0),
        .Q(INHIBIT_FRAME),
        .S(SR));
LUT2 #(
    .INIT(4'h2)) 
     LENGTH_TYPE_ERR_i_1
       (.I0(FRAME_LEN_ERR),
        .I1(TYPE_FRAME),
        .O(LENGTH_TYPE_ERR0));
FDRE LENGTH_TYPE_ERR_reg
       (.C(I1),
        .CE(I2),
        .D(LENGTH_TYPE_ERR0),
        .Q(D[4]),
        .R(SR));
LUT6 #(
    .INIT(64'h000000000E0E0EEE)) 
     MAX_LENGTH_ERR_i_1
       (.I0(n_0_MAX_LENGTH_ERR_reg),
        .I1(MAX_LENGTH_ERR3_out),
        .I2(I2),
        .I3(I9),
        .I4(PREAMBLE_FIELD),
        .I5(SR),
        .O(n_0_MAX_LENGTH_ERR_i_1));
FDRE MAX_LENGTH_ERR_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_MAX_LENGTH_ERR_i_1),
        .Q(n_0_MAX_LENGTH_ERR_reg),
        .R(\<const0> ));
FDRE MIN_LENGTH_MATCH_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(I7),
        .Q(O3),
        .R(\<const0> ));
FDRE OUT_OF_BOUNDS_ERR_reg
       (.C(I1),
        .CE(I2),
        .D(n_0_MAX_LENGTH_ERR_reg),
        .Q(D[3]),
        .R(SR));
FDRE STATISTICS_VALID_reg
       (.C(I1),
        .CE(I2),
        .D(p_8_in),
        .Q(O2),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair91" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \STATISTICS_VECTOR[24]_i_1 
       (.I0(CRC_ERR),
        .I1(ALIGNMENT_ERR_REG),
        .O(D[5]));
(* SOFT_HLUTNM = "soft_lutpair91" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \STATISTICS_VECTOR[2]_i_1 
       (.I0(CRC_ERR),
        .I1(ALIGNMENT_ERR_REG),
        .O(D[2]));
LUT2 #(
    .INIT(4'h1)) 
     VALIDATE_REQUIRED_i_2
       (.I0(D[1]),
        .I1(D[0]),
        .O(O4));
VCC VCC
       (.P(\<const1> ));
endmodule

module TriMACSTATE_MACHINES
   (END_OF_DATA,
    FCS_FIELD,
    O1,
    LENGTH_FIELD,
    DATA_FIELD,
    EXTENSION_FIELD,
    PREAMBLE_FIELD,
    O2,
    LENGTH_ZERO0,
    O3,
    LENGTH_ONE0,
    I18,
    CONTROL_MATCH0,
    TYPE_PACKET10_out,
    LESS_THAN_2560,
    INHIBIT_FRAME0,
    CRC_COMPUTE0,
    DATA_NO_FCS0,
    DATA_WITH_FCS0,
    O4,
    O5,
    p_8_in,
    PRE_IFG_FLAG,
    PRE_FALSE_CARR_FLAG,
    I22,
    O6,
    O7,
    O8,
    O9,
    O10,
    O11,
    E,
    O12,
    O13,
    O14,
    O15,
    SR,
    I2,
    I1,
    RX_DV_REG6,
    RX_ERR_REG6,
    IFG_FLAG,
    FALSE_CARR_FLAG,
    SFD_FLAG,
    I3,
    RX_DV_REG7,
    I4,
    LT_CHECK_HELD,
    LESS_THAN_256,
    I5,
    I6,
    I7,
    Q,
    INHIBIT_FRAME,
    COMPUTE,
    LENGTH_FIELD_MATCH,
    TYPE_FRAME,
    DATA_WITH_FCS,
    LENGTH_ZERO,
    DATA_NO_FCS,
    LENGTH_ONE,
    broadcastaddressmatch,
    I8,
    D,
    RX_DV_REG5,
    RX_ERR_REG5,
    RX_ERR_REG7,
    MATCH_FRAME_INT,
    MATCH_FRAME_INT0,
    CONTROL_FRAME_INT,
    I9,
    CONTROL_MATCH,
    MULTICAST_MATCH,
    int_alignment_err_pulse,
    alignment_err_reg,
    ALIGNMENT_ERR,
    I10,
    EXTENSION_FLAG,
    FRAME_LEN_ERR,
    EXCEEDED_MIN_LEN,
    I11,
    I12,
    I13,
    RX_DV_REG2);
  output END_OF_DATA;
  output FCS_FIELD;
  output O1;
  output LENGTH_FIELD;
  output DATA_FIELD;
  output EXTENSION_FIELD;
  output PREAMBLE_FIELD;
  output O2;
  output LENGTH_ZERO0;
  output [0:0]O3;
  output LENGTH_ONE0;
  output [0:0]I18;
  output CONTROL_MATCH0;
  output TYPE_PACKET10_out;
  output LESS_THAN_2560;
  output INHIBIT_FRAME0;
  output CRC_COMPUTE0;
  output DATA_NO_FCS0;
  output DATA_WITH_FCS0;
  output O4;
  output O5;
  output p_8_in;
  output PRE_IFG_FLAG;
  output PRE_FALSE_CARR_FLAG;
  output [0:0]I22;
  output O6;
  output O7;
  output O8;
  output O9;
  output O10;
  output O11;
  output [0:0]E;
  output O12;
  output O13;
  output O14;
  output O15;
  input [0:0]SR;
  input I2;
  input I1;
  input RX_DV_REG6;
  input RX_ERR_REG6;
  input IFG_FLAG;
  input FALSE_CARR_FLAG;
  input SFD_FLAG;
  input I3;
  input RX_DV_REG7;
  input I4;
  input LT_CHECK_HELD;
  input LESS_THAN_256;
  input I5;
  input I6;
  input I7;
  input [7:0]Q;
  input INHIBIT_FRAME;
  input COMPUTE;
  input LENGTH_FIELD_MATCH;
  input TYPE_FRAME;
  input DATA_WITH_FCS;
  input LENGTH_ZERO;
  input DATA_NO_FCS;
  input LENGTH_ONE;
  input broadcastaddressmatch;
  input I8;
  input [7:0]D;
  input RX_DV_REG5;
  input RX_ERR_REG5;
  input RX_ERR_REG7;
  input MATCH_FRAME_INT;
  input MATCH_FRAME_INT0;
  input CONTROL_FRAME_INT;
  input I9;
  input CONTROL_MATCH;
  input MULTICAST_MATCH;
  input int_alignment_err_pulse;
  input alignment_err_reg;
  input ALIGNMENT_ERR;
  input I10;
  input EXTENSION_FLAG;
  input FRAME_LEN_ERR;
  input EXCEEDED_MIN_LEN;
  input I11;
  input I12;
  input I13;
  input RX_DV_REG2;

  wire \<const0> ;
  wire \<const1> ;
  wire ALIGNMENT_ERR;
  wire COMPUTE;
  wire CONTROL_FRAME_INT;
  wire CONTROL_MATCH;
  wire CONTROL_MATCH0;
  wire CRC_COMPUTE0;
  wire CRC_FIELD0;
  wire [7:0]D;
  wire DATA_FIELD;
  wire DATA_NO_FCS;
  wire DATA_NO_FCS0;
  wire DATA_WITH_FCS;
  wire DATA_WITH_FCS0;
  wire DAT_FIELD0;
  wire DEST_ADDRESS_FIELD0;
  wire DEST_ADD_FIELD;
  wire [0:0]E;
  wire END_EXT;
  wire END_EXT0;
  wire END_FCS0;
  wire END_OF_DATA;
  wire END_OF_FCS;
  wire EXCEEDED_MIN_LEN;
  wire EXTENSION_FIELD;
  wire EXTENSION_FLAG;
  wire FALSE_CARR_FLAG;
  wire FCS_FIELD;
  wire [5:0]FIELD_COUNTER;
  wire FRAME_LEN_ERR;
  wire I1;
  wire I10;
  wire I11;
  wire I12;
  wire I13;
  wire [0:0]I18;
  wire I2;
  wire [0:0]I22;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire IFG_FLAG;
  wire INHIBIT_FRAME;
  wire INHIBIT_FRAME0;
  wire LENGTH_FIELD;
  wire LENGTH_FIELD_MATCH;
  wire LENGTH_ONE;
  wire LENGTH_ONE0;
  wire LENGTH_ZERO;
  wire LENGTH_ZERO0;
  wire LEN_FIELD0;
  wire LESS_THAN_256;
  wire LESS_THAN_2560;
  wire LT_CHECK_HELD;
  wire MATCH_FRAME_INT;
  wire MATCH_FRAME_INT0;
  wire MULTICAST_MATCH;
  wire O1;
  wire O10;
  wire O11;
  wire O12;
  wire O13;
  wire O14;
  wire O15;
  wire O2;
  wire [0:0]O3;
  wire O4;
  wire O5;
  wire O6;
  wire O7;
  wire O8;
  wire O9;
  wire PREAMBLE_FIELD;
  wire PRE_FALSE_CARR_FLAG;
  wire PRE_IFG_FLAG;
  wire [7:0]Q;
  wire RX_DV_REG2;
  wire RX_DV_REG5;
  wire RX_DV_REG6;
  wire RX_DV_REG7;
  wire RX_ERR_REG5;
  wire RX_ERR_REG6;
  wire RX_ERR_REG7;
  wire SFD_FLAG;
  wire SOURCE_ADD_FIELD;
  wire [0:0]SR;
  wire SRC_ADDRESS_FIELD0;
  wire TYPE_FRAME;
  wire TYPE_PACKET10_out;
  wire alignment_err_reg;
  wire broadcastaddressmatch;
  wire int_alignment_err_pulse;
  wire n_0_CONTROL_FRAME_INT_i_3;
  wire n_0_CONTROL_MATCH_i_2;
  wire n_0_DATA_NO_FCS_i_2;
  wire n_0_END_DATA_i_1;
  wire n_0_END_FRAME_i_1;
  wire n_0_END_FRAME_i_2;
  wire n_0_END_FRAME_i_3;
  wire n_0_EXT_FIELD_i_1;
  wire n_0_EXT_FIELD_i_2;
  wire n_0_FCS_ERR_i_2;
  wire \n_0_FIELD_CONTROL[0]_i_1 ;
  wire \n_0_FIELD_CONTROL[1]_i_1 ;
  wire \n_0_FIELD_CONTROL[1]_i_2 ;
  wire \n_0_FIELD_CONTROL[2]_i_1 ;
  wire \n_0_FIELD_CONTROL[3]_i_1 ;
  wire \n_0_FIELD_CONTROL[4]_i_1 ;
  wire \n_0_FIELD_CONTROL[5]_i_1 ;
  wire \n_0_FIELD_CONTROL_reg[2] ;
  wire \n_0_FIELD_CONTROL_reg[3] ;
  wire \n_0_FIELD_CONTROL_reg[4] ;
  wire n_0_IFG_FLAG_i_2;
  wire n_0_IFG_FLAG_i_3;
  wire n_0_MULTICAST_MATCH_i_2;
  wire n_0_MULTICAST_MATCH_i_3;
  wire n_0_PREAMBLE_i_1__0;
  wire n_0_PREAMBLE_i_2;
  wire n_0_TYPE_PACKET_i_2;
  wire p_8_in;

LUT4 #(
    .INIT(16'h5554)) 
     ALIGNMENT_ERR_INT_i_1
       (.I0(O1),
        .I1(int_alignment_err_pulse),
        .I2(alignment_err_reg),
        .I3(ALIGNMENT_ERR),
        .O(O11));
(* SOFT_HLUTNM = "soft_lutpair96" *) 
   LUT4 #(
    .INIT(16'hF888)) 
     \CALC[29]_i_1__0 
       (.I0(PREAMBLE_FIELD),
        .I1(SFD_FLAG),
        .I2(I3),
        .I3(I2),
        .O(O4));
(* SOFT_HLUTNM = "soft_lutpair92" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \CALC[29]_i_4 
       (.I0(SFD_FLAG),
        .I1(PREAMBLE_FIELD),
        .O(O5));
LUT6 #(
    .INIT(64'hE2220000E222E222)) 
     CONTROL_FRAME_INT_i_1
       (.I0(CONTROL_FRAME_INT),
        .I1(O9),
        .I2(I9),
        .I3(CONTROL_MATCH),
        .I4(n_0_CONTROL_FRAME_INT_i_3),
        .I5(O2),
        .O(O8));
(* SOFT_HLUTNM = "soft_lutpair100" *) 
   LUT3 #(
    .INIT(8'h08)) 
     CONTROL_FRAME_INT_i_3
       (.I0(O3),
        .I1(LENGTH_FIELD),
        .I2(SR),
        .O(n_0_CONTROL_FRAME_INT_i_3));
LUT5 #(
    .INIT(32'h00000020)) 
     CONTROL_MATCH_i_1
       (.I0(n_0_CONTROL_MATCH_i_2),
        .I1(Q[1]),
        .I2(Q[3]),
        .I3(Q[0]),
        .I4(Q[2]),
        .O(CONTROL_MATCH0));
LUT6 #(
    .INIT(64'h0000000000000800)) 
     CONTROL_MATCH_i_2
       (.I0(FIELD_COUNTER[0]),
        .I1(LENGTH_FIELD),
        .I2(Q[6]),
        .I3(Q[7]),
        .I4(Q[5]),
        .I5(Q[4]),
        .O(n_0_CONTROL_MATCH_i_2));
(* SOFT_HLUTNM = "soft_lutpair92" *) 
   LUT5 #(
    .INIT(32'h88888F88)) 
     CRC_COMPUTE_i_1__0
       (.I0(PREAMBLE_FIELD),
        .I1(SFD_FLAG),
        .I2(O1),
        .I3(COMPUTE),
        .I4(END_OF_DATA),
        .O(CRC_COMPUTE0));
(* SOFT_HLUTNM = "soft_lutpair98" *) 
   LUT3 #(
    .INIT(8'hBA)) 
     CRC_FIELD_i_1
       (.I0(END_OF_DATA),
        .I1(END_OF_FCS),
        .I2(FCS_FIELD),
        .O(CRC_FIELD0));
FDRE CRC_FIELD_reg
       (.C(I1),
        .CE(I2),
        .D(CRC_FIELD0),
        .Q(FCS_FIELD),
        .R(SR));
LUT5 #(
    .INIT(32'hAAAAAAA8)) 
     \DATA_COUNTER[10]_i_2 
       (.I0(I2),
        .I1(LENGTH_FIELD),
        .I2(DATA_FIELD),
        .I3(FCS_FIELD),
        .I4(EXTENSION_FIELD),
        .O(I22));
LUT6 #(
    .INIT(64'h8F8F8F8F8F8F888F)) 
     DATA_NO_FCS_i_1
       (.I0(PREAMBLE_FIELD),
        .I1(SFD_FLAG),
        .I2(n_0_DATA_NO_FCS_i_2),
        .I3(LENGTH_FIELD_MATCH),
        .I4(TYPE_FRAME),
        .I5(LT_CHECK_HELD),
        .O(DATA_NO_FCS0));
LUT6 #(
    .INIT(64'hFFFFFFFFFFEFEFEF)) 
     DATA_NO_FCS_i_2
       (.I0(O1),
        .I1(LENGTH_ZERO),
        .I2(DATA_NO_FCS),
        .I3(DATA_FIELD),
        .I4(END_OF_DATA),
        .I5(LENGTH_ONE),
        .O(n_0_DATA_NO_FCS_i_2));
(* SOFT_HLUTNM = "soft_lutpair95" *) 
   LUT4 #(
    .INIT(16'h00F8)) 
     DATA_WITH_FCS_i_1
       (.I0(SFD_FLAG),
        .I1(PREAMBLE_FIELD),
        .I2(DATA_WITH_FCS),
        .I3(END_OF_FCS),
        .O(DATA_WITH_FCS0));
LUT5 #(
    .INIT(32'h0000F800)) 
     DAT_FIELD_i_1
       (.I0(LENGTH_FIELD),
        .I1(O3),
        .I2(DATA_FIELD),
        .I3(RX_DV_REG6),
        .I4(END_OF_DATA),
        .O(DAT_FIELD0));
FDRE DAT_FIELD_reg
       (.C(I1),
        .CE(I2),
        .D(DAT_FIELD0),
        .Q(DATA_FIELD),
        .R(SR));
LUT6 #(
    .INIT(64'h00000000FF8A0000)) 
     DEST_ADDRESS_FIELD_i_1
       (.I0(SFD_FLAG),
        .I1(PREAMBLE_FIELD),
        .I2(RX_DV_REG7),
        .I3(DEST_ADD_FIELD),
        .I4(RX_DV_REG6),
        .I5(FIELD_COUNTER[5]),
        .O(DEST_ADDRESS_FIELD0));
FDRE DEST_ADDRESS_FIELD_reg
       (.C(I1),
        .CE(I2),
        .D(DEST_ADDRESS_FIELD0),
        .Q(DEST_ADD_FIELD),
        .R(SR));
LUT2 #(
    .INIT(4'h2)) 
     END_DATA_i_1
       (.I0(I13),
        .I1(RX_DV_REG2),
        .O(n_0_END_DATA_i_1));
FDRE END_DATA_reg
       (.C(I1),
        .CE(I2),
        .D(n_0_END_DATA_i_1),
        .Q(END_OF_DATA),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair93" *) 
   LUT5 #(
    .INIT(32'h0000EF00)) 
     END_EXT_i_1
       (.I0(PRE_FALSE_CARR_FLAG),
        .I1(RX_DV_REG5),
        .I2(RX_ERR_REG5),
        .I3(EXTENSION_FIELD),
        .I4(END_EXT),
        .O(END_EXT0));
FDRE END_EXT_reg
       (.C(I1),
        .CE(I2),
        .D(END_EXT0),
        .Q(END_EXT),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair94" *) 
   LUT2 #(
    .INIT(4'h2)) 
     END_FCS_i_1
       (.I0(RX_DV_REG6),
        .I1(RX_DV_REG5),
        .O(END_FCS0));
FDRE END_FCS_reg
       (.C(I1),
        .CE(I2),
        .D(END_FCS0),
        .Q(END_OF_FCS),
        .R(SR));
LUT6 #(
    .INIT(64'hBBBBBBBBBBBABBBB)) 
     END_FRAME_i_1
       (.I0(n_0_END_FRAME_i_2),
        .I1(n_0_END_FRAME_i_3),
        .I2(PRE_IFG_FLAG),
        .I3(I8),
        .I4(RX_ERR_REG6),
        .I5(PRE_FALSE_CARR_FLAG),
        .O(n_0_END_FRAME_i_1));
LUT6 #(
    .INIT(64'h000000000000FF04)) 
     END_FRAME_i_2
       (.I0(RX_DV_REG7),
        .I1(RX_ERR_REG7),
        .I2(RX_ERR_REG6),
        .I3(END_EXT),
        .I4(I8),
        .I5(O1),
        .O(n_0_END_FRAME_i_2));
(* SOFT_HLUTNM = "soft_lutpair99" *) 
   LUT2 #(
    .INIT(4'hB)) 
     END_FRAME_i_3
       (.I0(RX_DV_REG6),
        .I1(RX_DV_REG7),
        .O(n_0_END_FRAME_i_3));
FDRE END_FRAME_reg
       (.C(I1),
        .CE(I2),
        .D(n_0_END_FRAME_i_1),
        .Q(O1),
        .R(SR));
LUT4 #(
    .INIT(16'h5444)) 
     EXCEEDED_MIN_LEN_i_1
       (.I0(O1),
        .I1(EXCEEDED_MIN_LEN),
        .I2(DATA_FIELD),
        .I3(I12),
        .O(O15));
LUT6 #(
    .INIT(64'h005F005500080000)) 
     EXT_FIELD_i_1
       (.I0(I2),
        .I1(FCS_FIELD),
        .I2(I8),
        .I3(SR),
        .I4(n_0_EXT_FIELD_i_2),
        .I5(EXTENSION_FIELD),
        .O(n_0_EXT_FIELD_i_1));
(* SOFT_HLUTNM = "soft_lutpair99" *) 
   LUT4 #(
    .INIT(16'h0004)) 
     EXT_FIELD_i_2
       (.I0(RX_DV_REG6),
        .I1(RX_ERR_REG6),
        .I2(IFG_FLAG),
        .I3(FALSE_CARR_FLAG),
        .O(n_0_EXT_FIELD_i_2));
FDRE EXT_FIELD_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_EXT_FIELD_i_1),
        .Q(EXTENSION_FIELD),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h0000000000008000)) 
     FALSE_CARR_FLAG_i_1
       (.I0(n_0_IFG_FLAG_i_2),
        .I1(D[2]),
        .I2(D[1]),
        .I3(D[3]),
        .I4(D[0]),
        .I5(n_0_IFG_FLAG_i_3),
        .O(PRE_FALSE_CARR_FLAG));
LUT6 #(
    .INIT(64'h5555454445444544)) 
     FCS_ERR_i_1
       (.I0(O1),
        .I1(I10),
        .I2(EXTENSION_FLAG),
        .I3(EXTENSION_FIELD),
        .I4(RX_ERR_REG7),
        .I5(n_0_FCS_ERR_i_2),
        .O(O13));
(* SOFT_HLUTNM = "soft_lutpair101" *) 
   LUT2 #(
    .INIT(4'h2)) 
     FCS_ERR_i_2
       (.I0(RX_DV_REG7),
        .I1(PREAMBLE_FIELD),
        .O(n_0_FCS_ERR_i_2));
LUT6 #(
    .INIT(64'hFFFFFFFCFFFAFFFA)) 
     \FIELD_CONTROL[0]_i_1 
       (.I0(FIELD_COUNTER[0]),
        .I1(FIELD_COUNTER[5]),
        .I2(\n_0_FIELD_CONTROL[1]_i_2 ),
        .I3(SR),
        .I4(O1),
        .I5(I2),
        .O(\n_0_FIELD_CONTROL[0]_i_1 ));
LUT6 #(
    .INIT(64'h0000000C000A000A)) 
     \FIELD_CONTROL[1]_i_1 
       (.I0(O3),
        .I1(FIELD_COUNTER[0]),
        .I2(\n_0_FIELD_CONTROL[1]_i_2 ),
        .I3(SR),
        .I4(O1),
        .I5(I2),
        .O(\n_0_FIELD_CONTROL[1]_i_1 ));
LUT5 #(
    .INIT(32'h00000002)) 
     \FIELD_CONTROL[1]_i_2 
       (.I0(I2),
        .I1(FCS_FIELD),
        .I2(DEST_ADD_FIELD),
        .I3(LENGTH_FIELD),
        .I4(SOURCE_ADD_FIELD),
        .O(\n_0_FIELD_CONTROL[1]_i_2 ));
LUT5 #(
    .INIT(32'h00000ACA)) 
     \FIELD_CONTROL[2]_i_1 
       (.I0(\n_0_FIELD_CONTROL_reg[2] ),
        .I1(O3),
        .I2(I2),
        .I3(O1),
        .I4(SR),
        .O(\n_0_FIELD_CONTROL[2]_i_1 ));
LUT5 #(
    .INIT(32'h00000ACA)) 
     \FIELD_CONTROL[3]_i_1 
       (.I0(\n_0_FIELD_CONTROL_reg[3] ),
        .I1(\n_0_FIELD_CONTROL_reg[2] ),
        .I2(I2),
        .I3(O1),
        .I4(SR),
        .O(\n_0_FIELD_CONTROL[3]_i_1 ));
LUT5 #(
    .INIT(32'h00000ACA)) 
     \FIELD_CONTROL[4]_i_1 
       (.I0(\n_0_FIELD_CONTROL_reg[4] ),
        .I1(\n_0_FIELD_CONTROL_reg[3] ),
        .I2(I2),
        .I3(O1),
        .I4(SR),
        .O(\n_0_FIELD_CONTROL[4]_i_1 ));
LUT5 #(
    .INIT(32'h00000ACA)) 
     \FIELD_CONTROL[5]_i_1 
       (.I0(FIELD_COUNTER[5]),
        .I1(\n_0_FIELD_CONTROL_reg[4] ),
        .I2(I2),
        .I3(O1),
        .I4(SR),
        .O(\n_0_FIELD_CONTROL[5]_i_1 ));
FDRE \FIELD_CONTROL_reg[0] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_FIELD_CONTROL[0]_i_1 ),
        .Q(FIELD_COUNTER[0]),
        .R(\<const0> ));
FDRE \FIELD_CONTROL_reg[1] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_FIELD_CONTROL[1]_i_1 ),
        .Q(O3),
        .R(\<const0> ));
FDRE \FIELD_CONTROL_reg[2] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_FIELD_CONTROL[2]_i_1 ),
        .Q(\n_0_FIELD_CONTROL_reg[2] ),
        .R(\<const0> ));
FDRE \FIELD_CONTROL_reg[3] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_FIELD_CONTROL[3]_i_1 ),
        .Q(\n_0_FIELD_CONTROL_reg[3] ),
        .R(\<const0> ));
FDRE \FIELD_CONTROL_reg[4] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_FIELD_CONTROL[4]_i_1 ),
        .Q(\n_0_FIELD_CONTROL_reg[4] ),
        .R(\<const0> ));
FDRE \FIELD_CONTROL_reg[5] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_FIELD_CONTROL[5]_i_1 ),
        .Q(FIELD_COUNTER[5]),
        .R(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair96" *) 
   LUT4 #(
    .INIT(16'hFF80)) 
     \FRAME_COUNTER[0]_i_1 
       (.I0(I2),
        .I1(SFD_FLAG),
        .I2(PREAMBLE_FIELD),
        .I3(SR),
        .O(O2));
LUT5 #(
    .INIT(32'h45445555)) 
     FRAME_LEN_ERR_i_1
       (.I0(O1),
        .I1(FRAME_LEN_ERR),
        .I2(EXCEEDED_MIN_LEN),
        .I3(FCS_FIELD),
        .I4(I11),
        .O(O14));
GND GND
       (.G(\<const0> ));
LUT6 #(
    .INIT(64'h0000000000000002)) 
     IFG_FLAG_i_1
       (.I0(n_0_IFG_FLAG_i_2),
        .I1(D[2]),
        .I2(D[1]),
        .I3(D[3]),
        .I4(D[0]),
        .I5(n_0_IFG_FLAG_i_3),
        .O(PRE_IFG_FLAG));
LUT4 #(
    .INIT(16'h0001)) 
     IFG_FLAG_i_2
       (.I0(D[5]),
        .I1(D[4]),
        .I2(D[6]),
        .I3(D[7]),
        .O(n_0_IFG_FLAG_i_2));
(* SOFT_HLUTNM = "soft_lutpair93" *) 
   LUT2 #(
    .INIT(4'hB)) 
     IFG_FLAG_i_3
       (.I0(RX_DV_REG5),
        .I1(RX_ERR_REG5),
        .O(n_0_IFG_FLAG_i_3));
(* SOFT_HLUTNM = "soft_lutpair97" *) 
   LUT4 #(
    .INIT(16'h0EEE)) 
     INHIBIT_FRAME_i_1
       (.I0(INHIBIT_FRAME),
        .I1(O1),
        .I2(PREAMBLE_FIELD),
        .I3(SFD_FLAG),
        .O(INHIBIT_FRAME0));
LUT6 #(
    .INIT(64'h0000000000004000)) 
     LENGTH_ONE_i_1
       (.I0(LT_CHECK_HELD),
        .I1(LESS_THAN_256),
        .I2(LENGTH_FIELD),
        .I3(O3),
        .I4(I5),
        .I5(I6),
        .O(LENGTH_ONE0));
(* SOFT_HLUTNM = "soft_lutpair102" *) 
   LUT3 #(
    .INIT(8'h80)) 
     \LENGTH_TYPE[10]_i_2 
       (.I0(I2),
        .I1(FIELD_COUNTER[0]),
        .I2(LENGTH_FIELD),
        .O(TYPE_PACKET10_out));
(* SOFT_HLUTNM = "soft_lutpair100" *) 
   LUT3 #(
    .INIT(8'h80)) 
     \LENGTH_TYPE[7]_i_2 
       (.I0(O3),
        .I1(LENGTH_FIELD),
        .I2(I2),
        .O(O9));
LUT5 #(
    .INIT(32'h20000000)) 
     LENGTH_ZERO_i_1
       (.I0(I4),
        .I1(LT_CHECK_HELD),
        .I2(LESS_THAN_256),
        .I3(LENGTH_FIELD),
        .I4(O3),
        .O(LENGTH_ZERO0));
LUT5 #(
    .INIT(32'h30203000)) 
     LEN_FIELD_i_1
       (.I0(FIELD_COUNTER[5]),
        .I1(O3),
        .I2(RX_DV_REG6),
        .I3(LENGTH_FIELD),
        .I4(SOURCE_ADD_FIELD),
        .O(LEN_FIELD0));
FDRE LEN_FIELD_reg
       (.C(I1),
        .CE(I2),
        .D(LEN_FIELD0),
        .Q(LENGTH_FIELD),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair102" *) 
   LUT3 #(
    .INIT(8'h80)) 
     LESS_THAN_256_i_1
       (.I0(I4),
        .I1(FIELD_COUNTER[0]),
        .I2(LENGTH_FIELD),
        .O(LESS_THAN_2560));
(* SOFT_HLUTNM = "soft_lutpair101" *) 
   LUT3 #(
    .INIT(8'h80)) 
     LT_CHECK_HELD_i_1
       (.I0(PREAMBLE_FIELD),
        .I1(SFD_FLAG),
        .I2(I2),
        .O(O12));
LUT5 #(
    .INIT(32'h0000EA2A)) 
     MATCH_FRAME_INT_i_1
       (.I0(MATCH_FRAME_INT),
        .I1(END_OF_FCS),
        .I2(I2),
        .I3(MATCH_FRAME_INT0),
        .I4(SR),
        .O(O7));
(* SOFT_HLUTNM = "soft_lutpair95" *) 
   LUT3 #(
    .INIT(8'h80)) 
     \MAX_FRAME_LENGTH_HELD[14]_i_1 
       (.I0(PREAMBLE_FIELD),
        .I1(SFD_FLAG),
        .I2(I2),
        .O(E));
LUT6 #(
    .INIT(64'h000000008ABA8A8A)) 
     MULTICAST_MATCH_i_1
       (.I0(MULTICAST_MATCH),
        .I1(n_0_MULTICAST_MATCH_i_2),
        .I2(I2),
        .I3(n_0_MULTICAST_MATCH_i_3),
        .I4(Q[0]),
        .I5(SR),
        .O(O10));
LUT6 #(
    .INIT(64'h00000000FDFD00FF)) 
     MULTICAST_MATCH_i_2
       (.I0(FIELD_COUNTER[0]),
        .I1(FCS_FIELD),
        .I2(END_OF_DATA),
        .I3(broadcastaddressmatch),
        .I4(DEST_ADD_FIELD),
        .I5(O1),
        .O(n_0_MULTICAST_MATCH_i_2));
(* SOFT_HLUTNM = "soft_lutpair98" *) 
   LUT4 #(
    .INIT(16'hEFFF)) 
     MULTICAST_MATCH_i_3
       (.I0(END_OF_DATA),
        .I1(FCS_FIELD),
        .I2(DEST_ADD_FIELD),
        .I3(FIELD_COUNTER[0]),
        .O(n_0_MULTICAST_MATCH_i_3));
LUT6 #(
    .INIT(64'h0000DF5500008800)) 
     PREAMBLE_i_1__0
       (.I0(I2),
        .I1(n_0_PREAMBLE_i_2),
        .I2(SFD_FLAG),
        .I3(RX_DV_REG6),
        .I4(SR),
        .I5(PREAMBLE_FIELD),
        .O(n_0_PREAMBLE_i_1__0));
LUT2 #(
    .INIT(4'h2)) 
     PREAMBLE_i_2
       (.I0(I3),
        .I1(RX_DV_REG7),
        .O(n_0_PREAMBLE_i_2));
FDRE PREAMBLE_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_PREAMBLE_i_1__0),
        .Q(PREAMBLE_FIELD),
        .R(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair94" *) 
   LUT4 #(
    .INIT(16'hA808)) 
     SRC_ADDRESS_FIELD_i_1
       (.I0(RX_DV_REG6),
        .I1(SOURCE_ADD_FIELD),
        .I2(FIELD_COUNTER[5]),
        .I3(DEST_ADD_FIELD),
        .O(SRC_ADDRESS_FIELD0));
FDRE SRC_ADDRESS_FIELD_reg
       (.C(I1),
        .CE(I2),
        .D(SRC_ADDRESS_FIELD0),
        .Q(SOURCE_ADD_FIELD),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair97" *) 
   LUT2 #(
    .INIT(4'h2)) 
     STATISTICS_VALID_i_1
       (.I0(O1),
        .I1(INHIBIT_FRAME),
        .O(p_8_in));
LUT5 #(
    .INIT(32'hEFFFAAAA)) 
     TYPE_PACKET_i_1
       (.I0(n_0_TYPE_PACKET_i_2),
        .I1(SR),
        .I2(FIELD_COUNTER[0]),
        .I3(LENGTH_FIELD),
        .I4(O2),
        .O(O6));
LUT6 #(
    .INIT(64'hFFEAFFFFFFEA0000)) 
     TYPE_PACKET_i_2
       (.I0(I6),
        .I1(Q[1]),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(TYPE_PACKET10_out),
        .I5(TYPE_FRAME),
        .O(n_0_TYPE_PACKET_i_2));
VCC VCC
       (.P(\<const1> ));
LUT6 #(
    .INIT(64'h0000000000080000)) 
     \VLAN_MATCH[0]_i_1 
       (.I0(n_0_CONTROL_MATCH_i_2),
        .I1(I7),
        .I2(Q[1]),
        .I3(Q[3]),
        .I4(Q[0]),
        .I5(Q[2]),
        .O(I18));
endmodule

(* ORIG_REF_NAME = "TX_STATE_MACH" *) 
module TriMACTX_STATE_MACH__parameterized0
   (REG_DATA_VALID,
    PAD,
    tx_statistics_valid,
    O1,
    O2,
    O3,
    O4,
    O5,
    O6,
    O7,
    O8,
    int_gmii_tx_er,
    int_gmii_tx_en,
    Q,
    NUMBER_OF_BYTES_PRE_REG,
    int_tx_ack_in,
    O9,
    D,
    O10,
    tx_statistics_vector,
    SR,
    INT_CRC_MODE,
    I1,
    gtx_clk,
    I2,
    I3,
    I4,
    tx_ce_sample,
    int_tx_data_valid_out,
    I5,
    tx_configuration_vector,
    I6,
    I7,
    data_avail_in_reg,
    I8,
    I9,
    tx_underrun_int,
    I10,
    I11,
    I12,
    I13,
    I14,
    I15,
    I16,
    I17,
    Q_0,
    I18,
    I19,
    E,
    tx_ifg_delay,
    I20,
    I21);
  output REG_DATA_VALID;
  output PAD;
  output tx_statistics_valid;
  output O1;
  output O2;
  output O3;
  output O4;
  output O5;
  output O6;
  output O7;
  output O8;
  output int_gmii_tx_er;
  output int_gmii_tx_en;
  output [1:0]Q;
  output NUMBER_OF_BYTES_PRE_REG;
  output int_tx_ack_in;
  output O9;
  output [7:0]D;
  output O10;
  output [29:0]tx_statistics_vector;
  input [0:0]SR;
  input INT_CRC_MODE;
  input I1;
  input gtx_clk;
  input I2;
  input I3;
  input I4;
  input tx_ce_sample;
  input int_tx_data_valid_out;
  input I5;
  input [15:0]tx_configuration_vector;
  input I6;
  input I7;
  input data_avail_in_reg;
  input I8;
  input I9;
  input tx_underrun_int;
  input I10;
  input I11;
  input I12;
  input I13;
  input I14;
  input I15;
  input I16;
  input I17;
  input Q_0;
  input I18;
  input [0:0]I19;
  input [0:0]E;
  input [7:0]tx_ifg_delay;
  input [0:0]I20;
  input [7:0]I21;

  wire \<const0> ;
  wire \<const1> ;
  wire CLIENT_FRAME_DONE;
  wire COMPUTE;
  wire COMPUTE0;
  wire CR178124_FIX;
  wire CR178124_FIX0;
  wire CRC;
  wire CRC0;
  wire [1:0]CRC_COUNT;
  wire [7:0]D;
  wire DATA_REG4_BIT0;
  wire [7:0]\DATA_REG_reg[0]_3 ;
  wire [7:0]\DATA_REG_reg[1]_2 ;
  wire [7:0]\DATA_REG_reg[2]_1 ;
  wire DST_ADDR_MULTI_MATCH;
  wire [0:0]E;
  wire FRAME_BAD;
  wire [4:2]FRAME_MAX;
  wire I1;
  wire I10;
  wire I11;
  wire I12;
  wire I13;
  wire I14;
  wire I15;
  wire I16;
  wire I17;
  wire I18;
  wire [0:0]I19;
  wire I2;
  wire [0:0]I20;
  wire [7:0]I21;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire INT_CRC_MODE;
  wire INT_IFG_DEL_EN;
  wire [7:0]INT_IFG_DEL_MASKED;
  wire INT_JUMBO_EN;
  wire INT_MAX_FRAME_ENABLE;
  wire [14:0]INT_MAX_FRAME_LENGTH;
  wire INT_TX_BROADCAST;
  wire INT_TX_CONTROL;
  wire INT_TX_MULTICAST;
  wire INT_TX_STATUS_VALID;
  wire INT_TX_SUCCESS;
  wire INT_TX_UNDERRUN2;
  wire INT_VLAN_EN;
  wire NUMBER_OF_BYTES_PRE_REG;
  wire O1;
  wire O10;
  wire O2;
  wire O3;
  wire O4;
  wire O5;
  wire O6;
  wire O7;
  wire O8;
  wire O9;
  wire PAD;
  wire PAD0;
  wire PAD_PIPE;
  wire PREAMBLE;
  wire PREAMBLE0;
  wire PREAMBLE_DONE;
  wire [1:0]Q;
  wire Q_0;
  wire REG_DATA_VALID;
  wire REG_PREAMBLE;
  wire REG_PREAMBLE_DONE;
  wire REG_SCSH;
  wire REG_STATUS_VALID;
  wire REG_TX_CONTROL;
  wire REG_TX_VLAN;
  wire [0:0]SR;
  wire TRANSMIT;
  wire TRANSMIT0;
  wire data_avail_in_reg;
  wire eqOp74_in;
  wire gtx_clk;
  wire int_gmii_tx_en;
  wire int_gmii_tx_er;
  wire int_tx_ack_in;
  wire int_tx_data_valid_out;
  wire \n_0_BYTE_COUNT[0][14]_i_1 ;
  wire \n_0_BYTE_COUNT[1][0]_i_1 ;
  wire \n_0_BYTE_COUNT[1][10]_i_1 ;
  wire \n_0_BYTE_COUNT[1][11]_i_1 ;
  wire \n_0_BYTE_COUNT[1][12]_i_1 ;
  wire \n_0_BYTE_COUNT[1][13]_i_1 ;
  wire \n_0_BYTE_COUNT[1][1]_i_1 ;
  wire \n_0_BYTE_COUNT[1][2]_i_1 ;
  wire \n_0_BYTE_COUNT[1][3]_i_1 ;
  wire \n_0_BYTE_COUNT[1][4]_i_1 ;
  wire \n_0_BYTE_COUNT[1][5]_i_1 ;
  wire \n_0_BYTE_COUNT[1][6]_i_1 ;
  wire \n_0_BYTE_COUNT[1][7]_i_1 ;
  wire \n_0_BYTE_COUNT[1][8]_i_1 ;
  wire \n_0_BYTE_COUNT[1][9]_i_1 ;
  wire \n_0_BYTE_COUNT_reg[0][0] ;
  wire \n_0_BYTE_COUNT_reg[0][10] ;
  wire \n_0_BYTE_COUNT_reg[0][11] ;
  wire \n_0_BYTE_COUNT_reg[0][12] ;
  wire \n_0_BYTE_COUNT_reg[0][13] ;
  wire \n_0_BYTE_COUNT_reg[0][14] ;
  wire \n_0_BYTE_COUNT_reg[0][1] ;
  wire \n_0_BYTE_COUNT_reg[0][2] ;
  wire \n_0_BYTE_COUNT_reg[0][3] ;
  wire \n_0_BYTE_COUNT_reg[0][4] ;
  wire \n_0_BYTE_COUNT_reg[0][5] ;
  wire \n_0_BYTE_COUNT_reg[0][6] ;
  wire \n_0_BYTE_COUNT_reg[0][7] ;
  wire \n_0_BYTE_COUNT_reg[0][8] ;
  wire \n_0_BYTE_COUNT_reg[0][9] ;
  wire \n_0_BYTE_COUNT_reg[1][0] ;
  wire \n_0_BYTE_COUNT_reg[1][10] ;
  wire \n_0_BYTE_COUNT_reg[1][11] ;
  wire \n_0_BYTE_COUNT_reg[1][12] ;
  wire \n_0_BYTE_COUNT_reg[1][13] ;
  wire \n_0_BYTE_COUNT_reg[1][1] ;
  wire \n_0_BYTE_COUNT_reg[1][2] ;
  wire \n_0_BYTE_COUNT_reg[1][3] ;
  wire \n_0_BYTE_COUNT_reg[1][4] ;
  wire \n_0_BYTE_COUNT_reg[1][5] ;
  wire \n_0_BYTE_COUNT_reg[1][6] ;
  wire \n_0_BYTE_COUNT_reg[1][7] ;
  wire \n_0_BYTE_COUNT_reg[1][8] ;
  wire \n_0_BYTE_COUNT_reg[1][9] ;
  wire n_0_CDS_i_1;
  wire n_0_CDS_reg;
  wire n_0_CFL_i_1;
  wire n_0_CFL_reg;
  wire n_0_CLIENT_FRAME_DONE_i_1;
  wire n_0_CLIENT_FRAME_DONE_i_2;
  wire n_0_COF_SEEN_i_1;
  wire n_0_COF_i_1;
  wire n_0_COF_i_2;
  wire n_0_COF_i_3;
  wire \n_0_CORE_DOES_NO_HD_2.TX_OK_i_1 ;
  wire \n_0_CORE_DOES_NO_HD_2.TX_OK_i_2 ;
  wire \n_0_CORE_DOES_NO_HD_2.TX_OK_reg ;
  wire \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[2]_i_1 ;
  wire \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[3]_i_1 ;
  wire \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[4]_i_1 ;
  wire \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[5]_i_1 ;
  wire \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[6]_i_1 ;
  wire \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1 ;
  wire \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_2 ;
  wire \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_3 ;
  wire \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_1 ;
  wire \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_2 ;
  wire \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_3 ;
  wire \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ;
  wire \n_0_CORE_DOES_NO_HD_PRE.PRE_i_1 ;
  wire \n_0_CRC_COUNT[0]_i_1 ;
  wire \n_0_CRC_COUNT[1]_i_1 ;
  wire \n_0_DATA_REG[1][0]_i_1 ;
  wire \n_0_DATA_REG[1][1]_i_1 ;
  wire \n_0_DATA_REG[1][2]_i_1 ;
  wire \n_0_DATA_REG[1][3]_i_1 ;
  wire \n_0_DATA_REG[1][4]_i_1 ;
  wire \n_0_DATA_REG[1][5]_i_1 ;
  wire \n_0_DATA_REG[1][6]_i_1 ;
  wire \n_0_DATA_REG[1][7]_i_1 ;
  wire \n_0_DATA_REG[2][7]_i_1 ;
  wire \n_0_DATA_REG_reg[3][0] ;
  wire \n_0_DATA_REG_reg[3][1] ;
  wire \n_0_DATA_REG_reg[3][2] ;
  wire \n_0_DATA_REG_reg[3][3] ;
  wire \n_0_DATA_REG_reg[3][4] ;
  wire \n_0_DATA_REG_reg[3][5] ;
  wire \n_0_DATA_REG_reg[3][6] ;
  wire \n_0_DATA_REG_reg[3][7] ;
  wire n_0_DST_ADDR_BYTE_MATCH_i_1;
  wire n_0_FCS_i_1;
  wire n_0_FCS_i_2;
  wire n_0_FCS_reg;
  wire n_0_FRAME_BAD_i_1;
  wire n_0_FRAME_BAD_i_3;
  wire n_0_FRAME_BAD_reg;
  wire \n_0_FRAME_COUNT[0]_i_1 ;
  wire \n_0_FRAME_COUNT[10]_i_1 ;
  wire \n_0_FRAME_COUNT[11]_i_1 ;
  wire \n_0_FRAME_COUNT[11]_i_3 ;
  wire \n_0_FRAME_COUNT[11]_i_4 ;
  wire \n_0_FRAME_COUNT[11]_i_5 ;
  wire \n_0_FRAME_COUNT[11]_i_6 ;
  wire \n_0_FRAME_COUNT[12]_i_1 ;
  wire \n_0_FRAME_COUNT[13]_i_1 ;
  wire \n_0_FRAME_COUNT[13]_i_2 ;
  wire \n_0_FRAME_COUNT[14]_i_1 ;
  wire \n_0_FRAME_COUNT[14]_i_3 ;
  wire \n_0_FRAME_COUNT[14]_i_4 ;
  wire \n_0_FRAME_COUNT[14]_i_5 ;
  wire \n_0_FRAME_COUNT[1]_i_1 ;
  wire \n_0_FRAME_COUNT[2]_i_1 ;
  wire \n_0_FRAME_COUNT[3]_i_1 ;
  wire \n_0_FRAME_COUNT[3]_i_3 ;
  wire \n_0_FRAME_COUNT[3]_i_4 ;
  wire \n_0_FRAME_COUNT[3]_i_5 ;
  wire \n_0_FRAME_COUNT[3]_i_6 ;
  wire \n_0_FRAME_COUNT[4]_i_1 ;
  wire \n_0_FRAME_COUNT[5]_i_1 ;
  wire \n_0_FRAME_COUNT[6]_i_1 ;
  wire \n_0_FRAME_COUNT[7]_i_1 ;
  wire \n_0_FRAME_COUNT[7]_i_3 ;
  wire \n_0_FRAME_COUNT[7]_i_4 ;
  wire \n_0_FRAME_COUNT[7]_i_5 ;
  wire \n_0_FRAME_COUNT[7]_i_6 ;
  wire \n_0_FRAME_COUNT[8]_i_1 ;
  wire \n_0_FRAME_COUNT[9]_i_1 ;
  wire \n_0_FRAME_COUNT_reg[0] ;
  wire \n_0_FRAME_COUNT_reg[10] ;
  wire \n_0_FRAME_COUNT_reg[11] ;
  wire \n_0_FRAME_COUNT_reg[11]_i_2 ;
  wire \n_0_FRAME_COUNT_reg[12] ;
  wire \n_0_FRAME_COUNT_reg[13] ;
  wire \n_0_FRAME_COUNT_reg[14] ;
  wire \n_0_FRAME_COUNT_reg[1] ;
  wire \n_0_FRAME_COUNT_reg[2] ;
  wire \n_0_FRAME_COUNT_reg[3] ;
  wire \n_0_FRAME_COUNT_reg[3]_i_2 ;
  wire \n_0_FRAME_COUNT_reg[4] ;
  wire \n_0_FRAME_COUNT_reg[5] ;
  wire \n_0_FRAME_COUNT_reg[6] ;
  wire \n_0_FRAME_COUNT_reg[7] ;
  wire \n_0_FRAME_COUNT_reg[7]_i_2 ;
  wire \n_0_FRAME_COUNT_reg[8] ;
  wire \n_0_FRAME_COUNT_reg[9] ;
  wire n_0_FRAME_GOOD_i_1;
  wire n_0_FRAME_GOOD_i_2;
  wire n_0_FRAME_GOOD_i_3;
  wire n_0_FRAME_GOOD_reg;
  wire \n_0_FRAME_MAX[2]_i_1 ;
  wire \n_0_FRAME_MAX[3]_i_1 ;
  wire \n_0_FRAME_MAX[4]_i_1 ;
  wire \n_0_FRAME_MAX[4]_i_2 ;
  wire n_0_IDL_i_1;
  wire n_0_IDL_i_2;
  wire \n_0_IFG_COUNT[0]_i_1 ;
  wire \n_0_IFG_COUNT[0]_i_2 ;
  wire \n_0_IFG_COUNT[1]_i_1 ;
  wire \n_0_IFG_COUNT[2]_i_1 ;
  wire \n_0_IFG_COUNT[2]_i_2 ;
  wire \n_0_IFG_COUNT[2]_i_3 ;
  wire \n_0_IFG_COUNT[3]_i_1 ;
  wire \n_0_IFG_COUNT[3]_i_2 ;
  wire \n_0_IFG_COUNT[4]_i_1 ;
  wire \n_0_IFG_COUNT[4]_i_2 ;
  wire \n_0_IFG_COUNT[5]_i_1 ;
  wire \n_0_IFG_COUNT[6]_i_1 ;
  wire \n_0_IFG_COUNT[6]_i_2 ;
  wire \n_0_IFG_COUNT[7]_i_1 ;
  wire \n_0_IFG_COUNT[7]_i_2 ;
  wire \n_0_IFG_COUNT[7]_i_3 ;
  wire \n_0_IFG_COUNT[7]_i_4 ;
  wire \n_0_IFG_COUNT[7]_i_5 ;
  wire \n_0_IFG_COUNT_reg[0] ;
  wire \n_0_IFG_COUNT_reg[2] ;
  wire \n_0_IFG_COUNT_reg[4] ;
  wire \n_0_IFG_COUNT_reg[5] ;
  wire \n_0_IFG_COUNT_reg[6] ;
  wire n_0_INT_CRC_MODE_reg;
  wire n_0_INT_HALF_DUPLEX_i_1;
  wire n_0_INT_HALF_DUPLEX_reg;
  wire \n_0_INT_IFG_DELAY_reg[0] ;
  wire \n_0_INT_IFG_DELAY_reg[1] ;
  wire \n_0_INT_IFG_DELAY_reg[2] ;
  wire \n_0_INT_IFG_DELAY_reg[3] ;
  wire \n_0_INT_IFG_DELAY_reg[4] ;
  wire \n_0_INT_IFG_DELAY_reg[5] ;
  wire \n_0_INT_IFG_DELAY_reg[6] ;
  wire \n_0_INT_IFG_DELAY_reg[7] ;
  wire \n_0_INT_MAX_FRAME_LENGTH[0]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[10]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[11]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[12]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[13]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[14]_i_2 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[1]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[2]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[3]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[4]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[5]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[6]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[7]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[8]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH[9]_i_1 ;
  wire \n_0_INT_MAX_FRAME_LENGTH_reg[2] ;
  wire \n_0_INT_MAX_FRAME_LENGTH_reg[3] ;
  wire \n_0_INT_MAX_FRAME_LENGTH_reg[4] ;
  wire n_0_INT_SPEED_IS_10_100_reg;
  wire n_0_INT_TX_BROADCAST_i_1;
  wire n_0_INT_TX_EN_DELAY_i_2;
  wire n_0_INT_TX_MULTICAST_i_1;
  wire n_0_INT_TX_SUCCESS_i_1;
  wire n_0_INT_TX_UNDERRUN2_i_1;
  wire n_0_INT_TX_UNDERRUN2_reg;
  wire \n_0_LEN_reg[0] ;
  wire \n_0_LEN_reg[10] ;
  wire \n_0_LEN_reg[12] ;
  wire \n_0_LEN_reg[13] ;
  wire \n_0_LEN_reg[14] ;
  wire \n_0_LEN_reg[15] ;
  wire \n_0_LEN_reg[1] ;
  wire \n_0_LEN_reg[2] ;
  wire \n_0_LEN_reg[4] ;
  wire \n_0_LEN_reg[5] ;
  wire \n_0_LEN_reg[6] ;
  wire \n_0_LEN_reg[8] ;
  wire \n_0_LEN_reg[9] ;
  wire n_0_MAX_PKT_LEN_REACHED_i_1;
  wire n_0_MAX_PKT_LEN_REACHED_i_10;
  wire n_0_MAX_PKT_LEN_REACHED_i_3;
  wire n_0_MAX_PKT_LEN_REACHED_i_5;
  wire n_0_MAX_PKT_LEN_REACHED_i_6;
  wire n_0_MAX_PKT_LEN_REACHED_i_7;
  wire n_0_MAX_PKT_LEN_REACHED_i_8;
  wire n_0_MAX_PKT_LEN_REACHED_i_9;
  wire n_0_MAX_PKT_LEN_REACHED_reg_i_4;
  wire n_0_MIN_PKT_LEN_REACHED_i_1;
  wire n_0_MIN_PKT_LEN_REACHED_reg;
  wire \n_0_PREAMBLE_PIPE_reg[0] ;
  wire \n_0_PREAMBLE_PIPE_reg[10] ;
  wire \n_0_PREAMBLE_PIPE_reg[11] ;
  wire \n_0_PREAMBLE_PIPE_reg[12] ;
  wire \n_0_PREAMBLE_PIPE_reg[1] ;
  wire \n_0_PREAMBLE_PIPE_reg[3] ;
  wire \n_0_PREAMBLE_PIPE_reg[6] ;
  wire \n_0_PREAMBLE_PIPE_reg[7] ;
  wire \n_0_PREAMBLE_PIPE_reg[8] ;
  wire \n_0_PREAMBLE_PIPE_reg[9] ;
  wire \n_0_PRE_COUNT[0]_i_1 ;
  wire \n_0_PRE_COUNT[1]_i_1 ;
  wire \n_0_PRE_COUNT[2]_i_1 ;
  wire \n_0_PRE_COUNT_reg[0] ;
  wire \n_0_PRE_COUNT_reg[2] ;
  wire n_0_REG_STATUS_VALID_i_1;
  wire n_0_REG_STATUS_VALID_i_2;
  wire n_0_REG_TX_CONTROL_i_2;
  wire n_0_REG_TX_CONTROL_i_3;
  wire n_0_REG_TX_VLAN_i_2;
  wire n_0_REG_TX_VLAN_i_3;
  wire n_0_SCSH_i_1;
  wire n_0_SCSH_reg;
  wire n_0_STOP_MAX_PKT_i_1;
  wire n_0_STOP_MAX_PKT_reg;
  wire \n_0_TRANSMIT_PIPE_reg[0] ;
  wire n_0_TX_i_1;
  wire n_0_TX_i_2;
  wire n_0_TX_i_3;
  wire \n_1_FRAME_COUNT_reg[11]_i_2 ;
  wire \n_1_FRAME_COUNT_reg[3]_i_2 ;
  wire \n_1_FRAME_COUNT_reg[7]_i_2 ;
  wire n_1_MAX_PKT_LEN_REACHED_reg_i_4;
  wire \n_2_FRAME_COUNT_reg[11]_i_2 ;
  wire \n_2_FRAME_COUNT_reg[14]_i_2 ;
  wire \n_2_FRAME_COUNT_reg[3]_i_2 ;
  wire \n_2_FRAME_COUNT_reg[7]_i_2 ;
  wire n_2_MAX_PKT_LEN_REACHED_reg_i_4;
  wire \n_3_FRAME_COUNT_reg[11]_i_2 ;
  wire \n_3_FRAME_COUNT_reg[14]_i_2 ;
  wire \n_3_FRAME_COUNT_reg[3]_i_2 ;
  wire \n_3_FRAME_COUNT_reg[7]_i_2 ;
  wire n_3_MAX_PKT_LEN_REACHED_reg_i_4;
  wire p_0_in1_in;
  wire p_0_in5_in;
  wire p_0_in62_in;
  wire p_0_in8_in;
  wire p_1_in4_in;
  wire p_2_in61_in;
  wire p_3_in;
  wire p_4_in;
  wire p_53_out;
  wire p_5_in;
  wire p_72_in;
  wire p_8_in;
  wire [14:0]plusOp;
  wire tx_ce_sample;
  wire [15:0]tx_configuration_vector;
  wire [7:0]tx_ifg_delay;
  wire tx_statistics_valid;
  wire [29:0]tx_statistics_vector;
  wire tx_underrun_int;
  wire [3:2]\NLW_FRAME_COUNT_reg[14]_i_2_CO_UNCONNECTED ;
  wire [3:3]\NLW_FRAME_COUNT_reg[14]_i_2_O_UNCONNECTED ;
  wire [3:1]NLW_MAX_PKT_LEN_REACHED_reg_i_2_CO_UNCONNECTED;
  wire [3:0]NLW_MAX_PKT_LEN_REACHED_reg_i_2_O_UNCONNECTED;
  wire [3:0]NLW_MAX_PKT_LEN_REACHED_reg_i_4_O_UNCONNECTED;

(* SOFT_HLUTNM = "soft_lutpair46" *) 
   LUT5 #(
    .INIT(32'hEFEFEFEE)) 
     BYTECNTSRL_i_1
       (.I0(Q[0]),
        .I1(PAD_PIPE),
        .I2(CR178124_FIX),
        .I3(p_0_in8_in),
        .I4(CRC),
        .O(int_gmii_tx_en));
LUT4 #(
    .INIT(16'h0010)) 
     \BYTE_COUNT[0][14]_i_1 
       (.I0(REG_SCSH),
        .I1(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .I2(tx_ce_sample),
        .I3(n_0_FCS_reg),
        .O(\n_0_BYTE_COUNT[0][14]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][0]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][0] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][0] ),
        .O(\n_0_BYTE_COUNT[1][0]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][10]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][10] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][10] ),
        .O(\n_0_BYTE_COUNT[1][10]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][11]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][11] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][11] ),
        .O(\n_0_BYTE_COUNT[1][11]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][12]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][12] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][12] ),
        .O(\n_0_BYTE_COUNT[1][12]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][13]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][13] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][13] ),
        .O(\n_0_BYTE_COUNT[1][13]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][1]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][1] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][1] ),
        .O(\n_0_BYTE_COUNT[1][1]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][2]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][2] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][2] ),
        .O(\n_0_BYTE_COUNT[1][2]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][3]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][3] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][3] ),
        .O(\n_0_BYTE_COUNT[1][3]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][4]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][4] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][4] ),
        .O(\n_0_BYTE_COUNT[1][4]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][5]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][5] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][5] ),
        .O(\n_0_BYTE_COUNT[1][5]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][6]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][6] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][6] ),
        .O(\n_0_BYTE_COUNT[1][6]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][7]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][7] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][7] ),
        .O(\n_0_BYTE_COUNT[1][7]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][8]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][8] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][8] ),
        .O(\n_0_BYTE_COUNT[1][8]_i_1 ));
LUT6 #(
    .INIT(64'h8888A8A88888A808)) 
     \BYTE_COUNT[1][9]_i_1 
       (.I0(I11),
        .I1(\n_0_BYTE_COUNT_reg[1][9] ),
        .I2(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .I3(\n_0_BYTE_COUNT_reg[0][14] ),
        .I4(n_0_STOP_MAX_PKT_reg),
        .I5(\n_0_BYTE_COUNT_reg[0][9] ),
        .O(\n_0_BYTE_COUNT[1][9]_i_1 ));
FDRE \BYTE_COUNT_reg[0][0] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[0] ),
        .Q(\n_0_BYTE_COUNT_reg[0][0] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][10] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[10] ),
        .Q(\n_0_BYTE_COUNT_reg[0][10] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][11] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[11] ),
        .Q(\n_0_BYTE_COUNT_reg[0][11] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][12] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[12] ),
        .Q(\n_0_BYTE_COUNT_reg[0][12] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][13] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[13] ),
        .Q(\n_0_BYTE_COUNT_reg[0][13] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][14] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[14] ),
        .Q(\n_0_BYTE_COUNT_reg[0][14] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][1] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[1] ),
        .Q(\n_0_BYTE_COUNT_reg[0][1] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][2] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[2] ),
        .Q(\n_0_BYTE_COUNT_reg[0][2] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][3] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[3] ),
        .Q(\n_0_BYTE_COUNT_reg[0][3] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][4] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[4] ),
        .Q(\n_0_BYTE_COUNT_reg[0][4] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][5] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[5] ),
        .Q(\n_0_BYTE_COUNT_reg[0][5] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][6] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[6] ),
        .Q(\n_0_BYTE_COUNT_reg[0][6] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][7] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[7] ),
        .Q(\n_0_BYTE_COUNT_reg[0][7] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][8] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[8] ),
        .Q(\n_0_BYTE_COUNT_reg[0][8] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[0][9] 
       (.C(gtx_clk),
        .CE(\n_0_BYTE_COUNT[0][14]_i_1 ),
        .D(\n_0_FRAME_COUNT_reg[9] ),
        .Q(\n_0_BYTE_COUNT_reg[0][9] ),
        .R(SR));
FDRE \BYTE_COUNT_reg[1][0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][0]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][0] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][10] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][10]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][10] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][11] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][11]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][11] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][12] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][12]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][12] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][13] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][13]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][13] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][1] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][1]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][1] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][2] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][2]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][2] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][3] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][3]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][3] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][4] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][4]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][4] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][5] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][5]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][5] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][6] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][6]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][6] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][7] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][7]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][7] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][8] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][8]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][8] ),
        .R(\<const0> ));
FDRE \BYTE_COUNT_reg[1][9] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_BYTE_COUNT[1][9]_i_1 ),
        .Q(\n_0_BYTE_COUNT_reg[1][9] ),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h0203030302000200)) 
     CDS_i_1
       (.I0(I12),
        .I1(I8),
        .I2(I9),
        .I3(tx_ce_sample),
        .I4(O5),
        .I5(n_0_CDS_reg),
        .O(n_0_CDS_i_1));
FDRE CDS_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_CDS_i_1),
        .Q(n_0_CDS_reg),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h02AAAAAA00AA0000)) 
     CFL_i_1
       (.I0(I11),
        .I1(n_0_FCS_reg),
        .I2(n_0_SCSH_reg),
        .I3(I14),
        .I4(tx_ce_sample),
        .I5(n_0_CFL_reg),
        .O(n_0_CFL_i_1));
FDRE CFL_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_CFL_i_1),
        .Q(n_0_CFL_reg),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h4F4FCFCFFF4FCFCF)) 
     CLIENT_FRAME_DONE_i_1
       (.I0(O5),
        .I1(CLIENT_FRAME_DONE),
        .I2(I11),
        .I3(n_0_CLIENT_FRAME_DONE_i_2),
        .I4(tx_ce_sample),
        .I5(int_tx_data_valid_out),
        .O(n_0_CLIENT_FRAME_DONE_i_1));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     CLIENT_FRAME_DONE_i_2
       (.I0(n_0_FCS_reg),
        .I1(O3),
        .I2(n_0_CFL_reg),
        .I3(n_0_SCSH_reg),
        .I4(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .I5(O2),
        .O(n_0_CLIENT_FRAME_DONE_i_2));
FDRE CLIENT_FRAME_DONE_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_CLIENT_FRAME_DONE_i_1),
        .Q(CLIENT_FRAME_DONE),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'hABFF0000AA000000)) 
     COF_SEEN_i_1
       (.I0(O2),
        .I1(O5),
        .I2(O9),
        .I3(tx_ce_sample),
        .I4(I11),
        .I5(O4),
        .O(n_0_COF_SEEN_i_1));
FDRE COF_SEEN_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_COF_SEEN_i_1),
        .Q(O4),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'hA000BFFFA0008000)) 
     COF_i_1
       (.I0(I11),
        .I1(tx_ce_sample),
        .I2(O1),
        .I3(n_0_COF_i_2),
        .I4(n_0_COF_i_3),
        .I5(O2),
        .O(n_0_COF_i_1));
(* SOFT_HLUTNM = "soft_lutpair56" *) 
   LUT2 #(
    .INIT(4'h2)) 
     COF_i_2
       (.I0(O3),
        .I1(n_0_CFL_reg),
        .O(n_0_COF_i_2));
LUT5 #(
    .INIT(32'hFFFFFFE0)) 
     COF_i_3
       (.I0(n_0_SCSH_reg),
        .I1(n_0_FCS_reg),
        .I2(tx_ce_sample),
        .I3(I9),
        .I4(I8),
        .O(n_0_COF_i_3));
FDRE COF_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_COF_i_1),
        .Q(O2),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h0103030300030000)) 
     \CORE_DOES_NO_HD_2.TX_OK_i_1 
       (.I0(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .I1(I8),
        .I2(I9),
        .I3(\n_0_CORE_DOES_NO_HD_2.TX_OK_i_2 ),
        .I4(tx_ce_sample),
        .I5(\n_0_CORE_DOES_NO_HD_2.TX_OK_reg ),
        .O(\n_0_CORE_DOES_NO_HD_2.TX_OK_i_1 ));
LUT4 #(
    .INIT(16'hFFF7)) 
     \CORE_DOES_NO_HD_2.TX_OK_i_2 
       (.I0(n_0_FRAME_GOOD_reg),
        .I1(n_0_SCSH_reg),
        .I2(n_0_FRAME_BAD_reg),
        .I3(\n_0_CORE_DOES_NO_HD_2.TX_OK_reg ),
        .O(\n_0_CORE_DOES_NO_HD_2.TX_OK_i_2 ));
FDRE \CORE_DOES_NO_HD_2.TX_OK_reg 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_CORE_DOES_NO_HD_2.TX_OK_i_1 ),
        .Q(\n_0_CORE_DOES_NO_HD_2.TX_OK_reg ),
        .R(\<const0> ));
LUT1 #(
    .INIT(2'h1)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[2]_i_1 
       (.I0(\n_0_INT_IFG_DELAY_reg[2] ),
        .O(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[2]_i_1 ));
LUT2 #(
    .INIT(4'h9)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[3]_i_1 
       (.I0(\n_0_INT_IFG_DELAY_reg[2] ),
        .I1(\n_0_INT_IFG_DELAY_reg[3] ),
        .O(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair52" *) 
   LUT3 #(
    .INIT(8'hA9)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[4]_i_1 
       (.I0(\n_0_INT_IFG_DELAY_reg[4] ),
        .I1(\n_0_INT_IFG_DELAY_reg[3] ),
        .I2(\n_0_INT_IFG_DELAY_reg[2] ),
        .O(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair52" *) 
   LUT4 #(
    .INIT(16'hAAA9)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[5]_i_1 
       (.I0(\n_0_INT_IFG_DELAY_reg[5] ),
        .I1(\n_0_INT_IFG_DELAY_reg[4] ),
        .I2(\n_0_INT_IFG_DELAY_reg[2] ),
        .I3(\n_0_INT_IFG_DELAY_reg[3] ),
        .O(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair51" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[6]_i_1 
       (.I0(\n_0_INT_IFG_DELAY_reg[6] ),
        .I1(\n_0_INT_IFG_DELAY_reg[3] ),
        .I2(\n_0_INT_IFG_DELAY_reg[2] ),
        .I3(\n_0_INT_IFG_DELAY_reg[4] ),
        .I4(\n_0_INT_IFG_DELAY_reg[5] ),
        .O(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[6]_i_1 ));
LUT5 #(
    .INIT(32'h8AAA8A8A)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1 
       (.I0(tx_ce_sample),
        .I1(n_0_INT_HALF_DUPLEX_reg),
        .I2(INT_IFG_DEL_EN),
        .I3(\n_0_INT_IFG_DELAY_reg[7] ),
        .I4(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_3 ),
        .O(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA9)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_2 
       (.I0(\n_0_INT_IFG_DELAY_reg[7] ),
        .I1(\n_0_INT_IFG_DELAY_reg[5] ),
        .I2(\n_0_INT_IFG_DELAY_reg[4] ),
        .I3(\n_0_INT_IFG_DELAY_reg[2] ),
        .I4(\n_0_INT_IFG_DELAY_reg[3] ),
        .I5(\n_0_INT_IFG_DELAY_reg[6] ),
        .O(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair51" *) 
   LUT5 #(
    .INIT(32'h00000001)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_3 
       (.I0(\n_0_INT_IFG_DELAY_reg[6] ),
        .I1(\n_0_INT_IFG_DELAY_reg[3] ),
        .I2(\n_0_INT_IFG_DELAY_reg[2] ),
        .I3(\n_0_INT_IFG_DELAY_reg[4] ),
        .I4(\n_0_INT_IFG_DELAY_reg[5] ),
        .O(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_3 ));
FDRE #(
    .INIT(1'b0)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_INT_IFG_DELAY_reg[0] ),
        .Q(INT_IFG_DEL_MASKED[0]),
        .R(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_INT_IFG_DELAY_reg[1] ),
        .Q(INT_IFG_DEL_MASKED[1]),
        .R(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1 ));
FDRE #(
    .INIT(1'b1)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[2] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[2]_i_1 ),
        .Q(INT_IFG_DEL_MASKED[2]),
        .R(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1 ));
FDSE #(
    .INIT(1'b0)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[3] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[3]_i_1 ),
        .Q(INT_IFG_DEL_MASKED[3]),
        .S(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[4] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[4]_i_1 ),
        .Q(INT_IFG_DEL_MASKED[4]),
        .R(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[5] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[5]_i_1 ),
        .Q(INT_IFG_DEL_MASKED[5]),
        .R(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[6] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[6]_i_1 ),
        .Q(INT_IFG_DEL_MASKED[6]),
        .R(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[7] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_2 ),
        .Q(INT_IFG_DEL_MASKED[7]),
        .R(\n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1 ));
LUT6 #(
    .INIT(64'h0000007F00000050)) 
     \CORE_DOES_NO_HD_MIFG.MIFG_i_1 
       (.I0(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_2 ),
        .I1(O9),
        .I2(tx_ce_sample),
        .I3(I9),
        .I4(I8),
        .I5(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .O(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair50" *) 
   LUT5 #(
    .INIT(32'hFFFD00FD)) 
     \CORE_DOES_NO_HD_MIFG.MIFG_i_2 
       (.I0(n_0_FCS_reg),
        .I1(CRC_COUNT[1]),
        .I2(CRC_COUNT[0]),
        .I3(n_0_INT_CRC_MODE_reg),
        .I4(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_3 ),
        .O(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair56" *) 
   LUT3 #(
    .INIT(8'h15)) 
     \CORE_DOES_NO_HD_MIFG.MIFG_i_3 
       (.I0(O2),
        .I1(n_0_MIN_PKT_LEN_REACHED_reg),
        .I2(n_0_CFL_reg),
        .O(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_3 ));
FDRE \CORE_DOES_NO_HD_MIFG.MIFG_reg 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_1 ),
        .Q(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h000000BF00000088)) 
     \CORE_DOES_NO_HD_PRE.PRE_i_1 
       (.I0(I12),
        .I1(tx_ce_sample),
        .I2(O3),
        .I3(I8),
        .I4(I9),
        .I5(O5),
        .O(\n_0_CORE_DOES_NO_HD_PRE.PRE_i_1 ));
FDRE \CORE_DOES_NO_HD_PRE.PRE_reg 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_CORE_DOES_NO_HD_PRE.PRE_i_1 ),
        .Q(O5),
        .R(\<const0> ));
LUT3 #(
    .INIT(8'h80)) 
     \CORE_DOES_NO_HD_STATS.INT_TX_STATUS_VALID_i_1 
       (.I0(CLIENT_FRAME_DONE),
        .I1(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .I2(O9),
        .O(p_53_out));
FDRE \CORE_DOES_NO_HD_STATS.INT_TX_STATUS_VALID_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(p_53_out),
        .Q(INT_TX_STATUS_VALID),
        .R(SR));
LUT3 #(
    .INIT(8'h80)) 
     CR178124_FIX_i_1
       (.I0(n_0_SCSH_reg),
        .I1(O4),
        .I2(O1),
        .O(CR178124_FIX0));
FDRE CR178124_FIX_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(CR178124_FIX0),
        .Q(CR178124_FIX),
        .R(SR));
TriMACCRC32_8_21 CRCGEN
       (.COMPUTE(COMPUTE),
        .CRC(CRC),
        .D(D),
        .I1(Q[0]),
        .I18(I18),
        .Q({\n_0_DATA_REG_reg[3][7] ,\n_0_DATA_REG_reg[3][6] ,\n_0_DATA_REG_reg[3][5] ,\n_0_DATA_REG_reg[3][4] ,\n_0_DATA_REG_reg[3][3] ,\n_0_DATA_REG_reg[3][2] ,\n_0_DATA_REG_reg[3][1] ,\n_0_DATA_REG_reg[3][0] }),
        .gtx_clk(gtx_clk));
LUT2 #(
    .INIT(4'hE)) 
     CRC_COMPUTE_i_1
       (.I0(PAD),
        .I1(\n_0_TRANSMIT_PIPE_reg[0] ),
        .O(COMPUTE0));
FDRE CRC_COMPUTE_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(COMPUTE0),
        .Q(COMPUTE),
        .R(SR));
LUT5 #(
    .INIT(32'hFFFFFF7A)) 
     \CRC_COUNT[0]_i_1 
       (.I0(CRC_COUNT[0]),
        .I1(n_0_FCS_reg),
        .I2(tx_ce_sample),
        .I3(I8),
        .I4(I9),
        .O(\n_0_CRC_COUNT[0]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFF9FAA)) 
     \CRC_COUNT[1]_i_1 
       (.I0(CRC_COUNT[1]),
        .I1(CRC_COUNT[0]),
        .I2(n_0_FCS_reg),
        .I3(tx_ce_sample),
        .I4(I8),
        .I5(I9),
        .O(\n_0_CRC_COUNT[1]_i_1 ));
FDRE \CRC_COUNT_reg[0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_CRC_COUNT[0]_i_1 ),
        .Q(CRC_COUNT[0]),
        .R(\<const0> ));
FDRE \CRC_COUNT_reg[1] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_CRC_COUNT[1]_i_1 ),
        .Q(CRC_COUNT[1]),
        .R(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair57" *) 
   LUT2 #(
    .INIT(4'h2)) 
     CRC_i_1
       (.I0(n_0_FCS_reg),
        .I1(n_0_CFL_reg),
        .O(CRC0));
FDRE CRC_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(CRC0),
        .Q(CRC),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     DATA_REG4_BIT0_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_DATA_REG_reg[3][0] ),
        .Q(DATA_REG4_BIT0),
        .R(\<const0> ));
LUT4 #(
    .INIT(16'hFCAA)) 
     \DATA_REG[1][0]_i_1 
       (.I0(\DATA_REG_reg[1]_2 [0]),
        .I1(\DATA_REG_reg[0]_3 [0]),
        .I2(PREAMBLE),
        .I3(tx_ce_sample),
        .O(\n_0_DATA_REG[1][0]_i_1 ));
LUT4 #(
    .INIT(16'h0CAA)) 
     \DATA_REG[1][1]_i_1 
       (.I0(\DATA_REG_reg[1]_2 [1]),
        .I1(\DATA_REG_reg[0]_3 [1]),
        .I2(PREAMBLE),
        .I3(tx_ce_sample),
        .O(\n_0_DATA_REG[1][1]_i_1 ));
LUT4 #(
    .INIT(16'hFCAA)) 
     \DATA_REG[1][2]_i_1 
       (.I0(\DATA_REG_reg[1]_2 [2]),
        .I1(\DATA_REG_reg[0]_3 [2]),
        .I2(PREAMBLE),
        .I3(tx_ce_sample),
        .O(\n_0_DATA_REG[1][2]_i_1 ));
LUT4 #(
    .INIT(16'h0CAA)) 
     \DATA_REG[1][3]_i_1 
       (.I0(\DATA_REG_reg[1]_2 [3]),
        .I1(\DATA_REG_reg[0]_3 [3]),
        .I2(PREAMBLE),
        .I3(tx_ce_sample),
        .O(\n_0_DATA_REG[1][3]_i_1 ));
LUT4 #(
    .INIT(16'hFCAA)) 
     \DATA_REG[1][4]_i_1 
       (.I0(\DATA_REG_reg[1]_2 [4]),
        .I1(\DATA_REG_reg[0]_3 [4]),
        .I2(PREAMBLE),
        .I3(tx_ce_sample),
        .O(\n_0_DATA_REG[1][4]_i_1 ));
LUT4 #(
    .INIT(16'h0CAA)) 
     \DATA_REG[1][5]_i_1 
       (.I0(\DATA_REG_reg[1]_2 [5]),
        .I1(\DATA_REG_reg[0]_3 [5]),
        .I2(PREAMBLE),
        .I3(tx_ce_sample),
        .O(\n_0_DATA_REG[1][5]_i_1 ));
LUT4 #(
    .INIT(16'hFCAA)) 
     \DATA_REG[1][6]_i_1 
       (.I0(\DATA_REG_reg[1]_2 [6]),
        .I1(\DATA_REG_reg[0]_3 [6]),
        .I2(PREAMBLE),
        .I3(tx_ce_sample),
        .O(\n_0_DATA_REG[1][6]_i_1 ));
LUT5 #(
    .INIT(32'hFACA0ACA)) 
     \DATA_REG[1][7]_i_1 
       (.I0(\DATA_REG_reg[1]_2 [7]),
        .I1(\DATA_REG_reg[0]_3 [7]),
        .I2(tx_ce_sample),
        .I3(PREAMBLE),
        .I4(REG_PREAMBLE_DONE),
        .O(\n_0_DATA_REG[1][7]_i_1 ));
LUT3 #(
    .INIT(8'h04)) 
     \DATA_REG[2][7]_i_1 
       (.I0(REG_PREAMBLE),
        .I1(tx_ce_sample),
        .I2(TRANSMIT),
        .O(\n_0_DATA_REG[2][7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[0][0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I21[0]),
        .Q(\DATA_REG_reg[0]_3 [0]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[0][1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I21[1]),
        .Q(\DATA_REG_reg[0]_3 [1]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[0][2] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I21[2]),
        .Q(\DATA_REG_reg[0]_3 [2]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[0][3] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I21[3]),
        .Q(\DATA_REG_reg[0]_3 [3]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[0][4] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I21[4]),
        .Q(\DATA_REG_reg[0]_3 [4]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[0][5] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I21[5]),
        .Q(\DATA_REG_reg[0]_3 [5]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[0][6] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I21[6]),
        .Q(\DATA_REG_reg[0]_3 [6]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[0][7] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I21[7]),
        .Q(\DATA_REG_reg[0]_3 [7]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[1][0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_DATA_REG[1][0]_i_1 ),
        .Q(\DATA_REG_reg[1]_2 [0]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[1][1] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_DATA_REG[1][1]_i_1 ),
        .Q(\DATA_REG_reg[1]_2 [1]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[1][2] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_DATA_REG[1][2]_i_1 ),
        .Q(\DATA_REG_reg[1]_2 [2]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[1][3] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_DATA_REG[1][3]_i_1 ),
        .Q(\DATA_REG_reg[1]_2 [3]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[1][4] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_DATA_REG[1][4]_i_1 ),
        .Q(\DATA_REG_reg[1]_2 [4]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[1][5] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_DATA_REG[1][5]_i_1 ),
        .Q(\DATA_REG_reg[1]_2 [5]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[1][6] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_DATA_REG[1][6]_i_1 ),
        .Q(\DATA_REG_reg[1]_2 [6]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[1][7] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_DATA_REG[1][7]_i_1 ),
        .Q(\DATA_REG_reg[1]_2 [7]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[2][0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[1]_2 [0]),
        .Q(\DATA_REG_reg[2]_1 [0]),
        .R(\n_0_DATA_REG[2][7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[2][1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[1]_2 [1]),
        .Q(\DATA_REG_reg[2]_1 [1]),
        .R(\n_0_DATA_REG[2][7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[2][2] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[1]_2 [2]),
        .Q(\DATA_REG_reg[2]_1 [2]),
        .R(\n_0_DATA_REG[2][7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[2][3] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[1]_2 [3]),
        .Q(\DATA_REG_reg[2]_1 [3]),
        .R(\n_0_DATA_REG[2][7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[2][4] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[1]_2 [4]),
        .Q(\DATA_REG_reg[2]_1 [4]),
        .R(\n_0_DATA_REG[2][7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[2][5] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[1]_2 [5]),
        .Q(\DATA_REG_reg[2]_1 [5]),
        .R(\n_0_DATA_REG[2][7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[2][6] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[1]_2 [6]),
        .Q(\DATA_REG_reg[2]_1 [6]),
        .R(\n_0_DATA_REG[2][7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[2][7] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[1]_2 [7]),
        .Q(\DATA_REG_reg[2]_1 [7]),
        .R(\n_0_DATA_REG[2][7]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[3][0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[2]_1 [0]),
        .Q(\n_0_DATA_REG_reg[3][0] ),
        .R(I19));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[3][1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[2]_1 [1]),
        .Q(\n_0_DATA_REG_reg[3][1] ),
        .R(I19));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[3][2] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[2]_1 [2]),
        .Q(\n_0_DATA_REG_reg[3][2] ),
        .R(I19));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[3][3] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[2]_1 [3]),
        .Q(\n_0_DATA_REG_reg[3][3] ),
        .R(I19));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[3][4] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[2]_1 [4]),
        .Q(\n_0_DATA_REG_reg[3][4] ),
        .R(I19));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[3][5] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[2]_1 [5]),
        .Q(\n_0_DATA_REG_reg[3][5] ),
        .R(I19));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[3][6] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[2]_1 [6]),
        .Q(\n_0_DATA_REG_reg[3][6] ),
        .R(I19));
FDRE #(
    .INIT(1'b0)) 
     \DATA_REG_reg[3][7] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\DATA_REG_reg[2]_1 [7]),
        .Q(\n_0_DATA_REG_reg[3][7] ),
        .R(I19));
LUT6 #(
    .INIT(64'hC0FFAAAAC0C0AAAA)) 
     DST_ADDR_BYTE_MATCH_i_1
       (.I0(O6),
        .I1(I15),
        .I2(I16),
        .I3(p_0_in62_in),
        .I4(tx_ce_sample),
        .I5(p_1_in4_in),
        .O(n_0_DST_ADDR_BYTE_MATCH_i_1));
FDRE #(
    .INIT(1'b0)) 
     DST_ADDR_BYTE_MATCH_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_DST_ADDR_BYTE_MATCH_i_1),
        .Q(O6),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     DST_ADDR_MULTI_MATCH_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(DATA_REG4_BIT0),
        .Q(DST_ADDR_MULTI_MATCH),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h000000DF000000C0)) 
     FCS_i_1
       (.I0(n_0_SCSH_reg),
        .I1(n_0_FCS_i_2),
        .I2(tx_ce_sample),
        .I3(I9),
        .I4(I8),
        .I5(n_0_FCS_reg),
        .O(n_0_FCS_i_1));
LUT6 #(
    .INIT(64'h00000000F8F8F800)) 
     FCS_i_2
       (.I0(n_0_CFL_reg),
        .I1(n_0_MIN_PKT_LEN_REACHED_reg),
        .I2(O2),
        .I3(CRC_COUNT[0]),
        .I4(CRC_COUNT[1]),
        .I5(n_0_INT_CRC_MODE_reg),
        .O(n_0_FCS_i_2));
FDRE FCS_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_FCS_i_1),
        .Q(n_0_FCS_reg),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h0000000000000EEE)) 
     FRAME_BAD_i_1
       (.I0(n_0_FRAME_BAD_reg),
        .I1(FRAME_BAD),
        .I2(tx_ce_sample),
        .I3(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .I4(I8),
        .I5(I9),
        .O(n_0_FRAME_BAD_i_1));
LUT6 #(
    .INIT(64'hAA80808080808080)) 
     FRAME_BAD_i_2
       (.I0(tx_ce_sample),
        .I1(n_0_INT_CRC_MODE_reg),
        .I2(O2),
        .I3(O4),
        .I4(O1),
        .I5(n_0_FRAME_BAD_i_3),
        .O(FRAME_BAD));
(* SOFT_HLUTNM = "soft_lutpair57" *) 
   LUT3 #(
    .INIT(8'h02)) 
     FRAME_BAD_i_3
       (.I0(n_0_FCS_reg),
        .I1(CRC_COUNT[1]),
        .I2(CRC_COUNT[0]),
        .O(n_0_FRAME_BAD_i_3));
FDRE FRAME_BAD_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_FRAME_BAD_i_1),
        .Q(n_0_FRAME_BAD_reg),
        .R(\<const0> ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[0]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[0] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[0]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[0]_i_1 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[10]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[10] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[10]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[10]_i_1 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[11]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[11] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[11]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[11]_i_1 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[11]_i_3 
       (.I0(\n_0_FRAME_COUNT_reg[11] ),
        .O(\n_0_FRAME_COUNT[11]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[11]_i_4 
       (.I0(\n_0_FRAME_COUNT_reg[10] ),
        .O(\n_0_FRAME_COUNT[11]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[11]_i_5 
       (.I0(\n_0_FRAME_COUNT_reg[9] ),
        .O(\n_0_FRAME_COUNT[11]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[11]_i_6 
       (.I0(\n_0_FRAME_COUNT_reg[8] ),
        .O(\n_0_FRAME_COUNT[11]_i_6 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[12]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[12] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[12]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[12]_i_1 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[13]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[13] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[13]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[13]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair54" *) 
   LUT3 #(
    .INIT(8'h01)) 
     \FRAME_COUNT[13]_i_2 
       (.I0(n_0_CFL_reg),
        .I1(O3),
        .I2(n_0_FCS_reg),
        .O(\n_0_FRAME_COUNT[13]_i_2 ));
LUT6 #(
    .INIT(64'hEAEAEAEAEAEAEA0A)) 
     \FRAME_COUNT[14]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[14] ),
        .I1(plusOp[14]),
        .I2(tx_ce_sample),
        .I3(n_0_CFL_reg),
        .I4(O3),
        .I5(n_0_FCS_reg),
        .O(\n_0_FRAME_COUNT[14]_i_1 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[14]_i_3 
       (.I0(\n_0_FRAME_COUNT_reg[14] ),
        .O(\n_0_FRAME_COUNT[14]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[14]_i_4 
       (.I0(\n_0_FRAME_COUNT_reg[13] ),
        .O(\n_0_FRAME_COUNT[14]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[14]_i_5 
       (.I0(\n_0_FRAME_COUNT_reg[12] ),
        .O(\n_0_FRAME_COUNT[14]_i_5 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[1]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[1] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[1]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[1]_i_1 ));
LUT6 #(
    .INIT(64'h00FFB8B8AAAAAAAA)) 
     \FRAME_COUNT[2]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[2] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[2]),
        .I3(n_0_INT_CRC_MODE_reg),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .I5(tx_ce_sample),
        .O(\n_0_FRAME_COUNT[2]_i_1 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[3]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[3] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[3]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[3]_i_1 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[3]_i_3 
       (.I0(\n_0_FRAME_COUNT_reg[3] ),
        .O(\n_0_FRAME_COUNT[3]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[3]_i_4 
       (.I0(\n_0_FRAME_COUNT_reg[2] ),
        .O(\n_0_FRAME_COUNT[3]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[3]_i_5 
       (.I0(\n_0_FRAME_COUNT_reg[1] ),
        .O(\n_0_FRAME_COUNT[3]_i_5 ));
LUT1 #(
    .INIT(2'h1)) 
     \FRAME_COUNT[3]_i_6 
       (.I0(\n_0_FRAME_COUNT_reg[0] ),
        .O(\n_0_FRAME_COUNT[3]_i_6 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[4]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[4] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[4]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[4]_i_1 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[5]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[5] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[5]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[5]_i_1 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[6]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[6] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[6]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[6]_i_1 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[7]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[7] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[7]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[7]_i_1 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[7]_i_3 
       (.I0(\n_0_FRAME_COUNT_reg[7] ),
        .O(\n_0_FRAME_COUNT[7]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[7]_i_4 
       (.I0(\n_0_FRAME_COUNT_reg[6] ),
        .O(\n_0_FRAME_COUNT[7]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[7]_i_5 
       (.I0(\n_0_FRAME_COUNT_reg[5] ),
        .O(\n_0_FRAME_COUNT[7]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \FRAME_COUNT[7]_i_6 
       (.I0(\n_0_FRAME_COUNT_reg[4] ),
        .O(\n_0_FRAME_COUNT[7]_i_6 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[8]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[8] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[8]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[8]_i_1 ));
LUT5 #(
    .INIT(32'h00AAB8AA)) 
     \FRAME_COUNT[9]_i_1 
       (.I0(\n_0_FRAME_COUNT_reg[9] ),
        .I1(\n_0_FRAME_COUNT_reg[14] ),
        .I2(plusOp[9]),
        .I3(tx_ce_sample),
        .I4(\n_0_FRAME_COUNT[13]_i_2 ),
        .O(\n_0_FRAME_COUNT[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[0]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[0] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[10] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[10]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[10] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[11] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[11]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[11] ),
        .R(\<const0> ));
CARRY4 \FRAME_COUNT_reg[11]_i_2 
       (.CI(\n_0_FRAME_COUNT_reg[7]_i_2 ),
        .CO({\n_0_FRAME_COUNT_reg[11]_i_2 ,\n_1_FRAME_COUNT_reg[11]_i_2 ,\n_2_FRAME_COUNT_reg[11]_i_2 ,\n_3_FRAME_COUNT_reg[11]_i_2 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(plusOp[11:8]),
        .S({\n_0_FRAME_COUNT[11]_i_3 ,\n_0_FRAME_COUNT[11]_i_4 ,\n_0_FRAME_COUNT[11]_i_5 ,\n_0_FRAME_COUNT[11]_i_6 }));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[12] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[12]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[12] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[13] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[13]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[13] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[14] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[14]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[14] ),
        .R(\<const0> ));
CARRY4 \FRAME_COUNT_reg[14]_i_2 
       (.CI(\n_0_FRAME_COUNT_reg[11]_i_2 ),
        .CO({\NLW_FRAME_COUNT_reg[14]_i_2_CO_UNCONNECTED [3:2],\n_2_FRAME_COUNT_reg[14]_i_2 ,\n_3_FRAME_COUNT_reg[14]_i_2 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\NLW_FRAME_COUNT_reg[14]_i_2_O_UNCONNECTED [3],plusOp[14:12]}),
        .S({\<const0> ,\n_0_FRAME_COUNT[14]_i_3 ,\n_0_FRAME_COUNT[14]_i_4 ,\n_0_FRAME_COUNT[14]_i_5 }));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[1] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[1]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[1] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[2] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[2]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[2] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[3] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[3]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[3] ),
        .R(\<const0> ));
CARRY4 \FRAME_COUNT_reg[3]_i_2 
       (.CI(\<const0> ),
        .CO({\n_0_FRAME_COUNT_reg[3]_i_2 ,\n_1_FRAME_COUNT_reg[3]_i_2 ,\n_2_FRAME_COUNT_reg[3]_i_2 ,\n_3_FRAME_COUNT_reg[3]_i_2 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\n_0_FRAME_COUNT_reg[0] }),
        .O(plusOp[3:0]),
        .S({\n_0_FRAME_COUNT[3]_i_3 ,\n_0_FRAME_COUNT[3]_i_4 ,\n_0_FRAME_COUNT[3]_i_5 ,\n_0_FRAME_COUNT[3]_i_6 }));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[4] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[4]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[4] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[5] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[5]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[5] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[6] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[6]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[6] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[7] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[7]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[7] ),
        .R(\<const0> ));
CARRY4 \FRAME_COUNT_reg[7]_i_2 
       (.CI(\n_0_FRAME_COUNT_reg[3]_i_2 ),
        .CO({\n_0_FRAME_COUNT_reg[7]_i_2 ,\n_1_FRAME_COUNT_reg[7]_i_2 ,\n_2_FRAME_COUNT_reg[7]_i_2 ,\n_3_FRAME_COUNT_reg[7]_i_2 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(plusOp[7:4]),
        .S({\n_0_FRAME_COUNT[7]_i_3 ,\n_0_FRAME_COUNT[7]_i_4 ,\n_0_FRAME_COUNT[7]_i_5 ,\n_0_FRAME_COUNT[7]_i_6 }));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[8] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[8]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[8] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \FRAME_COUNT_reg[9] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_COUNT[9]_i_1 ),
        .Q(\n_0_FRAME_COUNT_reg[9] ),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h0103030300030000)) 
     FRAME_GOOD_i_1
       (.I0(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .I1(I8),
        .I2(I9),
        .I3(n_0_FRAME_GOOD_i_2),
        .I4(tx_ce_sample),
        .I5(n_0_FRAME_GOOD_reg),
        .O(n_0_FRAME_GOOD_i_1));
LUT6 #(
    .INIT(64'h00F8F8F8F8F8F8F8)) 
     FRAME_GOOD_i_2
       (.I0(O1),
        .I1(O4),
        .I2(n_0_FRAME_GOOD_i_3),
        .I3(n_0_INT_CRC_MODE_reg),
        .I4(n_0_CFL_reg),
        .I5(n_0_MIN_PKT_LEN_REACHED_reg),
        .O(n_0_FRAME_GOOD_i_2));
(* SOFT_HLUTNM = "soft_lutpair50" *) 
   LUT4 #(
    .INIT(16'hFEFF)) 
     FRAME_GOOD_i_3
       (.I0(n_0_INT_CRC_MODE_reg),
        .I1(CRC_COUNT[0]),
        .I2(CRC_COUNT[1]),
        .I3(n_0_FCS_reg),
        .O(n_0_FRAME_GOOD_i_3));
FDRE FRAME_GOOD_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_FRAME_GOOD_i_1),
        .Q(n_0_FRAME_GOOD_reg),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFF3202)) 
     \FRAME_MAX[2]_i_1 
       (.I0(FRAME_MAX[2]),
        .I1(\n_0_FRAME_MAX[4]_i_2 ),
        .I2(tx_ce_sample),
        .I3(\n_0_INT_MAX_FRAME_LENGTH_reg[2] ),
        .I4(I9),
        .I5(I8),
        .O(\n_0_FRAME_MAX[2]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFF3202)) 
     \FRAME_MAX[3]_i_1 
       (.I0(FRAME_MAX[3]),
        .I1(\n_0_FRAME_MAX[4]_i_2 ),
        .I2(tx_ce_sample),
        .I3(\n_0_INT_MAX_FRAME_LENGTH_reg[3] ),
        .I4(I9),
        .I5(I8),
        .O(\n_0_FRAME_MAX[3]_i_1 ));
LUT6 #(
    .INIT(64'h1111111011001110)) 
     \FRAME_MAX[4]_i_1 
       (.I0(I9),
        .I1(I8),
        .I2(FRAME_MAX[4]),
        .I3(\n_0_FRAME_MAX[4]_i_2 ),
        .I4(tx_ce_sample),
        .I5(\n_0_INT_MAX_FRAME_LENGTH_reg[4] ),
        .O(\n_0_FRAME_MAX[4]_i_1 ));
LUT4 #(
    .INIT(16'h0080)) 
     \FRAME_MAX[4]_i_2 
       (.I0(p_72_in),
        .I1(tx_ce_sample),
        .I2(INT_VLAN_EN),
        .I3(INT_MAX_FRAME_ENABLE),
        .O(\n_0_FRAME_MAX[4]_i_2 ));
FDRE \FRAME_MAX_reg[2] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_MAX[2]_i_1 ),
        .Q(FRAME_MAX[2]),
        .R(\<const0> ));
FDRE \FRAME_MAX_reg[3] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_MAX[3]_i_1 ),
        .Q(FRAME_MAX[3]),
        .R(\<const0> ));
FDRE \FRAME_MAX_reg[4] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FRAME_MAX[4]_i_1 ),
        .Q(FRAME_MAX[4]),
        .R(\<const0> ));
GND GND
       (.G(\<const0> ));
LUT6 #(
    .INIT(64'hFF4F4F4FCFCFCFCF)) 
     IDL_i_1
       (.I0(n_0_CDS_reg),
        .I1(O9),
        .I2(I11),
        .I3(n_0_IDL_i_2),
        .I4(CLIENT_FRAME_DONE),
        .I5(tx_ce_sample),
        .O(n_0_IDL_i_1));
(* SOFT_HLUTNM = "soft_lutpair45" *) 
   LUT5 #(
    .INIT(32'h00000200)) 
     IDL_i_2
       (.I0(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .I1(p_0_in1_in),
        .I2(\n_0_IFG_COUNT_reg[5] ),
        .I3(\n_0_IFG_COUNT[6]_i_2 ),
        .I4(\n_0_IFG_COUNT_reg[6] ),
        .O(n_0_IDL_i_2));
FDRE IDL_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_IDL_i_1),
        .Q(O9),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h33FFBFFFFF33B333)) 
     \IFG_COUNT[0]_i_1 
       (.I0(\n_0_IFG_COUNT[0]_i_2 ),
        .I1(I11),
        .I2(O5),
        .I3(tx_ce_sample),
        .I4(\n_0_IFG_COUNT[7]_i_4 ),
        .I5(\n_0_IFG_COUNT_reg[0] ),
        .O(\n_0_IFG_COUNT[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair55" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \IFG_COUNT[0]_i_2 
       (.I0(n_0_INT_SPEED_IS_10_100_reg),
        .I1(n_0_INT_HALF_DUPLEX_reg),
        .I2(INT_IFG_DEL_MASKED[0]),
        .O(\n_0_IFG_COUNT[0]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair49" *) 
   LUT5 #(
    .INIT(32'hF20202F2)) 
     \IFG_COUNT[1]_i_1 
       (.I0(INT_IFG_DEL_MASKED[1]),
        .I1(n_0_INT_HALF_DUPLEX_reg),
        .I2(\n_0_IFG_COUNT[7]_i_4 ),
        .I3(p_5_in),
        .I4(\n_0_IFG_COUNT_reg[0] ),
        .O(\n_0_IFG_COUNT[1]_i_1 ));
LUT5 #(
    .INIT(32'hFEFFFE00)) 
     \IFG_COUNT[2]_i_1 
       (.I0(\n_0_IFG_COUNT[2]_i_2 ),
        .I1(I9),
        .I2(I8),
        .I3(\n_0_IFG_COUNT[7]_i_2 ),
        .I4(\n_0_IFG_COUNT_reg[2] ),
        .O(\n_0_IFG_COUNT[2]_i_1 ));
LUT6 #(
    .INIT(64'h606F6F6F606F6060)) 
     \IFG_COUNT[2]_i_2 
       (.I0(\n_0_IFG_COUNT_reg[2] ),
        .I1(\n_0_IFG_COUNT[2]_i_3 ),
        .I2(\n_0_IFG_COUNT[7]_i_4 ),
        .I3(n_0_INT_SPEED_IS_10_100_reg),
        .I4(n_0_INT_HALF_DUPLEX_reg),
        .I5(INT_IFG_DEL_MASKED[2]),
        .O(\n_0_IFG_COUNT[2]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair49" *) 
   LUT2 #(
    .INIT(4'h1)) 
     \IFG_COUNT[2]_i_3 
       (.I0(\n_0_IFG_COUNT_reg[0] ),
        .I1(p_5_in),
        .O(\n_0_IFG_COUNT[2]_i_3 ));
LUT6 #(
    .INIT(64'h0072FF72FF720072)) 
     \IFG_COUNT[3]_i_1 
       (.I0(n_0_INT_HALF_DUPLEX_reg),
        .I1(n_0_INT_SPEED_IS_10_100_reg),
        .I2(INT_IFG_DEL_MASKED[3]),
        .I3(\n_0_IFG_COUNT[7]_i_4 ),
        .I4(\n_0_IFG_COUNT[3]_i_2 ),
        .I5(p_3_in),
        .O(\n_0_IFG_COUNT[3]_i_1 ));
LUT3 #(
    .INIT(8'h01)) 
     \IFG_COUNT[3]_i_2 
       (.I0(p_5_in),
        .I1(\n_0_IFG_COUNT_reg[0] ),
        .I2(\n_0_IFG_COUNT_reg[2] ),
        .O(\n_0_IFG_COUNT[3]_i_2 ));
LUT5 #(
    .INIT(32'hF20202F2)) 
     \IFG_COUNT[4]_i_1 
       (.I0(INT_IFG_DEL_MASKED[4]),
        .I1(n_0_INT_HALF_DUPLEX_reg),
        .I2(\n_0_IFG_COUNT[7]_i_4 ),
        .I3(\n_0_IFG_COUNT[4]_i_2 ),
        .I4(\n_0_IFG_COUNT_reg[4] ),
        .O(\n_0_IFG_COUNT[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair48" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     \IFG_COUNT[4]_i_2 
       (.I0(p_3_in),
        .I1(\n_0_IFG_COUNT_reg[2] ),
        .I2(\n_0_IFG_COUNT_reg[0] ),
        .I3(p_5_in),
        .O(\n_0_IFG_COUNT[4]_i_2 ));
LUT5 #(
    .INIT(32'h02F2F202)) 
     \IFG_COUNT[5]_i_1 
       (.I0(INT_IFG_DEL_MASKED[5]),
        .I1(n_0_INT_HALF_DUPLEX_reg),
        .I2(\n_0_IFG_COUNT[7]_i_4 ),
        .I3(\n_0_IFG_COUNT_reg[5] ),
        .I4(\n_0_IFG_COUNT[6]_i_2 ),
        .O(\n_0_IFG_COUNT[5]_i_1 ));
LUT6 #(
    .INIT(64'hF202F2F202F20202)) 
     \IFG_COUNT[6]_i_1 
       (.I0(INT_IFG_DEL_MASKED[6]),
        .I1(n_0_INT_HALF_DUPLEX_reg),
        .I2(\n_0_IFG_COUNT[7]_i_4 ),
        .I3(\n_0_IFG_COUNT_reg[5] ),
        .I4(\n_0_IFG_COUNT[6]_i_2 ),
        .I5(\n_0_IFG_COUNT_reg[6] ),
        .O(\n_0_IFG_COUNT[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair48" *) 
   LUT5 #(
    .INIT(32'h00000001)) 
     \IFG_COUNT[6]_i_2 
       (.I0(\n_0_IFG_COUNT_reg[4] ),
        .I1(p_5_in),
        .I2(\n_0_IFG_COUNT_reg[0] ),
        .I3(\n_0_IFG_COUNT_reg[2] ),
        .I4(p_3_in),
        .O(\n_0_IFG_COUNT[6]_i_2 ));
LUT3 #(
    .INIT(8'hA8)) 
     \IFG_COUNT[7]_i_1 
       (.I0(\n_0_IFG_COUNT[7]_i_2 ),
        .I1(I9),
        .I2(I8),
        .O(\n_0_IFG_COUNT[7]_i_1 ));
LUT5 #(
    .INIT(32'hFFEEFEEE)) 
     \IFG_COUNT[7]_i_2 
       (.I0(I8),
        .I1(I9),
        .I2(O5),
        .I3(tx_ce_sample),
        .I4(\n_0_IFG_COUNT[7]_i_4 ),
        .O(\n_0_IFG_COUNT[7]_i_2 ));
LUT6 #(
    .INIT(64'hF0FF020022222222)) 
     \IFG_COUNT[7]_i_3 
       (.I0(INT_IFG_DEL_MASKED[7]),
        .I1(n_0_INT_HALF_DUPLEX_reg),
        .I2(\n_0_IFG_COUNT_reg[6] ),
        .I3(\n_0_IFG_COUNT[7]_i_5 ),
        .I4(p_0_in1_in),
        .I5(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .O(\n_0_IFG_COUNT[7]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair45" *) 
   LUT5 #(
    .INIT(32'hAAAAA8AA)) 
     \IFG_COUNT[7]_i_4 
       (.I0(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .I1(p_0_in1_in),
        .I2(\n_0_IFG_COUNT_reg[5] ),
        .I3(\n_0_IFG_COUNT[6]_i_2 ),
        .I4(\n_0_IFG_COUNT_reg[6] ),
        .O(\n_0_IFG_COUNT[7]_i_4 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \IFG_COUNT[7]_i_5 
       (.I0(p_3_in),
        .I1(\n_0_IFG_COUNT_reg[2] ),
        .I2(\n_0_IFG_COUNT_reg[0] ),
        .I3(p_5_in),
        .I4(\n_0_IFG_COUNT_reg[4] ),
        .I5(\n_0_IFG_COUNT_reg[5] ),
        .O(\n_0_IFG_COUNT[7]_i_5 ));
FDRE \IFG_COUNT_reg[0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_IFG_COUNT[0]_i_1 ),
        .Q(\n_0_IFG_COUNT_reg[0] ),
        .R(\<const0> ));
FDRE \IFG_COUNT_reg[1] 
       (.C(gtx_clk),
        .CE(\n_0_IFG_COUNT[7]_i_2 ),
        .D(\n_0_IFG_COUNT[1]_i_1 ),
        .Q(p_5_in),
        .R(\n_0_IFG_COUNT[7]_i_1 ));
FDRE \IFG_COUNT_reg[2] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_IFG_COUNT[2]_i_1 ),
        .Q(\n_0_IFG_COUNT_reg[2] ),
        .R(\<const0> ));
FDRE \IFG_COUNT_reg[3] 
       (.C(gtx_clk),
        .CE(\n_0_IFG_COUNT[7]_i_2 ),
        .D(\n_0_IFG_COUNT[3]_i_1 ),
        .Q(p_3_in),
        .R(\n_0_IFG_COUNT[7]_i_1 ));
FDRE \IFG_COUNT_reg[4] 
       (.C(gtx_clk),
        .CE(\n_0_IFG_COUNT[7]_i_2 ),
        .D(\n_0_IFG_COUNT[4]_i_1 ),
        .Q(\n_0_IFG_COUNT_reg[4] ),
        .R(\n_0_IFG_COUNT[7]_i_1 ));
FDRE \IFG_COUNT_reg[5] 
       (.C(gtx_clk),
        .CE(\n_0_IFG_COUNT[7]_i_2 ),
        .D(\n_0_IFG_COUNT[5]_i_1 ),
        .Q(\n_0_IFG_COUNT_reg[5] ),
        .R(\n_0_IFG_COUNT[7]_i_1 ));
FDRE \IFG_COUNT_reg[6] 
       (.C(gtx_clk),
        .CE(\n_0_IFG_COUNT[7]_i_2 ),
        .D(\n_0_IFG_COUNT[6]_i_1 ),
        .Q(\n_0_IFG_COUNT_reg[6] ),
        .R(\n_0_IFG_COUNT[7]_i_1 ));
FDRE \IFG_COUNT_reg[7] 
       (.C(gtx_clk),
        .CE(\n_0_IFG_COUNT[7]_i_2 ),
        .D(\n_0_IFG_COUNT[7]_i_3 ),
        .Q(p_0_in1_in),
        .R(\n_0_IFG_COUNT[7]_i_1 ));
FDRE INT_CRC_MODE_reg
       (.C(gtx_clk),
        .CE(INT_CRC_MODE),
        .D(I1),
        .Q(n_0_INT_CRC_MODE_reg),
        .R(SR));
LUT6 #(
    .INIT(64'hA8A8A88808080888)) 
     INT_HALF_DUPLEX_i_1
       (.I0(I11),
        .I1(n_0_INT_HALF_DUPLEX_reg),
        .I2(tx_ce_sample),
        .I3(n_0_CDS_reg),
        .I4(O5),
        .I5(I13),
        .O(n_0_INT_HALF_DUPLEX_i_1));
FDRE INT_HALF_DUPLEX_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_INT_HALF_DUPLEX_i_1),
        .Q(n_0_INT_HALF_DUPLEX_reg),
        .R(\<const0> ));
FDRE \INT_IFG_DELAY_reg[0] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_ifg_delay[0]),
        .Q(\n_0_INT_IFG_DELAY_reg[0] ),
        .R(SR));
FDRE \INT_IFG_DELAY_reg[1] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_ifg_delay[1]),
        .Q(\n_0_INT_IFG_DELAY_reg[1] ),
        .R(SR));
FDRE \INT_IFG_DELAY_reg[2] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_ifg_delay[2]),
        .Q(\n_0_INT_IFG_DELAY_reg[2] ),
        .R(SR));
FDRE \INT_IFG_DELAY_reg[3] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_ifg_delay[3]),
        .Q(\n_0_INT_IFG_DELAY_reg[3] ),
        .R(SR));
FDRE \INT_IFG_DELAY_reg[4] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_ifg_delay[4]),
        .Q(\n_0_INT_IFG_DELAY_reg[4] ),
        .R(SR));
FDRE \INT_IFG_DELAY_reg[5] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_ifg_delay[5]),
        .Q(\n_0_INT_IFG_DELAY_reg[5] ),
        .R(SR));
FDRE \INT_IFG_DELAY_reg[6] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_ifg_delay[6]),
        .Q(\n_0_INT_IFG_DELAY_reg[6] ),
        .R(SR));
FDRE \INT_IFG_DELAY_reg[7] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_ifg_delay[7]),
        .Q(\n_0_INT_IFG_DELAY_reg[7] ),
        .R(SR));
FDRE INT_IFG_DEL_EN_reg
       (.C(gtx_clk),
        .CE(INT_CRC_MODE),
        .D(I4),
        .Q(INT_IFG_DEL_EN),
        .R(SR));
FDRE INT_JUMBO_EN_reg
       (.C(gtx_clk),
        .CE(INT_CRC_MODE),
        .D(I2),
        .Q(INT_JUMBO_EN),
        .R(SR));
FDRE INT_MAX_FRAME_ENABLE_reg
       (.C(gtx_clk),
        .CE(INT_CRC_MODE),
        .D(tx_configuration_vector[0]),
        .Q(INT_MAX_FRAME_ENABLE),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair58" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \INT_MAX_FRAME_LENGTH[0]_i_1 
       (.I0(tx_configuration_vector[0]),
        .I1(tx_configuration_vector[1]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair61" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \INT_MAX_FRAME_LENGTH[10]_i_1 
       (.I0(tx_configuration_vector[11]),
        .I1(tx_configuration_vector[0]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[10]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair59" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \INT_MAX_FRAME_LENGTH[11]_i_1 
       (.I0(tx_configuration_vector[0]),
        .I1(tx_configuration_vector[12]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[11]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair60" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \INT_MAX_FRAME_LENGTH[12]_i_1 
       (.I0(tx_configuration_vector[0]),
        .I1(tx_configuration_vector[13]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[12]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair60" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \INT_MAX_FRAME_LENGTH[13]_i_1 
       (.I0(tx_configuration_vector[0]),
        .I1(tx_configuration_vector[14]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[13]_i_1 ));
LUT2 #(
    .INIT(4'h8)) 
     \INT_MAX_FRAME_LENGTH[14]_i_2 
       (.I0(tx_configuration_vector[0]),
        .I1(tx_configuration_vector[15]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[14]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair61" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \INT_MAX_FRAME_LENGTH[1]_i_1 
       (.I0(tx_configuration_vector[2]),
        .I1(tx_configuration_vector[0]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair62" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \INT_MAX_FRAME_LENGTH[2]_i_1 
       (.I0(tx_configuration_vector[3]),
        .I1(tx_configuration_vector[0]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair63" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \INT_MAX_FRAME_LENGTH[3]_i_1 
       (.I0(tx_configuration_vector[4]),
        .I1(tx_configuration_vector[0]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair58" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \INT_MAX_FRAME_LENGTH[4]_i_1 
       (.I0(tx_configuration_vector[0]),
        .I1(tx_configuration_vector[5]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair64" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \INT_MAX_FRAME_LENGTH[5]_i_1 
       (.I0(tx_configuration_vector[6]),
        .I1(tx_configuration_vector[0]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair64" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \INT_MAX_FRAME_LENGTH[6]_i_1 
       (.I0(tx_configuration_vector[7]),
        .I1(tx_configuration_vector[0]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair62" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \INT_MAX_FRAME_LENGTH[7]_i_1 
       (.I0(tx_configuration_vector[8]),
        .I1(tx_configuration_vector[0]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[7]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair63" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \INT_MAX_FRAME_LENGTH[8]_i_1 
       (.I0(tx_configuration_vector[9]),
        .I1(tx_configuration_vector[0]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[8]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair59" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \INT_MAX_FRAME_LENGTH[9]_i_1 
       (.I0(tx_configuration_vector[0]),
        .I1(tx_configuration_vector[10]),
        .O(\n_0_INT_MAX_FRAME_LENGTH[9]_i_1 ));
FDRE \INT_MAX_FRAME_LENGTH_reg[0] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[0]_i_1 ),
        .Q(INT_MAX_FRAME_LENGTH[0]),
        .R(SR));
FDSE \INT_MAX_FRAME_LENGTH_reg[10] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[10]_i_1 ),
        .Q(INT_MAX_FRAME_LENGTH[10]),
        .S(SR));
FDRE \INT_MAX_FRAME_LENGTH_reg[11] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[11]_i_1 ),
        .Q(INT_MAX_FRAME_LENGTH[11]),
        .R(SR));
FDRE \INT_MAX_FRAME_LENGTH_reg[12] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[12]_i_1 ),
        .Q(INT_MAX_FRAME_LENGTH[12]),
        .R(SR));
FDRE \INT_MAX_FRAME_LENGTH_reg[13] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[13]_i_1 ),
        .Q(INT_MAX_FRAME_LENGTH[13]),
        .R(SR));
FDRE \INT_MAX_FRAME_LENGTH_reg[14] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[14]_i_2 ),
        .Q(INT_MAX_FRAME_LENGTH[14]),
        .R(SR));
FDSE \INT_MAX_FRAME_LENGTH_reg[1] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[1]_i_1 ),
        .Q(INT_MAX_FRAME_LENGTH[1]),
        .S(SR));
FDSE \INT_MAX_FRAME_LENGTH_reg[2] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[2]_i_1 ),
        .Q(\n_0_INT_MAX_FRAME_LENGTH_reg[2] ),
        .S(SR));
FDSE \INT_MAX_FRAME_LENGTH_reg[3] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[3]_i_1 ),
        .Q(\n_0_INT_MAX_FRAME_LENGTH_reg[3] ),
        .S(SR));
FDRE \INT_MAX_FRAME_LENGTH_reg[4] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[4]_i_1 ),
        .Q(\n_0_INT_MAX_FRAME_LENGTH_reg[4] ),
        .R(SR));
FDSE \INT_MAX_FRAME_LENGTH_reg[5] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[5]_i_1 ),
        .Q(INT_MAX_FRAME_LENGTH[5]),
        .S(SR));
FDSE \INT_MAX_FRAME_LENGTH_reg[6] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[6]_i_1 ),
        .Q(INT_MAX_FRAME_LENGTH[6]),
        .S(SR));
FDSE \INT_MAX_FRAME_LENGTH_reg[7] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[7]_i_1 ),
        .Q(INT_MAX_FRAME_LENGTH[7]),
        .S(SR));
FDSE \INT_MAX_FRAME_LENGTH_reg[8] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[8]_i_1 ),
        .Q(INT_MAX_FRAME_LENGTH[8]),
        .S(SR));
FDRE \INT_MAX_FRAME_LENGTH_reg[9] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_INT_MAX_FRAME_LENGTH[9]_i_1 ),
        .Q(INT_MAX_FRAME_LENGTH[9]),
        .R(SR));
FDRE INT_SPEED_IS_10_100_reg
       (.C(gtx_clk),
        .CE(INT_CRC_MODE),
        .D(I3),
        .Q(n_0_INT_SPEED_IS_10_100_reg),
        .R(SR));
LUT4 #(
    .INIT(16'hBF80)) 
     INT_TX_BROADCAST_i_1
       (.I0(O6),
        .I1(tx_ce_sample),
        .I2(p_0_in62_in),
        .I3(INT_TX_BROADCAST),
        .O(n_0_INT_TX_BROADCAST_i_1));
FDRE #(
    .INIT(1'b0)) 
     INT_TX_BROADCAST_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_INT_TX_BROADCAST_i_1),
        .Q(INT_TX_BROADCAST),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h1313331302000200)) 
     INT_TX_EN_DELAY_i_1
       (.I0(tx_ce_sample),
        .I1(I8),
        .I2(I17),
        .I3(Q_0),
        .I4(n_0_INT_TX_EN_DELAY_i_2),
        .I5(I10),
        .O(O10));
(* SOFT_HLUTNM = "soft_lutpair46" *) 
   LUT5 #(
    .INIT(32'h000000F1)) 
     INT_TX_EN_DELAY_i_2
       (.I0(CRC),
        .I1(p_0_in8_in),
        .I2(CR178124_FIX),
        .I3(PAD_PIPE),
        .I4(Q[0]),
        .O(n_0_INT_TX_EN_DELAY_i_2));
LUT5 #(
    .INIT(32'h2FFF2000)) 
     INT_TX_MULTICAST_i_1
       (.I0(DST_ADDR_MULTI_MATCH),
        .I1(O6),
        .I2(tx_ce_sample),
        .I3(p_0_in62_in),
        .I4(INT_TX_MULTICAST),
        .O(n_0_INT_TX_MULTICAST_i_1));
FDRE #(
    .INIT(1'b0)) 
     INT_TX_MULTICAST_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_INT_TX_MULTICAST_i_1),
        .Q(INT_TX_MULTICAST),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h2A22AAAA0A000000)) 
     INT_TX_SUCCESS_i_1
       (.I0(I11),
        .I1(O5),
        .I2(n_0_INT_TX_UNDERRUN2_reg),
        .I3(\n_0_CORE_DOES_NO_HD_2.TX_OK_reg ),
        .I4(tx_ce_sample),
        .I5(INT_TX_SUCCESS),
        .O(n_0_INT_TX_SUCCESS_i_1));
FDRE INT_TX_SUCCESS_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_INT_TX_SUCCESS_i_1),
        .Q(INT_TX_SUCCESS),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h0000000000000EEE)) 
     INT_TX_UNDERRUN2_i_1
       (.I0(n_0_INT_TX_UNDERRUN2_reg),
        .I1(INT_TX_UNDERRUN2),
        .I2(tx_ce_sample),
        .I3(REG_STATUS_VALID),
        .I4(I8),
        .I5(I9),
        .O(n_0_INT_TX_UNDERRUN2_i_1));
LUT6 #(
    .INIT(64'h0000FE0000000000)) 
     INT_TX_UNDERRUN2_i_2
       (.I0(n_0_FCS_reg),
        .I1(O3),
        .I2(O5),
        .I3(tx_underrun_int),
        .I4(I7),
        .I5(tx_ce_sample),
        .O(INT_TX_UNDERRUN2));
FDRE INT_TX_UNDERRUN2_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_INT_TX_UNDERRUN2_i_1),
        .Q(n_0_INT_TX_UNDERRUN2_reg),
        .R(\<const0> ));
FDRE INT_VLAN_EN_reg
       (.C(gtx_clk),
        .CE(INT_CRC_MODE),
        .D(I5),
        .Q(INT_VLAN_EN),
        .R(SR));
FDRE \LEN_reg[0] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[1]_2 [0]),
        .Q(\n_0_LEN_reg[0] ),
        .R(SR));
FDRE \LEN_reg[10] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[0]_3 [2]),
        .Q(\n_0_LEN_reg[10] ),
        .R(SR));
FDRE \LEN_reg[11] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[0]_3 [3]),
        .Q(p_8_in),
        .R(SR));
FDRE \LEN_reg[12] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[0]_3 [4]),
        .Q(\n_0_LEN_reg[12] ),
        .R(SR));
FDRE \LEN_reg[13] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[0]_3 [5]),
        .Q(\n_0_LEN_reg[13] ),
        .R(SR));
FDRE \LEN_reg[14] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[0]_3 [6]),
        .Q(\n_0_LEN_reg[14] ),
        .R(SR));
FDRE \LEN_reg[15] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[0]_3 [7]),
        .Q(\n_0_LEN_reg[15] ),
        .R(SR));
FDRE \LEN_reg[1] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[1]_2 [1]),
        .Q(\n_0_LEN_reg[1] ),
        .R(SR));
FDRE \LEN_reg[2] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[1]_2 [2]),
        .Q(\n_0_LEN_reg[2] ),
        .R(SR));
FDRE \LEN_reg[3] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[1]_2 [3]),
        .Q(p_2_in61_in),
        .R(SR));
FDRE \LEN_reg[4] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[1]_2 [4]),
        .Q(\n_0_LEN_reg[4] ),
        .R(SR));
FDRE \LEN_reg[5] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[1]_2 [5]),
        .Q(\n_0_LEN_reg[5] ),
        .R(SR));
FDRE \LEN_reg[6] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[1]_2 [6]),
        .Q(\n_0_LEN_reg[6] ),
        .R(SR));
FDRE \LEN_reg[7] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[1]_2 [7]),
        .Q(p_4_in),
        .R(SR));
FDRE \LEN_reg[8] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[0]_3 [0]),
        .Q(\n_0_LEN_reg[8] ),
        .R(SR));
FDRE \LEN_reg[9] 
       (.C(gtx_clk),
        .CE(I20),
        .D(\DATA_REG_reg[0]_3 [1]),
        .Q(\n_0_LEN_reg[9] ),
        .R(SR));
LUT6 #(
    .INIT(64'h02FF000002000000)) 
     MAX_PKT_LEN_REACHED_i_1
       (.I0(eqOp74_in),
        .I1(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .I2(INT_JUMBO_EN),
        .I3(n_0_MAX_PKT_LEN_REACHED_i_3),
        .I4(I11),
        .I5(O1),
        .O(n_0_MAX_PKT_LEN_REACHED_i_1));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     MAX_PKT_LEN_REACHED_i_10
       (.I0(\n_0_FRAME_COUNT_reg[0] ),
        .I1(INT_MAX_FRAME_LENGTH[0]),
        .I2(\n_0_FRAME_COUNT_reg[1] ),
        .I3(INT_MAX_FRAME_LENGTH[1]),
        .I4(FRAME_MAX[2]),
        .I5(\n_0_FRAME_COUNT_reg[2] ),
        .O(n_0_MAX_PKT_LEN_REACHED_i_10));
LUT5 #(
    .INIT(32'hFFF400B0)) 
     MAX_PKT_LEN_REACHED_i_3
       (.I0(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .I1(eqOp74_in),
        .I2(n_0_MAX_PKT_LEN_REACHED_i_6),
        .I3(INT_JUMBO_EN),
        .I4(tx_ce_sample),
        .O(n_0_MAX_PKT_LEN_REACHED_i_3));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     MAX_PKT_LEN_REACHED_i_5
       (.I0(\n_0_FRAME_COUNT_reg[12] ),
        .I1(INT_MAX_FRAME_LENGTH[12]),
        .I2(\n_0_FRAME_COUNT_reg[13] ),
        .I3(INT_MAX_FRAME_LENGTH[13]),
        .I4(INT_MAX_FRAME_LENGTH[14]),
        .I5(\n_0_FRAME_COUNT_reg[14] ),
        .O(n_0_MAX_PKT_LEN_REACHED_i_5));
LUT6 #(
    .INIT(64'h0000000000080000)) 
     MAX_PKT_LEN_REACHED_i_6
       (.I0(tx_ce_sample),
        .I1(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg ),
        .I2(p_0_in1_in),
        .I3(\n_0_IFG_COUNT_reg[5] ),
        .I4(\n_0_IFG_COUNT[6]_i_2 ),
        .I5(\n_0_IFG_COUNT_reg[6] ),
        .O(n_0_MAX_PKT_LEN_REACHED_i_6));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     MAX_PKT_LEN_REACHED_i_7
       (.I0(\n_0_FRAME_COUNT_reg[10] ),
        .I1(INT_MAX_FRAME_LENGTH[10]),
        .I2(\n_0_FRAME_COUNT_reg[11] ),
        .I3(INT_MAX_FRAME_LENGTH[11]),
        .I4(INT_MAX_FRAME_LENGTH[9]),
        .I5(\n_0_FRAME_COUNT_reg[9] ),
        .O(n_0_MAX_PKT_LEN_REACHED_i_7));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     MAX_PKT_LEN_REACHED_i_8
       (.I0(\n_0_FRAME_COUNT_reg[6] ),
        .I1(INT_MAX_FRAME_LENGTH[6]),
        .I2(\n_0_FRAME_COUNT_reg[7] ),
        .I3(INT_MAX_FRAME_LENGTH[7]),
        .I4(INT_MAX_FRAME_LENGTH[8]),
        .I5(\n_0_FRAME_COUNT_reg[8] ),
        .O(n_0_MAX_PKT_LEN_REACHED_i_8));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     MAX_PKT_LEN_REACHED_i_9
       (.I0(\n_0_FRAME_COUNT_reg[3] ),
        .I1(FRAME_MAX[3]),
        .I2(\n_0_FRAME_COUNT_reg[4] ),
        .I3(FRAME_MAX[4]),
        .I4(INT_MAX_FRAME_LENGTH[5]),
        .I5(\n_0_FRAME_COUNT_reg[5] ),
        .O(n_0_MAX_PKT_LEN_REACHED_i_9));
FDRE MAX_PKT_LEN_REACHED_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_MAX_PKT_LEN_REACHED_i_1),
        .Q(O1),
        .R(\<const0> ));
CARRY4 MAX_PKT_LEN_REACHED_reg_i_2
       (.CI(n_0_MAX_PKT_LEN_REACHED_reg_i_4),
        .CO({NLW_MAX_PKT_LEN_REACHED_reg_i_2_CO_UNCONNECTED[3:1],eqOp74_in}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(NLW_MAX_PKT_LEN_REACHED_reg_i_2_O_UNCONNECTED[3:0]),
        .S({\<const0> ,\<const0> ,\<const0> ,n_0_MAX_PKT_LEN_REACHED_i_5}));
CARRY4 MAX_PKT_LEN_REACHED_reg_i_4
       (.CI(\<const0> ),
        .CO({n_0_MAX_PKT_LEN_REACHED_reg_i_4,n_1_MAX_PKT_LEN_REACHED_reg_i_4,n_2_MAX_PKT_LEN_REACHED_reg_i_4,n_3_MAX_PKT_LEN_REACHED_reg_i_4}),
        .CYINIT(\<const1> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(NLW_MAX_PKT_LEN_REACHED_reg_i_4_O_UNCONNECTED[3:0]),
        .S({n_0_MAX_PKT_LEN_REACHED_i_7,n_0_MAX_PKT_LEN_REACHED_i_8,n_0_MAX_PKT_LEN_REACHED_i_9,n_0_MAX_PKT_LEN_REACHED_i_10}));
LUT6 #(
    .INIT(64'h1101111111000000)) 
     MIN_PKT_LEN_REACHED_i_1
       (.I0(I8),
        .I1(I9),
        .I2(O5),
        .I3(\n_0_FRAME_COUNT_reg[6] ),
        .I4(tx_ce_sample),
        .I5(n_0_MIN_PKT_LEN_REACHED_reg),
        .O(n_0_MIN_PKT_LEN_REACHED_i_1));
FDRE MIN_PKT_LEN_REACHED_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_MIN_PKT_LEN_REACHED_i_1),
        .Q(n_0_MIN_PKT_LEN_REACHED_reg),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'hA8AAA8AAA8AAA8A8)) 
     NUMBER_OF_BYTES_i_1
       (.I0(I10),
        .I1(Q[0]),
        .I2(PAD_PIPE),
        .I3(CR178124_FIX),
        .I4(p_0_in8_in),
        .I5(CRC),
        .O(NUMBER_OF_BYTES_PRE_REG));
FDRE PAD_PIPE_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(PAD),
        .Q(PAD_PIPE),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair54" *) 
   LUT4 #(
    .INIT(16'h0010)) 
     PAD_i_1
       (.I0(n_0_FCS_reg),
        .I1(n_0_SCSH_reg),
        .I2(n_0_CFL_reg),
        .I3(O3),
        .O(PAD0));
FDRE PAD_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(PAD0),
        .Q(PAD),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(PREAMBLE),
        .Q(\n_0_PREAMBLE_PIPE_reg[0] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[10] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_PREAMBLE_PIPE_reg[9] ),
        .Q(\n_0_PREAMBLE_PIPE_reg[10] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[11] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_PREAMBLE_PIPE_reg[10] ),
        .Q(\n_0_PREAMBLE_PIPE_reg[11] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[12] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_PREAMBLE_PIPE_reg[11] ),
        .Q(\n_0_PREAMBLE_PIPE_reg[12] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[13] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_PREAMBLE_PIPE_reg[12] ),
        .Q(Q[1]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_PREAMBLE_PIPE_reg[0] ),
        .Q(\n_0_PREAMBLE_PIPE_reg[1] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[2] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_PREAMBLE_PIPE_reg[1] ),
        .Q(Q[0]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[3] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(Q[0]),
        .Q(\n_0_PREAMBLE_PIPE_reg[3] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[4] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_PREAMBLE_PIPE_reg[3] ),
        .Q(p_1_in4_in),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[5] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(p_1_in4_in),
        .Q(p_0_in62_in),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[6] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(p_0_in62_in),
        .Q(\n_0_PREAMBLE_PIPE_reg[6] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[7] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_PREAMBLE_PIPE_reg[6] ),
        .Q(\n_0_PREAMBLE_PIPE_reg[7] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[8] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_PREAMBLE_PIPE_reg[7] ),
        .Q(\n_0_PREAMBLE_PIPE_reg[8] ),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \PREAMBLE_PIPE_reg[9] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_PREAMBLE_PIPE_reg[8] ),
        .Q(\n_0_PREAMBLE_PIPE_reg[9] ),
        .R(SR));
LUT2 #(
    .INIT(4'h2)) 
     PREAMBLE_i_1
       (.I0(O5),
        .I1(O3),
        .O(PREAMBLE0));
FDRE PREAMBLE_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(PREAMBLE0),
        .Q(PREAMBLE),
        .R(SR));
LUT5 #(
    .INIT(32'hFFFFFF7A)) 
     \PRE_COUNT[0]_i_1 
       (.I0(\n_0_PRE_COUNT_reg[0] ),
        .I1(O5),
        .I2(tx_ce_sample),
        .I3(I8),
        .I4(I9),
        .O(\n_0_PRE_COUNT[0]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFF9FAA)) 
     \PRE_COUNT[1]_i_1 
       (.I0(p_0_in5_in),
        .I1(\n_0_PRE_COUNT_reg[0] ),
        .I2(O5),
        .I3(tx_ce_sample),
        .I4(I8),
        .I5(I9),
        .O(\n_0_PRE_COUNT[1]_i_1 ));
LUT6 #(
    .INIT(64'hA9FFAAAAFFFFFFFF)) 
     \PRE_COUNT[2]_i_1 
       (.I0(\n_0_PRE_COUNT_reg[2] ),
        .I1(\n_0_PRE_COUNT_reg[0] ),
        .I2(p_0_in5_in),
        .I3(O5),
        .I4(tx_ce_sample),
        .I5(I11),
        .O(\n_0_PRE_COUNT[2]_i_1 ));
FDRE \PRE_COUNT_reg[0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_PRE_COUNT[0]_i_1 ),
        .Q(\n_0_PRE_COUNT_reg[0] ),
        .R(\<const0> ));
FDRE \PRE_COUNT_reg[1] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_PRE_COUNT[1]_i_1 ),
        .Q(p_0_in5_in),
        .R(\<const0> ));
FDRE \PRE_COUNT_reg[2] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_PRE_COUNT[2]_i_1 ),
        .Q(\n_0_PRE_COUNT_reg[2] ),
        .R(\<const0> ));
FDRE REG_DATA_VALID_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(int_tx_data_valid_out),
        .Q(REG_DATA_VALID),
        .R(SR));
LUT3 #(
    .INIT(8'h01)) 
     REG_PREAMBLE_DONE_i_1
       (.I0(p_0_in5_in),
        .I1(\n_0_PRE_COUNT_reg[0] ),
        .I2(\n_0_PRE_COUNT_reg[2] ),
        .O(PREAMBLE_DONE));
FDRE REG_PREAMBLE_DONE_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(PREAMBLE_DONE),
        .Q(REG_PREAMBLE_DONE),
        .R(SR));
FDRE REG_PREAMBLE_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(PREAMBLE),
        .Q(REG_PREAMBLE),
        .R(SR));
FDRE REG_SCSH_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(n_0_SCSH_reg),
        .Q(REG_SCSH),
        .R(SR));
LUT6 #(
    .INIT(64'hCEFF0000CC000000)) 
     REG_STATUS_VALID_i_1
       (.I0(n_0_REG_STATUS_VALID_i_2),
        .I1(INT_TX_STATUS_VALID),
        .I2(O3),
        .I3(tx_ce_sample),
        .I4(I11),
        .I5(REG_STATUS_VALID),
        .O(n_0_REG_STATUS_VALID_i_1));
(* SOFT_HLUTNM = "soft_lutpair55" *) 
   LUT2 #(
    .INIT(4'h2)) 
     REG_STATUS_VALID_i_2
       (.I0(n_0_INT_HALF_DUPLEX_reg),
        .I1(n_0_INT_SPEED_IS_10_100_reg),
        .O(n_0_REG_STATUS_VALID_i_2));
FDRE REG_STATUS_VALID_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_REG_STATUS_VALID_i_1),
        .Q(REG_STATUS_VALID),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h0000000000000002)) 
     REG_TX_CONTROL_i_1
       (.I0(n_0_REG_TX_CONTROL_i_2),
        .I1(\n_0_LEN_reg[10] ),
        .I2(\n_0_LEN_reg[1] ),
        .I3(n_0_REG_TX_CONTROL_i_3),
        .I4(\n_0_LEN_reg[14] ),
        .I5(\n_0_LEN_reg[15] ),
        .O(INT_TX_CONTROL));
LUT5 #(
    .INIT(32'h00000020)) 
     REG_TX_CONTROL_i_2
       (.I0(p_2_in61_in),
        .I1(\n_0_LEN_reg[6] ),
        .I2(p_8_in),
        .I3(\n_0_LEN_reg[0] ),
        .I4(n_0_REG_TX_VLAN_i_3),
        .O(n_0_REG_TX_CONTROL_i_2));
LUT4 #(
    .INIT(16'hFFFD)) 
     REG_TX_CONTROL_i_3
       (.I0(p_4_in),
        .I1(\n_0_LEN_reg[2] ),
        .I2(\n_0_LEN_reg[8] ),
        .I3(\n_0_LEN_reg[9] ),
        .O(n_0_REG_TX_CONTROL_i_3));
FDRE REG_TX_CONTROL_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(INT_TX_CONTROL),
        .Q(REG_TX_CONTROL),
        .R(SR));
LUT6 #(
    .INIT(64'h0000000000000002)) 
     REG_TX_VLAN_i_1
       (.I0(n_0_REG_TX_VLAN_i_2),
        .I1(\n_0_LEN_reg[10] ),
        .I2(\n_0_LEN_reg[1] ),
        .I3(n_0_REG_TX_VLAN_i_3),
        .I4(\n_0_LEN_reg[14] ),
        .I5(\n_0_LEN_reg[15] ),
        .O(p_72_in));
LUT6 #(
    .INIT(64'h0000000000100000)) 
     REG_TX_VLAN_i_2
       (.I0(p_8_in),
        .I1(\n_0_LEN_reg[6] ),
        .I2(\n_0_LEN_reg[0] ),
        .I3(p_2_in61_in),
        .I4(INT_VLAN_EN),
        .I5(n_0_REG_TX_CONTROL_i_3),
        .O(n_0_REG_TX_VLAN_i_2));
LUT4 #(
    .INIT(16'hFFFE)) 
     REG_TX_VLAN_i_3
       (.I0(\n_0_LEN_reg[12] ),
        .I1(\n_0_LEN_reg[5] ),
        .I2(\n_0_LEN_reg[13] ),
        .I3(\n_0_LEN_reg[4] ),
        .O(n_0_REG_TX_VLAN_i_3));
FDRE REG_TX_VLAN_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(p_72_in),
        .Q(REG_TX_VLAN),
        .R(SR));
LUT6 #(
    .INIT(64'h0A2AAAAA0A0A0000)) 
     SCSH_i_1
       (.I0(I11),
        .I1(O9),
        .I2(\n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_2 ),
        .I3(\n_0_CORE_DOES_NO_HD_2.TX_OK_reg ),
        .I4(tx_ce_sample),
        .I5(n_0_SCSH_reg),
        .O(n_0_SCSH_i_1));
FDRE SCSH_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_SCSH_i_1),
        .Q(n_0_SCSH_reg),
        .R(\<const0> ));
FDRE STATUS_VALID_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(INT_TX_STATUS_VALID),
        .Q(tx_statistics_valid),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(INT_TX_SUCCESS),
        .Q(tx_statistics_vector[0]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[10] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][5] ),
        .Q(tx_statistics_vector[10]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[11] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][6] ),
        .Q(tx_statistics_vector[11]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[12] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][7] ),
        .Q(tx_statistics_vector[12]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[13] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][8] ),
        .Q(tx_statistics_vector[13]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[14] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][9] ),
        .Q(tx_statistics_vector[14]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[15] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][10] ),
        .Q(tx_statistics_vector[15]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[16] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][11] ),
        .Q(tx_statistics_vector[16]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[17] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][12] ),
        .Q(tx_statistics_vector[17]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[18] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][13] ),
        .Q(tx_statistics_vector[18]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[19] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG_TX_VLAN),
        .Q(tx_statistics_vector[19]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(INT_TX_BROADCAST),
        .Q(tx_statistics_vector[1]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[20] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const0> ),
        .Q(tx_statistics_vector[20]),
        .R(tx_ce_sample));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[21] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const0> ),
        .Q(tx_statistics_vector[21]),
        .R(tx_ce_sample));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[22] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const0> ),
        .Q(tx_statistics_vector[22]),
        .R(tx_ce_sample));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[23] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const0> ),
        .Q(tx_statistics_vector[23]),
        .R(tx_ce_sample));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[24] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const0> ),
        .Q(tx_statistics_vector[24]),
        .R(tx_ce_sample));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[25] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const0> ),
        .Q(tx_statistics_vector[25]),
        .R(tx_ce_sample));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[26] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const0> ),
        .Q(tx_statistics_vector[26]),
        .R(tx_ce_sample));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[27] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const0> ),
        .Q(tx_statistics_vector[27]),
        .R(tx_ce_sample));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[28] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const0> ),
        .Q(tx_statistics_vector[28]),
        .R(tx_ce_sample));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[29] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const0> ),
        .Q(tx_statistics_vector[29]),
        .R(tx_ce_sample));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[2] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(INT_TX_MULTICAST),
        .Q(tx_statistics_vector[2]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[3] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(n_0_INT_TX_UNDERRUN2_reg),
        .Q(tx_statistics_vector[3]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[4] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG_TX_CONTROL),
        .Q(tx_statistics_vector[4]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[5] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][0] ),
        .Q(tx_statistics_vector[5]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[6] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][1] ),
        .Q(tx_statistics_vector[6]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[7] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][2] ),
        .Q(tx_statistics_vector[7]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[8] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][3] ),
        .Q(tx_statistics_vector[8]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATUS_VECTOR_reg[9] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_BYTE_COUNT_reg[1][4] ),
        .Q(tx_statistics_vector[9]),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h1101111111000000)) 
     STOP_MAX_PKT_i_1
       (.I0(I8),
        .I1(I9),
        .I2(O5),
        .I3(O1),
        .I4(tx_ce_sample),
        .I5(n_0_STOP_MAX_PKT_reg),
        .O(n_0_STOP_MAX_PKT_i_1));
FDRE STOP_MAX_PKT_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_STOP_MAX_PKT_i_1),
        .Q(n_0_STOP_MAX_PKT_reg),
        .R(\<const0> ));
FDRE \TRANSMIT_PIPE_reg[0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(TRANSMIT),
        .Q(\n_0_TRANSMIT_PIPE_reg[0] ),
        .R(SR));
FDRE \TRANSMIT_PIPE_reg[1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_TRANSMIT_PIPE_reg[0] ),
        .Q(p_0_in8_in),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair47" *) 
   LUT5 #(
    .INIT(32'h00000100)) 
     TRANSMIT_i_1
       (.I0(O2),
        .I1(n_0_CFL_reg),
        .I2(O5),
        .I3(O3),
        .I4(CRC),
        .O(TRANSMIT0));
FDRE TRANSMIT_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(TRANSMIT0),
        .Q(TRANSMIT),
        .R(SR));
LUT6 #(
    .INIT(64'h5DFF000055000000)) 
     TX_i_1
       (.I0(n_0_TX_i_2),
        .I1(n_0_TX_i_3),
        .I2(n_0_CDS_reg),
        .I3(tx_ce_sample),
        .I4(I11),
        .I5(O3),
        .O(n_0_TX_i_1));
(* SOFT_HLUTNM = "soft_lutpair53" *) 
   LUT4 #(
    .INIT(16'hFFFD)) 
     TX_i_2
       (.I0(O5),
        .I1(\n_0_PRE_COUNT_reg[2] ),
        .I2(\n_0_PRE_COUNT_reg[0] ),
        .I3(p_0_in5_in),
        .O(n_0_TX_i_2));
(* SOFT_HLUTNM = "soft_lutpair47" *) 
   LUT2 #(
    .INIT(4'h1)) 
     TX_i_3
       (.I0(n_0_CFL_reg),
        .I1(O2),
        .O(n_0_TX_i_3));
FDRE TX_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_TX_i_1),
        .Q(O3),
        .R(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* SOFT_HLUTNM = "soft_lutpair53" *) 
   LUT4 #(
    .INIT(16'h0040)) 
     ack_int_i_1
       (.I0(p_0_in5_in),
        .I1(\n_0_PRE_COUNT_reg[0] ),
        .I2(PREAMBLE),
        .I3(\n_0_PRE_COUNT_reg[2] ),
        .O(int_tx_ack_in));
LUT6 #(
    .INIT(64'hBFFFBFBFBFFFFFFF)) 
     end_of_tx_reg_i_1
       (.I0(O4),
        .I1(REG_DATA_VALID),
        .I2(O2),
        .I3(I6),
        .I4(I7),
        .I5(data_avail_in_reg),
        .O(O7));
LUT6 #(
    .INIT(64'hBFFFBFBF00000000)) 
     mux_control_i_5
       (.I0(O4),
        .I1(REG_DATA_VALID),
        .I2(O2),
        .I3(I6),
        .I4(I7),
        .I5(data_avail_in_reg),
        .O(O8));
LUT6 #(
    .INIT(64'hF222F222F2220000)) 
     tx_er_reg1_i_1
       (.I0(tx_underrun_int),
        .I1(I7),
        .I2(O2),
        .I3(O1),
        .I4(PREAMBLE_DONE),
        .I5(O3),
        .O(int_gmii_tx_er));
endmodule

module TriMACTriMAC_block
   (gtx_clk,
    glbl_rstn,
    rx_axi_rstn,
    tx_axi_rstn,
    rx_enable,
    rx_statistics_vector,
    rx_statistics_valid,
    rx_mac_aclk,
    rx_reset,
    rx_axis_mac_tdata,
    rx_axis_mac_tvalid,
    rx_axis_mac_tlast,
    rx_axis_mac_tuser,
    tx_enable,
    tx_ifg_delay,
    tx_statistics_vector,
    tx_statistics_valid,
    tx_mac_aclk,
    tx_reset,
    tx_axis_mac_tdata,
    tx_axis_mac_tvalid,
    tx_axis_mac_tlast,
    tx_axis_mac_tuser,
    tx_axis_mac_tready,
    pause_req,
    pause_val,
    speedis100,
    speedis10100,
    rgmii_txd,
    rgmii_tx_ctl,
    rgmii_txc,
    rgmii_rxd,
    rgmii_rx_ctl,
    rgmii_rxc,
    inband_link_status,
    inband_clock_speed,
    inband_duplex_status,
    rx_configuration_vector,
    tx_configuration_vector);
  input gtx_clk;
  input glbl_rstn;
  input rx_axi_rstn;
  input tx_axi_rstn;
  output rx_enable;
  output [27:0]rx_statistics_vector;
  output rx_statistics_valid;
  output rx_mac_aclk;
  output rx_reset;
  output [7:0]rx_axis_mac_tdata;
  output rx_axis_mac_tvalid;
  output rx_axis_mac_tlast;
  output rx_axis_mac_tuser;
  output tx_enable;
  input [7:0]tx_ifg_delay;
  output [31:0]tx_statistics_vector;
  output tx_statistics_valid;
  output tx_mac_aclk;
  output tx_reset;
  input [7:0]tx_axis_mac_tdata;
  input tx_axis_mac_tvalid;
  input tx_axis_mac_tlast;
  input tx_axis_mac_tuser;
  output tx_axis_mac_tready;
  input pause_req;
  input [15:0]pause_val;
  output speedis100;
  output speedis10100;
  output [3:0]rgmii_txd;
  output rgmii_tx_ctl;
  output rgmii_txc;
  input [3:0]rgmii_rxd;
  input rgmii_rx_ctl;
  input rgmii_rxc;
  output inband_link_status;
  output [1:0]inband_clock_speed;
  output inband_duplex_status;
  input [79:0]rx_configuration_vector;
  input [79:0]tx_configuration_vector;

  wire \<const1> ;
  wire clk_div5;
  wire clk_div5_shift;
  wire counter0;
  wire glbl_rstn;
  wire gmii_rx_dv_int;
  wire gmii_rx_er_int;
  wire [7:0]gmii_rxd_int;
  wire [3:0]gmii_txd_falling;
  wire [3:0]gmii_txd_int;
  wire gtx_clk;
  wire [1:0]inband_clock_speed;
  wire inband_duplex_status;
  wire inband_link_status;
  wire n_0_rx_enable_int_i_1;
  wire n_65_TriMAC_core;
  wire n_6_enable_gen;
  wire pause_req;
  wire [15:0]pause_val;
  wire phy_tx_enable;
(* IBUF_LOW_PWR *)   wire rgmii_rx_ctl;
(* IBUF_LOW_PWR *)   wire rgmii_rxc;
(* IBUF_LOW_PWR *)   wire [3:0]rgmii_rxd;
(* DRIVE = "12" *)   wire rgmii_tx_ctl;
  wire rgmii_tx_ctl_int;
(* DRIVE = "12" *)   wire rgmii_txc;
(* DRIVE = "12" *)   wire [3:0]rgmii_txd;
  wire rx_axi_rstn;
  wire [7:0]rx_axis_mac_tdata;
  wire rx_axis_mac_tlast;
  wire rx_axis_mac_tuser;
  wire rx_axis_mac_tvalid;
  wire [79:0]rx_configuration_vector;
  wire rx_enable;
  wire rx_mac_aclk;
  wire rx_reset;
  wire rx_statistics_valid;
  wire [27:0]rx_statistics_vector;
  wire rxspeedis10100;
  wire speedis100;
  wire speedis10100;
  wire tx_axi_rstn;
  wire [7:0]tx_axis_mac_tdata;
  wire tx_axis_mac_tlast;
  wire tx_axis_mac_tready;
  wire tx_axis_mac_tuser;
  wire tx_axis_mac_tvalid;
  wire [79:0]tx_configuration_vector;
  wire tx_en_to_ddr;
  wire tx_enable;
  wire [7:0]tx_ifg_delay;
  wire tx_reset;
  wire tx_statistics_valid;
  wire [31:0]tx_statistics_vector;

  assign tx_mac_aclk = gtx_clk;
TriMACtri_mode_ethernet_mac_v8_1 TriMAC_core
       (.D(gmii_rxd_int),
        .E(tx_axis_mac_tready),
        .I1(rx_mac_aclk),
        .I2(rx_enable),
        .O1(rx_reset),
        .O2(tx_reset),
        .O3(speedis10100),
        .Q(gmii_txd_int),
        .SR(n_65_TriMAC_core),
        .clk_div5(clk_div5),
        .counter0(counter0),
        .glbl_rstn(glbl_rstn),
        .gmii_rx_dv_int(gmii_rx_dv_int),
        .gmii_rx_er_int(gmii_rx_er_int),
        .gmii_txd_falling(gmii_txd_falling),
        .gtx_clk(gtx_clk),
        .pause_req(pause_req),
        .pause_val(pause_val),
        .phy_tx_enable(phy_tx_enable),
        .rgmii_tx_ctl_int(rgmii_tx_ctl_int),
        .rx_axi_rstn(rx_axi_rstn),
        .rx_axis_mac_tdata(rx_axis_mac_tdata),
        .rx_axis_mac_tlast(rx_axis_mac_tlast),
        .rx_axis_mac_tuser(rx_axis_mac_tuser),
        .rx_axis_mac_tvalid(rx_axis_mac_tvalid),
        .rx_configuration_vector({rx_configuration_vector[79:32],rx_configuration_vector[30:16],rx_configuration_vector[14],rx_configuration_vector[11],rx_configuration_vector[9:8],rx_configuration_vector[5:0]}),
        .rx_statistics_valid(rx_statistics_valid),
        .rx_statistics_vector(rx_statistics_vector),
        .tx_axi_rstn(tx_axi_rstn),
        .tx_axis_mac_tdata(tx_axis_mac_tdata),
        .tx_axis_mac_tlast(tx_axis_mac_tlast),
        .tx_axis_mac_tuser(tx_axis_mac_tuser),
        .tx_axis_mac_tvalid(tx_axis_mac_tvalid),
        .tx_configuration_vector({tx_configuration_vector[79:32],tx_configuration_vector[30:16],tx_configuration_vector[14:12],tx_configuration_vector[8],tx_configuration_vector[5:0]}),
        .tx_en_to_ddr(tx_en_to_ddr),
        .tx_enable(tx_enable),
        .tx_ifg_delay(tx_ifg_delay),
        .tx_statistics_valid(tx_statistics_valid),
        .tx_statistics_vector(tx_statistics_vector));
VCC VCC
       (.P(\<const1> ));
TriMACTriMAC_clk_en_gen enable_gen
       (.I1(tx_reset),
        .O1(n_6_enable_gen),
        .SR(n_65_TriMAC_core),
        .clk_div5(clk_div5),
        .clk_div5_shift(clk_div5_shift),
        .counter0(counter0),
        .gtx_clk(gtx_clk),
        .phy_tx_enable(phy_tx_enable),
        .speedis100(speedis100),
        .speedis10100(speedis10100),
        .tx_configuration_vector(tx_configuration_vector[13:12]),
        .tx_enable(tx_enable));
TriMACTriMAC_rgmii_v2_0_if rgmii_interface
       (.D(gmii_rxd_int),
        .I1(tx_reset),
        .I2(rx_reset),
        .I3(n_6_enable_gen),
        .O1(rx_mac_aclk),
        .Q(gmii_txd_int),
        .clk_div5(clk_div5),
        .clk_div5_shift(clk_div5_shift),
        .gmii_rx_dv_int(gmii_rx_dv_int),
        .gmii_rx_er_int(gmii_rx_er_int),
        .gmii_txd_falling(gmii_txd_falling),
        .gtx_clk(gtx_clk),
        .inband_clock_speed(inband_clock_speed),
        .inband_duplex_status(inband_duplex_status),
        .inband_link_status(inband_link_status),
        .rgmii_rx_ctl(rgmii_rx_ctl),
        .rgmii_rxc(rgmii_rxc),
        .rgmii_rxd(rgmii_rxd),
        .rgmii_tx_ctl(rgmii_tx_ctl),
        .rgmii_tx_ctl_int(rgmii_tx_ctl_int),
        .rgmii_txc(rgmii_txc),
        .rgmii_txd(rgmii_txd),
        .tx_en_to_ddr(tx_en_to_ddr));
LUT2 #(
    .INIT(4'h7)) 
     rx_enable_int_i_1
       (.I0(rx_enable),
        .I1(rxspeedis10100),
        .O(n_0_rx_enable_int_i_1));
FDRE #(
    .INIT(1'b0)) 
     rx_enable_int_reg
       (.C(rx_mac_aclk),
        .CE(\<const1> ),
        .D(n_0_rx_enable_int_i_1),
        .Q(rx_enable),
        .R(rx_reset));
(* DEPTH = "5" *) 
   (* DONT_TOUCH *) 
   (* INITIALISE = "1'b0" *) 
   TriMACTriMAC_block_sync_block rxspeedis10100gen
       (.clk(rx_mac_aclk),
        .data_in(speedis10100),
        .data_out(rxspeedis10100));
endmodule

(* dont_touch = "yes" *) (* INITIALISE = "1'b0" *) (* DEPTH = "5" *) 
module TriMACTriMAC_block_sync_block
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire \<const0> ;
  wire \<const1> ;
  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(clk),
        .CE(\<const1> ),
        .D(data_in),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
endmodule

(* ORIG_REF_NAME = "TriMAC_block_sync_block" *) (* dont_touch = "yes" *) (* INITIALISE = "1'b0" *) 
(* DEPTH = "5" *) 
module TriMACTriMAC_block_sync_block__1
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire \<const0> ;
  wire \<const1> ;
  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(clk),
        .CE(\<const1> ),
        .D(data_in),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
endmodule

(* ORIG_REF_NAME = "TriMAC_block_sync_block" *) (* dont_touch = "yes" *) (* INITIALISE = "1'b0" *) 
(* DEPTH = "5" *) 
module TriMACTriMAC_block_sync_block__2
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire \<const0> ;
  wire \<const1> ;
  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(clk),
        .CE(\<const1> ),
        .D(data_in),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "NO" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
endmodule

module TriMACTriMAC_clk_en_gen
   (speedis100,
    tx_enable,
    phy_tx_enable,
    counter0,
    clk_div5,
    clk_div5_shift,
    O1,
    gtx_clk,
    speedis10100,
    I1,
    tx_configuration_vector,
    SR);
  output speedis100;
  output tx_enable;
  output phy_tx_enable;
  output counter0;
  output clk_div5;
  output clk_div5_shift;
  output O1;
  input gtx_clk;
  input speedis10100;
  input I1;
  input [1:0]tx_configuration_vector;
  input [0:0]SR;

  wire \<const0> ;
  wire \<const1> ;
  wire I1;
  wire O1;
  wire [0:0]SR;
  wire client_tx_enable0;
  wire clk_div5;
  wire clk_div5_int;
  wire clk_div5_shift;
  wire clk_div5_shift_int;
  wire counter0;
  wire [5:0]counter_reg__0;
  wire div_2;
  wire gtx_clk;
  wire n_0_clk_div5_int_i_1;
  wire n_0_clk_div5_int_i_2;
  wire n_0_clk_div5_int_i_3;
  wire n_0_clk_div5_int_i_4;
  wire n_0_clk_div5_int_i_5;
  wire n_0_clk_div5_int_i_6;
  wire n_0_clk_div5_shift_int_i_1;
  wire n_0_div_2_i_1;
  wire n_0_phy_tx_enable_falling_i_1;
  wire n_0_phy_tx_enable_falling_i_2;
  wire n_0_phy_tx_enable_falling_i_3;
  wire n_0_phy_tx_enable_i_2;
  wire [5:0]p_0_in;
  wire phy_tx_enable;
  wire phy_tx_enable_falling;
  wire speed_is_100_int;
  wire speed_is_10_100_int;
  wire speedis100;
  wire speedis10100;
  wire [1:0]tx_configuration_vector;
  wire tx_enable;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
LUT2 #(
    .INIT(4'h2)) 
     client_tx_enable_i_1
       (.I0(counter0),
        .I1(div_2),
        .O(client_tx_enable0));
FDRE client_tx_enable_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(client_tx_enable0),
        .Q(tx_enable),
        .R(I1));
LUT6 #(
    .INIT(64'h0F0001000E000000)) 
     clk_div5_int_i_1
       (.I0(n_0_clk_div5_int_i_2),
        .I1(n_0_clk_div5_int_i_3),
        .I2(I1),
        .I3(speed_is_10_100_int),
        .I4(counter0),
        .I5(clk_div5_int),
        .O(n_0_clk_div5_int_i_1));
LUT6 #(
    .INIT(64'hAAAABAEFAAAAAAAA)) 
     clk_div5_int_i_2
       (.I0(counter0),
        .I1(speed_is_100_int),
        .I2(speed_is_10_100_int),
        .I3(counter_reg__0[4]),
        .I4(n_0_clk_div5_int_i_4),
        .I5(n_0_clk_div5_int_i_5),
        .O(n_0_clk_div5_int_i_2));
LUT6 #(
    .INIT(64'h0000000000080051)) 
     clk_div5_int_i_3
       (.I0(counter_reg__0[3]),
        .I1(speed_is_10_100_int),
        .I2(speed_is_100_int),
        .I3(counter_reg__0[5]),
        .I4(counter_reg__0[4]),
        .I5(n_0_clk_div5_int_i_6),
        .O(n_0_clk_div5_int_i_3));
LUT6 #(
    .INIT(64'hFFEEFFFFEEFFFEFE)) 
     clk_div5_int_i_4
       (.I0(counter_reg__0[5]),
        .I1(counter_reg__0[3]),
        .I2(counter_reg__0[0]),
        .I3(speed_is_100_int),
        .I4(speed_is_10_100_int),
        .I5(counter_reg__0[2]),
        .O(n_0_clk_div5_int_i_4));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT4 #(
    .INIT(16'h6033)) 
     clk_div5_int_i_5
       (.I0(speed_is_100_int),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[0]),
        .I3(speed_is_10_100_int),
        .O(n_0_clk_div5_int_i_5));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT5 #(
    .INIT(32'hFFFFBEEE)) 
     clk_div5_int_i_6
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .I2(speed_is_10_100_int),
        .I3(speed_is_100_int),
        .I4(counter_reg__0[2]),
        .O(n_0_clk_div5_int_i_6));
FDRE clk_div5_int_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_clk_div5_int_i_1),
        .Q(clk_div5_int),
        .R(\<const0> ));
FDRE clk_div5_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(clk_div5_int),
        .Q(clk_div5),
        .R(I1));
LUT5 #(
    .INIT(32'h0B0F0A0F)) 
     clk_div5_shift_int_i_1
       (.I0(n_0_clk_div5_int_i_2),
        .I1(n_0_clk_div5_int_i_3),
        .I2(I1),
        .I3(speed_is_10_100_int),
        .I4(clk_div5_shift_int),
        .O(n_0_clk_div5_shift_int_i_1));
FDRE clk_div5_shift_int_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_clk_div5_shift_int_i_1),
        .Q(clk_div5_shift_int),
        .R(\<const0> ));
FDRE clk_div5_shift_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(clk_div5_shift_int),
        .Q(clk_div5_shift),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     control_enable_i_1
       (.I0(phy_tx_enable),
        .I1(phy_tx_enable_falling),
        .I2(tx_configuration_vector[1]),
        .I3(I1),
        .O(O1));
LUT1 #(
    .INIT(2'h1)) 
     \counter[0]_i_1__0 
       (.I0(counter_reg__0[0]),
        .O(p_0_in[0]));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \counter[1]_i_1__0 
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .O(p_0_in[1]));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \counter[2]_i_1__0 
       (.I0(counter_reg__0[2]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[0]),
        .O(p_0_in[2]));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \counter[3]_i_1__0 
       (.I0(counter_reg__0[3]),
        .I1(counter_reg__0[2]),
        .I2(counter_reg__0[0]),
        .I3(counter_reg__0[1]),
        .O(p_0_in[3]));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \counter[4]_i_1__0 
       (.I0(counter_reg__0[4]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[0]),
        .I3(counter_reg__0[2]),
        .I4(counter_reg__0[3]),
        .O(p_0_in[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \counter[5]_i_2__0 
       (.I0(counter_reg__0[5]),
        .I1(counter_reg__0[3]),
        .I2(counter_reg__0[2]),
        .I3(counter_reg__0[0]),
        .I4(counter_reg__0[1]),
        .I5(counter_reg__0[4]),
        .O(p_0_in[5]));
(* counter = "13" *) 
   FDRE \counter_reg[0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(p_0_in[0]),
        .Q(counter_reg__0[0]),
        .R(SR));
(* counter = "13" *) 
   FDRE \counter_reg[1] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(p_0_in[1]),
        .Q(counter_reg__0[1]),
        .R(SR));
(* counter = "13" *) 
   FDRE \counter_reg[2] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(p_0_in[2]),
        .Q(counter_reg__0[2]),
        .R(SR));
(* counter = "13" *) 
   FDRE \counter_reg[3] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(p_0_in[3]),
        .Q(counter_reg__0[3]),
        .R(SR));
(* counter = "13" *) 
   FDRE \counter_reg[4] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(p_0_in[4]),
        .Q(counter_reg__0[4]),
        .R(SR));
(* counter = "13" *) 
   FDRE \counter_reg[5] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(p_0_in[5]),
        .Q(counter_reg__0[5]),
        .R(SR));
LUT4 #(
    .INIT(16'h0060)) 
     div_2_i_1
       (.I0(div_2),
        .I1(counter0),
        .I2(speed_is_10_100_int),
        .I3(I1),
        .O(n_0_div_2_i_1));
FDRE div_2_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_div_2_i_1),
        .Q(div_2),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'hBBBBBBBBBBB8B888)) 
     phy_tx_enable_falling_i_1
       (.I0(phy_tx_enable_falling),
        .I1(I1),
        .I2(counter_reg__0[4]),
        .I3(n_0_phy_tx_enable_falling_i_2),
        .I4(n_0_phy_tx_enable_falling_i_3),
        .I5(counter_reg__0[5]),
        .O(n_0_phy_tx_enable_falling_i_1));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT2 #(
    .INIT(4'hB)) 
     phy_tx_enable_falling_i_2
       (.I0(speed_is_100_int),
        .I1(speed_is_10_100_int),
        .O(n_0_phy_tx_enable_falling_i_2));
LUT6 #(
    .INIT(64'hFFFFFFFFFE80FFFF)) 
     phy_tx_enable_falling_i_3
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[2]),
        .I3(speed_is_100_int),
        .I4(speed_is_10_100_int),
        .I5(counter_reg__0[3]),
        .O(n_0_phy_tx_enable_falling_i_3));
FDRE phy_tx_enable_falling_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_phy_tx_enable_falling_i_1),
        .Q(phy_tx_enable_falling),
        .R(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT5 #(
    .INIT(32'hBFBBBB0B)) 
     phy_tx_enable_i_1
       (.I0(speed_is_100_int),
        .I1(speed_is_10_100_int),
        .I2(n_0_phy_tx_enable_i_2),
        .I3(counter_reg__0[4]),
        .I4(counter_reg__0[5]),
        .O(counter0));
LUT6 #(
    .INIT(64'h0000000050005100)) 
     phy_tx_enable_i_2
       (.I0(counter_reg__0[3]),
        .I1(counter_reg__0[1]),
        .I2(speed_is_100_int),
        .I3(speed_is_10_100_int),
        .I4(counter_reg__0[0]),
        .I5(counter_reg__0[2]),
        .O(n_0_phy_tx_enable_i_2));
FDRE phy_tx_enable_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(counter0),
        .Q(phy_tx_enable),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT2 #(
    .INIT(4'h2)) 
     speedis100_INST_0
       (.I0(tx_configuration_vector[0]),
        .I1(tx_configuration_vector[1]),
        .O(speedis100));
(* DEPTH = "5" *) 
   (* DONT_TOUCH *) 
   (* INITIALISE = "1'b0" *) 
   TriMACTriMAC_block_sync_block__2 txspeedis100gen
       (.clk(gtx_clk),
        .data_in(speedis100),
        .data_out(speed_is_100_int));
(* DEPTH = "5" *) 
   (* DONT_TOUCH *) 
   (* INITIALISE = "1'b0" *) 
   TriMACTriMAC_block_sync_block__1 txspeedis10100gen
       (.clk(gtx_clk),
        .data_in(speedis10100),
        .data_out(speed_is_10_100_int));
endmodule

module TriMACTriMAC_rgmii_v2_0_if
   (rgmii_txc,
    rgmii_tx_ctl,
    O1,
    gmii_rx_dv_int,
    rgmii_txd,
    D,
    inband_link_status,
    inband_duplex_status,
    inband_clock_speed,
    gmii_rx_er_int,
    rgmii_rxc,
    rgmii_rx_ctl,
    gtx_clk,
    clk_div5_shift,
    clk_div5,
    I1,
    tx_en_to_ddr,
    rgmii_tx_ctl_int,
    rgmii_rxd,
    Q,
    gmii_txd_falling,
    I2,
    I3);
  output rgmii_txc;
  output rgmii_tx_ctl;
  output O1;
  output gmii_rx_dv_int;
  output [3:0]rgmii_txd;
  output [7:0]D;
  output inband_link_status;
  output inband_duplex_status;
  output [1:0]inband_clock_speed;
  output gmii_rx_er_int;
  input rgmii_rxc;
  input rgmii_rx_ctl;
  input gtx_clk;
  input clk_div5_shift;
  input clk_div5;
  input I1;
  input tx_en_to_ddr;
  input rgmii_tx_ctl_int;
  input [3:0]rgmii_rxd;
  input [3:0]Q;
  input [3:0]gmii_txd_falling;
  input I2;
  input I3;

  wire \<const0> ;
  wire \<const1> ;
  wire [7:0]D;
  wire I1;
  wire I2;
  wire I3;
  wire O1;
  wire [3:0]Q;
  wire clk_div5;
  wire clk_div5_shift;
  wire control_enable;
  wire gmii_rx_dv_int;
  wire gmii_rx_er_int;
  wire [3:0]gmii_txd_falling;
  wire gtx_clk;
  wire inband_ce;
  wire [1:0]inband_clock_speed;
  wire inband_duplex_status;
  wire inband_link_status;
  wire \n_0_rxdata_bus[1].delay_rgmii_rxd ;
  wire \n_0_rxdata_bus[3].delay_rgmii_rxd ;
  wire \n_0_txdata_out_bus[0].delay_rgmii_txd ;
  wire \n_0_txdata_out_bus[0].rgmii_txd_out ;
  wire \n_0_txdata_out_bus[1].rgmii_txd_out ;
  wire \n_0_txdata_out_bus[2].delay_rgmii_txd ;
  wire \n_0_txdata_out_bus[2].rgmii_txd_out ;
  wire \n_0_txdata_out_bus[3].rgmii_txd_out ;
  wire p_0_in;
  wire p_0_out;
  wire p_2_in;
  wire p_2_out;
  wire p_3_in;
  wire p_4_in;
  wire p_6_in;
  wire p_9_in;
  wire rgmii_rx_clk_bufio;
(* IBUF_LOW_PWR *)   wire rgmii_rx_ctl;
  wire rgmii_rx_ctl_delay;
  wire rgmii_rx_ctl_ibuf;
  wire rgmii_rx_ctl_reg;
(* IBUF_LOW_PWR *)   wire rgmii_rxc;
  wire rgmii_rxc_ibuf;
(* IBUF_LOW_PWR *)   wire [3:0]rgmii_rxd;
(* DRIVE = "12" *)   wire rgmii_tx_ctl;
  wire rgmii_tx_ctl_int;
  wire rgmii_tx_ctl_obuf;
  wire rgmii_tx_ctl_odelay;
(* DRIVE = "12" *)   wire rgmii_txc;
  wire rgmii_txc_obuf;
  wire rgmii_txc_odelay;
(* DRIVE = "12" *)   wire [3:0]rgmii_txd;
  wire tx_en_to_ddr;
  wire NLW_ctl_output_S_UNCONNECTED;
  wire [4:0]NLW_delay_rgmii_rx_ctl_CNTVALUEOUT_UNCONNECTED;
  wire [4:0]NLW_delay_rgmii_tx_clk_CNTVALUEOUT_UNCONNECTED;
  wire [4:0]NLW_delay_rgmii_tx_ctl_CNTVALUEOUT_UNCONNECTED;
  wire NLW_rgmii_txc_ddr_S_UNCONNECTED;
  wire [4:0]\NLW_rxdata_bus[0].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED ;
  wire [4:0]\NLW_rxdata_bus[1].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED ;
  wire [4:0]\NLW_rxdata_bus[2].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED ;
  wire [4:0]\NLW_rxdata_bus[3].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED ;
  wire [4:0]\NLW_txdata_out_bus[0].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED ;
  wire \NLW_txdata_out_bus[0].rgmii_txd_out_S_UNCONNECTED ;
  wire [4:0]\NLW_txdata_out_bus[1].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED ;
  wire \NLW_txdata_out_bus[1].rgmii_txd_out_S_UNCONNECTED ;
  wire [4:0]\NLW_txdata_out_bus[2].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED ;
  wire \NLW_txdata_out_bus[2].rgmii_txd_out_S_UNCONNECTED ;
  wire [4:0]\NLW_txdata_out_bus[3].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED ;
  wire \NLW_txdata_out_bus[3].rgmii_txd_out_S_UNCONNECTED ;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   BUFIO bufio_rgmii_rx_clk
       (.I(rgmii_rxc_ibuf),
        .O(rgmii_rx_clk_bufio));
(* BOX_TYPE = "PRIMITIVE" *) 
   BUFR #(
    .BUFR_DIVIDE("BYPASS"),
    .SIM_DEVICE("7SERIES")) 
     bufr_rgmii_rx_clk
       (.CE(\<const1> ),
        .CLR(\<const0> ),
        .I(rgmii_rxc_ibuf),
        .O(O1));
FDRE \clock_speed_reg[0] 
       (.C(O1),
        .CE(inband_ce),
        .D(D[1]),
        .Q(inband_clock_speed[0]),
        .R(I2));
FDRE \clock_speed_reg[1] 
       (.C(O1),
        .CE(inband_ce),
        .D(D[2]),
        .Q(inband_clock_speed[1]),
        .R(I2));
FDRE control_enable_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(I3),
        .Q(control_enable),
        .R(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* __SRVAL = "FALSE" *) 
   ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
     ctl_output
       (.C(gtx_clk),
        .CE(control_enable),
        .D1(tx_en_to_ddr),
        .D2(rgmii_tx_ctl_int),
        .Q(rgmii_tx_ctl_odelay),
        .R(I1),
        .S(NLW_ctl_output_S_UNCONNECTED));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* SIM_DELAY_D = "0" *) 
   IDELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("IDATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IDELAY_TYPE("FIXED"),
    .IDELAY_VALUE(13),
    .IS_C_INVERTED(1'b0),
    .IS_DATAIN_INVERTED(1'b0),
    .IS_IDATAIN_INVERTED(1'b0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
     delay_rgmii_rx_ctl
       (.C(\<const0> ),
        .CE(\<const0> ),
        .CINVCTRL(\<const0> ),
        .CNTVALUEIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CNTVALUEOUT(NLW_delay_rgmii_rx_ctl_CNTVALUEOUT_UNCONNECTED[4:0]),
        .DATAIN(\<const0> ),
        .DATAOUT(rgmii_rx_ctl_delay),
        .IDATAIN(rgmii_rx_ctl_ibuf),
        .INC(\<const0> ),
        .LD(\<const0> ),
        .LDPIPEEN(\<const0> ),
        .REGRST(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* SIM_DELAY_D = "0" *) 
   ODELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("ODATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IS_C_INVERTED(1'b0),
    .IS_ODATAIN_INVERTED(1'b0),
    .ODELAY_TYPE("FIXED"),
    .ODELAY_VALUE(26),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
     delay_rgmii_tx_clk
       (.C(\<const0> ),
        .CE(\<const0> ),
        .CINVCTRL(\<const0> ),
        .CLKIN(\<const0> ),
        .CNTVALUEIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CNTVALUEOUT(NLW_delay_rgmii_tx_clk_CNTVALUEOUT_UNCONNECTED[4:0]),
        .DATAOUT(rgmii_txc_obuf),
        .INC(\<const0> ),
        .LD(\<const0> ),
        .LDPIPEEN(\<const0> ),
        .ODATAIN(rgmii_txc_odelay),
        .REGRST(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* SIM_DELAY_D = "0" *) 
   ODELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("ODATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IS_C_INVERTED(1'b0),
    .IS_ODATAIN_INVERTED(1'b0),
    .ODELAY_TYPE("FIXED"),
    .ODELAY_VALUE(0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
     delay_rgmii_tx_ctl
       (.C(\<const0> ),
        .CE(\<const0> ),
        .CINVCTRL(\<const0> ),
        .CLKIN(\<const0> ),
        .CNTVALUEIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CNTVALUEOUT(NLW_delay_rgmii_tx_ctl_CNTVALUEOUT_UNCONNECTED[4:0]),
        .DATAOUT(rgmii_tx_ctl_obuf),
        .INC(\<const0> ),
        .LD(\<const0> ),
        .LDPIPEEN(\<const0> ),
        .ODATAIN(rgmii_tx_ctl_odelay),
        .REGRST(\<const0> ));
FDRE duplex_status_reg
       (.C(O1),
        .CE(inband_ce),
        .D(D[3]),
        .Q(inband_duplex_status),
        .R(I2));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   (* IBUF_DELAY_VALUE = "0" *) 
   (* IFD_DELAY_VALUE = "AUTO" *) 
   IBUF #(
    .IOSTANDARD("DEFAULT")) 
     \ibuf_data[0].rgmii_rxd_ibuf_i 
       (.I(rgmii_rxd[0]),
        .O(p_6_in));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   (* IBUF_DELAY_VALUE = "0" *) 
   (* IFD_DELAY_VALUE = "AUTO" *) 
   IBUF #(
    .IOSTANDARD("DEFAULT")) 
     \ibuf_data[1].rgmii_rxd_ibuf_i 
       (.I(rgmii_rxd[1]),
        .O(p_4_in));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   (* IBUF_DELAY_VALUE = "0" *) 
   (* IFD_DELAY_VALUE = "AUTO" *) 
   IBUF #(
    .IOSTANDARD("DEFAULT")) 
     \ibuf_data[2].rgmii_rxd_ibuf_i 
       (.I(rgmii_rxd[2]),
        .O(p_2_in));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   (* IBUF_DELAY_VALUE = "0" *) 
   (* IFD_DELAY_VALUE = "AUTO" *) 
   IBUF #(
    .IOSTANDARD("DEFAULT")) 
     \ibuf_data[3].rgmii_rxd_ibuf_i 
       (.I(rgmii_rxd[3]),
        .O(p_0_in));
LUT2 #(
    .INIT(4'h1)) 
     link_status_i_1
       (.I0(rgmii_rx_ctl_reg),
        .I1(gmii_rx_dv_int),
        .O(inband_ce));
FDRE link_status_reg
       (.C(O1),
        .CE(inband_ce),
        .D(D[0]),
        .Q(inband_link_status),
        .R(I2));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   OBUF #(
    .IOSTANDARD("DEFAULT")) 
     \obuf_data[0].rgmii_txd_obuf_i 
       (.I(\n_0_txdata_out_bus[0].delay_rgmii_txd ),
        .O(rgmii_txd[0]));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   OBUF #(
    .IOSTANDARD("DEFAULT")) 
     \obuf_data[1].rgmii_txd_obuf_i 
       (.I(p_2_out),
        .O(rgmii_txd[1]));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   OBUF #(
    .IOSTANDARD("DEFAULT")) 
     \obuf_data[2].rgmii_txd_obuf_i 
       (.I(\n_0_txdata_out_bus[2].delay_rgmii_txd ),
        .O(rgmii_txd[2]));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   OBUF #(
    .IOSTANDARD("DEFAULT")) 
     \obuf_data[3].rgmii_txd_obuf_i 
       (.I(p_0_out),
        .O(rgmii_txd[3]));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   (* IBUF_DELAY_VALUE = "0" *) 
   (* IFD_DELAY_VALUE = "AUTO" *) 
   IBUF #(
    .IOSTANDARD("DEFAULT")) 
     rgmii_rx_ctl_ibuf_i
       (.I(rgmii_rx_ctl),
        .O(rgmii_rx_ctl_ibuf));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* __SRVAL = "TRUE" *) 
   IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
     rgmii_rx_ctl_in
       (.C(rgmii_rx_clk_bufio),
        .CE(\<const1> ),
        .D(rgmii_rx_ctl_delay),
        .Q1(gmii_rx_dv_int),
        .Q2(rgmii_rx_ctl_reg),
        .R(\<const0> ),
        .S(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   (* IBUF_DELAY_VALUE = "0" *) 
   (* IFD_DELAY_VALUE = "AUTO" *) 
   IBUF #(
    .IOSTANDARD("DEFAULT")) 
     rgmii_rxc_ibuf_i
       (.I(rgmii_rxc),
        .O(rgmii_rxc_ibuf));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   OBUF #(
    .IOSTANDARD("DEFAULT")) 
     rgmii_tx_ctl_obuf_i
       (.I(rgmii_tx_ctl_obuf),
        .O(rgmii_tx_ctl));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* __SRVAL = "FALSE" *) 
   ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
     rgmii_txc_ddr
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D1(clk_div5_shift),
        .D2(clk_div5),
        .Q(rgmii_txc_odelay),
        .R(I1),
        .S(NLW_rgmii_txc_ddr_S_UNCONNECTED));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* CAPACITANCE = "DONT_CARE" *) 
   OBUF #(
    .IOSTANDARD("DEFAULT")) 
     rgmii_txc_obuf_i
       (.I(rgmii_txc_obuf),
        .O(rgmii_txc));
LUT2 #(
    .INIT(4'h6)) 
     rx_er_reg1_i_1
       (.I0(gmii_rx_dv_int),
        .I1(rgmii_rx_ctl_reg),
        .O(gmii_rx_er_int));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* SIM_DELAY_D = "0" *) 
   IDELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("IDATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IDELAY_TYPE("FIXED"),
    .IDELAY_VALUE(13),
    .IS_C_INVERTED(1'b0),
    .IS_DATAIN_INVERTED(1'b0),
    .IS_IDATAIN_INVERTED(1'b0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
     \rxdata_bus[0].delay_rgmii_rxd 
       (.C(\<const0> ),
        .CE(\<const0> ),
        .CINVCTRL(\<const0> ),
        .CNTVALUEIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CNTVALUEOUT(\NLW_rxdata_bus[0].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED [4:0]),
        .DATAIN(\<const0> ),
        .DATAOUT(p_9_in),
        .IDATAIN(p_6_in),
        .INC(\<const0> ),
        .LD(\<const0> ),
        .LDPIPEEN(\<const0> ),
        .REGRST(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* SIM_DELAY_D = "0" *) 
   IDELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("IDATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IDELAY_TYPE("FIXED"),
    .IDELAY_VALUE(13),
    .IS_C_INVERTED(1'b0),
    .IS_DATAIN_INVERTED(1'b0),
    .IS_IDATAIN_INVERTED(1'b0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
     \rxdata_bus[1].delay_rgmii_rxd 
       (.C(\<const0> ),
        .CE(\<const0> ),
        .CINVCTRL(\<const0> ),
        .CNTVALUEIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CNTVALUEOUT(\NLW_rxdata_bus[1].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED [4:0]),
        .DATAIN(\<const0> ),
        .DATAOUT(\n_0_rxdata_bus[1].delay_rgmii_rxd ),
        .IDATAIN(p_4_in),
        .INC(\<const0> ),
        .LD(\<const0> ),
        .LDPIPEEN(\<const0> ),
        .REGRST(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* SIM_DELAY_D = "0" *) 
   IDELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("IDATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IDELAY_TYPE("FIXED"),
    .IDELAY_VALUE(13),
    .IS_C_INVERTED(1'b0),
    .IS_DATAIN_INVERTED(1'b0),
    .IS_IDATAIN_INVERTED(1'b0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
     \rxdata_bus[2].delay_rgmii_rxd 
       (.C(\<const0> ),
        .CE(\<const0> ),
        .CINVCTRL(\<const0> ),
        .CNTVALUEIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CNTVALUEOUT(\NLW_rxdata_bus[2].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED [4:0]),
        .DATAIN(\<const0> ),
        .DATAOUT(p_3_in),
        .IDATAIN(p_2_in),
        .INC(\<const0> ),
        .LD(\<const0> ),
        .LDPIPEEN(\<const0> ),
        .REGRST(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* SIM_DELAY_D = "0" *) 
   IDELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("IDATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IDELAY_TYPE("FIXED"),
    .IDELAY_VALUE(13),
    .IS_C_INVERTED(1'b0),
    .IS_DATAIN_INVERTED(1'b0),
    .IS_IDATAIN_INVERTED(1'b0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
     \rxdata_bus[3].delay_rgmii_rxd 
       (.C(\<const0> ),
        .CE(\<const0> ),
        .CINVCTRL(\<const0> ),
        .CNTVALUEIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CNTVALUEOUT(\NLW_rxdata_bus[3].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED [4:0]),
        .DATAIN(\<const0> ),
        .DATAOUT(\n_0_rxdata_bus[3].delay_rgmii_rxd ),
        .IDATAIN(p_0_in),
        .INC(\<const0> ),
        .LD(\<const0> ),
        .LDPIPEEN(\<const0> ),
        .REGRST(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* __SRVAL = "TRUE" *) 
   IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
     \rxdata_in_bus[0].rgmii_rx_data_in 
       (.C(rgmii_rx_clk_bufio),
        .CE(\<const1> ),
        .D(p_9_in),
        .Q1(D[0]),
        .Q2(D[4]),
        .R(\<const0> ),
        .S(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* __SRVAL = "TRUE" *) 
   IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
     \rxdata_in_bus[1].rgmii_rx_data_in 
       (.C(rgmii_rx_clk_bufio),
        .CE(\<const1> ),
        .D(\n_0_rxdata_bus[1].delay_rgmii_rxd ),
        .Q1(D[1]),
        .Q2(D[5]),
        .R(\<const0> ),
        .S(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* __SRVAL = "TRUE" *) 
   IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
     \rxdata_in_bus[2].rgmii_rx_data_in 
       (.C(rgmii_rx_clk_bufio),
        .CE(\<const1> ),
        .D(p_3_in),
        .Q1(D[2]),
        .Q2(D[6]),
        .R(\<const0> ),
        .S(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* __SRVAL = "TRUE" *) 
   IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
     \rxdata_in_bus[3].rgmii_rx_data_in 
       (.C(rgmii_rx_clk_bufio),
        .CE(\<const1> ),
        .D(\n_0_rxdata_bus[3].delay_rgmii_rxd ),
        .Q1(D[3]),
        .Q2(D[7]),
        .R(\<const0> ),
        .S(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* SIM_DELAY_D = "0" *) 
   ODELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("ODATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IS_C_INVERTED(1'b0),
    .IS_ODATAIN_INVERTED(1'b0),
    .ODELAY_TYPE("FIXED"),
    .ODELAY_VALUE(0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
     \txdata_out_bus[0].delay_rgmii_txd 
       (.C(\<const0> ),
        .CE(\<const0> ),
        .CINVCTRL(\<const0> ),
        .CLKIN(\<const0> ),
        .CNTVALUEIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CNTVALUEOUT(\NLW_txdata_out_bus[0].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED [4:0]),
        .DATAOUT(\n_0_txdata_out_bus[0].delay_rgmii_txd ),
        .INC(\<const0> ),
        .LD(\<const0> ),
        .LDPIPEEN(\<const0> ),
        .ODATAIN(\n_0_txdata_out_bus[0].rgmii_txd_out ),
        .REGRST(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* __SRVAL = "FALSE" *) 
   ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
     \txdata_out_bus[0].rgmii_txd_out 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D1(Q[0]),
        .D2(gmii_txd_falling[0]),
        .Q(\n_0_txdata_out_bus[0].rgmii_txd_out ),
        .R(I1),
        .S(\NLW_txdata_out_bus[0].rgmii_txd_out_S_UNCONNECTED ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* SIM_DELAY_D = "0" *) 
   ODELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("ODATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IS_C_INVERTED(1'b0),
    .IS_ODATAIN_INVERTED(1'b0),
    .ODELAY_TYPE("FIXED"),
    .ODELAY_VALUE(0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
     \txdata_out_bus[1].delay_rgmii_txd 
       (.C(\<const0> ),
        .CE(\<const0> ),
        .CINVCTRL(\<const0> ),
        .CLKIN(\<const0> ),
        .CNTVALUEIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CNTVALUEOUT(\NLW_txdata_out_bus[1].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED [4:0]),
        .DATAOUT(p_2_out),
        .INC(\<const0> ),
        .LD(\<const0> ),
        .LDPIPEEN(\<const0> ),
        .ODATAIN(\n_0_txdata_out_bus[1].rgmii_txd_out ),
        .REGRST(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* __SRVAL = "FALSE" *) 
   ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
     \txdata_out_bus[1].rgmii_txd_out 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D1(Q[1]),
        .D2(gmii_txd_falling[1]),
        .Q(\n_0_txdata_out_bus[1].rgmii_txd_out ),
        .R(I1),
        .S(\NLW_txdata_out_bus[1].rgmii_txd_out_S_UNCONNECTED ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* SIM_DELAY_D = "0" *) 
   ODELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("ODATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IS_C_INVERTED(1'b0),
    .IS_ODATAIN_INVERTED(1'b0),
    .ODELAY_TYPE("FIXED"),
    .ODELAY_VALUE(0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
     \txdata_out_bus[2].delay_rgmii_txd 
       (.C(\<const0> ),
        .CE(\<const0> ),
        .CINVCTRL(\<const0> ),
        .CLKIN(\<const0> ),
        .CNTVALUEIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CNTVALUEOUT(\NLW_txdata_out_bus[2].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED [4:0]),
        .DATAOUT(\n_0_txdata_out_bus[2].delay_rgmii_txd ),
        .INC(\<const0> ),
        .LD(\<const0> ),
        .LDPIPEEN(\<const0> ),
        .ODATAIN(\n_0_txdata_out_bus[2].rgmii_txd_out ),
        .REGRST(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* __SRVAL = "FALSE" *) 
   ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
     \txdata_out_bus[2].rgmii_txd_out 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D1(Q[2]),
        .D2(gmii_txd_falling[2]),
        .Q(\n_0_txdata_out_bus[2].rgmii_txd_out ),
        .R(I1),
        .S(\NLW_txdata_out_bus[2].rgmii_txd_out_S_UNCONNECTED ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* SIM_DELAY_D = "0" *) 
   ODELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("ODATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IS_C_INVERTED(1'b0),
    .IS_ODATAIN_INVERTED(1'b0),
    .ODELAY_TYPE("FIXED"),
    .ODELAY_VALUE(0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
     \txdata_out_bus[3].delay_rgmii_txd 
       (.C(\<const0> ),
        .CE(\<const0> ),
        .CINVCTRL(\<const0> ),
        .CLKIN(\<const0> ),
        .CNTVALUEIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CNTVALUEOUT(\NLW_txdata_out_bus[3].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED [4:0]),
        .DATAOUT(p_0_out),
        .INC(\<const0> ),
        .LD(\<const0> ),
        .LDPIPEEN(\<const0> ),
        .ODATAIN(\n_0_txdata_out_bus[3].rgmii_txd_out ),
        .REGRST(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* __SRVAL = "FALSE" *) 
   ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
     \txdata_out_bus[3].rgmii_txd_out 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D1(Q[3]),
        .D2(gmii_txd_falling[3]),
        .Q(\n_0_txdata_out_bus[3].rgmii_txd_out ),
        .R(I1),
        .S(\NLW_txdata_out_bus[3].rgmii_txd_out_S_UNCONNECTED ));
endmodule

module TriMACrx
   (O1,
    END_OF_FRAME,
    int_rx_control_frame,
    int_rx_data_valid_in,
    int_rx_good_frame_in,
    int_rx_bad_frame_in,
    rx_statistics_valid,
    O3,
    O2,
    O4,
    O5,
    bad_pfc_opcode_int,
    rx_bad_frame_comb,
    rx_statistics_vector,
    I7,
    O6,
    data_valid_early,
    E,
    O7,
    pause_match_reg0,
    special_pause_match_comb,
    O8,
    O9,
    I2,
    broadcastaddressmatch,
    I1,
    SR,
    rx_configuration_vector,
    gmii_rx_er_from_mii,
    gmii_rx_dv_from_mii,
    tx_configuration_vector,
    Q,
    I3,
    I4,
    I5,
    rx_data_valid_reg1,
    update_pause_ad_sync,
    update_pause_ad_sync_reg,
    address_valid_early,
    I6,
    MATCH_FRAME_INT0,
    pauseaddressmatch,
    specialpauseaddressmatch,
    int_alignment_err_pulse,
    alignment_err_reg,
    I8,
    rx_enable_reg,
    broadcast_byte_match,
    p_10_out,
    p_6_out,
    p_3_out,
    p_0_out,
    p_4_out,
    p_2_out,
    p_1_out,
    p_5_out,
    I9,
    p_9_out,
    I10,
    p_8_out,
    p_7_out,
    I11,
    I12,
    I13,
    D,
    I14);
  output O1;
  output END_OF_FRAME;
  output int_rx_control_frame;
  output int_rx_data_valid_in;
  output int_rx_good_frame_in;
  output int_rx_bad_frame_in;
  output rx_statistics_valid;
  output O3;
  output O2;
  output O4;
  output [0:0]O5;
  output bad_pfc_opcode_int;
  output rx_bad_frame_comb;
  output [25:0]rx_statistics_vector;
  output [0:0]I7;
  output O6;
  output data_valid_early;
  output [0:0]E;
  output O7;
  output pause_match_reg0;
  output special_pause_match_comb;
  output O8;
  output [7:0]O9;
  input I2;
  input broadcastaddressmatch;
  input I1;
  input [0:0]SR;
  input [21:0]rx_configuration_vector;
  input gmii_rx_er_from_mii;
  input gmii_rx_dv_from_mii;
  input [1:0]tx_configuration_vector;
  input [0:0]Q;
  input I3;
  input I4;
  input I5;
  input rx_data_valid_reg1;
  input update_pause_ad_sync;
  input update_pause_ad_sync_reg;
  input address_valid_early;
  input I6;
  input MATCH_FRAME_INT0;
  input pauseaddressmatch;
  input specialpauseaddressmatch;
  input int_alignment_err_pulse;
  input alignment_err_reg;
  input I8;
  input rx_enable_reg;
  input broadcast_byte_match;
  input p_10_out;
  input p_6_out;
  input p_3_out;
  input p_0_out;
  input p_4_out;
  input p_2_out;
  input p_1_out;
  input p_5_out;
  input I9;
  input p_9_out;
  input I10;
  input p_8_out;
  input p_7_out;
  input I11;
  input I12;
  input I13;
  input [7:0]D;
  input [0:0]I14;

  wire \<const0> ;
  wire \<const1> ;
  wire ALIGNMENT_ERR;
  wire ALIGNMENT_ERR_REG;
  wire BAD_FRAME_INT0_out;
  wire CE_REG1_OUT;
  wire CE_REG1_OUT6_out;
  wire CE_REG2_OUT;
  wire CE_REG3_OUT;
  wire CE_REG4_OUT;
  wire CE_REG5_OUT;
  wire CLK_DIV100_REG;
  wire CLK_DIV10_REG;
  wire CLK_DIV20_REG;
  wire COMPUTE;
  wire CONTROL_FRAME_INT;
  wire CONTROL_MATCH;
  wire CONTROL_MATCH0;
  wire CRC1000_EN;
  wire CRC100_EN;
  wire CRC50_EN;
  wire CRC_COMPUTE0;
  wire CRC_ENGINE_ERR0;
  wire [7:0]D;
  wire DATA_FIELD;
  wire DATA_NO_FCS;
  wire DATA_NO_FCS0;
  wire DATA_OUT;
  wire DATA_VALID_FINAL0;
  wire DATA_WITH_FCS;
  wire DATA_WITH_FCS0;
  wire [0:0]E;
  wire END_OF_DATA;
  wire END_OF_FRAME;
  wire EXCEEDED_MIN_LEN;
  wire EXTENSION_FIELD;
  wire EXTENSION_FLAG;
  wire EXTENSION_FLAG0;
  wire FALSE_CARR_FLAG;
  wire FCS_FIELD;
  wire [1:1]FIELD_COUNTER;
  wire FRAME_LEN_ERR;
  wire GOOD_FRAME_INT;
  wire I1;
  wire I10;
  wire I11;
  wire I12;
  wire I13;
  wire [0:0]I14;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire [0:0]I7;
  wire I8;
  wire I9;
  wire IFG_FLAG;
  wire INHIBIT_FRAME;
  wire INHIBIT_FRAME0;
  wire LENGTH_FIELD;
  wire LENGTH_FIELD_MATCH;
  wire LENGTH_ONE;
  wire LENGTH_ONE0;
  wire LENGTH_ZERO;
  wire LENGTH_ZERO0;
  wire LESS_THAN_256;
  wire LESS_THAN_2560;
  wire LT_CHECK_HELD;
  wire MATCH_FRAME_INT;
  wire MATCH_FRAME_INT0;
  wire MAX_LENGTH_ERR3_out;
  wire MULTICAST_MATCH;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire [0:0]O5;
  wire O6;
  wire O7;
  wire O8;
  wire [7:0]O9;
  wire PAUSE_LT_CHECK_HELD;
  wire PREAMBLE_FIELD;
  wire PRE_FALSE_CARR_FLAG;
  wire PRE_IFG_FLAG;
  wire [0:0]Q;
  wire Q0_out;
  wire Q1_out;
  wire Q2_out;
  wire Q3_out;
  wire Q4_out;
  wire Q5_out;
  wire Q6_out;
  wire REG0_OUT2;
  wire REG1_OUT;
  wire REG2_OUT;
  wire REG3_OUT;
  wire REG4_OUT;
  wire REG5_OUT;
  wire REG6_OUT2;
  wire REG7_OUT2;
  wire REG8_OUT2;
  wire REG9_OUT2;
  wire [0:0]RXD_REG5;
  wire [7:0]RXD_REG6;
  wire [7:0]RXD_REG8;
  wire RX_DV_REG2;
  wire RX_DV_REG5;
  wire RX_DV_REG6;
  wire RX_DV_REG7;
  wire RX_ERR_REG1;
  wire RX_ERR_REG5;
  wire RX_ERR_REG6;
  wire RX_ERR_REG7;
  wire SFD_FLAG;
  wire SFD_FLAG0;
  wire SPEED_0_RESYNC_REG;
  wire SPEED_1_RESYNC_REG;
  wire [0:0]SR;
  wire TYPE_FRAME;
  wire TYPE_PACKET10_out;
  wire VALIDATE_REQUIRED;
  wire VLAN_FRAME;
  wire address_valid_early;
  wire alignment_err_reg;
  wire bad_pfc_opcode_int;
  wire broadcast_byte_match;
  wire broadcastaddressmatch;
  wire [7:0]data_early;
  wire data_valid_early;
  wire gmii_rx_dv_from_mii;
  wire gmii_rx_er_from_mii;
  wire int_alignment_err_pulse;
  wire int_rx_bad_frame_in;
  wire int_rx_control_frame;
  wire int_rx_control_frame_any_da;
  wire int_rx_data_valid_in;
  wire int_rx_good_frame_in;
  wire \n_0_CONFIG_SELECT.CALCULATE_CRC2 ;
  wire \n_0_CONFIG_SELECT.CE_REG1_OUT_i_1__0 ;
  wire \n_0_CONFIG_SELECT.CE_REG5_OUT_reg ;
  wire \n_0_CONFIG_SELECT.CRC1000_EN_i_1__0 ;
  wire \n_0_CONFIG_SELECT.CRC100_EN_i_1__0 ;
  wire \n_0_CONFIG_SELECT.CRC50_EN_i_1__0 ;
  wire \n_0_CONFIG_SELECT.REG0_OUT2_reg ;
  wire \n_0_CONFIG_SELECT.REG1_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG1_OUT_i_1__0 ;
  wire \n_0_CONFIG_SELECT.REG2_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG3_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG4_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1 ;
  wire \n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_rxgen_CONFIG_SELECT.REG5_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG5_OUT2_reg_gate ;
  wire \n_0_CONFIG_SELECT.REG5_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG5_OUT_reg ;
  wire \n_0_CONFIG_SELECT.SPEED_1_SYNC ;
  wire n_0_CRC_MODE_HELD_reg;
  wire n_0_DATA_VALID_EARLY_INT_i_1;
  wire n_0_DATA_VALID_EARLY_INT_i_2;
  wire n_0_DATA_VALID_EARLY_INT_i_3;
  wire n_0_ENABLE_REG_reg;
  wire n_0_EXTENSION_FLAG_i_2;
  wire n_0_JUMBO_FRAMES_HELD_reg;
  wire n_0_MAX_FRAME_ENABLE_HELD_reg;
  wire \n_0_MAX_FRAME_LENGTH_HELD[0]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[10]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[11]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[12]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[13]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[14]_i_2 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[1]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[2]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[3]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[4]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[5]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[6]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[7]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[8]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD[9]_i_1 ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[0] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[10] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[11] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[12] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[13] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[14] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[1] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[2] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[3] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[4] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[5] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[6] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[7] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[8] ;
  wire \n_0_MAX_FRAME_LENGTH_HELD_reg[9] ;
  wire \n_0_RXD_REG7_reg[0] ;
  wire \n_0_RXD_REG7_reg[1] ;
  wire \n_0_RXD_REG7_reg[2] ;
  wire \n_0_RXD_REG7_reg[3] ;
  wire \n_0_RXD_REG7_reg[4] ;
  wire \n_0_RXD_REG7_reg[5] ;
  wire \n_0_RXD_REG7_reg[6] ;
  wire \n_0_RXD_REG7_reg[7] ;
  wire n_0_RX_DV_REG3_reg;
  wire n_0_SFD_FLAG_i_2;
  wire n_0_SPEED_IS_10_100_HELD_reg;
  wire n_0_VLAN_ENABLE_HELD_reg;
  wire n_0_broadcast_byte_match_i_2;
  wire n_0_pause_match_reg_i_2;
  wire n_0_pause_match_reg_i_3;
  wire n_0_special_pause_match_reg_i_2;
  wire n_0_special_pause_match_reg_i_3;
  wire n_11_FRAME_CHECKER;
  wire n_12_FRAME_CHECKER;
  wire n_14_FRAME_CHECKER;
  wire n_19_RX_SM;
  wire n_1_FRAME_CHECKER;
  wire n_20_RX_SM;
  wire n_24_RX_SM;
  wire n_25_RX_SM;
  wire n_26_RX_SM;
  wire n_27_RX_SM;
  wire n_28_RX_SM;
  wire n_29_RX_SM;
  wire n_30_RX_SM;
  wire n_31_FRAME_DECODER;
  wire n_31_RX_SM;
  wire n_32_FRAME_DECODER;
  wire n_32_RX_SM;
  wire n_33_FRAME_DECODER;
  wire n_33_RX_SM;
  wire n_34_FRAME_DECODER;
  wire n_34_RX_SM;
  wire n_35_RX_SM;
  wire n_36_FRAME_DECODER;
  wire n_38_FRAME_DECODER;
  wire n_40_FRAME_DECODER;
  wire n_7_RX_SM;
  wire p_0_out;
  wire [24:0]p_0_out_0;
  wire p_10_out;
  wire p_1_out;
  wire p_2_out;
  wire p_3_out;
  wire [0:0]p_3_out_0;
  wire p_4_out;
  wire p_5_out;
  wire p_6_out;
  wire p_7_out;
  wire p_8_in;
  wire p_8_out;
  wire p_9_out;
  wire pause_match_reg0;
  wire pauseaddressmatch;
  wire rx_bad_frame_comb;
  wire [21:0]rx_configuration_vector;
  wire rx_data_valid_reg1;
  wire rx_enable_reg;
  wire rx_statistics_valid;
  wire [25:0]rx_statistics_vector;
  wire special_pause_match_comb;
  wire specialpauseaddressmatch;
  wire [1:0]tx_configuration_vector;
  wire update_pause_ad_sync;
  wire update_pause_ad_sync_reg;

FDRE ALIGNMENT_ERR_REG_reg
       (.C(I1),
        .CE(I2),
        .D(ALIGNMENT_ERR),
        .Q(ALIGNMENT_ERR_REG),
        .R(\<const0> ));
FDRE BAD_FRAME_INT_reg
       (.C(I1),
        .CE(I2),
        .D(BAD_FRAME_INT0_out),
        .Q(int_rx_bad_frame_in),
        .R(SR));
TriMACCRC_64_32 \CONFIG_SELECT.CALCULATE_CRC2 
       (.CRC1000_EN(CRC1000_EN),
        .CRC50_EN(CRC50_EN),
        .I1(I1),
        .I2(I2),
        .O1(\n_0_CONFIG_SELECT.CALCULATE_CRC2 ),
        .SPEED_0_RESYNC_REG(SPEED_0_RESYNC_REG),
        .SPEED_1_RESYNC_REG(SPEED_1_RESYNC_REG),
        .rx_configuration_vector(rx_configuration_vector[0]));
LUT1 #(
    .INIT(2'h1)) 
     \CONFIG_SELECT.CE_REG1_OUT_i_1__0 
       (.I0(\n_0_CONFIG_SELECT.CE_REG5_OUT_reg ),
        .O(\n_0_CONFIG_SELECT.CE_REG1_OUT_i_1__0 ));
FDRE \CONFIG_SELECT.CE_REG1_OUT_reg 
       (.C(I1),
        .CE(CE_REG1_OUT6_out),
        .D(\n_0_CONFIG_SELECT.CE_REG1_OUT_i_1__0 ),
        .Q(CE_REG1_OUT),
        .R(CE_REG5_OUT));
FDRE \CONFIG_SELECT.CE_REG2_OUT_reg 
       (.C(I1),
        .CE(CE_REG1_OUT6_out),
        .D(CE_REG1_OUT),
        .Q(CE_REG2_OUT),
        .R(CE_REG5_OUT));
FDRE \CONFIG_SELECT.CE_REG3_OUT_reg 
       (.C(I1),
        .CE(CE_REG1_OUT6_out),
        .D(CE_REG2_OUT),
        .Q(CE_REG3_OUT),
        .R(CE_REG5_OUT));
LUT5 #(
    .INIT(32'hBAAAAAAA)) 
     \CONFIG_SELECT.CE_REG4_OUT_i_1__0 
       (.I0(SR),
        .I1(CE_REG4_OUT),
        .I2(\n_0_CONFIG_SELECT.CE_REG5_OUT_reg ),
        .I3(I2),
        .I4(CRC100_EN),
        .O(CE_REG5_OUT));
LUT2 #(
    .INIT(4'h8)) 
     \CONFIG_SELECT.CE_REG4_OUT_i_2__0 
       (.I0(I2),
        .I1(CRC100_EN),
        .O(CE_REG1_OUT6_out));
FDRE \CONFIG_SELECT.CE_REG4_OUT_reg 
       (.C(I1),
        .CE(CE_REG1_OUT6_out),
        .D(CE_REG3_OUT),
        .Q(CE_REG4_OUT),
        .R(CE_REG5_OUT));
FDRE \CONFIG_SELECT.CE_REG5_OUT_reg 
       (.C(I1),
        .CE(CE_REG1_OUT6_out),
        .D(CE_REG4_OUT),
        .Q(\n_0_CONFIG_SELECT.CE_REG5_OUT_reg ),
        .R(CE_REG5_OUT));
FDRE \CONFIG_SELECT.CLK_DIV100_REG_reg 
       (.C(I1),
        .CE(I2),
        .D(CE_REG3_OUT),
        .Q(CLK_DIV100_REG),
        .R(\<const0> ));
FDRE \CONFIG_SELECT.CLK_DIV10_REG_reg 
       (.C(I1),
        .CE(I2),
        .D(REG3_OUT),
        .Q(CLK_DIV10_REG),
        .R(\<const0> ));
FDRE \CONFIG_SELECT.CLK_DIV20_REG_reg 
       (.C(I1),
        .CE(I2),
        .D(REG6_OUT2),
        .Q(CLK_DIV20_REG),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'h2)) 
     \CONFIG_SELECT.CRC1000_EN_i_1__0 
       (.I0(CE_REG3_OUT),
        .I1(CLK_DIV100_REG),
        .O(\n_0_CONFIG_SELECT.CRC1000_EN_i_1__0 ));
FDRE \CONFIG_SELECT.CRC1000_EN_reg 
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.CRC1000_EN_i_1__0 ),
        .Q(CRC1000_EN),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'h2)) 
     \CONFIG_SELECT.CRC100_EN_i_1__0 
       (.I0(REG3_OUT),
        .I1(CLK_DIV10_REG),
        .O(\n_0_CONFIG_SELECT.CRC100_EN_i_1__0 ));
FDRE \CONFIG_SELECT.CRC100_EN_reg 
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.CRC100_EN_i_1__0 ),
        .Q(CRC100_EN),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'h2)) 
     \CONFIG_SELECT.CRC50_EN_i_1__0 
       (.I0(REG6_OUT2),
        .I1(CLK_DIV20_REG),
        .O(\n_0_CONFIG_SELECT.CRC50_EN_i_1__0 ));
FDRE \CONFIG_SELECT.CRC50_EN_reg 
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.CRC50_EN_i_1__0 ),
        .Q(CRC50_EN),
        .R(\<const0> ));
FDRE \CONFIG_SELECT.REG0_OUT2_reg 
       (.C(I1),
        .CE(I2),
        .D(REG9_OUT2),
        .Q(\n_0_CONFIG_SELECT.REG0_OUT2_reg ),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG1_OUT2_reg_r 
       (.C(I1),
        .CE(I2),
        .D(\<const1> ),
        .Q(\n_0_CONFIG_SELECT.REG1_OUT2_reg_r ),
        .R(REG0_OUT2));
LUT1 #(
    .INIT(2'h1)) 
     \CONFIG_SELECT.REG1_OUT_i_1__0 
       (.I0(\n_0_CONFIG_SELECT.REG5_OUT_reg ),
        .O(\n_0_CONFIG_SELECT.REG1_OUT_i_1__0 ));
FDRE \CONFIG_SELECT.REG1_OUT_reg 
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.REG1_OUT_i_1__0 ),
        .Q(REG1_OUT),
        .R(REG5_OUT));
FDRE \CONFIG_SELECT.REG2_OUT2_reg_r 
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.REG1_OUT2_reg_r ),
        .Q(\n_0_CONFIG_SELECT.REG2_OUT2_reg_r ),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG2_OUT_reg 
       (.C(I1),
        .CE(I2),
        .D(REG1_OUT),
        .Q(REG2_OUT),
        .R(REG5_OUT));
FDRE \CONFIG_SELECT.REG3_OUT2_reg_r 
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.REG2_OUT2_reg_r ),
        .Q(\n_0_CONFIG_SELECT.REG3_OUT2_reg_r ),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG3_OUT_reg 
       (.C(I1),
        .CE(I2),
        .D(REG2_OUT),
        .Q(REG3_OUT),
        .R(REG5_OUT));
FDRE \CONFIG_SELECT.REG4_OUT2_reg_r 
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.REG3_OUT2_reg_r ),
        .Q(\n_0_CONFIG_SELECT.REG4_OUT2_reg_r ),
        .R(REG0_OUT2));
(* srl_name = "inst/\TriMAC_core/rxgen/CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r " *) 
   SRL16E \CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(\n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1 ),
        .Q(\n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r ));
LUT1 #(
    .INIT(2'h1)) 
     \CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1 
       (.I0(\n_0_CONFIG_SELECT.REG0_OUT2_reg ),
        .O(\n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1 ));
LUT4 #(
    .INIT(16'hBAAA)) 
     \CONFIG_SELECT.REG4_OUT_i_1__0 
       (.I0(SR),
        .I1(REG4_OUT),
        .I2(I2),
        .I3(\n_0_CONFIG_SELECT.REG5_OUT_reg ),
        .O(REG5_OUT));
FDRE \CONFIG_SELECT.REG4_OUT_reg 
       (.C(I1),
        .CE(I2),
        .D(REG3_OUT),
        .Q(REG4_OUT),
        .R(REG5_OUT));
FDRE \CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_rxgen_CONFIG_SELECT.REG5_OUT2_reg_r 
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r ),
        .Q(\n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_rxgen_CONFIG_SELECT.REG5_OUT2_reg_r ),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'h8)) 
     \CONFIG_SELECT.REG5_OUT2_reg_gate 
       (.I0(\n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_rxgen_CONFIG_SELECT.REG5_OUT2_reg_r ),
        .I1(\n_0_CONFIG_SELECT.REG5_OUT2_reg_r ),
        .O(\n_0_CONFIG_SELECT.REG5_OUT2_reg_gate ));
FDRE \CONFIG_SELECT.REG5_OUT2_reg_r 
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.REG4_OUT2_reg_r ),
        .Q(\n_0_CONFIG_SELECT.REG5_OUT2_reg_r ),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG5_OUT_reg 
       (.C(I1),
        .CE(I2),
        .D(REG4_OUT),
        .Q(\n_0_CONFIG_SELECT.REG5_OUT_reg ),
        .R(REG5_OUT));
FDRE \CONFIG_SELECT.REG6_OUT2_reg 
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.REG5_OUT2_reg_gate ),
        .Q(REG6_OUT2),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG7_OUT2_reg 
       (.C(I1),
        .CE(I2),
        .D(REG6_OUT2),
        .Q(REG7_OUT2),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG8_OUT2_reg 
       (.C(I1),
        .CE(I2),
        .D(REG7_OUT2),
        .Q(REG8_OUT2),
        .R(REG0_OUT2));
LUT4 #(
    .INIT(16'hBAAA)) 
     \CONFIG_SELECT.REG9_OUT2_i_1__0 
       (.I0(SR),
        .I1(REG9_OUT2),
        .I2(I2),
        .I3(\n_0_CONFIG_SELECT.REG0_OUT2_reg ),
        .O(REG0_OUT2));
FDRE \CONFIG_SELECT.REG9_OUT2_reg 
       (.C(I1),
        .CE(I2),
        .D(REG8_OUT2),
        .Q(REG9_OUT2),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.SPEED_0_RESYNC_REG_reg 
       (.C(I1),
        .CE(I2),
        .D(DATA_OUT),
        .Q(SPEED_0_RESYNC_REG),
        .R(SR));
TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1 \CONFIG_SELECT.SPEED_0_SYNC 
       (.I1(I1),
        .data_out(DATA_OUT),
        .tx_configuration_vector(tx_configuration_vector[0]));
FDRE \CONFIG_SELECT.SPEED_1_RESYNC_REG_reg 
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.SPEED_1_SYNC ),
        .Q(SPEED_1_RESYNC_REG),
        .R(SR));
TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_7 \CONFIG_SELECT.SPEED_1_SYNC 
       (.I1(I1),
        .data_out(\n_0_CONFIG_SELECT.SPEED_1_SYNC ),
        .tx_configuration_vector(tx_configuration_vector[1]));
FDRE CRC_MODE_HELD_reg
       (.C(I1),
        .CE(n_32_RX_SM),
        .D(rx_configuration_vector[2]),
        .Q(n_0_CRC_MODE_HELD_reg),
        .R(SR));
LUT6 #(
    .INIT(64'h0000FF5500008000)) 
     DATA_VALID_EARLY_INT_i_1
       (.I0(I2),
        .I1(n_0_DATA_VALID_EARLY_INT_i_2),
        .I2(n_0_DATA_VALID_EARLY_INT_i_3),
        .I3(O1),
        .I4(SR),
        .I5(O2),
        .O(n_0_DATA_VALID_EARLY_INT_i_1));
LUT3 #(
    .INIT(8'h80)) 
     DATA_VALID_EARLY_INT_i_2
       (.I0(data_early[2]),
        .I1(data_early[6]),
        .I2(data_early[0]),
        .O(n_0_DATA_VALID_EARLY_INT_i_2));
LUT6 #(
    .INIT(64'h0000000000100000)) 
     DATA_VALID_EARLY_INT_i_3
       (.I0(data_early[3]),
        .I1(data_early[1]),
        .I2(data_early[7]),
        .I3(RX_ERR_REG1),
        .I4(data_early[4]),
        .I5(data_early[5]),
        .O(n_0_DATA_VALID_EARLY_INT_i_3));
FDRE DATA_VALID_EARLY_INT_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_DATA_VALID_EARLY_INT_i_1),
        .Q(O2),
        .R(\<const0> ));
FDRE DATA_VALID_FINAL_reg
       (.C(I1),
        .CE(I2),
        .D(DATA_VALID_FINAL0),
        .Q(int_rx_data_valid_in),
        .R(SR));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_BROADCASTADDRESSMATCH " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     DELAY_BROADCASTADDRESSMATCH
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(broadcastaddressmatch),
        .Q(p_0_out_0[3]));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_bus_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS " *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[0].DELAY_RXD " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     \DELAY_RXD_BUS[0].DELAY_RXD 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(data_early[0]),
        .Q(RXD_REG5));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_bus_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS " *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[1].DELAY_RXD " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     \DELAY_RXD_BUS[1].DELAY_RXD 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(data_early[1]),
        .Q(Q0_out));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_bus_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS " *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[2].DELAY_RXD " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     \DELAY_RXD_BUS[2].DELAY_RXD 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(data_early[2]),
        .Q(Q1_out));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_bus_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS " *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[3].DELAY_RXD " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     \DELAY_RXD_BUS[3].DELAY_RXD 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(data_early[3]),
        .Q(Q2_out));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_bus_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS " *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[4].DELAY_RXD " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     \DELAY_RXD_BUS[4].DELAY_RXD 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(data_early[4]),
        .Q(Q3_out));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_bus_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS " *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[5].DELAY_RXD " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     \DELAY_RXD_BUS[5].DELAY_RXD 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(data_early[5]),
        .Q(Q4_out));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_bus_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS " *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[6].DELAY_RXD " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     \DELAY_RXD_BUS[6].DELAY_RXD 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(data_early[6]),
        .Q(Q5_out));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_bus_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS " *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[7].DELAY_RXD " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     \DELAY_RXD_BUS[7].DELAY_RXD 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(data_early[7]),
        .Q(Q6_out));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_RX_DV1 " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     DELAY_RX_DV1
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(O1),
        .Q(RX_DV_REG2));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_RX_DV2 " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     DELAY_RX_DV2
       (.A0(\<const0> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(n_0_RX_DV_REG3_reg),
        .Q(RX_DV_REG5));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_name = "inst/\TriMAC_core/rxgen/DELAY_RX_ERR " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     DELAY_RX_ERR
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(RX_ERR_REG1),
        .Q(RX_ERR_REG5));
FDRE ENABLE_REG_reg
       (.C(I1),
        .CE(I2),
        .D(\n_0_CONFIG_SELECT.CALCULATE_CRC2 ),
        .Q(n_0_ENABLE_REG_reg),
        .R(SR));
LUT5 #(
    .INIT(32'h00000800)) 
     EXTENSION_FLAG_i_1
       (.I0(n_0_EXTENSION_FLAG_i_2),
        .I1(RX_ERR_REG6),
        .I2(RX_DV_REG6),
        .I3(RXD_REG6[2]),
        .I4(RXD_REG6[5]),
        .O(EXTENSION_FLAG0));
LUT6 #(
    .INIT(64'h0000000000000080)) 
     EXTENSION_FLAG_i_2
       (.I0(RXD_REG6[0]),
        .I1(RXD_REG6[1]),
        .I2(RXD_REG6[3]),
        .I3(RXD_REG6[7]),
        .I4(RXD_REG6[4]),
        .I5(RXD_REG6[6]),
        .O(n_0_EXTENSION_FLAG_i_2));
FDRE EXTENSION_FLAG_reg
       (.C(I1),
        .CE(I2),
        .D(EXTENSION_FLAG0),
        .Q(EXTENSION_FLAG),
        .R(SR));
FDRE FALSE_CARR_FLAG_reg
       (.C(I1),
        .CE(I2),
        .D(PRE_FALSE_CARR_FLAG),
        .Q(FALSE_CARR_FLAG),
        .R(SR));
TriMACCRC32_8 FCS_CHECK
       (.COMPUTE(COMPUTE),
        .CRC_ENGINE_ERR0(CRC_ENGINE_ERR0),
        .FCS_FIELD(FCS_FIELD),
        .I1(n_20_RX_SM),
        .I2(n_19_RX_SM),
        .I3(I1),
        .PREAMBLE_FIELD(PREAMBLE_FIELD),
        .Q({\n_0_RXD_REG7_reg[7] ,\n_0_RXD_REG7_reg[6] ,\n_0_RXD_REG7_reg[5] ,\n_0_RXD_REG7_reg[4] ,\n_0_RXD_REG7_reg[3] ,\n_0_RXD_REG7_reg[2] ,\n_0_RXD_REG7_reg[1] ,\n_0_RXD_REG7_reg[0] }),
        .SFD_FLAG(SFD_FLAG));
TriMACPARAM_CHECK__parameterized0 FRAME_CHECKER
       (.ALIGNMENT_ERR(ALIGNMENT_ERR),
        .ALIGNMENT_ERR_REG(ALIGNMENT_ERR_REG),
        .BAD_FRAME_INT0_out(BAD_FRAME_INT0_out),
        .CRC_ENGINE_ERR0(CRC_ENGINE_ERR0),
        .D({p_0_out_0[24:23],p_0_out_0[20],p_0_out_0[2:0]}),
        .EXCEEDED_MIN_LEN(EXCEEDED_MIN_LEN),
        .FRAME_LEN_ERR(FRAME_LEN_ERR),
        .GOOD_FRAME_INT(GOOD_FRAME_INT),
        .I1(I1),
        .I2(I2),
        .I3(n_33_RX_SM),
        .I4(n_35_RX_SM),
        .I5(n_34_RX_SM),
        .I6(n_30_RX_SM),
        .I7(n_36_FRAME_DECODER),
        .I8(END_OF_FRAME),
        .I9(n_0_JUMBO_FRAMES_HELD_reg),
        .INHIBIT_FRAME(INHIBIT_FRAME),
        .INHIBIT_FRAME0(INHIBIT_FRAME0),
        .MATCH_FRAME_INT(MATCH_FRAME_INT),
        .MAX_LENGTH_ERR3_out(MAX_LENGTH_ERR3_out),
        .O1(n_1_FRAME_CHECKER),
        .O2(n_11_FRAME_CHECKER),
        .O3(n_12_FRAME_CHECKER),
        .O4(n_14_FRAME_CHECKER),
        .PREAMBLE_FIELD(PREAMBLE_FIELD),
        .SR(SR),
        .TYPE_FRAME(TYPE_FRAME),
        .VALIDATE_REQUIRED(VALIDATE_REQUIRED),
        .p_8_in(p_8_in));
TriMACDECODE_FRAME FRAME_DECODER
       (.COMPUTE(COMPUTE),
        .CONTROL_FRAME_INT(CONTROL_FRAME_INT),
        .CONTROL_MATCH(CONTROL_MATCH),
        .CONTROL_MATCH0(CONTROL_MATCH0),
        .CRC_COMPUTE0(CRC_COMPUTE0),
        .D({p_0_out_0[22],VLAN_FRAME,int_rx_control_frame_any_da,p_0_out_0[18:4]}),
        .DATA_FIELD(DATA_FIELD),
        .DATA_NO_FCS(DATA_NO_FCS),
        .DATA_NO_FCS0(DATA_NO_FCS0),
        .DATA_VALID_FINAL0(DATA_VALID_FINAL0),
        .DATA_WITH_FCS(DATA_WITH_FCS),
        .DATA_WITH_FCS0(DATA_WITH_FCS0),
        .E(E),
        .END_OF_DATA(END_OF_DATA),
        .EXCEEDED_MIN_LEN(EXCEEDED_MIN_LEN),
        .EXTENSION_FIELD(EXTENSION_FIELD),
        .FIELD_COUNTER(FIELD_COUNTER),
        .I1(I1),
        .I10(END_OF_FRAME),
        .I11({\n_0_MAX_FRAME_LENGTH_HELD_reg[14] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[13] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[12] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[11] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[10] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[9] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[8] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[7] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[6] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[5] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[4] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[3] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[2] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[1] ,\n_0_MAX_FRAME_LENGTH_HELD_reg[0] }),
        .I12(n_0_MAX_FRAME_ENABLE_HELD_reg),
        .I13(n_12_FRAME_CHECKER),
        .I14(I6),
        .I15(I8),
        .I16(n_28_RX_SM),
        .I17(n_14_FRAME_CHECKER),
        .I18(p_3_out_0),
        .I19(n_20_RX_SM),
        .I2(I2),
        .I20(n_7_RX_SM),
        .I21(I14),
        .I22(n_24_RX_SM),
        .I3(n_25_RX_SM),
        .I4(n_27_RX_SM),
        .I5(n_29_RX_SM),
        .I6(int_rx_good_frame_in),
        .I7(I4),
        .I8(I5),
        .I9(n_0_CRC_MODE_HELD_reg),
        .LENGTH_FIELD(LENGTH_FIELD),
        .LENGTH_FIELD_MATCH(LENGTH_FIELD_MATCH),
        .LENGTH_ONE(LENGTH_ONE),
        .LENGTH_ONE0(LENGTH_ONE0),
        .LENGTH_ZERO(LENGTH_ZERO),
        .LENGTH_ZERO0(LENGTH_ZERO0),
        .LESS_THAN_256(LESS_THAN_256),
        .LESS_THAN_2560(LESS_THAN_2560),
        .LT_CHECK_HELD(LT_CHECK_HELD),
        .MAX_LENGTH_ERR3_out(MAX_LENGTH_ERR3_out),
        .MULTICAST_MATCH(MULTICAST_MATCH),
        .O1(n_31_FRAME_DECODER),
        .O2(n_32_FRAME_DECODER),
        .O3(n_33_FRAME_DECODER),
        .O4(n_34_FRAME_DECODER),
        .O5(n_36_FRAME_DECODER),
        .O6(n_38_FRAME_DECODER),
        .O7(n_40_FRAME_DECODER),
        .PAUSE_LT_CHECK_HELD(PAUSE_LT_CHECK_HELD),
        .Q({\n_0_RXD_REG7_reg[7] ,\n_0_RXD_REG7_reg[6] ,\n_0_RXD_REG7_reg[5] ,\n_0_RXD_REG7_reg[4] ,\n_0_RXD_REG7_reg[3] ,\n_0_RXD_REG7_reg[2] ,\n_0_RXD_REG7_reg[1] ,\n_0_RXD_REG7_reg[0] }),
        .RX_DV_REG7(RX_DV_REG7),
        .SR(SR),
        .TYPE_FRAME(TYPE_FRAME),
        .TYPE_PACKET10_out(TYPE_PACKET10_out),
        .VALIDATE_REQUIRED(VALIDATE_REQUIRED),
        .address_valid_early(address_valid_early),
        .int_rx_control_frame(int_rx_control_frame),
        .pauseaddressmatch(pauseaddressmatch),
        .rx_enable_reg(rx_enable_reg),
        .rx_statistics_vector(rx_statistics_vector[23]),
        .specialpauseaddressmatch(specialpauseaddressmatch));
GND GND
       (.G(\<const0> ));
FDRE GOOD_FRAME_INT_reg
       (.C(I1),
        .CE(I2),
        .D(GOOD_FRAME_INT),
        .Q(int_rx_good_frame_in),
        .R(SR));
FDRE \G_NO_1588_HOOKS.DATA_reg[0] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG8[0]),
        .Q(O9[0]),
        .R(SR));
FDRE \G_NO_1588_HOOKS.DATA_reg[1] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG8[1]),
        .Q(O9[1]),
        .R(SR));
FDRE \G_NO_1588_HOOKS.DATA_reg[2] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG8[2]),
        .Q(O9[2]),
        .R(SR));
FDRE \G_NO_1588_HOOKS.DATA_reg[3] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG8[3]),
        .Q(O9[3]),
        .R(SR));
FDRE \G_NO_1588_HOOKS.DATA_reg[4] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG8[4]),
        .Q(O9[4]),
        .R(SR));
FDRE \G_NO_1588_HOOKS.DATA_reg[5] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG8[5]),
        .Q(O9[5]),
        .R(SR));
FDRE \G_NO_1588_HOOKS.DATA_reg[6] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG8[6]),
        .Q(O9[6]),
        .R(SR));
FDRE \G_NO_1588_HOOKS.DATA_reg[7] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG8[7]),
        .Q(O9[7]),
        .R(SR));
FDRE IFG_FLAG_reg
       (.C(I1),
        .CE(I2),
        .D(PRE_IFG_FLAG),
        .Q(IFG_FLAG),
        .R(SR));
FDRE JUMBO_FRAMES_HELD_reg
       (.C(I1),
        .CE(n_32_RX_SM),
        .D(rx_configuration_vector[3]),
        .Q(n_0_JUMBO_FRAMES_HELD_reg),
        .R(SR));
FDRE LT_CHECK_HELD_reg
       (.C(I1),
        .CE(n_32_RX_SM),
        .D(rx_configuration_vector[4]),
        .Q(LT_CHECK_HELD),
        .R(SR));
FDRE MATCH_FRAME_INT_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_26_RX_SM),
        .Q(MATCH_FRAME_INT),
        .R(\<const0> ));
FDRE MAX_FRAME_ENABLE_HELD_reg
       (.C(I1),
        .CE(n_32_RX_SM),
        .D(rx_configuration_vector[6]),
        .Q(n_0_MAX_FRAME_ENABLE_HELD_reg),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair106" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \MAX_FRAME_LENGTH_HELD[0]_i_1 
       (.I0(rx_configuration_vector[6]),
        .I1(rx_configuration_vector[7]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair110" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \MAX_FRAME_LENGTH_HELD[10]_i_1 
       (.I0(rx_configuration_vector[17]),
        .I1(rx_configuration_vector[6]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[10]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair107" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \MAX_FRAME_LENGTH_HELD[11]_i_1 
       (.I0(rx_configuration_vector[6]),
        .I1(rx_configuration_vector[18]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[11]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair108" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \MAX_FRAME_LENGTH_HELD[12]_i_1 
       (.I0(rx_configuration_vector[6]),
        .I1(rx_configuration_vector[19]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[12]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair108" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \MAX_FRAME_LENGTH_HELD[13]_i_1 
       (.I0(rx_configuration_vector[6]),
        .I1(rx_configuration_vector[20]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[13]_i_1 ));
LUT2 #(
    .INIT(4'h8)) 
     \MAX_FRAME_LENGTH_HELD[14]_i_2 
       (.I0(rx_configuration_vector[6]),
        .I1(rx_configuration_vector[21]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[14]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair109" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \MAX_FRAME_LENGTH_HELD[1]_i_1 
       (.I0(rx_configuration_vector[8]),
        .I1(rx_configuration_vector[6]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair110" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \MAX_FRAME_LENGTH_HELD[2]_i_1 
       (.I0(rx_configuration_vector[9]),
        .I1(rx_configuration_vector[6]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair109" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \MAX_FRAME_LENGTH_HELD[3]_i_1 
       (.I0(rx_configuration_vector[10]),
        .I1(rx_configuration_vector[6]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair106" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \MAX_FRAME_LENGTH_HELD[4]_i_1 
       (.I0(rx_configuration_vector[6]),
        .I1(rx_configuration_vector[11]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair111" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \MAX_FRAME_LENGTH_HELD[5]_i_1 
       (.I0(rx_configuration_vector[12]),
        .I1(rx_configuration_vector[6]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair112" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \MAX_FRAME_LENGTH_HELD[6]_i_1 
       (.I0(rx_configuration_vector[13]),
        .I1(rx_configuration_vector[6]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair112" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \MAX_FRAME_LENGTH_HELD[7]_i_1 
       (.I0(rx_configuration_vector[14]),
        .I1(rx_configuration_vector[6]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[7]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair111" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \MAX_FRAME_LENGTH_HELD[8]_i_1 
       (.I0(rx_configuration_vector[15]),
        .I1(rx_configuration_vector[6]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[8]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair107" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \MAX_FRAME_LENGTH_HELD[9]_i_1 
       (.I0(rx_configuration_vector[6]),
        .I1(rx_configuration_vector[16]),
        .O(\n_0_MAX_FRAME_LENGTH_HELD[9]_i_1 ));
FDRE \MAX_FRAME_LENGTH_HELD_reg[0] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[0]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[0] ),
        .R(SR));
FDSE \MAX_FRAME_LENGTH_HELD_reg[10] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[10]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[10] ),
        .S(SR));
FDRE \MAX_FRAME_LENGTH_HELD_reg[11] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[11]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[11] ),
        .R(SR));
FDRE \MAX_FRAME_LENGTH_HELD_reg[12] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[12]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[12] ),
        .R(SR));
FDRE \MAX_FRAME_LENGTH_HELD_reg[13] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[13]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[13] ),
        .R(SR));
FDRE \MAX_FRAME_LENGTH_HELD_reg[14] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[14]_i_2 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[14] ),
        .R(SR));
FDSE \MAX_FRAME_LENGTH_HELD_reg[1] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[1]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[1] ),
        .S(SR));
FDSE \MAX_FRAME_LENGTH_HELD_reg[2] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[2]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[2] ),
        .S(SR));
FDSE \MAX_FRAME_LENGTH_HELD_reg[3] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[3]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[3] ),
        .S(SR));
FDRE \MAX_FRAME_LENGTH_HELD_reg[4] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[4]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[4] ),
        .R(SR));
FDSE \MAX_FRAME_LENGTH_HELD_reg[5] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[5]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[5] ),
        .S(SR));
FDSE \MAX_FRAME_LENGTH_HELD_reg[6] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[6]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[6] ),
        .S(SR));
FDSE \MAX_FRAME_LENGTH_HELD_reg[7] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[7]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[7] ),
        .S(SR));
FDSE \MAX_FRAME_LENGTH_HELD_reg[8] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[8]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[8] ),
        .S(SR));
FDRE \MAX_FRAME_LENGTH_HELD_reg[9] 
       (.C(I1),
        .CE(n_31_RX_SM),
        .D(\n_0_MAX_FRAME_LENGTH_HELD[9]_i_1 ),
        .Q(\n_0_MAX_FRAME_LENGTH_HELD_reg[9] ),
        .R(SR));
FDRE PAUSE_LT_CHECK_HELD_reg
       (.C(I1),
        .CE(n_32_RX_SM),
        .D(rx_configuration_vector[5]),
        .Q(PAUSE_LT_CHECK_HELD),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG1_reg[0] 
       (.C(I1),
        .CE(I2),
        .D(D[0]),
        .Q(data_early[0]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG1_reg[1] 
       (.C(I1),
        .CE(I2),
        .D(D[1]),
        .Q(data_early[1]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG1_reg[2] 
       (.C(I1),
        .CE(I2),
        .D(D[2]),
        .Q(data_early[2]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG1_reg[3] 
       (.C(I1),
        .CE(I2),
        .D(D[3]),
        .Q(data_early[3]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG1_reg[4] 
       (.C(I1),
        .CE(I2),
        .D(D[4]),
        .Q(data_early[4]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG1_reg[5] 
       (.C(I1),
        .CE(I2),
        .D(D[5]),
        .Q(data_early[5]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG1_reg[6] 
       (.C(I1),
        .CE(I2),
        .D(D[6]),
        .Q(data_early[6]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG1_reg[7] 
       (.C(I1),
        .CE(I2),
        .D(D[7]),
        .Q(data_early[7]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG6_reg[0] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG5),
        .Q(RXD_REG6[0]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG6_reg[1] 
       (.C(I1),
        .CE(I2),
        .D(Q0_out),
        .Q(RXD_REG6[1]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG6_reg[2] 
       (.C(I1),
        .CE(I2),
        .D(Q1_out),
        .Q(RXD_REG6[2]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG6_reg[3] 
       (.C(I1),
        .CE(I2),
        .D(Q2_out),
        .Q(RXD_REG6[3]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG6_reg[4] 
       (.C(I1),
        .CE(I2),
        .D(Q3_out),
        .Q(RXD_REG6[4]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG6_reg[5] 
       (.C(I1),
        .CE(I2),
        .D(Q4_out),
        .Q(RXD_REG6[5]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG6_reg[6] 
       (.C(I1),
        .CE(I2),
        .D(Q5_out),
        .Q(RXD_REG6[6]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG6_reg[7] 
       (.C(I1),
        .CE(I2),
        .D(Q6_out),
        .Q(RXD_REG6[7]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG7_reg[0] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG6[0]),
        .Q(\n_0_RXD_REG7_reg[0] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG7_reg[1] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG6[1]),
        .Q(\n_0_RXD_REG7_reg[1] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG7_reg[2] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG6[2]),
        .Q(\n_0_RXD_REG7_reg[2] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG7_reg[3] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG6[3]),
        .Q(\n_0_RXD_REG7_reg[3] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG7_reg[4] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG6[4]),
        .Q(\n_0_RXD_REG7_reg[4] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG7_reg[5] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG6[5]),
        .Q(\n_0_RXD_REG7_reg[5] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG7_reg[6] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG6[6]),
        .Q(\n_0_RXD_REG7_reg[6] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG7_reg[7] 
       (.C(I1),
        .CE(I2),
        .D(RXD_REG6[7]),
        .Q(\n_0_RXD_REG7_reg[7] ),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG8_reg[0] 
       (.C(I1),
        .CE(I2),
        .D(\n_0_RXD_REG7_reg[0] ),
        .Q(RXD_REG8[0]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG8_reg[1] 
       (.C(I1),
        .CE(I2),
        .D(\n_0_RXD_REG7_reg[1] ),
        .Q(RXD_REG8[1]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG8_reg[2] 
       (.C(I1),
        .CE(I2),
        .D(\n_0_RXD_REG7_reg[2] ),
        .Q(RXD_REG8[2]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG8_reg[3] 
       (.C(I1),
        .CE(I2),
        .D(\n_0_RXD_REG7_reg[3] ),
        .Q(RXD_REG8[3]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG8_reg[4] 
       (.C(I1),
        .CE(I2),
        .D(\n_0_RXD_REG7_reg[4] ),
        .Q(RXD_REG8[4]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG8_reg[5] 
       (.C(I1),
        .CE(I2),
        .D(\n_0_RXD_REG7_reg[5] ),
        .Q(RXD_REG8[5]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG8_reg[6] 
       (.C(I1),
        .CE(I2),
        .D(\n_0_RXD_REG7_reg[6] ),
        .Q(RXD_REG8[6]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \RXD_REG8_reg[7] 
       (.C(I1),
        .CE(I2),
        .D(\n_0_RXD_REG7_reg[7] ),
        .Q(RXD_REG8[7]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     RX_DV_REG1_reg
       (.C(I1),
        .CE(I2),
        .D(gmii_rx_dv_from_mii),
        .Q(O1),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     RX_DV_REG3_reg
       (.C(I1),
        .CE(I2),
        .D(RX_DV_REG2),
        .Q(n_0_RX_DV_REG3_reg),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     RX_DV_REG6_reg
       (.C(I1),
        .CE(I2),
        .D(RX_DV_REG5),
        .Q(RX_DV_REG6),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     RX_DV_REG7_reg
       (.C(I1),
        .CE(I2),
        .D(RX_DV_REG6),
        .Q(RX_DV_REG7),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     RX_ERR_REG1_reg
       (.C(I1),
        .CE(I2),
        .D(gmii_rx_er_from_mii),
        .Q(RX_ERR_REG1),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     RX_ERR_REG6_reg
       (.C(I1),
        .CE(I2),
        .D(RX_ERR_REG5),
        .Q(RX_ERR_REG6),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     RX_ERR_REG7_reg
       (.C(I1),
        .CE(I2),
        .D(RX_ERR_REG6),
        .Q(RX_ERR_REG7),
        .R(\<const0> ));
TriMACSTATE_MACHINES RX_SM
       (.ALIGNMENT_ERR(ALIGNMENT_ERR),
        .COMPUTE(COMPUTE),
        .CONTROL_FRAME_INT(CONTROL_FRAME_INT),
        .CONTROL_MATCH(CONTROL_MATCH),
        .CONTROL_MATCH0(CONTROL_MATCH0),
        .CRC_COMPUTE0(CRC_COMPUTE0),
        .D({Q6_out,Q5_out,Q4_out,Q3_out,Q2_out,Q1_out,Q0_out,RXD_REG5}),
        .DATA_FIELD(DATA_FIELD),
        .DATA_NO_FCS(DATA_NO_FCS),
        .DATA_NO_FCS0(DATA_NO_FCS0),
        .DATA_WITH_FCS(DATA_WITH_FCS),
        .DATA_WITH_FCS0(DATA_WITH_FCS0),
        .E(n_31_RX_SM),
        .END_OF_DATA(END_OF_DATA),
        .EXCEEDED_MIN_LEN(EXCEEDED_MIN_LEN),
        .EXTENSION_FIELD(EXTENSION_FIELD),
        .EXTENSION_FLAG(EXTENSION_FLAG),
        .FALSE_CARR_FLAG(FALSE_CARR_FLAG),
        .FCS_FIELD(FCS_FIELD),
        .FRAME_LEN_ERR(FRAME_LEN_ERR),
        .I1(I1),
        .I10(n_1_FRAME_CHECKER),
        .I11(n_38_FRAME_DECODER),
        .I12(n_12_FRAME_CHECKER),
        .I13(n_0_RX_DV_REG3_reg),
        .I18(p_3_out_0),
        .I2(I2),
        .I22(n_24_RX_SM),
        .I3(n_0_ENABLE_REG_reg),
        .I4(n_32_FRAME_DECODER),
        .I5(n_31_FRAME_DECODER),
        .I6(n_33_FRAME_DECODER),
        .I7(n_0_VLAN_ENABLE_HELD_reg),
        .I8(n_0_SPEED_IS_10_100_HELD_reg),
        .I9(n_34_FRAME_DECODER),
        .IFG_FLAG(IFG_FLAG),
        .INHIBIT_FRAME(INHIBIT_FRAME),
        .INHIBIT_FRAME0(INHIBIT_FRAME0),
        .LENGTH_FIELD(LENGTH_FIELD),
        .LENGTH_FIELD_MATCH(LENGTH_FIELD_MATCH),
        .LENGTH_ONE(LENGTH_ONE),
        .LENGTH_ONE0(LENGTH_ONE0),
        .LENGTH_ZERO(LENGTH_ZERO),
        .LENGTH_ZERO0(LENGTH_ZERO0),
        .LESS_THAN_256(LESS_THAN_256),
        .LESS_THAN_2560(LESS_THAN_2560),
        .LT_CHECK_HELD(LT_CHECK_HELD),
        .MATCH_FRAME_INT(MATCH_FRAME_INT),
        .MATCH_FRAME_INT0(MATCH_FRAME_INT0),
        .MULTICAST_MATCH(MULTICAST_MATCH),
        .O1(END_OF_FRAME),
        .O10(n_29_RX_SM),
        .O11(n_30_RX_SM),
        .O12(n_32_RX_SM),
        .O13(n_33_RX_SM),
        .O14(n_34_RX_SM),
        .O15(n_35_RX_SM),
        .O2(n_7_RX_SM),
        .O3(FIELD_COUNTER),
        .O4(n_19_RX_SM),
        .O5(n_20_RX_SM),
        .O6(n_25_RX_SM),
        .O7(n_26_RX_SM),
        .O8(n_27_RX_SM),
        .O9(n_28_RX_SM),
        .PREAMBLE_FIELD(PREAMBLE_FIELD),
        .PRE_FALSE_CARR_FLAG(PRE_FALSE_CARR_FLAG),
        .PRE_IFG_FLAG(PRE_IFG_FLAG),
        .Q({\n_0_RXD_REG7_reg[7] ,\n_0_RXD_REG7_reg[6] ,\n_0_RXD_REG7_reg[5] ,\n_0_RXD_REG7_reg[4] ,\n_0_RXD_REG7_reg[3] ,\n_0_RXD_REG7_reg[2] ,\n_0_RXD_REG7_reg[1] ,\n_0_RXD_REG7_reg[0] }),
        .RX_DV_REG2(RX_DV_REG2),
        .RX_DV_REG5(RX_DV_REG5),
        .RX_DV_REG6(RX_DV_REG6),
        .RX_DV_REG7(RX_DV_REG7),
        .RX_ERR_REG5(RX_ERR_REG5),
        .RX_ERR_REG6(RX_ERR_REG6),
        .RX_ERR_REG7(RX_ERR_REG7),
        .SFD_FLAG(SFD_FLAG),
        .SR(SR),
        .TYPE_FRAME(TYPE_FRAME),
        .TYPE_PACKET10_out(TYPE_PACKET10_out),
        .alignment_err_reg(alignment_err_reg),
        .broadcastaddressmatch(broadcastaddressmatch),
        .int_alignment_err_pulse(int_alignment_err_pulse),
        .p_8_in(p_8_in));
LUT5 #(
    .INIT(32'h00000800)) 
     SFD_FLAG_i_1
       (.I0(n_0_SFD_FLAG_i_2),
        .I1(RXD_REG6[0]),
        .I2(RXD_REG6[1]),
        .I3(RXD_REG6[2]),
        .I4(RXD_REG6[5]),
        .O(SFD_FLAG0));
LUT6 #(
    .INIT(64'h0040000000000000)) 
     SFD_FLAG_i_2
       (.I0(RXD_REG6[3]),
        .I1(RXD_REG6[4]),
        .I2(RX_DV_REG6),
        .I3(RX_ERR_REG6),
        .I4(RXD_REG6[6]),
        .I5(RXD_REG6[7]),
        .O(n_0_SFD_FLAG_i_2));
FDRE SFD_FLAG_reg
       (.C(I1),
        .CE(I2),
        .D(SFD_FLAG0),
        .Q(SFD_FLAG),
        .R(SR));
FDRE SPEED_IS_10_100_HELD_reg
       (.C(I1),
        .CE(n_32_RX_SM),
        .D(O3),
        .Q(n_0_SPEED_IS_10_100_HELD_reg),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     STATISTICS_VALID_reg
       (.C(I1),
        .CE(I2),
        .D(n_11_FRAME_CHECKER),
        .Q(rx_statistics_valid),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[0] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[0]),
        .Q(rx_statistics_vector[0]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[10] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[10]),
        .Q(rx_statistics_vector[10]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[11] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[11]),
        .Q(rx_statistics_vector[11]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[12] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[12]),
        .Q(rx_statistics_vector[12]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[13] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[13]),
        .Q(rx_statistics_vector[13]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[14] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[14]),
        .Q(rx_statistics_vector[14]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[15] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[15]),
        .Q(rx_statistics_vector[15]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[16] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[16]),
        .Q(rx_statistics_vector[16]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[17] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[17]),
        .Q(rx_statistics_vector[17]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[18] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[18]),
        .Q(rx_statistics_vector[18]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[19] 
       (.C(I1),
        .CE(I2),
        .D(int_rx_control_frame_any_da),
        .Q(rx_statistics_vector[19]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[1] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[1]),
        .Q(rx_statistics_vector[1]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[20] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[20]),
        .Q(rx_statistics_vector[20]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[21] 
       (.C(I1),
        .CE(I2),
        .D(VLAN_FRAME),
        .Q(rx_statistics_vector[21]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[22] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[22]),
        .Q(rx_statistics_vector[22]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[23] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[23]),
        .Q(rx_statistics_vector[24]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[24] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[24]),
        .Q(rx_statistics_vector[25]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[2] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[2]),
        .Q(rx_statistics_vector[2]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[3] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[3]),
        .Q(rx_statistics_vector[3]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[4] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[4]),
        .Q(rx_statistics_vector[4]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[5] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[5]),
        .Q(rx_statistics_vector[5]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[6] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[6]),
        .Q(rx_statistics_vector[6]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[7] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[7]),
        .Q(rx_statistics_vector[7]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[8] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[8]),
        .Q(rx_statistics_vector[8]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \STATISTICS_VECTOR_reg[9] 
       (.C(I1),
        .CE(I2),
        .D(p_0_out_0[9]),
        .Q(rx_statistics_vector[9]),
        .R(\<const0> ));
FDRE VALIDATE_REQUIRED_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_40_FRAME_DECODER),
        .Q(VALIDATE_REQUIRED),
        .R(\<const0> ));
VCC VCC
       (.P(\<const1> ));
FDRE VLAN_ENABLE_HELD_reg
       (.C(I1),
        .CE(n_32_RX_SM),
        .D(rx_configuration_vector[1]),
        .Q(n_0_VLAN_ENABLE_HELD_reg),
        .R(SR));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     bad_fc_opcode_int_i_4
       (.I0(O9[3]),
        .I1(O9[2]),
        .I2(O9[6]),
        .I3(O9[7]),
        .I4(O9[4]),
        .I5(O9[5]),
        .O(O8));
LUT5 #(
    .INIT(32'h888F8880)) 
     broadcast_byte_match_i_1
       (.I0(n_0_DATA_VALID_EARLY_INT_i_2),
        .I1(n_0_broadcast_byte_match_i_2),
        .I2(SR),
        .I3(I2),
        .I4(broadcast_byte_match),
        .O(O7));
LUT6 #(
    .INIT(64'h0080000000000000)) 
     broadcast_byte_match_i_2
       (.I0(data_early[3]),
        .I1(data_early[1]),
        .I2(data_early[7]),
        .I3(SR),
        .I4(data_early[4]),
        .I5(data_early[5]),
        .O(n_0_broadcast_byte_match_i_2));
(* SOFT_HLUTNM = "soft_lutpair105" *) 
   LUT4 #(
    .INIT(16'hFEAA)) 
     check_opcode_i_2
       (.I0(SR),
        .I1(int_rx_good_frame_in),
        .I2(int_rx_bad_frame_in),
        .I3(I2),
        .O(bad_pfc_opcode_int));
(* SOFT_HLUTNM = "soft_lutpair103" *) 
   LUT5 #(
    .INIT(32'hBFAAAAAA)) 
     \counter[5]_i_1__0 
       (.I0(SR),
        .I1(O1),
        .I2(O2),
        .I3(I2),
        .I4(rx_data_valid_reg1),
        .O(I7));
(* SOFT_HLUTNM = "soft_lutpair103" *) 
   LUT2 #(
    .INIT(4'h8)) 
     delay_rx_data_valid_i_1
       (.I0(O1),
        .I1(O2),
        .O(data_valid_early));
LUT5 #(
    .INIT(32'hAABFBFAA)) 
     \load_count_pipe[2]_i_1 
       (.I0(SR),
        .I1(O1),
        .I2(O2),
        .I3(update_pause_ad_sync),
        .I4(update_pause_ad_sync_reg),
        .O(O6));
LUT6 #(
    .INIT(64'h9009000000000000)) 
     pause_match_reg_i_1
       (.I0(data_early[0]),
        .I1(p_10_out),
        .I2(data_early[1]),
        .I3(p_6_out),
        .I4(n_0_pause_match_reg_i_2),
        .I5(n_0_pause_match_reg_i_3),
        .O(pause_match_reg0));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     pause_match_reg_i_2
       (.I0(data_early[4]),
        .I1(p_3_out),
        .I2(data_early[7]),
        .I3(p_0_out),
        .I4(p_4_out),
        .I5(data_early[3]),
        .O(n_0_pause_match_reg_i_2));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     pause_match_reg_i_3
       (.I0(data_early[5]),
        .I1(p_2_out),
        .I2(data_early[6]),
        .I3(p_1_out),
        .I4(p_5_out),
        .I5(data_early[2]),
        .O(n_0_pause_match_reg_i_3));
(* SOFT_HLUTNM = "soft_lutpair104" *) 
   LUT4 #(
    .INIT(16'hFEAA)) 
     \pause_opcode_early[7]_i_1 
       (.I0(SR),
        .I1(int_rx_good_frame_in),
        .I2(int_rx_bad_frame_in),
        .I3(I2),
        .O(O5));
(* SOFT_HLUTNM = "soft_lutpair104" *) 
   LUT4 #(
    .INIT(16'h1000)) 
     \pause_value[15]_i_3 
       (.I0(int_rx_bad_frame_in),
        .I1(int_rx_good_frame_in),
        .I2(Q),
        .I3(I2),
        .O(O4));
(* SOFT_HLUTNM = "soft_lutpair105" *) 
   LUT3 #(
    .INIT(8'hBA)) 
     rx_bad_frame_int_i_1
       (.I0(int_rx_bad_frame_in),
        .I1(I3),
        .I2(int_rx_good_frame_in),
        .O(rx_bad_frame_comb));
LUT6 #(
    .INIT(64'h9009000000000000)) 
     special_pause_match_reg_i_1
       (.I0(data_early[4]),
        .I1(I9),
        .I2(data_early[1]),
        .I3(p_9_out),
        .I4(n_0_special_pause_match_reg_i_2),
        .I5(n_0_special_pause_match_reg_i_3),
        .O(special_pause_match_comb));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     special_pause_match_reg_i_2
       (.I0(data_early[7]),
        .I1(I10),
        .I2(data_early[2]),
        .I3(p_8_out),
        .I4(p_7_out),
        .I5(data_early[3]),
        .O(n_0_special_pause_match_reg_i_2));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     special_pause_match_reg_i_3
       (.I0(data_early[5]),
        .I1(I11),
        .I2(data_early[0]),
        .I3(I12),
        .I4(I13),
        .I5(data_early[6]),
        .O(n_0_special_pause_match_reg_i_3));
LUT1 #(
    .INIT(2'h1)) 
     speedis10100_INST_0
       (.I0(tx_configuration_vector[1]),
        .O(O3));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1
   (O1,
    O2,
    tx_statistics_valid,
    tx_statistics_vector,
    O3,
    rx_statistics_valid,
    rx_statistics_vector,
    SR,
    rgmii_tx_ctl_int,
    E,
    gmii_txd_falling,
    Q,
    tx_en_to_ddr,
    rx_axis_mac_tdata,
    rx_axis_mac_tvalid,
    rx_axis_mac_tlast,
    rx_axis_mac_tuser,
    gmii_rx_dv_int,
    I1,
    gmii_rx_er_int,
    tx_enable,
    gtx_clk,
    I2,
    tx_configuration_vector,
    rx_configuration_vector,
    phy_tx_enable,
    counter0,
    tx_axis_mac_tvalid,
    tx_axis_mac_tuser,
    tx_axis_mac_tlast,
    pause_req,
    clk_div5,
    pause_val,
    tx_axis_mac_tdata,
    D,
    tx_ifg_delay,
    rx_axi_rstn,
    glbl_rstn,
    tx_axi_rstn);
  output O1;
  output O2;
  output tx_statistics_valid;
  output [31:0]tx_statistics_vector;
  output O3;
  output rx_statistics_valid;
  output [27:0]rx_statistics_vector;
  output [0:0]SR;
  output rgmii_tx_ctl_int;
  output [0:0]E;
  output [3:0]gmii_txd_falling;
  output [3:0]Q;
  output tx_en_to_ddr;
  output [7:0]rx_axis_mac_tdata;
  output rx_axis_mac_tvalid;
  output rx_axis_mac_tlast;
  output rx_axis_mac_tuser;
  input gmii_rx_dv_int;
  input I1;
  input gmii_rx_er_int;
  input tx_enable;
  input gtx_clk;
  input I2;
  input [72:0]tx_configuration_vector;
  input [72:0]rx_configuration_vector;
  input phy_tx_enable;
  input counter0;
  input tx_axis_mac_tvalid;
  input tx_axis_mac_tuser;
  input tx_axis_mac_tlast;
  input pause_req;
  input clk_div5;
  input [15:0]pause_val;
  input [7:0]tx_axis_mac_tdata;
  input [7:0]D;
  input [7:0]tx_ifg_delay;
  input rx_axi_rstn;
  input glbl_rstn;
  input tx_axi_rstn;

  wire \<const1> ;
  wire CE_REG1_OUT7_out;
  wire CRC100_EN;
  wire CRC_OK;
  wire [7:0]D;
  wire [0:0]E;
  wire END_OF_FRAME;
  wire I1;
  wire I2;
  wire INT_ENABLE;
  wire MATCH_FRAME_INT0;
  wire O1;
  wire O2;
  wire O3;
  wire [3:0]Q;
  wire [0:0]SR;
  wire \TX_SM1/INT_CRC_MODE ;
  wire \TX_SM1/MAX_PKT_LEN_REACHED ;
  wire \TX_SM1/PAD ;
  wire \TX_SM1/REG_DATA_VALID ;
  wire \address_filter_inst/broadcast_byte_match ;
  wire \address_filter_inst/p_0_out ;
  wire \address_filter_inst/p_10_out ;
  wire \address_filter_inst/p_1_out ;
  wire \address_filter_inst/p_2_out ;
  wire \address_filter_inst/p_3_out ;
  wire \address_filter_inst/p_4_out ;
  wire \address_filter_inst/p_5_out ;
  wire \address_filter_inst/p_6_out ;
  wire \address_filter_inst/p_7_out ;
  wire \address_filter_inst/p_8_out ;
  wire \address_filter_inst/p_9_out ;
  wire \address_filter_inst/rx_data_valid_reg1 ;
  wire \address_filter_inst/update_pause_ad_sync ;
  wire \address_filter_inst/update_pause_ad_sync_reg ;
  wire address_valid_early;
  wire alignment_err_reg;
  wire broadcastaddressmatch;
  wire clk_div5;
  wire counter0;
  wire data_valid_early;
  wire glbl_rstn;
  wire gmii_rx_dv_from_mii;
  wire gmii_rx_dv_int;
  wire gmii_rx_er_from_mii;
  wire gmii_rx_er_int;
  wire [7:0]gmii_rxd_from_mii;
  wire [3:0]gmii_txd_falling;
  wire gtx_clk;
  wire \hd_tieoff.extension_reg_reg ;
  wire int_alignment_err_pulse;
  wire int_gmii_tx_en;
  wire int_gmii_tx_er;
  wire [7:0]int_gmii_txd;
  wire int_rx_bad_frame_in;
  wire int_rx_control_frame;
  wire [7:0]int_rx_data_in;
  wire int_rx_data_valid_in;
  wire int_rx_good_frame_in;
  wire int_tx_ack_in;
  wire int_tx_crc_enable_out;
  wire [7:0]int_tx_data_out;
  wire int_tx_data_valid_out;
  wire int_tx_vlan_enable_out;
  wire load_source;
  wire n_0_rx_axi_shim;
  wire n_0_rxgen;
  wire n_10_flow;
  wire n_10_rxgen;
  wire n_11_flow;
  wire \n_11_tx_axi_intf.tx_axi_shim ;
  wire n_12_addr_filter_top;
  wire n_12_flow;
  wire \n_12_tx_axi_intf.tx_axi_shim ;
  wire n_13_addr_filter_top;
  wire n_13_flow;
  wire n_14_addr_filter_top;
  wire n_14_flow;
  wire n_15_addr_filter_top;
  wire n_15_flow;
  wire n_16_flow;
  wire n_18_flow;
  wire n_1_rx_axi_shim;
  wire n_1_sync_rx_reset_i;
  wire n_2_sync_rx_reset_i;
  wire n_2_sync_tx_reset_i;
  wire n_33_flow;
  wire n_34_flow;
  wire n_35_flow;
  wire n_39_rxgen;
  wire n_39_txgen;
  wire n_3_sync_tx_reset_i;
  wire n_40_rxgen;
  wire n_40_txgen;
  wire n_41_txgen;
  wire n_42_rxgen;
  wire n_42_txgen;
  wire n_43_rxgen;
  wire n_43_txgen;
  wire n_44_txgen;
  wire n_45_txgen;
  wire n_46_rxgen;
  wire n_47_txgen;
  wire n_48_txgen;
  wire n_4_sync_tx_reset_i;
  wire \n_4_tx_axi_intf.tx_axi_shim ;
  wire n_50_txgen;
  wire \n_5_tx_axi_intf.tx_axi_shim ;
  wire n_6_flow;
  wire \n_7_tx_axi_intf.tx_axi_shim ;
  wire n_8_addr_filter_top;
  wire n_8_rxgen;
  wire \n_8_tx_axi_intf.tx_axi_shim ;
  wire n_9_flow;
  wire n_9_rxgen;
  wire \n_9_tx_axi_intf.tx_axi_shim ;
  wire [1:0]next_rx_state;
  wire pause_match_reg0;
  wire pause_req;
  wire [15:0]pause_val;
  wire pauseaddressmatch;
  wire phy_tx_enable;
  wire rgmii_tx_ctl_int;
  wire \rx/bad_pfc_opcode_int ;
  wire [4:4]\rx/data_count_reg ;
  wire rx_axi_rstn;
  wire [7:0]rx_axis_mac_tdata;
  wire rx_axis_mac_tlast;
  wire rx_axis_mac_tuser;
  wire rx_axis_mac_tvalid;
  wire rx_bad_frame_comb;
  wire [72:0]rx_configuration_vector;
  wire [7:0]rx_data;
  wire rx_enable_reg;
  wire rx_mac_tlast0;
  wire rx_mac_tuser0;
  wire rx_statistics_valid;
  wire [27:0]rx_statistics_vector;
  wire rxstatsaddressmatch;
  wire sample;
  wire special_pause_match_comb;
  wire specialpauseaddressmatch;
  wire \tx/data_avail_in_reg ;
  wire tx_ack_int;
  wire tx_axi_rstn;
  wire [7:0]tx_axis_mac_tdata;
  wire tx_axis_mac_tlast;
  wire tx_axis_mac_tuser;
  wire tx_axis_mac_tvalid;
  wire tx_ce_sample;
  wire [72:0]tx_configuration_vector;
  wire [7:0]tx_data_int;
  wire tx_data_valid_int;
  wire tx_en_to_ddr;
  wire tx_enable;
  wire [7:0]tx_ifg_delay;
  wire tx_statistics_valid;
  wire [31:0]tx_statistics_vector;
  wire tx_underrun_int;
  wire tx_underrun_int_0;

VCC VCC
       (.P(\<const1> ));
TriMACtri_mode_ethernet_mac_v8_1_addr_filter_wrap addr_filter_top
       (.I1(I1),
        .I2(I2),
        .I3(n_43_rxgen),
        .I4(n_8_rxgen),
        .I5(n_0_rxgen),
        .I6(n_40_rxgen),
        .I7(n_39_rxgen),
        .MATCH_FRAME_INT0(MATCH_FRAME_INT0),
        .O1(n_8_addr_filter_top),
        .O2(n_12_addr_filter_top),
        .O3(n_13_addr_filter_top),
        .O4(n_14_addr_filter_top),
        .O5(n_15_addr_filter_top),
        .SR(O1),
        .address_valid_early(address_valid_early),
        .broadcast_byte_match(\address_filter_inst/broadcast_byte_match ),
        .broadcastaddressmatch(broadcastaddressmatch),
        .data_out(\address_filter_inst/update_pause_ad_sync ),
        .data_valid_early(data_valid_early),
        .p_0_out(\address_filter_inst/p_0_out ),
        .p_10_out(\address_filter_inst/p_10_out ),
        .p_1_out(\address_filter_inst/p_1_out ),
        .p_2_out(\address_filter_inst/p_2_out ),
        .p_3_out(\address_filter_inst/p_3_out ),
        .p_4_out(\address_filter_inst/p_4_out ),
        .p_5_out(\address_filter_inst/p_5_out ),
        .p_6_out(\address_filter_inst/p_6_out ),
        .p_7_out(\address_filter_inst/p_7_out ),
        .p_8_out(\address_filter_inst/p_8_out ),
        .p_9_out(\address_filter_inst/p_9_out ),
        .pause_match_reg0(pause_match_reg0),
        .pauseaddressmatch(pauseaddressmatch),
        .rx_configuration_vector({rx_configuration_vector[72:25],rx_configuration_vector[8]}),
        .rx_data_valid_reg1(\address_filter_inst/rx_data_valid_reg1 ),
        .rxstatsaddressmatch(rxstatsaddressmatch),
        .special_pause_match_comb(special_pause_match_comb),
        .specialpauseaddressmatch(specialpauseaddressmatch),
        .update_pause_ad_sync_reg(\address_filter_inst/update_pause_ad_sync_reg ));
TriMACtri_mode_ethernet_mac_v8_1_control flow
       (.D(tx_data_int),
        .E(n_42_rxgen),
        .I1(O2),
        .I10(n_43_txgen),
        .I11(int_tx_data_out),
        .I12(n_46_rxgen),
        .I13(int_rx_data_in),
        .I14(n_10_rxgen),
        .I15(\n_4_tx_axi_intf.tx_axi_shim ),
        .I16(\n_11_tx_axi_intf.tx_axi_shim ),
        .I17(\n_12_tx_axi_intf.tx_axi_shim ),
        .I18(n_9_rxgen),
        .I2(I2),
        .I3(I1),
        .I4(n_44_txgen),
        .I5(n_45_txgen),
        .I6(n_39_txgen),
        .I7(n_41_txgen),
        .I8(n_50_txgen),
        .I9(n_40_txgen),
        .INT_ENABLE(INT_ENABLE),
        .MAX_PKT_LEN_REACHED(\TX_SM1/MAX_PKT_LEN_REACHED ),
        .O1(n_6_flow),
        .O10(n_18_flow),
        .O11(n_34_flow),
        .O12(n_35_flow),
        .O13(rx_data),
        .O2(n_9_flow),
        .O3(n_10_flow),
        .O4(n_11_flow),
        .O5(n_12_flow),
        .O6(n_13_flow),
        .O7(n_14_flow),
        .O8(n_15_flow),
        .O9(n_16_flow),
        .Q(\rx/data_count_reg ),
        .REG_DATA_VALID(\TX_SM1/REG_DATA_VALID ),
        .SR(O1),
        .bad_pfc_opcode_int(\rx/bad_pfc_opcode_int ),
        .data_avail_in_reg(\tx/data_avail_in_reg ),
        .gtx_clk(gtx_clk),
        .int_rx_bad_frame_in(int_rx_bad_frame_in),
        .int_rx_control_frame(int_rx_control_frame),
        .int_rx_data_valid_in(int_rx_data_valid_in),
        .int_rx_good_frame_in(int_rx_good_frame_in),
        .int_tx_ack_in(int_tx_ack_in),
        .int_tx_crc_enable_out(int_tx_crc_enable_out),
        .int_tx_data_valid_out(int_tx_data_valid_out),
        .int_tx_vlan_enable_out(int_tx_vlan_enable_out),
        .load_source(load_source),
        .next_rx_state(next_rx_state),
        .pause_req(pause_req),
        .pause_val(pause_val),
        .rx_bad_frame_comb(rx_bad_frame_comb),
        .rx_configuration_vector(rx_configuration_vector[5]),
        .rx_enable_reg(rx_enable_reg),
        .rx_mac_tlast0(rx_mac_tlast0),
        .rx_mac_tuser0(rx_mac_tuser0),
        .rx_mac_tvalid0(n_33_flow),
        .rx_state({n_0_rx_axi_shim,n_1_rx_axi_shim}),
        .rx_statistics_vector(rx_statistics_vector[23]),
        .sample(sample),
        .tx_ack_int(tx_ack_int),
        .tx_ce_sample(tx_ce_sample),
        .tx_configuration_vector({tx_configuration_vector[72:25],tx_configuration_vector[5],tx_configuration_vector[3:2]}),
        .tx_data_valid_int(tx_data_valid_int),
        .tx_statistics_valid(tx_statistics_valid),
        .tx_statistics_vector(tx_statistics_vector[31]),
        .tx_underrun_int(tx_underrun_int),
        .tx_underrun_int_0(tx_underrun_int_0));
TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_rx gmii_mii_rx_gen
       (.D(gmii_rxd_from_mii),
        .I1(I1),
        .I2(D),
        .SR(O1),
        .alignment_err_reg(alignment_err_reg),
        .gmii_rx_dv_from_mii(gmii_rx_dv_from_mii),
        .gmii_rx_dv_int(gmii_rx_dv_int),
        .gmii_rx_er_from_mii(gmii_rx_er_from_mii),
        .gmii_rx_er_int(gmii_rx_er_int),
        .int_alignment_err_pulse(int_alignment_err_pulse),
        .tx_configuration_vector(tx_configuration_vector[8]));
TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_tx gmii_mii_tx_gen
       (.D(int_gmii_txd),
        .I1(O2),
        .I2(n_2_sync_tx_reset_i),
        .O1(\hd_tieoff.extension_reg_reg ),
        .Q(Q),
        .SR(n_3_sync_tx_reset_i),
        .clk_div5(clk_div5),
        .gmii_txd_falling(gmii_txd_falling),
        .gtx_clk(gtx_clk),
        .int_gmii_tx_en(int_gmii_tx_en),
        .int_gmii_tx_er(int_gmii_tx_er),
        .phy_tx_enable(phy_tx_enable),
        .rgmii_tx_ctl_int(rgmii_tx_ctl_int),
        .tx_configuration_vector(tx_configuration_vector[8]),
        .tx_en_to_ddr(tx_en_to_ddr));
TriMACtri_mode_ethernet_mac_v8_1_rx_axi_intf rx_axi_shim
       (.D(next_rx_state),
        .I1(I1),
        .I2(I2),
        .I3(rx_data),
        .Q({n_0_rx_axi_shim,n_1_rx_axi_shim}),
        .SR(O1),
        .rx_axis_mac_tdata(rx_axis_mac_tdata),
        .rx_axis_mac_tlast(rx_axis_mac_tlast),
        .rx_axis_mac_tuser(rx_axis_mac_tuser),
        .rx_axis_mac_tvalid(rx_axis_mac_tvalid),
        .rx_mac_tlast0(rx_mac_tlast0),
        .rx_mac_tuser0(rx_mac_tuser0),
        .rx_mac_tvalid0(n_33_flow));
TriMACrx rxgen
       (.D(gmii_rxd_from_mii),
        .E(n_42_rxgen),
        .END_OF_FRAME(END_OF_FRAME),
        .I1(I1),
        .I10(n_15_addr_filter_top),
        .I11(n_13_addr_filter_top),
        .I12(n_8_addr_filter_top),
        .I13(n_14_addr_filter_top),
        .I14(n_2_sync_rx_reset_i),
        .I2(I2),
        .I3(n_12_flow),
        .I4(n_11_flow),
        .I5(n_10_flow),
        .I6(n_1_sync_rx_reset_i),
        .I7(n_39_rxgen),
        .I8(n_9_flow),
        .I9(n_12_addr_filter_top),
        .MATCH_FRAME_INT0(MATCH_FRAME_INT0),
        .O1(n_0_rxgen),
        .O2(n_8_rxgen),
        .O3(O3),
        .O4(n_9_rxgen),
        .O5(n_10_rxgen),
        .O6(n_40_rxgen),
        .O7(n_43_rxgen),
        .O8(n_46_rxgen),
        .O9(int_rx_data_in),
        .Q(\rx/data_count_reg ),
        .SR(O1),
        .address_valid_early(address_valid_early),
        .alignment_err_reg(alignment_err_reg),
        .bad_pfc_opcode_int(\rx/bad_pfc_opcode_int ),
        .broadcast_byte_match(\address_filter_inst/broadcast_byte_match ),
        .broadcastaddressmatch(broadcastaddressmatch),
        .data_valid_early(data_valid_early),
        .gmii_rx_dv_from_mii(gmii_rx_dv_from_mii),
        .gmii_rx_er_from_mii(gmii_rx_er_from_mii),
        .int_alignment_err_pulse(int_alignment_err_pulse),
        .int_rx_bad_frame_in(int_rx_bad_frame_in),
        .int_rx_control_frame(int_rx_control_frame),
        .int_rx_data_valid_in(int_rx_data_valid_in),
        .int_rx_good_frame_in(int_rx_good_frame_in),
        .p_0_out(\address_filter_inst/p_0_out ),
        .p_10_out(\address_filter_inst/p_10_out ),
        .p_1_out(\address_filter_inst/p_1_out ),
        .p_2_out(\address_filter_inst/p_2_out ),
        .p_3_out(\address_filter_inst/p_3_out ),
        .p_4_out(\address_filter_inst/p_4_out ),
        .p_5_out(\address_filter_inst/p_5_out ),
        .p_6_out(\address_filter_inst/p_6_out ),
        .p_7_out(\address_filter_inst/p_7_out ),
        .p_8_out(\address_filter_inst/p_8_out ),
        .p_9_out(\address_filter_inst/p_9_out ),
        .pause_match_reg0(pause_match_reg0),
        .pauseaddressmatch(pauseaddressmatch),
        .rx_bad_frame_comb(rx_bad_frame_comb),
        .rx_configuration_vector({rx_configuration_vector[24:9],rx_configuration_vector[7:6],rx_configuration_vector[4:1]}),
        .rx_data_valid_reg1(\address_filter_inst/rx_data_valid_reg1 ),
        .rx_enable_reg(rx_enable_reg),
        .rx_statistics_valid(rx_statistics_valid),
        .rx_statistics_vector({rx_statistics_vector[26:24],rx_statistics_vector[22:0]}),
        .special_pause_match_comb(special_pause_match_comb),
        .specialpauseaddressmatch(specialpauseaddressmatch),
        .tx_configuration_vector(tx_configuration_vector[8:7]),
        .update_pause_ad_sync(\address_filter_inst/update_pause_ad_sync ),
        .update_pause_ad_sync_reg(\address_filter_inst/update_pause_ad_sync_reg ));
FDRE rxstatsaddressmatch_del_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(rxstatsaddressmatch),
        .Q(rx_statistics_vector[27]),
        .R(O1));
TriMACtri_mode_ethernet_mac_v8_1_sync_reset_0 sync_rx_reset_i
       (.END_OF_FRAME(END_OF_FRAME),
        .I1(I1),
        .I14(n_2_sync_rx_reset_i),
        .I2(I2),
        .O1(n_1_sync_rx_reset_i),
        .SR(O1),
        .glbl_rstn(glbl_rstn),
        .rx_axi_rstn(rx_axi_rstn),
        .rx_configuration_vector(rx_configuration_vector[0]));
TriMACtri_mode_ethernet_mac_v8_1_sync_reset sync_tx_reset_i
       (.CRC_OK(CRC_OK),
        .O1(O2),
        .O2(n_2_sync_tx_reset_i),
        .O3(n_3_sync_tx_reset_i),
        .O4(n_4_sync_tx_reset_i),
        .SR(SR),
        .counter0(counter0),
        .glbl_rstn(glbl_rstn),
        .gtx_clk(gtx_clk),
        .\hd_tieoff.extension_reg_reg (\hd_tieoff.extension_reg_reg ),
        .phy_tx_enable(phy_tx_enable),
        .tx_axi_rstn(tx_axi_rstn),
        .tx_configuration_vector(tx_configuration_vector[0]));
TriMACtri_mode_ethernet_mac_v8_1_tx_axi_intf \tx_axi_intf.tx_axi_shim 
       (.CE_REG1_OUT7_out(CE_REG1_OUT7_out),
        .CRC100_EN(CRC100_EN),
        .E(E),
        .I1(O2),
        .I2(n_6_flow),
        .I3(n_18_flow),
        .I4(n_42_txgen),
        .INT_CRC_MODE(\TX_SM1/INT_CRC_MODE ),
        .O1(\n_4_tx_axi_intf.tx_axi_shim ),
        .O2(\n_5_tx_axi_intf.tx_axi_shim ),
        .O3(\n_7_tx_axi_intf.tx_axi_shim ),
        .O4(\n_9_tx_axi_intf.tx_axi_shim ),
        .O5(\n_11_tx_axi_intf.tx_axi_shim ),
        .O6(\n_12_tx_axi_intf.tx_axi_shim ),
        .O7(tx_data_int),
        .PAD(\TX_SM1/PAD ),
        .Q({n_47_txgen,n_48_txgen}),
        .SR(\n_8_tx_axi_intf.tx_axi_shim ),
        .gtx_clk(gtx_clk),
        .load_source(load_source),
        .sample(sample),
        .tx_ack_int(tx_ack_int),
        .tx_axis_mac_tdata(tx_axis_mac_tdata),
        .tx_axis_mac_tlast(tx_axis_mac_tlast),
        .tx_axis_mac_tuser(tx_axis_mac_tuser),
        .tx_axis_mac_tvalid(tx_axis_mac_tvalid),
        .tx_ce_sample(tx_ce_sample),
        .tx_data_valid_int(tx_data_valid_int),
        .tx_enable(tx_enable),
        .tx_underrun_int(tx_underrun_int));
TriMACtx txgen
       (.CE_REG1_OUT7_out(CE_REG1_OUT7_out),
        .CRC100_EN(CRC100_EN),
        .CRC_OK(CRC_OK),
        .D(int_gmii_txd),
        .E(\n_7_tx_axi_intf.tx_axi_shim ),
        .I1(O2),
        .I10(\n_9_tx_axi_intf.tx_axi_shim ),
        .I11(int_tx_data_out),
        .I2(n_14_flow),
        .I3(n_13_flow),
        .I4(n_4_sync_tx_reset_i),
        .I5(n_15_flow),
        .I6(n_16_flow),
        .I7(n_35_flow),
        .I8(n_34_flow),
        .I9(\n_5_tx_axi_intf.tx_axi_shim ),
        .INT_CRC_MODE(\TX_SM1/INT_CRC_MODE ),
        .INT_ENABLE(INT_ENABLE),
        .MAX_PKT_LEN_REACHED(\TX_SM1/MAX_PKT_LEN_REACHED ),
        .O1(n_39_txgen),
        .O2(n_40_txgen),
        .O3(O3),
        .O4(n_41_txgen),
        .O5(n_42_txgen),
        .O6(n_43_txgen),
        .O7(n_44_txgen),
        .O8(n_45_txgen),
        .O9(n_50_txgen),
        .PAD(\TX_SM1/PAD ),
        .Q({n_47_txgen,n_48_txgen}),
        .REG_DATA_VALID(\TX_SM1/REG_DATA_VALID ),
        .SR(\n_8_tx_axi_intf.tx_axi_shim ),
        .data_avail_in_reg(\tx/data_avail_in_reg ),
        .gtx_clk(gtx_clk),
        .int_gmii_tx_en(int_gmii_tx_en),
        .int_gmii_tx_er(int_gmii_tx_er),
        .int_tx_ack_in(int_tx_ack_in),
        .int_tx_crc_enable_out(int_tx_crc_enable_out),
        .int_tx_data_valid_out(int_tx_data_valid_out),
        .int_tx_vlan_enable_out(int_tx_vlan_enable_out),
        .tx_ce_sample(tx_ce_sample),
        .tx_configuration_vector({tx_configuration_vector[24:6],tx_configuration_vector[4],tx_configuration_vector[1]}),
        .tx_ifg_delay(tx_ifg_delay),
        .tx_statistics_valid(tx_statistics_valid),
        .tx_statistics_vector(tx_statistics_vector[30:0]),
        .tx_underrun_int(tx_underrun_int_0));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_addr_filter
   (p_10_out,
    p_6_out,
    p_5_out,
    p_4_out,
    p_3_out,
    p_2_out,
    p_1_out,
    p_0_out,
    O1,
    p_9_out,
    p_8_out,
    p_7_out,
    O2,
    O3,
    O4,
    O5,
    O6,
    address_valid_early,
    pauseaddressmatch,
    broadcastaddressmatch,
    specialpauseaddressmatch,
    broadcast_byte_match,
    update_pause_ad_sync_reg,
    data_out,
    MATCH_FRAME_INT0,
    rxstatsaddressmatch,
    I2,
    data_valid_early,
    I1,
    SR,
    pause_match_reg0,
    special_pause_match_comb,
    I3,
    I4,
    I5,
    rx_configuration_vector,
    I6,
    I7);
  output p_10_out;
  output p_6_out;
  output p_5_out;
  output p_4_out;
  output p_3_out;
  output p_2_out;
  output p_1_out;
  output p_0_out;
  output O1;
  output p_9_out;
  output p_8_out;
  output p_7_out;
  output O2;
  output O3;
  output O4;
  output O5;
  output O6;
  output address_valid_early;
  output pauseaddressmatch;
  output broadcastaddressmatch;
  output specialpauseaddressmatch;
  output broadcast_byte_match;
  output update_pause_ad_sync_reg;
  output data_out;
  output MATCH_FRAME_INT0;
  output rxstatsaddressmatch;
  input I2;
  input data_valid_early;
  input I1;
  input [0:0]SR;
  input pause_match_reg0;
  input special_pause_match_comb;
  input I3;
  input I4;
  input I5;
  input [48:0]rx_configuration_vector;
  input I6;
  input [0:0]I7;

  wire \<const0> ;
  wire \<const1> ;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire [0:0]I7;
  wire MATCH_FRAME_INT0;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire O5;
  wire O6;
  wire [0:0]SR;
  wire address_match0;
  wire address_match1;
  wire address_valid_early;
  wire broadcast_byte_match;
  wire broadcastaddressmatch;
  wire broadcastaddressmatch_int;
  wire broadcastaddressmatch_int_0;
  wire [5:0]counter_reg__0;
  wire data_out;
  wire data_valid_early;
  wire [2:0]load_count;
  wire load_wr;
  wire [7:0]load_wr_data;
  wire n_0_address_match_i_1;
  wire n_0_address_match_i_4;
  wire n_0_address_match_reg;
  wire n_0_broadcast_match_i_1;
  wire n_0_broadcast_match_reg;
  wire \n_0_counter[5]_i_2 ;
  wire \n_0_load_count[0]_i_1 ;
  wire \n_0_load_count[1]_i_1 ;
  wire \n_0_load_count[2]_i_1 ;
  wire \n_0_load_count_pipe_reg[0] ;
  wire \n_0_load_count_pipe_reg[1] ;
  wire \n_0_load_count_pipe_reg[2] ;
  wire \n_0_load_wr_data[0]_i_2 ;
  wire \n_0_load_wr_data[0]_i_3 ;
  wire \n_0_load_wr_data[1]_i_2 ;
  wire \n_0_load_wr_data[1]_i_3 ;
  wire \n_0_load_wr_data[2]_i_2 ;
  wire \n_0_load_wr_data[2]_i_3 ;
  wire \n_0_load_wr_data[3]_i_2 ;
  wire \n_0_load_wr_data[3]_i_3 ;
  wire \n_0_load_wr_data[4]_i_2 ;
  wire \n_0_load_wr_data[4]_i_3 ;
  wire \n_0_load_wr_data[5]_i_2 ;
  wire \n_0_load_wr_data[5]_i_3 ;
  wire \n_0_load_wr_data[6]_i_2 ;
  wire \n_0_load_wr_data[6]_i_3 ;
  wire \n_0_load_wr_data[7]_i_2 ;
  wire \n_0_load_wr_data[7]_i_3 ;
  wire \n_0_load_wr_data_reg[0] ;
  wire \n_0_load_wr_data_reg[1] ;
  wire \n_0_load_wr_data_reg[2] ;
  wire \n_0_load_wr_data_reg[3] ;
  wire \n_0_load_wr_data_reg[4] ;
  wire \n_0_load_wr_data_reg[5] ;
  wire \n_0_load_wr_data_reg[6] ;
  wire \n_0_load_wr_data_reg[7] ;
  wire n_0_pause_match_i_1;
  wire n_0_pause_match_reg;
  wire n_0_resync_promiscuous_mode;
  wire n_0_rx_ptp_match_i_1;
  wire n_0_rxstatsaddressmatch_i_1;
  wire n_0_special_pause_match_i_1;
  wire n_0_special_pause_match_reg;
  wire n_1_sync_update;
  wire n_2_sync_update;
  wire [5:0]p_0_in__2;
  wire p_0_out;
  wire p_10_out;
  wire p_1_out;
  wire p_2_out;
  wire p_3_out;
  wire p_4_out;
  wire p_5_out;
  wire p_6_out;
  wire p_7_out;
  wire p_8_out;
  wire p_9_out;
  wire pause_match_reg0;
  wire pause_match_reg__0;
  wire pauseaddressmatch;
  wire pauseaddressmatch_int;
  wire [48:0]rx_configuration_vector;
  wire rx_data_valid_reg2;
  wire rx_data_valid_srl16;
  wire rx_data_valid_srl16_reg1;
  wire rx_data_valid_srl16_reg2;
  wire rx_filter_match_comb2;
  wire rx_filtered_data_valid0;
  wire rx_ptp_match;
  wire rxstatsaddressmatch;
  wire special_pause_match_comb;
  wire special_pause_match_reg__0;
  wire specialpauseaddressmatch;
  wire specialpauseaddressmatch_int;
  wire update_pause_ad_sync_reg;
  wire \NLW_byte_wide_ram[0].header_field_dist_ram_SPO_UNCONNECTED ;
  wire \NLW_byte_wide_ram[1].header_field_dist_ram_SPO_UNCONNECTED ;
  wire \NLW_byte_wide_ram[2].header_field_dist_ram_SPO_UNCONNECTED ;
  wire \NLW_byte_wide_ram[3].header_field_dist_ram_SPO_UNCONNECTED ;
  wire \NLW_byte_wide_ram[4].header_field_dist_ram_SPO_UNCONNECTED ;
  wire \NLW_byte_wide_ram[5].header_field_dist_ram_SPO_UNCONNECTED ;
  wire \NLW_byte_wide_ram[6].header_field_dist_ram_SPO_UNCONNECTED ;
  wire \NLW_byte_wide_ram[7].header_field_dist_ram_SPO_UNCONNECTED ;

GND GND
       (.G(\<const0> ));
LUT5 #(
    .INIT(32'hFFFFFFFE)) 
     MATCH_FRAME_INT_i_2
       (.I0(pauseaddressmatch),
        .I1(specialpauseaddressmatch),
        .I2(rx_filter_match_comb2),
        .I3(broadcastaddressmatch),
        .I4(rx_ptp_match),
        .O(MATCH_FRAME_INT0));
VCC VCC
       (.P(\<const1> ));
LUT4 #(
    .INIT(16'hBAAA)) 
     address_match_i_1
       (.I0(SR),
        .I1(rx_data_valid_reg2),
        .I2(O6),
        .I3(I2),
        .O(n_0_address_match_i_1));
LUT5 #(
    .INIT(32'h00000020)) 
     address_match_i_2
       (.I0(n_0_address_match_i_4),
        .I1(counter_reg__0[5]),
        .I2(I2),
        .I3(counter_reg__0[3]),
        .I4(counter_reg__0[4]),
        .O(broadcastaddressmatch_int_0));
LUT4 #(
    .INIT(16'hFFFE)) 
     address_match_i_3
       (.I0(n_0_pause_match_reg),
        .I1(n_0_special_pause_match_reg),
        .I2(n_0_broadcast_match_reg),
        .I3(address_match1),
        .O(address_match0));
(* SOFT_HLUTNM = "soft_lutpair67" *) 
   LUT3 #(
    .INIT(8'h80)) 
     address_match_i_4
       (.I0(counter_reg__0[2]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[0]),
        .O(n_0_address_match_i_4));
FDRE address_match_reg
       (.C(I1),
        .CE(broadcastaddressmatch_int_0),
        .D(address_match0),
        .Q(n_0_address_match_reg),
        .R(n_0_address_match_i_1));
FDRE broadcast_byte_match_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(I3),
        .Q(broadcast_byte_match),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h0F000F0F02000000)) 
     broadcast_match_i_1
       (.I0(O6),
        .I1(rx_data_valid_reg2),
        .I2(SR),
        .I3(broadcast_byte_match),
        .I4(I2),
        .I5(n_0_broadcast_match_reg),
        .O(n_0_broadcast_match_i_1));
FDRE broadcast_match_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_broadcast_match_i_1),
        .Q(n_0_broadcast_match_reg),
        .R(\<const0> ));
FDRE broadcastaddressmatch_int_reg
       (.C(I1),
        .CE(broadcastaddressmatch_int_0),
        .D(n_0_broadcast_match_reg),
        .Q(broadcastaddressmatch_int),
        .R(n_0_address_match_i_1));
FDRE broadcastaddressmatch_reg
       (.C(I1),
        .CE(I2),
        .D(broadcastaddressmatch_int),
        .Q(broadcastaddressmatch),
        .R(SR));
(* BOX_TYPE = "PRIMITIVE" *) 
   RAM64X1D #(
    .INIT(64'h0000000000000000),
    .IS_WCLK_INVERTED(1'b0)) 
     \byte_wide_ram[0].header_field_dist_ram 
       (.A0(\n_0_load_count_pipe_reg[0] ),
        .A1(\n_0_load_count_pipe_reg[1] ),
        .A2(\n_0_load_count_pipe_reg[2] ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .A5(\<const0> ),
        .D(\n_0_load_wr_data_reg[0] ),
        .DPO(p_10_out),
        .DPRA0(counter_reg__0[0]),
        .DPRA1(counter_reg__0[1]),
        .DPRA2(counter_reg__0[2]),
        .DPRA3(counter_reg__0[3]),
        .DPRA4(counter_reg__0[4]),
        .DPRA5(counter_reg__0[5]),
        .SPO(\NLW_byte_wide_ram[0].header_field_dist_ram_SPO_UNCONNECTED ),
        .WCLK(I1),
        .WE(load_wr));
(* BOX_TYPE = "PRIMITIVE" *) 
   RAM64X1D #(
    .INIT(64'h0000000000000000),
    .IS_WCLK_INVERTED(1'b0)) 
     \byte_wide_ram[1].header_field_dist_ram 
       (.A0(\n_0_load_count_pipe_reg[0] ),
        .A1(\n_0_load_count_pipe_reg[1] ),
        .A2(\n_0_load_count_pipe_reg[2] ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .A5(\<const0> ),
        .D(\n_0_load_wr_data_reg[1] ),
        .DPO(p_6_out),
        .DPRA0(counter_reg__0[0]),
        .DPRA1(counter_reg__0[1]),
        .DPRA2(counter_reg__0[2]),
        .DPRA3(counter_reg__0[3]),
        .DPRA4(counter_reg__0[4]),
        .DPRA5(counter_reg__0[5]),
        .SPO(\NLW_byte_wide_ram[1].header_field_dist_ram_SPO_UNCONNECTED ),
        .WCLK(I1),
        .WE(load_wr));
(* BOX_TYPE = "PRIMITIVE" *) 
   RAM64X1D #(
    .INIT(64'h0000000000000000),
    .IS_WCLK_INVERTED(1'b0)) 
     \byte_wide_ram[2].header_field_dist_ram 
       (.A0(\n_0_load_count_pipe_reg[0] ),
        .A1(\n_0_load_count_pipe_reg[1] ),
        .A2(\n_0_load_count_pipe_reg[2] ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .A5(\<const0> ),
        .D(\n_0_load_wr_data_reg[2] ),
        .DPO(p_5_out),
        .DPRA0(counter_reg__0[0]),
        .DPRA1(counter_reg__0[1]),
        .DPRA2(counter_reg__0[2]),
        .DPRA3(counter_reg__0[3]),
        .DPRA4(counter_reg__0[4]),
        .DPRA5(counter_reg__0[5]),
        .SPO(\NLW_byte_wide_ram[2].header_field_dist_ram_SPO_UNCONNECTED ),
        .WCLK(I1),
        .WE(load_wr));
(* BOX_TYPE = "PRIMITIVE" *) 
   RAM64X1D #(
    .INIT(64'h0000000000000000),
    .IS_WCLK_INVERTED(1'b0)) 
     \byte_wide_ram[3].header_field_dist_ram 
       (.A0(\n_0_load_count_pipe_reg[0] ),
        .A1(\n_0_load_count_pipe_reg[1] ),
        .A2(\n_0_load_count_pipe_reg[2] ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .A5(\<const0> ),
        .D(\n_0_load_wr_data_reg[3] ),
        .DPO(p_4_out),
        .DPRA0(counter_reg__0[0]),
        .DPRA1(counter_reg__0[1]),
        .DPRA2(counter_reg__0[2]),
        .DPRA3(counter_reg__0[3]),
        .DPRA4(counter_reg__0[4]),
        .DPRA5(counter_reg__0[5]),
        .SPO(\NLW_byte_wide_ram[3].header_field_dist_ram_SPO_UNCONNECTED ),
        .WCLK(I1),
        .WE(load_wr));
(* BOX_TYPE = "PRIMITIVE" *) 
   RAM64X1D #(
    .INIT(64'h0000000000000000),
    .IS_WCLK_INVERTED(1'b0)) 
     \byte_wide_ram[4].header_field_dist_ram 
       (.A0(\n_0_load_count_pipe_reg[0] ),
        .A1(\n_0_load_count_pipe_reg[1] ),
        .A2(\n_0_load_count_pipe_reg[2] ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .A5(\<const0> ),
        .D(\n_0_load_wr_data_reg[4] ),
        .DPO(p_3_out),
        .DPRA0(counter_reg__0[0]),
        .DPRA1(counter_reg__0[1]),
        .DPRA2(counter_reg__0[2]),
        .DPRA3(counter_reg__0[3]),
        .DPRA4(counter_reg__0[4]),
        .DPRA5(counter_reg__0[5]),
        .SPO(\NLW_byte_wide_ram[4].header_field_dist_ram_SPO_UNCONNECTED ),
        .WCLK(I1),
        .WE(load_wr));
(* BOX_TYPE = "PRIMITIVE" *) 
   RAM64X1D #(
    .INIT(64'h0000000000000000),
    .IS_WCLK_INVERTED(1'b0)) 
     \byte_wide_ram[5].header_field_dist_ram 
       (.A0(\n_0_load_count_pipe_reg[0] ),
        .A1(\n_0_load_count_pipe_reg[1] ),
        .A2(\n_0_load_count_pipe_reg[2] ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .A5(\<const0> ),
        .D(\n_0_load_wr_data_reg[5] ),
        .DPO(p_2_out),
        .DPRA0(counter_reg__0[0]),
        .DPRA1(counter_reg__0[1]),
        .DPRA2(counter_reg__0[2]),
        .DPRA3(counter_reg__0[3]),
        .DPRA4(counter_reg__0[4]),
        .DPRA5(counter_reg__0[5]),
        .SPO(\NLW_byte_wide_ram[5].header_field_dist_ram_SPO_UNCONNECTED ),
        .WCLK(I1),
        .WE(load_wr));
(* BOX_TYPE = "PRIMITIVE" *) 
   RAM64X1D #(
    .INIT(64'h0000000000000000),
    .IS_WCLK_INVERTED(1'b0)) 
     \byte_wide_ram[6].header_field_dist_ram 
       (.A0(\n_0_load_count_pipe_reg[0] ),
        .A1(\n_0_load_count_pipe_reg[1] ),
        .A2(\n_0_load_count_pipe_reg[2] ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .A5(\<const0> ),
        .D(\n_0_load_wr_data_reg[6] ),
        .DPO(p_1_out),
        .DPRA0(counter_reg__0[0]),
        .DPRA1(counter_reg__0[1]),
        .DPRA2(counter_reg__0[2]),
        .DPRA3(counter_reg__0[3]),
        .DPRA4(counter_reg__0[4]),
        .DPRA5(counter_reg__0[5]),
        .SPO(\NLW_byte_wide_ram[6].header_field_dist_ram_SPO_UNCONNECTED ),
        .WCLK(I1),
        .WE(load_wr));
(* BOX_TYPE = "PRIMITIVE" *) 
   RAM64X1D #(
    .INIT(64'h0000000000000000),
    .IS_WCLK_INVERTED(1'b0)) 
     \byte_wide_ram[7].header_field_dist_ram 
       (.A0(\n_0_load_count_pipe_reg[0] ),
        .A1(\n_0_load_count_pipe_reg[1] ),
        .A2(\n_0_load_count_pipe_reg[2] ),
        .A3(\<const0> ),
        .A4(\<const0> ),
        .A5(\<const0> ),
        .D(\n_0_load_wr_data_reg[7] ),
        .DPO(p_0_out),
        .DPRA0(counter_reg__0[0]),
        .DPRA1(counter_reg__0[1]),
        .DPRA2(counter_reg__0[2]),
        .DPRA3(counter_reg__0[3]),
        .DPRA4(counter_reg__0[4]),
        .DPRA5(counter_reg__0[5]),
        .SPO(\NLW_byte_wide_ram[7].header_field_dist_ram_SPO_UNCONNECTED ),
        .WCLK(I1),
        .WE(load_wr));
(* RETAIN_INVERTER *) 
   (* SOFT_HLUTNM = "soft_lutpair69" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \counter[0]_i_1 
       (.I0(counter_reg__0[0]),
        .O(p_0_in__2[0]));
(* SOFT_HLUTNM = "soft_lutpair69" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \counter[1]_i_1 
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .O(p_0_in__2[1]));
(* SOFT_HLUTNM = "soft_lutpair67" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \counter[2]_i_1 
       (.I0(counter_reg__0[2]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[0]),
        .O(p_0_in__2[2]));
(* SOFT_HLUTNM = "soft_lutpair66" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \counter[3]_i_1 
       (.I0(counter_reg__0[3]),
        .I1(counter_reg__0[0]),
        .I2(counter_reg__0[1]),
        .I3(counter_reg__0[2]),
        .O(p_0_in__2[3]));
(* SOFT_HLUTNM = "soft_lutpair66" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \counter[4]_i_1 
       (.I0(counter_reg__0[4]),
        .I1(counter_reg__0[2]),
        .I2(counter_reg__0[1]),
        .I3(counter_reg__0[0]),
        .I4(counter_reg__0[3]),
        .O(p_0_in__2[4]));
LUT6 #(
    .INIT(64'h7FFF000000000000)) 
     \counter[5]_i_2 
       (.I0(counter_reg__0[4]),
        .I1(n_0_address_match_i_4),
        .I2(counter_reg__0[3]),
        .I3(counter_reg__0[5]),
        .I4(data_valid_early),
        .I5(I2),
        .O(\n_0_counter[5]_i_2 ));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \counter[5]_i_3 
       (.I0(counter_reg__0[5]),
        .I1(counter_reg__0[3]),
        .I2(counter_reg__0[0]),
        .I3(counter_reg__0[1]),
        .I4(counter_reg__0[2]),
        .I5(counter_reg__0[4]),
        .O(p_0_in__2[5]));
(* counter = "12" *) 
   FDRE \counter_reg[0] 
       (.C(I1),
        .CE(\n_0_counter[5]_i_2 ),
        .D(p_0_in__2[0]),
        .Q(counter_reg__0[0]),
        .R(I7));
(* counter = "12" *) 
   FDRE \counter_reg[1] 
       (.C(I1),
        .CE(\n_0_counter[5]_i_2 ),
        .D(p_0_in__2[1]),
        .Q(counter_reg__0[1]),
        .R(I7));
(* counter = "12" *) 
   FDRE \counter_reg[2] 
       (.C(I1),
        .CE(\n_0_counter[5]_i_2 ),
        .D(p_0_in__2[2]),
        .Q(counter_reg__0[2]),
        .R(I7));
(* counter = "12" *) 
   FDRE \counter_reg[3] 
       (.C(I1),
        .CE(\n_0_counter[5]_i_2 ),
        .D(p_0_in__2[3]),
        .Q(counter_reg__0[3]),
        .R(I7));
(* counter = "12" *) 
   FDRE \counter_reg[4] 
       (.C(I1),
        .CE(\n_0_counter[5]_i_2 ),
        .D(p_0_in__2[4]),
        .Q(counter_reg__0[4]),
        .R(I7));
(* counter = "12" *) 
   FDRE \counter_reg[5] 
       (.C(I1),
        .CE(\n_0_counter[5]_i_2 ),
        .D(p_0_in__2[5]),
        .Q(counter_reg__0[5]),
        .R(I7));
(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_name = "inst/\TriMAC_core/addr_filter_top/address_filter_inst/delay_rx_data_valid " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     delay_rx_data_valid
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(I2),
        .CLK(I1),
        .D(data_valid_early),
        .Q(rx_data_valid_srl16));
LUT3 #(
    .INIT(8'hD3)) 
     \load_count[0]_i_1 
       (.I0(load_count[1]),
        .I1(load_count[0]),
        .I2(load_count[2]),
        .O(\n_0_load_count[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair68" *) 
   LUT3 #(
    .INIT(8'hA6)) 
     \load_count[1]_i_1 
       (.I0(load_count[1]),
        .I1(load_count[0]),
        .I2(load_count[2]),
        .O(\n_0_load_count[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair68" *) 
   LUT3 #(
    .INIT(8'hF8)) 
     \load_count[2]_i_1 
       (.I0(load_count[1]),
        .I1(load_count[0]),
        .I2(load_count[2]),
        .O(\n_0_load_count[2]_i_1 ));
FDRE \load_count_pipe_reg[0] 
       (.C(I1),
        .CE(\<const1> ),
        .D(load_count[0]),
        .Q(\n_0_load_count_pipe_reg[0] ),
        .R(I6));
FDRE \load_count_pipe_reg[1] 
       (.C(I1),
        .CE(\<const1> ),
        .D(load_count[1]),
        .Q(\n_0_load_count_pipe_reg[1] ),
        .R(I6));
FDRE \load_count_pipe_reg[2] 
       (.C(I1),
        .CE(\<const1> ),
        .D(load_count[2]),
        .Q(\n_0_load_count_pipe_reg[2] ),
        .R(I6));
FDRE \load_count_reg[0] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_load_count[0]_i_1 ),
        .Q(load_count[0]),
        .R(I6));
FDRE \load_count_reg[1] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_load_count[1]_i_1 ),
        .Q(load_count[1]),
        .R(I6));
FDRE \load_count_reg[2] 
       (.C(I1),
        .CE(\<const1> ),
        .D(\n_0_load_count[2]_i_1 ),
        .Q(load_count[2]),
        .R(I6));
LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
     \load_wr_data[0]_i_2 
       (.I0(rx_configuration_vector[25]),
        .I1(rx_configuration_vector[17]),
        .I2(load_count[1]),
        .I3(rx_configuration_vector[9]),
        .I4(load_count[0]),
        .I5(rx_configuration_vector[1]),
        .O(\n_0_load_wr_data[0]_i_2 ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \load_wr_data[0]_i_3 
       (.I0(rx_configuration_vector[1]),
        .I1(load_count[1]),
        .I2(rx_configuration_vector[41]),
        .I3(load_count[0]),
        .I4(rx_configuration_vector[33]),
        .O(\n_0_load_wr_data[0]_i_3 ));
LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
     \load_wr_data[1]_i_2 
       (.I0(rx_configuration_vector[26]),
        .I1(rx_configuration_vector[18]),
        .I2(load_count[1]),
        .I3(rx_configuration_vector[10]),
        .I4(load_count[0]),
        .I5(rx_configuration_vector[2]),
        .O(\n_0_load_wr_data[1]_i_2 ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \load_wr_data[1]_i_3 
       (.I0(rx_configuration_vector[2]),
        .I1(load_count[1]),
        .I2(rx_configuration_vector[42]),
        .I3(load_count[0]),
        .I4(rx_configuration_vector[34]),
        .O(\n_0_load_wr_data[1]_i_3 ));
LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
     \load_wr_data[2]_i_2 
       (.I0(rx_configuration_vector[27]),
        .I1(rx_configuration_vector[19]),
        .I2(load_count[1]),
        .I3(rx_configuration_vector[11]),
        .I4(load_count[0]),
        .I5(rx_configuration_vector[3]),
        .O(\n_0_load_wr_data[2]_i_2 ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \load_wr_data[2]_i_3 
       (.I0(rx_configuration_vector[3]),
        .I1(load_count[1]),
        .I2(rx_configuration_vector[43]),
        .I3(load_count[0]),
        .I4(rx_configuration_vector[35]),
        .O(\n_0_load_wr_data[2]_i_3 ));
LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
     \load_wr_data[3]_i_2 
       (.I0(rx_configuration_vector[28]),
        .I1(rx_configuration_vector[20]),
        .I2(load_count[1]),
        .I3(rx_configuration_vector[12]),
        .I4(load_count[0]),
        .I5(rx_configuration_vector[4]),
        .O(\n_0_load_wr_data[3]_i_2 ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \load_wr_data[3]_i_3 
       (.I0(rx_configuration_vector[4]),
        .I1(load_count[1]),
        .I2(rx_configuration_vector[44]),
        .I3(load_count[0]),
        .I4(rx_configuration_vector[36]),
        .O(\n_0_load_wr_data[3]_i_3 ));
LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
     \load_wr_data[4]_i_2 
       (.I0(rx_configuration_vector[29]),
        .I1(rx_configuration_vector[21]),
        .I2(load_count[1]),
        .I3(rx_configuration_vector[13]),
        .I4(load_count[0]),
        .I5(rx_configuration_vector[5]),
        .O(\n_0_load_wr_data[4]_i_2 ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \load_wr_data[4]_i_3 
       (.I0(rx_configuration_vector[5]),
        .I1(load_count[1]),
        .I2(rx_configuration_vector[45]),
        .I3(load_count[0]),
        .I4(rx_configuration_vector[37]),
        .O(\n_0_load_wr_data[4]_i_3 ));
LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
     \load_wr_data[5]_i_2 
       (.I0(rx_configuration_vector[30]),
        .I1(rx_configuration_vector[22]),
        .I2(load_count[1]),
        .I3(rx_configuration_vector[14]),
        .I4(load_count[0]),
        .I5(rx_configuration_vector[6]),
        .O(\n_0_load_wr_data[5]_i_2 ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \load_wr_data[5]_i_3 
       (.I0(rx_configuration_vector[6]),
        .I1(load_count[1]),
        .I2(rx_configuration_vector[46]),
        .I3(load_count[0]),
        .I4(rx_configuration_vector[38]),
        .O(\n_0_load_wr_data[5]_i_3 ));
LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
     \load_wr_data[6]_i_2 
       (.I0(rx_configuration_vector[31]),
        .I1(rx_configuration_vector[23]),
        .I2(load_count[1]),
        .I3(rx_configuration_vector[15]),
        .I4(load_count[0]),
        .I5(rx_configuration_vector[7]),
        .O(\n_0_load_wr_data[6]_i_2 ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \load_wr_data[6]_i_3 
       (.I0(rx_configuration_vector[7]),
        .I1(load_count[1]),
        .I2(rx_configuration_vector[47]),
        .I3(load_count[0]),
        .I4(rx_configuration_vector[39]),
        .O(\n_0_load_wr_data[6]_i_3 ));
LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
     \load_wr_data[7]_i_2 
       (.I0(rx_configuration_vector[32]),
        .I1(rx_configuration_vector[24]),
        .I2(load_count[1]),
        .I3(rx_configuration_vector[16]),
        .I4(load_count[0]),
        .I5(rx_configuration_vector[8]),
        .O(\n_0_load_wr_data[7]_i_2 ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \load_wr_data[7]_i_3 
       (.I0(rx_configuration_vector[8]),
        .I1(load_count[1]),
        .I2(rx_configuration_vector[48]),
        .I3(load_count[0]),
        .I4(rx_configuration_vector[40]),
        .O(\n_0_load_wr_data[7]_i_3 ));
FDRE \load_wr_data_reg[0] 
       (.C(I1),
        .CE(\<const1> ),
        .D(load_wr_data[0]),
        .Q(\n_0_load_wr_data_reg[0] ),
        .R(\<const0> ));
MUXF7 \load_wr_data_reg[0]_i_1 
       (.I0(\n_0_load_wr_data[0]_i_2 ),
        .I1(\n_0_load_wr_data[0]_i_3 ),
        .O(load_wr_data[0]),
        .S(load_count[2]));
FDRE \load_wr_data_reg[1] 
       (.C(I1),
        .CE(\<const1> ),
        .D(load_wr_data[1]),
        .Q(\n_0_load_wr_data_reg[1] ),
        .R(\<const0> ));
MUXF7 \load_wr_data_reg[1]_i_1 
       (.I0(\n_0_load_wr_data[1]_i_2 ),
        .I1(\n_0_load_wr_data[1]_i_3 ),
        .O(load_wr_data[1]),
        .S(load_count[2]));
FDRE \load_wr_data_reg[2] 
       (.C(I1),
        .CE(\<const1> ),
        .D(load_wr_data[2]),
        .Q(\n_0_load_wr_data_reg[2] ),
        .R(\<const0> ));
MUXF7 \load_wr_data_reg[2]_i_1 
       (.I0(\n_0_load_wr_data[2]_i_2 ),
        .I1(\n_0_load_wr_data[2]_i_3 ),
        .O(load_wr_data[2]),
        .S(load_count[2]));
FDRE \load_wr_data_reg[3] 
       (.C(I1),
        .CE(\<const1> ),
        .D(load_wr_data[3]),
        .Q(\n_0_load_wr_data_reg[3] ),
        .R(\<const0> ));
MUXF7 \load_wr_data_reg[3]_i_1 
       (.I0(\n_0_load_wr_data[3]_i_2 ),
        .I1(\n_0_load_wr_data[3]_i_3 ),
        .O(load_wr_data[3]),
        .S(load_count[2]));
FDRE \load_wr_data_reg[4] 
       (.C(I1),
        .CE(\<const1> ),
        .D(load_wr_data[4]),
        .Q(\n_0_load_wr_data_reg[4] ),
        .R(\<const0> ));
MUXF7 \load_wr_data_reg[4]_i_1 
       (.I0(\n_0_load_wr_data[4]_i_2 ),
        .I1(\n_0_load_wr_data[4]_i_3 ),
        .O(load_wr_data[4]),
        .S(load_count[2]));
FDRE \load_wr_data_reg[5] 
       (.C(I1),
        .CE(\<const1> ),
        .D(load_wr_data[5]),
        .Q(\n_0_load_wr_data_reg[5] ),
        .R(\<const0> ));
MUXF7 \load_wr_data_reg[5]_i_1 
       (.I0(\n_0_load_wr_data[5]_i_2 ),
        .I1(\n_0_load_wr_data[5]_i_3 ),
        .O(load_wr_data[5]),
        .S(load_count[2]));
FDRE \load_wr_data_reg[6] 
       (.C(I1),
        .CE(\<const1> ),
        .D(load_wr_data[6]),
        .Q(\n_0_load_wr_data_reg[6] ),
        .R(\<const0> ));
MUXF7 \load_wr_data_reg[6]_i_1 
       (.I0(\n_0_load_wr_data[6]_i_2 ),
        .I1(\n_0_load_wr_data[6]_i_3 ),
        .O(load_wr_data[6]),
        .S(load_count[2]));
FDRE \load_wr_data_reg[7] 
       (.C(I1),
        .CE(\<const1> ),
        .D(load_wr_data[7]),
        .Q(\n_0_load_wr_data_reg[7] ),
        .R(\<const0> ));
MUXF7 \load_wr_data_reg[7]_i_1 
       (.I0(\n_0_load_wr_data[7]_i_2 ),
        .I1(\n_0_load_wr_data[7]_i_3 ),
        .O(load_wr_data[7]),
        .S(load_count[2]));
FDRE load_wr_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_1_sync_update),
        .Q(load_wr),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h0F000F0F02000000)) 
     pause_match_i_1
       (.I0(O6),
        .I1(rx_data_valid_reg2),
        .I2(SR),
        .I3(pause_match_reg__0),
        .I4(I2),
        .I5(n_0_pause_match_reg),
        .O(n_0_pause_match_i_1));
FDRE pause_match_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_pause_match_i_1),
        .Q(n_0_pause_match_reg),
        .R(\<const0> ));
FDRE pause_match_reg_reg
       (.C(I1),
        .CE(I2),
        .D(pause_match_reg0),
        .Q(pause_match_reg__0),
        .R(SR));
FDRE pauseaddressmatch_int_reg
       (.C(I1),
        .CE(broadcastaddressmatch_int_0),
        .D(n_0_pause_match_reg),
        .Q(pauseaddressmatch_int),
        .R(n_0_address_match_i_1));
FDRE pauseaddressmatch_reg
       (.C(I1),
        .CE(I2),
        .D(pauseaddressmatch_int),
        .Q(pauseaddressmatch),
        .R(SR));
FDRE promiscuous_mode_sample_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_resync_promiscuous_mode),
        .Q(address_match1),
        .R(\<const0> ));
TriMACtri_mode_ethernet_mac_v8_1_sync_block_11 resync_promiscuous_mode
       (.I1(O6),
        .I2(I2),
        .I3(I1),
        .O1(n_0_resync_promiscuous_mode),
        .SR(SR),
        .address_match1(address_match1),
        .rx_configuration_vector(rx_configuration_vector[0]),
        .rx_data_valid_reg2(rx_data_valid_reg2));
FDRE rx_data_valid_reg1_reg
       (.C(I1),
        .CE(I2),
        .D(data_valid_early),
        .Q(O6),
        .R(SR));
FDRE rx_data_valid_reg2_reg
       (.C(I1),
        .CE(I2),
        .D(O6),
        .Q(rx_data_valid_reg2),
        .R(SR));
FDRE rx_data_valid_srl16_reg1_reg
       (.C(I1),
        .CE(I2),
        .D(rx_data_valid_srl16),
        .Q(rx_data_valid_srl16_reg1),
        .R(SR));
FDRE rx_data_valid_srl16_reg2_reg
       (.C(I1),
        .CE(I2),
        .D(rx_data_valid_srl16_reg1),
        .Q(rx_data_valid_srl16_reg2),
        .R(SR));
FDRE \rx_filter_match_reg[0] 
       (.C(I1),
        .CE(\<const1> ),
        .D(address_match1),
        .Q(rx_filter_match_comb2),
        .R(\<const0> ));
LUT3 #(
    .INIT(8'hA8)) 
     rx_filtered_data_valid_i_1
       (.I0(rx_data_valid_srl16_reg2),
        .I1(n_0_address_match_reg),
        .I2(address_match1),
        .O(rx_filtered_data_valid0));
FDRE rx_filtered_data_valid_reg
       (.C(I1),
        .CE(I2),
        .D(rx_filtered_data_valid0),
        .Q(address_valid_early),
        .R(SR));
LUT3 #(
    .INIT(8'h02)) 
     rx_ptp_match_i_1
       (.I0(rx_ptp_match),
        .I1(I2),
        .I2(SR),
        .O(n_0_rx_ptp_match_i_1));
FDRE rx_ptp_match_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_rx_ptp_match_i_1),
        .Q(rx_ptp_match),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h00000000EEAA0EAA)) 
     rxstatsaddressmatch_i_1
       (.I0(rxstatsaddressmatch),
        .I1(address_valid_early),
        .I2(rx_data_valid_srl16),
        .I3(I2),
        .I4(rx_data_valid_srl16_reg1),
        .I5(SR),
        .O(n_0_rxstatsaddressmatch_i_1));
FDRE rxstatsaddressmatch_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_rxstatsaddressmatch_i_1),
        .Q(rxstatsaddressmatch),
        .R(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT3 #(
    .INIT(8'h21)) 
     \special_pause_address[0].LUT3_special_pause_inst 
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[2]),
        .O(O1));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT3 #(
    .INIT(8'h04)) 
     \special_pause_address[1].LUT3_special_pause_inst 
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[2]),
        .O(p_9_out));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT3 #(
    .INIT(8'h00)) 
     \special_pause_address[2].LUT3_special_pause_inst 
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[2]),
        .O(p_8_out));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT3 #(
    .INIT(8'h00)) 
     \special_pause_address[3].LUT3_special_pause_inst 
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[2]),
        .O(p_7_out));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT3 #(
    .INIT(8'h00)) 
     \special_pause_address[4].LUT3_special_pause_inst 
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[2]),
        .O(O2));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT3 #(
    .INIT(8'h00)) 
     \special_pause_address[5].LUT3_special_pause_inst 
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[2]),
        .O(O3));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT3 #(
    .INIT(8'h04)) 
     \special_pause_address[6].LUT3_special_pause_inst 
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[2]),
        .O(O4));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT3 #(
    .INIT(8'h06)) 
     \special_pause_address[7].LUT3_special_pause_inst 
       (.I0(counter_reg__0[0]),
        .I1(counter_reg__0[1]),
        .I2(counter_reg__0[2]),
        .O(O5));
LUT6 #(
    .INIT(64'h0F000F0F02000000)) 
     special_pause_match_i_1
       (.I0(O6),
        .I1(rx_data_valid_reg2),
        .I2(SR),
        .I3(special_pause_match_reg__0),
        .I4(I2),
        .I5(n_0_special_pause_match_reg),
        .O(n_0_special_pause_match_i_1));
FDRE special_pause_match_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_special_pause_match_i_1),
        .Q(n_0_special_pause_match_reg),
        .R(\<const0> ));
FDRE special_pause_match_reg_reg
       (.C(I1),
        .CE(I2),
        .D(special_pause_match_comb),
        .Q(special_pause_match_reg__0),
        .R(SR));
FDRE specialpauseaddressmatch_int_reg
       (.C(I1),
        .CE(broadcastaddressmatch_int_0),
        .D(n_0_special_pause_match_reg),
        .Q(specialpauseaddressmatch_int),
        .R(n_0_address_match_i_1));
FDRE specialpauseaddressmatch_reg
       (.C(I1),
        .CE(I2),
        .D(specialpauseaddressmatch_int),
        .Q(specialpauseaddressmatch),
        .R(SR));
TriMACtri_mode_ethernet_mac_v8_1_sync_block_12 sync_update
       (.I1(I1),
        .I4(I4),
        .I5(I5),
        .O1(n_1_sync_update),
        .O2(n_2_sync_update),
        .Q({\n_0_load_count_pipe_reg[2] ,\n_0_load_count_pipe_reg[1] ,\n_0_load_count_pipe_reg[0] }),
        .SR(SR),
        .data_out(data_out),
        .update_pause_ad_sync_reg(update_pause_ad_sync_reg));
FDRE update_pause_ad_sync_reg_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_2_sync_update),
        .Q(update_pause_ad_sync_reg),
        .R(\<const0> ));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_addr_filter_wrap
   (p_10_out,
    p_6_out,
    p_5_out,
    p_4_out,
    p_3_out,
    p_2_out,
    p_1_out,
    p_0_out,
    O1,
    p_9_out,
    p_8_out,
    p_7_out,
    O2,
    O3,
    O4,
    O5,
    rx_data_valid_reg1,
    address_valid_early,
    pauseaddressmatch,
    broadcastaddressmatch,
    specialpauseaddressmatch,
    broadcast_byte_match,
    update_pause_ad_sync_reg,
    data_out,
    MATCH_FRAME_INT0,
    rxstatsaddressmatch,
    I2,
    data_valid_early,
    I1,
    SR,
    pause_match_reg0,
    special_pause_match_comb,
    I3,
    I4,
    I5,
    rx_configuration_vector,
    I6,
    I7);
  output p_10_out;
  output p_6_out;
  output p_5_out;
  output p_4_out;
  output p_3_out;
  output p_2_out;
  output p_1_out;
  output p_0_out;
  output O1;
  output p_9_out;
  output p_8_out;
  output p_7_out;
  output O2;
  output O3;
  output O4;
  output O5;
  output rx_data_valid_reg1;
  output address_valid_early;
  output pauseaddressmatch;
  output broadcastaddressmatch;
  output specialpauseaddressmatch;
  output broadcast_byte_match;
  output update_pause_ad_sync_reg;
  output data_out;
  output MATCH_FRAME_INT0;
  output rxstatsaddressmatch;
  input I2;
  input data_valid_early;
  input I1;
  input [0:0]SR;
  input pause_match_reg0;
  input special_pause_match_comb;
  input I3;
  input I4;
  input I5;
  input [48:0]rx_configuration_vector;
  input I6;
  input [0:0]I7;

  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire [0:0]I7;
  wire MATCH_FRAME_INT0;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire O5;
  wire [0:0]SR;
  wire address_valid_early;
  wire broadcast_byte_match;
  wire broadcastaddressmatch;
  wire data_out;
  wire data_valid_early;
  wire p_0_out;
  wire p_10_out;
  wire p_1_out;
  wire p_2_out;
  wire p_3_out;
  wire p_4_out;
  wire p_5_out;
  wire p_6_out;
  wire p_7_out;
  wire p_8_out;
  wire p_9_out;
  wire pause_match_reg0;
  wire pauseaddressmatch;
  wire [48:0]rx_configuration_vector;
  wire rx_data_valid_reg1;
  wire rxstatsaddressmatch;
  wire special_pause_match_comb;
  wire specialpauseaddressmatch;
  wire update_pause_ad_sync_reg;

TriMACtri_mode_ethernet_mac_v8_1_addr_filter address_filter_inst
       (.I1(I1),
        .I2(I2),
        .I3(I3),
        .I4(I4),
        .I5(I5),
        .I6(I6),
        .I7(I7),
        .MATCH_FRAME_INT0(MATCH_FRAME_INT0),
        .O1(O1),
        .O2(O2),
        .O3(O3),
        .O4(O4),
        .O5(O5),
        .O6(rx_data_valid_reg1),
        .SR(SR),
        .address_valid_early(address_valid_early),
        .broadcast_byte_match(broadcast_byte_match),
        .broadcastaddressmatch(broadcastaddressmatch),
        .data_out(data_out),
        .data_valid_early(data_valid_early),
        .p_0_out(p_0_out),
        .p_10_out(p_10_out),
        .p_1_out(p_1_out),
        .p_2_out(p_2_out),
        .p_3_out(p_3_out),
        .p_4_out(p_4_out),
        .p_5_out(p_5_out),
        .p_6_out(p_6_out),
        .p_7_out(p_7_out),
        .p_8_out(p_8_out),
        .p_9_out(p_9_out),
        .pause_match_reg0(pause_match_reg0),
        .pauseaddressmatch(pauseaddressmatch),
        .rx_configuration_vector(rx_configuration_vector),
        .rxstatsaddressmatch(rxstatsaddressmatch),
        .special_pause_match_comb(special_pause_match_comb),
        .specialpauseaddressmatch(specialpauseaddressmatch),
        .update_pause_ad_sync_reg(update_pause_ad_sync_reg));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_control
   (data_avail_in_reg,
    rx_enable_reg,
    tx_underrun_int_0,
    load_source,
    sample,
    tx_ack_int,
    O1,
    Q,
    rx_statistics_vector,
    O2,
    O3,
    O4,
    O5,
    O6,
    O7,
    O8,
    O9,
    int_tx_data_valid_out,
    O10,
    int_tx_crc_enable_out,
    int_tx_vlan_enable_out,
    rx_mac_tuser0,
    rx_mac_tlast0,
    next_rx_state,
    I11,
    rx_mac_tvalid0,
    O11,
    O12,
    O13,
    tx_statistics_vector,
    I1,
    tx_ce_sample,
    tx_data_valid_int,
    gtx_clk,
    int_tx_ack_in,
    SR,
    I2,
    I3,
    rx_bad_frame_comb,
    int_rx_data_valid_in,
    tx_underrun_int,
    I4,
    int_rx_control_frame,
    int_rx_good_frame_in,
    I5,
    I6,
    REG_DATA_VALID,
    I7,
    INT_ENABLE,
    I8,
    I9,
    MAX_PKT_LEN_REACHED,
    pause_req,
    tx_configuration_vector,
    rx_state,
    pause_val,
    bad_pfc_opcode_int,
    I10,
    I12,
    I13,
    rx_configuration_vector,
    int_rx_bad_frame_in,
    I14,
    I15,
    D,
    E,
    tx_statistics_valid,
    I16,
    I17,
    I18);
  output data_avail_in_reg;
  output rx_enable_reg;
  output tx_underrun_int_0;
  output load_source;
  output sample;
  output tx_ack_int;
  output O1;
  output [0:0]Q;
  output [0:0]rx_statistics_vector;
  output O2;
  output O3;
  output O4;
  output O5;
  output O6;
  output O7;
  output O8;
  output O9;
  output int_tx_data_valid_out;
  output O10;
  output int_tx_crc_enable_out;
  output int_tx_vlan_enable_out;
  output rx_mac_tuser0;
  output rx_mac_tlast0;
  output [1:0]next_rx_state;
  output [7:0]I11;
  output rx_mac_tvalid0;
  output O11;
  output O12;
  output [7:0]O13;
  output [0:0]tx_statistics_vector;
  input I1;
  input tx_ce_sample;
  input tx_data_valid_int;
  input gtx_clk;
  input int_tx_ack_in;
  input [0:0]SR;
  input I2;
  input I3;
  input rx_bad_frame_comb;
  input int_rx_data_valid_in;
  input tx_underrun_int;
  input I4;
  input int_rx_control_frame;
  input int_rx_good_frame_in;
  input I5;
  input I6;
  input REG_DATA_VALID;
  input I7;
  input INT_ENABLE;
  input I8;
  input I9;
  input MAX_PKT_LEN_REACHED;
  input pause_req;
  input [50:0]tx_configuration_vector;
  input [1:0]rx_state;
  input [15:0]pause_val;
  input bad_pfc_opcode_int;
  input I10;
  input I12;
  input [7:0]I13;
  input [0:0]rx_configuration_vector;
  input int_rx_bad_frame_in;
  input [0:0]I14;
  input I15;
  input [7:0]D;
  input [0:0]E;
  input tx_statistics_valid;
  input I16;
  input I17;
  input I18;

  wire \<const0> ;
  wire \<const1> ;
  wire [7:0]D;
  wire [0:0]E;
  wire I1;
  wire I10;
  wire [7:0]I11;
  wire I12;
  wire [7:0]I13;
  wire [0:0]I14;
  wire I15;
  wire I16;
  wire I17;
  wire I18;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire INT_ENABLE;
  wire MAX_PKT_LEN_REACHED;
  wire O1;
  wire O10;
  wire O11;
  wire O12;
  wire [7:0]O13;
  wire O2;
  wire O3;
  wire O4;
  wire O5;
  wire O6;
  wire O7;
  wire O8;
  wire O9;
  wire [0:0]Q;
  wire REG_DATA_VALID;
  wire [0:0]SR;
  wire bad_pfc_opcode_int;
  wire control_complete;
  wire data_avail_in_reg;
  wire gtx_clk;
  wire int_rx_bad_frame_in;
  wire int_rx_control_frame;
  wire int_rx_data_valid_in;
  wire int_rx_good_frame_in;
  wire int_tx_ack_in;
  wire int_tx_crc_enable_out;
  wire int_tx_data_valid_out;
  wire int_tx_vlan_enable_out;
  wire load_source;
  wire n_0_sync_rx_enable;
  wire n_0_sync_tx_enable;
  wire n_10_pfc_tx;
  wire n_10_rx;
  wire n_11_pfc_tx;
  wire n_11_rx;
  wire n_12_pfc_tx;
  wire n_12_rx;
  wire n_13_pfc_tx;
  wire n_13_rx;
  wire n_14_pfc_tx;
  wire n_14_rx;
  wire n_15_pfc_tx;
  wire n_15_rx;
  wire n_16_pfc_tx;
  wire n_16_rx;
  wire n_16_tx;
  wire n_17_pfc_tx;
  wire n_17_rx;
  wire n_18_rx;
  wire n_19_rx;
  wire n_1_rx_pause;
  wire n_20_rx;
  wire n_21_rx;
  wire n_22_rx;
  wire n_27_tx;
  wire n_2_pfc_tx;
  wire n_3_pfc_tx;
  wire n_4_pfc_tx;
  wire n_5_pfc_tx;
  wire n_6_pfc_tx;
  wire n_7_pfc_tx;
  wire n_7_rx;
  wire n_8_pfc_tx;
  wire n_8_rx;
  wire n_9_pfc_tx;
  wire n_9_rx;
  wire [1:0]next_rx_state;
  wire pause_req;
  wire pause_req_int0;
  wire pause_req_to_tx;
  wire pause_status_int;
  wire pause_status_req;
  wire [15:0]pause_val;
  wire [15:0]pause_value_to_tx;
  wire pfc_pause_req_out;
  wire pfc_req;
  wire pfc_rx_enable_sync;
  wire pfc_tx_enable_sync;
  wire rx_bad_frame;
  wire rx_bad_frame_comb;
  wire [0:0]rx_configuration_vector;
  wire rx_data_valid;
  wire rx_enable_reg;
  wire rx_good_frame;
  wire rx_good_frame_comb;
  wire rx_half_duplex_sync;
  wire rx_mac_tlast0;
  wire rx_mac_tuser0;
  wire rx_mac_tvalid0;
  wire [1:0]rx_state;
  wire [0:0]rx_statistics_vector;
  wire sample;
  wire tx_ack_int;
  wire tx_ce_sample;
  wire [50:0]tx_configuration_vector;
  wire [7:0]tx_data_int;
  wire tx_data_valid_int;
  wire tx_enable_reg;
  wire tx_half_duplex_sync;
  wire tx_statistics_valid;
  wire [0:0]tx_statistics_vector;
  wire tx_status;
  wire tx_underrun_int;
  wire tx_underrun_int_0;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
FDRE pause_vector_tx_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_27_tx),
        .Q(tx_statistics_vector),
        .R(\<const0> ));
TriMACtri_mode_ethernet_mac_v8_1_pfc_tx_cntl pfc_tx
       (.E(n_16_tx),
        .I1(sample),
        .I2(I1),
        .O1(n_2_pfc_tx),
        .O2(n_3_pfc_tx),
        .O3(n_4_pfc_tx),
        .O4(n_5_pfc_tx),
        .O5(n_6_pfc_tx),
        .O6(n_7_pfc_tx),
        .O7(n_8_pfc_tx),
        .O8(n_9_pfc_tx),
        .Q({n_10_pfc_tx,n_11_pfc_tx,n_12_pfc_tx,n_13_pfc_tx,n_14_pfc_tx,n_15_pfc_tx,n_16_pfc_tx,n_17_pfc_tx}),
        .control_complete(control_complete),
        .gtx_clk(gtx_clk),
        .pause_req(pause_req),
        .pause_req_int0(pause_req_int0),
        .pause_val(pause_val),
        .pfc_pause_req_out(pfc_pause_req_out),
        .pfc_req(pfc_req),
        .pfc_tx_enable_sync(pfc_tx_enable_sync),
        .tx_enable_reg(tx_enable_reg));
TriMACtri_mode_ethernet_mac_v8_1_rx_cntl rx
       (.D({n_7_rx,n_8_rx,n_9_rx,n_10_rx,n_11_rx,n_12_rx,n_13_rx,n_14_rx,n_15_rx,n_16_rx,n_17_rx,n_18_rx,n_19_rx,n_20_rx,n_21_rx,n_22_rx}),
        .I1(rx_enable_reg),
        .I12(I12),
        .I13(I13),
        .I14(I14),
        .I18(I18),
        .I2(I2),
        .I3(I3),
        .O1(O3),
        .O2(O2),
        .O3(O4),
        .O5(O5),
        .Q(Q),
        .SR(SR),
        .bad_pfc_opcode_int(bad_pfc_opcode_int),
        .data_out(pfc_rx_enable_sync),
        .int_rx_bad_frame_in(int_rx_bad_frame_in),
        .int_rx_control_frame(int_rx_control_frame),
        .int_rx_data_valid_in(int_rx_data_valid_in),
        .int_rx_good_frame_in(int_rx_good_frame_in),
        .rx_good_frame_comb(rx_good_frame_comb),
        .rx_statistics_vector(rx_statistics_vector));
FDRE rx_bad_frame_int_reg
       (.C(I3),
        .CE(I2),
        .D(rx_bad_frame_comb),
        .Q(rx_bad_frame),
        .R(SR));
FDRE \rx_data_int_reg[0] 
       (.C(I3),
        .CE(I2),
        .D(I13[0]),
        .Q(O13[0]),
        .R(SR));
FDRE \rx_data_int_reg[1] 
       (.C(I3),
        .CE(I2),
        .D(I13[1]),
        .Q(O13[1]),
        .R(SR));
FDRE \rx_data_int_reg[2] 
       (.C(I3),
        .CE(I2),
        .D(I13[2]),
        .Q(O13[2]),
        .R(SR));
FDRE \rx_data_int_reg[3] 
       (.C(I3),
        .CE(I2),
        .D(I13[3]),
        .Q(O13[3]),
        .R(SR));
FDRE \rx_data_int_reg[4] 
       (.C(I3),
        .CE(I2),
        .D(I13[4]),
        .Q(O13[4]),
        .R(SR));
FDRE \rx_data_int_reg[5] 
       (.C(I3),
        .CE(I2),
        .D(I13[5]),
        .Q(O13[5]),
        .R(SR));
FDRE \rx_data_int_reg[6] 
       (.C(I3),
        .CE(I2),
        .D(I13[6]),
        .Q(O13[6]),
        .R(SR));
FDRE \rx_data_int_reg[7] 
       (.C(I3),
        .CE(I2),
        .D(I13[7]),
        .Q(O13[7]),
        .R(SR));
FDRE rx_data_valid_int_reg
       (.C(I3),
        .CE(I2),
        .D(int_rx_data_valid_in),
        .Q(rx_data_valid),
        .R(SR));
FDRE rx_enable_reg_reg
       (.C(I3),
        .CE(I2),
        .D(n_0_sync_rx_enable),
        .Q(rx_enable_reg),
        .R(SR));
FDRE rx_good_frame_int_reg
       (.C(I3),
        .CE(I2),
        .D(rx_good_frame_comb),
        .Q(rx_good_frame),
        .R(SR));
LUT6 #(
    .INIT(64'h4440888844408880)) 
     rx_mac_tlast_i_1
       (.I0(rx_state[1]),
        .I1(I2),
        .I2(rx_good_frame),
        .I3(rx_bad_frame),
        .I4(rx_state[0]),
        .I5(rx_data_valid),
        .O(rx_mac_tlast0));
LUT6 #(
    .INIT(64'h000000003200C000)) 
     rx_mac_tuser_i_1
       (.I0(rx_data_valid),
        .I1(rx_state[0]),
        .I2(rx_bad_frame),
        .I3(I2),
        .I4(rx_state[1]),
        .I5(rx_good_frame),
        .O(rx_mac_tuser0));
LUT6 #(
    .INIT(64'h00FEFE0000000000)) 
     rx_mac_tvalid_i_1
       (.I0(rx_good_frame),
        .I1(rx_bad_frame),
        .I2(rx_data_valid),
        .I3(rx_state[1]),
        .I4(rx_state[0]),
        .I5(I2),
        .O(rx_mac_tvalid0));
TriMACtri_mode_ethernet_mac_v8_1_rx_sync_req rx_pause
       (.D({n_7_rx,n_8_rx,n_9_rx,n_10_rx,n_11_rx,n_12_rx,n_13_rx,n_14_rx,n_15_rx,n_16_rx,n_17_rx,n_18_rx,n_19_rx,n_20_rx,n_21_rx,n_22_rx}),
        .E(E),
        .I2(I2),
        .I3(I3),
        .O1(n_1_rx_pause),
        .Q(pause_value_to_tx),
        .SR(SR),
        .data_in(pause_req_to_tx),
        .rx_statistics_vector(rx_statistics_vector));
(* SOFT_HLUTNM = "soft_lutpair176" *) 
   LUT5 #(
    .INIT(32'h00FEFEF0)) 
     \rx_state[0]_i_1 
       (.I0(rx_good_frame),
        .I1(rx_bad_frame),
        .I2(rx_data_valid),
        .I3(rx_state[1]),
        .I4(rx_state[0]),
        .O(next_rx_state[0]));
(* SOFT_HLUTNM = "soft_lutpair176" *) 
   LUT5 #(
    .INIT(32'h66606666)) 
     \rx_state[1]_i_1 
       (.I0(rx_state[0]),
        .I1(rx_state[1]),
        .I2(rx_bad_frame),
        .I3(rx_good_frame),
        .I4(rx_data_valid),
        .O(next_rx_state[1]));
TriMACtri_mode_ethernet_mac_v8_1_sync_block_4 sync_rx_duplex
       (.I3(I3),
        .data_out(rx_half_duplex_sync));
TriMACtri_mode_ethernet_mac_v8_1_sync_block_5 sync_rx_enable
       (.I3(I3),
        .O1(n_0_sync_rx_enable),
        .rx_configuration_vector(rx_configuration_vector),
        .rx_half_duplex_sync(rx_half_duplex_sync));
TriMACtri_mode_ethernet_mac_v8_1_sync_block_3 sync_rx_pfc_en
       (.I3(I3),
        .data_out(pfc_rx_enable_sync));
TriMACtri_mode_ethernet_mac_v8_1_sync_block_2 sync_tx_duplex
       (.data_out(tx_half_duplex_sync),
        .gtx_clk(gtx_clk));
TriMACtri_mode_ethernet_mac_v8_1_sync_block_1 sync_tx_enable
       (.O1(n_0_sync_tx_enable),
        .data_out(tx_half_duplex_sync),
        .gtx_clk(gtx_clk),
        .tx_configuration_vector(tx_configuration_vector[2]));
TriMACtri_mode_ethernet_mac_v8_1_sync_block sync_tx_pfc_en
       (.data_out(pfc_tx_enable_sync),
        .gtx_clk(gtx_clk));
TriMACtri_mode_ethernet_mac_v8_1_tx_cntl tx
       (.E(n_16_tx),
        .I1(I1),
        .I10(I10),
        .I11(I11),
        .I12(n_3_pfc_tx),
        .I13(n_4_pfc_tx),
        .I14(n_5_pfc_tx),
        .I15(I15),
        .I16(I16),
        .I17(I17),
        .I18(n_6_pfc_tx),
        .I19(n_7_pfc_tx),
        .I2({n_10_pfc_tx,n_11_pfc_tx,n_12_pfc_tx,n_13_pfc_tx,n_14_pfc_tx,n_15_pfc_tx,n_16_pfc_tx,n_17_pfc_tx}),
        .I20(n_8_pfc_tx),
        .I21(n_9_pfc_tx),
        .I3(n_2_pfc_tx),
        .I4(I4),
        .I5(I5),
        .I6(I6),
        .I7(I7),
        .I8(I8),
        .I9(I9),
        .INT_ENABLE(INT_ENABLE),
        .MAX_PKT_LEN_REACHED(MAX_PKT_LEN_REACHED),
        .O1(data_avail_in_reg),
        .O10(n_27_tx),
        .O11(O11),
        .O12(O12),
        .O2(load_source),
        .O3(sample),
        .O4(O1),
        .O5(O6),
        .O6(O7),
        .O7(O10),
        .O8(O8),
        .O9(O9),
        .Q(tx_data_int),
        .REG_DATA_VALID(REG_DATA_VALID),
        .control_complete(control_complete),
        .data_out(pfc_tx_enable_sync),
        .gtx_clk(gtx_clk),
        .int_tx_ack_in(int_tx_ack_in),
        .int_tx_crc_enable_out(int_tx_crc_enable_out),
        .int_tx_data_valid_out(int_tx_data_valid_out),
        .int_tx_vlan_enable_out(int_tx_vlan_enable_out),
        .pause_req(pause_req),
        .pause_req_int0(pause_req_int0),
        .pause_status_int(pause_status_int),
        .pause_status_req(pause_status_req),
        .pfc_pause_req_out(pfc_pause_req_out),
        .pfc_req(pfc_req),
        .tx_ack_int(tx_ack_int),
        .tx_ce_sample(tx_ce_sample),
        .tx_configuration_vector({tx_configuration_vector[50:3],tx_configuration_vector[1:0]}),
        .tx_data_valid_int(tx_data_valid_int),
        .tx_statistics_valid(tx_statistics_valid),
        .tx_statistics_vector(tx_statistics_vector),
        .tx_status(tx_status));
FDRE \tx_data_int_reg[0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(D[0]),
        .Q(tx_data_int[0]),
        .R(I1));
FDRE \tx_data_int_reg[1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(D[1]),
        .Q(tx_data_int[1]),
        .R(I1));
FDRE \tx_data_int_reg[2] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(D[2]),
        .Q(tx_data_int[2]),
        .R(I1));
FDRE \tx_data_int_reg[3] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(D[3]),
        .Q(tx_data_int[3]),
        .R(I1));
FDRE \tx_data_int_reg[4] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(D[4]),
        .Q(tx_data_int[4]),
        .R(I1));
FDRE \tx_data_int_reg[5] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(D[5]),
        .Q(tx_data_int[5]),
        .R(I1));
FDRE \tx_data_int_reg[6] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(D[6]),
        .Q(tx_data_int[6]),
        .R(I1));
FDRE \tx_data_int_reg[7] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(D[7]),
        .Q(tx_data_int[7]),
        .R(I1));
FDRE tx_enable_reg_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(n_0_sync_tx_enable),
        .Q(tx_enable_reg),
        .R(I1));
TriMACtri_mode_ethernet_mac_v8_1_tx_pause tx_pause
       (.I1(I1),
        .I2(n_1_rx_pause),
        .Q(pause_value_to_tx),
        .data_in(pause_req_to_tx),
        .gtx_clk(gtx_clk),
        .pause_status_int(pause_status_int),
        .pause_status_req(pause_status_req),
        .tx_ce_sample(tx_ce_sample),
        .tx_status(tx_status));
FDRE tx_underrun_int_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_underrun_int),
        .Q(tx_underrun_int_0),
        .R(I1));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_rx
   (alignment_err_reg,
    int_alignment_err_pulse,
    gmii_rx_dv_from_mii,
    gmii_rx_er_from_mii,
    D,
    SR,
    gmii_rx_dv_int,
    I1,
    gmii_rx_er_int,
    tx_configuration_vector,
    I2);
  output alignment_err_reg;
  output int_alignment_err_pulse;
  output gmii_rx_dv_from_mii;
  output gmii_rx_er_from_mii;
  output [7:0]D;
  input [0:0]SR;
  input gmii_rx_dv_int;
  input I1;
  input gmii_rx_er_int;
  input [0:0]tx_configuration_vector;
  input [7:0]I2;

  wire \<const0> ;
  wire \<const1> ;
  wire [7:0]D;
  wire I1;
  wire [7:0]I2;
  wire [0:0]SR;
  wire alignment_err_reg;
  wire gmii_rx_dv_from_mii;
  wire gmii_rx_dv_int;
  wire gmii_rx_er_from_mii;
  wire gmii_rx_er_int;
  wire int_alignment_err_pulse;
  wire muxsel;
  wire muxsel0;
  wire n_0_RX_ERR_REG1_i_2;
  wire n_0_muxsel_i_1__0;
  wire n_0_nibble_toggle_i_1;
  wire n_0_rx_dv_reg3_i_1;
  wire n_0_sfd_comb_reg1_i_2;
  wire n_0_sfd_enable_i_1;
  wire n_0_sfd_enable_i_2;
  wire n_0_sfd_enable_i_3;
  wire n_0_sfd_enable_reg;
  wire nibble_toggle;
  wire no_error;
  wire no_error_reg1;
  wire no_error_reg2;
  wire rx_dv_reg1;
  wire rx_dv_reg2;
  wire rx_dv_reg3;
  wire rx_er_reg1;
  wire rx_er_reg2;
  wire rx_er_reg3;
  wire rx_er_reg4;
  wire [7:4]rxd_reg1;
  wire [3:0]rxd_reg1__0;
  wire [3:0]rxd_reg2;
  wire [3:0]rxd_reg3;
  wire [3:0]rxd_reg4;
  wire sfd_comb_reg1;
  wire sfd_comb_reg2;
  wire [0:0]tx_configuration_vector;

GND GND
       (.G(\<const0> ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \RXD_REG1[0]_i_1 
       (.I0(rxd_reg1__0[0]),
        .I1(tx_configuration_vector),
        .I2(rxd_reg4[0]),
        .I3(muxsel),
        .I4(rxd_reg3[0]),
        .O(D[0]));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \RXD_REG1[1]_i_1 
       (.I0(rxd_reg1__0[1]),
        .I1(tx_configuration_vector),
        .I2(rxd_reg4[1]),
        .I3(muxsel),
        .I4(rxd_reg3[1]),
        .O(D[1]));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \RXD_REG1[2]_i_1 
       (.I0(rxd_reg1__0[2]),
        .I1(tx_configuration_vector),
        .I2(rxd_reg4[2]),
        .I3(muxsel),
        .I4(rxd_reg3[2]),
        .O(D[2]));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \RXD_REG1[3]_i_1 
       (.I0(rxd_reg1__0[3]),
        .I1(tx_configuration_vector),
        .I2(rxd_reg4[3]),
        .I3(muxsel),
        .I4(rxd_reg3[3]),
        .O(D[3]));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \RXD_REG1[4]_i_1 
       (.I0(rxd_reg1[4]),
        .I1(tx_configuration_vector),
        .I2(rxd_reg3[0]),
        .I3(muxsel),
        .I4(rxd_reg2[0]),
        .O(D[4]));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \RXD_REG1[5]_i_1 
       (.I0(rxd_reg1[5]),
        .I1(tx_configuration_vector),
        .I2(rxd_reg3[1]),
        .I3(muxsel),
        .I4(rxd_reg2[1]),
        .O(D[5]));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \RXD_REG1[6]_i_1 
       (.I0(rxd_reg1[6]),
        .I1(tx_configuration_vector),
        .I2(rxd_reg3[2]),
        .I3(muxsel),
        .I4(rxd_reg2[2]),
        .O(D[6]));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \RXD_REG1[7]_i_1 
       (.I0(rxd_reg1[7]),
        .I1(tx_configuration_vector),
        .I2(rxd_reg3[3]),
        .I3(muxsel),
        .I4(rxd_reg2[3]),
        .O(D[7]));
LUT3 #(
    .INIT(8'hB8)) 
     RX_DV_REG1_i_1
       (.I0(rx_dv_reg1),
        .I1(tx_configuration_vector),
        .I2(rx_dv_reg3),
        .O(gmii_rx_dv_from_mii));
LUT6 #(
    .INIT(64'hBBBBBBBB8888B888)) 
     RX_ERR_REG1_i_1
       (.I0(rx_er_reg1),
        .I1(tx_configuration_vector),
        .I2(rx_dv_reg2),
        .I3(rx_er_reg2),
        .I4(sfd_comb_reg2),
        .I5(n_0_RX_ERR_REG1_i_2),
        .O(gmii_rx_er_from_mii));
LUT4 #(
    .INIT(16'hFEEE)) 
     RX_ERR_REG1_i_2
       (.I0(rx_er_reg3),
        .I1(no_error_reg2),
        .I2(rx_er_reg4),
        .I3(muxsel),
        .O(n_0_RX_ERR_REG1_i_2));
VCC VCC
       (.P(\<const1> ));
(* SOFT_HLUTNM = "soft_lutpair71" *) 
   LUT4 #(
    .INIT(16'h0008)) 
     alignment_err_reg_i_1
       (.I0(nibble_toggle),
        .I1(rx_dv_reg2),
        .I2(tx_configuration_vector),
        .I3(rx_dv_reg1),
        .O(int_alignment_err_pulse));
FDRE alignment_err_reg_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(int_alignment_err_pulse),
        .Q(alignment_err_reg),
        .R(SR));
LUT6 #(
    .INIT(64'h000000000000FF7F)) 
     muxsel_i_1__0
       (.I0(n_0_sfd_enable_reg),
        .I1(n_0_sfd_comb_reg1_i_2),
        .I2(rxd_reg2[2]),
        .I3(rxd_reg2[1]),
        .I4(SR),
        .I5(muxsel),
        .O(n_0_muxsel_i_1__0));
FDRE muxsel_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_muxsel_i_1__0),
        .Q(muxsel),
        .R(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair71" *) 
   LUT2 #(
    .INIT(4'h6)) 
     nibble_toggle_i_1
       (.I0(rx_dv_reg2),
        .I1(nibble_toggle),
        .O(n_0_nibble_toggle_i_1));
FDCE nibble_toggle_reg
       (.C(I1),
        .CE(\<const1> ),
        .CLR(n_0_sfd_enable_reg),
        .D(n_0_nibble_toggle_i_1),
        .Q(nibble_toggle));
(* SOFT_HLUTNM = "soft_lutpair72" *) 
   LUT3 #(
    .INIT(8'h80)) 
     no_error_reg1_i_1
       (.I0(sfd_comb_reg2),
        .I1(rx_er_reg2),
        .I2(rx_dv_reg2),
        .O(no_error));
FDRE no_error_reg1_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(no_error),
        .Q(no_error_reg1),
        .R(SR));
FDRE no_error_reg2_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(no_error_reg1),
        .Q(no_error_reg2),
        .R(SR));
FDRE rx_dv_reg1_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(gmii_rx_dv_int),
        .Q(rx_dv_reg1),
        .R(SR));
FDRE rx_dv_reg2_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(rx_dv_reg1),
        .Q(rx_dv_reg2),
        .R(SR));
LUT6 #(
    .INIT(64'h00000000F0F0E0F0)) 
     rx_dv_reg3_i_1
       (.I0(rx_dv_reg1),
        .I1(tx_configuration_vector),
        .I2(rx_dv_reg2),
        .I3(nibble_toggle),
        .I4(rx_er_reg2),
        .I5(SR),
        .O(n_0_rx_dv_reg3_i_1));
FDRE rx_dv_reg3_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_rx_dv_reg3_i_1),
        .Q(rx_dv_reg3),
        .R(\<const0> ));
FDRE rx_er_reg1_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(gmii_rx_er_int),
        .Q(rx_er_reg1),
        .R(SR));
FDRE rx_er_reg2_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(rx_er_reg1),
        .Q(rx_er_reg2),
        .R(SR));
FDRE rx_er_reg3_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(rx_er_reg2),
        .Q(rx_er_reg3),
        .R(SR));
FDRE rx_er_reg4_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(rx_er_reg3),
        .Q(rx_er_reg4),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg1_reg[0] 
       (.C(I1),
        .CE(\<const1> ),
        .D(I2[0]),
        .Q(rxd_reg1__0[0]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg1_reg[1] 
       (.C(I1),
        .CE(\<const1> ),
        .D(I2[1]),
        .Q(rxd_reg1__0[1]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg1_reg[2] 
       (.C(I1),
        .CE(\<const1> ),
        .D(I2[2]),
        .Q(rxd_reg1__0[2]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg1_reg[3] 
       (.C(I1),
        .CE(\<const1> ),
        .D(I2[3]),
        .Q(rxd_reg1__0[3]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg1_reg[4] 
       (.C(I1),
        .CE(\<const1> ),
        .D(I2[4]),
        .Q(rxd_reg1[4]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg1_reg[5] 
       (.C(I1),
        .CE(\<const1> ),
        .D(I2[5]),
        .Q(rxd_reg1[5]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg1_reg[6] 
       (.C(I1),
        .CE(\<const1> ),
        .D(I2[6]),
        .Q(rxd_reg1[6]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg1_reg[7] 
       (.C(I1),
        .CE(\<const1> ),
        .D(I2[7]),
        .Q(rxd_reg1[7]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg2_reg[0] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg1__0[0]),
        .Q(rxd_reg2[0]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg2_reg[1] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg1__0[1]),
        .Q(rxd_reg2[1]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg2_reg[2] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg1__0[2]),
        .Q(rxd_reg2[2]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg2_reg[3] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg1__0[3]),
        .Q(rxd_reg2[3]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg3_reg[0] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg2[0]),
        .Q(rxd_reg3[0]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg3_reg[1] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg2[1]),
        .Q(rxd_reg3[1]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg3_reg[2] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg2[2]),
        .Q(rxd_reg3[2]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg3_reg[3] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg2[3]),
        .Q(rxd_reg3[3]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg4_reg[0] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg3[0]),
        .Q(rxd_reg4[0]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg4_reg[1] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg3[1]),
        .Q(rxd_reg4[1]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg4_reg[2] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg3[2]),
        .Q(rxd_reg4[2]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rxd_reg4_reg[3] 
       (.C(I1),
        .CE(\<const1> ),
        .D(rxd_reg3[3]),
        .Q(rxd_reg4[3]),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair70" *) 
   LUT4 #(
    .INIT(16'h0080)) 
     sfd_comb_reg1_i_1
       (.I0(n_0_sfd_enable_reg),
        .I1(n_0_sfd_comb_reg1_i_2),
        .I2(rxd_reg2[2]),
        .I3(rxd_reg2[1]),
        .O(muxsel0));
LUT6 #(
    .INIT(64'h0000000040000000)) 
     sfd_comb_reg1_i_2
       (.I0(rxd_reg2[3]),
        .I1(rxd_reg2[0]),
        .I2(rxd_reg1__0[2]),
        .I3(rxd_reg1__0[3]),
        .I4(rxd_reg1__0[0]),
        .I5(rxd_reg1__0[1]),
        .O(n_0_sfd_comb_reg1_i_2));
FDRE sfd_comb_reg1_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(muxsel0),
        .Q(sfd_comb_reg1),
        .R(SR));
FDRE sfd_comb_reg2_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(sfd_comb_reg1),
        .Q(sfd_comb_reg2),
        .R(SR));
LUT6 #(
    .INIT(64'h0000FFEF0000FF00)) 
     sfd_enable_i_1
       (.I0(rx_er_reg2),
        .I1(rx_er_reg1),
        .I2(n_0_sfd_enable_i_2),
        .I3(n_0_sfd_enable_i_3),
        .I4(SR),
        .I5(n_0_sfd_enable_reg),
        .O(n_0_sfd_enable_i_1));
(* SOFT_HLUTNM = "soft_lutpair70" *) 
   LUT3 #(
    .INIT(8'h40)) 
     sfd_enable_i_2
       (.I0(rxd_reg2[1]),
        .I1(rxd_reg2[2]),
        .I2(n_0_sfd_comb_reg1_i_2),
        .O(n_0_sfd_enable_i_2));
(* SOFT_HLUTNM = "soft_lutpair72" *) 
   LUT2 #(
    .INIT(4'h2)) 
     sfd_enable_i_3
       (.I0(rx_dv_reg1),
        .I1(rx_dv_reg2),
        .O(n_0_sfd_enable_i_3));
FDRE sfd_enable_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_sfd_enable_i_1),
        .Q(n_0_sfd_enable_reg),
        .R(\<const0> ));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_tx
   (O1,
    rgmii_tx_ctl_int,
    gmii_txd_falling,
    Q,
    tx_en_to_ddr,
    gtx_clk,
    I1,
    phy_tx_enable,
    int_gmii_tx_en,
    int_gmii_tx_er,
    tx_configuration_vector,
    clk_div5,
    I2,
    SR,
    D);
  output O1;
  output rgmii_tx_ctl_int;
  output [3:0]gmii_txd_falling;
  output [3:0]Q;
  output tx_en_to_ddr;
  input gtx_clk;
  input I1;
  input phy_tx_enable;
  input int_gmii_tx_en;
  input int_gmii_tx_er;
  input [0:0]tx_configuration_vector;
  input clk_div5;
  input I2;
  input [0:0]SR;
  input [7:0]D;

  wire \<const0> ;
  wire \<const1> ;
  wire [7:0]D;
  wire I1;
  wire I2;
  wire O1;
  wire [3:0]Q;
  wire [0:0]SR;
  wire clk_div5;
  wire gmii_tx_en_int;
  wire gmii_tx_er_int;
  wire [3:0]gmii_txd_falling;
  wire [7:4]gmii_txd_int;
  wire gtx_clk;
  wire int_gmii_tx_en;
  wire int_gmii_tx_er;
  wire muxsel;
  wire n_0_gmii_tx_en_to_phy_i_1;
  wire n_0_gmii_tx_er_to_phy_i_1;
  wire \n_0_gmii_txd_to_phy[0]_i_1 ;
  wire \n_0_gmii_txd_to_phy[1]_i_1 ;
  wire \n_0_gmii_txd_to_phy[2]_i_1 ;
  wire \n_0_gmii_txd_to_phy[3]_i_1 ;
  wire \n_0_gmii_txd_to_phy[4]_i_1 ;
  wire \n_0_gmii_txd_to_phy[5]_i_1 ;
  wire \n_0_gmii_txd_to_phy[6]_i_1 ;
  wire \n_0_gmii_txd_to_phy[7]_i_2 ;
  wire n_0_muxsel_i_1;
  wire phy_tx_enable;
  wire rgmii_tx_ctl_int;
  wire [0:0]tx_configuration_vector;
  wire tx_en_reg1;
  wire tx_en_reg2;
  wire tx_en_to_ddr;
  wire tx_er_reg1;
  wire tx_er_reg2;
  wire [7:0]txd_reg1;
  wire [7:0]txd_reg2;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* SOFT_HLUTNM = "soft_lutpair113" *) 
   LUT4 #(
    .INIT(16'hAA8A)) 
     ctl_output_i_1
       (.I0(gmii_tx_en_int),
        .I1(clk_div5),
        .I2(gmii_tx_er_int),
        .I3(tx_configuration_vector),
        .O(tx_en_to_ddr));
(* SOFT_HLUTNM = "soft_lutpair113" *) 
   LUT2 #(
    .INIT(4'h6)) 
     ctl_output_i_2
       (.I0(gmii_tx_er_int),
        .I1(gmii_tx_en_int),
        .O(rgmii_tx_ctl_int));
LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
     gmii_tx_en_to_phy_i_1
       (.I0(gmii_tx_en_int),
        .I1(phy_tx_enable),
        .I2(tx_en_reg2),
        .I3(tx_configuration_vector),
        .I4(tx_en_reg1),
        .I5(I2),
        .O(n_0_gmii_tx_en_to_phy_i_1));
FDRE gmii_tx_en_to_phy_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_gmii_tx_en_to_phy_i_1),
        .Q(gmii_tx_en_int),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h00000000EEE222E2)) 
     gmii_tx_er_to_phy_i_1
       (.I0(gmii_tx_er_int),
        .I1(phy_tx_enable),
        .I2(tx_er_reg2),
        .I3(tx_configuration_vector),
        .I4(tx_er_reg1),
        .I5(I2),
        .O(n_0_gmii_tx_er_to_phy_i_1));
FDRE gmii_tx_er_to_phy_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_gmii_tx_er_to_phy_i_1),
        .Q(gmii_tx_er_int),
        .R(\<const0> ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \gmii_txd_to_phy[0]_i_1 
       (.I0(txd_reg1[0]),
        .I1(tx_configuration_vector),
        .I2(txd_reg2[4]),
        .I3(muxsel),
        .I4(txd_reg2[0]),
        .O(\n_0_gmii_txd_to_phy[0]_i_1 ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \gmii_txd_to_phy[1]_i_1 
       (.I0(txd_reg1[1]),
        .I1(tx_configuration_vector),
        .I2(txd_reg2[5]),
        .I3(muxsel),
        .I4(txd_reg2[1]),
        .O(\n_0_gmii_txd_to_phy[1]_i_1 ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \gmii_txd_to_phy[2]_i_1 
       (.I0(txd_reg1[2]),
        .I1(tx_configuration_vector),
        .I2(txd_reg2[6]),
        .I3(muxsel),
        .I4(txd_reg2[2]),
        .O(\n_0_gmii_txd_to_phy[2]_i_1 ));
LUT5 #(
    .INIT(32'hB8BBB888)) 
     \gmii_txd_to_phy[3]_i_1 
       (.I0(txd_reg1[3]),
        .I1(tx_configuration_vector),
        .I2(txd_reg2[7]),
        .I3(muxsel),
        .I4(txd_reg2[3]),
        .O(\n_0_gmii_txd_to_phy[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair116" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \gmii_txd_to_phy[4]_i_1 
       (.I0(tx_configuration_vector),
        .I1(txd_reg1[4]),
        .O(\n_0_gmii_txd_to_phy[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair117" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \gmii_txd_to_phy[5]_i_1 
       (.I0(tx_configuration_vector),
        .I1(txd_reg1[5]),
        .O(\n_0_gmii_txd_to_phy[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair117" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \gmii_txd_to_phy[6]_i_1 
       (.I0(tx_configuration_vector),
        .I1(txd_reg1[6]),
        .O(\n_0_gmii_txd_to_phy[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair116" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \gmii_txd_to_phy[7]_i_2 
       (.I0(tx_configuration_vector),
        .I1(txd_reg1[7]),
        .O(\n_0_gmii_txd_to_phy[7]_i_2 ));
FDRE \gmii_txd_to_phy_reg[0] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(\n_0_gmii_txd_to_phy[0]_i_1 ),
        .Q(Q[0]),
        .R(SR));
FDRE \gmii_txd_to_phy_reg[1] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(\n_0_gmii_txd_to_phy[1]_i_1 ),
        .Q(Q[1]),
        .R(SR));
FDRE \gmii_txd_to_phy_reg[2] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(\n_0_gmii_txd_to_phy[2]_i_1 ),
        .Q(Q[2]),
        .R(SR));
FDRE \gmii_txd_to_phy_reg[3] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(\n_0_gmii_txd_to_phy[3]_i_1 ),
        .Q(Q[3]),
        .R(SR));
FDRE \gmii_txd_to_phy_reg[4] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(\n_0_gmii_txd_to_phy[4]_i_1 ),
        .Q(gmii_txd_int[4]),
        .R(SR));
FDRE \gmii_txd_to_phy_reg[5] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(\n_0_gmii_txd_to_phy[5]_i_1 ),
        .Q(gmii_txd_int[5]),
        .R(SR));
FDRE \gmii_txd_to_phy_reg[6] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(\n_0_gmii_txd_to_phy[6]_i_1 ),
        .Q(gmii_txd_int[6]),
        .R(SR));
FDRE \gmii_txd_to_phy_reg[7] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(\n_0_gmii_txd_to_phy[7]_i_2 ),
        .Q(gmii_txd_int[7]),
        .R(SR));
FDRE \hd_tieoff.extension_reg_reg 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(O1),
        .R(\<const0> ));
LUT5 #(
    .INIT(32'h00005A1A)) 
     muxsel_i_1
       (.I0(muxsel),
        .I1(tx_en_reg1),
        .I2(phy_tx_enable),
        .I3(tx_en_reg2),
        .I4(I1),
        .O(n_0_muxsel_i_1));
FDRE muxsel_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_muxsel_i_1),
        .Q(muxsel),
        .R(\<const0> ));
FDRE tx_en_reg1_reg
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(int_gmii_tx_en),
        .Q(tx_en_reg1),
        .R(I1));
FDRE tx_en_reg2_reg
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(tx_en_reg1),
        .Q(tx_en_reg2),
        .R(I1));
FDRE tx_er_reg1_reg
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(int_gmii_tx_er),
        .Q(tx_er_reg1),
        .R(I1));
FDRE tx_er_reg2_reg
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(tx_er_reg1),
        .Q(tx_er_reg2),
        .R(I1));
FDRE \txd_reg1_reg[0] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(D[0]),
        .Q(txd_reg1[0]),
        .R(I1));
FDRE \txd_reg1_reg[1] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(D[1]),
        .Q(txd_reg1[1]),
        .R(I1));
FDRE \txd_reg1_reg[2] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(D[2]),
        .Q(txd_reg1[2]),
        .R(I1));
FDRE \txd_reg1_reg[3] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(D[3]),
        .Q(txd_reg1[3]),
        .R(I1));
FDRE \txd_reg1_reg[4] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(D[4]),
        .Q(txd_reg1[4]),
        .R(I1));
FDRE \txd_reg1_reg[5] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(D[5]),
        .Q(txd_reg1[5]),
        .R(I1));
FDRE \txd_reg1_reg[6] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(D[6]),
        .Q(txd_reg1[6]),
        .R(I1));
FDRE \txd_reg1_reg[7] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(D[7]),
        .Q(txd_reg1[7]),
        .R(I1));
FDRE \txd_reg2_reg[0] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(txd_reg1[0]),
        .Q(txd_reg2[0]),
        .R(I1));
FDRE \txd_reg2_reg[1] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(txd_reg1[1]),
        .Q(txd_reg2[1]),
        .R(I1));
FDRE \txd_reg2_reg[2] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(txd_reg1[2]),
        .Q(txd_reg2[2]),
        .R(I1));
FDRE \txd_reg2_reg[3] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(txd_reg1[3]),
        .Q(txd_reg2[3]),
        .R(I1));
FDRE \txd_reg2_reg[4] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(txd_reg1[4]),
        .Q(txd_reg2[4]),
        .R(I1));
FDRE \txd_reg2_reg[5] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(txd_reg1[5]),
        .Q(txd_reg2[5]),
        .R(I1));
FDRE \txd_reg2_reg[6] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(txd_reg1[6]),
        .Q(txd_reg2[6]),
        .R(I1));
FDRE \txd_reg2_reg[7] 
       (.C(gtx_clk),
        .CE(phy_tx_enable),
        .D(txd_reg1[7]),
        .Q(txd_reg2[7]),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair115" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txdata_out_bus[0].rgmii_txd_out_i_1 
       (.I0(gmii_txd_int[4]),
        .I1(tx_configuration_vector),
        .I2(Q[0]),
        .O(gmii_txd_falling[0]));
(* SOFT_HLUTNM = "soft_lutpair115" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txdata_out_bus[1].rgmii_txd_out_i_1 
       (.I0(gmii_txd_int[5]),
        .I1(tx_configuration_vector),
        .I2(Q[1]),
        .O(gmii_txd_falling[1]));
(* SOFT_HLUTNM = "soft_lutpair114" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txdata_out_bus[2].rgmii_txd_out_i_1 
       (.I0(gmii_txd_int[6]),
        .I1(tx_configuration_vector),
        .I2(Q[2]),
        .O(gmii_txd_falling[2]));
(* SOFT_HLUTNM = "soft_lutpair114" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \txdata_out_bus[3].rgmii_txd_out_i_1 
       (.I0(gmii_txd_int[7]),
        .I1(tx_configuration_vector),
        .I2(Q[3]),
        .O(gmii_txd_falling[3]));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_pfc_tx_cntl
   (pfc_req,
    pause_req_int0,
    O1,
    O2,
    O3,
    O4,
    O5,
    O6,
    O7,
    O8,
    Q,
    gtx_clk,
    pfc_tx_enable_sync,
    tx_enable_reg,
    pause_req,
    I1,
    I2,
    pfc_pause_req_out,
    pause_val,
    control_complete,
    E);
  output pfc_req;
  output pause_req_int0;
  output O1;
  output O2;
  output O3;
  output O4;
  output O5;
  output O6;
  output O7;
  output O8;
  output [7:0]Q;
  input gtx_clk;
  input pfc_tx_enable_sync;
  input tx_enable_reg;
  input pause_req;
  input I1;
  input I2;
  input pfc_pause_req_out;
  input [15:0]pause_val;
  input control_complete;
  input [0:0]E;

  wire \<const0> ;
  wire \<const1> ;
  wire [0:0]E;
  wire I1;
  wire I2;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire O5;
  wire O6;
  wire O7;
  wire O8;
  wire [7:0]Q;
  wire control_complete;
  wire gtx_clk;
  wire \n_0_FSM_onehot_legacy_state[0]_i_1 ;
  wire \n_0_FSM_onehot_legacy_state[1]_i_1 ;
  wire \n_0_FSM_onehot_legacy_state[2]_i_1 ;
  wire \n_0_FSM_onehot_legacy_state[3]_i_1 ;
  wire \n_0_FSM_onehot_legacy_state[4]_i_1 ;
  wire \n_0_FSM_onehot_legacy_state_reg[0] ;
  wire \n_0_FSM_onehot_legacy_state_reg[1] ;
  wire \n_0_FSM_onehot_legacy_state_reg[2] ;
  wire \n_0_FSM_onehot_legacy_state_reg[3] ;
  wire \n_0_FSM_onehot_legacy_state_reg[4] ;
  wire \n_0_pause_state[0]_i_1 ;
  wire \n_0_pause_state[1]_i_1 ;
  wire \n_0_pause_state[1]_i_2 ;
  wire \n_0_pause_value[0]_i_1 ;
  wire \n_0_pause_value[10]_i_1 ;
  wire \n_0_pause_value[11]_i_1 ;
  wire \n_0_pause_value[12]_i_1 ;
  wire \n_0_pause_value[13]_i_1 ;
  wire \n_0_pause_value[14]_i_1 ;
  wire \n_0_pause_value[15]_i_2__0 ;
  wire \n_0_pause_value[1]_i_1 ;
  wire \n_0_pause_value[2]_i_1 ;
  wire \n_0_pause_value[3]_i_1 ;
  wire \n_0_pause_value[4]_i_1 ;
  wire \n_0_pause_value[5]_i_1 ;
  wire \n_0_pause_value[6]_i_1 ;
  wire \n_0_pause_value[7]_i_1 ;
  wire \n_0_pause_value[8]_i_1 ;
  wire \n_0_pause_value[9]_i_1 ;
  wire \n_0_pause_value_reg[0] ;
  wire \n_0_pause_value_reg[1] ;
  wire \n_0_pause_value_reg[2] ;
  wire \n_0_pause_value_reg[3] ;
  wire \n_0_pause_value_reg[4] ;
  wire \n_0_pause_value_reg[5] ;
  wire \n_0_pause_value_reg[6] ;
  wire \n_0_pause_value_reg[7] ;
  wire n_0_pfc_req_i_1;
  wire \n_0_pfc_valid[0]_i_1 ;
  wire pause_req;
  wire pause_req2_out;
  wire pause_req_int;
  wire pause_req_int0;
  wire [1:0]pause_state;
  wire [15:0]pause_val;
  wire pfc_pause_req_out;
  wire pfc_req;
  wire pfc_tx_enable_sync;
  wire pfc_valid;
  wire [0:0]quanta_low;
  wire tx_enable_reg;

LUT5 #(
    .INIT(32'h00010000)) 
     \FSM_onehot_legacy_state[0]_i_1 
       (.I0(\n_0_FSM_onehot_legacy_state_reg[2] ),
        .I1(\n_0_FSM_onehot_legacy_state_reg[1] ),
        .I2(\n_0_FSM_onehot_legacy_state_reg[4] ),
        .I3(\n_0_FSM_onehot_legacy_state_reg[0] ),
        .I4(\n_0_FSM_onehot_legacy_state_reg[3] ),
        .O(\n_0_FSM_onehot_legacy_state[0]_i_1 ));
LUT5 #(
    .INIT(32'h00010000)) 
     \FSM_onehot_legacy_state[1]_i_1 
       (.I0(\n_0_FSM_onehot_legacy_state_reg[2] ),
        .I1(\n_0_FSM_onehot_legacy_state_reg[1] ),
        .I2(\n_0_FSM_onehot_legacy_state_reg[3] ),
        .I3(\n_0_FSM_onehot_legacy_state_reg[4] ),
        .I4(\n_0_FSM_onehot_legacy_state_reg[0] ),
        .O(\n_0_FSM_onehot_legacy_state[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair162" *) 
   LUT5 #(
    .INIT(32'h00010000)) 
     \FSM_onehot_legacy_state[2]_i_1 
       (.I0(\n_0_FSM_onehot_legacy_state_reg[0] ),
        .I1(\n_0_FSM_onehot_legacy_state_reg[4] ),
        .I2(\n_0_FSM_onehot_legacy_state_reg[3] ),
        .I3(\n_0_FSM_onehot_legacy_state_reg[2] ),
        .I4(\n_0_FSM_onehot_legacy_state_reg[1] ),
        .O(\n_0_FSM_onehot_legacy_state[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair162" *) 
   LUT5 #(
    .INIT(32'h00000010)) 
     \FSM_onehot_legacy_state[3]_i_1 
       (.I0(\n_0_FSM_onehot_legacy_state_reg[0] ),
        .I1(\n_0_FSM_onehot_legacy_state_reg[4] ),
        .I2(\n_0_FSM_onehot_legacy_state_reg[2] ),
        .I3(\n_0_FSM_onehot_legacy_state_reg[3] ),
        .I4(\n_0_FSM_onehot_legacy_state_reg[1] ),
        .O(\n_0_FSM_onehot_legacy_state[3]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFEAFFFFAAEA)) 
     \FSM_onehot_legacy_state[4]_i_1 
       (.I0(\n_0_FSM_onehot_legacy_state_reg[1] ),
        .I1(tx_enable_reg),
        .I2(pause_req),
        .I3(\n_0_FSM_onehot_legacy_state_reg[2] ),
        .I4(\n_0_FSM_onehot_legacy_state_reg[3] ),
        .I5(I1),
        .O(\n_0_FSM_onehot_legacy_state[4]_i_1 ));
FDSE #(
    .INIT(1'b1)) 
     \FSM_onehot_legacy_state_reg[0] 
       (.C(gtx_clk),
        .CE(\n_0_FSM_onehot_legacy_state[4]_i_1 ),
        .D(\n_0_FSM_onehot_legacy_state[0]_i_1 ),
        .Q(\n_0_FSM_onehot_legacy_state_reg[0] ),
        .S(I2));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_legacy_state_reg[1] 
       (.C(gtx_clk),
        .CE(\n_0_FSM_onehot_legacy_state[4]_i_1 ),
        .D(\n_0_FSM_onehot_legacy_state[1]_i_1 ),
        .Q(\n_0_FSM_onehot_legacy_state_reg[1] ),
        .R(I2));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_legacy_state_reg[2] 
       (.C(gtx_clk),
        .CE(\n_0_FSM_onehot_legacy_state[4]_i_1 ),
        .D(\n_0_FSM_onehot_legacy_state[2]_i_1 ),
        .Q(\n_0_FSM_onehot_legacy_state_reg[2] ),
        .R(I2));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_legacy_state_reg[3] 
       (.C(gtx_clk),
        .CE(\n_0_FSM_onehot_legacy_state[4]_i_1 ),
        .D(\n_0_FSM_onehot_legacy_state[3]_i_1 ),
        .Q(\n_0_FSM_onehot_legacy_state_reg[3] ),
        .R(I2));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_legacy_state_reg[4] 
       (.C(gtx_clk),
        .CE(\n_0_FSM_onehot_legacy_state[4]_i_1 ),
        .D(\<const0> ),
        .Q(\n_0_FSM_onehot_legacy_state_reg[4] ),
        .R(I2));
GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* SOFT_HLUTNM = "soft_lutpair163" *) 
   LUT3 #(
    .INIT(8'h04)) 
     pause_req_i_1
       (.I0(pause_state[1]),
        .I1(pause_state[0]),
        .I2(I2),
        .O(pause_req2_out));
LUT4 #(
    .INIT(16'hF888)) 
     pause_req_int_i_2__0
       (.I0(pfc_req),
        .I1(pfc_tx_enable_sync),
        .I2(pause_req_int),
        .I3(tx_enable_reg),
        .O(pause_req_int0));
FDRE pause_req_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(pause_req2_out),
        .Q(pause_req_int),
        .R(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair161" *) 
   LUT5 #(
    .INIT(32'h30227422)) 
     \pause_state[0]_i_1 
       (.I0(\n_0_pause_state[1]_i_2 ),
        .I1(pause_state[0]),
        .I2(I1),
        .I3(pause_state[1]),
        .I4(control_complete),
        .O(\n_0_pause_state[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair161" *) 
   LUT5 #(
    .INIT(32'h31CC75CC)) 
     \pause_state[1]_i_1 
       (.I0(\n_0_pause_state[1]_i_2 ),
        .I1(pause_state[0]),
        .I2(I1),
        .I3(pause_state[1]),
        .I4(control_complete),
        .O(\n_0_pause_state[1]_i_1 ));
LUT5 #(
    .INIT(32'h0000FF12)) 
     \pause_state[1]_i_2 
       (.I0(\n_0_FSM_onehot_legacy_state_reg[1] ),
        .I1(\n_0_FSM_onehot_legacy_state_reg[3] ),
        .I2(\n_0_FSM_onehot_legacy_state_reg[2] ),
        .I3(quanta_low),
        .I4(pause_state[1]),
        .O(\n_0_pause_state[1]_i_2 ));
FDRE \pause_state_reg[0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_pause_state[0]_i_1 ),
        .Q(pause_state[0]),
        .R(I2));
FDRE \pause_state_reg[1] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_pause_state[1]_i_1 ),
        .Q(pause_state[1]),
        .R(I2));
(* SOFT_HLUTNM = "soft_lutpair175" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[0]_i_1 
       (.I0(pause_req),
        .I1(pause_val[0]),
        .O(\n_0_pause_value[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair169" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[10]_i_1 
       (.I0(pause_req),
        .I1(pause_val[10]),
        .O(\n_0_pause_value[10]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair168" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[11]_i_1 
       (.I0(pause_req),
        .I1(pause_val[11]),
        .O(\n_0_pause_value[11]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair171" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[12]_i_1 
       (.I0(pause_req),
        .I1(pause_val[12]),
        .O(\n_0_pause_value[12]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair170" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[13]_i_1 
       (.I0(pause_req),
        .I1(pause_val[13]),
        .O(\n_0_pause_value[13]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair169" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[14]_i_1 
       (.I0(pause_req),
        .I1(pause_val[14]),
        .O(\n_0_pause_value[14]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair168" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[15]_i_2__0 
       (.I0(pause_req),
        .I1(pause_val[15]),
        .O(\n_0_pause_value[15]_i_2__0 ));
(* SOFT_HLUTNM = "soft_lutpair175" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[1]_i_1 
       (.I0(pause_req),
        .I1(pause_val[1]),
        .O(\n_0_pause_value[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair174" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[2]_i_1 
       (.I0(pause_req),
        .I1(pause_val[2]),
        .O(\n_0_pause_value[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair174" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[3]_i_1 
       (.I0(pause_req),
        .I1(pause_val[3]),
        .O(\n_0_pause_value[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair173" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[4]_i_1 
       (.I0(pause_req),
        .I1(pause_val[4]),
        .O(\n_0_pause_value[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair172" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[5]_i_1 
       (.I0(pause_req),
        .I1(pause_val[5]),
        .O(\n_0_pause_value[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair173" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[6]_i_1 
       (.I0(pause_req),
        .I1(pause_val[6]),
        .O(\n_0_pause_value[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair171" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[7]_i_1 
       (.I0(pause_req),
        .I1(pause_val[7]),
        .O(\n_0_pause_value[7]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair172" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[8]_i_1 
       (.I0(pause_req),
        .I1(pause_val[8]),
        .O(\n_0_pause_value[8]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair170" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \pause_value[9]_i_1 
       (.I0(pause_req),
        .I1(pause_val[9]),
        .O(\n_0_pause_value[9]_i_1 ));
FDRE \pause_value_reg[0] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[0]_i_1 ),
        .Q(\n_0_pause_value_reg[0] ),
        .R(I2));
FDRE \pause_value_reg[10] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[10]_i_1 ),
        .Q(Q[2]),
        .R(I2));
FDRE \pause_value_reg[11] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[11]_i_1 ),
        .Q(Q[3]),
        .R(I2));
FDRE \pause_value_reg[12] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[12]_i_1 ),
        .Q(Q[4]),
        .R(I2));
FDRE \pause_value_reg[13] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[13]_i_1 ),
        .Q(Q[5]),
        .R(I2));
FDRE \pause_value_reg[14] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[14]_i_1 ),
        .Q(Q[6]),
        .R(I2));
FDRE \pause_value_reg[15] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[15]_i_2__0 ),
        .Q(Q[7]),
        .R(I2));
FDRE \pause_value_reg[1] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[1]_i_1 ),
        .Q(\n_0_pause_value_reg[1] ),
        .R(I2));
FDRE \pause_value_reg[2] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[2]_i_1 ),
        .Q(\n_0_pause_value_reg[2] ),
        .R(I2));
FDRE \pause_value_reg[3] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[3]_i_1 ),
        .Q(\n_0_pause_value_reg[3] ),
        .R(I2));
FDRE \pause_value_reg[4] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[4]_i_1 ),
        .Q(\n_0_pause_value_reg[4] ),
        .R(I2));
FDRE \pause_value_reg[5] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[5]_i_1 ),
        .Q(\n_0_pause_value_reg[5] ),
        .R(I2));
FDRE \pause_value_reg[6] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[6]_i_1 ),
        .Q(\n_0_pause_value_reg[6] ),
        .R(I2));
FDRE \pause_value_reg[7] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[7]_i_1 ),
        .Q(\n_0_pause_value_reg[7] ),
        .R(I2));
FDRE \pause_value_reg[8] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[8]_i_1 ),
        .Q(Q[0]),
        .R(I2));
FDRE \pause_value_reg[9] 
       (.C(gtx_clk),
        .CE(E),
        .D(\n_0_pause_value[9]_i_1 ),
        .Q(Q[1]),
        .R(I2));
(* SOFT_HLUTNM = "soft_lutpair167" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_value_sample[0]_i_1 
       (.I0(pfc_valid),
        .I1(pfc_pause_req_out),
        .I2(\n_0_pause_value_reg[0] ),
        .O(O8));
(* SOFT_HLUTNM = "soft_lutpair167" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_value_sample[1]_i_1 
       (.I0(pfc_valid),
        .I1(pfc_pause_req_out),
        .I2(\n_0_pause_value_reg[1] ),
        .O(O7));
(* SOFT_HLUTNM = "soft_lutpair166" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_value_sample[2]_i_1 
       (.I0(pfc_valid),
        .I1(pfc_pause_req_out),
        .I2(\n_0_pause_value_reg[2] ),
        .O(O6));
(* SOFT_HLUTNM = "soft_lutpair165" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_value_sample[3]_i_1 
       (.I0(pfc_valid),
        .I1(pfc_pause_req_out),
        .I2(\n_0_pause_value_reg[3] ),
        .O(O5));
(* SOFT_HLUTNM = "soft_lutpair164" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_value_sample[4]_i_1 
       (.I0(pfc_valid),
        .I1(pfc_pause_req_out),
        .I2(\n_0_pause_value_reg[4] ),
        .O(O4));
(* SOFT_HLUTNM = "soft_lutpair166" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_value_sample[5]_i_1 
       (.I0(pfc_valid),
        .I1(pfc_pause_req_out),
        .I2(\n_0_pause_value_reg[5] ),
        .O(O3));
(* SOFT_HLUTNM = "soft_lutpair165" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_value_sample[6]_i_1 
       (.I0(pfc_valid),
        .I1(pfc_pause_req_out),
        .I2(\n_0_pause_value_reg[6] ),
        .O(O2));
(* SOFT_HLUTNM = "soft_lutpair164" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_value_sample[7]_i_2 
       (.I0(pfc_valid),
        .I1(pfc_pause_req_out),
        .I2(\n_0_pause_value_reg[7] ),
        .O(O1));
(* SOFT_HLUTNM = "soft_lutpair163" *) 
   LUT5 #(
    .INIT(32'h00300020)) 
     pfc_req_i_1
       (.I0(quanta_low),
        .I1(I2),
        .I2(pause_state[0]),
        .I3(pause_state[1]),
        .I4(pfc_req),
        .O(n_0_pfc_req_i_1));
FDRE pfc_req_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_pfc_req_i_1),
        .Q(pfc_req),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h000000002AFF2A2A)) 
     \pfc_valid[0]_i_1 
       (.I0(pfc_valid),
        .I1(pause_state[0]),
        .I2(pause_state[1]),
        .I3(I1),
        .I4(quanta_low),
        .I5(I2),
        .O(\n_0_pfc_valid[0]_i_1 ));
FDRE \pfc_valid_reg[0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_pfc_valid[0]_i_1 ),
        .Q(pfc_valid),
        .R(\<const0> ));
FDRE \priority_fsm[0].quanta_low_reg[0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(quanta_low),
        .R(\<const0> ));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_rx_axi_intf
   (Q,
    rx_axis_mac_tdata,
    rx_axis_mac_tvalid,
    rx_axis_mac_tlast,
    rx_axis_mac_tuser,
    I2,
    SR,
    D,
    I1,
    rx_mac_tvalid0,
    rx_mac_tlast0,
    rx_mac_tuser0,
    I3);
  output [1:0]Q;
  output [7:0]rx_axis_mac_tdata;
  output rx_axis_mac_tvalid;
  output rx_axis_mac_tlast;
  output rx_axis_mac_tuser;
  input I2;
  input [0:0]SR;
  input [1:0]D;
  input I1;
  input rx_mac_tvalid0;
  input rx_mac_tlast0;
  input rx_mac_tuser0;
  input [7:0]I3;

  wire \<const0> ;
  wire \<const1> ;
  wire [1:0]D;
  wire I1;
  wire I2;
  wire [7:0]I3;
  wire [1:0]Q;
  wire [0:0]SR;
  wire [7:0]rx_axis_mac_tdata;
  wire rx_axis_mac_tlast;
  wire rx_axis_mac_tuser;
  wire rx_axis_mac_tvalid;
  wire [7:0]rx_data_reg;
  wire rx_mac_tdata0;
  wire rx_mac_tlast0;
  wire rx_mac_tuser0;
  wire rx_mac_tvalid0;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
FDRE \rx_data_reg_reg[0] 
       (.C(I1),
        .CE(I2),
        .D(I3[0]),
        .Q(rx_data_reg[0]),
        .R(\<const0> ));
FDRE \rx_data_reg_reg[1] 
       (.C(I1),
        .CE(I2),
        .D(I3[1]),
        .Q(rx_data_reg[1]),
        .R(\<const0> ));
FDRE \rx_data_reg_reg[2] 
       (.C(I1),
        .CE(I2),
        .D(I3[2]),
        .Q(rx_data_reg[2]),
        .R(\<const0> ));
FDRE \rx_data_reg_reg[3] 
       (.C(I1),
        .CE(I2),
        .D(I3[3]),
        .Q(rx_data_reg[3]),
        .R(\<const0> ));
FDRE \rx_data_reg_reg[4] 
       (.C(I1),
        .CE(I2),
        .D(I3[4]),
        .Q(rx_data_reg[4]),
        .R(\<const0> ));
FDRE \rx_data_reg_reg[5] 
       (.C(I1),
        .CE(I2),
        .D(I3[5]),
        .Q(rx_data_reg[5]),
        .R(\<const0> ));
FDRE \rx_data_reg_reg[6] 
       (.C(I1),
        .CE(I2),
        .D(I3[6]),
        .Q(rx_data_reg[6]),
        .R(\<const0> ));
FDRE \rx_data_reg_reg[7] 
       (.C(I1),
        .CE(I2),
        .D(I3[7]),
        .Q(rx_data_reg[7]),
        .R(\<const0> ));
LUT3 #(
    .INIT(8'h08)) 
     \rx_mac_tdata[7]_i_1 
       (.I0(I2),
        .I1(Q[0]),
        .I2(Q[1]),
        .O(rx_mac_tdata0));
FDRE #(
    .INIT(1'b0)) 
     \rx_mac_tdata_reg[0] 
       (.C(I1),
        .CE(rx_mac_tdata0),
        .D(rx_data_reg[0]),
        .Q(rx_axis_mac_tdata[0]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rx_mac_tdata_reg[1] 
       (.C(I1),
        .CE(rx_mac_tdata0),
        .D(rx_data_reg[1]),
        .Q(rx_axis_mac_tdata[1]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rx_mac_tdata_reg[2] 
       (.C(I1),
        .CE(rx_mac_tdata0),
        .D(rx_data_reg[2]),
        .Q(rx_axis_mac_tdata[2]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rx_mac_tdata_reg[3] 
       (.C(I1),
        .CE(rx_mac_tdata0),
        .D(rx_data_reg[3]),
        .Q(rx_axis_mac_tdata[3]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rx_mac_tdata_reg[4] 
       (.C(I1),
        .CE(rx_mac_tdata0),
        .D(rx_data_reg[4]),
        .Q(rx_axis_mac_tdata[4]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rx_mac_tdata_reg[5] 
       (.C(I1),
        .CE(rx_mac_tdata0),
        .D(rx_data_reg[5]),
        .Q(rx_axis_mac_tdata[5]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rx_mac_tdata_reg[6] 
       (.C(I1),
        .CE(rx_mac_tdata0),
        .D(rx_data_reg[6]),
        .Q(rx_axis_mac_tdata[6]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     \rx_mac_tdata_reg[7] 
       (.C(I1),
        .CE(rx_mac_tdata0),
        .D(rx_data_reg[7]),
        .Q(rx_axis_mac_tdata[7]),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     rx_mac_tlast_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(rx_mac_tlast0),
        .Q(rx_axis_mac_tlast),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     rx_mac_tuser_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(rx_mac_tuser0),
        .Q(rx_axis_mac_tuser),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     rx_mac_tvalid_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(rx_mac_tvalid0),
        .Q(rx_axis_mac_tvalid),
        .R(SR));
FDRE \rx_state_reg[0] 
       (.C(I1),
        .CE(I2),
        .D(D[0]),
        .Q(Q[0]),
        .R(SR));
FDRE \rx_state_reg[1] 
       (.C(I1),
        .CE(I2),
        .D(D[1]),
        .Q(Q[1]),
        .R(SR));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_rx_cntl
   (Q,
    rx_statistics_vector,
    O2,
    rx_good_frame_comb,
    O1,
    O3,
    O5,
    D,
    I3,
    I2,
    int_rx_data_valid_in,
    I1,
    int_rx_control_frame,
    int_rx_good_frame_in,
    data_out,
    bad_pfc_opcode_int,
    I12,
    I13,
    int_rx_bad_frame_in,
    SR,
    I14,
    I18);
  output [0:0]Q;
  output [0:0]rx_statistics_vector;
  output O2;
  output rx_good_frame_comb;
  output O1;
  output O3;
  output O5;
  output [15:0]D;
  input I3;
  input I2;
  input int_rx_data_valid_in;
  input I1;
  input int_rx_control_frame;
  input int_rx_good_frame_in;
  input data_out;
  input bad_pfc_opcode_int;
  input I12;
  input [7:0]I13;
  input int_rx_bad_frame_in;
  input [0:0]SR;
  input [0:0]I14;
  input I18;

  wire \<const0> ;
  wire \<const1> ;
  wire [15:0]D;
  wire I1;
  wire I12;
  wire [7:0]I13;
  wire [0:0]I14;
  wire I18;
  wire I2;
  wire I3;
  wire O1;
  wire O2;
  wire O3;
  wire O5;
  wire [0:0]Q;
  wire [0:0]SR;
  wire bad_fc_opcode_int2_out;
  wire bad_pfc_opcode_int;
  wire check_opcode;
  wire check_opcode4_out;
  wire data_count;
  wire [5:0]data_count_reg__0;
  wire data_out;
  wire int_rx_bad_frame_in;
  wire int_rx_control_frame;
  wire int_rx_data_valid_in;
  wire int_rx_good_frame_in;
  wire n_0_bad_fc_opcode_int_i_1;
  wire n_0_bad_fc_opcode_int_i_3;
  wire n_0_bad_fc_opcode_int_i_5;
  wire n_0_bad_pfc_opcode_int_i_1;
  wire n_0_check_opcode_i_1;
  wire \n_0_data_count[5]_i_3 ;
  wire \n_0_pause_opcode_early[7]_i_2 ;
  wire n_0_pause_req_int_i_1;
  wire \n_0_pause_value[0]_i_1 ;
  wire \n_0_pause_value[10]_i_1 ;
  wire \n_0_pause_value[11]_i_1 ;
  wire \n_0_pause_value[12]_i_1 ;
  wire \n_0_pause_value[13]_i_1 ;
  wire \n_0_pause_value[14]_i_1 ;
  wire \n_0_pause_value[15]_i_1 ;
  wire \n_0_pause_value[15]_i_2 ;
  wire \n_0_pause_value[1]_i_1 ;
  wire \n_0_pause_value[2]_i_1 ;
  wire \n_0_pause_value[3]_i_1 ;
  wire \n_0_pause_value[4]_i_1 ;
  wire \n_0_pause_value[5]_i_1 ;
  wire \n_0_pause_value[6]_i_1 ;
  wire \n_0_pause_value[7]_i_1 ;
  wire \n_0_pause_value[8]_i_1 ;
  wire \n_0_pause_value[9]_i_1 ;
  wire [5:0]p_0_in;
  wire [7:0]p_0_in_0;
  wire pause_req_int0_out;
  wire rx_good_frame_comb;
  wire [0:0]rx_statistics_vector;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
LUT6 #(
    .INIT(64'h000000000E0E0EEE)) 
     bad_fc_opcode_int_i_1
       (.I0(O1),
        .I1(bad_fc_opcode_int2_out),
        .I2(I2),
        .I3(int_rx_bad_frame_in),
        .I4(int_rx_good_frame_in),
        .I5(SR),
        .O(n_0_bad_fc_opcode_int_i_1));
(* SOFT_HLUTNM = "soft_lutpair120" *) 
   LUT3 #(
    .INIT(8'h08)) 
     bad_fc_opcode_int_i_2
       (.I0(check_opcode),
        .I1(I2),
        .I2(n_0_bad_fc_opcode_int_i_3),
        .O(bad_fc_opcode_int2_out));
LUT6 #(
    .INIT(64'h0001000000000000)) 
     bad_fc_opcode_int_i_3
       (.I0(p_0_in_0[1]),
        .I1(p_0_in_0[3]),
        .I2(p_0_in_0[2]),
        .I3(p_0_in_0[0]),
        .I4(I12),
        .I5(n_0_bad_fc_opcode_int_i_5),
        .O(n_0_bad_fc_opcode_int_i_3));
LUT6 #(
    .INIT(64'h0000000000000010)) 
     bad_fc_opcode_int_i_5
       (.I0(p_0_in_0[5]),
        .I1(p_0_in_0[4]),
        .I2(I13[0]),
        .I3(I13[1]),
        .I4(p_0_in_0[6]),
        .I5(p_0_in_0[7]),
        .O(n_0_bad_fc_opcode_int_i_5));
FDRE bad_fc_opcode_int_reg
       (.C(I3),
        .CE(\<const1> ),
        .D(n_0_bad_fc_opcode_int_i_1),
        .Q(O1),
        .R(\<const0> ));
LUT5 #(
    .INIT(32'hBBBB0BBB)) 
     bad_frame_int_i_2
       (.I0(O3),
        .I1(data_out),
        .I2(int_rx_control_frame),
        .I3(I1),
        .I4(O1),
        .O(O5));
LUT6 #(
    .INIT(64'h000000000A0A0AEA)) 
     bad_pfc_opcode_int_i_1
       (.I0(O3),
        .I1(check_opcode),
        .I2(I2),
        .I3(int_rx_bad_frame_in),
        .I4(int_rx_good_frame_in),
        .I5(SR),
        .O(n_0_bad_pfc_opcode_int_i_1));
FDRE bad_pfc_opcode_int_reg
       (.C(I3),
        .CE(\<const1> ),
        .D(n_0_bad_pfc_opcode_int_i_1),
        .Q(O3),
        .R(\<const0> ));
LUT4 #(
    .INIT(16'h002E)) 
     check_opcode_i_1
       (.I0(check_opcode),
        .I1(check_opcode4_out),
        .I2(data_count_reg__0[0]),
        .I3(bad_pfc_opcode_int),
        .O(n_0_check_opcode_i_1));
FDRE check_opcode_reg
       (.C(I3),
        .CE(\<const1> ),
        .D(n_0_check_opcode_i_1),
        .Q(check_opcode),
        .R(\<const0> ));
(* RETAIN_INVERTER *) 
   (* SOFT_HLUTNM = "soft_lutpair121" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \data_count[0]_i_1 
       (.I0(data_count_reg__0[0]),
        .O(p_0_in[0]));
(* SOFT_HLUTNM = "soft_lutpair121" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \data_count[1]_i_1 
       (.I0(data_count_reg__0[0]),
        .I1(data_count_reg__0[1]),
        .O(p_0_in[1]));
(* SOFT_HLUTNM = "soft_lutpair119" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \data_count[2]_i_1 
       (.I0(data_count_reg__0[2]),
        .I1(data_count_reg__0[1]),
        .I2(data_count_reg__0[0]),
        .O(p_0_in[2]));
(* SOFT_HLUTNM = "soft_lutpair118" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \data_count[3]_i_1 
       (.I0(data_count_reg__0[3]),
        .I1(data_count_reg__0[0]),
        .I2(data_count_reg__0[1]),
        .I3(data_count_reg__0[2]),
        .O(p_0_in[3]));
(* SOFT_HLUTNM = "soft_lutpair118" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \data_count[4]_i_1 
       (.I0(Q),
        .I1(data_count_reg__0[2]),
        .I2(data_count_reg__0[3]),
        .I3(data_count_reg__0[0]),
        .I4(data_count_reg__0[1]),
        .O(p_0_in[4]));
LUT3 #(
    .INIT(8'h80)) 
     \data_count[5]_i_1 
       (.I0(\n_0_data_count[5]_i_3 ),
        .I1(int_rx_data_valid_in),
        .I2(I2),
        .O(data_count));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \data_count[5]_i_2 
       (.I0(data_count_reg__0[5]),
        .I1(data_count_reg__0[1]),
        .I2(data_count_reg__0[0]),
        .I3(data_count_reg__0[3]),
        .I4(data_count_reg__0[2]),
        .I5(Q),
        .O(p_0_in[5]));
LUT6 #(
    .INIT(64'hFFFFFEFFFFFFFFFF)) 
     \data_count[5]_i_3 
       (.I0(data_count_reg__0[3]),
        .I1(data_count_reg__0[2]),
        .I2(data_count_reg__0[0]),
        .I3(data_count_reg__0[5]),
        .I4(Q),
        .I5(data_count_reg__0[1]),
        .O(\n_0_data_count[5]_i_3 ));
(* counter = "7" *) 
   FDRE \data_count_reg[0] 
       (.C(I3),
        .CE(data_count),
        .D(p_0_in[0]),
        .Q(data_count_reg__0[0]),
        .R(I14));
(* counter = "7" *) 
   FDRE \data_count_reg[1] 
       (.C(I3),
        .CE(data_count),
        .D(p_0_in[1]),
        .Q(data_count_reg__0[1]),
        .R(I14));
(* counter = "7" *) 
   FDRE \data_count_reg[2] 
       (.C(I3),
        .CE(data_count),
        .D(p_0_in[2]),
        .Q(data_count_reg__0[2]),
        .R(I14));
(* counter = "7" *) 
   FDRE \data_count_reg[3] 
       (.C(I3),
        .CE(data_count),
        .D(p_0_in[3]),
        .Q(data_count_reg__0[3]),
        .R(I14));
(* counter = "7" *) 
   FDRE \data_count_reg[4] 
       (.C(I3),
        .CE(data_count),
        .D(p_0_in[4]),
        .Q(Q),
        .R(I14));
(* counter = "7" *) 
   FDRE \data_count_reg[5] 
       (.C(I3),
        .CE(data_count),
        .D(p_0_in[5]),
        .Q(data_count_reg__0[5]),
        .R(I14));
LUT6 #(
    .INIT(64'h8AAA8AAA00008AAA)) 
     good_frame_int_i_1
       (.I0(int_rx_good_frame_in),
        .I1(O1),
        .I2(I1),
        .I3(int_rx_control_frame),
        .I4(data_out),
        .I5(O3),
        .O(rx_good_frame_comb));
LUT2 #(
    .INIT(4'h2)) 
     \pause_opcode_early[7]_i_2 
       (.I0(check_opcode4_out),
        .I1(data_count_reg__0[0]),
        .O(\n_0_pause_opcode_early[7]_i_2 ));
LUT6 #(
    .INIT(64'h0200000000000000)) 
     \pause_opcode_early[7]_i_3 
       (.I0(data_count_reg__0[1]),
        .I1(Q),
        .I2(data_count_reg__0[5]),
        .I3(I2),
        .I4(data_count_reg__0[2]),
        .I5(data_count_reg__0[3]),
        .O(check_opcode4_out));
FDRE \pause_opcode_early_reg[0] 
       (.C(I3),
        .CE(\n_0_pause_opcode_early[7]_i_2 ),
        .D(I13[0]),
        .Q(p_0_in_0[0]),
        .R(I14));
FDRE \pause_opcode_early_reg[1] 
       (.C(I3),
        .CE(\n_0_pause_opcode_early[7]_i_2 ),
        .D(I13[1]),
        .Q(p_0_in_0[1]),
        .R(I14));
FDRE \pause_opcode_early_reg[2] 
       (.C(I3),
        .CE(\n_0_pause_opcode_early[7]_i_2 ),
        .D(I13[2]),
        .Q(p_0_in_0[2]),
        .R(I14));
FDRE \pause_opcode_early_reg[3] 
       (.C(I3),
        .CE(\n_0_pause_opcode_early[7]_i_2 ),
        .D(I13[3]),
        .Q(p_0_in_0[3]),
        .R(I14));
FDRE \pause_opcode_early_reg[4] 
       (.C(I3),
        .CE(\n_0_pause_opcode_early[7]_i_2 ),
        .D(I13[4]),
        .Q(p_0_in_0[4]),
        .R(I14));
FDRE \pause_opcode_early_reg[5] 
       (.C(I3),
        .CE(\n_0_pause_opcode_early[7]_i_2 ),
        .D(I13[5]),
        .Q(p_0_in_0[5]),
        .R(I14));
FDRE \pause_opcode_early_reg[6] 
       (.C(I3),
        .CE(\n_0_pause_opcode_early[7]_i_2 ),
        .D(I13[6]),
        .Q(p_0_in_0[6]),
        .R(I14));
FDRE \pause_opcode_early_reg[7] 
       (.C(I3),
        .CE(\n_0_pause_opcode_early[7]_i_2 ),
        .D(I13[7]),
        .Q(p_0_in_0[7]),
        .R(I14));
LUT6 #(
    .INIT(64'h000000000E0E0EEE)) 
     pause_req_int_i_1
       (.I0(O2),
        .I1(pause_req_int0_out),
        .I2(I2),
        .I3(int_rx_bad_frame_in),
        .I4(int_rx_good_frame_in),
        .I5(SR),
        .O(n_0_pause_req_int_i_1));
(* SOFT_HLUTNM = "soft_lutpair120" *) 
   LUT3 #(
    .INIT(8'h80)) 
     pause_req_int_i_2
       (.I0(check_opcode),
        .I1(I2),
        .I2(n_0_bad_fc_opcode_int_i_3),
        .O(pause_req_int0_out));
FDRE pause_req_int_reg
       (.C(I3),
        .CE(\<const1> ),
        .D(n_0_pause_req_int_i_1),
        .Q(O2),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h00000000EAAA2AAA)) 
     \pause_value[0]_i_1 
       (.I0(D[0]),
        .I1(data_count_reg__0[0]),
        .I2(I18),
        .I3(\n_0_pause_value[15]_i_2 ),
        .I4(I13[0]),
        .I5(SR),
        .O(\n_0_pause_value[0]_i_1 ));
LUT6 #(
    .INIT(64'h00000000BAAA8AAA)) 
     \pause_value[10]_i_1 
       (.I0(D[10]),
        .I1(data_count_reg__0[0]),
        .I2(\n_0_pause_value[15]_i_2 ),
        .I3(I18),
        .I4(I13[2]),
        .I5(SR),
        .O(\n_0_pause_value[10]_i_1 ));
LUT6 #(
    .INIT(64'h00000000BAAA8AAA)) 
     \pause_value[11]_i_1 
       (.I0(D[11]),
        .I1(data_count_reg__0[0]),
        .I2(\n_0_pause_value[15]_i_2 ),
        .I3(I18),
        .I4(I13[3]),
        .I5(SR),
        .O(\n_0_pause_value[11]_i_1 ));
LUT6 #(
    .INIT(64'h00000000BAAA8AAA)) 
     \pause_value[12]_i_1 
       (.I0(D[12]),
        .I1(data_count_reg__0[0]),
        .I2(\n_0_pause_value[15]_i_2 ),
        .I3(I18),
        .I4(I13[4]),
        .I5(SR),
        .O(\n_0_pause_value[12]_i_1 ));
LUT6 #(
    .INIT(64'h00000000BAAA8AAA)) 
     \pause_value[13]_i_1 
       (.I0(D[13]),
        .I1(data_count_reg__0[0]),
        .I2(\n_0_pause_value[15]_i_2 ),
        .I3(I18),
        .I4(I13[5]),
        .I5(SR),
        .O(\n_0_pause_value[13]_i_1 ));
LUT6 #(
    .INIT(64'h00000000BAAA8AAA)) 
     \pause_value[14]_i_1 
       (.I0(D[14]),
        .I1(data_count_reg__0[0]),
        .I2(\n_0_pause_value[15]_i_2 ),
        .I3(I18),
        .I4(I13[6]),
        .I5(SR),
        .O(\n_0_pause_value[14]_i_1 ));
LUT6 #(
    .INIT(64'h00000000BAAA8AAA)) 
     \pause_value[15]_i_1 
       (.I0(D[15]),
        .I1(data_count_reg__0[0]),
        .I2(\n_0_pause_value[15]_i_2 ),
        .I3(I18),
        .I4(I13[7]),
        .I5(SR),
        .O(\n_0_pause_value[15]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair119" *) 
   LUT4 #(
    .INIT(16'h0001)) 
     \pause_value[15]_i_2 
       (.I0(data_count_reg__0[3]),
        .I1(data_count_reg__0[2]),
        .I2(data_count_reg__0[5]),
        .I3(data_count_reg__0[1]),
        .O(\n_0_pause_value[15]_i_2 ));
LUT6 #(
    .INIT(64'h00000000EAAA2AAA)) 
     \pause_value[1]_i_1 
       (.I0(D[1]),
        .I1(data_count_reg__0[0]),
        .I2(I18),
        .I3(\n_0_pause_value[15]_i_2 ),
        .I4(I13[1]),
        .I5(SR),
        .O(\n_0_pause_value[1]_i_1 ));
LUT6 #(
    .INIT(64'h00000000EAAA2AAA)) 
     \pause_value[2]_i_1 
       (.I0(D[2]),
        .I1(data_count_reg__0[0]),
        .I2(I18),
        .I3(\n_0_pause_value[15]_i_2 ),
        .I4(I13[2]),
        .I5(SR),
        .O(\n_0_pause_value[2]_i_1 ));
LUT6 #(
    .INIT(64'h00000000EAAA2AAA)) 
     \pause_value[3]_i_1 
       (.I0(D[3]),
        .I1(data_count_reg__0[0]),
        .I2(I18),
        .I3(\n_0_pause_value[15]_i_2 ),
        .I4(I13[3]),
        .I5(SR),
        .O(\n_0_pause_value[3]_i_1 ));
LUT6 #(
    .INIT(64'h00000000EAAA2AAA)) 
     \pause_value[4]_i_1 
       (.I0(D[4]),
        .I1(data_count_reg__0[0]),
        .I2(I18),
        .I3(\n_0_pause_value[15]_i_2 ),
        .I4(I13[4]),
        .I5(SR),
        .O(\n_0_pause_value[4]_i_1 ));
LUT6 #(
    .INIT(64'h00000000EAAA2AAA)) 
     \pause_value[5]_i_1 
       (.I0(D[5]),
        .I1(data_count_reg__0[0]),
        .I2(I18),
        .I3(\n_0_pause_value[15]_i_2 ),
        .I4(I13[5]),
        .I5(SR),
        .O(\n_0_pause_value[5]_i_1 ));
LUT6 #(
    .INIT(64'h00000000EAAA2AAA)) 
     \pause_value[6]_i_1 
       (.I0(D[6]),
        .I1(data_count_reg__0[0]),
        .I2(I18),
        .I3(\n_0_pause_value[15]_i_2 ),
        .I4(I13[6]),
        .I5(SR),
        .O(\n_0_pause_value[6]_i_1 ));
LUT6 #(
    .INIT(64'h00000000EAAA2AAA)) 
     \pause_value[7]_i_1 
       (.I0(D[7]),
        .I1(data_count_reg__0[0]),
        .I2(I18),
        .I3(\n_0_pause_value[15]_i_2 ),
        .I4(I13[7]),
        .I5(SR),
        .O(\n_0_pause_value[7]_i_1 ));
LUT6 #(
    .INIT(64'h00000000BAAA8AAA)) 
     \pause_value[8]_i_1 
       (.I0(D[8]),
        .I1(data_count_reg__0[0]),
        .I2(\n_0_pause_value[15]_i_2 ),
        .I3(I18),
        .I4(I13[0]),
        .I5(SR),
        .O(\n_0_pause_value[8]_i_1 ));
LUT6 #(
    .INIT(64'h00000000BAAA8AAA)) 
     \pause_value[9]_i_1 
       (.I0(D[9]),
        .I1(data_count_reg__0[0]),
        .I2(\n_0_pause_value[15]_i_2 ),
        .I3(I18),
        .I4(I13[1]),
        .I5(SR),
        .O(\n_0_pause_value[9]_i_1 ));
FDRE \pause_value_reg[0] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[0]_i_1 ),
        .Q(D[0]),
        .R(\<const0> ));
FDRE \pause_value_reg[10] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[10]_i_1 ),
        .Q(D[10]),
        .R(\<const0> ));
FDRE \pause_value_reg[11] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[11]_i_1 ),
        .Q(D[11]),
        .R(\<const0> ));
FDRE \pause_value_reg[12] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[12]_i_1 ),
        .Q(D[12]),
        .R(\<const0> ));
FDRE \pause_value_reg[13] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[13]_i_1 ),
        .Q(D[13]),
        .R(\<const0> ));
FDRE \pause_value_reg[14] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[14]_i_1 ),
        .Q(D[14]),
        .R(\<const0> ));
FDRE \pause_value_reg[15] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[15]_i_1 ),
        .Q(D[15]),
        .R(\<const0> ));
FDRE \pause_value_reg[1] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[1]_i_1 ),
        .Q(D[1]),
        .R(\<const0> ));
FDRE \pause_value_reg[2] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[2]_i_1 ),
        .Q(D[2]),
        .R(\<const0> ));
FDRE \pause_value_reg[3] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[3]_i_1 ),
        .Q(D[3]),
        .R(\<const0> ));
FDRE \pause_value_reg[4] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[4]_i_1 ),
        .Q(D[4]),
        .R(\<const0> ));
FDRE \pause_value_reg[5] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[5]_i_1 ),
        .Q(D[5]),
        .R(\<const0> ));
FDRE \pause_value_reg[6] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[6]_i_1 ),
        .Q(D[6]),
        .R(\<const0> ));
FDRE \pause_value_reg[7] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[7]_i_1 ),
        .Q(D[7]),
        .R(\<const0> ));
FDRE \pause_value_reg[8] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[8]_i_1 ),
        .Q(D[8]),
        .R(\<const0> ));
FDRE \pause_value_reg[9] 
       (.C(I3),
        .CE(\<const1> ),
        .D(\n_0_pause_value[9]_i_1 ),
        .Q(D[9]),
        .R(\<const0> ));
LUT4 #(
    .INIT(16'h8000)) 
     \statistics_vector[23]_INST_0 
       (.I0(I1),
        .I1(int_rx_control_frame),
        .I2(O2),
        .I3(int_rx_good_frame_in),
        .O(rx_statistics_vector));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_rx_sync_req
   (data_in,
    O1,
    Q,
    I3,
    I2,
    rx_statistics_vector,
    SR,
    E,
    D);
  output data_in;
  output O1;
  output [15:0]Q;
  input I3;
  input I2;
  input [0:0]rx_statistics_vector;
  input [0:0]SR;
  input [0:0]E;
  input [15:0]D;

  wire \<const0> ;
  wire \<const1> ;
  wire [15:0]D;
  wire [0:0]E;
  wire I2;
  wire I3;
  wire O1;
  wire [15:0]Q;
  wire [0:0]SR;
  wire data_in;
  wire n_0_count_set_i_4;
  wire n_0_count_set_i_5;
  wire n_0_pause_req_to_tx_int_i_1;
  wire [0:0]rx_statistics_vector;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     count_set_i_2
       (.I0(Q[4]),
        .I1(Q[7]),
        .I2(Q[5]),
        .I3(Q[6]),
        .I4(n_0_count_set_i_4),
        .I5(n_0_count_set_i_5),
        .O(O1));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     count_set_i_4
       (.I0(Q[10]),
        .I1(Q[9]),
        .I2(Q[14]),
        .I3(Q[15]),
        .I4(Q[12]),
        .I5(Q[13]),
        .O(n_0_count_set_i_4));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     count_set_i_5
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[8]),
        .I3(Q[11]),
        .I4(Q[2]),
        .I5(Q[3]),
        .O(n_0_count_set_i_5));
LUT4 #(
    .INIT(16'h006A)) 
     pause_req_to_tx_int_i_1
       (.I0(data_in),
        .I1(I2),
        .I2(rx_statistics_vector),
        .I3(SR),
        .O(n_0_pause_req_to_tx_int_i_1));
FDRE pause_req_to_tx_int_reg
       (.C(I3),
        .CE(\<const1> ),
        .D(n_0_pause_req_to_tx_int_i_1),
        .Q(data_in),
        .R(\<const0> ));
FDRE \pause_value_to_tx_reg[0] 
       (.C(I3),
        .CE(E),
        .D(D[0]),
        .Q(Q[0]),
        .R(SR));
FDRE \pause_value_to_tx_reg[10] 
       (.C(I3),
        .CE(E),
        .D(D[10]),
        .Q(Q[10]),
        .R(SR));
FDRE \pause_value_to_tx_reg[11] 
       (.C(I3),
        .CE(E),
        .D(D[11]),
        .Q(Q[11]),
        .R(SR));
FDRE \pause_value_to_tx_reg[12] 
       (.C(I3),
        .CE(E),
        .D(D[12]),
        .Q(Q[12]),
        .R(SR));
FDRE \pause_value_to_tx_reg[13] 
       (.C(I3),
        .CE(E),
        .D(D[13]),
        .Q(Q[13]),
        .R(SR));
FDRE \pause_value_to_tx_reg[14] 
       (.C(I3),
        .CE(E),
        .D(D[14]),
        .Q(Q[14]),
        .R(SR));
FDRE \pause_value_to_tx_reg[15] 
       (.C(I3),
        .CE(E),
        .D(D[15]),
        .Q(Q[15]),
        .R(SR));
FDRE \pause_value_to_tx_reg[1] 
       (.C(I3),
        .CE(E),
        .D(D[1]),
        .Q(Q[1]),
        .R(SR));
FDRE \pause_value_to_tx_reg[2] 
       (.C(I3),
        .CE(E),
        .D(D[2]),
        .Q(Q[2]),
        .R(SR));
FDRE \pause_value_to_tx_reg[3] 
       (.C(I3),
        .CE(E),
        .D(D[3]),
        .Q(Q[3]),
        .R(SR));
FDRE \pause_value_to_tx_reg[4] 
       (.C(I3),
        .CE(E),
        .D(D[4]),
        .Q(Q[4]),
        .R(SR));
FDRE \pause_value_to_tx_reg[5] 
       (.C(I3),
        .CE(E),
        .D(D[5]),
        .Q(Q[5]),
        .R(SR));
FDRE \pause_value_to_tx_reg[6] 
       (.C(I3),
        .CE(E),
        .D(D[6]),
        .Q(Q[6]),
        .R(SR));
FDRE \pause_value_to_tx_reg[7] 
       (.C(I3),
        .CE(E),
        .D(D[7]),
        .Q(Q[7]),
        .R(SR));
FDRE \pause_value_to_tx_reg[8] 
       (.C(I3),
        .CE(E),
        .D(D[8]),
        .Q(Q[8]),
        .R(SR));
FDRE \pause_value_to_tx_reg[9] 
       (.C(I3),
        .CE(E),
        .D(D[9]),
        .Q(Q[9]),
        .R(SR));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_sync_block
   (data_out,
    gtx_clk);
  output data_out;
  input gtx_clk;

  wire \<const0> ;
  wire \<const1> ;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire gtx_clk;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block_1
   (O1,
    data_out,
    tx_configuration_vector,
    gtx_clk);
  output O1;
  input data_out;
  input [0:0]tx_configuration_vector;
  input gtx_clk;

  wire \<const0> ;
  wire \<const1> ;
  wire O1;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire gtx_clk;
  wire [0:0]tx_configuration_vector;
  wire tx_enable_sync;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(tx_configuration_vector),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(tx_enable_sync),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'h2)) 
     tx_enable_reg_i_1
       (.I0(tx_enable_sync),
        .I1(data_out),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block_11
   (O1,
    address_match1,
    rx_data_valid_reg2,
    I1,
    I2,
    SR,
    rx_configuration_vector,
    I3);
  output O1;
  input address_match1;
  input rx_data_valid_reg2;
  input I1;
  input I2;
  input [0:0]SR;
  input [0:0]rx_configuration_vector;
  input I3;

  wire \<const0> ;
  wire \<const1> ;
  wire I1;
  wire I2;
  wire I3;
  wire O1;
  wire [0:0]SR;
  wire address_match1;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire promiscuous_mode_resync;
  wire [0:0]rx_configuration_vector;
  wire rx_data_valid_reg2;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(I3),
        .CE(\<const1> ),
        .D(rx_configuration_vector),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(promiscuous_mode_resync),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'hFFFFFFFFBAAA8AAA)) 
     promiscuous_mode_sample_i_1
       (.I0(address_match1),
        .I1(rx_data_valid_reg2),
        .I2(I1),
        .I3(I2),
        .I4(promiscuous_mode_resync),
        .I5(SR),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block_12
   (data_out,
    O1,
    O2,
    update_pause_ad_sync_reg,
    I4,
    I5,
    Q,
    SR,
    I1);
  output data_out;
  output O1;
  output O2;
  input update_pause_ad_sync_reg;
  input I4;
  input I5;
  input [2:0]Q;
  input [0:0]SR;
  input I1;

  wire \<const0> ;
  wire \<const1> ;
  wire I1;
  wire I4;
  wire I5;
  wire O1;
  wire O2;
  wire [2:0]Q;
  wire [0:0]SR;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire n_0_load_wr_i_2;
  wire update_pause_ad_sync_reg;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(I1),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
LUT5 #(
    .INIT(32'h0000001F)) 
     load_wr_i_1
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(n_0_load_wr_i_2),
        .I4(SR),
        .O(O1));
(* SOFT_HLUTNM = "soft_lutpair65" *) 
   LUT4 #(
    .INIT(16'h0666)) 
     load_wr_i_2
       (.I0(update_pause_ad_sync_reg),
        .I1(data_out),
        .I2(I4),
        .I3(I5),
        .O(n_0_load_wr_i_2));
(* SOFT_HLUTNM = "soft_lutpair65" *) 
   LUT4 #(
    .INIT(16'hBF80)) 
     update_pause_ad_sync_reg_i_1
       (.I0(update_pause_ad_sync_reg),
        .I1(I5),
        .I2(I4),
        .I3(data_out),
        .O(O2));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block_2
   (data_out,
    gtx_clk);
  output data_out;
  input gtx_clk;

  wire \<const0> ;
  wire \<const1> ;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire gtx_clk;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block_3
   (data_out,
    I3);
  output data_out;
  input I3;

  wire \<const0> ;
  wire \<const1> ;
  wire I3;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(I3),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block_4
   (data_out,
    I3);
  output data_out;
  input I3;

  wire \<const0> ;
  wire \<const1> ;
  wire I3;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(I3),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block_5
   (O1,
    rx_half_duplex_sync,
    rx_configuration_vector,
    I3);
  output O1;
  input rx_half_duplex_sync;
  input [0:0]rx_configuration_vector;
  input I3;

  wire \<const0> ;
  wire \<const1> ;
  wire I3;
  wire O1;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire [0:0]rx_configuration_vector;
  wire rx_enable_sync;
  wire rx_half_duplex_sync;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(I3),
        .CE(\<const1> ),
        .D(rx_configuration_vector),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(I3),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(rx_enable_sync),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'h2)) 
     rx_enable_reg_i_1
       (.I0(rx_enable_sync),
        .I1(rx_half_duplex_sync),
        .O(O1));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block_6
   (O,
    O1,
    O2,
    O3,
    SR,
    data_out,
    O4,
    O5,
    O6,
    tx_ce_sample,
    pause_req_in_tx_reg,
    I1,
    I2,
    I3,
    I4,
    pause_status_req,
    I5,
    Q,
    pause_count_reg,
    I6,
    data_in,
    gtx_clk);
  output [3:0]O;
  output [3:0]O1;
  output [3:0]O2;
  output [3:0]O3;
  output [0:0]SR;
  output data_out;
  output O4;
  output O5;
  output O6;
  input tx_ce_sample;
  input pause_req_in_tx_reg;
  input I1;
  input I2;
  input I3;
  input I4;
  input pause_status_req;
  input I5;
  input [0:0]Q;
  input [15:0]pause_count_reg;
  input [15:0]I6;
  input data_in;
  input gtx_clk;

  wire \<const0> ;
  wire \<const1> ;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire [15:0]I6;
  wire [3:0]O;
  wire [3:0]O1;
  wire [3:0]O2;
  wire [3:0]O3;
  wire O4;
  wire O5;
  wire O6;
  wire [0:0]Q;
  wire [0:0]SR;
  wire data_in;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire gtx_clk;
  wire n_0_count_set_i_3;
  wire \n_0_pause_count[0]_i_3 ;
  wire \n_0_pause_count[0]_i_4 ;
  wire \n_0_pause_count[0]_i_5 ;
  wire \n_0_pause_count[0]_i_6 ;
  wire \n_0_pause_count[0]_i_7 ;
  wire \n_0_pause_count[12]_i_2 ;
  wire \n_0_pause_count[12]_i_3 ;
  wire \n_0_pause_count[12]_i_4 ;
  wire \n_0_pause_count[12]_i_5 ;
  wire \n_0_pause_count[4]_i_2 ;
  wire \n_0_pause_count[4]_i_3 ;
  wire \n_0_pause_count[4]_i_4 ;
  wire \n_0_pause_count[4]_i_5 ;
  wire \n_0_pause_count[8]_i_2 ;
  wire \n_0_pause_count[8]_i_3 ;
  wire \n_0_pause_count[8]_i_4 ;
  wire \n_0_pause_count[8]_i_5 ;
  wire \n_0_pause_count_reg[0]_i_2 ;
  wire \n_0_pause_count_reg[4]_i_1 ;
  wire \n_0_pause_count_reg[8]_i_1 ;
  wire n_0_pause_dec_i_3;
  wire \n_1_pause_count_reg[0]_i_2 ;
  wire \n_1_pause_count_reg[12]_i_1 ;
  wire \n_1_pause_count_reg[4]_i_1 ;
  wire \n_1_pause_count_reg[8]_i_1 ;
  wire \n_2_pause_count_reg[0]_i_2 ;
  wire \n_2_pause_count_reg[12]_i_1 ;
  wire \n_2_pause_count_reg[4]_i_1 ;
  wire \n_2_pause_count_reg[8]_i_1 ;
  wire \n_3_pause_count_reg[0]_i_2 ;
  wire \n_3_pause_count_reg[12]_i_1 ;
  wire \n_3_pause_count_reg[4]_i_1 ;
  wire \n_3_pause_count_reg[8]_i_1 ;
  wire [15:0]pause_count_reg;
  wire pause_req_in_tx_reg;
  wire pause_status_req;
  wire tx_ce_sample;
  wire [3:3]\NLW_pause_count_reg[12]_i_1_CO_UNCONNECTED ;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
LUT6 #(
    .INIT(64'h00B300BF00800080)) 
     count_set_i_1
       (.I0(I4),
        .I1(tx_ce_sample),
        .I2(n_0_count_set_i_3),
        .I3(I2),
        .I4(I1),
        .I5(pause_status_req),
        .O(O5));
(* SOFT_HLUTNM = "soft_lutpair156" *) 
   LUT2 #(
    .INIT(4'h6)) 
     count_set_i_3
       (.I0(data_out),
        .I1(pause_req_in_tx_reg),
        .O(n_0_count_set_i_3));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_in),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair156" *) 
   LUT5 #(
    .INIT(32'hAA282828)) 
     \pause_count[0]_i_1 
       (.I0(tx_ce_sample),
        .I1(data_out),
        .I2(pause_req_in_tx_reg),
        .I3(I1),
        .I4(I3),
        .O(O4));
LUT2 #(
    .INIT(4'h9)) 
     \pause_count[0]_i_3 
       (.I0(pause_req_in_tx_reg),
        .I1(data_out),
        .O(\n_0_pause_count[0]_i_3 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[0]_i_4 
       (.I0(pause_count_reg[3]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[3]),
        .O(\n_0_pause_count[0]_i_4 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[0]_i_5 
       (.I0(pause_count_reg[2]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[2]),
        .O(\n_0_pause_count[0]_i_5 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[0]_i_6 
       (.I0(pause_count_reg[1]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[1]),
        .O(\n_0_pause_count[0]_i_6 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[0]_i_7 
       (.I0(pause_count_reg[0]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[0]),
        .O(\n_0_pause_count[0]_i_7 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[12]_i_2 
       (.I0(pause_count_reg[15]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[15]),
        .O(\n_0_pause_count[12]_i_2 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[12]_i_3 
       (.I0(pause_count_reg[14]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[14]),
        .O(\n_0_pause_count[12]_i_3 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[12]_i_4 
       (.I0(pause_count_reg[13]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[13]),
        .O(\n_0_pause_count[12]_i_4 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[12]_i_5 
       (.I0(pause_count_reg[12]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[12]),
        .O(\n_0_pause_count[12]_i_5 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[4]_i_2 
       (.I0(pause_count_reg[7]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[7]),
        .O(\n_0_pause_count[4]_i_2 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[4]_i_3 
       (.I0(pause_count_reg[6]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[6]),
        .O(\n_0_pause_count[4]_i_3 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[4]_i_4 
       (.I0(pause_count_reg[5]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[5]),
        .O(\n_0_pause_count[4]_i_4 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[4]_i_5 
       (.I0(pause_count_reg[4]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[4]),
        .O(\n_0_pause_count[4]_i_5 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[8]_i_2 
       (.I0(pause_count_reg[11]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[11]),
        .O(\n_0_pause_count[8]_i_2 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[8]_i_3 
       (.I0(pause_count_reg[10]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[10]),
        .O(\n_0_pause_count[8]_i_3 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[8]_i_4 
       (.I0(pause_count_reg[9]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[9]),
        .O(\n_0_pause_count[8]_i_4 ));
LUT4 #(
    .INIT(16'h7D41)) 
     \pause_count[8]_i_5 
       (.I0(pause_count_reg[8]),
        .I1(pause_req_in_tx_reg),
        .I2(data_out),
        .I3(I6[8]),
        .O(\n_0_pause_count[8]_i_5 ));
CARRY4 \pause_count_reg[0]_i_2 
       (.CI(\<const0> ),
        .CO({\n_0_pause_count_reg[0]_i_2 ,\n_1_pause_count_reg[0]_i_2 ,\n_2_pause_count_reg[0]_i_2 ,\n_3_pause_count_reg[0]_i_2 }),
        .CYINIT(\<const0> ),
        .DI({\n_0_pause_count[0]_i_3 ,\n_0_pause_count[0]_i_3 ,\n_0_pause_count[0]_i_3 ,\n_0_pause_count[0]_i_3 }),
        .O(O),
        .S({\n_0_pause_count[0]_i_4 ,\n_0_pause_count[0]_i_5 ,\n_0_pause_count[0]_i_6 ,\n_0_pause_count[0]_i_7 }));
CARRY4 \pause_count_reg[12]_i_1 
       (.CI(\n_0_pause_count_reg[8]_i_1 ),
        .CO({\NLW_pause_count_reg[12]_i_1_CO_UNCONNECTED [3],\n_1_pause_count_reg[12]_i_1 ,\n_2_pause_count_reg[12]_i_1 ,\n_3_pause_count_reg[12]_i_1 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\n_0_pause_count[0]_i_3 ,\n_0_pause_count[0]_i_3 ,\n_0_pause_count[0]_i_3 }),
        .O(O3),
        .S({\n_0_pause_count[12]_i_2 ,\n_0_pause_count[12]_i_3 ,\n_0_pause_count[12]_i_4 ,\n_0_pause_count[12]_i_5 }));
CARRY4 \pause_count_reg[4]_i_1 
       (.CI(\n_0_pause_count_reg[0]_i_2 ),
        .CO({\n_0_pause_count_reg[4]_i_1 ,\n_1_pause_count_reg[4]_i_1 ,\n_2_pause_count_reg[4]_i_1 ,\n_3_pause_count_reg[4]_i_1 }),
        .CYINIT(\<const0> ),
        .DI({\n_0_pause_count[0]_i_3 ,\n_0_pause_count[0]_i_3 ,\n_0_pause_count[0]_i_3 ,\n_0_pause_count[0]_i_3 }),
        .O(O1),
        .S({\n_0_pause_count[4]_i_2 ,\n_0_pause_count[4]_i_3 ,\n_0_pause_count[4]_i_4 ,\n_0_pause_count[4]_i_5 }));
CARRY4 \pause_count_reg[8]_i_1 
       (.CI(\n_0_pause_count_reg[4]_i_1 ),
        .CO({\n_0_pause_count_reg[8]_i_1 ,\n_1_pause_count_reg[8]_i_1 ,\n_2_pause_count_reg[8]_i_1 ,\n_3_pause_count_reg[8]_i_1 }),
        .CYINIT(\<const0> ),
        .DI({\n_0_pause_count[0]_i_3 ,\n_0_pause_count[0]_i_3 ,\n_0_pause_count[0]_i_3 ,\n_0_pause_count[0]_i_3 }),
        .O(O2),
        .S({\n_0_pause_count[8]_i_2 ,\n_0_pause_count[8]_i_3 ,\n_0_pause_count[8]_i_4 ,\n_0_pause_count[8]_i_5 }));
LUT6 #(
    .INIT(64'hC000C000AA00AAAA)) 
     pause_dec_i_1
       (.I0(I3),
        .I1(I5),
        .I2(Q),
        .I3(n_0_pause_dec_i_3),
        .I4(I2),
        .I5(tx_ce_sample),
        .O(O6));
(* SOFT_HLUTNM = "soft_lutpair157" *) 
   LUT4 #(
    .INIT(16'h4004)) 
     pause_dec_i_3
       (.I0(I2),
        .I1(I1),
        .I2(pause_req_in_tx_reg),
        .I3(data_out),
        .O(n_0_pause_dec_i_3));
(* SOFT_HLUTNM = "soft_lutpair157" *) 
   LUT5 #(
    .INIT(32'hFFFF28AA)) 
     \quanta_count[5]_i_1 
       (.I0(tx_ce_sample),
        .I1(data_out),
        .I2(pause_req_in_tx_reg),
        .I3(I1),
        .I4(I2),
        .O(SR));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1
   (data_out,
    tx_configuration_vector,
    I1);
  output data_out;
  input [0:0]tx_configuration_vector;
  input I1;

  wire \<const0> ;
  wire \<const1> ;
  wire I1;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire [0:0]tx_configuration_vector;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(I1),
        .CE(\<const1> ),
        .D(tx_configuration_vector),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_13
   (data_out,
    tx_configuration_vector,
    gtx_clk);
  output data_out;
  input [0:0]tx_configuration_vector;
  input gtx_clk;

  wire \<const0> ;
  wire \<const1> ;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire gtx_clk;
  wire [0:0]tx_configuration_vector;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(tx_configuration_vector),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_14
   (data_out,
    tx_configuration_vector,
    gtx_clk);
  output data_out;
  input [0:0]tx_configuration_vector;
  input gtx_clk;

  wire \<const0> ;
  wire \<const1> ;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire gtx_clk;
  wire [0:0]tx_configuration_vector;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(tx_configuration_vector),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_block" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_7
   (data_out,
    tx_configuration_vector,
    I1);
  output data_out;
  input [0:0]tx_configuration_vector;
  input I1;

  wire \<const0> ;
  wire \<const1> ;
  wire I1;
  wire data_out;
  wire data_sync0;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire [0:0]tx_configuration_vector;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg0
       (.C(I1),
        .CE(\<const1> ),
        .D(tx_configuration_vector),
        .Q(data_sync0),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg1
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync0),
        .Q(data_sync1),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg2
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync1),
        .Q(data_sync2),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg3
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync2),
        .Q(data_sync3),
        .R(\<const0> ));
(* ASYNC_REG *) 
   (* BOX_TYPE = "PRIMITIVE" *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
     data_sync_reg4
       (.C(I1),
        .CE(\<const1> ),
        .D(data_sync3),
        .Q(data_out),
        .R(\<const0> ));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_sync_reset
   (O1,
    SR,
    O2,
    O3,
    O4,
    gtx_clk,
    counter0,
    \hd_tieoff.extension_reg_reg ,
    phy_tx_enable,
    CRC_OK,
    tx_axi_rstn,
    tx_configuration_vector,
    glbl_rstn);
  output O1;
  output [0:0]SR;
  output O2;
  output [0:0]O3;
  output O4;
  input gtx_clk;
  input counter0;
  input \hd_tieoff.extension_reg_reg ;
  input phy_tx_enable;
  input CRC_OK;
  input tx_axi_rstn;
  input [0:0]tx_configuration_vector;
  input glbl_rstn;

  wire \<const0> ;
  wire \<const1> ;
  wire CRC_OK;
  wire O1;
  wire O2;
  wire [0:0]O3;
  wire O4;
  wire [0:0]SR;
  wire async_rst0;
  wire async_rst1;
  wire async_rst2;
  wire async_rst3;
  wire async_rst4;
  wire counter0;
  wire glbl_rstn;
  wire gtx_clk;
  wire \hd_tieoff.extension_reg_reg ;
  wire int_tx_rst_asynch;
  wire n_0_sync_rst1_i_1;
  wire phy_tx_enable;
  wire sync_rst0;
  wire tx_axi_rstn;
  wire [0:0]tx_configuration_vector;

GND GND
       (.G(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair29" *) 
   LUT2 #(
    .INIT(4'h1)) 
     \IFG_COUNT[0]_i_3 
       (.I0(O1),
        .I1(CRC_OK),
        .O(O4));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     async_rst0_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .PRE(int_tx_rst_asynch),
        .Q(async_rst0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     async_rst1_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(async_rst0),
        .PRE(int_tx_rst_asynch),
        .Q(async_rst1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     async_rst2_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(async_rst1),
        .PRE(int_tx_rst_asynch),
        .Q(async_rst2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     async_rst3_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(async_rst2),
        .PRE(int_tx_rst_asynch),
        .Q(async_rst3));
LUT3 #(
    .INIT(8'hDF)) 
     async_rst4_i_1__0
       (.I0(tx_axi_rstn),
        .I1(tx_configuration_vector),
        .I2(glbl_rstn),
        .O(int_tx_rst_asynch));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     async_rst4_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(async_rst3),
        .PRE(int_tx_rst_asynch),
        .Q(async_rst4));
(* SOFT_HLUTNM = "soft_lutpair29" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \counter[5]_i_1 
       (.I0(O1),
        .I1(counter0),
        .O(SR));
(* SOFT_HLUTNM = "soft_lutpair28" *) 
   LUT3 #(
    .INIT(8'hEA)) 
     gmii_tx_en_to_phy_i_2
       (.I0(O1),
        .I1(\hd_tieoff.extension_reg_reg ),
        .I2(phy_tx_enable),
        .O(O2));
(* SOFT_HLUTNM = "soft_lutpair28" *) 
   LUT3 #(
    .INIT(8'hEA)) 
     \gmii_txd_to_phy[7]_i_1 
       (.I0(O1),
        .I1(\hd_tieoff.extension_reg_reg ),
        .I2(phy_tx_enable),
        .O(O3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b1)) 
     sync_rst0_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(async_rst4),
        .Q(sync_rst0),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'hE)) 
     sync_rst1_i_1
       (.I0(sync_rst0),
        .I1(async_rst4),
        .O(n_0_sync_rst1_i_1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b1)) 
     sync_rst1_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_sync_rst1_i_1),
        .Q(O1),
        .R(\<const0> ));
endmodule

(* ORIG_REF_NAME = "tri_mode_ethernet_mac_v8_1_sync_reset" *) 
module TriMACtri_mode_ethernet_mac_v8_1_sync_reset_0
   (SR,
    O1,
    I14,
    I1,
    I2,
    END_OF_FRAME,
    rx_axi_rstn,
    rx_configuration_vector,
    glbl_rstn);
  output [0:0]SR;
  output O1;
  output [0:0]I14;
  input I1;
  input I2;
  input END_OF_FRAME;
  input rx_axi_rstn;
  input [0:0]rx_configuration_vector;
  input glbl_rstn;

  wire \<const0> ;
  wire \<const1> ;
  wire END_OF_FRAME;
  wire I1;
  wire [0:0]I14;
  wire I2;
  wire O1;
  wire [0:0]SR;
  wire glbl_rstn;
  wire int_rx_rst_asynch;
  wire n_0_async_rst0_reg;
  wire n_0_async_rst1_reg;
  wire n_0_async_rst2_reg;
  wire n_0_async_rst3_reg;
  wire n_0_async_rst4_reg;
  wire n_0_sync_rst0_reg;
  wire n_0_sync_rst1_i_1__0;
  wire rx_axi_rstn;
  wire [0:0]rx_configuration_vector;

(* SOFT_HLUTNM = "soft_lutpair177" *) 
   LUT3 #(
    .INIT(8'hEA)) 
     \DATA_COUNTER[10]_i_1 
       (.I0(SR),
        .I1(END_OF_FRAME),
        .I2(I2),
        .O(I14));
GND GND
       (.G(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair177" *) 
   LUT2 #(
    .INIT(4'hE)) 
     MIN_LENGTH_MATCH_i_3
       (.I0(SR),
        .I1(I2),
        .O(O1));
VCC VCC
       (.P(\<const1> ));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     async_rst0_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(\<const0> ),
        .PRE(int_rx_rst_asynch),
        .Q(n_0_async_rst0_reg));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     async_rst1_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_async_rst0_reg),
        .PRE(int_rx_rst_asynch),
        .Q(n_0_async_rst1_reg));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     async_rst2_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_async_rst1_reg),
        .PRE(int_rx_rst_asynch),
        .Q(n_0_async_rst2_reg));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     async_rst3_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_async_rst2_reg),
        .PRE(int_rx_rst_asynch),
        .Q(n_0_async_rst3_reg));
LUT3 #(
    .INIT(8'hDF)) 
     async_rst4_i_1
       (.I0(rx_axi_rstn),
        .I1(rx_configuration_vector),
        .I2(glbl_rstn),
        .O(int_rx_rst_asynch));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDPE #(
    .INIT(1'b1)) 
     async_rst4_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_async_rst3_reg),
        .PRE(int_rx_rst_asynch),
        .Q(n_0_async_rst4_reg));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b1)) 
     sync_rst0_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_async_rst4_reg),
        .Q(n_0_sync_rst0_reg),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'hE)) 
     sync_rst1_i_1__0
       (.I0(n_0_sync_rst0_reg),
        .I1(n_0_async_rst4_reg),
        .O(n_0_sync_rst1_i_1__0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   FDRE #(
    .INIT(1'b1)) 
     sync_rst1_reg
       (.C(I1),
        .CE(\<const1> ),
        .D(n_0_sync_rst1_i_1__0),
        .Q(SR),
        .R(\<const0> ));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_tx_axi_intf
   (tx_ce_sample,
    tx_data_valid_int,
    tx_underrun_int,
    E,
    O1,
    O2,
    INT_CRC_MODE,
    O3,
    SR,
    O4,
    CE_REG1_OUT7_out,
    O5,
    O6,
    O7,
    tx_enable,
    gtx_clk,
    I1,
    tx_ack_int,
    tx_axis_mac_tvalid,
    tx_axis_mac_tuser,
    tx_axis_mac_tlast,
    I2,
    I3,
    Q,
    I4,
    PAD,
    CRC100_EN,
    load_source,
    sample,
    tx_axis_mac_tdata);
  output tx_ce_sample;
  output tx_data_valid_int;
  output tx_underrun_int;
  output [0:0]E;
  output O1;
  output O2;
  output INT_CRC_MODE;
  output [0:0]O3;
  output [0:0]SR;
  output [0:0]O4;
  output CE_REG1_OUT7_out;
  output O5;
  output O6;
  output [7:0]O7;
  input tx_enable;
  input gtx_clk;
  input I1;
  input tx_ack_int;
  input tx_axis_mac_tvalid;
  input tx_axis_mac_tuser;
  input tx_axis_mac_tlast;
  input I2;
  input I3;
  input [1:0]Q;
  input I4;
  input PAD;
  input CRC100_EN;
  input load_source;
  input sample;
  input [7:0]tx_axis_mac_tdata;

  wire \<const0> ;
  wire \<const1> ;
  wire CE_REG1_OUT7_out;
  wire CRC100_EN;
  wire [0:0]E;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire INT_CRC_MODE;
  wire O1;
  wire O2;
  wire [0:0]O3;
  wire [0:0]O4;
  wire O5;
  wire O6;
  wire [7:0]O7;
  wire PAD;
  wire [1:0]Q;
  wire [0:0]SR;
  wire force_end;
  wire gate_tready;
  wire gtx_clk;
  wire load_source;
  wire \n_0_FSM_onehot_tx_state[0]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[1]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[2]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[3]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[4]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[5]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[6]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[7]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[7]_i_2 ;
  wire \n_0_FSM_onehot_tx_state[7]_i_3 ;
  wire \n_0_FSM_onehot_tx_state[7]_i_4 ;
  wire \n_0_FSM_onehot_tx_state[7]_i_5 ;
  wire \n_0_FSM_onehot_tx_state[7]_i_6 ;
  wire \n_0_FSM_onehot_tx_state[7]_i_7 ;
  wire \n_0_FSM_onehot_tx_state[7]_i_8 ;
  wire \n_0_FSM_onehot_tx_state[8]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_10 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_11 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_12 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_14 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_15 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_16 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_17 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_18 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_19 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_2 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_20 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_21 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_22 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_23 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_24 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_25 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_26 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_27 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_28 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_29 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_3 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_30 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_31 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_4 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_5 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_6 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_7 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_8 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_9 ;
  wire \n_0_FSM_onehot_tx_state_reg[0] ;
  wire \n_0_FSM_onehot_tx_state_reg[10] ;
  wire \n_0_FSM_onehot_tx_state_reg[11] ;
  wire \n_0_FSM_onehot_tx_state_reg[1] ;
  wire \n_0_FSM_onehot_tx_state_reg[2] ;
  wire \n_0_FSM_onehot_tx_state_reg[3] ;
  wire \n_0_FSM_onehot_tx_state_reg[4] ;
  wire \n_0_FSM_onehot_tx_state_reg[5] ;
  wire \n_0_FSM_onehot_tx_state_reg[6] ;
  wire \n_0_FSM_onehot_tx_state_reg[7] ;
  wire \n_0_FSM_onehot_tx_state_reg[8] ;
  wire \n_0_FSM_onehot_tx_state_reg[9] ;
  wire \n_0_FSM_onehot_tx_state_reg[9]_i_13 ;
  wire n_0_early_deassert_i_1;
  wire n_0_early_deassert_i_2;
  wire n_0_early_deassert_i_3;
  wire n_0_early_deassert_i_4;
  wire n_0_early_deassert_reg;
  wire n_0_early_underrun_i_1;
  wire n_0_early_underrun_i_2;
  wire n_0_early_underrun_i_3;
  wire n_0_early_underrun_i_4;
  wire n_0_early_underrun_reg;
  wire n_0_force_assert_i_1;
  wire n_0_force_assert_i_2;
  wire n_0_force_assert_i_3;
  wire n_0_force_assert_i_4;
  wire n_0_force_assert_i_5;
  wire n_0_force_assert_reg;
  wire n_0_force_burst1_i_1;
  wire n_0_force_burst1_i_2;
  wire n_0_force_burst1_reg;
  wire n_0_force_burst2_i_1;
  wire n_0_force_burst2_i_2;
  wire n_0_force_burst2_i_3;
  wire n_0_force_burst2_reg;
  wire n_0_force_end_i_1;
  wire n_0_force_end_i_2;
  wire n_0_force_end_i_3;
  wire n_0_force_end_i_4;
  wire n_0_force_end_i_6;
  wire n_0_force_end_i_7;
  wire n_0_gate_tready_i_1;
  wire n_0_ignore_packet_i_1;
  wire n_0_ignore_packet_i_2;
  wire n_0_ignore_packet_i_3;
  wire n_0_ignore_packet_reg;
  wire n_0_no_burst_i_1;
  wire n_0_no_burst_i_2;
  wire n_0_no_burst_i_3;
  wire n_0_tlast_reg_i_1;
  wire n_0_tlast_reg_reg;
  wire n_0_two_byte_tx_i_1;
  wire n_0_two_byte_tx_i_2;
  wire \n_0_tx_data[7]_i_1 ;
  wire \n_0_tx_data[7]_i_3 ;
  wire \n_0_tx_data[7]_i_4 ;
  wire \n_0_tx_data[7]_i_5 ;
  wire n_0_tx_data_valid_i_1;
  wire n_0_tx_data_valid_i_2;
  wire n_0_tx_data_valid_i_3;
  wire n_0_tx_data_valid_i_4;
  wire n_0_tx_data_valid_i_5;
  wire n_0_tx_data_valid_i_6;
  wire n_0_tx_data_valid_i_7;
  wire n_0_tx_mac_tready_reg_i_11;
  wire n_0_tx_mac_tready_reg_i_12;
  wire n_0_tx_mac_tready_reg_i_13;
  wire n_0_tx_mac_tready_reg_i_14;
  wire n_0_tx_mac_tready_reg_i_15;
  wire n_0_tx_mac_tready_reg_i_16;
  wire n_0_tx_mac_tready_reg_i_17;
  wire n_0_tx_mac_tready_reg_i_18;
  wire n_0_tx_mac_tready_reg_i_19;
  wire n_0_tx_mac_tready_reg_i_2;
  wire n_0_tx_mac_tready_reg_i_20;
  wire n_0_tx_mac_tready_reg_i_21;
  wire n_0_tx_mac_tready_reg_i_22;
  wire n_0_tx_mac_tready_reg_i_23;
  wire n_0_tx_mac_tready_reg_i_24;
  wire n_0_tx_mac_tready_reg_i_25;
  wire n_0_tx_mac_tready_reg_i_26;
  wire n_0_tx_mac_tready_reg_i_27;
  wire n_0_tx_mac_tready_reg_i_28;
  wire n_0_tx_mac_tready_reg_i_29;
  wire n_0_tx_mac_tready_reg_i_3;
  wire n_0_tx_mac_tready_reg_i_5;
  wire n_0_tx_mac_tready_reg_i_6;
  wire n_0_tx_mac_tready_reg_i_7;
  wire n_0_tx_mac_tready_reg_i_8;
  wire n_0_tx_mac_tready_reg_i_9;
  wire n_0_tx_mac_tready_reg_reg_i_10;
  wire n_0_tx_mac_tready_reg_reg_i_4;
  wire n_0_tx_underrun_i_1;
  wire n_0_tx_underrun_i_2;
  wire n_0_tx_underrun_i_3;
  wire no_burst;
  wire [7:0]p_1_in;
  wire sample;
  wire two_byte_tx;
  wire tx_ack_int;
  wire [7:0]tx_axis_mac_tdata;
  wire tx_axis_mac_tlast;
  wire tx_axis_mac_tuser;
  wire tx_axis_mac_tvalid;
  wire tx_ce_sample;
  wire [7:0]tx_data_hold;
  wire tx_data_valid_int;
  wire tx_enable;
  wire tx_mac_tready_reg;
  wire tx_mac_tready_reg0;
  wire tx_underrun_int;

(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \CALC[29]_i_1 
       (.I0(tx_ce_sample),
        .I1(Q[0]),
        .O(O2));
(* SOFT_HLUTNM = "soft_lutpair27" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \CONFIG_SELECT.CE_REG4_OUT_i_2 
       (.I0(tx_ce_sample),
        .I1(CRC100_EN),
        .O(CE_REG1_OUT7_out));
(* SOFT_HLUTNM = "soft_lutpair26" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \DATA_REG[3][7]_i_1 
       (.I0(tx_ce_sample),
        .I1(PAD),
        .O(SR));
LUT6 #(
    .INIT(64'h0000000000F20000)) 
     \FSM_onehot_tx_state[0]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_2 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_3 ),
        .I2(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .I3(\n_0_FSM_onehot_tx_state[7]_i_3 ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_5 ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_4 ),
        .O(\n_0_FSM_onehot_tx_state[0]_i_1 ));
LUT6 #(
    .INIT(64'h00000000000D0000)) 
     \FSM_onehot_tx_state[1]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_2 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_3 ),
        .I2(\n_0_FSM_onehot_tx_state[7]_i_3 ),
        .I3(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_5 ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_4 ),
        .O(\n_0_FSM_onehot_tx_state[1]_i_1 ));
LUT6 #(
    .INIT(64'h00000000F2000000)) 
     \FSM_onehot_tx_state[2]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_2 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_3 ),
        .I2(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .I3(\n_0_FSM_onehot_tx_state[7]_i_3 ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_5 ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_4 ),
        .O(\n_0_FSM_onehot_tx_state[2]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000D00000)) 
     \FSM_onehot_tx_state[3]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_2 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_3 ),
        .I2(\n_0_FSM_onehot_tx_state[7]_i_3 ),
        .I3(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_5 ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_4 ),
        .O(\n_0_FSM_onehot_tx_state[3]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000005504)) 
     \FSM_onehot_tx_state[4]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_5 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_2 ),
        .I2(\n_0_FSM_onehot_tx_state[9]_i_3 ),
        .I3(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .I4(\n_0_FSM_onehot_tx_state[7]_i_3 ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_4 ),
        .O(\n_0_FSM_onehot_tx_state[4]_i_1 ));
LUT6 #(
    .INIT(64'h0000000001000101)) 
     \FSM_onehot_tx_state[5]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_5 ),
        .I1(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .I2(\n_0_FSM_onehot_tx_state[7]_i_3 ),
        .I3(\n_0_FSM_onehot_tx_state[9]_i_3 ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_2 ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_4 ),
        .O(\n_0_FSM_onehot_tx_state[5]_i_1 ));
LUT6 #(
    .INIT(64'h0000000055040000)) 
     \FSM_onehot_tx_state[6]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_5 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_2 ),
        .I2(\n_0_FSM_onehot_tx_state[9]_i_3 ),
        .I3(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .I4(\n_0_FSM_onehot_tx_state[7]_i_3 ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_4 ),
        .O(\n_0_FSM_onehot_tx_state[6]_i_1 ));
LUT6 #(
    .INIT(64'h0000000010001010)) 
     \FSM_onehot_tx_state[7]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_5 ),
        .I1(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .I2(\n_0_FSM_onehot_tx_state[7]_i_3 ),
        .I3(\n_0_FSM_onehot_tx_state[9]_i_3 ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_2 ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_4 ),
        .O(\n_0_FSM_onehot_tx_state[7]_i_1 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_tx_state[7]_i_2 
       (.I0(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[11] ),
        .O(\n_0_FSM_onehot_tx_state[7]_i_2 ));
LUT6 #(
    .INIT(64'h0000000000000002)) 
     \FSM_onehot_tx_state[7]_i_3 
       (.I0(\n_0_FSM_onehot_tx_state[7]_i_4 ),
        .I1(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I5(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .O(\n_0_FSM_onehot_tx_state[7]_i_3 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAEAEFFAA)) 
     \FSM_onehot_tx_state[7]_i_4 
       (.I0(\n_0_FSM_onehot_tx_state[7]_i_5 ),
        .I1(\n_0_FSM_onehot_tx_state[7]_i_6 ),
        .I2(\n_0_FSM_onehot_tx_state[7]_i_7 ),
        .I3(\n_0_FSM_onehot_tx_state[7]_i_8 ),
        .I4(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_9 ),
        .O(\n_0_FSM_onehot_tx_state[7]_i_4 ));
LUT6 #(
    .INIT(64'h0000010001000000)) 
     \FSM_onehot_tx_state[7]_i_5 
       (.I0(n_0_tx_mac_tready_reg_i_15),
        .I1(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I3(\n_0_FSM_onehot_tx_state[9]_i_29 ),
        .I4(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[1] ),
        .O(\n_0_FSM_onehot_tx_state[7]_i_5 ));
(* SOFT_HLUTNM = "soft_lutpair21" *) 
   LUT3 #(
    .INIT(8'h01)) 
     \FSM_onehot_tx_state[7]_i_6 
       (.I0(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .O(\n_0_FSM_onehot_tx_state[7]_i_6 ));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT4 #(
    .INIT(16'hF888)) 
     \FSM_onehot_tx_state[7]_i_7 
       (.I0(tx_ce_sample),
        .I1(tx_ack_int),
        .I2(tx_axis_mac_tlast),
        .I3(tx_axis_mac_tuser),
        .O(\n_0_FSM_onehot_tx_state[7]_i_7 ));
LUT6 #(
    .INIT(64'h000055151515AA00)) 
     \FSM_onehot_tx_state[7]_i_8 
       (.I0(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I1(tx_ce_sample),
        .I2(tx_ack_int),
        .I3(tx_axis_mac_tvalid),
        .I4(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[6] ),
        .O(\n_0_FSM_onehot_tx_state[7]_i_8 ));
LUT6 #(
    .INIT(64'h8880888088888880)) 
     \FSM_onehot_tx_state[8]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_5 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_4 ),
        .I2(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[11] ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_2 ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_3 ),
        .O(\n_0_FSM_onehot_tx_state[8]_i_1 ));
LUT6 #(
    .INIT(64'h000D0000FFFF0000)) 
     \FSM_onehot_tx_state[9]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_2 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_3 ),
        .I2(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[11] ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_4 ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_5 ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000020030)) 
     \FSM_onehot_tx_state[9]_i_10 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_22 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_8 ),
        .I2(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_17 ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_10 ));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT5 #(
    .INIT(32'hFFF7FFFF)) 
     \FSM_onehot_tx_state[9]_i_11 
       (.I0(tx_axis_mac_tuser),
        .I1(tx_axis_mac_tlast),
        .I2(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[1] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_11 ));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT4 #(
    .INIT(16'h0001)) 
     \FSM_onehot_tx_state[9]_i_12 
       (.I0(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[9] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_12 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \FSM_onehot_tx_state[9]_i_14 
       (.I0(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I3(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .I4(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[2] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_14 ));
(* SOFT_HLUTNM = "soft_lutpair23" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_tx_state[9]_i_15 
       (.I0(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_15 ));
LUT6 #(
    .INIT(64'h00000000FEFE00FF)) 
     \FSM_onehot_tx_state[9]_i_16 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_9 ),
        .I1(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I2(\n_0_FSM_onehot_tx_state[9]_i_25 ),
        .I3(\n_0_FSM_onehot_tx_state[9]_i_26 ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_27 ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_28 ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_16 ));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT5 #(
    .INIT(32'hFFFFFFFE)) 
     \FSM_onehot_tx_state[9]_i_17 
       (.I0(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[7] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_17 ));
LUT6 #(
    .INIT(64'h0000000000000800)) 
     \FSM_onehot_tx_state[9]_i_18 
       (.I0(n_0_no_burst_i_3),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_29 ),
        .I2(\n_0_FSM_onehot_tx_state[9]_i_8 ),
        .I3(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I4(tx_axis_mac_tvalid),
        .I5(I2),
        .O(\n_0_FSM_onehot_tx_state[9]_i_18 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_tx_state[9]_i_19 
       (.I0(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[6] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_19 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFF5554)) 
     \FSM_onehot_tx_state[9]_i_2 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_6 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_7 ),
        .I2(\n_0_FSM_onehot_tx_state[9]_i_8 ),
        .I3(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_9 ),
        .I5(\n_0_FSM_onehot_tx_state_reg[0] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_2 ));
LUT6 #(
    .INIT(64'hFFFFF888FFFFFFFF)) 
     \FSM_onehot_tx_state[9]_i_20 
       (.I0(tx_axis_mac_tuser),
        .I1(tx_axis_mac_tlast),
        .I2(tx_ack_int),
        .I3(tx_ce_sample),
        .I4(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I5(n_0_no_burst_i_3),
        .O(\n_0_FSM_onehot_tx_state[9]_i_20 ));
LUT6 #(
    .INIT(64'hFFFFFFFF0000FBCB)) 
     \FSM_onehot_tx_state[9]_i_21 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_30 ),
        .I1(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I3(tx_ce_sample),
        .I4(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_31 ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_21 ));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT5 #(
    .INIT(32'h00000400)) 
     \FSM_onehot_tx_state[9]_i_22 
       (.I0(tx_axis_mac_tuser),
        .I1(tx_axis_mac_tvalid),
        .I2(n_0_ignore_packet_reg),
        .I3(tx_ce_sample),
        .I4(no_burst),
        .O(\n_0_FSM_onehot_tx_state[9]_i_22 ));
LUT5 #(
    .INIT(32'h00033380)) 
     \FSM_onehot_tx_state[9]_i_23 
       (.I0(tx_ack_int),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I2(tx_ce_sample),
        .I3(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[9] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_23 ));
LUT6 #(
    .INIT(64'h0000000001010100)) 
     \FSM_onehot_tx_state[9]_i_24 
       (.I0(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I3(force_end),
        .I4(I2),
        .I5(tx_axis_mac_tvalid),
        .O(\n_0_FSM_onehot_tx_state[9]_i_24 ));
LUT6 #(
    .INIT(64'hFFFFBBBABABA0000)) 
     \FSM_onehot_tx_state[9]_i_25 
       (.I0(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I1(tx_axis_mac_tvalid),
        .I2(I2),
        .I3(force_end),
        .I4(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[5] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_25 ));
LUT6 #(
    .INIT(64'h010C000000000000)) 
     \FSM_onehot_tx_state[9]_i_26 
       (.I0(I2),
        .I1(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I4(tx_axis_mac_tlast),
        .I5(tx_axis_mac_tuser),
        .O(\n_0_FSM_onehot_tx_state[9]_i_26 ));
(* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT3 #(
    .INIT(8'hFE)) 
     \FSM_onehot_tx_state[9]_i_27 
       (.I0(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_27 ));
LUT6 #(
    .INIT(64'h0000000000100000)) 
     \FSM_onehot_tx_state[9]_i_28 
       (.I0(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I4(n_0_tx_mac_tready_reg_i_15),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_19 ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_28 ));
(* SOFT_HLUTNM = "soft_lutpair21" *) 
   LUT2 #(
    .INIT(4'h1)) 
     \FSM_onehot_tx_state[9]_i_29 
       (.I0(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[6] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_29 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAABA)) 
     \FSM_onehot_tx_state[9]_i_3 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_10 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_11 ),
        .I2(\n_0_FSM_onehot_tx_state[9]_i_12 ),
        .I3(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[5] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT5 #(
    .INIT(32'h0000007F)) 
     \FSM_onehot_tx_state[9]_i_30 
       (.I0(tx_axis_mac_tlast),
        .I1(tx_mac_tready_reg),
        .I2(gate_tready),
        .I3(n_0_early_deassert_reg),
        .I4(two_byte_tx),
        .O(\n_0_FSM_onehot_tx_state[9]_i_30 ));
LUT6 #(
    .INIT(64'hFFFEFEFEAAAAAAAA)) 
     \FSM_onehot_tx_state[9]_i_31 
       (.I0(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I3(tx_ce_sample),
        .I4(tx_ack_int),
        .I5(\n_0_FSM_onehot_tx_state_reg[7] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_31 ));
LUT6 #(
    .INIT(64'h0232020202020202)) 
     \FSM_onehot_tx_state[9]_i_4 
       (.I0(\n_0_FSM_onehot_tx_state_reg[9]_i_13 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_14 ),
        .I2(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I3(\n_0_FSM_onehot_tx_state[9]_i_15 ),
        .I4(n_0_no_burst_i_3),
        .I5(I2),
        .O(\n_0_FSM_onehot_tx_state[9]_i_4 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \FSM_onehot_tx_state[9]_i_5 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_16 ),
        .I1(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I5(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_5 ));
LUT6 #(
    .INIT(64'hCCCCDCDCCCCFDCDC)) 
     \FSM_onehot_tx_state[9]_i_6 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_17 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_18 ),
        .I2(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I3(\n_0_FSM_onehot_tx_state[9]_i_19 ),
        .I4(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I5(\n_0_FSM_onehot_tx_state[9]_i_20 ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_6 ));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAA2A)) 
     \FSM_onehot_tx_state[9]_i_7 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_21 ),
        .I1(tx_axis_mac_tvalid),
        .I2(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[7] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_7 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_tx_state[9]_i_8 
       (.I0(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[4] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_8 ));
(* SOFT_HLUTNM = "soft_lutpair24" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_tx_state[9]_i_9 
       (.I0(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[2] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_9 ));
FDSE #(
    .INIT(1'b1)) 
     \FSM_onehot_tx_state_reg[0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FSM_onehot_tx_state[0]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[0] ),
        .S(I1));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[10] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(\n_0_FSM_onehot_tx_state_reg[10] ),
        .R(I1));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[11] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(\n_0_FSM_onehot_tx_state_reg[11] ),
        .R(I1));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[1] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FSM_onehot_tx_state[1]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[1] ),
        .R(I1));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[2] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FSM_onehot_tx_state[2]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[2] ),
        .R(I1));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[3] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FSM_onehot_tx_state[3]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[3] ),
        .R(I1));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[4] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FSM_onehot_tx_state[4]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[4] ),
        .R(I1));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[5] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FSM_onehot_tx_state[5]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[5] ),
        .R(I1));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[6] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FSM_onehot_tx_state[6]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[6] ),
        .R(I1));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[7] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FSM_onehot_tx_state[7]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[7] ),
        .R(I1));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[8] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FSM_onehot_tx_state[8]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[8] ),
        .R(I1));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[9] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_FSM_onehot_tx_state[9]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[9] ),
        .R(I1));
MUXF7 \FSM_onehot_tx_state_reg[9]_i_13 
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_23 ),
        .I1(\n_0_FSM_onehot_tx_state[9]_i_24 ),
        .O(\n_0_FSM_onehot_tx_state_reg[9]_i_13 ),
        .S(\n_0_FSM_onehot_tx_state_reg[5] ));
GND GND
       (.G(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT2 #(
    .INIT(4'h8)) 
     INT_CRC_MODE_i_1__0
       (.I0(tx_ce_sample),
        .I1(I4),
        .O(INT_CRC_MODE));
(* SOFT_HLUTNM = "soft_lutpair25" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \INT_MAX_FRAME_LENGTH[14]_i_1 
       (.I0(tx_ce_sample),
        .I1(I4),
        .O(O3));
(* SOFT_HLUTNM = "soft_lutpair27" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \LEN[15]_i_1 
       (.I0(tx_ce_sample),
        .I1(Q[1]),
        .O(O4));
VCC VCC
       (.P(\<const1> ));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \data_count[5]_i_3__0 
       (.I0(tx_ce_sample),
        .I1(I3),
        .O(O1));
LUT6 #(
    .INIT(64'h0303550300005500)) 
     early_deassert_i_1
       (.I0(I1),
        .I1(n_0_force_assert_i_4),
        .I2(n_0_early_deassert_i_2),
        .I3(n_0_early_deassert_i_3),
        .I4(n_0_early_deassert_i_4),
        .I5(n_0_early_deassert_reg),
        .O(n_0_early_deassert_i_1));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT4 #(
    .INIT(16'hFFF4)) 
     early_deassert_i_2
       (.I0(tx_data_valid_int),
        .I1(tx_ce_sample),
        .I2(two_byte_tx),
        .I3(I1),
        .O(n_0_early_deassert_i_2));
(* SOFT_HLUTNM = "soft_lutpair20" *) 
   LUT2 #(
    .INIT(4'h2)) 
     early_deassert_i_3
       (.I0(tx_axis_mac_tvalid),
        .I1(\n_0_tx_data[7]_i_3 ),
        .O(n_0_early_deassert_i_3));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT3 #(
    .INIT(8'h7F)) 
     early_deassert_i_4
       (.I0(gate_tready),
        .I1(tx_mac_tready_reg),
        .I2(tx_axis_mac_tlast),
        .O(n_0_early_deassert_i_4));
FDRE early_deassert_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_early_deassert_i_1),
        .Q(n_0_early_deassert_reg),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h00AA00AB00AA00AA)) 
     early_underrun_i_1
       (.I0(n_0_early_underrun_i_2),
        .I1(n_0_early_underrun_i_3),
        .I2(I2),
        .I3(I1),
        .I4(n_0_early_underrun_i_4),
        .I5(n_0_early_underrun_reg),
        .O(n_0_early_underrun_i_1));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT4 #(
    .INIT(16'h4000)) 
     early_underrun_i_2
       (.I0(\n_0_tx_data[7]_i_3 ),
        .I1(tx_axis_mac_tuser),
        .I2(tx_mac_tready_reg),
        .I3(gate_tready),
        .O(n_0_early_underrun_i_2));
(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT5 #(
    .INIT(32'h00000001)) 
     early_underrun_i_3
       (.I0(n_0_force_end_i_4),
        .I1(n_0_force_end_i_7),
        .I2(n_0_no_burst_i_2),
        .I3(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[9] ),
        .O(n_0_early_underrun_i_3));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT2 #(
    .INIT(4'h2)) 
     early_underrun_i_4
       (.I0(\n_0_tx_data[7]_i_3 ),
        .I1(\n_0_FSM_onehot_tx_state_reg[8] ),
        .O(n_0_early_underrun_i_4));
FDRE early_underrun_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_early_underrun_i_1),
        .Q(n_0_early_underrun_reg),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h2322F3FF23220300)) 
     force_assert_i_1
       (.I0(n_0_force_assert_i_2),
        .I1(I1),
        .I2(n_0_force_assert_i_3),
        .I3(n_0_force_assert_i_4),
        .I4(n_0_force_assert_i_5),
        .I5(n_0_force_assert_reg),
        .O(n_0_force_assert_i_1));
(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT4 #(
    .INIT(16'h6020)) 
     force_assert_i_2
       (.I0(n_0_force_burst2_reg),
        .I1(n_0_force_burst1_reg),
        .I2(tx_ce_sample),
        .I3(tx_ack_int),
        .O(n_0_force_assert_i_2));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT2 #(
    .INIT(4'hB)) 
     force_assert_i_3
       (.I0(tx_axis_mac_tlast),
        .I1(n_0_early_deassert_reg),
        .O(n_0_force_assert_i_3));
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT4 #(
    .INIT(16'h0040)) 
     force_assert_i_4
       (.I0(n_0_tx_mac_tready_reg_i_3),
        .I1(n_0_tx_mac_tready_reg_reg_i_4),
        .I2(n_0_tx_mac_tready_reg_i_6),
        .I3(n_0_tx_mac_tready_reg_i_7),
        .O(n_0_force_assert_i_4));
LUT6 #(
    .INIT(64'hFFFFFFFFFF003800)) 
     force_assert_i_5
       (.I0(tx_ack_int),
        .I1(n_0_force_burst1_reg),
        .I2(n_0_force_burst2_reg),
        .I3(tx_ce_sample),
        .I4(tx_data_valid_int),
        .I5(I1),
        .O(n_0_force_assert_i_5));
FDRE force_assert_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_force_assert_i_1),
        .Q(n_0_force_assert_reg),
        .R(\<const0> ));
LUT5 #(
    .INIT(32'h070F000F)) 
     force_burst1_i_1
       (.I0(tx_ack_int),
        .I1(tx_ce_sample),
        .I2(I1),
        .I3(n_0_force_burst1_i_2),
        .I4(n_0_force_burst1_reg),
        .O(n_0_force_burst1_i_1));
LUT5 #(
    .INIT(32'h00007FFF)) 
     force_burst1_i_2
       (.I0(n_0_tlast_reg_reg),
        .I1(n_0_early_deassert_reg),
        .I2(tx_axis_mac_tvalid),
        .I3(n_0_two_byte_tx_i_2),
        .I4(n_0_force_burst2_i_2),
        .O(n_0_force_burst1_i_2));
FDRE force_burst1_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_force_burst1_i_1),
        .Q(n_0_force_burst1_reg),
        .R(\<const0> ));
LUT5 #(
    .INIT(32'h00FB00AA)) 
     force_burst2_i_1
       (.I0(n_0_force_burst2_i_2),
        .I1(tx_ce_sample),
        .I2(n_0_force_burst1_reg),
        .I3(I1),
        .I4(n_0_force_burst2_reg),
        .O(n_0_force_burst2_i_1));
LUT6 #(
    .INIT(64'h0000000040000000)) 
     force_burst2_i_2
       (.I0(n_0_force_burst2_i_3),
        .I1(n_0_force_end_i_7),
        .I2(n_0_tlast_reg_reg),
        .I3(two_byte_tx),
        .I4(tx_axis_mac_tvalid),
        .I5(n_0_force_end_i_4),
        .O(n_0_force_burst2_i_2));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFF0001)) 
     force_burst2_i_3
       (.I0(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[9] ),
        .O(n_0_force_burst2_i_3));
FDRE force_burst2_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_force_burst2_i_1),
        .Q(n_0_force_burst2_reg),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'hF8CC88CC88CC88CC)) 
     force_end_i_1
       (.I0(n_0_force_end_i_2),
        .I1(force_end),
        .I2(n_0_force_end_i_3),
        .I3(n_0_force_end_i_4),
        .I4(I2),
        .I5(n_0_force_end_i_6),
        .O(n_0_force_end_i_1));
LUT4 #(
    .INIT(16'hFF3E)) 
     force_end_i_2
       (.I0(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I1(n_0_force_end_i_7),
        .I2(n_0_no_burst_i_2),
        .I3(\n_0_FSM_onehot_tx_state_reg[8] ),
        .O(n_0_force_end_i_2));
(* SOFT_HLUTNM = "soft_lutpair23" *) 
   LUT2 #(
    .INIT(4'hE)) 
     force_end_i_3
       (.I0(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[4] ),
        .O(n_0_force_end_i_3));
LUT4 #(
    .INIT(16'h0001)) 
     force_end_i_4
       (.I0(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[3] ),
        .O(n_0_force_end_i_4));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     force_end_i_6
       (.I0(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[8] ),
        .O(n_0_force_end_i_6));
(* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT4 #(
    .INIT(16'h0001)) 
     force_end_i_7
       (.I0(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[5] ),
        .O(n_0_force_end_i_7));
FDRE force_end_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_force_end_i_1),
        .Q(force_end),
        .R(\<const0> ));
LUT4 #(
    .INIT(16'hFFEF)) 
     gate_tready_i_1
       (.I0(tx_enable),
        .I1(n_0_tx_mac_tready_reg_reg_i_4),
        .I2(n_0_tx_mac_tready_reg_i_3),
        .I3(n_0_tx_mac_tready_reg_i_2),
        .O(n_0_gate_tready_i_1));
FDSE #(
    .INIT(1'b0)) 
     gate_tready_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_gate_tready_i_1),
        .Q(gate_tready),
        .S(I1));
LUT5 #(
    .INIT(32'h0A0E0A0A)) 
     ignore_packet_i_1
       (.I0(n_0_ignore_packet_i_2),
        .I1(tx_axis_mac_tvalid),
        .I2(I1),
        .I3(tx_axis_mac_tlast),
        .I4(n_0_ignore_packet_reg),
        .O(n_0_ignore_packet_i_1));
LUT6 #(
    .INIT(64'h0000400000000000)) 
     ignore_packet_i_2
       (.I0(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I1(\n_0_tx_data[7]_i_3 ),
        .I2(n_0_ignore_packet_i_3),
        .I3(tx_axis_mac_tvalid),
        .I4(n_0_ignore_packet_reg),
        .I5(tx_axis_mac_tuser),
        .O(n_0_ignore_packet_i_2));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT2 #(
    .INIT(4'h7)) 
     ignore_packet_i_3
       (.I0(tx_mac_tready_reg),
        .I1(gate_tready),
        .O(n_0_ignore_packet_i_3));
FDRE ignore_packet_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_ignore_packet_i_1),
        .Q(n_0_ignore_packet_reg),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h0000000000000004)) 
     no_burst_i_1
       (.I0(n_0_no_burst_i_2),
        .I1(n_0_force_end_i_4),
        .I2(tx_axis_mac_tvalid),
        .I3(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I5(n_0_no_burst_i_3),
        .O(n_0_no_burst_i_1));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT5 #(
    .INIT(32'h00000001)) 
     no_burst_i_2
       (.I0(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[9] ),
        .O(n_0_no_burst_i_2));
LUT2 #(
    .INIT(4'h1)) 
     no_burst_i_3
       (.I0(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[8] ),
        .O(n_0_no_burst_i_3));
FDRE no_burst_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_no_burst_i_1),
        .Q(no_burst),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair25" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \pause_source_shift[47]_i_1 
       (.I0(tx_ce_sample),
        .I1(load_source),
        .O(O5));
(* SOFT_HLUTNM = "soft_lutpair26" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \pause_value_sample[7]_i_1 
       (.I0(tx_ce_sample),
        .I1(sample),
        .O(O6));
LUT6 #(
    .INIT(64'h3111111130000000)) 
     tlast_reg_i_1
       (.I0(tx_ce_sample),
        .I1(I1),
        .I2(tx_axis_mac_tlast),
        .I3(tx_mac_tready_reg),
        .I4(gate_tready),
        .I5(n_0_tlast_reg_reg),
        .O(n_0_tlast_reg_i_1));
FDRE tlast_reg_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_tlast_reg_i_1),
        .Q(n_0_tlast_reg_reg),
        .R(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT4 #(
    .INIT(16'h00E2)) 
     two_byte_tx_i_1
       (.I0(two_byte_tx),
        .I1(n_0_two_byte_tx_i_2),
        .I2(tx_axis_mac_tlast),
        .I3(I1),
        .O(n_0_two_byte_tx_i_1));
(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT5 #(
    .INIT(32'h10001001)) 
     two_byte_tx_i_2
       (.I0(n_0_force_end_i_4),
        .I1(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I2(n_0_no_burst_i_2),
        .I3(n_0_force_end_i_7),
        .I4(\n_0_FSM_onehot_tx_state_reg[9] ),
        .O(n_0_two_byte_tx_i_2));
FDRE two_byte_tx_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_two_byte_tx_i_1),
        .Q(two_byte_tx),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'h8)) 
     tx_axis_mac_tready_INST_0
       (.I0(gate_tready),
        .I1(tx_mac_tready_reg),
        .O(E));
LUT5 #(
    .INIT(32'hFF758A00)) 
     \tx_data[0]_i_1 
       (.I0(tx_ce_sample),
        .I1(\n_0_tx_data[7]_i_3 ),
        .I2(\n_0_tx_data[7]_i_4 ),
        .I3(tx_axis_mac_tdata[0]),
        .I4(tx_data_hold[0]),
        .O(p_1_in[0]));
LUT5 #(
    .INIT(32'hFF758A00)) 
     \tx_data[1]_i_1 
       (.I0(tx_ce_sample),
        .I1(\n_0_tx_data[7]_i_3 ),
        .I2(\n_0_tx_data[7]_i_4 ),
        .I3(tx_axis_mac_tdata[1]),
        .I4(tx_data_hold[1]),
        .O(p_1_in[1]));
LUT5 #(
    .INIT(32'hFF758A00)) 
     \tx_data[2]_i_1 
       (.I0(tx_ce_sample),
        .I1(\n_0_tx_data[7]_i_3 ),
        .I2(\n_0_tx_data[7]_i_4 ),
        .I3(tx_axis_mac_tdata[2]),
        .I4(tx_data_hold[2]),
        .O(p_1_in[2]));
LUT5 #(
    .INIT(32'hFF758A00)) 
     \tx_data[3]_i_1 
       (.I0(tx_ce_sample),
        .I1(\n_0_tx_data[7]_i_3 ),
        .I2(\n_0_tx_data[7]_i_4 ),
        .I3(tx_axis_mac_tdata[3]),
        .I4(tx_data_hold[3]),
        .O(p_1_in[3]));
LUT5 #(
    .INIT(32'hFF758A00)) 
     \tx_data[4]_i_1 
       (.I0(tx_ce_sample),
        .I1(\n_0_tx_data[7]_i_3 ),
        .I2(\n_0_tx_data[7]_i_4 ),
        .I3(tx_axis_mac_tdata[4]),
        .I4(tx_data_hold[4]),
        .O(p_1_in[4]));
LUT5 #(
    .INIT(32'hFF758A00)) 
     \tx_data[5]_i_1 
       (.I0(tx_ce_sample),
        .I1(\n_0_tx_data[7]_i_3 ),
        .I2(\n_0_tx_data[7]_i_4 ),
        .I3(tx_axis_mac_tdata[5]),
        .I4(tx_data_hold[5]),
        .O(p_1_in[5]));
LUT5 #(
    .INIT(32'hFF758A00)) 
     \tx_data[6]_i_1 
       (.I0(tx_ce_sample),
        .I1(\n_0_tx_data[7]_i_3 ),
        .I2(\n_0_tx_data[7]_i_4 ),
        .I3(tx_axis_mac_tdata[6]),
        .I4(tx_data_hold[6]),
        .O(p_1_in[6]));
LUT4 #(
    .INIT(16'hAA8A)) 
     \tx_data[7]_i_1 
       (.I0(tx_ce_sample),
        .I1(\n_0_tx_data[7]_i_3 ),
        .I2(\n_0_tx_data[7]_i_4 ),
        .I3(tx_ack_int),
        .O(\n_0_tx_data[7]_i_1 ));
LUT5 #(
    .INIT(32'hFF758A00)) 
     \tx_data[7]_i_2 
       (.I0(tx_ce_sample),
        .I1(\n_0_tx_data[7]_i_3 ),
        .I2(\n_0_tx_data[7]_i_4 ),
        .I3(tx_axis_mac_tdata[7]),
        .I4(tx_data_hold[7]),
        .O(p_1_in[7]));
LUT6 #(
    .INIT(64'h0000000000000080)) 
     \tx_data[7]_i_3 
       (.I0(n_0_force_end_i_7),
        .I1(\n_0_tx_data[7]_i_5 ),
        .I2(n_0_force_end_i_4),
        .I3(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[5] ),
        .O(\n_0_tx_data[7]_i_3 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFF0FFFB)) 
     \tx_data[7]_i_4 
       (.I0(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I1(tx_ack_int),
        .I2(n_0_force_end_i_4),
        .I3(n_0_force_end_i_7),
        .I4(n_0_no_burst_i_2),
        .I5(\n_0_FSM_onehot_tx_state_reg[8] ),
        .O(\n_0_tx_data[7]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair24" *) 
   LUT2 #(
    .INIT(4'h1)) 
     \tx_data[7]_i_5 
       (.I0(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[3] ),
        .O(\n_0_tx_data[7]_i_5 ));
FDRE \tx_data_hold_reg[0] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_axis_mac_tdata[0]),
        .Q(tx_data_hold[0]),
        .R(I1));
FDRE \tx_data_hold_reg[1] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_axis_mac_tdata[1]),
        .Q(tx_data_hold[1]),
        .R(I1));
FDRE \tx_data_hold_reg[2] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_axis_mac_tdata[2]),
        .Q(tx_data_hold[2]),
        .R(I1));
FDRE \tx_data_hold_reg[3] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_axis_mac_tdata[3]),
        .Q(tx_data_hold[3]),
        .R(I1));
FDRE \tx_data_hold_reg[4] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_axis_mac_tdata[4]),
        .Q(tx_data_hold[4]),
        .R(I1));
FDRE \tx_data_hold_reg[5] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_axis_mac_tdata[5]),
        .Q(tx_data_hold[5]),
        .R(I1));
FDRE \tx_data_hold_reg[6] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_axis_mac_tdata[6]),
        .Q(tx_data_hold[6]),
        .R(I1));
FDRE \tx_data_hold_reg[7] 
       (.C(gtx_clk),
        .CE(E),
        .D(tx_axis_mac_tdata[7]),
        .Q(tx_data_hold[7]),
        .R(I1));
FDRE \tx_data_reg[0] 
       (.C(gtx_clk),
        .CE(\n_0_tx_data[7]_i_1 ),
        .D(p_1_in[0]),
        .Q(O7[0]),
        .R(I1));
FDRE \tx_data_reg[1] 
       (.C(gtx_clk),
        .CE(\n_0_tx_data[7]_i_1 ),
        .D(p_1_in[1]),
        .Q(O7[1]),
        .R(I1));
FDRE \tx_data_reg[2] 
       (.C(gtx_clk),
        .CE(\n_0_tx_data[7]_i_1 ),
        .D(p_1_in[2]),
        .Q(O7[2]),
        .R(I1));
FDRE \tx_data_reg[3] 
       (.C(gtx_clk),
        .CE(\n_0_tx_data[7]_i_1 ),
        .D(p_1_in[3]),
        .Q(O7[3]),
        .R(I1));
FDRE \tx_data_reg[4] 
       (.C(gtx_clk),
        .CE(\n_0_tx_data[7]_i_1 ),
        .D(p_1_in[4]),
        .Q(O7[4]),
        .R(I1));
FDRE \tx_data_reg[5] 
       (.C(gtx_clk),
        .CE(\n_0_tx_data[7]_i_1 ),
        .D(p_1_in[5]),
        .Q(O7[5]),
        .R(I1));
FDRE \tx_data_reg[6] 
       (.C(gtx_clk),
        .CE(\n_0_tx_data[7]_i_1 ),
        .D(p_1_in[6]),
        .Q(O7[6]),
        .R(I1));
FDRE \tx_data_reg[7] 
       (.C(gtx_clk),
        .CE(\n_0_tx_data[7]_i_1 ),
        .D(p_1_in[7]),
        .Q(O7[7]),
        .R(I1));
LUT6 #(
    .INIT(64'h0D0D0F0D0C0C0F0C)) 
     tx_data_valid_i_1
       (.I0(n_0_tx_data_valid_i_2),
        .I1(n_0_tx_data_valid_i_3),
        .I2(I1),
        .I3(n_0_tx_data_valid_i_4),
        .I4(n_0_tx_data_valid_i_5),
        .I5(tx_data_valid_int),
        .O(n_0_tx_data_valid_i_1));
LUT6 #(
    .INIT(64'h88888888888A8888)) 
     tx_data_valid_i_2
       (.I0(tx_ce_sample),
        .I1(n_0_tx_data_valid_i_6),
        .I2(n_0_tx_mac_tready_reg_reg_i_4),
        .I3(n_0_tx_mac_tready_reg_i_3),
        .I4(n_0_tx_mac_tready_reg_i_7),
        .I5(n_0_tx_mac_tready_reg_i_6),
        .O(n_0_tx_data_valid_i_2));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT2 #(
    .INIT(4'h8)) 
     tx_data_valid_i_3
       (.I0(tx_ce_sample),
        .I1(n_0_force_assert_reg),
        .O(n_0_tx_data_valid_i_3));
(* SOFT_HLUTNM = "soft_lutpair22" *) 
   LUT2 #(
    .INIT(4'h1)) 
     tx_data_valid_i_4
       (.I0(n_0_tx_mac_tready_reg_i_6),
        .I1(n_0_tx_mac_tready_reg_i_7),
        .O(n_0_tx_data_valid_i_4));
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT2 #(
    .INIT(4'hE)) 
     tx_data_valid_i_5
       (.I0(n_0_tx_mac_tready_reg_i_3),
        .I1(n_0_tx_mac_tready_reg_reg_i_4),
        .O(n_0_tx_data_valid_i_5));
LUT5 #(
    .INIT(32'hF8888888)) 
     tx_data_valid_i_6
       (.I0(n_0_tx_data_valid_i_7),
        .I1(two_byte_tx),
        .I2(tx_ack_int),
        .I3(tx_ce_sample),
        .I4(n_0_early_deassert_reg),
        .O(n_0_tx_data_valid_i_6));
LUT6 #(
    .INIT(64'h0008000800080000)) 
     tx_data_valid_i_7
       (.I0(n_0_no_burst_i_2),
        .I1(n_0_force_end_i_4),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[8] ),
        .O(n_0_tx_data_valid_i_7));
FDRE tx_data_valid_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_tx_data_valid_i_1),
        .Q(tx_data_valid_int),
        .R(\<const0> ));
FDRE tx_enable_reg_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(tx_enable),
        .Q(tx_ce_sample),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'hFFFFFFFF00000004)) 
     tx_mac_tready_reg_i_1
       (.I0(n_0_tx_mac_tready_reg_i_2),
        .I1(n_0_tx_mac_tready_reg_i_3),
        .I2(n_0_tx_mac_tready_reg_reg_i_4),
        .I3(two_byte_tx),
        .I4(n_0_early_deassert_reg),
        .I5(n_0_tx_mac_tready_reg_i_5),
        .O(tx_mac_tready_reg0));
LUT2 #(
    .INIT(4'h8)) 
     tx_mac_tready_reg_i_11
       (.I0(n_0_tx_mac_tready_reg_i_25),
        .I1(n_0_force_end_i_7),
        .O(n_0_tx_mac_tready_reg_i_11));
LUT6 #(
    .INIT(64'hAAAAAAAABFAAAAAA)) 
     tx_mac_tready_reg_i_12
       (.I0(n_0_tx_mac_tready_reg_i_26),
        .I1(n_0_no_burst_i_2),
        .I2(n_0_force_end_i_4),
        .I3(n_0_tx_mac_tready_reg_i_15),
        .I4(n_0_force_end_i_7),
        .I5(n_0_tx_mac_tready_reg_i_27),
        .O(n_0_tx_mac_tready_reg_i_12));
LUT6 #(
    .INIT(64'hFF003FE0FFFF3FFF)) 
     tx_mac_tready_reg_i_13
       (.I0(tx_axis_mac_tvalid),
        .I1(n_0_force_end_i_7),
        .I2(\n_0_tx_data[7]_i_5 ),
        .I3(n_0_force_end_i_4),
        .I4(n_0_tx_mac_tready_reg_i_28),
        .I5(I2),
        .O(n_0_tx_mac_tready_reg_i_13));
(* SOFT_HLUTNM = "soft_lutpair20" *) 
   LUT3 #(
    .INIT(8'hB0)) 
     tx_mac_tready_reg_i_14
       (.I0(n_0_no_burst_i_2),
        .I1(tx_axis_mac_tvalid),
        .I2(n_0_force_end_i_4),
        .O(n_0_tx_mac_tready_reg_i_14));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT2 #(
    .INIT(4'h8)) 
     tx_mac_tready_reg_i_15
       (.I0(tx_axis_mac_tuser),
        .I1(tx_axis_mac_tlast),
        .O(n_0_tx_mac_tready_reg_i_15));
LUT6 #(
    .INIT(64'h8888888888888880)) 
     tx_mac_tready_reg_i_16
       (.I0(tx_axis_mac_tvalid),
        .I1(n_0_no_burst_i_2),
        .I2(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[6] ),
        .O(n_0_tx_mac_tready_reg_i_16));
LUT6 #(
    .INIT(64'hFC00FC3BFC3BFC3B)) 
     tx_mac_tready_reg_i_17
       (.I0(n_0_tx_mac_tready_reg_i_29),
        .I1(n_0_force_end_i_4),
        .I2(tx_axis_mac_tvalid),
        .I3(n_0_no_burst_i_2),
        .I4(tx_ce_sample),
        .I5(tx_ack_int),
        .O(n_0_tx_mac_tready_reg_i_17));
LUT6 #(
    .INIT(64'hC0C3C0C3BBBBC0C3)) 
     tx_mac_tready_reg_i_18
       (.I0(\n_0_FSM_onehot_tx_state[9]_i_22 ),
        .I1(n_0_force_end_i_4),
        .I2(n_0_tx_mac_tready_reg_i_15),
        .I3(I2),
        .I4(\n_0_tx_data[7]_i_5 ),
        .I5(n_0_tx_mac_tready_reg_i_28),
        .O(n_0_tx_mac_tready_reg_i_18));
LUT6 #(
    .INIT(64'h7575754575757575)) 
     tx_mac_tready_reg_i_19
       (.I0(tx_ce_sample),
        .I1(n_0_tx_mac_tready_reg_i_28),
        .I2(\n_0_tx_data[7]_i_5 ),
        .I3(n_0_early_deassert_reg),
        .I4(two_byte_tx),
        .I5(n_0_early_deassert_i_4),
        .O(n_0_tx_mac_tready_reg_i_19));
(* SOFT_HLUTNM = "soft_lutpair22" *) 
   LUT2 #(
    .INIT(4'hB)) 
     tx_mac_tready_reg_i_2
       (.I0(n_0_tx_mac_tready_reg_i_6),
        .I1(n_0_tx_mac_tready_reg_i_7),
        .O(n_0_tx_mac_tready_reg_i_2));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT5 #(
    .INIT(32'hFFFFFDFF)) 
     tx_mac_tready_reg_i_20
       (.I0(tx_ce_sample),
        .I1(n_0_ignore_packet_reg),
        .I2(no_burst),
        .I3(tx_axis_mac_tvalid),
        .I4(tx_axis_mac_tuser),
        .O(n_0_tx_mac_tready_reg_i_20));
LUT6 #(
    .INIT(64'h5555555455545554)) 
     tx_mac_tready_reg_i_21
       (.I0(tx_axis_mac_tvalid),
        .I1(force_end),
        .I2(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I4(tx_ce_sample),
        .I5(tx_ack_int),
        .O(n_0_tx_mac_tready_reg_i_21));
LUT6 #(
    .INIT(64'h0000000000000002)) 
     tx_mac_tready_reg_i_22
       (.I0(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[5] ),
        .O(n_0_tx_mac_tready_reg_i_22));
LUT4 #(
    .INIT(16'hA800)) 
     tx_mac_tready_reg_i_23
       (.I0(n_0_no_burst_i_2),
        .I1(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I3(tx_axis_mac_tvalid),
        .O(n_0_tx_mac_tready_reg_i_23));
LUT6 #(
    .INIT(64'h5755575544444744)) 
     tx_mac_tready_reg_i_24
       (.I0(tx_ce_sample),
        .I1(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I2(\n_0_FSM_onehot_tx_state[9]_i_15 ),
        .I3(\n_0_tx_data[7]_i_5 ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_30 ),
        .I5(\n_0_FSM_onehot_tx_state_reg[8] ),
        .O(n_0_tx_mac_tready_reg_i_24));
LUT6 #(
    .INIT(64'hA8A8000000A800A8)) 
     tx_mac_tready_reg_i_25
       (.I0(n_0_force_end_i_4),
        .I1(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I3(tx_ce_sample),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_30 ),
        .I5(n_0_no_burst_i_2),
        .O(n_0_tx_mac_tready_reg_i_25));
LUT6 #(
    .INIT(64'h00FA00FB00A000F0)) 
     tx_mac_tready_reg_i_26
       (.I0(tx_axis_mac_tvalid),
        .I1(force_end),
        .I2(n_0_no_burst_i_2),
        .I3(n_0_force_end_i_7),
        .I4(I2),
        .I5(n_0_force_end_i_4),
        .O(n_0_tx_mac_tready_reg_i_26));
LUT6 #(
    .INIT(64'h00000000FE000000)) 
     tx_mac_tready_reg_i_27
       (.I0(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I2(n_0_tx_mac_tready_reg_i_28),
        .I3(tx_ack_int),
        .I4(tx_ce_sample),
        .I5(n_0_force_end_i_4),
        .O(n_0_tx_mac_tready_reg_i_27));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT3 #(
    .INIT(8'hFE)) 
     tx_mac_tready_reg_i_28
       (.I0(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .O(n_0_tx_mac_tready_reg_i_28));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     tx_mac_tready_reg_i_29
       (.I0(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I3(force_end),
        .I4(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[3] ),
        .O(n_0_tx_mac_tready_reg_i_29));
LUT6 #(
    .INIT(64'hFFFA000C000A000C)) 
     tx_mac_tready_reg_i_3
       (.I0(n_0_tx_mac_tready_reg_i_8),
        .I1(n_0_tx_mac_tready_reg_i_9),
        .I2(\n_0_FSM_onehot_tx_state_reg[9] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I4(n_0_force_end_i_7),
        .I5(n_0_tx_mac_tready_reg_reg_i_10),
        .O(n_0_tx_mac_tready_reg_i_3));
LUT6 #(
    .INIT(64'hBAEEBAFEAAEBAAEB)) 
     tx_mac_tready_reg_i_5
       (.I0(n_0_ignore_packet_reg),
        .I1(n_0_tx_mac_tready_reg_reg_i_4),
        .I2(n_0_tx_mac_tready_reg_i_6),
        .I3(n_0_tx_mac_tready_reg_i_3),
        .I4(tx_axis_mac_tlast),
        .I5(n_0_tx_mac_tready_reg_i_7),
        .O(n_0_tx_mac_tready_reg_i_5));
LUT6 #(
    .INIT(64'h0AFF22000A002200)) 
     tx_mac_tready_reg_i_6
       (.I0(n_0_tx_mac_tready_reg_i_13),
        .I1(n_0_tx_mac_tready_reg_i_14),
        .I2(n_0_tx_mac_tready_reg_i_15),
        .I3(n_0_no_burst_i_3),
        .I4(n_0_force_end_i_7),
        .I5(n_0_tx_mac_tready_reg_i_16),
        .O(n_0_tx_mac_tready_reg_i_6));
LUT6 #(
    .INIT(64'h305F3F5F3F5F3F5F)) 
     tx_mac_tready_reg_i_7
       (.I0(n_0_tx_mac_tready_reg_i_17),
        .I1(n_0_tx_mac_tready_reg_i_18),
        .I2(n_0_no_burst_i_3),
        .I3(n_0_force_end_i_7),
        .I4(n_0_tx_mac_tready_reg_i_19),
        .I5(n_0_force_end_i_4),
        .O(n_0_tx_mac_tready_reg_i_7));
LUT6 #(
    .INIT(64'h0808080833003303)) 
     tx_mac_tready_reg_i_8
       (.I0(n_0_tx_mac_tready_reg_i_20),
        .I1(n_0_force_end_i_4),
        .I2(n_0_no_burst_i_3),
        .I3(I2),
        .I4(n_0_tx_mac_tready_reg_i_15),
        .I5(n_0_no_burst_i_2),
        .O(n_0_tx_mac_tready_reg_i_8));
LUT6 #(
    .INIT(64'h00000300BBBB8B88)) 
     tx_mac_tready_reg_i_9
       (.I0(n_0_tx_mac_tready_reg_i_21),
        .I1(n_0_force_end_i_4),
        .I2(tx_axis_mac_tvalid),
        .I3(n_0_tx_mac_tready_reg_i_22),
        .I4(I2),
        .I5(n_0_no_burst_i_2),
        .O(n_0_tx_mac_tready_reg_i_9));
FDRE #(
    .INIT(1'b0)) 
     tx_mac_tready_reg_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(tx_mac_tready_reg0),
        .Q(tx_mac_tready_reg),
        .R(I1));
MUXF7 tx_mac_tready_reg_reg_i_10
       (.I0(n_0_tx_mac_tready_reg_i_23),
        .I1(n_0_tx_mac_tready_reg_i_24),
        .O(n_0_tx_mac_tready_reg_reg_i_10),
        .S(n_0_force_end_i_4));
MUXF7 tx_mac_tready_reg_reg_i_4
       (.I0(n_0_tx_mac_tready_reg_i_11),
        .I1(n_0_tx_mac_tready_reg_i_12),
        .O(n_0_tx_mac_tready_reg_reg_i_4),
        .S(n_0_no_burst_i_3));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT4 #(
    .INIT(16'h1303)) 
     tx_underrun_i_1
       (.I0(tx_ce_sample),
        .I1(I1),
        .I2(n_0_tx_underrun_i_2),
        .I3(tx_underrun_int),
        .O(n_0_tx_underrun_i_1));
LUT6 #(
    .INIT(64'h00000000FFFF777F)) 
     tx_underrun_i_2
       (.I0(n_0_early_underrun_reg),
        .I1(tx_ce_sample),
        .I2(force_end),
        .I3(tx_ack_int),
        .I4(n_0_early_underrun_i_3),
        .I5(n_0_tx_underrun_i_3),
        .O(n_0_tx_underrun_i_2));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT5 #(
    .INIT(32'hA2000000)) 
     tx_underrun_i_3
       (.I0(n_0_tx_data_valid_i_7),
        .I1(tx_axis_mac_tvalid),
        .I2(tx_axis_mac_tuser),
        .I3(tx_mac_tready_reg),
        .I4(gate_tready),
        .O(n_0_tx_underrun_i_3));
FDRE tx_underrun_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_tx_underrun_i_1),
        .Q(tx_underrun_int),
        .R(\<const0> ));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_tx_cntl
   (O1,
    O2,
    control_complete,
    O3,
    tx_ack_int,
    O4,
    O5,
    O6,
    O8,
    O9,
    int_tx_data_valid_out,
    O7,
    tx_status,
    pfc_pause_req_out,
    int_tx_crc_enable_out,
    int_tx_vlan_enable_out,
    E,
    I11,
    O11,
    O12,
    O10,
    I1,
    tx_ce_sample,
    tx_data_valid_int,
    gtx_clk,
    int_tx_ack_in,
    I4,
    pause_status_req,
    I5,
    I6,
    REG_DATA_VALID,
    I7,
    INT_ENABLE,
    I8,
    I9,
    MAX_PKT_LEN_REACHED,
    pause_status_int,
    tx_configuration_vector,
    pause_req,
    Q,
    I2,
    I10,
    tx_statistics_vector,
    tx_statistics_valid,
    I15,
    pfc_req,
    data_out,
    pause_req_int0,
    I16,
    I17,
    I3,
    I12,
    I13,
    I14,
    I18,
    I19,
    I20,
    I21);
  output O1;
  output O2;
  output control_complete;
  output O3;
  output tx_ack_int;
  output O4;
  output O5;
  output O6;
  output O8;
  output O9;
  output int_tx_data_valid_out;
  output O7;
  output tx_status;
  output pfc_pause_req_out;
  output int_tx_crc_enable_out;
  output int_tx_vlan_enable_out;
  output [0:0]E;
  output [7:0]I11;
  output O11;
  output O12;
  output O10;
  input I1;
  input tx_ce_sample;
  input tx_data_valid_int;
  input gtx_clk;
  input int_tx_ack_in;
  input I4;
  input pause_status_req;
  input I5;
  input I6;
  input REG_DATA_VALID;
  input I7;
  input INT_ENABLE;
  input I8;
  input I9;
  input MAX_PKT_LEN_REACHED;
  input pause_status_int;
  input [49:0]tx_configuration_vector;
  input pause_req;
  input [7:0]Q;
  input [7:0]I2;
  input I10;
  input [0:0]tx_statistics_vector;
  input tx_statistics_valid;
  input I15;
  input pfc_req;
  input data_out;
  input pause_req_int0;
  input I16;
  input I17;
  input I3;
  input I12;
  input I13;
  input I14;
  input I18;
  input I19;
  input I20;
  input I21;

  wire \<const0> ;
  wire \<const1> ;
  wire [0:0]E;
  wire I1;
  wire I10;
  wire [7:0]I11;
  wire I12;
  wire I13;
  wire I14;
  wire I15;
  wire I16;
  wire I17;
  wire I18;
  wire I19;
  wire [7:0]I2;
  wire I20;
  wire I21;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire INT_ENABLE;
  wire MAX_PKT_LEN_REACHED;
  wire O1;
  wire O10;
  wire O11;
  wire O12;
  wire O2;
  wire O3;
  wire O4;
  wire O5;
  wire O6;
  wire O7;
  wire O8;
  wire O9;
  wire [7:0]Q;
  wire REG_DATA_VALID;
  wire ack_int;
  wire control_complete;
  wire control_complete0;
  wire control_complete_1;
  wire [7:0]data3;
  wire data_avail_control3_out;
  wire [7:0]data_control;
  wire [7:0]data_control_0;
  wire data_out;
  wire end_of_tx_reg;
  wire [7:0]fixed_frame_fields;
  wire gtx_clk;
  wire int_tx_ack_in;
  wire int_tx_crc_enable_out;
  wire int_tx_data_valid_out;
  wire int_tx_vlan_enable_out;
  wire n_0_DST_ADDR_BYTE_MATCH_i_4;
  wire n_0_DST_ADDR_BYTE_MATCH_i_5;
  wire n_0_ack_out_i_1;
  wire n_0_control_complete_i_1;
  wire n_0_control_complete_i_4;
  wire n_0_data_avail_control_i_1;
  wire n_0_data_avail_control_i_2;
  wire n_0_data_avail_control_i_4;
  wire \n_0_data_control[0]_i_2 ;
  wire \n_0_data_control[1]_i_2 ;
  wire \n_0_data_control[2]_i_2 ;
  wire \n_0_data_control[3]_i_2 ;
  wire \n_0_data_control[4]_i_2 ;
  wire \n_0_data_control[5]_i_2 ;
  wire \n_0_data_control[6]_i_2 ;
  wire \n_0_data_control[7]_i_2 ;
  wire \n_0_data_control[7]_i_3 ;
  wire \n_0_data_control[7]_i_4 ;
  wire \n_0_data_control[7]_i_5 ;
  wire \n_0_data_control[7]_i_6 ;
  wire \n_0_data_count[0]_i_1 ;
  wire \n_0_data_count[1]_i_1 ;
  wire \n_0_data_count[2]_i_1 ;
  wire \n_0_data_count[3]_i_1 ;
  wire \n_0_data_count[3]_i_2 ;
  wire \n_0_data_count[4]_i_1 ;
  wire \n_0_data_count[4]_i_3 ;
  wire \n_0_data_count[5]_i_1 ;
  wire \n_0_data_count[5]_i_2__0 ;
  wire \n_0_data_count[5]_i_4 ;
  wire \n_0_data_count_reg[0] ;
  wire \n_0_data_count_reg[1] ;
  wire \n_0_data_count_reg[2] ;
  wire \n_0_data_count_reg[3] ;
  wire \n_0_data_count_reg[4] ;
  wire \n_0_data_count_reg[5] ;
  wire n_0_end_of_tx_held_i_1;
  wire n_0_end_of_tx_held_i_2;
  wire n_0_end_of_tx_held_reg;
  wire n_0_load_source_i_1;
  wire n_0_mux_control_i_1;
  wire n_0_mux_control_i_2;
  wire n_0_mux_control_i_3;
  wire n_0_mux_control_i_4;
  wire n_0_pause_req_int_i_1;
  wire \n_0_pause_source_shift[0]_i_1 ;
  wire \n_0_pause_source_shift[10]_i_1 ;
  wire \n_0_pause_source_shift[11]_i_1 ;
  wire \n_0_pause_source_shift[12]_i_1 ;
  wire \n_0_pause_source_shift[13]_i_1 ;
  wire \n_0_pause_source_shift[14]_i_1 ;
  wire \n_0_pause_source_shift[15]_i_1 ;
  wire \n_0_pause_source_shift[16]_i_1 ;
  wire \n_0_pause_source_shift[17]_i_1 ;
  wire \n_0_pause_source_shift[18]_i_1 ;
  wire \n_0_pause_source_shift[19]_i_1 ;
  wire \n_0_pause_source_shift[1]_i_1 ;
  wire \n_0_pause_source_shift[20]_i_1 ;
  wire \n_0_pause_source_shift[21]_i_1 ;
  wire \n_0_pause_source_shift[22]_i_1 ;
  wire \n_0_pause_source_shift[23]_i_1 ;
  wire \n_0_pause_source_shift[24]_i_1 ;
  wire \n_0_pause_source_shift[25]_i_1 ;
  wire \n_0_pause_source_shift[26]_i_1 ;
  wire \n_0_pause_source_shift[27]_i_1 ;
  wire \n_0_pause_source_shift[28]_i_1 ;
  wire \n_0_pause_source_shift[29]_i_1 ;
  wire \n_0_pause_source_shift[2]_i_1 ;
  wire \n_0_pause_source_shift[30]_i_1 ;
  wire \n_0_pause_source_shift[31]_i_1 ;
  wire \n_0_pause_source_shift[32]_i_1 ;
  wire \n_0_pause_source_shift[33]_i_1 ;
  wire \n_0_pause_source_shift[34]_i_1 ;
  wire \n_0_pause_source_shift[35]_i_1 ;
  wire \n_0_pause_source_shift[36]_i_1 ;
  wire \n_0_pause_source_shift[37]_i_1 ;
  wire \n_0_pause_source_shift[38]_i_1 ;
  wire \n_0_pause_source_shift[39]_i_1 ;
  wire \n_0_pause_source_shift[3]_i_1 ;
  wire \n_0_pause_source_shift[4]_i_1 ;
  wire \n_0_pause_source_shift[5]_i_1 ;
  wire \n_0_pause_source_shift[6]_i_1 ;
  wire \n_0_pause_source_shift[7]_i_1 ;
  wire \n_0_pause_source_shift[8]_i_1 ;
  wire \n_0_pause_source_shift[9]_i_1 ;
  wire \n_0_pause_value_sample[10]_i_1 ;
  wire \n_0_pause_value_sample[11]_i_1 ;
  wire \n_0_pause_value_sample[12]_i_1 ;
  wire \n_0_pause_value_sample[13]_i_1 ;
  wire \n_0_pause_value_sample[14]_i_1 ;
  wire \n_0_pause_value_sample[15]_i_1 ;
  wire \n_0_pause_value_sample[8]_i_1 ;
  wire \n_0_pause_value_sample[9]_i_1 ;
  wire \n_0_pause_value_sample_reg[0] ;
  wire \n_0_pause_value_sample_reg[1] ;
  wire \n_0_pause_value_sample_reg[2] ;
  wire \n_0_pause_value_sample_reg[3] ;
  wire \n_0_pause_value_sample_reg[4] ;
  wire \n_0_pause_value_sample_reg[5] ;
  wire \n_0_pause_value_sample_reg[6] ;
  wire \n_0_pause_value_sample_reg[7] ;
  wire n_0_pfc_pause_req_int_i_1;
  wire n_0_sample_int_i_1;
  wire n_0_sample_int_i_2;
  wire \n_0_state_count[0]_i_1 ;
  wire \n_0_state_count[1]_i_1 ;
  wire \n_0_state_count[2]_i_1 ;
  wire \n_0_state_count[2]_i_2 ;
  wire \n_0_state_count[2]_i_3 ;
  wire \n_0_state_count[2]_i_4 ;
  wire \n_0_state_count_reg[1] ;
  wire \n_0_state_count_reg[2] ;
  wire pause_req;
  wire pause_req_int;
  wire pause_req_int0;
  wire [47:0]pause_source_shift;
  wire pause_status_int;
  wire pause_status_req;
  wire pfc_pause_req_out;
  wire [7:0]\pfc_quanta_pipe_reg[1]_0 ;
  wire pfc_req;
  wire tx_ack_int;
  wire tx_ce_sample;
  wire [49:0]tx_configuration_vector;
  wire tx_data_valid_int;
  wire tx_statistics_valid;
  wire [0:0]tx_statistics_vector;
  wire tx_status;

LUT5 #(
    .INIT(32'hE2000000)) 
     CDS_i_2
       (.I0(O1),
        .I1(O5),
        .I2(O6),
        .I3(INT_ENABLE),
        .I4(I8),
        .O(O8));
(* SOFT_HLUTNM = "soft_lutpair123" *) 
   LUT5 #(
    .INIT(32'hFFFFE2FF)) 
     CFL_i_2
       (.I0(O1),
        .I1(O5),
        .I2(O6),
        .I3(I9),
        .I4(MAX_PKT_LEN_REACHED),
        .O(O9));
LUT3 #(
    .INIT(8'hB8)) 
     \DATA_REG[0][0]_i_1 
       (.I0(data_control[0]),
        .I1(O5),
        .I2(Q[0]),
        .O(I11[0]));
(* SOFT_HLUTNM = "soft_lutpair143" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \DATA_REG[0][1]_i_1 
       (.I0(data_control[1]),
        .I1(O5),
        .I2(Q[1]),
        .O(I11[1]));
(* SOFT_HLUTNM = "soft_lutpair153" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \DATA_REG[0][2]_i_1 
       (.I0(data_control[2]),
        .I1(O5),
        .I2(Q[2]),
        .O(I11[2]));
(* SOFT_HLUTNM = "soft_lutpair154" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \DATA_REG[0][3]_i_1 
       (.I0(data_control[3]),
        .I1(O5),
        .I2(Q[3]),
        .O(I11[3]));
(* SOFT_HLUTNM = "soft_lutpair155" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \DATA_REG[0][4]_i_1 
       (.I0(data_control[4]),
        .I1(O5),
        .I2(Q[4]),
        .O(I11[4]));
(* SOFT_HLUTNM = "soft_lutpair125" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \DATA_REG[0][5]_i_1 
       (.I0(data_control[5]),
        .I1(O5),
        .I2(Q[5]),
        .O(I11[5]));
(* SOFT_HLUTNM = "soft_lutpair155" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \DATA_REG[0][6]_i_1 
       (.I0(data_control[6]),
        .I1(O5),
        .I2(Q[6]),
        .O(I11[6]));
(* SOFT_HLUTNM = "soft_lutpair154" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \DATA_REG[0][7]_i_1 
       (.I0(data_control[7]),
        .I1(O5),
        .I2(Q[7]),
        .O(I11[7]));
LUT6 #(
    .INIT(64'hB830880000000000)) 
     DST_ADDR_BYTE_MATCH_i_2
       (.I0(data_control[1]),
        .I1(O5),
        .I2(Q[1]),
        .I3(data_control[4]),
        .I4(Q[4]),
        .I5(n_0_DST_ADDR_BYTE_MATCH_i_4),
        .O(O12));
LUT6 #(
    .INIT(64'hB830880000000000)) 
     DST_ADDR_BYTE_MATCH_i_3
       (.I0(data_control[6]),
        .I1(O5),
        .I2(Q[6]),
        .I3(data_control[7]),
        .I4(Q[7]),
        .I5(n_0_DST_ADDR_BYTE_MATCH_i_5),
        .O(O11));
LUT6 #(
    .INIT(64'hC000A0A0C0000000)) 
     DST_ADDR_BYTE_MATCH_i_4
       (.I0(Q[2]),
        .I1(data_control[2]),
        .I2(I10),
        .I3(data_control[0]),
        .I4(O5),
        .I5(Q[0]),
        .O(n_0_DST_ADDR_BYTE_MATCH_i_4));
(* SOFT_HLUTNM = "soft_lutpair125" *) 
   LUT5 #(
    .INIT(32'hCCA000A0)) 
     DST_ADDR_BYTE_MATCH_i_5
       (.I0(Q[5]),
        .I1(data_control[5]),
        .I2(Q[3]),
        .I3(O5),
        .I4(data_control[3]),
        .O(n_0_DST_ADDR_BYTE_MATCH_i_5));
GND GND
       (.G(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair143" *) 
   LUT2 #(
    .INIT(4'h2)) 
     INT_CRC_MODE_i_1
       (.I0(tx_configuration_vector[1]),
        .I1(O5),
        .O(int_tx_crc_enable_out));
(* SOFT_HLUTNM = "soft_lutpair153" *) 
   LUT2 #(
    .INIT(4'h2)) 
     INT_VLAN_ENABLE_i_1
       (.I0(tx_configuration_vector[0]),
        .I1(O5),
        .O(int_tx_vlan_enable_out));
(* SOFT_HLUTNM = "soft_lutpair123" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     REG_DATA_VALID_i_1
       (.I0(O6),
        .I1(O5),
        .I2(O1),
        .O(int_tx_data_valid_out));
VCC VCC
       (.P(\<const1> ));
FDRE ack_int_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(int_tx_ack_in),
        .Q(ack_int),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair128" *) 
   LUT5 #(
    .INIT(32'h00000ACA)) 
     ack_out_i_1
       (.I0(tx_ack_int),
        .I1(int_tx_ack_in),
        .I2(tx_ce_sample),
        .I3(O5),
        .I4(I1),
        .O(n_0_ack_out_i_1));
FDRE ack_out_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_ack_out_i_1),
        .Q(tx_ack_int),
        .R(\<const0> ));
LUT4 #(
    .INIT(16'hFFE2)) 
     control_complete_i_1
       (.I0(control_complete),
        .I1(tx_ce_sample),
        .I2(control_complete0),
        .I3(control_complete_1),
        .O(n_0_control_complete_i_1));
LUT6 #(
    .INIT(64'h0000400000000000)) 
     control_complete_i_2
       (.I0(\n_0_data_count_reg[2] ),
        .I1(\n_0_data_count_reg[5] ),
        .I2(pfc_pause_req_out),
        .I3(n_0_control_complete_i_4),
        .I4(\n_0_data_count_reg[1] ),
        .I5(\n_0_data_count_reg[0] ),
        .O(control_complete0));
LUT6 #(
    .INIT(64'h0000200000000000)) 
     control_complete_i_3
       (.I0(n_0_data_avail_control_i_4),
        .I1(pfc_pause_req_out),
        .I2(\n_0_data_count_reg[4] ),
        .I3(\n_0_data_count_reg[0] ),
        .I4(\n_0_data_count_reg[1] ),
        .I5(tx_ce_sample),
        .O(control_complete_1));
LUT2 #(
    .INIT(4'h1)) 
     control_complete_i_4
       (.I0(\n_0_data_count_reg[3] ),
        .I1(\n_0_data_count_reg[4] ),
        .O(n_0_control_complete_i_4));
FDRE #(
    .INIT(1'b0)) 
     control_complete_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_control_complete_i_1),
        .Q(control_complete),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'hFFFFFFFFFA2A0A2A)) 
     data_avail_control_i_1
       (.I0(O6),
        .I1(control_complete),
        .I2(tx_ce_sample),
        .I3(n_0_data_avail_control_i_2),
        .I4(end_of_tx_reg),
        .I5(data_avail_control3_out),
        .O(n_0_data_avail_control_i_1));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     data_avail_control_i_2
       (.I0(\n_0_data_count_reg[1] ),
        .I1(\n_0_data_count_reg[0] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .I4(\n_0_data_count_reg[5] ),
        .I5(\n_0_data_count_reg[4] ),
        .O(n_0_data_avail_control_i_2));
(* SOFT_HLUTNM = "soft_lutpair124" *) 
   LUT5 #(
    .INIT(32'h00200000)) 
     data_avail_control_i_3
       (.I0(n_0_data_avail_control_i_4),
        .I1(\n_0_data_count_reg[4] ),
        .I2(tx_ce_sample),
        .I3(\n_0_data_count_reg[1] ),
        .I4(\n_0_data_count_reg[0] ),
        .O(data_avail_control3_out));
(* SOFT_HLUTNM = "soft_lutpair129" *) 
   LUT3 #(
    .INIT(8'h01)) 
     data_avail_control_i_4
       (.I0(\n_0_data_count_reg[2] ),
        .I1(\n_0_data_count_reg[3] ),
        .I2(\n_0_data_count_reg[5] ),
        .O(n_0_data_avail_control_i_4));
FDRE #(
    .INIT(1'b0)) 
     data_avail_control_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_data_avail_control_i_1),
        .Q(O6),
        .R(\<const0> ));
FDRE data_avail_in_reg_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_data_valid_int),
        .Q(O1),
        .R(I1));
LUT5 #(
    .INIT(32'hB833B800)) 
     \data_control[0]_i_1 
       (.I0(data3[0]),
        .I1(\n_0_data_control[7]_i_2 ),
        .I2(\pfc_quanta_pipe_reg[1]_0 [0]),
        .I3(\n_0_data_control[7]_i_3 ),
        .I4(\n_0_data_control[0]_i_2 ),
        .O(data_control_0[0]));
LUT5 #(
    .INIT(32'hF3C0B8B8)) 
     \data_control[0]_i_2 
       (.I0(pfc_pause_req_out),
        .I1(\n_0_data_control[7]_i_5 ),
        .I2(fixed_frame_fields[0]),
        .I3(pause_source_shift[0]),
        .I4(\n_0_data_control[7]_i_6 ),
        .O(\n_0_data_control[0]_i_2 ));
LUT5 #(
    .INIT(32'hB833B800)) 
     \data_control[1]_i_1 
       (.I0(data3[1]),
        .I1(\n_0_data_control[7]_i_2 ),
        .I2(\pfc_quanta_pipe_reg[1]_0 [1]),
        .I3(\n_0_data_control[7]_i_3 ),
        .I4(\n_0_data_control[1]_i_2 ),
        .O(data_control_0[1]));
LUT4 #(
    .INIT(16'hEF40)) 
     \data_control[1]_i_2 
       (.I0(\n_0_data_control[7]_i_5 ),
        .I1(pause_source_shift[1]),
        .I2(\n_0_data_control[7]_i_6 ),
        .I3(fixed_frame_fields[1]),
        .O(\n_0_data_control[1]_i_2 ));
LUT5 #(
    .INIT(32'hB833B800)) 
     \data_control[2]_i_1 
       (.I0(data3[2]),
        .I1(\n_0_data_control[7]_i_2 ),
        .I2(\pfc_quanta_pipe_reg[1]_0 [2]),
        .I3(\n_0_data_control[7]_i_3 ),
        .I4(\n_0_data_control[2]_i_2 ),
        .O(data_control_0[2]));
LUT4 #(
    .INIT(16'hEF40)) 
     \data_control[2]_i_2 
       (.I0(\n_0_data_control[7]_i_5 ),
        .I1(pause_source_shift[2]),
        .I2(\n_0_data_control[7]_i_6 ),
        .I3(fixed_frame_fields[2]),
        .O(\n_0_data_control[2]_i_2 ));
LUT5 #(
    .INIT(32'hB833B800)) 
     \data_control[3]_i_1 
       (.I0(data3[3]),
        .I1(\n_0_data_control[7]_i_2 ),
        .I2(\pfc_quanta_pipe_reg[1]_0 [3]),
        .I3(\n_0_data_control[7]_i_3 ),
        .I4(\n_0_data_control[3]_i_2 ),
        .O(data_control_0[3]));
LUT4 #(
    .INIT(16'hEF40)) 
     \data_control[3]_i_2 
       (.I0(\n_0_data_control[7]_i_5 ),
        .I1(pause_source_shift[3]),
        .I2(\n_0_data_control[7]_i_6 ),
        .I3(fixed_frame_fields[3]),
        .O(\n_0_data_control[3]_i_2 ));
LUT5 #(
    .INIT(32'hB833B800)) 
     \data_control[4]_i_1 
       (.I0(data3[4]),
        .I1(\n_0_data_control[7]_i_2 ),
        .I2(\pfc_quanta_pipe_reg[1]_0 [4]),
        .I3(\n_0_data_control[7]_i_3 ),
        .I4(\n_0_data_control[4]_i_2 ),
        .O(data_control_0[4]));
LUT4 #(
    .INIT(16'hEF40)) 
     \data_control[4]_i_2 
       (.I0(\n_0_data_control[7]_i_5 ),
        .I1(pause_source_shift[4]),
        .I2(\n_0_data_control[7]_i_6 ),
        .I3(fixed_frame_fields[4]),
        .O(\n_0_data_control[4]_i_2 ));
LUT5 #(
    .INIT(32'hB833B800)) 
     \data_control[5]_i_1 
       (.I0(data3[5]),
        .I1(\n_0_data_control[7]_i_2 ),
        .I2(\pfc_quanta_pipe_reg[1]_0 [5]),
        .I3(\n_0_data_control[7]_i_3 ),
        .I4(\n_0_data_control[5]_i_2 ),
        .O(data_control_0[5]));
LUT4 #(
    .INIT(16'hEF40)) 
     \data_control[5]_i_2 
       (.I0(\n_0_data_control[7]_i_5 ),
        .I1(pause_source_shift[5]),
        .I2(\n_0_data_control[7]_i_6 ),
        .I3(fixed_frame_fields[5]),
        .O(\n_0_data_control[5]_i_2 ));
LUT5 #(
    .INIT(32'hB833B800)) 
     \data_control[6]_i_1 
       (.I0(data3[6]),
        .I1(\n_0_data_control[7]_i_2 ),
        .I2(\pfc_quanta_pipe_reg[1]_0 [6]),
        .I3(\n_0_data_control[7]_i_3 ),
        .I4(\n_0_data_control[6]_i_2 ),
        .O(data_control_0[6]));
LUT4 #(
    .INIT(16'hEF40)) 
     \data_control[6]_i_2 
       (.I0(\n_0_data_control[7]_i_5 ),
        .I1(pause_source_shift[6]),
        .I2(\n_0_data_control[7]_i_6 ),
        .I3(fixed_frame_fields[6]),
        .O(\n_0_data_control[6]_i_2 ));
LUT5 #(
    .INIT(32'hB833B800)) 
     \data_control[7]_i_1 
       (.I0(data3[7]),
        .I1(\n_0_data_control[7]_i_2 ),
        .I2(\pfc_quanta_pipe_reg[1]_0 [7]),
        .I3(\n_0_data_control[7]_i_3 ),
        .I4(\n_0_data_control[7]_i_4 ),
        .O(data_control_0[7]));
LUT6 #(
    .INIT(64'h0002000400000004)) 
     \data_control[7]_i_2 
       (.I0(\n_0_data_count_reg[5] ),
        .I1(\n_0_data_count_reg[4] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .I4(\n_0_data_count_reg[1] ),
        .I5(\n_0_data_count_reg[0] ),
        .O(\n_0_data_control[7]_i_2 ));
LUT6 #(
    .INIT(64'hFFFFFFF7FFFF0000)) 
     \data_control[7]_i_3 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .I2(\n_0_data_count_reg[3] ),
        .I3(\n_0_data_count_reg[2] ),
        .I4(\n_0_data_count_reg[4] ),
        .I5(\n_0_data_count_reg[5] ),
        .O(\n_0_data_control[7]_i_3 ));
LUT4 #(
    .INIT(16'hEF40)) 
     \data_control[7]_i_4 
       (.I0(\n_0_data_control[7]_i_5 ),
        .I1(pause_source_shift[7]),
        .I2(\n_0_data_control[7]_i_6 ),
        .I3(fixed_frame_fields[7]),
        .O(\n_0_data_control[7]_i_4 ));
LUT6 #(
    .INIT(64'hFFFFFFF7FFFCC000)) 
     \data_control[7]_i_5 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .I2(\n_0_data_count_reg[3] ),
        .I3(\n_0_data_count_reg[2] ),
        .I4(\n_0_data_count_reg[4] ),
        .I5(\n_0_data_count_reg[5] ),
        .O(\n_0_data_control[7]_i_5 ));
LUT6 #(
    .INIT(64'h1114011000100010)) 
     \data_control[7]_i_6 
       (.I0(\n_0_data_count_reg[4] ),
        .I1(\n_0_data_count_reg[5] ),
        .I2(\n_0_data_count_reg[3] ),
        .I3(\n_0_data_count_reg[2] ),
        .I4(\n_0_data_count_reg[0] ),
        .I5(\n_0_data_count_reg[1] ),
        .O(\n_0_data_control[7]_i_6 ));
FDRE #(
    .INIT(1'b0)) 
     \data_control_reg[0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(data_control_0[0]),
        .Q(data_control[0]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \data_control_reg[1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(data_control_0[1]),
        .Q(data_control[1]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \data_control_reg[2] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(data_control_0[2]),
        .Q(data_control[2]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \data_control_reg[3] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(data_control_0[3]),
        .Q(data_control[3]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \data_control_reg[4] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(data_control_0[4]),
        .Q(data_control[4]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \data_control_reg[5] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(data_control_0[5]),
        .Q(data_control[5]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \data_control_reg[6] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(data_control_0[6]),
        .Q(data_control[6]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \data_control_reg[7] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(data_control_0[7]),
        .Q(data_control[7]),
        .R(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair126" *) 
   LUT5 #(
    .INIT(32'hFFFF19AA)) 
     \data_count[0]_i_1 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(O7),
        .I2(pause_req_int),
        .I3(tx_ce_sample),
        .I4(I1),
        .O(\n_0_data_count[0]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFFF19AA2AAA)) 
     \data_count[1]_i_1 
       (.I0(\n_0_data_count_reg[1] ),
        .I1(O7),
        .I2(pause_req_int),
        .I3(tx_ce_sample),
        .I4(\n_0_data_count_reg[0] ),
        .I5(I1),
        .O(\n_0_data_count[1]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000006AAA)) 
     \data_count[2]_i_1 
       (.I0(\n_0_data_count_reg[2] ),
        .I1(I15),
        .I2(\n_0_data_count_reg[0] ),
        .I3(\n_0_data_count_reg[1] ),
        .I4(\n_0_data_count[5]_i_2__0 ),
        .I5(I1),
        .O(\n_0_data_count[2]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000006AAA)) 
     \data_count[3]_i_1 
       (.I0(\n_0_data_count_reg[3] ),
        .I1(I15),
        .I2(\n_0_data_count[3]_i_2 ),
        .I3(\n_0_data_count_reg[2] ),
        .I4(\n_0_data_count[5]_i_2__0 ),
        .I5(I1),
        .O(\n_0_data_count[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair124" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \data_count[3]_i_2 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .O(\n_0_data_count[3]_i_2 ));
LUT6 #(
    .INIT(64'h0000000006A6AAAA)) 
     \data_count[4]_i_1 
       (.I0(\n_0_data_count_reg[4] ),
        .I1(\n_0_data_count[5]_i_4 ),
        .I2(O7),
        .I3(pause_req_int),
        .I4(tx_ce_sample),
        .I5(I1),
        .O(\n_0_data_count[4]_i_1 ));
LUT5 #(
    .INIT(32'h8F8F8FFF)) 
     \data_count[4]_i_2 
       (.I0(\n_0_data_count[4]_i_3 ),
        .I1(\n_0_data_count_reg[5] ),
        .I2(O5),
        .I3(\n_0_state_count_reg[2] ),
        .I4(ack_int),
        .O(O7));
(* SOFT_HLUTNM = "soft_lutpair122" *) 
   LUT5 #(
    .INIT(32'h00001000)) 
     \data_count[4]_i_3 
       (.I0(\n_0_data_count_reg[4] ),
        .I1(\n_0_data_count_reg[3] ),
        .I2(\n_0_data_count_reg[0] ),
        .I3(\n_0_data_count_reg[1] ),
        .I4(\n_0_data_count_reg[2] ),
        .O(\n_0_data_count[4]_i_3 ));
LUT6 #(
    .INIT(64'hFFFFFFFF12222222)) 
     \data_count[5]_i_1 
       (.I0(\n_0_data_count_reg[5] ),
        .I1(\n_0_data_count[5]_i_2__0 ),
        .I2(I15),
        .I3(\n_0_data_count_reg[4] ),
        .I4(\n_0_data_count[5]_i_4 ),
        .I5(I1),
        .O(\n_0_data_count[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair126" *) 
   LUT3 #(
    .INIT(8'h80)) 
     \data_count[5]_i_2__0 
       (.I0(O7),
        .I1(pause_req_int),
        .I2(tx_ce_sample),
        .O(\n_0_data_count[5]_i_2__0 ));
(* SOFT_HLUTNM = "soft_lutpair122" *) 
   LUT4 #(
    .INIT(16'h8000)) 
     \data_count[5]_i_4 
       (.I0(\n_0_data_count_reg[1] ),
        .I1(\n_0_data_count_reg[0] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .O(\n_0_data_count[5]_i_4 ));
FDRE \data_count_reg[0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_data_count[0]_i_1 ),
        .Q(\n_0_data_count_reg[0] ),
        .R(\<const0> ));
FDRE \data_count_reg[1] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_data_count[1]_i_1 ),
        .Q(\n_0_data_count_reg[1] ),
        .R(\<const0> ));
FDRE \data_count_reg[2] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_data_count[2]_i_1 ),
        .Q(\n_0_data_count_reg[2] ),
        .R(\<const0> ));
FDRE \data_count_reg[3] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_data_count[3]_i_1 ),
        .Q(\n_0_data_count_reg[3] ),
        .R(\<const0> ));
FDRE \data_count_reg[4] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_data_count[4]_i_1 ),
        .Q(\n_0_data_count_reg[4] ),
        .R(\<const0> ));
FDRE \data_count_reg[5] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_data_count[5]_i_1 ),
        .Q(\n_0_data_count_reg[5] ),
        .R(\<const0> ));
LUT5 #(
    .INIT(32'h0000EA0A)) 
     end_of_tx_held_i_1
       (.I0(n_0_end_of_tx_held_reg),
        .I1(n_0_end_of_tx_held_i_2),
        .I2(tx_ce_sample),
        .I3(O1),
        .I4(I1),
        .O(n_0_end_of_tx_held_i_1));
LUT6 #(
    .INIT(64'h00000000E2000000)) 
     end_of_tx_held_i_2
       (.I0(O1),
        .I1(O5),
        .I2(O6),
        .I3(I6),
        .I4(REG_DATA_VALID),
        .I5(I7),
        .O(n_0_end_of_tx_held_i_2));
FDRE end_of_tx_held_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_end_of_tx_held_i_1),
        .Q(n_0_end_of_tx_held_reg),
        .R(\<const0> ));
FDRE end_of_tx_reg_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I4),
        .Q(end_of_tx_reg),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair128" *) 
   LUT2 #(
    .INIT(4'h8)) 
     force_end_i_5
       (.I0(tx_ack_int),
        .I1(tx_ce_sample),
        .O(O4));
LUT6 #(
    .INIT(64'h0000000000000010)) 
     load_source_i_1
       (.I0(\n_0_data_count_reg[1] ),
        .I1(\n_0_data_count_reg[0] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[5] ),
        .I4(\n_0_data_count_reg[3] ),
        .I5(\n_0_data_count_reg[4] ),
        .O(n_0_load_source_i_1));
FDRE load_source_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(n_0_load_source_i_1),
        .Q(O2),
        .R(I1));
LUT5 #(
    .INIT(32'hFFFEFAFA)) 
     mux_control_i_1
       (.I0(n_0_mux_control_i_2),
        .I1(pause_status_int),
        .I2(I1),
        .I3(n_0_mux_control_i_3),
        .I4(tx_ce_sample),
        .O(n_0_mux_control_i_1));
LUT6 #(
    .INIT(64'hA888AAAAAAAAAAAA)) 
     mux_control_i_2
       (.I0(O5),
        .I1(pause_req_int),
        .I2(n_0_end_of_tx_held_reg),
        .I3(O1),
        .I4(tx_ce_sample),
        .I5(tx_status),
        .O(n_0_mux_control_i_2));
LUT5 #(
    .INIT(32'h80FF80F0)) 
     mux_control_i_3
       (.I0(O5),
        .I1(n_0_mux_control_i_4),
        .I2(pause_status_req),
        .I3(I5),
        .I4(pause_req_int),
        .O(n_0_mux_control_i_3));
(* SOFT_HLUTNM = "soft_lutpair127" *) 
   LUT3 #(
    .INIT(8'h02)) 
     mux_control_i_4
       (.I0(tx_status),
        .I1(\n_0_state_count_reg[1] ),
        .I2(\n_0_state_count_reg[2] ),
        .O(n_0_mux_control_i_4));
FDRE mux_control_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_mux_control_i_1),
        .Q(O5),
        .R(\<const0> ));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT4 #(
    .INIT(16'h8021)) 
     \pause_fixed_field_lut[0].LUT4_special_pause_inst 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .O(fixed_frame_fields[0]));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT4 #(
    .INIT(16'h0004)) 
     \pause_fixed_field_lut[1].LUT4_special_pause_inst 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .O(fixed_frame_fields[1]));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT4 #(
    .INIT(16'h0000)) 
     \pause_fixed_field_lut[2].LUT4_special_pause_inst 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .O(fixed_frame_fields[2]));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT4 #(
    .INIT(16'h3000)) 
     \pause_fixed_field_lut[3].LUT4_special_pause_inst 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .O(fixed_frame_fields[3]));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT4 #(
    .INIT(16'h0000)) 
     \pause_fixed_field_lut[4].LUT4_special_pause_inst 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .O(fixed_frame_fields[4]));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT4 #(
    .INIT(16'h0000)) 
     \pause_fixed_field_lut[5].LUT4_special_pause_inst 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .O(fixed_frame_fields[5]));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT4 #(
    .INIT(16'h0004)) 
     \pause_fixed_field_lut[6].LUT4_special_pause_inst 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .O(fixed_frame_fields[6]));
(* BOX_TYPE = "PRIMITIVE" *) 
   LUT4 #(
    .INIT(16'h1006)) 
     \pause_fixed_field_lut[7].LUT4_special_pause_inst 
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .O(fixed_frame_fields[7]));
LUT5 #(
    .INIT(32'h00000EEE)) 
     pause_req_int_i_1
       (.I0(pause_req_int),
        .I1(pause_req_int0),
        .I2(tx_ce_sample),
        .I3(control_complete),
        .I4(I1),
        .O(n_0_pause_req_int_i_1));
FDRE pause_req_int_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_pause_req_int_i_1),
        .Q(pause_req_int),
        .R(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair152" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[0]_i_1 
       (.I0(tx_configuration_vector[2]),
        .I1(O2),
        .I2(pause_source_shift[8]),
        .O(\n_0_pause_source_shift[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair144" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[10]_i_1 
       (.I0(tx_configuration_vector[12]),
        .I1(O2),
        .I2(pause_source_shift[18]),
        .O(\n_0_pause_source_shift[10]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair148" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[11]_i_1 
       (.I0(tx_configuration_vector[13]),
        .I1(O2),
        .I2(pause_source_shift[19]),
        .O(\n_0_pause_source_shift[11]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair147" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[12]_i_1 
       (.I0(tx_configuration_vector[14]),
        .I1(O2),
        .I2(pause_source_shift[20]),
        .O(\n_0_pause_source_shift[12]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair141" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[13]_i_1 
       (.I0(tx_configuration_vector[15]),
        .I1(O2),
        .I2(pause_source_shift[21]),
        .O(\n_0_pause_source_shift[13]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair146" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[14]_i_1 
       (.I0(tx_configuration_vector[16]),
        .I1(O2),
        .I2(pause_source_shift[22]),
        .O(\n_0_pause_source_shift[14]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair139" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[15]_i_1 
       (.I0(tx_configuration_vector[17]),
        .I1(O2),
        .I2(pause_source_shift[23]),
        .O(\n_0_pause_source_shift[15]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair138" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[16]_i_1 
       (.I0(tx_configuration_vector[18]),
        .I1(O2),
        .I2(pause_source_shift[24]),
        .O(\n_0_pause_source_shift[16]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair146" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[17]_i_1 
       (.I0(tx_configuration_vector[19]),
        .I1(O2),
        .I2(pause_source_shift[25]),
        .O(\n_0_pause_source_shift[17]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair136" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[18]_i_1 
       (.I0(tx_configuration_vector[20]),
        .I1(O2),
        .I2(pause_source_shift[26]),
        .O(\n_0_pause_source_shift[18]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair140" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[19]_i_1 
       (.I0(tx_configuration_vector[21]),
        .I1(O2),
        .I2(pause_source_shift[27]),
        .O(\n_0_pause_source_shift[19]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair151" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[1]_i_1 
       (.I0(tx_configuration_vector[3]),
        .I1(O2),
        .I2(pause_source_shift[9]),
        .O(\n_0_pause_source_shift[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair137" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[20]_i_1 
       (.I0(tx_configuration_vector[22]),
        .I1(O2),
        .I2(pause_source_shift[28]),
        .O(\n_0_pause_source_shift[20]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair135" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[21]_i_1 
       (.I0(tx_configuration_vector[23]),
        .I1(O2),
        .I2(pause_source_shift[29]),
        .O(\n_0_pause_source_shift[21]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair134" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[22]_i_1 
       (.I0(tx_configuration_vector[24]),
        .I1(O2),
        .I2(pause_source_shift[30]),
        .O(\n_0_pause_source_shift[22]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair132" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[23]_i_1 
       (.I0(tx_configuration_vector[25]),
        .I1(O2),
        .I2(pause_source_shift[31]),
        .O(\n_0_pause_source_shift[23]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair133" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[24]_i_1 
       (.I0(tx_configuration_vector[26]),
        .I1(O2),
        .I2(pause_source_shift[32]),
        .O(\n_0_pause_source_shift[24]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair145" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[25]_i_1 
       (.I0(tx_configuration_vector[27]),
        .I1(O2),
        .I2(pause_source_shift[33]),
        .O(\n_0_pause_source_shift[25]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair142" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[26]_i_1 
       (.I0(tx_configuration_vector[28]),
        .I1(O2),
        .I2(pause_source_shift[34]),
        .O(\n_0_pause_source_shift[26]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair145" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[27]_i_1 
       (.I0(tx_configuration_vector[29]),
        .I1(O2),
        .I2(pause_source_shift[35]),
        .O(\n_0_pause_source_shift[27]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair144" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[28]_i_1 
       (.I0(tx_configuration_vector[30]),
        .I1(O2),
        .I2(pause_source_shift[36]),
        .O(\n_0_pause_source_shift[28]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair142" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[29]_i_1 
       (.I0(tx_configuration_vector[31]),
        .I1(O2),
        .I2(pause_source_shift[37]),
        .O(\n_0_pause_source_shift[29]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair150" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[2]_i_1 
       (.I0(tx_configuration_vector[4]),
        .I1(O2),
        .I2(pause_source_shift[10]),
        .O(\n_0_pause_source_shift[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair141" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[30]_i_1 
       (.I0(tx_configuration_vector[32]),
        .I1(O2),
        .I2(pause_source_shift[38]),
        .O(\n_0_pause_source_shift[30]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair140" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[31]_i_1 
       (.I0(tx_configuration_vector[33]),
        .I1(O2),
        .I2(pause_source_shift[39]),
        .O(\n_0_pause_source_shift[31]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair139" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[32]_i_1 
       (.I0(tx_configuration_vector[34]),
        .I1(O2),
        .I2(pause_source_shift[40]),
        .O(\n_0_pause_source_shift[32]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair138" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[33]_i_1 
       (.I0(tx_configuration_vector[35]),
        .I1(O2),
        .I2(pause_source_shift[41]),
        .O(\n_0_pause_source_shift[33]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair137" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[34]_i_1 
       (.I0(tx_configuration_vector[36]),
        .I1(O2),
        .I2(pause_source_shift[42]),
        .O(\n_0_pause_source_shift[34]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair136" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[35]_i_1 
       (.I0(tx_configuration_vector[37]),
        .I1(O2),
        .I2(pause_source_shift[43]),
        .O(\n_0_pause_source_shift[35]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair135" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[36]_i_1 
       (.I0(tx_configuration_vector[38]),
        .I1(O2),
        .I2(pause_source_shift[44]),
        .O(\n_0_pause_source_shift[36]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair134" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[37]_i_1 
       (.I0(tx_configuration_vector[39]),
        .I1(O2),
        .I2(pause_source_shift[45]),
        .O(\n_0_pause_source_shift[37]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair133" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[38]_i_1 
       (.I0(tx_configuration_vector[40]),
        .I1(O2),
        .I2(pause_source_shift[46]),
        .O(\n_0_pause_source_shift[38]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair132" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[39]_i_1 
       (.I0(tx_configuration_vector[41]),
        .I1(O2),
        .I2(pause_source_shift[47]),
        .O(\n_0_pause_source_shift[39]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair149" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[3]_i_1 
       (.I0(tx_configuration_vector[5]),
        .I1(O2),
        .I2(pause_source_shift[11]),
        .O(\n_0_pause_source_shift[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair148" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[4]_i_1 
       (.I0(tx_configuration_vector[6]),
        .I1(O2),
        .I2(pause_source_shift[12]),
        .O(\n_0_pause_source_shift[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair147" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[5]_i_1 
       (.I0(tx_configuration_vector[7]),
        .I1(O2),
        .I2(pause_source_shift[13]),
        .O(\n_0_pause_source_shift[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair152" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[6]_i_1 
       (.I0(tx_configuration_vector[8]),
        .I1(O2),
        .I2(pause_source_shift[14]),
        .O(\n_0_pause_source_shift[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair151" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[7]_i_1 
       (.I0(tx_configuration_vector[9]),
        .I1(O2),
        .I2(pause_source_shift[15]),
        .O(\n_0_pause_source_shift[7]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair150" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[8]_i_1 
       (.I0(tx_configuration_vector[10]),
        .I1(O2),
        .I2(pause_source_shift[16]),
        .O(\n_0_pause_source_shift[8]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair149" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \pause_source_shift[9]_i_1 
       (.I0(tx_configuration_vector[11]),
        .I1(O2),
        .I2(pause_source_shift[17]),
        .O(\n_0_pause_source_shift[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[0]_i_1 ),
        .Q(pause_source_shift[0]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[10] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[10]_i_1 ),
        .Q(pause_source_shift[10]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[11] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[11]_i_1 ),
        .Q(pause_source_shift[11]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[12] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[12]_i_1 ),
        .Q(pause_source_shift[12]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[13] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[13]_i_1 ),
        .Q(pause_source_shift[13]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[14] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[14]_i_1 ),
        .Q(pause_source_shift[14]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[15] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[15]_i_1 ),
        .Q(pause_source_shift[15]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[16] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[16]_i_1 ),
        .Q(pause_source_shift[16]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[17] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[17]_i_1 ),
        .Q(pause_source_shift[17]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[18] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[18]_i_1 ),
        .Q(pause_source_shift[18]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[19] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[19]_i_1 ),
        .Q(pause_source_shift[19]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[1]_i_1 ),
        .Q(pause_source_shift[1]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[20] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[20]_i_1 ),
        .Q(pause_source_shift[20]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[21] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[21]_i_1 ),
        .Q(pause_source_shift[21]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[22] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[22]_i_1 ),
        .Q(pause_source_shift[22]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[23] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[23]_i_1 ),
        .Q(pause_source_shift[23]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[24] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[24]_i_1 ),
        .Q(pause_source_shift[24]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[25] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[25]_i_1 ),
        .Q(pause_source_shift[25]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[26] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[26]_i_1 ),
        .Q(pause_source_shift[26]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[27] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[27]_i_1 ),
        .Q(pause_source_shift[27]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[28] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[28]_i_1 ),
        .Q(pause_source_shift[28]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[29] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[29]_i_1 ),
        .Q(pause_source_shift[29]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[2] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[2]_i_1 ),
        .Q(pause_source_shift[2]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[30] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[30]_i_1 ),
        .Q(pause_source_shift[30]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[31] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[31]_i_1 ),
        .Q(pause_source_shift[31]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[32] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[32]_i_1 ),
        .Q(pause_source_shift[32]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[33] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[33]_i_1 ),
        .Q(pause_source_shift[33]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[34] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[34]_i_1 ),
        .Q(pause_source_shift[34]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[35] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[35]_i_1 ),
        .Q(pause_source_shift[35]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[36] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[36]_i_1 ),
        .Q(pause_source_shift[36]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[37] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[37]_i_1 ),
        .Q(pause_source_shift[37]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[38] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[38]_i_1 ),
        .Q(pause_source_shift[38]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[39] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[39]_i_1 ),
        .Q(pause_source_shift[39]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[3] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[3]_i_1 ),
        .Q(pause_source_shift[3]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[40] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_configuration_vector[42]),
        .Q(pause_source_shift[40]),
        .R(I16));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[41] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_configuration_vector[43]),
        .Q(pause_source_shift[41]),
        .R(I16));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[42] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_configuration_vector[44]),
        .Q(pause_source_shift[42]),
        .R(I16));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[43] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_configuration_vector[45]),
        .Q(pause_source_shift[43]),
        .R(I16));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[44] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_configuration_vector[46]),
        .Q(pause_source_shift[44]),
        .R(I16));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[45] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_configuration_vector[47]),
        .Q(pause_source_shift[45]),
        .R(I16));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[46] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_configuration_vector[48]),
        .Q(pause_source_shift[46]),
        .R(I16));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[47] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_configuration_vector[49]),
        .Q(pause_source_shift[47]),
        .R(I16));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[4] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[4]_i_1 ),
        .Q(pause_source_shift[4]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[5] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[5]_i_1 ),
        .Q(pause_source_shift[5]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[6] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[6]_i_1 ),
        .Q(pause_source_shift[6]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[7] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[7]_i_1 ),
        .Q(pause_source_shift[7]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[8] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[8]_i_1 ),
        .Q(pause_source_shift[8]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_source_shift_reg[9] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_source_shift[9]_i_1 ),
        .Q(pause_source_shift[9]),
        .R(\<const0> ));
(* SOFT_HLUTNM = "soft_lutpair131" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \pause_value[15]_i_1 
       (.I0(pause_req),
        .I1(O3),
        .O(E));
LUT4 #(
    .INIT(16'h2F20)) 
     \pause_value_sample[10]_i_1 
       (.I0(I2[2]),
        .I1(pfc_pause_req_out),
        .I2(O3),
        .I3(\n_0_pause_value_sample_reg[2] ),
        .O(\n_0_pause_value_sample[10]_i_1 ));
LUT4 #(
    .INIT(16'h2F20)) 
     \pause_value_sample[11]_i_1 
       (.I0(I2[3]),
        .I1(pfc_pause_req_out),
        .I2(O3),
        .I3(\n_0_pause_value_sample_reg[3] ),
        .O(\n_0_pause_value_sample[11]_i_1 ));
LUT4 #(
    .INIT(16'h2F20)) 
     \pause_value_sample[12]_i_1 
       (.I0(I2[4]),
        .I1(pfc_pause_req_out),
        .I2(O3),
        .I3(\n_0_pause_value_sample_reg[4] ),
        .O(\n_0_pause_value_sample[12]_i_1 ));
LUT4 #(
    .INIT(16'h2F20)) 
     \pause_value_sample[13]_i_1 
       (.I0(I2[5]),
        .I1(pfc_pause_req_out),
        .I2(O3),
        .I3(\n_0_pause_value_sample_reg[5] ),
        .O(\n_0_pause_value_sample[13]_i_1 ));
LUT4 #(
    .INIT(16'h2F20)) 
     \pause_value_sample[14]_i_1 
       (.I0(I2[6]),
        .I1(pfc_pause_req_out),
        .I2(O3),
        .I3(\n_0_pause_value_sample_reg[6] ),
        .O(\n_0_pause_value_sample[14]_i_1 ));
LUT4 #(
    .INIT(16'h2F20)) 
     \pause_value_sample[15]_i_1 
       (.I0(I2[7]),
        .I1(pfc_pause_req_out),
        .I2(O3),
        .I3(\n_0_pause_value_sample_reg[7] ),
        .O(\n_0_pause_value_sample[15]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair131" *) 
   LUT4 #(
    .INIT(16'h2F20)) 
     \pause_value_sample[8]_i_1 
       (.I0(I2[0]),
        .I1(pfc_pause_req_out),
        .I2(O3),
        .I3(\n_0_pause_value_sample_reg[0] ),
        .O(\n_0_pause_value_sample[8]_i_1 ));
LUT4 #(
    .INIT(16'h2F20)) 
     \pause_value_sample[9]_i_1 
       (.I0(I2[1]),
        .I1(pfc_pause_req_out),
        .I2(O3),
        .I3(\n_0_pause_value_sample_reg[1] ),
        .O(\n_0_pause_value_sample[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I21),
        .Q(\n_0_pause_value_sample_reg[0] ),
        .R(I17));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[10] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_value_sample[10]_i_1 ),
        .Q(data3[2]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[11] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_value_sample[11]_i_1 ),
        .Q(data3[3]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[12] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_value_sample[12]_i_1 ),
        .Q(data3[4]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[13] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_value_sample[13]_i_1 ),
        .Q(data3[5]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[14] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_value_sample[14]_i_1 ),
        .Q(data3[6]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[15] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_value_sample[15]_i_1 ),
        .Q(data3[7]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I20),
        .Q(\n_0_pause_value_sample_reg[1] ),
        .R(I17));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[2] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I19),
        .Q(\n_0_pause_value_sample_reg[2] ),
        .R(I17));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[3] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I18),
        .Q(\n_0_pause_value_sample_reg[3] ),
        .R(I17));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[4] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I14),
        .Q(\n_0_pause_value_sample_reg[4] ),
        .R(I17));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[5] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I13),
        .Q(\n_0_pause_value_sample_reg[5] ),
        .R(I17));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[6] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I12),
        .Q(\n_0_pause_value_sample_reg[6] ),
        .R(I17));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[7] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(I3),
        .Q(\n_0_pause_value_sample_reg[7] ),
        .R(I17));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[8] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_value_sample[8]_i_1 ),
        .Q(data3[0]),
        .R(\<const0> ));
FDRE #(
    .INIT(1'b0)) 
     \pause_value_sample_reg[9] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_pause_value_sample[9]_i_1 ),
        .Q(data3[1]),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h0022032202220222)) 
     pause_vector_tx_i_1
       (.I0(tx_statistics_vector),
        .I1(I1),
        .I2(tx_statistics_valid),
        .I3(tx_ce_sample),
        .I4(pfc_pause_req_out),
        .I5(control_complete),
        .O(O10));
LUT6 #(
    .INIT(64'h0000000000EAEAEA)) 
     pfc_pause_req_int_i_1
       (.I0(pfc_pause_req_out),
        .I1(pfc_req),
        .I2(data_out),
        .I3(tx_ce_sample),
        .I4(control_complete),
        .I5(I1),
        .O(n_0_pfc_pause_req_int_i_1));
FDRE pfc_pause_req_int_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_pfc_pause_req_int_i_1),
        .Q(pfc_pause_req_out),
        .R(\<const0> ));
FDRE \pfc_quanta_pipe_reg[1][0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(\pfc_quanta_pipe_reg[1]_0 [0]),
        .R(\<const0> ));
FDRE \pfc_quanta_pipe_reg[1][1] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(\pfc_quanta_pipe_reg[1]_0 [1]),
        .R(\<const0> ));
FDRE \pfc_quanta_pipe_reg[1][2] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(\pfc_quanta_pipe_reg[1]_0 [2]),
        .R(\<const0> ));
FDRE \pfc_quanta_pipe_reg[1][3] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(\pfc_quanta_pipe_reg[1]_0 [3]),
        .R(\<const0> ));
FDRE \pfc_quanta_pipe_reg[1][4] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(\pfc_quanta_pipe_reg[1]_0 [4]),
        .R(\<const0> ));
FDRE \pfc_quanta_pipe_reg[1][5] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(\pfc_quanta_pipe_reg[1]_0 [5]),
        .R(\<const0> ));
FDRE \pfc_quanta_pipe_reg[1][6] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(\pfc_quanta_pipe_reg[1]_0 [6]),
        .R(\<const0> ));
FDRE \pfc_quanta_pipe_reg[1][7] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\<const0> ),
        .Q(\pfc_quanta_pipe_reg[1]_0 [7]),
        .R(\<const0> ));
LUT6 #(
    .INIT(64'h000400FF00040000)) 
     sample_int_i_1
       (.I0(\n_0_data_count_reg[0] ),
        .I1(\n_0_data_count_reg[1] ),
        .I2(n_0_sample_int_i_2),
        .I3(I1),
        .I4(tx_ce_sample),
        .I5(O3),
        .O(n_0_sample_int_i_1));
(* SOFT_HLUTNM = "soft_lutpair129" *) 
   LUT4 #(
    .INIT(16'hEFFF)) 
     sample_int_i_2
       (.I0(\n_0_data_count_reg[4] ),
        .I1(\n_0_data_count_reg[5] ),
        .I2(\n_0_data_count_reg[2] ),
        .I3(\n_0_data_count_reg[3] ),
        .O(n_0_sample_int_i_2));
FDRE sample_int_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_sample_int_i_1),
        .Q(O3),
        .R(\<const0> ));
LUT4 #(
    .INIT(16'hEFD0)) 
     \state_count[0]_i_1 
       (.I0(\n_0_state_count_reg[1] ),
        .I1(\n_0_state_count_reg[2] ),
        .I2(\n_0_state_count[2]_i_2 ),
        .I3(tx_status),
        .O(\n_0_state_count[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair130" *) 
   LUT4 #(
    .INIT(16'h0F20)) 
     \state_count[1]_i_1 
       (.I0(tx_status),
        .I1(\n_0_state_count_reg[2] ),
        .I2(\n_0_state_count[2]_i_2 ),
        .I3(\n_0_state_count_reg[1] ),
        .O(\n_0_state_count[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair130" *) 
   LUT4 #(
    .INIT(16'h0F20)) 
     \state_count[2]_i_1 
       (.I0(\n_0_state_count_reg[1] ),
        .I1(tx_status),
        .I2(\n_0_state_count[2]_i_2 ),
        .I3(\n_0_state_count_reg[2] ),
        .O(\n_0_state_count[2]_i_1 ));
LUT6 #(
    .INIT(64'hA2A2A2AA22222222)) 
     \state_count[2]_i_2 
       (.I0(tx_ce_sample),
        .I1(\n_0_state_count[2]_i_3 ),
        .I2(control_complete),
        .I3(O5),
        .I4(I5),
        .I5(\n_0_state_count_reg[2] ),
        .O(\n_0_state_count[2]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair127" *) 
   LUT5 #(
    .INIT(32'h03040334)) 
     \state_count[2]_i_3 
       (.I0(\n_0_state_count[2]_i_4 ),
        .I1(tx_status),
        .I2(\n_0_state_count_reg[1] ),
        .I3(\n_0_state_count_reg[2] ),
        .I4(ack_int),
        .O(\n_0_state_count[2]_i_3 ));
LUT5 #(
    .INIT(32'hAAAAABAA)) 
     \state_count[2]_i_4 
       (.I0(pause_req_int),
        .I1(pause_status_int),
        .I2(n_0_end_of_tx_held_reg),
        .I3(O1),
        .I4(O5),
        .O(\n_0_state_count[2]_i_4 ));
FDSE \state_count_reg[0] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_state_count[0]_i_1 ),
        .Q(tx_status),
        .S(I1));
FDRE \state_count_reg[1] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_state_count[1]_i_1 ),
        .Q(\n_0_state_count_reg[1] ),
        .R(I1));
FDRE \state_count_reg[2] 
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(\n_0_state_count[2]_i_1 ),
        .Q(\n_0_state_count_reg[2] ),
        .R(I1));
endmodule

module TriMACtri_mode_ethernet_mac_v8_1_tx_pause
   (pause_status_req,
    pause_status_int,
    I1,
    tx_ce_sample,
    gtx_clk,
    tx_status,
    I2,
    Q,
    data_in);
  output pause_status_req;
  output pause_status_int;
  input I1;
  input tx_ce_sample;
  input gtx_clk;
  input tx_status;
  input I2;
  input [15:0]Q;
  input data_in;

  wire \<const0> ;
  wire \<const1> ;
  wire I1;
  wire I2;
  wire [15:0]Q;
  wire count_set_reg__0;
  wire data_in;
  wire gtx_clk;
  wire n_0_pause_dec_i_2;
  wire n_0_pause_dec_reg;
  wire n_0_pause_status_int_i_1;
  wire n_0_pause_status_int_i_3;
  wire n_0_pause_status_int_i_4;
  wire n_0_pause_status_int_i_5;
  wire n_0_sync_good_rx;
  wire n_10_sync_good_rx;
  wire n_11_sync_good_rx;
  wire n_12_sync_good_rx;
  wire n_13_sync_good_rx;
  wire n_14_sync_good_rx;
  wire n_15_sync_good_rx;
  wire n_16_sync_good_rx;
  wire n_18_sync_good_rx;
  wire n_19_sync_good_rx;
  wire n_1_sync_good_rx;
  wire n_20_sync_good_rx;
  wire n_2_sync_good_rx;
  wire n_3_sync_good_rx;
  wire n_4_sync_good_rx;
  wire n_5_sync_good_rx;
  wire n_6_sync_good_rx;
  wire n_7_sync_good_rx;
  wire n_8_sync_good_rx;
  wire n_9_sync_good_rx;
  wire [5:0]p_0_in__0;
  wire [15:0]pause_count_reg;
  wire pause_req_in_tx;
  wire pause_req_in_tx_reg;
  wire pause_status_int;
  wire pause_status_int_0;
  wire pause_status_req;
  wire [5:0]quanta_count_reg__0;
  wire tx_ce_sample;
  wire tx_status;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
FDRE count_set_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_19_sync_good_rx),
        .Q(pause_status_req),
        .R(\<const0> ));
FDRE count_set_reg_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(pause_status_req),
        .Q(count_set_reg__0),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[0] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_3_sync_good_rx),
        .Q(pause_count_reg[0]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[10] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_9_sync_good_rx),
        .Q(pause_count_reg[10]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[11] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_8_sync_good_rx),
        .Q(pause_count_reg[11]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[12] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_15_sync_good_rx),
        .Q(pause_count_reg[12]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[13] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_14_sync_good_rx),
        .Q(pause_count_reg[13]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[14] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_13_sync_good_rx),
        .Q(pause_count_reg[14]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[15] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_12_sync_good_rx),
        .Q(pause_count_reg[15]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[1] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_2_sync_good_rx),
        .Q(pause_count_reg[1]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[2] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_1_sync_good_rx),
        .Q(pause_count_reg[2]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[3] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_0_sync_good_rx),
        .Q(pause_count_reg[3]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[4] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_7_sync_good_rx),
        .Q(pause_count_reg[4]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[5] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_6_sync_good_rx),
        .Q(pause_count_reg[5]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[6] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_5_sync_good_rx),
        .Q(pause_count_reg[6]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[7] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_4_sync_good_rx),
        .Q(pause_count_reg[7]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[8] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_11_sync_good_rx),
        .Q(pause_count_reg[8]),
        .R(I1));
(* counter = "8" *) 
   FDRE \pause_count_reg[9] 
       (.C(gtx_clk),
        .CE(n_18_sync_good_rx),
        .D(n_10_sync_good_rx),
        .Q(pause_count_reg[9]),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair158" *) 
   LUT5 #(
    .INIT(32'h80000000)) 
     pause_dec_i_2
       (.I0(quanta_count_reg__0[4]),
        .I1(quanta_count_reg__0[2]),
        .I2(quanta_count_reg__0[1]),
        .I3(quanta_count_reg__0[0]),
        .I4(quanta_count_reg__0[3]),
        .O(n_0_pause_dec_i_2));
FDRE pause_dec_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_20_sync_good_rx),
        .Q(n_0_pause_dec_reg),
        .R(\<const0> ));
FDRE pause_req_in_tx_reg_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(pause_req_in_tx),
        .Q(pause_req_in_tx_reg),
        .R(I1));
LUT6 #(
    .INIT(64'h000000000EEEEEEE)) 
     pause_status_int_i_1
       (.I0(pause_status_int),
        .I1(pause_status_int_0),
        .I2(n_0_pause_status_int_i_3),
        .I3(n_0_pause_status_int_i_4),
        .I4(n_0_pause_status_int_i_5),
        .I5(I1),
        .O(n_0_pause_status_int_i_1));
LUT3 #(
    .INIT(8'h80)) 
     pause_status_int_i_2
       (.I0(count_set_reg__0),
        .I1(tx_status),
        .I2(tx_ce_sample),
        .O(pause_status_int_0));
LUT5 #(
    .INIT(32'h00000001)) 
     pause_status_int_i_3
       (.I0(pause_count_reg[12]),
        .I1(pause_count_reg[8]),
        .I2(pause_count_reg[15]),
        .I3(pause_count_reg[6]),
        .I4(pause_count_reg[14]),
        .O(n_0_pause_status_int_i_3));
LUT6 #(
    .INIT(64'h0000000000000010)) 
     pause_status_int_i_4
       (.I0(pause_count_reg[3]),
        .I1(pause_count_reg[5]),
        .I2(tx_ce_sample),
        .I3(pause_count_reg[7]),
        .I4(pause_count_reg[10]),
        .I5(pause_count_reg[4]),
        .O(n_0_pause_status_int_i_4));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     pause_status_int_i_5
       (.I0(pause_count_reg[1]),
        .I1(pause_count_reg[11]),
        .I2(pause_count_reg[9]),
        .I3(pause_count_reg[2]),
        .I4(pause_count_reg[13]),
        .I5(pause_count_reg[0]),
        .O(n_0_pause_status_int_i_5));
FDRE pause_status_int_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_pause_status_int_i_1),
        .Q(pause_status_int),
        .R(\<const0> ));
(* RETAIN_INVERTER *) 
   (* SOFT_HLUTNM = "soft_lutpair160" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \quanta_count[0]_i_1 
       (.I0(quanta_count_reg__0[0]),
        .O(p_0_in__0[0]));
(* SOFT_HLUTNM = "soft_lutpair160" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \quanta_count[1]_i_1 
       (.I0(quanta_count_reg__0[0]),
        .I1(quanta_count_reg__0[1]),
        .O(p_0_in__0[1]));
(* SOFT_HLUTNM = "soft_lutpair159" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \quanta_count[2]_i_1 
       (.I0(quanta_count_reg__0[2]),
        .I1(quanta_count_reg__0[1]),
        .I2(quanta_count_reg__0[0]),
        .O(p_0_in__0[2]));
(* SOFT_HLUTNM = "soft_lutpair159" *) 
   LUT4 #(
    .INIT(16'h6AAA)) 
     \quanta_count[3]_i_1 
       (.I0(quanta_count_reg__0[3]),
        .I1(quanta_count_reg__0[0]),
        .I2(quanta_count_reg__0[1]),
        .I3(quanta_count_reg__0[2]),
        .O(p_0_in__0[3]));
(* SOFT_HLUTNM = "soft_lutpair158" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \quanta_count[4]_i_1 
       (.I0(quanta_count_reg__0[4]),
        .I1(quanta_count_reg__0[2]),
        .I2(quanta_count_reg__0[1]),
        .I3(quanta_count_reg__0[0]),
        .I4(quanta_count_reg__0[3]),
        .O(p_0_in__0[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \quanta_count[5]_i_2 
       (.I0(quanta_count_reg__0[5]),
        .I1(quanta_count_reg__0[3]),
        .I2(quanta_count_reg__0[0]),
        .I3(quanta_count_reg__0[1]),
        .I4(quanta_count_reg__0[2]),
        .I5(quanta_count_reg__0[4]),
        .O(p_0_in__0[5]));
(* counter = "9" *) 
   FDRE \quanta_count_reg[0] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(p_0_in__0[0]),
        .Q(quanta_count_reg__0[0]),
        .R(n_16_sync_good_rx));
(* counter = "9" *) 
   FDRE \quanta_count_reg[1] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(p_0_in__0[1]),
        .Q(quanta_count_reg__0[1]),
        .R(n_16_sync_good_rx));
(* counter = "9" *) 
   FDRE \quanta_count_reg[2] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(p_0_in__0[2]),
        .Q(quanta_count_reg__0[2]),
        .R(n_16_sync_good_rx));
(* counter = "9" *) 
   FDRE \quanta_count_reg[3] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(p_0_in__0[3]),
        .Q(quanta_count_reg__0[3]),
        .R(n_16_sync_good_rx));
(* counter = "9" *) 
   FDRE \quanta_count_reg[4] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(p_0_in__0[4]),
        .Q(quanta_count_reg__0[4]),
        .R(n_16_sync_good_rx));
(* counter = "9" *) 
   FDRE \quanta_count_reg[5] 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(p_0_in__0[5]),
        .Q(quanta_count_reg__0[5]),
        .R(n_16_sync_good_rx));
TriMACtri_mode_ethernet_mac_v8_1_sync_block_6 sync_good_rx
       (.I1(pause_status_int),
        .I2(I1),
        .I3(n_0_pause_dec_reg),
        .I4(I2),
        .I5(n_0_pause_dec_i_2),
        .I6(Q),
        .O({n_0_sync_good_rx,n_1_sync_good_rx,n_2_sync_good_rx,n_3_sync_good_rx}),
        .O1({n_4_sync_good_rx,n_5_sync_good_rx,n_6_sync_good_rx,n_7_sync_good_rx}),
        .O2({n_8_sync_good_rx,n_9_sync_good_rx,n_10_sync_good_rx,n_11_sync_good_rx}),
        .O3({n_12_sync_good_rx,n_13_sync_good_rx,n_14_sync_good_rx,n_15_sync_good_rx}),
        .O4(n_18_sync_good_rx),
        .O5(n_19_sync_good_rx),
        .O6(n_20_sync_good_rx),
        .Q(quanta_count_reg__0[5]),
        .SR(n_16_sync_good_rx),
        .data_in(data_in),
        .data_out(pause_req_in_tx),
        .gtx_clk(gtx_clk),
        .pause_count_reg(pause_count_reg),
        .pause_req_in_tx_reg(pause_req_in_tx_reg),
        .pause_status_req(pause_status_req),
        .tx_ce_sample(tx_ce_sample));
endmodule

module TriMACtx
   (int_gmii_tx_en,
    CRC_OK,
    REG_DATA_VALID,
    PAD,
    tx_statistics_valid,
    tx_statistics_vector,
    INT_ENABLE,
    CRC100_EN,
    MAX_PKT_LEN_REACHED,
    O1,
    O2,
    O4,
    O5,
    O6,
    O7,
    O8,
    int_gmii_tx_er,
    Q,
    int_tx_ack_in,
    O9,
    D,
    tx_ce_sample,
    gtx_clk,
    INT_CRC_MODE,
    int_tx_data_valid_out,
    I1,
    tx_configuration_vector,
    CE_REG1_OUT7_out,
    int_tx_crc_enable_out,
    O3,
    int_tx_vlan_enable_out,
    I2,
    I3,
    data_avail_in_reg,
    tx_underrun_int,
    I4,
    I5,
    I6,
    I7,
    I8,
    I9,
    SR,
    E,
    tx_ifg_delay,
    I10,
    I11);
  output int_gmii_tx_en;
  output CRC_OK;
  output REG_DATA_VALID;
  output PAD;
  output tx_statistics_valid;
  output [30:0]tx_statistics_vector;
  output INT_ENABLE;
  output CRC100_EN;
  output MAX_PKT_LEN_REACHED;
  output O1;
  output O2;
  output O4;
  output O5;
  output O6;
  output O7;
  output O8;
  output int_gmii_tx_er;
  output [1:0]Q;
  output int_tx_ack_in;
  output O9;
  output [7:0]D;
  input tx_ce_sample;
  input gtx_clk;
  input INT_CRC_MODE;
  input int_tx_data_valid_out;
  input I1;
  input [20:0]tx_configuration_vector;
  input CE_REG1_OUT7_out;
  input int_tx_crc_enable_out;
  input O3;
  input int_tx_vlan_enable_out;
  input I2;
  input I3;
  input data_avail_in_reg;
  input tx_underrun_int;
  input I4;
  input I5;
  input I6;
  input I7;
  input I8;
  input I9;
  input [0:0]SR;
  input [0:0]E;
  input [7:0]tx_ifg_delay;
  input [0:0]I10;
  input [7:0]I11;

  wire \<const0> ;
  wire \<const1> ;
  wire CE_REG1_OUT;
  wire CE_REG1_OUT7_out;
  wire CE_REG2_OUT;
  wire CE_REG3_OUT;
  wire CE_REG4_OUT;
  wire CE_REG5_OUT;
  wire CLK_DIV100_REG;
  wire CLK_DIV10_REG;
  wire CLK_DIV20_REG;
  wire CRC1000_EN;
  wire CRC100_EN;
  wire CRC50_EN;
  wire CRC_OK;
  wire [7:0]D;
  wire [0:0]E;
  wire I1;
  wire [0:0]I10;
  wire [7:0]I11;
  wire I2;
  wire I3;
  wire I4;
  wire I5;
  wire I6;
  wire I7;
  wire I8;
  wire I9;
  wire INT_CRC_MODE;
  wire INT_ENABLE;
  wire MAX_PKT_LEN_REACHED;
  wire NUMBER_OF_BYTES_PRE_REG;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire O5;
  wire O6;
  wire O7;
  wire O8;
  wire O9;
  wire PAD;
  wire [1:0]Q;
  wire Q_0;
  wire REG0_OUT2;
  wire REG1_OUT;
  wire REG2_OUT;
  wire REG3_OUT;
  wire REG4_OUT;
  wire REG5_OUT;
  wire REG6_OUT2;
  wire REG7_OUT2;
  wire REG8_OUT2;
  wire REG9_OUT2;
  wire REG_DATA_VALID;
  wire SPEED_0_RESYNC_REG;
  wire SPEED_1_RESYNC_REG;
  wire [0:0]SR;
  wire data_avail_in_reg;
  wire gtx_clk;
  wire int_gmii_tx_en;
  wire int_gmii_tx_er;
  wire int_tx_ack_in;
  wire int_tx_crc_enable_out;
  wire int_tx_data_valid_out;
  wire int_tx_vlan_enable_out;
  wire n_0_CAPTURE_i_1;
  wire n_0_CAPTURE_reg;
  wire \n_0_CONFIG_SELECT.CE_REG1_OUT_i_1 ;
  wire \n_0_CONFIG_SELECT.CE_REG5_OUT_reg ;
  wire \n_0_CONFIG_SELECT.CRC1000_EN_i_1 ;
  wire \n_0_CONFIG_SELECT.CRC100_EN_i_1 ;
  wire \n_0_CONFIG_SELECT.CRC50_EN_i_1 ;
  wire \n_0_CONFIG_SELECT.REG0_OUT2_reg ;
  wire \n_0_CONFIG_SELECT.REG1_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG1_OUT_i_1 ;
  wire \n_0_CONFIG_SELECT.REG2_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG3_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG4_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1 ;
  wire \n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_txgen_CONFIG_SELECT.REG5_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG5_OUT2_reg_gate ;
  wire \n_0_CONFIG_SELECT.REG5_OUT2_reg_r ;
  wire \n_0_CONFIG_SELECT.REG5_OUT_reg ;
  wire \n_0_CONFIG_SELECT.SPEED_0_SYNC ;
  wire \n_0_CONFIG_SELECT.SPEED_1_SYNC ;
  wire n_0_INT_CRC_MODE_reg;
  wire n_0_INT_HALF_DUPLEX_reg;
  wire n_0_INT_IFG_DEL_EN_reg;
  wire n_0_INT_JUMBO_ENABLE_reg;
  wire n_0_INT_SPEED_IS_10_100_reg;
  wire n_0_INT_TX_EN_DELAY_reg;
  wire n_0_INT_VLAN_ENABLE_reg;
  wire \n_1_CONFIG_SELECT.CRCGEN2 ;
  wire n_26_TX_SM1;
  wire tx_ce_sample;
  wire [20:0]tx_configuration_vector;
  wire [7:0]tx_ifg_delay;
  wire tx_statistics_valid;
  wire [30:0]tx_statistics_vector;
  wire tx_underrun_int;

(* BOX_TYPE = "PRIMITIVE" *) 
   (* srl_name = "inst/\TriMAC_core/txgen/BYTECNTSRL " *) 
   SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
     BYTECNTSRL
       (.A0(\<const0> ),
        .A1(\<const1> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(tx_ce_sample),
        .CLK(gtx_clk),
        .D(int_gmii_tx_en),
        .Q(Q_0));
LUT4 #(
    .INIT(16'h00D8)) 
     CAPTURE_i_1
       (.I0(tx_ce_sample),
        .I1(Q_0),
        .I2(n_0_CAPTURE_reg),
        .I3(I1),
        .O(n_0_CAPTURE_i_1));
FDRE CAPTURE_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_0_CAPTURE_i_1),
        .Q(n_0_CAPTURE_reg),
        .R(\<const0> ));
LUT1 #(
    .INIT(2'h1)) 
     \CONFIG_SELECT.CE_REG1_OUT_i_1 
       (.I0(\n_0_CONFIG_SELECT.CE_REG5_OUT_reg ),
        .O(\n_0_CONFIG_SELECT.CE_REG1_OUT_i_1 ));
FDRE \CONFIG_SELECT.CE_REG1_OUT_reg 
       (.C(gtx_clk),
        .CE(CE_REG1_OUT7_out),
        .D(\n_0_CONFIG_SELECT.CE_REG1_OUT_i_1 ),
        .Q(CE_REG1_OUT),
        .R(CE_REG5_OUT));
FDRE \CONFIG_SELECT.CE_REG2_OUT_reg 
       (.C(gtx_clk),
        .CE(CE_REG1_OUT7_out),
        .D(CE_REG1_OUT),
        .Q(CE_REG2_OUT),
        .R(CE_REG5_OUT));
FDRE \CONFIG_SELECT.CE_REG3_OUT_reg 
       (.C(gtx_clk),
        .CE(CE_REG1_OUT7_out),
        .D(CE_REG2_OUT),
        .Q(CE_REG3_OUT),
        .R(CE_REG5_OUT));
LUT5 #(
    .INIT(32'hBAAAAAAA)) 
     \CONFIG_SELECT.CE_REG4_OUT_i_1 
       (.I0(I1),
        .I1(CE_REG4_OUT),
        .I2(\n_0_CONFIG_SELECT.CE_REG5_OUT_reg ),
        .I3(tx_ce_sample),
        .I4(CRC100_EN),
        .O(CE_REG5_OUT));
FDRE \CONFIG_SELECT.CE_REG4_OUT_reg 
       (.C(gtx_clk),
        .CE(CE_REG1_OUT7_out),
        .D(CE_REG3_OUT),
        .Q(CE_REG4_OUT),
        .R(CE_REG5_OUT));
FDRE \CONFIG_SELECT.CE_REG5_OUT_reg 
       (.C(gtx_clk),
        .CE(CE_REG1_OUT7_out),
        .D(CE_REG4_OUT),
        .Q(\n_0_CONFIG_SELECT.CE_REG5_OUT_reg ),
        .R(CE_REG5_OUT));
FDRE \CONFIG_SELECT.CLK_DIV100_REG_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(CE_REG3_OUT),
        .Q(CLK_DIV100_REG),
        .R(I1));
FDRE \CONFIG_SELECT.CLK_DIV10_REG_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG3_OUT),
        .Q(CLK_DIV10_REG),
        .R(I1));
FDRE \CONFIG_SELECT.CLK_DIV20_REG_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG6_OUT2),
        .Q(CLK_DIV20_REG),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'h2)) 
     \CONFIG_SELECT.CRC1000_EN_i_1 
       (.I0(CE_REG3_OUT),
        .I1(CLK_DIV100_REG),
        .O(\n_0_CONFIG_SELECT.CRC1000_EN_i_1 ));
FDRE \CONFIG_SELECT.CRC1000_EN_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.CRC1000_EN_i_1 ),
        .Q(CRC1000_EN),
        .R(I1));
LUT2 #(
    .INIT(4'h2)) 
     \CONFIG_SELECT.CRC100_EN_i_1 
       (.I0(REG3_OUT),
        .I1(CLK_DIV10_REG),
        .O(\n_0_CONFIG_SELECT.CRC100_EN_i_1 ));
FDRE \CONFIG_SELECT.CRC100_EN_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.CRC100_EN_i_1 ),
        .Q(CRC100_EN),
        .R(I1));
LUT2 #(
    .INIT(4'h2)) 
     \CONFIG_SELECT.CRC50_EN_i_1 
       (.I0(REG6_OUT2),
        .I1(CLK_DIV20_REG),
        .O(\n_0_CONFIG_SELECT.CRC50_EN_i_1 ));
FDRE \CONFIG_SELECT.CRC50_EN_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.CRC50_EN_i_1 ),
        .Q(CRC50_EN),
        .R(\<const0> ));
TriMACCRC_64_32_15 \CONFIG_SELECT.CRCGEN2 
       (.CRC1000_EN(CRC1000_EN),
        .CRC50_EN(CRC50_EN),
        .CRC_OK(CRC_OK),
        .I1(I1),
        .SPEED_0_RESYNC_REG(SPEED_0_RESYNC_REG),
        .SPEED_1_RESYNC_REG(SPEED_1_RESYNC_REG),
        .SR(\n_1_CONFIG_SELECT.CRCGEN2 ),
        .gtx_clk(gtx_clk),
        .tx_ce_sample(tx_ce_sample));
FDRE \CONFIG_SELECT.REG0_OUT2_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG9_OUT2),
        .Q(\n_0_CONFIG_SELECT.REG0_OUT2_reg ),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG1_OUT2_reg_r 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const1> ),
        .Q(\n_0_CONFIG_SELECT.REG1_OUT2_reg_r ),
        .R(REG0_OUT2));
LUT1 #(
    .INIT(2'h1)) 
     \CONFIG_SELECT.REG1_OUT_i_1 
       (.I0(\n_0_CONFIG_SELECT.REG5_OUT_reg ),
        .O(\n_0_CONFIG_SELECT.REG1_OUT_i_1 ));
FDRE \CONFIG_SELECT.REG1_OUT_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.REG1_OUT_i_1 ),
        .Q(REG1_OUT),
        .R(REG5_OUT));
FDRE \CONFIG_SELECT.REG2_OUT2_reg_r 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.REG1_OUT2_reg_r ),
        .Q(\n_0_CONFIG_SELECT.REG2_OUT2_reg_r ),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG2_OUT_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG1_OUT),
        .Q(REG2_OUT),
        .R(REG5_OUT));
FDRE \CONFIG_SELECT.REG3_OUT2_reg_r 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.REG2_OUT2_reg_r ),
        .Q(\n_0_CONFIG_SELECT.REG3_OUT2_reg_r ),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG3_OUT_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG2_OUT),
        .Q(REG3_OUT),
        .R(REG5_OUT));
FDRE \CONFIG_SELECT.REG4_OUT2_reg_r 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.REG3_OUT2_reg_r ),
        .Q(\n_0_CONFIG_SELECT.REG4_OUT2_reg_r ),
        .R(REG0_OUT2));
(* srl_name = "inst/\TriMAC_core/txgen/CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r " *) 
   SRL16E \CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(tx_ce_sample),
        .CLK(gtx_clk),
        .D(\n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1 ),
        .Q(\n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r ));
LUT1 #(
    .INIT(2'h1)) 
     \CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1 
       (.I0(\n_0_CONFIG_SELECT.REG0_OUT2_reg ),
        .O(\n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1 ));
LUT4 #(
    .INIT(16'hBAAA)) 
     \CONFIG_SELECT.REG4_OUT_i_1 
       (.I0(I1),
        .I1(REG4_OUT),
        .I2(tx_ce_sample),
        .I3(\n_0_CONFIG_SELECT.REG5_OUT_reg ),
        .O(REG5_OUT));
FDRE \CONFIG_SELECT.REG4_OUT_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG3_OUT),
        .Q(REG4_OUT),
        .R(REG5_OUT));
FDRE \CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_txgen_CONFIG_SELECT.REG5_OUT2_reg_r 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r ),
        .Q(\n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_txgen_CONFIG_SELECT.REG5_OUT2_reg_r ),
        .R(\<const0> ));
LUT2 #(
    .INIT(4'h8)) 
     \CONFIG_SELECT.REG5_OUT2_reg_gate 
       (.I0(\n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_txgen_CONFIG_SELECT.REG5_OUT2_reg_r ),
        .I1(\n_0_CONFIG_SELECT.REG5_OUT2_reg_r ),
        .O(\n_0_CONFIG_SELECT.REG5_OUT2_reg_gate ));
FDRE \CONFIG_SELECT.REG5_OUT2_reg_r 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.REG4_OUT2_reg_r ),
        .Q(\n_0_CONFIG_SELECT.REG5_OUT2_reg_r ),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG5_OUT_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG4_OUT),
        .Q(\n_0_CONFIG_SELECT.REG5_OUT_reg ),
        .R(REG5_OUT));
FDRE \CONFIG_SELECT.REG6_OUT2_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.REG5_OUT2_reg_gate ),
        .Q(REG6_OUT2),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG7_OUT2_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG6_OUT2),
        .Q(REG7_OUT2),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.REG8_OUT2_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG7_OUT2),
        .Q(REG8_OUT2),
        .R(REG0_OUT2));
LUT4 #(
    .INIT(16'hBAAA)) 
     \CONFIG_SELECT.REG9_OUT2_i_1 
       (.I0(I1),
        .I1(REG9_OUT2),
        .I2(tx_ce_sample),
        .I3(\n_0_CONFIG_SELECT.REG0_OUT2_reg ),
        .O(REG0_OUT2));
FDRE \CONFIG_SELECT.REG9_OUT2_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(REG8_OUT2),
        .Q(REG9_OUT2),
        .R(REG0_OUT2));
FDRE \CONFIG_SELECT.SPEED_0_RESYNC_REG_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.SPEED_0_SYNC ),
        .Q(SPEED_0_RESYNC_REG),
        .R(I1));
TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_13 \CONFIG_SELECT.SPEED_0_SYNC 
       (.data_out(\n_0_CONFIG_SELECT.SPEED_0_SYNC ),
        .gtx_clk(gtx_clk),
        .tx_configuration_vector(tx_configuration_vector[3]));
FDRE \CONFIG_SELECT.SPEED_1_RESYNC_REG_reg 
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\n_0_CONFIG_SELECT.SPEED_1_SYNC ),
        .Q(SPEED_1_RESYNC_REG),
        .R(I1));
TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_14 \CONFIG_SELECT.SPEED_1_SYNC 
       (.data_out(\n_0_CONFIG_SELECT.SPEED_1_SYNC ),
        .gtx_clk(gtx_clk),
        .tx_configuration_vector(tx_configuration_vector[4]));
GND GND
       (.G(\<const0> ));
FDRE INT_CRC_MODE_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(int_tx_crc_enable_out),
        .Q(n_0_INT_CRC_MODE_reg),
        .R(I1));
FDRE INT_ENABLE_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_configuration_vector[0]),
        .Q(INT_ENABLE),
        .R(I1));
FDRE INT_HALF_DUPLEX_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(\<const0> ),
        .Q(n_0_INT_HALF_DUPLEX_reg),
        .R(I1));
FDRE INT_IFG_DEL_EN_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_configuration_vector[2]),
        .Q(n_0_INT_IFG_DEL_EN_reg),
        .R(I1));
FDRE INT_JUMBO_ENABLE_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(tx_configuration_vector[1]),
        .Q(n_0_INT_JUMBO_ENABLE_reg),
        .R(I1));
FDRE INT_SPEED_IS_10_100_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(O3),
        .Q(n_0_INT_SPEED_IS_10_100_reg),
        .R(I1));
FDRE INT_TX_EN_DELAY_reg
       (.C(gtx_clk),
        .CE(\<const1> ),
        .D(n_26_TX_SM1),
        .Q(n_0_INT_TX_EN_DELAY_reg),
        .R(\<const0> ));
FDRE INT_VLAN_ENABLE_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(int_tx_vlan_enable_out),
        .Q(n_0_INT_VLAN_ENABLE_reg),
        .R(I1));
FDRE NUMBER_OF_BYTES_reg
       (.C(gtx_clk),
        .CE(tx_ce_sample),
        .D(NUMBER_OF_BYTES_PRE_REG),
        .Q(tx_statistics_vector[30]),
        .R(I1));
TriMACTX_STATE_MACH__parameterized0 TX_SM1
       (.D(D),
        .E(E),
        .I1(n_0_INT_CRC_MODE_reg),
        .I10(n_0_INT_TX_EN_DELAY_reg),
        .I11(I4),
        .I12(I5),
        .I13(n_0_INT_HALF_DUPLEX_reg),
        .I14(I6),
        .I15(I7),
        .I16(I8),
        .I17(n_0_CAPTURE_reg),
        .I18(I9),
        .I19(SR),
        .I2(n_0_INT_JUMBO_ENABLE_reg),
        .I20(I10),
        .I21(I11),
        .I3(n_0_INT_SPEED_IS_10_100_reg),
        .I4(n_0_INT_IFG_DEL_EN_reg),
        .I5(n_0_INT_VLAN_ENABLE_reg),
        .I6(I2),
        .I7(I3),
        .I8(I1),
        .I9(CRC_OK),
        .INT_CRC_MODE(INT_CRC_MODE),
        .NUMBER_OF_BYTES_PRE_REG(NUMBER_OF_BYTES_PRE_REG),
        .O1(MAX_PKT_LEN_REACHED),
        .O10(n_26_TX_SM1),
        .O2(O1),
        .O3(O2),
        .O4(O4),
        .O5(O5),
        .O6(O6),
        .O7(O7),
        .O8(O8),
        .O9(O9),
        .PAD(PAD),
        .Q(Q),
        .Q_0(Q_0),
        .REG_DATA_VALID(REG_DATA_VALID),
        .SR(\n_1_CONFIG_SELECT.CRCGEN2 ),
        .data_avail_in_reg(data_avail_in_reg),
        .gtx_clk(gtx_clk),
        .int_gmii_tx_en(int_gmii_tx_en),
        .int_gmii_tx_er(int_gmii_tx_er),
        .int_tx_ack_in(int_tx_ack_in),
        .int_tx_data_valid_out(int_tx_data_valid_out),
        .tx_ce_sample(tx_ce_sample),
        .tx_configuration_vector(tx_configuration_vector[20:5]),
        .tx_ifg_delay(tx_ifg_delay),
        .tx_statistics_valid(tx_statistics_valid),
        .tx_statistics_vector(tx_statistics_vector[29:0]),
        .tx_underrun_int(tx_underrun_int));
VCC VCC
       (.P(\<const1> ));
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
