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

architecture unbuffer of siso_gen_unbuffer is
  -- registers
  signal data_in_temp: std_logic_vector(word_length_unbuffer-1 downto 0);
  signal data_out_temp: std_logic;
begin
  -- the next process is sequential and only sensitive to clk and reset
  seq_parallel: process(clk_unbuffer_parallel, clk_unbuffer_serial, reset)
  begin
    if (reset = '0')
    then
		data_in_temp <= (others =>'0');
    elsif rising_edge(clk_unbuffer_parallel)
    then
		data_in_temp <= data_in_unbuffer;
    elsif rising_edge(clk_unbuffer_serial)
    then
		data_in_temp <= '0'&data_in_temp(word_length_unbuffer-1 downto 1);
		data_out_temp <= data_in_temp(0);
    end if; -- (reset = '0')
  end process seq_parallel; 

  -- the next process is sequential and only sensitive to clk and reset
  --seq_serial: process(clk_unbuffer_serial, reset)
  --begin
  --  if (reset = '0')
  --  then
--		data_out_temp <= '0';
--		data_in_temp <= (others =>'0');
  --  elsif rising_edge(clk_unbuffer_serial)
  --  then
		--data_in_temp <= '0'&data_in_temp(word_length_unbuffer-1 downto 1);
		--data_out_temp <= data_in_temp(0);
  --  end if; -- (reset = '0')
  --end process seq_serial; 
  
  -- output register can be any of num1 or num2
  data_out_unbuffer <= data_out_temp;

end unbuffer;