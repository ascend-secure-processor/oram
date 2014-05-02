
##################################################################################################
## Memory Device: DDR3_SDRAM->SODIMMs->MT8JTF12864HZ-1G6
## Data Width: 64
## Time Period: 1250
## Data Mask: 1
##################################################################################################

set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]

#######################################
# UART
#######################################

set_property BOARD_PIN rs232_uart_txd [get_ports uart_txd]
set_property PACKAGE_PIN AU36 [get_ports uart_txd]
set_property IOSTANDARD LVCMOS18 [get_ports uart_txd]
set_property BOARD_PIN rs232_uart_rxd [get_ports uart_rxd]
set_property PACKAGE_PIN AU33 [get_ports uart_rxd]
set_property IOSTANDARD LVCMOS18 [get_ports uart_rxd]

#######################################
# Clocks
#######################################

create_clock -period 5.000 -name ClockF200 [get_ports sys_clk_p]
#set_propagated_clock sys_clk_p

# PadFunction: IO_L12P_T1_MRCC_38 
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]

# PadFunction: IO_L12N_T1_MRCC_38 
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_n]
set_property PACKAGE_PIN E18 [get_ports sys_clk_n]

#######################################
# Reset
#######################################

# PadFunction: IO_L13P_T2_MRCC_15 
set_property IOSTANDARD LVCMOS18 [get_ports sys_rst]
set_property PACKAGE_PIN AV40 [get_ports sys_rst]

#######################################
# GPIO
#######################################

# Bank: 33 - GPIO_LED_0_LS
set_property DRIVE 12 [get_ports {led[0]}]
set_property SLEW SLOW [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[0]}]
set_property PACKAGE_PIN AM39 [get_ports {led[0]}]

# Bank: 33 - GPIO_LED_1_LS
set_property DRIVE 12 [get_ports {led[1]}]
set_property SLEW SLOW [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[1]}]
set_property PACKAGE_PIN AN39 [get_ports {led[1]}]

# Bank: 33 - GPIO_LED_2_LS
set_property DRIVE 12 [get_ports {led[2]}]
set_property SLEW SLOW [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[2]}]
set_property PACKAGE_PIN AR37 [get_ports {led[2]}]

# Bank: 33 - GPIO_LED_3_LS
set_property DRIVE 12 [get_ports {led[3]}]
set_property SLEW SLOW [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[3]}]
set_property PACKAGE_PIN AT37 [get_ports {led[3]}]

# Bank: 33 - GPIO_LED_4_LS
set_property DRIVE 12 [get_ports {led[4]}]
set_property SLEW SLOW [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[4]}]
set_property PACKAGE_PIN AR35 [get_ports {led[4]}]

# Bank: 33 - GPIO_LED_5_LS
set_property DRIVE 12 [get_ports {led[5]}]
set_property SLEW SLOW [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[5]}]
set_property PACKAGE_PIN AP41 [get_ports {led[5]}]

# Bank: 33 - GPIO_LED_6_LS
set_property DRIVE 12 [get_ports {led[6]}]
set_property SLEW SLOW [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[6]}]
set_property PACKAGE_PIN AP42 [get_ports {led[6]}]

# Bank: 33 - GPIO_LED_7_LS
set_property DRIVE 12 [get_ports {led[7]}]
set_property SLEW SLOW [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led[7]}]
set_property PACKAGE_PIN AU39 [get_ports {led[7]}]

#######################################
# DRAM
#######################################

# PadFunction: IO_L23N_T3_39 
set_property SLEW FAST [get_ports {ddr3_dq[0]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[0]}]
set_property PACKAGE_PIN N14 [get_ports {ddr3_dq[0]}]

# PadFunction: IO_L22P_T3_39 
set_property SLEW FAST [get_ports {ddr3_dq[1]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[1]}]
set_property PACKAGE_PIN N13 [get_ports {ddr3_dq[1]}]

# PadFunction: IO_L20N_T3_39 
set_property SLEW FAST [get_ports {ddr3_dq[2]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[2]}]
set_property PACKAGE_PIN L14 [get_ports {ddr3_dq[2]}]

# PadFunction: IO_L20P_T3_39 
set_property SLEW FAST [get_ports {ddr3_dq[3]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[3]}]
set_property PACKAGE_PIN M14 [get_ports {ddr3_dq[3]}]

# PadFunction: IO_L24P_T3_39 
set_property SLEW FAST [get_ports {ddr3_dq[4]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[4]}]
set_property PACKAGE_PIN M12 [get_ports {ddr3_dq[4]}]

# PadFunction: IO_L23P_T3_39 
set_property SLEW FAST [get_ports {ddr3_dq[5]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[5]}]
set_property PACKAGE_PIN N15 [get_ports {ddr3_dq[5]}]

# PadFunction: IO_L24N_T3_39 
set_property SLEW FAST [get_ports {ddr3_dq[6]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[6]}]
set_property PACKAGE_PIN M11 [get_ports {ddr3_dq[6]}]

# PadFunction: IO_L19P_T3_39 
set_property SLEW FAST [get_ports {ddr3_dq[7]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[7]}]
set_property PACKAGE_PIN L12 [get_ports {ddr3_dq[7]}]

# PadFunction: IO_L17P_T2_39 
set_property SLEW FAST [get_ports {ddr3_dq[8]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[8]}]
set_property PACKAGE_PIN K14 [get_ports {ddr3_dq[8]}]

# PadFunction: IO_L17N_T2_39 
set_property SLEW FAST [get_ports {ddr3_dq[9]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[9]}]
set_property PACKAGE_PIN K13 [get_ports {ddr3_dq[9]}]

# PadFunction: IO_L14N_T2_SRCC_39 
set_property SLEW FAST [get_ports {ddr3_dq[10]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[10]}]
set_property PACKAGE_PIN H13 [get_ports {ddr3_dq[10]}]

# PadFunction: IO_L14P_T2_SRCC_39 
set_property SLEW FAST [get_ports {ddr3_dq[11]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[11]}]
set_property PACKAGE_PIN J13 [get_ports {ddr3_dq[11]}]

# PadFunction: IO_L18P_T2_39 
set_property SLEW FAST [get_ports {ddr3_dq[12]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[12]}]
set_property PACKAGE_PIN L16 [get_ports {ddr3_dq[12]}]

# PadFunction: IO_L18N_T2_39 
set_property SLEW FAST [get_ports {ddr3_dq[13]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[13]}]
set_property PACKAGE_PIN L15 [get_ports {ddr3_dq[13]}]

# PadFunction: IO_L13N_T2_MRCC_39 
set_property SLEW FAST [get_ports {ddr3_dq[14]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[14]}]
set_property PACKAGE_PIN H14 [get_ports {ddr3_dq[14]}]

