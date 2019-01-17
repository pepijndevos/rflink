-------------------------------------------------------------------------------
-- File: decoder_4B5B_ent.vhd
-- Description: 8B10B lookup table, decoding
-- Author: Jelle Bakker
-------------------------------------------------------------------------------


-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;

entity decoder_4B5B is
  generic (word_length_in_4B5B_decoder: integer := 10;
	   word_length_out_4B5B_decoder: integer := 8);
  port (data_in_4B5B_decoder: in std_logic_vector(word_length_in_4B5B_decoder-1 downto 0);
        clk_4B5B_decoder: in std_logic;
        reset: in std_logic;
        data_out_4B5B_decoder: out std_logic_vector(word_length_out_4B5B_decoder-1 downto 0));
end decoder_4B5B;
