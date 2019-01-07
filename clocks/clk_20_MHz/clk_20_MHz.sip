set_global_assignment -entity "clk_20_MHz" -library "lib_clk_20_MHz" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clk_20_MHz" -library "lib_clk_20_MHz" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "clk_20_MHz" -library "lib_clk_20_MHz" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clk_20_MHz" -name SPD_FILE [file join $::quartus(sip_path) "clk_20_MHz.spd"]

set_global_assignment -library "lib_clk_20_MHz" -name MISC_FILE [file join $::quartus(sip_path) "clk_20_MHz_sim/clk_20_MHz.vho"]