# PadFunction: IO_L16N_T2_39 
set_property SLEW FAST [get_ports {ddr3_dq[15]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[15]}]
set_property PACKAGE_PIN J15 [get_ports {ddr3_dq[15]}]

# PadFunction: IO_L7N_T1_39 
set_property SLEW FAST [get_ports {ddr3_dq[16]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[16]}]
set_property PACKAGE_PIN E15 [get_ports {ddr3_dq[16]}]

# PadFunction: IO_L8N_T1_39 
set_property SLEW FAST [get_ports {ddr3_dq[17]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[17]}]
set_property PACKAGE_PIN E13 [get_ports {ddr3_dq[17]}]

# PadFunction: IO_L11P_T1_SRCC_39 
set_property SLEW FAST [get_ports {ddr3_dq[18]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[18]}]
set_property PACKAGE_PIN F15 [get_ports {ddr3_dq[18]}]

# PadFunction: IO_L8P_T1_39 
set_property SLEW FAST [get_ports {ddr3_dq[19]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[19]}]
set_property PACKAGE_PIN E14 [get_ports {ddr3_dq[19]}]

# PadFunction: IO_L12N_T1_MRCC_39 
set_property SLEW FAST [get_ports {ddr3_dq[20]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[20]}]
set_property PACKAGE_PIN G13 [get_ports {ddr3_dq[20]}]

# PadFunction: IO_L10P_T1_39 
set_property SLEW FAST [get_ports {ddr3_dq[21]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[21]}]
set_property PACKAGE_PIN G12 [get_ports {ddr3_dq[21]}]

# PadFunction: IO_L11N_T1_SRCC_39 
set_property SLEW FAST [get_ports {ddr3_dq[22]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[22]}]
set_property PACKAGE_PIN F14 [get_ports {ddr3_dq[22]}]

# PadFunction: IO_L12P_T1_MRCC_39 
set_property SLEW FAST [get_ports {ddr3_dq[23]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[23]}]
set_property PACKAGE_PIN G14 [get_ports {ddr3_dq[23]}]

# PadFunction: IO_L2P_T0_39 
set_property SLEW FAST [get_ports {ddr3_dq[24]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[24]}]
set_property PACKAGE_PIN B14 [get_ports {ddr3_dq[24]}]

# PadFunction: IO_L4N_T0_39 
set_property SLEW FAST [get_ports {ddr3_dq[25]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[25]}]
set_property PACKAGE_PIN C13 [get_ports {ddr3_dq[25]}]

# PadFunction: IO_L1N_T0_39 
set_property SLEW FAST [get_ports {ddr3_dq[26]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[26]}]
set_property PACKAGE_PIN B16 [get_ports {ddr3_dq[26]}]

# PadFunction: IO_L5N_T0_39 
set_property SLEW FAST [get_ports {ddr3_dq[27]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[27]}]
set_property PACKAGE_PIN D15 [get_ports {ddr3_dq[27]}]

# PadFunction: IO_L4P_T0_39 
set_property SLEW FAST [get_ports {ddr3_dq[28]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[28]}]
set_property PACKAGE_PIN D13 [get_ports {ddr3_dq[28]}]

# PadFunction: IO_L6P_T0_39 
set_property SLEW FAST [get_ports {ddr3_dq[29]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[29]}]
set_property PACKAGE_PIN E12 [get_ports {ddr3_dq[29]}]

# PadFunction: IO_L1P_T0_39 
set_property SLEW FAST [get_ports {ddr3_dq[30]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[30]}]
set_property PACKAGE_PIN C16 [get_ports {ddr3_dq[30]}]

# PadFunction: IO_L5P_T0_39 
set_property SLEW FAST [get_ports {ddr3_dq[31]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[31]}]
set_property PACKAGE_PIN D16 [get_ports {ddr3_dq[31]}]

# PadFunction: IO_L1P_T0_37 
set_property SLEW FAST [get_ports {ddr3_dq[32]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[32]}]
set_property PACKAGE_PIN A24 [get_ports {ddr3_dq[32]}]

# PadFunction: IO_L4N_T0_37 
set_property SLEW FAST [get_ports {ddr3_dq[33]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[33]}]
set_property PACKAGE_PIN B23 [get_ports {ddr3_dq[33]}]

# PadFunction: IO_L5N_T0_37 
set_property SLEW FAST [get_ports {ddr3_dq[34]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[34]}]
set_property PACKAGE_PIN B27 [get_ports {ddr3_dq[34]}]

# PadFunction: IO_L5P_T0_37 
set_property SLEW FAST [get_ports {ddr3_dq[35]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[35]}]
set_property PACKAGE_PIN B26 [get_ports {ddr3_dq[35]}]

# PadFunction: IO_L2N_T0_37 
set_property SLEW FAST [get_ports {ddr3_dq[36]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[36]}]
set_property PACKAGE_PIN A22 [get_ports {ddr3_dq[36]}]

# PadFunction: IO_L2P_T0_37 
set_property SLEW FAST [get_ports {ddr3_dq[37]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[37]}]
set_property PACKAGE_PIN B22 [get_ports {ddr3_dq[37]}]

# PadFunction: IO_L1N_T0_37 
set_property SLEW FAST [get_ports {ddr3_dq[38]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[38]}]
set_property PACKAGE_PIN A25 [get_ports {ddr3_dq[38]}]

# PadFunction: IO_L6P_T0_37 
set_property SLEW FAST [get_ports {ddr3_dq[39]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[39]}]
set_property PACKAGE_PIN C24 [get_ports {ddr3_dq[39]}]

# PadFunction: IO_L7N_T1_37 
set_property SLEW FAST [get_ports {ddr3_dq[40]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[40]}]
set_property PACKAGE_PIN E24 [get_ports {ddr3_dq[40]}]

# PadFunction: IO_L10N_T1_37 
set_property SLEW FAST [get_ports {ddr3_dq[41]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[41]}]
set_property PACKAGE_PIN D23 [get_ports {ddr3_dq[41]}]

# PadFunction: IO_L11N_T1_SRCC_37 
set_property SLEW FAST [get_ports {ddr3_dq[42]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[42]}]
set_property PACKAGE_PIN D26 [get_ports {ddr3_dq[42]}]

# PadFunction: IO_L12P_T1_MRCC_37 
set_property SLEW FAST [get_ports {ddr3_dq[43]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[43]}]
set_property PACKAGE_PIN C25 [get_ports {ddr3_dq[43]}]

# PadFunction: IO_L7P_T1_37 
set_property SLEW FAST [get_ports {ddr3_dq[44]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[44]}]
set_property PACKAGE_PIN E23 [get_ports {ddr3_dq[44]}]

# PadFunction: IO_L10P_T1_37 
set_property SLEW FAST [get_ports {ddr3_dq[45]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[45]}]
set_property PACKAGE_PIN D22 [get_ports {ddr3_dq[45]}]

