create_clock -name fpga_clk_24 -period 41.667 [get_ports {CLK_24}]
derive_pll_clocks
derive_clock_uncertainty