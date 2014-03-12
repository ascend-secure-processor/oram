
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
set_property BOARD_PIN rs232_uart_rxd [get_ports uart_rxd]

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

################################################################################
# ChipScope cores
################################################################################

