-- Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
-- Date        : Sat May 10 09:55:44 2014
-- Host        : sinister running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode funcsim
--               c:/chip/vc707_newproj/vc707_newproj.srcs/sources_1/ip/TriMAC/TriMAC_funcsim.vhdl
-- Design      : TriMAC
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7vx485tffg1761-2
-- --------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCC2CE is
  port (
    CEO : out STD_LOGIC;
    CE : in STD_LOGIC;
    I1 : in STD_LOGIC
  );
end TriMACCC2CE;

architecture STRUCTURE of TriMACCC2CE is
  signal \<const0>\ : STD_LOGIC;
  signal C0 : STD_LOGIC;
  signal C1 : STD_LOGIC;
  signal TQ0 : STD_LOGIC;
  signal TQ1 : STD_LOGIC;
  signal X36_1N12 : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal n_0_X36_1I298 : STD_LOGIC;
  signal n_0_X36_1I35 : STD_LOGIC;
  signal n_0_X36_1I36 : STD_LOGIC;
  signal NLW_X36_1I4_CARRY4_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_X36_1I4_CARRY4_DI_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_X36_1I4_CARRY4_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_X36_1I4_CARRY4_S_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 2 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of X36_1I35 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I886 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I923 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
X36_1I35: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ1,
      Q => n_0_X36_1I35
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ0,
      Q => n_0_X36_1I36
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3 downto 2) => NLW_X36_1I4_CARRY4_CO_UNCONNECTED(3 downto 2),
      CO(1) => n_0_X36_1I298,
      CO(0) => C1,
      CYINIT => C0,
      DI(3 downto 2) => NLW_X36_1I4_CARRY4_DI_UNCONNECTED(3 downto 2),
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3 downto 2) => NLW_X36_1I4_CARRY4_O_UNCONNECTED(3 downto 2),
      O(1) => TQ1,
      O(0) => TQ0,
      S(3 downto 2) => NLW_X36_1I4_CARRY4_S_UNCONNECTED(3 downto 2),
      S(1) => n_0_X36_1I35,
      S(0) => n_0_X36_1I36
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I886: unisim.vcomponents.GND
    port map (
      G => X36_1N12
    );
X36_1I923: unisim.vcomponents.VCC
    port map (
      P => C0
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => CE,
      I1 => n_0_X36_1I298,
      O => CEO
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCC2CE_20 is
  port (
    CEO : out STD_LOGIC;
    CE : in STD_LOGIC;
    gtx_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACCC2CE_20 : entity is "CC2CE";
end TriMACCC2CE_20;

architecture STRUCTURE of TriMACCC2CE_20 is
  signal \<const0>\ : STD_LOGIC;
  signal C0 : STD_LOGIC;
  signal C1 : STD_LOGIC;
  signal TQ0 : STD_LOGIC;
  signal TQ1 : STD_LOGIC;
  signal X36_1N12 : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal n_0_X36_1I298 : STD_LOGIC;
  signal n_0_X36_1I35 : STD_LOGIC;
  signal n_0_X36_1I36 : STD_LOGIC;
  signal NLW_X36_1I4_CARRY4_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_X36_1I4_CARRY4_DI_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_X36_1I4_CARRY4_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_X36_1I4_CARRY4_S_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 2 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of X36_1I35 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I886 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I923 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
X36_1I35: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ1,
      Q => n_0_X36_1I35
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ0,
      Q => n_0_X36_1I36
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3 downto 2) => NLW_X36_1I4_CARRY4_CO_UNCONNECTED(3 downto 2),
      CO(1) => n_0_X36_1I298,
      CO(0) => C1,
      CYINIT => C0,
      DI(3 downto 2) => NLW_X36_1I4_CARRY4_DI_UNCONNECTED(3 downto 2),
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3 downto 2) => NLW_X36_1I4_CARRY4_O_UNCONNECTED(3 downto 2),
      O(1) => TQ1,
      O(0) => TQ0,
      S(3 downto 2) => NLW_X36_1I4_CARRY4_S_UNCONNECTED(3 downto 2),
      S(1) => n_0_X36_1I35,
      S(0) => n_0_X36_1I36
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I886: unisim.vcomponents.GND
    port map (
      G => X36_1N12
    );
X36_1I923: unisim.vcomponents.VCC
    port map (
      P => C0
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => CE,
      I1 => n_0_X36_1I298,
      O => CEO
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCC8CE is
  port (
    CEO : out STD_LOGIC;
    CRC1000_EN : in STD_LOGIC;
    SPEED_1_RESYNC_REG : in STD_LOGIC;
    CRC50_EN : in STD_LOGIC;
    SPEED_0_RESYNC_REG : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I1 : in STD_LOGIC
  );
end TriMACCC8CE;

architecture STRUCTURE of TriMACCC8CE is
  signal \<const0>\ : STD_LOGIC;
  signal C0 : STD_LOGIC;
  signal C1 : STD_LOGIC;
  signal C2 : STD_LOGIC;
  signal C3 : STD_LOGIC;
  signal C4 : STD_LOGIC;
  signal C5 : STD_LOGIC;
  signal C6 : STD_LOGIC;
  signal C7 : STD_LOGIC;
  signal TQ0 : STD_LOGIC;
  signal TQ1 : STD_LOGIC;
  signal TQ2 : STD_LOGIC;
  signal TQ3 : STD_LOGIC;
  signal TQ4 : STD_LOGIC;
  signal TQ5 : STD_LOGIC;
  signal TQ6 : STD_LOGIC;
  signal TQ7 : STD_LOGIC;
  signal X36_1N12 : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal n_0_X36_1I224 : STD_LOGIC;
  signal n_0_X36_1I237 : STD_LOGIC;
  signal n_0_X36_1I250 : STD_LOGIC;
  signal n_0_X36_1I263 : STD_LOGIC;
  signal \n_0_X36_1I263_i_1__0\ : STD_LOGIC;
  signal n_0_X36_1I276 : STD_LOGIC;
  signal n_0_X36_1I289 : STD_LOGIC;
  signal n_0_X36_1I298 : STD_LOGIC;
  signal n_0_X36_1I35 : STD_LOGIC;
  signal n_0_X36_1I36 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of X36_1I224 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of X36_1I224 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I237 : label is true;
  attribute BOX_TYPE of X36_1I237 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I250 : label is true;
  attribute BOX_TYPE of X36_1I250 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I259_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I259_CARRY4 : label is "(MUXCY,XORCY)";
  attribute ASYNC_REG of X36_1I263 : label is true;
  attribute BOX_TYPE of X36_1I263 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I276 : label is true;
  attribute BOX_TYPE of X36_1I276 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I289 : label is true;
  attribute BOX_TYPE of X36_1I289 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I35 : label is true;
  attribute BOX_TYPE of X36_1I35 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I36 : label is true;
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I886 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I923 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
X36_1I224: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \n_0_X36_1I263_i_1__0\,
      CLR => \<const0>\,
      D => TQ2,
      Q => n_0_X36_1I224
    );
X36_1I237: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \n_0_X36_1I263_i_1__0\,
      CLR => \<const0>\,
      D => TQ3,
      Q => n_0_X36_1I237
    );
X36_1I250: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \n_0_X36_1I263_i_1__0\,
      CLR => \<const0>\,
      D => TQ4,
      Q => n_0_X36_1I250
    );
X36_1I259_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => C4,
      CO(3) => n_0_X36_1I298,
      CO(2) => C7,
      CO(1) => C6,
      CO(0) => C5,
      CYINIT => lopt_1,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ7,
      O(2) => TQ6,
      O(1) => TQ5,
      O(0) => TQ4,
      S(3) => n_0_X36_1I289,
      S(2) => n_0_X36_1I276,
      S(1) => n_0_X36_1I263,
      S(0) => n_0_X36_1I250
    );
X36_1I259_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
X36_1I263: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \n_0_X36_1I263_i_1__0\,
      CLR => \<const0>\,
      D => TQ5,
      Q => n_0_X36_1I263
    );
\X36_1I263_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => CRC1000_EN,
      I1 => SPEED_1_RESYNC_REG,
      I2 => CRC50_EN,
      I3 => SPEED_0_RESYNC_REG,
      I4 => I2,
      O => \n_0_X36_1I263_i_1__0\
    );
X36_1I276: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \n_0_X36_1I263_i_1__0\,
      CLR => \<const0>\,
      D => TQ6,
      Q => n_0_X36_1I276
    );
X36_1I289: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \n_0_X36_1I263_i_1__0\,
      CLR => \<const0>\,
      D => TQ7,
      Q => n_0_X36_1I289
    );
X36_1I35: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \n_0_X36_1I263_i_1__0\,
      CLR => \<const0>\,
      D => TQ1,
      Q => n_0_X36_1I35
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \n_0_X36_1I263_i_1__0\,
      CLR => \<const0>\,
      D => TQ0,
      Q => n_0_X36_1I36
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => C4,
      CO(2) => C3,
      CO(1) => C2,
      CO(0) => C1,
      CYINIT => C0,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ3,
      O(2) => TQ2,
      O(1) => TQ1,
      O(0) => TQ0,
      S(3) => n_0_X36_1I237,
      S(2) => n_0_X36_1I224,
      S(1) => n_0_X36_1I35,
      S(0) => n_0_X36_1I36
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I886: unisim.vcomponents.GND
    port map (
      G => X36_1N12
    );
X36_1I923: unisim.vcomponents.VCC
    port map (
      P => C0
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \n_0_X36_1I263_i_1__0\,
      I1 => n_0_X36_1I298,
      O => CEO
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCC8CE_10 is
  port (
    CEO : out STD_LOGIC;
    CE : in STD_LOGIC;
    I1 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACCC8CE_10 : entity is "CC8CE";
end TriMACCC8CE_10;

architecture STRUCTURE of TriMACCC8CE_10 is
  signal \<const0>\ : STD_LOGIC;
  signal C0 : STD_LOGIC;
  signal C1 : STD_LOGIC;
  signal C2 : STD_LOGIC;
  signal C3 : STD_LOGIC;
  signal C4 : STD_LOGIC;
  signal C5 : STD_LOGIC;
  signal C6 : STD_LOGIC;
  signal C7 : STD_LOGIC;
  signal TQ0 : STD_LOGIC;
  signal TQ1 : STD_LOGIC;
  signal TQ2 : STD_LOGIC;
  signal TQ3 : STD_LOGIC;
  signal TQ4 : STD_LOGIC;
  signal TQ5 : STD_LOGIC;
  signal TQ6 : STD_LOGIC;
  signal TQ7 : STD_LOGIC;
  signal X36_1N12 : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal n_0_X36_1I224 : STD_LOGIC;
  signal n_0_X36_1I237 : STD_LOGIC;
  signal n_0_X36_1I250 : STD_LOGIC;
  signal n_0_X36_1I263 : STD_LOGIC;
  signal n_0_X36_1I276 : STD_LOGIC;
  signal n_0_X36_1I289 : STD_LOGIC;
  signal n_0_X36_1I298 : STD_LOGIC;
  signal n_0_X36_1I35 : STD_LOGIC;
  signal n_0_X36_1I36 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of X36_1I224 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of X36_1I224 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I237 : label is true;
  attribute BOX_TYPE of X36_1I237 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I250 : label is true;
  attribute BOX_TYPE of X36_1I250 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I259_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I259_CARRY4 : label is "(MUXCY,XORCY)";
  attribute ASYNC_REG of X36_1I263 : label is true;
  attribute BOX_TYPE of X36_1I263 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I276 : label is true;
  attribute BOX_TYPE of X36_1I276 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I289 : label is true;
  attribute BOX_TYPE of X36_1I289 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I35 : label is true;
  attribute BOX_TYPE of X36_1I35 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I36 : label is true;
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I886 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I923 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
X36_1I224: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ2,
      Q => n_0_X36_1I224
    );
X36_1I237: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ3,
      Q => n_0_X36_1I237
    );
X36_1I250: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ4,
      Q => n_0_X36_1I250
    );
X36_1I259_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => C4,
      CO(3) => n_0_X36_1I298,
      CO(2) => C7,
      CO(1) => C6,
      CO(0) => C5,
      CYINIT => lopt_1,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ7,
      O(2) => TQ6,
      O(1) => TQ5,
      O(0) => TQ4,
      S(3) => n_0_X36_1I289,
      S(2) => n_0_X36_1I276,
      S(1) => n_0_X36_1I263,
      S(0) => n_0_X36_1I250
    );
X36_1I259_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
X36_1I263: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ5,
      Q => n_0_X36_1I263
    );
X36_1I276: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ6,
      Q => n_0_X36_1I276
    );
X36_1I289: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ7,
      Q => n_0_X36_1I289
    );
X36_1I35: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ1,
      Q => n_0_X36_1I35
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ0,
      Q => n_0_X36_1I36
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => C4,
      CO(2) => C3,
      CO(1) => C2,
      CO(0) => C1,
      CYINIT => C0,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ3,
      O(2) => TQ2,
      O(1) => TQ1,
      O(0) => TQ0,
      S(3) => n_0_X36_1I237,
      S(2) => n_0_X36_1I224,
      S(1) => n_0_X36_1I35,
      S(0) => n_0_X36_1I36
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I886: unisim.vcomponents.GND
    port map (
      G => X36_1N12
    );
X36_1I923: unisim.vcomponents.VCC
    port map (
      P => C0
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => CE,
      I1 => n_0_X36_1I298,
      O => CEO
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCC8CE_16 is
  port (
    CEO : out STD_LOGIC;
    CRC1000_EN : in STD_LOGIC;
    SPEED_1_RESYNC_REG : in STD_LOGIC;
    CRC50_EN : in STD_LOGIC;
    SPEED_0_RESYNC_REG : in STD_LOGIC;
    tx_ce_sample : in STD_LOGIC;
    gtx_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACCC8CE_16 : entity is "CC8CE";
end TriMACCC8CE_16;

architecture STRUCTURE of TriMACCC8CE_16 is
  signal \<const0>\ : STD_LOGIC;
  signal C0 : STD_LOGIC;
  signal C1 : STD_LOGIC;
  signal C2 : STD_LOGIC;
  signal C3 : STD_LOGIC;
  signal C4 : STD_LOGIC;
  signal C5 : STD_LOGIC;
  signal C6 : STD_LOGIC;
  signal C7 : STD_LOGIC;
  signal TQ0 : STD_LOGIC;
  signal TQ1 : STD_LOGIC;
  signal TQ2 : STD_LOGIC;
  signal TQ3 : STD_LOGIC;
  signal TQ4 : STD_LOGIC;
  signal TQ5 : STD_LOGIC;
  signal TQ6 : STD_LOGIC;
  signal TQ7 : STD_LOGIC;
  signal X36_1N12 : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal n_0_X36_1I224 : STD_LOGIC;
  signal n_0_X36_1I237 : STD_LOGIC;
  signal n_0_X36_1I250 : STD_LOGIC;
  signal n_0_X36_1I263 : STD_LOGIC;
  signal n_0_X36_1I263_i_1 : STD_LOGIC;
  signal n_0_X36_1I276 : STD_LOGIC;
  signal n_0_X36_1I289 : STD_LOGIC;
  signal n_0_X36_1I298 : STD_LOGIC;
  signal n_0_X36_1I35 : STD_LOGIC;
  signal n_0_X36_1I36 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of X36_1I224 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of X36_1I224 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I237 : label is true;
  attribute BOX_TYPE of X36_1I237 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I250 : label is true;
  attribute BOX_TYPE of X36_1I250 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I259_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I259_CARRY4 : label is "(MUXCY,XORCY)";
  attribute ASYNC_REG of X36_1I263 : label is true;
  attribute BOX_TYPE of X36_1I263 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I276 : label is true;
  attribute BOX_TYPE of X36_1I276 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I289 : label is true;
  attribute BOX_TYPE of X36_1I289 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I35 : label is true;
  attribute BOX_TYPE of X36_1I35 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I36 : label is true;
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I886 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I923 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
X36_1I224: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => n_0_X36_1I263_i_1,
      CLR => \<const0>\,
      D => TQ2,
      Q => n_0_X36_1I224
    );
X36_1I237: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => n_0_X36_1I263_i_1,
      CLR => \<const0>\,
      D => TQ3,
      Q => n_0_X36_1I237
    );
X36_1I250: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => n_0_X36_1I263_i_1,
      CLR => \<const0>\,
      D => TQ4,
      Q => n_0_X36_1I250
    );
X36_1I259_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => C4,
      CO(3) => n_0_X36_1I298,
      CO(2) => C7,
      CO(1) => C6,
      CO(0) => C5,
      CYINIT => lopt_1,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ7,
      O(2) => TQ6,
      O(1) => TQ5,
      O(0) => TQ4,
      S(3) => n_0_X36_1I289,
      S(2) => n_0_X36_1I276,
      S(1) => n_0_X36_1I263,
      S(0) => n_0_X36_1I250
    );
X36_1I259_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
X36_1I263: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => n_0_X36_1I263_i_1,
      CLR => \<const0>\,
      D => TQ5,
      Q => n_0_X36_1I263
    );
X36_1I263_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => CRC1000_EN,
      I1 => SPEED_1_RESYNC_REG,
      I2 => CRC50_EN,
      I3 => SPEED_0_RESYNC_REG,
      I4 => tx_ce_sample,
      O => n_0_X36_1I263_i_1
    );
X36_1I276: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => n_0_X36_1I263_i_1,
      CLR => \<const0>\,
      D => TQ6,
      Q => n_0_X36_1I276
    );
X36_1I289: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => n_0_X36_1I263_i_1,
      CLR => \<const0>\,
      D => TQ7,
      Q => n_0_X36_1I289
    );
X36_1I35: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => n_0_X36_1I263_i_1,
      CLR => \<const0>\,
      D => TQ1,
      Q => n_0_X36_1I35
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => n_0_X36_1I263_i_1,
      CLR => \<const0>\,
      D => TQ0,
      Q => n_0_X36_1I36
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => C4,
      CO(2) => C3,
      CO(1) => C2,
      CO(0) => C1,
      CYINIT => C0,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ3,
      O(2) => TQ2,
      O(1) => TQ1,
      O(0) => TQ0,
      S(3) => n_0_X36_1I237,
      S(2) => n_0_X36_1I224,
      S(1) => n_0_X36_1I35,
      S(0) => n_0_X36_1I36
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I886: unisim.vcomponents.GND
    port map (
      G => X36_1N12
    );
X36_1I923: unisim.vcomponents.VCC
    port map (
      P => C0
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => n_0_X36_1I263_i_1,
      I1 => n_0_X36_1I298,
      O => CEO
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCC8CE_17 is
  port (
    CEO : out STD_LOGIC;
    CE : in STD_LOGIC;
    gtx_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACCC8CE_17 : entity is "CC8CE";
end TriMACCC8CE_17;

architecture STRUCTURE of TriMACCC8CE_17 is
  signal \<const0>\ : STD_LOGIC;
  signal C0 : STD_LOGIC;
  signal C1 : STD_LOGIC;
  signal C2 : STD_LOGIC;
  signal C3 : STD_LOGIC;
  signal C4 : STD_LOGIC;
  signal C5 : STD_LOGIC;
  signal C6 : STD_LOGIC;
  signal C7 : STD_LOGIC;
  signal TQ0 : STD_LOGIC;
  signal TQ1 : STD_LOGIC;
  signal TQ2 : STD_LOGIC;
  signal TQ3 : STD_LOGIC;
  signal TQ4 : STD_LOGIC;
  signal TQ5 : STD_LOGIC;
  signal TQ6 : STD_LOGIC;
  signal TQ7 : STD_LOGIC;
  signal X36_1N12 : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal n_0_X36_1I224 : STD_LOGIC;
  signal n_0_X36_1I237 : STD_LOGIC;
  signal n_0_X36_1I250 : STD_LOGIC;
  signal n_0_X36_1I263 : STD_LOGIC;
  signal n_0_X36_1I276 : STD_LOGIC;
  signal n_0_X36_1I289 : STD_LOGIC;
  signal n_0_X36_1I298 : STD_LOGIC;
  signal n_0_X36_1I35 : STD_LOGIC;
  signal n_0_X36_1I36 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of X36_1I224 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of X36_1I224 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I237 : label is true;
  attribute BOX_TYPE of X36_1I237 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I250 : label is true;
  attribute BOX_TYPE of X36_1I250 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I259_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I259_CARRY4 : label is "(MUXCY,XORCY)";
  attribute ASYNC_REG of X36_1I263 : label is true;
  attribute BOX_TYPE of X36_1I263 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I276 : label is true;
  attribute BOX_TYPE of X36_1I276 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I289 : label is true;
  attribute BOX_TYPE of X36_1I289 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I35 : label is true;
  attribute BOX_TYPE of X36_1I35 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I36 : label is true;
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I886 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I923 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
X36_1I224: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ2,
      Q => n_0_X36_1I224
    );
X36_1I237: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ3,
      Q => n_0_X36_1I237
    );
X36_1I250: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ4,
      Q => n_0_X36_1I250
    );
X36_1I259_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => C4,
      CO(3) => n_0_X36_1I298,
      CO(2) => C7,
      CO(1) => C6,
      CO(0) => C5,
      CYINIT => lopt_1,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ7,
      O(2) => TQ6,
      O(1) => TQ5,
      O(0) => TQ4,
      S(3) => n_0_X36_1I289,
      S(2) => n_0_X36_1I276,
      S(1) => n_0_X36_1I263,
      S(0) => n_0_X36_1I250
    );
X36_1I259_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
X36_1I263: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ5,
      Q => n_0_X36_1I263
    );
X36_1I276: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ6,
      Q => n_0_X36_1I276
    );
X36_1I289: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ7,
      Q => n_0_X36_1I289
    );
X36_1I35: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ1,
      Q => n_0_X36_1I35
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ0,
      Q => n_0_X36_1I36
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => C4,
      CO(2) => C3,
      CO(1) => C2,
      CO(0) => C1,
      CYINIT => C0,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ3,
      O(2) => TQ2,
      O(1) => TQ1,
      O(0) => TQ0,
      S(3) => n_0_X36_1I237,
      S(2) => n_0_X36_1I224,
      S(1) => n_0_X36_1I35,
      S(0) => n_0_X36_1I36
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I886: unisim.vcomponents.GND
    port map (
      G => X36_1N12
    );
X36_1I923: unisim.vcomponents.VCC
    port map (
      P => C0
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => CE,
      I1 => n_0_X36_1I298,
      O => CEO
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCC8CE_18 is
  port (
    CEO : out STD_LOGIC;
    CE : in STD_LOGIC;
    gtx_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACCC8CE_18 : entity is "CC8CE";
end TriMACCC8CE_18;

architecture STRUCTURE of TriMACCC8CE_18 is
  signal \<const0>\ : STD_LOGIC;
  signal C0 : STD_LOGIC;
  signal C1 : STD_LOGIC;
  signal C2 : STD_LOGIC;
  signal C3 : STD_LOGIC;
  signal C4 : STD_LOGIC;
  signal C5 : STD_LOGIC;
  signal C6 : STD_LOGIC;
  signal C7 : STD_LOGIC;
  signal TQ0 : STD_LOGIC;
  signal TQ1 : STD_LOGIC;
  signal TQ2 : STD_LOGIC;
  signal TQ3 : STD_LOGIC;
  signal TQ4 : STD_LOGIC;
  signal TQ5 : STD_LOGIC;
  signal TQ6 : STD_LOGIC;
  signal TQ7 : STD_LOGIC;
  signal X36_1N12 : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal n_0_X36_1I224 : STD_LOGIC;
  signal n_0_X36_1I237 : STD_LOGIC;
  signal n_0_X36_1I250 : STD_LOGIC;
  signal n_0_X36_1I263 : STD_LOGIC;
  signal n_0_X36_1I276 : STD_LOGIC;
  signal n_0_X36_1I289 : STD_LOGIC;
  signal n_0_X36_1I298 : STD_LOGIC;
  signal n_0_X36_1I35 : STD_LOGIC;
  signal n_0_X36_1I36 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of X36_1I224 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of X36_1I224 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I237 : label is true;
  attribute BOX_TYPE of X36_1I237 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I250 : label is true;
  attribute BOX_TYPE of X36_1I250 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I259_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I259_CARRY4 : label is "(MUXCY,XORCY)";
  attribute ASYNC_REG of X36_1I263 : label is true;
  attribute BOX_TYPE of X36_1I263 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I276 : label is true;
  attribute BOX_TYPE of X36_1I276 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I289 : label is true;
  attribute BOX_TYPE of X36_1I289 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I35 : label is true;
  attribute BOX_TYPE of X36_1I35 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I36 : label is true;
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I886 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I923 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
X36_1I224: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ2,
      Q => n_0_X36_1I224
    );
X36_1I237: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ3,
      Q => n_0_X36_1I237
    );
X36_1I250: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ4,
      Q => n_0_X36_1I250
    );
X36_1I259_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => C4,
      CO(3) => n_0_X36_1I298,
      CO(2) => C7,
      CO(1) => C6,
      CO(0) => C5,
      CYINIT => lopt_1,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ7,
      O(2) => TQ6,
      O(1) => TQ5,
      O(0) => TQ4,
      S(3) => n_0_X36_1I289,
      S(2) => n_0_X36_1I276,
      S(1) => n_0_X36_1I263,
      S(0) => n_0_X36_1I250
    );
X36_1I259_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
X36_1I263: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ5,
      Q => n_0_X36_1I263
    );
X36_1I276: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ6,
      Q => n_0_X36_1I276
    );
X36_1I289: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ7,
      Q => n_0_X36_1I289
    );
X36_1I35: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ1,
      Q => n_0_X36_1I35
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ0,
      Q => n_0_X36_1I36
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => C4,
      CO(2) => C3,
      CO(1) => C2,
      CO(0) => C1,
      CYINIT => C0,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ3,
      O(2) => TQ2,
      O(1) => TQ1,
      O(0) => TQ0,
      S(3) => n_0_X36_1I237,
      S(2) => n_0_X36_1I224,
      S(1) => n_0_X36_1I35,
      S(0) => n_0_X36_1I36
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I886: unisim.vcomponents.GND
    port map (
      G => X36_1N12
    );
X36_1I923: unisim.vcomponents.VCC
    port map (
      P => C0
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => CE,
      I1 => n_0_X36_1I298,
      O => CEO
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCC8CE_19 is
  port (
    CEO : out STD_LOGIC;
    CE : in STD_LOGIC;
    gtx_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACCC8CE_19 : entity is "CC8CE";
end TriMACCC8CE_19;

architecture STRUCTURE of TriMACCC8CE_19 is
  signal \<const0>\ : STD_LOGIC;
  signal C0 : STD_LOGIC;
  signal C1 : STD_LOGIC;
  signal C2 : STD_LOGIC;
  signal C3 : STD_LOGIC;
  signal C4 : STD_LOGIC;
  signal C5 : STD_LOGIC;
  signal C6 : STD_LOGIC;
  signal C7 : STD_LOGIC;
  signal TQ0 : STD_LOGIC;
  signal TQ1 : STD_LOGIC;
  signal TQ2 : STD_LOGIC;
  signal TQ3 : STD_LOGIC;
  signal TQ4 : STD_LOGIC;
  signal TQ5 : STD_LOGIC;
  signal TQ6 : STD_LOGIC;
  signal TQ7 : STD_LOGIC;
  signal X36_1N12 : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal n_0_X36_1I224 : STD_LOGIC;
  signal n_0_X36_1I237 : STD_LOGIC;
  signal n_0_X36_1I250 : STD_LOGIC;
  signal n_0_X36_1I263 : STD_LOGIC;
  signal n_0_X36_1I276 : STD_LOGIC;
  signal n_0_X36_1I289 : STD_LOGIC;
  signal n_0_X36_1I298 : STD_LOGIC;
  signal n_0_X36_1I35 : STD_LOGIC;
  signal n_0_X36_1I36 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of X36_1I224 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of X36_1I224 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I237 : label is true;
  attribute BOX_TYPE of X36_1I237 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I250 : label is true;
  attribute BOX_TYPE of X36_1I250 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I259_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I259_CARRY4 : label is "(MUXCY,XORCY)";
  attribute ASYNC_REG of X36_1I263 : label is true;
  attribute BOX_TYPE of X36_1I263 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I276 : label is true;
  attribute BOX_TYPE of X36_1I276 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I289 : label is true;
  attribute BOX_TYPE of X36_1I289 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I35 : label is true;
  attribute BOX_TYPE of X36_1I35 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I36 : label is true;
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I886 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I923 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
X36_1I224: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ2,
      Q => n_0_X36_1I224
    );
X36_1I237: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ3,
      Q => n_0_X36_1I237
    );
X36_1I250: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ4,
      Q => n_0_X36_1I250
    );
X36_1I259_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => C4,
      CO(3) => n_0_X36_1I298,
      CO(2) => C7,
      CO(1) => C6,
      CO(0) => C5,
      CYINIT => lopt_1,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ7,
      O(2) => TQ6,
      O(1) => TQ5,
      O(0) => TQ4,
      S(3) => n_0_X36_1I289,
      S(2) => n_0_X36_1I276,
      S(1) => n_0_X36_1I263,
      S(0) => n_0_X36_1I250
    );
X36_1I259_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
X36_1I263: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ5,
      Q => n_0_X36_1I263
    );
X36_1I276: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ6,
      Q => n_0_X36_1I276
    );
X36_1I289: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ7,
      Q => n_0_X36_1I289
    );
X36_1I35: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ1,
      Q => n_0_X36_1I35
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => CE,
      CLR => \<const0>\,
      D => TQ0,
      Q => n_0_X36_1I36
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => C4,
      CO(2) => C3,
      CO(1) => C2,
      CO(0) => C1,
      CYINIT => C0,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ3,
      O(2) => TQ2,
      O(1) => TQ1,
      O(0) => TQ0,
      S(3) => n_0_X36_1I237,
      S(2) => n_0_X36_1I224,
      S(1) => n_0_X36_1I35,
      S(0) => n_0_X36_1I36
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I886: unisim.vcomponents.GND
    port map (
      G => X36_1N12
    );
X36_1I923: unisim.vcomponents.VCC
    port map (
      P => C0
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => CE,
      I1 => n_0_X36_1I298,
      O => CEO
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCC8CE_8 is
  port (
    CEO : out STD_LOGIC;
    CE : in STD_LOGIC;
    I1 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACCC8CE_8 : entity is "CC8CE";
end TriMACCC8CE_8;

architecture STRUCTURE of TriMACCC8CE_8 is
  signal \<const0>\ : STD_LOGIC;
  signal C0 : STD_LOGIC;
  signal C1 : STD_LOGIC;
  signal C2 : STD_LOGIC;
  signal C3 : STD_LOGIC;
  signal C4 : STD_LOGIC;
  signal C5 : STD_LOGIC;
  signal C6 : STD_LOGIC;
  signal C7 : STD_LOGIC;
  signal TQ0 : STD_LOGIC;
  signal TQ1 : STD_LOGIC;
  signal TQ2 : STD_LOGIC;
  signal TQ3 : STD_LOGIC;
  signal TQ4 : STD_LOGIC;
  signal TQ5 : STD_LOGIC;
  signal TQ6 : STD_LOGIC;
  signal TQ7 : STD_LOGIC;
  signal X36_1N12 : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal n_0_X36_1I224 : STD_LOGIC;
  signal n_0_X36_1I237 : STD_LOGIC;
  signal n_0_X36_1I250 : STD_LOGIC;
  signal n_0_X36_1I263 : STD_LOGIC;
  signal n_0_X36_1I276 : STD_LOGIC;
  signal n_0_X36_1I289 : STD_LOGIC;
  signal n_0_X36_1I298 : STD_LOGIC;
  signal n_0_X36_1I35 : STD_LOGIC;
  signal n_0_X36_1I36 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of X36_1I224 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of X36_1I224 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I237 : label is true;
  attribute BOX_TYPE of X36_1I237 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I250 : label is true;
  attribute BOX_TYPE of X36_1I250 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I259_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I259_CARRY4 : label is "(MUXCY,XORCY)";
  attribute ASYNC_REG of X36_1I263 : label is true;
  attribute BOX_TYPE of X36_1I263 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I276 : label is true;
  attribute BOX_TYPE of X36_1I276 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I289 : label is true;
  attribute BOX_TYPE of X36_1I289 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I35 : label is true;
  attribute BOX_TYPE of X36_1I35 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I36 : label is true;
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I886 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I923 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
X36_1I224: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ2,
      Q => n_0_X36_1I224
    );
X36_1I237: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ3,
      Q => n_0_X36_1I237
    );
X36_1I250: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ4,
      Q => n_0_X36_1I250
    );
X36_1I259_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => C4,
      CO(3) => n_0_X36_1I298,
      CO(2) => C7,
      CO(1) => C6,
      CO(0) => C5,
      CYINIT => lopt_1,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ7,
      O(2) => TQ6,
      O(1) => TQ5,
      O(0) => TQ4,
      S(3) => n_0_X36_1I289,
      S(2) => n_0_X36_1I276,
      S(1) => n_0_X36_1I263,
      S(0) => n_0_X36_1I250
    );
X36_1I259_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
X36_1I263: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ5,
      Q => n_0_X36_1I263
    );
X36_1I276: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ6,
      Q => n_0_X36_1I276
    );
X36_1I289: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ7,
      Q => n_0_X36_1I289
    );
X36_1I35: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ1,
      Q => n_0_X36_1I35
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ0,
      Q => n_0_X36_1I36
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => C4,
      CO(2) => C3,
      CO(1) => C2,
      CO(0) => C1,
      CYINIT => C0,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ3,
      O(2) => TQ2,
      O(1) => TQ1,
      O(0) => TQ0,
      S(3) => n_0_X36_1I237,
      S(2) => n_0_X36_1I224,
      S(1) => n_0_X36_1I35,
      S(0) => n_0_X36_1I36
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I886: unisim.vcomponents.GND
    port map (
      G => X36_1N12
    );
X36_1I923: unisim.vcomponents.VCC
    port map (
      P => C0
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => CE,
      I1 => n_0_X36_1I298,
      O => CEO
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCC8CE_9 is
  port (
    CEO : out STD_LOGIC;
    CE : in STD_LOGIC;
    I1 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACCC8CE_9 : entity is "CC8CE";
end TriMACCC8CE_9;

architecture STRUCTURE of TriMACCC8CE_9 is
  signal \<const0>\ : STD_LOGIC;
  signal C0 : STD_LOGIC;
  signal C1 : STD_LOGIC;
  signal C2 : STD_LOGIC;
  signal C3 : STD_LOGIC;
  signal C4 : STD_LOGIC;
  signal C5 : STD_LOGIC;
  signal C6 : STD_LOGIC;
  signal C7 : STD_LOGIC;
  signal TQ0 : STD_LOGIC;
  signal TQ1 : STD_LOGIC;
  signal TQ2 : STD_LOGIC;
  signal TQ3 : STD_LOGIC;
  signal TQ4 : STD_LOGIC;
  signal TQ5 : STD_LOGIC;
  signal TQ6 : STD_LOGIC;
  signal TQ7 : STD_LOGIC;
  signal X36_1N12 : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal lopt_1 : STD_LOGIC;
  signal n_0_X36_1I224 : STD_LOGIC;
  signal n_0_X36_1I237 : STD_LOGIC;
  signal n_0_X36_1I250 : STD_LOGIC;
  signal n_0_X36_1I263 : STD_LOGIC;
  signal n_0_X36_1I276 : STD_LOGIC;
  signal n_0_X36_1I289 : STD_LOGIC;
  signal n_0_X36_1I298 : STD_LOGIC;
  signal n_0_X36_1I35 : STD_LOGIC;
  signal n_0_X36_1I36 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of X36_1I224 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of X36_1I224 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I237 : label is true;
  attribute BOX_TYPE of X36_1I237 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I250 : label is true;
  attribute BOX_TYPE of X36_1I250 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I259_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I259_CARRY4 : label is "(MUXCY,XORCY)";
  attribute ASYNC_REG of X36_1I263 : label is true;
  attribute BOX_TYPE of X36_1I263 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I276 : label is true;
  attribute BOX_TYPE of X36_1I276 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I289 : label is true;
  attribute BOX_TYPE of X36_1I289 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I35 : label is true;
  attribute BOX_TYPE of X36_1I35 : label is "PRIMITIVE";
  attribute ASYNC_REG of X36_1I36 : label is true;
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I886 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I923 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
X36_1I224: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ2,
      Q => n_0_X36_1I224
    );
X36_1I237: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ3,
      Q => n_0_X36_1I237
    );
X36_1I250: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ4,
      Q => n_0_X36_1I250
    );
X36_1I259_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => C4,
      CO(3) => n_0_X36_1I298,
      CO(2) => C7,
      CO(1) => C6,
      CO(0) => C5,
      CYINIT => lopt_1,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ7,
      O(2) => TQ6,
      O(1) => TQ5,
      O(0) => TQ4,
      S(3) => n_0_X36_1I289,
      S(2) => n_0_X36_1I276,
      S(1) => n_0_X36_1I263,
      S(0) => n_0_X36_1I250
    );
X36_1I259_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt_1
    );
X36_1I263: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ5,
      Q => n_0_X36_1I263
    );
X36_1I276: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ6,
      Q => n_0_X36_1I276
    );
X36_1I289: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ7,
      Q => n_0_X36_1I289
    );
X36_1I35: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ1,
      Q => n_0_X36_1I35
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => CE,
      CLR => \<const0>\,
      D => TQ0,
      Q => n_0_X36_1I36
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3) => C4,
      CO(2) => C3,
      CO(1) => C2,
      CO(0) => C1,
      CYINIT => C0,
      DI(3) => X36_1N12,
      DI(2) => X36_1N12,
      DI(1) => X36_1N12,
      DI(0) => X36_1N12,
      O(3) => TQ3,
      O(2) => TQ2,
      O(1) => TQ1,
      O(0) => TQ0,
      S(3) => n_0_X36_1I237,
      S(2) => n_0_X36_1I224,
      S(1) => n_0_X36_1I35,
      S(0) => n_0_X36_1I36
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I886: unisim.vcomponents.GND
    port map (
      G => X36_1N12
    );
X36_1I923: unisim.vcomponents.VCC
    port map (
      P => C0
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => CE,
      I1 => n_0_X36_1I298,
      O => CEO
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCRC32_8 is
  port (
    CRC_ENGINE_ERR0 : out STD_LOGIC;
    I1 : in STD_LOGIC;
    COMPUTE : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 7 downto 0 );
    SFD_FLAG : in STD_LOGIC;
    PREAMBLE_FIELD : in STD_LOGIC;
    FCS_FIELD : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC
  );
end TriMACCRC32_8;

architecture STRUCTURE of TriMACCRC32_8 is
  signal \<const0>\ : STD_LOGIC;
  signal CRC_CODE : STD_LOGIC_VECTOR ( 7 downto 3 );
  signal \CRC_CODE__0\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \n_0_CALC[0]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[0]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[10]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[10]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[10]_i_3\ : STD_LOGIC;
  signal \n_0_CALC[10]_i_4__0\ : STD_LOGIC;
  signal \n_0_CALC[11]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[12]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[12]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[13]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[13]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[14]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[14]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[15]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[16]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[16]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[17]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[18]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[19]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[19]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[1]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[1]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[20]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[21]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[22]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[23]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[24]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[24]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[25]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[26]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[26]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[27]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[27]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[27]_i_3\ : STD_LOGIC;
  signal \n_0_CALC[28]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[28]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[29]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[29]_i_3\ : STD_LOGIC;
  signal \n_0_CALC[2]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[2]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[30]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[30]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[31]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[31]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[3]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[3]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[3]_i_3__0\ : STD_LOGIC;
  signal \n_0_CALC[4]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[4]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[4]_i_3\ : STD_LOGIC;
  signal \n_0_CALC[5]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[5]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[6]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[7]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[8]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[8]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[9]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[9]_i_2\ : STD_LOGIC;
  signal \n_0_CALC_reg[0]\ : STD_LOGIC;
  signal \n_0_CALC_reg[10]\ : STD_LOGIC;
  signal \n_0_CALC_reg[11]\ : STD_LOGIC;
  signal \n_0_CALC_reg[12]\ : STD_LOGIC;
  signal \n_0_CALC_reg[13]\ : STD_LOGIC;
  signal \n_0_CALC_reg[14]\ : STD_LOGIC;
  signal \n_0_CALC_reg[15]\ : STD_LOGIC;
  signal \n_0_CALC_reg[16]\ : STD_LOGIC;
  signal \n_0_CALC_reg[17]\ : STD_LOGIC;
  signal \n_0_CALC_reg[18]\ : STD_LOGIC;
  signal \n_0_CALC_reg[19]\ : STD_LOGIC;
  signal \n_0_CALC_reg[1]\ : STD_LOGIC;
  signal \n_0_CALC_reg[20]\ : STD_LOGIC;
  signal \n_0_CALC_reg[21]\ : STD_LOGIC;
  signal \n_0_CALC_reg[22]\ : STD_LOGIC;
  signal \n_0_CALC_reg[23]\ : STD_LOGIC;
  signal \n_0_CALC_reg[2]\ : STD_LOGIC;
  signal \n_0_CALC_reg[3]\ : STD_LOGIC;
  signal \n_0_CALC_reg[4]\ : STD_LOGIC;
  signal \n_0_CALC_reg[5]\ : STD_LOGIC;
  signal \n_0_CALC_reg[6]\ : STD_LOGIC;
  signal \n_0_CALC_reg[7]\ : STD_LOGIC;
  signal \n_0_CALC_reg[8]\ : STD_LOGIC;
  signal \n_0_CALC_reg[9]\ : STD_LOGIC;
  signal n_0_CRC_ENGINE_ERR_i_2 : STD_LOGIC;
  signal n_0_CRC_ENGINE_ERR_i_3 : STD_LOGIC;
  signal n_0_CRC_ENGINE_ERR_i_4 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \CALC[0]_i_2\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \CALC[10]_i_2\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \CALC[10]_i_3\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \CALC[10]_i_4__0\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \CALC[19]_i_2\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \CALC[1]_i_2__0\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \CALC[21]_i_1\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \CALC[22]_i_1\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \CALC[24]_i_2__0\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \CALC[26]_i_2\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \CALC[27]_i_2\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \CALC[27]_i_3\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \CALC[28]_i_2\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \CALC[29]_i_3\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \CALC[31]_i_2\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \CALC[3]_i_3__0\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \CALC[4]_i_2\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \CALC[4]_i_3\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of CRC_ENGINE_ERR_i_3 : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of CRC_ENGINE_ERR_i_4 : label is "soft_lutpair81";
begin
\CALC[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000006969FF00"
    )
    port map (
      I0 => CRC_CODE(7),
      I1 => Q(7),
      I2 => \n_0_CALC[0]_i_2\,
      I3 => Q(0),
      I4 => COMPUTE,
      I5 => I1,
      O => \n_0_CALC[0]_i_1\
    );
\CALC[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => Q(1),
      I1 => \CRC_CODE__0\(1),
      O => \n_0_CALC[0]_i_2\
    );
\CALC[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000096FF6900"
    )
    port map (
      I0 => \n_0_CALC[10]_i_2\,
      I1 => \n_0_CALC[10]_i_3\,
      I2 => \n_0_CALC[10]_i_4__0\,
      I3 => COMPUTE,
      I4 => \n_0_CALC_reg[2]\,
      I5 => I1,
      O => \n_0_CALC[10]_i_1\
    );
\CALC[10]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9669"
    )
    port map (
      I0 => \CRC_CODE__0\(2),
      I1 => Q(2),
      I2 => Q(4),
      I3 => Q(7),
      O => \n_0_CALC[10]_i_2\
    );
\CALC[10]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => Q(5),
      I1 => CRC_CODE(5),
      O => \n_0_CALC[10]_i_3\
    );
\CALC[10]_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => CRC_CODE(7),
      I1 => CRC_CODE(4),
      O => \n_0_CALC[10]_i_4__0\
    );
\CALC[11]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A6"
    )
    port map (
      I0 => \n_0_CALC_reg[3]\,
      I1 => COMPUTE,
      I2 => \n_0_CALC[8]_i_2\,
      O => \n_0_CALC[11]_i_1__0\
    );
\CALC[12]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"96696996FFFF0000"
    )
    port map (
      I0 => \n_0_CALC[12]_i_2\,
      I1 => \n_0_CALC[0]_i_2\,
      I2 => Q(2),
      I3 => \CRC_CODE__0\(2),
      I4 => \n_0_CALC_reg[4]\,
      I5 => COMPUTE,
      O => \n_0_CALC[12]_i_1__0\
    );
\CALC[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => Q(7),
      I1 => CRC_CODE(7),
      I2 => Q(6),
      I3 => CRC_CODE(6),
      I4 => \n_0_CALC[4]_i_3\,
      I5 => \n_0_CALC[10]_i_3\,
      O => \n_0_CALC[12]_i_2\
    );
\CALC[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669FFFF96690000"
    )
    port map (
      I0 => \n_0_CALC[13]_i_2__0\,
      I1 => CRC_CODE(4),
      I2 => \n_0_CALC[19]_i_2\,
      I3 => \n_0_CALC[28]_i_2\,
      I4 => COMPUTE,
      I5 => \n_0_CALC_reg[5]\,
      O => \n_0_CALC[13]_i_1\
    );
\CALC[13]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
    port map (
      I0 => Q(6),
      I1 => CRC_CODE(5),
      I2 => \n_0_CALC_reg[5]\,
      I3 => Q(5),
      I4 => Q(4),
      I5 => CRC_CODE(6),
      O => \n_0_CALC[13]_i_2__0\
    );
\CALC[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996FFFF96690000"
    )
    port map (
      I0 => CRC_CODE(5),
      I1 => CRC_CODE(4),
      I2 => \n_0_CALC[19]_i_2\,
      I3 => \n_0_CALC[14]_i_2\,
      I4 => COMPUTE,
      I5 => \n_0_CALC_reg[6]\,
      O => \n_0_CALC[14]_i_1\
    );
\CALC[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => Q(3),
      I1 => CRC_CODE(3),
      I2 => Q(1),
      I3 => \CRC_CODE__0\(1),
      I4 => Q(4),
      I5 => Q(5),
      O => \n_0_CALC[14]_i_2\
    );
\CALC[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A66A6AA66AA6A66A"
    )
    port map (
      I0 => \n_0_CALC_reg[7]\,
      I1 => COMPUTE,
      I2 => \n_0_CALC[19]_i_2\,
      I3 => CRC_CODE(4),
      I4 => Q(4),
      I5 => \n_0_CALC[16]_i_2\,
      O => \n_0_CALC[15]_i_1\
    );
\CALC[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000096FF6900"
    )
    port map (
      I0 => \n_0_CALC[16]_i_2\,
      I1 => Q(7),
      I2 => CRC_CODE(7),
      I3 => COMPUTE,
      I4 => \n_0_CALC_reg[8]\,
      I5 => I1,
      O => \n_0_CALC[16]_i_1\
    );
\CALC[16]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => CRC_CODE(3),
      I1 => Q(3),
      I2 => \CRC_CODE__0\(2),
      I3 => Q(2),
      O => \n_0_CALC[16]_i_2\
    );
\CALC[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A66A6AA66AA6A66A"
    )
    port map (
      I0 => \n_0_CALC_reg[9]\,
      I1 => COMPUTE,
      I2 => \n_0_CALC[24]_i_2__0\,
      I3 => \n_0_CALC[0]_i_2\,
      I4 => \CRC_CODE__0\(2),
      I5 => Q(2),
      O => \n_0_CALC[17]_i_1\
    );
\CALC[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000009669AAAA"
    )
    port map (
      I0 => \n_0_CALC_reg[10]\,
      I1 => CRC_CODE(5),
      I2 => Q(5),
      I3 => \n_0_CALC[29]_i_3\,
      I4 => COMPUTE,
      I5 => I1,
      O => \n_0_CALC[18]_i_1\
    );
\CALC[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1551511540040440"
    )
    port map (
      I0 => I1,
      I1 => COMPUTE,
      I2 => \n_0_CALC[19]_i_2\,
      I3 => CRC_CODE(4),
      I4 => Q(4),
      I5 => \n_0_CALC_reg[11]\,
      O => \n_0_CALC[19]_i_1\
    );
\CALC[19]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => Q(0),
      I1 => \CRC_CODE__0\(0),
      O => \n_0_CALC[19]_i_2\
    );
\CALC[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000009669FF00"
    )
    port map (
      I0 => \n_0_CALC[19]_i_2\,
      I1 => \CRC_CODE__0\(1),
      I2 => \n_0_CALC[1]_i_2__0\,
      I3 => Q(1),
      I4 => COMPUTE,
      I5 => I1,
      O => \n_0_CALC[1]_i_1\
    );
\CALC[1]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => CRC_CODE(6),
      I1 => Q(6),
      I2 => CRC_CODE(7),
      I3 => Q(7),
      O => \n_0_CALC[1]_i_2__0\
    );
\CALC[20]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"69F0"
    )
    port map (
      I0 => CRC_CODE(3),
      I1 => Q(3),
      I2 => \n_0_CALC_reg[12]\,
      I3 => COMPUTE,
      O => \n_0_CALC[20]_i_1\
    );
\CALC[21]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"69AA"
    )
    port map (
      I0 => \n_0_CALC_reg[13]\,
      I1 => Q(2),
      I2 => \CRC_CODE__0\(2),
      I3 => COMPUTE,
      O => \n_0_CALC[21]_i_1\
    );
\CALC[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"69F0"
    )
    port map (
      I0 => CRC_CODE(7),
      I1 => Q(7),
      I2 => \n_0_CALC_reg[14]\,
      I3 => COMPUTE,
      O => \n_0_CALC[22]_i_1\
    );
\CALC[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"96696996FFFF0000"
    )
    port map (
      I0 => Q(7),
      I1 => CRC_CODE(7),
      I2 => \n_0_CALC[24]_i_2__0\,
      I3 => \n_0_CALC[0]_i_2\,
      I4 => \n_0_CALC_reg[15]\,
      I5 => COMPUTE,
      O => \n_0_CALC[23]_i_1\
    );
\CALC[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669FFFF69960000"
    )
    port map (
      I0 => \CRC_CODE__0\(0),
      I1 => Q(0),
      I2 => \n_0_CALC[10]_i_3\,
      I3 => \n_0_CALC[24]_i_2__0\,
      I4 => COMPUTE,
      I5 => \n_0_CALC_reg[16]\,
      O => \n_0_CALC[24]_i_1\
    );
\CALC[24]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => Q(6),
      I1 => CRC_CODE(6),
      O => \n_0_CALC[24]_i_2__0\
    );
\CALC[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A66A6AA66AA6A66A"
    )
    port map (
      I0 => \n_0_CALC_reg[17]\,
      I1 => COMPUTE,
      I2 => Q(4),
      I3 => CRC_CODE(4),
      I4 => Q(5),
      I5 => CRC_CODE(5),
      O => \n_0_CALC[25]_i_1\
    );
\CALC[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A66A6AA66AA6A66A"
    )
    port map (
      I0 => \n_0_CALC_reg[18]\,
      I1 => COMPUTE,
      I2 => \n_0_CALC[26]_i_2\,
      I3 => \n_0_CALC[10]_i_4__0\,
      I4 => Q(7),
      I5 => Q(4),
      O => \n_0_CALC[26]_i_1\
    );
\CALC[26]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \CRC_CODE__0\(1),
      I1 => Q(1),
      I2 => CRC_CODE(3),
      I3 => Q(3),
      O => \n_0_CALC[26]_i_2\
    );
\CALC[27]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"96696996FFFF0000"
    )
    port map (
      I0 => \n_0_CALC[27]_i_2\,
      I1 => CRC_CODE(6),
      I2 => Q(6),
      I3 => \n_0_CALC[27]_i_3\,
      I4 => \n_0_CALC_reg[19]\,
      I5 => COMPUTE,
      O => \n_0_CALC[27]_i_1__0\
    );
\CALC[27]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => Q(2),
      I1 => \CRC_CODE__0\(2),
      O => \n_0_CALC[27]_i_2\
    );
\CALC[27]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \CRC_CODE__0\(0),
      I1 => Q(0),
      I2 => CRC_CODE(3),
      I3 => Q(3),
      O => \n_0_CALC[27]_i_3\
    );
\CALC[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000096FF6900"
    )
    port map (
      I0 => \n_0_CALC[28]_i_2\,
      I1 => Q(5),
      I2 => CRC_CODE(5),
      I3 => COMPUTE,
      I4 => \n_0_CALC_reg[20]\,
      I5 => I1,
      O => \n_0_CALC[28]_i_1\
    );
\CALC[28]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \CRC_CODE__0\(1),
      I1 => Q(1),
      I2 => \CRC_CODE__0\(2),
      I3 => Q(2),
      O => \n_0_CALC[28]_i_2\
    );
\CALC[29]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000096FF6900"
    )
    port map (
      I0 => \n_0_CALC[29]_i_3\,
      I1 => CRC_CODE(4),
      I2 => Q(4),
      I3 => COMPUTE,
      I4 => \n_0_CALC_reg[21]\,
      I5 => I1,
      O => \n_0_CALC[29]_i_2\
    );
\CALC[29]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \CRC_CODE__0\(1),
      I1 => Q(1),
      I2 => \CRC_CODE__0\(0),
      I3 => Q(0),
      O => \n_0_CALC[29]_i_3\
    );
\CALC[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996FFFF69960000"
    )
    port map (
      I0 => \n_0_CALC[2]_i_2\,
      I1 => Q(6),
      I2 => CRC_CODE(6),
      I3 => Q(7),
      I4 => COMPUTE,
      I5 => Q(2),
      O => \n_0_CALC[2]_i_1\
    );
\CALC[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => Q(0),
      I1 => \CRC_CODE__0\(0),
      I2 => Q(1),
      I3 => \CRC_CODE__0\(1),
      I4 => \n_0_CALC[10]_i_3\,
      I5 => CRC_CODE(7),
      O => \n_0_CALC[2]_i_2\
    );
\CALC[30]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => SFD_FLAG,
      I1 => PREAMBLE_FIELD,
      O => \n_0_CALC[30]_i_1\
    );
\CALC[30]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"96696996AAAAAAAA"
    )
    port map (
      I0 => \n_0_CALC_reg[22]\,
      I1 => \CRC_CODE__0\(0),
      I2 => Q(0),
      I3 => CRC_CODE(3),
      I4 => Q(3),
      I5 => COMPUTE,
      O => \n_0_CALC[30]_i_2\
    );
\CALC[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => SFD_FLAG,
      I1 => PREAMBLE_FIELD,
      O => \n_0_CALC[31]_i_1\
    );
\CALC[31]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"69AA"
    )
    port map (
      I0 => \n_0_CALC_reg[23]\,
      I1 => Q(2),
      I2 => \CRC_CODE__0\(2),
      I3 => COMPUTE,
      O => \n_0_CALC[31]_i_2\
    );
\CALC[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"005C5C5C"
    )
    port map (
      I0 => \n_0_CALC[3]_i_2\,
      I1 => Q(3),
      I2 => COMPUTE,
      I3 => SFD_FLAG,
      I4 => PREAMBLE_FIELD,
      O => \n_0_CALC[3]_i_1\
    );
\CALC[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
    port map (
      I0 => CRC_CODE(6),
      I1 => Q(4),
      I2 => Q(6),
      I3 => CRC_CODE(5),
      I4 => \n_0_CALC[3]_i_3__0\,
      I5 => Q(5),
      O => \n_0_CALC[3]_i_2\
    );
\CALC[3]_i_3__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
    port map (
      I0 => CRC_CODE(4),
      I1 => \CRC_CODE__0\(0),
      I2 => Q(0),
      O => \n_0_CALC[3]_i_3__0\
    );
\CALC[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"96696996FFFF0000"
    )
    port map (
      I0 => Q(7),
      I1 => \n_0_CALC[0]_i_2\,
      I2 => \n_0_CALC[4]_i_2\,
      I3 => \n_0_CALC[4]_i_3\,
      I4 => Q(4),
      I5 => COMPUTE,
      O => \n_0_CALC[4]_i_1\
    );
\CALC[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => CRC_CODE(5),
      I1 => Q(5),
      I2 => CRC_CODE(4),
      I3 => CRC_CODE(7),
      O => \n_0_CALC[4]_i_2\
    );
\CALC[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => Q(3),
      I1 => CRC_CODE(3),
      O => \n_0_CALC[4]_i_3\
    );
\CALC[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2EE2E22E"
    )
    port map (
      I0 => Q(5),
      I1 => COMPUTE,
      I2 => \n_0_CALC[5]_i_2__0\,
      I3 => \n_0_CALC[29]_i_3\,
      I4 => \n_0_CALC[16]_i_2\,
      O => \n_0_CALC[5]_i_1\
    );
\CALC[5]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
    port map (
      I0 => Q(6),
      I1 => Q(7),
      I2 => CRC_CODE(6),
      I3 => Q(4),
      I4 => CRC_CODE(7),
      I5 => CRC_CODE(4),
      O => \n_0_CALC[5]_i_2__0\
    );
\CALC[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AA6A66AA66A6AA6"
    )
    port map (
      I0 => Q(6),
      I1 => COMPUTE,
      I2 => \n_0_CALC[29]_i_3\,
      I3 => \n_0_CALC[16]_i_2\,
      I4 => CRC_CODE(6),
      I5 => \n_0_CALC[10]_i_3\,
      O => \n_0_CALC[6]_i_1\
    );
\CALC[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E22E2EE22EE2E22E"
    )
    port map (
      I0 => Q(7),
      I1 => COMPUTE,
      I2 => \n_0_CALC[10]_i_3\,
      I3 => \n_0_CALC[10]_i_4__0\,
      I4 => \n_0_CALC[19]_i_2\,
      I5 => \n_0_CALC[10]_i_2\,
      O => \n_0_CALC[7]_i_1\
    );
\CALC[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9A"
    )
    port map (
      I0 => \n_0_CALC_reg[0]\,
      I1 => \n_0_CALC[8]_i_2\,
      I2 => COMPUTE,
      O => \n_0_CALC[8]_i_1\
    );
\CALC[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => CRC_CODE(4),
      I1 => CRC_CODE(7),
      I2 => \n_0_CALC[24]_i_2__0\,
      I3 => \n_0_CALC[4]_i_3\,
      I4 => Q(7),
      I5 => Q(4),
      O => \n_0_CALC[8]_i_2\
    );
\CALC[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00747474"
    )
    port map (
      I0 => \n_0_CALC[9]_i_2\,
      I1 => COMPUTE,
      I2 => \n_0_CALC_reg[1]\,
      I3 => SFD_FLAG,
      I4 => PREAMBLE_FIELD,
      O => \n_0_CALC[9]_i_1\
    );
\CALC[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
    port map (
      I0 => CRC_CODE(5),
      I1 => \n_0_CALC_reg[1]\,
      I2 => Q(6),
      I3 => Q(5),
      I4 => \n_0_CALC[16]_i_2\,
      I5 => CRC_CODE(6),
      O => \n_0_CALC[9]_i_2\
    );
\CALC_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[0]_i_1\,
      Q => \n_0_CALC_reg[0]\,
      R => \<const0>\
    );
\CALC_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[10]_i_1\,
      Q => \n_0_CALC_reg[10]\,
      R => \<const0>\
    );
\CALC_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[11]_i_1__0\,
      Q => \n_0_CALC_reg[11]\,
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[12]_i_1__0\,
      Q => \n_0_CALC_reg[12]\,
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[13]_i_1\,
      Q => \n_0_CALC_reg[13]\,
      R => \n_0_CALC[31]_i_1\
    );
\CALC_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[14]_i_1\,
      Q => \n_0_CALC_reg[14]\,
      R => \n_0_CALC[31]_i_1\
    );
\CALC_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[15]_i_1\,
      Q => \n_0_CALC_reg[15]\,
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[16]_i_1\,
      Q => \n_0_CALC_reg[16]\,
      R => \<const0>\
    );
\CALC_reg[17]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[17]_i_1\,
      Q => \n_0_CALC_reg[17]\,
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[18]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[18]_i_1\,
      Q => \n_0_CALC_reg[18]\,
      R => \<const0>\
    );
\CALC_reg[19]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[19]_i_1\,
      Q => \n_0_CALC_reg[19]\,
      R => \<const0>\
    );
\CALC_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[1]_i_1\,
      Q => \n_0_CALC_reg[1]\,
      R => \<const0>\
    );
\CALC_reg[20]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[20]_i_1\,
      Q => \n_0_CALC_reg[20]\,
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[21]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[21]_i_1\,
      Q => \n_0_CALC_reg[21]\,
      R => \n_0_CALC[31]_i_1\
    );
\CALC_reg[22]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[22]_i_1\,
      Q => \n_0_CALC_reg[22]\,
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[23]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[23]_i_1\,
      Q => \n_0_CALC_reg[23]\,
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[24]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[24]_i_1\,
      Q => CRC_CODE(7),
      R => \n_0_CALC[31]_i_1\
    );
\CALC_reg[25]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[25]_i_1\,
      Q => CRC_CODE(6),
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[26]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[26]_i_1\,
      Q => CRC_CODE(5),
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[27]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[27]_i_1__0\,
      Q => CRC_CODE(4),
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[28]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[28]_i_1\,
      Q => CRC_CODE(3),
      R => \<const0>\
    );
\CALC_reg[29]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[29]_i_2\,
      Q => \CRC_CODE__0\(2),
      R => \<const0>\
    );
\CALC_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[2]_i_1\,
      Q => \n_0_CALC_reg[2]\,
      R => \n_0_CALC[31]_i_1\
    );
\CALC_reg[30]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[30]_i_2\,
      Q => \CRC_CODE__0\(1),
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[31]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[31]_i_2\,
      Q => \CRC_CODE__0\(0),
      R => \n_0_CALC[31]_i_1\
    );
\CALC_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[3]_i_1\,
      Q => \n_0_CALC_reg[3]\,
      R => \<const0>\
    );
\CALC_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[4]_i_1\,
      Q => \n_0_CALC_reg[4]\,
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[5]_i_1\,
      Q => \n_0_CALC_reg[5]\,
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[6]_i_1\,
      Q => \n_0_CALC_reg[6]\,
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[7]_i_1\,
      Q => \n_0_CALC_reg[7]\,
      R => \n_0_CALC[30]_i_1\
    );
\CALC_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[8]_i_1\,
      Q => \n_0_CALC_reg[8]\,
      R => \n_0_CALC[31]_i_1\
    );
\CALC_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => \n_0_CALC[9]_i_1\,
      Q => \n_0_CALC_reg[9]\,
      R => \<const0>\
    );
CRC_ENGINE_ERR_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2AA2AAAAAAAA2AA2"
    )
    port map (
      I0 => FCS_FIELD,
      I1 => n_0_CRC_ENGINE_ERR_i_2,
      I2 => CRC_CODE(6),
      I3 => Q(6),
      I4 => CRC_CODE(3),
      I5 => Q(3),
      O => CRC_ENGINE_ERR0
    );
CRC_ENGINE_ERR_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => n_0_CRC_ENGINE_ERR_i_3,
      I1 => \n_0_CALC[27]_i_2\,
      I2 => \n_0_CALC[10]_i_3\,
      I3 => \n_0_CALC[0]_i_2\,
      I4 => \n_0_CALC[19]_i_2\,
      I5 => n_0_CRC_ENGINE_ERR_i_4,
      O => n_0_CRC_ENGINE_ERR_i_2
    );
CRC_ENGINE_ERR_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => Q(7),
      I1 => CRC_CODE(7),
      O => n_0_CRC_ENGINE_ERR_i_3
    );
CRC_ENGINE_ERR_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => CRC_CODE(4),
      I1 => Q(4),
      O => n_0_CRC_ENGINE_ERR_i_4
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCRC32_8_21 is
  port (
    D : out STD_LOGIC_VECTOR ( 7 downto 0 );
    CRC : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 7 downto 0 );
    COMPUTE : in STD_LOGIC;
    I1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I18 : in STD_LOGIC;
    gtx_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACCRC32_8_21 : entity is "CRC32_8";
end TriMACCRC32_8_21;

architecture STRUCTURE of TriMACCRC32_8_21 is
  signal \<const0>\ : STD_LOGIC;
  signal DATA_OUT0 : STD_LOGIC;
  signal \n_0_CALC[0]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[0]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[10]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[10]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[10]_i_3__0\ : STD_LOGIC;
  signal \n_0_CALC[10]_i_4\ : STD_LOGIC;
  signal \n_0_CALC[11]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[11]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[11]_i_3\ : STD_LOGIC;
  signal \n_0_CALC[12]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[12]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[13]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[13]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[13]_i_3\ : STD_LOGIC;
  signal \n_0_CALC[14]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[14]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[15]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[16]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[16]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[17]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[18]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[19]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[1]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[1]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[1]_i_3\ : STD_LOGIC;
  signal \n_0_CALC[20]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[21]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[22]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[23]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[24]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[24]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[25]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[26]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[26]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[26]_i_3\ : STD_LOGIC;
  signal \n_0_CALC[27]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[27]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[28]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[28]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[29]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[29]_i_3__0\ : STD_LOGIC;
  signal \n_0_CALC[2]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[2]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[30]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[31]_i_1\ : STD_LOGIC;
  signal \n_0_CALC[3]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[3]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[3]_i_3\ : STD_LOGIC;
  signal \n_0_CALC[4]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[4]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC[5]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[5]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[6]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[6]_i_2\ : STD_LOGIC;
  signal \n_0_CALC[7]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[8]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[9]_i_1__0\ : STD_LOGIC;
  signal \n_0_CALC[9]_i_2__0\ : STD_LOGIC;
  signal \n_0_CALC_reg[0]\ : STD_LOGIC;
  signal \n_0_CALC_reg[10]\ : STD_LOGIC;
  signal \n_0_CALC_reg[11]\ : STD_LOGIC;
  signal \n_0_CALC_reg[12]\ : STD_LOGIC;
  signal \n_0_CALC_reg[13]\ : STD_LOGIC;
  signal \n_0_CALC_reg[14]\ : STD_LOGIC;
  signal \n_0_CALC_reg[15]\ : STD_LOGIC;
  signal \n_0_CALC_reg[16]\ : STD_LOGIC;
  signal \n_0_CALC_reg[17]\ : STD_LOGIC;
  signal \n_0_CALC_reg[18]\ : STD_LOGIC;
  signal \n_0_CALC_reg[19]\ : STD_LOGIC;
  signal \n_0_CALC_reg[1]\ : STD_LOGIC;
  signal \n_0_CALC_reg[20]\ : STD_LOGIC;
  signal \n_0_CALC_reg[21]\ : STD_LOGIC;
  signal \n_0_CALC_reg[22]\ : STD_LOGIC;
  signal \n_0_CALC_reg[23]\ : STD_LOGIC;
  signal \n_0_CALC_reg[25]\ : STD_LOGIC;
  signal \n_0_CALC_reg[26]\ : STD_LOGIC;
  signal \n_0_CALC_reg[27]\ : STD_LOGIC;
  signal \n_0_CALC_reg[28]\ : STD_LOGIC;
  signal \n_0_CALC_reg[29]\ : STD_LOGIC;
  signal \n_0_CALC_reg[2]\ : STD_LOGIC;
  signal \n_0_CALC_reg[30]\ : STD_LOGIC;
  signal \n_0_CALC_reg[31]\ : STD_LOGIC;
  signal \n_0_CALC_reg[3]\ : STD_LOGIC;
  signal \n_0_CALC_reg[4]\ : STD_LOGIC;
  signal \n_0_CALC_reg[5]\ : STD_LOGIC;
  signal \n_0_CALC_reg[6]\ : STD_LOGIC;
  signal \n_0_CALC_reg[7]\ : STD_LOGIC;
  signal \n_0_CALC_reg[8]\ : STD_LOGIC;
  signal \n_0_CALC_reg[9]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \CALC[0]_i_2__0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \CALC[10]_i_2__0\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \CALC[10]_i_3__0\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \CALC[10]_i_4\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \CALC[11]_i_3\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \CALC[13]_i_3\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \CALC[16]_i_2__0\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \CALC[1]_i_3\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \CALC[20]_i_1__0\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \CALC[21]_i_1__0\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \CALC[22]_i_1__0\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \CALC[23]_i_1__0\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \CALC[24]_i_2\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \CALC[26]_i_2__0\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \CALC[26]_i_3\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \CALC[28]_i_2__0\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \CALC[29]_i_3__0\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \CALC[31]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \CALC[3]_i_1__0\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \CALC[3]_i_3\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \CALC[4]_i_2__0\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \CALC[9]_i_2__0\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \txd_reg1[0]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \txd_reg1[1]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \txd_reg1[2]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \txd_reg1[3]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \txd_reg1[4]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \txd_reg1[5]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \txd_reg1[6]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \txd_reg1[7]_i_1\ : label is "soft_lutpair33";
begin
\CALC[0]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000006969FF00"
    )
    port map (
      I0 => \n_0_CALC[0]_i_2__0\,
      I1 => DATA_OUT0,
      I2 => Q(7),
      I3 => Q(0),
      I4 => COMPUTE,
      I5 => I1(0),
      O => \n_0_CALC[0]_i_1__0\
    );
\CALC[0]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_CALC_reg[30]\,
      I1 => Q(1),
      O => \n_0_CALC[0]_i_2__0\
    );
\CALC[10]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000009669FF00"
    )
    port map (
      I0 => \n_0_CALC[10]_i_2__0\,
      I1 => \n_0_CALC[10]_i_3__0\,
      I2 => \n_0_CALC[10]_i_4\,
      I3 => \n_0_CALC_reg[2]\,
      I4 => COMPUTE,
      I5 => I1(0),
      O => \n_0_CALC[10]_i_1__0\
    );
\CALC[10]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => Q(7),
      I1 => Q(4),
      O => \n_0_CALC[10]_i_2__0\
    );
\CALC[10]_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => Q(2),
      I1 => \n_0_CALC_reg[29]\,
      O => \n_0_CALC[10]_i_3__0\
    );
\CALC[10]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_CALC_reg[26]\,
      I1 => Q(5),
      I2 => \n_0_CALC_reg[27]\,
      I3 => DATA_OUT0,
      O => \n_0_CALC[10]_i_4\
    );
\CALC[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
    port map (
      I0 => \n_0_CALC_reg[3]\,
      I1 => \n_0_CALC[11]_i_2\,
      I2 => I1(0),
      O => \n_0_CALC[11]_i_1\
    );
\CALC[11]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2882822882282882"
    )
    port map (
      I0 => COMPUTE,
      I1 => Q(4),
      I2 => Q(7),
      I3 => \n_0_CALC[11]_i_3\,
      I4 => \n_0_CALC[4]_i_2__0\,
      I5 => \n_0_CALC[26]_i_3\,
      O => \n_0_CALC[11]_i_2\
    );
\CALC[11]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => Q(6),
      I1 => \n_0_CALC_reg[25]\,
      O => \n_0_CALC[11]_i_3\
    );
\CALC[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A66A6AA66AA6A66A"
    )
    port map (
      I0 => \n_0_CALC_reg[4]\,
      I1 => COMPUTE,
      I2 => \n_0_CALC_reg[29]\,
      I3 => Q(2),
      I4 => \n_0_CALC[0]_i_2__0\,
      I5 => \n_0_CALC[12]_i_2__0\,
      O => \n_0_CALC[12]_i_1\
    );
\CALC[12]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => Q(7),
      I1 => DATA_OUT0,
      I2 => Q(6),
      I3 => \n_0_CALC_reg[25]\,
      I4 => \n_0_CALC[24]_i_2\,
      I5 => \n_0_CALC[4]_i_2__0\,
      O => \n_0_CALC[12]_i_2__0\
    );
\CALC[13]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669FFFF96690000"
    )
    port map (
      I0 => \n_0_CALC_reg[25]\,
      I1 => \n_0_CALC[13]_i_2\,
      I2 => \n_0_CALC[28]_i_2__0\,
      I3 => \n_0_CALC[13]_i_3\,
      I4 => COMPUTE,
      I5 => \n_0_CALC_reg[5]\,
      O => \n_0_CALC[13]_i_1__0\
    );
\CALC[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => \n_0_CALC_reg[31]\,
      I1 => Q(0),
      I2 => \n_0_CALC_reg[27]\,
      I3 => Q(6),
      I4 => \n_0_CALC_reg[26]\,
      I5 => \n_0_CALC_reg[5]\,
      O => \n_0_CALC[13]_i_2\
    );
\CALC[13]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => Q(5),
      I1 => Q(4),
      O => \n_0_CALC[13]_i_3\
    );
\CALC[14]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996FFFF96690000"
    )
    port map (
      I0 => Q(5),
      I1 => Q(4),
      I2 => \n_0_CALC_reg[26]\,
      I3 => \n_0_CALC[14]_i_2__0\,
      I4 => COMPUTE,
      I5 => \n_0_CALC_reg[6]\,
      O => \n_0_CALC[14]_i_1__0\
    );
\CALC[14]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => \n_0_CALC_reg[30]\,
      I1 => Q(1),
      I2 => Q(3),
      I3 => \n_0_CALC_reg[28]\,
      I4 => \n_0_CALC[1]_i_2\,
      I5 => \n_0_CALC_reg[27]\,
      O => \n_0_CALC[14]_i_2__0\
    );
\CALC[15]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A66A6AA66AA6A66A"
    )
    port map (
      I0 => \n_0_CALC_reg[7]\,
      I1 => COMPUTE,
      I2 => \n_0_CALC_reg[27]\,
      I3 => Q(4),
      I4 => \n_0_CALC[1]_i_2\,
      I5 => \n_0_CALC[16]_i_2__0\,
      O => \n_0_CALC[15]_i_1__0\
    );
\CALC[16]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000009669FF00"
    )
    port map (
      I0 => Q(7),
      I1 => DATA_OUT0,
      I2 => \n_0_CALC[16]_i_2__0\,
      I3 => \n_0_CALC_reg[8]\,
      I4 => COMPUTE,
      I5 => I1(0),
      O => \n_0_CALC[16]_i_1__0\
    );
\CALC[16]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_CALC_reg[29]\,
      I1 => Q(2),
      I2 => \n_0_CALC_reg[28]\,
      I3 => Q(3),
      O => \n_0_CALC[16]_i_2__0\
    );
\CALC[17]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AA6A66AA66A6AA6"
    )
    port map (
      I0 => \n_0_CALC_reg[9]\,
      I1 => COMPUTE,
      I2 => \n_0_CALC_reg[25]\,
      I3 => Q(6),
      I4 => \n_0_CALC[10]_i_3__0\,
      I5 => \n_0_CALC[0]_i_2__0\,
      O => \n_0_CALC[17]_i_1__0\
    );
\CALC[18]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4114144144444444"
    )
    port map (
      I0 => I1(0),
      I1 => \n_0_CALC_reg[10]\,
      I2 => Q(5),
      I3 => \n_0_CALC_reg[26]\,
      I4 => \n_0_CALC[29]_i_3__0\,
      I5 => COMPUTE,
      O => \n_0_CALC[18]_i_1__0\
    );
\CALC[19]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A66A6AA66AA6A66A"
    )
    port map (
      I0 => \n_0_CALC_reg[11]\,
      I1 => COMPUTE,
      I2 => Q(4),
      I3 => Q(0),
      I4 => \n_0_CALC_reg[31]\,
      I5 => \n_0_CALC_reg[27]\,
      O => \n_0_CALC[19]_i_1__0\
    );
\CALC[1]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000009669FF00"
    )
    port map (
      I0 => \n_0_CALC_reg[30]\,
      I1 => \n_0_CALC[1]_i_2\,
      I2 => \n_0_CALC[1]_i_3\,
      I3 => Q(1),
      I4 => COMPUTE,
      I5 => I1(0),
      O => \n_0_CALC[1]_i_1__0\
    );
\CALC[1]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_CALC_reg[31]\,
      I1 => Q(0),
      O => \n_0_CALC[1]_i_2\
    );
\CALC[1]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_CALC_reg[25]\,
      I1 => Q(6),
      I2 => DATA_OUT0,
      I3 => Q(7),
      O => \n_0_CALC[1]_i_3\
    );
\CALC[20]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"69F0"
    )
    port map (
      I0 => \n_0_CALC_reg[28]\,
      I1 => Q(3),
      I2 => \n_0_CALC_reg[12]\,
      I3 => COMPUTE,
      O => \n_0_CALC[20]_i_1__0\
    );
\CALC[21]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"69AA"
    )
    port map (
      I0 => \n_0_CALC_reg[13]\,
      I1 => Q(2),
      I2 => \n_0_CALC_reg[29]\,
      I3 => COMPUTE,
      O => \n_0_CALC[21]_i_1__0\
    );
\CALC[22]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"69F0"
    )
    port map (
      I0 => DATA_OUT0,
      I1 => Q(7),
      I2 => \n_0_CALC_reg[14]\,
      I3 => COMPUTE,
      O => \n_0_CALC[22]_i_1__0\
    );
\CALC[23]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"9669FF00"
    )
    port map (
      I0 => \n_0_CALC[1]_i_3\,
      I1 => \n_0_CALC_reg[30]\,
      I2 => Q(1),
      I3 => \n_0_CALC_reg[15]\,
      I4 => COMPUTE,
      O => \n_0_CALC[23]_i_1__0\
    );
\CALC[24]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996FFFF96690000"
    )
    port map (
      I0 => \n_0_CALC[1]_i_2\,
      I1 => \n_0_CALC[24]_i_2\,
      I2 => Q(6),
      I3 => \n_0_CALC_reg[25]\,
      I4 => COMPUTE,
      I5 => \n_0_CALC_reg[16]\,
      O => \n_0_CALC[24]_i_1__0\
    );
\CALC[24]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => Q(5),
      I1 => \n_0_CALC_reg[26]\,
      O => \n_0_CALC[24]_i_2\
    );
\CALC[25]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A66A6AA66AA6A66A"
    )
    port map (
      I0 => \n_0_CALC_reg[17]\,
      I1 => COMPUTE,
      I2 => Q(4),
      I3 => \n_0_CALC_reg[27]\,
      I4 => Q(5),
      I5 => \n_0_CALC_reg[26]\,
      O => \n_0_CALC[25]_i_1__0\
    );
\CALC[26]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A66A6AA66AA6A66A"
    )
    port map (
      I0 => \n_0_CALC_reg[18]\,
      I1 => COMPUTE,
      I2 => \n_0_CALC[26]_i_2__0\,
      I3 => \n_0_CALC[26]_i_3\,
      I4 => Q(7),
      I5 => Q(4),
      O => \n_0_CALC[26]_i_1__0\
    );
\CALC[26]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_CALC_reg[28]\,
      I1 => Q(3),
      I2 => Q(1),
      I3 => \n_0_CALC_reg[30]\,
      O => \n_0_CALC[26]_i_2__0\
    );
\CALC[26]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => DATA_OUT0,
      I1 => \n_0_CALC_reg[27]\,
      O => \n_0_CALC[26]_i_3\
    );
\CALC[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000096F0"
    )
    port map (
      I0 => Q(6),
      I1 => \n_0_CALC[27]_i_2__0\,
      I2 => \n_0_CALC_reg[19]\,
      I3 => COMPUTE,
      I4 => I1(0),
      O => \n_0_CALC[27]_i_1\
    );
\CALC[27]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => Q(3),
      I1 => \n_0_CALC_reg[28]\,
      I2 => \n_0_CALC[1]_i_2\,
      I3 => Q(2),
      I4 => \n_0_CALC_reg[29]\,
      I5 => \n_0_CALC_reg[25]\,
      O => \n_0_CALC[27]_i_2__0\
    );
\CALC[28]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000009669FF00"
    )
    port map (
      I0 => \n_0_CALC[28]_i_2__0\,
      I1 => Q(5),
      I2 => \n_0_CALC_reg[26]\,
      I3 => \n_0_CALC_reg[20]\,
      I4 => COMPUTE,
      I5 => I1(0),
      O => \n_0_CALC[28]_i_1__0\
    );
\CALC[28]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_CALC_reg[29]\,
      I1 => Q(2),
      I2 => Q(1),
      I3 => \n_0_CALC_reg[30]\,
      O => \n_0_CALC[28]_i_2__0\
    );
\CALC[29]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000009669FF00"
    )
    port map (
      I0 => \n_0_CALC[29]_i_3__0\,
      I1 => \n_0_CALC_reg[27]\,
      I2 => Q(4),
      I3 => \n_0_CALC_reg[21]\,
      I4 => COMPUTE,
      I5 => I1(0),
      O => \n_0_CALC[29]_i_2__0\
    );
\CALC[29]_i_3__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => Q(0),
      I1 => \n_0_CALC_reg[31]\,
      I2 => Q(1),
      I3 => \n_0_CALC_reg[30]\,
      O => \n_0_CALC[29]_i_3__0\
    );
\CALC[2]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"005C"
    )
    port map (
      I0 => \n_0_CALC[2]_i_2__0\,
      I1 => Q(2),
      I2 => COMPUTE,
      I3 => I1(0),
      O => \n_0_CALC[2]_i_1__0\
    );
\CALC[2]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
    port map (
      I0 => Q(7),
      I1 => Q(6),
      I2 => \n_0_CALC_reg[25]\,
      I3 => DATA_OUT0,
      I4 => \n_0_CALC[24]_i_2\,
      I5 => \n_0_CALC[29]_i_3__0\,
      O => \n_0_CALC[2]_i_2__0\
    );
\CALC[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669FFFF69960000"
    )
    port map (
      I0 => \n_0_CALC_reg[28]\,
      I1 => Q(3),
      I2 => \n_0_CALC_reg[31]\,
      I3 => Q(0),
      I4 => COMPUTE,
      I5 => \n_0_CALC_reg[22]\,
      O => \n_0_CALC[30]_i_1\
    );
\CALC[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"69AA"
    )
    port map (
      I0 => \n_0_CALC_reg[23]\,
      I1 => Q(2),
      I2 => \n_0_CALC_reg[29]\,
      I3 => COMPUTE,
      O => \n_0_CALC[31]_i_1\
    );
\CALC[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"005C"
    )
    port map (
      I0 => \n_0_CALC[3]_i_2__0\,
      I1 => Q(3),
      I2 => COMPUTE,
      I3 => I1(0),
      O => \n_0_CALC[3]_i_1__0\
    );
\CALC[3]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => Q(5),
      I1 => \n_0_CALC_reg[27]\,
      I2 => \n_0_CALC[1]_i_2\,
      I3 => \n_0_CALC[3]_i_3\,
      I4 => Q(6),
      I5 => \n_0_CALC_reg[26]\,
      O => \n_0_CALC[3]_i_2__0\
    );
\CALC[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_CALC_reg[25]\,
      I1 => Q(4),
      O => \n_0_CALC[3]_i_3\
    );
\CALC[4]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"96696996FFFF0000"
    )
    port map (
      I0 => Q(7),
      I1 => \n_0_CALC[0]_i_2__0\,
      I2 => \n_0_CALC[10]_i_4\,
      I3 => \n_0_CALC[4]_i_2__0\,
      I4 => Q(4),
      I5 => COMPUTE,
      O => \n_0_CALC[4]_i_1__0\
    );
\CALC[4]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => Q(3),
      I1 => \n_0_CALC_reg[28]\,
      O => \n_0_CALC[4]_i_2__0\
    );
\CALC[5]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E22E2EE22EE2E22E"
    )
    port map (
      I0 => Q(5),
      I1 => COMPUTE,
      I2 => \n_0_CALC[5]_i_2\,
      I3 => \n_0_CALC[26]_i_2__0\,
      I4 => \n_0_CALC[1]_i_2\,
      I5 => \n_0_CALC[10]_i_3__0\,
      O => \n_0_CALC[5]_i_1__0\
    );
\CALC[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
    port map (
      I0 => Q(4),
      I1 => \n_0_CALC_reg[25]\,
      I2 => Q(7),
      I3 => Q(6),
      I4 => DATA_OUT0,
      I5 => \n_0_CALC_reg[27]\,
      O => \n_0_CALC[5]_i_2\
    );
\CALC[6]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AA6A66AA66A6AA6"
    )
    port map (
      I0 => Q(6),
      I1 => COMPUTE,
      I2 => \n_0_CALC[6]_i_2\,
      I3 => \n_0_CALC_reg[26]\,
      I4 => Q(5),
      I5 => \n_0_CALC_reg[25]\,
      O => \n_0_CALC[6]_i_1__0\
    );
\CALC[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
    port map (
      I0 => \n_0_CALC_reg[30]\,
      I1 => Q(1),
      I2 => \n_0_CALC[4]_i_2__0\,
      I3 => \n_0_CALC[1]_i_2\,
      I4 => Q(2),
      I5 => \n_0_CALC_reg[29]\,
      O => \n_0_CALC[6]_i_2\
    );
\CALC[7]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A66A6AA66AA6A66A"
    )
    port map (
      I0 => Q(7),
      I1 => COMPUTE,
      I2 => \n_0_CALC[1]_i_2\,
      I3 => \n_0_CALC[10]_i_4\,
      I4 => \n_0_CALC[10]_i_3__0\,
      I5 => Q(4),
      O => \n_0_CALC[7]_i_1__0\
    );
\CALC[8]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \n_0_CALC_reg[0]\,
      I1 => \n_0_CALC[11]_i_2\,
      O => \n_0_CALC[8]_i_1__0\
    );
\CALC[9]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000009696FF00"
    )
    port map (
      I0 => \n_0_CALC[9]_i_2__0\,
      I1 => \n_0_CALC[16]_i_2__0\,
      I2 => \n_0_CALC_reg[25]\,
      I3 => \n_0_CALC_reg[1]\,
      I4 => COMPUTE,
      I5 => I1(0),
      O => \n_0_CALC[9]_i_1__0\
    );
\CALC[9]_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => \n_0_CALC_reg[1]\,
      I1 => \n_0_CALC_reg[26]\,
      I2 => Q(5),
      I3 => Q(6),
      O => \n_0_CALC[9]_i_2__0\
    );
\CALC_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[0]_i_1__0\,
      Q => \n_0_CALC_reg[0]\,
      R => \<const0>\
    );
\CALC_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[10]_i_1__0\,
      Q => \n_0_CALC_reg[10]\,
      R => \<const0>\
    );
\CALC_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[11]_i_1\,
      Q => \n_0_CALC_reg[11]\,
      R => \<const0>\
    );
\CALC_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[12]_i_1\,
      Q => \n_0_CALC_reg[12]\,
      R => I1(0)
    );
\CALC_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[13]_i_1__0\,
      Q => \n_0_CALC_reg[13]\,
      R => I1(0)
    );
\CALC_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[14]_i_1__0\,
      Q => \n_0_CALC_reg[14]\,
      R => I1(0)
    );
\CALC_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[15]_i_1__0\,
      Q => \n_0_CALC_reg[15]\,
      R => I1(0)
    );
\CALC_reg[16]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[16]_i_1__0\,
      Q => \n_0_CALC_reg[16]\,
      R => \<const0>\
    );
\CALC_reg[17]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[17]_i_1__0\,
      Q => \n_0_CALC_reg[17]\,
      R => I1(0)
    );
\CALC_reg[18]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[18]_i_1__0\,
      Q => \n_0_CALC_reg[18]\,
      R => \<const0>\
    );
\CALC_reg[19]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[19]_i_1__0\,
      Q => \n_0_CALC_reg[19]\,
      R => I1(0)
    );
\CALC_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[1]_i_1__0\,
      Q => \n_0_CALC_reg[1]\,
      R => \<const0>\
    );
\CALC_reg[20]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[20]_i_1__0\,
      Q => \n_0_CALC_reg[20]\,
      R => I1(0)
    );
\CALC_reg[21]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[21]_i_1__0\,
      Q => \n_0_CALC_reg[21]\,
      R => I1(0)
    );
\CALC_reg[22]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[22]_i_1__0\,
      Q => \n_0_CALC_reg[22]\,
      R => I1(0)
    );
\CALC_reg[23]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[23]_i_1__0\,
      Q => \n_0_CALC_reg[23]\,
      R => I1(0)
    );
\CALC_reg[24]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[24]_i_1__0\,
      Q => DATA_OUT0,
      R => I1(0)
    );
\CALC_reg[25]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[25]_i_1__0\,
      Q => \n_0_CALC_reg[25]\,
      R => I1(0)
    );
\CALC_reg[26]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[26]_i_1__0\,
      Q => \n_0_CALC_reg[26]\,
      R => I1(0)
    );
\CALC_reg[27]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[27]_i_1\,
      Q => \n_0_CALC_reg[27]\,
      R => \<const0>\
    );
\CALC_reg[28]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[28]_i_1__0\,
      Q => \n_0_CALC_reg[28]\,
      R => \<const0>\
    );
\CALC_reg[29]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[29]_i_2__0\,
      Q => \n_0_CALC_reg[29]\,
      R => \<const0>\
    );
\CALC_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[2]_i_1__0\,
      Q => \n_0_CALC_reg[2]\,
      R => \<const0>\
    );
\CALC_reg[30]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[30]_i_1\,
      Q => \n_0_CALC_reg[30]\,
      R => I1(0)
    );
\CALC_reg[31]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[31]_i_1\,
      Q => \n_0_CALC_reg[31]\,
      R => I1(0)
    );
\CALC_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[3]_i_1__0\,
      Q => \n_0_CALC_reg[3]\,
      R => \<const0>\
    );
\CALC_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[4]_i_1__0\,
      Q => \n_0_CALC_reg[4]\,
      R => I1(0)
    );
\CALC_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[5]_i_1__0\,
      Q => \n_0_CALC_reg[5]\,
      R => I1(0)
    );
\CALC_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[6]_i_1__0\,
      Q => \n_0_CALC_reg[6]\,
      R => I1(0)
    );
\CALC_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[7]_i_1__0\,
      Q => \n_0_CALC_reg[7]\,
      R => I1(0)
    );
\CALC_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[8]_i_1__0\,
      Q => \n_0_CALC_reg[8]\,
      R => I1(0)
    );
\CALC_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I18,
      D => \n_0_CALC[9]_i_1__0\,
      Q => \n_0_CALC_reg[9]\,
      R => \<const0>\
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\txd_reg1[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_CALC_reg[31]\,
      I1 => CRC,
      I2 => Q(0),
      O => D(0)
    );
\txd_reg1[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_CALC_reg[30]\,
      I1 => CRC,
      I2 => Q(1),
      O => D(1)
    );
\txd_reg1[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_CALC_reg[29]\,
      I1 => CRC,
      I2 => Q(2),
      O => D(2)
    );
\txd_reg1[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_CALC_reg[28]\,
      I1 => CRC,
      I2 => Q(3),
      O => D(3)
    );
\txd_reg1[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_CALC_reg[27]\,
      I1 => CRC,
      I2 => Q(4),
      O => D(4)
    );
\txd_reg1[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_CALC_reg[26]\,
      I1 => CRC,
      I2 => Q(5),
      O => D(5)
    );
\txd_reg1[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \n_0_CALC_reg[25]\,
      I1 => CRC,
      I2 => Q(6),
      O => D(6)
    );
\txd_reg1[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => DATA_OUT0,
      I1 => CRC,
      I2 => Q(7),
      O => D(7)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACDECODE_FRAME is
  port (
    DATA_WITH_FCS : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 17 downto 0 );
    LESS_THAN_256 : out STD_LOGIC;
    LENGTH_ONE : out STD_LOGIC;
    LENGTH_ZERO : out STD_LOGIC;
    DATA_NO_FCS : out STD_LOGIC;
    COMPUTE : out STD_LOGIC;
    CONTROL_MATCH : out STD_LOGIC;
    CONTROL_FRAME_INT : out STD_LOGIC;
    int_rx_control_frame : out STD_LOGIC;
    MULTICAST_MATCH : out STD_LOGIC;
    LENGTH_FIELD_MATCH : out STD_LOGIC;
    TYPE_FRAME : out STD_LOGIC;
    rx_statistics_vector : out STD_LOGIC_VECTOR ( 0 to 0 );
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    DATA_VALID_FINAL0 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    O6 : out STD_LOGIC;
    MAX_LENGTH_ERR3_out : out STD_LOGIC;
    O7 : out STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC;
    DATA_WITH_FCS0 : in STD_LOGIC;
    I1 : in STD_LOGIC;
    LESS_THAN_2560 : in STD_LOGIC;
    RX_DV_REG7 : in STD_LOGIC;
    LENGTH_ONE0 : in STD_LOGIC;
    LENGTH_ZERO0 : in STD_LOGIC;
    DATA_NO_FCS0 : in STD_LOGIC;
    CRC_COMPUTE0 : in STD_LOGIC;
    CONTROL_MATCH0 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    I5 : in STD_LOGIC;
    I6 : in STD_LOGIC;
    I7 : in STD_LOGIC;
    I8 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 7 downto 0 );
    I9 : in STD_LOGIC;
    EXTENSION_FIELD : in STD_LOGIC;
    I10 : in STD_LOGIC;
    I11 : in STD_LOGIC_VECTOR ( 14 downto 0 );
    I12 : in STD_LOGIC;
    LT_CHECK_HELD : in STD_LOGIC;
    PAUSE_LT_CHECK_HELD : in STD_LOGIC;
    EXCEEDED_MIN_LEN : in STD_LOGIC;
    I13 : in STD_LOGIC;
    address_valid_early : in STD_LOGIC;
    VALIDATE_REQUIRED : in STD_LOGIC;
    DATA_FIELD : in STD_LOGIC;
    I14 : in STD_LOGIC;
    pauseaddressmatch : in STD_LOGIC;
    specialpauseaddressmatch : in STD_LOGIC;
    I15 : in STD_LOGIC;
    rx_enable_reg : in STD_LOGIC;
    I16 : in STD_LOGIC;
    END_OF_DATA : in STD_LOGIC;
    I17 : in STD_LOGIC;
    I18 : in STD_LOGIC_VECTOR ( 0 to 0 );
    FIELD_COUNTER : in STD_LOGIC_VECTOR ( 0 to 0 );
    LENGTH_FIELD : in STD_LOGIC;
    I19 : in STD_LOGIC;
    TYPE_PACKET10_out : in STD_LOGIC;
    I20 : in STD_LOGIC;
    I21 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I22 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end TriMACDECODE_FRAME;

architecture STRUCTURE of TriMACDECODE_FRAME is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal ADD_CONTROL_ENABLE : STD_LOGIC;
  signal ADD_CONTROL_FRAME_INT : STD_LOGIC;
  signal \^control_frame_int\ : STD_LOGIC;
  signal \^control_match\ : STD_LOGIC;
  signal \^d\ : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal \DATA_COUNTER_reg__0\ : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal \^data_no_fcs\ : STD_LOGIC;
  signal \^data_with_fcs\ : STD_LOGIC;
  signal EQUAL : STD_LOGIC;
  signal \FRAME_CHECKER/MAX_LENGTH_ERR21_in\ : STD_LOGIC;
  signal FRAME_COUNTER : STD_LOGIC_VECTOR ( 14 to 14 );
  signal \FRAME_COUNTER__0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal FRAME_COUNTER_reg : STD_LOGIC_VECTOR ( 13 downto 8 );
  signal \^length_field_match\ : STD_LOGIC;
  signal LENGTH_TYPE : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal \^length_zero\ : STD_LOGIC;
  signal \^less_than_256\ : STD_LOGIC;
  signal \^multicast_match\ : STD_LOGIC;
  signal \^o2\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC;
  signal \^o4\ : STD_LOGIC;
  signal PADDED_FRAME : STD_LOGIC;
  signal RX_DV_REG : STD_LOGIC;
  signal \^type_frame\ : STD_LOGIC;
  signal VLAN_MATCH : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^int_rx_control_frame\ : STD_LOGIC;
  signal n_0_ADD_CONTROL_ENABLE_i_1 : STD_LOGIC;
  signal n_0_ADD_CONTROL_ENABLE_i_2 : STD_LOGIC;
  signal \n_0_DATA_COUNTER[10]_i_4\ : STD_LOGIC;
  signal n_0_DATA_VALID_i_1 : STD_LOGIC;
  signal n_0_DATA_VALID_reg : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[0]_i_3\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[0]_i_4\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[0]_i_5\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[0]_i_6\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[12]_i_2\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[12]_i_3\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[12]_i_4\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[4]_i_2\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[4]_i_3\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[4]_i_4\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[4]_i_5\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[8]_i_2\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[8]_i_3\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[8]_i_4\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER[8]_i_5\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER_reg[0]_i_2\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER_reg[4]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNTER_reg[8]_i_1\ : STD_LOGIC;
  signal n_0_FRAME_LEN_ERR_i_3 : STD_LOGIC;
  signal n_0_LENGTH_MATCH_i_1 : STD_LOGIC;
  signal n_0_LENGTH_MATCH_i_3 : STD_LOGIC;
  signal n_0_LENGTH_MATCH_i_4 : STD_LOGIC;
  signal n_0_LENGTH_MATCH_i_5 : STD_LOGIC;
  signal n_0_LENGTH_MATCH_i_6 : STD_LOGIC;
  signal \n_0_LENGTH_TYPE[0]_i_1\ : STD_LOGIC;
  signal \n_0_LENGTH_TYPE[10]_i_1\ : STD_LOGIC;
  signal \n_0_LENGTH_TYPE[1]_i_1\ : STD_LOGIC;
  signal \n_0_LENGTH_TYPE[2]_i_1\ : STD_LOGIC;
  signal \n_0_LENGTH_TYPE[3]_i_1\ : STD_LOGIC;
  signal \n_0_LENGTH_TYPE[4]_i_1\ : STD_LOGIC;
  signal \n_0_LENGTH_TYPE[5]_i_1\ : STD_LOGIC;
  signal \n_0_LENGTH_TYPE[6]_i_1\ : STD_LOGIC;
  signal \n_0_LENGTH_TYPE[7]_i_1\ : STD_LOGIC;
  signal \n_0_LENGTH_TYPE[8]_i_1\ : STD_LOGIC;
  signal \n_0_LENGTH_TYPE[9]_i_1\ : STD_LOGIC;
  signal n_0_MAX_LENGTH_ERR_i_10 : STD_LOGIC;
  signal n_0_MAX_LENGTH_ERR_i_4 : STD_LOGIC;
  signal n_0_MAX_LENGTH_ERR_i_5 : STD_LOGIC;
  signal n_0_MAX_LENGTH_ERR_i_6 : STD_LOGIC;
  signal n_0_MAX_LENGTH_ERR_i_7 : STD_LOGIC;
  signal n_0_MAX_LENGTH_ERR_i_8 : STD_LOGIC;
  signal n_0_MAX_LENGTH_ERR_i_9 : STD_LOGIC;
  signal n_0_MIN_LENGTH_MATCH_i_2 : STD_LOGIC;
  signal n_0_PADDED_FRAME_i_1 : STD_LOGIC;
  signal n_0_PADDED_FRAME_i_2 : STD_LOGIC;
  signal n_0_PADDED_FRAME_i_3 : STD_LOGIC;
  signal \n_0_STATISTICS_LENGTH[13]_i_1\ : STD_LOGIC;
  signal \n_0_VLAN_MATCH[1]_i_1\ : STD_LOGIC;
  signal \n_0_VLAN_MATCH[1]_i_2\ : STD_LOGIC;
  signal \n_0_VLAN_MATCH_reg[1]\ : STD_LOGIC;
  signal \n_1_FRAME_COUNTER_reg[0]_i_2\ : STD_LOGIC;
  signal \n_1_FRAME_COUNTER_reg[4]_i_1\ : STD_LOGIC;
  signal \n_1_FRAME_COUNTER_reg[8]_i_1\ : STD_LOGIC;
  signal n_1_LENGTH_MATCH_reg_i_2 : STD_LOGIC;
  signal n_1_MAX_LENGTH_ERR_reg_i_3 : STD_LOGIC;
  signal \n_2_FRAME_COUNTER_reg[0]_i_2\ : STD_LOGIC;
  signal \n_2_FRAME_COUNTER_reg[12]_i_1\ : STD_LOGIC;
  signal \n_2_FRAME_COUNTER_reg[4]_i_1\ : STD_LOGIC;
  signal \n_2_FRAME_COUNTER_reg[8]_i_1\ : STD_LOGIC;
  signal n_2_LENGTH_MATCH_reg_i_2 : STD_LOGIC;
  signal n_2_MAX_LENGTH_ERR_reg_i_3 : STD_LOGIC;
  signal \n_3_FRAME_COUNTER_reg[0]_i_2\ : STD_LOGIC;
  signal \n_3_FRAME_COUNTER_reg[12]_i_1\ : STD_LOGIC;
  signal \n_3_FRAME_COUNTER_reg[4]_i_1\ : STD_LOGIC;
  signal \n_3_FRAME_COUNTER_reg[8]_i_1\ : STD_LOGIC;
  signal n_3_LENGTH_MATCH_reg_i_2 : STD_LOGIC;
  signal n_3_MAX_LENGTH_ERR_reg_i_3 : STD_LOGIC;
  signal \n_4_FRAME_COUNTER_reg[0]_i_2\ : STD_LOGIC;
  signal \n_4_FRAME_COUNTER_reg[4]_i_1\ : STD_LOGIC;
  signal \n_4_FRAME_COUNTER_reg[8]_i_1\ : STD_LOGIC;
  signal \n_5_FRAME_COUNTER_reg[0]_i_2\ : STD_LOGIC;
  signal \n_5_FRAME_COUNTER_reg[12]_i_1\ : STD_LOGIC;
  signal \n_5_FRAME_COUNTER_reg[4]_i_1\ : STD_LOGIC;
  signal \n_5_FRAME_COUNTER_reg[8]_i_1\ : STD_LOGIC;
  signal \n_6_FRAME_COUNTER_reg[0]_i_2\ : STD_LOGIC;
  signal \n_6_FRAME_COUNTER_reg[12]_i_1\ : STD_LOGIC;
  signal \n_6_FRAME_COUNTER_reg[4]_i_1\ : STD_LOGIC;
  signal \n_6_FRAME_COUNTER_reg[8]_i_1\ : STD_LOGIC;
  signal \n_7_FRAME_COUNTER_reg[0]_i_2\ : STD_LOGIC;
  signal \n_7_FRAME_COUNTER_reg[12]_i_1\ : STD_LOGIC;
  signal \n_7_FRAME_COUNTER_reg[4]_i_1\ : STD_LOGIC;
  signal \n_7_FRAME_COUNTER_reg[8]_i_1\ : STD_LOGIC;
  signal \p_0_in__1\ : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal \NLW_FRAME_COUNTER_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_FRAME_COUNTER_reg[12]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_LENGTH_MATCH_reg_i_2_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_MAX_LENGTH_ERR_reg_i_3_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of CONTROL_FRAME_INT_i_2 : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \DATA_COUNTER[1]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \DATA_COUNTER[2]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \DATA_COUNTER[3]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \DATA_COUNTER[4]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \DATA_COUNTER[6]_i_1\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \DATA_COUNTER[7]_i_1\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \DATA_COUNTER[8]_i_1\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \DATA_COUNTER[9]_i_1\ : label is "soft_lutpair84";
  attribute counter : integer;
  attribute counter of \DATA_COUNTER_reg[0]\ : label is 11;
  attribute counter of \DATA_COUNTER_reg[10]\ : label is 11;
  attribute counter of \DATA_COUNTER_reg[1]\ : label is 11;
  attribute counter of \DATA_COUNTER_reg[2]\ : label is 11;
  attribute counter of \DATA_COUNTER_reg[3]\ : label is 11;
  attribute counter of \DATA_COUNTER_reg[4]\ : label is 11;
  attribute counter of \DATA_COUNTER_reg[5]\ : label is 11;
  attribute counter of \DATA_COUNTER_reg[6]\ : label is 11;
  attribute counter of \DATA_COUNTER_reg[7]\ : label is 11;
  attribute counter of \DATA_COUNTER_reg[8]\ : label is 11;
  attribute counter of \DATA_COUNTER_reg[9]\ : label is 11;
  attribute counter of \FRAME_COUNTER_reg[0]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[10]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[11]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[12]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[13]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[14]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[1]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[2]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[3]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[4]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[5]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[6]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[7]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[8]\ : label is 10;
  attribute counter of \FRAME_COUNTER_reg[9]\ : label is 10;
  attribute SOFT_HLUTNM of LENGTH_ONE_i_2 : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of LENGTH_ONE_i_3 : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of LESS_THAN_256_i_2 : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of PADDED_FRAME_i_2 : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of PADDED_FRAME_i_3 : label is "soft_lutpair85";
begin
  CONTROL_FRAME_INT <= \^control_frame_int\;
  CONTROL_MATCH <= \^control_match\;
  D(17 downto 0) <= \^d\(17 downto 0);
  DATA_NO_FCS <= \^data_no_fcs\;
  DATA_WITH_FCS <= \^data_with_fcs\;
  LENGTH_FIELD_MATCH <= \^length_field_match\;
  LENGTH_ZERO <= \^length_zero\;
  LESS_THAN_256 <= \^less_than_256\;
  MULTICAST_MATCH <= \^multicast_match\;
  O2 <= \^o2\;
  O3 <= \^o3\;
  O4 <= \^o4\;
  TYPE_FRAME <= \^type_frame\;
  int_rx_control_frame <= \^int_rx_control_frame\;
ADD_CONTROL_ENABLE_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"080A0A0A"
    )
    port map (
      I0 => n_0_ADD_CONTROL_ENABLE_i_2,
      I1 => \^control_match\,
      I2 => SR(0),
      I3 => I10,
      I4 => I2,
      O => n_0_ADD_CONTROL_ENABLE_i_1
    );
ADD_CONTROL_ENABLE_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8FFFFFFA8000000"
    )
    port map (
      I0 => \^o4\,
      I1 => pauseaddressmatch,
      I2 => specialpauseaddressmatch,
      I3 => I2,
      I4 => \^control_match\,
      I5 => ADD_CONTROL_ENABLE,
      O => n_0_ADD_CONTROL_ENABLE_i_2
    );
ADD_CONTROL_ENABLE_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_ADD_CONTROL_ENABLE_i_1,
      Q => ADD_CONTROL_ENABLE,
      R => \<const0>\
    );
ADD_CONTROL_FRAME_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => ADD_CONTROL_ENABLE,
      Q => ADD_CONTROL_FRAME_INT,
      R => SR(0)
    );
ADD_CONTROL_FRAME_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => ADD_CONTROL_FRAME_INT,
      Q => \^int_rx_control_frame\,
      R => SR(0)
    );
CONTROL_FRAME_INT_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000010"
    )
    port map (
      I0 => \^o3\,
      I1 => Q(1),
      I2 => Q(3),
      I3 => Q(0),
      I4 => Q(2),
      O => \^o4\
    );
CONTROL_FRAME_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => I4,
      Q => \^control_frame_int\,
      R => \<const0>\
    );
CONTROL_FRAME_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \^control_frame_int\,
      Q => \^d\(15),
      R => SR(0)
    );
CONTROL_MATCH_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => CONTROL_MATCH0,
      Q => \^control_match\,
      R => SR(0)
    );
COUNT_THIS_BYTE_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \^data_with_fcs\,
      Q => \^d\(17),
      R => \<const0>\
    );
CRC_COMPUTE_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => CRC_COMPUTE0,
      Q => COMPUTE,
      R => SR(0)
    );
\DATA_COUNTER[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(0),
      O => \p_0_in__1\(0)
    );
\DATA_COUNTER[10]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(10),
      I1 => \DATA_COUNTER_reg__0\(6),
      I2 => \n_0_DATA_COUNTER[10]_i_4\,
      I3 => \DATA_COUNTER_reg__0\(7),
      I4 => \DATA_COUNTER_reg__0\(8),
      I5 => \DATA_COUNTER_reg__0\(9),
      O => \p_0_in__1\(10)
    );
\DATA_COUNTER[10]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(3),
      I1 => \DATA_COUNTER_reg__0\(0),
      I2 => \DATA_COUNTER_reg__0\(1),
      I3 => \DATA_COUNTER_reg__0\(2),
      I4 => \DATA_COUNTER_reg__0\(4),
      I5 => \DATA_COUNTER_reg__0\(5),
      O => \n_0_DATA_COUNTER[10]_i_4\
    );
\DATA_COUNTER[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(0),
      I1 => \DATA_COUNTER_reg__0\(1),
      O => \p_0_in__1\(1)
    );
\DATA_COUNTER[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(2),
      I1 => \DATA_COUNTER_reg__0\(1),
      I2 => \DATA_COUNTER_reg__0\(0),
      O => \p_0_in__1\(2)
    );
\DATA_COUNTER[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(3),
      I1 => \DATA_COUNTER_reg__0\(0),
      I2 => \DATA_COUNTER_reg__0\(1),
      I3 => \DATA_COUNTER_reg__0\(2),
      O => \p_0_in__1\(3)
    );
\DATA_COUNTER[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(4),
      I1 => \DATA_COUNTER_reg__0\(2),
      I2 => \DATA_COUNTER_reg__0\(1),
      I3 => \DATA_COUNTER_reg__0\(0),
      I4 => \DATA_COUNTER_reg__0\(3),
      O => \p_0_in__1\(4)
    );
\DATA_COUNTER[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(5),
      I1 => \DATA_COUNTER_reg__0\(3),
      I2 => \DATA_COUNTER_reg__0\(0),
      I3 => \DATA_COUNTER_reg__0\(1),
      I4 => \DATA_COUNTER_reg__0\(2),
      I5 => \DATA_COUNTER_reg__0\(4),
      O => \p_0_in__1\(5)
    );
\DATA_COUNTER[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(6),
      I1 => \n_0_DATA_COUNTER[10]_i_4\,
      O => \p_0_in__1\(6)
    );
\DATA_COUNTER[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(7),
      I1 => \n_0_DATA_COUNTER[10]_i_4\,
      I2 => \DATA_COUNTER_reg__0\(6),
      O => \p_0_in__1\(7)
    );
\DATA_COUNTER[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(8),
      I1 => \DATA_COUNTER_reg__0\(6),
      I2 => \n_0_DATA_COUNTER[10]_i_4\,
      I3 => \DATA_COUNTER_reg__0\(7),
      O => \p_0_in__1\(8)
    );
\DATA_COUNTER[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => \DATA_COUNTER_reg__0\(9),
      I1 => \DATA_COUNTER_reg__0\(8),
      I2 => \DATA_COUNTER_reg__0\(7),
      I3 => \n_0_DATA_COUNTER[10]_i_4\,
      I4 => \DATA_COUNTER_reg__0\(6),
      O => \p_0_in__1\(9)
    );
\DATA_COUNTER_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I22(0),
      D => \p_0_in__1\(0),
      Q => \DATA_COUNTER_reg__0\(0),
      R => I21(0)
    );
\DATA_COUNTER_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I22(0),
      D => \p_0_in__1\(10),
      Q => \DATA_COUNTER_reg__0\(10),
      R => I21(0)
    );
\DATA_COUNTER_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I22(0),
      D => \p_0_in__1\(1),
      Q => \DATA_COUNTER_reg__0\(1),
      R => I21(0)
    );
\DATA_COUNTER_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I22(0),
      D => \p_0_in__1\(2),
      Q => \DATA_COUNTER_reg__0\(2),
      R => I21(0)
    );
\DATA_COUNTER_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I22(0),
      D => \p_0_in__1\(3),
      Q => \DATA_COUNTER_reg__0\(3),
      R => I21(0)
    );
\DATA_COUNTER_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I22(0),
      D => \p_0_in__1\(4),
      Q => \DATA_COUNTER_reg__0\(4),
      R => I21(0)
    );
\DATA_COUNTER_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I22(0),
      D => \p_0_in__1\(5),
      Q => \DATA_COUNTER_reg__0\(5),
      R => I21(0)
    );
\DATA_COUNTER_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I22(0),
      D => \p_0_in__1\(6),
      Q => \DATA_COUNTER_reg__0\(6),
      R => I21(0)
    );
\DATA_COUNTER_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I22(0),
      D => \p_0_in__1\(7),
      Q => \DATA_COUNTER_reg__0\(7),
      R => I21(0)
    );
\DATA_COUNTER_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I22(0),
      D => \p_0_in__1\(8),
      Q => \DATA_COUNTER_reg__0\(8),
      R => I21(0)
    );
\DATA_COUNTER_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I22(0),
      D => \p_0_in__1\(9),
      Q => \DATA_COUNTER_reg__0\(9),
      R => I21(0)
    );
DATA_NO_FCS_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => DATA_NO_FCS0,
      Q => \^data_no_fcs\,
      R => SR(0)
    );
DATA_VALID_FINAL_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => n_0_DATA_VALID_reg,
      I1 => address_valid_early,
      I2 => VALIDATE_REQUIRED,
      O => DATA_VALID_FINAL0
    );
DATA_VALID_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888888B88888888"
    )
    port map (
      I0 => \^data_with_fcs\,
      I1 => I9,
      I2 => EXTENSION_FIELD,
      I3 => I10,
      I4 => \^length_zero\,
      I5 => \^data_no_fcs\,
      O => n_0_DATA_VALID_i_1
    );
DATA_VALID_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => n_0_DATA_VALID_i_1,
      Q => n_0_DATA_VALID_reg,
      R => SR(0)
    );
DATA_WITH_FCS_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => DATA_WITH_FCS0,
      Q => \^data_with_fcs\,
      R => SR(0)
    );
\FRAME_COUNTER[0]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(3),
      O => \n_0_FRAME_COUNTER[0]_i_3\
    );
\FRAME_COUNTER[0]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(2),
      O => \n_0_FRAME_COUNTER[0]_i_4\
    );
\FRAME_COUNTER[0]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(1),
      O => \n_0_FRAME_COUNTER[0]_i_5\
    );
\FRAME_COUNTER[0]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(0),
      O => \n_0_FRAME_COUNTER[0]_i_6\
    );
\FRAME_COUNTER[12]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => FRAME_COUNTER(14),
      O => \n_0_FRAME_COUNTER[12]_i_2\
    );
\FRAME_COUNTER[12]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => FRAME_COUNTER_reg(13),
      O => \n_0_FRAME_COUNTER[12]_i_3\
    );
\FRAME_COUNTER[12]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => FRAME_COUNTER_reg(12),
      O => \n_0_FRAME_COUNTER[12]_i_4\
    );
\FRAME_COUNTER[4]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(7),
      O => \n_0_FRAME_COUNTER[4]_i_2\
    );
\FRAME_COUNTER[4]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(6),
      O => \n_0_FRAME_COUNTER[4]_i_3\
    );
\FRAME_COUNTER[4]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(5),
      O => \n_0_FRAME_COUNTER[4]_i_4\
    );
\FRAME_COUNTER[4]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(4),
      O => \n_0_FRAME_COUNTER[4]_i_5\
    );
\FRAME_COUNTER[8]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => FRAME_COUNTER_reg(11),
      O => \n_0_FRAME_COUNTER[8]_i_2\
    );
\FRAME_COUNTER[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => FRAME_COUNTER_reg(10),
      O => \n_0_FRAME_COUNTER[8]_i_3\
    );
\FRAME_COUNTER[8]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => FRAME_COUNTER_reg(9),
      O => \n_0_FRAME_COUNTER[8]_i_4\
    );
\FRAME_COUNTER[8]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => FRAME_COUNTER_reg(8),
      O => \n_0_FRAME_COUNTER[8]_i_5\
    );
\FRAME_COUNTER_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_7_FRAME_COUNTER_reg[0]_i_2\,
      Q => \FRAME_COUNTER__0\(0),
      R => I20
    );
\FRAME_COUNTER_reg[0]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_FRAME_COUNTER_reg[0]_i_2\,
      CO(2) => \n_1_FRAME_COUNTER_reg[0]_i_2\,
      CO(1) => \n_2_FRAME_COUNTER_reg[0]_i_2\,
      CO(0) => \n_3_FRAME_COUNTER_reg[0]_i_2\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const1>\,
      O(3) => \n_4_FRAME_COUNTER_reg[0]_i_2\,
      O(2) => \n_5_FRAME_COUNTER_reg[0]_i_2\,
      O(1) => \n_6_FRAME_COUNTER_reg[0]_i_2\,
      O(0) => \n_7_FRAME_COUNTER_reg[0]_i_2\,
      S(3) => \n_0_FRAME_COUNTER[0]_i_3\,
      S(2) => \n_0_FRAME_COUNTER[0]_i_4\,
      S(1) => \n_0_FRAME_COUNTER[0]_i_5\,
      S(0) => \n_0_FRAME_COUNTER[0]_i_6\
    );
\FRAME_COUNTER_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_5_FRAME_COUNTER_reg[8]_i_1\,
      Q => FRAME_COUNTER_reg(10),
      R => I20
    );
\FRAME_COUNTER_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_4_FRAME_COUNTER_reg[8]_i_1\,
      Q => FRAME_COUNTER_reg(11),
      R => I20
    );
\FRAME_COUNTER_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_7_FRAME_COUNTER_reg[12]_i_1\,
      Q => FRAME_COUNTER_reg(12),
      R => I20
    );
\FRAME_COUNTER_reg[12]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FRAME_COUNTER_reg[8]_i_1\,
      CO(3 downto 2) => \NLW_FRAME_COUNTER_reg[12]_i_1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \n_2_FRAME_COUNTER_reg[12]_i_1\,
      CO(0) => \n_3_FRAME_COUNTER_reg[12]_i_1\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \NLW_FRAME_COUNTER_reg[12]_i_1_O_UNCONNECTED\(3),
      O(2) => \n_5_FRAME_COUNTER_reg[12]_i_1\,
      O(1) => \n_6_FRAME_COUNTER_reg[12]_i_1\,
      O(0) => \n_7_FRAME_COUNTER_reg[12]_i_1\,
      S(3) => \<const0>\,
      S(2) => \n_0_FRAME_COUNTER[12]_i_2\,
      S(1) => \n_0_FRAME_COUNTER[12]_i_3\,
      S(0) => \n_0_FRAME_COUNTER[12]_i_4\
    );
\FRAME_COUNTER_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_6_FRAME_COUNTER_reg[12]_i_1\,
      Q => FRAME_COUNTER_reg(13),
      R => I20
    );
\FRAME_COUNTER_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_5_FRAME_COUNTER_reg[12]_i_1\,
      Q => FRAME_COUNTER(14),
      R => I20
    );
\FRAME_COUNTER_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_6_FRAME_COUNTER_reg[0]_i_2\,
      Q => \FRAME_COUNTER__0\(1),
      R => I20
    );
\FRAME_COUNTER_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_5_FRAME_COUNTER_reg[0]_i_2\,
      Q => \FRAME_COUNTER__0\(2),
      R => I20
    );
\FRAME_COUNTER_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_4_FRAME_COUNTER_reg[0]_i_2\,
      Q => \FRAME_COUNTER__0\(3),
      R => I20
    );
\FRAME_COUNTER_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_7_FRAME_COUNTER_reg[4]_i_1\,
      Q => \FRAME_COUNTER__0\(4),
      R => I20
    );
\FRAME_COUNTER_reg[4]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FRAME_COUNTER_reg[0]_i_2\,
      CO(3) => \n_0_FRAME_COUNTER_reg[4]_i_1\,
      CO(2) => \n_1_FRAME_COUNTER_reg[4]_i_1\,
      CO(1) => \n_2_FRAME_COUNTER_reg[4]_i_1\,
      CO(0) => \n_3_FRAME_COUNTER_reg[4]_i_1\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_FRAME_COUNTER_reg[4]_i_1\,
      O(2) => \n_5_FRAME_COUNTER_reg[4]_i_1\,
      O(1) => \n_6_FRAME_COUNTER_reg[4]_i_1\,
      O(0) => \n_7_FRAME_COUNTER_reg[4]_i_1\,
      S(3) => \n_0_FRAME_COUNTER[4]_i_2\,
      S(2) => \n_0_FRAME_COUNTER[4]_i_3\,
      S(1) => \n_0_FRAME_COUNTER[4]_i_4\,
      S(0) => \n_0_FRAME_COUNTER[4]_i_5\
    );
\FRAME_COUNTER_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_6_FRAME_COUNTER_reg[4]_i_1\,
      Q => \FRAME_COUNTER__0\(5),
      R => I20
    );
\FRAME_COUNTER_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_5_FRAME_COUNTER_reg[4]_i_1\,
      Q => \FRAME_COUNTER__0\(6),
      R => I20
    );
\FRAME_COUNTER_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_4_FRAME_COUNTER_reg[4]_i_1\,
      Q => \FRAME_COUNTER__0\(7),
      R => I20
    );
\FRAME_COUNTER_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_7_FRAME_COUNTER_reg[8]_i_1\,
      Q => FRAME_COUNTER_reg(8),
      R => I20
    );
\FRAME_COUNTER_reg[8]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FRAME_COUNTER_reg[4]_i_1\,
      CO(3) => \n_0_FRAME_COUNTER_reg[8]_i_1\,
      CO(2) => \n_1_FRAME_COUNTER_reg[8]_i_1\,
      CO(1) => \n_2_FRAME_COUNTER_reg[8]_i_1\,
      CO(0) => \n_3_FRAME_COUNTER_reg[8]_i_1\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \n_4_FRAME_COUNTER_reg[8]_i_1\,
      O(2) => \n_5_FRAME_COUNTER_reg[8]_i_1\,
      O(1) => \n_6_FRAME_COUNTER_reg[8]_i_1\,
      O(0) => \n_7_FRAME_COUNTER_reg[8]_i_1\,
      S(3) => \n_0_FRAME_COUNTER[8]_i_2\,
      S(2) => \n_0_FRAME_COUNTER[8]_i_3\,
      S(1) => \n_0_FRAME_COUNTER[8]_i_4\,
      S(0) => \n_0_FRAME_COUNTER[8]_i_5\
    );
\FRAME_COUNTER_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \n_6_FRAME_COUNTER_reg[8]_i_1\,
      Q => FRAME_COUNTER_reg(9),
      R => I20
    );
FRAME_LEN_ERR_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFE0000FFFFFFFF"
    )
    port map (
      I0 => \^type_frame\,
      I1 => LT_CHECK_HELD,
      I2 => PADDED_FRAME,
      I3 => \^length_field_match\,
      I4 => n_0_FRAME_LEN_ERR_i_3,
      I5 => END_OF_DATA,
      O => O6
    );
FRAME_LEN_ERR_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D0DDFFFFD0DDD0DD"
    )
    port map (
      I0 => PADDED_FRAME,
      I1 => LT_CHECK_HELD,
      I2 => PAUSE_LT_CHECK_HELD,
      I3 => \^d\(15),
      I4 => EXCEEDED_MIN_LEN,
      I5 => I13,
      O => n_0_FRAME_LEN_ERR_i_3
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
LENGTH_MATCH_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000AAE2AA"
    )
    port map (
      I0 => \^length_field_match\,
      I1 => DATA_FIELD,
      I2 => EQUAL,
      I3 => I2,
      I4 => I10,
      I5 => SR(0),
      O => n_0_LENGTH_MATCH_i_1
    );
LENGTH_MATCH_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => LENGTH_TYPE(9),
      I1 => \DATA_COUNTER_reg__0\(9),
      I2 => LENGTH_TYPE(10),
      I3 => \DATA_COUNTER_reg__0\(10),
      O => n_0_LENGTH_MATCH_i_3
    );
LENGTH_MATCH_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => LENGTH_TYPE(8),
      I1 => \DATA_COUNTER_reg__0\(8),
      I2 => \DATA_COUNTER_reg__0\(6),
      I3 => LENGTH_TYPE(6),
      I4 => \DATA_COUNTER_reg__0\(7),
      I5 => LENGTH_TYPE(7),
      O => n_0_LENGTH_MATCH_i_4
    );
LENGTH_MATCH_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => LENGTH_TYPE(5),
      I1 => \DATA_COUNTER_reg__0\(5),
      I2 => \DATA_COUNTER_reg__0\(3),
      I3 => LENGTH_TYPE(3),
      I4 => \DATA_COUNTER_reg__0\(4),
      I5 => LENGTH_TYPE(4),
      O => n_0_LENGTH_MATCH_i_5
    );
LENGTH_MATCH_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => LENGTH_TYPE(0),
      I1 => \DATA_COUNTER_reg__0\(0),
      I2 => \DATA_COUNTER_reg__0\(1),
      I3 => LENGTH_TYPE(1),
      I4 => \DATA_COUNTER_reg__0\(2),
      I5 => LENGTH_TYPE(2),
      O => n_0_LENGTH_MATCH_i_6
    );
LENGTH_MATCH_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_LENGTH_MATCH_i_1,
      Q => \^length_field_match\,
      R => \<const0>\
    );
LENGTH_MATCH_reg_i_2: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => EQUAL,
      CO(2) => n_1_LENGTH_MATCH_reg_i_2,
      CO(1) => n_2_LENGTH_MATCH_reg_i_2,
      CO(0) => n_3_LENGTH_MATCH_reg_i_2,
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => NLW_LENGTH_MATCH_reg_i_2_O_UNCONNECTED(3 downto 0),
      S(3) => n_0_LENGTH_MATCH_i_3,
      S(2) => n_0_LENGTH_MATCH_i_4,
      S(1) => n_0_LENGTH_MATCH_i_5,
      S(0) => n_0_LENGTH_MATCH_i_6
    );
LENGTH_ONE_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => Q(1),
      I1 => Q(3),
      I2 => Q(0),
      I3 => Q(2),
      O => O1
    );
LENGTH_ONE_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => Q(4),
      I1 => Q(5),
      I2 => Q(6),
      I3 => Q(7),
      O => \^o3\
    );
LENGTH_ONE_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => LENGTH_ONE0,
      Q => LENGTH_ONE,
      R => SR(0)
    );
\LENGTH_TYPE[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFBFFF8FCF8"
    )
    port map (
      I0 => Q(0),
      I1 => I16,
      I2 => SR(0),
      I3 => I19,
      I4 => I2,
      I5 => LENGTH_TYPE(0),
      O => \n_0_LENGTH_TYPE[0]_i_1\
    );
\LENGTH_TYPE[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFEFFFFFEFEFCCC"
    )
    port map (
      I0 => Q(2),
      I1 => SR(0),
      I2 => I19,
      I3 => I2,
      I4 => TYPE_PACKET10_out,
      I5 => LENGTH_TYPE(10),
      O => \n_0_LENGTH_TYPE[10]_i_1\
    );
\LENGTH_TYPE[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFBFFF8FCF8"
    )
    port map (
      I0 => Q(1),
      I1 => I16,
      I2 => SR(0),
      I3 => I19,
      I4 => I2,
      I5 => LENGTH_TYPE(1),
      O => \n_0_LENGTH_TYPE[1]_i_1\
    );
\LENGTH_TYPE[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFBFFF8FCF8"
    )
    port map (
      I0 => Q(2),
      I1 => I16,
      I2 => SR(0),
      I3 => I19,
      I4 => I2,
      I5 => LENGTH_TYPE(2),
      O => \n_0_LENGTH_TYPE[2]_i_1\
    );
\LENGTH_TYPE[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFBFFF8FCF8"
    )
    port map (
      I0 => Q(3),
      I1 => I16,
      I2 => SR(0),
      I3 => I19,
      I4 => I2,
      I5 => LENGTH_TYPE(3),
      O => \n_0_LENGTH_TYPE[3]_i_1\
    );
\LENGTH_TYPE[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFBFFF8FCF8"
    )
    port map (
      I0 => Q(4),
      I1 => I16,
      I2 => SR(0),
      I3 => I19,
      I4 => I2,
      I5 => LENGTH_TYPE(4),
      O => \n_0_LENGTH_TYPE[4]_i_1\
    );
\LENGTH_TYPE[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFBFFF8FCF8"
    )
    port map (
      I0 => Q(5),
      I1 => I16,
      I2 => SR(0),
      I3 => I19,
      I4 => I2,
      I5 => LENGTH_TYPE(5),
      O => \n_0_LENGTH_TYPE[5]_i_1\
    );
\LENGTH_TYPE[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFBFFF8FCF8"
    )
    port map (
      I0 => Q(6),
      I1 => I16,
      I2 => SR(0),
      I3 => I19,
      I4 => I2,
      I5 => LENGTH_TYPE(6),
      O => \n_0_LENGTH_TYPE[6]_i_1\
    );
\LENGTH_TYPE[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFBFFF8FCF8"
    )
    port map (
      I0 => Q(7),
      I1 => I16,
      I2 => SR(0),
      I3 => I19,
      I4 => I2,
      I5 => LENGTH_TYPE(7),
      O => \n_0_LENGTH_TYPE[7]_i_1\
    );
\LENGTH_TYPE[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFEFFFFFEFEFCCC"
    )
    port map (
      I0 => Q(0),
      I1 => SR(0),
      I2 => I19,
      I3 => I2,
      I4 => TYPE_PACKET10_out,
      I5 => LENGTH_TYPE(8),
      O => \n_0_LENGTH_TYPE[8]_i_1\
    );
\LENGTH_TYPE[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFEFFFFFEFEFCCC"
    )
    port map (
      I0 => Q(1),
      I1 => SR(0),
      I2 => I19,
      I3 => I2,
      I4 => TYPE_PACKET10_out,
      I5 => LENGTH_TYPE(9),
      O => \n_0_LENGTH_TYPE[9]_i_1\
    );
\LENGTH_TYPE_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_LENGTH_TYPE[0]_i_1\,
      Q => LENGTH_TYPE(0),
      R => \<const0>\
    );
\LENGTH_TYPE_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_LENGTH_TYPE[10]_i_1\,
      Q => LENGTH_TYPE(10),
      R => \<const0>\
    );
\LENGTH_TYPE_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_LENGTH_TYPE[1]_i_1\,
      Q => LENGTH_TYPE(1),
      R => \<const0>\
    );
\LENGTH_TYPE_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_LENGTH_TYPE[2]_i_1\,
      Q => LENGTH_TYPE(2),
      R => \<const0>\
    );
\LENGTH_TYPE_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_LENGTH_TYPE[3]_i_1\,
      Q => LENGTH_TYPE(3),
      R => \<const0>\
    );
\LENGTH_TYPE_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_LENGTH_TYPE[4]_i_1\,
      Q => LENGTH_TYPE(4),
      R => \<const0>\
    );
\LENGTH_TYPE_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_LENGTH_TYPE[5]_i_1\,
      Q => LENGTH_TYPE(5),
      R => \<const0>\
    );
\LENGTH_TYPE_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_LENGTH_TYPE[6]_i_1\,
      Q => LENGTH_TYPE(6),
      R => \<const0>\
    );
\LENGTH_TYPE_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_LENGTH_TYPE[7]_i_1\,
      Q => LENGTH_TYPE(7),
      R => \<const0>\
    );
\LENGTH_TYPE_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_LENGTH_TYPE[8]_i_1\,
      Q => LENGTH_TYPE(8),
      R => \<const0>\
    );
\LENGTH_TYPE_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_LENGTH_TYPE[9]_i_1\,
      Q => LENGTH_TYPE(9),
      R => \<const0>\
    );
LENGTH_ZERO_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => LENGTH_ZERO0,
      Q => \^length_zero\,
      R => SR(0)
    );
LESS_THAN_256_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => \^o3\,
      I1 => Q(3),
      I2 => Q(1),
      I3 => Q(0),
      I4 => Q(2),
      O => \^o2\
    );
LESS_THAN_256_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => LESS_THAN_2560,
      Q => \^less_than_256\,
      R => SR(0)
    );
MAX_LENGTH_ERR_i_10: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(4),
      I1 => I11(4),
      I2 => \FRAME_COUNTER__0\(3),
      I3 => I11(3),
      I4 => I11(2),
      I5 => \FRAME_COUNTER__0\(2),
      O => n_0_MAX_LENGTH_ERR_i_10
    );
MAX_LENGTH_ERR_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => \FRAME_CHECKER/MAX_LENGTH_ERR21_in\,
      I1 => EXTENSION_FIELD,
      I2 => n_0_MAX_LENGTH_ERR_i_4,
      I3 => n_0_MAX_LENGTH_ERR_i_5,
      O => MAX_LENGTH_ERR3_out
    );
MAX_LENGTH_ERR_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF04FF00000400"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(2),
      I1 => \FRAME_COUNTER__0\(4),
      I2 => \FRAME_COUNTER__0\(3),
      I3 => \^d\(16),
      I4 => I12,
      I5 => n_0_MAX_LENGTH_ERR_i_10,
      O => n_0_MAX_LENGTH_ERR_i_4
    );
MAX_LENGTH_ERR_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"82000082"
    )
    port map (
      I0 => I2,
      I1 => \FRAME_COUNTER__0\(1),
      I2 => I11(1),
      I3 => \FRAME_COUNTER__0\(0),
      I4 => I11(0),
      O => n_0_MAX_LENGTH_ERR_i_5
    );
MAX_LENGTH_ERR_i_6: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => FRAME_COUNTER(14),
      I1 => I11(14),
      O => n_0_MAX_LENGTH_ERR_i_6
    );
MAX_LENGTH_ERR_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => FRAME_COUNTER_reg(12),
      I1 => I11(12),
      I2 => FRAME_COUNTER_reg(13),
      I3 => I11(13),
      I4 => I11(11),
      I5 => FRAME_COUNTER_reg(11),
      O => n_0_MAX_LENGTH_ERR_i_7
    );
MAX_LENGTH_ERR_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => FRAME_COUNTER_reg(8),
      I1 => I11(8),
      I2 => FRAME_COUNTER_reg(9),
      I3 => I11(9),
      I4 => I11(10),
      I5 => FRAME_COUNTER_reg(10),
      O => n_0_MAX_LENGTH_ERR_i_8
    );
MAX_LENGTH_ERR_i_9: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(5),
      I1 => I11(5),
      I2 => \FRAME_COUNTER__0\(6),
      I3 => I11(6),
      I4 => I11(7),
      I5 => \FRAME_COUNTER__0\(7),
      O => n_0_MAX_LENGTH_ERR_i_9
    );
MAX_LENGTH_ERR_reg_i_3: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \FRAME_CHECKER/MAX_LENGTH_ERR21_in\,
      CO(2) => n_1_MAX_LENGTH_ERR_reg_i_3,
      CO(1) => n_2_MAX_LENGTH_ERR_reg_i_3,
      CO(0) => n_3_MAX_LENGTH_ERR_reg_i_3,
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => NLW_MAX_LENGTH_ERR_reg_i_3_O_UNCONNECTED(3 downto 0),
      S(3) => n_0_MAX_LENGTH_ERR_i_6,
      S(2) => n_0_MAX_LENGTH_ERR_i_7,
      S(1) => n_0_MAX_LENGTH_ERR_i_8,
      S(0) => n_0_MAX_LENGTH_ERR_i_9
    );
MIN_LENGTH_MATCH_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0400FFFF04000000"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(0),
      I1 => \FRAME_COUNTER__0\(1),
      I2 => \FRAME_COUNTER__0\(2),
      I3 => n_0_MIN_LENGTH_MATCH_i_2,
      I4 => I14,
      I5 => I13,
      O => O5
    );
MIN_LENGTH_MATCH_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000080000"
    )
    port map (
      I0 => \FRAME_COUNTER__0\(4),
      I1 => \FRAME_COUNTER__0\(3),
      I2 => \FRAME_COUNTER__0\(7),
      I3 => SR(0),
      I4 => \FRAME_COUNTER__0\(5),
      I5 => \FRAME_COUNTER__0\(6),
      O => n_0_MIN_LENGTH_MATCH_i_2
    );
MULTICAST_FRAME_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \^multicast_match\,
      Q => \^d\(0),
      R => SR(0)
    );
MULTICAST_MATCH_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => I5,
      Q => \^multicast_match\,
      R => \<const0>\
    );
PADDED_FRAME_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"007FFFFF007F0000"
    )
    port map (
      I0 => Q(5),
      I1 => Q(3),
      I2 => n_0_PADDED_FRAME_i_2,
      I3 => n_0_PADDED_FRAME_i_3,
      I4 => I16,
      I5 => PADDED_FRAME,
      O => n_0_PADDED_FRAME_i_1
    );
PADDED_FRAME_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => Q(1),
      I1 => Q(2),
      O => n_0_PADDED_FRAME_i_2
    );
PADDED_FRAME_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEEEFFFF"
    )
    port map (
      I0 => Q(6),
      I1 => Q(7),
      I2 => Q(5),
      I3 => Q(4),
      I4 => \^less_than_256\,
      O => n_0_PADDED_FRAME_i_3
    );
PADDED_FRAME_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_PADDED_FRAME_i_1,
      Q => PADDED_FRAME,
      R => SR(0)
    );
RX_DV_REG_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => RX_DV_REG7,
      Q => RX_DV_REG,
      R => SR(0)
    );
\STATISTICS_LENGTH[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => RX_DV_REG,
      I1 => I2,
      I2 => FRAME_COUNTER(14),
      O => \n_0_STATISTICS_LENGTH[13]_i_1\
    );
\STATISTICS_LENGTH_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \FRAME_COUNTER__0\(0),
      Q => \^d\(1),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => FRAME_COUNTER_reg(10),
      Q => \^d\(11),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => FRAME_COUNTER_reg(11),
      Q => \^d\(12),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => FRAME_COUNTER_reg(12),
      Q => \^d\(13),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => FRAME_COUNTER_reg(13),
      Q => \^d\(14),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \FRAME_COUNTER__0\(1),
      Q => \^d\(2),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \FRAME_COUNTER__0\(2),
      Q => \^d\(3),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \FRAME_COUNTER__0\(3),
      Q => \^d\(4),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \FRAME_COUNTER__0\(4),
      Q => \^d\(5),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \FRAME_COUNTER__0\(5),
      Q => \^d\(6),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \FRAME_COUNTER__0\(6),
      Q => \^d\(7),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => \FRAME_COUNTER__0\(7),
      Q => \^d\(8),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => FRAME_COUNTER_reg(8),
      Q => \^d\(9),
      R => \<const0>\
    );
\STATISTICS_LENGTH_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \n_0_STATISTICS_LENGTH[13]_i_1\,
      D => FRAME_COUNTER_reg(9),
      Q => \^d\(10),
      R => \<const0>\
    );
TYPE_PACKET_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => I3,
      Q => \^type_frame\,
      R => \<const0>\
    );
VALIDATE_REQUIRED_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAA00AA"
    )
    port map (
      I0 => VALIDATE_REQUIRED,
      I1 => address_valid_early,
      I2 => n_0_DATA_VALID_reg,
      I3 => I2,
      I4 => I17,
      I5 => SR(0),
      O => O7
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
VLAN_FRAME_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_VLAN_MATCH_reg[1]\,
      Q => \^d\(16),
      R => SR(0)
    );
\VLAN_MATCH[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008000AA00AA00AA"
    )
    port map (
      I0 => \n_0_VLAN_MATCH[1]_i_2\,
      I1 => FIELD_COUNTER(0),
      I2 => LENGTH_FIELD,
      I3 => SR(0),
      I4 => I10,
      I5 => I2,
      O => \n_0_VLAN_MATCH[1]_i_1\
    );
\VLAN_MATCH[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8FFFFFFF80000000"
    )
    port map (
      I0 => VLAN_MATCH(0),
      I1 => \^o2\,
      I2 => FIELD_COUNTER(0),
      I3 => LENGTH_FIELD,
      I4 => I2,
      I5 => \n_0_VLAN_MATCH_reg[1]\,
      O => \n_0_VLAN_MATCH[1]_i_2\
    );
\VLAN_MATCH_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I18(0),
      Q => VLAN_MATCH(0),
      R => SR(0)
    );
\VLAN_MATCH_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_VLAN_MATCH[1]_i_1\,
      Q => \n_0_VLAN_MATCH_reg[1]\,
      R => \<const0>\
    );
\pause_value_to_tx[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
    port map (
      I0 => I6,
      I1 => I15,
      I2 => \^int_rx_control_frame\,
      I3 => rx_enable_reg,
      I4 => I2,
      O => E(0)
    );
\rx_statistics_vector[24]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => \^d\(15),
      I1 => I6,
      I2 => I7,
      I3 => I8,
      O => rx_statistics_vector(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \TriMACPARAM_CHECK__parameterized0\ is
  port (
    INHIBIT_FRAME : out STD_LOGIC;
    O1 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 5 downto 0 );
    EXCEEDED_MIN_LEN : out STD_LOGIC;
    FRAME_LEN_ERR : out STD_LOGIC;
    ALIGNMENT_ERR : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    BAD_FRAME_INT0_out : out STD_LOGIC;
    O4 : out STD_LOGIC;
    GOOD_FRAME_INT : out STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC;
    INHIBIT_FRAME0 : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    CRC_ENGINE_ERR0 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    I5 : in STD_LOGIC;
    I6 : in STD_LOGIC;
    p_8_in : in STD_LOGIC;
    I7 : in STD_LOGIC;
    I8 : in STD_LOGIC;
    TYPE_FRAME : in STD_LOGIC;
    MATCH_FRAME_INT : in STD_LOGIC;
    VALIDATE_REQUIRED : in STD_LOGIC;
    ALIGNMENT_ERR_REG : in STD_LOGIC;
    MAX_LENGTH_ERR3_out : in STD_LOGIC;
    I9 : in STD_LOGIC;
    PREAMBLE_FIELD : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \TriMACPARAM_CHECK__parameterized0\ : entity is "PARAM_CHECK";
end \TriMACPARAM_CHECK__parameterized0\;

architecture STRUCTURE of \TriMACPARAM_CHECK__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal BAD_FRAME0 : STD_LOGIC;
  signal CRC_ENGINE_ERR : STD_LOGIC;
  signal CRC_ERR : STD_LOGIC;
  signal \^d\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \^exceeded_min_len\ : STD_LOGIC;
  signal FCS_ERR : STD_LOGIC;
  signal \^frame_len_err\ : STD_LOGIC;
  signal GOOD_FRAME0 : STD_LOGIC;
  signal \^inhibit_frame\ : STD_LOGIC;
  signal LENGTH_TYPE_ERR0 : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal n_0_MAX_LENGTH_ERR_i_1 : STD_LOGIC;
  signal n_0_MAX_LENGTH_ERR_reg : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of BAD_FRAME_INT_i_1 : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of GOOD_FRAME_INT_i_1 : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \STATISTICS_VECTOR[24]_i_1\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \STATISTICS_VECTOR[2]_i_1\ : label is "soft_lutpair91";
begin
  D(5 downto 0) <= \^d\(5 downto 0);
  EXCEEDED_MIN_LEN <= \^exceeded_min_len\;
  FRAME_LEN_ERR <= \^frame_len_err\;
  INHIBIT_FRAME <= \^inhibit_frame\;
  O1 <= \^o1\;
ALIGNMENT_ERR_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I6,
      Q => ALIGNMENT_ERR,
      R => SR(0)
    );
BAD_FRAME_INT_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CC40"
    )
    port map (
      I0 => MATCH_FRAME_INT,
      I1 => VALIDATE_REQUIRED,
      I2 => \^d\(0),
      I3 => \^d\(1),
      O => BAD_FRAME_INT0_out
    );
BAD_FRAME_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5050505050505010"
    )
    port map (
      I0 => \^inhibit_frame\,
      I1 => \^exceeded_min_len\,
      I2 => I8,
      I3 => n_0_MAX_LENGTH_ERR_reg,
      I4 => \^frame_len_err\,
      I5 => \^o1\,
      O => BAD_FRAME0
    );
BAD_FRAME_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => BAD_FRAME0,
      Q => \^d\(1),
      R => SR(0)
    );
CRC_ENGINE_ERR_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => CRC_ENGINE_ERR0,
      Q => CRC_ENGINE_ERR,
      R => SR(0)
    );
CRC_ERR_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => FCS_ERR,
      I1 => CRC_ENGINE_ERR,
      O => \^o1\
    );
CRC_ERR_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \^o1\,
      Q => CRC_ERR,
      R => SR(0)
    );
EXCEEDED_MIN_LEN_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I4,
      Q => \^exceeded_min_len\,
      R => SR(0)
    );
FCS_ERR_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I3,
      Q => FCS_ERR,
      R => SR(0)
    );
FRAME_LEN_ERR_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I5,
      Q => \^frame_len_err\,
      R => SR(0)
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
GOOD_FRAME_INT_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => VALIDATE_REQUIRED,
      I1 => MATCH_FRAME_INT,
      I2 => \^d\(0),
      O => GOOD_FRAME_INT
    );
GOOD_FRAME_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000200000000"
    )
    port map (
      I0 => \^exceeded_min_len\,
      I1 => n_0_MAX_LENGTH_ERR_reg,
      I2 => \^frame_len_err\,
      I3 => \^o1\,
      I4 => \^inhibit_frame\,
      I5 => I8,
      O => GOOD_FRAME0
    );
GOOD_FRAME_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => GOOD_FRAME0,
      Q => \^d\(0),
      R => SR(0)
    );
INHIBIT_FRAME_reg: unisim.vcomponents.FDSE
    port map (
      C => I1,
      CE => I2,
      D => INHIBIT_FRAME0,
      Q => \^inhibit_frame\,
      S => SR(0)
    );
LENGTH_TYPE_ERR_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^frame_len_err\,
      I1 => TYPE_FRAME,
      O => LENGTH_TYPE_ERR0
    );
LENGTH_TYPE_ERR_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => LENGTH_TYPE_ERR0,
      Q => \^d\(4),
      R => SR(0)
    );
MAX_LENGTH_ERR_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000E0E0EEE"
    )
    port map (
      I0 => n_0_MAX_LENGTH_ERR_reg,
      I1 => MAX_LENGTH_ERR3_out,
      I2 => I2,
      I3 => I9,
      I4 => PREAMBLE_FIELD,
      I5 => SR(0),
      O => n_0_MAX_LENGTH_ERR_i_1
    );
MAX_LENGTH_ERR_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_MAX_LENGTH_ERR_i_1,
      Q => n_0_MAX_LENGTH_ERR_reg,
      R => \<const0>\
    );
MIN_LENGTH_MATCH_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => I7,
      Q => O3,
      R => \<const0>\
    );
OUT_OF_BOUNDS_ERR_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => n_0_MAX_LENGTH_ERR_reg,
      Q => \^d\(3),
      R => SR(0)
    );
STATISTICS_VALID_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => p_8_in,
      Q => O2,
      R => SR(0)
    );
\STATISTICS_VECTOR[24]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => CRC_ERR,
      I1 => ALIGNMENT_ERR_REG,
      O => \^d\(5)
    );
\STATISTICS_VECTOR[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => CRC_ERR,
      I1 => ALIGNMENT_ERR_REG,
      O => \^d\(2)
    );
VALIDATE_REQUIRED_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \^d\(1),
      I1 => \^d\(0),
      O => O4
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACSTATE_MACHINES is
  port (
    END_OF_DATA : out STD_LOGIC;
    FCS_FIELD : out STD_LOGIC;
    O1 : out STD_LOGIC;
    LENGTH_FIELD : out STD_LOGIC;
    DATA_FIELD : out STD_LOGIC;
    EXTENSION_FIELD : out STD_LOGIC;
    PREAMBLE_FIELD : out STD_LOGIC;
    O2 : out STD_LOGIC;
    LENGTH_ZERO0 : out STD_LOGIC;
    O3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    LENGTH_ONE0 : out STD_LOGIC;
    I18 : out STD_LOGIC_VECTOR ( 0 to 0 );
    CONTROL_MATCH0 : out STD_LOGIC;
    TYPE_PACKET10_out : out STD_LOGIC;
    LESS_THAN_2560 : out STD_LOGIC;
    INHIBIT_FRAME0 : out STD_LOGIC;
    CRC_COMPUTE0 : out STD_LOGIC;
    DATA_NO_FCS0 : out STD_LOGIC;
    DATA_WITH_FCS0 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    p_8_in : out STD_LOGIC;
    PRE_IFG_FLAG : out STD_LOGIC;
    PRE_FALSE_CARR_FLAG : out STD_LOGIC;
    I22 : out STD_LOGIC_VECTOR ( 0 to 0 );
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    O9 : out STD_LOGIC;
    O10 : out STD_LOGIC;
    O11 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    O12 : out STD_LOGIC;
    O13 : out STD_LOGIC;
    O14 : out STD_LOGIC;
    O15 : out STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC;
    I1 : in STD_LOGIC;
    RX_DV_REG6 : in STD_LOGIC;
    RX_ERR_REG6 : in STD_LOGIC;
    IFG_FLAG : in STD_LOGIC;
    FALSE_CARR_FLAG : in STD_LOGIC;
    SFD_FLAG : in STD_LOGIC;
    I3 : in STD_LOGIC;
    RX_DV_REG7 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    LT_CHECK_HELD : in STD_LOGIC;
    LESS_THAN_256 : in STD_LOGIC;
    I5 : in STD_LOGIC;
    I6 : in STD_LOGIC;
    I7 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 7 downto 0 );
    INHIBIT_FRAME : in STD_LOGIC;
    COMPUTE : in STD_LOGIC;
    LENGTH_FIELD_MATCH : in STD_LOGIC;
    TYPE_FRAME : in STD_LOGIC;
    DATA_WITH_FCS : in STD_LOGIC;
    LENGTH_ZERO : in STD_LOGIC;
    DATA_NO_FCS : in STD_LOGIC;
    LENGTH_ONE : in STD_LOGIC;
    broadcastaddressmatch : in STD_LOGIC;
    I8 : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 7 downto 0 );
    RX_DV_REG5 : in STD_LOGIC;
    RX_ERR_REG5 : in STD_LOGIC;
    RX_ERR_REG7 : in STD_LOGIC;
    MATCH_FRAME_INT : in STD_LOGIC;
    MATCH_FRAME_INT0 : in STD_LOGIC;
    CONTROL_FRAME_INT : in STD_LOGIC;
    I9 : in STD_LOGIC;
    CONTROL_MATCH : in STD_LOGIC;
    MULTICAST_MATCH : in STD_LOGIC;
    int_alignment_err_pulse : in STD_LOGIC;
    alignment_err_reg : in STD_LOGIC;
    ALIGNMENT_ERR : in STD_LOGIC;
    I10 : in STD_LOGIC;
    EXTENSION_FLAG : in STD_LOGIC;
    FRAME_LEN_ERR : in STD_LOGIC;
    EXCEEDED_MIN_LEN : in STD_LOGIC;
    I11 : in STD_LOGIC;
    I12 : in STD_LOGIC;
    I13 : in STD_LOGIC;
    RX_DV_REG2 : in STD_LOGIC
  );
end TriMACSTATE_MACHINES;

architecture STRUCTURE of TriMACSTATE_MACHINES is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal CRC_FIELD0 : STD_LOGIC;
  signal \^data_field\ : STD_LOGIC;
  signal DAT_FIELD0 : STD_LOGIC;
  signal DEST_ADDRESS_FIELD0 : STD_LOGIC;
  signal DEST_ADD_FIELD : STD_LOGIC;
  signal END_EXT : STD_LOGIC;
  signal END_EXT0 : STD_LOGIC;
  signal END_FCS0 : STD_LOGIC;
  signal \^end_of_data\ : STD_LOGIC;
  signal END_OF_FCS : STD_LOGIC;
  signal \^extension_field\ : STD_LOGIC;
  signal \^fcs_field\ : STD_LOGIC;
  signal FIELD_COUNTER : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \^length_field\ : STD_LOGIC;
  signal LEN_FIELD0 : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal \^o2\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^o9\ : STD_LOGIC;
  signal \^preamble_field\ : STD_LOGIC;
  signal \^pre_false_carr_flag\ : STD_LOGIC;
  signal \^pre_ifg_flag\ : STD_LOGIC;
  signal SOURCE_ADD_FIELD : STD_LOGIC;
  signal SRC_ADDRESS_FIELD0 : STD_LOGIC;
  signal \^type_packet10_out\ : STD_LOGIC;
  signal n_0_CONTROL_FRAME_INT_i_3 : STD_LOGIC;
  signal n_0_CONTROL_MATCH_i_2 : STD_LOGIC;
  signal n_0_DATA_NO_FCS_i_2 : STD_LOGIC;
  signal n_0_END_DATA_i_1 : STD_LOGIC;
  signal n_0_END_FRAME_i_1 : STD_LOGIC;
  signal n_0_END_FRAME_i_2 : STD_LOGIC;
  signal n_0_END_FRAME_i_3 : STD_LOGIC;
  signal n_0_EXT_FIELD_i_1 : STD_LOGIC;
  signal n_0_EXT_FIELD_i_2 : STD_LOGIC;
  signal n_0_FCS_ERR_i_2 : STD_LOGIC;
  signal \n_0_FIELD_CONTROL[0]_i_1\ : STD_LOGIC;
  signal \n_0_FIELD_CONTROL[1]_i_1\ : STD_LOGIC;
  signal \n_0_FIELD_CONTROL[1]_i_2\ : STD_LOGIC;
  signal \n_0_FIELD_CONTROL[2]_i_1\ : STD_LOGIC;
  signal \n_0_FIELD_CONTROL[3]_i_1\ : STD_LOGIC;
  signal \n_0_FIELD_CONTROL[4]_i_1\ : STD_LOGIC;
  signal \n_0_FIELD_CONTROL[5]_i_1\ : STD_LOGIC;
  signal \n_0_FIELD_CONTROL_reg[2]\ : STD_LOGIC;
  signal \n_0_FIELD_CONTROL_reg[3]\ : STD_LOGIC;
  signal \n_0_FIELD_CONTROL_reg[4]\ : STD_LOGIC;
  signal n_0_IFG_FLAG_i_2 : STD_LOGIC;
  signal n_0_IFG_FLAG_i_3 : STD_LOGIC;
  signal n_0_MULTICAST_MATCH_i_2 : STD_LOGIC;
  signal n_0_MULTICAST_MATCH_i_3 : STD_LOGIC;
  signal \n_0_PREAMBLE_i_1__0\ : STD_LOGIC;
  signal n_0_PREAMBLE_i_2 : STD_LOGIC;
  signal n_0_TYPE_PACKET_i_2 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \CALC[29]_i_1__0\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of \CALC[29]_i_4\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of CONTROL_FRAME_INT_i_3 : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \CRC_COMPUTE_i_1__0\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of CRC_FIELD_i_1 : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of DATA_WITH_FCS_i_1 : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of END_EXT_i_1 : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of END_FCS_i_1 : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of END_FRAME_i_3 : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of EXT_FIELD_i_2 : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of FCS_ERR_i_2 : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \FRAME_COUNTER[0]_i_1\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of IFG_FLAG_i_3 : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of INHIBIT_FRAME_i_1 : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \LENGTH_TYPE[10]_i_2\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \LENGTH_TYPE[7]_i_2\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of LESS_THAN_256_i_1 : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of LT_CHECK_HELD_i_1 : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[14]_i_1\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of MULTICAST_MATCH_i_3 : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of SRC_ADDRESS_FIELD_i_1 : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of STATISTICS_VALID_i_1 : label is "soft_lutpair97";
begin
  DATA_FIELD <= \^data_field\;
  END_OF_DATA <= \^end_of_data\;
  EXTENSION_FIELD <= \^extension_field\;
  FCS_FIELD <= \^fcs_field\;
  LENGTH_FIELD <= \^length_field\;
  O1 <= \^o1\;
  O2 <= \^o2\;
  O3(0) <= \^o3\(0);
  O9 <= \^o9\;
  PREAMBLE_FIELD <= \^preamble_field\;
  PRE_FALSE_CARR_FLAG <= \^pre_false_carr_flag\;
  PRE_IFG_FLAG <= \^pre_ifg_flag\;
  TYPE_PACKET10_out <= \^type_packet10_out\;
ALIGNMENT_ERR_INT_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5554"
    )
    port map (
      I0 => \^o1\,
      I1 => int_alignment_err_pulse,
      I2 => alignment_err_reg,
      I3 => ALIGNMENT_ERR,
      O => O11
    );
\CALC[29]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => \^preamble_field\,
      I1 => SFD_FLAG,
      I2 => I3,
      I3 => I2,
      O => O4
    );
\CALC[29]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => SFD_FLAG,
      I1 => \^preamble_field\,
      O => O5
    );
CONTROL_FRAME_INT_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2220000E222E222"
    )
    port map (
      I0 => CONTROL_FRAME_INT,
      I1 => \^o9\,
      I2 => I9,
      I3 => CONTROL_MATCH,
      I4 => n_0_CONTROL_FRAME_INT_i_3,
      I5 => \^o2\,
      O => O8
    );
CONTROL_FRAME_INT_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => \^o3\(0),
      I1 => \^length_field\,
      I2 => SR(0),
      O => n_0_CONTROL_FRAME_INT_i_3
    );
CONTROL_MATCH_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000020"
    )
    port map (
      I0 => n_0_CONTROL_MATCH_i_2,
      I1 => Q(1),
      I2 => Q(3),
      I3 => Q(0),
      I4 => Q(2),
      O => CONTROL_MATCH0
    );
CONTROL_MATCH_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000800"
    )
    port map (
      I0 => FIELD_COUNTER(0),
      I1 => \^length_field\,
      I2 => Q(6),
      I3 => Q(7),
      I4 => Q(5),
      I5 => Q(4),
      O => n_0_CONTROL_MATCH_i_2
    );
\CRC_COMPUTE_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888F88"
    )
    port map (
      I0 => \^preamble_field\,
      I1 => SFD_FLAG,
      I2 => \^o1\,
      I3 => COMPUTE,
      I4 => \^end_of_data\,
      O => CRC_COMPUTE0
    );
CRC_FIELD_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => \^end_of_data\,
      I1 => END_OF_FCS,
      I2 => \^fcs_field\,
      O => CRC_FIELD0
    );
CRC_FIELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => CRC_FIELD0,
      Q => \^fcs_field\,
      R => SR(0)
    );
\DATA_COUNTER[10]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAAA8"
    )
    port map (
      I0 => I2,
      I1 => \^length_field\,
      I2 => \^data_field\,
      I3 => \^fcs_field\,
      I4 => \^extension_field\,
      O => I22(0)
    );
DATA_NO_FCS_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8F8F8F8F8F8F888F"
    )
    port map (
      I0 => \^preamble_field\,
      I1 => SFD_FLAG,
      I2 => n_0_DATA_NO_FCS_i_2,
      I3 => LENGTH_FIELD_MATCH,
      I4 => TYPE_FRAME,
      I5 => LT_CHECK_HELD,
      O => DATA_NO_FCS0
    );
DATA_NO_FCS_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFEFEFEF"
    )
    port map (
      I0 => \^o1\,
      I1 => LENGTH_ZERO,
      I2 => DATA_NO_FCS,
      I3 => \^data_field\,
      I4 => \^end_of_data\,
      I5 => LENGTH_ONE,
      O => n_0_DATA_NO_FCS_i_2
    );
DATA_WITH_FCS_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00F8"
    )
    port map (
      I0 => SFD_FLAG,
      I1 => \^preamble_field\,
      I2 => DATA_WITH_FCS,
      I3 => END_OF_FCS,
      O => DATA_WITH_FCS0
    );
DAT_FIELD_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000F800"
    )
    port map (
      I0 => \^length_field\,
      I1 => \^o3\(0),
      I2 => \^data_field\,
      I3 => RX_DV_REG6,
      I4 => \^end_of_data\,
      O => DAT_FIELD0
    );
DAT_FIELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => DAT_FIELD0,
      Q => \^data_field\,
      R => SR(0)
    );
DEST_ADDRESS_FIELD_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FF8A0000"
    )
    port map (
      I0 => SFD_FLAG,
      I1 => \^preamble_field\,
      I2 => RX_DV_REG7,
      I3 => DEST_ADD_FIELD,
      I4 => RX_DV_REG6,
      I5 => FIELD_COUNTER(5),
      O => DEST_ADDRESS_FIELD0
    );
DEST_ADDRESS_FIELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => DEST_ADDRESS_FIELD0,
      Q => DEST_ADD_FIELD,
      R => SR(0)
    );
END_DATA_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => I13,
      I1 => RX_DV_REG2,
      O => n_0_END_DATA_i_1
    );
END_DATA_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => n_0_END_DATA_i_1,
      Q => \^end_of_data\,
      R => SR(0)
    );
END_EXT_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000EF00"
    )
    port map (
      I0 => \^pre_false_carr_flag\,
      I1 => RX_DV_REG5,
      I2 => RX_ERR_REG5,
      I3 => \^extension_field\,
      I4 => END_EXT,
      O => END_EXT0
    );
END_EXT_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => END_EXT0,
      Q => END_EXT,
      R => SR(0)
    );
END_FCS_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => RX_DV_REG6,
      I1 => RX_DV_REG5,
      O => END_FCS0
    );
END_FCS_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => END_FCS0,
      Q => END_OF_FCS,
      R => SR(0)
    );
END_FRAME_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBBBBBBBBBABBBB"
    )
    port map (
      I0 => n_0_END_FRAME_i_2,
      I1 => n_0_END_FRAME_i_3,
      I2 => \^pre_ifg_flag\,
      I3 => I8,
      I4 => RX_ERR_REG6,
      I5 => \^pre_false_carr_flag\,
      O => n_0_END_FRAME_i_1
    );
END_FRAME_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000000FF04"
    )
    port map (
      I0 => RX_DV_REG7,
      I1 => RX_ERR_REG7,
      I2 => RX_ERR_REG6,
      I3 => END_EXT,
      I4 => I8,
      I5 => \^o1\,
      O => n_0_END_FRAME_i_2
    );
END_FRAME_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => RX_DV_REG6,
      I1 => RX_DV_REG7,
      O => n_0_END_FRAME_i_3
    );
END_FRAME_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => n_0_END_FRAME_i_1,
      Q => \^o1\,
      R => SR(0)
    );
EXCEEDED_MIN_LEN_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5444"
    )
    port map (
      I0 => \^o1\,
      I1 => EXCEEDED_MIN_LEN,
      I2 => \^data_field\,
      I3 => I12,
      O => O15
    );
EXT_FIELD_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"005F005500080000"
    )
    port map (
      I0 => I2,
      I1 => \^fcs_field\,
      I2 => I8,
      I3 => SR(0),
      I4 => n_0_EXT_FIELD_i_2,
      I5 => \^extension_field\,
      O => n_0_EXT_FIELD_i_1
    );
EXT_FIELD_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => RX_DV_REG6,
      I1 => RX_ERR_REG6,
      I2 => IFG_FLAG,
      I3 => FALSE_CARR_FLAG,
      O => n_0_EXT_FIELD_i_2
    );
EXT_FIELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_EXT_FIELD_i_1,
      Q => \^extension_field\,
      R => \<const0>\
    );
FALSE_CARR_FLAG_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000008000"
    )
    port map (
      I0 => n_0_IFG_FLAG_i_2,
      I1 => D(2),
      I2 => D(1),
      I3 => D(3),
      I4 => D(0),
      I5 => n_0_IFG_FLAG_i_3,
      O => \^pre_false_carr_flag\
    );
FCS_ERR_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555454445444544"
    )
    port map (
      I0 => \^o1\,
      I1 => I10,
      I2 => EXTENSION_FLAG,
      I3 => \^extension_field\,
      I4 => RX_ERR_REG7,
      I5 => n_0_FCS_ERR_i_2,
      O => O13
    );
FCS_ERR_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => RX_DV_REG7,
      I1 => \^preamble_field\,
      O => n_0_FCS_ERR_i_2
    );
\FIELD_CONTROL[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFCFFFAFFFA"
    )
    port map (
      I0 => FIELD_COUNTER(0),
      I1 => FIELD_COUNTER(5),
      I2 => \n_0_FIELD_CONTROL[1]_i_2\,
      I3 => SR(0),
      I4 => \^o1\,
      I5 => I2,
      O => \n_0_FIELD_CONTROL[0]_i_1\
    );
\FIELD_CONTROL[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000C000A000A"
    )
    port map (
      I0 => \^o3\(0),
      I1 => FIELD_COUNTER(0),
      I2 => \n_0_FIELD_CONTROL[1]_i_2\,
      I3 => SR(0),
      I4 => \^o1\,
      I5 => I2,
      O => \n_0_FIELD_CONTROL[1]_i_1\
    );
\FIELD_CONTROL[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
    port map (
      I0 => I2,
      I1 => \^fcs_field\,
      I2 => DEST_ADD_FIELD,
      I3 => \^length_field\,
      I4 => SOURCE_ADD_FIELD,
      O => \n_0_FIELD_CONTROL[1]_i_2\
    );
\FIELD_CONTROL[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000ACA"
    )
    port map (
      I0 => \n_0_FIELD_CONTROL_reg[2]\,
      I1 => \^o3\(0),
      I2 => I2,
      I3 => \^o1\,
      I4 => SR(0),
      O => \n_0_FIELD_CONTROL[2]_i_1\
    );
\FIELD_CONTROL[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000ACA"
    )
    port map (
      I0 => \n_0_FIELD_CONTROL_reg[3]\,
      I1 => \n_0_FIELD_CONTROL_reg[2]\,
      I2 => I2,
      I3 => \^o1\,
      I4 => SR(0),
      O => \n_0_FIELD_CONTROL[3]_i_1\
    );
\FIELD_CONTROL[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000ACA"
    )
    port map (
      I0 => \n_0_FIELD_CONTROL_reg[4]\,
      I1 => \n_0_FIELD_CONTROL_reg[3]\,
      I2 => I2,
      I3 => \^o1\,
      I4 => SR(0),
      O => \n_0_FIELD_CONTROL[4]_i_1\
    );
\FIELD_CONTROL[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000ACA"
    )
    port map (
      I0 => FIELD_COUNTER(5),
      I1 => \n_0_FIELD_CONTROL_reg[4]\,
      I2 => I2,
      I3 => \^o1\,
      I4 => SR(0),
      O => \n_0_FIELD_CONTROL[5]_i_1\
    );
\FIELD_CONTROL_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_FIELD_CONTROL[0]_i_1\,
      Q => FIELD_COUNTER(0),
      R => \<const0>\
    );
\FIELD_CONTROL_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_FIELD_CONTROL[1]_i_1\,
      Q => \^o3\(0),
      R => \<const0>\
    );
\FIELD_CONTROL_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_FIELD_CONTROL[2]_i_1\,
      Q => \n_0_FIELD_CONTROL_reg[2]\,
      R => \<const0>\
    );
\FIELD_CONTROL_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_FIELD_CONTROL[3]_i_1\,
      Q => \n_0_FIELD_CONTROL_reg[3]\,
      R => \<const0>\
    );
\FIELD_CONTROL_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_FIELD_CONTROL[4]_i_1\,
      Q => \n_0_FIELD_CONTROL_reg[4]\,
      R => \<const0>\
    );
\FIELD_CONTROL_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_FIELD_CONTROL[5]_i_1\,
      Q => FIELD_COUNTER(5),
      R => \<const0>\
    );
\FRAME_COUNTER[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => I2,
      I1 => SFD_FLAG,
      I2 => \^preamble_field\,
      I3 => SR(0),
      O => \^o2\
    );
FRAME_LEN_ERR_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"45445555"
    )
    port map (
      I0 => \^o1\,
      I1 => FRAME_LEN_ERR,
      I2 => EXCEEDED_MIN_LEN,
      I3 => \^fcs_field\,
      I4 => I11,
      O => O14
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
IFG_FLAG_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
    port map (
      I0 => n_0_IFG_FLAG_i_2,
      I1 => D(2),
      I2 => D(1),
      I3 => D(3),
      I4 => D(0),
      I5 => n_0_IFG_FLAG_i_3,
      O => \^pre_ifg_flag\
    );
IFG_FLAG_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => D(5),
      I1 => D(4),
      I2 => D(6),
      I3 => D(7),
      O => n_0_IFG_FLAG_i_2
    );
IFG_FLAG_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => RX_DV_REG5,
      I1 => RX_ERR_REG5,
      O => n_0_IFG_FLAG_i_3
    );
INHIBIT_FRAME_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0EEE"
    )
    port map (
      I0 => INHIBIT_FRAME,
      I1 => \^o1\,
      I2 => \^preamble_field\,
      I3 => SFD_FLAG,
      O => INHIBIT_FRAME0
    );
LENGTH_ONE_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000004000"
    )
    port map (
      I0 => LT_CHECK_HELD,
      I1 => LESS_THAN_256,
      I2 => \^length_field\,
      I3 => \^o3\(0),
      I4 => I5,
      I5 => I6,
      O => LENGTH_ONE0
    );
\LENGTH_TYPE[10]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => I2,
      I1 => FIELD_COUNTER(0),
      I2 => \^length_field\,
      O => \^type_packet10_out\
    );
\LENGTH_TYPE[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \^o3\(0),
      I1 => \^length_field\,
      I2 => I2,
      O => \^o9\
    );
LENGTH_ZERO_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20000000"
    )
    port map (
      I0 => I4,
      I1 => LT_CHECK_HELD,
      I2 => LESS_THAN_256,
      I3 => \^length_field\,
      I4 => \^o3\(0),
      O => LENGTH_ZERO0
    );
LEN_FIELD_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30203000"
    )
    port map (
      I0 => FIELD_COUNTER(5),
      I1 => \^o3\(0),
      I2 => RX_DV_REG6,
      I3 => \^length_field\,
      I4 => SOURCE_ADD_FIELD,
      O => LEN_FIELD0
    );
LEN_FIELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => LEN_FIELD0,
      Q => \^length_field\,
      R => SR(0)
    );
LESS_THAN_256_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => I4,
      I1 => FIELD_COUNTER(0),
      I2 => \^length_field\,
      O => LESS_THAN_2560
    );
LT_CHECK_HELD_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \^preamble_field\,
      I1 => SFD_FLAG,
      I2 => I2,
      O => O12
    );
MATCH_FRAME_INT_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000EA2A"
    )
    port map (
      I0 => MATCH_FRAME_INT,
      I1 => END_OF_FCS,
      I2 => I2,
      I3 => MATCH_FRAME_INT0,
      I4 => SR(0),
      O => O7
    );
\MAX_FRAME_LENGTH_HELD[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \^preamble_field\,
      I1 => SFD_FLAG,
      I2 => I2,
      O => E(0)
    );
MULTICAST_MATCH_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000008ABA8A8A"
    )
    port map (
      I0 => MULTICAST_MATCH,
      I1 => n_0_MULTICAST_MATCH_i_2,
      I2 => I2,
      I3 => n_0_MULTICAST_MATCH_i_3,
      I4 => Q(0),
      I5 => SR(0),
      O => O10
    );
MULTICAST_MATCH_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FDFD00FF"
    )
    port map (
      I0 => FIELD_COUNTER(0),
      I1 => \^fcs_field\,
      I2 => \^end_of_data\,
      I3 => broadcastaddressmatch,
      I4 => DEST_ADD_FIELD,
      I5 => \^o1\,
      O => n_0_MULTICAST_MATCH_i_2
    );
MULTICAST_MATCH_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      I0 => \^end_of_data\,
      I1 => \^fcs_field\,
      I2 => DEST_ADD_FIELD,
      I3 => FIELD_COUNTER(0),
      O => n_0_MULTICAST_MATCH_i_3
    );
\PREAMBLE_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000DF5500008800"
    )
    port map (
      I0 => I2,
      I1 => n_0_PREAMBLE_i_2,
      I2 => SFD_FLAG,
      I3 => RX_DV_REG6,
      I4 => SR(0),
      I5 => \^preamble_field\,
      O => \n_0_PREAMBLE_i_1__0\
    );
PREAMBLE_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => I3,
      I1 => RX_DV_REG7,
      O => n_0_PREAMBLE_i_2
    );
PREAMBLE_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_PREAMBLE_i_1__0\,
      Q => \^preamble_field\,
      R => \<const0>\
    );
SRC_ADDRESS_FIELD_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A808"
    )
    port map (
      I0 => RX_DV_REG6,
      I1 => SOURCE_ADD_FIELD,
      I2 => FIELD_COUNTER(5),
      I3 => DEST_ADD_FIELD,
      O => SRC_ADDRESS_FIELD0
    );
SRC_ADDRESS_FIELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => SRC_ADDRESS_FIELD0,
      Q => SOURCE_ADD_FIELD,
      R => SR(0)
    );
STATISTICS_VALID_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^o1\,
      I1 => INHIBIT_FRAME,
      O => p_8_in
    );
TYPE_PACKET_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFFAAAA"
    )
    port map (
      I0 => n_0_TYPE_PACKET_i_2,
      I1 => SR(0),
      I2 => FIELD_COUNTER(0),
      I3 => \^length_field\,
      I4 => \^o2\,
      O => O6
    );
TYPE_PACKET_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFEAFFFFFFEA0000"
    )
    port map (
      I0 => I6,
      I1 => Q(1),
      I2 => Q(2),
      I3 => Q(3),
      I4 => \^type_packet10_out\,
      I5 => TYPE_FRAME,
      O => n_0_TYPE_PACKET_i_2
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\VLAN_MATCH[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000080000"
    )
    port map (
      I0 => n_0_CONTROL_MATCH_i_2,
      I1 => I7,
      I2 => Q(1),
      I3 => Q(3),
      I4 => Q(0),
      I5 => Q(2),
      O => I18(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACTriMAC_block_sync_block is
  port (
    clk : in STD_LOGIC;
    data_in : in STD_LOGIC;
    data_out : out STD_LOGIC
  );
  attribute dont_touch : string;
  attribute dont_touch of TriMACTriMAC_block_sync_block : entity is "yes";
  attribute INITIALISE : string;
  attribute INITIALISE of TriMACTriMAC_block_sync_block : entity is "1'b0";
  attribute DEPTH : integer;
  attribute DEPTH of TriMACTriMAC_block_sync_block : entity is 5;
end TriMACTriMAC_block_sync_block;

architecture STRUCTURE of TriMACTriMAC_block_sync_block is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "NO";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "NO";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "NO";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "NO";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "NO";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_in,
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync3,
      Q => data_out,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \TriMACTriMAC_block_sync_block__1\ is
  port (
    clk : in STD_LOGIC;
    data_in : in STD_LOGIC;
    data_out : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \TriMACTriMAC_block_sync_block__1\ : entity is "TriMAC_block_sync_block";
  attribute dont_touch : string;
  attribute dont_touch of \TriMACTriMAC_block_sync_block__1\ : entity is "yes";
  attribute INITIALISE : string;
  attribute INITIALISE of \TriMACTriMAC_block_sync_block__1\ : entity is "1'b0";
  attribute DEPTH : integer;
  attribute DEPTH of \TriMACTriMAC_block_sync_block__1\ : entity is 5;
end \TriMACTriMAC_block_sync_block__1\;

architecture STRUCTURE of \TriMACTriMAC_block_sync_block__1\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "NO";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "NO";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "NO";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "NO";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "NO";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_in,
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync3,
      Q => data_out,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \TriMACTriMAC_block_sync_block__2\ is
  port (
    clk : in STD_LOGIC;
    data_in : in STD_LOGIC;
    data_out : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \TriMACTriMAC_block_sync_block__2\ : entity is "TriMAC_block_sync_block";
  attribute dont_touch : string;
  attribute dont_touch of \TriMACTriMAC_block_sync_block__2\ : entity is "yes";
  attribute INITIALISE : string;
  attribute INITIALISE of \TriMACTriMAC_block_sync_block__2\ : entity is "1'b0";
  attribute DEPTH : integer;
  attribute DEPTH of \TriMACTriMAC_block_sync_block__2\ : entity is 5;
end \TriMACTriMAC_block_sync_block__2\;

architecture STRUCTURE of \TriMACTriMAC_block_sync_block__2\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "NO";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "NO";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "NO";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "NO";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "NO";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_in,
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => clk,
      CE => \<const1>\,
      D => data_sync3,
      Q => data_out,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACTriMAC_rgmii_v2_0_if is
  port (
    rgmii_txc : out STD_LOGIC;
    rgmii_tx_ctl : out STD_LOGIC;
    O1 : out STD_LOGIC;
    gmii_rx_dv_int : out STD_LOGIC;
    rgmii_txd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    D : out STD_LOGIC_VECTOR ( 7 downto 0 );
    inband_link_status : out STD_LOGIC;
    inband_duplex_status : out STD_LOGIC;
    inband_clock_speed : out STD_LOGIC_VECTOR ( 1 downto 0 );
    gmii_rx_er_int : out STD_LOGIC;
    rgmii_rxc : in STD_LOGIC;
    rgmii_rx_ctl : in STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    clk_div5_shift : in STD_LOGIC;
    clk_div5 : in STD_LOGIC;
    I1 : in STD_LOGIC;
    tx_en_to_ddr : in STD_LOGIC;
    rgmii_tx_ctl_int : in STD_LOGIC;
    rgmii_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gmii_txd_falling : in STD_LOGIC_VECTOR ( 3 downto 0 );
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC
  );
end TriMACTriMAC_rgmii_v2_0_if;

architecture STRUCTURE of TriMACTriMAC_rgmii_v2_0_if is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^d\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^o1\ : STD_LOGIC;
  signal control_enable : STD_LOGIC;
  signal \^gmii_rx_dv_int\ : STD_LOGIC;
  signal inband_ce : STD_LOGIC;
  signal \n_0_rxdata_bus[1].delay_rgmii_rxd\ : STD_LOGIC;
  signal \n_0_rxdata_bus[3].delay_rgmii_rxd\ : STD_LOGIC;
  signal \n_0_txdata_out_bus[0].delay_rgmii_txd\ : STD_LOGIC;
  signal \n_0_txdata_out_bus[0].rgmii_txd_out\ : STD_LOGIC;
  signal \n_0_txdata_out_bus[1].rgmii_txd_out\ : STD_LOGIC;
  signal \n_0_txdata_out_bus[2].delay_rgmii_txd\ : STD_LOGIC;
  signal \n_0_txdata_out_bus[2].rgmii_txd_out\ : STD_LOGIC;
  signal \n_0_txdata_out_bus[3].rgmii_txd_out\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_0_out : STD_LOGIC;
  signal p_2_in : STD_LOGIC;
  signal p_2_out : STD_LOGIC;
  signal p_3_in : STD_LOGIC;
  signal p_4_in : STD_LOGIC;
  signal p_6_in : STD_LOGIC;
  signal p_9_in : STD_LOGIC;
  signal rgmii_rx_clk_bufio : STD_LOGIC;
  signal rgmii_rx_ctl_delay : STD_LOGIC;
  signal rgmii_rx_ctl_ibuf : STD_LOGIC;
  signal rgmii_rx_ctl_reg : STD_LOGIC;
  signal rgmii_rxc_ibuf : STD_LOGIC;
  signal rgmii_tx_ctl_obuf : STD_LOGIC;
  signal rgmii_tx_ctl_odelay : STD_LOGIC;
  signal rgmii_txc_obuf : STD_LOGIC;
  signal rgmii_txc_odelay : STD_LOGIC;
  signal NLW_ctl_output_S_UNCONNECTED : STD_LOGIC;
  signal NLW_delay_rgmii_rx_ctl_CNTVALUEOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_delay_rgmii_tx_clk_CNTVALUEOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_delay_rgmii_tx_ctl_CNTVALUEOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_rgmii_txc_ddr_S_UNCONNECTED : STD_LOGIC;
  signal \NLW_rxdata_bus[0].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_rxdata_bus[1].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_rxdata_bus[2].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_rxdata_bus[3].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_txdata_out_bus[0].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_txdata_out_bus[0].rgmii_txd_out_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_txdata_out_bus[1].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_txdata_out_bus[1].rgmii_txd_out_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_txdata_out_bus[2].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_txdata_out_bus[2].rgmii_txd_out_S_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_txdata_out_bus[3].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \NLW_txdata_out_bus[3].rgmii_txd_out_S_UNCONNECTED\ : STD_LOGIC;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of bufio_rgmii_rx_clk : label is "PRIMITIVE";
  attribute BOX_TYPE of bufr_rgmii_rx_clk : label is "PRIMITIVE";
  attribute BOX_TYPE of ctl_output : label is "PRIMITIVE";
  attribute \__SRVAL\ : string;
  attribute \__SRVAL\ of ctl_output : label is "FALSE";
  attribute BOX_TYPE of delay_rgmii_rx_ctl : label is "PRIMITIVE";
  attribute SIM_DELAY_D : integer;
  attribute SIM_DELAY_D of delay_rgmii_rx_ctl : label is 0;
  attribute BOX_TYPE of delay_rgmii_tx_clk : label is "PRIMITIVE";
  attribute SIM_DELAY_D of delay_rgmii_tx_clk : label is 0;
  attribute BOX_TYPE of delay_rgmii_tx_ctl : label is "PRIMITIVE";
  attribute SIM_DELAY_D of delay_rgmii_tx_ctl : label is 0;
  attribute BOX_TYPE of \ibuf_data[0].rgmii_rxd_ibuf_i\ : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of \ibuf_data[0].rgmii_rxd_ibuf_i\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of \ibuf_data[0].rgmii_rxd_ibuf_i\ : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of \ibuf_data[0].rgmii_rxd_ibuf_i\ : label is "AUTO";
  attribute BOX_TYPE of \ibuf_data[1].rgmii_rxd_ibuf_i\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \ibuf_data[1].rgmii_rxd_ibuf_i\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \ibuf_data[1].rgmii_rxd_ibuf_i\ : label is "0";
  attribute IFD_DELAY_VALUE of \ibuf_data[1].rgmii_rxd_ibuf_i\ : label is "AUTO";
  attribute BOX_TYPE of \ibuf_data[2].rgmii_rxd_ibuf_i\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \ibuf_data[2].rgmii_rxd_ibuf_i\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \ibuf_data[2].rgmii_rxd_ibuf_i\ : label is "0";
  attribute IFD_DELAY_VALUE of \ibuf_data[2].rgmii_rxd_ibuf_i\ : label is "AUTO";
  attribute BOX_TYPE of \ibuf_data[3].rgmii_rxd_ibuf_i\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \ibuf_data[3].rgmii_rxd_ibuf_i\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \ibuf_data[3].rgmii_rxd_ibuf_i\ : label is "0";
  attribute IFD_DELAY_VALUE of \ibuf_data[3].rgmii_rxd_ibuf_i\ : label is "AUTO";
  attribute BOX_TYPE of \obuf_data[0].rgmii_txd_obuf_i\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \obuf_data[0].rgmii_txd_obuf_i\ : label is "DONT_CARE";
  attribute BOX_TYPE of \obuf_data[1].rgmii_txd_obuf_i\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \obuf_data[1].rgmii_txd_obuf_i\ : label is "DONT_CARE";
  attribute BOX_TYPE of \obuf_data[2].rgmii_txd_obuf_i\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \obuf_data[2].rgmii_txd_obuf_i\ : label is "DONT_CARE";
  attribute BOX_TYPE of \obuf_data[3].rgmii_txd_obuf_i\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \obuf_data[3].rgmii_txd_obuf_i\ : label is "DONT_CARE";
  attribute BOX_TYPE of rgmii_rx_ctl_ibuf_i : label is "PRIMITIVE";
  attribute CAPACITANCE of rgmii_rx_ctl_ibuf_i : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of rgmii_rx_ctl_ibuf_i : label is "0";
  attribute IFD_DELAY_VALUE of rgmii_rx_ctl_ibuf_i : label is "AUTO";
  attribute BOX_TYPE of rgmii_rx_ctl_in : label is "PRIMITIVE";
  attribute \__SRVAL\ of rgmii_rx_ctl_in : label is "TRUE";
  attribute BOX_TYPE of rgmii_rxc_ibuf_i : label is "PRIMITIVE";
  attribute CAPACITANCE of rgmii_rxc_ibuf_i : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of rgmii_rxc_ibuf_i : label is "0";
  attribute IFD_DELAY_VALUE of rgmii_rxc_ibuf_i : label is "AUTO";
  attribute BOX_TYPE of rgmii_tx_ctl_obuf_i : label is "PRIMITIVE";
  attribute CAPACITANCE of rgmii_tx_ctl_obuf_i : label is "DONT_CARE";
  attribute BOX_TYPE of rgmii_txc_ddr : label is "PRIMITIVE";
  attribute \__SRVAL\ of rgmii_txc_ddr : label is "FALSE";
  attribute BOX_TYPE of rgmii_txc_obuf_i : label is "PRIMITIVE";
  attribute CAPACITANCE of rgmii_txc_obuf_i : label is "DONT_CARE";
  attribute BOX_TYPE of \rxdata_bus[0].delay_rgmii_rxd\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \rxdata_bus[0].delay_rgmii_rxd\ : label is 0;
  attribute BOX_TYPE of \rxdata_bus[1].delay_rgmii_rxd\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \rxdata_bus[1].delay_rgmii_rxd\ : label is 0;
  attribute BOX_TYPE of \rxdata_bus[2].delay_rgmii_rxd\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \rxdata_bus[2].delay_rgmii_rxd\ : label is 0;
  attribute BOX_TYPE of \rxdata_bus[3].delay_rgmii_rxd\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \rxdata_bus[3].delay_rgmii_rxd\ : label is 0;
  attribute BOX_TYPE of \rxdata_in_bus[0].rgmii_rx_data_in\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \rxdata_in_bus[0].rgmii_rx_data_in\ : label is "TRUE";
  attribute BOX_TYPE of \rxdata_in_bus[1].rgmii_rx_data_in\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \rxdata_in_bus[1].rgmii_rx_data_in\ : label is "TRUE";
  attribute BOX_TYPE of \rxdata_in_bus[2].rgmii_rx_data_in\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \rxdata_in_bus[2].rgmii_rx_data_in\ : label is "TRUE";
  attribute BOX_TYPE of \rxdata_in_bus[3].rgmii_rx_data_in\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \rxdata_in_bus[3].rgmii_rx_data_in\ : label is "TRUE";
  attribute BOX_TYPE of \txdata_out_bus[0].delay_rgmii_txd\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \txdata_out_bus[0].delay_rgmii_txd\ : label is 0;
  attribute BOX_TYPE of \txdata_out_bus[0].rgmii_txd_out\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \txdata_out_bus[0].rgmii_txd_out\ : label is "FALSE";
  attribute BOX_TYPE of \txdata_out_bus[1].delay_rgmii_txd\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \txdata_out_bus[1].delay_rgmii_txd\ : label is 0;
  attribute BOX_TYPE of \txdata_out_bus[1].rgmii_txd_out\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \txdata_out_bus[1].rgmii_txd_out\ : label is "FALSE";
  attribute BOX_TYPE of \txdata_out_bus[2].delay_rgmii_txd\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \txdata_out_bus[2].delay_rgmii_txd\ : label is 0;
  attribute BOX_TYPE of \txdata_out_bus[2].rgmii_txd_out\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \txdata_out_bus[2].rgmii_txd_out\ : label is "FALSE";
  attribute BOX_TYPE of \txdata_out_bus[3].delay_rgmii_txd\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \txdata_out_bus[3].delay_rgmii_txd\ : label is 0;
  attribute BOX_TYPE of \txdata_out_bus[3].rgmii_txd_out\ : label is "PRIMITIVE";
  attribute \__SRVAL\ of \txdata_out_bus[3].rgmii_txd_out\ : label is "FALSE";
begin
  D(7 downto 0) <= \^d\(7 downto 0);
  O1 <= \^o1\;
  gmii_rx_dv_int <= \^gmii_rx_dv_int\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
bufio_rgmii_rx_clk: unisim.vcomponents.BUFIO
    port map (
      I => rgmii_rxc_ibuf,
      O => rgmii_rx_clk_bufio
    );
bufr_rgmii_rx_clk: unisim.vcomponents.BUFR
    generic map(
      BUFR_DIVIDE => "BYPASS",
      SIM_DEVICE => "7SERIES"
    )
    port map (
      CE => \<const1>\,
      CLR => \<const0>\,
      I => rgmii_rxc_ibuf,
      O => \^o1\
    );
\clock_speed_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => \^o1\,
      CE => inband_ce,
      D => \^d\(1),
      Q => inband_clock_speed(0),
      R => I2
    );
\clock_speed_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => \^o1\,
      CE => inband_ce,
      D => \^d\(2),
      Q => inband_clock_speed(1),
      R => I2
    );
control_enable_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => I3,
      Q => control_enable,
      R => \<const0>\
    );
ctl_output: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "SYNC"
    )
    port map (
      C => gtx_clk,
      CE => control_enable,
      D1 => tx_en_to_ddr,
      D2 => rgmii_tx_ctl_int,
      Q => rgmii_tx_ctl_odelay,
      R => I1,
      S => NLW_ctl_output_S_UNCONNECTED
    );
delay_rgmii_rx_ctl: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "FIXED",
      IDELAY_VALUE => 13,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => \<const0>\,
      CE => \<const0>\,
      CINVCTRL => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => NLW_delay_rgmii_rx_ctl_CNTVALUEOUT_UNCONNECTED(4 downto 0),
      DATAIN => \<const0>\,
      DATAOUT => rgmii_rx_ctl_delay,
      IDATAIN => rgmii_rx_ctl_ibuf,
      INC => \<const0>\,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      REGRST => \<const0>\
    );
delay_rgmii_tx_clk: unisim.vcomponents.ODELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "ODATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IS_C_INVERTED => '0',
      IS_ODATAIN_INVERTED => '0',
      ODELAY_TYPE => "FIXED",
      ODELAY_VALUE => 26,
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => \<const0>\,
      CE => \<const0>\,
      CINVCTRL => \<const0>\,
      CLKIN => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => NLW_delay_rgmii_tx_clk_CNTVALUEOUT_UNCONNECTED(4 downto 0),
      DATAOUT => rgmii_txc_obuf,
      INC => \<const0>\,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      ODATAIN => rgmii_txc_odelay,
      REGRST => \<const0>\
    );
delay_rgmii_tx_ctl: unisim.vcomponents.ODELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "ODATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IS_C_INVERTED => '0',
      IS_ODATAIN_INVERTED => '0',
      ODELAY_TYPE => "FIXED",
      ODELAY_VALUE => 0,
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => \<const0>\,
      CE => \<const0>\,
      CINVCTRL => \<const0>\,
      CLKIN => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => NLW_delay_rgmii_tx_ctl_CNTVALUEOUT_UNCONNECTED(4 downto 0),
      DATAOUT => rgmii_tx_ctl_obuf,
      INC => \<const0>\,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      ODATAIN => rgmii_tx_ctl_odelay,
      REGRST => \<const0>\
    );
duplex_status_reg: unisim.vcomponents.FDRE
    port map (
      C => \^o1\,
      CE => inband_ce,
      D => \^d\(3),
      Q => inband_duplex_status,
      R => I2
    );
\ibuf_data[0].rgmii_rxd_ibuf_i\: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => rgmii_rxd(0),
      O => p_6_in
    );
\ibuf_data[1].rgmii_rxd_ibuf_i\: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => rgmii_rxd(1),
      O => p_4_in
    );
\ibuf_data[2].rgmii_rxd_ibuf_i\: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => rgmii_rxd(2),
      O => p_2_in
    );
\ibuf_data[3].rgmii_rxd_ibuf_i\: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => rgmii_rxd(3),
      O => p_0_in
    );
link_status_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => rgmii_rx_ctl_reg,
      I1 => \^gmii_rx_dv_int\,
      O => inband_ce
    );
link_status_reg: unisim.vcomponents.FDRE
    port map (
      C => \^o1\,
      CE => inband_ce,
      D => \^d\(0),
      Q => inband_link_status,
      R => I2
    );
\obuf_data[0].rgmii_txd_obuf_i\: unisim.vcomponents.OBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => \n_0_txdata_out_bus[0].delay_rgmii_txd\,
      O => rgmii_txd(0)
    );
\obuf_data[1].rgmii_txd_obuf_i\: unisim.vcomponents.OBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => p_2_out,
      O => rgmii_txd(1)
    );
\obuf_data[2].rgmii_txd_obuf_i\: unisim.vcomponents.OBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => \n_0_txdata_out_bus[2].delay_rgmii_txd\,
      O => rgmii_txd(2)
    );
\obuf_data[3].rgmii_txd_obuf_i\: unisim.vcomponents.OBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => p_0_out,
      O => rgmii_txd(3)
    );
rgmii_rx_ctl_ibuf_i: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => rgmii_rx_ctl,
      O => rgmii_rx_ctl_ibuf
    );
rgmii_rx_ctl_in: unisim.vcomponents.IDDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      SRTYPE => "SYNC"
    )
    port map (
      C => rgmii_rx_clk_bufio,
      CE => \<const1>\,
      D => rgmii_rx_ctl_delay,
      Q1 => \^gmii_rx_dv_int\,
      Q2 => rgmii_rx_ctl_reg,
      R => \<const0>\,
      S => \<const0>\
    );
rgmii_rxc_ibuf_i: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => rgmii_rxc,
      O => rgmii_rxc_ibuf
    );
rgmii_tx_ctl_obuf_i: unisim.vcomponents.OBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => rgmii_tx_ctl_obuf,
      O => rgmii_tx_ctl
    );
rgmii_txc_ddr: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "SYNC"
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D1 => clk_div5_shift,
      D2 => clk_div5,
      Q => rgmii_txc_odelay,
      R => I1,
      S => NLW_rgmii_txc_ddr_S_UNCONNECTED
    );
rgmii_txc_obuf_i: unisim.vcomponents.OBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
    port map (
      I => rgmii_txc_obuf,
      O => rgmii_txc
    );
rx_er_reg1_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^gmii_rx_dv_int\,
      I1 => rgmii_rx_ctl_reg,
      O => gmii_rx_er_int
    );
\rxdata_bus[0].delay_rgmii_rxd\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "FIXED",
      IDELAY_VALUE => 13,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => \<const0>\,
      CE => \<const0>\,
      CINVCTRL => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_rxdata_bus[0].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAIN => \<const0>\,
      DATAOUT => p_9_in,
      IDATAIN => p_6_in,
      INC => \<const0>\,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      REGRST => \<const0>\
    );
\rxdata_bus[1].delay_rgmii_rxd\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "FIXED",
      IDELAY_VALUE => 13,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => \<const0>\,
      CE => \<const0>\,
      CINVCTRL => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_rxdata_bus[1].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAIN => \<const0>\,
      DATAOUT => \n_0_rxdata_bus[1].delay_rgmii_rxd\,
      IDATAIN => p_4_in,
      INC => \<const0>\,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      REGRST => \<const0>\
    );
\rxdata_bus[2].delay_rgmii_rxd\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "FIXED",
      IDELAY_VALUE => 13,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => \<const0>\,
      CE => \<const0>\,
      CINVCTRL => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_rxdata_bus[2].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAIN => \<const0>\,
      DATAOUT => p_3_in,
      IDATAIN => p_2_in,
      INC => \<const0>\,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      REGRST => \<const0>\
    );
\rxdata_bus[3].delay_rgmii_rxd\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "FIXED",
      IDELAY_VALUE => 13,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => \<const0>\,
      CE => \<const0>\,
      CINVCTRL => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_rxdata_bus[3].delay_rgmii_rxd_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAIN => \<const0>\,
      DATAOUT => \n_0_rxdata_bus[3].delay_rgmii_rxd\,
      IDATAIN => p_0_in,
      INC => \<const0>\,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      REGRST => \<const0>\
    );
\rxdata_in_bus[0].rgmii_rx_data_in\: unisim.vcomponents.IDDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      SRTYPE => "SYNC"
    )
    port map (
      C => rgmii_rx_clk_bufio,
      CE => \<const1>\,
      D => p_9_in,
      Q1 => \^d\(0),
      Q2 => \^d\(4),
      R => \<const0>\,
      S => \<const0>\
    );
\rxdata_in_bus[1].rgmii_rx_data_in\: unisim.vcomponents.IDDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      SRTYPE => "SYNC"
    )
    port map (
      C => rgmii_rx_clk_bufio,
      CE => \<const1>\,
      D => \n_0_rxdata_bus[1].delay_rgmii_rxd\,
      Q1 => \^d\(1),
      Q2 => \^d\(5),
      R => \<const0>\,
      S => \<const0>\
    );
\rxdata_in_bus[2].rgmii_rx_data_in\: unisim.vcomponents.IDDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      SRTYPE => "SYNC"
    )
    port map (
      C => rgmii_rx_clk_bufio,
      CE => \<const1>\,
      D => p_3_in,
      Q1 => \^d\(2),
      Q2 => \^d\(6),
      R => \<const0>\,
      S => \<const0>\
    );
\rxdata_in_bus[3].rgmii_rx_data_in\: unisim.vcomponents.IDDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      SRTYPE => "SYNC"
    )
    port map (
      C => rgmii_rx_clk_bufio,
      CE => \<const1>\,
      D => \n_0_rxdata_bus[3].delay_rgmii_rxd\,
      Q1 => \^d\(3),
      Q2 => \^d\(7),
      R => \<const0>\,
      S => \<const0>\
    );
\txdata_out_bus[0].delay_rgmii_txd\: unisim.vcomponents.ODELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "ODATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IS_C_INVERTED => '0',
      IS_ODATAIN_INVERTED => '0',
      ODELAY_TYPE => "FIXED",
      ODELAY_VALUE => 0,
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => \<const0>\,
      CE => \<const0>\,
      CINVCTRL => \<const0>\,
      CLKIN => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_txdata_out_bus[0].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAOUT => \n_0_txdata_out_bus[0].delay_rgmii_txd\,
      INC => \<const0>\,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      ODATAIN => \n_0_txdata_out_bus[0].rgmii_txd_out\,
      REGRST => \<const0>\
    );
\txdata_out_bus[0].rgmii_txd_out\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "SYNC"
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D1 => Q(0),
      D2 => gmii_txd_falling(0),
      Q => \n_0_txdata_out_bus[0].rgmii_txd_out\,
      R => I1,
      S => \NLW_txdata_out_bus[0].rgmii_txd_out_S_UNCONNECTED\
    );
\txdata_out_bus[1].delay_rgmii_txd\: unisim.vcomponents.ODELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "ODATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IS_C_INVERTED => '0',
      IS_ODATAIN_INVERTED => '0',
      ODELAY_TYPE => "FIXED",
      ODELAY_VALUE => 0,
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => \<const0>\,
      CE => \<const0>\,
      CINVCTRL => \<const0>\,
      CLKIN => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_txdata_out_bus[1].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAOUT => p_2_out,
      INC => \<const0>\,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      ODATAIN => \n_0_txdata_out_bus[1].rgmii_txd_out\,
      REGRST => \<const0>\
    );
\txdata_out_bus[1].rgmii_txd_out\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "SYNC"
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D1 => Q(1),
      D2 => gmii_txd_falling(1),
      Q => \n_0_txdata_out_bus[1].rgmii_txd_out\,
      R => I1,
      S => \NLW_txdata_out_bus[1].rgmii_txd_out_S_UNCONNECTED\
    );
\txdata_out_bus[2].delay_rgmii_txd\: unisim.vcomponents.ODELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "ODATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IS_C_INVERTED => '0',
      IS_ODATAIN_INVERTED => '0',
      ODELAY_TYPE => "FIXED",
      ODELAY_VALUE => 0,
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => \<const0>\,
      CE => \<const0>\,
      CINVCTRL => \<const0>\,
      CLKIN => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_txdata_out_bus[2].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAOUT => \n_0_txdata_out_bus[2].delay_rgmii_txd\,
      INC => \<const0>\,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      ODATAIN => \n_0_txdata_out_bus[2].rgmii_txd_out\,
      REGRST => \<const0>\
    );
\txdata_out_bus[2].rgmii_txd_out\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "SYNC"
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D1 => Q(2),
      D2 => gmii_txd_falling(2),
      Q => \n_0_txdata_out_bus[2].rgmii_txd_out\,
      R => I1,
      S => \NLW_txdata_out_bus[2].rgmii_txd_out_S_UNCONNECTED\
    );
\txdata_out_bus[3].delay_rgmii_txd\: unisim.vcomponents.ODELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "ODATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IS_C_INVERTED => '0',
      IS_ODATAIN_INVERTED => '0',
      ODELAY_TYPE => "FIXED",
      ODELAY_VALUE => 0,
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
    port map (
      C => \<const0>\,
      CE => \<const0>\,
      CINVCTRL => \<const0>\,
      CLKIN => \<const0>\,
      CNTVALUEIN(4) => \<const0>\,
      CNTVALUEIN(3) => \<const0>\,
      CNTVALUEIN(2) => \<const0>\,
      CNTVALUEIN(1) => \<const0>\,
      CNTVALUEIN(0) => \<const0>\,
      CNTVALUEOUT(4 downto 0) => \NLW_txdata_out_bus[3].delay_rgmii_txd_CNTVALUEOUT_UNCONNECTED\(4 downto 0),
      DATAOUT => p_0_out,
      INC => \<const0>\,
      LD => \<const0>\,
      LDPIPEEN => \<const0>\,
      ODATAIN => \n_0_txdata_out_bus[3].rgmii_txd_out\,
      REGRST => \<const0>\
    );
\txdata_out_bus[3].rgmii_txd_out\: unisim.vcomponents.ODDR
    generic map(
      DDR_CLK_EDGE => "SAME_EDGE",
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D1_INVERTED => '0',
      IS_D2_INVERTED => '0',
      SRTYPE => "SYNC"
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D1 => Q(3),
      D2 => gmii_txd_falling(3),
      Q => \n_0_txdata_out_bus[3].rgmii_txd_out\,
      R => I1,
      S => \NLW_txdata_out_bus[3].rgmii_txd_out_S_UNCONNECTED\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_rx is
  port (
    alignment_err_reg : out STD_LOGIC;
    int_alignment_err_pulse : out STD_LOGIC;
    gmii_rx_dv_from_mii : out STD_LOGIC;
    gmii_rx_er_from_mii : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 7 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    gmii_rx_dv_int : in STD_LOGIC;
    I1 : in STD_LOGIC;
    gmii_rx_er_int : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
end TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_rx;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_rx is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^int_alignment_err_pulse\ : STD_LOGIC;
  signal muxsel : STD_LOGIC;
  signal muxsel0 : STD_LOGIC;
  signal n_0_RX_ERR_REG1_i_2 : STD_LOGIC;
  signal \n_0_muxsel_i_1__0\ : STD_LOGIC;
  signal n_0_nibble_toggle_i_1 : STD_LOGIC;
  signal n_0_rx_dv_reg3_i_1 : STD_LOGIC;
  signal n_0_sfd_comb_reg1_i_2 : STD_LOGIC;
  signal n_0_sfd_enable_i_1 : STD_LOGIC;
  signal n_0_sfd_enable_i_2 : STD_LOGIC;
  signal n_0_sfd_enable_i_3 : STD_LOGIC;
  signal n_0_sfd_enable_reg : STD_LOGIC;
  signal nibble_toggle : STD_LOGIC;
  signal no_error : STD_LOGIC;
  signal no_error_reg1 : STD_LOGIC;
  signal no_error_reg2 : STD_LOGIC;
  signal rx_dv_reg1 : STD_LOGIC;
  signal rx_dv_reg2 : STD_LOGIC;
  signal rx_dv_reg3 : STD_LOGIC;
  signal rx_er_reg1 : STD_LOGIC;
  signal rx_er_reg2 : STD_LOGIC;
  signal rx_er_reg3 : STD_LOGIC;
  signal rx_er_reg4 : STD_LOGIC;
  signal rxd_reg1 : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal \rxd_reg1__0\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rxd_reg2 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rxd_reg3 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rxd_reg4 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal sfd_comb_reg1 : STD_LOGIC;
  signal sfd_comb_reg2 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of alignment_err_reg_i_1 : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of nibble_toggle_i_1 : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of no_error_reg1_i_1 : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of sfd_comb_reg1_i_1 : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of sfd_enable_i_2 : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of sfd_enable_i_3 : label is "soft_lutpair72";
begin
  int_alignment_err_pulse <= \^int_alignment_err_pulse\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\RXD_REG1[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => \rxd_reg1__0\(0),
      I1 => tx_configuration_vector(0),
      I2 => rxd_reg4(0),
      I3 => muxsel,
      I4 => rxd_reg3(0),
      O => D(0)
    );
\RXD_REG1[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => \rxd_reg1__0\(1),
      I1 => tx_configuration_vector(0),
      I2 => rxd_reg4(1),
      I3 => muxsel,
      I4 => rxd_reg3(1),
      O => D(1)
    );
\RXD_REG1[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => \rxd_reg1__0\(2),
      I1 => tx_configuration_vector(0),
      I2 => rxd_reg4(2),
      I3 => muxsel,
      I4 => rxd_reg3(2),
      O => D(2)
    );
\RXD_REG1[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => \rxd_reg1__0\(3),
      I1 => tx_configuration_vector(0),
      I2 => rxd_reg4(3),
      I3 => muxsel,
      I4 => rxd_reg3(3),
      O => D(3)
    );
\RXD_REG1[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rxd_reg1(4),
      I1 => tx_configuration_vector(0),
      I2 => rxd_reg3(0),
      I3 => muxsel,
      I4 => rxd_reg2(0),
      O => D(4)
    );
\RXD_REG1[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rxd_reg1(5),
      I1 => tx_configuration_vector(0),
      I2 => rxd_reg3(1),
      I3 => muxsel,
      I4 => rxd_reg2(1),
      O => D(5)
    );
\RXD_REG1[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rxd_reg1(6),
      I1 => tx_configuration_vector(0),
      I2 => rxd_reg3(2),
      I3 => muxsel,
      I4 => rxd_reg2(2),
      O => D(6)
    );
\RXD_REG1[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rxd_reg1(7),
      I1 => tx_configuration_vector(0),
      I2 => rxd_reg3(3),
      I3 => muxsel,
      I4 => rxd_reg2(3),
      O => D(7)
    );
RX_DV_REG1_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => rx_dv_reg1,
      I1 => tx_configuration_vector(0),
      I2 => rx_dv_reg3,
      O => gmii_rx_dv_from_mii
    );
RX_ERR_REG1_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBBBBBB8888B888"
    )
    port map (
      I0 => rx_er_reg1,
      I1 => tx_configuration_vector(0),
      I2 => rx_dv_reg2,
      I3 => rx_er_reg2,
      I4 => sfd_comb_reg2,
      I5 => n_0_RX_ERR_REG1_i_2,
      O => gmii_rx_er_from_mii
    );
RX_ERR_REG1_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEEE"
    )
    port map (
      I0 => rx_er_reg3,
      I1 => no_error_reg2,
      I2 => rx_er_reg4,
      I3 => muxsel,
      O => n_0_RX_ERR_REG1_i_2
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
alignment_err_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0008"
    )
    port map (
      I0 => nibble_toggle,
      I1 => rx_dv_reg2,
      I2 => tx_configuration_vector(0),
      I3 => rx_dv_reg1,
      O => \^int_alignment_err_pulse\
    );
alignment_err_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \^int_alignment_err_pulse\,
      Q => alignment_err_reg,
      R => SR(0)
    );
\muxsel_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000000FF7F"
    )
    port map (
      I0 => n_0_sfd_enable_reg,
      I1 => n_0_sfd_comb_reg1_i_2,
      I2 => rxd_reg2(2),
      I3 => rxd_reg2(1),
      I4 => SR(0),
      I5 => muxsel,
      O => \n_0_muxsel_i_1__0\
    );
muxsel_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_muxsel_i_1__0\,
      Q => muxsel,
      R => \<const0>\
    );
nibble_toggle_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => rx_dv_reg2,
      I1 => nibble_toggle,
      O => n_0_nibble_toggle_i_1
    );
nibble_toggle_reg: unisim.vcomponents.FDCE
    port map (
      C => I1,
      CE => \<const1>\,
      CLR => n_0_sfd_enable_reg,
      D => n_0_nibble_toggle_i_1,
      Q => nibble_toggle
    );
no_error_reg1_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => sfd_comb_reg2,
      I1 => rx_er_reg2,
      I2 => rx_dv_reg2,
      O => no_error
    );
no_error_reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => no_error,
      Q => no_error_reg1,
      R => SR(0)
    );
no_error_reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => no_error_reg1,
      Q => no_error_reg2,
      R => SR(0)
    );
rx_dv_reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => gmii_rx_dv_int,
      Q => rx_dv_reg1,
      R => SR(0)
    );
rx_dv_reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => rx_dv_reg1,
      Q => rx_dv_reg2,
      R => SR(0)
    );
rx_dv_reg3_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F0F0E0F0"
    )
    port map (
      I0 => rx_dv_reg1,
      I1 => tx_configuration_vector(0),
      I2 => rx_dv_reg2,
      I3 => nibble_toggle,
      I4 => rx_er_reg2,
      I5 => SR(0),
      O => n_0_rx_dv_reg3_i_1
    );
rx_dv_reg3_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_rx_dv_reg3_i_1,
      Q => rx_dv_reg3,
      R => \<const0>\
    );
rx_er_reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => gmii_rx_er_int,
      Q => rx_er_reg1,
      R => SR(0)
    );
rx_er_reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => rx_er_reg1,
      Q => rx_er_reg2,
      R => SR(0)
    );
rx_er_reg3_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => rx_er_reg2,
      Q => rx_er_reg3,
      R => SR(0)
    );
rx_er_reg4_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => rx_er_reg3,
      Q => rx_er_reg4,
      R => SR(0)
    );
\rxd_reg1_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => I2(0),
      Q => \rxd_reg1__0\(0),
      R => SR(0)
    );
\rxd_reg1_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => I2(1),
      Q => \rxd_reg1__0\(1),
      R => SR(0)
    );
\rxd_reg1_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => I2(2),
      Q => \rxd_reg1__0\(2),
      R => SR(0)
    );
\rxd_reg1_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => I2(3),
      Q => \rxd_reg1__0\(3),
      R => SR(0)
    );
\rxd_reg1_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => I2(4),
      Q => rxd_reg1(4),
      R => SR(0)
    );
\rxd_reg1_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => I2(5),
      Q => rxd_reg1(5),
      R => SR(0)
    );
\rxd_reg1_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => I2(6),
      Q => rxd_reg1(6),
      R => SR(0)
    );
\rxd_reg1_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => I2(7),
      Q => rxd_reg1(7),
      R => SR(0)
    );
\rxd_reg2_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => \rxd_reg1__0\(0),
      Q => rxd_reg2(0),
      R => SR(0)
    );
\rxd_reg2_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => \rxd_reg1__0\(1),
      Q => rxd_reg2(1),
      R => SR(0)
    );
\rxd_reg2_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => \rxd_reg1__0\(2),
      Q => rxd_reg2(2),
      R => SR(0)
    );
\rxd_reg2_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => \rxd_reg1__0\(3),
      Q => rxd_reg2(3),
      R => SR(0)
    );
\rxd_reg3_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => rxd_reg2(0),
      Q => rxd_reg3(0),
      R => SR(0)
    );
\rxd_reg3_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => rxd_reg2(1),
      Q => rxd_reg3(1),
      R => SR(0)
    );
\rxd_reg3_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => rxd_reg2(2),
      Q => rxd_reg3(2),
      R => SR(0)
    );
\rxd_reg3_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => rxd_reg2(3),
      Q => rxd_reg3(3),
      R => SR(0)
    );
\rxd_reg4_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => rxd_reg3(0),
      Q => rxd_reg4(0),
      R => SR(0)
    );
\rxd_reg4_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => rxd_reg3(1),
      Q => rxd_reg4(1),
      R => SR(0)
    );
\rxd_reg4_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => rxd_reg3(2),
      Q => rxd_reg4(2),
      R => SR(0)
    );
\rxd_reg4_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => rxd_reg3(3),
      Q => rxd_reg4(3),
      R => SR(0)
    );
sfd_comb_reg1_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => n_0_sfd_enable_reg,
      I1 => n_0_sfd_comb_reg1_i_2,
      I2 => rxd_reg2(2),
      I3 => rxd_reg2(1),
      O => muxsel0
    );
sfd_comb_reg1_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000040000000"
    )
    port map (
      I0 => rxd_reg2(3),
      I1 => rxd_reg2(0),
      I2 => \rxd_reg1__0\(2),
      I3 => \rxd_reg1__0\(3),
      I4 => \rxd_reg1__0\(0),
      I5 => \rxd_reg1__0\(1),
      O => n_0_sfd_comb_reg1_i_2
    );
sfd_comb_reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => muxsel0,
      Q => sfd_comb_reg1,
      R => SR(0)
    );
sfd_comb_reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => sfd_comb_reg1,
      Q => sfd_comb_reg2,
      R => SR(0)
    );
sfd_enable_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFEF0000FF00"
    )
    port map (
      I0 => rx_er_reg2,
      I1 => rx_er_reg1,
      I2 => n_0_sfd_enable_i_2,
      I3 => n_0_sfd_enable_i_3,
      I4 => SR(0),
      I5 => n_0_sfd_enable_reg,
      O => n_0_sfd_enable_i_1
    );
sfd_enable_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
    port map (
      I0 => rxd_reg2(1),
      I1 => rxd_reg2(2),
      I2 => n_0_sfd_comb_reg1_i_2,
      O => n_0_sfd_enable_i_2
    );
sfd_enable_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => rx_dv_reg1,
      I1 => rx_dv_reg2,
      O => n_0_sfd_enable_i_3
    );
sfd_enable_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_sfd_enable_i_1,
      Q => n_0_sfd_enable_reg,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_tx is
  port (
    O1 : out STD_LOGIC;
    rgmii_tx_ctl_int : out STD_LOGIC;
    gmii_txd_falling : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    tx_en_to_ddr : out STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    I1 : in STD_LOGIC;
    phy_tx_enable : in STD_LOGIC;
    int_gmii_tx_en : in STD_LOGIC;
    int_gmii_tx_er : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk_div5 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    D : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
end TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_tx;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_tx is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal gmii_tx_en_int : STD_LOGIC;
  signal gmii_tx_er_int : STD_LOGIC;
  signal gmii_txd_int : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal muxsel : STD_LOGIC;
  signal n_0_gmii_tx_en_to_phy_i_1 : STD_LOGIC;
  signal n_0_gmii_tx_er_to_phy_i_1 : STD_LOGIC;
  signal \n_0_gmii_txd_to_phy[0]_i_1\ : STD_LOGIC;
  signal \n_0_gmii_txd_to_phy[1]_i_1\ : STD_LOGIC;
  signal \n_0_gmii_txd_to_phy[2]_i_1\ : STD_LOGIC;
  signal \n_0_gmii_txd_to_phy[3]_i_1\ : STD_LOGIC;
  signal \n_0_gmii_txd_to_phy[4]_i_1\ : STD_LOGIC;
  signal \n_0_gmii_txd_to_phy[5]_i_1\ : STD_LOGIC;
  signal \n_0_gmii_txd_to_phy[6]_i_1\ : STD_LOGIC;
  signal \n_0_gmii_txd_to_phy[7]_i_2\ : STD_LOGIC;
  signal n_0_muxsel_i_1 : STD_LOGIC;
  signal tx_en_reg1 : STD_LOGIC;
  signal tx_en_reg2 : STD_LOGIC;
  signal tx_er_reg1 : STD_LOGIC;
  signal tx_er_reg2 : STD_LOGIC;
  signal txd_reg1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal txd_reg2 : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of ctl_output_i_1 : label is "soft_lutpair113";
  attribute SOFT_HLUTNM of ctl_output_i_2 : label is "soft_lutpair113";
  attribute SOFT_HLUTNM of \gmii_txd_to_phy[4]_i_1\ : label is "soft_lutpair116";
  attribute SOFT_HLUTNM of \gmii_txd_to_phy[5]_i_1\ : label is "soft_lutpair117";
  attribute SOFT_HLUTNM of \gmii_txd_to_phy[6]_i_1\ : label is "soft_lutpair117";
  attribute SOFT_HLUTNM of \gmii_txd_to_phy[7]_i_2\ : label is "soft_lutpair116";
  attribute SOFT_HLUTNM of \txdata_out_bus[0].rgmii_txd_out_i_1\ : label is "soft_lutpair115";
  attribute SOFT_HLUTNM of \txdata_out_bus[1].rgmii_txd_out_i_1\ : label is "soft_lutpair115";
  attribute SOFT_HLUTNM of \txdata_out_bus[2].rgmii_txd_out_i_1\ : label is "soft_lutpair114";
  attribute SOFT_HLUTNM of \txdata_out_bus[3].rgmii_txd_out_i_1\ : label is "soft_lutpair114";
begin
  Q(3 downto 0) <= \^q\(3 downto 0);
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
ctl_output_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA8A"
    )
    port map (
      I0 => gmii_tx_en_int,
      I1 => clk_div5,
      I2 => gmii_tx_er_int,
      I3 => tx_configuration_vector(0),
      O => tx_en_to_ddr
    );
ctl_output_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => gmii_tx_er_int,
      I1 => gmii_tx_en_int,
      O => rgmii_tx_ctl_int
    );
gmii_tx_en_to_phy_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EEE222E2"
    )
    port map (
      I0 => gmii_tx_en_int,
      I1 => phy_tx_enable,
      I2 => tx_en_reg2,
      I3 => tx_configuration_vector(0),
      I4 => tx_en_reg1,
      I5 => I2,
      O => n_0_gmii_tx_en_to_phy_i_1
    );
gmii_tx_en_to_phy_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_gmii_tx_en_to_phy_i_1,
      Q => gmii_tx_en_int,
      R => \<const0>\
    );
gmii_tx_er_to_phy_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EEE222E2"
    )
    port map (
      I0 => gmii_tx_er_int,
      I1 => phy_tx_enable,
      I2 => tx_er_reg2,
      I3 => tx_configuration_vector(0),
      I4 => tx_er_reg1,
      I5 => I2,
      O => n_0_gmii_tx_er_to_phy_i_1
    );
gmii_tx_er_to_phy_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_gmii_tx_er_to_phy_i_1,
      Q => gmii_tx_er_int,
      R => \<const0>\
    );
\gmii_txd_to_phy[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => txd_reg1(0),
      I1 => tx_configuration_vector(0),
      I2 => txd_reg2(4),
      I3 => muxsel,
      I4 => txd_reg2(0),
      O => \n_0_gmii_txd_to_phy[0]_i_1\
    );
\gmii_txd_to_phy[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => txd_reg1(1),
      I1 => tx_configuration_vector(0),
      I2 => txd_reg2(5),
      I3 => muxsel,
      I4 => txd_reg2(1),
      O => \n_0_gmii_txd_to_phy[1]_i_1\
    );
\gmii_txd_to_phy[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => txd_reg1(2),
      I1 => tx_configuration_vector(0),
      I2 => txd_reg2(6),
      I3 => muxsel,
      I4 => txd_reg2(2),
      O => \n_0_gmii_txd_to_phy[2]_i_1\
    );
\gmii_txd_to_phy[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => txd_reg1(3),
      I1 => tx_configuration_vector(0),
      I2 => txd_reg2(7),
      I3 => muxsel,
      I4 => txd_reg2(3),
      O => \n_0_gmii_txd_to_phy[3]_i_1\
    );
\gmii_txd_to_phy[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => txd_reg1(4),
      O => \n_0_gmii_txd_to_phy[4]_i_1\
    );
\gmii_txd_to_phy[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => txd_reg1(5),
      O => \n_0_gmii_txd_to_phy[5]_i_1\
    );
\gmii_txd_to_phy[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => txd_reg1(6),
      O => \n_0_gmii_txd_to_phy[6]_i_1\
    );
\gmii_txd_to_phy[7]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => txd_reg1(7),
      O => \n_0_gmii_txd_to_phy[7]_i_2\
    );
\gmii_txd_to_phy_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => \n_0_gmii_txd_to_phy[0]_i_1\,
      Q => \^q\(0),
      R => SR(0)
    );
\gmii_txd_to_phy_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => \n_0_gmii_txd_to_phy[1]_i_1\,
      Q => \^q\(1),
      R => SR(0)
    );
\gmii_txd_to_phy_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => \n_0_gmii_txd_to_phy[2]_i_1\,
      Q => \^q\(2),
      R => SR(0)
    );
\gmii_txd_to_phy_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => \n_0_gmii_txd_to_phy[3]_i_1\,
      Q => \^q\(3),
      R => SR(0)
    );
\gmii_txd_to_phy_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => \n_0_gmii_txd_to_phy[4]_i_1\,
      Q => gmii_txd_int(4),
      R => SR(0)
    );
\gmii_txd_to_phy_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => \n_0_gmii_txd_to_phy[5]_i_1\,
      Q => gmii_txd_int(5),
      R => SR(0)
    );
\gmii_txd_to_phy_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => \n_0_gmii_txd_to_phy[6]_i_1\,
      Q => gmii_txd_int(6),
      R => SR(0)
    );
\gmii_txd_to_phy_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => \n_0_gmii_txd_to_phy[7]_i_2\,
      Q => gmii_txd_int(7),
      R => SR(0)
    );
\hd_tieoff.extension_reg_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => O1,
      R => \<const0>\
    );
muxsel_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00005A1A"
    )
    port map (
      I0 => muxsel,
      I1 => tx_en_reg1,
      I2 => phy_tx_enable,
      I3 => tx_en_reg2,
      I4 => I1,
      O => n_0_muxsel_i_1
    );
muxsel_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_muxsel_i_1,
      Q => muxsel,
      R => \<const0>\
    );
tx_en_reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => int_gmii_tx_en,
      Q => tx_en_reg1,
      R => I1
    );
tx_en_reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => tx_en_reg1,
      Q => tx_en_reg2,
      R => I1
    );
tx_er_reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => int_gmii_tx_er,
      Q => tx_er_reg1,
      R => I1
    );
tx_er_reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => tx_er_reg1,
      Q => tx_er_reg2,
      R => I1
    );
\txd_reg1_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => D(0),
      Q => txd_reg1(0),
      R => I1
    );
\txd_reg1_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => D(1),
      Q => txd_reg1(1),
      R => I1
    );
\txd_reg1_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => D(2),
      Q => txd_reg1(2),
      R => I1
    );
\txd_reg1_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => D(3),
      Q => txd_reg1(3),
      R => I1
    );
\txd_reg1_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => D(4),
      Q => txd_reg1(4),
      R => I1
    );
\txd_reg1_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => D(5),
      Q => txd_reg1(5),
      R => I1
    );
\txd_reg1_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => D(6),
      Q => txd_reg1(6),
      R => I1
    );
\txd_reg1_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => D(7),
      Q => txd_reg1(7),
      R => I1
    );
\txd_reg2_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => txd_reg1(0),
      Q => txd_reg2(0),
      R => I1
    );
\txd_reg2_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => txd_reg1(1),
      Q => txd_reg2(1),
      R => I1
    );
\txd_reg2_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => txd_reg1(2),
      Q => txd_reg2(2),
      R => I1
    );
\txd_reg2_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => txd_reg1(3),
      Q => txd_reg2(3),
      R => I1
    );
\txd_reg2_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => txd_reg1(4),
      Q => txd_reg2(4),
      R => I1
    );
\txd_reg2_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => txd_reg1(5),
      Q => txd_reg2(5),
      R => I1
    );
\txd_reg2_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => txd_reg1(6),
      Q => txd_reg2(6),
      R => I1
    );
\txd_reg2_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => phy_tx_enable,
      D => txd_reg1(7),
      Q => txd_reg2(7),
      R => I1
    );
\txdata_out_bus[0].rgmii_txd_out_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => gmii_txd_int(4),
      I1 => tx_configuration_vector(0),
      I2 => \^q\(0),
      O => gmii_txd_falling(0)
    );
\txdata_out_bus[1].rgmii_txd_out_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => gmii_txd_int(5),
      I1 => tx_configuration_vector(0),
      I2 => \^q\(1),
      O => gmii_txd_falling(1)
    );
\txdata_out_bus[2].rgmii_txd_out_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => gmii_txd_int(6),
      I1 => tx_configuration_vector(0),
      I2 => \^q\(2),
      O => gmii_txd_falling(2)
    );
\txdata_out_bus[3].rgmii_txd_out_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => gmii_txd_int(7),
      I1 => tx_configuration_vector(0),
      I2 => \^q\(3),
      O => gmii_txd_falling(3)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_pfc_tx_cntl is
  port (
    pfc_req : out STD_LOGIC;
    pause_req_int0 : out STD_LOGIC;
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gtx_clk : in STD_LOGIC;
    pfc_tx_enable_sync : in STD_LOGIC;
    tx_enable_reg : in STD_LOGIC;
    pause_req : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    pfc_pause_req_out : in STD_LOGIC;
    pause_val : in STD_LOGIC_VECTOR ( 15 downto 0 );
    control_complete : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end TriMACtri_mode_ethernet_mac_v8_1_pfc_tx_cntl;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_pfc_tx_cntl is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \n_0_FSM_onehot_legacy_state[0]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_legacy_state[1]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_legacy_state[2]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_legacy_state[3]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_legacy_state[4]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_legacy_state_reg[0]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_legacy_state_reg[1]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_legacy_state_reg[2]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_legacy_state_reg[3]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_legacy_state_reg[4]\ : STD_LOGIC;
  signal \n_0_pause_state[0]_i_1\ : STD_LOGIC;
  signal \n_0_pause_state[1]_i_1\ : STD_LOGIC;
  signal \n_0_pause_state[1]_i_2\ : STD_LOGIC;
  signal \n_0_pause_value[0]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[10]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[11]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[12]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[13]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[14]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[15]_i_2__0\ : STD_LOGIC;
  signal \n_0_pause_value[1]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[2]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[3]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[4]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[5]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[6]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[7]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[8]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[9]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value_reg[0]\ : STD_LOGIC;
  signal \n_0_pause_value_reg[1]\ : STD_LOGIC;
  signal \n_0_pause_value_reg[2]\ : STD_LOGIC;
  signal \n_0_pause_value_reg[3]\ : STD_LOGIC;
  signal \n_0_pause_value_reg[4]\ : STD_LOGIC;
  signal \n_0_pause_value_reg[5]\ : STD_LOGIC;
  signal \n_0_pause_value_reg[6]\ : STD_LOGIC;
  signal \n_0_pause_value_reg[7]\ : STD_LOGIC;
  signal n_0_pfc_req_i_1 : STD_LOGIC;
  signal \n_0_pfc_valid[0]_i_1\ : STD_LOGIC;
  signal pause_req2_out : STD_LOGIC;
  signal pause_req_int : STD_LOGIC;
  signal pause_state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^pfc_req\ : STD_LOGIC;
  signal pfc_valid : STD_LOGIC;
  signal quanta_low : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_legacy_state[2]_i_1\ : label is "soft_lutpair162";
  attribute SOFT_HLUTNM of \FSM_onehot_legacy_state[3]_i_1\ : label is "soft_lutpair162";
  attribute SOFT_HLUTNM of pause_req_i_1 : label is "soft_lutpair163";
  attribute SOFT_HLUTNM of \pause_state[0]_i_1\ : label is "soft_lutpair161";
  attribute SOFT_HLUTNM of \pause_state[1]_i_1\ : label is "soft_lutpair161";
  attribute SOFT_HLUTNM of \pause_value[0]_i_1\ : label is "soft_lutpair175";
  attribute SOFT_HLUTNM of \pause_value[10]_i_1\ : label is "soft_lutpair169";
  attribute SOFT_HLUTNM of \pause_value[11]_i_1\ : label is "soft_lutpair168";
  attribute SOFT_HLUTNM of \pause_value[12]_i_1\ : label is "soft_lutpair171";
  attribute SOFT_HLUTNM of \pause_value[13]_i_1\ : label is "soft_lutpair170";
  attribute SOFT_HLUTNM of \pause_value[14]_i_1\ : label is "soft_lutpair169";
  attribute SOFT_HLUTNM of \pause_value[15]_i_2__0\ : label is "soft_lutpair168";
  attribute SOFT_HLUTNM of \pause_value[1]_i_1\ : label is "soft_lutpair175";
  attribute SOFT_HLUTNM of \pause_value[2]_i_1\ : label is "soft_lutpair174";
  attribute SOFT_HLUTNM of \pause_value[3]_i_1\ : label is "soft_lutpair174";
  attribute SOFT_HLUTNM of \pause_value[4]_i_1\ : label is "soft_lutpair173";
  attribute SOFT_HLUTNM of \pause_value[5]_i_1\ : label is "soft_lutpair172";
  attribute SOFT_HLUTNM of \pause_value[6]_i_1\ : label is "soft_lutpair173";
  attribute SOFT_HLUTNM of \pause_value[7]_i_1\ : label is "soft_lutpair171";
  attribute SOFT_HLUTNM of \pause_value[8]_i_1\ : label is "soft_lutpair172";
  attribute SOFT_HLUTNM of \pause_value[9]_i_1\ : label is "soft_lutpair170";
  attribute SOFT_HLUTNM of \pause_value_sample[0]_i_1\ : label is "soft_lutpair167";
  attribute SOFT_HLUTNM of \pause_value_sample[1]_i_1\ : label is "soft_lutpair167";
  attribute SOFT_HLUTNM of \pause_value_sample[2]_i_1\ : label is "soft_lutpair166";
  attribute SOFT_HLUTNM of \pause_value_sample[3]_i_1\ : label is "soft_lutpair165";
  attribute SOFT_HLUTNM of \pause_value_sample[4]_i_1\ : label is "soft_lutpair164";
  attribute SOFT_HLUTNM of \pause_value_sample[5]_i_1\ : label is "soft_lutpair166";
  attribute SOFT_HLUTNM of \pause_value_sample[6]_i_1\ : label is "soft_lutpair165";
  attribute SOFT_HLUTNM of \pause_value_sample[7]_i_2\ : label is "soft_lutpair164";
  attribute SOFT_HLUTNM of pfc_req_i_1 : label is "soft_lutpair163";
begin
  pfc_req <= \^pfc_req\;
\FSM_onehot_legacy_state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
    port map (
      I0 => \n_0_FSM_onehot_legacy_state_reg[2]\,
      I1 => \n_0_FSM_onehot_legacy_state_reg[1]\,
      I2 => \n_0_FSM_onehot_legacy_state_reg[4]\,
      I3 => \n_0_FSM_onehot_legacy_state_reg[0]\,
      I4 => \n_0_FSM_onehot_legacy_state_reg[3]\,
      O => \n_0_FSM_onehot_legacy_state[0]_i_1\
    );
\FSM_onehot_legacy_state[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
    port map (
      I0 => \n_0_FSM_onehot_legacy_state_reg[2]\,
      I1 => \n_0_FSM_onehot_legacy_state_reg[1]\,
      I2 => \n_0_FSM_onehot_legacy_state_reg[3]\,
      I3 => \n_0_FSM_onehot_legacy_state_reg[4]\,
      I4 => \n_0_FSM_onehot_legacy_state_reg[0]\,
      O => \n_0_FSM_onehot_legacy_state[1]_i_1\
    );
\FSM_onehot_legacy_state[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
    port map (
      I0 => \n_0_FSM_onehot_legacy_state_reg[0]\,
      I1 => \n_0_FSM_onehot_legacy_state_reg[4]\,
      I2 => \n_0_FSM_onehot_legacy_state_reg[3]\,
      I3 => \n_0_FSM_onehot_legacy_state_reg[2]\,
      I4 => \n_0_FSM_onehot_legacy_state_reg[1]\,
      O => \n_0_FSM_onehot_legacy_state[2]_i_1\
    );
\FSM_onehot_legacy_state[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000010"
    )
    port map (
      I0 => \n_0_FSM_onehot_legacy_state_reg[0]\,
      I1 => \n_0_FSM_onehot_legacy_state_reg[4]\,
      I2 => \n_0_FSM_onehot_legacy_state_reg[2]\,
      I3 => \n_0_FSM_onehot_legacy_state_reg[3]\,
      I4 => \n_0_FSM_onehot_legacy_state_reg[1]\,
      O => \n_0_FSM_onehot_legacy_state[3]_i_1\
    );
\FSM_onehot_legacy_state[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFEAFFFFAAEA"
    )
    port map (
      I0 => \n_0_FSM_onehot_legacy_state_reg[1]\,
      I1 => tx_enable_reg,
      I2 => pause_req,
      I3 => \n_0_FSM_onehot_legacy_state_reg[2]\,
      I4 => \n_0_FSM_onehot_legacy_state_reg[3]\,
      I5 => I1,
      O => \n_0_FSM_onehot_legacy_state[4]_i_1\
    );
\FSM_onehot_legacy_state_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => gtx_clk,
      CE => \n_0_FSM_onehot_legacy_state[4]_i_1\,
      D => \n_0_FSM_onehot_legacy_state[0]_i_1\,
      Q => \n_0_FSM_onehot_legacy_state_reg[0]\,
      S => I2
    );
\FSM_onehot_legacy_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \n_0_FSM_onehot_legacy_state[4]_i_1\,
      D => \n_0_FSM_onehot_legacy_state[1]_i_1\,
      Q => \n_0_FSM_onehot_legacy_state_reg[1]\,
      R => I2
    );
\FSM_onehot_legacy_state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \n_0_FSM_onehot_legacy_state[4]_i_1\,
      D => \n_0_FSM_onehot_legacy_state[2]_i_1\,
      Q => \n_0_FSM_onehot_legacy_state_reg[2]\,
      R => I2
    );
\FSM_onehot_legacy_state_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \n_0_FSM_onehot_legacy_state[4]_i_1\,
      D => \n_0_FSM_onehot_legacy_state[3]_i_1\,
      Q => \n_0_FSM_onehot_legacy_state_reg[3]\,
      R => I2
    );
\FSM_onehot_legacy_state_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \n_0_FSM_onehot_legacy_state[4]_i_1\,
      D => \<const0>\,
      Q => \n_0_FSM_onehot_legacy_state_reg[4]\,
      R => I2
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
pause_req_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => pause_state(1),
      I1 => pause_state(0),
      I2 => I2,
      O => pause_req2_out
    );
\pause_req_int_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => \^pfc_req\,
      I1 => pfc_tx_enable_sync,
      I2 => pause_req_int,
      I3 => tx_enable_reg,
      O => pause_req_int0
    );
pause_req_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => pause_req2_out,
      Q => pause_req_int,
      R => \<const0>\
    );
\pause_state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30227422"
    )
    port map (
      I0 => \n_0_pause_state[1]_i_2\,
      I1 => pause_state(0),
      I2 => I1,
      I3 => pause_state(1),
      I4 => control_complete,
      O => \n_0_pause_state[0]_i_1\
    );
\pause_state[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"31CC75CC"
    )
    port map (
      I0 => \n_0_pause_state[1]_i_2\,
      I1 => pause_state(0),
      I2 => I1,
      I3 => pause_state(1),
      I4 => control_complete,
      O => \n_0_pause_state[1]_i_1\
    );
\pause_state[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FF12"
    )
    port map (
      I0 => \n_0_FSM_onehot_legacy_state_reg[1]\,
      I1 => \n_0_FSM_onehot_legacy_state_reg[3]\,
      I2 => \n_0_FSM_onehot_legacy_state_reg[2]\,
      I3 => quanta_low(0),
      I4 => pause_state(1),
      O => \n_0_pause_state[1]_i_2\
    );
\pause_state_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_pause_state[0]_i_1\,
      Q => pause_state(0),
      R => I2
    );
\pause_state_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_pause_state[1]_i_1\,
      Q => pause_state(1),
      R => I2
    );
\pause_value[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(0),
      O => \n_0_pause_value[0]_i_1\
    );
\pause_value[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(10),
      O => \n_0_pause_value[10]_i_1\
    );
\pause_value[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(11),
      O => \n_0_pause_value[11]_i_1\
    );
\pause_value[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(12),
      O => \n_0_pause_value[12]_i_1\
    );
\pause_value[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(13),
      O => \n_0_pause_value[13]_i_1\
    );
\pause_value[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(14),
      O => \n_0_pause_value[14]_i_1\
    );
\pause_value[15]_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(15),
      O => \n_0_pause_value[15]_i_2__0\
    );
\pause_value[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(1),
      O => \n_0_pause_value[1]_i_1\
    );
\pause_value[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(2),
      O => \n_0_pause_value[2]_i_1\
    );
\pause_value[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(3),
      O => \n_0_pause_value[3]_i_1\
    );
\pause_value[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(4),
      O => \n_0_pause_value[4]_i_1\
    );
\pause_value[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(5),
      O => \n_0_pause_value[5]_i_1\
    );
\pause_value[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(6),
      O => \n_0_pause_value[6]_i_1\
    );
\pause_value[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(7),
      O => \n_0_pause_value[7]_i_1\
    );
\pause_value[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(8),
      O => \n_0_pause_value[8]_i_1\
    );
\pause_value[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => pause_req,
      I1 => pause_val(9),
      O => \n_0_pause_value[9]_i_1\
    );
\pause_value_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[0]_i_1\,
      Q => \n_0_pause_value_reg[0]\,
      R => I2
    );
\pause_value_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[10]_i_1\,
      Q => Q(2),
      R => I2
    );
\pause_value_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[11]_i_1\,
      Q => Q(3),
      R => I2
    );
\pause_value_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[12]_i_1\,
      Q => Q(4),
      R => I2
    );
\pause_value_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[13]_i_1\,
      Q => Q(5),
      R => I2
    );
\pause_value_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[14]_i_1\,
      Q => Q(6),
      R => I2
    );
\pause_value_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[15]_i_2__0\,
      Q => Q(7),
      R => I2
    );
\pause_value_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[1]_i_1\,
      Q => \n_0_pause_value_reg[1]\,
      R => I2
    );
\pause_value_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[2]_i_1\,
      Q => \n_0_pause_value_reg[2]\,
      R => I2
    );
\pause_value_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[3]_i_1\,
      Q => \n_0_pause_value_reg[3]\,
      R => I2
    );
\pause_value_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[4]_i_1\,
      Q => \n_0_pause_value_reg[4]\,
      R => I2
    );
\pause_value_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[5]_i_1\,
      Q => \n_0_pause_value_reg[5]\,
      R => I2
    );
\pause_value_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[6]_i_1\,
      Q => \n_0_pause_value_reg[6]\,
      R => I2
    );
\pause_value_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[7]_i_1\,
      Q => \n_0_pause_value_reg[7]\,
      R => I2
    );
\pause_value_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[8]_i_1\,
      Q => Q(0),
      R => I2
    );
\pause_value_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_pause_value[9]_i_1\,
      Q => Q(1),
      R => I2
    );
\pause_value_sample[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => pfc_valid,
      I1 => pfc_pause_req_out,
      I2 => \n_0_pause_value_reg[0]\,
      O => O8
    );
\pause_value_sample[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => pfc_valid,
      I1 => pfc_pause_req_out,
      I2 => \n_0_pause_value_reg[1]\,
      O => O7
    );
\pause_value_sample[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => pfc_valid,
      I1 => pfc_pause_req_out,
      I2 => \n_0_pause_value_reg[2]\,
      O => O6
    );
\pause_value_sample[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => pfc_valid,
      I1 => pfc_pause_req_out,
      I2 => \n_0_pause_value_reg[3]\,
      O => O5
    );
\pause_value_sample[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => pfc_valid,
      I1 => pfc_pause_req_out,
      I2 => \n_0_pause_value_reg[4]\,
      O => O4
    );
\pause_value_sample[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => pfc_valid,
      I1 => pfc_pause_req_out,
      I2 => \n_0_pause_value_reg[5]\,
      O => O3
    );
\pause_value_sample[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => pfc_valid,
      I1 => pfc_pause_req_out,
      I2 => \n_0_pause_value_reg[6]\,
      O => O2
    );
\pause_value_sample[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => pfc_valid,
      I1 => pfc_pause_req_out,
      I2 => \n_0_pause_value_reg[7]\,
      O => O1
    );
pfc_req_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00300020"
    )
    port map (
      I0 => quanta_low(0),
      I1 => I2,
      I2 => pause_state(0),
      I3 => pause_state(1),
      I4 => \^pfc_req\,
      O => n_0_pfc_req_i_1
    );
pfc_req_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_pfc_req_i_1,
      Q => \^pfc_req\,
      R => \<const0>\
    );
\pfc_valid[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000002AFF2A2A"
    )
    port map (
      I0 => pfc_valid,
      I1 => pause_state(0),
      I2 => pause_state(1),
      I3 => I1,
      I4 => quanta_low(0),
      I5 => I2,
      O => \n_0_pfc_valid[0]_i_1\
    );
\pfc_valid_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_pfc_valid[0]_i_1\,
      Q => pfc_valid,
      R => \<const0>\
    );
\priority_fsm[0].quanta_low_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => quanta_low(0),
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_rx_axi_intf is
  port (
    Q : out STD_LOGIC_VECTOR ( 1 downto 0 );
    rx_axis_mac_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_axis_mac_tvalid : out STD_LOGIC;
    rx_axis_mac_tlast : out STD_LOGIC;
    rx_axis_mac_tuser : out STD_LOGIC;
    I2 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    D : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I1 : in STD_LOGIC;
    rx_mac_tvalid0 : in STD_LOGIC;
    rx_mac_tlast0 : in STD_LOGIC;
    rx_mac_tuser0 : in STD_LOGIC;
    I3 : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
end TriMACtri_mode_ethernet_mac_v8_1_rx_axi_intf;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_rx_axi_intf is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal rx_data_reg : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal rx_mac_tdata0 : STD_LOGIC;
begin
  Q(1 downto 0) <= \^q\(1 downto 0);
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\rx_data_reg_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I3(0),
      Q => rx_data_reg(0),
      R => \<const0>\
    );
\rx_data_reg_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I3(1),
      Q => rx_data_reg(1),
      R => \<const0>\
    );
\rx_data_reg_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I3(2),
      Q => rx_data_reg(2),
      R => \<const0>\
    );
\rx_data_reg_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I3(3),
      Q => rx_data_reg(3),
      R => \<const0>\
    );
\rx_data_reg_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I3(4),
      Q => rx_data_reg(4),
      R => \<const0>\
    );
\rx_data_reg_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I3(5),
      Q => rx_data_reg(5),
      R => \<const0>\
    );
\rx_data_reg_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I3(6),
      Q => rx_data_reg(6),
      R => \<const0>\
    );
\rx_data_reg_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => I3(7),
      Q => rx_data_reg(7),
      R => \<const0>\
    );
\rx_mac_tdata[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => I2,
      I1 => \^q\(0),
      I2 => \^q\(1),
      O => rx_mac_tdata0
    );
\rx_mac_tdata_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => rx_mac_tdata0,
      D => rx_data_reg(0),
      Q => rx_axis_mac_tdata(0),
      R => SR(0)
    );
\rx_mac_tdata_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => rx_mac_tdata0,
      D => rx_data_reg(1),
      Q => rx_axis_mac_tdata(1),
      R => SR(0)
    );
\rx_mac_tdata_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => rx_mac_tdata0,
      D => rx_data_reg(2),
      Q => rx_axis_mac_tdata(2),
      R => SR(0)
    );
\rx_mac_tdata_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => rx_mac_tdata0,
      D => rx_data_reg(3),
      Q => rx_axis_mac_tdata(3),
      R => SR(0)
    );
\rx_mac_tdata_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => rx_mac_tdata0,
      D => rx_data_reg(4),
      Q => rx_axis_mac_tdata(4),
      R => SR(0)
    );
\rx_mac_tdata_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => rx_mac_tdata0,
      D => rx_data_reg(5),
      Q => rx_axis_mac_tdata(5),
      R => SR(0)
    );
\rx_mac_tdata_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => rx_mac_tdata0,
      D => rx_data_reg(6),
      Q => rx_axis_mac_tdata(6),
      R => SR(0)
    );
\rx_mac_tdata_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => rx_mac_tdata0,
      D => rx_data_reg(7),
      Q => rx_axis_mac_tdata(7),
      R => SR(0)
    );
rx_mac_tlast_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => rx_mac_tlast0,
      Q => rx_axis_mac_tlast,
      R => SR(0)
    );
rx_mac_tuser_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => rx_mac_tuser0,
      Q => rx_axis_mac_tuser,
      R => SR(0)
    );
rx_mac_tvalid_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => rx_mac_tvalid0,
      Q => rx_axis_mac_tvalid,
      R => SR(0)
    );
\rx_state_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => D(0),
      Q => \^q\(0),
      R => SR(0)
    );
\rx_state_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => D(1),
      Q => \^q\(1),
      R => SR(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_rx_cntl is
  port (
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    rx_statistics_vector : out STD_LOGIC_VECTOR ( 0 to 0 );
    O2 : out STD_LOGIC;
    rx_good_frame_comb : out STD_LOGIC;
    O1 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 15 downto 0 );
    I3 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    int_rx_data_valid_in : in STD_LOGIC;
    I1 : in STD_LOGIC;
    int_rx_control_frame : in STD_LOGIC;
    int_rx_good_frame_in : in STD_LOGIC;
    data_out : in STD_LOGIC;
    bad_pfc_opcode_int : in STD_LOGIC;
    I12 : in STD_LOGIC;
    I13 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    int_rx_bad_frame_in : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    I14 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I18 : in STD_LOGIC
  );
end TriMACtri_mode_ethernet_mac_v8_1_rx_cntl;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_rx_cntl is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^d\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^o1\ : STD_LOGIC;
  signal \^o2\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal bad_fc_opcode_int2_out : STD_LOGIC;
  signal check_opcode : STD_LOGIC;
  signal check_opcode4_out : STD_LOGIC;
  signal data_count : STD_LOGIC;
  signal \data_count_reg__0\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal n_0_bad_fc_opcode_int_i_1 : STD_LOGIC;
  signal n_0_bad_fc_opcode_int_i_3 : STD_LOGIC;
  signal n_0_bad_fc_opcode_int_i_5 : STD_LOGIC;
  signal n_0_bad_pfc_opcode_int_i_1 : STD_LOGIC;
  signal n_0_check_opcode_i_1 : STD_LOGIC;
  signal \n_0_data_count[5]_i_3\ : STD_LOGIC;
  signal \n_0_pause_opcode_early[7]_i_2\ : STD_LOGIC;
  signal n_0_pause_req_int_i_1 : STD_LOGIC;
  signal \n_0_pause_value[0]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[10]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[11]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[12]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[13]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[14]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[15]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[15]_i_2\ : STD_LOGIC;
  signal \n_0_pause_value[1]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[2]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[3]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[4]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[5]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[6]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[7]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[8]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value[9]_i_1\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal p_0_in_0 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pause_req_int0_out : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of bad_fc_opcode_int_i_2 : label is "soft_lutpair120";
  attribute RETAIN_INVERTER : boolean;
  attribute RETAIN_INVERTER of \data_count[0]_i_1\ : label is true;
  attribute SOFT_HLUTNM of \data_count[0]_i_1\ : label is "soft_lutpair121";
  attribute SOFT_HLUTNM of \data_count[1]_i_1\ : label is "soft_lutpair121";
  attribute SOFT_HLUTNM of \data_count[2]_i_1\ : label is "soft_lutpair119";
  attribute SOFT_HLUTNM of \data_count[3]_i_1\ : label is "soft_lutpair118";
  attribute SOFT_HLUTNM of \data_count[4]_i_1\ : label is "soft_lutpair118";
  attribute counter : integer;
  attribute counter of \data_count_reg[0]\ : label is 7;
  attribute counter of \data_count_reg[1]\ : label is 7;
  attribute counter of \data_count_reg[2]\ : label is 7;
  attribute counter of \data_count_reg[3]\ : label is 7;
  attribute counter of \data_count_reg[4]\ : label is 7;
  attribute counter of \data_count_reg[5]\ : label is 7;
  attribute SOFT_HLUTNM of pause_req_int_i_2 : label is "soft_lutpair120";
  attribute SOFT_HLUTNM of \pause_value[15]_i_2\ : label is "soft_lutpair119";
begin
  D(15 downto 0) <= \^d\(15 downto 0);
  O1 <= \^o1\;
  O2 <= \^o2\;
  O3 <= \^o3\;
  Q(0) <= \^q\(0);
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
bad_fc_opcode_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000E0E0EEE"
    )
    port map (
      I0 => \^o1\,
      I1 => bad_fc_opcode_int2_out,
      I2 => I2,
      I3 => int_rx_bad_frame_in,
      I4 => int_rx_good_frame_in,
      I5 => SR(0),
      O => n_0_bad_fc_opcode_int_i_1
    );
bad_fc_opcode_int_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => check_opcode,
      I1 => I2,
      I2 => n_0_bad_fc_opcode_int_i_3,
      O => bad_fc_opcode_int2_out
    );
bad_fc_opcode_int_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0001000000000000"
    )
    port map (
      I0 => p_0_in_0(1),
      I1 => p_0_in_0(3),
      I2 => p_0_in_0(2),
      I3 => p_0_in_0(0),
      I4 => I12,
      I5 => n_0_bad_fc_opcode_int_i_5,
      O => n_0_bad_fc_opcode_int_i_3
    );
bad_fc_opcode_int_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000010"
    )
    port map (
      I0 => p_0_in_0(5),
      I1 => p_0_in_0(4),
      I2 => I13(0),
      I3 => I13(1),
      I4 => p_0_in_0(6),
      I5 => p_0_in_0(7),
      O => n_0_bad_fc_opcode_int_i_5
    );
bad_fc_opcode_int_reg: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => n_0_bad_fc_opcode_int_i_1,
      Q => \^o1\,
      R => \<const0>\
    );
bad_frame_int_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBBB0BBB"
    )
    port map (
      I0 => \^o3\,
      I1 => data_out,
      I2 => int_rx_control_frame,
      I3 => I1,
      I4 => \^o1\,
      O => O5
    );
bad_pfc_opcode_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000A0A0AEA"
    )
    port map (
      I0 => \^o3\,
      I1 => check_opcode,
      I2 => I2,
      I3 => int_rx_bad_frame_in,
      I4 => int_rx_good_frame_in,
      I5 => SR(0),
      O => n_0_bad_pfc_opcode_int_i_1
    );
bad_pfc_opcode_int_reg: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => n_0_bad_pfc_opcode_int_i_1,
      Q => \^o3\,
      R => \<const0>\
    );
check_opcode_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"002E"
    )
    port map (
      I0 => check_opcode,
      I1 => check_opcode4_out,
      I2 => \data_count_reg__0\(0),
      I3 => bad_pfc_opcode_int,
      O => n_0_check_opcode_i_1
    );
check_opcode_reg: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => n_0_check_opcode_i_1,
      Q => check_opcode,
      R => \<const0>\
    );
\data_count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \data_count_reg__0\(0),
      O => p_0_in(0)
    );
\data_count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \data_count_reg__0\(0),
      I1 => \data_count_reg__0\(1),
      O => p_0_in(1)
    );
\data_count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => \data_count_reg__0\(2),
      I1 => \data_count_reg__0\(1),
      I2 => \data_count_reg__0\(0),
      O => p_0_in(2)
    );
\data_count[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => \data_count_reg__0\(3),
      I1 => \data_count_reg__0\(0),
      I2 => \data_count_reg__0\(1),
      I3 => \data_count_reg__0\(2),
      O => p_0_in(3)
    );
\data_count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => \^q\(0),
      I1 => \data_count_reg__0\(2),
      I2 => \data_count_reg__0\(3),
      I3 => \data_count_reg__0\(0),
      I4 => \data_count_reg__0\(1),
      O => p_0_in(4)
    );
\data_count[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \n_0_data_count[5]_i_3\,
      I1 => int_rx_data_valid_in,
      I2 => I2,
      O => data_count
    );
\data_count[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => \data_count_reg__0\(5),
      I1 => \data_count_reg__0\(1),
      I2 => \data_count_reg__0\(0),
      I3 => \data_count_reg__0\(3),
      I4 => \data_count_reg__0\(2),
      I5 => \^q\(0),
      O => p_0_in(5)
    );
\data_count[5]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEFFFFFFFFFF"
    )
    port map (
      I0 => \data_count_reg__0\(3),
      I1 => \data_count_reg__0\(2),
      I2 => \data_count_reg__0\(0),
      I3 => \data_count_reg__0\(5),
      I4 => \^q\(0),
      I5 => \data_count_reg__0\(1),
      O => \n_0_data_count[5]_i_3\
    );
\data_count_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => data_count,
      D => p_0_in(0),
      Q => \data_count_reg__0\(0),
      R => I14(0)
    );
\data_count_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => data_count,
      D => p_0_in(1),
      Q => \data_count_reg__0\(1),
      R => I14(0)
    );
\data_count_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => data_count,
      D => p_0_in(2),
      Q => \data_count_reg__0\(2),
      R => I14(0)
    );
\data_count_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => data_count,
      D => p_0_in(3),
      Q => \data_count_reg__0\(3),
      R => I14(0)
    );
\data_count_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => data_count,
      D => p_0_in(4),
      Q => \^q\(0),
      R => I14(0)
    );
\data_count_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => data_count,
      D => p_0_in(5),
      Q => \data_count_reg__0\(5),
      R => I14(0)
    );
good_frame_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8AAA8AAA00008AAA"
    )
    port map (
      I0 => int_rx_good_frame_in,
      I1 => \^o1\,
      I2 => I1,
      I3 => int_rx_control_frame,
      I4 => data_out,
      I5 => \^o3\,
      O => rx_good_frame_comb
    );
\pause_opcode_early[7]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => check_opcode4_out,
      I1 => \data_count_reg__0\(0),
      O => \n_0_pause_opcode_early[7]_i_2\
    );
\pause_opcode_early[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0200000000000000"
    )
    port map (
      I0 => \data_count_reg__0\(1),
      I1 => \^q\(0),
      I2 => \data_count_reg__0\(5),
      I3 => I2,
      I4 => \data_count_reg__0\(2),
      I5 => \data_count_reg__0\(3),
      O => check_opcode4_out
    );
\pause_opcode_early_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_pause_opcode_early[7]_i_2\,
      D => I13(0),
      Q => p_0_in_0(0),
      R => I14(0)
    );
\pause_opcode_early_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_pause_opcode_early[7]_i_2\,
      D => I13(1),
      Q => p_0_in_0(1),
      R => I14(0)
    );
\pause_opcode_early_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_pause_opcode_early[7]_i_2\,
      D => I13(2),
      Q => p_0_in_0(2),
      R => I14(0)
    );
\pause_opcode_early_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_pause_opcode_early[7]_i_2\,
      D => I13(3),
      Q => p_0_in_0(3),
      R => I14(0)
    );
\pause_opcode_early_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_pause_opcode_early[7]_i_2\,
      D => I13(4),
      Q => p_0_in_0(4),
      R => I14(0)
    );
\pause_opcode_early_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_pause_opcode_early[7]_i_2\,
      D => I13(5),
      Q => p_0_in_0(5),
      R => I14(0)
    );
\pause_opcode_early_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_pause_opcode_early[7]_i_2\,
      D => I13(6),
      Q => p_0_in_0(6),
      R => I14(0)
    );
\pause_opcode_early_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \n_0_pause_opcode_early[7]_i_2\,
      D => I13(7),
      Q => p_0_in_0(7),
      R => I14(0)
    );
pause_req_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000E0E0EEE"
    )
    port map (
      I0 => \^o2\,
      I1 => pause_req_int0_out,
      I2 => I2,
      I3 => int_rx_bad_frame_in,
      I4 => int_rx_good_frame_in,
      I5 => SR(0),
      O => n_0_pause_req_int_i_1
    );
pause_req_int_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => check_opcode,
      I1 => I2,
      I2 => n_0_bad_fc_opcode_int_i_3,
      O => pause_req_int0_out
    );
pause_req_int_reg: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => n_0_pause_req_int_i_1,
      Q => \^o2\,
      R => \<const0>\
    );
\pause_value[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAA2AAA"
    )
    port map (
      I0 => \^d\(0),
      I1 => \data_count_reg__0\(0),
      I2 => I18,
      I3 => \n_0_pause_value[15]_i_2\,
      I4 => I13(0),
      I5 => SR(0),
      O => \n_0_pause_value[0]_i_1\
    );
\pause_value[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BAAA8AAA"
    )
    port map (
      I0 => \^d\(10),
      I1 => \data_count_reg__0\(0),
      I2 => \n_0_pause_value[15]_i_2\,
      I3 => I18,
      I4 => I13(2),
      I5 => SR(0),
      O => \n_0_pause_value[10]_i_1\
    );
\pause_value[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BAAA8AAA"
    )
    port map (
      I0 => \^d\(11),
      I1 => \data_count_reg__0\(0),
      I2 => \n_0_pause_value[15]_i_2\,
      I3 => I18,
      I4 => I13(3),
      I5 => SR(0),
      O => \n_0_pause_value[11]_i_1\
    );
\pause_value[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BAAA8AAA"
    )
    port map (
      I0 => \^d\(12),
      I1 => \data_count_reg__0\(0),
      I2 => \n_0_pause_value[15]_i_2\,
      I3 => I18,
      I4 => I13(4),
      I5 => SR(0),
      O => \n_0_pause_value[12]_i_1\
    );
\pause_value[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BAAA8AAA"
    )
    port map (
      I0 => \^d\(13),
      I1 => \data_count_reg__0\(0),
      I2 => \n_0_pause_value[15]_i_2\,
      I3 => I18,
      I4 => I13(5),
      I5 => SR(0),
      O => \n_0_pause_value[13]_i_1\
    );
\pause_value[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BAAA8AAA"
    )
    port map (
      I0 => \^d\(14),
      I1 => \data_count_reg__0\(0),
      I2 => \n_0_pause_value[15]_i_2\,
      I3 => I18,
      I4 => I13(6),
      I5 => SR(0),
      O => \n_0_pause_value[14]_i_1\
    );
\pause_value[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BAAA8AAA"
    )
    port map (
      I0 => \^d\(15),
      I1 => \data_count_reg__0\(0),
      I2 => \n_0_pause_value[15]_i_2\,
      I3 => I18,
      I4 => I13(7),
      I5 => SR(0),
      O => \n_0_pause_value[15]_i_1\
    );
\pause_value[15]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => \data_count_reg__0\(3),
      I1 => \data_count_reg__0\(2),
      I2 => \data_count_reg__0\(5),
      I3 => \data_count_reg__0\(1),
      O => \n_0_pause_value[15]_i_2\
    );
\pause_value[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAA2AAA"
    )
    port map (
      I0 => \^d\(1),
      I1 => \data_count_reg__0\(0),
      I2 => I18,
      I3 => \n_0_pause_value[15]_i_2\,
      I4 => I13(1),
      I5 => SR(0),
      O => \n_0_pause_value[1]_i_1\
    );
\pause_value[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAA2AAA"
    )
    port map (
      I0 => \^d\(2),
      I1 => \data_count_reg__0\(0),
      I2 => I18,
      I3 => \n_0_pause_value[15]_i_2\,
      I4 => I13(2),
      I5 => SR(0),
      O => \n_0_pause_value[2]_i_1\
    );
\pause_value[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAA2AAA"
    )
    port map (
      I0 => \^d\(3),
      I1 => \data_count_reg__0\(0),
      I2 => I18,
      I3 => \n_0_pause_value[15]_i_2\,
      I4 => I13(3),
      I5 => SR(0),
      O => \n_0_pause_value[3]_i_1\
    );
\pause_value[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAA2AAA"
    )
    port map (
      I0 => \^d\(4),
      I1 => \data_count_reg__0\(0),
      I2 => I18,
      I3 => \n_0_pause_value[15]_i_2\,
      I4 => I13(4),
      I5 => SR(0),
      O => \n_0_pause_value[4]_i_1\
    );
\pause_value[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAA2AAA"
    )
    port map (
      I0 => \^d\(5),
      I1 => \data_count_reg__0\(0),
      I2 => I18,
      I3 => \n_0_pause_value[15]_i_2\,
      I4 => I13(5),
      I5 => SR(0),
      O => \n_0_pause_value[5]_i_1\
    );
\pause_value[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAA2AAA"
    )
    port map (
      I0 => \^d\(6),
      I1 => \data_count_reg__0\(0),
      I2 => I18,
      I3 => \n_0_pause_value[15]_i_2\,
      I4 => I13(6),
      I5 => SR(0),
      O => \n_0_pause_value[6]_i_1\
    );
\pause_value[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAAA2AAA"
    )
    port map (
      I0 => \^d\(7),
      I1 => \data_count_reg__0\(0),
      I2 => I18,
      I3 => \n_0_pause_value[15]_i_2\,
      I4 => I13(7),
      I5 => SR(0),
      O => \n_0_pause_value[7]_i_1\
    );
\pause_value[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BAAA8AAA"
    )
    port map (
      I0 => \^d\(8),
      I1 => \data_count_reg__0\(0),
      I2 => \n_0_pause_value[15]_i_2\,
      I3 => I18,
      I4 => I13(0),
      I5 => SR(0),
      O => \n_0_pause_value[8]_i_1\
    );
\pause_value[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BAAA8AAA"
    )
    port map (
      I0 => \^d\(9),
      I1 => \data_count_reg__0\(0),
      I2 => \n_0_pause_value[15]_i_2\,
      I3 => I18,
      I4 => I13(1),
      I5 => SR(0),
      O => \n_0_pause_value[9]_i_1\
    );
\pause_value_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[0]_i_1\,
      Q => \^d\(0),
      R => \<const0>\
    );
\pause_value_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[10]_i_1\,
      Q => \^d\(10),
      R => \<const0>\
    );
\pause_value_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[11]_i_1\,
      Q => \^d\(11),
      R => \<const0>\
    );
\pause_value_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[12]_i_1\,
      Q => \^d\(12),
      R => \<const0>\
    );
\pause_value_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[13]_i_1\,
      Q => \^d\(13),
      R => \<const0>\
    );
\pause_value_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[14]_i_1\,
      Q => \^d\(14),
      R => \<const0>\
    );
\pause_value_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[15]_i_1\,
      Q => \^d\(15),
      R => \<const0>\
    );
\pause_value_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[1]_i_1\,
      Q => \^d\(1),
      R => \<const0>\
    );
\pause_value_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[2]_i_1\,
      Q => \^d\(2),
      R => \<const0>\
    );
\pause_value_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[3]_i_1\,
      Q => \^d\(3),
      R => \<const0>\
    );
\pause_value_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[4]_i_1\,
      Q => \^d\(4),
      R => \<const0>\
    );
\pause_value_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[5]_i_1\,
      Q => \^d\(5),
      R => \<const0>\
    );
\pause_value_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[6]_i_1\,
      Q => \^d\(6),
      R => \<const0>\
    );
\pause_value_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[7]_i_1\,
      Q => \^d\(7),
      R => \<const0>\
    );
\pause_value_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[8]_i_1\,
      Q => \^d\(8),
      R => \<const0>\
    );
\pause_value_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => \n_0_pause_value[9]_i_1\,
      Q => \^d\(9),
      R => \<const0>\
    );
\statistics_vector[23]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => I1,
      I1 => int_rx_control_frame,
      I2 => \^o2\,
      I3 => int_rx_good_frame_in,
      O => rx_statistics_vector(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_rx_sync_req is
  port (
    data_in : out STD_LOGIC;
    O1 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 );
    I3 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    rx_statistics_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    D : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end TriMACtri_mode_ethernet_mac_v8_1_rx_sync_req;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_rx_sync_req is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^data_in\ : STD_LOGIC;
  signal n_0_count_set_i_4 : STD_LOGIC;
  signal n_0_count_set_i_5 : STD_LOGIC;
  signal n_0_pause_req_to_tx_int_i_1 : STD_LOGIC;
begin
  Q(15 downto 0) <= \^q\(15 downto 0);
  data_in <= \^data_in\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
count_set_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => \^q\(4),
      I1 => \^q\(7),
      I2 => \^q\(5),
      I3 => \^q\(6),
      I4 => n_0_count_set_i_4,
      I5 => n_0_count_set_i_5,
      O => O1
    );
count_set_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => \^q\(10),
      I1 => \^q\(9),
      I2 => \^q\(14),
      I3 => \^q\(15),
      I4 => \^q\(12),
      I5 => \^q\(13),
      O => n_0_count_set_i_4
    );
count_set_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(8),
      I3 => \^q\(11),
      I4 => \^q\(2),
      I5 => \^q\(3),
      O => n_0_count_set_i_5
    );
pause_req_to_tx_int_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"006A"
    )
    port map (
      I0 => \^data_in\,
      I1 => I2,
      I2 => rx_statistics_vector(0),
      I3 => SR(0),
      O => n_0_pause_req_to_tx_int_i_1
    );
pause_req_to_tx_int_reg: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => \<const1>\,
      D => n_0_pause_req_to_tx_int_i_1,
      Q => \^data_in\,
      R => \<const0>\
    );
\pause_value_to_tx_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(0),
      Q => \^q\(0),
      R => SR(0)
    );
\pause_value_to_tx_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(10),
      Q => \^q\(10),
      R => SR(0)
    );
\pause_value_to_tx_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(11),
      Q => \^q\(11),
      R => SR(0)
    );
\pause_value_to_tx_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(12),
      Q => \^q\(12),
      R => SR(0)
    );
\pause_value_to_tx_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(13),
      Q => \^q\(13),
      R => SR(0)
    );
\pause_value_to_tx_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(14),
      Q => \^q\(14),
      R => SR(0)
    );
\pause_value_to_tx_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(15),
      Q => \^q\(15),
      R => SR(0)
    );
\pause_value_to_tx_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(1),
      Q => \^q\(1),
      R => SR(0)
    );
\pause_value_to_tx_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(2),
      Q => \^q\(2),
      R => SR(0)
    );
\pause_value_to_tx_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(3),
      Q => \^q\(3),
      R => SR(0)
    );
\pause_value_to_tx_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(4),
      Q => \^q\(4),
      R => SR(0)
    );
\pause_value_to_tx_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(5),
      Q => \^q\(5),
      R => SR(0)
    );
\pause_value_to_tx_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(6),
      Q => \^q\(6),
      R => SR(0)
    );
\pause_value_to_tx_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(7),
      Q => \^q\(7),
      R => SR(0)
    );
\pause_value_to_tx_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(8),
      Q => \^q\(8),
      R => SR(0)
    );
\pause_value_to_tx_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => E(0),
      D => D(9),
      Q => \^q\(9),
      R => SR(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_sync_block is
  port (
    data_out : out STD_LOGIC;
    gtx_clk : in STD_LOGIC
  );
end TriMACtri_mode_ethernet_mac_v8_1_sync_block;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_sync_block is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync3,
      Q => data_out,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_sync_block_1 is
  port (
    O1 : out STD_LOGIC;
    data_out : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtx_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACtri_mode_ethernet_mac_v8_1_sync_block_1 : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end TriMACtri_mode_ethernet_mac_v8_1_sync_block_1;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_sync_block_1 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal tx_enable_sync : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => tx_configuration_vector(0),
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync3,
      Q => tx_enable_sync,
      R => \<const0>\
    );
tx_enable_reg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => tx_enable_sync,
      I1 => data_out,
      O => O1
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_sync_block_11 is
  port (
    O1 : out STD_LOGIC;
    address_match1 : in STD_LOGIC;
    rx_data_valid_reg2 : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    I3 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACtri_mode_ethernet_mac_v8_1_sync_block_11 : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end TriMACtri_mode_ethernet_mac_v8_1_sync_block_11;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_sync_block_11 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal promiscuous_mode_resync : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => rx_configuration_vector(0),
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync3,
      Q => promiscuous_mode_resync,
      R => \<const0>\
    );
promiscuous_mode_sample_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBAAA8AAA"
    )
    port map (
      I0 => address_match1,
      I1 => rx_data_valid_reg2,
      I2 => I1,
      I3 => I2,
      I4 => promiscuous_mode_resync,
      I5 => SR(0),
      O => O1
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_sync_block_12 is
  port (
    data_out : out STD_LOGIC;
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    update_pause_ad_sync_reg : in STD_LOGIC;
    I4 : in STD_LOGIC;
    I5 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACtri_mode_ethernet_mac_v8_1_sync_block_12 : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end TriMACtri_mode_ethernet_mac_v8_1_sync_block_12;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_sync_block_12 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^data_out\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal n_0_load_wr_i_2 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of load_wr_i_2 : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of update_pause_ad_sync_reg_i_1 : label is "soft_lutpair65";
begin
  data_out <= \^data_out\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => \<const0>\,
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync3,
      Q => \^data_out\,
      R => \<const0>\
    );
load_wr_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000001F"
    )
    port map (
      I0 => Q(1),
      I1 => Q(0),
      I2 => Q(2),
      I3 => n_0_load_wr_i_2,
      I4 => SR(0),
      O => O1
    );
load_wr_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0666"
    )
    port map (
      I0 => update_pause_ad_sync_reg,
      I1 => \^data_out\,
      I2 => I4,
      I3 => I5,
      O => n_0_load_wr_i_2
    );
update_pause_ad_sync_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      I0 => update_pause_ad_sync_reg,
      I1 => I5,
      I2 => I4,
      I3 => \^data_out\,
      O => O2
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_sync_block_2 is
  port (
    data_out : out STD_LOGIC;
    gtx_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACtri_mode_ethernet_mac_v8_1_sync_block_2 : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end TriMACtri_mode_ethernet_mac_v8_1_sync_block_2;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_sync_block_2 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync3,
      Q => data_out,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_sync_block_3 is
  port (
    data_out : out STD_LOGIC;
    I3 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACtri_mode_ethernet_mac_v8_1_sync_block_3 : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end TriMACtri_mode_ethernet_mac_v8_1_sync_block_3;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_sync_block_3 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => \<const0>\,
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync3,
      Q => data_out,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_sync_block_4 is
  port (
    data_out : out STD_LOGIC;
    I3 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACtri_mode_ethernet_mac_v8_1_sync_block_4 : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end TriMACtri_mode_ethernet_mac_v8_1_sync_block_4;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_sync_block_4 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => \<const0>\,
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync3,
      Q => data_out,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_sync_block_5 is
  port (
    O1 : out STD_LOGIC;
    rx_half_duplex_sync : in STD_LOGIC;
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    I3 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACtri_mode_ethernet_mac_v8_1_sync_block_5 : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end TriMACtri_mode_ethernet_mac_v8_1_sync_block_5;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_sync_block_5 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal rx_enable_sync : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => rx_configuration_vector(0),
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I3,
      CE => \<const1>\,
      D => data_sync3,
      Q => rx_enable_sync,
      R => \<const0>\
    );
rx_enable_reg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => rx_enable_sync,
      I1 => rx_half_duplex_sync,
      O => O1
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_sync_block_6 is
  port (
    O : out STD_LOGIC_VECTOR ( 3 downto 0 );
    O1 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    O2 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    O3 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    data_out : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    tx_ce_sample : in STD_LOGIC;
    pause_req_in_tx_reg : in STD_LOGIC;
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    pause_status_req : in STD_LOGIC;
    I5 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    pause_count_reg : in STD_LOGIC_VECTOR ( 15 downto 0 );
    I6 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    data_in : in STD_LOGIC;
    gtx_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACtri_mode_ethernet_mac_v8_1_sync_block_6 : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end TriMACtri_mode_ethernet_mac_v8_1_sync_block_6;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_sync_block_6 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^data_out\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  signal n_0_count_set_i_3 : STD_LOGIC;
  signal \n_0_pause_count[0]_i_3\ : STD_LOGIC;
  signal \n_0_pause_count[0]_i_4\ : STD_LOGIC;
  signal \n_0_pause_count[0]_i_5\ : STD_LOGIC;
  signal \n_0_pause_count[0]_i_6\ : STD_LOGIC;
  signal \n_0_pause_count[0]_i_7\ : STD_LOGIC;
  signal \n_0_pause_count[12]_i_2\ : STD_LOGIC;
  signal \n_0_pause_count[12]_i_3\ : STD_LOGIC;
  signal \n_0_pause_count[12]_i_4\ : STD_LOGIC;
  signal \n_0_pause_count[12]_i_5\ : STD_LOGIC;
  signal \n_0_pause_count[4]_i_2\ : STD_LOGIC;
  signal \n_0_pause_count[4]_i_3\ : STD_LOGIC;
  signal \n_0_pause_count[4]_i_4\ : STD_LOGIC;
  signal \n_0_pause_count[4]_i_5\ : STD_LOGIC;
  signal \n_0_pause_count[8]_i_2\ : STD_LOGIC;
  signal \n_0_pause_count[8]_i_3\ : STD_LOGIC;
  signal \n_0_pause_count[8]_i_4\ : STD_LOGIC;
  signal \n_0_pause_count[8]_i_5\ : STD_LOGIC;
  signal \n_0_pause_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_0_pause_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_0_pause_count_reg[8]_i_1\ : STD_LOGIC;
  signal n_0_pause_dec_i_3 : STD_LOGIC;
  signal \n_1_pause_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_1_pause_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_1_pause_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_1_pause_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_2_pause_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_2_pause_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_2_pause_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_2_pause_count_reg[8]_i_1\ : STD_LOGIC;
  signal \n_3_pause_count_reg[0]_i_2\ : STD_LOGIC;
  signal \n_3_pause_count_reg[12]_i_1\ : STD_LOGIC;
  signal \n_3_pause_count_reg[4]_i_1\ : STD_LOGIC;
  signal \n_3_pause_count_reg[8]_i_1\ : STD_LOGIC;
  signal \NLW_pause_count_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of count_set_i_3 : label is "soft_lutpair156";
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
  attribute SOFT_HLUTNM of \pause_count[0]_i_1\ : label is "soft_lutpair156";
  attribute SOFT_HLUTNM of pause_dec_i_3 : label is "soft_lutpair157";
  attribute SOFT_HLUTNM of \quanta_count[5]_i_1\ : label is "soft_lutpair157";
begin
  data_out <= \^data_out\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
count_set_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00B300BF00800080"
    )
    port map (
      I0 => I4,
      I1 => tx_ce_sample,
      I2 => n_0_count_set_i_3,
      I3 => I2,
      I4 => I1,
      I5 => pause_status_req,
      O => O5
    );
count_set_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \^data_out\,
      I1 => pause_req_in_tx_reg,
      O => n_0_count_set_i_3
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_in,
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync3,
      Q => \^data_out\,
      R => \<const0>\
    );
\pause_count[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AA282828"
    )
    port map (
      I0 => tx_ce_sample,
      I1 => \^data_out\,
      I2 => pause_req_in_tx_reg,
      I3 => I1,
      I4 => I3,
      O => O4
    );
\pause_count[0]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => pause_req_in_tx_reg,
      I1 => \^data_out\,
      O => \n_0_pause_count[0]_i_3\
    );
\pause_count[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(3),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(3),
      O => \n_0_pause_count[0]_i_4\
    );
\pause_count[0]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(2),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(2),
      O => \n_0_pause_count[0]_i_5\
    );
\pause_count[0]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(1),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(1),
      O => \n_0_pause_count[0]_i_6\
    );
\pause_count[0]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(0),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(0),
      O => \n_0_pause_count[0]_i_7\
    );
\pause_count[12]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(15),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(15),
      O => \n_0_pause_count[12]_i_2\
    );
\pause_count[12]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(14),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(14),
      O => \n_0_pause_count[12]_i_3\
    );
\pause_count[12]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(13),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(13),
      O => \n_0_pause_count[12]_i_4\
    );
\pause_count[12]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(12),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(12),
      O => \n_0_pause_count[12]_i_5\
    );
\pause_count[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(7),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(7),
      O => \n_0_pause_count[4]_i_2\
    );
\pause_count[4]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(6),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(6),
      O => \n_0_pause_count[4]_i_3\
    );
\pause_count[4]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(5),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(5),
      O => \n_0_pause_count[4]_i_4\
    );
\pause_count[4]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(4),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(4),
      O => \n_0_pause_count[4]_i_5\
    );
\pause_count[8]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(11),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(11),
      O => \n_0_pause_count[8]_i_2\
    );
\pause_count[8]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(10),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(10),
      O => \n_0_pause_count[8]_i_3\
    );
\pause_count[8]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(9),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(9),
      O => \n_0_pause_count[8]_i_4\
    );
\pause_count[8]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7D41"
    )
    port map (
      I0 => pause_count_reg(8),
      I1 => pause_req_in_tx_reg,
      I2 => \^data_out\,
      I3 => I6(8),
      O => \n_0_pause_count[8]_i_5\
    );
\pause_count_reg[0]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_pause_count_reg[0]_i_2\,
      CO(2) => \n_1_pause_count_reg[0]_i_2\,
      CO(1) => \n_2_pause_count_reg[0]_i_2\,
      CO(0) => \n_3_pause_count_reg[0]_i_2\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_pause_count[0]_i_3\,
      DI(2) => \n_0_pause_count[0]_i_3\,
      DI(1) => \n_0_pause_count[0]_i_3\,
      DI(0) => \n_0_pause_count[0]_i_3\,
      O(3 downto 0) => O(3 downto 0),
      S(3) => \n_0_pause_count[0]_i_4\,
      S(2) => \n_0_pause_count[0]_i_5\,
      S(1) => \n_0_pause_count[0]_i_6\,
      S(0) => \n_0_pause_count[0]_i_7\
    );
\pause_count_reg[12]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_pause_count_reg[8]_i_1\,
      CO(3) => \NLW_pause_count_reg[12]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \n_1_pause_count_reg[12]_i_1\,
      CO(1) => \n_2_pause_count_reg[12]_i_1\,
      CO(0) => \n_3_pause_count_reg[12]_i_1\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \n_0_pause_count[0]_i_3\,
      DI(1) => \n_0_pause_count[0]_i_3\,
      DI(0) => \n_0_pause_count[0]_i_3\,
      O(3 downto 0) => O3(3 downto 0),
      S(3) => \n_0_pause_count[12]_i_2\,
      S(2) => \n_0_pause_count[12]_i_3\,
      S(1) => \n_0_pause_count[12]_i_4\,
      S(0) => \n_0_pause_count[12]_i_5\
    );
\pause_count_reg[4]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_pause_count_reg[0]_i_2\,
      CO(3) => \n_0_pause_count_reg[4]_i_1\,
      CO(2) => \n_1_pause_count_reg[4]_i_1\,
      CO(1) => \n_2_pause_count_reg[4]_i_1\,
      CO(0) => \n_3_pause_count_reg[4]_i_1\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_pause_count[0]_i_3\,
      DI(2) => \n_0_pause_count[0]_i_3\,
      DI(1) => \n_0_pause_count[0]_i_3\,
      DI(0) => \n_0_pause_count[0]_i_3\,
      O(3 downto 0) => O1(3 downto 0),
      S(3) => \n_0_pause_count[4]_i_2\,
      S(2) => \n_0_pause_count[4]_i_3\,
      S(1) => \n_0_pause_count[4]_i_4\,
      S(0) => \n_0_pause_count[4]_i_5\
    );
\pause_count_reg[8]_i_1\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_pause_count_reg[4]_i_1\,
      CO(3) => \n_0_pause_count_reg[8]_i_1\,
      CO(2) => \n_1_pause_count_reg[8]_i_1\,
      CO(1) => \n_2_pause_count_reg[8]_i_1\,
      CO(0) => \n_3_pause_count_reg[8]_i_1\,
      CYINIT => \<const0>\,
      DI(3) => \n_0_pause_count[0]_i_3\,
      DI(2) => \n_0_pause_count[0]_i_3\,
      DI(1) => \n_0_pause_count[0]_i_3\,
      DI(0) => \n_0_pause_count[0]_i_3\,
      O(3 downto 0) => O2(3 downto 0),
      S(3) => \n_0_pause_count[8]_i_2\,
      S(2) => \n_0_pause_count[8]_i_3\,
      S(1) => \n_0_pause_count[8]_i_4\,
      S(0) => \n_0_pause_count[8]_i_5\
    );
pause_dec_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C000C000AA00AAAA"
    )
    port map (
      I0 => I3,
      I1 => I5,
      I2 => Q(0),
      I3 => n_0_pause_dec_i_3,
      I4 => I2,
      I5 => tx_ce_sample,
      O => O6
    );
pause_dec_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4004"
    )
    port map (
      I0 => I2,
      I1 => I1,
      I2 => pause_req_in_tx_reg,
      I3 => \^data_out\,
      O => n_0_pause_dec_i_3
    );
\quanta_count[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF28AA"
    )
    port map (
      I0 => tx_ce_sample,
      I1 => \^data_out\,
      I2 => pause_req_in_tx_reg,
      I3 => I1,
      I4 => I2,
      O => SR(0)
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1\ is
  port (
    data_out : out STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1\ : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1\;

architecture STRUCTURE of \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => tx_configuration_vector(0),
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync3,
      Q => data_out,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_13\ is
  port (
    data_out : out STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtx_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_13\ : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_13\;

architecture STRUCTURE of \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_13\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => tx_configuration_vector(0),
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync3,
      Q => data_out,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_14\ is
  port (
    data_out : out STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    gtx_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_14\ : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_14\;

architecture STRUCTURE of \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_14\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => tx_configuration_vector(0),
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => data_sync3,
      Q => data_out,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_7\ is
  port (
    data_out : out STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_7\ : entity is "tri_mode_ethernet_mac_v8_1_sync_block";
end \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_7\;

architecture STRUCTURE of \TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_7\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal data_sync0 : STD_LOGIC;
  signal data_sync1 : STD_LOGIC;
  signal data_sync2 : STD_LOGIC;
  signal data_sync3 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of data_sync_reg0 : label is true;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of data_sync_reg0 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of data_sync_reg0 : label is "no";
  attribute ASYNC_REG of data_sync_reg1 : label is true;
  attribute BOX_TYPE of data_sync_reg1 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg1 : label is "no";
  attribute ASYNC_REG of data_sync_reg2 : label is true;
  attribute BOX_TYPE of data_sync_reg2 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg2 : label is "no";
  attribute ASYNC_REG of data_sync_reg3 : label is true;
  attribute BOX_TYPE of data_sync_reg3 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg3 : label is "no";
  attribute ASYNC_REG of data_sync_reg4 : label is true;
  attribute BOX_TYPE of data_sync_reg4 : label is "PRIMITIVE";
  attribute SHREG_EXTRACT of data_sync_reg4 : label is "no";
begin
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
data_sync_reg0: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => tx_configuration_vector(0),
      Q => data_sync0,
      R => \<const0>\
    );
data_sync_reg1: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync0,
      Q => data_sync1,
      R => \<const0>\
    );
data_sync_reg2: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync1,
      Q => data_sync2,
      R => \<const0>\
    );
data_sync_reg3: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync2,
      Q => data_sync3,
      R => \<const0>\
    );
data_sync_reg4: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => data_sync3,
      Q => data_out,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_sync_reset is
  port (
    O1 : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    O4 : out STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    counter0 : in STD_LOGIC;
    \hd_tieoff.extension_reg_reg\ : in STD_LOGIC;
    phy_tx_enable : in STD_LOGIC;
    CRC_OK : in STD_LOGIC;
    tx_axi_rstn : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    glbl_rstn : in STD_LOGIC
  );
end TriMACtri_mode_ethernet_mac_v8_1_sync_reset;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_sync_reset is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal async_rst0 : STD_LOGIC;
  signal async_rst1 : STD_LOGIC;
  signal async_rst2 : STD_LOGIC;
  signal async_rst3 : STD_LOGIC;
  signal async_rst4 : STD_LOGIC;
  signal int_tx_rst_asynch : STD_LOGIC;
  signal n_0_sync_rst1_i_1 : STD_LOGIC;
  signal sync_rst0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \IFG_COUNT[0]_i_3\ : label is "soft_lutpair29";
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of async_rst0_reg : label is true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of async_rst0_reg : label is "no";
  attribute ASYNC_REG of async_rst1_reg : label is true;
  attribute SHREG_EXTRACT of async_rst1_reg : label is "no";
  attribute ASYNC_REG of async_rst2_reg : label is true;
  attribute SHREG_EXTRACT of async_rst2_reg : label is "no";
  attribute ASYNC_REG of async_rst3_reg : label is true;
  attribute SHREG_EXTRACT of async_rst3_reg : label is "no";
  attribute ASYNC_REG of async_rst4_reg : label is true;
  attribute SHREG_EXTRACT of async_rst4_reg : label is "no";
  attribute SOFT_HLUTNM of \counter[5]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of gmii_tx_en_to_phy_i_2 : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \gmii_txd_to_phy[7]_i_1\ : label is "soft_lutpair28";
  attribute ASYNC_REG of sync_rst0_reg : label is true;
  attribute SHREG_EXTRACT of sync_rst0_reg : label is "no";
  attribute ASYNC_REG of sync_rst1_reg : label is true;
  attribute SHREG_EXTRACT of sync_rst1_reg : label is "no";
begin
  O1 <= \^o1\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\IFG_COUNT[0]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \^o1\,
      I1 => CRC_OK,
      O => O4
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
async_rst0_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => int_tx_rst_asynch,
      Q => async_rst0
    );
async_rst1_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => async_rst0,
      PRE => int_tx_rst_asynch,
      Q => async_rst1
    );
async_rst2_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => async_rst1,
      PRE => int_tx_rst_asynch,
      Q => async_rst2
    );
async_rst3_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => async_rst2,
      PRE => int_tx_rst_asynch,
      Q => async_rst3
    );
\async_rst4_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"DF"
    )
    port map (
      I0 => tx_axi_rstn,
      I1 => tx_configuration_vector(0),
      I2 => glbl_rstn,
      O => int_tx_rst_asynch
    );
async_rst4_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => async_rst3,
      PRE => int_tx_rst_asynch,
      Q => async_rst4
    );
\counter[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \^o1\,
      I1 => counter0,
      O => SR(0)
    );
gmii_tx_en_to_phy_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => \^o1\,
      I1 => \hd_tieoff.extension_reg_reg\,
      I2 => phy_tx_enable,
      O => O2
    );
\gmii_txd_to_phy[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => \^o1\,
      I1 => \hd_tieoff.extension_reg_reg\,
      I2 => phy_tx_enable,
      O => O3(0)
    );
sync_rst0_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => async_rst4,
      Q => sync_rst0,
      R => \<const0>\
    );
sync_rst1_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => sync_rst0,
      I1 => async_rst4,
      O => n_0_sync_rst1_i_1
    );
sync_rst1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_sync_rst1_i_1,
      Q => \^o1\,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_sync_reset_0 is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    O1 : out STD_LOGIC;
    I14 : out STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC;
    I2 : in STD_LOGIC;
    END_OF_FRAME : in STD_LOGIC;
    rx_axi_rstn : in STD_LOGIC;
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    glbl_rstn : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACtri_mode_ethernet_mac_v8_1_sync_reset_0 : entity is "tri_mode_ethernet_mac_v8_1_sync_reset";
end TriMACtri_mode_ethernet_mac_v8_1_sync_reset_0;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_sync_reset_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal int_rx_rst_asynch : STD_LOGIC;
  signal n_0_async_rst0_reg : STD_LOGIC;
  signal n_0_async_rst1_reg : STD_LOGIC;
  signal n_0_async_rst2_reg : STD_LOGIC;
  signal n_0_async_rst3_reg : STD_LOGIC;
  signal n_0_async_rst4_reg : STD_LOGIC;
  signal n_0_sync_rst0_reg : STD_LOGIC;
  signal \n_0_sync_rst1_i_1__0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \DATA_COUNTER[10]_i_1\ : label is "soft_lutpair177";
  attribute SOFT_HLUTNM of MIN_LENGTH_MATCH_i_3 : label is "soft_lutpair177";
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of async_rst0_reg : label is true;
  attribute SHREG_EXTRACT : string;
  attribute SHREG_EXTRACT of async_rst0_reg : label is "no";
  attribute ASYNC_REG of async_rst1_reg : label is true;
  attribute SHREG_EXTRACT of async_rst1_reg : label is "no";
  attribute ASYNC_REG of async_rst2_reg : label is true;
  attribute SHREG_EXTRACT of async_rst2_reg : label is "no";
  attribute ASYNC_REG of async_rst3_reg : label is true;
  attribute SHREG_EXTRACT of async_rst3_reg : label is "no";
  attribute ASYNC_REG of async_rst4_reg : label is true;
  attribute SHREG_EXTRACT of async_rst4_reg : label is "no";
  attribute ASYNC_REG of sync_rst0_reg : label is true;
  attribute SHREG_EXTRACT of sync_rst0_reg : label is "no";
  attribute ASYNC_REG of sync_rst1_reg : label is true;
  attribute SHREG_EXTRACT of sync_rst1_reg : label is "no";
begin
  SR(0) <= \^sr\(0);
\DATA_COUNTER[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => \^sr\(0),
      I1 => END_OF_FRAME,
      I2 => I2,
      O => I14(0)
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
MIN_LENGTH_MATCH_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \^sr\(0),
      I1 => I2,
      O => O1
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
async_rst0_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => \<const0>\,
      PRE => int_rx_rst_asynch,
      Q => n_0_async_rst0_reg
    );
async_rst1_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_async_rst0_reg,
      PRE => int_rx_rst_asynch,
      Q => n_0_async_rst1_reg
    );
async_rst2_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_async_rst1_reg,
      PRE => int_rx_rst_asynch,
      Q => n_0_async_rst2_reg
    );
async_rst3_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_async_rst2_reg,
      PRE => int_rx_rst_asynch,
      Q => n_0_async_rst3_reg
    );
async_rst4_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"DF"
    )
    port map (
      I0 => rx_axi_rstn,
      I1 => rx_configuration_vector(0),
      I2 => glbl_rstn,
      O => int_rx_rst_asynch
    );
async_rst4_reg: unisim.vcomponents.FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_async_rst3_reg,
      PRE => int_rx_rst_asynch,
      Q => n_0_async_rst4_reg
    );
sync_rst0_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_async_rst4_reg,
      Q => n_0_sync_rst0_reg,
      R => \<const0>\
    );
\sync_rst1_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => n_0_sync_rst0_reg,
      I1 => n_0_async_rst4_reg,
      O => \n_0_sync_rst1_i_1__0\
    );
sync_rst1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_sync_rst1_i_1__0\,
      Q => \^sr\(0),
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_tx_axi_intf is
  port (
    tx_ce_sample : out STD_LOGIC;
    tx_data_valid_int : out STD_LOGIC;
    tx_underrun_int : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    INT_CRC_MODE : out STD_LOGIC;
    O3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    O4 : out STD_LOGIC_VECTOR ( 0 to 0 );
    CE_REG1_OUT7_out : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_enable : in STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    I1 : in STD_LOGIC;
    tx_ack_int : in STD_LOGIC;
    tx_axis_mac_tvalid : in STD_LOGIC;
    tx_axis_mac_tuser : in STD_LOGIC;
    tx_axis_mac_tlast : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    I4 : in STD_LOGIC;
    PAD : in STD_LOGIC;
    CRC100_EN : in STD_LOGIC;
    load_source : in STD_LOGIC;
    sample : in STD_LOGIC;
    tx_axis_mac_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
end TriMACtri_mode_ethernet_mac_v8_1_tx_axi_intf;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_tx_axi_intf is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^e\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal force_end : STD_LOGIC;
  signal gate_tready : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[0]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[1]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[2]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[3]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[4]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[5]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[6]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[7]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[7]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[7]_i_3\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[7]_i_4\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[7]_i_5\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[7]_i_6\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[7]_i_7\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[7]_i_8\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[8]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_1\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_10\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_11\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_12\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_14\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_15\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_16\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_17\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_18\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_19\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_2\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_20\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_21\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_22\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_23\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_24\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_25\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_26\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_27\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_28\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_29\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_3\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_30\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_31\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_4\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_5\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_6\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_7\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_8\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state[9]_i_9\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[0]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[10]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[11]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[1]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[2]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[3]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[4]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[5]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[6]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[7]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[8]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[9]\ : STD_LOGIC;
  signal \n_0_FSM_onehot_tx_state_reg[9]_i_13\ : STD_LOGIC;
  signal n_0_early_deassert_i_1 : STD_LOGIC;
  signal n_0_early_deassert_i_2 : STD_LOGIC;
  signal n_0_early_deassert_i_3 : STD_LOGIC;
  signal n_0_early_deassert_i_4 : STD_LOGIC;
  signal n_0_early_deassert_reg : STD_LOGIC;
  signal n_0_early_underrun_i_1 : STD_LOGIC;
  signal n_0_early_underrun_i_2 : STD_LOGIC;
  signal n_0_early_underrun_i_3 : STD_LOGIC;
  signal n_0_early_underrun_i_4 : STD_LOGIC;
  signal n_0_early_underrun_reg : STD_LOGIC;
  signal n_0_force_assert_i_1 : STD_LOGIC;
  signal n_0_force_assert_i_2 : STD_LOGIC;
  signal n_0_force_assert_i_3 : STD_LOGIC;
  signal n_0_force_assert_i_4 : STD_LOGIC;
  signal n_0_force_assert_i_5 : STD_LOGIC;
  signal n_0_force_assert_reg : STD_LOGIC;
  signal n_0_force_burst1_i_1 : STD_LOGIC;
  signal n_0_force_burst1_i_2 : STD_LOGIC;
  signal n_0_force_burst1_reg : STD_LOGIC;
  signal n_0_force_burst2_i_1 : STD_LOGIC;
  signal n_0_force_burst2_i_2 : STD_LOGIC;
  signal n_0_force_burst2_i_3 : STD_LOGIC;
  signal n_0_force_burst2_reg : STD_LOGIC;
  signal n_0_force_end_i_1 : STD_LOGIC;
  signal n_0_force_end_i_2 : STD_LOGIC;
  signal n_0_force_end_i_3 : STD_LOGIC;
  signal n_0_force_end_i_4 : STD_LOGIC;
  signal n_0_force_end_i_6 : STD_LOGIC;
  signal n_0_force_end_i_7 : STD_LOGIC;
  signal n_0_gate_tready_i_1 : STD_LOGIC;
  signal n_0_ignore_packet_i_1 : STD_LOGIC;
  signal n_0_ignore_packet_i_2 : STD_LOGIC;
  signal n_0_ignore_packet_i_3 : STD_LOGIC;
  signal n_0_ignore_packet_reg : STD_LOGIC;
  signal n_0_no_burst_i_1 : STD_LOGIC;
  signal n_0_no_burst_i_2 : STD_LOGIC;
  signal n_0_no_burst_i_3 : STD_LOGIC;
  signal n_0_tlast_reg_i_1 : STD_LOGIC;
  signal n_0_tlast_reg_reg : STD_LOGIC;
  signal n_0_two_byte_tx_i_1 : STD_LOGIC;
  signal n_0_two_byte_tx_i_2 : STD_LOGIC;
  signal \n_0_tx_data[7]_i_1\ : STD_LOGIC;
  signal \n_0_tx_data[7]_i_3\ : STD_LOGIC;
  signal \n_0_tx_data[7]_i_4\ : STD_LOGIC;
  signal \n_0_tx_data[7]_i_5\ : STD_LOGIC;
  signal n_0_tx_data_valid_i_1 : STD_LOGIC;
  signal n_0_tx_data_valid_i_2 : STD_LOGIC;
  signal n_0_tx_data_valid_i_3 : STD_LOGIC;
  signal n_0_tx_data_valid_i_4 : STD_LOGIC;
  signal n_0_tx_data_valid_i_5 : STD_LOGIC;
  signal n_0_tx_data_valid_i_6 : STD_LOGIC;
  signal n_0_tx_data_valid_i_7 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_11 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_12 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_13 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_14 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_15 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_16 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_17 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_18 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_19 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_2 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_20 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_21 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_22 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_23 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_24 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_25 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_26 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_27 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_28 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_29 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_3 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_5 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_6 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_7 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_8 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_i_9 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_reg_i_10 : STD_LOGIC;
  signal n_0_tx_mac_tready_reg_reg_i_4 : STD_LOGIC;
  signal n_0_tx_underrun_i_1 : STD_LOGIC;
  signal n_0_tx_underrun_i_2 : STD_LOGIC;
  signal n_0_tx_underrun_i_3 : STD_LOGIC;
  signal no_burst : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal two_byte_tx : STD_LOGIC;
  signal \^tx_ce_sample\ : STD_LOGIC;
  signal tx_data_hold : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^tx_data_valid_int\ : STD_LOGIC;
  signal tx_mac_tready_reg : STD_LOGIC;
  signal tx_mac_tready_reg0 : STD_LOGIC;
  signal \^tx_underrun_int\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \CALC[29]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \CONFIG_SELECT.CE_REG4_OUT_i_2\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \DATA_REG[3][7]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \FSM_onehot_tx_state[7]_i_6\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \FSM_onehot_tx_state[7]_i_7\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \FSM_onehot_tx_state[9]_i_11\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \FSM_onehot_tx_state[9]_i_12\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \FSM_onehot_tx_state[9]_i_15\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \FSM_onehot_tx_state[9]_i_17\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \FSM_onehot_tx_state[9]_i_22\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \FSM_onehot_tx_state[9]_i_27\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \FSM_onehot_tx_state[9]_i_29\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \FSM_onehot_tx_state[9]_i_30\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \FSM_onehot_tx_state[9]_i_9\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \INT_CRC_MODE_i_1__0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[14]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \LEN[15]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \data_count[5]_i_3__0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of early_deassert_i_2 : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of early_deassert_i_3 : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of early_deassert_i_4 : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of early_underrun_i_2 : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of early_underrun_i_3 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of early_underrun_i_4 : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of force_assert_i_2 : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of force_assert_i_3 : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of force_assert_i_4 : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of force_end_i_3 : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of force_end_i_7 : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of ignore_packet_i_3 : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of no_burst_i_2 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \pause_source_shift[47]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \pause_value_sample[7]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of two_byte_tx_i_1 : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of two_byte_tx_i_2 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \tx_data[7]_i_5\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of tx_data_valid_i_3 : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of tx_data_valid_i_4 : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of tx_data_valid_i_5 : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of tx_mac_tready_reg_i_14 : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of tx_mac_tready_reg_i_15 : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of tx_mac_tready_reg_i_2 : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of tx_mac_tready_reg_i_20 : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of tx_mac_tready_reg_i_28 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of tx_underrun_i_1 : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of tx_underrun_i_3 : label is "soft_lutpair5";
begin
  E(0) <= \^e\(0);
  tx_ce_sample <= \^tx_ce_sample\;
  tx_data_valid_int <= \^tx_data_valid_int\;
  tx_underrun_int <= \^tx_underrun_int\;
\CALC[29]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => Q(0),
      O => O2
    );
\CONFIG_SELECT.CE_REG4_OUT_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => CRC100_EN,
      O => CE_REG1_OUT7_out
    );
\DATA_REG[3][7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => PAD,
      O => SR(0)
    );
\FSM_onehot_tx_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000F20000"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_2\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_3\,
      I2 => \n_0_FSM_onehot_tx_state[7]_i_2\,
      I3 => \n_0_FSM_onehot_tx_state[7]_i_3\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_5\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_4\,
      O => \n_0_FSM_onehot_tx_state[0]_i_1\
    );
\FSM_onehot_tx_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000000D0000"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_2\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_3\,
      I2 => \n_0_FSM_onehot_tx_state[7]_i_3\,
      I3 => \n_0_FSM_onehot_tx_state[7]_i_2\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_5\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_4\,
      O => \n_0_FSM_onehot_tx_state[1]_i_1\
    );
\FSM_onehot_tx_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F2000000"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_2\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_3\,
      I2 => \n_0_FSM_onehot_tx_state[7]_i_2\,
      I3 => \n_0_FSM_onehot_tx_state[7]_i_3\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_5\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_4\,
      O => \n_0_FSM_onehot_tx_state[2]_i_1\
    );
\FSM_onehot_tx_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000D00000"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_2\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_3\,
      I2 => \n_0_FSM_onehot_tx_state[7]_i_3\,
      I3 => \n_0_FSM_onehot_tx_state[7]_i_2\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_5\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_4\,
      O => \n_0_FSM_onehot_tx_state[3]_i_1\
    );
\FSM_onehot_tx_state[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000005504"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_5\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_2\,
      I2 => \n_0_FSM_onehot_tx_state[9]_i_3\,
      I3 => \n_0_FSM_onehot_tx_state[7]_i_2\,
      I4 => \n_0_FSM_onehot_tx_state[7]_i_3\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_4\,
      O => \n_0_FSM_onehot_tx_state[4]_i_1\
    );
\FSM_onehot_tx_state[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000001000101"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_5\,
      I1 => \n_0_FSM_onehot_tx_state[7]_i_2\,
      I2 => \n_0_FSM_onehot_tx_state[7]_i_3\,
      I3 => \n_0_FSM_onehot_tx_state[9]_i_3\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_2\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_4\,
      O => \n_0_FSM_onehot_tx_state[5]_i_1\
    );
\FSM_onehot_tx_state[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000055040000"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_5\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_2\,
      I2 => \n_0_FSM_onehot_tx_state[9]_i_3\,
      I3 => \n_0_FSM_onehot_tx_state[7]_i_2\,
      I4 => \n_0_FSM_onehot_tx_state[7]_i_3\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_4\,
      O => \n_0_FSM_onehot_tx_state[6]_i_1\
    );
\FSM_onehot_tx_state[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000010001010"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_5\,
      I1 => \n_0_FSM_onehot_tx_state[7]_i_2\,
      I2 => \n_0_FSM_onehot_tx_state[7]_i_3\,
      I3 => \n_0_FSM_onehot_tx_state[9]_i_3\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_2\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_4\,
      O => \n_0_FSM_onehot_tx_state[7]_i_1\
    );
\FSM_onehot_tx_state[7]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[10]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[11]\,
      O => \n_0_FSM_onehot_tx_state[7]_i_2\
    );
\FSM_onehot_tx_state[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[7]_i_4\,
      I1 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[0]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[4]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I5 => \n_0_FSM_onehot_tx_state[7]_i_2\,
      O => \n_0_FSM_onehot_tx_state[7]_i_3\
    );
\FSM_onehot_tx_state[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAEAEFFAA"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[7]_i_5\,
      I1 => \n_0_FSM_onehot_tx_state[7]_i_6\,
      I2 => \n_0_FSM_onehot_tx_state[7]_i_7\,
      I3 => \n_0_FSM_onehot_tx_state[7]_i_8\,
      I4 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_9\,
      O => \n_0_FSM_onehot_tx_state[7]_i_4\
    );
\FSM_onehot_tx_state[7]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000010001000000"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_15,
      I1 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I3 => \n_0_FSM_onehot_tx_state[9]_i_29\,
      I4 => \n_0_FSM_onehot_tx_state_reg[2]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[1]\,
      O => \n_0_FSM_onehot_tx_state[7]_i_5\
    );
\FSM_onehot_tx_state[7]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[6]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[5]\,
      O => \n_0_FSM_onehot_tx_state[7]_i_6\
    );
\FSM_onehot_tx_state[7]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => tx_ack_int,
      I2 => tx_axis_mac_tlast,
      I3 => tx_axis_mac_tuser,
      O => \n_0_FSM_onehot_tx_state[7]_i_7\
    );
\FSM_onehot_tx_state[7]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000055151515AA00"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I1 => \^tx_ce_sample\,
      I2 => tx_ack_int,
      I3 => tx_axis_mac_tvalid,
      I4 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[6]\,
      O => \n_0_FSM_onehot_tx_state[7]_i_8\
    );
\FSM_onehot_tx_state[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8880888088888880"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_5\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_4\,
      I2 => \n_0_FSM_onehot_tx_state_reg[10]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[11]\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_2\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_3\,
      O => \n_0_FSM_onehot_tx_state[8]_i_1\
    );
\FSM_onehot_tx_state[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000D0000FFFF0000"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_2\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_3\,
      I2 => \n_0_FSM_onehot_tx_state_reg[10]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[11]\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_4\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_5\,
      O => \n_0_FSM_onehot_tx_state[9]_i_1\
    );
\FSM_onehot_tx_state[9]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000020030"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_22\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_8\,
      I2 => \n_0_FSM_onehot_tx_state_reg[2]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[0]\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_17\,
      O => \n_0_FSM_onehot_tx_state[9]_i_10\
    );
\FSM_onehot_tx_state[9]_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF7FFFF"
    )
    port map (
      I0 => tx_axis_mac_tuser,
      I1 => tx_axis_mac_tlast,
      I2 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[2]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[1]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_11\
    );
\FSM_onehot_tx_state[9]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[6]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[9]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_12\
    );
\FSM_onehot_tx_state[9]_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[4]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[0]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[6]\,
      I3 => \n_0_FSM_onehot_tx_state[7]_i_2\,
      I4 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[2]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_14\
    );
\FSM_onehot_tx_state[9]_i_15\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[7]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_15\
    );
\FSM_onehot_tx_state[9]_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FEFE00FF"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_9\,
      I1 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I2 => \n_0_FSM_onehot_tx_state[9]_i_25\,
      I3 => \n_0_FSM_onehot_tx_state[9]_i_26\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_27\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_28\,
      O => \n_0_FSM_onehot_tx_state[9]_i_16\
    );
\FSM_onehot_tx_state[9]_i_17\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[6]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[7]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_17\
    );
\FSM_onehot_tx_state[9]_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000800"
    )
    port map (
      I0 => n_0_no_burst_i_3,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_29\,
      I2 => \n_0_FSM_onehot_tx_state[9]_i_8\,
      I3 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I4 => tx_axis_mac_tvalid,
      I5 => I2,
      O => \n_0_FSM_onehot_tx_state[9]_i_18\
    );
\FSM_onehot_tx_state[9]_i_19\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[6]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_19\
    );
\FSM_onehot_tx_state[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF5554"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_6\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_7\,
      I2 => \n_0_FSM_onehot_tx_state[9]_i_8\,
      I3 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_9\,
      I5 => \n_0_FSM_onehot_tx_state_reg[0]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_2\
    );
\FSM_onehot_tx_state[9]_i_20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888FFFFFFFF"
    )
    port map (
      I0 => tx_axis_mac_tuser,
      I1 => tx_axis_mac_tlast,
      I2 => tx_ack_int,
      I3 => \^tx_ce_sample\,
      I4 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I5 => n_0_no_burst_i_3,
      O => \n_0_FSM_onehot_tx_state[9]_i_20\
    );
\FSM_onehot_tx_state[9]_i_21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF0000FBCB"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_30\,
      I1 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I3 => \^tx_ce_sample\,
      I4 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_31\,
      O => \n_0_FSM_onehot_tx_state[9]_i_21\
    );
\FSM_onehot_tx_state[9]_i_22\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000400"
    )
    port map (
      I0 => tx_axis_mac_tuser,
      I1 => tx_axis_mac_tvalid,
      I2 => n_0_ignore_packet_reg,
      I3 => \^tx_ce_sample\,
      I4 => no_burst,
      O => \n_0_FSM_onehot_tx_state[9]_i_22\
    );
\FSM_onehot_tx_state[9]_i_23\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00033380"
    )
    port map (
      I0 => tx_ack_int,
      I1 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I2 => \^tx_ce_sample\,
      I3 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[9]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_23\
    );
\FSM_onehot_tx_state[9]_i_24\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000001010100"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I3 => force_end,
      I4 => I2,
      I5 => tx_axis_mac_tvalid,
      O => \n_0_FSM_onehot_tx_state[9]_i_24\
    );
\FSM_onehot_tx_state[9]_i_25\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBBBABABA0000"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[4]\,
      I1 => tx_axis_mac_tvalid,
      I2 => I2,
      I3 => force_end,
      I4 => \n_0_FSM_onehot_tx_state_reg[6]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[5]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_25\
    );
\FSM_onehot_tx_state[9]_i_26\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"010C000000000000"
    )
    port map (
      I0 => I2,
      I1 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[2]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I4 => tx_axis_mac_tlast,
      I5 => tx_axis_mac_tuser,
      O => \n_0_FSM_onehot_tx_state[9]_i_26\
    );
\FSM_onehot_tx_state[9]_i_27\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[4]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[6]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[5]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_27\
    );
\FSM_onehot_tx_state[9]_i_28\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000100000"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[4]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[2]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I4 => n_0_tx_mac_tready_reg_i_15,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_19\,
      O => \n_0_FSM_onehot_tx_state[9]_i_28\
    );
\FSM_onehot_tx_state[9]_i_29\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[6]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_29\
    );
\FSM_onehot_tx_state[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAAAABA"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_10\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_11\,
      I2 => \n_0_FSM_onehot_tx_state[9]_i_12\,
      I3 => \n_0_FSM_onehot_tx_state_reg[4]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[0]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[5]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_3\
    );
\FSM_onehot_tx_state[9]_i_30\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000007F"
    )
    port map (
      I0 => tx_axis_mac_tlast,
      I1 => tx_mac_tready_reg,
      I2 => gate_tready,
      I3 => n_0_early_deassert_reg,
      I4 => two_byte_tx,
      O => \n_0_FSM_onehot_tx_state[9]_i_30\
    );
\FSM_onehot_tx_state[9]_i_31\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEFEFEAAAAAAAA"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[6]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I3 => \^tx_ce_sample\,
      I4 => tx_ack_int,
      I5 => \n_0_FSM_onehot_tx_state_reg[7]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_31\
    );
\FSM_onehot_tx_state[9]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0232020202020202"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[9]_i_13\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_14\,
      I2 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I3 => \n_0_FSM_onehot_tx_state[9]_i_15\,
      I4 => n_0_no_burst_i_3,
      I5 => I2,
      O => \n_0_FSM_onehot_tx_state[9]_i_4\
    );
\FSM_onehot_tx_state[9]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_16\,
      I1 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[0]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I5 => \n_0_FSM_onehot_tx_state[7]_i_2\,
      O => \n_0_FSM_onehot_tx_state[9]_i_5\
    );
\FSM_onehot_tx_state[9]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCCCDCDCCCCFDCDC"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_17\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_18\,
      I2 => \n_0_FSM_onehot_tx_state_reg[4]\,
      I3 => \n_0_FSM_onehot_tx_state[9]_i_19\,
      I4 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I5 => \n_0_FSM_onehot_tx_state[9]_i_20\,
      O => \n_0_FSM_onehot_tx_state[9]_i_6\
    );
\FSM_onehot_tx_state[9]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAAAA2A"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_21\,
      I1 => tx_axis_mac_tvalid,
      I2 => \n_0_FSM_onehot_tx_state_reg[6]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[7]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_7\
    );
\FSM_onehot_tx_state[9]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[4]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_8\
    );
\FSM_onehot_tx_state[9]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[2]\,
      O => \n_0_FSM_onehot_tx_state[9]_i_9\
    );
\FSM_onehot_tx_state_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FSM_onehot_tx_state[0]_i_1\,
      Q => \n_0_FSM_onehot_tx_state_reg[0]\,
      S => I1
    );
\FSM_onehot_tx_state_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \n_0_FSM_onehot_tx_state_reg[10]\,
      R => I1
    );
\FSM_onehot_tx_state_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \n_0_FSM_onehot_tx_state_reg[11]\,
      R => I1
    );
\FSM_onehot_tx_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FSM_onehot_tx_state[1]_i_1\,
      Q => \n_0_FSM_onehot_tx_state_reg[1]\,
      R => I1
    );
\FSM_onehot_tx_state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FSM_onehot_tx_state[2]_i_1\,
      Q => \n_0_FSM_onehot_tx_state_reg[2]\,
      R => I1
    );
\FSM_onehot_tx_state_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FSM_onehot_tx_state[3]_i_1\,
      Q => \n_0_FSM_onehot_tx_state_reg[3]\,
      R => I1
    );
\FSM_onehot_tx_state_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FSM_onehot_tx_state[4]_i_1\,
      Q => \n_0_FSM_onehot_tx_state_reg[4]\,
      R => I1
    );
\FSM_onehot_tx_state_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FSM_onehot_tx_state[5]_i_1\,
      Q => \n_0_FSM_onehot_tx_state_reg[5]\,
      R => I1
    );
\FSM_onehot_tx_state_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FSM_onehot_tx_state[6]_i_1\,
      Q => \n_0_FSM_onehot_tx_state_reg[6]\,
      R => I1
    );
\FSM_onehot_tx_state_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FSM_onehot_tx_state[7]_i_1\,
      Q => \n_0_FSM_onehot_tx_state_reg[7]\,
      R => I1
    );
\FSM_onehot_tx_state_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FSM_onehot_tx_state[8]_i_1\,
      Q => \n_0_FSM_onehot_tx_state_reg[8]\,
      R => I1
    );
\FSM_onehot_tx_state_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FSM_onehot_tx_state[9]_i_1\,
      Q => \n_0_FSM_onehot_tx_state_reg[9]\,
      R => I1
    );
\FSM_onehot_tx_state_reg[9]_i_13\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_23\,
      I1 => \n_0_FSM_onehot_tx_state[9]_i_24\,
      O => \n_0_FSM_onehot_tx_state_reg[9]_i_13\,
      S => \n_0_FSM_onehot_tx_state_reg[5]\
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
\INT_CRC_MODE_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => I4,
      O => INT_CRC_MODE
    );
\INT_MAX_FRAME_LENGTH[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => I4,
      O => O3(0)
    );
\LEN[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => Q(1),
      O => O4(0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
\data_count[5]_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => I3,
      O => O1
    );
early_deassert_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0303550300005500"
    )
    port map (
      I0 => I1,
      I1 => n_0_force_assert_i_4,
      I2 => n_0_early_deassert_i_2,
      I3 => n_0_early_deassert_i_3,
      I4 => n_0_early_deassert_i_4,
      I5 => n_0_early_deassert_reg,
      O => n_0_early_deassert_i_1
    );
early_deassert_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFF4"
    )
    port map (
      I0 => \^tx_data_valid_int\,
      I1 => \^tx_ce_sample\,
      I2 => two_byte_tx,
      I3 => I1,
      O => n_0_early_deassert_i_2
    );
early_deassert_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => tx_axis_mac_tvalid,
      I1 => \n_0_tx_data[7]_i_3\,
      O => n_0_early_deassert_i_3
    );
early_deassert_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => gate_tready,
      I1 => tx_mac_tready_reg,
      I2 => tx_axis_mac_tlast,
      O => n_0_early_deassert_i_4
    );
early_deassert_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_early_deassert_i_1,
      Q => n_0_early_deassert_reg,
      R => \<const0>\
    );
early_underrun_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00AA00AB00AA00AA"
    )
    port map (
      I0 => n_0_early_underrun_i_2,
      I1 => n_0_early_underrun_i_3,
      I2 => I2,
      I3 => I1,
      I4 => n_0_early_underrun_i_4,
      I5 => n_0_early_underrun_reg,
      O => n_0_early_underrun_i_1
    );
early_underrun_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      I0 => \n_0_tx_data[7]_i_3\,
      I1 => tx_axis_mac_tuser,
      I2 => tx_mac_tready_reg,
      I3 => gate_tready,
      O => n_0_early_underrun_i_2
    );
early_underrun_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => n_0_force_end_i_4,
      I1 => n_0_force_end_i_7,
      I2 => n_0_no_burst_i_2,
      I3 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[9]\,
      O => n_0_early_underrun_i_3
    );
early_underrun_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_tx_data[7]_i_3\,
      I1 => \n_0_FSM_onehot_tx_state_reg[8]\,
      O => n_0_early_underrun_i_4
    );
early_underrun_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_early_underrun_i_1,
      Q => n_0_early_underrun_reg,
      R => \<const0>\
    );
force_assert_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2322F3FF23220300"
    )
    port map (
      I0 => n_0_force_assert_i_2,
      I1 => I1,
      I2 => n_0_force_assert_i_3,
      I3 => n_0_force_assert_i_4,
      I4 => n_0_force_assert_i_5,
      I5 => n_0_force_assert_reg,
      O => n_0_force_assert_i_1
    );
force_assert_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6020"
    )
    port map (
      I0 => n_0_force_burst2_reg,
      I1 => n_0_force_burst1_reg,
      I2 => \^tx_ce_sample\,
      I3 => tx_ack_int,
      O => n_0_force_assert_i_2
    );
force_assert_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => tx_axis_mac_tlast,
      I1 => n_0_early_deassert_reg,
      O => n_0_force_assert_i_3
    );
force_assert_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_3,
      I1 => n_0_tx_mac_tready_reg_reg_i_4,
      I2 => n_0_tx_mac_tready_reg_i_6,
      I3 => n_0_tx_mac_tready_reg_i_7,
      O => n_0_force_assert_i_4
    );
force_assert_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFF003800"
    )
    port map (
      I0 => tx_ack_int,
      I1 => n_0_force_burst1_reg,
      I2 => n_0_force_burst2_reg,
      I3 => \^tx_ce_sample\,
      I4 => \^tx_data_valid_int\,
      I5 => I1,
      O => n_0_force_assert_i_5
    );
force_assert_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_force_assert_i_1,
      Q => n_0_force_assert_reg,
      R => \<const0>\
    );
force_burst1_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"070F000F"
    )
    port map (
      I0 => tx_ack_int,
      I1 => \^tx_ce_sample\,
      I2 => I1,
      I3 => n_0_force_burst1_i_2,
      I4 => n_0_force_burst1_reg,
      O => n_0_force_burst1_i_1
    );
force_burst1_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00007FFF"
    )
    port map (
      I0 => n_0_tlast_reg_reg,
      I1 => n_0_early_deassert_reg,
      I2 => tx_axis_mac_tvalid,
      I3 => n_0_two_byte_tx_i_2,
      I4 => n_0_force_burst2_i_2,
      O => n_0_force_burst1_i_2
    );
force_burst1_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_force_burst1_i_1,
      Q => n_0_force_burst1_reg,
      R => \<const0>\
    );
force_burst2_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00FB00AA"
    )
    port map (
      I0 => n_0_force_burst2_i_2,
      I1 => \^tx_ce_sample\,
      I2 => n_0_force_burst1_reg,
      I3 => I1,
      I4 => n_0_force_burst2_reg,
      O => n_0_force_burst2_i_1
    );
force_burst2_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000040000000"
    )
    port map (
      I0 => n_0_force_burst2_i_3,
      I1 => n_0_force_end_i_7,
      I2 => n_0_tlast_reg_reg,
      I3 => two_byte_tx,
      I4 => tx_axis_mac_tvalid,
      I5 => n_0_force_end_i_4,
      O => n_0_force_burst2_i_2
    );
force_burst2_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF0001"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[9]\,
      O => n_0_force_burst2_i_3
    );
force_burst2_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_force_burst2_i_1,
      Q => n_0_force_burst2_reg,
      R => \<const0>\
    );
force_end_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F8CC88CC88CC88CC"
    )
    port map (
      I0 => n_0_force_end_i_2,
      I1 => force_end,
      I2 => n_0_force_end_i_3,
      I3 => n_0_force_end_i_4,
      I4 => I2,
      I5 => n_0_force_end_i_6,
      O => n_0_force_end_i_1
    );
force_end_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF3E"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I1 => n_0_force_end_i_7,
      I2 => n_0_no_burst_i_2,
      I3 => \n_0_FSM_onehot_tx_state_reg[8]\,
      O => n_0_force_end_i_2
    );
force_end_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[4]\,
      O => n_0_force_end_i_3
    );
force_end_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[6]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[2]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[3]\,
      O => n_0_force_end_i_4
    );
force_end_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[8]\,
      O => n_0_force_end_i_6
    );
force_end_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[6]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[4]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[5]\,
      O => n_0_force_end_i_7
    );
force_end_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_force_end_i_1,
      Q => force_end,
      R => \<const0>\
    );
gate_tready_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => tx_enable,
      I1 => n_0_tx_mac_tready_reg_reg_i_4,
      I2 => n_0_tx_mac_tready_reg_i_3,
      I3 => n_0_tx_mac_tready_reg_i_2,
      O => n_0_gate_tready_i_1
    );
gate_tready_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_gate_tready_i_1,
      Q => gate_tready,
      S => I1
    );
ignore_packet_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0A0E0A0A"
    )
    port map (
      I0 => n_0_ignore_packet_i_2,
      I1 => tx_axis_mac_tvalid,
      I2 => I1,
      I3 => tx_axis_mac_tlast,
      I4 => n_0_ignore_packet_reg,
      O => n_0_ignore_packet_i_1
    );
ignore_packet_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000400000000000"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I1 => \n_0_tx_data[7]_i_3\,
      I2 => n_0_ignore_packet_i_3,
      I3 => tx_axis_mac_tvalid,
      I4 => n_0_ignore_packet_reg,
      I5 => tx_axis_mac_tuser,
      O => n_0_ignore_packet_i_2
    );
ignore_packet_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => tx_mac_tready_reg,
      I1 => gate_tready,
      O => n_0_ignore_packet_i_3
    );
ignore_packet_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_ignore_packet_i_1,
      Q => n_0_ignore_packet_reg,
      R => \<const0>\
    );
no_burst_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
    port map (
      I0 => n_0_no_burst_i_2,
      I1 => n_0_force_end_i_4,
      I2 => tx_axis_mac_tvalid,
      I3 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[4]\,
      I5 => n_0_no_burst_i_3,
      O => n_0_no_burst_i_1
    );
no_burst_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[9]\,
      O => n_0_no_burst_i_2
    );
no_burst_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[8]\,
      O => n_0_no_burst_i_3
    );
no_burst_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_no_burst_i_1,
      Q => no_burst,
      R => I1
    );
\pause_source_shift[47]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => load_source,
      O => O5
    );
\pause_value_sample[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => sample,
      O => O6
    );
tlast_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3111111130000000"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => I1,
      I2 => tx_axis_mac_tlast,
      I3 => tx_mac_tready_reg,
      I4 => gate_tready,
      I5 => n_0_tlast_reg_reg,
      O => n_0_tlast_reg_i_1
    );
tlast_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_tlast_reg_i_1,
      Q => n_0_tlast_reg_reg,
      R => \<const0>\
    );
two_byte_tx_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
    port map (
      I0 => two_byte_tx,
      I1 => n_0_two_byte_tx_i_2,
      I2 => tx_axis_mac_tlast,
      I3 => I1,
      O => n_0_two_byte_tx_i_1
    );
two_byte_tx_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"10001001"
    )
    port map (
      I0 => n_0_force_end_i_4,
      I1 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I2 => n_0_no_burst_i_2,
      I3 => n_0_force_end_i_7,
      I4 => \n_0_FSM_onehot_tx_state_reg[9]\,
      O => n_0_two_byte_tx_i_2
    );
two_byte_tx_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_two_byte_tx_i_1,
      Q => two_byte_tx,
      R => \<const0>\
    );
tx_axis_mac_tready_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => gate_tready,
      I1 => tx_mac_tready_reg,
      O => \^e\(0)
    );
\tx_data[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF758A00"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => \n_0_tx_data[7]_i_3\,
      I2 => \n_0_tx_data[7]_i_4\,
      I3 => tx_axis_mac_tdata(0),
      I4 => tx_data_hold(0),
      O => p_1_in(0)
    );
\tx_data[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF758A00"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => \n_0_tx_data[7]_i_3\,
      I2 => \n_0_tx_data[7]_i_4\,
      I3 => tx_axis_mac_tdata(1),
      I4 => tx_data_hold(1),
      O => p_1_in(1)
    );
\tx_data[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF758A00"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => \n_0_tx_data[7]_i_3\,
      I2 => \n_0_tx_data[7]_i_4\,
      I3 => tx_axis_mac_tdata(2),
      I4 => tx_data_hold(2),
      O => p_1_in(2)
    );
\tx_data[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF758A00"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => \n_0_tx_data[7]_i_3\,
      I2 => \n_0_tx_data[7]_i_4\,
      I3 => tx_axis_mac_tdata(3),
      I4 => tx_data_hold(3),
      O => p_1_in(3)
    );
\tx_data[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF758A00"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => \n_0_tx_data[7]_i_3\,
      I2 => \n_0_tx_data[7]_i_4\,
      I3 => tx_axis_mac_tdata(4),
      I4 => tx_data_hold(4),
      O => p_1_in(4)
    );
\tx_data[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF758A00"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => \n_0_tx_data[7]_i_3\,
      I2 => \n_0_tx_data[7]_i_4\,
      I3 => tx_axis_mac_tdata(5),
      I4 => tx_data_hold(5),
      O => p_1_in(5)
    );
\tx_data[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF758A00"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => \n_0_tx_data[7]_i_3\,
      I2 => \n_0_tx_data[7]_i_4\,
      I3 => tx_axis_mac_tdata(6),
      I4 => tx_data_hold(6),
      O => p_1_in(6)
    );
\tx_data[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA8A"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => \n_0_tx_data[7]_i_3\,
      I2 => \n_0_tx_data[7]_i_4\,
      I3 => tx_ack_int,
      O => \n_0_tx_data[7]_i_1\
    );
\tx_data[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF758A00"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => \n_0_tx_data[7]_i_3\,
      I2 => \n_0_tx_data[7]_i_4\,
      I3 => tx_axis_mac_tdata(7),
      I4 => tx_data_hold(7),
      O => p_1_in(7)
    );
\tx_data[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000080"
    )
    port map (
      I0 => n_0_force_end_i_7,
      I1 => \n_0_tx_data[7]_i_5\,
      I2 => n_0_force_end_i_4,
      I3 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[5]\,
      O => \n_0_tx_data[7]_i_3\
    );
\tx_data[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFF0FFFB"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I1 => tx_ack_int,
      I2 => n_0_force_end_i_4,
      I3 => n_0_force_end_i_7,
      I4 => n_0_no_burst_i_2,
      I5 => \n_0_FSM_onehot_tx_state_reg[8]\,
      O => \n_0_tx_data[7]_i_4\
    );
\tx_data[7]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[3]\,
      O => \n_0_tx_data[7]_i_5\
    );
\tx_data_hold_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \^e\(0),
      D => tx_axis_mac_tdata(0),
      Q => tx_data_hold(0),
      R => I1
    );
\tx_data_hold_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \^e\(0),
      D => tx_axis_mac_tdata(1),
      Q => tx_data_hold(1),
      R => I1
    );
\tx_data_hold_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \^e\(0),
      D => tx_axis_mac_tdata(2),
      Q => tx_data_hold(2),
      R => I1
    );
\tx_data_hold_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \^e\(0),
      D => tx_axis_mac_tdata(3),
      Q => tx_data_hold(3),
      R => I1
    );
\tx_data_hold_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \^e\(0),
      D => tx_axis_mac_tdata(4),
      Q => tx_data_hold(4),
      R => I1
    );
\tx_data_hold_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \^e\(0),
      D => tx_axis_mac_tdata(5),
      Q => tx_data_hold(5),
      R => I1
    );
\tx_data_hold_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \^e\(0),
      D => tx_axis_mac_tdata(6),
      Q => tx_data_hold(6),
      R => I1
    );
\tx_data_hold_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \^e\(0),
      D => tx_axis_mac_tdata(7),
      Q => tx_data_hold(7),
      R => I1
    );
\tx_data_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_tx_data[7]_i_1\,
      D => p_1_in(0),
      Q => O7(0),
      R => I1
    );
\tx_data_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_tx_data[7]_i_1\,
      D => p_1_in(1),
      Q => O7(1),
      R => I1
    );
\tx_data_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_tx_data[7]_i_1\,
      D => p_1_in(2),
      Q => O7(2),
      R => I1
    );
\tx_data_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_tx_data[7]_i_1\,
      D => p_1_in(3),
      Q => O7(3),
      R => I1
    );
\tx_data_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_tx_data[7]_i_1\,
      D => p_1_in(4),
      Q => O7(4),
      R => I1
    );
\tx_data_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_tx_data[7]_i_1\,
      D => p_1_in(5),
      Q => O7(5),
      R => I1
    );
\tx_data_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_tx_data[7]_i_1\,
      D => p_1_in(6),
      Q => O7(6),
      R => I1
    );
\tx_data_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_tx_data[7]_i_1\,
      D => p_1_in(7),
      Q => O7(7),
      R => I1
    );
tx_data_valid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0D0D0F0D0C0C0F0C"
    )
    port map (
      I0 => n_0_tx_data_valid_i_2,
      I1 => n_0_tx_data_valid_i_3,
      I2 => I1,
      I3 => n_0_tx_data_valid_i_4,
      I4 => n_0_tx_data_valid_i_5,
      I5 => \^tx_data_valid_int\,
      O => n_0_tx_data_valid_i_1
    );
tx_data_valid_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888888888A8888"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => n_0_tx_data_valid_i_6,
      I2 => n_0_tx_mac_tready_reg_reg_i_4,
      I3 => n_0_tx_mac_tready_reg_i_3,
      I4 => n_0_tx_mac_tready_reg_i_7,
      I5 => n_0_tx_mac_tready_reg_i_6,
      O => n_0_tx_data_valid_i_2
    );
tx_data_valid_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => n_0_force_assert_reg,
      O => n_0_tx_data_valid_i_3
    );
tx_data_valid_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_6,
      I1 => n_0_tx_mac_tready_reg_i_7,
      O => n_0_tx_data_valid_i_4
    );
tx_data_valid_i_5: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_3,
      I1 => n_0_tx_mac_tready_reg_reg_i_4,
      O => n_0_tx_data_valid_i_5
    );
tx_data_valid_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F8888888"
    )
    port map (
      I0 => n_0_tx_data_valid_i_7,
      I1 => two_byte_tx,
      I2 => tx_ack_int,
      I3 => \^tx_ce_sample\,
      I4 => n_0_early_deassert_reg,
      O => n_0_tx_data_valid_i_6
    );
tx_data_valid_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0008000800080000"
    )
    port map (
      I0 => n_0_no_burst_i_2,
      I1 => n_0_force_end_i_4,
      I2 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[4]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[8]\,
      O => n_0_tx_data_valid_i_7
    );
tx_data_valid_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_tx_data_valid_i_1,
      Q => \^tx_data_valid_int\,
      R => \<const0>\
    );
tx_enable_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => tx_enable,
      Q => \^tx_ce_sample\,
      R => \<const0>\
    );
tx_mac_tready_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00000004"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_2,
      I1 => n_0_tx_mac_tready_reg_i_3,
      I2 => n_0_tx_mac_tready_reg_reg_i_4,
      I3 => two_byte_tx,
      I4 => n_0_early_deassert_reg,
      I5 => n_0_tx_mac_tready_reg_i_5,
      O => tx_mac_tready_reg0
    );
tx_mac_tready_reg_i_11: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_25,
      I1 => n_0_force_end_i_7,
      O => n_0_tx_mac_tready_reg_i_11
    );
tx_mac_tready_reg_i_12: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAABFAAAAAA"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_26,
      I1 => n_0_no_burst_i_2,
      I2 => n_0_force_end_i_4,
      I3 => n_0_tx_mac_tready_reg_i_15,
      I4 => n_0_force_end_i_7,
      I5 => n_0_tx_mac_tready_reg_i_27,
      O => n_0_tx_mac_tready_reg_i_12
    );
tx_mac_tready_reg_i_13: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF003FE0FFFF3FFF"
    )
    port map (
      I0 => tx_axis_mac_tvalid,
      I1 => n_0_force_end_i_7,
      I2 => \n_0_tx_data[7]_i_5\,
      I3 => n_0_force_end_i_4,
      I4 => n_0_tx_mac_tready_reg_i_28,
      I5 => I2,
      O => n_0_tx_mac_tready_reg_i_13
    );
tx_mac_tready_reg_i_14: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B0"
    )
    port map (
      I0 => n_0_no_burst_i_2,
      I1 => tx_axis_mac_tvalid,
      I2 => n_0_force_end_i_4,
      O => n_0_tx_mac_tready_reg_i_14
    );
tx_mac_tready_reg_i_15: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_axis_mac_tuser,
      I1 => tx_axis_mac_tlast,
      O => n_0_tx_mac_tready_reg_i_15
    );
tx_mac_tready_reg_i_16: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888888888888880"
    )
    port map (
      I0 => tx_axis_mac_tvalid,
      I1 => n_0_no_burst_i_2,
      I2 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[2]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[6]\,
      O => n_0_tx_mac_tready_reg_i_16
    );
tx_mac_tready_reg_i_17: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FC00FC3BFC3BFC3B"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_29,
      I1 => n_0_force_end_i_4,
      I2 => tx_axis_mac_tvalid,
      I3 => n_0_no_burst_i_2,
      I4 => \^tx_ce_sample\,
      I5 => tx_ack_int,
      O => n_0_tx_mac_tready_reg_i_17
    );
tx_mac_tready_reg_i_18: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0C3C0C3BBBBC0C3"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state[9]_i_22\,
      I1 => n_0_force_end_i_4,
      I2 => n_0_tx_mac_tready_reg_i_15,
      I3 => I2,
      I4 => \n_0_tx_data[7]_i_5\,
      I5 => n_0_tx_mac_tready_reg_i_28,
      O => n_0_tx_mac_tready_reg_i_18
    );
tx_mac_tready_reg_i_19: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7575754575757575"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => n_0_tx_mac_tready_reg_i_28,
      I2 => \n_0_tx_data[7]_i_5\,
      I3 => n_0_early_deassert_reg,
      I4 => two_byte_tx,
      I5 => n_0_early_deassert_i_4,
      O => n_0_tx_mac_tready_reg_i_19
    );
tx_mac_tready_reg_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_6,
      I1 => n_0_tx_mac_tready_reg_i_7,
      O => n_0_tx_mac_tready_reg_i_2
    );
tx_mac_tready_reg_i_20: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFDFF"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => n_0_ignore_packet_reg,
      I2 => no_burst,
      I3 => tx_axis_mac_tvalid,
      I4 => tx_axis_mac_tuser,
      O => n_0_tx_mac_tready_reg_i_20
    );
tx_mac_tready_reg_i_21: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5555555455545554"
    )
    port map (
      I0 => tx_axis_mac_tvalid,
      I1 => force_end,
      I2 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I4 => \^tx_ce_sample\,
      I5 => tx_ack_int,
      O => n_0_tx_mac_tready_reg_i_21
    );
tx_mac_tready_reg_i_22: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I4 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[5]\,
      O => n_0_tx_mac_tready_reg_i_22
    );
tx_mac_tready_reg_i_23: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A800"
    )
    port map (
      I0 => n_0_no_burst_i_2,
      I1 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I3 => tx_axis_mac_tvalid,
      O => n_0_tx_mac_tready_reg_i_23
    );
tx_mac_tready_reg_i_24: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5755575544444744"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I2 => \n_0_FSM_onehot_tx_state[9]_i_15\,
      I3 => \n_0_tx_data[7]_i_5\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_30\,
      I5 => \n_0_FSM_onehot_tx_state_reg[8]\,
      O => n_0_tx_mac_tready_reg_i_24
    );
tx_mac_tready_reg_i_25: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8000000A800A8"
    )
    port map (
      I0 => n_0_force_end_i_4,
      I1 => \n_0_FSM_onehot_tx_state_reg[4]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I3 => \^tx_ce_sample\,
      I4 => \n_0_FSM_onehot_tx_state[9]_i_30\,
      I5 => n_0_no_burst_i_2,
      O => n_0_tx_mac_tready_reg_i_25
    );
tx_mac_tready_reg_i_26: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FA00FB00A000F0"
    )
    port map (
      I0 => tx_axis_mac_tvalid,
      I1 => force_end,
      I2 => n_0_no_burst_i_2,
      I3 => n_0_force_end_i_7,
      I4 => I2,
      I5 => n_0_force_end_i_4,
      O => n_0_tx_mac_tready_reg_i_26
    );
tx_mac_tready_reg_i_27: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FE000000"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[3]\,
      I2 => n_0_tx_mac_tready_reg_i_28,
      I3 => tx_ack_int,
      I4 => \^tx_ce_sample\,
      I5 => n_0_force_end_i_4,
      O => n_0_tx_mac_tready_reg_i_27
    );
tx_mac_tready_reg_i_28: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[5]\,
      O => n_0_tx_mac_tready_reg_i_28
    );
tx_mac_tready_reg_i_29: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => \n_0_FSM_onehot_tx_state_reg[7]\,
      I1 => \n_0_FSM_onehot_tx_state_reg[5]\,
      I2 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I3 => force_end,
      I4 => \n_0_FSM_onehot_tx_state_reg[1]\,
      I5 => \n_0_FSM_onehot_tx_state_reg[3]\,
      O => n_0_tx_mac_tready_reg_i_29
    );
tx_mac_tready_reg_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFA000C000A000C"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_8,
      I1 => n_0_tx_mac_tready_reg_i_9,
      I2 => \n_0_FSM_onehot_tx_state_reg[9]\,
      I3 => \n_0_FSM_onehot_tx_state_reg[8]\,
      I4 => n_0_force_end_i_7,
      I5 => n_0_tx_mac_tready_reg_reg_i_10,
      O => n_0_tx_mac_tready_reg_i_3
    );
tx_mac_tready_reg_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BAEEBAFEAAEBAAEB"
    )
    port map (
      I0 => n_0_ignore_packet_reg,
      I1 => n_0_tx_mac_tready_reg_reg_i_4,
      I2 => n_0_tx_mac_tready_reg_i_6,
      I3 => n_0_tx_mac_tready_reg_i_3,
      I4 => tx_axis_mac_tlast,
      I5 => n_0_tx_mac_tready_reg_i_7,
      O => n_0_tx_mac_tready_reg_i_5
    );
tx_mac_tready_reg_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0AFF22000A002200"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_13,
      I1 => n_0_tx_mac_tready_reg_i_14,
      I2 => n_0_tx_mac_tready_reg_i_15,
      I3 => n_0_no_burst_i_3,
      I4 => n_0_force_end_i_7,
      I5 => n_0_tx_mac_tready_reg_i_16,
      O => n_0_tx_mac_tready_reg_i_6
    );
tx_mac_tready_reg_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"305F3F5F3F5F3F5F"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_17,
      I1 => n_0_tx_mac_tready_reg_i_18,
      I2 => n_0_no_burst_i_3,
      I3 => n_0_force_end_i_7,
      I4 => n_0_tx_mac_tready_reg_i_19,
      I5 => n_0_force_end_i_4,
      O => n_0_tx_mac_tready_reg_i_7
    );
tx_mac_tready_reg_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0808080833003303"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_20,
      I1 => n_0_force_end_i_4,
      I2 => n_0_no_burst_i_3,
      I3 => I2,
      I4 => n_0_tx_mac_tready_reg_i_15,
      I5 => n_0_no_burst_i_2,
      O => n_0_tx_mac_tready_reg_i_8
    );
tx_mac_tready_reg_i_9: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000300BBBB8B88"
    )
    port map (
      I0 => n_0_tx_mac_tready_reg_i_21,
      I1 => n_0_force_end_i_4,
      I2 => tx_axis_mac_tvalid,
      I3 => n_0_tx_mac_tready_reg_i_22,
      I4 => I2,
      I5 => n_0_no_burst_i_2,
      O => n_0_tx_mac_tready_reg_i_9
    );
tx_mac_tready_reg_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => tx_mac_tready_reg0,
      Q => tx_mac_tready_reg,
      R => I1
    );
tx_mac_tready_reg_reg_i_10: unisim.vcomponents.MUXF7
    port map (
      I0 => n_0_tx_mac_tready_reg_i_23,
      I1 => n_0_tx_mac_tready_reg_i_24,
      O => n_0_tx_mac_tready_reg_reg_i_10,
      S => n_0_force_end_i_4
    );
tx_mac_tready_reg_reg_i_4: unisim.vcomponents.MUXF7
    port map (
      I0 => n_0_tx_mac_tready_reg_i_11,
      I1 => n_0_tx_mac_tready_reg_i_12,
      O => n_0_tx_mac_tready_reg_reg_i_4,
      S => n_0_no_burst_i_3
    );
tx_underrun_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1303"
    )
    port map (
      I0 => \^tx_ce_sample\,
      I1 => I1,
      I2 => n_0_tx_underrun_i_2,
      I3 => \^tx_underrun_int\,
      O => n_0_tx_underrun_i_1
    );
tx_underrun_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFFF777F"
    )
    port map (
      I0 => n_0_early_underrun_reg,
      I1 => \^tx_ce_sample\,
      I2 => force_end,
      I3 => tx_ack_int,
      I4 => n_0_early_underrun_i_3,
      I5 => n_0_tx_underrun_i_3,
      O => n_0_tx_underrun_i_2
    );
tx_underrun_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A2000000"
    )
    port map (
      I0 => n_0_tx_data_valid_i_7,
      I1 => tx_axis_mac_tvalid,
      I2 => tx_axis_mac_tuser,
      I3 => tx_mac_tready_reg,
      I4 => gate_tready,
      O => n_0_tx_underrun_i_3
    );
tx_underrun_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_tx_underrun_i_1,
      Q => \^tx_underrun_int\,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_tx_cntl is
  port (
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    control_complete : out STD_LOGIC;
    O3 : out STD_LOGIC;
    tx_ack_int : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    O9 : out STD_LOGIC;
    int_tx_data_valid_out : out STD_LOGIC;
    O7 : out STD_LOGIC;
    tx_status : out STD_LOGIC;
    pfc_pause_req_out : out STD_LOGIC;
    int_tx_crc_enable_out : out STD_LOGIC;
    int_tx_vlan_enable_out : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    I11 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    O11 : out STD_LOGIC;
    O12 : out STD_LOGIC;
    O10 : out STD_LOGIC;
    I1 : in STD_LOGIC;
    tx_ce_sample : in STD_LOGIC;
    tx_data_valid_int : in STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    int_tx_ack_in : in STD_LOGIC;
    I4 : in STD_LOGIC;
    pause_status_req : in STD_LOGIC;
    I5 : in STD_LOGIC;
    I6 : in STD_LOGIC;
    REG_DATA_VALID : in STD_LOGIC;
    I7 : in STD_LOGIC;
    INT_ENABLE : in STD_LOGIC;
    I8 : in STD_LOGIC;
    I9 : in STD_LOGIC;
    MAX_PKT_LEN_REACHED : in STD_LOGIC;
    pause_status_int : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 49 downto 0 );
    pause_req : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 7 downto 0 );
    I2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    I10 : in STD_LOGIC;
    tx_statistics_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    tx_statistics_valid : in STD_LOGIC;
    I15 : in STD_LOGIC;
    pfc_req : in STD_LOGIC;
    data_out : in STD_LOGIC;
    pause_req_int0 : in STD_LOGIC;
    I16 : in STD_LOGIC;
    I17 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I12 : in STD_LOGIC;
    I13 : in STD_LOGIC;
    I14 : in STD_LOGIC;
    I18 : in STD_LOGIC;
    I19 : in STD_LOGIC;
    I20 : in STD_LOGIC;
    I21 : in STD_LOGIC
  );
end TriMACtri_mode_ethernet_mac_v8_1_tx_cntl;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_tx_cntl is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal \^o2\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC;
  signal \^o5\ : STD_LOGIC;
  signal \^o6\ : STD_LOGIC;
  signal \^o7\ : STD_LOGIC;
  signal ack_int : STD_LOGIC;
  signal \^control_complete\ : STD_LOGIC;
  signal control_complete0 : STD_LOGIC;
  signal control_complete_1 : STD_LOGIC;
  signal data3 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal data_avail_control3_out : STD_LOGIC;
  signal data_control : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal data_control_0 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal end_of_tx_reg : STD_LOGIC;
  signal fixed_frame_fields : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal n_0_DST_ADDR_BYTE_MATCH_i_4 : STD_LOGIC;
  signal n_0_DST_ADDR_BYTE_MATCH_i_5 : STD_LOGIC;
  signal n_0_ack_out_i_1 : STD_LOGIC;
  signal n_0_control_complete_i_1 : STD_LOGIC;
  signal n_0_control_complete_i_4 : STD_LOGIC;
  signal n_0_data_avail_control_i_1 : STD_LOGIC;
  signal n_0_data_avail_control_i_2 : STD_LOGIC;
  signal n_0_data_avail_control_i_4 : STD_LOGIC;
  signal \n_0_data_control[0]_i_2\ : STD_LOGIC;
  signal \n_0_data_control[1]_i_2\ : STD_LOGIC;
  signal \n_0_data_control[2]_i_2\ : STD_LOGIC;
  signal \n_0_data_control[3]_i_2\ : STD_LOGIC;
  signal \n_0_data_control[4]_i_2\ : STD_LOGIC;
  signal \n_0_data_control[5]_i_2\ : STD_LOGIC;
  signal \n_0_data_control[6]_i_2\ : STD_LOGIC;
  signal \n_0_data_control[7]_i_2\ : STD_LOGIC;
  signal \n_0_data_control[7]_i_3\ : STD_LOGIC;
  signal \n_0_data_control[7]_i_4\ : STD_LOGIC;
  signal \n_0_data_control[7]_i_5\ : STD_LOGIC;
  signal \n_0_data_control[7]_i_6\ : STD_LOGIC;
  signal \n_0_data_count[0]_i_1\ : STD_LOGIC;
  signal \n_0_data_count[1]_i_1\ : STD_LOGIC;
  signal \n_0_data_count[2]_i_1\ : STD_LOGIC;
  signal \n_0_data_count[3]_i_1\ : STD_LOGIC;
  signal \n_0_data_count[3]_i_2\ : STD_LOGIC;
  signal \n_0_data_count[4]_i_1\ : STD_LOGIC;
  signal \n_0_data_count[4]_i_3\ : STD_LOGIC;
  signal \n_0_data_count[5]_i_1\ : STD_LOGIC;
  signal \n_0_data_count[5]_i_2__0\ : STD_LOGIC;
  signal \n_0_data_count[5]_i_4\ : STD_LOGIC;
  signal \n_0_data_count_reg[0]\ : STD_LOGIC;
  signal \n_0_data_count_reg[1]\ : STD_LOGIC;
  signal \n_0_data_count_reg[2]\ : STD_LOGIC;
  signal \n_0_data_count_reg[3]\ : STD_LOGIC;
  signal \n_0_data_count_reg[4]\ : STD_LOGIC;
  signal \n_0_data_count_reg[5]\ : STD_LOGIC;
  signal n_0_end_of_tx_held_i_1 : STD_LOGIC;
  signal n_0_end_of_tx_held_i_2 : STD_LOGIC;
  signal n_0_end_of_tx_held_reg : STD_LOGIC;
  signal n_0_load_source_i_1 : STD_LOGIC;
  signal n_0_mux_control_i_1 : STD_LOGIC;
  signal n_0_mux_control_i_2 : STD_LOGIC;
  signal n_0_mux_control_i_3 : STD_LOGIC;
  signal n_0_mux_control_i_4 : STD_LOGIC;
  signal n_0_pause_req_int_i_1 : STD_LOGIC;
  signal \n_0_pause_source_shift[0]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[10]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[11]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[12]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[13]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[14]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[15]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[16]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[17]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[18]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[19]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[1]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[20]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[21]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[22]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[23]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[24]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[25]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[26]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[27]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[28]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[29]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[2]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[30]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[31]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[32]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[33]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[34]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[35]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[36]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[37]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[38]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[39]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[3]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[4]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[5]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[6]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[7]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[8]_i_1\ : STD_LOGIC;
  signal \n_0_pause_source_shift[9]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value_sample[10]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value_sample[11]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value_sample[12]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value_sample[13]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value_sample[14]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value_sample[15]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value_sample[8]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value_sample[9]_i_1\ : STD_LOGIC;
  signal \n_0_pause_value_sample_reg[0]\ : STD_LOGIC;
  signal \n_0_pause_value_sample_reg[1]\ : STD_LOGIC;
  signal \n_0_pause_value_sample_reg[2]\ : STD_LOGIC;
  signal \n_0_pause_value_sample_reg[3]\ : STD_LOGIC;
  signal \n_0_pause_value_sample_reg[4]\ : STD_LOGIC;
  signal \n_0_pause_value_sample_reg[5]\ : STD_LOGIC;
  signal \n_0_pause_value_sample_reg[6]\ : STD_LOGIC;
  signal \n_0_pause_value_sample_reg[7]\ : STD_LOGIC;
  signal n_0_pfc_pause_req_int_i_1 : STD_LOGIC;
  signal n_0_sample_int_i_1 : STD_LOGIC;
  signal n_0_sample_int_i_2 : STD_LOGIC;
  signal \n_0_state_count[0]_i_1\ : STD_LOGIC;
  signal \n_0_state_count[1]_i_1\ : STD_LOGIC;
  signal \n_0_state_count[2]_i_1\ : STD_LOGIC;
  signal \n_0_state_count[2]_i_2\ : STD_LOGIC;
  signal \n_0_state_count[2]_i_3\ : STD_LOGIC;
  signal \n_0_state_count[2]_i_4\ : STD_LOGIC;
  signal \n_0_state_count_reg[1]\ : STD_LOGIC;
  signal \n_0_state_count_reg[2]\ : STD_LOGIC;
  signal pause_req_int : STD_LOGIC;
  signal pause_source_shift : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal \^pfc_pause_req_out\ : STD_LOGIC;
  signal \pfc_quanta_pipe_reg[1]_0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^tx_ack_int\ : STD_LOGIC;
  signal \^tx_status\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of CFL_i_2 : label is "soft_lutpair123";
  attribute SOFT_HLUTNM of \DATA_REG[0][1]_i_1\ : label is "soft_lutpair143";
  attribute SOFT_HLUTNM of \DATA_REG[0][2]_i_1\ : label is "soft_lutpair153";
  attribute SOFT_HLUTNM of \DATA_REG[0][3]_i_1\ : label is "soft_lutpair154";
  attribute SOFT_HLUTNM of \DATA_REG[0][4]_i_1\ : label is "soft_lutpair155";
  attribute SOFT_HLUTNM of \DATA_REG[0][5]_i_1\ : label is "soft_lutpair125";
  attribute SOFT_HLUTNM of \DATA_REG[0][6]_i_1\ : label is "soft_lutpair155";
  attribute SOFT_HLUTNM of \DATA_REG[0][7]_i_1\ : label is "soft_lutpair154";
  attribute SOFT_HLUTNM of DST_ADDR_BYTE_MATCH_i_5 : label is "soft_lutpair125";
  attribute SOFT_HLUTNM of INT_CRC_MODE_i_1 : label is "soft_lutpair143";
  attribute SOFT_HLUTNM of INT_VLAN_ENABLE_i_1 : label is "soft_lutpair153";
  attribute SOFT_HLUTNM of REG_DATA_VALID_i_1 : label is "soft_lutpair123";
  attribute SOFT_HLUTNM of ack_out_i_1 : label is "soft_lutpair128";
  attribute SOFT_HLUTNM of data_avail_control_i_3 : label is "soft_lutpair124";
  attribute SOFT_HLUTNM of data_avail_control_i_4 : label is "soft_lutpair129";
  attribute SOFT_HLUTNM of \data_count[0]_i_1\ : label is "soft_lutpair126";
  attribute SOFT_HLUTNM of \data_count[3]_i_2\ : label is "soft_lutpair124";
  attribute SOFT_HLUTNM of \data_count[4]_i_3\ : label is "soft_lutpair122";
  attribute SOFT_HLUTNM of \data_count[5]_i_2__0\ : label is "soft_lutpair126";
  attribute SOFT_HLUTNM of \data_count[5]_i_4\ : label is "soft_lutpair122";
  attribute SOFT_HLUTNM of force_end_i_5 : label is "soft_lutpair128";
  attribute SOFT_HLUTNM of mux_control_i_4 : label is "soft_lutpair127";
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \pause_fixed_field_lut[0].LUT4_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \pause_fixed_field_lut[1].LUT4_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \pause_fixed_field_lut[2].LUT4_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \pause_fixed_field_lut[3].LUT4_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \pause_fixed_field_lut[4].LUT4_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \pause_fixed_field_lut[5].LUT4_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \pause_fixed_field_lut[6].LUT4_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \pause_fixed_field_lut[7].LUT4_special_pause_inst\ : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of \pause_source_shift[0]_i_1\ : label is "soft_lutpair152";
  attribute SOFT_HLUTNM of \pause_source_shift[10]_i_1\ : label is "soft_lutpair144";
  attribute SOFT_HLUTNM of \pause_source_shift[11]_i_1\ : label is "soft_lutpair148";
  attribute SOFT_HLUTNM of \pause_source_shift[12]_i_1\ : label is "soft_lutpair147";
  attribute SOFT_HLUTNM of \pause_source_shift[13]_i_1\ : label is "soft_lutpair141";
  attribute SOFT_HLUTNM of \pause_source_shift[14]_i_1\ : label is "soft_lutpair146";
  attribute SOFT_HLUTNM of \pause_source_shift[15]_i_1\ : label is "soft_lutpair139";
  attribute SOFT_HLUTNM of \pause_source_shift[16]_i_1\ : label is "soft_lutpair138";
  attribute SOFT_HLUTNM of \pause_source_shift[17]_i_1\ : label is "soft_lutpair146";
  attribute SOFT_HLUTNM of \pause_source_shift[18]_i_1\ : label is "soft_lutpair136";
  attribute SOFT_HLUTNM of \pause_source_shift[19]_i_1\ : label is "soft_lutpair140";
  attribute SOFT_HLUTNM of \pause_source_shift[1]_i_1\ : label is "soft_lutpair151";
  attribute SOFT_HLUTNM of \pause_source_shift[20]_i_1\ : label is "soft_lutpair137";
  attribute SOFT_HLUTNM of \pause_source_shift[21]_i_1\ : label is "soft_lutpair135";
  attribute SOFT_HLUTNM of \pause_source_shift[22]_i_1\ : label is "soft_lutpair134";
  attribute SOFT_HLUTNM of \pause_source_shift[23]_i_1\ : label is "soft_lutpair132";
  attribute SOFT_HLUTNM of \pause_source_shift[24]_i_1\ : label is "soft_lutpair133";
  attribute SOFT_HLUTNM of \pause_source_shift[25]_i_1\ : label is "soft_lutpair145";
  attribute SOFT_HLUTNM of \pause_source_shift[26]_i_1\ : label is "soft_lutpair142";
  attribute SOFT_HLUTNM of \pause_source_shift[27]_i_1\ : label is "soft_lutpair145";
  attribute SOFT_HLUTNM of \pause_source_shift[28]_i_1\ : label is "soft_lutpair144";
  attribute SOFT_HLUTNM of \pause_source_shift[29]_i_1\ : label is "soft_lutpair142";
  attribute SOFT_HLUTNM of \pause_source_shift[2]_i_1\ : label is "soft_lutpair150";
  attribute SOFT_HLUTNM of \pause_source_shift[30]_i_1\ : label is "soft_lutpair141";
  attribute SOFT_HLUTNM of \pause_source_shift[31]_i_1\ : label is "soft_lutpair140";
  attribute SOFT_HLUTNM of \pause_source_shift[32]_i_1\ : label is "soft_lutpair139";
  attribute SOFT_HLUTNM of \pause_source_shift[33]_i_1\ : label is "soft_lutpair138";
  attribute SOFT_HLUTNM of \pause_source_shift[34]_i_1\ : label is "soft_lutpair137";
  attribute SOFT_HLUTNM of \pause_source_shift[35]_i_1\ : label is "soft_lutpair136";
  attribute SOFT_HLUTNM of \pause_source_shift[36]_i_1\ : label is "soft_lutpair135";
  attribute SOFT_HLUTNM of \pause_source_shift[37]_i_1\ : label is "soft_lutpair134";
  attribute SOFT_HLUTNM of \pause_source_shift[38]_i_1\ : label is "soft_lutpair133";
  attribute SOFT_HLUTNM of \pause_source_shift[39]_i_1\ : label is "soft_lutpair132";
  attribute SOFT_HLUTNM of \pause_source_shift[3]_i_1\ : label is "soft_lutpair149";
  attribute SOFT_HLUTNM of \pause_source_shift[4]_i_1\ : label is "soft_lutpair148";
  attribute SOFT_HLUTNM of \pause_source_shift[5]_i_1\ : label is "soft_lutpair147";
  attribute SOFT_HLUTNM of \pause_source_shift[6]_i_1\ : label is "soft_lutpair152";
  attribute SOFT_HLUTNM of \pause_source_shift[7]_i_1\ : label is "soft_lutpair151";
  attribute SOFT_HLUTNM of \pause_source_shift[8]_i_1\ : label is "soft_lutpair150";
  attribute SOFT_HLUTNM of \pause_source_shift[9]_i_1\ : label is "soft_lutpair149";
  attribute SOFT_HLUTNM of \pause_value[15]_i_1\ : label is "soft_lutpair131";
  attribute SOFT_HLUTNM of \pause_value_sample[8]_i_1\ : label is "soft_lutpair131";
  attribute SOFT_HLUTNM of sample_int_i_2 : label is "soft_lutpair129";
  attribute SOFT_HLUTNM of \state_count[1]_i_1\ : label is "soft_lutpair130";
  attribute SOFT_HLUTNM of \state_count[2]_i_1\ : label is "soft_lutpair130";
  attribute SOFT_HLUTNM of \state_count[2]_i_3\ : label is "soft_lutpair127";
begin
  O1 <= \^o1\;
  O2 <= \^o2\;
  O3 <= \^o3\;
  O5 <= \^o5\;
  O6 <= \^o6\;
  O7 <= \^o7\;
  control_complete <= \^control_complete\;
  pfc_pause_req_out <= \^pfc_pause_req_out\;
  tx_ack_int <= \^tx_ack_int\;
  tx_status <= \^tx_status\;
CDS_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"E2000000"
    )
    port map (
      I0 => \^o1\,
      I1 => \^o5\,
      I2 => \^o6\,
      I3 => INT_ENABLE,
      I4 => I8,
      O => O8
    );
CFL_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFE2FF"
    )
    port map (
      I0 => \^o1\,
      I1 => \^o5\,
      I2 => \^o6\,
      I3 => I9,
      I4 => MAX_PKT_LEN_REACHED,
      O => O9
    );
\DATA_REG[0][0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => data_control(0),
      I1 => \^o5\,
      I2 => Q(0),
      O => I11(0)
    );
\DATA_REG[0][1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => data_control(1),
      I1 => \^o5\,
      I2 => Q(1),
      O => I11(1)
    );
\DATA_REG[0][2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => data_control(2),
      I1 => \^o5\,
      I2 => Q(2),
      O => I11(2)
    );
\DATA_REG[0][3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => data_control(3),
      I1 => \^o5\,
      I2 => Q(3),
      O => I11(3)
    );
\DATA_REG[0][4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => data_control(4),
      I1 => \^o5\,
      I2 => Q(4),
      O => I11(4)
    );
\DATA_REG[0][5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => data_control(5),
      I1 => \^o5\,
      I2 => Q(5),
      O => I11(5)
    );
\DATA_REG[0][6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => data_control(6),
      I1 => \^o5\,
      I2 => Q(6),
      O => I11(6)
    );
\DATA_REG[0][7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => data_control(7),
      I1 => \^o5\,
      I2 => Q(7),
      O => I11(7)
    );
DST_ADDR_BYTE_MATCH_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B830880000000000"
    )
    port map (
      I0 => data_control(1),
      I1 => \^o5\,
      I2 => Q(1),
      I3 => data_control(4),
      I4 => Q(4),
      I5 => n_0_DST_ADDR_BYTE_MATCH_i_4,
      O => O12
    );
DST_ADDR_BYTE_MATCH_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B830880000000000"
    )
    port map (
      I0 => data_control(6),
      I1 => \^o5\,
      I2 => Q(6),
      I3 => data_control(7),
      I4 => Q(7),
      I5 => n_0_DST_ADDR_BYTE_MATCH_i_5,
      O => O11
    );
DST_ADDR_BYTE_MATCH_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C000A0A0C0000000"
    )
    port map (
      I0 => Q(2),
      I1 => data_control(2),
      I2 => I10,
      I3 => data_control(0),
      I4 => \^o5\,
      I5 => Q(0),
      O => n_0_DST_ADDR_BYTE_MATCH_i_4
    );
DST_ADDR_BYTE_MATCH_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCA000A0"
    )
    port map (
      I0 => Q(5),
      I1 => data_control(5),
      I2 => Q(3),
      I3 => \^o5\,
      I4 => data_control(3),
      O => n_0_DST_ADDR_BYTE_MATCH_i_5
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
INT_CRC_MODE_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => tx_configuration_vector(1),
      I1 => \^o5\,
      O => int_tx_crc_enable_out
    );
INT_VLAN_ENABLE_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => \^o5\,
      O => int_tx_vlan_enable_out
    );
REG_DATA_VALID_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => \^o6\,
      I1 => \^o5\,
      I2 => \^o1\,
      O => int_tx_data_valid_out
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
ack_int_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => int_tx_ack_in,
      Q => ack_int,
      R => I1
    );
ack_out_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000ACA"
    )
    port map (
      I0 => \^tx_ack_int\,
      I1 => int_tx_ack_in,
      I2 => tx_ce_sample,
      I3 => \^o5\,
      I4 => I1,
      O => n_0_ack_out_i_1
    );
ack_out_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_ack_out_i_1,
      Q => \^tx_ack_int\,
      R => \<const0>\
    );
control_complete_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFE2"
    )
    port map (
      I0 => \^control_complete\,
      I1 => tx_ce_sample,
      I2 => control_complete0,
      I3 => control_complete_1,
      O => n_0_control_complete_i_1
    );
control_complete_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000400000000000"
    )
    port map (
      I0 => \n_0_data_count_reg[2]\,
      I1 => \n_0_data_count_reg[5]\,
      I2 => \^pfc_pause_req_out\,
      I3 => n_0_control_complete_i_4,
      I4 => \n_0_data_count_reg[1]\,
      I5 => \n_0_data_count_reg[0]\,
      O => control_complete0
    );
control_complete_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000200000000000"
    )
    port map (
      I0 => n_0_data_avail_control_i_4,
      I1 => \^pfc_pause_req_out\,
      I2 => \n_0_data_count_reg[4]\,
      I3 => \n_0_data_count_reg[0]\,
      I4 => \n_0_data_count_reg[1]\,
      I5 => tx_ce_sample,
      O => control_complete_1
    );
control_complete_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_data_count_reg[3]\,
      I1 => \n_0_data_count_reg[4]\,
      O => n_0_control_complete_i_4
    );
control_complete_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_control_complete_i_1,
      Q => \^control_complete\,
      R => \<const0>\
    );
data_avail_control_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFA2A0A2A"
    )
    port map (
      I0 => \^o6\,
      I1 => \^control_complete\,
      I2 => tx_ce_sample,
      I3 => n_0_data_avail_control_i_2,
      I4 => end_of_tx_reg,
      I5 => data_avail_control3_out,
      O => n_0_data_avail_control_i_1
    );
data_avail_control_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => \n_0_data_count_reg[1]\,
      I1 => \n_0_data_count_reg[0]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      I4 => \n_0_data_count_reg[5]\,
      I5 => \n_0_data_count_reg[4]\,
      O => n_0_data_avail_control_i_2
    );
data_avail_control_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00200000"
    )
    port map (
      I0 => n_0_data_avail_control_i_4,
      I1 => \n_0_data_count_reg[4]\,
      I2 => tx_ce_sample,
      I3 => \n_0_data_count_reg[1]\,
      I4 => \n_0_data_count_reg[0]\,
      O => data_avail_control3_out
    );
data_avail_control_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => \n_0_data_count_reg[2]\,
      I1 => \n_0_data_count_reg[3]\,
      I2 => \n_0_data_count_reg[5]\,
      O => n_0_data_avail_control_i_4
    );
data_avail_control_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_data_avail_control_i_1,
      Q => \^o6\,
      R => \<const0>\
    );
data_avail_in_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_data_valid_int,
      Q => \^o1\,
      R => I1
    );
\data_control[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B833B800"
    )
    port map (
      I0 => data3(0),
      I1 => \n_0_data_control[7]_i_2\,
      I2 => \pfc_quanta_pipe_reg[1]_0\(0),
      I3 => \n_0_data_control[7]_i_3\,
      I4 => \n_0_data_control[0]_i_2\,
      O => data_control_0(0)
    );
\data_control[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F3C0B8B8"
    )
    port map (
      I0 => \^pfc_pause_req_out\,
      I1 => \n_0_data_control[7]_i_5\,
      I2 => fixed_frame_fields(0),
      I3 => pause_source_shift(0),
      I4 => \n_0_data_control[7]_i_6\,
      O => \n_0_data_control[0]_i_2\
    );
\data_control[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B833B800"
    )
    port map (
      I0 => data3(1),
      I1 => \n_0_data_control[7]_i_2\,
      I2 => \pfc_quanta_pipe_reg[1]_0\(1),
      I3 => \n_0_data_control[7]_i_3\,
      I4 => \n_0_data_control[1]_i_2\,
      O => data_control_0(1)
    );
\data_control[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EF40"
    )
    port map (
      I0 => \n_0_data_control[7]_i_5\,
      I1 => pause_source_shift(1),
      I2 => \n_0_data_control[7]_i_6\,
      I3 => fixed_frame_fields(1),
      O => \n_0_data_control[1]_i_2\
    );
\data_control[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B833B800"
    )
    port map (
      I0 => data3(2),
      I1 => \n_0_data_control[7]_i_2\,
      I2 => \pfc_quanta_pipe_reg[1]_0\(2),
      I3 => \n_0_data_control[7]_i_3\,
      I4 => \n_0_data_control[2]_i_2\,
      O => data_control_0(2)
    );
\data_control[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EF40"
    )
    port map (
      I0 => \n_0_data_control[7]_i_5\,
      I1 => pause_source_shift(2),
      I2 => \n_0_data_control[7]_i_6\,
      I3 => fixed_frame_fields(2),
      O => \n_0_data_control[2]_i_2\
    );
\data_control[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B833B800"
    )
    port map (
      I0 => data3(3),
      I1 => \n_0_data_control[7]_i_2\,
      I2 => \pfc_quanta_pipe_reg[1]_0\(3),
      I3 => \n_0_data_control[7]_i_3\,
      I4 => \n_0_data_control[3]_i_2\,
      O => data_control_0(3)
    );
\data_control[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EF40"
    )
    port map (
      I0 => \n_0_data_control[7]_i_5\,
      I1 => pause_source_shift(3),
      I2 => \n_0_data_control[7]_i_6\,
      I3 => fixed_frame_fields(3),
      O => \n_0_data_control[3]_i_2\
    );
\data_control[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B833B800"
    )
    port map (
      I0 => data3(4),
      I1 => \n_0_data_control[7]_i_2\,
      I2 => \pfc_quanta_pipe_reg[1]_0\(4),
      I3 => \n_0_data_control[7]_i_3\,
      I4 => \n_0_data_control[4]_i_2\,
      O => data_control_0(4)
    );
\data_control[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EF40"
    )
    port map (
      I0 => \n_0_data_control[7]_i_5\,
      I1 => pause_source_shift(4),
      I2 => \n_0_data_control[7]_i_6\,
      I3 => fixed_frame_fields(4),
      O => \n_0_data_control[4]_i_2\
    );
\data_control[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B833B800"
    )
    port map (
      I0 => data3(5),
      I1 => \n_0_data_control[7]_i_2\,
      I2 => \pfc_quanta_pipe_reg[1]_0\(5),
      I3 => \n_0_data_control[7]_i_3\,
      I4 => \n_0_data_control[5]_i_2\,
      O => data_control_0(5)
    );
\data_control[5]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EF40"
    )
    port map (
      I0 => \n_0_data_control[7]_i_5\,
      I1 => pause_source_shift(5),
      I2 => \n_0_data_control[7]_i_6\,
      I3 => fixed_frame_fields(5),
      O => \n_0_data_control[5]_i_2\
    );
\data_control[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B833B800"
    )
    port map (
      I0 => data3(6),
      I1 => \n_0_data_control[7]_i_2\,
      I2 => \pfc_quanta_pipe_reg[1]_0\(6),
      I3 => \n_0_data_control[7]_i_3\,
      I4 => \n_0_data_control[6]_i_2\,
      O => data_control_0(6)
    );
\data_control[6]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EF40"
    )
    port map (
      I0 => \n_0_data_control[7]_i_5\,
      I1 => pause_source_shift(6),
      I2 => \n_0_data_control[7]_i_6\,
      I3 => fixed_frame_fields(6),
      O => \n_0_data_control[6]_i_2\
    );
\data_control[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B833B800"
    )
    port map (
      I0 => data3(7),
      I1 => \n_0_data_control[7]_i_2\,
      I2 => \pfc_quanta_pipe_reg[1]_0\(7),
      I3 => \n_0_data_control[7]_i_3\,
      I4 => \n_0_data_control[7]_i_4\,
      O => data_control_0(7)
    );
\data_control[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002000400000004"
    )
    port map (
      I0 => \n_0_data_count_reg[5]\,
      I1 => \n_0_data_count_reg[4]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      I4 => \n_0_data_count_reg[1]\,
      I5 => \n_0_data_count_reg[0]\,
      O => \n_0_data_control[7]_i_2\
    );
\data_control[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFF7FFFF0000"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      I2 => \n_0_data_count_reg[3]\,
      I3 => \n_0_data_count_reg[2]\,
      I4 => \n_0_data_count_reg[4]\,
      I5 => \n_0_data_count_reg[5]\,
      O => \n_0_data_control[7]_i_3\
    );
\data_control[7]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EF40"
    )
    port map (
      I0 => \n_0_data_control[7]_i_5\,
      I1 => pause_source_shift(7),
      I2 => \n_0_data_control[7]_i_6\,
      I3 => fixed_frame_fields(7),
      O => \n_0_data_control[7]_i_4\
    );
\data_control[7]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFF7FFFCC000"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      I2 => \n_0_data_count_reg[3]\,
      I3 => \n_0_data_count_reg[2]\,
      I4 => \n_0_data_count_reg[4]\,
      I5 => \n_0_data_count_reg[5]\,
      O => \n_0_data_control[7]_i_5\
    );
\data_control[7]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1114011000100010"
    )
    port map (
      I0 => \n_0_data_count_reg[4]\,
      I1 => \n_0_data_count_reg[5]\,
      I2 => \n_0_data_count_reg[3]\,
      I3 => \n_0_data_count_reg[2]\,
      I4 => \n_0_data_count_reg[0]\,
      I5 => \n_0_data_count_reg[1]\,
      O => \n_0_data_control[7]_i_6\
    );
\data_control_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => data_control_0(0),
      Q => data_control(0),
      R => \<const0>\
    );
\data_control_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => data_control_0(1),
      Q => data_control(1),
      R => \<const0>\
    );
\data_control_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => data_control_0(2),
      Q => data_control(2),
      R => \<const0>\
    );
\data_control_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => data_control_0(3),
      Q => data_control(3),
      R => \<const0>\
    );
\data_control_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => data_control_0(4),
      Q => data_control(4),
      R => \<const0>\
    );
\data_control_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => data_control_0(5),
      Q => data_control(5),
      R => \<const0>\
    );
\data_control_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => data_control_0(6),
      Q => data_control(6),
      R => \<const0>\
    );
\data_control_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => data_control_0(7),
      Q => data_control(7),
      R => \<const0>\
    );
\data_count[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF19AA"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \^o7\,
      I2 => pause_req_int,
      I3 => tx_ce_sample,
      I4 => I1,
      O => \n_0_data_count[0]_i_1\
    );
\data_count[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF19AA2AAA"
    )
    port map (
      I0 => \n_0_data_count_reg[1]\,
      I1 => \^o7\,
      I2 => pause_req_int,
      I3 => tx_ce_sample,
      I4 => \n_0_data_count_reg[0]\,
      I5 => I1,
      O => \n_0_data_count[1]_i_1\
    );
\data_count[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000006AAA"
    )
    port map (
      I0 => \n_0_data_count_reg[2]\,
      I1 => I15,
      I2 => \n_0_data_count_reg[0]\,
      I3 => \n_0_data_count_reg[1]\,
      I4 => \n_0_data_count[5]_i_2__0\,
      I5 => I1,
      O => \n_0_data_count[2]_i_1\
    );
\data_count[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000006AAA"
    )
    port map (
      I0 => \n_0_data_count_reg[3]\,
      I1 => I15,
      I2 => \n_0_data_count[3]_i_2\,
      I3 => \n_0_data_count_reg[2]\,
      I4 => \n_0_data_count[5]_i_2__0\,
      I5 => I1,
      O => \n_0_data_count[3]_i_1\
    );
\data_count[3]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      O => \n_0_data_count[3]_i_2\
    );
\data_count[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000006A6AAAA"
    )
    port map (
      I0 => \n_0_data_count_reg[4]\,
      I1 => \n_0_data_count[5]_i_4\,
      I2 => \^o7\,
      I3 => pause_req_int,
      I4 => tx_ce_sample,
      I5 => I1,
      O => \n_0_data_count[4]_i_1\
    );
\data_count[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8F8F8FFF"
    )
    port map (
      I0 => \n_0_data_count[4]_i_3\,
      I1 => \n_0_data_count_reg[5]\,
      I2 => \^o5\,
      I3 => \n_0_state_count_reg[2]\,
      I4 => ack_int,
      O => \^o7\
    );
\data_count[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00001000"
    )
    port map (
      I0 => \n_0_data_count_reg[4]\,
      I1 => \n_0_data_count_reg[3]\,
      I2 => \n_0_data_count_reg[0]\,
      I3 => \n_0_data_count_reg[1]\,
      I4 => \n_0_data_count_reg[2]\,
      O => \n_0_data_count[4]_i_3\
    );
\data_count[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF12222222"
    )
    port map (
      I0 => \n_0_data_count_reg[5]\,
      I1 => \n_0_data_count[5]_i_2__0\,
      I2 => I15,
      I3 => \n_0_data_count_reg[4]\,
      I4 => \n_0_data_count[5]_i_4\,
      I5 => I1,
      O => \n_0_data_count[5]_i_1\
    );
\data_count[5]_i_2__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \^o7\,
      I1 => pause_req_int,
      I2 => tx_ce_sample,
      O => \n_0_data_count[5]_i_2__0\
    );
\data_count[5]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => \n_0_data_count_reg[1]\,
      I1 => \n_0_data_count_reg[0]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      O => \n_0_data_count[5]_i_4\
    );
\data_count_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_data_count[0]_i_1\,
      Q => \n_0_data_count_reg[0]\,
      R => \<const0>\
    );
\data_count_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_data_count[1]_i_1\,
      Q => \n_0_data_count_reg[1]\,
      R => \<const0>\
    );
\data_count_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_data_count[2]_i_1\,
      Q => \n_0_data_count_reg[2]\,
      R => \<const0>\
    );
\data_count_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_data_count[3]_i_1\,
      Q => \n_0_data_count_reg[3]\,
      R => \<const0>\
    );
\data_count_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_data_count[4]_i_1\,
      Q => \n_0_data_count_reg[4]\,
      R => \<const0>\
    );
\data_count_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_data_count[5]_i_1\,
      Q => \n_0_data_count_reg[5]\,
      R => \<const0>\
    );
end_of_tx_held_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000EA0A"
    )
    port map (
      I0 => n_0_end_of_tx_held_reg,
      I1 => n_0_end_of_tx_held_i_2,
      I2 => tx_ce_sample,
      I3 => \^o1\,
      I4 => I1,
      O => n_0_end_of_tx_held_i_1
    );
end_of_tx_held_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000E2000000"
    )
    port map (
      I0 => \^o1\,
      I1 => \^o5\,
      I2 => \^o6\,
      I3 => I6,
      I4 => REG_DATA_VALID,
      I5 => I7,
      O => n_0_end_of_tx_held_i_2
    );
end_of_tx_held_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_end_of_tx_held_i_1,
      Q => n_0_end_of_tx_held_reg,
      R => \<const0>\
    );
end_of_tx_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I4,
      Q => end_of_tx_reg,
      R => I1
    );
force_end_i_5: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^tx_ack_int\,
      I1 => tx_ce_sample,
      O => O4
    );
load_source_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000010"
    )
    port map (
      I0 => \n_0_data_count_reg[1]\,
      I1 => \n_0_data_count_reg[0]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[5]\,
      I4 => \n_0_data_count_reg[3]\,
      I5 => \n_0_data_count_reg[4]\,
      O => n_0_load_source_i_1
    );
load_source_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => n_0_load_source_i_1,
      Q => \^o2\,
      R => I1
    );
mux_control_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFEFAFA"
    )
    port map (
      I0 => n_0_mux_control_i_2,
      I1 => pause_status_int,
      I2 => I1,
      I3 => n_0_mux_control_i_3,
      I4 => tx_ce_sample,
      O => n_0_mux_control_i_1
    );
mux_control_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A888AAAAAAAAAAAA"
    )
    port map (
      I0 => \^o5\,
      I1 => pause_req_int,
      I2 => n_0_end_of_tx_held_reg,
      I3 => \^o1\,
      I4 => tx_ce_sample,
      I5 => \^tx_status\,
      O => n_0_mux_control_i_2
    );
mux_control_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80FF80F0"
    )
    port map (
      I0 => \^o5\,
      I1 => n_0_mux_control_i_4,
      I2 => pause_status_req,
      I3 => I5,
      I4 => pause_req_int,
      O => n_0_mux_control_i_3
    );
mux_control_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => \^tx_status\,
      I1 => \n_0_state_count_reg[1]\,
      I2 => \n_0_state_count_reg[2]\,
      O => n_0_mux_control_i_4
    );
mux_control_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_mux_control_i_1,
      Q => \^o5\,
      R => \<const0>\
    );
\pause_fixed_field_lut[0].LUT4_special_pause_inst\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8021"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      O => fixed_frame_fields(0)
    );
\pause_fixed_field_lut[1].LUT4_special_pause_inst\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      O => fixed_frame_fields(1)
    );
\pause_fixed_field_lut[2].LUT4_special_pause_inst\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      O => fixed_frame_fields(2)
    );
\pause_fixed_field_lut[3].LUT4_special_pause_inst\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3000"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      O => fixed_frame_fields(3)
    );
\pause_fixed_field_lut[4].LUT4_special_pause_inst\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      O => fixed_frame_fields(4)
    );
\pause_fixed_field_lut[5].LUT4_special_pause_inst\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0000"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      O => fixed_frame_fields(5)
    );
\pause_fixed_field_lut[6].LUT4_special_pause_inst\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      O => fixed_frame_fields(6)
    );
\pause_fixed_field_lut[7].LUT4_special_pause_inst\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1006"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      O => fixed_frame_fields(7)
    );
pause_req_int_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000EEE"
    )
    port map (
      I0 => pause_req_int,
      I1 => pause_req_int0,
      I2 => tx_ce_sample,
      I3 => \^control_complete\,
      I4 => I1,
      O => n_0_pause_req_int_i_1
    );
pause_req_int_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_pause_req_int_i_1,
      Q => pause_req_int,
      R => \<const0>\
    );
\pause_source_shift[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(2),
      I1 => \^o2\,
      I2 => pause_source_shift(8),
      O => \n_0_pause_source_shift[0]_i_1\
    );
\pause_source_shift[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(12),
      I1 => \^o2\,
      I2 => pause_source_shift(18),
      O => \n_0_pause_source_shift[10]_i_1\
    );
\pause_source_shift[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(13),
      I1 => \^o2\,
      I2 => pause_source_shift(19),
      O => \n_0_pause_source_shift[11]_i_1\
    );
\pause_source_shift[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(14),
      I1 => \^o2\,
      I2 => pause_source_shift(20),
      O => \n_0_pause_source_shift[12]_i_1\
    );
\pause_source_shift[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(15),
      I1 => \^o2\,
      I2 => pause_source_shift(21),
      O => \n_0_pause_source_shift[13]_i_1\
    );
\pause_source_shift[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(16),
      I1 => \^o2\,
      I2 => pause_source_shift(22),
      O => \n_0_pause_source_shift[14]_i_1\
    );
\pause_source_shift[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(17),
      I1 => \^o2\,
      I2 => pause_source_shift(23),
      O => \n_0_pause_source_shift[15]_i_1\
    );
\pause_source_shift[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(18),
      I1 => \^o2\,
      I2 => pause_source_shift(24),
      O => \n_0_pause_source_shift[16]_i_1\
    );
\pause_source_shift[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(19),
      I1 => \^o2\,
      I2 => pause_source_shift(25),
      O => \n_0_pause_source_shift[17]_i_1\
    );
\pause_source_shift[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(20),
      I1 => \^o2\,
      I2 => pause_source_shift(26),
      O => \n_0_pause_source_shift[18]_i_1\
    );
\pause_source_shift[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(21),
      I1 => \^o2\,
      I2 => pause_source_shift(27),
      O => \n_0_pause_source_shift[19]_i_1\
    );
\pause_source_shift[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(3),
      I1 => \^o2\,
      I2 => pause_source_shift(9),
      O => \n_0_pause_source_shift[1]_i_1\
    );
\pause_source_shift[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(22),
      I1 => \^o2\,
      I2 => pause_source_shift(28),
      O => \n_0_pause_source_shift[20]_i_1\
    );
\pause_source_shift[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(23),
      I1 => \^o2\,
      I2 => pause_source_shift(29),
      O => \n_0_pause_source_shift[21]_i_1\
    );
\pause_source_shift[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(24),
      I1 => \^o2\,
      I2 => pause_source_shift(30),
      O => \n_0_pause_source_shift[22]_i_1\
    );
\pause_source_shift[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(25),
      I1 => \^o2\,
      I2 => pause_source_shift(31),
      O => \n_0_pause_source_shift[23]_i_1\
    );
\pause_source_shift[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(26),
      I1 => \^o2\,
      I2 => pause_source_shift(32),
      O => \n_0_pause_source_shift[24]_i_1\
    );
\pause_source_shift[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(27),
      I1 => \^o2\,
      I2 => pause_source_shift(33),
      O => \n_0_pause_source_shift[25]_i_1\
    );
\pause_source_shift[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(28),
      I1 => \^o2\,
      I2 => pause_source_shift(34),
      O => \n_0_pause_source_shift[26]_i_1\
    );
\pause_source_shift[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(29),
      I1 => \^o2\,
      I2 => pause_source_shift(35),
      O => \n_0_pause_source_shift[27]_i_1\
    );
\pause_source_shift[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(30),
      I1 => \^o2\,
      I2 => pause_source_shift(36),
      O => \n_0_pause_source_shift[28]_i_1\
    );
\pause_source_shift[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(31),
      I1 => \^o2\,
      I2 => pause_source_shift(37),
      O => \n_0_pause_source_shift[29]_i_1\
    );
\pause_source_shift[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(4),
      I1 => \^o2\,
      I2 => pause_source_shift(10),
      O => \n_0_pause_source_shift[2]_i_1\
    );
\pause_source_shift[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(32),
      I1 => \^o2\,
      I2 => pause_source_shift(38),
      O => \n_0_pause_source_shift[30]_i_1\
    );
\pause_source_shift[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(33),
      I1 => \^o2\,
      I2 => pause_source_shift(39),
      O => \n_0_pause_source_shift[31]_i_1\
    );
\pause_source_shift[32]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(34),
      I1 => \^o2\,
      I2 => pause_source_shift(40),
      O => \n_0_pause_source_shift[32]_i_1\
    );
\pause_source_shift[33]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(35),
      I1 => \^o2\,
      I2 => pause_source_shift(41),
      O => \n_0_pause_source_shift[33]_i_1\
    );
\pause_source_shift[34]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(36),
      I1 => \^o2\,
      I2 => pause_source_shift(42),
      O => \n_0_pause_source_shift[34]_i_1\
    );
\pause_source_shift[35]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(37),
      I1 => \^o2\,
      I2 => pause_source_shift(43),
      O => \n_0_pause_source_shift[35]_i_1\
    );
\pause_source_shift[36]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(38),
      I1 => \^o2\,
      I2 => pause_source_shift(44),
      O => \n_0_pause_source_shift[36]_i_1\
    );
\pause_source_shift[37]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(39),
      I1 => \^o2\,
      I2 => pause_source_shift(45),
      O => \n_0_pause_source_shift[37]_i_1\
    );
\pause_source_shift[38]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(40),
      I1 => \^o2\,
      I2 => pause_source_shift(46),
      O => \n_0_pause_source_shift[38]_i_1\
    );
\pause_source_shift[39]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(41),
      I1 => \^o2\,
      I2 => pause_source_shift(47),
      O => \n_0_pause_source_shift[39]_i_1\
    );
\pause_source_shift[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(5),
      I1 => \^o2\,
      I2 => pause_source_shift(11),
      O => \n_0_pause_source_shift[3]_i_1\
    );
\pause_source_shift[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(6),
      I1 => \^o2\,
      I2 => pause_source_shift(12),
      O => \n_0_pause_source_shift[4]_i_1\
    );
\pause_source_shift[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(7),
      I1 => \^o2\,
      I2 => pause_source_shift(13),
      O => \n_0_pause_source_shift[5]_i_1\
    );
\pause_source_shift[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(8),
      I1 => \^o2\,
      I2 => pause_source_shift(14),
      O => \n_0_pause_source_shift[6]_i_1\
    );
\pause_source_shift[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(9),
      I1 => \^o2\,
      I2 => pause_source_shift(15),
      O => \n_0_pause_source_shift[7]_i_1\
    );
\pause_source_shift[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(10),
      I1 => \^o2\,
      I2 => pause_source_shift(16),
      O => \n_0_pause_source_shift[8]_i_1\
    );
\pause_source_shift[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => tx_configuration_vector(11),
      I1 => \^o2\,
      I2 => pause_source_shift(17),
      O => \n_0_pause_source_shift[9]_i_1\
    );
\pause_source_shift_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[0]_i_1\,
      Q => pause_source_shift(0),
      R => \<const0>\
    );
\pause_source_shift_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[10]_i_1\,
      Q => pause_source_shift(10),
      R => \<const0>\
    );
\pause_source_shift_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[11]_i_1\,
      Q => pause_source_shift(11),
      R => \<const0>\
    );
\pause_source_shift_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[12]_i_1\,
      Q => pause_source_shift(12),
      R => \<const0>\
    );
\pause_source_shift_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[13]_i_1\,
      Q => pause_source_shift(13),
      R => \<const0>\
    );
\pause_source_shift_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[14]_i_1\,
      Q => pause_source_shift(14),
      R => \<const0>\
    );
\pause_source_shift_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[15]_i_1\,
      Q => pause_source_shift(15),
      R => \<const0>\
    );
\pause_source_shift_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[16]_i_1\,
      Q => pause_source_shift(16),
      R => \<const0>\
    );
\pause_source_shift_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[17]_i_1\,
      Q => pause_source_shift(17),
      R => \<const0>\
    );
\pause_source_shift_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[18]_i_1\,
      Q => pause_source_shift(18),
      R => \<const0>\
    );
\pause_source_shift_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[19]_i_1\,
      Q => pause_source_shift(19),
      R => \<const0>\
    );
\pause_source_shift_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[1]_i_1\,
      Q => pause_source_shift(1),
      R => \<const0>\
    );
\pause_source_shift_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[20]_i_1\,
      Q => pause_source_shift(20),
      R => \<const0>\
    );
\pause_source_shift_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[21]_i_1\,
      Q => pause_source_shift(21),
      R => \<const0>\
    );
\pause_source_shift_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[22]_i_1\,
      Q => pause_source_shift(22),
      R => \<const0>\
    );
\pause_source_shift_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[23]_i_1\,
      Q => pause_source_shift(23),
      R => \<const0>\
    );
\pause_source_shift_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[24]_i_1\,
      Q => pause_source_shift(24),
      R => \<const0>\
    );
\pause_source_shift_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[25]_i_1\,
      Q => pause_source_shift(25),
      R => \<const0>\
    );
\pause_source_shift_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[26]_i_1\,
      Q => pause_source_shift(26),
      R => \<const0>\
    );
\pause_source_shift_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[27]_i_1\,
      Q => pause_source_shift(27),
      R => \<const0>\
    );
\pause_source_shift_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[28]_i_1\,
      Q => pause_source_shift(28),
      R => \<const0>\
    );
\pause_source_shift_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[29]_i_1\,
      Q => pause_source_shift(29),
      R => \<const0>\
    );
\pause_source_shift_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[2]_i_1\,
      Q => pause_source_shift(2),
      R => \<const0>\
    );
\pause_source_shift_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[30]_i_1\,
      Q => pause_source_shift(30),
      R => \<const0>\
    );
\pause_source_shift_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[31]_i_1\,
      Q => pause_source_shift(31),
      R => \<const0>\
    );
\pause_source_shift_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[32]_i_1\,
      Q => pause_source_shift(32),
      R => \<const0>\
    );
\pause_source_shift_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[33]_i_1\,
      Q => pause_source_shift(33),
      R => \<const0>\
    );
\pause_source_shift_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[34]_i_1\,
      Q => pause_source_shift(34),
      R => \<const0>\
    );
\pause_source_shift_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[35]_i_1\,
      Q => pause_source_shift(35),
      R => \<const0>\
    );
\pause_source_shift_reg[36]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[36]_i_1\,
      Q => pause_source_shift(36),
      R => \<const0>\
    );
\pause_source_shift_reg[37]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[37]_i_1\,
      Q => pause_source_shift(37),
      R => \<const0>\
    );
\pause_source_shift_reg[38]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[38]_i_1\,
      Q => pause_source_shift(38),
      R => \<const0>\
    );
\pause_source_shift_reg[39]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[39]_i_1\,
      Q => pause_source_shift(39),
      R => \<const0>\
    );
\pause_source_shift_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[3]_i_1\,
      Q => pause_source_shift(3),
      R => \<const0>\
    );
\pause_source_shift_reg[40]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_configuration_vector(42),
      Q => pause_source_shift(40),
      R => I16
    );
\pause_source_shift_reg[41]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_configuration_vector(43),
      Q => pause_source_shift(41),
      R => I16
    );
\pause_source_shift_reg[42]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_configuration_vector(44),
      Q => pause_source_shift(42),
      R => I16
    );
\pause_source_shift_reg[43]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_configuration_vector(45),
      Q => pause_source_shift(43),
      R => I16
    );
\pause_source_shift_reg[44]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_configuration_vector(46),
      Q => pause_source_shift(44),
      R => I16
    );
\pause_source_shift_reg[45]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_configuration_vector(47),
      Q => pause_source_shift(45),
      R => I16
    );
\pause_source_shift_reg[46]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_configuration_vector(48),
      Q => pause_source_shift(46),
      R => I16
    );
\pause_source_shift_reg[47]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_configuration_vector(49),
      Q => pause_source_shift(47),
      R => I16
    );
\pause_source_shift_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[4]_i_1\,
      Q => pause_source_shift(4),
      R => \<const0>\
    );
\pause_source_shift_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[5]_i_1\,
      Q => pause_source_shift(5),
      R => \<const0>\
    );
\pause_source_shift_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[6]_i_1\,
      Q => pause_source_shift(6),
      R => \<const0>\
    );
\pause_source_shift_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[7]_i_1\,
      Q => pause_source_shift(7),
      R => \<const0>\
    );
\pause_source_shift_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[8]_i_1\,
      Q => pause_source_shift(8),
      R => \<const0>\
    );
\pause_source_shift_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_source_shift[9]_i_1\,
      Q => pause_source_shift(9),
      R => \<const0>\
    );
\pause_value[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => pause_req,
      I1 => \^o3\,
      O => E(0)
    );
\pause_value_sample[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
    port map (
      I0 => I2(2),
      I1 => \^pfc_pause_req_out\,
      I2 => \^o3\,
      I3 => \n_0_pause_value_sample_reg[2]\,
      O => \n_0_pause_value_sample[10]_i_1\
    );
\pause_value_sample[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
    port map (
      I0 => I2(3),
      I1 => \^pfc_pause_req_out\,
      I2 => \^o3\,
      I3 => \n_0_pause_value_sample_reg[3]\,
      O => \n_0_pause_value_sample[11]_i_1\
    );
\pause_value_sample[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
    port map (
      I0 => I2(4),
      I1 => \^pfc_pause_req_out\,
      I2 => \^o3\,
      I3 => \n_0_pause_value_sample_reg[4]\,
      O => \n_0_pause_value_sample[12]_i_1\
    );
\pause_value_sample[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
    port map (
      I0 => I2(5),
      I1 => \^pfc_pause_req_out\,
      I2 => \^o3\,
      I3 => \n_0_pause_value_sample_reg[5]\,
      O => \n_0_pause_value_sample[13]_i_1\
    );
\pause_value_sample[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
    port map (
      I0 => I2(6),
      I1 => \^pfc_pause_req_out\,
      I2 => \^o3\,
      I3 => \n_0_pause_value_sample_reg[6]\,
      O => \n_0_pause_value_sample[14]_i_1\
    );
\pause_value_sample[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
    port map (
      I0 => I2(7),
      I1 => \^pfc_pause_req_out\,
      I2 => \^o3\,
      I3 => \n_0_pause_value_sample_reg[7]\,
      O => \n_0_pause_value_sample[15]_i_1\
    );
\pause_value_sample[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
    port map (
      I0 => I2(0),
      I1 => \^pfc_pause_req_out\,
      I2 => \^o3\,
      I3 => \n_0_pause_value_sample_reg[0]\,
      O => \n_0_pause_value_sample[8]_i_1\
    );
\pause_value_sample[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
    port map (
      I0 => I2(1),
      I1 => \^pfc_pause_req_out\,
      I2 => \^o3\,
      I3 => \n_0_pause_value_sample_reg[1]\,
      O => \n_0_pause_value_sample[9]_i_1\
    );
\pause_value_sample_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I21,
      Q => \n_0_pause_value_sample_reg[0]\,
      R => I17
    );
\pause_value_sample_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_value_sample[10]_i_1\,
      Q => data3(2),
      R => \<const0>\
    );
\pause_value_sample_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_value_sample[11]_i_1\,
      Q => data3(3),
      R => \<const0>\
    );
\pause_value_sample_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_value_sample[12]_i_1\,
      Q => data3(4),
      R => \<const0>\
    );
\pause_value_sample_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_value_sample[13]_i_1\,
      Q => data3(5),
      R => \<const0>\
    );
\pause_value_sample_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_value_sample[14]_i_1\,
      Q => data3(6),
      R => \<const0>\
    );
\pause_value_sample_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_value_sample[15]_i_1\,
      Q => data3(7),
      R => \<const0>\
    );
\pause_value_sample_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I20,
      Q => \n_0_pause_value_sample_reg[1]\,
      R => I17
    );
\pause_value_sample_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I19,
      Q => \n_0_pause_value_sample_reg[2]\,
      R => I17
    );
\pause_value_sample_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I18,
      Q => \n_0_pause_value_sample_reg[3]\,
      R => I17
    );
\pause_value_sample_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I14,
      Q => \n_0_pause_value_sample_reg[4]\,
      R => I17
    );
\pause_value_sample_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I13,
      Q => \n_0_pause_value_sample_reg[5]\,
      R => I17
    );
\pause_value_sample_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I12,
      Q => \n_0_pause_value_sample_reg[6]\,
      R => I17
    );
\pause_value_sample_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I3,
      Q => \n_0_pause_value_sample_reg[7]\,
      R => I17
    );
\pause_value_sample_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_value_sample[8]_i_1\,
      Q => data3(0),
      R => \<const0>\
    );
\pause_value_sample_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_pause_value_sample[9]_i_1\,
      Q => data3(1),
      R => \<const0>\
    );
pause_vector_tx_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0022032202220222"
    )
    port map (
      I0 => tx_statistics_vector(0),
      I1 => I1,
      I2 => tx_statistics_valid,
      I3 => tx_ce_sample,
      I4 => \^pfc_pause_req_out\,
      I5 => \^control_complete\,
      O => O10
    );
pfc_pause_req_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000EAEAEA"
    )
    port map (
      I0 => \^pfc_pause_req_out\,
      I1 => pfc_req,
      I2 => data_out,
      I3 => tx_ce_sample,
      I4 => \^control_complete\,
      I5 => I1,
      O => n_0_pfc_pause_req_int_i_1
    );
pfc_pause_req_int_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_pfc_pause_req_int_i_1,
      Q => \^pfc_pause_req_out\,
      R => \<const0>\
    );
\pfc_quanta_pipe_reg[1][0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \pfc_quanta_pipe_reg[1]_0\(0),
      R => \<const0>\
    );
\pfc_quanta_pipe_reg[1][1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \pfc_quanta_pipe_reg[1]_0\(1),
      R => \<const0>\
    );
\pfc_quanta_pipe_reg[1][2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \pfc_quanta_pipe_reg[1]_0\(2),
      R => \<const0>\
    );
\pfc_quanta_pipe_reg[1][3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \pfc_quanta_pipe_reg[1]_0\(3),
      R => \<const0>\
    );
\pfc_quanta_pipe_reg[1][4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \pfc_quanta_pipe_reg[1]_0\(4),
      R => \<const0>\
    );
\pfc_quanta_pipe_reg[1][5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \pfc_quanta_pipe_reg[1]_0\(5),
      R => \<const0>\
    );
\pfc_quanta_pipe_reg[1][6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \pfc_quanta_pipe_reg[1]_0\(6),
      R => \<const0>\
    );
\pfc_quanta_pipe_reg[1][7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \<const0>\,
      Q => \pfc_quanta_pipe_reg[1]_0\(7),
      R => \<const0>\
    );
sample_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000400FF00040000"
    )
    port map (
      I0 => \n_0_data_count_reg[0]\,
      I1 => \n_0_data_count_reg[1]\,
      I2 => n_0_sample_int_i_2,
      I3 => I1,
      I4 => tx_ce_sample,
      I5 => \^o3\,
      O => n_0_sample_int_i_1
    );
sample_int_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFFF"
    )
    port map (
      I0 => \n_0_data_count_reg[4]\,
      I1 => \n_0_data_count_reg[5]\,
      I2 => \n_0_data_count_reg[2]\,
      I3 => \n_0_data_count_reg[3]\,
      O => n_0_sample_int_i_2
    );
sample_int_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_sample_int_i_1,
      Q => \^o3\,
      R => \<const0>\
    );
\state_count[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFD0"
    )
    port map (
      I0 => \n_0_state_count_reg[1]\,
      I1 => \n_0_state_count_reg[2]\,
      I2 => \n_0_state_count[2]_i_2\,
      I3 => \^tx_status\,
      O => \n_0_state_count[0]_i_1\
    );
\state_count[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0F20"
    )
    port map (
      I0 => \^tx_status\,
      I1 => \n_0_state_count_reg[2]\,
      I2 => \n_0_state_count[2]_i_2\,
      I3 => \n_0_state_count_reg[1]\,
      O => \n_0_state_count[1]_i_1\
    );
\state_count[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0F20"
    )
    port map (
      I0 => \n_0_state_count_reg[1]\,
      I1 => \^tx_status\,
      I2 => \n_0_state_count[2]_i_2\,
      I3 => \n_0_state_count_reg[2]\,
      O => \n_0_state_count[2]_i_1\
    );
\state_count[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A2A2A2AA22222222"
    )
    port map (
      I0 => tx_ce_sample,
      I1 => \n_0_state_count[2]_i_3\,
      I2 => \^control_complete\,
      I3 => \^o5\,
      I4 => I5,
      I5 => \n_0_state_count_reg[2]\,
      O => \n_0_state_count[2]_i_2\
    );
\state_count[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"03040334"
    )
    port map (
      I0 => \n_0_state_count[2]_i_4\,
      I1 => \^tx_status\,
      I2 => \n_0_state_count_reg[1]\,
      I3 => \n_0_state_count_reg[2]\,
      I4 => ack_int,
      O => \n_0_state_count[2]_i_3\
    );
\state_count[2]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAABAA"
    )
    port map (
      I0 => pause_req_int,
      I1 => pause_status_int,
      I2 => n_0_end_of_tx_held_reg,
      I3 => \^o1\,
      I4 => \^o5\,
      O => \n_0_state_count[2]_i_4\
    );
\state_count_reg[0]\: unisim.vcomponents.FDSE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_state_count[0]_i_1\,
      Q => \^tx_status\,
      S => I1
    );
\state_count_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_state_count[1]_i_1\,
      Q => \n_0_state_count_reg[1]\,
      R => I1
    );
\state_count_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_state_count[2]_i_1\,
      Q => \n_0_state_count_reg[2]\,
      R => I1
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCRC_64_32 is
  port (
    O1 : out STD_LOGIC;
    I1 : in STD_LOGIC;
    CRC1000_EN : in STD_LOGIC;
    SPEED_1_RESYNC_REG : in STD_LOGIC;
    CRC50_EN : in STD_LOGIC;
    SPEED_0_RESYNC_REG : in STD_LOGIC;
    I2 : in STD_LOGIC;
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end TriMACCRC_64_32;

architecture STRUCTURE of TriMACCRC_64_32 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal CE : STD_LOGIC;
  signal CRC_OK : STD_LOGIC;
  signal D : STD_LOGIC;
  signal I1_0 : STD_LOGIC;
  signal Q : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal n_0_CRC2 : STD_LOGIC;
  signal n_0_CRC3 : STD_LOGIC;
  signal n_0_CRC4 : STD_LOGIC;
  signal n_0_CRC5 : STD_LOGIC;
  signal n_0_FF2 : STD_LOGIC;
  signal n_0_FF3 : STD_LOGIC;
  signal n_0_FF4 : STD_LOGIC;
  signal n_0_FF5 : STD_LOGIC;
  signal n_0_X36_1I6 : STD_LOGIC;
  signal n_0_X36_1I956 : STD_LOGIC;
  signal NLW_X36_1I4_CARRY4_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_X36_1I4_CARRY4_DI_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_X36_1I4_CARRY4_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_X36_1I4_CARRY4_S_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of FF1 : label is "PRIMITIVE";
  attribute BOX_TYPE of FF2 : label is "PRIMITIVE";
  attribute BOX_TYPE of FF3 : label is "PRIMITIVE";
  attribute BOX_TYPE of FF4 : label is "PRIMITIVE";
  attribute BOX_TYPE of FF5 : label is "PRIMITIVE";
  attribute BOX_TYPE of FF6 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
CRC1: entity work.TriMACCC8CE
    port map (
      CEO => D,
      CRC1000_EN => CRC1000_EN,
      CRC50_EN => CRC50_EN,
      I1 => I1,
      I2 => I2,
      SPEED_0_RESYNC_REG => SPEED_0_RESYNC_REG,
      SPEED_1_RESYNC_REG => SPEED_1_RESYNC_REG
    );
CRC2: entity work.TriMACCC8CE_8
    port map (
      CE => CE,
      CEO => n_0_CRC2,
      I1 => I1
    );
CRC3: entity work.TriMACCC8CE_9
    port map (
      CE => n_0_FF2,
      CEO => n_0_CRC3,
      I1 => I1
    );
CRC4: entity work.TriMACCC8CE_10
    port map (
      CE => n_0_FF3,
      CEO => n_0_CRC4,
      I1 => I1
    );
CRC5: entity work.TriMACCC2CE
    port map (
      CE => n_0_FF4,
      CEO => n_0_CRC5,
      I1 => I1
    );
ENABLE_REG_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => rx_configuration_vector(0),
      I1 => CRC_OK,
      O => O1
    );
FF1: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      CLR => \<const0>\,
      D => D,
      Q => CE
    );
FF2: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      CLR => \<const0>\,
      D => n_0_CRC2,
      Q => n_0_FF2
    );
FF3: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      CLR => \<const0>\,
      D => n_0_CRC3,
      Q => n_0_FF3
    );
FF4: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      CLR => \<const0>\,
      D => n_0_CRC4,
      Q => n_0_FF4
    );
FF5: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => \<const1>\,
      CLR => \<const0>\,
      D => n_0_CRC5,
      Q => n_0_FF5
    );
FF6: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => n_0_X36_1I956,
      CLR => \<const0>\,
      D => \<const1>\,
      Q => CRC_OK
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => I1,
      CE => n_0_FF5,
      CLR => \<const0>\,
      D => n_0_X36_1I6,
      Q => Q
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3 downto 1) => NLW_X36_1I4_CARRY4_CO_UNCONNECTED(3 downto 1),
      CO(0) => I1_0,
      CYINIT => \<const1>\,
      DI(3 downto 1) => NLW_X36_1I4_CARRY4_DI_UNCONNECTED(3 downto 1),
      DI(0) => \<const0>\,
      O(3 downto 1) => NLW_X36_1I4_CARRY4_O_UNCONNECTED(3 downto 1),
      O(0) => n_0_X36_1I6,
      S(3 downto 1) => NLW_X36_1I4_CARRY4_S_UNCONNECTED(3 downto 1),
      S(0) => Q
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => n_0_FF5,
      I1 => I1_0,
      O => n_0_X36_1I956
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACCRC_64_32_15 is
  port (
    CRC_OK : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    gtx_clk : in STD_LOGIC;
    I1 : in STD_LOGIC;
    CRC1000_EN : in STD_LOGIC;
    SPEED_1_RESYNC_REG : in STD_LOGIC;
    CRC50_EN : in STD_LOGIC;
    SPEED_0_RESYNC_REG : in STD_LOGIC;
    tx_ce_sample : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of TriMACCRC_64_32_15 : entity is "CRC_64_32";
end TriMACCRC_64_32_15;

architecture STRUCTURE of TriMACCRC_64_32_15 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal CE : STD_LOGIC;
  signal \^crc_ok\ : STD_LOGIC;
  signal D : STD_LOGIC;
  signal I1_0 : STD_LOGIC;
  signal Q : STD_LOGIC;
  signal lopt : STD_LOGIC;
  signal n_0_CRC2 : STD_LOGIC;
  signal n_0_CRC3 : STD_LOGIC;
  signal n_0_CRC4 : STD_LOGIC;
  signal n_0_CRC5 : STD_LOGIC;
  signal n_0_FF2 : STD_LOGIC;
  signal n_0_FF3 : STD_LOGIC;
  signal n_0_FF4 : STD_LOGIC;
  signal n_0_FF5 : STD_LOGIC;
  signal n_0_X36_1I6 : STD_LOGIC;
  signal n_0_X36_1I956 : STD_LOGIC;
  signal NLW_X36_1I4_CARRY4_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_X36_1I4_CARRY4_DI_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_X36_1I4_CARRY4_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_X36_1I4_CARRY4_S_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of FF1 : label is "PRIMITIVE";
  attribute BOX_TYPE of FF2 : label is "PRIMITIVE";
  attribute BOX_TYPE of FF3 : label is "PRIMITIVE";
  attribute BOX_TYPE of FF4 : label is "PRIMITIVE";
  attribute BOX_TYPE of FF5 : label is "PRIMITIVE";
  attribute BOX_TYPE of FF6 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I36 : label is "PRIMITIVE";
  attribute BOX_TYPE of X36_1I4_CARRY4 : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of X36_1I4_CARRY4 : label is "(MUXCY,XORCY)";
  attribute BOX_TYPE of X36_1I956 : label is "PRIMITIVE";
begin
  CRC_OK <= \^crc_ok\;
CRC1: entity work.TriMACCC8CE_16
    port map (
      CEO => D,
      CRC1000_EN => CRC1000_EN,
      CRC50_EN => CRC50_EN,
      SPEED_0_RESYNC_REG => SPEED_0_RESYNC_REG,
      SPEED_1_RESYNC_REG => SPEED_1_RESYNC_REG,
      gtx_clk => gtx_clk,
      tx_ce_sample => tx_ce_sample
    );
CRC2: entity work.TriMACCC8CE_17
    port map (
      CE => CE,
      CEO => n_0_CRC2,
      gtx_clk => gtx_clk
    );
CRC3: entity work.TriMACCC8CE_18
    port map (
      CE => n_0_FF2,
      CEO => n_0_CRC3,
      gtx_clk => gtx_clk
    );
CRC4: entity work.TriMACCC8CE_19
    port map (
      CE => n_0_FF3,
      CEO => n_0_CRC4,
      gtx_clk => gtx_clk
    );
CRC5: entity work.TriMACCC2CE_20
    port map (
      CE => n_0_FF4,
      CEO => n_0_CRC5,
      gtx_clk => gtx_clk
    );
FF1: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      CLR => \<const0>\,
      D => D,
      Q => CE
    );
FF2: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      CLR => \<const0>\,
      D => n_0_CRC2,
      Q => n_0_FF2
    );
FF3: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      CLR => \<const0>\,
      D => n_0_CRC3,
      Q => n_0_FF3
    );
FF4: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      CLR => \<const0>\,
      D => n_0_CRC4,
      Q => n_0_FF4
    );
FF5: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      CLR => \<const0>\,
      D => n_0_CRC5,
      Q => n_0_FF5
    );
FF6: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => n_0_X36_1I956,
      CLR => \<const0>\,
      D => \<const1>\,
      Q => \^crc_ok\
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
STATUS_VALID_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \^crc_ok\,
      I1 => I1,
      O => SR(0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
X36_1I36: unisim.vcomponents.FDCE
    generic map(
      INIT => '0',
      IS_CLR_INVERTED => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0'
    )
    port map (
      C => gtx_clk,
      CE => n_0_FF5,
      CLR => \<const0>\,
      D => n_0_X36_1I6,
      Q => Q
    );
X36_1I4_CARRY4: unisim.vcomponents.CARRY4
    port map (
      CI => lopt,
      CO(3 downto 1) => NLW_X36_1I4_CARRY4_CO_UNCONNECTED(3 downto 1),
      CO(0) => I1_0,
      CYINIT => \<const1>\,
      DI(3 downto 1) => NLW_X36_1I4_CARRY4_DI_UNCONNECTED(3 downto 1),
      DI(0) => \<const0>\,
      O(3 downto 1) => NLW_X36_1I4_CARRY4_O_UNCONNECTED(3 downto 1),
      O(0) => n_0_X36_1I6,
      S(3 downto 1) => NLW_X36_1I4_CARRY4_S_UNCONNECTED(3 downto 1),
      S(0) => Q
    );
X36_1I4_CARRY4_GND: unisim.vcomponents.GND
    port map (
      G => lopt
    );
X36_1I956: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => n_0_FF5,
      I1 => I1_0,
      O => n_0_X36_1I956
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity \TriMACTX_STATE_MACH__parameterized0\ is
  port (
    REG_DATA_VALID : out STD_LOGIC;
    PAD : out STD_LOGIC;
    tx_statistics_valid : out STD_LOGIC;
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    int_gmii_tx_er : out STD_LOGIC;
    int_gmii_tx_en : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 1 downto 0 );
    NUMBER_OF_BYTES_PRE_REG : out STD_LOGIC;
    int_tx_ack_in : out STD_LOGIC;
    O9 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 7 downto 0 );
    O10 : out STD_LOGIC;
    tx_statistics_vector : out STD_LOGIC_VECTOR ( 29 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    INT_CRC_MODE : in STD_LOGIC;
    I1 : in STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    tx_ce_sample : in STD_LOGIC;
    int_tx_data_valid_out : in STD_LOGIC;
    I5 : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 15 downto 0 );
    I6 : in STD_LOGIC;
    I7 : in STD_LOGIC;
    data_avail_in_reg : in STD_LOGIC;
    I8 : in STD_LOGIC;
    I9 : in STD_LOGIC;
    tx_underrun_int : in STD_LOGIC;
    I10 : in STD_LOGIC;
    I11 : in STD_LOGIC;
    I12 : in STD_LOGIC;
    I13 : in STD_LOGIC;
    I14 : in STD_LOGIC;
    I15 : in STD_LOGIC;
    I16 : in STD_LOGIC;
    I17 : in STD_LOGIC;
    Q_0 : in STD_LOGIC;
    I18 : in STD_LOGIC;
    I19 : in STD_LOGIC_VECTOR ( 0 to 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    tx_ifg_delay : in STD_LOGIC_VECTOR ( 7 downto 0 );
    I20 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I21 : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \TriMACTX_STATE_MACH__parameterized0\ : entity is "TX_STATE_MACH";
end \TriMACTX_STATE_MACH__parameterized0\;

architecture STRUCTURE of \TriMACTX_STATE_MACH__parameterized0\ is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal CLIENT_FRAME_DONE : STD_LOGIC;
  signal COMPUTE : STD_LOGIC;
  signal COMPUTE0 : STD_LOGIC;
  signal CR178124_FIX : STD_LOGIC;
  signal CR178124_FIX0 : STD_LOGIC;
  signal CRC : STD_LOGIC;
  signal CRC0 : STD_LOGIC;
  signal CRC_COUNT : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal DATA_REG4_BIT0 : STD_LOGIC;
  signal \DATA_REG_reg[0]_3\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \DATA_REG_reg[1]_2\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \DATA_REG_reg[2]_1\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal DST_ADDR_MULTI_MATCH : STD_LOGIC;
  signal FRAME_BAD : STD_LOGIC;
  signal FRAME_MAX : STD_LOGIC_VECTOR ( 4 downto 2 );
  signal INT_IFG_DEL_EN : STD_LOGIC;
  signal INT_IFG_DEL_MASKED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal INT_JUMBO_EN : STD_LOGIC;
  signal INT_MAX_FRAME_ENABLE : STD_LOGIC;
  signal INT_MAX_FRAME_LENGTH : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal INT_TX_BROADCAST : STD_LOGIC;
  signal INT_TX_CONTROL : STD_LOGIC;
  signal INT_TX_MULTICAST : STD_LOGIC;
  signal INT_TX_STATUS_VALID : STD_LOGIC;
  signal INT_TX_SUCCESS : STD_LOGIC;
  signal INT_TX_UNDERRUN2 : STD_LOGIC;
  signal INT_VLAN_EN : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal \^o2\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC;
  signal \^o4\ : STD_LOGIC;
  signal \^o5\ : STD_LOGIC;
  signal \^o6\ : STD_LOGIC;
  signal \^o9\ : STD_LOGIC;
  signal \^pad\ : STD_LOGIC;
  signal PAD0 : STD_LOGIC;
  signal PAD_PIPE : STD_LOGIC;
  signal PREAMBLE : STD_LOGIC;
  signal PREAMBLE0 : STD_LOGIC;
  signal PREAMBLE_DONE : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^reg_data_valid\ : STD_LOGIC;
  signal REG_PREAMBLE : STD_LOGIC;
  signal REG_PREAMBLE_DONE : STD_LOGIC;
  signal REG_SCSH : STD_LOGIC;
  signal REG_STATUS_VALID : STD_LOGIC;
  signal REG_TX_CONTROL : STD_LOGIC;
  signal REG_TX_VLAN : STD_LOGIC;
  signal TRANSMIT : STD_LOGIC;
  signal TRANSMIT0 : STD_LOGIC;
  signal eqOp74_in : STD_LOGIC;
  signal \n_0_BYTE_COUNT[0][14]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][0]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][10]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][11]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][12]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][13]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][1]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][2]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][3]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][4]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][5]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][6]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][7]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][8]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT[1][9]_i_1\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][0]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][10]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][11]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][12]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][13]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][14]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][1]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][2]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][3]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][4]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][5]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][6]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][7]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][8]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[0][9]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][0]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][10]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][11]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][12]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][13]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][1]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][2]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][3]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][4]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][5]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][6]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][7]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][8]\ : STD_LOGIC;
  signal \n_0_BYTE_COUNT_reg[1][9]\ : STD_LOGIC;
  signal n_0_CDS_i_1 : STD_LOGIC;
  signal n_0_CDS_reg : STD_LOGIC;
  signal n_0_CFL_i_1 : STD_LOGIC;
  signal n_0_CFL_reg : STD_LOGIC;
  signal n_0_CLIENT_FRAME_DONE_i_1 : STD_LOGIC;
  signal n_0_CLIENT_FRAME_DONE_i_2 : STD_LOGIC;
  signal n_0_COF_SEEN_i_1 : STD_LOGIC;
  signal n_0_COF_i_1 : STD_LOGIC;
  signal n_0_COF_i_2 : STD_LOGIC;
  signal n_0_COF_i_3 : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_2.TX_OK_i_1\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_2.TX_OK_i_2\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_2.TX_OK_reg\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[2]_i_1\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[3]_i_1\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[4]_i_1\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[5]_i_1\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[6]_i_1\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_2\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_3\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_1\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_2\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_3\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\ : STD_LOGIC;
  signal \n_0_CORE_DOES_NO_HD_PRE.PRE_i_1\ : STD_LOGIC;
  signal \n_0_CRC_COUNT[0]_i_1\ : STD_LOGIC;
  signal \n_0_CRC_COUNT[1]_i_1\ : STD_LOGIC;
  signal \n_0_DATA_REG[1][0]_i_1\ : STD_LOGIC;
  signal \n_0_DATA_REG[1][1]_i_1\ : STD_LOGIC;
  signal \n_0_DATA_REG[1][2]_i_1\ : STD_LOGIC;
  signal \n_0_DATA_REG[1][3]_i_1\ : STD_LOGIC;
  signal \n_0_DATA_REG[1][4]_i_1\ : STD_LOGIC;
  signal \n_0_DATA_REG[1][5]_i_1\ : STD_LOGIC;
  signal \n_0_DATA_REG[1][6]_i_1\ : STD_LOGIC;
  signal \n_0_DATA_REG[1][7]_i_1\ : STD_LOGIC;
  signal \n_0_DATA_REG[2][7]_i_1\ : STD_LOGIC;
  signal \n_0_DATA_REG_reg[3][0]\ : STD_LOGIC;
  signal \n_0_DATA_REG_reg[3][1]\ : STD_LOGIC;
  signal \n_0_DATA_REG_reg[3][2]\ : STD_LOGIC;
  signal \n_0_DATA_REG_reg[3][3]\ : STD_LOGIC;
  signal \n_0_DATA_REG_reg[3][4]\ : STD_LOGIC;
  signal \n_0_DATA_REG_reg[3][5]\ : STD_LOGIC;
  signal \n_0_DATA_REG_reg[3][6]\ : STD_LOGIC;
  signal \n_0_DATA_REG_reg[3][7]\ : STD_LOGIC;
  signal n_0_DST_ADDR_BYTE_MATCH_i_1 : STD_LOGIC;
  signal n_0_FCS_i_1 : STD_LOGIC;
  signal n_0_FCS_i_2 : STD_LOGIC;
  signal n_0_FCS_reg : STD_LOGIC;
  signal n_0_FRAME_BAD_i_1 : STD_LOGIC;
  signal n_0_FRAME_BAD_i_3 : STD_LOGIC;
  signal n_0_FRAME_BAD_reg : STD_LOGIC;
  signal \n_0_FRAME_COUNT[0]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[10]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[11]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[11]_i_3\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[11]_i_4\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[11]_i_5\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[11]_i_6\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[12]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[13]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[13]_i_2\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[14]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[14]_i_3\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[14]_i_4\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[14]_i_5\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[1]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[2]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[3]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[3]_i_3\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[3]_i_4\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[3]_i_5\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[3]_i_6\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[4]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[5]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[6]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[7]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[7]_i_3\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[7]_i_4\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[7]_i_5\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[7]_i_6\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[8]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT[9]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[0]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[10]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[11]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[11]_i_2\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[12]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[13]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[14]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[1]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[2]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[3]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[3]_i_2\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[4]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[5]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[6]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[7]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[7]_i_2\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[8]\ : STD_LOGIC;
  signal \n_0_FRAME_COUNT_reg[9]\ : STD_LOGIC;
  signal n_0_FRAME_GOOD_i_1 : STD_LOGIC;
  signal n_0_FRAME_GOOD_i_2 : STD_LOGIC;
  signal n_0_FRAME_GOOD_i_3 : STD_LOGIC;
  signal n_0_FRAME_GOOD_reg : STD_LOGIC;
  signal \n_0_FRAME_MAX[2]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_MAX[3]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_MAX[4]_i_1\ : STD_LOGIC;
  signal \n_0_FRAME_MAX[4]_i_2\ : STD_LOGIC;
  signal n_0_IDL_i_1 : STD_LOGIC;
  signal n_0_IDL_i_2 : STD_LOGIC;
  signal \n_0_IFG_COUNT[0]_i_1\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[0]_i_2\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[1]_i_1\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[2]_i_1\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[2]_i_2\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[2]_i_3\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[3]_i_1\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[3]_i_2\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[4]_i_1\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[4]_i_2\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[5]_i_1\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[6]_i_1\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[6]_i_2\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[7]_i_1\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[7]_i_2\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[7]_i_3\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[7]_i_4\ : STD_LOGIC;
  signal \n_0_IFG_COUNT[7]_i_5\ : STD_LOGIC;
  signal \n_0_IFG_COUNT_reg[0]\ : STD_LOGIC;
  signal \n_0_IFG_COUNT_reg[2]\ : STD_LOGIC;
  signal \n_0_IFG_COUNT_reg[4]\ : STD_LOGIC;
  signal \n_0_IFG_COUNT_reg[5]\ : STD_LOGIC;
  signal \n_0_IFG_COUNT_reg[6]\ : STD_LOGIC;
  signal n_0_INT_CRC_MODE_reg : STD_LOGIC;
  signal n_0_INT_HALF_DUPLEX_i_1 : STD_LOGIC;
  signal n_0_INT_HALF_DUPLEX_reg : STD_LOGIC;
  signal \n_0_INT_IFG_DELAY_reg[0]\ : STD_LOGIC;
  signal \n_0_INT_IFG_DELAY_reg[1]\ : STD_LOGIC;
  signal \n_0_INT_IFG_DELAY_reg[2]\ : STD_LOGIC;
  signal \n_0_INT_IFG_DELAY_reg[3]\ : STD_LOGIC;
  signal \n_0_INT_IFG_DELAY_reg[4]\ : STD_LOGIC;
  signal \n_0_INT_IFG_DELAY_reg[5]\ : STD_LOGIC;
  signal \n_0_INT_IFG_DELAY_reg[6]\ : STD_LOGIC;
  signal \n_0_INT_IFG_DELAY_reg[7]\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[0]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[10]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[11]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[12]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[13]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[14]_i_2\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[1]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[2]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[3]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[4]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[5]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[6]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[7]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[8]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH[9]_i_1\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH_reg[2]\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH_reg[3]\ : STD_LOGIC;
  signal \n_0_INT_MAX_FRAME_LENGTH_reg[4]\ : STD_LOGIC;
  signal n_0_INT_SPEED_IS_10_100_reg : STD_LOGIC;
  signal n_0_INT_TX_BROADCAST_i_1 : STD_LOGIC;
  signal n_0_INT_TX_EN_DELAY_i_2 : STD_LOGIC;
  signal n_0_INT_TX_MULTICAST_i_1 : STD_LOGIC;
  signal n_0_INT_TX_SUCCESS_i_1 : STD_LOGIC;
  signal n_0_INT_TX_UNDERRUN2_i_1 : STD_LOGIC;
  signal n_0_INT_TX_UNDERRUN2_reg : STD_LOGIC;
  signal \n_0_LEN_reg[0]\ : STD_LOGIC;
  signal \n_0_LEN_reg[10]\ : STD_LOGIC;
  signal \n_0_LEN_reg[12]\ : STD_LOGIC;
  signal \n_0_LEN_reg[13]\ : STD_LOGIC;
  signal \n_0_LEN_reg[14]\ : STD_LOGIC;
  signal \n_0_LEN_reg[15]\ : STD_LOGIC;
  signal \n_0_LEN_reg[1]\ : STD_LOGIC;
  signal \n_0_LEN_reg[2]\ : STD_LOGIC;
  signal \n_0_LEN_reg[4]\ : STD_LOGIC;
  signal \n_0_LEN_reg[5]\ : STD_LOGIC;
  signal \n_0_LEN_reg[6]\ : STD_LOGIC;
  signal \n_0_LEN_reg[8]\ : STD_LOGIC;
  signal \n_0_LEN_reg[9]\ : STD_LOGIC;
  signal n_0_MAX_PKT_LEN_REACHED_i_1 : STD_LOGIC;
  signal n_0_MAX_PKT_LEN_REACHED_i_10 : STD_LOGIC;
  signal n_0_MAX_PKT_LEN_REACHED_i_3 : STD_LOGIC;
  signal n_0_MAX_PKT_LEN_REACHED_i_5 : STD_LOGIC;
  signal n_0_MAX_PKT_LEN_REACHED_i_6 : STD_LOGIC;
  signal n_0_MAX_PKT_LEN_REACHED_i_7 : STD_LOGIC;
  signal n_0_MAX_PKT_LEN_REACHED_i_8 : STD_LOGIC;
  signal n_0_MAX_PKT_LEN_REACHED_i_9 : STD_LOGIC;
  signal n_0_MAX_PKT_LEN_REACHED_reg_i_4 : STD_LOGIC;
  signal n_0_MIN_PKT_LEN_REACHED_i_1 : STD_LOGIC;
  signal n_0_MIN_PKT_LEN_REACHED_reg : STD_LOGIC;
  signal \n_0_PREAMBLE_PIPE_reg[0]\ : STD_LOGIC;
  signal \n_0_PREAMBLE_PIPE_reg[10]\ : STD_LOGIC;
  signal \n_0_PREAMBLE_PIPE_reg[11]\ : STD_LOGIC;
  signal \n_0_PREAMBLE_PIPE_reg[12]\ : STD_LOGIC;
  signal \n_0_PREAMBLE_PIPE_reg[1]\ : STD_LOGIC;
  signal \n_0_PREAMBLE_PIPE_reg[3]\ : STD_LOGIC;
  signal \n_0_PREAMBLE_PIPE_reg[6]\ : STD_LOGIC;
  signal \n_0_PREAMBLE_PIPE_reg[7]\ : STD_LOGIC;
  signal \n_0_PREAMBLE_PIPE_reg[8]\ : STD_LOGIC;
  signal \n_0_PREAMBLE_PIPE_reg[9]\ : STD_LOGIC;
  signal \n_0_PRE_COUNT[0]_i_1\ : STD_LOGIC;
  signal \n_0_PRE_COUNT[1]_i_1\ : STD_LOGIC;
  signal \n_0_PRE_COUNT[2]_i_1\ : STD_LOGIC;
  signal \n_0_PRE_COUNT_reg[0]\ : STD_LOGIC;
  signal \n_0_PRE_COUNT_reg[2]\ : STD_LOGIC;
  signal n_0_REG_STATUS_VALID_i_1 : STD_LOGIC;
  signal n_0_REG_STATUS_VALID_i_2 : STD_LOGIC;
  signal n_0_REG_TX_CONTROL_i_2 : STD_LOGIC;
  signal n_0_REG_TX_CONTROL_i_3 : STD_LOGIC;
  signal n_0_REG_TX_VLAN_i_2 : STD_LOGIC;
  signal n_0_REG_TX_VLAN_i_3 : STD_LOGIC;
  signal n_0_SCSH_i_1 : STD_LOGIC;
  signal n_0_SCSH_reg : STD_LOGIC;
  signal n_0_STOP_MAX_PKT_i_1 : STD_LOGIC;
  signal n_0_STOP_MAX_PKT_reg : STD_LOGIC;
  signal \n_0_TRANSMIT_PIPE_reg[0]\ : STD_LOGIC;
  signal n_0_TX_i_1 : STD_LOGIC;
  signal n_0_TX_i_2 : STD_LOGIC;
  signal n_0_TX_i_3 : STD_LOGIC;
  signal \n_1_FRAME_COUNT_reg[11]_i_2\ : STD_LOGIC;
  signal \n_1_FRAME_COUNT_reg[3]_i_2\ : STD_LOGIC;
  signal \n_1_FRAME_COUNT_reg[7]_i_2\ : STD_LOGIC;
  signal n_1_MAX_PKT_LEN_REACHED_reg_i_4 : STD_LOGIC;
  signal \n_2_FRAME_COUNT_reg[11]_i_2\ : STD_LOGIC;
  signal \n_2_FRAME_COUNT_reg[14]_i_2\ : STD_LOGIC;
  signal \n_2_FRAME_COUNT_reg[3]_i_2\ : STD_LOGIC;
  signal \n_2_FRAME_COUNT_reg[7]_i_2\ : STD_LOGIC;
  signal n_2_MAX_PKT_LEN_REACHED_reg_i_4 : STD_LOGIC;
  signal \n_3_FRAME_COUNT_reg[11]_i_2\ : STD_LOGIC;
  signal \n_3_FRAME_COUNT_reg[14]_i_2\ : STD_LOGIC;
  signal \n_3_FRAME_COUNT_reg[3]_i_2\ : STD_LOGIC;
  signal \n_3_FRAME_COUNT_reg[7]_i_2\ : STD_LOGIC;
  signal n_3_MAX_PKT_LEN_REACHED_reg_i_4 : STD_LOGIC;
  signal p_0_in1_in : STD_LOGIC;
  signal p_0_in5_in : STD_LOGIC;
  signal p_0_in62_in : STD_LOGIC;
  signal p_0_in8_in : STD_LOGIC;
  signal p_1_in4_in : STD_LOGIC;
  signal p_2_in61_in : STD_LOGIC;
  signal p_3_in : STD_LOGIC;
  signal p_4_in : STD_LOGIC;
  signal p_53_out : STD_LOGIC;
  signal p_5_in : STD_LOGIC;
  signal p_72_in : STD_LOGIC;
  signal p_8_in : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \NLW_FRAME_COUNT_reg[14]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_FRAME_COUNT_reg[14]_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_MAX_PKT_LEN_REACHED_reg_i_2_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_MAX_PKT_LEN_REACHED_reg_i_2_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_MAX_PKT_LEN_REACHED_reg_i_4_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of BYTECNTSRL_i_1 : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of COF_i_2 : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[4]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[5]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[6]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_3\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \CORE_DOES_NO_HD_MIFG.MIFG_i_2\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \CORE_DOES_NO_HD_MIFG.MIFG_i_3\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of CRC_i_1 : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of FRAME_BAD_i_3 : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \FRAME_COUNT[13]_i_2\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of FRAME_GOOD_i_3 : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of IDL_i_2 : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \IFG_COUNT[0]_i_2\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \IFG_COUNT[1]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \IFG_COUNT[2]_i_3\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \IFG_COUNT[4]_i_2\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \IFG_COUNT[6]_i_2\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \IFG_COUNT[7]_i_4\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[0]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[10]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[11]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[12]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[13]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[1]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[2]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[3]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[4]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[5]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[6]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[7]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[8]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \INT_MAX_FRAME_LENGTH[9]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of INT_TX_EN_DELAY_i_2 : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of PAD_i_1 : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of REG_STATUS_VALID_i_2 : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of TRANSMIT_i_1 : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of TX_i_2 : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of TX_i_3 : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of ack_int_i_1 : label is "soft_lutpair53";
begin
  O1 <= \^o1\;
  O2 <= \^o2\;
  O3 <= \^o3\;
  O4 <= \^o4\;
  O5 <= \^o5\;
  O6 <= \^o6\;
  O9 <= \^o9\;
  PAD <= \^pad\;
  Q(1 downto 0) <= \^q\(1 downto 0);
  REG_DATA_VALID <= \^reg_data_valid\;
BYTECNTSRL_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFEFEFEE"
    )
    port map (
      I0 => \^q\(0),
      I1 => PAD_PIPE,
      I2 => CR178124_FIX,
      I3 => p_0_in8_in,
      I4 => CRC,
      O => int_gmii_tx_en
    );
\BYTE_COUNT[0][14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      I0 => REG_SCSH,
      I1 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      I2 => tx_ce_sample,
      I3 => n_0_FCS_reg,
      O => \n_0_BYTE_COUNT[0][14]_i_1\
    );
\BYTE_COUNT[1][0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][0]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][0]\,
      O => \n_0_BYTE_COUNT[1][0]_i_1\
    );
\BYTE_COUNT[1][10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][10]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][10]\,
      O => \n_0_BYTE_COUNT[1][10]_i_1\
    );
\BYTE_COUNT[1][11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][11]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][11]\,
      O => \n_0_BYTE_COUNT[1][11]_i_1\
    );
\BYTE_COUNT[1][12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][12]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][12]\,
      O => \n_0_BYTE_COUNT[1][12]_i_1\
    );
\BYTE_COUNT[1][13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][13]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][13]\,
      O => \n_0_BYTE_COUNT[1][13]_i_1\
    );
\BYTE_COUNT[1][1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][1]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][1]\,
      O => \n_0_BYTE_COUNT[1][1]_i_1\
    );
\BYTE_COUNT[1][2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][2]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][2]\,
      O => \n_0_BYTE_COUNT[1][2]_i_1\
    );
\BYTE_COUNT[1][3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][3]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][3]\,
      O => \n_0_BYTE_COUNT[1][3]_i_1\
    );
\BYTE_COUNT[1][4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][4]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][4]\,
      O => \n_0_BYTE_COUNT[1][4]_i_1\
    );
\BYTE_COUNT[1][5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][5]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][5]\,
      O => \n_0_BYTE_COUNT[1][5]_i_1\
    );
\BYTE_COUNT[1][6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][6]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][6]\,
      O => \n_0_BYTE_COUNT[1][6]_i_1\
    );
\BYTE_COUNT[1][7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][7]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][7]\,
      O => \n_0_BYTE_COUNT[1][7]_i_1\
    );
\BYTE_COUNT[1][8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][8]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][8]\,
      O => \n_0_BYTE_COUNT[1][8]_i_1\
    );
\BYTE_COUNT[1][9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888A8A88888A808"
    )
    port map (
      I0 => I11,
      I1 => \n_0_BYTE_COUNT_reg[1][9]\,
      I2 => \n_0_BYTE_COUNT[0][14]_i_1\,
      I3 => \n_0_BYTE_COUNT_reg[0][14]\,
      I4 => n_0_STOP_MAX_PKT_reg,
      I5 => \n_0_BYTE_COUNT_reg[0][9]\,
      O => \n_0_BYTE_COUNT[1][9]_i_1\
    );
\BYTE_COUNT_reg[0][0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[0]\,
      Q => \n_0_BYTE_COUNT_reg[0][0]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][10]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[10]\,
      Q => \n_0_BYTE_COUNT_reg[0][10]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][11]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[11]\,
      Q => \n_0_BYTE_COUNT_reg[0][11]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][12]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[12]\,
      Q => \n_0_BYTE_COUNT_reg[0][12]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][13]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[13]\,
      Q => \n_0_BYTE_COUNT_reg[0][13]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][14]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[14]\,
      Q => \n_0_BYTE_COUNT_reg[0][14]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[1]\,
      Q => \n_0_BYTE_COUNT_reg[0][1]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[2]\,
      Q => \n_0_BYTE_COUNT_reg[0][2]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[3]\,
      Q => \n_0_BYTE_COUNT_reg[0][3]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[4]\,
      Q => \n_0_BYTE_COUNT_reg[0][4]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[5]\,
      Q => \n_0_BYTE_COUNT_reg[0][5]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[6]\,
      Q => \n_0_BYTE_COUNT_reg[0][6]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[7]\,
      Q => \n_0_BYTE_COUNT_reg[0][7]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][8]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[8]\,
      Q => \n_0_BYTE_COUNT_reg[0][8]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[0][9]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_BYTE_COUNT[0][14]_i_1\,
      D => \n_0_FRAME_COUNT_reg[9]\,
      Q => \n_0_BYTE_COUNT_reg[0][9]\,
      R => SR(0)
    );
\BYTE_COUNT_reg[1][0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][0]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][0]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][10]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][10]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][10]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][11]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][11]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][11]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][12]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][12]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][12]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][13]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][13]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][13]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][1]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][1]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][2]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][2]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][3]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][3]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][4]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][4]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][5]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][5]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][6]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][6]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][7]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][7]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][8]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][8]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][8]\,
      R => \<const0>\
    );
\BYTE_COUNT_reg[1][9]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_BYTE_COUNT[1][9]_i_1\,
      Q => \n_0_BYTE_COUNT_reg[1][9]\,
      R => \<const0>\
    );
CDS_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0203030302000200"
    )
    port map (
      I0 => I12,
      I1 => I8,
      I2 => I9,
      I3 => tx_ce_sample,
      I4 => \^o5\,
      I5 => n_0_CDS_reg,
      O => n_0_CDS_i_1
    );
CDS_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_CDS_i_1,
      Q => n_0_CDS_reg,
      R => \<const0>\
    );
CFL_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02AAAAAA00AA0000"
    )
    port map (
      I0 => I11,
      I1 => n_0_FCS_reg,
      I2 => n_0_SCSH_reg,
      I3 => I14,
      I4 => tx_ce_sample,
      I5 => n_0_CFL_reg,
      O => n_0_CFL_i_1
    );
CFL_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_CFL_i_1,
      Q => n_0_CFL_reg,
      R => \<const0>\
    );
CLIENT_FRAME_DONE_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4FCFCFFF4FCFCF"
    )
    port map (
      I0 => \^o5\,
      I1 => CLIENT_FRAME_DONE,
      I2 => I11,
      I3 => n_0_CLIENT_FRAME_DONE_i_2,
      I4 => tx_ce_sample,
      I5 => int_tx_data_valid_out,
      O => n_0_CLIENT_FRAME_DONE_i_1
    );
CLIENT_FRAME_DONE_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => n_0_FCS_reg,
      I1 => \^o3\,
      I2 => n_0_CFL_reg,
      I3 => n_0_SCSH_reg,
      I4 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      I5 => \^o2\,
      O => n_0_CLIENT_FRAME_DONE_i_2
    );
CLIENT_FRAME_DONE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_CLIENT_FRAME_DONE_i_1,
      Q => CLIENT_FRAME_DONE,
      R => \<const0>\
    );
COF_SEEN_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABFF0000AA000000"
    )
    port map (
      I0 => \^o2\,
      I1 => \^o5\,
      I2 => \^o9\,
      I3 => tx_ce_sample,
      I4 => I11,
      I5 => \^o4\,
      O => n_0_COF_SEEN_i_1
    );
COF_SEEN_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_COF_SEEN_i_1,
      Q => \^o4\,
      R => \<const0>\
    );
COF_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A000BFFFA0008000"
    )
    port map (
      I0 => I11,
      I1 => tx_ce_sample,
      I2 => \^o1\,
      I3 => n_0_COF_i_2,
      I4 => n_0_COF_i_3,
      I5 => \^o2\,
      O => n_0_COF_i_1
    );
COF_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^o3\,
      I1 => n_0_CFL_reg,
      O => n_0_COF_i_2
    );
COF_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFE0"
    )
    port map (
      I0 => n_0_SCSH_reg,
      I1 => n_0_FCS_reg,
      I2 => tx_ce_sample,
      I3 => I9,
      I4 => I8,
      O => n_0_COF_i_3
    );
COF_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_COF_i_1,
      Q => \^o2\,
      R => \<const0>\
    );
\CORE_DOES_NO_HD_2.TX_OK_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0103030300030000"
    )
    port map (
      I0 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      I1 => I8,
      I2 => I9,
      I3 => \n_0_CORE_DOES_NO_HD_2.TX_OK_i_2\,
      I4 => tx_ce_sample,
      I5 => \n_0_CORE_DOES_NO_HD_2.TX_OK_reg\,
      O => \n_0_CORE_DOES_NO_HD_2.TX_OK_i_1\
    );
\CORE_DOES_NO_HD_2.TX_OK_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFF7"
    )
    port map (
      I0 => n_0_FRAME_GOOD_reg,
      I1 => n_0_SCSH_reg,
      I2 => n_0_FRAME_BAD_reg,
      I3 => \n_0_CORE_DOES_NO_HD_2.TX_OK_reg\,
      O => \n_0_CORE_DOES_NO_HD_2.TX_OK_i_2\
    );
\CORE_DOES_NO_HD_2.TX_OK_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_CORE_DOES_NO_HD_2.TX_OK_i_1\,
      Q => \n_0_CORE_DOES_NO_HD_2.TX_OK_reg\,
      R => \<const0>\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[2]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_INT_IFG_DELAY_reg[2]\,
      O => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[2]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => \n_0_INT_IFG_DELAY_reg[2]\,
      I1 => \n_0_INT_IFG_DELAY_reg[3]\,
      O => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[3]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A9"
    )
    port map (
      I0 => \n_0_INT_IFG_DELAY_reg[4]\,
      I1 => \n_0_INT_IFG_DELAY_reg[3]\,
      I2 => \n_0_INT_IFG_DELAY_reg[2]\,
      O => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[4]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA9"
    )
    port map (
      I0 => \n_0_INT_IFG_DELAY_reg[5]\,
      I1 => \n_0_INT_IFG_DELAY_reg[4]\,
      I2 => \n_0_INT_IFG_DELAY_reg[2]\,
      I3 => \n_0_INT_IFG_DELAY_reg[3]\,
      O => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[5]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAAA9"
    )
    port map (
      I0 => \n_0_INT_IFG_DELAY_reg[6]\,
      I1 => \n_0_INT_IFG_DELAY_reg[3]\,
      I2 => \n_0_INT_IFG_DELAY_reg[2]\,
      I3 => \n_0_INT_IFG_DELAY_reg[4]\,
      I4 => \n_0_INT_IFG_DELAY_reg[5]\,
      O => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[6]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8AAA8A8A"
    )
    port map (
      I0 => tx_ce_sample,
      I1 => n_0_INT_HALF_DUPLEX_reg,
      I2 => INT_IFG_DEL_EN,
      I3 => \n_0_INT_IFG_DELAY_reg[7]\,
      I4 => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_3\,
      O => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAAAAA9"
    )
    port map (
      I0 => \n_0_INT_IFG_DELAY_reg[7]\,
      I1 => \n_0_INT_IFG_DELAY_reg[5]\,
      I2 => \n_0_INT_IFG_DELAY_reg[4]\,
      I3 => \n_0_INT_IFG_DELAY_reg[2]\,
      I4 => \n_0_INT_IFG_DELAY_reg[3]\,
      I5 => \n_0_INT_IFG_DELAY_reg[6]\,
      O => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_2\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => \n_0_INT_IFG_DELAY_reg[6]\,
      I1 => \n_0_INT_IFG_DELAY_reg[3]\,
      I2 => \n_0_INT_IFG_DELAY_reg[2]\,
      I3 => \n_0_INT_IFG_DELAY_reg[4]\,
      I4 => \n_0_INT_IFG_DELAY_reg[5]\,
      O => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_3\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_INT_IFG_DELAY_reg[0]\,
      Q => INT_IFG_DEL_MASKED(0),
      R => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_INT_IFG_DELAY_reg[1]\,
      Q => INT_IFG_DEL_MASKED(1),
      R => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[2]_i_1\,
      Q => INT_IFG_DEL_MASKED(2),
      R => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[3]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[3]_i_1\,
      Q => INT_IFG_DEL_MASKED(3),
      S => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[4]_i_1\,
      Q => INT_IFG_DEL_MASKED(4),
      R => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[5]_i_1\,
      Q => INT_IFG_DEL_MASKED(5),
      R => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[6]_i_1\,
      Q => INT_IFG_DEL_MASKED(6),
      R => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1\
    );
\CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_2\,
      Q => INT_IFG_DEL_MASKED(7),
      R => \n_0_CORE_DOES_NO_HD_IFG.INT_IFG_DEL_MASKED[7]_i_1\
    );
\CORE_DOES_NO_HD_MIFG.MIFG_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000007F00000050"
    )
    port map (
      I0 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_2\,
      I1 => \^o9\,
      I2 => tx_ce_sample,
      I3 => I9,
      I4 => I8,
      I5 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      O => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_1\
    );
\CORE_DOES_NO_HD_MIFG.MIFG_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFD00FD"
    )
    port map (
      I0 => n_0_FCS_reg,
      I1 => CRC_COUNT(1),
      I2 => CRC_COUNT(0),
      I3 => n_0_INT_CRC_MODE_reg,
      I4 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_3\,
      O => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_2\
    );
\CORE_DOES_NO_HD_MIFG.MIFG_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => \^o2\,
      I1 => n_0_MIN_PKT_LEN_REACHED_reg,
      I2 => n_0_CFL_reg,
      O => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_3\
    );
\CORE_DOES_NO_HD_MIFG.MIFG_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_1\,
      Q => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      R => \<const0>\
    );
\CORE_DOES_NO_HD_PRE.PRE_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000BF00000088"
    )
    port map (
      I0 => I12,
      I1 => tx_ce_sample,
      I2 => \^o3\,
      I3 => I8,
      I4 => I9,
      I5 => \^o5\,
      O => \n_0_CORE_DOES_NO_HD_PRE.PRE_i_1\
    );
\CORE_DOES_NO_HD_PRE.PRE_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_CORE_DOES_NO_HD_PRE.PRE_i_1\,
      Q => \^o5\,
      R => \<const0>\
    );
\CORE_DOES_NO_HD_STATS.INT_TX_STATUS_VALID_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => CLIENT_FRAME_DONE,
      I1 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      I2 => \^o9\,
      O => p_53_out
    );
\CORE_DOES_NO_HD_STATS.INT_TX_STATUS_VALID_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => p_53_out,
      Q => INT_TX_STATUS_VALID,
      R => SR(0)
    );
CR178124_FIX_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => n_0_SCSH_reg,
      I1 => \^o4\,
      I2 => \^o1\,
      O => CR178124_FIX0
    );
CR178124_FIX_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => CR178124_FIX0,
      Q => CR178124_FIX,
      R => SR(0)
    );
CRCGEN: entity work.TriMACCRC32_8_21
    port map (
      COMPUTE => COMPUTE,
      CRC => CRC,
      D(7 downto 0) => D(7 downto 0),
      I1(0) => \^q\(0),
      I18 => I18,
      Q(7) => \n_0_DATA_REG_reg[3][7]\,
      Q(6) => \n_0_DATA_REG_reg[3][6]\,
      Q(5) => \n_0_DATA_REG_reg[3][5]\,
      Q(4) => \n_0_DATA_REG_reg[3][4]\,
      Q(3) => \n_0_DATA_REG_reg[3][3]\,
      Q(2) => \n_0_DATA_REG_reg[3][2]\,
      Q(1) => \n_0_DATA_REG_reg[3][1]\,
      Q(0) => \n_0_DATA_REG_reg[3][0]\,
      gtx_clk => gtx_clk
    );
CRC_COMPUTE_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => \^pad\,
      I1 => \n_0_TRANSMIT_PIPE_reg[0]\,
      O => COMPUTE0
    );
CRC_COMPUTE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => COMPUTE0,
      Q => COMPUTE,
      R => SR(0)
    );
\CRC_COUNT[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFF7A"
    )
    port map (
      I0 => CRC_COUNT(0),
      I1 => n_0_FCS_reg,
      I2 => tx_ce_sample,
      I3 => I8,
      I4 => I9,
      O => \n_0_CRC_COUNT[0]_i_1\
    );
\CRC_COUNT[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF9FAA"
    )
    port map (
      I0 => CRC_COUNT(1),
      I1 => CRC_COUNT(0),
      I2 => n_0_FCS_reg,
      I3 => tx_ce_sample,
      I4 => I8,
      I5 => I9,
      O => \n_0_CRC_COUNT[1]_i_1\
    );
\CRC_COUNT_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_CRC_COUNT[0]_i_1\,
      Q => CRC_COUNT(0),
      R => \<const0>\
    );
\CRC_COUNT_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_CRC_COUNT[1]_i_1\,
      Q => CRC_COUNT(1),
      R => \<const0>\
    );
CRC_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => n_0_FCS_reg,
      I1 => n_0_CFL_reg,
      O => CRC0
    );
CRC_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => CRC0,
      Q => CRC,
      R => SR(0)
    );
DATA_REG4_BIT0_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_DATA_REG_reg[3][0]\,
      Q => DATA_REG4_BIT0,
      R => \<const0>\
    );
\DATA_REG[1][0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FCAA"
    )
    port map (
      I0 => \DATA_REG_reg[1]_2\(0),
      I1 => \DATA_REG_reg[0]_3\(0),
      I2 => PREAMBLE,
      I3 => tx_ce_sample,
      O => \n_0_DATA_REG[1][0]_i_1\
    );
\DATA_REG[1][1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0CAA"
    )
    port map (
      I0 => \DATA_REG_reg[1]_2\(1),
      I1 => \DATA_REG_reg[0]_3\(1),
      I2 => PREAMBLE,
      I3 => tx_ce_sample,
      O => \n_0_DATA_REG[1][1]_i_1\
    );
\DATA_REG[1][2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FCAA"
    )
    port map (
      I0 => \DATA_REG_reg[1]_2\(2),
      I1 => \DATA_REG_reg[0]_3\(2),
      I2 => PREAMBLE,
      I3 => tx_ce_sample,
      O => \n_0_DATA_REG[1][2]_i_1\
    );
\DATA_REG[1][3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0CAA"
    )
    port map (
      I0 => \DATA_REG_reg[1]_2\(3),
      I1 => \DATA_REG_reg[0]_3\(3),
      I2 => PREAMBLE,
      I3 => tx_ce_sample,
      O => \n_0_DATA_REG[1][3]_i_1\
    );
\DATA_REG[1][4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FCAA"
    )
    port map (
      I0 => \DATA_REG_reg[1]_2\(4),
      I1 => \DATA_REG_reg[0]_3\(4),
      I2 => PREAMBLE,
      I3 => tx_ce_sample,
      O => \n_0_DATA_REG[1][4]_i_1\
    );
\DATA_REG[1][5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0CAA"
    )
    port map (
      I0 => \DATA_REG_reg[1]_2\(5),
      I1 => \DATA_REG_reg[0]_3\(5),
      I2 => PREAMBLE,
      I3 => tx_ce_sample,
      O => \n_0_DATA_REG[1][5]_i_1\
    );
\DATA_REG[1][6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FCAA"
    )
    port map (
      I0 => \DATA_REG_reg[1]_2\(6),
      I1 => \DATA_REG_reg[0]_3\(6),
      I2 => PREAMBLE,
      I3 => tx_ce_sample,
      O => \n_0_DATA_REG[1][6]_i_1\
    );
\DATA_REG[1][7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FACA0ACA"
    )
    port map (
      I0 => \DATA_REG_reg[1]_2\(7),
      I1 => \DATA_REG_reg[0]_3\(7),
      I2 => tx_ce_sample,
      I3 => PREAMBLE,
      I4 => REG_PREAMBLE_DONE,
      O => \n_0_DATA_REG[1][7]_i_1\
    );
\DATA_REG[2][7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => REG_PREAMBLE,
      I1 => tx_ce_sample,
      I2 => TRANSMIT,
      O => \n_0_DATA_REG[2][7]_i_1\
    );
\DATA_REG_reg[0][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I21(0),
      Q => \DATA_REG_reg[0]_3\(0),
      R => \<const0>\
    );
\DATA_REG_reg[0][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I21(1),
      Q => \DATA_REG_reg[0]_3\(1),
      R => \<const0>\
    );
\DATA_REG_reg[0][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I21(2),
      Q => \DATA_REG_reg[0]_3\(2),
      R => \<const0>\
    );
\DATA_REG_reg[0][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I21(3),
      Q => \DATA_REG_reg[0]_3\(3),
      R => \<const0>\
    );
\DATA_REG_reg[0][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I21(4),
      Q => \DATA_REG_reg[0]_3\(4),
      R => \<const0>\
    );
\DATA_REG_reg[0][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I21(5),
      Q => \DATA_REG_reg[0]_3\(5),
      R => \<const0>\
    );
\DATA_REG_reg[0][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I21(6),
      Q => \DATA_REG_reg[0]_3\(6),
      R => \<const0>\
    );
\DATA_REG_reg[0][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => I21(7),
      Q => \DATA_REG_reg[0]_3\(7),
      R => \<const0>\
    );
\DATA_REG_reg[1][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_DATA_REG[1][0]_i_1\,
      Q => \DATA_REG_reg[1]_2\(0),
      R => \<const0>\
    );
\DATA_REG_reg[1][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_DATA_REG[1][1]_i_1\,
      Q => \DATA_REG_reg[1]_2\(1),
      R => \<const0>\
    );
\DATA_REG_reg[1][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_DATA_REG[1][2]_i_1\,
      Q => \DATA_REG_reg[1]_2\(2),
      R => \<const0>\
    );
\DATA_REG_reg[1][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_DATA_REG[1][3]_i_1\,
      Q => \DATA_REG_reg[1]_2\(3),
      R => \<const0>\
    );
\DATA_REG_reg[1][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_DATA_REG[1][4]_i_1\,
      Q => \DATA_REG_reg[1]_2\(4),
      R => \<const0>\
    );
\DATA_REG_reg[1][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_DATA_REG[1][5]_i_1\,
      Q => \DATA_REG_reg[1]_2\(5),
      R => \<const0>\
    );
\DATA_REG_reg[1][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_DATA_REG[1][6]_i_1\,
      Q => \DATA_REG_reg[1]_2\(6),
      R => \<const0>\
    );
\DATA_REG_reg[1][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_DATA_REG[1][7]_i_1\,
      Q => \DATA_REG_reg[1]_2\(7),
      R => \<const0>\
    );
\DATA_REG_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[1]_2\(0),
      Q => \DATA_REG_reg[2]_1\(0),
      R => \n_0_DATA_REG[2][7]_i_1\
    );
\DATA_REG_reg[2][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[1]_2\(1),
      Q => \DATA_REG_reg[2]_1\(1),
      R => \n_0_DATA_REG[2][7]_i_1\
    );
\DATA_REG_reg[2][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[1]_2\(2),
      Q => \DATA_REG_reg[2]_1\(2),
      R => \n_0_DATA_REG[2][7]_i_1\
    );
\DATA_REG_reg[2][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[1]_2\(3),
      Q => \DATA_REG_reg[2]_1\(3),
      R => \n_0_DATA_REG[2][7]_i_1\
    );
\DATA_REG_reg[2][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[1]_2\(4),
      Q => \DATA_REG_reg[2]_1\(4),
      R => \n_0_DATA_REG[2][7]_i_1\
    );
\DATA_REG_reg[2][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[1]_2\(5),
      Q => \DATA_REG_reg[2]_1\(5),
      R => \n_0_DATA_REG[2][7]_i_1\
    );
\DATA_REG_reg[2][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[1]_2\(6),
      Q => \DATA_REG_reg[2]_1\(6),
      R => \n_0_DATA_REG[2][7]_i_1\
    );
\DATA_REG_reg[2][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[1]_2\(7),
      Q => \DATA_REG_reg[2]_1\(7),
      R => \n_0_DATA_REG[2][7]_i_1\
    );
\DATA_REG_reg[3][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[2]_1\(0),
      Q => \n_0_DATA_REG_reg[3][0]\,
      R => I19(0)
    );
\DATA_REG_reg[3][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[2]_1\(1),
      Q => \n_0_DATA_REG_reg[3][1]\,
      R => I19(0)
    );
\DATA_REG_reg[3][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[2]_1\(2),
      Q => \n_0_DATA_REG_reg[3][2]\,
      R => I19(0)
    );
\DATA_REG_reg[3][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[2]_1\(3),
      Q => \n_0_DATA_REG_reg[3][3]\,
      R => I19(0)
    );
\DATA_REG_reg[3][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[2]_1\(4),
      Q => \n_0_DATA_REG_reg[3][4]\,
      R => I19(0)
    );
\DATA_REG_reg[3][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[2]_1\(5),
      Q => \n_0_DATA_REG_reg[3][5]\,
      R => I19(0)
    );
\DATA_REG_reg[3][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[2]_1\(6),
      Q => \n_0_DATA_REG_reg[3][6]\,
      R => I19(0)
    );
\DATA_REG_reg[3][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \DATA_REG_reg[2]_1\(7),
      Q => \n_0_DATA_REG_reg[3][7]\,
      R => I19(0)
    );
DST_ADDR_BYTE_MATCH_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0FFAAAAC0C0AAAA"
    )
    port map (
      I0 => \^o6\,
      I1 => I15,
      I2 => I16,
      I3 => p_0_in62_in,
      I4 => tx_ce_sample,
      I5 => p_1_in4_in,
      O => n_0_DST_ADDR_BYTE_MATCH_i_1
    );
DST_ADDR_BYTE_MATCH_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_DST_ADDR_BYTE_MATCH_i_1,
      Q => \^o6\,
      R => \<const0>\
    );
DST_ADDR_MULTI_MATCH_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => DATA_REG4_BIT0,
      Q => DST_ADDR_MULTI_MATCH,
      R => \<const0>\
    );
FCS_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000DF000000C0"
    )
    port map (
      I0 => n_0_SCSH_reg,
      I1 => n_0_FCS_i_2,
      I2 => tx_ce_sample,
      I3 => I9,
      I4 => I8,
      I5 => n_0_FCS_reg,
      O => n_0_FCS_i_1
    );
FCS_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F8F8F800"
    )
    port map (
      I0 => n_0_CFL_reg,
      I1 => n_0_MIN_PKT_LEN_REACHED_reg,
      I2 => \^o2\,
      I3 => CRC_COUNT(0),
      I4 => CRC_COUNT(1),
      I5 => n_0_INT_CRC_MODE_reg,
      O => n_0_FCS_i_2
    );
FCS_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_FCS_i_1,
      Q => n_0_FCS_reg,
      R => \<const0>\
    );
FRAME_BAD_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000EEE"
    )
    port map (
      I0 => n_0_FRAME_BAD_reg,
      I1 => FRAME_BAD,
      I2 => tx_ce_sample,
      I3 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      I4 => I8,
      I5 => I9,
      O => n_0_FRAME_BAD_i_1
    );
FRAME_BAD_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA80808080808080"
    )
    port map (
      I0 => tx_ce_sample,
      I1 => n_0_INT_CRC_MODE_reg,
      I2 => \^o2\,
      I3 => \^o4\,
      I4 => \^o1\,
      I5 => n_0_FRAME_BAD_i_3,
      O => FRAME_BAD
    );
FRAME_BAD_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => n_0_FCS_reg,
      I1 => CRC_COUNT(1),
      I2 => CRC_COUNT(0),
      O => n_0_FRAME_BAD_i_3
    );
FRAME_BAD_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_FRAME_BAD_i_1,
      Q => n_0_FRAME_BAD_reg,
      R => \<const0>\
    );
\FRAME_COUNT[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[0]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(0),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[0]_i_1\
    );
\FRAME_COUNT[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[10]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(10),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[10]_i_1\
    );
\FRAME_COUNT[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[11]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(11),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[11]_i_1\
    );
\FRAME_COUNT[11]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[11]\,
      O => \n_0_FRAME_COUNT[11]_i_3\
    );
\FRAME_COUNT[11]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[10]\,
      O => \n_0_FRAME_COUNT[11]_i_4\
    );
\FRAME_COUNT[11]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[9]\,
      O => \n_0_FRAME_COUNT[11]_i_5\
    );
\FRAME_COUNT[11]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[8]\,
      O => \n_0_FRAME_COUNT[11]_i_6\
    );
\FRAME_COUNT[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[12]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(12),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[12]_i_1\
    );
\FRAME_COUNT[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[13]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(13),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[13]_i_1\
    );
\FRAME_COUNT[13]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => n_0_CFL_reg,
      I1 => \^o3\,
      I2 => n_0_FCS_reg,
      O => \n_0_FRAME_COUNT[13]_i_2\
    );
\FRAME_COUNT[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EAEAEAEAEAEAEA0A"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[14]\,
      I1 => plusOp(14),
      I2 => tx_ce_sample,
      I3 => n_0_CFL_reg,
      I4 => \^o3\,
      I5 => n_0_FCS_reg,
      O => \n_0_FRAME_COUNT[14]_i_1\
    );
\FRAME_COUNT[14]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[14]\,
      O => \n_0_FRAME_COUNT[14]_i_3\
    );
\FRAME_COUNT[14]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[13]\,
      O => \n_0_FRAME_COUNT[14]_i_4\
    );
\FRAME_COUNT[14]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[12]\,
      O => \n_0_FRAME_COUNT[14]_i_5\
    );
\FRAME_COUNT[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[1]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(1),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[1]_i_1\
    );
\FRAME_COUNT[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FFB8B8AAAAAAAA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[2]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(2),
      I3 => n_0_INT_CRC_MODE_reg,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      I5 => tx_ce_sample,
      O => \n_0_FRAME_COUNT[2]_i_1\
    );
\FRAME_COUNT[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[3]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(3),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[3]_i_1\
    );
\FRAME_COUNT[3]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[3]\,
      O => \n_0_FRAME_COUNT[3]_i_3\
    );
\FRAME_COUNT[3]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[2]\,
      O => \n_0_FRAME_COUNT[3]_i_4\
    );
\FRAME_COUNT[3]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[1]\,
      O => \n_0_FRAME_COUNT[3]_i_5\
    );
\FRAME_COUNT[3]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[0]\,
      O => \n_0_FRAME_COUNT[3]_i_6\
    );
\FRAME_COUNT[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[4]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(4),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[4]_i_1\
    );
\FRAME_COUNT[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[5]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(5),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[5]_i_1\
    );
\FRAME_COUNT[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[6]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(6),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[6]_i_1\
    );
\FRAME_COUNT[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[7]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(7),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[7]_i_1\
    );
\FRAME_COUNT[7]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[7]\,
      O => \n_0_FRAME_COUNT[7]_i_3\
    );
\FRAME_COUNT[7]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[6]\,
      O => \n_0_FRAME_COUNT[7]_i_4\
    );
\FRAME_COUNT[7]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[5]\,
      O => \n_0_FRAME_COUNT[7]_i_5\
    );
\FRAME_COUNT[7]_i_6\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[4]\,
      O => \n_0_FRAME_COUNT[7]_i_6\
    );
\FRAME_COUNT[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[8]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(8),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[8]_i_1\
    );
\FRAME_COUNT[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00AAB8AA"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[9]\,
      I1 => \n_0_FRAME_COUNT_reg[14]\,
      I2 => plusOp(9),
      I3 => tx_ce_sample,
      I4 => \n_0_FRAME_COUNT[13]_i_2\,
      O => \n_0_FRAME_COUNT[9]_i_1\
    );
\FRAME_COUNT_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[0]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[0]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[10]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[10]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[11]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[11]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[11]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FRAME_COUNT_reg[7]_i_2\,
      CO(3) => \n_0_FRAME_COUNT_reg[11]_i_2\,
      CO(2) => \n_1_FRAME_COUNT_reg[11]_i_2\,
      CO(1) => \n_2_FRAME_COUNT_reg[11]_i_2\,
      CO(0) => \n_3_FRAME_COUNT_reg[11]_i_2\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => plusOp(11 downto 8),
      S(3) => \n_0_FRAME_COUNT[11]_i_3\,
      S(2) => \n_0_FRAME_COUNT[11]_i_4\,
      S(1) => \n_0_FRAME_COUNT[11]_i_5\,
      S(0) => \n_0_FRAME_COUNT[11]_i_6\
    );
\FRAME_COUNT_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[12]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[12]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[13]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[13]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[14]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[14]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[14]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FRAME_COUNT_reg[11]_i_2\,
      CO(3 downto 2) => \NLW_FRAME_COUNT_reg[14]_i_2_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \n_2_FRAME_COUNT_reg[14]_i_2\,
      CO(0) => \n_3_FRAME_COUNT_reg[14]_i_2\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3) => \NLW_FRAME_COUNT_reg[14]_i_2_O_UNCONNECTED\(3),
      O(2 downto 0) => plusOp(14 downto 12),
      S(3) => \<const0>\,
      S(2) => \n_0_FRAME_COUNT[14]_i_3\,
      S(1) => \n_0_FRAME_COUNT[14]_i_4\,
      S(0) => \n_0_FRAME_COUNT[14]_i_5\
    );
\FRAME_COUNT_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[1]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[1]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[2]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[2]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[3]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[3]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[3]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => \n_0_FRAME_COUNT_reg[3]_i_2\,
      CO(2) => \n_1_FRAME_COUNT_reg[3]_i_2\,
      CO(1) => \n_2_FRAME_COUNT_reg[3]_i_2\,
      CO(0) => \n_3_FRAME_COUNT_reg[3]_i_2\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \n_0_FRAME_COUNT_reg[0]\,
      O(3 downto 0) => plusOp(3 downto 0),
      S(3) => \n_0_FRAME_COUNT[3]_i_3\,
      S(2) => \n_0_FRAME_COUNT[3]_i_4\,
      S(1) => \n_0_FRAME_COUNT[3]_i_5\,
      S(0) => \n_0_FRAME_COUNT[3]_i_6\
    );
\FRAME_COUNT_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[4]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[4]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[5]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[5]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[6]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[6]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[7]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[7]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[7]_i_2\: unisim.vcomponents.CARRY4
    port map (
      CI => \n_0_FRAME_COUNT_reg[3]_i_2\,
      CO(3) => \n_0_FRAME_COUNT_reg[7]_i_2\,
      CO(2) => \n_1_FRAME_COUNT_reg[7]_i_2\,
      CO(1) => \n_2_FRAME_COUNT_reg[7]_i_2\,
      CO(0) => \n_3_FRAME_COUNT_reg[7]_i_2\,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => plusOp(7 downto 4),
      S(3) => \n_0_FRAME_COUNT[7]_i_3\,
      S(2) => \n_0_FRAME_COUNT[7]_i_4\,
      S(1) => \n_0_FRAME_COUNT[7]_i_5\,
      S(0) => \n_0_FRAME_COUNT[7]_i_6\
    );
\FRAME_COUNT_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[8]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[8]\,
      R => \<const0>\
    );
\FRAME_COUNT_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_COUNT[9]_i_1\,
      Q => \n_0_FRAME_COUNT_reg[9]\,
      R => \<const0>\
    );
FRAME_GOOD_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0103030300030000"
    )
    port map (
      I0 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      I1 => I8,
      I2 => I9,
      I3 => n_0_FRAME_GOOD_i_2,
      I4 => tx_ce_sample,
      I5 => n_0_FRAME_GOOD_reg,
      O => n_0_FRAME_GOOD_i_1
    );
FRAME_GOOD_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F8F8F8F8F8F8F8"
    )
    port map (
      I0 => \^o1\,
      I1 => \^o4\,
      I2 => n_0_FRAME_GOOD_i_3,
      I3 => n_0_INT_CRC_MODE_reg,
      I4 => n_0_CFL_reg,
      I5 => n_0_MIN_PKT_LEN_REACHED_reg,
      O => n_0_FRAME_GOOD_i_2
    );
FRAME_GOOD_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEFF"
    )
    port map (
      I0 => n_0_INT_CRC_MODE_reg,
      I1 => CRC_COUNT(0),
      I2 => CRC_COUNT(1),
      I3 => n_0_FCS_reg,
      O => n_0_FRAME_GOOD_i_3
    );
FRAME_GOOD_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_FRAME_GOOD_i_1,
      Q => n_0_FRAME_GOOD_reg,
      R => \<const0>\
    );
\FRAME_MAX[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF3202"
    )
    port map (
      I0 => FRAME_MAX(2),
      I1 => \n_0_FRAME_MAX[4]_i_2\,
      I2 => tx_ce_sample,
      I3 => \n_0_INT_MAX_FRAME_LENGTH_reg[2]\,
      I4 => I9,
      I5 => I8,
      O => \n_0_FRAME_MAX[2]_i_1\
    );
\FRAME_MAX[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF3202"
    )
    port map (
      I0 => FRAME_MAX(3),
      I1 => \n_0_FRAME_MAX[4]_i_2\,
      I2 => tx_ce_sample,
      I3 => \n_0_INT_MAX_FRAME_LENGTH_reg[3]\,
      I4 => I9,
      I5 => I8,
      O => \n_0_FRAME_MAX[3]_i_1\
    );
\FRAME_MAX[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1111111011001110"
    )
    port map (
      I0 => I9,
      I1 => I8,
      I2 => FRAME_MAX(4),
      I3 => \n_0_FRAME_MAX[4]_i_2\,
      I4 => tx_ce_sample,
      I5 => \n_0_INT_MAX_FRAME_LENGTH_reg[4]\,
      O => \n_0_FRAME_MAX[4]_i_1\
    );
\FRAME_MAX[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => p_72_in,
      I1 => tx_ce_sample,
      I2 => INT_VLAN_EN,
      I3 => INT_MAX_FRAME_ENABLE,
      O => \n_0_FRAME_MAX[4]_i_2\
    );
\FRAME_MAX_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_MAX[2]_i_1\,
      Q => FRAME_MAX(2),
      R => \<const0>\
    );
\FRAME_MAX_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_MAX[3]_i_1\,
      Q => FRAME_MAX(3),
      R => \<const0>\
    );
\FRAME_MAX_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_FRAME_MAX[4]_i_1\,
      Q => FRAME_MAX(4),
      R => \<const0>\
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
IDL_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF4F4F4FCFCFCFCF"
    )
    port map (
      I0 => n_0_CDS_reg,
      I1 => \^o9\,
      I2 => I11,
      I3 => n_0_IDL_i_2,
      I4 => CLIENT_FRAME_DONE,
      I5 => tx_ce_sample,
      O => n_0_IDL_i_1
    );
IDL_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000200"
    )
    port map (
      I0 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      I1 => p_0_in1_in,
      I2 => \n_0_IFG_COUNT_reg[5]\,
      I3 => \n_0_IFG_COUNT[6]_i_2\,
      I4 => \n_0_IFG_COUNT_reg[6]\,
      O => n_0_IDL_i_2
    );
IDL_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_IDL_i_1,
      Q => \^o9\,
      R => \<const0>\
    );
\IFG_COUNT[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"33FFBFFFFF33B333"
    )
    port map (
      I0 => \n_0_IFG_COUNT[0]_i_2\,
      I1 => I11,
      I2 => \^o5\,
      I3 => tx_ce_sample,
      I4 => \n_0_IFG_COUNT[7]_i_4\,
      I5 => \n_0_IFG_COUNT_reg[0]\,
      O => \n_0_IFG_COUNT[0]_i_1\
    );
\IFG_COUNT[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
    port map (
      I0 => n_0_INT_SPEED_IS_10_100_reg,
      I1 => n_0_INT_HALF_DUPLEX_reg,
      I2 => INT_IFG_DEL_MASKED(0),
      O => \n_0_IFG_COUNT[0]_i_2\
    );
\IFG_COUNT[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F20202F2"
    )
    port map (
      I0 => INT_IFG_DEL_MASKED(1),
      I1 => n_0_INT_HALF_DUPLEX_reg,
      I2 => \n_0_IFG_COUNT[7]_i_4\,
      I3 => p_5_in,
      I4 => \n_0_IFG_COUNT_reg[0]\,
      O => \n_0_IFG_COUNT[1]_i_1\
    );
\IFG_COUNT[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEFFFE00"
    )
    port map (
      I0 => \n_0_IFG_COUNT[2]_i_2\,
      I1 => I9,
      I2 => I8,
      I3 => \n_0_IFG_COUNT[7]_i_2\,
      I4 => \n_0_IFG_COUNT_reg[2]\,
      O => \n_0_IFG_COUNT[2]_i_1\
    );
\IFG_COUNT[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"606F6F6F606F6060"
    )
    port map (
      I0 => \n_0_IFG_COUNT_reg[2]\,
      I1 => \n_0_IFG_COUNT[2]_i_3\,
      I2 => \n_0_IFG_COUNT[7]_i_4\,
      I3 => n_0_INT_SPEED_IS_10_100_reg,
      I4 => n_0_INT_HALF_DUPLEX_reg,
      I5 => INT_IFG_DEL_MASKED(2),
      O => \n_0_IFG_COUNT[2]_i_2\
    );
\IFG_COUNT[2]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_IFG_COUNT_reg[0]\,
      I1 => p_5_in,
      O => \n_0_IFG_COUNT[2]_i_3\
    );
\IFG_COUNT[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0072FF72FF720072"
    )
    port map (
      I0 => n_0_INT_HALF_DUPLEX_reg,
      I1 => n_0_INT_SPEED_IS_10_100_reg,
      I2 => INT_IFG_DEL_MASKED(3),
      I3 => \n_0_IFG_COUNT[7]_i_4\,
      I4 => \n_0_IFG_COUNT[3]_i_2\,
      I5 => p_3_in,
      O => \n_0_IFG_COUNT[3]_i_1\
    );
\IFG_COUNT[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => p_5_in,
      I1 => \n_0_IFG_COUNT_reg[0]\,
      I2 => \n_0_IFG_COUNT_reg[2]\,
      O => \n_0_IFG_COUNT[3]_i_2\
    );
\IFG_COUNT[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F20202F2"
    )
    port map (
      I0 => INT_IFG_DEL_MASKED(4),
      I1 => n_0_INT_HALF_DUPLEX_reg,
      I2 => \n_0_IFG_COUNT[7]_i_4\,
      I3 => \n_0_IFG_COUNT[4]_i_2\,
      I4 => \n_0_IFG_COUNT_reg[4]\,
      O => \n_0_IFG_COUNT[4]_i_1\
    );
\IFG_COUNT[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => p_3_in,
      I1 => \n_0_IFG_COUNT_reg[2]\,
      I2 => \n_0_IFG_COUNT_reg[0]\,
      I3 => p_5_in,
      O => \n_0_IFG_COUNT[4]_i_2\
    );
\IFG_COUNT[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"02F2F202"
    )
    port map (
      I0 => INT_IFG_DEL_MASKED(5),
      I1 => n_0_INT_HALF_DUPLEX_reg,
      I2 => \n_0_IFG_COUNT[7]_i_4\,
      I3 => \n_0_IFG_COUNT_reg[5]\,
      I4 => \n_0_IFG_COUNT[6]_i_2\,
      O => \n_0_IFG_COUNT[5]_i_1\
    );
\IFG_COUNT[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F202F2F202F20202"
    )
    port map (
      I0 => INT_IFG_DEL_MASKED(6),
      I1 => n_0_INT_HALF_DUPLEX_reg,
      I2 => \n_0_IFG_COUNT[7]_i_4\,
      I3 => \n_0_IFG_COUNT_reg[5]\,
      I4 => \n_0_IFG_COUNT[6]_i_2\,
      I5 => \n_0_IFG_COUNT_reg[6]\,
      O => \n_0_IFG_COUNT[6]_i_1\
    );
\IFG_COUNT[6]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => \n_0_IFG_COUNT_reg[4]\,
      I1 => p_5_in,
      I2 => \n_0_IFG_COUNT_reg[0]\,
      I3 => \n_0_IFG_COUNT_reg[2]\,
      I4 => p_3_in,
      O => \n_0_IFG_COUNT[6]_i_2\
    );
\IFG_COUNT[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => \n_0_IFG_COUNT[7]_i_2\,
      I1 => I9,
      I2 => I8,
      O => \n_0_IFG_COUNT[7]_i_1\
    );
\IFG_COUNT[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEEFEEE"
    )
    port map (
      I0 => I8,
      I1 => I9,
      I2 => \^o5\,
      I3 => tx_ce_sample,
      I4 => \n_0_IFG_COUNT[7]_i_4\,
      O => \n_0_IFG_COUNT[7]_i_2\
    );
\IFG_COUNT[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FF020022222222"
    )
    port map (
      I0 => INT_IFG_DEL_MASKED(7),
      I1 => n_0_INT_HALF_DUPLEX_reg,
      I2 => \n_0_IFG_COUNT_reg[6]\,
      I3 => \n_0_IFG_COUNT[7]_i_5\,
      I4 => p_0_in1_in,
      I5 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      O => \n_0_IFG_COUNT[7]_i_3\
    );
\IFG_COUNT[7]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAA8AA"
    )
    port map (
      I0 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      I1 => p_0_in1_in,
      I2 => \n_0_IFG_COUNT_reg[5]\,
      I3 => \n_0_IFG_COUNT[6]_i_2\,
      I4 => \n_0_IFG_COUNT_reg[6]\,
      O => \n_0_IFG_COUNT[7]_i_4\
    );
\IFG_COUNT[7]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => p_3_in,
      I1 => \n_0_IFG_COUNT_reg[2]\,
      I2 => \n_0_IFG_COUNT_reg[0]\,
      I3 => p_5_in,
      I4 => \n_0_IFG_COUNT_reg[4]\,
      I5 => \n_0_IFG_COUNT_reg[5]\,
      O => \n_0_IFG_COUNT[7]_i_5\
    );
\IFG_COUNT_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_IFG_COUNT[0]_i_1\,
      Q => \n_0_IFG_COUNT_reg[0]\,
      R => \<const0>\
    );
\IFG_COUNT_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_IFG_COUNT[7]_i_2\,
      D => \n_0_IFG_COUNT[1]_i_1\,
      Q => p_5_in,
      R => \n_0_IFG_COUNT[7]_i_1\
    );
\IFG_COUNT_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_IFG_COUNT[2]_i_1\,
      Q => \n_0_IFG_COUNT_reg[2]\,
      R => \<const0>\
    );
\IFG_COUNT_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_IFG_COUNT[7]_i_2\,
      D => \n_0_IFG_COUNT[3]_i_1\,
      Q => p_3_in,
      R => \n_0_IFG_COUNT[7]_i_1\
    );
\IFG_COUNT_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_IFG_COUNT[7]_i_2\,
      D => \n_0_IFG_COUNT[4]_i_1\,
      Q => \n_0_IFG_COUNT_reg[4]\,
      R => \n_0_IFG_COUNT[7]_i_1\
    );
\IFG_COUNT_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_IFG_COUNT[7]_i_2\,
      D => \n_0_IFG_COUNT[5]_i_1\,
      Q => \n_0_IFG_COUNT_reg[5]\,
      R => \n_0_IFG_COUNT[7]_i_1\
    );
\IFG_COUNT_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_IFG_COUNT[7]_i_2\,
      D => \n_0_IFG_COUNT[6]_i_1\,
      Q => \n_0_IFG_COUNT_reg[6]\,
      R => \n_0_IFG_COUNT[7]_i_1\
    );
\IFG_COUNT_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \n_0_IFG_COUNT[7]_i_2\,
      D => \n_0_IFG_COUNT[7]_i_3\,
      Q => p_0_in1_in,
      R => \n_0_IFG_COUNT[7]_i_1\
    );
INT_CRC_MODE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => INT_CRC_MODE,
      D => I1,
      Q => n_0_INT_CRC_MODE_reg,
      R => SR(0)
    );
INT_HALF_DUPLEX_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8A8A88808080888"
    )
    port map (
      I0 => I11,
      I1 => n_0_INT_HALF_DUPLEX_reg,
      I2 => tx_ce_sample,
      I3 => n_0_CDS_reg,
      I4 => \^o5\,
      I5 => I13,
      O => n_0_INT_HALF_DUPLEX_i_1
    );
INT_HALF_DUPLEX_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_INT_HALF_DUPLEX_i_1,
      Q => n_0_INT_HALF_DUPLEX_reg,
      R => \<const0>\
    );
\INT_IFG_DELAY_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => tx_ifg_delay(0),
      Q => \n_0_INT_IFG_DELAY_reg[0]\,
      R => SR(0)
    );
\INT_IFG_DELAY_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => tx_ifg_delay(1),
      Q => \n_0_INT_IFG_DELAY_reg[1]\,
      R => SR(0)
    );
\INT_IFG_DELAY_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => tx_ifg_delay(2),
      Q => \n_0_INT_IFG_DELAY_reg[2]\,
      R => SR(0)
    );
\INT_IFG_DELAY_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => tx_ifg_delay(3),
      Q => \n_0_INT_IFG_DELAY_reg[3]\,
      R => SR(0)
    );
\INT_IFG_DELAY_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => tx_ifg_delay(4),
      Q => \n_0_INT_IFG_DELAY_reg[4]\,
      R => SR(0)
    );
\INT_IFG_DELAY_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => tx_ifg_delay(5),
      Q => \n_0_INT_IFG_DELAY_reg[5]\,
      R => SR(0)
    );
\INT_IFG_DELAY_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => tx_ifg_delay(6),
      Q => \n_0_INT_IFG_DELAY_reg[6]\,
      R => SR(0)
    );
\INT_IFG_DELAY_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => tx_ifg_delay(7),
      Q => \n_0_INT_IFG_DELAY_reg[7]\,
      R => SR(0)
    );
INT_IFG_DEL_EN_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => INT_CRC_MODE,
      D => I4,
      Q => INT_IFG_DEL_EN,
      R => SR(0)
    );
INT_JUMBO_EN_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => INT_CRC_MODE,
      D => I2,
      Q => INT_JUMBO_EN,
      R => SR(0)
    );
INT_MAX_FRAME_ENABLE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => INT_CRC_MODE,
      D => tx_configuration_vector(0),
      Q => INT_MAX_FRAME_ENABLE,
      R => SR(0)
    );
\INT_MAX_FRAME_LENGTH[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => tx_configuration_vector(1),
      O => \n_0_INT_MAX_FRAME_LENGTH[0]_i_1\
    );
\INT_MAX_FRAME_LENGTH[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => tx_configuration_vector(11),
      I1 => tx_configuration_vector(0),
      O => \n_0_INT_MAX_FRAME_LENGTH[10]_i_1\
    );
\INT_MAX_FRAME_LENGTH[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => tx_configuration_vector(12),
      O => \n_0_INT_MAX_FRAME_LENGTH[11]_i_1\
    );
\INT_MAX_FRAME_LENGTH[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => tx_configuration_vector(13),
      O => \n_0_INT_MAX_FRAME_LENGTH[12]_i_1\
    );
\INT_MAX_FRAME_LENGTH[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => tx_configuration_vector(14),
      O => \n_0_INT_MAX_FRAME_LENGTH[13]_i_1\
    );
\INT_MAX_FRAME_LENGTH[14]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => tx_configuration_vector(15),
      O => \n_0_INT_MAX_FRAME_LENGTH[14]_i_2\
    );
\INT_MAX_FRAME_LENGTH[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => tx_configuration_vector(2),
      I1 => tx_configuration_vector(0),
      O => \n_0_INT_MAX_FRAME_LENGTH[1]_i_1\
    );
\INT_MAX_FRAME_LENGTH[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => tx_configuration_vector(3),
      I1 => tx_configuration_vector(0),
      O => \n_0_INT_MAX_FRAME_LENGTH[2]_i_1\
    );
\INT_MAX_FRAME_LENGTH[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => tx_configuration_vector(4),
      I1 => tx_configuration_vector(0),
      O => \n_0_INT_MAX_FRAME_LENGTH[3]_i_1\
    );
\INT_MAX_FRAME_LENGTH[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => tx_configuration_vector(5),
      O => \n_0_INT_MAX_FRAME_LENGTH[4]_i_1\
    );
\INT_MAX_FRAME_LENGTH[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => tx_configuration_vector(6),
      I1 => tx_configuration_vector(0),
      O => \n_0_INT_MAX_FRAME_LENGTH[5]_i_1\
    );
\INT_MAX_FRAME_LENGTH[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => tx_configuration_vector(7),
      I1 => tx_configuration_vector(0),
      O => \n_0_INT_MAX_FRAME_LENGTH[6]_i_1\
    );
\INT_MAX_FRAME_LENGTH[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => tx_configuration_vector(8),
      I1 => tx_configuration_vector(0),
      O => \n_0_INT_MAX_FRAME_LENGTH[7]_i_1\
    );
\INT_MAX_FRAME_LENGTH[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => tx_configuration_vector(9),
      I1 => tx_configuration_vector(0),
      O => \n_0_INT_MAX_FRAME_LENGTH[8]_i_1\
    );
\INT_MAX_FRAME_LENGTH[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => tx_configuration_vector(10),
      O => \n_0_INT_MAX_FRAME_LENGTH[9]_i_1\
    );
\INT_MAX_FRAME_LENGTH_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[0]_i_1\,
      Q => INT_MAX_FRAME_LENGTH(0),
      R => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[10]\: unisim.vcomponents.FDSE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[10]_i_1\,
      Q => INT_MAX_FRAME_LENGTH(10),
      S => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[11]_i_1\,
      Q => INT_MAX_FRAME_LENGTH(11),
      R => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[12]_i_1\,
      Q => INT_MAX_FRAME_LENGTH(12),
      R => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[13]_i_1\,
      Q => INT_MAX_FRAME_LENGTH(13),
      R => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[14]_i_2\,
      Q => INT_MAX_FRAME_LENGTH(14),
      R => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[1]\: unisim.vcomponents.FDSE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[1]_i_1\,
      Q => INT_MAX_FRAME_LENGTH(1),
      S => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[2]\: unisim.vcomponents.FDSE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[2]_i_1\,
      Q => \n_0_INT_MAX_FRAME_LENGTH_reg[2]\,
      S => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[3]\: unisim.vcomponents.FDSE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[3]_i_1\,
      Q => \n_0_INT_MAX_FRAME_LENGTH_reg[3]\,
      S => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[4]_i_1\,
      Q => \n_0_INT_MAX_FRAME_LENGTH_reg[4]\,
      R => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[5]\: unisim.vcomponents.FDSE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[5]_i_1\,
      Q => INT_MAX_FRAME_LENGTH(5),
      S => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[6]\: unisim.vcomponents.FDSE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[6]_i_1\,
      Q => INT_MAX_FRAME_LENGTH(6),
      S => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[7]\: unisim.vcomponents.FDSE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[7]_i_1\,
      Q => INT_MAX_FRAME_LENGTH(7),
      S => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[8]\: unisim.vcomponents.FDSE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[8]_i_1\,
      Q => INT_MAX_FRAME_LENGTH(8),
      S => SR(0)
    );
\INT_MAX_FRAME_LENGTH_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => E(0),
      D => \n_0_INT_MAX_FRAME_LENGTH[9]_i_1\,
      Q => INT_MAX_FRAME_LENGTH(9),
      R => SR(0)
    );
INT_SPEED_IS_10_100_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => INT_CRC_MODE,
      D => I3,
      Q => n_0_INT_SPEED_IS_10_100_reg,
      R => SR(0)
    );
INT_TX_BROADCAST_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BF80"
    )
    port map (
      I0 => \^o6\,
      I1 => tx_ce_sample,
      I2 => p_0_in62_in,
      I3 => INT_TX_BROADCAST,
      O => n_0_INT_TX_BROADCAST_i_1
    );
INT_TX_BROADCAST_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_INT_TX_BROADCAST_i_1,
      Q => INT_TX_BROADCAST,
      R => \<const0>\
    );
INT_TX_EN_DELAY_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1313331302000200"
    )
    port map (
      I0 => tx_ce_sample,
      I1 => I8,
      I2 => I17,
      I3 => Q_0,
      I4 => n_0_INT_TX_EN_DELAY_i_2,
      I5 => I10,
      O => O10
    );
INT_TX_EN_DELAY_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000F1"
    )
    port map (
      I0 => CRC,
      I1 => p_0_in8_in,
      I2 => CR178124_FIX,
      I3 => PAD_PIPE,
      I4 => \^q\(0),
      O => n_0_INT_TX_EN_DELAY_i_2
    );
INT_TX_MULTICAST_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2FFF2000"
    )
    port map (
      I0 => DST_ADDR_MULTI_MATCH,
      I1 => \^o6\,
      I2 => tx_ce_sample,
      I3 => p_0_in62_in,
      I4 => INT_TX_MULTICAST,
      O => n_0_INT_TX_MULTICAST_i_1
    );
INT_TX_MULTICAST_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_INT_TX_MULTICAST_i_1,
      Q => INT_TX_MULTICAST,
      R => \<const0>\
    );
INT_TX_SUCCESS_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2A22AAAA0A000000"
    )
    port map (
      I0 => I11,
      I1 => \^o5\,
      I2 => n_0_INT_TX_UNDERRUN2_reg,
      I3 => \n_0_CORE_DOES_NO_HD_2.TX_OK_reg\,
      I4 => tx_ce_sample,
      I5 => INT_TX_SUCCESS,
      O => n_0_INT_TX_SUCCESS_i_1
    );
INT_TX_SUCCESS_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_INT_TX_SUCCESS_i_1,
      Q => INT_TX_SUCCESS,
      R => \<const0>\
    );
INT_TX_UNDERRUN2_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000EEE"
    )
    port map (
      I0 => n_0_INT_TX_UNDERRUN2_reg,
      I1 => INT_TX_UNDERRUN2,
      I2 => tx_ce_sample,
      I3 => REG_STATUS_VALID,
      I4 => I8,
      I5 => I9,
      O => n_0_INT_TX_UNDERRUN2_i_1
    );
INT_TX_UNDERRUN2_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0000000000"
    )
    port map (
      I0 => n_0_FCS_reg,
      I1 => \^o3\,
      I2 => \^o5\,
      I3 => tx_underrun_int,
      I4 => I7,
      I5 => tx_ce_sample,
      O => INT_TX_UNDERRUN2
    );
INT_TX_UNDERRUN2_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_INT_TX_UNDERRUN2_i_1,
      Q => n_0_INT_TX_UNDERRUN2_reg,
      R => \<const0>\
    );
INT_VLAN_EN_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => INT_CRC_MODE,
      D => I5,
      Q => INT_VLAN_EN,
      R => SR(0)
    );
\LEN_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[1]_2\(0),
      Q => \n_0_LEN_reg[0]\,
      R => SR(0)
    );
\LEN_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[0]_3\(2),
      Q => \n_0_LEN_reg[10]\,
      R => SR(0)
    );
\LEN_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[0]_3\(3),
      Q => p_8_in,
      R => SR(0)
    );
\LEN_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[0]_3\(4),
      Q => \n_0_LEN_reg[12]\,
      R => SR(0)
    );
\LEN_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[0]_3\(5),
      Q => \n_0_LEN_reg[13]\,
      R => SR(0)
    );
\LEN_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[0]_3\(6),
      Q => \n_0_LEN_reg[14]\,
      R => SR(0)
    );
\LEN_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[0]_3\(7),
      Q => \n_0_LEN_reg[15]\,
      R => SR(0)
    );
\LEN_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[1]_2\(1),
      Q => \n_0_LEN_reg[1]\,
      R => SR(0)
    );
\LEN_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[1]_2\(2),
      Q => \n_0_LEN_reg[2]\,
      R => SR(0)
    );
\LEN_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[1]_2\(3),
      Q => p_2_in61_in,
      R => SR(0)
    );
\LEN_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[1]_2\(4),
      Q => \n_0_LEN_reg[4]\,
      R => SR(0)
    );
\LEN_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[1]_2\(5),
      Q => \n_0_LEN_reg[5]\,
      R => SR(0)
    );
\LEN_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[1]_2\(6),
      Q => \n_0_LEN_reg[6]\,
      R => SR(0)
    );
\LEN_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[1]_2\(7),
      Q => p_4_in,
      R => SR(0)
    );
\LEN_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[0]_3\(0),
      Q => \n_0_LEN_reg[8]\,
      R => SR(0)
    );
\LEN_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => I20(0),
      D => \DATA_REG_reg[0]_3\(1),
      Q => \n_0_LEN_reg[9]\,
      R => SR(0)
    );
MAX_PKT_LEN_REACHED_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02FF000002000000"
    )
    port map (
      I0 => eqOp74_in,
      I1 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      I2 => INT_JUMBO_EN,
      I3 => n_0_MAX_PKT_LEN_REACHED_i_3,
      I4 => I11,
      I5 => \^o1\,
      O => n_0_MAX_PKT_LEN_REACHED_i_1
    );
MAX_PKT_LEN_REACHED_i_10: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[0]\,
      I1 => INT_MAX_FRAME_LENGTH(0),
      I2 => \n_0_FRAME_COUNT_reg[1]\,
      I3 => INT_MAX_FRAME_LENGTH(1),
      I4 => FRAME_MAX(2),
      I5 => \n_0_FRAME_COUNT_reg[2]\,
      O => n_0_MAX_PKT_LEN_REACHED_i_10
    );
MAX_PKT_LEN_REACHED_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF400B0"
    )
    port map (
      I0 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      I1 => eqOp74_in,
      I2 => n_0_MAX_PKT_LEN_REACHED_i_6,
      I3 => INT_JUMBO_EN,
      I4 => tx_ce_sample,
      O => n_0_MAX_PKT_LEN_REACHED_i_3
    );
MAX_PKT_LEN_REACHED_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[12]\,
      I1 => INT_MAX_FRAME_LENGTH(12),
      I2 => \n_0_FRAME_COUNT_reg[13]\,
      I3 => INT_MAX_FRAME_LENGTH(13),
      I4 => INT_MAX_FRAME_LENGTH(14),
      I5 => \n_0_FRAME_COUNT_reg[14]\,
      O => n_0_MAX_PKT_LEN_REACHED_i_5
    );
MAX_PKT_LEN_REACHED_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000080000"
    )
    port map (
      I0 => tx_ce_sample,
      I1 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_reg\,
      I2 => p_0_in1_in,
      I3 => \n_0_IFG_COUNT_reg[5]\,
      I4 => \n_0_IFG_COUNT[6]_i_2\,
      I5 => \n_0_IFG_COUNT_reg[6]\,
      O => n_0_MAX_PKT_LEN_REACHED_i_6
    );
MAX_PKT_LEN_REACHED_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[10]\,
      I1 => INT_MAX_FRAME_LENGTH(10),
      I2 => \n_0_FRAME_COUNT_reg[11]\,
      I3 => INT_MAX_FRAME_LENGTH(11),
      I4 => INT_MAX_FRAME_LENGTH(9),
      I5 => \n_0_FRAME_COUNT_reg[9]\,
      O => n_0_MAX_PKT_LEN_REACHED_i_7
    );
MAX_PKT_LEN_REACHED_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[6]\,
      I1 => INT_MAX_FRAME_LENGTH(6),
      I2 => \n_0_FRAME_COUNT_reg[7]\,
      I3 => INT_MAX_FRAME_LENGTH(7),
      I4 => INT_MAX_FRAME_LENGTH(8),
      I5 => \n_0_FRAME_COUNT_reg[8]\,
      O => n_0_MAX_PKT_LEN_REACHED_i_8
    );
MAX_PKT_LEN_REACHED_i_9: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => \n_0_FRAME_COUNT_reg[3]\,
      I1 => FRAME_MAX(3),
      I2 => \n_0_FRAME_COUNT_reg[4]\,
      I3 => FRAME_MAX(4),
      I4 => INT_MAX_FRAME_LENGTH(5),
      I5 => \n_0_FRAME_COUNT_reg[5]\,
      O => n_0_MAX_PKT_LEN_REACHED_i_9
    );
MAX_PKT_LEN_REACHED_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_MAX_PKT_LEN_REACHED_i_1,
      Q => \^o1\,
      R => \<const0>\
    );
MAX_PKT_LEN_REACHED_reg_i_2: unisim.vcomponents.CARRY4
    port map (
      CI => n_0_MAX_PKT_LEN_REACHED_reg_i_4,
      CO(3 downto 1) => NLW_MAX_PKT_LEN_REACHED_reg_i_2_CO_UNCONNECTED(3 downto 1),
      CO(0) => eqOp74_in,
      CYINIT => \<const0>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => NLW_MAX_PKT_LEN_REACHED_reg_i_2_O_UNCONNECTED(3 downto 0),
      S(3) => \<const0>\,
      S(2) => \<const0>\,
      S(1) => \<const0>\,
      S(0) => n_0_MAX_PKT_LEN_REACHED_i_5
    );
MAX_PKT_LEN_REACHED_reg_i_4: unisim.vcomponents.CARRY4
    port map (
      CI => \<const0>\,
      CO(3) => n_0_MAX_PKT_LEN_REACHED_reg_i_4,
      CO(2) => n_1_MAX_PKT_LEN_REACHED_reg_i_4,
      CO(1) => n_2_MAX_PKT_LEN_REACHED_reg_i_4,
      CO(0) => n_3_MAX_PKT_LEN_REACHED_reg_i_4,
      CYINIT => \<const1>\,
      DI(3) => \<const0>\,
      DI(2) => \<const0>\,
      DI(1) => \<const0>\,
      DI(0) => \<const0>\,
      O(3 downto 0) => NLW_MAX_PKT_LEN_REACHED_reg_i_4_O_UNCONNECTED(3 downto 0),
      S(3) => n_0_MAX_PKT_LEN_REACHED_i_7,
      S(2) => n_0_MAX_PKT_LEN_REACHED_i_8,
      S(1) => n_0_MAX_PKT_LEN_REACHED_i_9,
      S(0) => n_0_MAX_PKT_LEN_REACHED_i_10
    );
MIN_PKT_LEN_REACHED_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1101111111000000"
    )
    port map (
      I0 => I8,
      I1 => I9,
      I2 => \^o5\,
      I3 => \n_0_FRAME_COUNT_reg[6]\,
      I4 => tx_ce_sample,
      I5 => n_0_MIN_PKT_LEN_REACHED_reg,
      O => n_0_MIN_PKT_LEN_REACHED_i_1
    );
MIN_PKT_LEN_REACHED_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_MIN_PKT_LEN_REACHED_i_1,
      Q => n_0_MIN_PKT_LEN_REACHED_reg,
      R => \<const0>\
    );
NUMBER_OF_BYTES_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8AAA8AAA8AAA8A8"
    )
    port map (
      I0 => I10,
      I1 => \^q\(0),
      I2 => PAD_PIPE,
      I3 => CR178124_FIX,
      I4 => p_0_in8_in,
      I5 => CRC,
      O => NUMBER_OF_BYTES_PRE_REG
    );
PAD_PIPE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \^pad\,
      Q => PAD_PIPE,
      R => SR(0)
    );
PAD_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      I0 => n_0_FCS_reg,
      I1 => n_0_SCSH_reg,
      I2 => n_0_CFL_reg,
      I3 => \^o3\,
      O => PAD0
    );
PAD_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => PAD0,
      Q => \^pad\,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => PREAMBLE,
      Q => \n_0_PREAMBLE_PIPE_reg[0]\,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_PREAMBLE_PIPE_reg[9]\,
      Q => \n_0_PREAMBLE_PIPE_reg[10]\,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_PREAMBLE_PIPE_reg[10]\,
      Q => \n_0_PREAMBLE_PIPE_reg[11]\,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_PREAMBLE_PIPE_reg[11]\,
      Q => \n_0_PREAMBLE_PIPE_reg[12]\,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_PREAMBLE_PIPE_reg[12]\,
      Q => \^q\(1),
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_PREAMBLE_PIPE_reg[0]\,
      Q => \n_0_PREAMBLE_PIPE_reg[1]\,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_PREAMBLE_PIPE_reg[1]\,
      Q => \^q\(0),
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \^q\(0),
      Q => \n_0_PREAMBLE_PIPE_reg[3]\,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_PREAMBLE_PIPE_reg[3]\,
      Q => p_1_in4_in,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => p_1_in4_in,
      Q => p_0_in62_in,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => p_0_in62_in,
      Q => \n_0_PREAMBLE_PIPE_reg[6]\,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_PREAMBLE_PIPE_reg[6]\,
      Q => \n_0_PREAMBLE_PIPE_reg[7]\,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_PREAMBLE_PIPE_reg[7]\,
      Q => \n_0_PREAMBLE_PIPE_reg[8]\,
      R => SR(0)
    );
\PREAMBLE_PIPE_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_PREAMBLE_PIPE_reg[8]\,
      Q => \n_0_PREAMBLE_PIPE_reg[9]\,
      R => SR(0)
    );
PREAMBLE_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^o5\,
      I1 => \^o3\,
      O => PREAMBLE0
    );
PREAMBLE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => PREAMBLE0,
      Q => PREAMBLE,
      R => SR(0)
    );
\PRE_COUNT[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFF7A"
    )
    port map (
      I0 => \n_0_PRE_COUNT_reg[0]\,
      I1 => \^o5\,
      I2 => tx_ce_sample,
      I3 => I8,
      I4 => I9,
      O => \n_0_PRE_COUNT[0]_i_1\
    );
\PRE_COUNT[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF9FAA"
    )
    port map (
      I0 => p_0_in5_in,
      I1 => \n_0_PRE_COUNT_reg[0]\,
      I2 => \^o5\,
      I3 => tx_ce_sample,
      I4 => I8,
      I5 => I9,
      O => \n_0_PRE_COUNT[1]_i_1\
    );
\PRE_COUNT[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A9FFAAAAFFFFFFFF"
    )
    port map (
      I0 => \n_0_PRE_COUNT_reg[2]\,
      I1 => \n_0_PRE_COUNT_reg[0]\,
      I2 => p_0_in5_in,
      I3 => \^o5\,
      I4 => tx_ce_sample,
      I5 => I11,
      O => \n_0_PRE_COUNT[2]_i_1\
    );
\PRE_COUNT_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_PRE_COUNT[0]_i_1\,
      Q => \n_0_PRE_COUNT_reg[0]\,
      R => \<const0>\
    );
\PRE_COUNT_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_PRE_COUNT[1]_i_1\,
      Q => p_0_in5_in,
      R => \<const0>\
    );
\PRE_COUNT_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \n_0_PRE_COUNT[2]_i_1\,
      Q => \n_0_PRE_COUNT_reg[2]\,
      R => \<const0>\
    );
REG_DATA_VALID_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => int_tx_data_valid_out,
      Q => \^reg_data_valid\,
      R => SR(0)
    );
REG_PREAMBLE_DONE_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => p_0_in5_in,
      I1 => \n_0_PRE_COUNT_reg[0]\,
      I2 => \n_0_PRE_COUNT_reg[2]\,
      O => PREAMBLE_DONE
    );
REG_PREAMBLE_DONE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => PREAMBLE_DONE,
      Q => REG_PREAMBLE_DONE,
      R => SR(0)
    );
REG_PREAMBLE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => PREAMBLE,
      Q => REG_PREAMBLE,
      R => SR(0)
    );
REG_SCSH_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => n_0_SCSH_reg,
      Q => REG_SCSH,
      R => SR(0)
    );
REG_STATUS_VALID_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CEFF0000CC000000"
    )
    port map (
      I0 => n_0_REG_STATUS_VALID_i_2,
      I1 => INT_TX_STATUS_VALID,
      I2 => \^o3\,
      I3 => tx_ce_sample,
      I4 => I11,
      I5 => REG_STATUS_VALID,
      O => n_0_REG_STATUS_VALID_i_1
    );
REG_STATUS_VALID_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => n_0_INT_HALF_DUPLEX_reg,
      I1 => n_0_INT_SPEED_IS_10_100_reg,
      O => n_0_REG_STATUS_VALID_i_2
    );
REG_STATUS_VALID_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_REG_STATUS_VALID_i_1,
      Q => REG_STATUS_VALID,
      R => \<const0>\
    );
REG_TX_CONTROL_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
    port map (
      I0 => n_0_REG_TX_CONTROL_i_2,
      I1 => \n_0_LEN_reg[10]\,
      I2 => \n_0_LEN_reg[1]\,
      I3 => n_0_REG_TX_CONTROL_i_3,
      I4 => \n_0_LEN_reg[14]\,
      I5 => \n_0_LEN_reg[15]\,
      O => INT_TX_CONTROL
    );
REG_TX_CONTROL_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000020"
    )
    port map (
      I0 => p_2_in61_in,
      I1 => \n_0_LEN_reg[6]\,
      I2 => p_8_in,
      I3 => \n_0_LEN_reg[0]\,
      I4 => n_0_REG_TX_VLAN_i_3,
      O => n_0_REG_TX_CONTROL_i_2
    );
REG_TX_CONTROL_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      I0 => p_4_in,
      I1 => \n_0_LEN_reg[2]\,
      I2 => \n_0_LEN_reg[8]\,
      I3 => \n_0_LEN_reg[9]\,
      O => n_0_REG_TX_CONTROL_i_3
    );
REG_TX_CONTROL_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => INT_TX_CONTROL,
      Q => REG_TX_CONTROL,
      R => SR(0)
    );
REG_TX_VLAN_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
    port map (
      I0 => n_0_REG_TX_VLAN_i_2,
      I1 => \n_0_LEN_reg[10]\,
      I2 => \n_0_LEN_reg[1]\,
      I3 => n_0_REG_TX_VLAN_i_3,
      I4 => \n_0_LEN_reg[14]\,
      I5 => \n_0_LEN_reg[15]\,
      O => p_72_in
    );
REG_TX_VLAN_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000100000"
    )
    port map (
      I0 => p_8_in,
      I1 => \n_0_LEN_reg[6]\,
      I2 => \n_0_LEN_reg[0]\,
      I3 => p_2_in61_in,
      I4 => INT_VLAN_EN,
      I5 => n_0_REG_TX_CONTROL_i_3,
      O => n_0_REG_TX_VLAN_i_2
    );
REG_TX_VLAN_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => \n_0_LEN_reg[12]\,
      I1 => \n_0_LEN_reg[5]\,
      I2 => \n_0_LEN_reg[13]\,
      I3 => \n_0_LEN_reg[4]\,
      O => n_0_REG_TX_VLAN_i_3
    );
REG_TX_VLAN_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => p_72_in,
      Q => REG_TX_VLAN,
      R => SR(0)
    );
SCSH_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A2AAAAA0A0A0000"
    )
    port map (
      I0 => I11,
      I1 => \^o9\,
      I2 => \n_0_CORE_DOES_NO_HD_MIFG.MIFG_i_2\,
      I3 => \n_0_CORE_DOES_NO_HD_2.TX_OK_reg\,
      I4 => tx_ce_sample,
      I5 => n_0_SCSH_reg,
      O => n_0_SCSH_i_1
    );
SCSH_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_SCSH_i_1,
      Q => n_0_SCSH_reg,
      R => \<const0>\
    );
STATUS_VALID_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => INT_TX_STATUS_VALID,
      Q => tx_statistics_valid,
      R => SR(0)
    );
\STATUS_VECTOR_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => INT_TX_SUCCESS,
      Q => tx_statistics_vector(0),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][5]\,
      Q => tx_statistics_vector(10),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][6]\,
      Q => tx_statistics_vector(11),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][7]\,
      Q => tx_statistics_vector(12),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][8]\,
      Q => tx_statistics_vector(13),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][9]\,
      Q => tx_statistics_vector(14),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][10]\,
      Q => tx_statistics_vector(15),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][11]\,
      Q => tx_statistics_vector(16),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][12]\,
      Q => tx_statistics_vector(17),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][13]\,
      Q => tx_statistics_vector(18),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG_TX_VLAN,
      Q => tx_statistics_vector(19),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => INT_TX_BROADCAST,
      Q => tx_statistics_vector(1),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const0>\,
      Q => tx_statistics_vector(20),
      R => tx_ce_sample
    );
\STATUS_VECTOR_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const0>\,
      Q => tx_statistics_vector(21),
      R => tx_ce_sample
    );
\STATUS_VECTOR_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const0>\,
      Q => tx_statistics_vector(22),
      R => tx_ce_sample
    );
\STATUS_VECTOR_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const0>\,
      Q => tx_statistics_vector(23),
      R => tx_ce_sample
    );
\STATUS_VECTOR_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const0>\,
      Q => tx_statistics_vector(24),
      R => tx_ce_sample
    );
\STATUS_VECTOR_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const0>\,
      Q => tx_statistics_vector(25),
      R => tx_ce_sample
    );
\STATUS_VECTOR_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const0>\,
      Q => tx_statistics_vector(26),
      R => tx_ce_sample
    );
\STATUS_VECTOR_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const0>\,
      Q => tx_statistics_vector(27),
      R => tx_ce_sample
    );
\STATUS_VECTOR_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const0>\,
      Q => tx_statistics_vector(28),
      R => tx_ce_sample
    );
\STATUS_VECTOR_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const0>\,
      Q => tx_statistics_vector(29),
      R => tx_ce_sample
    );
\STATUS_VECTOR_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => INT_TX_MULTICAST,
      Q => tx_statistics_vector(2),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => n_0_INT_TX_UNDERRUN2_reg,
      Q => tx_statistics_vector(3),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG_TX_CONTROL,
      Q => tx_statistics_vector(4),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][0]\,
      Q => tx_statistics_vector(5),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][1]\,
      Q => tx_statistics_vector(6),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][2]\,
      Q => tx_statistics_vector(7),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][3]\,
      Q => tx_statistics_vector(8),
      R => \<const0>\
    );
\STATUS_VECTOR_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_BYTE_COUNT_reg[1][4]\,
      Q => tx_statistics_vector(9),
      R => \<const0>\
    );
STOP_MAX_PKT_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1101111111000000"
    )
    port map (
      I0 => I8,
      I1 => I9,
      I2 => \^o5\,
      I3 => \^o1\,
      I4 => tx_ce_sample,
      I5 => n_0_STOP_MAX_PKT_reg,
      O => n_0_STOP_MAX_PKT_i_1
    );
STOP_MAX_PKT_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_STOP_MAX_PKT_i_1,
      Q => n_0_STOP_MAX_PKT_reg,
      R => \<const0>\
    );
\TRANSMIT_PIPE_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => TRANSMIT,
      Q => \n_0_TRANSMIT_PIPE_reg[0]\,
      R => SR(0)
    );
\TRANSMIT_PIPE_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_TRANSMIT_PIPE_reg[0]\,
      Q => p_0_in8_in,
      R => SR(0)
    );
TRANSMIT_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000100"
    )
    port map (
      I0 => \^o2\,
      I1 => n_0_CFL_reg,
      I2 => \^o5\,
      I3 => \^o3\,
      I4 => CRC,
      O => TRANSMIT0
    );
TRANSMIT_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => TRANSMIT0,
      Q => TRANSMIT,
      R => SR(0)
    );
TX_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5DFF000055000000"
    )
    port map (
      I0 => n_0_TX_i_2,
      I1 => n_0_TX_i_3,
      I2 => n_0_CDS_reg,
      I3 => tx_ce_sample,
      I4 => I11,
      I5 => \^o3\,
      O => n_0_TX_i_1
    );
TX_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
    port map (
      I0 => \^o5\,
      I1 => \n_0_PRE_COUNT_reg[2]\,
      I2 => \n_0_PRE_COUNT_reg[0]\,
      I3 => p_0_in5_in,
      O => n_0_TX_i_2
    );
TX_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => n_0_CFL_reg,
      I1 => \^o2\,
      O => n_0_TX_i_3
    );
TX_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_TX_i_1,
      Q => \^o3\,
      R => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
ack_int_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => p_0_in5_in,
      I1 => \n_0_PRE_COUNT_reg[0]\,
      I2 => PREAMBLE,
      I3 => \n_0_PRE_COUNT_reg[2]\,
      O => int_tx_ack_in
    );
end_of_tx_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFBFBFBFFFFFFF"
    )
    port map (
      I0 => \^o4\,
      I1 => \^reg_data_valid\,
      I2 => \^o2\,
      I3 => I6,
      I4 => I7,
      I5 => data_avail_in_reg,
      O => O7
    );
mux_control_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFBFBF00000000"
    )
    port map (
      I0 => \^o4\,
      I1 => \^reg_data_valid\,
      I2 => \^o2\,
      I3 => I6,
      I4 => I7,
      I5 => data_avail_in_reg,
      O => O8
    );
tx_er_reg1_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F222F222F2220000"
    )
    port map (
      I0 => tx_underrun_int,
      I1 => I7,
      I2 => \^o2\,
      I3 => \^o1\,
      I4 => PREAMBLE_DONE,
      I5 => \^o3\,
      O => int_gmii_tx_er
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACTriMAC_clk_en_gen is
  port (
    speedis100 : out STD_LOGIC;
    tx_enable : out STD_LOGIC;
    phy_tx_enable : out STD_LOGIC;
    counter0 : out STD_LOGIC;
    clk_div5 : out STD_LOGIC;
    clk_div5_shift : out STD_LOGIC;
    O1 : out STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    speedis10100 : in STD_LOGIC;
    I1 : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 1 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end TriMACTriMAC_clk_en_gen;

architecture STRUCTURE of TriMACTriMAC_clk_en_gen is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal client_tx_enable0 : STD_LOGIC;
  signal clk_div5_int : STD_LOGIC;
  signal clk_div5_shift_int : STD_LOGIC;
  signal \^counter0\ : STD_LOGIC;
  signal \counter_reg__0\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal div_2 : STD_LOGIC;
  signal n_0_clk_div5_int_i_1 : STD_LOGIC;
  signal n_0_clk_div5_int_i_2 : STD_LOGIC;
  signal n_0_clk_div5_int_i_3 : STD_LOGIC;
  signal n_0_clk_div5_int_i_4 : STD_LOGIC;
  signal n_0_clk_div5_int_i_5 : STD_LOGIC;
  signal n_0_clk_div5_int_i_6 : STD_LOGIC;
  signal n_0_clk_div5_shift_int_i_1 : STD_LOGIC;
  signal n_0_div_2_i_1 : STD_LOGIC;
  signal n_0_phy_tx_enable_falling_i_1 : STD_LOGIC;
  signal n_0_phy_tx_enable_falling_i_2 : STD_LOGIC;
  signal n_0_phy_tx_enable_falling_i_3 : STD_LOGIC;
  signal n_0_phy_tx_enable_i_2 : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \^phy_tx_enable\ : STD_LOGIC;
  signal phy_tx_enable_falling : STD_LOGIC;
  signal speed_is_100_int : STD_LOGIC;
  signal speed_is_10_100_int : STD_LOGIC;
  signal \^speedis100\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of clk_div5_int_i_5 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of clk_div5_int_i_6 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of control_enable_i_1 : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \counter[1]_i_1__0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \counter[2]_i_1__0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \counter[3]_i_1__0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \counter[4]_i_1__0\ : label is "soft_lutpair2";
  attribute counter : integer;
  attribute counter of \counter_reg[0]\ : label is 13;
  attribute counter of \counter_reg[1]\ : label is 13;
  attribute counter of \counter_reg[2]\ : label is 13;
  attribute counter of \counter_reg[3]\ : label is 13;
  attribute counter of \counter_reg[4]\ : label is 13;
  attribute counter of \counter_reg[5]\ : label is 13;
  attribute SOFT_HLUTNM of phy_tx_enable_falling_i_2 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of phy_tx_enable_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of speedis100_INST_0 : label is "soft_lutpair3";
  attribute DEPTH : integer;
  attribute DEPTH of txspeedis100gen : label is 5;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of txspeedis100gen : label is true;
  attribute INITIALISE : string;
  attribute INITIALISE of txspeedis100gen : label is "1'b0";
  attribute DEPTH of txspeedis10100gen : label is 5;
  attribute DONT_TOUCH of txspeedis10100gen : label is true;
  attribute INITIALISE of txspeedis10100gen : label is "1'b0";
begin
  counter0 <= \^counter0\;
  phy_tx_enable <= \^phy_tx_enable\;
  speedis100 <= \^speedis100\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
client_tx_enable_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => \^counter0\,
      I1 => div_2,
      O => client_tx_enable0
    );
client_tx_enable_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => client_tx_enable0,
      Q => tx_enable,
      R => I1
    );
clk_div5_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F0001000E000000"
    )
    port map (
      I0 => n_0_clk_div5_int_i_2,
      I1 => n_0_clk_div5_int_i_3,
      I2 => I1,
      I3 => speed_is_10_100_int,
      I4 => \^counter0\,
      I5 => clk_div5_int,
      O => n_0_clk_div5_int_i_1
    );
clk_div5_int_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAABAEFAAAAAAAA"
    )
    port map (
      I0 => \^counter0\,
      I1 => speed_is_100_int,
      I2 => speed_is_10_100_int,
      I3 => \counter_reg__0\(4),
      I4 => n_0_clk_div5_int_i_4,
      I5 => n_0_clk_div5_int_i_5,
      O => n_0_clk_div5_int_i_2
    );
clk_div5_int_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000080051"
    )
    port map (
      I0 => \counter_reg__0\(3),
      I1 => speed_is_10_100_int,
      I2 => speed_is_100_int,
      I3 => \counter_reg__0\(5),
      I4 => \counter_reg__0\(4),
      I5 => n_0_clk_div5_int_i_6,
      O => n_0_clk_div5_int_i_3
    );
clk_div5_int_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFEEFFFFEEFFFEFE"
    )
    port map (
      I0 => \counter_reg__0\(5),
      I1 => \counter_reg__0\(3),
      I2 => \counter_reg__0\(0),
      I3 => speed_is_100_int,
      I4 => speed_is_10_100_int,
      I5 => \counter_reg__0\(2),
      O => n_0_clk_div5_int_i_4
    );
clk_div5_int_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6033"
    )
    port map (
      I0 => speed_is_100_int,
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(0),
      I3 => speed_is_10_100_int,
      O => n_0_clk_div5_int_i_5
    );
clk_div5_int_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFBEEE"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      I2 => speed_is_10_100_int,
      I3 => speed_is_100_int,
      I4 => \counter_reg__0\(2),
      O => n_0_clk_div5_int_i_6
    );
clk_div5_int_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_clk_div5_int_i_1,
      Q => clk_div5_int,
      R => \<const0>\
    );
clk_div5_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => clk_div5_int,
      Q => clk_div5,
      R => I1
    );
clk_div5_shift_int_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0B0F0A0F"
    )
    port map (
      I0 => n_0_clk_div5_int_i_2,
      I1 => n_0_clk_div5_int_i_3,
      I2 => I1,
      I3 => speed_is_10_100_int,
      I4 => clk_div5_shift_int,
      O => n_0_clk_div5_shift_int_i_1
    );
clk_div5_shift_int_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_clk_div5_shift_int_i_1,
      Q => clk_div5_shift_int,
      R => \<const0>\
    );
clk_div5_shift_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => clk_div5_shift_int,
      Q => clk_div5_shift,
      R => I1
    );
control_enable_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => \^phy_tx_enable\,
      I1 => phy_tx_enable_falling,
      I2 => tx_configuration_vector(1),
      I3 => I1,
      O => O1
    );
\counter[0]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \counter_reg__0\(0),
      O => p_0_in(0)
    );
\counter[1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      O => p_0_in(1)
    );
\counter[2]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => \counter_reg__0\(2),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(0),
      O => p_0_in(2)
    );
\counter[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => \counter_reg__0\(3),
      I1 => \counter_reg__0\(2),
      I2 => \counter_reg__0\(0),
      I3 => \counter_reg__0\(1),
      O => p_0_in(3)
    );
\counter[4]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => \counter_reg__0\(4),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(0),
      I3 => \counter_reg__0\(2),
      I4 => \counter_reg__0\(3),
      O => p_0_in(4)
    );
\counter[5]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => \counter_reg__0\(5),
      I1 => \counter_reg__0\(3),
      I2 => \counter_reg__0\(2),
      I3 => \counter_reg__0\(0),
      I4 => \counter_reg__0\(1),
      I5 => \counter_reg__0\(4),
      O => p_0_in(5)
    );
\counter_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => p_0_in(0),
      Q => \counter_reg__0\(0),
      R => SR(0)
    );
\counter_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => p_0_in(1),
      Q => \counter_reg__0\(1),
      R => SR(0)
    );
\counter_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => p_0_in(2),
      Q => \counter_reg__0\(2),
      R => SR(0)
    );
\counter_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => p_0_in(3),
      Q => \counter_reg__0\(3),
      R => SR(0)
    );
\counter_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => p_0_in(4),
      Q => \counter_reg__0\(4),
      R => SR(0)
    );
\counter_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => p_0_in(5),
      Q => \counter_reg__0\(5),
      R => SR(0)
    );
div_2_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0060"
    )
    port map (
      I0 => div_2,
      I1 => \^counter0\,
      I2 => speed_is_10_100_int,
      I3 => I1,
      O => n_0_div_2_i_1
    );
div_2_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_div_2_i_1,
      Q => div_2,
      R => \<const0>\
    );
phy_tx_enable_falling_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBBBBBBBBB8B888"
    )
    port map (
      I0 => phy_tx_enable_falling,
      I1 => I1,
      I2 => \counter_reg__0\(4),
      I3 => n_0_phy_tx_enable_falling_i_2,
      I4 => n_0_phy_tx_enable_falling_i_3,
      I5 => \counter_reg__0\(5),
      O => n_0_phy_tx_enable_falling_i_1
    );
phy_tx_enable_falling_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => speed_is_100_int,
      I1 => speed_is_10_100_int,
      O => n_0_phy_tx_enable_falling_i_2
    );
phy_tx_enable_falling_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFE80FFFF"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(2),
      I3 => speed_is_100_int,
      I4 => speed_is_10_100_int,
      I5 => \counter_reg__0\(3),
      O => n_0_phy_tx_enable_falling_i_3
    );
phy_tx_enable_falling_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_phy_tx_enable_falling_i_1,
      Q => phy_tx_enable_falling,
      R => \<const0>\
    );
phy_tx_enable_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFBBBB0B"
    )
    port map (
      I0 => speed_is_100_int,
      I1 => speed_is_10_100_int,
      I2 => n_0_phy_tx_enable_i_2,
      I3 => \counter_reg__0\(4),
      I4 => \counter_reg__0\(5),
      O => \^counter0\
    );
phy_tx_enable_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000050005100"
    )
    port map (
      I0 => \counter_reg__0\(3),
      I1 => \counter_reg__0\(1),
      I2 => speed_is_100_int,
      I3 => speed_is_10_100_int,
      I4 => \counter_reg__0\(0),
      I5 => \counter_reg__0\(2),
      O => n_0_phy_tx_enable_i_2
    );
phy_tx_enable_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => \^counter0\,
      Q => \^phy_tx_enable\,
      R => I1
    );
speedis100_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => tx_configuration_vector(0),
      I1 => tx_configuration_vector(1),
      O => \^speedis100\
    );
txspeedis100gen: entity work.\TriMACTriMAC_block_sync_block__2\
    port map (
      clk => gtx_clk,
      data_in => \^speedis100\,
      data_out => speed_is_100_int
    );
txspeedis10100gen: entity work.\TriMACTriMAC_block_sync_block__1\
    port map (
      clk => gtx_clk,
      data_in => speedis10100,
      data_out => speed_is_10_100_int
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_addr_filter is
  port (
    p_10_out : out STD_LOGIC;
    p_6_out : out STD_LOGIC;
    p_5_out : out STD_LOGIC;
    p_4_out : out STD_LOGIC;
    p_3_out : out STD_LOGIC;
    p_2_out : out STD_LOGIC;
    p_1_out : out STD_LOGIC;
    p_0_out : out STD_LOGIC;
    O1 : out STD_LOGIC;
    p_9_out : out STD_LOGIC;
    p_8_out : out STD_LOGIC;
    p_7_out : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    address_valid_early : out STD_LOGIC;
    pauseaddressmatch : out STD_LOGIC;
    broadcastaddressmatch : out STD_LOGIC;
    specialpauseaddressmatch : out STD_LOGIC;
    broadcast_byte_match : out STD_LOGIC;
    update_pause_ad_sync_reg : out STD_LOGIC;
    data_out : out STD_LOGIC;
    MATCH_FRAME_INT0 : out STD_LOGIC;
    rxstatsaddressmatch : out STD_LOGIC;
    I2 : in STD_LOGIC;
    data_valid_early : in STD_LOGIC;
    I1 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    pause_match_reg0 : in STD_LOGIC;
    special_pause_match_comb : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    I5 : in STD_LOGIC;
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 48 downto 0 );
    I6 : in STD_LOGIC;
    I7 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end TriMACtri_mode_ethernet_mac_v8_1_addr_filter;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_addr_filter is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^o6\ : STD_LOGIC;
  signal address_match0 : STD_LOGIC;
  signal address_match1 : STD_LOGIC;
  signal \^address_valid_early\ : STD_LOGIC;
  signal \^broadcast_byte_match\ : STD_LOGIC;
  signal \^broadcastaddressmatch\ : STD_LOGIC;
  signal broadcastaddressmatch_int : STD_LOGIC;
  signal broadcastaddressmatch_int_0 : STD_LOGIC;
  signal \counter_reg__0\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal load_count : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal load_wr : STD_LOGIC;
  signal load_wr_data : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal n_0_address_match_i_1 : STD_LOGIC;
  signal n_0_address_match_i_4 : STD_LOGIC;
  signal n_0_address_match_reg : STD_LOGIC;
  signal n_0_broadcast_match_i_1 : STD_LOGIC;
  signal n_0_broadcast_match_reg : STD_LOGIC;
  signal \n_0_counter[5]_i_2\ : STD_LOGIC;
  signal \n_0_load_count[0]_i_1\ : STD_LOGIC;
  signal \n_0_load_count[1]_i_1\ : STD_LOGIC;
  signal \n_0_load_count[2]_i_1\ : STD_LOGIC;
  signal \n_0_load_count_pipe_reg[0]\ : STD_LOGIC;
  signal \n_0_load_count_pipe_reg[1]\ : STD_LOGIC;
  signal \n_0_load_count_pipe_reg[2]\ : STD_LOGIC;
  signal \n_0_load_wr_data[0]_i_2\ : STD_LOGIC;
  signal \n_0_load_wr_data[0]_i_3\ : STD_LOGIC;
  signal \n_0_load_wr_data[1]_i_2\ : STD_LOGIC;
  signal \n_0_load_wr_data[1]_i_3\ : STD_LOGIC;
  signal \n_0_load_wr_data[2]_i_2\ : STD_LOGIC;
  signal \n_0_load_wr_data[2]_i_3\ : STD_LOGIC;
  signal \n_0_load_wr_data[3]_i_2\ : STD_LOGIC;
  signal \n_0_load_wr_data[3]_i_3\ : STD_LOGIC;
  signal \n_0_load_wr_data[4]_i_2\ : STD_LOGIC;
  signal \n_0_load_wr_data[4]_i_3\ : STD_LOGIC;
  signal \n_0_load_wr_data[5]_i_2\ : STD_LOGIC;
  signal \n_0_load_wr_data[5]_i_3\ : STD_LOGIC;
  signal \n_0_load_wr_data[6]_i_2\ : STD_LOGIC;
  signal \n_0_load_wr_data[6]_i_3\ : STD_LOGIC;
  signal \n_0_load_wr_data[7]_i_2\ : STD_LOGIC;
  signal \n_0_load_wr_data[7]_i_3\ : STD_LOGIC;
  signal \n_0_load_wr_data_reg[0]\ : STD_LOGIC;
  signal \n_0_load_wr_data_reg[1]\ : STD_LOGIC;
  signal \n_0_load_wr_data_reg[2]\ : STD_LOGIC;
  signal \n_0_load_wr_data_reg[3]\ : STD_LOGIC;
  signal \n_0_load_wr_data_reg[4]\ : STD_LOGIC;
  signal \n_0_load_wr_data_reg[5]\ : STD_LOGIC;
  signal \n_0_load_wr_data_reg[6]\ : STD_LOGIC;
  signal \n_0_load_wr_data_reg[7]\ : STD_LOGIC;
  signal n_0_pause_match_i_1 : STD_LOGIC;
  signal n_0_pause_match_reg : STD_LOGIC;
  signal n_0_resync_promiscuous_mode : STD_LOGIC;
  signal n_0_rx_ptp_match_i_1 : STD_LOGIC;
  signal n_0_rxstatsaddressmatch_i_1 : STD_LOGIC;
  signal n_0_special_pause_match_i_1 : STD_LOGIC;
  signal n_0_special_pause_match_reg : STD_LOGIC;
  signal n_1_sync_update : STD_LOGIC;
  signal n_2_sync_update : STD_LOGIC;
  signal \p_0_in__2\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \pause_match_reg__0\ : STD_LOGIC;
  signal \^pauseaddressmatch\ : STD_LOGIC;
  signal pauseaddressmatch_int : STD_LOGIC;
  signal rx_data_valid_reg2 : STD_LOGIC;
  signal rx_data_valid_srl16 : STD_LOGIC;
  signal rx_data_valid_srl16_reg1 : STD_LOGIC;
  signal rx_data_valid_srl16_reg2 : STD_LOGIC;
  signal rx_filter_match_comb2 : STD_LOGIC;
  signal rx_filtered_data_valid0 : STD_LOGIC;
  signal rx_ptp_match : STD_LOGIC;
  signal \^rxstatsaddressmatch\ : STD_LOGIC;
  signal \special_pause_match_reg__0\ : STD_LOGIC;
  signal \^specialpauseaddressmatch\ : STD_LOGIC;
  signal specialpauseaddressmatch_int : STD_LOGIC;
  signal \^update_pause_ad_sync_reg\ : STD_LOGIC;
  signal \NLW_byte_wide_ram[0].header_field_dist_ram_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_byte_wide_ram[1].header_field_dist_ram_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_byte_wide_ram[2].header_field_dist_ram_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_byte_wide_ram[3].header_field_dist_ram_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_byte_wide_ram[4].header_field_dist_ram_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_byte_wide_ram[5].header_field_dist_ram_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_byte_wide_ram[6].header_field_dist_ram_SPO_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_byte_wide_ram[7].header_field_dist_ram_SPO_UNCONNECTED\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of address_match_i_4 : label is "soft_lutpair67";
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \byte_wide_ram[0].header_field_dist_ram\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \byte_wide_ram[1].header_field_dist_ram\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \byte_wide_ram[2].header_field_dist_ram\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \byte_wide_ram[3].header_field_dist_ram\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \byte_wide_ram[4].header_field_dist_ram\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \byte_wide_ram[5].header_field_dist_ram\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \byte_wide_ram[6].header_field_dist_ram\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \byte_wide_ram[7].header_field_dist_ram\ : label is "PRIMITIVE";
  attribute RETAIN_INVERTER : boolean;
  attribute RETAIN_INVERTER of \counter[0]_i_1\ : label is true;
  attribute SOFT_HLUTNM of \counter[0]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \counter[1]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \counter[2]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \counter[3]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \counter[4]_i_1\ : label is "soft_lutpair66";
  attribute counter : integer;
  attribute counter of \counter_reg[0]\ : label is 12;
  attribute counter of \counter_reg[1]\ : label is 12;
  attribute counter of \counter_reg[2]\ : label is 12;
  attribute counter of \counter_reg[3]\ : label is 12;
  attribute counter of \counter_reg[4]\ : label is 12;
  attribute counter of \counter_reg[5]\ : label is 12;
  attribute BOX_TYPE of delay_rx_data_valid : label is "PRIMITIVE";
  attribute srl_name : string;
  attribute srl_name of delay_rx_data_valid : label is "inst/\TriMAC_core/addr_filter_top/address_filter_inst/delay_rx_data_valid ";
  attribute SOFT_HLUTNM of \load_count[1]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \load_count[2]_i_1\ : label is "soft_lutpair68";
  attribute BOX_TYPE of \special_pause_address[0].LUT3_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \special_pause_address[1].LUT3_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \special_pause_address[2].LUT3_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \special_pause_address[3].LUT3_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \special_pause_address[4].LUT3_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \special_pause_address[5].LUT3_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \special_pause_address[6].LUT3_special_pause_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \special_pause_address[7].LUT3_special_pause_inst\ : label is "PRIMITIVE";
begin
  O6 <= \^o6\;
  address_valid_early <= \^address_valid_early\;
  broadcast_byte_match <= \^broadcast_byte_match\;
  broadcastaddressmatch <= \^broadcastaddressmatch\;
  pauseaddressmatch <= \^pauseaddressmatch\;
  rxstatsaddressmatch <= \^rxstatsaddressmatch\;
  specialpauseaddressmatch <= \^specialpauseaddressmatch\;
  update_pause_ad_sync_reg <= \^update_pause_ad_sync_reg\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
MATCH_FRAME_INT_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
    port map (
      I0 => \^pauseaddressmatch\,
      I1 => \^specialpauseaddressmatch\,
      I2 => rx_filter_match_comb2,
      I3 => \^broadcastaddressmatch\,
      I4 => rx_ptp_match,
      O => MATCH_FRAME_INT0
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
address_match_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => SR(0),
      I1 => rx_data_valid_reg2,
      I2 => \^o6\,
      I3 => I2,
      O => n_0_address_match_i_1
    );
address_match_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000020"
    )
    port map (
      I0 => n_0_address_match_i_4,
      I1 => \counter_reg__0\(5),
      I2 => I2,
      I3 => \counter_reg__0\(3),
      I4 => \counter_reg__0\(4),
      O => broadcastaddressmatch_int_0
    );
address_match_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => n_0_pause_match_reg,
      I1 => n_0_special_pause_match_reg,
      I2 => n_0_broadcast_match_reg,
      I3 => address_match1,
      O => address_match0
    );
address_match_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \counter_reg__0\(2),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(0),
      O => n_0_address_match_i_4
    );
address_match_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => broadcastaddressmatch_int_0,
      D => address_match0,
      Q => n_0_address_match_reg,
      R => n_0_address_match_i_1
    );
broadcast_byte_match_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => I3,
      Q => \^broadcast_byte_match\,
      R => \<const0>\
    );
broadcast_match_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000F0F02000000"
    )
    port map (
      I0 => \^o6\,
      I1 => rx_data_valid_reg2,
      I2 => SR(0),
      I3 => \^broadcast_byte_match\,
      I4 => I2,
      I5 => n_0_broadcast_match_reg,
      O => n_0_broadcast_match_i_1
    );
broadcast_match_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_broadcast_match_i_1,
      Q => n_0_broadcast_match_reg,
      R => \<const0>\
    );
broadcastaddressmatch_int_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => broadcastaddressmatch_int_0,
      D => n_0_broadcast_match_reg,
      Q => broadcastaddressmatch_int,
      R => n_0_address_match_i_1
    );
broadcastaddressmatch_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => broadcastaddressmatch_int,
      Q => \^broadcastaddressmatch\,
      R => SR(0)
    );
\byte_wide_ram[0].header_field_dist_ram\: unisim.vcomponents.RAM64X1D
    generic map(
      INIT => X"0000000000000000",
      IS_WCLK_INVERTED => '0'
    )
    port map (
      A0 => \n_0_load_count_pipe_reg[0]\,
      A1 => \n_0_load_count_pipe_reg[1]\,
      A2 => \n_0_load_count_pipe_reg[2]\,
      A3 => \<const0>\,
      A4 => \<const0>\,
      A5 => \<const0>\,
      D => \n_0_load_wr_data_reg[0]\,
      DPO => p_10_out,
      DPRA0 => \counter_reg__0\(0),
      DPRA1 => \counter_reg__0\(1),
      DPRA2 => \counter_reg__0\(2),
      DPRA3 => \counter_reg__0\(3),
      DPRA4 => \counter_reg__0\(4),
      DPRA5 => \counter_reg__0\(5),
      SPO => \NLW_byte_wide_ram[0].header_field_dist_ram_SPO_UNCONNECTED\,
      WCLK => I1,
      WE => load_wr
    );
\byte_wide_ram[1].header_field_dist_ram\: unisim.vcomponents.RAM64X1D
    generic map(
      INIT => X"0000000000000000",
      IS_WCLK_INVERTED => '0'
    )
    port map (
      A0 => \n_0_load_count_pipe_reg[0]\,
      A1 => \n_0_load_count_pipe_reg[1]\,
      A2 => \n_0_load_count_pipe_reg[2]\,
      A3 => \<const0>\,
      A4 => \<const0>\,
      A5 => \<const0>\,
      D => \n_0_load_wr_data_reg[1]\,
      DPO => p_6_out,
      DPRA0 => \counter_reg__0\(0),
      DPRA1 => \counter_reg__0\(1),
      DPRA2 => \counter_reg__0\(2),
      DPRA3 => \counter_reg__0\(3),
      DPRA4 => \counter_reg__0\(4),
      DPRA5 => \counter_reg__0\(5),
      SPO => \NLW_byte_wide_ram[1].header_field_dist_ram_SPO_UNCONNECTED\,
      WCLK => I1,
      WE => load_wr
    );
\byte_wide_ram[2].header_field_dist_ram\: unisim.vcomponents.RAM64X1D
    generic map(
      INIT => X"0000000000000000",
      IS_WCLK_INVERTED => '0'
    )
    port map (
      A0 => \n_0_load_count_pipe_reg[0]\,
      A1 => \n_0_load_count_pipe_reg[1]\,
      A2 => \n_0_load_count_pipe_reg[2]\,
      A3 => \<const0>\,
      A4 => \<const0>\,
      A5 => \<const0>\,
      D => \n_0_load_wr_data_reg[2]\,
      DPO => p_5_out,
      DPRA0 => \counter_reg__0\(0),
      DPRA1 => \counter_reg__0\(1),
      DPRA2 => \counter_reg__0\(2),
      DPRA3 => \counter_reg__0\(3),
      DPRA4 => \counter_reg__0\(4),
      DPRA5 => \counter_reg__0\(5),
      SPO => \NLW_byte_wide_ram[2].header_field_dist_ram_SPO_UNCONNECTED\,
      WCLK => I1,
      WE => load_wr
    );
\byte_wide_ram[3].header_field_dist_ram\: unisim.vcomponents.RAM64X1D
    generic map(
      INIT => X"0000000000000000",
      IS_WCLK_INVERTED => '0'
    )
    port map (
      A0 => \n_0_load_count_pipe_reg[0]\,
      A1 => \n_0_load_count_pipe_reg[1]\,
      A2 => \n_0_load_count_pipe_reg[2]\,
      A3 => \<const0>\,
      A4 => \<const0>\,
      A5 => \<const0>\,
      D => \n_0_load_wr_data_reg[3]\,
      DPO => p_4_out,
      DPRA0 => \counter_reg__0\(0),
      DPRA1 => \counter_reg__0\(1),
      DPRA2 => \counter_reg__0\(2),
      DPRA3 => \counter_reg__0\(3),
      DPRA4 => \counter_reg__0\(4),
      DPRA5 => \counter_reg__0\(5),
      SPO => \NLW_byte_wide_ram[3].header_field_dist_ram_SPO_UNCONNECTED\,
      WCLK => I1,
      WE => load_wr
    );
\byte_wide_ram[4].header_field_dist_ram\: unisim.vcomponents.RAM64X1D
    generic map(
      INIT => X"0000000000000000",
      IS_WCLK_INVERTED => '0'
    )
    port map (
      A0 => \n_0_load_count_pipe_reg[0]\,
      A1 => \n_0_load_count_pipe_reg[1]\,
      A2 => \n_0_load_count_pipe_reg[2]\,
      A3 => \<const0>\,
      A4 => \<const0>\,
      A5 => \<const0>\,
      D => \n_0_load_wr_data_reg[4]\,
      DPO => p_3_out,
      DPRA0 => \counter_reg__0\(0),
      DPRA1 => \counter_reg__0\(1),
      DPRA2 => \counter_reg__0\(2),
      DPRA3 => \counter_reg__0\(3),
      DPRA4 => \counter_reg__0\(4),
      DPRA5 => \counter_reg__0\(5),
      SPO => \NLW_byte_wide_ram[4].header_field_dist_ram_SPO_UNCONNECTED\,
      WCLK => I1,
      WE => load_wr
    );
\byte_wide_ram[5].header_field_dist_ram\: unisim.vcomponents.RAM64X1D
    generic map(
      INIT => X"0000000000000000",
      IS_WCLK_INVERTED => '0'
    )
    port map (
      A0 => \n_0_load_count_pipe_reg[0]\,
      A1 => \n_0_load_count_pipe_reg[1]\,
      A2 => \n_0_load_count_pipe_reg[2]\,
      A3 => \<const0>\,
      A4 => \<const0>\,
      A5 => \<const0>\,
      D => \n_0_load_wr_data_reg[5]\,
      DPO => p_2_out,
      DPRA0 => \counter_reg__0\(0),
      DPRA1 => \counter_reg__0\(1),
      DPRA2 => \counter_reg__0\(2),
      DPRA3 => \counter_reg__0\(3),
      DPRA4 => \counter_reg__0\(4),
      DPRA5 => \counter_reg__0\(5),
      SPO => \NLW_byte_wide_ram[5].header_field_dist_ram_SPO_UNCONNECTED\,
      WCLK => I1,
      WE => load_wr
    );
\byte_wide_ram[6].header_field_dist_ram\: unisim.vcomponents.RAM64X1D
    generic map(
      INIT => X"0000000000000000",
      IS_WCLK_INVERTED => '0'
    )
    port map (
      A0 => \n_0_load_count_pipe_reg[0]\,
      A1 => \n_0_load_count_pipe_reg[1]\,
      A2 => \n_0_load_count_pipe_reg[2]\,
      A3 => \<const0>\,
      A4 => \<const0>\,
      A5 => \<const0>\,
      D => \n_0_load_wr_data_reg[6]\,
      DPO => p_1_out,
      DPRA0 => \counter_reg__0\(0),
      DPRA1 => \counter_reg__0\(1),
      DPRA2 => \counter_reg__0\(2),
      DPRA3 => \counter_reg__0\(3),
      DPRA4 => \counter_reg__0\(4),
      DPRA5 => \counter_reg__0\(5),
      SPO => \NLW_byte_wide_ram[6].header_field_dist_ram_SPO_UNCONNECTED\,
      WCLK => I1,
      WE => load_wr
    );
\byte_wide_ram[7].header_field_dist_ram\: unisim.vcomponents.RAM64X1D
    generic map(
      INIT => X"0000000000000000",
      IS_WCLK_INVERTED => '0'
    )
    port map (
      A0 => \n_0_load_count_pipe_reg[0]\,
      A1 => \n_0_load_count_pipe_reg[1]\,
      A2 => \n_0_load_count_pipe_reg[2]\,
      A3 => \<const0>\,
      A4 => \<const0>\,
      A5 => \<const0>\,
      D => \n_0_load_wr_data_reg[7]\,
      DPO => p_0_out,
      DPRA0 => \counter_reg__0\(0),
      DPRA1 => \counter_reg__0\(1),
      DPRA2 => \counter_reg__0\(2),
      DPRA3 => \counter_reg__0\(3),
      DPRA4 => \counter_reg__0\(4),
      DPRA5 => \counter_reg__0\(5),
      SPO => \NLW_byte_wide_ram[7].header_field_dist_ram_SPO_UNCONNECTED\,
      WCLK => I1,
      WE => load_wr
    );
\counter[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \counter_reg__0\(0),
      O => \p_0_in__2\(0)
    );
\counter[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      O => \p_0_in__2\(1)
    );
\counter[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => \counter_reg__0\(2),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(0),
      O => \p_0_in__2\(2)
    );
\counter[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => \counter_reg__0\(3),
      I1 => \counter_reg__0\(0),
      I2 => \counter_reg__0\(1),
      I3 => \counter_reg__0\(2),
      O => \p_0_in__2\(3)
    );
\counter[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => \counter_reg__0\(4),
      I1 => \counter_reg__0\(2),
      I2 => \counter_reg__0\(1),
      I3 => \counter_reg__0\(0),
      I4 => \counter_reg__0\(3),
      O => \p_0_in__2\(4)
    );
\counter[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF000000000000"
    )
    port map (
      I0 => \counter_reg__0\(4),
      I1 => n_0_address_match_i_4,
      I2 => \counter_reg__0\(3),
      I3 => \counter_reg__0\(5),
      I4 => data_valid_early,
      I5 => I2,
      O => \n_0_counter[5]_i_2\
    );
\counter[5]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => \counter_reg__0\(5),
      I1 => \counter_reg__0\(3),
      I2 => \counter_reg__0\(0),
      I3 => \counter_reg__0\(1),
      I4 => \counter_reg__0\(2),
      I5 => \counter_reg__0\(4),
      O => \p_0_in__2\(5)
    );
\counter_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_counter[5]_i_2\,
      D => \p_0_in__2\(0),
      Q => \counter_reg__0\(0),
      R => I7(0)
    );
\counter_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_counter[5]_i_2\,
      D => \p_0_in__2\(1),
      Q => \counter_reg__0\(1),
      R => I7(0)
    );
\counter_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_counter[5]_i_2\,
      D => \p_0_in__2\(2),
      Q => \counter_reg__0\(2),
      R => I7(0)
    );
\counter_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_counter[5]_i_2\,
      D => \p_0_in__2\(3),
      Q => \counter_reg__0\(3),
      R => I7(0)
    );
\counter_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_counter[5]_i_2\,
      D => \p_0_in__2\(4),
      Q => \counter_reg__0\(4),
      R => I7(0)
    );
\counter_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \n_0_counter[5]_i_2\,
      D => \p_0_in__2\(5),
      Q => \counter_reg__0\(5),
      R => I7(0)
    );
delay_rx_data_valid: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => data_valid_early,
      Q => rx_data_valid_srl16
    );
\load_count[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"D3"
    )
    port map (
      I0 => load_count(1),
      I1 => load_count(0),
      I2 => load_count(2),
      O => \n_0_load_count[0]_i_1\
    );
\load_count[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A6"
    )
    port map (
      I0 => load_count(1),
      I1 => load_count(0),
      I2 => load_count(2),
      O => \n_0_load_count[1]_i_1\
    );
\load_count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F8"
    )
    port map (
      I0 => load_count(1),
      I1 => load_count(0),
      I2 => load_count(2),
      O => \n_0_load_count[2]_i_1\
    );
\load_count_pipe_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => load_count(0),
      Q => \n_0_load_count_pipe_reg[0]\,
      R => I6
    );
\load_count_pipe_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => load_count(1),
      Q => \n_0_load_count_pipe_reg[1]\,
      R => I6
    );
\load_count_pipe_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => load_count(2),
      Q => \n_0_load_count_pipe_reg[2]\,
      R => I6
    );
\load_count_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_load_count[0]_i_1\,
      Q => load_count(0),
      R => I6
    );
\load_count_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_load_count[1]_i_1\,
      Q => load_count(1),
      R => I6
    );
\load_count_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => \n_0_load_count[2]_i_1\,
      Q => load_count(2),
      R => I6
    );
\load_wr_data[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => rx_configuration_vector(25),
      I1 => rx_configuration_vector(17),
      I2 => load_count(1),
      I3 => rx_configuration_vector(9),
      I4 => load_count(0),
      I5 => rx_configuration_vector(1),
      O => \n_0_load_wr_data[0]_i_2\
    );
\load_wr_data[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rx_configuration_vector(1),
      I1 => load_count(1),
      I2 => rx_configuration_vector(41),
      I3 => load_count(0),
      I4 => rx_configuration_vector(33),
      O => \n_0_load_wr_data[0]_i_3\
    );
\load_wr_data[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => rx_configuration_vector(26),
      I1 => rx_configuration_vector(18),
      I2 => load_count(1),
      I3 => rx_configuration_vector(10),
      I4 => load_count(0),
      I5 => rx_configuration_vector(2),
      O => \n_0_load_wr_data[1]_i_2\
    );
\load_wr_data[1]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rx_configuration_vector(2),
      I1 => load_count(1),
      I2 => rx_configuration_vector(42),
      I3 => load_count(0),
      I4 => rx_configuration_vector(34),
      O => \n_0_load_wr_data[1]_i_3\
    );
\load_wr_data[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => rx_configuration_vector(27),
      I1 => rx_configuration_vector(19),
      I2 => load_count(1),
      I3 => rx_configuration_vector(11),
      I4 => load_count(0),
      I5 => rx_configuration_vector(3),
      O => \n_0_load_wr_data[2]_i_2\
    );
\load_wr_data[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rx_configuration_vector(3),
      I1 => load_count(1),
      I2 => rx_configuration_vector(43),
      I3 => load_count(0),
      I4 => rx_configuration_vector(35),
      O => \n_0_load_wr_data[2]_i_3\
    );
\load_wr_data[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => rx_configuration_vector(28),
      I1 => rx_configuration_vector(20),
      I2 => load_count(1),
      I3 => rx_configuration_vector(12),
      I4 => load_count(0),
      I5 => rx_configuration_vector(4),
      O => \n_0_load_wr_data[3]_i_2\
    );
\load_wr_data[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rx_configuration_vector(4),
      I1 => load_count(1),
      I2 => rx_configuration_vector(44),
      I3 => load_count(0),
      I4 => rx_configuration_vector(36),
      O => \n_0_load_wr_data[3]_i_3\
    );
\load_wr_data[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => rx_configuration_vector(29),
      I1 => rx_configuration_vector(21),
      I2 => load_count(1),
      I3 => rx_configuration_vector(13),
      I4 => load_count(0),
      I5 => rx_configuration_vector(5),
      O => \n_0_load_wr_data[4]_i_2\
    );
\load_wr_data[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rx_configuration_vector(5),
      I1 => load_count(1),
      I2 => rx_configuration_vector(45),
      I3 => load_count(0),
      I4 => rx_configuration_vector(37),
      O => \n_0_load_wr_data[4]_i_3\
    );
\load_wr_data[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => rx_configuration_vector(30),
      I1 => rx_configuration_vector(22),
      I2 => load_count(1),
      I3 => rx_configuration_vector(14),
      I4 => load_count(0),
      I5 => rx_configuration_vector(6),
      O => \n_0_load_wr_data[5]_i_2\
    );
\load_wr_data[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rx_configuration_vector(6),
      I1 => load_count(1),
      I2 => rx_configuration_vector(46),
      I3 => load_count(0),
      I4 => rx_configuration_vector(38),
      O => \n_0_load_wr_data[5]_i_3\
    );
\load_wr_data[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => rx_configuration_vector(31),
      I1 => rx_configuration_vector(23),
      I2 => load_count(1),
      I3 => rx_configuration_vector(15),
      I4 => load_count(0),
      I5 => rx_configuration_vector(7),
      O => \n_0_load_wr_data[6]_i_2\
    );
\load_wr_data[6]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rx_configuration_vector(7),
      I1 => load_count(1),
      I2 => rx_configuration_vector(47),
      I3 => load_count(0),
      I4 => rx_configuration_vector(39),
      O => \n_0_load_wr_data[6]_i_3\
    );
\load_wr_data[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
    port map (
      I0 => rx_configuration_vector(32),
      I1 => rx_configuration_vector(24),
      I2 => load_count(1),
      I3 => rx_configuration_vector(16),
      I4 => load_count(0),
      I5 => rx_configuration_vector(8),
      O => \n_0_load_wr_data[7]_i_2\
    );
\load_wr_data[7]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
    port map (
      I0 => rx_configuration_vector(8),
      I1 => load_count(1),
      I2 => rx_configuration_vector(48),
      I3 => load_count(0),
      I4 => rx_configuration_vector(40),
      O => \n_0_load_wr_data[7]_i_3\
    );
\load_wr_data_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => load_wr_data(0),
      Q => \n_0_load_wr_data_reg[0]\,
      R => \<const0>\
    );
\load_wr_data_reg[0]_i_1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_load_wr_data[0]_i_2\,
      I1 => \n_0_load_wr_data[0]_i_3\,
      O => load_wr_data(0),
      S => load_count(2)
    );
\load_wr_data_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => load_wr_data(1),
      Q => \n_0_load_wr_data_reg[1]\,
      R => \<const0>\
    );
\load_wr_data_reg[1]_i_1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_load_wr_data[1]_i_2\,
      I1 => \n_0_load_wr_data[1]_i_3\,
      O => load_wr_data(1),
      S => load_count(2)
    );
\load_wr_data_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => load_wr_data(2),
      Q => \n_0_load_wr_data_reg[2]\,
      R => \<const0>\
    );
\load_wr_data_reg[2]_i_1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_load_wr_data[2]_i_2\,
      I1 => \n_0_load_wr_data[2]_i_3\,
      O => load_wr_data(2),
      S => load_count(2)
    );
\load_wr_data_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => load_wr_data(3),
      Q => \n_0_load_wr_data_reg[3]\,
      R => \<const0>\
    );
\load_wr_data_reg[3]_i_1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_load_wr_data[3]_i_2\,
      I1 => \n_0_load_wr_data[3]_i_3\,
      O => load_wr_data(3),
      S => load_count(2)
    );
\load_wr_data_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => load_wr_data(4),
      Q => \n_0_load_wr_data_reg[4]\,
      R => \<const0>\
    );
\load_wr_data_reg[4]_i_1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_load_wr_data[4]_i_2\,
      I1 => \n_0_load_wr_data[4]_i_3\,
      O => load_wr_data(4),
      S => load_count(2)
    );
\load_wr_data_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => load_wr_data(5),
      Q => \n_0_load_wr_data_reg[5]\,
      R => \<const0>\
    );
\load_wr_data_reg[5]_i_1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_load_wr_data[5]_i_2\,
      I1 => \n_0_load_wr_data[5]_i_3\,
      O => load_wr_data(5),
      S => load_count(2)
    );
\load_wr_data_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => load_wr_data(6),
      Q => \n_0_load_wr_data_reg[6]\,
      R => \<const0>\
    );
\load_wr_data_reg[6]_i_1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_load_wr_data[6]_i_2\,
      I1 => \n_0_load_wr_data[6]_i_3\,
      O => load_wr_data(6),
      S => load_count(2)
    );
\load_wr_data_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => load_wr_data(7),
      Q => \n_0_load_wr_data_reg[7]\,
      R => \<const0>\
    );
\load_wr_data_reg[7]_i_1\: unisim.vcomponents.MUXF7
    port map (
      I0 => \n_0_load_wr_data[7]_i_2\,
      I1 => \n_0_load_wr_data[7]_i_3\,
      O => load_wr_data(7),
      S => load_count(2)
    );
load_wr_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_1_sync_update,
      Q => load_wr,
      R => \<const0>\
    );
pause_match_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000F0F02000000"
    )
    port map (
      I0 => \^o6\,
      I1 => rx_data_valid_reg2,
      I2 => SR(0),
      I3 => \pause_match_reg__0\,
      I4 => I2,
      I5 => n_0_pause_match_reg,
      O => n_0_pause_match_i_1
    );
pause_match_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_pause_match_i_1,
      Q => n_0_pause_match_reg,
      R => \<const0>\
    );
pause_match_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => pause_match_reg0,
      Q => \pause_match_reg__0\,
      R => SR(0)
    );
pauseaddressmatch_int_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => broadcastaddressmatch_int_0,
      D => n_0_pause_match_reg,
      Q => pauseaddressmatch_int,
      R => n_0_address_match_i_1
    );
pauseaddressmatch_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => pauseaddressmatch_int,
      Q => \^pauseaddressmatch\,
      R => SR(0)
    );
promiscuous_mode_sample_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_resync_promiscuous_mode,
      Q => address_match1,
      R => \<const0>\
    );
resync_promiscuous_mode: entity work.TriMACtri_mode_ethernet_mac_v8_1_sync_block_11
    port map (
      I1 => \^o6\,
      I2 => I2,
      I3 => I1,
      O1 => n_0_resync_promiscuous_mode,
      SR(0) => SR(0),
      address_match1 => address_match1,
      rx_configuration_vector(0) => rx_configuration_vector(0),
      rx_data_valid_reg2 => rx_data_valid_reg2
    );
rx_data_valid_reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => data_valid_early,
      Q => \^o6\,
      R => SR(0)
    );
rx_data_valid_reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \^o6\,
      Q => rx_data_valid_reg2,
      R => SR(0)
    );
rx_data_valid_srl16_reg1_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => rx_data_valid_srl16,
      Q => rx_data_valid_srl16_reg1,
      R => SR(0)
    );
rx_data_valid_srl16_reg2_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => rx_data_valid_srl16_reg1,
      Q => rx_data_valid_srl16_reg2,
      R => SR(0)
    );
\rx_filter_match_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => address_match1,
      Q => rx_filter_match_comb2,
      R => \<const0>\
    );
rx_filtered_data_valid_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => rx_data_valid_srl16_reg2,
      I1 => n_0_address_match_reg,
      I2 => address_match1,
      O => rx_filtered_data_valid0
    );
rx_filtered_data_valid_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => rx_filtered_data_valid0,
      Q => \^address_valid_early\,
      R => SR(0)
    );
rx_ptp_match_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => rx_ptp_match,
      I1 => I2,
      I2 => SR(0),
      O => n_0_rx_ptp_match_i_1
    );
rx_ptp_match_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_rx_ptp_match_i_1,
      Q => rx_ptp_match,
      R => \<const0>\
    );
rxstatsaddressmatch_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EEAA0EAA"
    )
    port map (
      I0 => \^rxstatsaddressmatch\,
      I1 => \^address_valid_early\,
      I2 => rx_data_valid_srl16,
      I3 => I2,
      I4 => rx_data_valid_srl16_reg1,
      I5 => SR(0),
      O => n_0_rxstatsaddressmatch_i_1
    );
rxstatsaddressmatch_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_rxstatsaddressmatch_i_1,
      Q => \^rxstatsaddressmatch\,
      R => \<const0>\
    );
\special_pause_address[0].LUT3_special_pause_inst\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"21"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(2),
      O => O1
    );
\special_pause_address[1].LUT3_special_pause_inst\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(2),
      O => p_9_out
    );
\special_pause_address[2].LUT3_special_pause_inst\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"00"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(2),
      O => p_8_out
    );
\special_pause_address[3].LUT3_special_pause_inst\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"00"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(2),
      O => p_7_out
    );
\special_pause_address[4].LUT3_special_pause_inst\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"00"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(2),
      O => O2
    );
\special_pause_address[5].LUT3_special_pause_inst\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"00"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(2),
      O => O3
    );
\special_pause_address[6].LUT3_special_pause_inst\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(2),
      O => O4
    );
\special_pause_address[7].LUT3_special_pause_inst\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
    port map (
      I0 => \counter_reg__0\(0),
      I1 => \counter_reg__0\(1),
      I2 => \counter_reg__0\(2),
      O => O5
    );
special_pause_match_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F000F0F02000000"
    )
    port map (
      I0 => \^o6\,
      I1 => rx_data_valid_reg2,
      I2 => SR(0),
      I3 => \special_pause_match_reg__0\,
      I4 => I2,
      I5 => n_0_special_pause_match_reg,
      O => n_0_special_pause_match_i_1
    );
special_pause_match_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_special_pause_match_i_1,
      Q => n_0_special_pause_match_reg,
      R => \<const0>\
    );
special_pause_match_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => special_pause_match_comb,
      Q => \special_pause_match_reg__0\,
      R => SR(0)
    );
specialpauseaddressmatch_int_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => broadcastaddressmatch_int_0,
      D => n_0_special_pause_match_reg,
      Q => specialpauseaddressmatch_int,
      R => n_0_address_match_i_1
    );
specialpauseaddressmatch_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => specialpauseaddressmatch_int,
      Q => \^specialpauseaddressmatch\,
      R => SR(0)
    );
sync_update: entity work.TriMACtri_mode_ethernet_mac_v8_1_sync_block_12
    port map (
      I1 => I1,
      I4 => I4,
      I5 => I5,
      O1 => n_1_sync_update,
      O2 => n_2_sync_update,
      Q(2) => \n_0_load_count_pipe_reg[2]\,
      Q(1) => \n_0_load_count_pipe_reg[1]\,
      Q(0) => \n_0_load_count_pipe_reg[0]\,
      SR(0) => SR(0),
      data_out => data_out,
      update_pause_ad_sync_reg => \^update_pause_ad_sync_reg\
    );
update_pause_ad_sync_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_2_sync_update,
      Q => \^update_pause_ad_sync_reg\,
      R => \<const0>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_tx_pause is
  port (
    pause_status_req : out STD_LOGIC;
    pause_status_int : out STD_LOGIC;
    I1 : in STD_LOGIC;
    tx_ce_sample : in STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    tx_status : in STD_LOGIC;
    I2 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    data_in : in STD_LOGIC
  );
end TriMACtri_mode_ethernet_mac_v8_1_tx_pause;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_tx_pause is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \count_set_reg__0\ : STD_LOGIC;
  signal n_0_pause_dec_i_2 : STD_LOGIC;
  signal n_0_pause_dec_reg : STD_LOGIC;
  signal n_0_pause_status_int_i_1 : STD_LOGIC;
  signal n_0_pause_status_int_i_3 : STD_LOGIC;
  signal n_0_pause_status_int_i_4 : STD_LOGIC;
  signal n_0_pause_status_int_i_5 : STD_LOGIC;
  signal n_0_sync_good_rx : STD_LOGIC;
  signal n_10_sync_good_rx : STD_LOGIC;
  signal n_11_sync_good_rx : STD_LOGIC;
  signal n_12_sync_good_rx : STD_LOGIC;
  signal n_13_sync_good_rx : STD_LOGIC;
  signal n_14_sync_good_rx : STD_LOGIC;
  signal n_15_sync_good_rx : STD_LOGIC;
  signal n_16_sync_good_rx : STD_LOGIC;
  signal n_18_sync_good_rx : STD_LOGIC;
  signal n_19_sync_good_rx : STD_LOGIC;
  signal n_1_sync_good_rx : STD_LOGIC;
  signal n_20_sync_good_rx : STD_LOGIC;
  signal n_2_sync_good_rx : STD_LOGIC;
  signal n_3_sync_good_rx : STD_LOGIC;
  signal n_4_sync_good_rx : STD_LOGIC;
  signal n_5_sync_good_rx : STD_LOGIC;
  signal n_6_sync_good_rx : STD_LOGIC;
  signal n_7_sync_good_rx : STD_LOGIC;
  signal n_8_sync_good_rx : STD_LOGIC;
  signal n_9_sync_good_rx : STD_LOGIC;
  signal \p_0_in__0\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal pause_count_reg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal pause_req_in_tx : STD_LOGIC;
  signal pause_req_in_tx_reg : STD_LOGIC;
  signal \^pause_status_int\ : STD_LOGIC;
  signal pause_status_int_0 : STD_LOGIC;
  signal \^pause_status_req\ : STD_LOGIC;
  signal \quanta_count_reg__0\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  attribute counter : integer;
  attribute counter of \pause_count_reg[0]\ : label is 8;
  attribute counter of \pause_count_reg[10]\ : label is 8;
  attribute counter of \pause_count_reg[11]\ : label is 8;
  attribute counter of \pause_count_reg[12]\ : label is 8;
  attribute counter of \pause_count_reg[13]\ : label is 8;
  attribute counter of \pause_count_reg[14]\ : label is 8;
  attribute counter of \pause_count_reg[15]\ : label is 8;
  attribute counter of \pause_count_reg[1]\ : label is 8;
  attribute counter of \pause_count_reg[2]\ : label is 8;
  attribute counter of \pause_count_reg[3]\ : label is 8;
  attribute counter of \pause_count_reg[4]\ : label is 8;
  attribute counter of \pause_count_reg[5]\ : label is 8;
  attribute counter of \pause_count_reg[6]\ : label is 8;
  attribute counter of \pause_count_reg[7]\ : label is 8;
  attribute counter of \pause_count_reg[8]\ : label is 8;
  attribute counter of \pause_count_reg[9]\ : label is 8;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of pause_dec_i_2 : label is "soft_lutpair158";
  attribute RETAIN_INVERTER : boolean;
  attribute RETAIN_INVERTER of \quanta_count[0]_i_1\ : label is true;
  attribute SOFT_HLUTNM of \quanta_count[0]_i_1\ : label is "soft_lutpair160";
  attribute SOFT_HLUTNM of \quanta_count[1]_i_1\ : label is "soft_lutpair160";
  attribute SOFT_HLUTNM of \quanta_count[2]_i_1\ : label is "soft_lutpair159";
  attribute SOFT_HLUTNM of \quanta_count[3]_i_1\ : label is "soft_lutpair159";
  attribute SOFT_HLUTNM of \quanta_count[4]_i_1\ : label is "soft_lutpair158";
  attribute counter of \quanta_count_reg[0]\ : label is 9;
  attribute counter of \quanta_count_reg[1]\ : label is 9;
  attribute counter of \quanta_count_reg[2]\ : label is 9;
  attribute counter of \quanta_count_reg[3]\ : label is 9;
  attribute counter of \quanta_count_reg[4]\ : label is 9;
  attribute counter of \quanta_count_reg[5]\ : label is 9;
begin
  pause_status_int <= \^pause_status_int\;
  pause_status_req <= \^pause_status_req\;
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
count_set_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_19_sync_good_rx,
      Q => \^pause_status_req\,
      R => \<const0>\
    );
count_set_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \^pause_status_req\,
      Q => \count_set_reg__0\,
      R => I1
    );
\pause_count_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_3_sync_good_rx,
      Q => pause_count_reg(0),
      R => I1
    );
\pause_count_reg[10]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_9_sync_good_rx,
      Q => pause_count_reg(10),
      R => I1
    );
\pause_count_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_8_sync_good_rx,
      Q => pause_count_reg(11),
      R => I1
    );
\pause_count_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_15_sync_good_rx,
      Q => pause_count_reg(12),
      R => I1
    );
\pause_count_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_14_sync_good_rx,
      Q => pause_count_reg(13),
      R => I1
    );
\pause_count_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_13_sync_good_rx,
      Q => pause_count_reg(14),
      R => I1
    );
\pause_count_reg[15]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_12_sync_good_rx,
      Q => pause_count_reg(15),
      R => I1
    );
\pause_count_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_2_sync_good_rx,
      Q => pause_count_reg(1),
      R => I1
    );
\pause_count_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_1_sync_good_rx,
      Q => pause_count_reg(2),
      R => I1
    );
\pause_count_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_0_sync_good_rx,
      Q => pause_count_reg(3),
      R => I1
    );
\pause_count_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_7_sync_good_rx,
      Q => pause_count_reg(4),
      R => I1
    );
\pause_count_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_6_sync_good_rx,
      Q => pause_count_reg(5),
      R => I1
    );
\pause_count_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_5_sync_good_rx,
      Q => pause_count_reg(6),
      R => I1
    );
\pause_count_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_4_sync_good_rx,
      Q => pause_count_reg(7),
      R => I1
    );
\pause_count_reg[8]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_11_sync_good_rx,
      Q => pause_count_reg(8),
      R => I1
    );
\pause_count_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => n_18_sync_good_rx,
      D => n_10_sync_good_rx,
      Q => pause_count_reg(9),
      R => I1
    );
pause_dec_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
    port map (
      I0 => \quanta_count_reg__0\(4),
      I1 => \quanta_count_reg__0\(2),
      I2 => \quanta_count_reg__0\(1),
      I3 => \quanta_count_reg__0\(0),
      I4 => \quanta_count_reg__0\(3),
      O => n_0_pause_dec_i_2
    );
pause_dec_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_20_sync_good_rx,
      Q => n_0_pause_dec_reg,
      R => \<const0>\
    );
pause_req_in_tx_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => pause_req_in_tx,
      Q => pause_req_in_tx_reg,
      R => I1
    );
pause_status_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000000EEEEEEE"
    )
    port map (
      I0 => \^pause_status_int\,
      I1 => pause_status_int_0,
      I2 => n_0_pause_status_int_i_3,
      I3 => n_0_pause_status_int_i_4,
      I4 => n_0_pause_status_int_i_5,
      I5 => I1,
      O => n_0_pause_status_int_i_1
    );
pause_status_int_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => \count_set_reg__0\,
      I1 => tx_status,
      I2 => tx_ce_sample,
      O => pause_status_int_0
    );
pause_status_int_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => pause_count_reg(12),
      I1 => pause_count_reg(8),
      I2 => pause_count_reg(15),
      I3 => pause_count_reg(6),
      I4 => pause_count_reg(14),
      O => n_0_pause_status_int_i_3
    );
pause_status_int_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000010"
    )
    port map (
      I0 => pause_count_reg(3),
      I1 => pause_count_reg(5),
      I2 => tx_ce_sample,
      I3 => pause_count_reg(7),
      I4 => pause_count_reg(10),
      I5 => pause_count_reg(4),
      O => n_0_pause_status_int_i_4
    );
pause_status_int_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => pause_count_reg(1),
      I1 => pause_count_reg(11),
      I2 => pause_count_reg(9),
      I3 => pause_count_reg(2),
      I4 => pause_count_reg(13),
      I5 => pause_count_reg(0),
      O => n_0_pause_status_int_i_5
    );
pause_status_int_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_pause_status_int_i_1,
      Q => \^pause_status_int\,
      R => \<const0>\
    );
\quanta_count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \quanta_count_reg__0\(0),
      O => \p_0_in__0\(0)
    );
\quanta_count[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => \quanta_count_reg__0\(0),
      I1 => \quanta_count_reg__0\(1),
      O => \p_0_in__0\(1)
    );
\quanta_count[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => \quanta_count_reg__0\(2),
      I1 => \quanta_count_reg__0\(1),
      I2 => \quanta_count_reg__0\(0),
      O => \p_0_in__0\(2)
    );
\quanta_count[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => \quanta_count_reg__0\(3),
      I1 => \quanta_count_reg__0\(0),
      I2 => \quanta_count_reg__0\(1),
      I3 => \quanta_count_reg__0\(2),
      O => \p_0_in__0\(3)
    );
\quanta_count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => \quanta_count_reg__0\(4),
      I1 => \quanta_count_reg__0\(2),
      I2 => \quanta_count_reg__0\(1),
      I3 => \quanta_count_reg__0\(0),
      I4 => \quanta_count_reg__0\(3),
      O => \p_0_in__0\(4)
    );
\quanta_count[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
    port map (
      I0 => \quanta_count_reg__0\(5),
      I1 => \quanta_count_reg__0\(3),
      I2 => \quanta_count_reg__0\(0),
      I3 => \quanta_count_reg__0\(1),
      I4 => \quanta_count_reg__0\(2),
      I5 => \quanta_count_reg__0\(4),
      O => \p_0_in__0\(5)
    );
\quanta_count_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \p_0_in__0\(0),
      Q => \quanta_count_reg__0\(0),
      R => n_16_sync_good_rx
    );
\quanta_count_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \p_0_in__0\(1),
      Q => \quanta_count_reg__0\(1),
      R => n_16_sync_good_rx
    );
\quanta_count_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \p_0_in__0\(2),
      Q => \quanta_count_reg__0\(2),
      R => n_16_sync_good_rx
    );
\quanta_count_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \p_0_in__0\(3),
      Q => \quanta_count_reg__0\(3),
      R => n_16_sync_good_rx
    );
\quanta_count_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \p_0_in__0\(4),
      Q => \quanta_count_reg__0\(4),
      R => n_16_sync_good_rx
    );
\quanta_count_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \p_0_in__0\(5),
      Q => \quanta_count_reg__0\(5),
      R => n_16_sync_good_rx
    );
sync_good_rx: entity work.TriMACtri_mode_ethernet_mac_v8_1_sync_block_6
    port map (
      I1 => \^pause_status_int\,
      I2 => I1,
      I3 => n_0_pause_dec_reg,
      I4 => I2,
      I5 => n_0_pause_dec_i_2,
      I6(15 downto 0) => Q(15 downto 0),
      O(3) => n_0_sync_good_rx,
      O(2) => n_1_sync_good_rx,
      O(1) => n_2_sync_good_rx,
      O(0) => n_3_sync_good_rx,
      O1(3) => n_4_sync_good_rx,
      O1(2) => n_5_sync_good_rx,
      O1(1) => n_6_sync_good_rx,
      O1(0) => n_7_sync_good_rx,
      O2(3) => n_8_sync_good_rx,
      O2(2) => n_9_sync_good_rx,
      O2(1) => n_10_sync_good_rx,
      O2(0) => n_11_sync_good_rx,
      O3(3) => n_12_sync_good_rx,
      O3(2) => n_13_sync_good_rx,
      O3(1) => n_14_sync_good_rx,
      O3(0) => n_15_sync_good_rx,
      O4 => n_18_sync_good_rx,
      O5 => n_19_sync_good_rx,
      O6 => n_20_sync_good_rx,
      Q(0) => \quanta_count_reg__0\(5),
      SR(0) => n_16_sync_good_rx,
      data_in => data_in,
      data_out => pause_req_in_tx,
      gtx_clk => gtx_clk,
      pause_count_reg(15 downto 0) => pause_count_reg(15 downto 0),
      pause_req_in_tx_reg => pause_req_in_tx_reg,
      pause_status_req => \^pause_status_req\,
      tx_ce_sample => tx_ce_sample
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACrx is
  port (
    O1 : out STD_LOGIC;
    END_OF_FRAME : out STD_LOGIC;
    int_rx_control_frame : out STD_LOGIC;
    int_rx_data_valid_in : out STD_LOGIC;
    int_rx_good_frame_in : out STD_LOGIC;
    int_rx_bad_frame_in : out STD_LOGIC;
    rx_statistics_valid : out STD_LOGIC;
    O3 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC_VECTOR ( 0 to 0 );
    bad_pfc_opcode_int : out STD_LOGIC;
    rx_bad_frame_comb : out STD_LOGIC;
    rx_statistics_vector : out STD_LOGIC_VECTOR ( 25 downto 0 );
    I7 : out STD_LOGIC_VECTOR ( 0 to 0 );
    O6 : out STD_LOGIC;
    data_valid_early : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    O7 : out STD_LOGIC;
    pause_match_reg0 : out STD_LOGIC;
    special_pause_match_comb : out STD_LOGIC;
    O8 : out STD_LOGIC;
    O9 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    I2 : in STD_LOGIC;
    broadcastaddressmatch : in STD_LOGIC;
    I1 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 21 downto 0 );
    gmii_rx_er_from_mii : in STD_LOGIC;
    gmii_rx_dv_from_mii : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 1 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    I5 : in STD_LOGIC;
    rx_data_valid_reg1 : in STD_LOGIC;
    update_pause_ad_sync : in STD_LOGIC;
    update_pause_ad_sync_reg : in STD_LOGIC;
    address_valid_early : in STD_LOGIC;
    I6 : in STD_LOGIC;
    MATCH_FRAME_INT0 : in STD_LOGIC;
    pauseaddressmatch : in STD_LOGIC;
    specialpauseaddressmatch : in STD_LOGIC;
    int_alignment_err_pulse : in STD_LOGIC;
    alignment_err_reg : in STD_LOGIC;
    I8 : in STD_LOGIC;
    rx_enable_reg : in STD_LOGIC;
    broadcast_byte_match : in STD_LOGIC;
    p_10_out : in STD_LOGIC;
    p_6_out : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    p_0_out : in STD_LOGIC;
    p_4_out : in STD_LOGIC;
    p_2_out : in STD_LOGIC;
    p_1_out : in STD_LOGIC;
    p_5_out : in STD_LOGIC;
    I9 : in STD_LOGIC;
    p_9_out : in STD_LOGIC;
    I10 : in STD_LOGIC;
    p_8_out : in STD_LOGIC;
    p_7_out : in STD_LOGIC;
    I11 : in STD_LOGIC;
    I12 : in STD_LOGIC;
    I13 : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 7 downto 0 );
    I14 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end TriMACrx;

architecture STRUCTURE of TriMACrx is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal ALIGNMENT_ERR : STD_LOGIC;
  signal \^alignment_err_reg\ : STD_LOGIC;
  signal BAD_FRAME_INT0_out : STD_LOGIC;
  signal CE_REG1_OUT : STD_LOGIC;
  signal CE_REG1_OUT6_out : STD_LOGIC;
  signal CE_REG2_OUT : STD_LOGIC;
  signal CE_REG3_OUT : STD_LOGIC;
  signal CE_REG4_OUT : STD_LOGIC;
  signal CE_REG5_OUT : STD_LOGIC;
  signal CLK_DIV100_REG : STD_LOGIC;
  signal CLK_DIV10_REG : STD_LOGIC;
  signal CLK_DIV20_REG : STD_LOGIC;
  signal COMPUTE : STD_LOGIC;
  signal CONTROL_FRAME_INT : STD_LOGIC;
  signal CONTROL_MATCH : STD_LOGIC;
  signal CONTROL_MATCH0 : STD_LOGIC;
  signal CRC1000_EN : STD_LOGIC;
  signal CRC100_EN : STD_LOGIC;
  signal CRC50_EN : STD_LOGIC;
  signal CRC_COMPUTE0 : STD_LOGIC;
  signal CRC_ENGINE_ERR0 : STD_LOGIC;
  signal DATA_FIELD : STD_LOGIC;
  signal DATA_NO_FCS : STD_LOGIC;
  signal DATA_NO_FCS0 : STD_LOGIC;
  signal DATA_OUT : STD_LOGIC;
  signal DATA_VALID_FINAL0 : STD_LOGIC;
  signal DATA_WITH_FCS : STD_LOGIC;
  signal DATA_WITH_FCS0 : STD_LOGIC;
  signal END_OF_DATA : STD_LOGIC;
  signal \^end_of_frame\ : STD_LOGIC;
  signal EXCEEDED_MIN_LEN : STD_LOGIC;
  signal EXTENSION_FIELD : STD_LOGIC;
  signal EXTENSION_FLAG : STD_LOGIC;
  signal EXTENSION_FLAG0 : STD_LOGIC;
  signal FALSE_CARR_FLAG : STD_LOGIC;
  signal FCS_FIELD : STD_LOGIC;
  signal FIELD_COUNTER : STD_LOGIC_VECTOR ( 1 to 1 );
  signal FRAME_LEN_ERR : STD_LOGIC;
  signal GOOD_FRAME_INT : STD_LOGIC;
  signal IFG_FLAG : STD_LOGIC;
  signal INHIBIT_FRAME : STD_LOGIC;
  signal INHIBIT_FRAME0 : STD_LOGIC;
  signal LENGTH_FIELD : STD_LOGIC;
  signal LENGTH_FIELD_MATCH : STD_LOGIC;
  signal LENGTH_ONE : STD_LOGIC;
  signal LENGTH_ONE0 : STD_LOGIC;
  signal LENGTH_ZERO : STD_LOGIC;
  signal LENGTH_ZERO0 : STD_LOGIC;
  signal LESS_THAN_256 : STD_LOGIC;
  signal LESS_THAN_2560 : STD_LOGIC;
  signal LT_CHECK_HELD : STD_LOGIC;
  signal MATCH_FRAME_INT : STD_LOGIC;
  signal MAX_LENGTH_ERR3_out : STD_LOGIC;
  signal MULTICAST_MATCH : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal \^o2\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC;
  signal \^o9\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal PAUSE_LT_CHECK_HELD : STD_LOGIC;
  signal PREAMBLE_FIELD : STD_LOGIC;
  signal PRE_FALSE_CARR_FLAG : STD_LOGIC;
  signal PRE_IFG_FLAG : STD_LOGIC;
  signal Q0_out : STD_LOGIC;
  signal Q1_out : STD_LOGIC;
  signal Q2_out : STD_LOGIC;
  signal Q3_out : STD_LOGIC;
  signal Q4_out : STD_LOGIC;
  signal Q5_out : STD_LOGIC;
  signal Q6_out : STD_LOGIC;
  signal REG0_OUT2 : STD_LOGIC;
  signal REG1_OUT : STD_LOGIC;
  signal REG2_OUT : STD_LOGIC;
  signal REG3_OUT : STD_LOGIC;
  signal REG4_OUT : STD_LOGIC;
  signal REG5_OUT : STD_LOGIC;
  signal REG6_OUT2 : STD_LOGIC;
  signal REG7_OUT2 : STD_LOGIC;
  signal REG8_OUT2 : STD_LOGIC;
  signal REG9_OUT2 : STD_LOGIC;
  signal RXD_REG5 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal RXD_REG6 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal RXD_REG8 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal RX_DV_REG2 : STD_LOGIC;
  signal RX_DV_REG5 : STD_LOGIC;
  signal RX_DV_REG6 : STD_LOGIC;
  signal RX_DV_REG7 : STD_LOGIC;
  signal RX_ERR_REG1 : STD_LOGIC;
  signal RX_ERR_REG5 : STD_LOGIC;
  signal RX_ERR_REG6 : STD_LOGIC;
  signal RX_ERR_REG7 : STD_LOGIC;
  signal SFD_FLAG : STD_LOGIC;
  signal SFD_FLAG0 : STD_LOGIC;
  signal SPEED_0_RESYNC_REG : STD_LOGIC;
  signal SPEED_1_RESYNC_REG : STD_LOGIC;
  signal TYPE_FRAME : STD_LOGIC;
  signal TYPE_PACKET10_out : STD_LOGIC;
  signal VALIDATE_REQUIRED : STD_LOGIC;
  signal VLAN_FRAME : STD_LOGIC;
  signal data_early : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^int_rx_bad_frame_in\ : STD_LOGIC;
  signal int_rx_control_frame_any_da : STD_LOGIC;
  signal \^int_rx_good_frame_in\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.CALCULATE_CRC2\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.CE_REG1_OUT_i_1__0\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.CE_REG5_OUT_reg\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.CRC1000_EN_i_1__0\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.CRC100_EN_i_1__0\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.CRC50_EN_i_1__0\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG0_OUT2_reg\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG1_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG1_OUT_i_1__0\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG2_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG3_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG4_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_rxgen_CONFIG_SELECT.REG5_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG5_OUT2_reg_gate\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG5_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG5_OUT_reg\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.SPEED_1_SYNC\ : STD_LOGIC;
  signal n_0_CRC_MODE_HELD_reg : STD_LOGIC;
  signal n_0_DATA_VALID_EARLY_INT_i_1 : STD_LOGIC;
  signal n_0_DATA_VALID_EARLY_INT_i_2 : STD_LOGIC;
  signal n_0_DATA_VALID_EARLY_INT_i_3 : STD_LOGIC;
  signal n_0_ENABLE_REG_reg : STD_LOGIC;
  signal n_0_EXTENSION_FLAG_i_2 : STD_LOGIC;
  signal n_0_JUMBO_FRAMES_HELD_reg : STD_LOGIC;
  signal n_0_MAX_FRAME_ENABLE_HELD_reg : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[0]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[10]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[11]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[12]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[13]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[14]_i_2\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[1]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[2]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[3]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[4]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[5]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[6]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[7]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[8]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD[9]_i_1\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[0]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[10]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[11]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[12]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[13]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[14]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[1]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[2]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[3]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[4]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[5]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[6]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[7]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[8]\ : STD_LOGIC;
  signal \n_0_MAX_FRAME_LENGTH_HELD_reg[9]\ : STD_LOGIC;
  signal \n_0_RXD_REG7_reg[0]\ : STD_LOGIC;
  signal \n_0_RXD_REG7_reg[1]\ : STD_LOGIC;
  signal \n_0_RXD_REG7_reg[2]\ : STD_LOGIC;
  signal \n_0_RXD_REG7_reg[3]\ : STD_LOGIC;
  signal \n_0_RXD_REG7_reg[4]\ : STD_LOGIC;
  signal \n_0_RXD_REG7_reg[5]\ : STD_LOGIC;
  signal \n_0_RXD_REG7_reg[6]\ : STD_LOGIC;
  signal \n_0_RXD_REG7_reg[7]\ : STD_LOGIC;
  signal n_0_RX_DV_REG3_reg : STD_LOGIC;
  signal n_0_SFD_FLAG_i_2 : STD_LOGIC;
  signal n_0_SPEED_IS_10_100_HELD_reg : STD_LOGIC;
  signal n_0_VLAN_ENABLE_HELD_reg : STD_LOGIC;
  signal n_0_broadcast_byte_match_i_2 : STD_LOGIC;
  signal n_0_pause_match_reg_i_2 : STD_LOGIC;
  signal n_0_pause_match_reg_i_3 : STD_LOGIC;
  signal n_0_special_pause_match_reg_i_2 : STD_LOGIC;
  signal n_0_special_pause_match_reg_i_3 : STD_LOGIC;
  signal n_11_FRAME_CHECKER : STD_LOGIC;
  signal n_12_FRAME_CHECKER : STD_LOGIC;
  signal n_14_FRAME_CHECKER : STD_LOGIC;
  signal n_19_RX_SM : STD_LOGIC;
  signal n_1_FRAME_CHECKER : STD_LOGIC;
  signal n_20_RX_SM : STD_LOGIC;
  signal n_24_RX_SM : STD_LOGIC;
  signal n_25_RX_SM : STD_LOGIC;
  signal n_26_RX_SM : STD_LOGIC;
  signal n_27_RX_SM : STD_LOGIC;
  signal n_28_RX_SM : STD_LOGIC;
  signal n_29_RX_SM : STD_LOGIC;
  signal n_30_RX_SM : STD_LOGIC;
  signal n_31_FRAME_DECODER : STD_LOGIC;
  signal n_31_RX_SM : STD_LOGIC;
  signal n_32_FRAME_DECODER : STD_LOGIC;
  signal n_32_RX_SM : STD_LOGIC;
  signal n_33_FRAME_DECODER : STD_LOGIC;
  signal n_33_RX_SM : STD_LOGIC;
  signal n_34_FRAME_DECODER : STD_LOGIC;
  signal n_34_RX_SM : STD_LOGIC;
  signal n_35_RX_SM : STD_LOGIC;
  signal n_36_FRAME_DECODER : STD_LOGIC;
  signal n_38_FRAME_DECODER : STD_LOGIC;
  signal n_40_FRAME_DECODER : STD_LOGIC;
  signal n_7_RX_SM : STD_LOGIC;
  signal p_0_out_0 : STD_LOGIC_VECTOR ( 24 downto 0 );
  signal p_3_out_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal p_8_in : STD_LOGIC;
  attribute srl_name : string;
  attribute srl_name of \CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r\ : label is "inst/\TriMAC_core/rxgen/CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r ";
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of DELAY_BROADCASTADDRESSMATCH : label is "PRIMITIVE";
  attribute srl_name of DELAY_BROADCASTADDRESSMATCH : label is "inst/\TriMAC_core/rxgen/DELAY_BROADCASTADDRESSMATCH ";
  attribute BOX_TYPE of \DELAY_RXD_BUS[0].DELAY_RXD\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \DELAY_RXD_BUS[0].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS ";
  attribute srl_name of \DELAY_RXD_BUS[0].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[0].DELAY_RXD ";
  attribute BOX_TYPE of \DELAY_RXD_BUS[1].DELAY_RXD\ : label is "PRIMITIVE";
  attribute srl_bus_name of \DELAY_RXD_BUS[1].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS ";
  attribute srl_name of \DELAY_RXD_BUS[1].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[1].DELAY_RXD ";
  attribute BOX_TYPE of \DELAY_RXD_BUS[2].DELAY_RXD\ : label is "PRIMITIVE";
  attribute srl_bus_name of \DELAY_RXD_BUS[2].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS ";
  attribute srl_name of \DELAY_RXD_BUS[2].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[2].DELAY_RXD ";
  attribute BOX_TYPE of \DELAY_RXD_BUS[3].DELAY_RXD\ : label is "PRIMITIVE";
  attribute srl_bus_name of \DELAY_RXD_BUS[3].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS ";
  attribute srl_name of \DELAY_RXD_BUS[3].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[3].DELAY_RXD ";
  attribute BOX_TYPE of \DELAY_RXD_BUS[4].DELAY_RXD\ : label is "PRIMITIVE";
  attribute srl_bus_name of \DELAY_RXD_BUS[4].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS ";
  attribute srl_name of \DELAY_RXD_BUS[4].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[4].DELAY_RXD ";
  attribute BOX_TYPE of \DELAY_RXD_BUS[5].DELAY_RXD\ : label is "PRIMITIVE";
  attribute srl_bus_name of \DELAY_RXD_BUS[5].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS ";
  attribute srl_name of \DELAY_RXD_BUS[5].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[5].DELAY_RXD ";
  attribute BOX_TYPE of \DELAY_RXD_BUS[6].DELAY_RXD\ : label is "PRIMITIVE";
  attribute srl_bus_name of \DELAY_RXD_BUS[6].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS ";
  attribute srl_name of \DELAY_RXD_BUS[6].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[6].DELAY_RXD ";
  attribute BOX_TYPE of \DELAY_RXD_BUS[7].DELAY_RXD\ : label is "PRIMITIVE";
  attribute srl_bus_name of \DELAY_RXD_BUS[7].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS ";
  attribute srl_name of \DELAY_RXD_BUS[7].DELAY_RXD\ : label is "inst/\TriMAC_core/rxgen/DELAY_RXD_BUS[7].DELAY_RXD ";
  attribute BOX_TYPE of DELAY_RX_DV1 : label is "PRIMITIVE";
  attribute srl_name of DELAY_RX_DV1 : label is "inst/\TriMAC_core/rxgen/DELAY_RX_DV1 ";
  attribute BOX_TYPE of DELAY_RX_DV2 : label is "PRIMITIVE";
  attribute srl_name of DELAY_RX_DV2 : label is "inst/\TriMAC_core/rxgen/DELAY_RX_DV2 ";
  attribute BOX_TYPE of DELAY_RX_ERR : label is "PRIMITIVE";
  attribute srl_name of DELAY_RX_ERR : label is "inst/\TriMAC_core/rxgen/DELAY_RX_ERR ";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[0]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[10]_i_1\ : label is "soft_lutpair110";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[11]_i_1\ : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[12]_i_1\ : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[13]_i_1\ : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[1]_i_1\ : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[2]_i_1\ : label is "soft_lutpair110";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[3]_i_1\ : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[4]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[5]_i_1\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[6]_i_1\ : label is "soft_lutpair112";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[7]_i_1\ : label is "soft_lutpair112";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[8]_i_1\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \MAX_FRAME_LENGTH_HELD[9]_i_1\ : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of check_opcode_i_2 : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \counter[5]_i_1__0\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of delay_rx_data_valid_i_1 : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \pause_opcode_early[7]_i_1\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \pause_value[15]_i_3\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of rx_bad_frame_int_i_1 : label is "soft_lutpair105";
begin
  END_OF_FRAME <= \^end_of_frame\;
  O1 <= \^o1\;
  O2 <= \^o2\;
  O3 <= \^o3\;
  O9(7 downto 0) <= \^o9\(7 downto 0);
  int_rx_bad_frame_in <= \^int_rx_bad_frame_in\;
  int_rx_good_frame_in <= \^int_rx_good_frame_in\;
ALIGNMENT_ERR_REG_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => ALIGNMENT_ERR,
      Q => \^alignment_err_reg\,
      R => \<const0>\
    );
BAD_FRAME_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => BAD_FRAME_INT0_out,
      Q => \^int_rx_bad_frame_in\,
      R => SR(0)
    );
\CONFIG_SELECT.CALCULATE_CRC2\: entity work.TriMACCRC_64_32
    port map (
      CRC1000_EN => CRC1000_EN,
      CRC50_EN => CRC50_EN,
      I1 => I1,
      I2 => I2,
      O1 => \n_0_CONFIG_SELECT.CALCULATE_CRC2\,
      SPEED_0_RESYNC_REG => SPEED_0_RESYNC_REG,
      SPEED_1_RESYNC_REG => SPEED_1_RESYNC_REG,
      rx_configuration_vector(0) => rx_configuration_vector(0)
    );
\CONFIG_SELECT.CE_REG1_OUT_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_CONFIG_SELECT.CE_REG5_OUT_reg\,
      O => \n_0_CONFIG_SELECT.CE_REG1_OUT_i_1__0\
    );
\CONFIG_SELECT.CE_REG1_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => CE_REG1_OUT6_out,
      D => \n_0_CONFIG_SELECT.CE_REG1_OUT_i_1__0\,
      Q => CE_REG1_OUT,
      R => CE_REG5_OUT
    );
\CONFIG_SELECT.CE_REG2_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => CE_REG1_OUT6_out,
      D => CE_REG1_OUT,
      Q => CE_REG2_OUT,
      R => CE_REG5_OUT
    );
\CONFIG_SELECT.CE_REG3_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => CE_REG1_OUT6_out,
      D => CE_REG2_OUT,
      Q => CE_REG3_OUT,
      R => CE_REG5_OUT
    );
\CONFIG_SELECT.CE_REG4_OUT_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BAAAAAAA"
    )
    port map (
      I0 => SR(0),
      I1 => CE_REG4_OUT,
      I2 => \n_0_CONFIG_SELECT.CE_REG5_OUT_reg\,
      I3 => I2,
      I4 => CRC100_EN,
      O => CE_REG5_OUT
    );
\CONFIG_SELECT.CE_REG4_OUT_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => I2,
      I1 => CRC100_EN,
      O => CE_REG1_OUT6_out
    );
\CONFIG_SELECT.CE_REG4_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => CE_REG1_OUT6_out,
      D => CE_REG3_OUT,
      Q => CE_REG4_OUT,
      R => CE_REG5_OUT
    );
\CONFIG_SELECT.CE_REG5_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => CE_REG1_OUT6_out,
      D => CE_REG4_OUT,
      Q => \n_0_CONFIG_SELECT.CE_REG5_OUT_reg\,
      R => CE_REG5_OUT
    );
\CONFIG_SELECT.CLK_DIV100_REG_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => CE_REG3_OUT,
      Q => CLK_DIV100_REG,
      R => \<const0>\
    );
\CONFIG_SELECT.CLK_DIV10_REG_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => REG3_OUT,
      Q => CLK_DIV10_REG,
      R => \<const0>\
    );
\CONFIG_SELECT.CLK_DIV20_REG_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => REG6_OUT2,
      Q => CLK_DIV20_REG,
      R => \<const0>\
    );
\CONFIG_SELECT.CRC1000_EN_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => CE_REG3_OUT,
      I1 => CLK_DIV100_REG,
      O => \n_0_CONFIG_SELECT.CRC1000_EN_i_1__0\
    );
\CONFIG_SELECT.CRC1000_EN_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.CRC1000_EN_i_1__0\,
      Q => CRC1000_EN,
      R => \<const0>\
    );
\CONFIG_SELECT.CRC100_EN_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => REG3_OUT,
      I1 => CLK_DIV10_REG,
      O => \n_0_CONFIG_SELECT.CRC100_EN_i_1__0\
    );
\CONFIG_SELECT.CRC100_EN_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.CRC100_EN_i_1__0\,
      Q => CRC100_EN,
      R => \<const0>\
    );
\CONFIG_SELECT.CRC50_EN_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => REG6_OUT2,
      I1 => CLK_DIV20_REG,
      O => \n_0_CONFIG_SELECT.CRC50_EN_i_1__0\
    );
\CONFIG_SELECT.CRC50_EN_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.CRC50_EN_i_1__0\,
      Q => CRC50_EN,
      R => \<const0>\
    );
\CONFIG_SELECT.REG0_OUT2_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => REG9_OUT2,
      Q => \n_0_CONFIG_SELECT.REG0_OUT2_reg\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG1_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \<const1>\,
      Q => \n_0_CONFIG_SELECT.REG1_OUT2_reg_r\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG1_OUT_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_CONFIG_SELECT.REG5_OUT_reg\,
      O => \n_0_CONFIG_SELECT.REG1_OUT_i_1__0\
    );
\CONFIG_SELECT.REG1_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.REG1_OUT_i_1__0\,
      Q => REG1_OUT,
      R => REG5_OUT
    );
\CONFIG_SELECT.REG2_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.REG1_OUT2_reg_r\,
      Q => \n_0_CONFIG_SELECT.REG2_OUT2_reg_r\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG2_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => REG1_OUT,
      Q => REG2_OUT,
      R => REG5_OUT
    );
\CONFIG_SELECT.REG3_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.REG2_OUT2_reg_r\,
      Q => \n_0_CONFIG_SELECT.REG3_OUT2_reg_r\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG3_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => REG2_OUT,
      Q => REG3_OUT,
      R => REG5_OUT
    );
\CONFIG_SELECT.REG4_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.REG3_OUT2_reg_r\,
      Q => \n_0_CONFIG_SELECT.REG4_OUT2_reg_r\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r\: unisim.vcomponents.SRL16E
    port map (
      A0 => \<const1>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1\,
      Q => \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r\
    );
\CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_CONFIG_SELECT.REG0_OUT2_reg\,
      O => \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1\
    );
\CONFIG_SELECT.REG4_OUT_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => SR(0),
      I1 => REG4_OUT,
      I2 => I2,
      I3 => \n_0_CONFIG_SELECT.REG5_OUT_reg\,
      O => REG5_OUT
    );
\CONFIG_SELECT.REG4_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => REG3_OUT,
      Q => REG4_OUT,
      R => REG5_OUT
    );
\CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_rxgen_CONFIG_SELECT.REG5_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_rxgen_CONFIG_SELECT.REG4_OUT2_reg_r\,
      Q => \n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_rxgen_CONFIG_SELECT.REG5_OUT2_reg_r\,
      R => \<const0>\
    );
\CONFIG_SELECT.REG5_OUT2_reg_gate\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_rxgen_CONFIG_SELECT.REG5_OUT2_reg_r\,
      I1 => \n_0_CONFIG_SELECT.REG5_OUT2_reg_r\,
      O => \n_0_CONFIG_SELECT.REG5_OUT2_reg_gate\
    );
\CONFIG_SELECT.REG5_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.REG4_OUT2_reg_r\,
      Q => \n_0_CONFIG_SELECT.REG5_OUT2_reg_r\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG5_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => REG4_OUT,
      Q => \n_0_CONFIG_SELECT.REG5_OUT_reg\,
      R => REG5_OUT
    );
\CONFIG_SELECT.REG6_OUT2_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.REG5_OUT2_reg_gate\,
      Q => REG6_OUT2,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG7_OUT2_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => REG6_OUT2,
      Q => REG7_OUT2,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG8_OUT2_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => REG7_OUT2,
      Q => REG8_OUT2,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG9_OUT2_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => SR(0),
      I1 => REG9_OUT2,
      I2 => I2,
      I3 => \n_0_CONFIG_SELECT.REG0_OUT2_reg\,
      O => REG0_OUT2
    );
\CONFIG_SELECT.REG9_OUT2_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => REG8_OUT2,
      Q => REG9_OUT2,
      R => REG0_OUT2
    );
\CONFIG_SELECT.SPEED_0_RESYNC_REG_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => DATA_OUT,
      Q => SPEED_0_RESYNC_REG,
      R => SR(0)
    );
\CONFIG_SELECT.SPEED_0_SYNC\: entity work.\TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1\
    port map (
      I1 => I1,
      data_out => DATA_OUT,
      tx_configuration_vector(0) => tx_configuration_vector(0)
    );
\CONFIG_SELECT.SPEED_1_RESYNC_REG_reg\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.SPEED_1_SYNC\,
      Q => SPEED_1_RESYNC_REG,
      R => SR(0)
    );
\CONFIG_SELECT.SPEED_1_SYNC\: entity work.\TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_7\
    port map (
      I1 => I1,
      data_out => \n_0_CONFIG_SELECT.SPEED_1_SYNC\,
      tx_configuration_vector(0) => tx_configuration_vector(1)
    );
CRC_MODE_HELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_32_RX_SM,
      D => rx_configuration_vector(2),
      Q => n_0_CRC_MODE_HELD_reg,
      R => SR(0)
    );
DATA_VALID_EARLY_INT_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FF5500008000"
    )
    port map (
      I0 => I2,
      I1 => n_0_DATA_VALID_EARLY_INT_i_2,
      I2 => n_0_DATA_VALID_EARLY_INT_i_3,
      I3 => \^o1\,
      I4 => SR(0),
      I5 => \^o2\,
      O => n_0_DATA_VALID_EARLY_INT_i_1
    );
DATA_VALID_EARLY_INT_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => data_early(2),
      I1 => data_early(6),
      I2 => data_early(0),
      O => n_0_DATA_VALID_EARLY_INT_i_2
    );
DATA_VALID_EARLY_INT_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000100000"
    )
    port map (
      I0 => data_early(3),
      I1 => data_early(1),
      I2 => data_early(7),
      I3 => RX_ERR_REG1,
      I4 => data_early(4),
      I5 => data_early(5),
      O => n_0_DATA_VALID_EARLY_INT_i_3
    );
DATA_VALID_EARLY_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_0_DATA_VALID_EARLY_INT_i_1,
      Q => \^o2\,
      R => \<const0>\
    );
DATA_VALID_FINAL_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => DATA_VALID_FINAL0,
      Q => int_rx_data_valid_in,
      R => SR(0)
    );
DELAY_BROADCASTADDRESSMATCH: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => broadcastaddressmatch,
      Q => p_0_out_0(3)
    );
\DELAY_RXD_BUS[0].DELAY_RXD\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => data_early(0),
      Q => RXD_REG5(0)
    );
\DELAY_RXD_BUS[1].DELAY_RXD\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => data_early(1),
      Q => Q0_out
    );
\DELAY_RXD_BUS[2].DELAY_RXD\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => data_early(2),
      Q => Q1_out
    );
\DELAY_RXD_BUS[3].DELAY_RXD\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => data_early(3),
      Q => Q2_out
    );
\DELAY_RXD_BUS[4].DELAY_RXD\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => data_early(4),
      Q => Q3_out
    );
\DELAY_RXD_BUS[5].DELAY_RXD\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => data_early(5),
      Q => Q4_out
    );
\DELAY_RXD_BUS[6].DELAY_RXD\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => data_early(6),
      Q => Q5_out
    );
\DELAY_RXD_BUS[7].DELAY_RXD\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => data_early(7),
      Q => Q6_out
    );
DELAY_RX_DV1: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => \^o1\,
      Q => RX_DV_REG2
    );
DELAY_RX_DV2: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => n_0_RX_DV_REG3_reg,
      Q => RX_DV_REG5
    );
DELAY_RX_ERR: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const1>\,
      A1 => \<const0>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => I2,
      CLK => I1,
      D => RX_ERR_REG1,
      Q => RX_ERR_REG5
    );
ENABLE_REG_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => \n_0_CONFIG_SELECT.CALCULATE_CRC2\,
      Q => n_0_ENABLE_REG_reg,
      R => SR(0)
    );
EXTENSION_FLAG_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000800"
    )
    port map (
      I0 => n_0_EXTENSION_FLAG_i_2,
      I1 => RX_ERR_REG6,
      I2 => RX_DV_REG6,
      I3 => RXD_REG6(2),
      I4 => RXD_REG6(5),
      O => EXTENSION_FLAG0
    );
EXTENSION_FLAG_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000080"
    )
    port map (
      I0 => RXD_REG6(0),
      I1 => RXD_REG6(1),
      I2 => RXD_REG6(3),
      I3 => RXD_REG6(7),
      I4 => RXD_REG6(4),
      I5 => RXD_REG6(6),
      O => n_0_EXTENSION_FLAG_i_2
    );
EXTENSION_FLAG_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => EXTENSION_FLAG0,
      Q => EXTENSION_FLAG,
      R => SR(0)
    );
FALSE_CARR_FLAG_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => PRE_FALSE_CARR_FLAG,
      Q => FALSE_CARR_FLAG,
      R => SR(0)
    );
FCS_CHECK: entity work.TriMACCRC32_8
    port map (
      COMPUTE => COMPUTE,
      CRC_ENGINE_ERR0 => CRC_ENGINE_ERR0,
      FCS_FIELD => FCS_FIELD,
      I1 => n_20_RX_SM,
      I2 => n_19_RX_SM,
      I3 => I1,
      PREAMBLE_FIELD => PREAMBLE_FIELD,
      Q(7) => \n_0_RXD_REG7_reg[7]\,
      Q(6) => \n_0_RXD_REG7_reg[6]\,
      Q(5) => \n_0_RXD_REG7_reg[5]\,
      Q(4) => \n_0_RXD_REG7_reg[4]\,
      Q(3) => \n_0_RXD_REG7_reg[3]\,
      Q(2) => \n_0_RXD_REG7_reg[2]\,
      Q(1) => \n_0_RXD_REG7_reg[1]\,
      Q(0) => \n_0_RXD_REG7_reg[0]\,
      SFD_FLAG => SFD_FLAG
    );
FRAME_CHECKER: entity work.\TriMACPARAM_CHECK__parameterized0\
    port map (
      ALIGNMENT_ERR => ALIGNMENT_ERR,
      ALIGNMENT_ERR_REG => \^alignment_err_reg\,
      BAD_FRAME_INT0_out => BAD_FRAME_INT0_out,
      CRC_ENGINE_ERR0 => CRC_ENGINE_ERR0,
      D(5 downto 4) => p_0_out_0(24 downto 23),
      D(3) => p_0_out_0(20),
      D(2 downto 0) => p_0_out_0(2 downto 0),
      EXCEEDED_MIN_LEN => EXCEEDED_MIN_LEN,
      FRAME_LEN_ERR => FRAME_LEN_ERR,
      GOOD_FRAME_INT => GOOD_FRAME_INT,
      I1 => I1,
      I2 => I2,
      I3 => n_33_RX_SM,
      I4 => n_35_RX_SM,
      I5 => n_34_RX_SM,
      I6 => n_30_RX_SM,
      I7 => n_36_FRAME_DECODER,
      I8 => \^end_of_frame\,
      I9 => n_0_JUMBO_FRAMES_HELD_reg,
      INHIBIT_FRAME => INHIBIT_FRAME,
      INHIBIT_FRAME0 => INHIBIT_FRAME0,
      MATCH_FRAME_INT => MATCH_FRAME_INT,
      MAX_LENGTH_ERR3_out => MAX_LENGTH_ERR3_out,
      O1 => n_1_FRAME_CHECKER,
      O2 => n_11_FRAME_CHECKER,
      O3 => n_12_FRAME_CHECKER,
      O4 => n_14_FRAME_CHECKER,
      PREAMBLE_FIELD => PREAMBLE_FIELD,
      SR(0) => SR(0),
      TYPE_FRAME => TYPE_FRAME,
      VALIDATE_REQUIRED => VALIDATE_REQUIRED,
      p_8_in => p_8_in
    );
FRAME_DECODER: entity work.TriMACDECODE_FRAME
    port map (
      COMPUTE => COMPUTE,
      CONTROL_FRAME_INT => CONTROL_FRAME_INT,
      CONTROL_MATCH => CONTROL_MATCH,
      CONTROL_MATCH0 => CONTROL_MATCH0,
      CRC_COMPUTE0 => CRC_COMPUTE0,
      D(17) => p_0_out_0(22),
      D(16) => VLAN_FRAME,
      D(15) => int_rx_control_frame_any_da,
      D(14 downto 0) => p_0_out_0(18 downto 4),
      DATA_FIELD => DATA_FIELD,
      DATA_NO_FCS => DATA_NO_FCS,
      DATA_NO_FCS0 => DATA_NO_FCS0,
      DATA_VALID_FINAL0 => DATA_VALID_FINAL0,
      DATA_WITH_FCS => DATA_WITH_FCS,
      DATA_WITH_FCS0 => DATA_WITH_FCS0,
      E(0) => E(0),
      END_OF_DATA => END_OF_DATA,
      EXCEEDED_MIN_LEN => EXCEEDED_MIN_LEN,
      EXTENSION_FIELD => EXTENSION_FIELD,
      FIELD_COUNTER(0) => FIELD_COUNTER(1),
      I1 => I1,
      I10 => \^end_of_frame\,
      I11(14) => \n_0_MAX_FRAME_LENGTH_HELD_reg[14]\,
      I11(13) => \n_0_MAX_FRAME_LENGTH_HELD_reg[13]\,
      I11(12) => \n_0_MAX_FRAME_LENGTH_HELD_reg[12]\,
      I11(11) => \n_0_MAX_FRAME_LENGTH_HELD_reg[11]\,
      I11(10) => \n_0_MAX_FRAME_LENGTH_HELD_reg[10]\,
      I11(9) => \n_0_MAX_FRAME_LENGTH_HELD_reg[9]\,
      I11(8) => \n_0_MAX_FRAME_LENGTH_HELD_reg[8]\,
      I11(7) => \n_0_MAX_FRAME_LENGTH_HELD_reg[7]\,
      I11(6) => \n_0_MAX_FRAME_LENGTH_HELD_reg[6]\,
      I11(5) => \n_0_MAX_FRAME_LENGTH_HELD_reg[5]\,
      I11(4) => \n_0_MAX_FRAME_LENGTH_HELD_reg[4]\,
      I11(3) => \n_0_MAX_FRAME_LENGTH_HELD_reg[3]\,
      I11(2) => \n_0_MAX_FRAME_LENGTH_HELD_reg[2]\,
      I11(1) => \n_0_MAX_FRAME_LENGTH_HELD_reg[1]\,
      I11(0) => \n_0_MAX_FRAME_LENGTH_HELD_reg[0]\,
      I12 => n_0_MAX_FRAME_ENABLE_HELD_reg,
      I13 => n_12_FRAME_CHECKER,
      I14 => I6,
      I15 => I8,
      I16 => n_28_RX_SM,
      I17 => n_14_FRAME_CHECKER,
      I18(0) => p_3_out_0(0),
      I19 => n_20_RX_SM,
      I2 => I2,
      I20 => n_7_RX_SM,
      I21(0) => I14(0),
      I22(0) => n_24_RX_SM,
      I3 => n_25_RX_SM,
      I4 => n_27_RX_SM,
      I5 => n_29_RX_SM,
      I6 => \^int_rx_good_frame_in\,
      I7 => I4,
      I8 => I5,
      I9 => n_0_CRC_MODE_HELD_reg,
      LENGTH_FIELD => LENGTH_FIELD,
      LENGTH_FIELD_MATCH => LENGTH_FIELD_MATCH,
      LENGTH_ONE => LENGTH_ONE,
      LENGTH_ONE0 => LENGTH_ONE0,
      LENGTH_ZERO => LENGTH_ZERO,
      LENGTH_ZERO0 => LENGTH_ZERO0,
      LESS_THAN_256 => LESS_THAN_256,
      LESS_THAN_2560 => LESS_THAN_2560,
      LT_CHECK_HELD => LT_CHECK_HELD,
      MAX_LENGTH_ERR3_out => MAX_LENGTH_ERR3_out,
      MULTICAST_MATCH => MULTICAST_MATCH,
      O1 => n_31_FRAME_DECODER,
      O2 => n_32_FRAME_DECODER,
      O3 => n_33_FRAME_DECODER,
      O4 => n_34_FRAME_DECODER,
      O5 => n_36_FRAME_DECODER,
      O6 => n_38_FRAME_DECODER,
      O7 => n_40_FRAME_DECODER,
      PAUSE_LT_CHECK_HELD => PAUSE_LT_CHECK_HELD,
      Q(7) => \n_0_RXD_REG7_reg[7]\,
      Q(6) => \n_0_RXD_REG7_reg[6]\,
      Q(5) => \n_0_RXD_REG7_reg[5]\,
      Q(4) => \n_0_RXD_REG7_reg[4]\,
      Q(3) => \n_0_RXD_REG7_reg[3]\,
      Q(2) => \n_0_RXD_REG7_reg[2]\,
      Q(1) => \n_0_RXD_REG7_reg[1]\,
      Q(0) => \n_0_RXD_REG7_reg[0]\,
      RX_DV_REG7 => RX_DV_REG7,
      SR(0) => SR(0),
      TYPE_FRAME => TYPE_FRAME,
      TYPE_PACKET10_out => TYPE_PACKET10_out,
      VALIDATE_REQUIRED => VALIDATE_REQUIRED,
      address_valid_early => address_valid_early,
      int_rx_control_frame => int_rx_control_frame,
      pauseaddressmatch => pauseaddressmatch,
      rx_enable_reg => rx_enable_reg,
      rx_statistics_vector(0) => rx_statistics_vector(23),
      specialpauseaddressmatch => specialpauseaddressmatch
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
GOOD_FRAME_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => GOOD_FRAME_INT,
      Q => \^int_rx_good_frame_in\,
      R => SR(0)
    );
\G_NO_1588_HOOKS.DATA_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG8(0),
      Q => \^o9\(0),
      R => SR(0)
    );
\G_NO_1588_HOOKS.DATA_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG8(1),
      Q => \^o9\(1),
      R => SR(0)
    );
\G_NO_1588_HOOKS.DATA_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG8(2),
      Q => \^o9\(2),
      R => SR(0)
    );
\G_NO_1588_HOOKS.DATA_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG8(3),
      Q => \^o9\(3),
      R => SR(0)
    );
\G_NO_1588_HOOKS.DATA_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG8(4),
      Q => \^o9\(4),
      R => SR(0)
    );
\G_NO_1588_HOOKS.DATA_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG8(5),
      Q => \^o9\(5),
      R => SR(0)
    );
\G_NO_1588_HOOKS.DATA_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG8(6),
      Q => \^o9\(6),
      R => SR(0)
    );
\G_NO_1588_HOOKS.DATA_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG8(7),
      Q => \^o9\(7),
      R => SR(0)
    );
IFG_FLAG_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => PRE_IFG_FLAG,
      Q => IFG_FLAG,
      R => SR(0)
    );
JUMBO_FRAMES_HELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_32_RX_SM,
      D => rx_configuration_vector(3),
      Q => n_0_JUMBO_FRAMES_HELD_reg,
      R => SR(0)
    );
LT_CHECK_HELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_32_RX_SM,
      D => rx_configuration_vector(4),
      Q => LT_CHECK_HELD,
      R => SR(0)
    );
MATCH_FRAME_INT_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_26_RX_SM,
      Q => MATCH_FRAME_INT,
      R => \<const0>\
    );
MAX_FRAME_ENABLE_HELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_32_RX_SM,
      D => rx_configuration_vector(6),
      Q => n_0_MAX_FRAME_ENABLE_HELD_reg,
      R => SR(0)
    );
\MAX_FRAME_LENGTH_HELD[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => rx_configuration_vector(6),
      I1 => rx_configuration_vector(7),
      O => \n_0_MAX_FRAME_LENGTH_HELD[0]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => rx_configuration_vector(17),
      I1 => rx_configuration_vector(6),
      O => \n_0_MAX_FRAME_LENGTH_HELD[10]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => rx_configuration_vector(6),
      I1 => rx_configuration_vector(18),
      O => \n_0_MAX_FRAME_LENGTH_HELD[11]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => rx_configuration_vector(6),
      I1 => rx_configuration_vector(19),
      O => \n_0_MAX_FRAME_LENGTH_HELD[12]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => rx_configuration_vector(6),
      I1 => rx_configuration_vector(20),
      O => \n_0_MAX_FRAME_LENGTH_HELD[13]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[14]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => rx_configuration_vector(6),
      I1 => rx_configuration_vector(21),
      O => \n_0_MAX_FRAME_LENGTH_HELD[14]_i_2\
    );
\MAX_FRAME_LENGTH_HELD[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => rx_configuration_vector(8),
      I1 => rx_configuration_vector(6),
      O => \n_0_MAX_FRAME_LENGTH_HELD[1]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => rx_configuration_vector(9),
      I1 => rx_configuration_vector(6),
      O => \n_0_MAX_FRAME_LENGTH_HELD[2]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => rx_configuration_vector(10),
      I1 => rx_configuration_vector(6),
      O => \n_0_MAX_FRAME_LENGTH_HELD[3]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => rx_configuration_vector(6),
      I1 => rx_configuration_vector(11),
      O => \n_0_MAX_FRAME_LENGTH_HELD[4]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => rx_configuration_vector(12),
      I1 => rx_configuration_vector(6),
      O => \n_0_MAX_FRAME_LENGTH_HELD[5]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => rx_configuration_vector(13),
      I1 => rx_configuration_vector(6),
      O => \n_0_MAX_FRAME_LENGTH_HELD[6]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => rx_configuration_vector(14),
      I1 => rx_configuration_vector(6),
      O => \n_0_MAX_FRAME_LENGTH_HELD[7]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => rx_configuration_vector(15),
      I1 => rx_configuration_vector(6),
      O => \n_0_MAX_FRAME_LENGTH_HELD[8]_i_1\
    );
\MAX_FRAME_LENGTH_HELD[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => rx_configuration_vector(6),
      I1 => rx_configuration_vector(16),
      O => \n_0_MAX_FRAME_LENGTH_HELD[9]_i_1\
    );
\MAX_FRAME_LENGTH_HELD_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[0]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[0]\,
      R => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[10]\: unisim.vcomponents.FDSE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[10]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[10]\,
      S => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[11]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[11]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[11]\,
      R => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[12]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[12]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[12]\,
      R => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[13]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[13]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[13]\,
      R => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[14]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[14]_i_2\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[14]\,
      R => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[1]\: unisim.vcomponents.FDSE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[1]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[1]\,
      S => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[2]\: unisim.vcomponents.FDSE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[2]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[2]\,
      S => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[3]\: unisim.vcomponents.FDSE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[3]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[3]\,
      S => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[4]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[4]\,
      R => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[5]\: unisim.vcomponents.FDSE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[5]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[5]\,
      S => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[6]\: unisim.vcomponents.FDSE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[6]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[6]\,
      S => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[7]\: unisim.vcomponents.FDSE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[7]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[7]\,
      S => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[8]\: unisim.vcomponents.FDSE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[8]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[8]\,
      S => SR(0)
    );
\MAX_FRAME_LENGTH_HELD_reg[9]\: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_31_RX_SM,
      D => \n_0_MAX_FRAME_LENGTH_HELD[9]_i_1\,
      Q => \n_0_MAX_FRAME_LENGTH_HELD_reg[9]\,
      R => SR(0)
    );
PAUSE_LT_CHECK_HELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_32_RX_SM,
      D => rx_configuration_vector(5),
      Q => PAUSE_LT_CHECK_HELD,
      R => SR(0)
    );
\RXD_REG1_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => D(0),
      Q => data_early(0),
      R => \<const0>\
    );
\RXD_REG1_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => D(1),
      Q => data_early(1),
      R => \<const0>\
    );
\RXD_REG1_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => D(2),
      Q => data_early(2),
      R => \<const0>\
    );
\RXD_REG1_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => D(3),
      Q => data_early(3),
      R => \<const0>\
    );
\RXD_REG1_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => D(4),
      Q => data_early(4),
      R => \<const0>\
    );
\RXD_REG1_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => D(5),
      Q => data_early(5),
      R => \<const0>\
    );
\RXD_REG1_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => D(6),
      Q => data_early(6),
      R => \<const0>\
    );
\RXD_REG1_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => D(7),
      Q => data_early(7),
      R => \<const0>\
    );
\RXD_REG6_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG5(0),
      Q => RXD_REG6(0),
      R => \<const0>\
    );
\RXD_REG6_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => Q0_out,
      Q => RXD_REG6(1),
      R => \<const0>\
    );
\RXD_REG6_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => Q1_out,
      Q => RXD_REG6(2),
      R => \<const0>\
    );
\RXD_REG6_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => Q2_out,
      Q => RXD_REG6(3),
      R => \<const0>\
    );
\RXD_REG6_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => Q3_out,
      Q => RXD_REG6(4),
      R => \<const0>\
    );
\RXD_REG6_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => Q4_out,
      Q => RXD_REG6(5),
      R => \<const0>\
    );
\RXD_REG6_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => Q5_out,
      Q => RXD_REG6(6),
      R => \<const0>\
    );
\RXD_REG6_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => Q6_out,
      Q => RXD_REG6(7),
      R => \<const0>\
    );
\RXD_REG7_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG6(0),
      Q => \n_0_RXD_REG7_reg[0]\,
      R => \<const0>\
    );
\RXD_REG7_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG6(1),
      Q => \n_0_RXD_REG7_reg[1]\,
      R => \<const0>\
    );
\RXD_REG7_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG6(2),
      Q => \n_0_RXD_REG7_reg[2]\,
      R => \<const0>\
    );
\RXD_REG7_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG6(3),
      Q => \n_0_RXD_REG7_reg[3]\,
      R => \<const0>\
    );
\RXD_REG7_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG6(4),
      Q => \n_0_RXD_REG7_reg[4]\,
      R => \<const0>\
    );
\RXD_REG7_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG6(5),
      Q => \n_0_RXD_REG7_reg[5]\,
      R => \<const0>\
    );
\RXD_REG7_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG6(6),
      Q => \n_0_RXD_REG7_reg[6]\,
      R => \<const0>\
    );
\RXD_REG7_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RXD_REG6(7),
      Q => \n_0_RXD_REG7_reg[7]\,
      R => \<const0>\
    );
\RXD_REG8_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => \n_0_RXD_REG7_reg[0]\,
      Q => RXD_REG8(0),
      R => \<const0>\
    );
\RXD_REG8_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => \n_0_RXD_REG7_reg[1]\,
      Q => RXD_REG8(1),
      R => \<const0>\
    );
\RXD_REG8_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => \n_0_RXD_REG7_reg[2]\,
      Q => RXD_REG8(2),
      R => \<const0>\
    );
\RXD_REG8_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => \n_0_RXD_REG7_reg[3]\,
      Q => RXD_REG8(3),
      R => \<const0>\
    );
\RXD_REG8_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => \n_0_RXD_REG7_reg[4]\,
      Q => RXD_REG8(4),
      R => \<const0>\
    );
\RXD_REG8_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => \n_0_RXD_REG7_reg[5]\,
      Q => RXD_REG8(5),
      R => \<const0>\
    );
\RXD_REG8_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => \n_0_RXD_REG7_reg[6]\,
      Q => RXD_REG8(6),
      R => \<const0>\
    );
\RXD_REG8_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => \n_0_RXD_REG7_reg[7]\,
      Q => RXD_REG8(7),
      R => \<const0>\
    );
RX_DV_REG1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => gmii_rx_dv_from_mii,
      Q => \^o1\,
      R => \<const0>\
    );
RX_DV_REG3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RX_DV_REG2,
      Q => n_0_RX_DV_REG3_reg,
      R => \<const0>\
    );
RX_DV_REG6_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RX_DV_REG5,
      Q => RX_DV_REG6,
      R => \<const0>\
    );
RX_DV_REG7_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RX_DV_REG6,
      Q => RX_DV_REG7,
      R => \<const0>\
    );
RX_ERR_REG1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => gmii_rx_er_from_mii,
      Q => RX_ERR_REG1,
      R => \<const0>\
    );
RX_ERR_REG6_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RX_ERR_REG5,
      Q => RX_ERR_REG6,
      R => \<const0>\
    );
RX_ERR_REG7_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => RX_ERR_REG6,
      Q => RX_ERR_REG7,
      R => \<const0>\
    );
RX_SM: entity work.TriMACSTATE_MACHINES
    port map (
      ALIGNMENT_ERR => ALIGNMENT_ERR,
      COMPUTE => COMPUTE,
      CONTROL_FRAME_INT => CONTROL_FRAME_INT,
      CONTROL_MATCH => CONTROL_MATCH,
      CONTROL_MATCH0 => CONTROL_MATCH0,
      CRC_COMPUTE0 => CRC_COMPUTE0,
      D(7) => Q6_out,
      D(6) => Q5_out,
      D(5) => Q4_out,
      D(4) => Q3_out,
      D(3) => Q2_out,
      D(2) => Q1_out,
      D(1) => Q0_out,
      D(0) => RXD_REG5(0),
      DATA_FIELD => DATA_FIELD,
      DATA_NO_FCS => DATA_NO_FCS,
      DATA_NO_FCS0 => DATA_NO_FCS0,
      DATA_WITH_FCS => DATA_WITH_FCS,
      DATA_WITH_FCS0 => DATA_WITH_FCS0,
      E(0) => n_31_RX_SM,
      END_OF_DATA => END_OF_DATA,
      EXCEEDED_MIN_LEN => EXCEEDED_MIN_LEN,
      EXTENSION_FIELD => EXTENSION_FIELD,
      EXTENSION_FLAG => EXTENSION_FLAG,
      FALSE_CARR_FLAG => FALSE_CARR_FLAG,
      FCS_FIELD => FCS_FIELD,
      FRAME_LEN_ERR => FRAME_LEN_ERR,
      I1 => I1,
      I10 => n_1_FRAME_CHECKER,
      I11 => n_38_FRAME_DECODER,
      I12 => n_12_FRAME_CHECKER,
      I13 => n_0_RX_DV_REG3_reg,
      I18(0) => p_3_out_0(0),
      I2 => I2,
      I22(0) => n_24_RX_SM,
      I3 => n_0_ENABLE_REG_reg,
      I4 => n_32_FRAME_DECODER,
      I5 => n_31_FRAME_DECODER,
      I6 => n_33_FRAME_DECODER,
      I7 => n_0_VLAN_ENABLE_HELD_reg,
      I8 => n_0_SPEED_IS_10_100_HELD_reg,
      I9 => n_34_FRAME_DECODER,
      IFG_FLAG => IFG_FLAG,
      INHIBIT_FRAME => INHIBIT_FRAME,
      INHIBIT_FRAME0 => INHIBIT_FRAME0,
      LENGTH_FIELD => LENGTH_FIELD,
      LENGTH_FIELD_MATCH => LENGTH_FIELD_MATCH,
      LENGTH_ONE => LENGTH_ONE,
      LENGTH_ONE0 => LENGTH_ONE0,
      LENGTH_ZERO => LENGTH_ZERO,
      LENGTH_ZERO0 => LENGTH_ZERO0,
      LESS_THAN_256 => LESS_THAN_256,
      LESS_THAN_2560 => LESS_THAN_2560,
      LT_CHECK_HELD => LT_CHECK_HELD,
      MATCH_FRAME_INT => MATCH_FRAME_INT,
      MATCH_FRAME_INT0 => MATCH_FRAME_INT0,
      MULTICAST_MATCH => MULTICAST_MATCH,
      O1 => \^end_of_frame\,
      O10 => n_29_RX_SM,
      O11 => n_30_RX_SM,
      O12 => n_32_RX_SM,
      O13 => n_33_RX_SM,
      O14 => n_34_RX_SM,
      O15 => n_35_RX_SM,
      O2 => n_7_RX_SM,
      O3(0) => FIELD_COUNTER(1),
      O4 => n_19_RX_SM,
      O5 => n_20_RX_SM,
      O6 => n_25_RX_SM,
      O7 => n_26_RX_SM,
      O8 => n_27_RX_SM,
      O9 => n_28_RX_SM,
      PREAMBLE_FIELD => PREAMBLE_FIELD,
      PRE_FALSE_CARR_FLAG => PRE_FALSE_CARR_FLAG,
      PRE_IFG_FLAG => PRE_IFG_FLAG,
      Q(7) => \n_0_RXD_REG7_reg[7]\,
      Q(6) => \n_0_RXD_REG7_reg[6]\,
      Q(5) => \n_0_RXD_REG7_reg[5]\,
      Q(4) => \n_0_RXD_REG7_reg[4]\,
      Q(3) => \n_0_RXD_REG7_reg[3]\,
      Q(2) => \n_0_RXD_REG7_reg[2]\,
      Q(1) => \n_0_RXD_REG7_reg[1]\,
      Q(0) => \n_0_RXD_REG7_reg[0]\,
      RX_DV_REG2 => RX_DV_REG2,
      RX_DV_REG5 => RX_DV_REG5,
      RX_DV_REG6 => RX_DV_REG6,
      RX_DV_REG7 => RX_DV_REG7,
      RX_ERR_REG5 => RX_ERR_REG5,
      RX_ERR_REG6 => RX_ERR_REG6,
      RX_ERR_REG7 => RX_ERR_REG7,
      SFD_FLAG => SFD_FLAG,
      SR(0) => SR(0),
      TYPE_FRAME => TYPE_FRAME,
      TYPE_PACKET10_out => TYPE_PACKET10_out,
      alignment_err_reg => alignment_err_reg,
      broadcastaddressmatch => broadcastaddressmatch,
      int_alignment_err_pulse => int_alignment_err_pulse,
      p_8_in => p_8_in
    );
SFD_FLAG_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000800"
    )
    port map (
      I0 => n_0_SFD_FLAG_i_2,
      I1 => RXD_REG6(0),
      I2 => RXD_REG6(1),
      I3 => RXD_REG6(2),
      I4 => RXD_REG6(5),
      O => SFD_FLAG0
    );
SFD_FLAG_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0040000000000000"
    )
    port map (
      I0 => RXD_REG6(3),
      I1 => RXD_REG6(4),
      I2 => RX_DV_REG6,
      I3 => RX_ERR_REG6,
      I4 => RXD_REG6(6),
      I5 => RXD_REG6(7),
      O => n_0_SFD_FLAG_i_2
    );
SFD_FLAG_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => I2,
      D => SFD_FLAG0,
      Q => SFD_FLAG,
      R => SR(0)
    );
SPEED_IS_10_100_HELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_32_RX_SM,
      D => \^o3\,
      Q => n_0_SPEED_IS_10_100_HELD_reg,
      R => SR(0)
    );
STATISTICS_VALID_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => n_11_FRAME_CHECKER,
      Q => rx_statistics_valid,
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(0),
      Q => rx_statistics_vector(0),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(10),
      Q => rx_statistics_vector(10),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(11),
      Q => rx_statistics_vector(11),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(12),
      Q => rx_statistics_vector(12),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(13),
      Q => rx_statistics_vector(13),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(14),
      Q => rx_statistics_vector(14),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(15),
      Q => rx_statistics_vector(15),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(16),
      Q => rx_statistics_vector(16),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(17),
      Q => rx_statistics_vector(17),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(18),
      Q => rx_statistics_vector(18),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => int_rx_control_frame_any_da,
      Q => rx_statistics_vector(19),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(1),
      Q => rx_statistics_vector(1),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(20),
      Q => rx_statistics_vector(20),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => VLAN_FRAME,
      Q => rx_statistics_vector(21),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(22),
      Q => rx_statistics_vector(22),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(23),
      Q => rx_statistics_vector(24),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(24),
      Q => rx_statistics_vector(25),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(2),
      Q => rx_statistics_vector(2),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(3),
      Q => rx_statistics_vector(3),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(4),
      Q => rx_statistics_vector(4),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(5),
      Q => rx_statistics_vector(5),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(6),
      Q => rx_statistics_vector(6),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(7),
      Q => rx_statistics_vector(7),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(8),
      Q => rx_statistics_vector(8),
      R => \<const0>\
    );
\STATISTICS_VECTOR_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => I1,
      CE => I2,
      D => p_0_out_0(9),
      Q => rx_statistics_vector(9),
      R => \<const0>\
    );
VALIDATE_REQUIRED_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => n_40_FRAME_DECODER,
      Q => VALIDATE_REQUIRED,
      R => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
VLAN_ENABLE_HELD_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => n_32_RX_SM,
      D => rx_configuration_vector(1),
      Q => n_0_VLAN_ENABLE_HELD_reg,
      R => SR(0)
    );
bad_fc_opcode_int_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => \^o9\(3),
      I1 => \^o9\(2),
      I2 => \^o9\(6),
      I3 => \^o9\(7),
      I4 => \^o9\(4),
      I5 => \^o9\(5),
      O => O8
    );
broadcast_byte_match_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"888F8880"
    )
    port map (
      I0 => n_0_DATA_VALID_EARLY_INT_i_2,
      I1 => n_0_broadcast_byte_match_i_2,
      I2 => SR(0),
      I3 => I2,
      I4 => broadcast_byte_match,
      O => O7
    );
broadcast_byte_match_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000000000"
    )
    port map (
      I0 => data_early(3),
      I1 => data_early(1),
      I2 => data_early(7),
      I3 => SR(0),
      I4 => data_early(4),
      I5 => data_early(5),
      O => n_0_broadcast_byte_match_i_2
    );
check_opcode_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEAA"
    )
    port map (
      I0 => SR(0),
      I1 => \^int_rx_good_frame_in\,
      I2 => \^int_rx_bad_frame_in\,
      I3 => I2,
      O => bad_pfc_opcode_int
    );
\counter[5]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFAAAAAA"
    )
    port map (
      I0 => SR(0),
      I1 => \^o1\,
      I2 => \^o2\,
      I3 => I2,
      I4 => rx_data_valid_reg1,
      O => I7(0)
    );
delay_rx_data_valid_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \^o1\,
      I1 => \^o2\,
      O => data_valid_early
    );
\load_count_pipe[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AABFBFAA"
    )
    port map (
      I0 => SR(0),
      I1 => \^o1\,
      I2 => \^o2\,
      I3 => update_pause_ad_sync,
      I4 => update_pause_ad_sync_reg,
      O => O6
    );
pause_match_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000000000"
    )
    port map (
      I0 => data_early(0),
      I1 => p_10_out,
      I2 => data_early(1),
      I3 => p_6_out,
      I4 => n_0_pause_match_reg_i_2,
      I5 => n_0_pause_match_reg_i_3,
      O => pause_match_reg0
    );
pause_match_reg_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => data_early(4),
      I1 => p_3_out,
      I2 => data_early(7),
      I3 => p_0_out,
      I4 => p_4_out,
      I5 => data_early(3),
      O => n_0_pause_match_reg_i_2
    );
pause_match_reg_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => data_early(5),
      I1 => p_2_out,
      I2 => data_early(6),
      I3 => p_1_out,
      I4 => p_5_out,
      I5 => data_early(2),
      O => n_0_pause_match_reg_i_3
    );
\pause_opcode_early[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEAA"
    )
    port map (
      I0 => SR(0),
      I1 => \^int_rx_good_frame_in\,
      I2 => \^int_rx_bad_frame_in\,
      I3 => I2,
      O => O5(0)
    );
\pause_value[15]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => \^int_rx_bad_frame_in\,
      I1 => \^int_rx_good_frame_in\,
      I2 => Q(0),
      I3 => I2,
      O => O4
    );
rx_bad_frame_int_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => \^int_rx_bad_frame_in\,
      I1 => I3,
      I2 => \^int_rx_good_frame_in\,
      O => rx_bad_frame_comb
    );
special_pause_match_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000000000"
    )
    port map (
      I0 => data_early(4),
      I1 => I9,
      I2 => data_early(1),
      I3 => p_9_out,
      I4 => n_0_special_pause_match_reg_i_2,
      I5 => n_0_special_pause_match_reg_i_3,
      O => special_pause_match_comb
    );
special_pause_match_reg_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => data_early(7),
      I1 => I10,
      I2 => data_early(2),
      I3 => p_8_out,
      I4 => p_7_out,
      I5 => data_early(3),
      O => n_0_special_pause_match_reg_i_2
    );
special_pause_match_reg_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => data_early(5),
      I1 => I11,
      I2 => data_early(0),
      I3 => I12,
      I4 => I13,
      I5 => data_early(6),
      O => n_0_special_pause_match_reg_i_3
    );
speedis10100_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => tx_configuration_vector(1),
      O => \^o3\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_addr_filter_wrap is
  port (
    p_10_out : out STD_LOGIC;
    p_6_out : out STD_LOGIC;
    p_5_out : out STD_LOGIC;
    p_4_out : out STD_LOGIC;
    p_3_out : out STD_LOGIC;
    p_2_out : out STD_LOGIC;
    p_1_out : out STD_LOGIC;
    p_0_out : out STD_LOGIC;
    O1 : out STD_LOGIC;
    p_9_out : out STD_LOGIC;
    p_8_out : out STD_LOGIC;
    p_7_out : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    rx_data_valid_reg1 : out STD_LOGIC;
    address_valid_early : out STD_LOGIC;
    pauseaddressmatch : out STD_LOGIC;
    broadcastaddressmatch : out STD_LOGIC;
    specialpauseaddressmatch : out STD_LOGIC;
    broadcast_byte_match : out STD_LOGIC;
    update_pause_ad_sync_reg : out STD_LOGIC;
    data_out : out STD_LOGIC;
    MATCH_FRAME_INT0 : out STD_LOGIC;
    rxstatsaddressmatch : out STD_LOGIC;
    I2 : in STD_LOGIC;
    data_valid_early : in STD_LOGIC;
    I1 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    pause_match_reg0 : in STD_LOGIC;
    special_pause_match_comb : in STD_LOGIC;
    I3 : in STD_LOGIC;
    I4 : in STD_LOGIC;
    I5 : in STD_LOGIC;
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 48 downto 0 );
    I6 : in STD_LOGIC;
    I7 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end TriMACtri_mode_ethernet_mac_v8_1_addr_filter_wrap;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_addr_filter_wrap is
begin
address_filter_inst: entity work.TriMACtri_mode_ethernet_mac_v8_1_addr_filter
    port map (
      I1 => I1,
      I2 => I2,
      I3 => I3,
      I4 => I4,
      I5 => I5,
      I6 => I6,
      I7(0) => I7(0),
      MATCH_FRAME_INT0 => MATCH_FRAME_INT0,
      O1 => O1,
      O2 => O2,
      O3 => O3,
      O4 => O4,
      O5 => O5,
      O6 => rx_data_valid_reg1,
      SR(0) => SR(0),
      address_valid_early => address_valid_early,
      broadcast_byte_match => broadcast_byte_match,
      broadcastaddressmatch => broadcastaddressmatch,
      data_out => data_out,
      data_valid_early => data_valid_early,
      p_0_out => p_0_out,
      p_10_out => p_10_out,
      p_1_out => p_1_out,
      p_2_out => p_2_out,
      p_3_out => p_3_out,
      p_4_out => p_4_out,
      p_5_out => p_5_out,
      p_6_out => p_6_out,
      p_7_out => p_7_out,
      p_8_out => p_8_out,
      p_9_out => p_9_out,
      pause_match_reg0 => pause_match_reg0,
      pauseaddressmatch => pauseaddressmatch,
      rx_configuration_vector(48 downto 0) => rx_configuration_vector(48 downto 0),
      rxstatsaddressmatch => rxstatsaddressmatch,
      special_pause_match_comb => special_pause_match_comb,
      specialpauseaddressmatch => specialpauseaddressmatch,
      update_pause_ad_sync_reg => update_pause_ad_sync_reg
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1_control is
  port (
    data_avail_in_reg : out STD_LOGIC;
    rx_enable_reg : out STD_LOGIC;
    tx_underrun_int_0 : out STD_LOGIC;
    load_source : out STD_LOGIC;
    sample : out STD_LOGIC;
    tx_ack_int : out STD_LOGIC;
    O1 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    rx_statistics_vector : out STD_LOGIC_VECTOR ( 0 to 0 );
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    O9 : out STD_LOGIC;
    int_tx_data_valid_out : out STD_LOGIC;
    O10 : out STD_LOGIC;
    int_tx_crc_enable_out : out STD_LOGIC;
    int_tx_vlan_enable_out : out STD_LOGIC;
    rx_mac_tuser0 : out STD_LOGIC;
    rx_mac_tlast0 : out STD_LOGIC;
    next_rx_state : out STD_LOGIC_VECTOR ( 1 downto 0 );
    I11 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_mac_tvalid0 : out STD_LOGIC;
    O11 : out STD_LOGIC;
    O12 : out STD_LOGIC;
    O13 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_statistics_vector : out STD_LOGIC_VECTOR ( 0 to 0 );
    I1 : in STD_LOGIC;
    tx_ce_sample : in STD_LOGIC;
    tx_data_valid_int : in STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    int_tx_ack_in : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    rx_bad_frame_comb : in STD_LOGIC;
    int_rx_data_valid_in : in STD_LOGIC;
    tx_underrun_int : in STD_LOGIC;
    I4 : in STD_LOGIC;
    int_rx_control_frame : in STD_LOGIC;
    int_rx_good_frame_in : in STD_LOGIC;
    I5 : in STD_LOGIC;
    I6 : in STD_LOGIC;
    REG_DATA_VALID : in STD_LOGIC;
    I7 : in STD_LOGIC;
    INT_ENABLE : in STD_LOGIC;
    I8 : in STD_LOGIC;
    I9 : in STD_LOGIC;
    MAX_PKT_LEN_REACHED : in STD_LOGIC;
    pause_req : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 50 downto 0 );
    rx_state : in STD_LOGIC_VECTOR ( 1 downto 0 );
    pause_val : in STD_LOGIC_VECTOR ( 15 downto 0 );
    bad_pfc_opcode_int : in STD_LOGIC;
    I10 : in STD_LOGIC;
    I12 : in STD_LOGIC;
    I13 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 0 to 0 );
    int_rx_bad_frame_in : in STD_LOGIC;
    I14 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I15 : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 7 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    tx_statistics_valid : in STD_LOGIC;
    I16 : in STD_LOGIC;
    I17 : in STD_LOGIC;
    I18 : in STD_LOGIC
  );
end TriMACtri_mode_ethernet_mac_v8_1_control;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1_control is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal control_complete : STD_LOGIC;
  signal n_0_sync_rx_enable : STD_LOGIC;
  signal n_0_sync_tx_enable : STD_LOGIC;
  signal n_10_pfc_tx : STD_LOGIC;
  signal n_10_rx : STD_LOGIC;
  signal n_11_pfc_tx : STD_LOGIC;
  signal n_11_rx : STD_LOGIC;
  signal n_12_pfc_tx : STD_LOGIC;
  signal n_12_rx : STD_LOGIC;
  signal n_13_pfc_tx : STD_LOGIC;
  signal n_13_rx : STD_LOGIC;
  signal n_14_pfc_tx : STD_LOGIC;
  signal n_14_rx : STD_LOGIC;
  signal n_15_pfc_tx : STD_LOGIC;
  signal n_15_rx : STD_LOGIC;
  signal n_16_pfc_tx : STD_LOGIC;
  signal n_16_rx : STD_LOGIC;
  signal n_16_tx : STD_LOGIC;
  signal n_17_pfc_tx : STD_LOGIC;
  signal n_17_rx : STD_LOGIC;
  signal n_18_rx : STD_LOGIC;
  signal n_19_rx : STD_LOGIC;
  signal n_1_rx_pause : STD_LOGIC;
  signal n_20_rx : STD_LOGIC;
  signal n_21_rx : STD_LOGIC;
  signal n_22_rx : STD_LOGIC;
  signal n_27_tx : STD_LOGIC;
  signal n_2_pfc_tx : STD_LOGIC;
  signal n_3_pfc_tx : STD_LOGIC;
  signal n_4_pfc_tx : STD_LOGIC;
  signal n_5_pfc_tx : STD_LOGIC;
  signal n_6_pfc_tx : STD_LOGIC;
  signal n_7_pfc_tx : STD_LOGIC;
  signal n_7_rx : STD_LOGIC;
  signal n_8_pfc_tx : STD_LOGIC;
  signal n_8_rx : STD_LOGIC;
  signal n_9_pfc_tx : STD_LOGIC;
  signal n_9_rx : STD_LOGIC;
  signal pause_req_int0 : STD_LOGIC;
  signal pause_req_to_tx : STD_LOGIC;
  signal pause_status_int : STD_LOGIC;
  signal pause_status_req : STD_LOGIC;
  signal pause_value_to_tx : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal pfc_pause_req_out : STD_LOGIC;
  signal pfc_req : STD_LOGIC;
  signal pfc_rx_enable_sync : STD_LOGIC;
  signal pfc_tx_enable_sync : STD_LOGIC;
  signal rx_bad_frame : STD_LOGIC;
  signal rx_data_valid : STD_LOGIC;
  signal \^rx_enable_reg\ : STD_LOGIC;
  signal rx_good_frame : STD_LOGIC;
  signal rx_good_frame_comb : STD_LOGIC;
  signal rx_half_duplex_sync : STD_LOGIC;
  signal \^rx_statistics_vector\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^sample\ : STD_LOGIC;
  signal tx_data_int : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal tx_enable_reg : STD_LOGIC;
  signal tx_half_duplex_sync : STD_LOGIC;
  signal \^tx_statistics_vector\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal tx_status : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \rx_state[0]_i_1\ : label is "soft_lutpair176";
  attribute SOFT_HLUTNM of \rx_state[1]_i_1\ : label is "soft_lutpair176";
begin
  rx_enable_reg <= \^rx_enable_reg\;
  rx_statistics_vector(0) <= \^rx_statistics_vector\(0);
  sample <= \^sample\;
  tx_statistics_vector(0) <= \^tx_statistics_vector\(0);
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
pause_vector_tx_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_27_tx,
      Q => \^tx_statistics_vector\(0),
      R => \<const0>\
    );
pfc_tx: entity work.TriMACtri_mode_ethernet_mac_v8_1_pfc_tx_cntl
    port map (
      E(0) => n_16_tx,
      I1 => \^sample\,
      I2 => I1,
      O1 => n_2_pfc_tx,
      O2 => n_3_pfc_tx,
      O3 => n_4_pfc_tx,
      O4 => n_5_pfc_tx,
      O5 => n_6_pfc_tx,
      O6 => n_7_pfc_tx,
      O7 => n_8_pfc_tx,
      O8 => n_9_pfc_tx,
      Q(7) => n_10_pfc_tx,
      Q(6) => n_11_pfc_tx,
      Q(5) => n_12_pfc_tx,
      Q(4) => n_13_pfc_tx,
      Q(3) => n_14_pfc_tx,
      Q(2) => n_15_pfc_tx,
      Q(1) => n_16_pfc_tx,
      Q(0) => n_17_pfc_tx,
      control_complete => control_complete,
      gtx_clk => gtx_clk,
      pause_req => pause_req,
      pause_req_int0 => pause_req_int0,
      pause_val(15 downto 0) => pause_val(15 downto 0),
      pfc_pause_req_out => pfc_pause_req_out,
      pfc_req => pfc_req,
      pfc_tx_enable_sync => pfc_tx_enable_sync,
      tx_enable_reg => tx_enable_reg
    );
rx: entity work.TriMACtri_mode_ethernet_mac_v8_1_rx_cntl
    port map (
      D(15) => n_7_rx,
      D(14) => n_8_rx,
      D(13) => n_9_rx,
      D(12) => n_10_rx,
      D(11) => n_11_rx,
      D(10) => n_12_rx,
      D(9) => n_13_rx,
      D(8) => n_14_rx,
      D(7) => n_15_rx,
      D(6) => n_16_rx,
      D(5) => n_17_rx,
      D(4) => n_18_rx,
      D(3) => n_19_rx,
      D(2) => n_20_rx,
      D(1) => n_21_rx,
      D(0) => n_22_rx,
      I1 => \^rx_enable_reg\,
      I12 => I12,
      I13(7 downto 0) => I13(7 downto 0),
      I14(0) => I14(0),
      I18 => I18,
      I2 => I2,
      I3 => I3,
      O1 => O3,
      O2 => O2,
      O3 => O4,
      O5 => O5,
      Q(0) => Q(0),
      SR(0) => SR(0),
      bad_pfc_opcode_int => bad_pfc_opcode_int,
      data_out => pfc_rx_enable_sync,
      int_rx_bad_frame_in => int_rx_bad_frame_in,
      int_rx_control_frame => int_rx_control_frame,
      int_rx_data_valid_in => int_rx_data_valid_in,
      int_rx_good_frame_in => int_rx_good_frame_in,
      rx_good_frame_comb => rx_good_frame_comb,
      rx_statistics_vector(0) => \^rx_statistics_vector\(0)
    );
rx_bad_frame_int_reg: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => rx_bad_frame_comb,
      Q => rx_bad_frame,
      R => SR(0)
    );
\rx_data_int_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => I13(0),
      Q => O13(0),
      R => SR(0)
    );
\rx_data_int_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => I13(1),
      Q => O13(1),
      R => SR(0)
    );
\rx_data_int_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => I13(2),
      Q => O13(2),
      R => SR(0)
    );
\rx_data_int_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => I13(3),
      Q => O13(3),
      R => SR(0)
    );
\rx_data_int_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => I13(4),
      Q => O13(4),
      R => SR(0)
    );
\rx_data_int_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => I13(5),
      Q => O13(5),
      R => SR(0)
    );
\rx_data_int_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => I13(6),
      Q => O13(6),
      R => SR(0)
    );
\rx_data_int_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => I13(7),
      Q => O13(7),
      R => SR(0)
    );
rx_data_valid_int_reg: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => int_rx_data_valid_in,
      Q => rx_data_valid,
      R => SR(0)
    );
rx_enable_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => n_0_sync_rx_enable,
      Q => \^rx_enable_reg\,
      R => SR(0)
    );
rx_good_frame_int_reg: unisim.vcomponents.FDRE
    port map (
      C => I3,
      CE => I2,
      D => rx_good_frame_comb,
      Q => rx_good_frame,
      R => SR(0)
    );
rx_mac_tlast_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4440888844408880"
    )
    port map (
      I0 => rx_state(1),
      I1 => I2,
      I2 => rx_good_frame,
      I3 => rx_bad_frame,
      I4 => rx_state(0),
      I5 => rx_data_valid,
      O => rx_mac_tlast0
    );
rx_mac_tuser_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000003200C000"
    )
    port map (
      I0 => rx_data_valid,
      I1 => rx_state(0),
      I2 => rx_bad_frame,
      I3 => I2,
      I4 => rx_state(1),
      I5 => rx_good_frame,
      O => rx_mac_tuser0
    );
rx_mac_tvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FEFE0000000000"
    )
    port map (
      I0 => rx_good_frame,
      I1 => rx_bad_frame,
      I2 => rx_data_valid,
      I3 => rx_state(1),
      I4 => rx_state(0),
      I5 => I2,
      O => rx_mac_tvalid0
    );
rx_pause: entity work.TriMACtri_mode_ethernet_mac_v8_1_rx_sync_req
    port map (
      D(15) => n_7_rx,
      D(14) => n_8_rx,
      D(13) => n_9_rx,
      D(12) => n_10_rx,
      D(11) => n_11_rx,
      D(10) => n_12_rx,
      D(9) => n_13_rx,
      D(8) => n_14_rx,
      D(7) => n_15_rx,
      D(6) => n_16_rx,
      D(5) => n_17_rx,
      D(4) => n_18_rx,
      D(3) => n_19_rx,
      D(2) => n_20_rx,
      D(1) => n_21_rx,
      D(0) => n_22_rx,
      E(0) => E(0),
      I2 => I2,
      I3 => I3,
      O1 => n_1_rx_pause,
      Q(15 downto 0) => pause_value_to_tx(15 downto 0),
      SR(0) => SR(0),
      data_in => pause_req_to_tx,
      rx_statistics_vector(0) => \^rx_statistics_vector\(0)
    );
\rx_state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00FEFEF0"
    )
    port map (
      I0 => rx_good_frame,
      I1 => rx_bad_frame,
      I2 => rx_data_valid,
      I3 => rx_state(1),
      I4 => rx_state(0),
      O => next_rx_state(0)
    );
\rx_state[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"66606666"
    )
    port map (
      I0 => rx_state(0),
      I1 => rx_state(1),
      I2 => rx_bad_frame,
      I3 => rx_good_frame,
      I4 => rx_data_valid,
      O => next_rx_state(1)
    );
sync_rx_duplex: entity work.TriMACtri_mode_ethernet_mac_v8_1_sync_block_4
    port map (
      I3 => I3,
      data_out => rx_half_duplex_sync
    );
sync_rx_enable: entity work.TriMACtri_mode_ethernet_mac_v8_1_sync_block_5
    port map (
      I3 => I3,
      O1 => n_0_sync_rx_enable,
      rx_configuration_vector(0) => rx_configuration_vector(0),
      rx_half_duplex_sync => rx_half_duplex_sync
    );
sync_rx_pfc_en: entity work.TriMACtri_mode_ethernet_mac_v8_1_sync_block_3
    port map (
      I3 => I3,
      data_out => pfc_rx_enable_sync
    );
sync_tx_duplex: entity work.TriMACtri_mode_ethernet_mac_v8_1_sync_block_2
    port map (
      data_out => tx_half_duplex_sync,
      gtx_clk => gtx_clk
    );
sync_tx_enable: entity work.TriMACtri_mode_ethernet_mac_v8_1_sync_block_1
    port map (
      O1 => n_0_sync_tx_enable,
      data_out => tx_half_duplex_sync,
      gtx_clk => gtx_clk,
      tx_configuration_vector(0) => tx_configuration_vector(2)
    );
sync_tx_pfc_en: entity work.TriMACtri_mode_ethernet_mac_v8_1_sync_block
    port map (
      data_out => pfc_tx_enable_sync,
      gtx_clk => gtx_clk
    );
tx: entity work.TriMACtri_mode_ethernet_mac_v8_1_tx_cntl
    port map (
      E(0) => n_16_tx,
      I1 => I1,
      I10 => I10,
      I11(7 downto 0) => I11(7 downto 0),
      I12 => n_3_pfc_tx,
      I13 => n_4_pfc_tx,
      I14 => n_5_pfc_tx,
      I15 => I15,
      I16 => I16,
      I17 => I17,
      I18 => n_6_pfc_tx,
      I19 => n_7_pfc_tx,
      I2(7) => n_10_pfc_tx,
      I2(6) => n_11_pfc_tx,
      I2(5) => n_12_pfc_tx,
      I2(4) => n_13_pfc_tx,
      I2(3) => n_14_pfc_tx,
      I2(2) => n_15_pfc_tx,
      I2(1) => n_16_pfc_tx,
      I2(0) => n_17_pfc_tx,
      I20 => n_8_pfc_tx,
      I21 => n_9_pfc_tx,
      I3 => n_2_pfc_tx,
      I4 => I4,
      I5 => I5,
      I6 => I6,
      I7 => I7,
      I8 => I8,
      I9 => I9,
      INT_ENABLE => INT_ENABLE,
      MAX_PKT_LEN_REACHED => MAX_PKT_LEN_REACHED,
      O1 => data_avail_in_reg,
      O10 => n_27_tx,
      O11 => O11,
      O12 => O12,
      O2 => load_source,
      O3 => \^sample\,
      O4 => O1,
      O5 => O6,
      O6 => O7,
      O7 => O10,
      O8 => O8,
      O9 => O9,
      Q(7 downto 0) => tx_data_int(7 downto 0),
      REG_DATA_VALID => REG_DATA_VALID,
      control_complete => control_complete,
      data_out => pfc_tx_enable_sync,
      gtx_clk => gtx_clk,
      int_tx_ack_in => int_tx_ack_in,
      int_tx_crc_enable_out => int_tx_crc_enable_out,
      int_tx_data_valid_out => int_tx_data_valid_out,
      int_tx_vlan_enable_out => int_tx_vlan_enable_out,
      pause_req => pause_req,
      pause_req_int0 => pause_req_int0,
      pause_status_int => pause_status_int,
      pause_status_req => pause_status_req,
      pfc_pause_req_out => pfc_pause_req_out,
      pfc_req => pfc_req,
      tx_ack_int => tx_ack_int,
      tx_ce_sample => tx_ce_sample,
      tx_configuration_vector(49 downto 2) => tx_configuration_vector(50 downto 3),
      tx_configuration_vector(1 downto 0) => tx_configuration_vector(1 downto 0),
      tx_data_valid_int => tx_data_valid_int,
      tx_statistics_valid => tx_statistics_valid,
      tx_statistics_vector(0) => \^tx_statistics_vector\(0),
      tx_status => tx_status
    );
\tx_data_int_reg[0]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => D(0),
      Q => tx_data_int(0),
      R => I1
    );
\tx_data_int_reg[1]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => D(1),
      Q => tx_data_int(1),
      R => I1
    );
\tx_data_int_reg[2]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => D(2),
      Q => tx_data_int(2),
      R => I1
    );
\tx_data_int_reg[3]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => D(3),
      Q => tx_data_int(3),
      R => I1
    );
\tx_data_int_reg[4]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => D(4),
      Q => tx_data_int(4),
      R => I1
    );
\tx_data_int_reg[5]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => D(5),
      Q => tx_data_int(5),
      R => I1
    );
\tx_data_int_reg[6]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => D(6),
      Q => tx_data_int(6),
      R => I1
    );
\tx_data_int_reg[7]\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => D(7),
      Q => tx_data_int(7),
      R => I1
    );
tx_enable_reg_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => n_0_sync_tx_enable,
      Q => tx_enable_reg,
      R => I1
    );
tx_pause: entity work.TriMACtri_mode_ethernet_mac_v8_1_tx_pause
    port map (
      I1 => I1,
      I2 => n_1_rx_pause,
      Q(15 downto 0) => pause_value_to_tx(15 downto 0),
      data_in => pause_req_to_tx,
      gtx_clk => gtx_clk,
      pause_status_int => pause_status_int,
      pause_status_req => pause_status_req,
      tx_ce_sample => tx_ce_sample,
      tx_status => tx_status
    );
tx_underrun_int_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_underrun_int,
      Q => tx_underrun_int_0,
      R => I1
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtx is
  port (
    int_gmii_tx_en : out STD_LOGIC;
    CRC_OK : out STD_LOGIC;
    REG_DATA_VALID : out STD_LOGIC;
    PAD : out STD_LOGIC;
    tx_statistics_valid : out STD_LOGIC;
    tx_statistics_vector : out STD_LOGIC_VECTOR ( 30 downto 0 );
    INT_ENABLE : out STD_LOGIC;
    CRC100_EN : out STD_LOGIC;
    MAX_PKT_LEN_REACHED : out STD_LOGIC;
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O4 : out STD_LOGIC;
    O5 : out STD_LOGIC;
    O6 : out STD_LOGIC;
    O7 : out STD_LOGIC;
    O8 : out STD_LOGIC;
    int_gmii_tx_er : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 1 downto 0 );
    int_tx_ack_in : out STD_LOGIC;
    O9 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_ce_sample : in STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    INT_CRC_MODE : in STD_LOGIC;
    int_tx_data_valid_out : in STD_LOGIC;
    I1 : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 20 downto 0 );
    CE_REG1_OUT7_out : in STD_LOGIC;
    int_tx_crc_enable_out : in STD_LOGIC;
    O3 : in STD_LOGIC;
    int_tx_vlan_enable_out : in STD_LOGIC;
    I2 : in STD_LOGIC;
    I3 : in STD_LOGIC;
    data_avail_in_reg : in STD_LOGIC;
    tx_underrun_int : in STD_LOGIC;
    I4 : in STD_LOGIC;
    I5 : in STD_LOGIC;
    I6 : in STD_LOGIC;
    I7 : in STD_LOGIC;
    I8 : in STD_LOGIC;
    I9 : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    tx_ifg_delay : in STD_LOGIC_VECTOR ( 7 downto 0 );
    I10 : in STD_LOGIC_VECTOR ( 0 to 0 );
    I11 : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
end TriMACtx;

architecture STRUCTURE of TriMACtx is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal CE_REG1_OUT : STD_LOGIC;
  signal CE_REG2_OUT : STD_LOGIC;
  signal CE_REG3_OUT : STD_LOGIC;
  signal CE_REG4_OUT : STD_LOGIC;
  signal CE_REG5_OUT : STD_LOGIC;
  signal CLK_DIV100_REG : STD_LOGIC;
  signal CLK_DIV10_REG : STD_LOGIC;
  signal CLK_DIV20_REG : STD_LOGIC;
  signal CRC1000_EN : STD_LOGIC;
  signal \^crc100_en\ : STD_LOGIC;
  signal CRC50_EN : STD_LOGIC;
  signal \^crc_ok\ : STD_LOGIC;
  signal NUMBER_OF_BYTES_PRE_REG : STD_LOGIC;
  signal Q_0 : STD_LOGIC;
  signal REG0_OUT2 : STD_LOGIC;
  signal REG1_OUT : STD_LOGIC;
  signal REG2_OUT : STD_LOGIC;
  signal REG3_OUT : STD_LOGIC;
  signal REG4_OUT : STD_LOGIC;
  signal REG5_OUT : STD_LOGIC;
  signal REG6_OUT2 : STD_LOGIC;
  signal REG7_OUT2 : STD_LOGIC;
  signal REG8_OUT2 : STD_LOGIC;
  signal REG9_OUT2 : STD_LOGIC;
  signal SPEED_0_RESYNC_REG : STD_LOGIC;
  signal SPEED_1_RESYNC_REG : STD_LOGIC;
  signal \^int_gmii_tx_en\ : STD_LOGIC;
  signal n_0_CAPTURE_i_1 : STD_LOGIC;
  signal n_0_CAPTURE_reg : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.CE_REG1_OUT_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.CE_REG5_OUT_reg\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.CRC1000_EN_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.CRC100_EN_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.CRC50_EN_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG0_OUT2_reg\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG1_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG1_OUT_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG2_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG3_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG4_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_txgen_CONFIG_SELECT.REG5_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG5_OUT2_reg_gate\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG5_OUT2_reg_r\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.REG5_OUT_reg\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.SPEED_0_SYNC\ : STD_LOGIC;
  signal \n_0_CONFIG_SELECT.SPEED_1_SYNC\ : STD_LOGIC;
  signal n_0_INT_CRC_MODE_reg : STD_LOGIC;
  signal n_0_INT_HALF_DUPLEX_reg : STD_LOGIC;
  signal n_0_INT_IFG_DEL_EN_reg : STD_LOGIC;
  signal n_0_INT_JUMBO_ENABLE_reg : STD_LOGIC;
  signal n_0_INT_SPEED_IS_10_100_reg : STD_LOGIC;
  signal n_0_INT_TX_EN_DELAY_reg : STD_LOGIC;
  signal n_0_INT_VLAN_ENABLE_reg : STD_LOGIC;
  signal \n_1_CONFIG_SELECT.CRCGEN2\ : STD_LOGIC;
  signal n_26_TX_SM1 : STD_LOGIC;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of BYTECNTSRL : label is "PRIMITIVE";
  attribute srl_name : string;
  attribute srl_name of BYTECNTSRL : label is "inst/\TriMAC_core/txgen/BYTECNTSRL ";
  attribute srl_name of \CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r\ : label is "inst/\TriMAC_core/txgen/CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r ";
begin
  CRC100_EN <= \^crc100_en\;
  CRC_OK <= \^crc_ok\;
  int_gmii_tx_en <= \^int_gmii_tx_en\;
BYTECNTSRL: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
    port map (
      A0 => \<const0>\,
      A1 => \<const1>\,
      A2 => \<const1>\,
      A3 => \<const0>\,
      CE => tx_ce_sample,
      CLK => gtx_clk,
      D => \^int_gmii_tx_en\,
      Q => Q_0
    );
CAPTURE_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00D8"
    )
    port map (
      I0 => tx_ce_sample,
      I1 => Q_0,
      I2 => n_0_CAPTURE_reg,
      I3 => I1,
      O => n_0_CAPTURE_i_1
    );
CAPTURE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_0_CAPTURE_i_1,
      Q => n_0_CAPTURE_reg,
      R => \<const0>\
    );
\CONFIG_SELECT.CE_REG1_OUT_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_CONFIG_SELECT.CE_REG5_OUT_reg\,
      O => \n_0_CONFIG_SELECT.CE_REG1_OUT_i_1\
    );
\CONFIG_SELECT.CE_REG1_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => CE_REG1_OUT7_out,
      D => \n_0_CONFIG_SELECT.CE_REG1_OUT_i_1\,
      Q => CE_REG1_OUT,
      R => CE_REG5_OUT
    );
\CONFIG_SELECT.CE_REG2_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => CE_REG1_OUT7_out,
      D => CE_REG1_OUT,
      Q => CE_REG2_OUT,
      R => CE_REG5_OUT
    );
\CONFIG_SELECT.CE_REG3_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => CE_REG1_OUT7_out,
      D => CE_REG2_OUT,
      Q => CE_REG3_OUT,
      R => CE_REG5_OUT
    );
\CONFIG_SELECT.CE_REG4_OUT_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BAAAAAAA"
    )
    port map (
      I0 => I1,
      I1 => CE_REG4_OUT,
      I2 => \n_0_CONFIG_SELECT.CE_REG5_OUT_reg\,
      I3 => tx_ce_sample,
      I4 => \^crc100_en\,
      O => CE_REG5_OUT
    );
\CONFIG_SELECT.CE_REG4_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => CE_REG1_OUT7_out,
      D => CE_REG3_OUT,
      Q => CE_REG4_OUT,
      R => CE_REG5_OUT
    );
\CONFIG_SELECT.CE_REG5_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => CE_REG1_OUT7_out,
      D => CE_REG4_OUT,
      Q => \n_0_CONFIG_SELECT.CE_REG5_OUT_reg\,
      R => CE_REG5_OUT
    );
\CONFIG_SELECT.CLK_DIV100_REG_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => CE_REG3_OUT,
      Q => CLK_DIV100_REG,
      R => I1
    );
\CONFIG_SELECT.CLK_DIV10_REG_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG3_OUT,
      Q => CLK_DIV10_REG,
      R => I1
    );
\CONFIG_SELECT.CLK_DIV20_REG_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG6_OUT2,
      Q => CLK_DIV20_REG,
      R => \<const0>\
    );
\CONFIG_SELECT.CRC1000_EN_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => CE_REG3_OUT,
      I1 => CLK_DIV100_REG,
      O => \n_0_CONFIG_SELECT.CRC1000_EN_i_1\
    );
\CONFIG_SELECT.CRC1000_EN_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.CRC1000_EN_i_1\,
      Q => CRC1000_EN,
      R => I1
    );
\CONFIG_SELECT.CRC100_EN_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => REG3_OUT,
      I1 => CLK_DIV10_REG,
      O => \n_0_CONFIG_SELECT.CRC100_EN_i_1\
    );
\CONFIG_SELECT.CRC100_EN_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.CRC100_EN_i_1\,
      Q => \^crc100_en\,
      R => I1
    );
\CONFIG_SELECT.CRC50_EN_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => REG6_OUT2,
      I1 => CLK_DIV20_REG,
      O => \n_0_CONFIG_SELECT.CRC50_EN_i_1\
    );
\CONFIG_SELECT.CRC50_EN_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.CRC50_EN_i_1\,
      Q => CRC50_EN,
      R => \<const0>\
    );
\CONFIG_SELECT.CRCGEN2\: entity work.TriMACCRC_64_32_15
    port map (
      CRC1000_EN => CRC1000_EN,
      CRC50_EN => CRC50_EN,
      CRC_OK => \^crc_ok\,
      I1 => I1,
      SPEED_0_RESYNC_REG => SPEED_0_RESYNC_REG,
      SPEED_1_RESYNC_REG => SPEED_1_RESYNC_REG,
      SR(0) => \n_1_CONFIG_SELECT.CRCGEN2\,
      gtx_clk => gtx_clk,
      tx_ce_sample => tx_ce_sample
    );
\CONFIG_SELECT.REG0_OUT2_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG9_OUT2,
      Q => \n_0_CONFIG_SELECT.REG0_OUT2_reg\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG1_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const1>\,
      Q => \n_0_CONFIG_SELECT.REG1_OUT2_reg_r\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG1_OUT_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_CONFIG_SELECT.REG5_OUT_reg\,
      O => \n_0_CONFIG_SELECT.REG1_OUT_i_1\
    );
\CONFIG_SELECT.REG1_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.REG1_OUT_i_1\,
      Q => REG1_OUT,
      R => REG5_OUT
    );
\CONFIG_SELECT.REG2_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.REG1_OUT2_reg_r\,
      Q => \n_0_CONFIG_SELECT.REG2_OUT2_reg_r\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG2_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG1_OUT,
      Q => REG2_OUT,
      R => REG5_OUT
    );
\CONFIG_SELECT.REG3_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.REG2_OUT2_reg_r\,
      Q => \n_0_CONFIG_SELECT.REG3_OUT2_reg_r\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG3_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG2_OUT,
      Q => REG3_OUT,
      R => REG5_OUT
    );
\CONFIG_SELECT.REG4_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.REG3_OUT2_reg_r\,
      Q => \n_0_CONFIG_SELECT.REG4_OUT2_reg_r\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r\: unisim.vcomponents.SRL16E
    port map (
      A0 => \<const1>\,
      A1 => \<const1>\,
      A2 => \<const0>\,
      A3 => \<const0>\,
      CE => tx_ce_sample,
      CLK => gtx_clk,
      D => \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1\,
      Q => \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r\
    );
\CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => \n_0_CONFIG_SELECT.REG0_OUT2_reg\,
      O => \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r_i_1\
    );
\CONFIG_SELECT.REG4_OUT_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => I1,
      I1 => REG4_OUT,
      I2 => tx_ce_sample,
      I3 => \n_0_CONFIG_SELECT.REG5_OUT_reg\,
      O => REG5_OUT
    );
\CONFIG_SELECT.REG4_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG3_OUT,
      Q => REG4_OUT,
      R => REG5_OUT
    );
\CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_txgen_CONFIG_SELECT.REG5_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.REG4_OUT2_reg_srl4___TriMAC_core_txgen_CONFIG_SELECT.REG4_OUT2_reg_r\,
      Q => \n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_txgen_CONFIG_SELECT.REG5_OUT2_reg_r\,
      R => \<const0>\
    );
\CONFIG_SELECT.REG5_OUT2_reg_gate\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => \n_0_CONFIG_SELECT.REG5_OUT2_reg_TriMAC_core_txgen_CONFIG_SELECT.REG5_OUT2_reg_r\,
      I1 => \n_0_CONFIG_SELECT.REG5_OUT2_reg_r\,
      O => \n_0_CONFIG_SELECT.REG5_OUT2_reg_gate\
    );
\CONFIG_SELECT.REG5_OUT2_reg_r\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.REG4_OUT2_reg_r\,
      Q => \n_0_CONFIG_SELECT.REG5_OUT2_reg_r\,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG5_OUT_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG4_OUT,
      Q => \n_0_CONFIG_SELECT.REG5_OUT_reg\,
      R => REG5_OUT
    );
\CONFIG_SELECT.REG6_OUT2_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.REG5_OUT2_reg_gate\,
      Q => REG6_OUT2,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG7_OUT2_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG6_OUT2,
      Q => REG7_OUT2,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG8_OUT2_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG7_OUT2,
      Q => REG8_OUT2,
      R => REG0_OUT2
    );
\CONFIG_SELECT.REG9_OUT2_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BAAA"
    )
    port map (
      I0 => I1,
      I1 => REG9_OUT2,
      I2 => tx_ce_sample,
      I3 => \n_0_CONFIG_SELECT.REG0_OUT2_reg\,
      O => REG0_OUT2
    );
\CONFIG_SELECT.REG9_OUT2_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => REG8_OUT2,
      Q => REG9_OUT2,
      R => REG0_OUT2
    );
\CONFIG_SELECT.SPEED_0_RESYNC_REG_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.SPEED_0_SYNC\,
      Q => SPEED_0_RESYNC_REG,
      R => I1
    );
\CONFIG_SELECT.SPEED_0_SYNC\: entity work.\TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_13\
    port map (
      data_out => \n_0_CONFIG_SELECT.SPEED_0_SYNC\,
      gtx_clk => gtx_clk,
      tx_configuration_vector(0) => tx_configuration_vector(3)
    );
\CONFIG_SELECT.SPEED_1_RESYNC_REG_reg\: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \n_0_CONFIG_SELECT.SPEED_1_SYNC\,
      Q => SPEED_1_RESYNC_REG,
      R => I1
    );
\CONFIG_SELECT.SPEED_1_SYNC\: entity work.\TriMACtri_mode_ethernet_mac_v8_1_sync_block__parameterized1_14\
    port map (
      data_out => \n_0_CONFIG_SELECT.SPEED_1_SYNC\,
      gtx_clk => gtx_clk,
      tx_configuration_vector(0) => tx_configuration_vector(4)
    );
GND: unisim.vcomponents.GND
    port map (
      G => \<const0>\
    );
INT_CRC_MODE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => int_tx_crc_enable_out,
      Q => n_0_INT_CRC_MODE_reg,
      R => I1
    );
INT_ENABLE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_configuration_vector(0),
      Q => INT_ENABLE,
      R => I1
    );
INT_HALF_DUPLEX_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => \<const0>\,
      Q => n_0_INT_HALF_DUPLEX_reg,
      R => I1
    );
INT_IFG_DEL_EN_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_configuration_vector(2),
      Q => n_0_INT_IFG_DEL_EN_reg,
      R => I1
    );
INT_JUMBO_ENABLE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => tx_configuration_vector(1),
      Q => n_0_INT_JUMBO_ENABLE_reg,
      R => I1
    );
INT_SPEED_IS_10_100_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => O3,
      Q => n_0_INT_SPEED_IS_10_100_reg,
      R => I1
    );
INT_TX_EN_DELAY_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => \<const1>\,
      D => n_26_TX_SM1,
      Q => n_0_INT_TX_EN_DELAY_reg,
      R => \<const0>\
    );
INT_VLAN_ENABLE_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => int_tx_vlan_enable_out,
      Q => n_0_INT_VLAN_ENABLE_reg,
      R => I1
    );
NUMBER_OF_BYTES_reg: unisim.vcomponents.FDRE
    port map (
      C => gtx_clk,
      CE => tx_ce_sample,
      D => NUMBER_OF_BYTES_PRE_REG,
      Q => tx_statistics_vector(30),
      R => I1
    );
TX_SM1: entity work.\TriMACTX_STATE_MACH__parameterized0\
    port map (
      D(7 downto 0) => D(7 downto 0),
      E(0) => E(0),
      I1 => n_0_INT_CRC_MODE_reg,
      I10 => n_0_INT_TX_EN_DELAY_reg,
      I11 => I4,
      I12 => I5,
      I13 => n_0_INT_HALF_DUPLEX_reg,
      I14 => I6,
      I15 => I7,
      I16 => I8,
      I17 => n_0_CAPTURE_reg,
      I18 => I9,
      I19(0) => SR(0),
      I2 => n_0_INT_JUMBO_ENABLE_reg,
      I20(0) => I10(0),
      I21(7 downto 0) => I11(7 downto 0),
      I3 => n_0_INT_SPEED_IS_10_100_reg,
      I4 => n_0_INT_IFG_DEL_EN_reg,
      I5 => n_0_INT_VLAN_ENABLE_reg,
      I6 => I2,
      I7 => I3,
      I8 => I1,
      I9 => \^crc_ok\,
      INT_CRC_MODE => INT_CRC_MODE,
      NUMBER_OF_BYTES_PRE_REG => NUMBER_OF_BYTES_PRE_REG,
      O1 => MAX_PKT_LEN_REACHED,
      O10 => n_26_TX_SM1,
      O2 => O1,
      O3 => O2,
      O4 => O4,
      O5 => O5,
      O6 => O6,
      O7 => O7,
      O8 => O8,
      O9 => O9,
      PAD => PAD,
      Q(1 downto 0) => Q(1 downto 0),
      Q_0 => Q_0,
      REG_DATA_VALID => REG_DATA_VALID,
      SR(0) => \n_1_CONFIG_SELECT.CRCGEN2\,
      data_avail_in_reg => data_avail_in_reg,
      gtx_clk => gtx_clk,
      int_gmii_tx_en => \^int_gmii_tx_en\,
      int_gmii_tx_er => int_gmii_tx_er,
      int_tx_ack_in => int_tx_ack_in,
      int_tx_data_valid_out => int_tx_data_valid_out,
      tx_ce_sample => tx_ce_sample,
      tx_configuration_vector(15 downto 0) => tx_configuration_vector(20 downto 5),
      tx_ifg_delay(7 downto 0) => tx_ifg_delay(7 downto 0),
      tx_statistics_valid => tx_statistics_valid,
      tx_statistics_vector(29 downto 0) => tx_statistics_vector(29 downto 0),
      tx_underrun_int => tx_underrun_int
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACtri_mode_ethernet_mac_v8_1 is
  port (
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    tx_statistics_valid : out STD_LOGIC;
    tx_statistics_vector : out STD_LOGIC_VECTOR ( 31 downto 0 );
    O3 : out STD_LOGIC;
    rx_statistics_valid : out STD_LOGIC;
    rx_statistics_vector : out STD_LOGIC_VECTOR ( 27 downto 0 );
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    rgmii_tx_ctl_int : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    gmii_txd_falling : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    tx_en_to_ddr : out STD_LOGIC;
    rx_axis_mac_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_axis_mac_tvalid : out STD_LOGIC;
    rx_axis_mac_tlast : out STD_LOGIC;
    rx_axis_mac_tuser : out STD_LOGIC;
    gmii_rx_dv_int : in STD_LOGIC;
    I1 : in STD_LOGIC;
    gmii_rx_er_int : in STD_LOGIC;
    tx_enable : in STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    I2 : in STD_LOGIC;
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 72 downto 0 );
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 72 downto 0 );
    phy_tx_enable : in STD_LOGIC;
    counter0 : in STD_LOGIC;
    tx_axis_mac_tvalid : in STD_LOGIC;
    tx_axis_mac_tuser : in STD_LOGIC;
    tx_axis_mac_tlast : in STD_LOGIC;
    pause_req : in STD_LOGIC;
    clk_div5 : in STD_LOGIC;
    pause_val : in STD_LOGIC_VECTOR ( 15 downto 0 );
    tx_axis_mac_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    D : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_ifg_delay : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_axi_rstn : in STD_LOGIC;
    glbl_rstn : in STD_LOGIC;
    tx_axi_rstn : in STD_LOGIC
  );
end TriMACtri_mode_ethernet_mac_v8_1;

architecture STRUCTURE of TriMACtri_mode_ethernet_mac_v8_1 is
  signal \<const1>\ : STD_LOGIC;
  signal CE_REG1_OUT7_out : STD_LOGIC;
  signal CRC100_EN : STD_LOGIC;
  signal CRC_OK : STD_LOGIC;
  signal END_OF_FRAME : STD_LOGIC;
  signal INT_ENABLE : STD_LOGIC;
  signal MATCH_FRAME_INT0 : STD_LOGIC;
  signal \^o1\ : STD_LOGIC;
  signal \^o2\ : STD_LOGIC;
  signal \^o3\ : STD_LOGIC;
  signal \TX_SM1/INT_CRC_MODE\ : STD_LOGIC;
  signal \TX_SM1/MAX_PKT_LEN_REACHED\ : STD_LOGIC;
  signal \TX_SM1/PAD\ : STD_LOGIC;
  signal \TX_SM1/REG_DATA_VALID\ : STD_LOGIC;
  signal \address_filter_inst/broadcast_byte_match\ : STD_LOGIC;
  signal \address_filter_inst/p_0_out\ : STD_LOGIC;
  signal \address_filter_inst/p_10_out\ : STD_LOGIC;
  signal \address_filter_inst/p_1_out\ : STD_LOGIC;
  signal \address_filter_inst/p_2_out\ : STD_LOGIC;
  signal \address_filter_inst/p_3_out\ : STD_LOGIC;
  signal \address_filter_inst/p_4_out\ : STD_LOGIC;
  signal \address_filter_inst/p_5_out\ : STD_LOGIC;
  signal \address_filter_inst/p_6_out\ : STD_LOGIC;
  signal \address_filter_inst/p_7_out\ : STD_LOGIC;
  signal \address_filter_inst/p_8_out\ : STD_LOGIC;
  signal \address_filter_inst/p_9_out\ : STD_LOGIC;
  signal \address_filter_inst/rx_data_valid_reg1\ : STD_LOGIC;
  signal \address_filter_inst/update_pause_ad_sync\ : STD_LOGIC;
  signal \address_filter_inst/update_pause_ad_sync_reg\ : STD_LOGIC;
  signal address_valid_early : STD_LOGIC;
  signal alignment_err_reg : STD_LOGIC;
  signal broadcastaddressmatch : STD_LOGIC;
  signal data_valid_early : STD_LOGIC;
  signal gmii_rx_dv_from_mii : STD_LOGIC;
  signal gmii_rx_er_from_mii : STD_LOGIC;
  signal gmii_rxd_from_mii : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \hd_tieoff.extension_reg_reg\ : STD_LOGIC;
  signal int_alignment_err_pulse : STD_LOGIC;
  signal int_gmii_tx_en : STD_LOGIC;
  signal int_gmii_tx_er : STD_LOGIC;
  signal int_gmii_txd : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal int_rx_bad_frame_in : STD_LOGIC;
  signal int_rx_control_frame : STD_LOGIC;
  signal int_rx_data_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal int_rx_data_valid_in : STD_LOGIC;
  signal int_rx_good_frame_in : STD_LOGIC;
  signal int_tx_ack_in : STD_LOGIC;
  signal int_tx_crc_enable_out : STD_LOGIC;
  signal int_tx_data_out : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal int_tx_data_valid_out : STD_LOGIC;
  signal int_tx_vlan_enable_out : STD_LOGIC;
  signal load_source : STD_LOGIC;
  signal n_0_rx_axi_shim : STD_LOGIC;
  signal n_0_rxgen : STD_LOGIC;
  signal n_10_flow : STD_LOGIC;
  signal n_10_rxgen : STD_LOGIC;
  signal n_11_flow : STD_LOGIC;
  signal \n_11_tx_axi_intf.tx_axi_shim\ : STD_LOGIC;
  signal n_12_addr_filter_top : STD_LOGIC;
  signal n_12_flow : STD_LOGIC;
  signal \n_12_tx_axi_intf.tx_axi_shim\ : STD_LOGIC;
  signal n_13_addr_filter_top : STD_LOGIC;
  signal n_13_flow : STD_LOGIC;
  signal n_14_addr_filter_top : STD_LOGIC;
  signal n_14_flow : STD_LOGIC;
  signal n_15_addr_filter_top : STD_LOGIC;
  signal n_15_flow : STD_LOGIC;
  signal n_16_flow : STD_LOGIC;
  signal n_18_flow : STD_LOGIC;
  signal n_1_rx_axi_shim : STD_LOGIC;
  signal n_1_sync_rx_reset_i : STD_LOGIC;
  signal n_2_sync_rx_reset_i : STD_LOGIC;
  signal n_2_sync_tx_reset_i : STD_LOGIC;
  signal n_33_flow : STD_LOGIC;
  signal n_34_flow : STD_LOGIC;
  signal n_35_flow : STD_LOGIC;
  signal n_39_rxgen : STD_LOGIC;
  signal n_39_txgen : STD_LOGIC;
  signal n_3_sync_tx_reset_i : STD_LOGIC;
  signal n_40_rxgen : STD_LOGIC;
  signal n_40_txgen : STD_LOGIC;
  signal n_41_txgen : STD_LOGIC;
  signal n_42_rxgen : STD_LOGIC;
  signal n_42_txgen : STD_LOGIC;
  signal n_43_rxgen : STD_LOGIC;
  signal n_43_txgen : STD_LOGIC;
  signal n_44_txgen : STD_LOGIC;
  signal n_45_txgen : STD_LOGIC;
  signal n_46_rxgen : STD_LOGIC;
  signal n_47_txgen : STD_LOGIC;
  signal n_48_txgen : STD_LOGIC;
  signal n_4_sync_tx_reset_i : STD_LOGIC;
  signal \n_4_tx_axi_intf.tx_axi_shim\ : STD_LOGIC;
  signal n_50_txgen : STD_LOGIC;
  signal \n_5_tx_axi_intf.tx_axi_shim\ : STD_LOGIC;
  signal n_6_flow : STD_LOGIC;
  signal \n_7_tx_axi_intf.tx_axi_shim\ : STD_LOGIC;
  signal n_8_addr_filter_top : STD_LOGIC;
  signal n_8_rxgen : STD_LOGIC;
  signal \n_8_tx_axi_intf.tx_axi_shim\ : STD_LOGIC;
  signal n_9_flow : STD_LOGIC;
  signal n_9_rxgen : STD_LOGIC;
  signal \n_9_tx_axi_intf.tx_axi_shim\ : STD_LOGIC;
  signal next_rx_state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal pause_match_reg0 : STD_LOGIC;
  signal pauseaddressmatch : STD_LOGIC;
  signal \rx/bad_pfc_opcode_int\ : STD_LOGIC;
  signal \rx/data_count_reg\ : STD_LOGIC_VECTOR ( 4 to 4 );
  signal rx_bad_frame_comb : STD_LOGIC;
  signal rx_data : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal rx_enable_reg : STD_LOGIC;
  signal rx_mac_tlast0 : STD_LOGIC;
  signal rx_mac_tuser0 : STD_LOGIC;
  signal rxstatsaddressmatch : STD_LOGIC;
  signal sample : STD_LOGIC;
  signal special_pause_match_comb : STD_LOGIC;
  signal specialpauseaddressmatch : STD_LOGIC;
  signal \tx/data_avail_in_reg\ : STD_LOGIC;
  signal tx_ack_int : STD_LOGIC;
  signal tx_ce_sample : STD_LOGIC;
  signal tx_data_int : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal tx_data_valid_int : STD_LOGIC;
  signal \^tx_statistics_valid\ : STD_LOGIC;
  signal tx_underrun_int : STD_LOGIC;
  signal tx_underrun_int_0 : STD_LOGIC;
begin
  O1 <= \^o1\;
  O2 <= \^o2\;
  O3 <= \^o3\;
  tx_statistics_valid <= \^tx_statistics_valid\;
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
addr_filter_top: entity work.TriMACtri_mode_ethernet_mac_v8_1_addr_filter_wrap
    port map (
      I1 => I1,
      I2 => I2,
      I3 => n_43_rxgen,
      I4 => n_8_rxgen,
      I5 => n_0_rxgen,
      I6 => n_40_rxgen,
      I7(0) => n_39_rxgen,
      MATCH_FRAME_INT0 => MATCH_FRAME_INT0,
      O1 => n_8_addr_filter_top,
      O2 => n_12_addr_filter_top,
      O3 => n_13_addr_filter_top,
      O4 => n_14_addr_filter_top,
      O5 => n_15_addr_filter_top,
      SR(0) => \^o1\,
      address_valid_early => address_valid_early,
      broadcast_byte_match => \address_filter_inst/broadcast_byte_match\,
      broadcastaddressmatch => broadcastaddressmatch,
      data_out => \address_filter_inst/update_pause_ad_sync\,
      data_valid_early => data_valid_early,
      p_0_out => \address_filter_inst/p_0_out\,
      p_10_out => \address_filter_inst/p_10_out\,
      p_1_out => \address_filter_inst/p_1_out\,
      p_2_out => \address_filter_inst/p_2_out\,
      p_3_out => \address_filter_inst/p_3_out\,
      p_4_out => \address_filter_inst/p_4_out\,
      p_5_out => \address_filter_inst/p_5_out\,
      p_6_out => \address_filter_inst/p_6_out\,
      p_7_out => \address_filter_inst/p_7_out\,
      p_8_out => \address_filter_inst/p_8_out\,
      p_9_out => \address_filter_inst/p_9_out\,
      pause_match_reg0 => pause_match_reg0,
      pauseaddressmatch => pauseaddressmatch,
      rx_configuration_vector(48 downto 1) => rx_configuration_vector(72 downto 25),
      rx_configuration_vector(0) => rx_configuration_vector(8),
      rx_data_valid_reg1 => \address_filter_inst/rx_data_valid_reg1\,
      rxstatsaddressmatch => rxstatsaddressmatch,
      special_pause_match_comb => special_pause_match_comb,
      specialpauseaddressmatch => specialpauseaddressmatch,
      update_pause_ad_sync_reg => \address_filter_inst/update_pause_ad_sync_reg\
    );
flow: entity work.TriMACtri_mode_ethernet_mac_v8_1_control
    port map (
      D(7 downto 0) => tx_data_int(7 downto 0),
      E(0) => n_42_rxgen,
      I1 => \^o2\,
      I10 => n_43_txgen,
      I11(7 downto 0) => int_tx_data_out(7 downto 0),
      I12 => n_46_rxgen,
      I13(7 downto 0) => int_rx_data_in(7 downto 0),
      I14(0) => n_10_rxgen,
      I15 => \n_4_tx_axi_intf.tx_axi_shim\,
      I16 => \n_11_tx_axi_intf.tx_axi_shim\,
      I17 => \n_12_tx_axi_intf.tx_axi_shim\,
      I18 => n_9_rxgen,
      I2 => I2,
      I3 => I1,
      I4 => n_44_txgen,
      I5 => n_45_txgen,
      I6 => n_39_txgen,
      I7 => n_41_txgen,
      I8 => n_50_txgen,
      I9 => n_40_txgen,
      INT_ENABLE => INT_ENABLE,
      MAX_PKT_LEN_REACHED => \TX_SM1/MAX_PKT_LEN_REACHED\,
      O1 => n_6_flow,
      O10 => n_18_flow,
      O11 => n_34_flow,
      O12 => n_35_flow,
      O13(7 downto 0) => rx_data(7 downto 0),
      O2 => n_9_flow,
      O3 => n_10_flow,
      O4 => n_11_flow,
      O5 => n_12_flow,
      O6 => n_13_flow,
      O7 => n_14_flow,
      O8 => n_15_flow,
      O9 => n_16_flow,
      Q(0) => \rx/data_count_reg\(4),
      REG_DATA_VALID => \TX_SM1/REG_DATA_VALID\,
      SR(0) => \^o1\,
      bad_pfc_opcode_int => \rx/bad_pfc_opcode_int\,
      data_avail_in_reg => \tx/data_avail_in_reg\,
      gtx_clk => gtx_clk,
      int_rx_bad_frame_in => int_rx_bad_frame_in,
      int_rx_control_frame => int_rx_control_frame,
      int_rx_data_valid_in => int_rx_data_valid_in,
      int_rx_good_frame_in => int_rx_good_frame_in,
      int_tx_ack_in => int_tx_ack_in,
      int_tx_crc_enable_out => int_tx_crc_enable_out,
      int_tx_data_valid_out => int_tx_data_valid_out,
      int_tx_vlan_enable_out => int_tx_vlan_enable_out,
      load_source => load_source,
      next_rx_state(1 downto 0) => next_rx_state(1 downto 0),
      pause_req => pause_req,
      pause_val(15 downto 0) => pause_val(15 downto 0),
      rx_bad_frame_comb => rx_bad_frame_comb,
      rx_configuration_vector(0) => rx_configuration_vector(5),
      rx_enable_reg => rx_enable_reg,
      rx_mac_tlast0 => rx_mac_tlast0,
      rx_mac_tuser0 => rx_mac_tuser0,
      rx_mac_tvalid0 => n_33_flow,
      rx_state(1) => n_0_rx_axi_shim,
      rx_state(0) => n_1_rx_axi_shim,
      rx_statistics_vector(0) => rx_statistics_vector(23),
      sample => sample,
      tx_ack_int => tx_ack_int,
      tx_ce_sample => tx_ce_sample,
      tx_configuration_vector(50 downto 3) => tx_configuration_vector(72 downto 25),
      tx_configuration_vector(2) => tx_configuration_vector(5),
      tx_configuration_vector(1 downto 0) => tx_configuration_vector(3 downto 2),
      tx_data_valid_int => tx_data_valid_int,
      tx_statistics_valid => \^tx_statistics_valid\,
      tx_statistics_vector(0) => tx_statistics_vector(31),
      tx_underrun_int => tx_underrun_int,
      tx_underrun_int_0 => tx_underrun_int_0
    );
gmii_mii_rx_gen: entity work.TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_rx
    port map (
      D(7 downto 0) => gmii_rxd_from_mii(7 downto 0),
      I1 => I1,
      I2(7 downto 0) => D(7 downto 0),
      SR(0) => \^o1\,
      alignment_err_reg => alignment_err_reg,
      gmii_rx_dv_from_mii => gmii_rx_dv_from_mii,
      gmii_rx_dv_int => gmii_rx_dv_int,
      gmii_rx_er_from_mii => gmii_rx_er_from_mii,
      gmii_rx_er_int => gmii_rx_er_int,
      int_alignment_err_pulse => int_alignment_err_pulse,
      tx_configuration_vector(0) => tx_configuration_vector(8)
    );
gmii_mii_tx_gen: entity work.TriMACtri_mode_ethernet_mac_v8_1_gmii_mii_tx
    port map (
      D(7 downto 0) => int_gmii_txd(7 downto 0),
      I1 => \^o2\,
      I2 => n_2_sync_tx_reset_i,
      O1 => \hd_tieoff.extension_reg_reg\,
      Q(3 downto 0) => Q(3 downto 0),
      SR(0) => n_3_sync_tx_reset_i,
      clk_div5 => clk_div5,
      gmii_txd_falling(3 downto 0) => gmii_txd_falling(3 downto 0),
      gtx_clk => gtx_clk,
      int_gmii_tx_en => int_gmii_tx_en,
      int_gmii_tx_er => int_gmii_tx_er,
      phy_tx_enable => phy_tx_enable,
      rgmii_tx_ctl_int => rgmii_tx_ctl_int,
      tx_configuration_vector(0) => tx_configuration_vector(8),
      tx_en_to_ddr => tx_en_to_ddr
    );
rx_axi_shim: entity work.TriMACtri_mode_ethernet_mac_v8_1_rx_axi_intf
    port map (
      D(1 downto 0) => next_rx_state(1 downto 0),
      I1 => I1,
      I2 => I2,
      I3(7 downto 0) => rx_data(7 downto 0),
      Q(1) => n_0_rx_axi_shim,
      Q(0) => n_1_rx_axi_shim,
      SR(0) => \^o1\,
      rx_axis_mac_tdata(7 downto 0) => rx_axis_mac_tdata(7 downto 0),
      rx_axis_mac_tlast => rx_axis_mac_tlast,
      rx_axis_mac_tuser => rx_axis_mac_tuser,
      rx_axis_mac_tvalid => rx_axis_mac_tvalid,
      rx_mac_tlast0 => rx_mac_tlast0,
      rx_mac_tuser0 => rx_mac_tuser0,
      rx_mac_tvalid0 => n_33_flow
    );
rxgen: entity work.TriMACrx
    port map (
      D(7 downto 0) => gmii_rxd_from_mii(7 downto 0),
      E(0) => n_42_rxgen,
      END_OF_FRAME => END_OF_FRAME,
      I1 => I1,
      I10 => n_15_addr_filter_top,
      I11 => n_13_addr_filter_top,
      I12 => n_8_addr_filter_top,
      I13 => n_14_addr_filter_top,
      I14(0) => n_2_sync_rx_reset_i,
      I2 => I2,
      I3 => n_12_flow,
      I4 => n_11_flow,
      I5 => n_10_flow,
      I6 => n_1_sync_rx_reset_i,
      I7(0) => n_39_rxgen,
      I8 => n_9_flow,
      I9 => n_12_addr_filter_top,
      MATCH_FRAME_INT0 => MATCH_FRAME_INT0,
      O1 => n_0_rxgen,
      O2 => n_8_rxgen,
      O3 => \^o3\,
      O4 => n_9_rxgen,
      O5(0) => n_10_rxgen,
      O6 => n_40_rxgen,
      O7 => n_43_rxgen,
      O8 => n_46_rxgen,
      O9(7 downto 0) => int_rx_data_in(7 downto 0),
      Q(0) => \rx/data_count_reg\(4),
      SR(0) => \^o1\,
      address_valid_early => address_valid_early,
      alignment_err_reg => alignment_err_reg,
      bad_pfc_opcode_int => \rx/bad_pfc_opcode_int\,
      broadcast_byte_match => \address_filter_inst/broadcast_byte_match\,
      broadcastaddressmatch => broadcastaddressmatch,
      data_valid_early => data_valid_early,
      gmii_rx_dv_from_mii => gmii_rx_dv_from_mii,
      gmii_rx_er_from_mii => gmii_rx_er_from_mii,
      int_alignment_err_pulse => int_alignment_err_pulse,
      int_rx_bad_frame_in => int_rx_bad_frame_in,
      int_rx_control_frame => int_rx_control_frame,
      int_rx_data_valid_in => int_rx_data_valid_in,
      int_rx_good_frame_in => int_rx_good_frame_in,
      p_0_out => \address_filter_inst/p_0_out\,
      p_10_out => \address_filter_inst/p_10_out\,
      p_1_out => \address_filter_inst/p_1_out\,
      p_2_out => \address_filter_inst/p_2_out\,
      p_3_out => \address_filter_inst/p_3_out\,
      p_4_out => \address_filter_inst/p_4_out\,
      p_5_out => \address_filter_inst/p_5_out\,
      p_6_out => \address_filter_inst/p_6_out\,
      p_7_out => \address_filter_inst/p_7_out\,
      p_8_out => \address_filter_inst/p_8_out\,
      p_9_out => \address_filter_inst/p_9_out\,
      pause_match_reg0 => pause_match_reg0,
      pauseaddressmatch => pauseaddressmatch,
      rx_bad_frame_comb => rx_bad_frame_comb,
      rx_configuration_vector(21 downto 6) => rx_configuration_vector(24 downto 9),
      rx_configuration_vector(5 downto 4) => rx_configuration_vector(7 downto 6),
      rx_configuration_vector(3 downto 0) => rx_configuration_vector(4 downto 1),
      rx_data_valid_reg1 => \address_filter_inst/rx_data_valid_reg1\,
      rx_enable_reg => rx_enable_reg,
      rx_statistics_valid => rx_statistics_valid,
      rx_statistics_vector(25 downto 23) => rx_statistics_vector(26 downto 24),
      rx_statistics_vector(22 downto 0) => rx_statistics_vector(22 downto 0),
      special_pause_match_comb => special_pause_match_comb,
      specialpauseaddressmatch => specialpauseaddressmatch,
      tx_configuration_vector(1 downto 0) => tx_configuration_vector(8 downto 7),
      update_pause_ad_sync => \address_filter_inst/update_pause_ad_sync\,
      update_pause_ad_sync_reg => \address_filter_inst/update_pause_ad_sync_reg\
    );
rxstatsaddressmatch_del_reg: unisim.vcomponents.FDRE
    port map (
      C => I1,
      CE => \<const1>\,
      D => rxstatsaddressmatch,
      Q => rx_statistics_vector(27),
      R => \^o1\
    );
sync_rx_reset_i: entity work.TriMACtri_mode_ethernet_mac_v8_1_sync_reset_0
    port map (
      END_OF_FRAME => END_OF_FRAME,
      I1 => I1,
      I14(0) => n_2_sync_rx_reset_i,
      I2 => I2,
      O1 => n_1_sync_rx_reset_i,
      SR(0) => \^o1\,
      glbl_rstn => glbl_rstn,
      rx_axi_rstn => rx_axi_rstn,
      rx_configuration_vector(0) => rx_configuration_vector(0)
    );
sync_tx_reset_i: entity work.TriMACtri_mode_ethernet_mac_v8_1_sync_reset
    port map (
      CRC_OK => CRC_OK,
      O1 => \^o2\,
      O2 => n_2_sync_tx_reset_i,
      O3(0) => n_3_sync_tx_reset_i,
      O4 => n_4_sync_tx_reset_i,
      SR(0) => SR(0),
      counter0 => counter0,
      glbl_rstn => glbl_rstn,
      gtx_clk => gtx_clk,
      \hd_tieoff.extension_reg_reg\ => \hd_tieoff.extension_reg_reg\,
      phy_tx_enable => phy_tx_enable,
      tx_axi_rstn => tx_axi_rstn,
      tx_configuration_vector(0) => tx_configuration_vector(0)
    );
\tx_axi_intf.tx_axi_shim\: entity work.TriMACtri_mode_ethernet_mac_v8_1_tx_axi_intf
    port map (
      CE_REG1_OUT7_out => CE_REG1_OUT7_out,
      CRC100_EN => CRC100_EN,
      E(0) => E(0),
      I1 => \^o2\,
      I2 => n_6_flow,
      I3 => n_18_flow,
      I4 => n_42_txgen,
      INT_CRC_MODE => \TX_SM1/INT_CRC_MODE\,
      O1 => \n_4_tx_axi_intf.tx_axi_shim\,
      O2 => \n_5_tx_axi_intf.tx_axi_shim\,
      O3(0) => \n_7_tx_axi_intf.tx_axi_shim\,
      O4(0) => \n_9_tx_axi_intf.tx_axi_shim\,
      O5 => \n_11_tx_axi_intf.tx_axi_shim\,
      O6 => \n_12_tx_axi_intf.tx_axi_shim\,
      O7(7 downto 0) => tx_data_int(7 downto 0),
      PAD => \TX_SM1/PAD\,
      Q(1) => n_47_txgen,
      Q(0) => n_48_txgen,
      SR(0) => \n_8_tx_axi_intf.tx_axi_shim\,
      gtx_clk => gtx_clk,
      load_source => load_source,
      sample => sample,
      tx_ack_int => tx_ack_int,
      tx_axis_mac_tdata(7 downto 0) => tx_axis_mac_tdata(7 downto 0),
      tx_axis_mac_tlast => tx_axis_mac_tlast,
      tx_axis_mac_tuser => tx_axis_mac_tuser,
      tx_axis_mac_tvalid => tx_axis_mac_tvalid,
      tx_ce_sample => tx_ce_sample,
      tx_data_valid_int => tx_data_valid_int,
      tx_enable => tx_enable,
      tx_underrun_int => tx_underrun_int
    );
txgen: entity work.TriMACtx
    port map (
      CE_REG1_OUT7_out => CE_REG1_OUT7_out,
      CRC100_EN => CRC100_EN,
      CRC_OK => CRC_OK,
      D(7 downto 0) => int_gmii_txd(7 downto 0),
      E(0) => \n_7_tx_axi_intf.tx_axi_shim\,
      I1 => \^o2\,
      I10(0) => \n_9_tx_axi_intf.tx_axi_shim\,
      I11(7 downto 0) => int_tx_data_out(7 downto 0),
      I2 => n_14_flow,
      I3 => n_13_flow,
      I4 => n_4_sync_tx_reset_i,
      I5 => n_15_flow,
      I6 => n_16_flow,
      I7 => n_35_flow,
      I8 => n_34_flow,
      I9 => \n_5_tx_axi_intf.tx_axi_shim\,
      INT_CRC_MODE => \TX_SM1/INT_CRC_MODE\,
      INT_ENABLE => INT_ENABLE,
      MAX_PKT_LEN_REACHED => \TX_SM1/MAX_PKT_LEN_REACHED\,
      O1 => n_39_txgen,
      O2 => n_40_txgen,
      O3 => \^o3\,
      O4 => n_41_txgen,
      O5 => n_42_txgen,
      O6 => n_43_txgen,
      O7 => n_44_txgen,
      O8 => n_45_txgen,
      O9 => n_50_txgen,
      PAD => \TX_SM1/PAD\,
      Q(1) => n_47_txgen,
      Q(0) => n_48_txgen,
      REG_DATA_VALID => \TX_SM1/REG_DATA_VALID\,
      SR(0) => \n_8_tx_axi_intf.tx_axi_shim\,
      data_avail_in_reg => \tx/data_avail_in_reg\,
      gtx_clk => gtx_clk,
      int_gmii_tx_en => int_gmii_tx_en,
      int_gmii_tx_er => int_gmii_tx_er,
      int_tx_ack_in => int_tx_ack_in,
      int_tx_crc_enable_out => int_tx_crc_enable_out,
      int_tx_data_valid_out => int_tx_data_valid_out,
      int_tx_vlan_enable_out => int_tx_vlan_enable_out,
      tx_ce_sample => tx_ce_sample,
      tx_configuration_vector(20 downto 2) => tx_configuration_vector(24 downto 6),
      tx_configuration_vector(1) => tx_configuration_vector(4),
      tx_configuration_vector(0) => tx_configuration_vector(1),
      tx_ifg_delay(7 downto 0) => tx_ifg_delay(7 downto 0),
      tx_statistics_valid => \^tx_statistics_valid\,
      tx_statistics_vector(30 downto 0) => tx_statistics_vector(30 downto 0),
      tx_underrun_int => tx_underrun_int_0
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMACTriMAC_block is
  port (
    gtx_clk : in STD_LOGIC;
    glbl_rstn : in STD_LOGIC;
    rx_axi_rstn : in STD_LOGIC;
    tx_axi_rstn : in STD_LOGIC;
    rx_enable : out STD_LOGIC;
    rx_statistics_vector : out STD_LOGIC_VECTOR ( 27 downto 0 );
    rx_statistics_valid : out STD_LOGIC;
    rx_mac_aclk : out STD_LOGIC;
    rx_reset : out STD_LOGIC;
    rx_axis_mac_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_axis_mac_tvalid : out STD_LOGIC;
    rx_axis_mac_tlast : out STD_LOGIC;
    rx_axis_mac_tuser : out STD_LOGIC;
    tx_enable : out STD_LOGIC;
    tx_ifg_delay : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_statistics_vector : out STD_LOGIC_VECTOR ( 31 downto 0 );
    tx_statistics_valid : out STD_LOGIC;
    tx_mac_aclk : out STD_LOGIC;
    tx_reset : out STD_LOGIC;
    tx_axis_mac_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_axis_mac_tvalid : in STD_LOGIC;
    tx_axis_mac_tlast : in STD_LOGIC;
    tx_axis_mac_tuser : in STD_LOGIC;
    tx_axis_mac_tready : out STD_LOGIC;
    pause_req : in STD_LOGIC;
    pause_val : in STD_LOGIC_VECTOR ( 15 downto 0 );
    speedis100 : out STD_LOGIC;
    speedis10100 : out STD_LOGIC;
    rgmii_txd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_tx_ctl : out STD_LOGIC;
    rgmii_txc : out STD_LOGIC;
    rgmii_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_rx_ctl : in STD_LOGIC;
    rgmii_rxc : in STD_LOGIC;
    inband_link_status : out STD_LOGIC;
    inband_clock_speed : out STD_LOGIC_VECTOR ( 1 downto 0 );
    inband_duplex_status : out STD_LOGIC;
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 79 downto 0 );
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 79 downto 0 )
  );
end TriMACTriMAC_block;

architecture STRUCTURE of TriMACTriMAC_block is
  signal \<const1>\ : STD_LOGIC;
  signal clk_div5 : STD_LOGIC;
  signal clk_div5_shift : STD_LOGIC;
  signal counter0 : STD_LOGIC;
  signal gmii_rx_dv_int : STD_LOGIC;
  signal gmii_rx_er_int : STD_LOGIC;
  signal gmii_rxd_int : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal gmii_txd_falling : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal gmii_txd_int : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^gtx_clk\ : STD_LOGIC;
  signal n_0_rx_enable_int_i_1 : STD_LOGIC;
  signal n_65_TriMAC_core : STD_LOGIC;
  signal n_6_enable_gen : STD_LOGIC;
  signal phy_tx_enable : STD_LOGIC;
  signal rgmii_tx_ctl_int : STD_LOGIC;
  signal \^rx_enable\ : STD_LOGIC;
  signal \^rx_mac_aclk\ : STD_LOGIC;
  signal \^rx_reset\ : STD_LOGIC;
  signal rxspeedis10100 : STD_LOGIC;
  signal \^speedis10100\ : STD_LOGIC;
  signal tx_en_to_ddr : STD_LOGIC;
  signal \^tx_enable\ : STD_LOGIC;
  signal \^tx_reset\ : STD_LOGIC;
  attribute DEPTH : integer;
  attribute DEPTH of rxspeedis10100gen : label is 5;
  attribute DONT_TOUCH : boolean;
  attribute DONT_TOUCH of rxspeedis10100gen : label is true;
  attribute INITIALISE : string;
  attribute INITIALISE of rxspeedis10100gen : label is "1'b0";
begin
  \^gtx_clk\ <= gtx_clk;
  rx_enable <= \^rx_enable\;
  rx_mac_aclk <= \^rx_mac_aclk\;
  rx_reset <= \^rx_reset\;
  speedis10100 <= \^speedis10100\;
  tx_enable <= \^tx_enable\;
  tx_mac_aclk <= \^gtx_clk\;
  tx_reset <= \^tx_reset\;
TriMAC_core: entity work.TriMACtri_mode_ethernet_mac_v8_1
    port map (
      D(7 downto 0) => gmii_rxd_int(7 downto 0),
      E(0) => tx_axis_mac_tready,
      I1 => \^rx_mac_aclk\,
      I2 => \^rx_enable\,
      O1 => \^rx_reset\,
      O2 => \^tx_reset\,
      O3 => \^speedis10100\,
      Q(3 downto 0) => gmii_txd_int(3 downto 0),
      SR(0) => n_65_TriMAC_core,
      clk_div5 => clk_div5,
      counter0 => counter0,
      glbl_rstn => glbl_rstn,
      gmii_rx_dv_int => gmii_rx_dv_int,
      gmii_rx_er_int => gmii_rx_er_int,
      gmii_txd_falling(3 downto 0) => gmii_txd_falling(3 downto 0),
      gtx_clk => \^gtx_clk\,
      pause_req => pause_req,
      pause_val(15 downto 0) => pause_val(15 downto 0),
      phy_tx_enable => phy_tx_enable,
      rgmii_tx_ctl_int => rgmii_tx_ctl_int,
      rx_axi_rstn => rx_axi_rstn,
      rx_axis_mac_tdata(7 downto 0) => rx_axis_mac_tdata(7 downto 0),
      rx_axis_mac_tlast => rx_axis_mac_tlast,
      rx_axis_mac_tuser => rx_axis_mac_tuser,
      rx_axis_mac_tvalid => rx_axis_mac_tvalid,
      rx_configuration_vector(72 downto 25) => rx_configuration_vector(79 downto 32),
      rx_configuration_vector(24 downto 10) => rx_configuration_vector(30 downto 16),
      rx_configuration_vector(9) => rx_configuration_vector(14),
      rx_configuration_vector(8) => rx_configuration_vector(11),
      rx_configuration_vector(7 downto 6) => rx_configuration_vector(9 downto 8),
      rx_configuration_vector(5 downto 0) => rx_configuration_vector(5 downto 0),
      rx_statistics_valid => rx_statistics_valid,
      rx_statistics_vector(27 downto 0) => rx_statistics_vector(27 downto 0),
      tx_axi_rstn => tx_axi_rstn,
      tx_axis_mac_tdata(7 downto 0) => tx_axis_mac_tdata(7 downto 0),
      tx_axis_mac_tlast => tx_axis_mac_tlast,
      tx_axis_mac_tuser => tx_axis_mac_tuser,
      tx_axis_mac_tvalid => tx_axis_mac_tvalid,
      tx_configuration_vector(72 downto 25) => tx_configuration_vector(79 downto 32),
      tx_configuration_vector(24 downto 10) => tx_configuration_vector(30 downto 16),
      tx_configuration_vector(9 downto 7) => tx_configuration_vector(14 downto 12),
      tx_configuration_vector(6) => tx_configuration_vector(8),
      tx_configuration_vector(5 downto 0) => tx_configuration_vector(5 downto 0),
      tx_en_to_ddr => tx_en_to_ddr,
      tx_enable => \^tx_enable\,
      tx_ifg_delay(7 downto 0) => tx_ifg_delay(7 downto 0),
      tx_statistics_valid => tx_statistics_valid,
      tx_statistics_vector(31 downto 0) => tx_statistics_vector(31 downto 0)
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => \<const1>\
    );
enable_gen: entity work.TriMACTriMAC_clk_en_gen
    port map (
      I1 => \^tx_reset\,
      O1 => n_6_enable_gen,
      SR(0) => n_65_TriMAC_core,
      clk_div5 => clk_div5,
      clk_div5_shift => clk_div5_shift,
      counter0 => counter0,
      gtx_clk => \^gtx_clk\,
      phy_tx_enable => phy_tx_enable,
      speedis100 => speedis100,
      speedis10100 => \^speedis10100\,
      tx_configuration_vector(1 downto 0) => tx_configuration_vector(13 downto 12),
      tx_enable => \^tx_enable\
    );
rgmii_interface: entity work.TriMACTriMAC_rgmii_v2_0_if
    port map (
      D(7 downto 0) => gmii_rxd_int(7 downto 0),
      I1 => \^tx_reset\,
      I2 => \^rx_reset\,
      I3 => n_6_enable_gen,
      O1 => \^rx_mac_aclk\,
      Q(3 downto 0) => gmii_txd_int(3 downto 0),
      clk_div5 => clk_div5,
      clk_div5_shift => clk_div5_shift,
      gmii_rx_dv_int => gmii_rx_dv_int,
      gmii_rx_er_int => gmii_rx_er_int,
      gmii_txd_falling(3 downto 0) => gmii_txd_falling(3 downto 0),
      gtx_clk => \^gtx_clk\,
      inband_clock_speed(1 downto 0) => inband_clock_speed(1 downto 0),
      inband_duplex_status => inband_duplex_status,
      inband_link_status => inband_link_status,
      rgmii_rx_ctl => rgmii_rx_ctl,
      rgmii_rxc => rgmii_rxc,
      rgmii_rxd(3 downto 0) => rgmii_rxd(3 downto 0),
      rgmii_tx_ctl => rgmii_tx_ctl,
      rgmii_tx_ctl_int => rgmii_tx_ctl_int,
      rgmii_txc => rgmii_txc,
      rgmii_txd(3 downto 0) => rgmii_txd(3 downto 0),
      tx_en_to_ddr => tx_en_to_ddr
    );
rx_enable_int_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => \^rx_enable\,
      I1 => rxspeedis10100,
      O => n_0_rx_enable_int_i_1
    );
rx_enable_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => \^rx_mac_aclk\,
      CE => \<const1>\,
      D => n_0_rx_enable_int_i_1,
      Q => \^rx_enable\,
      R => \^rx_reset\
    );
rxspeedis10100gen: entity work.TriMACTriMAC_block_sync_block
    port map (
      clk => \^rx_mac_aclk\,
      data_in => \^speedis10100\,
      data_out => rxspeedis10100
    );
end STRUCTURE;
library IEEE; use IEEE.STD_LOGIC_1164.ALL;
library UNISIM; use UNISIM.VCOMPONENTS.ALL; 
entity TriMAC is
  port (
    gtx_clk : in STD_LOGIC;
    glbl_rstn : in STD_LOGIC;
    rx_axi_rstn : in STD_LOGIC;
    tx_axi_rstn : in STD_LOGIC;
    rx_enable : out STD_LOGIC;
    rx_statistics_vector : out STD_LOGIC_VECTOR ( 27 downto 0 );
    rx_statistics_valid : out STD_LOGIC;
    rx_mac_aclk : out STD_LOGIC;
    rx_reset : out STD_LOGIC;
    rx_axis_mac_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_axis_mac_tvalid : out STD_LOGIC;
    rx_axis_mac_tlast : out STD_LOGIC;
    rx_axis_mac_tuser : out STD_LOGIC;
    tx_enable : out STD_LOGIC;
    tx_ifg_delay : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_statistics_vector : out STD_LOGIC_VECTOR ( 31 downto 0 );
    tx_statistics_valid : out STD_LOGIC;
    tx_mac_aclk : out STD_LOGIC;
    tx_reset : out STD_LOGIC;
    tx_axis_mac_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_axis_mac_tvalid : in STD_LOGIC;
    tx_axis_mac_tlast : in STD_LOGIC;
    tx_axis_mac_tuser : in STD_LOGIC;
    tx_axis_mac_tready : out STD_LOGIC;
    pause_req : in STD_LOGIC;
    pause_val : in STD_LOGIC_VECTOR ( 15 downto 0 );
    speedis100 : out STD_LOGIC;
    speedis10100 : out STD_LOGIC;
    rgmii_txd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_tx_ctl : out STD_LOGIC;
    rgmii_txc : out STD_LOGIC;
    rgmii_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_rx_ctl : in STD_LOGIC;
    rgmii_rxc : in STD_LOGIC;
    inband_link_status : out STD_LOGIC;
    inband_clock_speed : out STD_LOGIC_VECTOR ( 1 downto 0 );
    inband_duplex_status : out STD_LOGIC;
    rx_configuration_vector : in STD_LOGIC_VECTOR ( 79 downto 0 );
    tx_configuration_vector : in STD_LOGIC_VECTOR ( 79 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of TriMAC : entity is true;
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of TriMAC : entity is "TriMAC,tri_mode_ethernet_mac_v8_1,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=tri_mode_ethernet_mac,x_ipVersion=8.1,x_ipCoreRevision=0,x_ipLanguage=VERILOG,x_ipLicense=tri_mode_eth_mac@2013.12(design_linking),x_ipLicense=10_100_mb_eth_mac@2013.12(design_linking),x_ipLicense=eth_avb_endpoint@2013.12(design_linking),c_component_name=TriMAC,c_physical_interface=RGMII,c_half_duplex=false,c_has_host=false,c_add_filter=true,c_at_entries=0,c_family=virtex7,c_mac_speed=TRI_SPEED,c_has_stats=false,c_num_stats=34,c_cntr_rst=true,c_stats_width=64,c_avb=false,c_1588=0,c_tx_tuser_width=1,c_rx_vec_width=79,c_tx_vec_width=79,c_addr_width=12,c_pfc=false}";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of TriMAC : entity is "TriMAC_block,Vivado 2013.3.0";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of TriMAC : entity is "yes";
end TriMAC;

architecture STRUCTURE of TriMAC is
begin
inst: entity work.TriMACTriMAC_block
    port map (
      glbl_rstn => glbl_rstn,
      gtx_clk => gtx_clk,
      inband_clock_speed(1 downto 0) => inband_clock_speed(1 downto 0),
      inband_duplex_status => inband_duplex_status,
      inband_link_status => inband_link_status,
      pause_req => pause_req,
      pause_val(15 downto 0) => pause_val(15 downto 0),
      rgmii_rx_ctl => rgmii_rx_ctl,
      rgmii_rxc => rgmii_rxc,
      rgmii_rxd(3 downto 0) => rgmii_rxd(3 downto 0),
      rgmii_tx_ctl => rgmii_tx_ctl,
      rgmii_txc => rgmii_txc,
      rgmii_txd(3 downto 0) => rgmii_txd(3 downto 0),
      rx_axi_rstn => rx_axi_rstn,
      rx_axis_mac_tdata(7 downto 0) => rx_axis_mac_tdata(7 downto 0),
      rx_axis_mac_tlast => rx_axis_mac_tlast,
      rx_axis_mac_tuser => rx_axis_mac_tuser,
      rx_axis_mac_tvalid => rx_axis_mac_tvalid,
      rx_configuration_vector(79 downto 0) => rx_configuration_vector(79 downto 0),
      rx_enable => rx_enable,
      rx_mac_aclk => rx_mac_aclk,
      rx_reset => rx_reset,
      rx_statistics_valid => rx_statistics_valid,
      rx_statistics_vector(27 downto 0) => rx_statistics_vector(27 downto 0),
      speedis100 => speedis100,
      speedis10100 => speedis10100,
      tx_axi_rstn => tx_axi_rstn,
      tx_axis_mac_tdata(7 downto 0) => tx_axis_mac_tdata(7 downto 0),
      tx_axis_mac_tlast => tx_axis_mac_tlast,
      tx_axis_mac_tready => tx_axis_mac_tready,
      tx_axis_mac_tuser => tx_axis_mac_tuser,
      tx_axis_mac_tvalid => tx_axis_mac_tvalid,
      tx_configuration_vector(79 downto 0) => tx_configuration_vector(79 downto 0),
      tx_enable => tx_enable,
      tx_ifg_delay(7 downto 0) => tx_ifg_delay(7 downto 0),
      tx_mac_aclk => tx_mac_aclk,
      tx_reset => tx_reset,
      tx_statistics_valid => tx_statistics_valid,
      tx_statistics_vector(31 downto 0) => tx_statistics_vector(31 downto 0)
    );
end STRUCTURE;
