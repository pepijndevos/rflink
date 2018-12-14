-------------------------------------------------------------------------------
-- File: tb_siso_gen.vhd
-- Description: testbench for siso with generic word length
-- Author: Sabih Gerez, University of Twente
-- Creation date: Sun Jul 11 00:46:01 CEST 2004
-------------------------------------------------------------------------------
-- $Rev: 8 $
-- $Author: gerezsh $
-- $Date: 2008-06-29 15:55:28 +0200 (Sun, 29 Jun 2008) $
-- $Log$
-------------------------------------------------------------------------------
-- $Log: tb_siso_gen.vhd,v $
-- Revision 1.2  2004/08/10 22:44:07  sabih
-- tvc declarations now in separate files
--
-- Revision 1.1  2004/07/10 23:46:57  sabih
-- initial check in
--
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- tb_siso_gen: testbench, connecting TVC and DUV
--
-- Note: the testbench does not have any I/O signals!
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity tb_siso_gen is 
  generic(word_length_synchronising: natural := 10;
	  word_length_buffer: natural :=10;
	  preamble_receiver: natural := 785;
	  synchronising_length : natural := 20);
end tb_siso_gen;

architecture structure of tb_siso_gen is
  -- declare components to be instantiated
  component siso_gen_synchronising
    generic (word_length_synchronising: natural;
	     preamble_receiver: natural;
	     synchronising_length: natural);
    port (data_in_synchronising: in std_logic;
          clk_synchronising_in: in std_logic;
          reset: in std_logic;
  	  clk_synchronising_out_serial: out std_logic;
	  clk_synchronising_out_parallel: out std_logic;
          data_out_synchronising: out std_logic);
  end component;

  component siso_gen_buffer
    generic (word_length_buffer: natural);
    port (data_in_buffer: in std_logic;
          clk_buffer_parallel: in std_logic;
	  clk_buffer_serial: in std_logic;
          reset: in std_logic;
  
          data_out_buffer: out std_logic_vector(word_length_buffer-1 downto 0));
  end component;

  component tvc_siso_gen 
    generic (word_length_synchronising: natural := 10;
	     word_length_buffer: natural := 10;
	     preamble_receiver: natural := 785;
	     synchronising_length : natural := 20;
             in_file_name: string := "siso_gen.in";
             out_file_name: string := "siso_gen.out");
    port (data_in_synchronising: out std_logic;
          clk_synchronising_in: out std_logic;
          reset: out std_logic;
  
          data_out_buffer: in std_logic_vector(word_length_buffer-1 downto 0));
  end component;

  -- declare local signals
  signal data_in_synchronising, data_out_synchronising, data_in_buffer: std_logic; 
  signal data_out_buffer: std_logic_vector(word_length_buffer-1 downto 0);
  signal clk_synchronising_out_serial, clk_synchronising_out_parallel, clk_synchronising_in: std_logic;
  signal clk_buffer_serial, clk_buffer_parallel, reset: std_logic;
	  
begin
  -- instantiate and interconnect components
  -- note that the generic word_length is passed to the subblocks
  duv: siso_gen_synchronising
    generic map (word_length_synchronising => word_length_synchronising,
		 preamble_receiver => preamble_receiver,
		 synchronising_length => synchronising_length)
    port map (data_in_synchronising => data_in_synchronising, clk_synchronising_in => clk_synchronising_in, reset => reset, 
	      data_out_synchronising => data_out_synchronising, clk_synchronising_out_parallel => clk_synchronising_out_parallel,
	      clk_synchronising_out_serial => clk_synchronising_out_serial);
  duv2: siso_gen_buffer
    generic map (word_length_buffer => word_length_buffer)
    port map (data_in_buffer => data_out_synchronising, clk_buffer_serial => clk_synchronising_out_serial, reset => reset, 
	      clk_buffer_parallel=>clk_synchronising_out_parallel, data_out_buffer => data_out_buffer);
  tvc: tvc_siso_gen
    generic map (word_length_synchronising => word_length_synchronising,
		 word_length_buffer => word_length_buffer,
		 preamble_receiver => preamble_receiver,
		 synchronising_length => synchronising_length)
    port map (data_in_synchronising => data_in_synchronising, clk_synchronising_in => clk_synchronising_in, reset => reset, 
              data_out_buffer => data_out_buffer);
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
