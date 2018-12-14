-------------------------------------------------------------------------------
-- File: tb_siso_gen.vhd
-- Description: testbench for siso with generic word length
-- Author: Sabih Gerez, University of Twente
-- Creation date: Sun Jul 11 00:46:01 CEST 2004
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_dac_test is 
  generic(
    dac_width: natural := 8;
    data_width: natural := 10
  );
end tb_dac_test;

architecture top of tb_dac_test is
  -- declare components to be instantiated
  component dac_test_interface 
    generic(
      dac_width : natural := 10;
      data_width : natural := 8
    );
    port (
      clk_1_25_MHz : in std_logic;	-- 1.25 MHz clock signal
      clk_5_MHz : in std_logic;		-- 5 MHz clock signal
      clk_20_MHz : in std_logic;	-- 20 MHz clock signal
      clk_40_MHz : in std_logic;	-- 40 MHz clock signal
      clk_50_MHz : in std_logic;
      reset_n : in std_logic;
      enable : in std_logic;
      dac_clk : out std_logic;
      ready_to_gpio : out std_logic;
      d_to_gpio : out std_logic_vector(dac_width-1 downto 0)
    );
  end component;

  component tvc_dac_interface 
    port (
     clk_1_25_MHz : out std_logic;	-- 1.25 MHz clock signal
     clk_5_MHz : out std_logic;		-- 5 MHz clock signal
     clk_20_MHz : out std_logic;	-- 20 MHz clock signal
     clk_40_MHz : out std_logic;	-- 40 MHz clock signal
     clk_50_MHz : out std_logic;
     reset_n : out std_logic;
     enable : out std_logic
   );
  end component;

  -- declare local signals
  signal clk_1_25_MHz, clk_5_MHz, clk_20_MHz, clk_40_MHz, clk_50_MHz, reset_n, enable, dac_clk: std_logic;
  signal scan_in, scan_shift, scan_out, ready_to_gpio: std_logic;
  signal d_to_gpio : std_logic_vector(dac_width-1 downto 0);
begin
  -- instantiate and interconnect components
  -- note that the generic word_length is passed to the subblocks
  duv: dac_test_interface
    generic map(dac_width => dac_width, data_width => data_width)
    port map (clk_1_25_MHz => clk_1_25_MHz, clk_5_MHz => clk_5_MHz, 
              clk_20_MHz => clk_20_MHz, clk_40_MHz => clk_40_MHz, 
              clk_50_MHz => clk_50_MHz, reset_n => reset_n, enable => enable, 
              dac_clk => dac_clk, ready_to_gpio => ready_to_gpio, d_to_gpio => d_to_gpio);
  tvc: tvc_dac_interface
    port map (clk_1_25_MHz => clk_1_25_MHz, clk_5_MHz => clk_5_MHz, 
              clk_20_MHz => clk_20_MHz, clk_40_MHz => clk_40_MHz, 
              clk_50_MHz => clk_50_MHz, reset_n => reset_n, enable => enable);
end top;