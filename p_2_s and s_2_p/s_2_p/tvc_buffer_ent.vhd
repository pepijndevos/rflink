library ieee, std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tvc_buffer is
  generic (word_length_deframing: natural := 10;
	   word_length_buffer: natural := 10;
	   preamble_receiver: natural := 785;
	   deframing_length: natural := 20;
           in_file_name: string := "siso_gen.in";
           out_file_name: string := "siso_gen.out";
           half_clock_period: time := 100 ns);
  port (data_in_deframing: out std_logic;
        clk_deframing_in: out std_logic;
        reset: out std_logic;
        data_out_buffer: in std_logic_vector(word_length_buffer-1 downto 0));
end tvc_buffer;
