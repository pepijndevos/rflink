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
entity clk_3_125MHz is
  port(outclk_0      : in std_logic;
		 reset 			: in std_logic;
		 clk_31_25kHz  : out std_logic
	   );
end clk_3_125MHz;


ARCHITECTURE Behavorial OF clk_3_125MHz IS

signal counter_clk : integer range 0 to 9;
signal clk_31_25kHz_temp : std_logic;

BEGIN

	seq : process(outclk_0, reset)
	begin
		if (reset = '0') 
		then
			counter_clk <= 0; 
			clk_31_25kHz_temp <= '0';
		elsif(rising_edge(outclk_0)) 
		then
			if (counter_clk = 9) 
			then
				clk_31_25kHz_temp <= not clk_31_25kHz_temp;
				counter_clk <= 0;
			elsif(counter_clk = 4)
			then
				clk_31_25kHz_temp <= not clk_31_25kHz_temp;
				counter_clk <= counter_clk + 1;
			else
				counter_clk <= counter_clk + 1;
			end if; --  (counter_clk = 9) 
		end if; --(reset = '0')
	end process;
			
	clk_31_25kHz <= clk_31_25kHz_temp;--clk at 31.25kHz
	
end Behavorial;
