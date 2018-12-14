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

architecture behavioral of framing is
  -- registers
  signal framing_counter : integer range 0 to framing_length;
  signal data_out_tmp: std_logic_vector(word_length_framing-1 downto 0);
begin
  -- the next process is sequential and only sensitive to clk and reset
  seq: process(clk_framing, reset)
  begin
    if (reset = '0')
    then
		framing_counter <= 0;
		data_out_tmp <=(others =>'0');
    elsif rising_edge(clk_framing)
    then
	if (framing_counter >= framing_length)
	then
	    data_out_tmp <= std_logic_vector(to_unsigned(preamble_transmitter,word_length_framing));
	    framing_counter <= 0;
	else
	    data_out_tmp <= data_in_framing;
	    framing_counter <= framing_counter + 1;
	end if; -- (frame_counter >= framing_length)
    end if; -- (reset = '0')
  end process seq; 
  
  -- output register can be any of num1 or num2
  data_out_framing <= data_out_tmp;

end behavioral;