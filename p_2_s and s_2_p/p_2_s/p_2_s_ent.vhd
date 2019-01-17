-------------------------------------------------------------------------------
-- File: p_2_s_ent.vhd
-- Description: Parallel to serial conversion
-- Author: Big Boss Bakker
-------------------------------------------------------------------------------


-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;

entity p_2_s is
  generic (word_length_unbuffer: integer := 10);
  port (data_in_unbuffer: in std_logic_vector(word_length_unbuffer-1 downto 0);
        clk_unbuffer_parallel: in std_logic;
        clk_unbuffer_serial: in std_logic;
        reset: in std_logic;
        data_out_unbuffer: out std_logic);
end p_2_s;
