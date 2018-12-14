-------------------------------------------------------------------------------
-- File: 
-- Description: 
-- Author: SoC2017, University of Twente
-- Creation date: 
--
-------------------------------------------------------------------------------

-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;

entity DAC_interface is
	generic(
		dac_width : natural := 10
	);
	port(
		dac_clk						: out std_logic;	-- DAC clock
		ready_out 	     	: out std_logic;  -- Enable DAC output
		clk_40_MHz				: in  std_logic;	-- 40 MHz clock
		reset_n						: in  std_logic;	-- Active low reset
		d_out							: out std_logic_vector (dac_width-1 downto 0); 	-- main outputs
		d_in_i, d_in_q		: in  std_logic_vector (dac_width-1 downto 0) 	-- main input
	);
end DAC_interface;