# PadFunction: IO_L8P_T1_37 
set_property SLEW FAST [get_ports {ddr3_dq[46]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[46]}]
set_property PACKAGE_PIN F22 [get_ports {ddr3_dq[46]}]

# PadFunction: IO_L8N_T1_37 
set_property SLEW FAST [get_ports {ddr3_dq[47]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[47]}]
set_property PACKAGE_PIN E22 [get_ports {ddr3_dq[47]}]

# PadFunction: IO_L17N_T2_37 
set_property SLEW FAST [get_ports {ddr3_dq[48]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[48]}]
set_property PACKAGE_PIN A30 [get_ports {ddr3_dq[48]}]

# PadFunction: IO_L13P_T2_MRCC_37 
set_property SLEW FAST [get_ports {ddr3_dq[49]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[49]}]
set_property PACKAGE_PIN D27 [get_ports {ddr3_dq[49]}]

# PadFunction: IO_L17P_T2_37 
set_property SLEW FAST [get_ports {ddr3_dq[50]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[50]}]
set_property PACKAGE_PIN A29 [get_ports {ddr3_dq[50]}]

# PadFunction: IO_L14P_T2_SRCC_37 
set_property SLEW FAST [get_ports {ddr3_dq[51]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[51]}]
set_property PACKAGE_PIN C28 [get_ports {ddr3_dq[51]}]

# PadFunction: IO_L13N_T2_MRCC_37 
set_property SLEW FAST [get_ports {ddr3_dq[52]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[52]}]
set_property PACKAGE_PIN D28 [get_ports {ddr3_dq[52]}]

# PadFunction: IO_L18N_T2_37 
set_property SLEW FAST [get_ports {ddr3_dq[53]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[53]}]
set_property PACKAGE_PIN B31 [get_ports {ddr3_dq[53]}]

# PadFunction: IO_L16P_T2_37 
set_property SLEW FAST [get_ports {ddr3_dq[54]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[54]}]
set_property PACKAGE_PIN A31 [get_ports {ddr3_dq[54]}]

# PadFunction: IO_L16N_T2_37 
set_property SLEW FAST [get_ports {ddr3_dq[55]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[55]}]
set_property PACKAGE_PIN A32 [get_ports {ddr3_dq[55]}]

# PadFunction: IO_L19P_T3_37 
set_property SLEW FAST [get_ports {ddr3_dq[56]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[56]}]
set_property PACKAGE_PIN E30 [get_ports {ddr3_dq[56]}]

# PadFunction: IO_L22P_T3_37 
set_property SLEW FAST [get_ports {ddr3_dq[57]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[57]}]
set_property PACKAGE_PIN F29 [get_ports {ddr3_dq[57]}]

# PadFunction: IO_L24P_T3_37 
set_property SLEW FAST [get_ports {ddr3_dq[58]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[58]}]
set_property PACKAGE_PIN F30 [get_ports {ddr3_dq[58]}]

# PadFunction: IO_L23N_T3_37 
set_property SLEW FAST [get_ports {ddr3_dq[59]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[59]}]
set_property PACKAGE_PIN F27 [get_ports {ddr3_dq[59]}]

# PadFunction: IO_L20N_T3_37 
set_property SLEW FAST [get_ports {ddr3_dq[60]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[60]}]
set_property PACKAGE_PIN C30 [get_ports {ddr3_dq[60]}]

# PadFunction: IO_L22N_T3_37 
set_property SLEW FAST [get_ports {ddr3_dq[61]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[61]}]
set_property PACKAGE_PIN E29 [get_ports {ddr3_dq[61]}]

# PadFunction: IO_L23P_T3_37 
set_property SLEW FAST [get_ports {ddr3_dq[62]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[62]}]
set_property PACKAGE_PIN F26 [get_ports {ddr3_dq[62]}]

# PadFunction: IO_L20P_T3_37 
set_property SLEW FAST [get_ports {ddr3_dq[63]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[63]}]
set_property PACKAGE_PIN D30 [get_ports {ddr3_dq[63]}]

# PadFunction: IO_L5N_T0_38 
set_property SLEW FAST [get_ports {ddr3_addr[13]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[13]}]
set_property PACKAGE_PIN A21 [get_ports {ddr3_addr[13]}]

# PadFunction: IO_L2N_T0_38 
set_property SLEW FAST [get_ports {ddr3_addr[12]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[12]}]
set_property PACKAGE_PIN A15 [get_ports {ddr3_addr[12]}]

# PadFunction: IO_L4P_T0_38 
set_property SLEW FAST [get_ports {ddr3_addr[11]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[11]}]
set_property PACKAGE_PIN B17 [get_ports {ddr3_addr[11]}]

# PadFunction: IO_L5P_T0_38 
set_property SLEW FAST [get_ports {ddr3_addr[10]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[10]}]
set_property PACKAGE_PIN B21 [get_ports {ddr3_addr[10]}]

# PadFunction: IO_L1P_T0_38 
set_property SLEW FAST [get_ports {ddr3_addr[9]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[9]}]
set_property PACKAGE_PIN C19 [get_ports {ddr3_addr[9]}]

# PadFunction: IO_L10N_T1_38 
set_property SLEW FAST [get_ports {ddr3_addr[8]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[8]}]
set_property PACKAGE_PIN D17 [get_ports {ddr3_addr[8]}]

# PadFunction: IO_L6P_T0_38 
set_property SLEW FAST [get_ports {ddr3_addr[7]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[7]}]
set_property PACKAGE_PIN C18 [get_ports {ddr3_addr[7]}]

# PadFunction: IO_L7P_T1_38 
set_property SLEW FAST [get_ports {ddr3_addr[6]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[6]}]
set_property PACKAGE_PIN D20 [get_ports {ddr3_addr[6]}]

# PadFunction: IO_L2P_T0_38 
set_property SLEW FAST [get_ports {ddr3_addr[5]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[5]}]
set_property PACKAGE_PIN A16 [get_ports {ddr3_addr[5]}]

# PadFunction: IO_L4N_T0_38 
set_property SLEW FAST [get_ports {ddr3_addr[4]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[4]}]
set_property PACKAGE_PIN A17 [get_ports {ddr3_addr[4]}]

# PadFunction: IO_L3N_T0_DQS_38 
set_property SLEW FAST [get_ports {ddr3_addr[3]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[3]}]
set_property PACKAGE_PIN A19 [get_ports {ddr3_addr[3]}]

