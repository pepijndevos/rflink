LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ARCHITECTURE Behavorial OF clock_divider2 IS

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
