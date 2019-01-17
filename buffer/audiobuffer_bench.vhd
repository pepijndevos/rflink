-------------------------------------------------------------------------------
-- File: audiobuffer_bench.vhd
-- Description: Test bench for the audio buffer
-- Author: Pepijn de Vos
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity modulatorbench is
end;

architecture testbench of modulatorbench is

  signal rst : std_logic := '0';
  signal clk : std_logic := '0';
  signal inclk : std_logic := '0';
  signal outclk : std_logic := '0';
  signal sample : signed(7 downto 0) := (7 => '0', others => '1');
  signal output : signed(7 downto 0) := (others => '0');

begin
  rst <= '1' after 20 ns;
  clk <= not clk after 10 ns;
  inclk <= not inclk AFTER 10 us;
  sample <= not sample AFTER 80 us;
  outclk <= not outclk AFTER 9 us;


  buf_inst: entity work.audiobuffer(interpolate)
  generic map (
    word_length => sample'length
  )
  port map (
    rst => rst,
    clk => clk,
    clk_in => inclk,
    clk_out => outclk,
    data_in => sample,
    data_out => output
);

end;
