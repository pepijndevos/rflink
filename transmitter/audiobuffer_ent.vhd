library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity audiobuffer is
  generic(word_length: integer:= 8)
	port(
    clk_in: in std_logic;
	data_in: in std_logic_vector(word_length-1 downto 0);
	data_out: out std_logic_vector(word_length-1 downto 0);
	);
end audiobuffer;
