library ieee;
use ieee.numeric_std.all;

architecture behavioral of p_2_s is
  -- registers
  signal data_in_temp1, data_in_temp2: std_logic_vector(word_length_unbuffer-1 downto 0);
  signal data_out_temp: std_logic;
  signal counter_unbuffer: integer range 0 to (word_length_unbuffer-1);

begin
  -- the next process is sequential and only sensitive to clk and reset
  seq_parallel: process(clk_unbuffer_parallel, reset)
  begin
    if (reset = '0')
    then
	data_in_temp1 <= (others =>'0');
    elsif rising_edge(clk_unbuffer_parallel)
    then
	data_in_temp1 <= data_in_unbuffer;
	--data_out_temp <= data_in_temp(0);
    end if; -- (reset = '0')
  end process seq_parallel;

  seq_serial: process(clk_unbuffer_serial, reset)
  begin
    if (reset = '0')
    then
	data_in_temp2 <= (others =>'0');
	data_out_temp <= '0';
	counter_unbuffer <= 0;
    elsif rising_edge(clk_unbuffer_serial)
    then
	if(counter_unbuffer = 0)
	then
	    data_in_temp2 <= '0'&data_in_temp1(word_length_unbuffer-1 downto 1);
	    counter_unbuffer <= counter_unbuffer+1;
	    data_out_temp <= data_in_temp1(0);
	elsif(counter_unbuffer = (word_length_unbuffer-1))
	then
	    data_in_temp2 <= '0'&data_in_temp2(word_length_unbuffer-1 downto 1);
	    counter_unbuffer <= 0;
	    data_out_temp <= data_in_temp2(0);		
	else
	    data_in_temp2 <= '0'&data_in_temp2(word_length_unbuffer-1 downto 1);
	    counter_unbuffer <= counter_unbuffer+1;
	    data_out_temp <= data_in_temp2(0);		
	end if;--(counter_buffer = 0)
    end if; -- (reset = '0')
  end process seq_serial;

 

  data_out_unbuffer <= data_out_temp;
 
end behavioral;