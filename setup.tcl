project_new nes -overwrite

set_global_assignment -name PROJECT_OUTPUT_DIRECTORY compile

set_global_assignment -name FAMILY "Cyclone II"
set_global_assignment -name DEVICE EP2C20F484C7
set_global_assignment -name TOP_LEVEL_ENTITY nes

set_global_assignment -name VERILOG_FILE src/nes.v

set_location_assignment PIN_D12 -to CLK_27

project_close
