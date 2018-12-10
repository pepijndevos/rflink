-------------------------------------------------------------------------------
-- File: siso_gen_ent.vhd
-- Description: generic serial-in serial-out device, entity declaration
-- Author: Sabih Gerez, University of Twente
-- Creation date: Sun Jul 11 00:34:27 CEST 2004
-------------------------------------------------------------------------------
-- $Rev: 8 $
-- $Author: gerezsh $
-- $Date: 2008-06-29 15:55:28 +0200 (Sun, 29 Jun 2008) $
-- $Log$
-------------------------------------------------------------------------------
-- $Log: siso_gen_ent.vhd,v $
-- Revision 1.2  2005/07/20 23:52:01  sabih
-- default values for generics supplied
--
-- Revision 1.1  2004/07/10 23:46:56  sabih
-- initial check in
--
-------------------------------------------------------------------------------


-- library and package declarations
library ieee;
use ieee.std_logic_1164.all;

entity siso_gen_buffer is
  generic (word_length_buffer: integer := 10);
  port (data_in_buffer: in std_logic;
        clk_buffer_parallel: in std_logic;
        clk_buffer_serial: in std_logic;
        reset: in std_logic;
        data_out_buffer: out std_logic_vector(word_length_buffer-1 downto 0));
end siso_gen_buffer;