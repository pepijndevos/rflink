-------------------------------------------------------------------------------
-- File: deframing_v2_arch.vhd
-- Description: Detects a preamble byte, to synchronise the bit stream for decoding
--              simplified implementation
-- Author: Big Boss Bakker
-------------------------------------------------------------------------------




-- this architecture needs arithmetic functions
library ieee;
use ieee.numeric_std.all;

architecture behavioral_v2 of deframing is
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
			data_in_temp_buffer_10_newest_of_20 <= (others => '0');
			data_in_temp_buffer_20_newest_of_20 <= (others => '0');
    elsif rising_edge(clk_deframing_in) then
	data_in_temp_buffer_10_newest_of_20 <= data_in_deframing&data_in_temp_buffer_10_newest_of_20(word_length_deframing-1 downto 1);
	data_in_temp_buffer_20_newest_of_20 <= data_in_temp_buffer_10_newest_of_20(0)&data_in_temp_buffer_20_newest_of_20(word_length_deframing-1 downto 1);
	if(((data_in_deframing&data_in_temp_buffer_10_newest_of_20(word_length_deframing-1 downto 1) = std_logic_vector(to_unsigned(preamble_receiver,word_length_deframing))) and (deframing_counter_frames = 0) and (deframing_counter_bits = 0)) or ((deframing_counter_frames > 0) or (deframing_counter_bits > 0)))
	then -- the preamble was found and you are currently not sending anything or you are sending frames
		if((deframing_counter_frames = 0)or ((deframing_counter_bits=0) and (deframing_counter_frames=1)))
		then
			if (deframing_counter_bits=(word_length_deframing-1)) then
				clk_deframing_out_parallel_temp <= '1';
				deframing_counter_bits<=0;
				deframing_counter_frames<=deframing_counter_frames+1;
				data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);
			else
				deframing_counter_bits<=deframing_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_20_newest_of_20(0);
				clk_deframing_out_parallel_temp <= '0';
				preamble_found <= '1';
			end if;--(deframing_counter_bits=((word_length_deframing/2)-1))
		elsif(deframing_counter_frames <= deframing_length-1) then
			if(deframing_counter_bits=(word_length_deframing-1)) then
				clk_deframing_out_parallel_temp <= '1';
				deframing_counter_bits<=0;
				deframing_counter_frames<=deframing_counter_frames+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			else
				clk_deframing_out_parallel_temp <=  '0';
				deframing_counter_bits<=deframing_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			end if;--(deframing_counter_bits=((word_length_deframing/2)-1))

		else
		  preamble_found <= '0';
			if (deframing_counter_bits=(word_length_deframing-1)) then
				clk_deframing_out_parallel_temp <= '1';
				deframing_counter_bits<=0;
				deframing_counter_frames<=0;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			else
				clk_deframing_out_parallel_temp <= '0';
				deframing_counter_bits<=deframing_counter_bits+1;
				data_out_tmp <=data_in_temp_buffer_10_newest_of_20(0);
			end if;--(deframing_counter_bits=((word_length_deframing/2)-1))
		end if; -- (deframing_counter_frames = 0)
	else-- you have not found any preamble and are not sending any frames
		deframing_counter_frames<=0;
		deframing_counter_bits<=0;
		data_out_tmp <= '0';
	end if;

    end if; -- (reset = '0')
  end process seq;

  -- output register can be any of num1 or num2
  data_out_deframing <= data_out_tmp;
  clk_deframing_out_serial<=clk_deframing_in;
  clk_deframing_out_parallel<=clk_deframing_out_parallel_temp;
end behavioral_v2;