# PadFunction: IO_L7N_T1_38 
set_property SLEW FAST [get_ports {ddr3_addr[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[2]}]
set_property PACKAGE_PIN C20 [get_ports {ddr3_addr[2]}]

# PadFunction: IO_L1N_T0_38 
set_property SLEW FAST [get_ports {ddr3_addr[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[1]}]
set_property PACKAGE_PIN B19 [get_ports {ddr3_addr[1]}]

# PadFunction: IO_L3P_T0_DQS_38 
set_property SLEW FAST [get_ports {ddr3_addr[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[0]}]
set_property PACKAGE_PIN A20 [get_ports {ddr3_addr[0]}]

# PadFunction: IO_L10P_T1_38 
set_property SLEW FAST [get_ports {ddr3_ba[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[2]}]
set_property PACKAGE_PIN D18 [get_ports {ddr3_ba[2]}]

# PadFunction: IO_L9N_T1_DQS_38 
set_property SLEW FAST [get_ports {ddr3_ba[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[1]}]
set_property PACKAGE_PIN C21 [get_ports {ddr3_ba[1]}]

# PadFunction: IO_L9P_T1_DQS_38 
set_property SLEW FAST [get_ports {ddr3_ba[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[0]}]
set_property PACKAGE_PIN D21 [get_ports {ddr3_ba[0]}]

# PadFunction: IO_L15N_T2_DQS_38 
set_property SLEW FAST [get_ports ddr3_ras_n]
set_property IOSTANDARD SSTL15 [get_ports ddr3_ras_n]
set_property PACKAGE_PIN E20 [get_ports ddr3_ras_n]

# PadFunction: IO_L16P_T2_38 
set_property SLEW FAST [get_ports ddr3_cas_n]
set_property IOSTANDARD SSTL15 [get_ports ddr3_cas_n]
set_property PACKAGE_PIN K17 [get_ports ddr3_cas_n]

# PadFunction: IO_L15P_T2_DQS_38 
set_property SLEW FAST [get_ports ddr3_we_n]
set_property IOSTANDARD SSTL15 [get_ports ddr3_we_n]
set_property PACKAGE_PIN F20 [get_ports ddr3_we_n]

# PadFunction: IO_L14N_T2_SRCC_37 
set_property SLEW FAST [get_ports ddr3_reset_n]
set_property IOSTANDARD LVCMOS15 [get_ports ddr3_reset_n]
set_property PACKAGE_PIN C29 [get_ports ddr3_reset_n]

# PadFunction: IO_L14P_T2_SRCC_38 
set_property SLEW FAST [get_ports {ddr3_cke[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cke[0]}]
set_property PACKAGE_PIN K19 [get_ports {ddr3_cke[0]}]

# PadFunction: IO_L17N_T2_38 
set_property SLEW FAST [get_ports {ddr3_odt[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_odt[0]}]
set_property PACKAGE_PIN H20 [get_ports {ddr3_odt[0]}]

# PadFunction: IO_L16N_T2_38 
set_property SLEW FAST [get_ports {ddr3_cs_n[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cs_n[0]}]
set_property PACKAGE_PIN J17 [get_ports {ddr3_cs_n[0]}]

# PadFunction: IO_L22N_T3_39 
set_property SLEW FAST [get_ports {ddr3_dm[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[0]}]
set_property PACKAGE_PIN M13 [get_ports {ddr3_dm[0]}]

# PadFunction: IO_L16P_T2_39 
set_property SLEW FAST [get_ports {ddr3_dm[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[1]}]
set_property PACKAGE_PIN K15 [get_ports {ddr3_dm[1]}]

# PadFunction: IO_L10N_T1_39 
set_property SLEW FAST [get_ports {ddr3_dm[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[2]}]
set_property PACKAGE_PIN F12 [get_ports {ddr3_dm[2]}]

# PadFunction: IO_L2N_T0_39 
set_property SLEW FAST [get_ports {ddr3_dm[3]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[3]}]
set_property PACKAGE_PIN A14 [get_ports {ddr3_dm[3]}]

# PadFunction: IO_L4P_T0_37 
set_property SLEW FAST [get_ports {ddr3_dm[4]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[4]}]
set_property PACKAGE_PIN C23 [get_ports {ddr3_dm[4]}]

# PadFunction: IO_L11P_T1_SRCC_37 
set_property SLEW FAST [get_ports {ddr3_dm[5]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[5]}]
set_property PACKAGE_PIN D25 [get_ports {ddr3_dm[5]}]

# PadFunction: IO_L18P_T2_37 
set_property SLEW FAST [get_ports {ddr3_dm[6]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[6]}]
set_property PACKAGE_PIN C31 [get_ports {ddr3_dm[6]}]

# PadFunction: IO_L24N_T3_37 
set_property SLEW FAST [get_ports {ddr3_dm[7]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[7]}]
set_property PACKAGE_PIN F31 [get_ports {ddr3_dm[7]}]

# PadFunction: IO_L21P_T3_DQS_39 
set_property SLEW FAST [get_ports {ddr3_dqs_p[0]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[0]}]

# PadFunction: IO_L21N_T3_DQS_39 
set_property SLEW FAST [get_ports {ddr3_dqs_n[0]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[0]}]
set_property PACKAGE_PIN M16 [get_ports {ddr3_dqs_n[0]}]

# PadFunction: IO_L15P_T2_DQS_39 
set_property SLEW FAST [get_ports {ddr3_dqs_p[1]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[1]}]

# PadFunction: IO_L15N_T2_DQS_39 
set_property SLEW FAST [get_ports {ddr3_dqs_n[1]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[1]}]
set_property PACKAGE_PIN J12 [get_ports {ddr3_dqs_n[1]}]

# PadFunction: IO_L9P_T1_DQS_39 
set_property SLEW FAST [get_ports {ddr3_dqs_p[2]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[2]}]

# PadFunction: IO_L9N_T1_DQS_39 
set_property SLEW FAST [get_ports {ddr3_dqs_n[2]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[2]}]
set_property PACKAGE_PIN G16 [get_ports {ddr3_dqs_n[2]}]

# PadFunction: IO_L3P_T0_DQS_39 
set_property SLEW FAST [get_ports {ddr3_dqs_p[3]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[3]}]

# PadFunction: IO_L3N_T0_DQS_39 
set_property SLEW FAST [get_ports {ddr3_dqs_n[3]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[3]}]
set_property PACKAGE_PIN C14 [get_ports {ddr3_dqs_n[3]}]

# PadFunction: IO_L3P_T0_DQS_37 
set_property SLEW FAST [get_ports {ddr3_dqs_p[4]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[4]}]

# PadFunction: IO_L3N_T0_DQS_37 
set_property SLEW FAST [get_ports {ddr3_dqs_n[4]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[4]}]
set_property PACKAGE_PIN A27 [get_ports {ddr3_dqs_n[4]}]

# PadFunction: IO_L9P_T1_DQS_37 
set_property SLEW FAST [get_ports {ddr3_dqs_p[5]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[5]}]

# PadFunction: IO_L9N_T1_DQS_37 
set_property SLEW FAST [get_ports {ddr3_dqs_n[5]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[5]}]
set_property PACKAGE_PIN E25 [get_ports {ddr3_dqs_n[5]}]

# PadFunction: IO_L15P_T2_DQS_37 
set_property SLEW FAST [get_ports {ddr3_dqs_p[6]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[6]}]

# PadFunction: IO_L15N_T2_DQS_37 
set_property SLEW FAST [get_ports {ddr3_dqs_n[6]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[6]}]
set_property PACKAGE_PIN B29 [get_ports {ddr3_dqs_n[6]}]

# PadFunction: IO_L21P_T3_DQS_37 
set_property SLEW FAST [get_ports {ddr3_dqs_p[7]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[7]}]

# PadFunction: IO_L21N_T3_DQS_37 
set_property SLEW FAST [get_ports {ddr3_dqs_n[7]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[7]}]
set_property PACKAGE_PIN E28 [get_ports {ddr3_dqs_n[7]}]

# PadFunction: IO_L13P_T2_MRCC_38 
set_property SLEW FAST [get_ports {ddr3_ck_p[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_p[0]}]

# PadFunction: IO_L13N_T2_MRCC_38 
set_property SLEW FAST [get_ports {ddr3_ck_n[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_n[0]}]
set_property PACKAGE_PIN G18 [get_ports {ddr3_ck_n[0]}]

################################################################################
# DDR3 MIG 7
################################################################################

set_property LOC PHASER_OUT_PHY_X1Y19 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/phaser_out]
set_property LOC PHASER_OUT_PHY_X1Y18 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/phaser_out]
set_property LOC PHASER_OUT_PHY_X1Y17 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/phaser_out]
set_property LOC PHASER_OUT_PHY_X1Y16 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/phaser_out]
set_property LOC PHASER_OUT_PHY_X1Y23 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/phaser_out]
set_property LOC PHASER_OUT_PHY_X1Y22 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/phaser_out]
set_property LOC PHASER_OUT_PHY_X1Y21 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/phaser_out]
set_property LOC PHASER_OUT_PHY_X1Y27 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/phaser_out]
set_property LOC PHASER_OUT_PHY_X1Y26 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/phaser_out]
set_property LOC PHASER_OUT_PHY_X1Y25 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/phaser_out]
set_property LOC PHASER_OUT_PHY_X1Y24 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/phaser_out]

set_property LOC PHASER_IN_PHY_X1Y19 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/phaser_in_gen.phaser_in]
set_property LOC PHASER_IN_PHY_X1Y18 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/phaser_in_gen.phaser_in]
set_property LOC PHASER_IN_PHY_X1Y17 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/phaser_in_gen.phaser_in]
set_property LOC PHASER_IN_PHY_X1Y16 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/phaser_in_gen.phaser_in]
set_property LOC PHASER_IN_PHY_X1Y27 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/phaser_in_gen.phaser_in]
set_property LOC PHASER_IN_PHY_X1Y26 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/phaser_in_gen.phaser_in]
set_property LOC PHASER_IN_PHY_X1Y25 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/phaser_in_gen.phaser_in]
set_property LOC PHASER_IN_PHY_X1Y24 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/phaser_in_gen.phaser_in]

