-------------------------------------------------------------------------------
-- File: tvc_deframing_ent.vhd
-- Description: Test bench for deframing
-- Author: Jelle Bakker
-------------------------------------------------------------------------------

-- library and package declarations
library ieee, std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tvc_deframing is
  generic (word_length_deframing: natural := 10;
	   preamble_receiver: natural := 785;
	   deframing_length: natural := 20;
           in_file_name: string := "siso_gen.in";
           out_file_name: string := "siso_gen.out";
           half_clock_period: time := 100 ns);
  port (data_in_deframing: out std_logic;
        clk_deframing_in: out std_logic;
        reset: out std_logic;
        data_out_deframing: in std_logic);
end tvc_deframing;
