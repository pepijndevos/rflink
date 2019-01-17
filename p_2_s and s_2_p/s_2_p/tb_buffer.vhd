-------------------------------------------------------------------------------
-- File: p_2_s.vhd
-- Description: Serial to parellel conversion test bench
-- Author: Big Boss Bakker
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_buffer is
  generic(word_length_deframing: natural := 10;
	  word_length_buffer: natural :=10;
	  preamble_receiver: natural := 785;
	  deframing_length : natural := 20);
end tb_buffer;

architecture structure of tb_buffer is
  -- declare components to be instantiated
  component deframing
    generic (word_length_deframing: natural;
	     preamble_receiver: natural;
	     deframing_length: natural);
    port (data_in_deframing: in std_logic;
          clk_deframing_in: in std_logic;
          reset: in std_logic;
  	  clk_deframing_out_serial: out std_logic;
	  clk_deframing_out_parallel: out std_logic;
          data_out_deframing: out std_logic);
  end component;

  component s_2_p
    generic (word_length_buffer: natural);
    port (data_in_buffer: in std_logic;
          clk_buffer_parallel: in std_logic;
	  clk_buffer_serial: in std_logic;
          reset: in std_logic;

          data_out_buffer: out std_logic_vector(word_length_buffer-1 downto 0));
  end component;

  component tvc_buffer
    generic (word_length_deframing: natural := 10;
	     word_length_buffer: natural := 10;
	     preamble_receiver: natural := 785;
	     deframing_length : natural := 20;
             in_file_name: string := "siso_gen.in";
             out_file_name: string := "siso_gen.out");
    port (data_in_deframing: out std_logic;
          clk_deframing_in: out std_logic;
          reset: out std_logic;

          data_out_buffer: in std_logic_vector(word_length_buffer-1 downto 0));
  end component;

  -- declare local signals
  signal data_in_deframing, data_out_deframing, data_in_buffer: std_logic;
  signal data_out_buffer: std_logic_vector(word_length_buffer-1 downto 0);
  signal clk_deframing_out_serial, clk_deframing_out_parallel, clk_deframing_in: std_logic;
  signal clk_buffer_serial, clk_buffer_parallel, reset: std_logic;

begin
  -- instantiate and interconnect components
  -- note that the generic word_length is passed to the subblocks
  duv: deframing
    generic map (word_length_deframing => word_length_deframing,
		 preamble_receiver => preamble_receiver,
		 deframing_length => deframing_length)
    port map (data_in_deframing => data_in_deframing, clk_deframing_in => clk_deframing_in, reset => reset,
	      data_out_deframing => data_out_deframing, clk_deframing_out_parallel => clk_deframing_out_parallel,
	      clk_deframing_out_serial => clk_deframing_out_serial);
  duv2: s_2_p
    generic map (word_length_buffer => word_length_buffer)
    port map (data_in_buffer => data_out_deframing, clk_buffer_serial => clk_deframing_out_serial, reset => reset,
	      clk_buffer_parallel=>clk_deframing_out_parallel, data_out_buffer => data_out_buffer);
  tvc: tvc_buffer
    generic map (word_length_deframing => word_length_deframing,
		 word_length_buffer => word_length_buffer,
		 preamble_receiver => preamble_receiver,
		 deframing_length => deframing_length)
    port map (data_in_deframing => data_in_deframing, clk_deframing_in => clk_deframing_in, reset => reset,
              data_out_buffer => data_out_buffer);
end structure;

-------------------------------------------------------------------------------
-- top level testbench (to bind generic word length)
-------------------------------------------------------------------------------

entity tb_buffer_top is
end tb_buffer_top;

architecture top of tb_buffer_top is
  component tb_buffer
    generic(word_length: natural := 8);
  end component;
begin
  tg: tb_buffer;
end top;
