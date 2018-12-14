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

entity ADC_interface is
    generic(
        data_width : natural := 10
    );
    port(
				enable						: in 	std_logic;
	    	ready_out					: out std_logic;
        -- Clock input: maximal (1/1) frequency
        clk_20_MHz				: in  std_logic;
        -- High active reset
        reset_n						: in  std_logic;
        -- main output
        d_out_i						: out std_logic_vector(data_width-1 downto 0);
        d_out_q						: out std_logic_vector(data_width-1 downto 0);
        -- main input
        d_in_i						: in  std_logic_vector(data_width-1 downto 0);
        d_in_q						: in  std_logic_vector(data_width-1 downto 0)
    );
end ADC_interface;
