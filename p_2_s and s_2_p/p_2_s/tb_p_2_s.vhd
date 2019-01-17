-------------------------------------------------------------------------------
-- File: tb_p_2_s.vhd
-- Description: Parallel to serial conversion test bench
-- Author: Big Boss Bakker
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_unbuffer is
  generic(word_length_unbuffer: natural := 10);
end tb_unbuffer;

architecture structure of tb_unbuffer is
  -- declare components to be instantiated
  component unbuffer
    generic (word_length_unbuffer: natural);
    port (data_in_unbuffer: in std_logic_vector(word_length_unbuffer-1 downto 0);
          clk_unbuffer_parallel: in std_logic;
	      clk_unbuffer_serial: in std_logic;
          reset: in std_logic;

          data_out_unbuffer: out std_logic);
  end component;

  component tvc_unbuffer
    generic (word_length_unbuffer: natural := 10;
             in_file_name: string := "p_2_s.in";
             out_file_name: string := "p_2_s.out");
    port (data_in_unbuffer: out std_logic_vector(word_length_unbuffer-1 downto 0);
          clk_unbuffer_parallel: out std_logic;
	      clk_unbuffer_serial: out std_logic;
          reset: out std_logic;

          data_out_unbuffer: in std_logic);
  end component;

  -- declare local signals
  signal data_in_unbuffer: std_logic_vector(word_length_unbuffer-1 downto 0);
  signal data_out_unbuffer: std_logic;
  signal clk_unbuffer_parallel, clk_unbuffer_serial, reset: std_logic;
begin
  -- instantiate and interconnect components
  -- note that the generic word_length is passed to the subblocks
  duv: unbuffer
    generic map (word_length_unbuffer => word_length_unbuffer)
    port map (data_in_unbuffer => data_in_unbuffer, clk_unbuffer_parallel => clk_unbuffer_parallel, clk_unbuffer_serial => clk_unbuffer_serial, reset => reset,
	      data_out_unbuffer => data_out_unbuffer);
  tvc: tvc_unbuffer
    generic map (word_length_unbuffer => word_length_unbuffer)
    port map (data_in_unbuffer => data_in_unbuffer, clk_unbuffer_parallel => clk_unbuffer_parallel, clk_unbuffer_serial => clk_unbuffer_serial, reset => reset,
              data_out_unbuffer => data_out_unbuffer);
end structure;

-------------------------------------------------------------------------------
-- top level testbench (to bind generic word length)
-------------------------------------------------------------------------------

entity tb_unbuffer_top is
end tb_unbuffer_top;

architecture top of tb_unbuffer_top is
  component tb_unbuffer
    generic(word_length: natural := 8);
  end component;
begin
  tg: tb_unbuffer;
end top;