set_property LOC OUT_FIFO_X1Y19 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/out_fifo]
set_property LOC OUT_FIFO_X1Y18 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/out_fifo]
set_property LOC OUT_FIFO_X1Y17 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/out_fifo]
set_property LOC OUT_FIFO_X1Y16 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/out_fifo]
set_property LOC OUT_FIFO_X1Y23 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/out_fifo]
set_property LOC OUT_FIFO_X1Y22 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/out_fifo]
set_property LOC OUT_FIFO_X1Y21 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/out_fifo]
set_property LOC OUT_FIFO_X1Y27 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/out_fifo]
set_property LOC OUT_FIFO_X1Y26 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/out_fifo]
set_property LOC OUT_FIFO_X1Y25 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/out_fifo]
set_property LOC OUT_FIFO_X1Y24 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/out_fifo]

set_property LOC IN_FIFO_X1Y19 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/in_fifo_gen.in_fifo]
set_property LOC IN_FIFO_X1Y18 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/in_fifo_gen.in_fifo]
set_property LOC IN_FIFO_X1Y17 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/in_fifo_gen.in_fifo]
set_property LOC IN_FIFO_X1Y16 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/in_fifo_gen.in_fifo]
set_property LOC IN_FIFO_X1Y27 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/in_fifo_gen.in_fifo]
set_property LOC IN_FIFO_X1Y26 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/in_fifo_gen.in_fifo]
set_property LOC IN_FIFO_X1Y25 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/in_fifo_gen.in_fifo]
set_property LOC IN_FIFO_X1Y24 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/in_fifo_gen.in_fifo]

set_property LOC PHY_CONTROL_X1Y4 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/phy_control_i]
set_property LOC PHY_CONTROL_X1Y5 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.u_ddr_phy_4lanes/phy_control_i]
set_property LOC PHY_CONTROL_X1Y6 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/phy_control_i]

set_property LOC PHASER_REF_X1Y4 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/phaser_ref_i]
set_property LOC PHASER_REF_X1Y5 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_1.u_ddr_phy_4lanes/phaser_ref_i]
set_property LOC PHASER_REF_X1Y6 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/phaser_ref_i]

set_property LOC OLOGIC_X1Y243 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/ddr_byte_group_io/slave_ts.oserdes_slave_ts]
set_property LOC OLOGIC_X1Y231 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/ddr_byte_group_io/slave_ts.oserdes_slave_ts]
set_property LOC OLOGIC_X1Y219 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/ddr_byte_group_io/slave_ts.oserdes_slave_ts]
set_property LOC OLOGIC_X1Y207 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_2.u_ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/ddr_byte_group_io/slave_ts.oserdes_slave_ts]
set_property LOC OLOGIC_X1Y343 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_D.ddr_byte_lane_D/ddr_byte_group_io/slave_ts.oserdes_slave_ts]
set_property LOC OLOGIC_X1Y331 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_C.ddr_byte_lane_C/ddr_byte_group_io/slave_ts.oserdes_slave_ts]
set_property LOC OLOGIC_X1Y319 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_B.ddr_byte_lane_B/ddr_byte_group_io/slave_ts.oserdes_slave_ts]
set_property LOC OLOGIC_X1Y307 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/u_ddr_mc_phy/ddr_phy_4lanes_0.u_ddr_phy_4lanes/ddr_byte_lane_A.ddr_byte_lane_A/ddr_byte_group_io/slave_ts.oserdes_slave_ts]

set_property LOC PLLE2_ADV_X1Y5 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_ddr3_infrastructure/plle2_i]
set_property LOC MMCME2_ADV_X1Y5 [get_cells DDR3SDRAMController/u_DDR3SDRAM_mig/u_ddr3_infrastructure/gen_mmcm.mmcm_i]

