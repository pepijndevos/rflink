-------------------------------------------------------------------------------
-- File: tb_encoder_4B5B.vhd
-- Description: Test bench for 8B10B encoding
-- Author: Jelle Bakker
-------------------------------------------------------------------------------

-- library and package declarations
library ieee, std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tvc_siso_gen is
  generic (word_length_in_4B5B_encoder: natural := 8;
	   word_length_out_4B5B_encoder: natural := 10;
           in_file_name: string := "siso_gen.in";
           out_file_name: string := "siso_gen.out";
           half_clock_period: time := 100 ns);
  port (data_in_4B5B_encoder: out std_logic_vector(word_length_in_4B5B_encoder-1 downto 0);
        clk_4B5B_encoder: out std_logic;
        reset: out std_logic;
        data_out_4B5B_encoder: in std_logic_vector(word_length_out_4B5B_encoder-1 downto 0));
end tvc_siso_gen;
