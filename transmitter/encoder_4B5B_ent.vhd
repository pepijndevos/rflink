-------------------------------------------------------------------------------
-- File: 4B5B_encoder.vhd
-- Description: 
-- Author: 
-- Creation date: 
-------------------------------------------------------------------------------
-- 
--
-------------------------------------------------------------------------------


-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;

entity encoder_4B5B is
  generic (word_length_in_4B5B_encoder: integer := 8;
	   word_length_out_4B5B_encoder: integer := 10);
  port (data_in_4B5B_encoder: in std_logic_vector(word_length_in_4B5B_encoder-1 downto 0);
        clk_4B5B_encoder: in std_logic;
        reset: in std_logic;
        data_out_4B5B_encoder: out std_logic_vector(word_length_out_4B5B_encoder-1 downto 0));
end siso_gen_4B5B_encoder;
