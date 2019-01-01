-------------------------------------------------------------------------------
-- File: 
-- Description: 
-- Author: SoC2017, University of Twente
-- Creation date: 
-------------------------------------------------------------------------------
-- Modified by: Remi Jonkman
-- Date: 14-12-2018
-- Description: Using 40 MHz PLL synthesized clock, hence enables not necessary anymore
-------------------------------------------------------------------------------

-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADC_interface is
    generic(
			data_width 		: natural := 10
    );
    port(
			enable				: in 	std_logic;
			ready_out			: out std_logic;
			clk_20_MHz		: in  std_logic;	-- Clock input: maximal (1/1) frequency
			reset_n				: in  std_logic;	-- High active reset
			
			-- main output
			d_out					: out signed(data_width-1 downto 0);
			--d_out_q			: out signed(data_width-1 downto 0);
			
			-- main input
			--d_in_i			: in  unsigned(data_width-1 downto 0);
			d_in					: in  unsigned(data_width-1 downto 0)
    );
end ADC_interface;
