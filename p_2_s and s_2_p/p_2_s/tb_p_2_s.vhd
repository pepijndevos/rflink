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
  generic(word_length_unbuffer: natural := 10);
end tb_siso_gen;

architecture structure of tb_siso_gen is
  -- declare components to be instantiated
  component siso_gen_unbuffer
    generic (word_length_unbuffer: natural);
    port (data_in_unbuffer: in std_logic_vector(word_length_unbuffer-1 downto 0);
          clk_unbuffer_parallel: in std_logic;
	      clk_unbuffer_serial: in std_logic;
          reset: in std_logic;
  
          data_out_unbuffer: out std_logic);
  end component;

  component tvc_siso_gen 
    generic (word_length_unbuffer: natural := 10;
             in_file_name: string := "siso_gen.in";
             out_file_name: string := "siso_gen.out");
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
  duv: siso_gen_unbuffer
    generic map (word_length_unbuffer => word_length_unbuffer)
    port map (data_in_unbuffer => data_in_unbuffer, clk_unbuffer_parallel => clk_unbuffer_parallel, clk_unbuffer_serial => clk_unbuffer_serial, reset => reset, 
	      data_out_unbuffer => data_out_unbuffer);
  tvc: tvc_siso_gen
    generic map (word_length_unbuffer => word_length_unbuffer)
    port map (data_in_unbuffer => data_in_unbuffer, clk_unbuffer_parallel => clk_unbuffer_parallel, clk_unbuffer_serial => clk_unbuffer_serial, reset => reset, 
              data_out_unbuffer => data_out_unbuffer);
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
