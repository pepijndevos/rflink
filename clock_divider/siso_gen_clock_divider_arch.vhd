-- audio_interface
-- 
-- This entity implements A/D and D/A capability on the Altera DE2
-- WM8731 Audio Codec. Setup of the codec requires the use of I2C
-- to set parameters located in I2C registers. Setup options can
-- be found in the SCI_REG_ROM and SCI_DAT_ROM. This entity is
-- capable of sampling at 48 kHz with 16 bit samples, one sample
-- for the left channel and one sample for the right channel.
--
-- http://courses.engr.illinois.edu/ECE298/lectures/Sound-Documentation.html
--
--
-- Version 1.0
--
-- Designer: Koushik Roy
-- April 23, 2010
--
-- Changes July 16, 2014
-- 1) unused signal INIT removed
-- 2) non IEEE packages removed (and necessary changes are made)


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ARCHITECTURE Behavorial OF clock_divider IS

signal counter_clk : integer ;
signal clk_low_freq_temp : std_logic;

BEGIN

	seq : process(clk_high_freq, reset)
	begin
		if (reset = '0') 
		then
			counter_clk <= 1; 
			clk_low_freq_temp <= '0';
		elsif(rising_edge(clk_high_freq)) 
		then
			if (counter_clk = clk_div) 
			then
				clk_low_freq_temp <= not clk_low_freq_temp;
				counter_clk <= 1;
			elsif(counter_clk = clk_div/2)
			then
				clk_low_freq_temp <= not clk_low_freq_temp;
				counter_clk <= counter_clk + 1;
			else
				counter_clk <= counter_clk + 1;
			end if; --  (counter_clk = 9) 
		end if; --(reset = '0')
	end process;
			
	clk_low_freq <= clk_low_freq_temp;--clk at 31.25kHz
	
			
end Behavorial;
