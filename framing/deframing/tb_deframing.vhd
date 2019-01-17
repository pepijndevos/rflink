-------------------------------------------------------------------------------
-- File: tb_deframing.vhd
-- Description: Test bench for deframing
-- Author: Jelle Bakker
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- tb_siso_gen: testbench, connecting TVC and DUV
--
-- Note: the testbench does not have any I/O signals!
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_deframing is
  generic(word_length_deframing: natural := 10;
	  preamble_receiver: natural := 785;
	  deframing_length : natural := 20);
end tb_deframing;

architecture structure of tb_deframing is
  -- declare components to be instantiated
  component deframing
    generic (word_length_deframing: natural;
	     preamble_receiver: natural;
	     deframing_length: natural);
    port (data_in_deframing: in std_logic;
          clk_deframing_in: in std_logic;
          reset: in std_logic;

          data_out_deframing: out std_logic);
  end component;

  component tvc_deframing
    generic (word_length_deframing: natural := 10;
	     preamble_receiver: natural := 785;
	     deframing_length : natural := 20;
             in_file_name: string := "siso_gen.in";
             out_file_name: string := "siso_gen.out");
    port (data_in_deframing: out std_logic;
          clk_deframing_in: out std_logic;
          reset: out std_logic;

          data_out_deframing: in std_logic);
  end component;

  -- declare local signals
  signal data_in_deframing: std_logic;
  signal data_out_deframing: std_logic;
  signal clk_deframing_in, reset: std_logic;
begin
  -- instantiate and interconnect components
  -- note that the generic word_length is passed to the subblocks
  duv: deframing
    generic map (word_length_deframing => word_length_deframing,
		 preamble_receiver => preamble_receiver,
		 deframing_length => deframing_length)
    port map (data_in_deframing => data_in_deframing, clk_deframing_in => clk_deframing_in, reset => reset,
	      data_out_deframing => data_out_deframing);
  tvc: tvc_deframing
    generic map (word_length_deframing => word_length_deframing,
		 preamble_receiver => preamble_receiver,
		 deframing_length => deframing_length)
    port map (data_in_deframing => data_in_deframing, clk_deframing_in => clk_deframing_in, reset => reset,
              data_out_deframing => data_out_deframing);
end structure;

-------------------------------------------------------------------------------
-- top level testbench (to bind generic word length)
-------------------------------------------------------------------------------

entity tb_top is
end tb_top;

architecture top of tb_top is
  component tb_deframing
    generic(word_length: natural := 8);
  end component;
begin
  tg: tb_deframing;
end top;
