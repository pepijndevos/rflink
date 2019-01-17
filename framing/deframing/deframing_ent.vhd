-------------------------------------------------------------------------------
-- File: deframing_arch.vhd
-- Description: Detects a preamble byte, to synchronise the bit stream for decoding
-- Author: Jelle Bakker
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity deframing is
  generic (
		word_length_deframing: integer := 10;
		preamble_receiver: integer := 785;
	  deframing_length: integer := 32550
	);
  port (
		data_in_deframing: in std_logic;
		clk_deframing_in: in std_logic;
		reset: in std_logic;
    data_out_deframing: out std_logic;
    clk_deframing_out_serial: out std_logic;
    clk_deframing_out_parallel: out std_logic;
		preamble_found : out std_logic
	);
end deframing;
