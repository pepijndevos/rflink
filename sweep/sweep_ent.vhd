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
		--clk_50_MHz 			: in std_logic;
		--clk_160_MHz 		: in std_logic;
		--reset_n					: in std_logic;
		--enable					: in std_logic;
		--next_btn				: in std_logic; -- pin AA14
		--sweep_btn				: in std_logic;	-- pin AA15
		--sin_out 				: out std_logic_vector(dac_width-1 downto 0);
		--pll_locked 			: out std_logic;
		--dac_clk					: out std_logic;
		--ready_to_gpio		: out std_logic
		CLOCK_50     			: in std_logic; 											-- 50 MHz Clock
		KEY 			  			: in std_logic_vector(3 downto 0); 		-- reset key
		GPIO_0 		  			: out std_logic_vector(53 downto 0);	-- gpio pins
		GPIO_1 		  			: in std_logic_vector(53 downto 0);	-- gpio pins
		LEDR 							: out std_logic_vector(9 downto 0)  	-- leds
	);	
end sweep;
