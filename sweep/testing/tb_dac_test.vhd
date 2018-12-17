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
  component sweep 
    generic(
      dac_width 			: natural := 10;
      data_width 			: natural := 8
    );
    port (
      clk_50_MHz 			: in std_logic;
			clk_160_MHz 		: in std_logic;
			reset_n					: in std_logic;
			enable					: in std_logic;
      sin_out 				: out std_logic_vector(dac_width-1 downto 0);
			pll_locked 			: out std_logic
    );
  end component;

  component tvc_dac_interface 
    port (
     clk_50_MHz 			: out std_logic;
		 clk_160_MHz			: out std_logic;
		 reset_n					: out std_logic;
		 enable						: out std_logic
   );
  end component;

  -- declare local signals
  signal clk_50_MHz, clk_160_MHz, reset_n, enable: std_logic;
begin
  -- instantiate and interconnect components
  -- note that the generic word_length is passed to the subblocks
  duv: sweep
    generic map(dac_width => dac_width, data_width => data_width)
    port map (clk_50_MHz => clk_50_MHz, clk_160_MHz => clk_160_MHz, reset_n => reset_n, enable => enable);
  tvc: tvc_dac_interface
    port map (clk_50_MHz => clk_50_MHz, clk_160_MHz => clk_160_MHz, reset_n => reset_n, enable => enable);
end top;
