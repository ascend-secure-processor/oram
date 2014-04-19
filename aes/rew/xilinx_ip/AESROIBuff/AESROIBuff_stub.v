// Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
// Date        : Thu Apr 17 19:47:21 2014
// Host        : running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               c:/chip/ascend_vc707/ascend_vc707.srcs/sources_1/ip/AESROIBuff/AESROIBuff_stub.v
// Design      : AESROIBuff
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module AESROIBuff(clk, din, wr_en, rd_en, dout, full, empty, valid)
/* synthesis syn_black_box black_box_pad_pin="clk,din[511:0],wr_en,rd_en,dout[511:0],full,empty,valid" */;
  input clk;
  input [511:0]din;
  input wr_en;
  input rd_en;
  output [511:0]dout;
  output full;
  output empty;
  output valid;
endmodule
