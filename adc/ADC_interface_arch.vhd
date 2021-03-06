-------------------------------------------------------------------------------
-- File: 
-- Description: 
-- Author: SoC2017, University of Twente
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Modified by: Remi Jonkman
-- Date: 14-12-2018
-- Description: Using 40 MHz PLL synthesized clock, hence enables not necessary anymore
-------------------------------------------------------------------------------

-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture adc_arch of ADC_interface is
begin
    seq : process(clk_20_MHz, reset_n)
    begin
		if (reset_n = '0') then
			d_out <= (data_width-1 downto 0 => '0');
				
			-- Indicate there is no sample ready
			ready_out <= '0';
		elsif (rising_edge(clk_20_MHz) and enable = '1') then
			-- convert offset binary to 2's complement
			d_out <= signed((not d_in(data_width-1) & d_in(data_width-2 downto 0)));
			
			-- Indicate a sample is ready
			ready_out <= '1';
		end if;
	end process seq;
end adc_arch;
