set_global_assignment -entity "clock_gen_3_2_MHz" -library "lib_clock_gen_3_2_MHz" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clock_gen_3_2_MHz" -library "lib_clock_gen_3_2_MHz" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "clock_gen_3_2_MHz" -library "lib_clock_gen_3_2_MHz" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clock_gen_3_2_MHz" -name SPD_FILE [file join $::quartus(sip_path) "clock_gen_3_2_MHz.spd"]

set_global_assignment -library "lib_clock_gen_3_2_MHz" -name MISC_FILE [file join $::quartus(sip_path) "clock_gen_3_2_MHz_sim/clock_gen_3_2_MHz.vho"]
