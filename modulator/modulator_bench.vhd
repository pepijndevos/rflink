library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity modulatorbench is
end;

architecture testbench of modulatorbench is

  signal rst : std_logic := '0';
  signal clk : std_logic := '0';

  signal pulse : unsigned(3 downto 0) := "0000";
  signal sine : signed(9 downto 0);
  signal rcv_sine : signed(9 downto 0);
  signal binary : std_logic;

begin
  rst <= '1' after 20 ns;
  clk <= not clk after 10 ns;
  pulse <= not pulse AFTER 2 us; -- ramp input
  rcv_sine <= sine/2 + 100;

  mod_inst: entity work.modulator(behavioral)
    port map (rst => rst,
      clk => clk,
      input => pulse,
      output => sine);

  demod_inst: entity work.demodulator(behavioral)
    port map (rst => rst,
      clk => clk,
      input => rcv_sine,
      output => binary);
end;
