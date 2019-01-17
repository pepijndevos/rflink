-------------------------------------------------------------------------------
-- File: conf_tb_decoder_4B5B.vhd
-- Description: 8B10B test bench
-- Author: Jelle Bakker
-------------------------------------------------------------------------------

-- library and package declarations
library ieee, std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tvc_siso_gen is
  generic (word_length_in_4B5B_decoder: natural := 10;
	   word_length_out_4B5B_decoder: natural := 8;
           in_file_name: string := "siso_gen.in";
           out_file_name: string := "siso_gen.out";
           half_clock_period: time := 100 ns);
  port (data_in_4B5B_decoder: out std_logic_vector(word_length_in_4B5B_decoder-1 downto 0);
        clk_4B5B_decoder: out std_logic;
        reset: out std_logic;
        data_out_4B5B_decoder: in std_logic_vector(word_length_out_4B5B_decoder-1 downto 0));
end tvc_siso_gen;
