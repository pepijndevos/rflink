-------------------------------------------------------------------------------
-- File: framing_ent.vhd
-- Description: Replace evey nth byte with a preamble byte for synchronization
-- Author: Jelle Bakker
-------------------------------------------------------------------------------


-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;

entity framing is
  generic (word_length_framing: integer := 10;
	   preamble_transmitter: integer := 785;
	   framing_length: integer := 32550);
  port (data_in_framing: in std_logic_vector(word_length_framing-1 downto 0);
        clk_framing: in std_logic;
        reset: in std_logic;
		  frame_ins: out std_logic;
        data_out_framing: out std_logic_vector(word_length_framing-1 downto 0));
end framing;