set_multicycle_path -setup -from [get_cells -hier -filter {NAME =~ */mc0/mc_read_idle_r_reg}] -to [get_cells -hier -filter {NAME =~ */input_[?].iserdes_dq_.iserdesdq}] 6
set_multicycle_path -hold -from [get_cells -hier -filter {NAME =~ */mc0/mc_read_idle_r_reg}] -to [get_cells -hier -filter {NAME =~ */input_[?].iserdes_dq_.iserdesdq}] 5

set_false_path -through [get_pins -filter {NAME =~ */DQSFOUND} -of [get_cells -hier -filter {REF_NAME == PHASER_IN_PHY}]]

set_multicycle_path -setup -start -through [get_pins -filter {NAME =~ */OSERDESRST} -of [get_cells -hier -filter {REF_NAME ==  PHASER_OUT_PHY}]] 2
set_multicycle_path -hold -start -through [get_pins -filter {NAME =~ */OSERDESRST} -of [get_cells -hier -filter {REF_NAME == PHASER_OUT_PHY}]] 1

set_max_delay -datapath_only -from [get_cells -hier -filter {NAME =~ *temp_mon_enabled.u_tempmon/*}] -to [get_cells -hier -filter {NAME =~ *temp_mon_enabled.u_tempmon/device_temp_sync_r1*}] 20.000
set_max_delay -datapath_only -from [get_cells -hier *rstdiv0_sync_r1_reg*] -to [get_pins -filter {NAME =~ */RESET} -of [get_cells -hier -filter {REF_NAME == PHY_CONTROL}]] 5.000

set_max_delay -datapath_only -from [get_cells -hier -filter {NAME =~ *ddr3_infrastructure/rstdiv0_sync_r1_reg*}] -to [get_cells -hier -filter {NAME =~ *temp_mon_enabled.u_tempmon/xadc_supplied_temperature.rst_r1*}] 20.000

################################################################################
# ChipScope cores
################################################################################

