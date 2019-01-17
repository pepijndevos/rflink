-------------------------------------------------------------------------------
-- File: tb_framing.vhd
-- Description: Test bench for framing
-- Author: Jelle Bakker
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_framing is
  generic(word_length_framing: natural := 10;
	  preamble_transmitter: natural := 785;
	  framing_length : natural := 30);
end tb_framing;

architecture structure of tb_framing is
  -- declare components to be instantiated
  component framing
    generic (word_length_framing: natural;
	     preamble_transmitter: natural;
	     framing_length: natural);
    port (data_in_framing: in std_logic_vector(word_length_framing-1 downto 0);
          clk_framing: in std_logic;
          reset: in std_logic;

          data_out_framing: out std_logic_vector(word_length_framing-1 downto 0));
  end component;

  component tvc_framing
    generic (word_length_framing: natural := 10;
	     preamble_transmitter: natural := 785;
	     framing_length : natural := 20;
             in_file_name: string := "siso_gen.in";
             out_file_name: string := "siso_gen.out");
    port (data_in_framing: out std_logic_vector(word_length_framing-1 downto 0);
          clk_framing: out std_logic;
          reset: out std_logic;

          data_out_framing: in std_logic_vector(word_length_framing-1 downto 0));
  end component;

  -- declare local signals
  signal data_in_framing: std_logic_vector(word_length_framing-1 downto 0);
  signal data_out_framing: std_logic_vector(word_length_framing-1 downto 0);
  signal clk_framing, reset: std_logic;
begin
  -- instantiate and interconnect components
  -- note that the generic word_length is passed to the subblocks
  duv: framing
    generic map (word_length_framing => word_length_framing,
		 preamble_transmitter => preamble_transmitter,
		 framing_length => framing_length)
    port map (data_in_framing => data_in_framing, clk_framing => clk_framing, reset => reset,
	      data_out_framing => data_out_framing);
  tvc: tvc_framing
    generic map (word_length_framing => word_length_framing,
		 preamble_transmitter => preamble_transmitter,
		 framing_length => framing_length)
    port map (data_in_framing => data_in_framing, clk_framing => clk_framing, reset => reset,
              data_out_framing => data_out_framing);
end structure;

-------------------------------------------------------------------------------
-- top level testbench (to bind generic word length)
-------------------------------------------------------------------------------

entity tb_framing_top is
end tb_framing_top;

architecture top of tb_framing_top is
  component tb_framing
    generic(word_length: natural := 8);
  end component;
begin
  tg: tb_framing;
end top;
