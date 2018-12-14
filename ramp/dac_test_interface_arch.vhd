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

--Clock architecture
architecture behavior of dac_test_interface is
	signal clk_1_25_MHz : std_logic;
	signal clk_5_MHz : std_logic;
	signal clk_20_MHz : std_logic;
	signal clk_40_MHz : std_logic;
	
	-- Ramps connect signal
	signal ramp_wave : std_logic_vector(dac_width - 1 downto 0);
	
	component clock_pll
		port (
			refclk : in std_logic;
			rst : in std_logic;
			outclk_0 : out std_logic;
			outclk_1 : out std_logic;
			outclk_2 : out std_logic;
			outclk_3 : out std_logic;
			locked : out std_logic
		);
	end component;
begin
	fgen: entity work.ramp_generator(behavior)
		generic map (
			dac_width
		)
		port map (
			clk => clk_5_MHz,
			reset_n => reset_n,
			enable => enable,
			dout => ramp_wave
		);
		
	-- Instantiate the DAC Multiplexer
	dac: entity work.dac_interface(dac_mux)
		generic map (
			dac_width											-- word size 10 bits
		)
		port map (
			dac_clk => dac_clk,						-- DAC clk
			ready_out => ready_to_gpio,		-- enable hardware DAC
			clk_40_MHz => clk_40_MHz,			-- 50 MHz standard clock
			reset_n => reset_n,						-- Active low reset
			d_out => d_to_gpio,						-- Output data (multiplexed)
			d_in_i => ramp_wave, 					-- In phase input
			d_in_q => ramp_wave						-- Quadrature input
		);
	
	-- Instantiate a PLL clock component
	clk_pll: clock_pll
		port map (
			refclk => clk_50_MHz, 				-- 50 MHz reference clock
			rst => not reset_n, 					-- Active high reset
			outclk_0 => clk_1_25_MHz,			-- 2.5 MHz clock
			outclk_1 => clk_5_MHz,
			outclk_2 => clk_20_MHz, 			-- 20 MHz clock
			outclk_3 => clk_40_MHz, 			-- 40 MHz clock
			locked => pll_locked 					-- Returns if the PLL is locked on all frequencies or not
		);
end architecture behavior;
