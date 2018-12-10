vsim work.conf_tb_siso_gen_buffer
add wave -position insertpoint sim:/tb_siso_gen_top/tg/duv/*
add wave -position insertpoint sim:/tb_siso_gen_top/tg/duv2/*
run -all