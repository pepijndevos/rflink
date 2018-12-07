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
  signal data_in_temp, data_in_temp2: std_logic_vector(word_length_unbuffer-1 downto 0);
  signal data_out_temp: std_logic;
  signal counter_bits: integer range 0 to (word_length_unbuffer-1);
begin
  -- the next process is sequential and only sensitive to clk and reset
  seq_parallel: process(clk_unbuffer_parallel, clk_unbuffer_serial, reset)
  begin
    if (reset = '0')
    then
		data_in_temp <= (others =>'0');
		data_in_temp2 <= (others =>'0');
		counter_bits <=0;
    elsif rising_edge(clk_unbuffer_parallel)
    then
		data_in_temp <= data_in_unbuffer;
		data_out_temp <= data_in_temp2(9);
		counter_bits<=0;
    elsif rising_edge(clk_unbuffer_serial)
    then

		data_in_temp <= '0'&data_in_temp(word_length_unbuffer-1 downto 1);
		if(counter_bits = 0)
		then
			data_out_temp <= data_in_temp(0);
			counter_bits<=counter_bits+1;
			data_in_temp2<=data_in_temp;			
		else
			data_out_temp <= data_in_temp(0);
			counter_bits<=counter_bits+1;
		end if;--(counter_bits<(word_length_unbuffer-1))
    end if; -- (reset = '0')
  end process seq_parallel; 

  data_out_unbuffer <= data_out_temp;
 
end unbuffer;