-------------------------------------------------------------------------------
-- File: sweep_arch.vhd
-- Description: 
-- Author: Remi Jonkman
-- Creation date: 3-12-2018
--
-------------------------------------------------------------------------------

-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture structure of sweep is
	signal clk_160_MHz : std_logic;
	signal clk_40_MHz : std_logic;
	signal phase_inc : std_logic_vector(31 downto 0) := (others => '0');
	signal cos_out : std_logic_vector(11 downto 0);
	signal squ_out : std_logic_vector(11 downto 0);
	signal saw_out : std_logic_vector(11 downto 0);
	signal dac_input : std_logic_vector(11 downto 0);

	signal freeze : std_logic;
	signal next_frequency : std_logic;
	
	type rom_type is array (0 to 5) of std_logic_vector (31 downto 0);
	constant frequency_array : rom_type := 
		(
			X"01000000",
			X"01800000",
			X"02000000",
			X"02800000",
			X"03000000",
			X"04000000"
		);

	component waveform_gen
		port (
			-- system signals
			clk         : in  std_logic;
			reset       : in  std_logic;
			
			-- clock-enable
			en          : in  std_logic;
			
			-- NCO frequency control
			phase_inc   : in  std_logic_vector(31 downto 0);
			
			-- Output waveforms
			sin_out     : out std_logic_vector(11 downto 0);
			cos_out     : out std_logic_vector(11 downto 0);
			squ_out     : out std_logic_vector(11 downto 0);
			saw_out     : out std_logic_vector(11 downto 0) 
		);
	end component;

	component dac_interface
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
	end component;

	component clock_pll
		port (
			refclk 			: in 	std_logic;
			rst 				: in 	std_logic;
			outclk_0 		: out std_logic;	-- 160 MHz
			outclk_1		: out std_logic;	-- 40 MHz
			locked 			: out std_logic
		);
	end component;

begin

	-- Instantiate a PLL clock component
	clk_pll: clock_pll
		port map (
			refclk => clk_50_MHz, 				-- 50 MHz reference clock
			rst => not reset_n, 					-- Active high reset
			outclk_0 => clk_160_MHz,			-- 160MHz clock
			outclk_1 => clk_40_MHz,
			locked => pll_locked 					-- Returns if the PLL is locked on all frequencies or not
		);

	-- Instantiate NCO
	nco: waveform_gen
	port map (
		-- system signals
		clk         => clk_160_MHz,
		reset       => reset_n,
		
		-- clock-enable
		en          => enable,
		
		-- NCO frequency control
		phase_inc   => phase_inc,
		
		-- Output waveforms
		sin_out     => dac_input,
		cos_out     => cos_out,
		squ_out     => squ_out,
		saw_out     => saw_out 
	);

	-- Instantiate the DAC Multiplexer
	dac: dac_interface
		generic map (
			dac_width																					-- word size 10 bits
		)
		port map (
			dac_clk => dac_clk,																-- DAC clk
			ready_out => ready_to_gpio,												-- enable hardware DAC
			clk_40_MHz => clk_40_MHz,													-- 50 MHz standard clock
			reset_n => reset_n,																-- Active low reset
			d_out => sin_out,																	-- Output data (multiplexed)
			d_in_i => dac_input(dac_width + 1 downto 2), 			-- In phase input
			d_in_q => dac_input(dac_width + 1 downto 2)				-- Quadrature input
		);
	
	control: process(clk_50_MHz, reset_n)
		variable next_pressed : std_logic := '0';
	begin
		if (reset_n = '0') then
			next_pressed := '0';
		elsif (rising_edge(clk_50_MHz)) then
			-- Next frequency
			if (next_btn = '1' and next_pressed = '0') then
				next_pressed := '1';
				next_frequency <= '1';
			elsif (next_btn = '1' and next_pressed = '1') then
				next_pressed := '1';
				next_frequency <= '0';
			elsif (next_btn = '0') then
				next_pressed := '0';
				next_frequency <= '0';
			end if;
		end if;
	end process control;
	
	sweep_freeze: process(reset_n, sweep_btn)
	begin
		if (reset_n = '0') then
			freeze <= '0';
		elsif (rising_edge(sweep_btn)) then
			freeze <= not freeze;
		end if;
	end process sweep_freeze;
	
	-- Instantiate RAMP component
	ramp: process(clk_50_MHz, reset_n)
		constant clock_frequency : integer := 50e6; -- 50 MHz
		variable counter : integer := 0;
		variable frequency_index : integer := 0;
	begin
		if (reset_n = '0') then
			counter := 0;
			frequency_index := 0;
		elsif (rising_edge(clk_50_MHz) and reset_n = '1') then
			if (freeze = '1') then
				if (next_frequency = '1') then
					frequency_index := frequency_index + 1;
				end if;
			else
				counter := counter + 1;
				if (counter > clock_frequency) then
					counter := 0;
					frequency_index := frequency_index + 1;
				end if;
			end if;
			
			if (frequency_index >= frequency_array'length - 1) then
				frequency_index := 0;
			end if;
			
			phase_inc <= frequency_array(frequency_index);
		end if;
	end process ramp;
	
end architecture structure;
