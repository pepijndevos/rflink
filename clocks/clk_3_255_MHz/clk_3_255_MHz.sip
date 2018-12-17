set_global_assignment -entity "clk_3_255_MHz" -library "lib_clk_3_255_MHz" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clk_3_255_MHz" -library "lib_clk_3_255_MHz" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "clk_3_255_MHz" -library "lib_clk_3_255_MHz" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clk_3_255_MHz" -name SPD_FILE [file join $::quartus(sip_path) "clk_3_255_MHz.spd"]

set_global_assignment -library "lib_clk_3_255_MHz" -name MISC_FILE [file join $::quartus(sip_path) "clk_3_255_MHz_sim/clk_3_255_MHz.vho"]
