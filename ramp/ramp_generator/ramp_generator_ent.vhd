-------------------------------------------------------------------------------
-- File: system_on_chip.vhd
-- Description: 
-- Author: Remi Jonkman
-- Creation date: 3-12-2018
--
-------------------------------------------------------------------------------

-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;

entity ramp_generator is
	generic(
		word_length : natural := 10		-- 10 bits
	);
	port (
		clk : in std_logic;
		reset_n : in std_logic;
		enable : in std_logic;
		dout : out std_logic_vector(word_length-1 downto 0)
	);
end ramp_generator;