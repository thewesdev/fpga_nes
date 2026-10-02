create_clock -name fpga_clk_27 -period 37.037 [get_ports {CLK_27}]
derive_pll_clocks
derive_clock_uncertainty