-------------------------------------------------------------------------------
-- File         : tvc_siso_gen_tester_arch.vhd
-- Description  : tester-style TVC for siso_gen
-- Author       : Sabih Gerez, University of Twente
-- Creation date: August 30, 2017
-------------------------------------------------------------------------------

-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;

entity tvc_dac_interface is
   port (
     clk_50_MHz : out std_logic;	-- 50 MHz clock signal
		 clk_160_MHz : out std_logic;	-- 160 MHz clock signal
     reset_n : out std_logic;
     enable : out std_logic
   );
end tvc_dac_interface;

architecture tester of tvc_dac_interface is
  constant half_period_50_MHz: time := 10 ns; -- 50 Mhz
	constant half_period_160_MHz: time := 3.125 ns; -- 160 Mhz
begin
  clk_50: process
    variable time_out_counter : integer := 0;
  begin
    reset_n <= '1';
    enable <= '1';

    wait for half_period_50_MHz;
    clk_50_MHz <= '0';
    wait for half_period_50_MHz;    
    clk_50_MHz <= '1';

    time_out_counter := time_out_counter + 1;
    if (time_out_counter > 20000) then
      assert false
        report "Clock timeout" severity failure;
    end if;
  end process clk_50;

	clk_160: process
    variable time_out_counter : integer := 0;
  begin
    wait for half_period_160_MHz;
    clk_160_MHz <= '0';
    wait for half_period_160_MHz;    
    clk_160_MHz <= '1';
  end process clk_160;
end tester;
