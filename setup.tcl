project_new nes -overwrite

set_global_assignment -name PROJECT_OUTPUT_DIRECTORY compile

set_global_assignment -name FAMILY "Cyclone II"
set_global_assignment -name DEVICE EP2C20F484C7
set_global_assignment -name TOP_LEVEL_ENTITY nes
set_global_assignment -name SDC_FILE src/nes.sdc

set_global_assignment -name SEARCH_PATH include

set_global_assignment -name VERILOG_FILE src/nes.v
set_global_assignment -name VERILOG_FILE src/pll.v
set_global_assignment -name VERILOG_FILE src/clock_stabilizer.v
#set_global_assignment -name VERILOG_FILE src/sram.v
#set_global_assignment -name VERILOG_FILE src/dram.v
set_global_assignment -name VERILOG_FILE src/cpu.v
set_global_assignment -name VERILOG_FILE src/decoder.v
set_global_assignment -name VERILOG_FILE src/chips/nes_decoder.v
# set_global_assignment -name VERILOG_FILE src/enable_pulse.v

set_location_assignment PIN_R20 -to LED_RST
set_location_assignment PIN_U22 -to LED_RUNNING
set_location_assignment PIN_U21 -to LED_MASTER_CLK

set_location_assignment PIN_A12 -to CLK_24

set_location_assignment PIN_AA10 -to SRAM_WE_N
set_location_assignment PIN_T8 -to SRAM_OE_N
set_location_assignment PIN_AB5 -to SRAM_CE_N
set_location_assignment PIN_Y7 -to SRAM_UB_N
set_location_assignment PIN_W7 -to SRAM_LB_N

set sram_addr_pins {
	PIN_AA3 PIN_AB3 PIN_AA4 PIN_AB4 PIN_AA5 PIN_AB10 PIN_AA11 PIN_AB11 PIN_V11
	PIN_W11 PIN_R11 PIN_T11 PIN_Y10 PIN_U10 PIN_R10 PIN_T7 PIN_Y6 PIN_Y5
}

set sram_data_pins {
	PIN_AA6 PIN_AB6 PIN_AA7 PIN_AB7 PIN_AA8 PIN_AB8 PIN_AA9 PIN_AB9
	PIN_Y9 PIN_W9 PIN_V9 PIN_U9 PIN_R9 PIN_W8 PIN_V8 PIN_U8
}

for {set i 0} {$i < 18} {incr i} {
	set_location_assignment [lindex $sram_addr_pins $i] -to SRAM_ADDR[$i]
}

for {set i 0} {$i < 16} {incr i} {
	set_location_assignment [lindex $sram_data_pins $i] -to SRAM_DQ[$i]
}

set_location_assignment PIN_U3 -to DRAM_BA_0
set_location_assignment PIN_V4 -to DRAM_BA_1
set_location_assignment PIN_R7 -to DRAM_LDQM
set_location_assignment PIN_M5 -to DRAM_UDQM
set_location_assignment PIN_T5 -to DRAM_RAS_N
set_location_assignment PIN_T3 -to DRAM_CAS_N
set_location_assignment PIN_N3 -to DRAM_CKE
set_location_assignment PIN_U4 -to DRAM_CLK
set_location_assignment PIN_R8 -to DRAM_WE_N
set_location_assignment PIN_T6 -to DRAM_CS_N

set dram_addr_pins {
	PIN_W4 PIN_W5 PIN_Y3 PIN_Y4 PIN_R6 PIN_R5
	PIN_P6 PIN_P5 PIN_P3 PIN_N4 PIN_W3 PIN_N6
}

set dram_data_pins {
	PIN_U1 PIN_U2 PIN_V1 PIN_V2 PIN_W1 PIN_W2 PIN_Y1 PIN_Y2
	PIN_N1 PIN_N2 PIN_P1 PIN_P2 PIN_R1 PIN_R2 PIN_T1 PIN_T2
}

for {set i 0} {$i < 12} {incr i} {
	set_location_assignment [lindex $dram_addr_pins $i] -to DRAM_ADDR[$i]
}

for {set i 0} {$i < 16} {incr i} {
	set_location_assignment [lindex $dram_data_pins $i] -to DRAM_DQ[$i]
}

project_close