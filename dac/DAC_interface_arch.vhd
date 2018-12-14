-------------------------------------------------------------------------------
-- File: 
-- Description: 
-- Author: Remi Jonkman, University of Twente
-- Creation date: 
--
-------------------------------------------------------------------------------

-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;

architecture dac_mux of DAC_interface is
    type muxstate is (s_i, s_q);
begin
	seq : process(clk_40_MHz, reset_n)
		variable state : muxstate := s_i;
	begin
		if (reset_n = '0') then
			d_out <= (others => '0');
			state := s_i;
			ready_out <= '0';
		elsif rising_edge(clk_40_MHz) then
			case state is
				when s_i =>
					d_out <= (not d_in_i(dac_width-1) & d_in_i(dac_width-2 downto 0)); 				-- convert 2's complement to offset binary
					state := s_q;
				when s_q =>
					d_out <= (not d_in_q(dac_width-1) & d_in_q(dac_width-2 downto 0)); 				-- convert 2's complement to offset binary
					state := s_i;
			end case;
			
			-- Set ready high
			ready_out <= '1';
		end if;
	end process seq;
	
	dac_clk <= clk_40_MHz;
end dac_mux;


