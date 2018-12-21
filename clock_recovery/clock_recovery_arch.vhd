library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

architecture behavioral of clock_recovery is
	signal period_256 	: unsigned(31 downto 0);
	signal period 			: unsigned(31 downto 0);
	signal last_input 	: std_logic;
	signal counter 			: unsigned(31 downto 0);
	signal multiple 		: unsigned(3 downto 0);
	signal error_rst		: std_logic;
begin
  period <= resize(period_256/256, period'length);
	error_reset_toggle <= error_rst;

  process(clk, rst)
	  variable polarity : std_logic;
  begin
    if rst = '0' then
	    period_256 <= to_unsigned(std_period*256, period_256'length);
	    counter <= (others => '0');
	    multiple <= to_unsigned(1, multiple'length);
	    last_input <= '0';
			error_reset <= '0';
			error_rst <= '0';
    elsif rising_edge(clk) then
	    if input /= last_input then
		    counter <= (others => '0');
		    period_256 <= resize((period_256*127 + (counter+1)*256/multiple)/128, period_256'length);
		    out_clk <= '1';
		    multiple <= to_unsigned(1, multiple'length);
	    elsif counter > period*multiple+timeout then
		    out_clk <= '1';
		    multiple <= multiple+1;
		    counter <= counter + 1;
	    else
		    out_clk <= '0';
		    counter <= counter + 1;
	    end if;
	    last_input <= input;

			-- reset derived period
	    if multiple > 10 then
		    period_256 <= to_unsigned(std_period*256, period_256'length);
				error_reset <= '1';
				error_rst <= not error_rst;
	    end if;
			
			if period <= ((std_period*50)/100) then
				period_256 <= to_unsigned(std_period*256, period_256'length);
			end if;
    end if;
  end process;

end;
