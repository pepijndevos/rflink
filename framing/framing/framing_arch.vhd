-------------------------------------------------------------------------------
-- File: framing_arch.vhd
-- Description: Replace evey nth byte with a preamble byte for synchronization
-- Author: Jelle Bakker
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
		 frame_ins <= '1';
	else
	    data_out_tmp <= data_in_framing;
	    framing_counter <= framing_counter + 1;
		 frame_ins <= '0';
	end if; -- (frame_counter >= framing_length)
    end if; -- (reset = '0')
  end process seq;

  -- output register can be any of num1 or num2
  data_out_framing <= data_out_tmp;

end behavioral;
