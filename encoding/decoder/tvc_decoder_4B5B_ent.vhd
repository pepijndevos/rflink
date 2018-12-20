-------------------------------------------------------------------------------
-- File: tvc_siso_gen_ent.vhd
-- Description: test-vector controller (TVC) for SISO with generic
--              word length
-- Author: Sabih Gerez, University of Twente
-- Creation date: Wed Aug 11 00:24:38 CEST 2004
-------------------------------------------------------------------------------
-- $Rev: 270 $
-- $Author: gerezsh $
-- $Date: 2018-08-28 00:34:51 +0200 (Tue, 28 Aug 2018) $
-- $Log$
-------------------------------------------------------------------------------
-- $Log: tvc_siso_gen_ent.vhd,v $
-- Revision 1.2  2004/08/10 23:34:10  sabih
-- generic scan_chain_length added
--
-- Revision 1.1  2004/08/10 22:41:23  sabih
-- initial check in
--
-------------------------------------------------------------------------------

-- library and package declarations
library ieee, std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tvc_siso_gen is
  generic (word_length_in_4B5B_decoder: natural := 10;
	   word_length_out_4B5B_decoder: natural := 8;
           in_file_name: string := "siso_gen.in";
           out_file_name: string := "siso_gen.out";
           half_clock_period: time := 100 ns);
  port (data_in_4B5B_decoder: out std_logic_vector(word_length_in_4B5B_decoder-1 downto 0);
        clk_4B5B_decoder: out std_logic;
        reset: out std_logic;
        data_out_4B5B_decoder: in std_logic_vector(word_length_out_4B5B_decoder-1 downto 0));
end tvc_siso_gen;