create_debug_core u_ila_0 labtools_ila_v3
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list SlowClock]]
set_property port_width 7 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {oram/back_end/bend_inner/stash_top/StashOccupancy[0]} {oram/back_end/bend_inner/stash_top/StashOccupancy[1]} {oram/back_end/bend_inner/stash_top/StashOccupancy[2]} {oram/back_end/bend_inner/stash_top/StashOccupancy[3]} {oram/back_end/bend_inner/stash_top/StashOccupancy[4]} {oram/back_end/bend_inner/stash_top/StashOccupancy[5]} {oram/back_end/bend_inner/stash_top/StashOccupancy[6]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {oram/back_end/AES_DRAMReadData[0]} {oram/back_end/AES_DRAMReadData[1]} {oram/back_end/AES_DRAMReadData[2]} {oram/back_end/AES_DRAMReadData[3]} {oram/back_end/AES_DRAMReadData[4]} {oram/back_end/AES_DRAMReadData[5]} {oram/back_end/AES_DRAMReadData[6]} {oram/back_end/AES_DRAMReadData[7]} {oram/back_end/AES_DRAMReadData[8]} {oram/back_end/AES_DRAMReadData[9]} {oram/back_end/AES_DRAMReadData[10]} {oram/back_end/AES_DRAMReadData[11]} {oram/back_end/AES_DRAMReadData[12]} {oram/back_end/AES_DRAMReadData[13]} {oram/back_end/AES_DRAMReadData[14]} {oram/back_end/AES_DRAMReadData[15]} {oram/back_end/AES_DRAMReadData[16]} {oram/back_end/AES_DRAMReadData[17]} {oram/back_end/AES_DRAMReadData[18]} {oram/back_end/AES_DRAMReadData[19]} {oram/back_end/AES_DRAMReadData[20]} {oram/back_end/AES_DRAMReadData[21]} {oram/back_end/AES_DRAMReadData[22]} {oram/back_end/AES_DRAMReadData[23]} {oram/back_end/AES_DRAMReadData[24]} {oram/back_end/AES_DRAMReadData[25]} {oram/back_end/AES_DRAMReadData[26]} {oram/back_end/AES_DRAMReadData[27]} {oram/back_end/AES_DRAMReadData[28]} {oram/back_end/AES_DRAMReadData[29]} {oram/back_end/AES_DRAMReadData[30]} {oram/back_end/AES_DRAMReadData[31]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {oram/back_end/AES_DRAMWriteData[0]} {oram/back_end/AES_DRAMWriteData[1]} {oram/back_end/AES_DRAMWriteData[2]} {oram/back_end/AES_DRAMWriteData[3]} {oram/back_end/AES_DRAMWriteData[4]} {oram/back_end/AES_DRAMWriteData[5]} {oram/back_end/AES_DRAMWriteData[6]} {oram/back_end/AES_DRAMWriteData[7]} {oram/back_end/AES_DRAMWriteData[8]} {oram/back_end/AES_DRAMWriteData[9]} {oram/back_end/AES_DRAMWriteData[10]} {oram/back_end/AES_DRAMWriteData[11]} {oram/back_end/AES_DRAMWriteData[12]} {oram/back_end/AES_DRAMWriteData[13]} {oram/back_end/AES_DRAMWriteData[14]} {oram/back_end/AES_DRAMWriteData[15]} {oram/back_end/AES_DRAMWriteData[16]} {oram/back_end/AES_DRAMWriteData[17]} {oram/back_end/AES_DRAMWriteData[18]} {oram/back_end/AES_DRAMWriteData[19]} {oram/back_end/AES_DRAMWriteData[20]} {oram/back_end/AES_DRAMWriteData[21]} {oram/back_end/AES_DRAMWriteData[22]} {oram/back_end/AES_DRAMWriteData[23]} {oram/back_end/AES_DRAMWriteData[24]} {oram/back_end/AES_DRAMWriteData[25]} {oram/back_end/AES_DRAMWriteData[26]} {oram/back_end/AES_DRAMWriteData[27]} {oram/back_end/AES_DRAMWriteData[28]} {oram/back_end/AES_DRAMWriteData[29]} {oram/back_end/AES_DRAMWriteData[30]} {oram/back_end/AES_DRAMWriteData[31]}]]
create_debug_port u_ila_0 probe
set_property port_width 20 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {oram/RemappedLeaf[0]} {oram/RemappedLeaf[1]} {oram/RemappedLeaf[2]} {oram/RemappedLeaf[3]} {oram/RemappedLeaf[4]} {oram/RemappedLeaf[5]} {oram/RemappedLeaf[6]} {oram/RemappedLeaf[7]} {oram/RemappedLeaf[8]} {oram/RemappedLeaf[9]} {oram/RemappedLeaf[10]} {oram/RemappedLeaf[11]} {oram/RemappedLeaf[12]} {oram/RemappedLeaf[13]} {oram/RemappedLeaf[14]} {oram/RemappedLeaf[15]} {oram/RemappedLeaf[16]} {oram/RemappedLeaf[17]} {oram/RemappedLeaf[18]} {oram/RemappedLeaf[19]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {oram/BEnd_PAddr[0]} {oram/BEnd_PAddr[1]} {oram/BEnd_PAddr[2]} {oram/BEnd_PAddr[3]} {oram/BEnd_PAddr[4]} {oram/BEnd_PAddr[5]} {oram/BEnd_PAddr[6]} {oram/BEnd_PAddr[7]} {oram/BEnd_PAddr[8]} {oram/BEnd_PAddr[9]} {oram/BEnd_PAddr[10]} {oram/BEnd_PAddr[11]} {oram/BEnd_PAddr[12]} {oram/BEnd_PAddr[13]} {oram/BEnd_PAddr[14]} {oram/BEnd_PAddr[15]} {oram/BEnd_PAddr[16]} {oram/BEnd_PAddr[17]} {oram/BEnd_PAddr[18]} {oram/BEnd_PAddr[19]} {oram/BEnd_PAddr[20]} {oram/BEnd_PAddr[21]} {oram/BEnd_PAddr[22]} {oram/BEnd_PAddr[23]} {oram/BEnd_PAddr[24]} {oram/BEnd_PAddr[25]} {oram/BEnd_PAddr[26]} {oram/BEnd_PAddr[27]} {oram/BEnd_PAddr[28]} {oram/BEnd_PAddr[29]} {oram/BEnd_PAddr[30]} {oram/BEnd_PAddr[31]}]]
create_debug_port u_ila_0 probe
set_property port_width 2 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {oram/BEnd_Cmd[0]} {oram/BEnd_Cmd[1]}]]
create_debug_port u_ila_0 probe
set_property port_width 20 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {oram/CurrentLeaf[0]} {oram/CurrentLeaf[1]} {oram/CurrentLeaf[2]} {oram/CurrentLeaf[3]} {oram/CurrentLeaf[4]} {oram/CurrentLeaf[5]} {oram/CurrentLeaf[6]} {oram/CurrentLeaf[7]} {oram/CurrentLeaf[8]} {oram/CurrentLeaf[9]} {oram/CurrentLeaf[10]} {oram/CurrentLeaf[11]} {oram/CurrentLeaf[12]} {oram/CurrentLeaf[13]} {oram/CurrentLeaf[14]} {oram/CurrentLeaf[15]} {oram/CurrentLeaf[16]} {oram/CurrentLeaf[17]} {oram/CurrentLeaf[18]} {oram/CurrentLeaf[19]}]]
create_debug_port u_ila_0 probe
set_property port_width 64 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {oram/LoadData[0]} {oram/LoadData[1]} {oram/LoadData[2]} {oram/LoadData[3]} {oram/LoadData[4]} {oram/LoadData[5]} {oram/LoadData[6]} {oram/LoadData[7]} {oram/LoadData[8]} {oram/LoadData[9]} {oram/LoadData[10]} {oram/LoadData[11]} {oram/LoadData[12]} {oram/LoadData[13]} {oram/LoadData[14]} {oram/LoadData[15]} {oram/LoadData[16]} {oram/LoadData[17]} {oram/LoadData[18]} {oram/LoadData[19]} {oram/LoadData[20]} {oram/LoadData[21]} {oram/LoadData[22]} {oram/LoadData[23]} {oram/LoadData[24]} {oram/LoadData[25]} {oram/LoadData[26]} {oram/LoadData[27]} {oram/LoadData[28]} {oram/LoadData[29]} {oram/LoadData[30]} {oram/LoadData[31]} {oram/LoadData[32]} {oram/LoadData[33]} {oram/LoadData[34]} {oram/LoadData[35]} {oram/LoadData[36]} {oram/LoadData[37]} {oram/LoadData[38]} {oram/LoadData[39]} {oram/LoadData[40]} {oram/LoadData[41]} {oram/LoadData[42]} {oram/LoadData[43]} {oram/LoadData[44]} {oram/LoadData[45]} {oram/LoadData[46]} {oram/LoadData[47]} {oram/LoadData[48]} {oram/LoadData[49]} {oram/LoadData[50]} {oram/LoadData[51]} {oram/LoadData[52]} {oram/LoadData[53]} {oram/LoadData[54]} {oram/LoadData[55]} {oram/LoadData[56]} {oram/LoadData[57]} {oram/LoadData[58]} {oram/LoadData[59]} {oram/LoadData[60]} {oram/LoadData[61]} {oram/LoadData[62]} {oram/LoadData[63]}]]
create_debug_port u_ila_0 probe
set_property port_width 3 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {DDR3SDRAM_Command[0]} {DDR3SDRAM_Command[1]} {DDR3SDRAM_Command[2]}]]
create_debug_port u_ila_0 probe
set_property port_width 28 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {DDR3SDRAM_Address[0]} {DDR3SDRAM_Address[1]} {DDR3SDRAM_Address[2]} {DDR3SDRAM_Address[3]} {DDR3SDRAM_Address[4]} {DDR3SDRAM_Address[5]} {DDR3SDRAM_Address[6]} {DDR3SDRAM_Address[7]} {DDR3SDRAM_Address[8]} {DDR3SDRAM_Address[9]} {DDR3SDRAM_Address[10]} {DDR3SDRAM_Address[11]} {DDR3SDRAM_Address[12]} {DDR3SDRAM_Address[13]} {DDR3SDRAM_Address[14]} {DDR3SDRAM_Address[15]} {DDR3SDRAM_Address[16]} {DDR3SDRAM_Address[17]} {DDR3SDRAM_Address[18]} {DDR3SDRAM_Address[19]} {DDR3SDRAM_Address[20]} {DDR3SDRAM_Address[21]} {DDR3SDRAM_Address[22]} {DDR3SDRAM_Address[23]} {DDR3SDRAM_Address[24]} {DDR3SDRAM_Address[25]} {DDR3SDRAM_Address[26]} {DDR3SDRAM_Address[27]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {DDR3SDRAM_WriteData[0]} {DDR3SDRAM_WriteData[1]} {DDR3SDRAM_WriteData[2]} {DDR3SDRAM_WriteData[3]} {DDR3SDRAM_WriteData[4]} {DDR3SDRAM_WriteData[5]} {DDR3SDRAM_WriteData[6]} {DDR3SDRAM_WriteData[7]} {DDR3SDRAM_WriteData[8]} {DDR3SDRAM_WriteData[9]} {DDR3SDRAM_WriteData[10]} {DDR3SDRAM_WriteData[11]} {DDR3SDRAM_WriteData[12]} {DDR3SDRAM_WriteData[13]} {DDR3SDRAM_WriteData[14]} {DDR3SDRAM_WriteData[15]} {DDR3SDRAM_WriteData[16]} {DDR3SDRAM_WriteData[17]} {DDR3SDRAM_WriteData[18]} {DDR3SDRAM_WriteData[19]} {DDR3SDRAM_WriteData[20]} {DDR3SDRAM_WriteData[21]} {DDR3SDRAM_WriteData[22]} {DDR3SDRAM_WriteData[23]} {DDR3SDRAM_WriteData[24]} {DDR3SDRAM_WriteData[25]} {DDR3SDRAM_WriteData[26]} {DDR3SDRAM_WriteData[27]} {DDR3SDRAM_WriteData[28]} {DDR3SDRAM_WriteData[29]} {DDR3SDRAM_WriteData[30]} {DDR3SDRAM_WriteData[31]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {DDR3SDRAM_ReadData[0]} {DDR3SDRAM_ReadData[1]} {DDR3SDRAM_ReadData[2]} {DDR3SDRAM_ReadData[3]} {DDR3SDRAM_ReadData[4]} {DDR3SDRAM_ReadData[5]} {DDR3SDRAM_ReadData[6]} {DDR3SDRAM_ReadData[7]} {DDR3SDRAM_ReadData[8]} {DDR3SDRAM_ReadData[9]} {DDR3SDRAM_ReadData[10]} {DDR3SDRAM_ReadData[11]} {DDR3SDRAM_ReadData[12]} {DDR3SDRAM_ReadData[13]} {DDR3SDRAM_ReadData[14]} {DDR3SDRAM_ReadData[15]} {DDR3SDRAM_ReadData[16]} {DDR3SDRAM_ReadData[17]} {DDR3SDRAM_ReadData[18]} {DDR3SDRAM_ReadData[19]} {DDR3SDRAM_ReadData[20]} {DDR3SDRAM_ReadData[21]} {DDR3SDRAM_ReadData[22]} {DDR3SDRAM_ReadData[23]} {DDR3SDRAM_ReadData[24]} {DDR3SDRAM_ReadData[25]} {DDR3SDRAM_ReadData[26]} {DDR3SDRAM_ReadData[27]} {DDR3SDRAM_ReadData[28]} {DDR3SDRAM_ReadData[29]} {DDR3SDRAM_ReadData[30]} {DDR3SDRAM_ReadData[31]}]]
create_debug_port u_ila_0 probe
set_property port_width 2 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {PathORAM_Command[0]} {PathORAM_Command[1]}]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {PathORAM_PAddr[0]} {PathORAM_PAddr[1]} {PathORAM_PAddr[2]} {PathORAM_PAddr[3]} {PathORAM_PAddr[4]} {PathORAM_PAddr[5]} {PathORAM_PAddr[6]} {PathORAM_PAddr[7]} {PathORAM_PAddr[8]} {PathORAM_PAddr[9]} {PathORAM_PAddr[10]} {PathORAM_PAddr[11]} {PathORAM_PAddr[12]} {PathORAM_PAddr[13]} {PathORAM_PAddr[14]} {PathORAM_PAddr[15]} {PathORAM_PAddr[16]} {PathORAM_PAddr[17]} {PathORAM_PAddr[18]} {PathORAM_PAddr[19]} {PathORAM_PAddr[20]} {PathORAM_PAddr[21]} {PathORAM_PAddr[22]} {PathORAM_PAddr[23]} {PathORAM_PAddr[24]} {PathORAM_PAddr[25]} {PathORAM_PAddr[26]} {PathORAM_PAddr[27]} {PathORAM_PAddr[28]} {PathORAM_PAddr[29]} {PathORAM_PAddr[30]} {PathORAM_PAddr[31]}]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list oram/back_end/AES_DRAMReadDataValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list oram/back_end/AES_DRAMWriteDataReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list oram/back_end/AES_DRAMWriteDataValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list back_end/AES_DRAMReadDataReady_orig]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list oram/back_end/BE_DRAMReadDataReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list oram/back_end/BE_DRAMReadDataValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list oram/back_end/BE_DRAMWriteDataReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list oram/back_end/BE_DRAMWriteDataValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list oram/BEnd_CmdReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list oram/BEnd_CmdValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list oram/back_end/bend_inner/stash_top/BlockNotFound]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list oram/back_end/bend_inner/stash_top/BlockNotFoundValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list oram/back_end/AES.REW_AES.aes/Core_ROCommandIn]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list oram/back_end/AES.REW_AES.aes/Core_ROCommandInReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list oram/back_end/AES.REW_AES.aes/Core_ROCommandInValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list oram/back_end/AES.REW_AES.aes/Core_ROCommandOut]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list oram/back_end/AES.REW_AES.aes/Core_RODataOutReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list oram/back_end/AES.REW_AES.aes/Core_RODataOutValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list oram/back_end/AES.REW_AES.aes/Core_RWCommandInReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list oram/back_end/AES.REW_AES.aes/Core_RWCommandInValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list oram/back_end/AES.REW_AES.aes/Core_RWDataOutValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list DDR3SDRAM_CommandReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe36]
connect_debug_port u_ila_0/probe36 [get_nets [list DDR3SDRAM_CommandValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe37]
connect_debug_port u_ila_0/probe37 [get_nets [list DDR3SDRAM_DataInReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe38]
connect_debug_port u_ila_0/probe38 [get_nets [list DDR3SDRAM_DataInValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe39]
connect_debug_port u_ila_0/probe39 [get_nets [list DDR3SDRAM_DataOutValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe40]
connect_debug_port u_ila_0/probe40 [get_nets [list oram/back_end/I1]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe41]
connect_debug_port u_ila_0/probe41 [get_nets [list oram/LoadReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe42]
connect_debug_port u_ila_0/probe42 [get_nets [list oram/LoadValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe43]
connect_debug_port u_ila_0/probe43 [get_nets [list n_1_oram]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe44]
connect_debug_port u_ila_0/probe44 [get_nets [list PathORAM_CommandReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe45]
connect_debug_port u_ila_0/probe45 [get_nets [list PathORAM_CommandValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe46]
connect_debug_port u_ila_0/probe46 [get_nets [list PathORAM_DataInReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe47]
connect_debug_port u_ila_0/probe47 [get_nets [list PathORAM_DataInValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe48]
connect_debug_port u_ila_0/probe48 [get_nets [list PathORAM_DataOutReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe49]
connect_debug_port u_ila_0/probe49 [get_nets [list PathORAM_DataOutValid]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe50]
connect_debug_port u_ila_0/probe50 [get_nets [list oram/back_end/bend_inner/StashAlmostFull]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe51]
connect_debug_port u_ila_0/probe51 [get_nets [list oram/back_end/bend_inner/stash_top/StashOverflow]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe52]
connect_debug_port u_ila_0/probe52 [get_nets [list oram/StoreReady]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe53]
connect_debug_port u_ila_0/probe53 [get_nets [list oram/StoreValid]]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
