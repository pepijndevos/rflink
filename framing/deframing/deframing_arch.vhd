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

architecture behavioral of deframing is
  -- registers
  signal deframing_counter_bits : integer range 0 to (deframing_length*word_length_deframing);
  signal deframing_counter_frames : integer range 0 to deframing_length;
  signal data_out_tmp, clk_deframing_out_parallel_temp, clk_deframing_out_parallel_temp_buffer1, clk_deframing_out_parallel_temp_buffer2, clk_deframing_out_parallel_temp_buffer3: std_logic;
  signal preamble_receiver_std_logic_vector, data_in_temp_buffer_10_newest_of_20, data_in_temp_buffer_20_newest_of_20 : std_logic_vector(word_length_deframing-1 downto 0);
begin
  -- the next process is sequential and only sensitive to clk and reset
  seq: process(clk_deframing_in, reset)
  begin
    if (reset = '0') then
			deframing_counter_bits <= 0;
			deframing_counter_frames <= 0;
			data_out_tmp <='0';
			clk_deframing_out_parallel_temp<='1';
			preamble_found <= '0';
			preamble_receiver_std_logic_vector <= std_logic_vector(to_unsigned(preamble_receiver,word_length_deframing));
			data_in_temp_buffer_10_newest_of_20 <= (others => '0');
			data_in_temp_buffer_20_newest_of_20 <= (others => '0');
    elsif rising_edge(clk_deframing_in) then
	data_in_temp_buffer_10_newest_of_20 <= data_in_deframing&data_in_temp_buffer_10_newest_of_20(word_length_deframing-1 downto 1);
	data_in_temp_buffer_20_newest_of_20 <= data_in_temp_buffer_10_newest_of_20(0)&data_in_temp_buffer_20_newest_of_20(word_length_deframing-1 downto 1);
	if((data_in_deframing&data_in_temp_buffer_10_newest_of_20(word_length_deframing-1 downto 1) = preamble_receiver_std_logic_vector) and (deframing_counter_frames = 0) and (deframing_counter_bits = 0))
	then -- the preamble was found and you are currently not sending anything
		data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);
		deframing_counter_bits<=deframing_counter_bits+1;
		preamble_found <= '1';
	elsif((deframing_counter_frames > 0) or (deframing_counter_bits > 0)) then -- you are sending frames 
		if(deframing_counter_frames = 0)
		then
			if (deframing_counter_bits=((word_length_deframing/2)-1)) then
				clk_deframing_out_parallel_temp <= not clk_deframing_out_parallel_temp;
				deframing_counter_bits<=deframing_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);
			elsif(deframing_counter_bits=(word_length_deframing-1))
			then 
				clk_deframing_out_parallel_temp <= not clk_deframing_out_parallel_temp;
				deframing_counter_bits<=0;
				deframing_counter_frames<=deframing_counter_frames+1;
				data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);
			else
				deframing_counter_bits<=deframing_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);
			end if;--(deframing_counter_bits=((word_length_deframing/2)-1))
	
		elsif(deframing_counter_frames <= deframing_length-1) then
			if((deframing_counter_bits=0) and (deframing_counter_frames=1))
			then
				deframing_counter_bits<=deframing_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);				
			elsif (deframing_counter_bits=((word_length_deframing/2)-1))
			then
				clk_deframing_out_parallel_temp <= not clk_deframing_out_parallel_temp;
				deframing_counter_bits<=deframing_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			elsif(deframing_counter_bits=(word_length_deframing-1))
			then 
				clk_deframing_out_parallel_temp <= not clk_deframing_out_parallel_temp;
				deframing_counter_bits<=0;
				deframing_counter_frames<=deframing_counter_frames+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			else
				deframing_counter_bits<=deframing_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			end if;--(deframing_counter_bits=((word_length_deframing/2)-1))

		else
		  preamble_found <= '0';
			if (deframing_counter_bits=((word_length_deframing/2)-1)) then
				clk_deframing_out_parallel_temp <= not clk_deframing_out_parallel_temp;
				deframing_counter_bits<=deframing_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			elsif(deframing_counter_bits=(word_length_deframing-1))
			then 
				clk_deframing_out_parallel_temp <= not clk_deframing_out_parallel_temp;
				deframing_counter_bits<=0;
				deframing_counter_frames<=0;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);	
			else
				deframing_counter_bits<=deframing_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			end if;--(deframing_counter_bits=((word_length_deframing/2)-1))
		end if; -- (deframing_counter_frames = 0)
	else-- you have not found any preamble and are not sending any frames
		deframing_counter_frames<=0;
		deframing_counter_bits<=0;	
		data_out_tmp <= '0';
	end if;
	
	clk_deframing_out_parallel_temp_buffer1<=clk_deframing_out_parallel_temp;
	clk_deframing_out_parallel_temp_buffer2<=clk_deframing_out_parallel_temp_buffer1;
	clk_deframing_out_parallel_temp_buffer3<=clk_deframing_out_parallel_temp_buffer2;
	
    end if; -- (reset = '0')
  end process seq; 
  
  -- output register can be any of num1 or num2
  data_out_deframing <= data_out_tmp;
  clk_deframing_out_serial<=clk_deframing_in;
  clk_deframing_out_parallel<=clk_deframing_out_parallel_temp_buffer2;
end behavioral;