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

entity dac_test_interface is
    generic(
			dac_width      	: natural := 10;
			data_width      : natural := 8
    );
		port (
		--	clk_1_25_MHz : in std_logic;			-- 1.25 MHz clock signal
		--	clk_5_MHz : in std_logic;					-- 5 MHz clock signal
		--	clk_20_MHz : in std_logic;				-- 20 MHz clock signal
		--	clk_40_MHz : in std_logic;				-- 40 MHz clock signal
			clk_50_MHz : in std_logic;					-- 50 MHz clock signal
			reset_n : in std_logic;							-- Active low reset
			enable : in std_logic;							-- Enable module
			dac_clk : out std_logic;						-- DAC clock
			ready_to_gpio : out std_logic;
			d_to_gpio : out std_logic_vector(dac_width-1 downto 0);
			pll_locked : out std_logic					-- PLL locked
		);
end dac_test_interface;
