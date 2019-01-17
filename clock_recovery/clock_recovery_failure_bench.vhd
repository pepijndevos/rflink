-------------------------------------------------------------------------------
-- File: clock_recovery_failure_bench.vhd
-- Description: Clock recovery test bench for invalid signals
-- Author: Pepijn de Vos
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity clockrecoverybench_fail is
end;

architecture testbench of clockrecoverybench_fail is

  signal rst : std_logic := '0';
  signal clk : std_logic := '0';
  signal outclk : std_logic := '0';

  signal data : std_logic := '0';

begin
  rst <= '1' after 20 ns;
  clk <= not clk after 10 ns;

-- play with various really short and long cycles
process
begin
    data <= '0';
    wait for 100 ns;
    data <= '1';
    wait for 100 ns;
end process;


  recovery_inst: entity work.clock_recovery(behavioral)
    port map (rst => rst,
      clk => clk,
      input => data,
      out_clk => outclk);

end;
