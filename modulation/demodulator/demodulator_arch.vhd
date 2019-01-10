library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

architecture behavioral of demodulator is
   signal input_buf : signed(9 downto 0);
	signal input_avg_256 : signed(31 downto 0);
	signal last_polarity : std_logic;
	signal counter : unsigned(31 downto 0);
	signal counter_avg_256 : unsigned(31 downto 0);
begin

  process(clk, rst)
	  variable polarity : std_logic;
  begin
    if rst = '0' then
	    input_avg_256 <= (others => '0');
	    counter <= to_unsigned(1024, counter'length);
	    counter_avg_256 <= (others => '0');
	    last_polarity <= '0';
    elsif rising_edge(clk) then
	    if input_buf*256 > input_avg_256 then
		    polarity := '1';
	    else
		    polarity := '0';
	    end if;
			
	    if polarity /= last_polarity and counter > min_bounce then
		    if (counter-1)*256 < counter_avg_256 then
			    output <= '1';
				 counter_avg_256 <= resize((counter_avg_256*127 + counter*256)/128, 32);

		    else
			    output <= '0';
				 counter_avg_256 <= resize((counter_avg_256*255 + counter*256)/256, 32);

		    end if;
		    
		    counter <= (others => '0');
	    else
		    counter <= counter + 1;
	    end if;
	    last_polarity <= polarity;
	    input_avg_256 <= resize((input_avg_256*127 + input_buf*256)/128, 32);
		 input_buf <= input;
    end if;
  end process;

end;