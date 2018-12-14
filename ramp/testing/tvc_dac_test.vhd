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
     clk_1_25_MHz : out std_logic;	-- 1.25 MHz clock signal
     clk_5_MHz : out std_logic;		-- 5 MHz clock signal
     clk_20_MHz : out std_logic;	-- 20 MHz clock signal
     clk_40_MHz : out std_logic;	-- 40 MHz clock signal
     clk_50_MHz : out std_logic;	-- 50 MHz clock signal
     reset_n : out std_logic;
     enable : out std_logic
   );
end tvc_dac_interface;

architecture tester of tvc_dac_interface is
  constant half_period_50_MHz: time := 20 ns; -- 50 Mhz
  constant half_period_5_MHz: time := 200 ns; -- 5 MHz
  constant half_period_40_MHz: time := 25 ns; -- 40 MHz
  constant half_period_20_MHz: time := 50 ns; -- 20 MHz
  constant half_period_1_25_MHz: time := 400 ns; -- 1.25 MHz
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
        report "Time out while waiting for req!" severity failure;
    end if;
  end process clk_50;

  clk_40: process
  begin
    wait for half_period_40_MHz;
    clk_40_MHz <= '0';
    wait for half_period_40_MHz;    
    clk_40_MHz <= '1';
  end process clk_40;

  clk_20: process
  begin
    wait for half_period_20_MHz;
    clk_20_MHz <= '0';
    wait for half_period_20_MHz;    
    clk_20_MHz <= '1';
  end process clk_20;

  clk_5: process
  begin
    wait for half_period_5_MHz;
    clk_5_MHz <= '0';
    wait for half_period_5_MHz;    
    clk_5_MHz <= '1';
  end process clk_5;

  clk_1_25: process
  begin
    wait for half_period_1_25_MHz;
    clk_1_25_MHz <= '0';
    wait for half_period_1_25_MHz;    
    clk_1_25_MHz <= '1';
  end process clk_1_25;
end tester;
