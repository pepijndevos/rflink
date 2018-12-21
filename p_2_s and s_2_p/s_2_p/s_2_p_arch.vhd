library ieee;
use ieee.numeric_std.all;

architecture behavioral of s_2_p is
  -- registers
  signal data_out_temp1, data_out_temp2, data_out_temp3: std_logic_vector(word_length_buffer-1 downto 0);
  signal data_in_buffer_temp0, data_in_buffer_temp1, data_in_buffer_temp2, data_in_buffer_temp3, data_in_buffer_temp4, data_in_buffer_temp5, data_in_buffer_temp6, data_in_buffer_temp7, data_in_buffer_temp8: std_logic; 
  signal counter_delay : integer;
  signal counter_delay_temp : integer
begin
	btn: process(clk_buffer_serial, reset)
		variable next_pressed : std_logic := '0';
	begin
		if (reset = '0') then
			next_pressed := '0';
			counter_delay <= 0;
		elsif (rising_edge(clk_buffer_serial)) then
			-- Next frequency
			if (delay = '1' and next_pressed = '0') then
				next_pressed := '1';
				counter_delay <= counter_delay + 1;
				
				if (counter_delay > 9) then
					counter_delay <= 0;
				end if;
			elsif (delay = '1' and next_pressed = '1') then
				next_pressed := '1';
			elsif (delay = '0') then
				next_pressed := '0';
			end if;
		end if;
	end process control;  

	-- the next process is sequential and only sensitive to clk and reset
  seq_serial: process(clk_buffer_serial, reset)
  begin
    if (reset = '0') then
			data_out_temp1 <= (others =>'0');
			data_in_buffer_temp0 <= '0';
    elsif rising_edge(clk_buffer_serial) then
		 data_out_temp3 <= data_in_buffer&data_out_temp3(word_length_buffer-1 downto 1);
	   data_out_temp1 <= data_out_temp3(counter_delay)&data_out_temp1(word_length_buffer-1 downto 1);
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
  delay_counter_out <= std_logic_vector(to_unsigned(counter_delay,4));
end behavioral;
