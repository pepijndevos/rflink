library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity modulatorbench is
end;

architecture testbench of modulatorbench is

  signal rst : std_logic := '0';
	signal clk : std_logic := '0';

  signal input : unsigned(3 downto 0) := "0000";
  signal output : signed(9 downto 0);

begin
  rst <= '1' after 20 ns;
  clk <= not clk after 10 ns;
  --data <= not data after 1 ms;
  input <= input+1 AFTER 4 us; -- ramp input

  mod_inst: entity work.modulator(behavioral)
    port map (rst => rst,
      clk => clk,
      input => input,
      output => output);
end;
