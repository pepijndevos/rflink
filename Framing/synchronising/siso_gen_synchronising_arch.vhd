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

architecture synchronising of siso_gen_synchronising is
  -- registers
  signal synchronising_counter : integer range 0 to synchronising_length;
  signal data_out_tmp: std_logic;
  signal preamble_receiver_std_logic_vector, received_data_buffer : std_logic_vector(word_length_synchronising-1 downto 0);
begin
  -- the next process is sequential and only sensitive to clk and reset
  seq: process(clk_synchronising, reset)
  begin
    if (reset = '0')
    then
	synchronising_counter <= 0;
	data_out_tmp <='0';
	preamble_receiver_std_logic_vector <= std_logic_vector(to_unsigned(preamble_receiver,word_length_synchronising));
	received_data_buffer <= (others => '0');
    elsif rising_edge(clk_synchronising)
    then
	data_out_tmp <= data_in_synchronising;
	data_in_temp <= data_in_synchronising&data_in_temp(word_length_unbuffer-1 downto 1);
	if(data_in_synchronising&data_in_temp(word_length_unbuffer-1 downto 1) = preamble_receiver_std_logic_vector)
	then
		found_preamble := true;
	else
		



    end if; -- (reset = '0')
  end process seq; 
  
  -- output register can be any of num1 or num2
  data_out_synchronising <= data_out_tmp;

end synchronising;