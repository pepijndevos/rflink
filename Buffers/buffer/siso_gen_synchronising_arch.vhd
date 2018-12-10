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
  signal synchronising_counter_bits : integer range 0 to (synchronising_length*word_length_synchronising);
  signal synchronising_counter_frames : integer range 0 to synchronising_length;
  signal data_out_tmp, clk_synchronising_out_parallel_temp, clk_synchronising_out_parallel_temp_buffer1, clk_synchronising_out_parallel_temp_buffer2: std_logic;
  signal preamble_receiver_std_logic_vector, data_in_temp_buffer_10_newest_of_20, data_in_temp_buffer_20_newest_of_20 : std_logic_vector(word_length_synchronising-1 downto 0);
begin
  -- the next process is sequential and only sensitive to clk and reset
  seq: process(clk_synchronising_in, reset)
  begin
    if (reset = '0')
    then
	synchronising_counter_bits <= 0;
	synchronising_counter_frames <= 0;
	data_out_tmp <='0';
	clk_synchronising_out_parallel_temp<='1';
	preamble_receiver_std_logic_vector <= std_logic_vector(to_unsigned(preamble_receiver,word_length_synchronising));
	data_in_temp_buffer_10_newest_of_20 <= (others => '0');
	data_in_temp_buffer_20_newest_of_20 <= (others => '0');
    elsif rising_edge(clk_synchronising_in)
    then
	data_in_temp_buffer_10_newest_of_20 <= data_in_synchronising&data_in_temp_buffer_10_newest_of_20(word_length_synchronising-1 downto 1);
	data_in_temp_buffer_20_newest_of_20 <= data_in_temp_buffer_10_newest_of_20(0)&data_in_temp_buffer_20_newest_of_20(word_length_synchronising-1 downto 1);
	if((data_in_synchronising&data_in_temp_buffer_10_newest_of_20(word_length_synchronising-1 downto 1) = preamble_receiver_std_logic_vector) and (synchronising_counter_frames = 0) and (synchronising_counter_bits = 0))
	then -- the preamble was found and you are currently not sending anything
		data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);
		synchronising_counter_bits<=synchronising_counter_bits+1;
	elsif((synchronising_counter_frames > 0) or (synchronising_counter_bits > 0))-- you are sending frames
	then
		if(synchronising_counter_frames = 0)
		then
			if (synchronising_counter_bits=((word_length_synchronising/2)-1))
			then
				clk_synchronising_out_parallel_temp <= not clk_synchronising_out_parallel_temp;
				synchronising_counter_bits<=synchronising_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);
			elsif(synchronising_counter_bits=(word_length_synchronising-1))
			then 
				clk_synchronising_out_parallel_temp <= not clk_synchronising_out_parallel_temp;
				synchronising_counter_bits<=0;
				synchronising_counter_frames<=synchronising_counter_frames+1;
				data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);
			else
				synchronising_counter_bits<=synchronising_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);
			end if;--(synchronising_counter_bits=((word_length_synchronising/2)-1))
	
		elsif(synchronising_counter_frames <= synchronising_length-1)
		then
			if((synchronising_counter_bits=0) and (synchronising_counter_frames=1))
			then
				synchronising_counter_bits<=synchronising_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);				
			elsif (synchronising_counter_bits=((word_length_synchronising/2)-1))
			then
				clk_synchronising_out_parallel_temp <= not clk_synchronising_out_parallel_temp;
				synchronising_counter_bits<=synchronising_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			elsif(synchronising_counter_bits=(word_length_synchronising-1))
			then 
				clk_synchronising_out_parallel_temp <= not clk_synchronising_out_parallel_temp;
				synchronising_counter_bits<=0;
				synchronising_counter_frames<=synchronising_counter_frames+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			else
				synchronising_counter_bits<=synchronising_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			end if;--(synchronising_counter_bits=((word_length_synchronising/2)-1))

		else
			if (synchronising_counter_bits=((word_length_synchronising/2)-1))
			then
				clk_synchronising_out_parallel_temp <= not clk_synchronising_out_parallel_temp;
				synchronising_counter_bits<=synchronising_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			elsif(synchronising_counter_bits=(word_length_synchronising-1))
			then 
				clk_synchronising_out_parallel_temp <= not clk_synchronising_out_parallel_temp;
				synchronising_counter_bits<=0;
				synchronising_counter_frames<=0;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);	
			else
				synchronising_counter_bits<=synchronising_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			end if;--(synchronising_counter_bits=((word_length_synchronising/2)-1))

		end if; -- (synchronising_counter_frames = 0)

	else-- you have not found any preamble and are not sending any frames
		synchronising_counter_frames<=0;
		synchronising_counter_bits<=0;	
		data_out_tmp <= '0';
	end if;
	clk_synchronising_out_parallel_temp_buffer1<=clk_synchronising_out_parallel_temp;
	clk_synchronising_out_parallel_temp_buffer2<=clk_synchronising_out_parallel_temp_buffer1;
    end if; -- (reset = '0')
  end process seq; 
  
  -- output register can be any of num1 or num2
  data_out_synchronising <= data_out_tmp;
  clk_synchronising_out_serial<=clk_synchronising_in;
  clk_synchronising_out_parallel<=clk_synchronising_out_parallel_temp_buffer2;
end synchronising;