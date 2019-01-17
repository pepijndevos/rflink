-------------------------------------------------------------------------------
-- File: tvc_framing_ent.vhd
-- Description: Test bench for framing
-- Author: Jelle Bakker
-------------------------------------------------------------------------------

-- library and package declarations
library ieee, std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tvc_framing is
  generic (word_length_framing: natural := 10;
	   preamble_transmitter: natural := 785;
	   framing_length: natural := 20;
           in_file_name: string := "siso_gen.in";
           out_file_name: string := "siso_gen.out";
           half_clock_period: time := 100 ns);
  port (data_in_framing: out std_logic_vector(word_length_framing-1 downto 0);
        clk_framing: out std_logic;
        reset: out std_logic;
        data_out_framing: in std_logic_vector(word_length_framing-1 downto 0));
end tvc_framing;
