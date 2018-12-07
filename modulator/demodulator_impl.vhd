library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

architecture behavioral of demodulator is
	signal input_avg_256 : signed(15 downto 0);
	signal last_polarity : std_logic;
	signal counter : unsigned(31 downto 0);
	signal counter_avg_256 : unsigned(31 downto 0);
begin

  process(clk, rst)
	  variable polarity : std_logic;
  begin
    if rst = '0' then
	    input_avg_256 <= (others => '0');
	    counter <= (others => '0');
	    counter_avg_256 <= (others => '0');
	    last_polarity <= '0';
    elsif rising_edge(clk) then
	    if input > input_avg_256/256 then
		    polarity := '1';
	    else
		    polarity := '0';
	    end if;
	    if polarity /= last_polarity then
		    if counter > counter_avg_256/256 then
			    output <= '1';
		    else
			    output <= '0';
		    end if;
		    counter_avg_256 <= resize((counter_avg_256*15 + counter*256)/16, 32);
		    counter <= (others => '0');
	    else
		    counter <= counter + 1;
	    end if;
	    last_polarity <= polarity;
	    input_avg_256 <= resize((input_avg_256*127 + input*256)/128, 16);
    end if;
  end process;

end;
