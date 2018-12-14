-------------------------------------------------------------------------------
-- File: system_on_chip.vhd
-- Description: This architecture generates a ramp with a resolution of 
--				word_length bits.
-- Author: Remi Jonkman
-- Creation date: 3-12-2018
-------------------------------------------------------------------------------

-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture behavior of ramp_generator is
begin
	counting: process(clk, reset_n)
		variable counter : integer := 0;
	begin
		if (reset_n = '0') then
			dout <= (others => '0');	-- set output to 0
			counter := 0;							-- reset counter
		elsif (rising_edge(clk) and enable = '1') then
			-- Push counter to output
			dout <= std_logic_vector(to_unsigned(counter, dout'length));
			
			counter := counter + 1;
			
			-- Reset counter when final value is reached
			if (counter > (2**word_length) - 1) then
				counter := 0;
			end if;
		end if;
	end process counting;
end architecture behavior;