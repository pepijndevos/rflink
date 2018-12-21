set_global_assignment -entity "clk_200_MHz" -library "lib_clk_200_MHz" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clk_200_MHz" -library "lib_clk_200_MHz" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "clk_200_MHz" -library "lib_clk_200_MHz" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clk_200_MHz" -name SPD_FILE [file join $::quartus(sip_path) "clk_200_MHz.spd"]

set_global_assignment -library "lib_clk_200_MHz" -name MISC_FILE [file join $::quartus(sip_path) "clk_200_MHz_sim/clk_200_MHz.vho"]
