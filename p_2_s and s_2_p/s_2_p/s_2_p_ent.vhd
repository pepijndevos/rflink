

-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;

entity s_2_p is
  generic (word_length_buffer: integer := 10);
  port (data_in_buffer: in std_logic;
        clk_buffer_parallel: in std_logic;
        clk_buffer_serial: in std_logic;
        reset: in std_logic;
		  delay: in std_logic := '1';
        data_out_buffer: out std_logic_vector(word_length_buffer-1 downto 0);
		  delay_counter_out : out std_logic_vector(3 downto 0));
end s_2_p;
