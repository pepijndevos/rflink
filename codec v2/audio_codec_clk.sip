set_global_assignment -entity "audio_codec_clk" -library "lib_audio_codec_clk" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "audio_codec_clk" -library "lib_audio_codec_clk" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "audio_codec_clk" -library "lib_audio_codec_clk" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_audio_codec_clk" -name SPD_FILE [file join $::quartus(sip_path) "audio_codec_clk.spd"]

set_global_assignment -library "lib_audio_codec_clk" -name MISC_FILE [file join $::quartus(sip_path) "audio_codec_clk_sim/audio_codec_clk.vho"]
