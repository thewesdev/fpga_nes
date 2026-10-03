project_new nes -overwrite

set_global_assignment -name PROJECT_OUTPUT_DIRECTORY compile

set_global_assignment -name FAMILY "Cyclone II"
set_global_assignment -name DEVICE EP2C20F484C7
set_global_assignment -name TOP_LEVEL_ENTITY nes
set_global_assignment -name SDC_FILE src/nes.sdc

set_global_assignment -name VERILOG_FILE src/nes.v
set_global_assignment -name VERILOG_FILE src/pll.v
set_global_assignment -name VERILOG_FILE src/mb8416a15sk.v
set_global_assignment -name VERILOG_FILE src/rp2a03.v
set_global_assignment -name VERILOG_FILE src/sn74ls139n.v

set_location_assignment PIN_R20 -to LED_RST
set_location_assignment PIN_U22 -to LED_RUNNING
set_location_assignment PIN_U21 -to LED_MASTER_CLK
set_location_assignment PIN_V22 -to LED_CPU_CLK

# set_location_assignment PIN_D12 -to CLK_27
set_location_assignment PIN_A12 -to CLK_24

project_close