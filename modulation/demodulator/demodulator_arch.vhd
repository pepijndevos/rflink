library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

architecture behavioral of demodulator is
   signal input_buf : signed(9 downto 0);
	signal input_avg_256 : signed(31 downto 0);
	signal last_polarity : std_logic;
	signal counter : unsigned(31 downto 0);
	signal counter_avg_256 : unsigned(31 downto 0);
	signal glitch_filter_in : std_logic;
	signal glitch_filter_out : std_logic;
	signal glitch_filter_mem : std_logic;
	
begin

  process(clk, rst)
	  variable polarity : std_logic;
	  variable scalea, scaleb : unsigned(10 downto 0);
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
		    if (counter-1)*220 < counter_avg_256 then
			    glitch_filter_in <= '1';
				 scalea := to_unsigned(254, scalea'length);
				 scaleb := to_unsigned(512, scaleb'length);

		    else
			    glitch_filter_in <= '0';
				 scalea := to_unsigned(255, scalea'length);
				 scaleb := to_unsigned(256, scaleb'length);
		    end if;
		    
		    counter <= (others => '0');
			 counter_avg_256 <= resize((counter_avg_256*scalea + counter*scaleb)/256, 32);
	    else
		    counter <= counter + 1;
	    end if;
	    last_polarity <= polarity;
	    input_avg_256 <= resize((input_avg_256*127 + input_buf*256)/128, 32);
		 input_buf <= input;
		 
		 if (glitch_filter_in = glitch_filter_mem) then
			output <= glitch_filter_out;
		 end if;
		 glitch_filter_mem <= glitch_filter_in;
		 
    end if;
  end process;

end;