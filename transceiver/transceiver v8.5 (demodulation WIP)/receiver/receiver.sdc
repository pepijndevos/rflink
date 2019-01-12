# http://www.altera.com/support/examples/timequest/exm-tq-clock-mux.html
# http://quartushelp.altera.com/12.1/mergedProjects/tafs/tafs/tcl_pkg_sdc_ver_1.5_cmd_create_clock.htm
# http://m.eet.com/media/1195900/Ch6%20cropped.pdf
# http://www.edaboard.com/thread237090.html
# Create a clock on each port
create_clock -name clk -period 50MHz [get_ports CLOCK_50]
create_clock -name clk_320_kHz -period 320kHz [get_registers clock_recovery:clk_recovery|out_clk] 
create_generated_clock -divide_by 10 -source [get_registers clock_recovery:clk_recovery|out_clk] -name clk_32_kHz [get_registers deframing:deframing_inst|clk_deframing_out_parallel_temp_buffer2]
create_generated_clock -divide_by 512 -source [get_ports CLOCK_50] -name clk_i2c [get_registers audio_interface:audio_inst|i2c_counter[9]]

# Set the clocks as exclusive clocks
#set_clock_groups -exclusive -group {clk} -group {clk_320_kHz}
# Set a false-path between two unrelated clocks
# See also set_clock_groups
#set_false_path -from [get_clocks clk] -to [get_clocks clk_320_kHz]
derive_pll_clocks
derive_clock_uncertainty

set_input_delay -clock clk -max 0 [get_ports GPIO_0[*]]
set_input_delay -clock clk -min 0 [get_ports GPIO_0[*]]
set_input_delay -clock clk -max 0 [get_ports SW[*]]
set_input_delay -clock clk -min 0 [get_ports SW[*]]
set_input_delay -clock clk -max 0 [get_ports KEY[*]]
set_input_delay -clock clk -min 0 [get_ports KEY[*]]
set_input_delay -clock clk -max 0 [get_ports AUD_BCLK]
set_input_delay -clock clk -min 0 [get_ports AUD_BCLK]
set_input_delay -clock clk -max 0 [get_ports AUD_DACLRCK]
set_input_delay -clock clk -min 0 [get_ports AUD_DACLRCK]
