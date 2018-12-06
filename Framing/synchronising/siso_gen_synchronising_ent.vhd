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

entity siso_gen_synchronising is
  generic (word_length_synchronising: integer := 10;
	   preamble_receiver: integer := 785;
	   synchronising_length: integer := 20);
  port (data_in_synchronising: in std_logic;
        clk_synchronising_in: in std_logic;
        reset: in std_logic;
        data_out_synchronising: out std_logic;
        clk_synchronising_out_serial: out std_logic;
        clk_synchronising_out_parallel: out std_logic);
end siso_gen_synchronising;
