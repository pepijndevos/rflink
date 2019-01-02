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
	
	signal next_btn : std_logic;
	signal pll_locked : std_logic;
	signal reset_n : std_logic;
	signal enable : std_logic;
	signal sweep_btn : std_logic;
	signal sin_out : std_logic_vector(dac_width-1 downto 0);
	signal dac_clk : std_logic;
	signal ready_to_gpio : std_logic;
	signal clk_50_MHz : std_logic;
	signal is_running : std_logic;

	signal freeze : std_logic;
	signal next_frequency : std_logic;
	
	type rom_type is array (0 to 40) of std_logic_vector (31 downto 0);
	constant frequency_array : rom_type := 
		(
			X"000068dc",
			X"0000d1b7",
			X"00013a93",
			X"0001a36e",
			X"00020c4a",
			X"00027525",
			X"0002de01",
			X"000346dc",
			X"0003afb8",
			X"00041893",
			X"00083127",
			X"000c49ba",
			X"0010624e",
			X"00147ae1",
			X"00189375",
			X"001cac08",
			X"0020c49c",
			X"0024dd2f",
			X"0028f5c3",
			X"0051eb85",
			X"007ae148",
			X"00a3d70a",
			X"00cccccd",
			X"00f5c28f",
			X"011eb852",
			X"0147ae14",
			X"0170a3d7",
			X"01800000", -- 0.9 MHz
			X"0199999a", -- 1 MHz
			X"02000000", -- 1.25 MHz
			X"03333333", -- 2 MHz
			X"04000000", -- 2.5 MHz
			X"04cccccd", -- 3 MHz
			X"06666666", -- 4 MHz
			X"08000000", -- 5 MHz
			X"0999999a", -- 6 MHz
			X"0b333333", -- 7 MHz
			X"0ccccccd", -- 8 MHz
			X"0e666666", -- 9 MHz
			X"10000000", -- 10 MHz
			X"20000000"	 -- 20 MHz
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
	-- Write to output
	reset_n <= KEY(0);
	next_btn <= KEY(1);
	sweep_btn <= KEY(2);
	clk_50_MHz <= CLOCK_50;
	enable <= GPIO_1(0); -- active high
	
	GPIO_0(9 downto 0) <= sin_out;
	GPIO_0(10) <= dac_clk;
	GPIO_0(11) <= enable;
	GPIO_0(12) <= ready_to_gpio;
	LEDR(0) <= dac_input(2);
	LEDR(1) <= dac_input(11);
	
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
			is_running <= '0';
		elsif (rising_edge(clk_50_MHz) and reset_n = '1') then
			is_running <= '1';
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
