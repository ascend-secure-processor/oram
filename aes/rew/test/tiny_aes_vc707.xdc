
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