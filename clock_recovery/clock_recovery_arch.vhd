library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

architecture behavioral of clock_recovery is
	signal period_256 						: unsigned(31 downto 0);
	signal period 								: unsigned(31 downto 0);
	signal last_input 						: std_logic;
	signal counter 								: unsigned(31 downto 0);
	signal counter_timeout				: unsigned(31 downto 0);
	signal multiple 							: unsigned(3 downto 0);
	signal error_multiple_toggle	: std_logic;
	signal error_period_toggle_low		: std_logic;
	signal error_period_toggle_high		: std_logic;
	signal out_clk_tmp						: std_logic;
begin
  period <= resize(period_256/256, period'length);
	error_reset_multiple <= error_multiple_toggle;
	error_reset_period_low <= error_period_toggle_low;
	error_reset_period_high <= error_period_toggle_high;

--  process(clk, rst)
--	  variable polarity : std_logic;
--  begin
--    if rst = '0' then
--	    period_256 <= to_unsigned(std_period*256, period_256'length);
--	    counter <= (others => '0');
--	    multiple <= to_unsigned(1, multiple'length);
--	    last_input <= '0';
--			error_reset <= '0';
--			error_toggle <= '0';
--    elsif rising_edge(clk) then
--	    if input /= last_input then
--		    counter <= (others => '0');
--		    period_256 <= resize((period_256*127 + (counter+1)*256/multiple)/128, period_256'length);
--		    out_clk <= '1';
--		    multiple <= to_unsigned(1, multiple'length);
--	    elsif counter > period*multiple+timeout then
--		    out_clk <= '1';
--		    multiple <= multiple+1;
--		    counter <= counter + 1;
--	    else
--		    out_clk <= '0';
--		    counter <= counter + 1;
--	    end if;
--	    last_input <= input;
--
--			-- reset derived period
--	    if multiple > 10 then
--		    period_256 <= to_unsigned(std_period*256, period_256'length);
--				error_reset <= '1';
--				error_toggle <= not error_toggle;
--	    end if;
--			
--			-- reset when the period is getting too small (0.5 of orignal frequency)
--			if period <= ((std_period*50)/100) then
--				period_256 <= to_unsigned(std_period*256, period_256'length);
--			end if;
--    end if;
--  end process;
  
  process(clk, rst)
	  variable polarity : std_logic;
  begin
    if rst = '0' then
	    period_256 <= to_unsigned(std_period*256, period_256'length);
	    counter <= (others => '0');
	    counter_timeout <= (others => '0');
	    multiple <= to_unsigned(1, multiple'length);
	    last_input <= '0';
			out_clk_tmp <= '0';
      out_clk <= '0';
			error_reset <= '0';
			error_multiple_toggle <= '0';
			error_period_toggle_low <= '0';
			error_period_toggle_high <= '0';
    elsif rising_edge(clk) then
	    if input /= last_input then
				if multiple = 1 then
					period_256 <= resize((period_256*127 + (counter+1)*256/multiple)/128, period_256'length);
				end if;
		    
				counter <= (others => '0');
		    out_clk_tmp <= '1';
        out_clk <= '0';
		    multiple <= to_unsigned(1, multiple'length);
	    elsif counter > period*multiple+timeout then
		    out_clk <= '1';
		    multiple <= multiple+1;
		    counter <= counter + 1;
	    else
			 if (out_clk_tmp = '1') and (counter_timeout <= timeout) then
				counter_timeout <= counter_timeout + 1;
			 elsif (out_clk_tmp = '1') and (counter_timeout > timeout) then
				out_clk_tmp <= '0';
				out_clk <= '1';
				counter_timeout <= (others => '0');
			 else
				out_clk <= '0';
			 end if;
		    counter <= counter + 1;
	    end if;
	    last_input <= input;

			-- reset derived period
	    if multiple > 10 then
		    period_256 <= to_unsigned(std_period*256, period_256'length);
				error_reset <= '1';
				error_multiple_toggle <= not error_multiple_toggle;
	    end if;
			
			if period <= ((std_period*95)/100) then
				error_period_toggle_low <= not error_period_toggle_low;
				period_256 <= to_unsigned(std_period*256, period_256'length);
			end if;
			
			if period >= ((std_period*105)/100) then
				error_period_toggle_high <= not error_period_toggle_high;
				period_256 <= to_unsigned(std_period*256, period_256'length);
			end if;
    end if;
  end process;

end;
