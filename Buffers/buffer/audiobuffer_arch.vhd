-------------------------------------------------------------------------------
-- File: siso_gen_gcd_arch.vhd
-- Description: siso_gen architecture for computing greatest common divider
-- Author: Sabih Gerez, University of Twente
-- Creation date: Sun Jul 11 00:37:33 CEST 2004
-------------------------------------------------------------------------------
-- $Rev: 8 $
-- $Author: gerezsh $
-- $Date: 2008-06-29 15:55:28 +0200 (Sun, 29 Jun 2008) $
-- $Log$
-------------------------------------------------------------------------------
-- $Log: siso_gen_gcd_arch.vhd,v $
-- Revision 1.1  2004/07/10 23:46:56  sabih
-- initial check in
--
-------------------------------------------------------------------------------



-- this architecture needs arithmetic functions
library ieee;
use ieee.numeric_std.all;

architecture buffer_1 of audiobuffer is
  -- registers
  signal data_out_temp1, data_out_temp2: std_logic_vector(word_length_buffer-1 downto 0);


begin
  -- the next process is sequential and only sensitive to clk and reset
  seq_serial: process(clk_buffer_serial, reset)
  begin
    if (reset = '0')
    then
	data_out_temp1 <= (others =>'0');
    elsif rising_edge(clk_buffer_serial)
    then
	data_out_temp1 <= data_in_buffer&data_out_temp1(word_length_buffer-1 downto 1);
	--data_out_temp <= data_in_temp(0);
    end if; -- (reset = '0')
  end process seq_serial;

  -- the next process is sequential and only sensitive to clk and reset
  seq_parallel: process(clk_buffer_parallel, reset)
  begin
    if (reset = '0')
    then
	data_out_temp2 <=(others =>'0');
    elsif rising_edge(clk_buffer_parallel)
    then
	data_out_temp2 <= data_out_temp1; --data_in_buffer&data_out_temp1(word_length_buffer-1 downto 1);
	--data_out_temp <= data_in_temp(0);
    end if; -- (reset = '0')
  end process seq_parallel; 

  data_out_buffer <= data_out_temp2;
 
end buffer_1;