library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

--Entity for synchronization testbench
entity tb_clock_divider is
    generic(
        clk_div : natural := 10
    );
end tb_clock_divider;

--Architecture for synchronization testbench
architecture structure of tb_clock_divider is
    -- declare components to be instantiated

    component clock_divider
    	generic(
            clk_div : natural := 10
        );
        port(
            clk_high_freq 	        : in  std_logic;
            clk_low_freq 	        : out  std_logic;
            reset       	: in  std_logic
        );
    end component;

    component tvc_clock_divider
        generic (
            clk_div : natural := 10
	    );
        port (
            clk_high_freq 	: out  std_logic;
            clk_low_freq 	: in  std_logic;
            reset           : out  std_logic
        );
    end component;

    -- declare local signals
    signal clk_high_freq, clk_low_freq, reset : std_logic;

begin

    duv: clock_divider 
    	generic map (
    		clk_div => clk_div
    	)
    	port map (
            clk_high_freq => clk_high_freq,
            clk_low_freq => clk_low_freq,
    		reset => reset
        );
    tvc : tvc_clock_divider
        generic map(
            clk_div     => clk_div
        )
        port map(
            clk_high_freq => clk_high_freq,
            clk_low_freq => clk_low_freq,
            reset => reset
        );
end structure;