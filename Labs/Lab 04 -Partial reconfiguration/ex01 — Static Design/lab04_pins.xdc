## Lab 04 - Nexys A7-100T (Artix-7 XC7A100T)
## Top-level ports from top.vhd

set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports CLK100MHZ]

set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports CPU_RESETN]

set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports UART_TXD_IN]
set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports UART_RXD_OUT]

set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {LED[0]}]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {LED[1]}]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {LED[2]}]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {LED[3]}]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {LED[4]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {LED[5]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {LED[6]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {LED[7]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {LED[8]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {LED[9]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {LED[10]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {LED[11]}]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {LED[12]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {LED[13]}]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {LED[14]}]
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports {LED[15]}]

create_pblock pblock_u_rm
add_cells_to_pblock [get_pblocks pblock_u_rm] [get_cells -quiet [list u_rm]]
resize_pblock [get_pblocks pblock_u_rm] -add {SLICE_X10Y170:SLICE_X39Y189 \
                                              DSP48_X0Y68:DSP48_X0Y75 \
}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_u_rm]
set_property SNAPPING_MODE ON [get_pblocks pblock_u_rm]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]


