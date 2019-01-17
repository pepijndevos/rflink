-------------------------------------------------------------------------------
-- File: conf_tb_decoder_4B5B.vhd
-- Description: 8B10B test bench
-- Author: Big Boss Bakker
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- tb_siso_gen: testbench, connecting TVC and DUV
--
-- Note: the testbench does not have any I/O signals!
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_siso_gen is
  generic(word_length_in_4B5B_decoder: natural := 10;
	  word_length_out_4B5B_decoder: natural := 8);
end tb_siso_gen;

architecture structure of tb_siso_gen is
  -- declare components to be instantiated
  component siso_gen_4B5B_decoder
    generic (word_length_in_4B5B_decoder: natural;
	     word_length_out_4B5B_decoder: natural);
    port (data_in_4B5B_decoder: in std_logic_vector(word_length_in_4B5B_decoder-1 downto 0);
          clk_4B5B_decoder: in std_logic;
          reset: in std_logic;

          data_out_4B5B_decoder: out std_logic_vector(word_length_out_4B5B_decoder-1 downto 0));
  end component;

  component tvc_siso_gen
    generic (word_length_in_4B5B_decoder: natural := 10;
	     word_length_out_4B5B_decoder: natural := 8;
             in_file_name: string := "siso_gen.in";
             out_file_name: string := "siso_gen.out");
    port (data_in_4B5B_decoder: out std_logic_vector(word_length_in_4B5B_decoder-1 downto 0);
          clk_4B5B_decoder: out std_logic;
          reset: out std_logic;

          data_out_4B5B_decoder: in std_logic_vector(word_length_out_4B5B_decoder-1 downto 0));
  end component;

  -- declare local signals
  signal data_in_4B5B_decoder: std_logic_vector(word_length_in_4B5B_decoder-1 downto 0);
  signal data_out_4B5B_decoder: std_logic_vector(word_length_out_4B5B_decoder-1 downto 0);
  signal clk_4B5B_decoder, reset: std_logic;
begin
  -- instantiate and interconnect components
  -- note that the generic word_length is passed to the subblocks
  duv: siso_gen_4B5B_decoder
    generic map (word_length_in_4B5B_decoder => word_length_in_4B5B_decoder,
		 word_length_out_4B5B_decoder => word_length_out_4B5B_decoder)
    port map (data_in_4B5B_decoder => data_in_4B5B_decoder, clk_4B5B_decoder => clk_4B5B_decoder, reset => reset,
	      data_out_4B5B_decoder => data_out_4B5B_decoder);
  tvc: tvc_siso_gen
    generic map (word_length_in_4B5B_decoder => word_length_in_4B5B_decoder,
		 word_length_out_4B5B_decoder => word_length_out_4B5B_decoder)
    port map (data_in_4B5B_decoder => data_in_4B5B_decoder, clk_4B5B_decoder => clk_4B5B_decoder, reset => reset,
              data_out_4B5B_decoder => data_out_4B5B_decoder);
end structure;

-------------------------------------------------------------------------------
-- top level testbench (to bind generic word length)
-------------------------------------------------------------------------------

entity tb_siso_gen_top is
end tb_siso_gen_top;

architecture top of tb_siso_gen_top is
  component tb_siso_gen
    generic(word_length: natural := 8);
  end component;
begin
  tg: tb_siso_gen;
end top;
