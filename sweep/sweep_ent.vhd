-------------------------------------------------------------------------------
-- File: sweep_ent.vhd
-- Description: 
-- Author: Remi Jonkman
-- Creation date: 3-12-2018
--
-------------------------------------------------------------------------------

-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;

entity sweep is
	generic(
		dac_width      	: natural := 10;
		data_width      : natural := 8
	);
	port (
		clk_50_MHz 			: in std_logic;
		--clk_160_MHz 		: in std_logic;
		reset_n					: in std_logic;
		enable					: in std_logic;
		next_btn				: in std_logic; -- pin AA14
		sweep_btn				: in std_logic;	-- pin AA15
		sin_out 				: out std_logic_vector(dac_width-1 downto 0);
		pll_locked 			: out std_logic;
		dac_clk					: out std_logic;
		ready_to_gpio		: out std_logic
	);	
end sweep;
