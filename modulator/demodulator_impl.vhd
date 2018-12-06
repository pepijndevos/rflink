library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

architecture behavioral of demodulator is
	signal input_avg : signed(9 downto 0);
	signal last_polarity : std_logic;
	signal counter : unsigned(31 downto 0);
	signal counter_avg : unsigned(31 downto 0);
begin

  process(clk, rst)
	  variable polarity : std_logic;
  begin
    if rst = '0' then
	    input_avg <= (others => '0');
	    counter <= (others => '0');
	    counter_avg <= to_unsigned(12, 32);
	    last_polarity <= '0';
    elsif rising_edge(clk) then
	    if input > input_avg then
		    polarity := '1';
	    else
		    polarity := '0';
	    end if;
	    if polarity /= last_polarity then
		    if counter > counter_avg then
			    output <= '1';
		    else
			    output <= '0';
		    end if;
		    --counter_avg <= resize((counter_avg*7 + counter)/8, 32);
		    counter <= (others => '0');
	    else
		    counter <= counter + 1;
	    end if;
	    last_polarity <= polarity;
	    input_avg <= resize((input_avg*127 + input)/128, 10);
    end if;
  end process;

end;
