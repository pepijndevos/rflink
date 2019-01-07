library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

architecture behavioral of clock_recovery is
	signal period_256 						: unsigned(31 downto 0);
	signal period 								: unsigned(31 downto 0);
		signal counter_period					: integer;

	signal input_buf 						: std_logic;
	signal last_input 						: std_logic;
	signal counter 								: unsigned(15 downto 0);
	signal counter_timeout				: unsigned(15 downto 0);
	signal on_timer				: unsigned(15 downto 0);
	signal multiple 							: unsigned(3 downto 0);
	signal error_multiple_toggle	: std_logic;
	signal error_period_toggle_low		: std_logic;
	signal error_period_toggle_high		: std_logic;
	signal out_clk_tmp						: std_logic;
	signal dynamic_enable					: std_logic;	
FUNCTION hex2display (n:std_logic_vector(3 DOWNTO 0)) RETURN std_logic_vector IS
    VARIABLE res : std_logic_vector(6 DOWNTO 0);
  BEGIN
    CASE n IS          --        gfedcba; low active
	    WHEN "0000" => RETURN NOT "0111111";
	    WHEN "0001" => RETURN NOT "0000110";
	    WHEN "0010" => RETURN NOT "1011011";
	    WHEN "0011" => RETURN NOT "1001111";
	    WHEN "0100" => RETURN NOT "1100110";
	    WHEN "0101" => RETURN NOT "1101101";
	    WHEN "0110" => RETURN NOT "1111101";
	    WHEN "0111" => RETURN NOT "0000111";
	    WHEN "1000" => RETURN NOT "1111111";
	    WHEN "1001" => RETURN NOT "1101111";
	    WHEN "1010" => RETURN NOT "1110111";
	    WHEN "1011" => RETURN NOT "1111100";
	    WHEN "1100" => RETURN NOT "0111001";
	    WHEN "1101" => RETURN NOT "1011110";
	    WHEN "1110" => RETURN NOT "1111001";
	    WHEN OTHERS => RETURN NOT "1110001";			
    END CASE;
  END hex2display;
	
	
begin

	
  comb_proc : process(period_256)
  begin
		period <= resize(period_256/256, period'length);	
		HEX0 <= hex2display(std_logic_vector(period(3 downto 0)));
		HEX1 <= hex2display(std_logic_vector(period(7 downto 4)));
		HEX2 <= hex2display(std_logic_vector(period(11 downto 8)));
		HEX3 <= hex2display(std_logic_vector(period(15 downto 12)));
		HEX4 <= hex2display(std_logic_vector(period(19 downto 16)));
		HEX5 <= hex2display(std_logic_vector(period(23 downto 20)));
  end process comb_proc;


  process(clk, rst)
	  variable polarity : std_logic;
  begin
    if rst = '0' then
	    period_256 <= to_unsigned(std_period*256, period_256'length);
	    counter <= (others => '0');
	    counter_timeout <= (others => '0');
	    on_timer <= (others => '0');
	    multiple <= to_unsigned(1, multiple'length);
	    last_input <= '0';
		 out_clk_tmp <= '0';
       out_clk <= '0';
    elsif rising_edge(clk) then
	    input_buf <= input;
	    if input_buf /= last_input then
			 if multiple = 1 then
			   period_256 <= resize((period_256*127 + (counter+1)*256)/128, period_256'length);
			 end if;
		    
			 counter <= (others => '0');
		    out_clk_tmp <= '1';
		    multiple <= to_unsigned(1, multiple'length);
			 counter_timeout <= (others => '0');

		 else
			counter <= counter + 1;
	    end if;
		 last_input <= input_buf;


		 
		 if counter > period*multiple+timeout then
		   out_clk <= '1';
		   multiple <= multiple+1;
			on_timer <= (others => '0');
	    elsif (out_clk_tmp = '1') and (counter_timeout <= timeout) then
			counter_timeout <= counter_timeout + 1;
	    elsif (out_clk_tmp = '1') and (counter_timeout > timeout) then
			out_clk_tmp <= '0';
			out_clk <= '1';
			counter_timeout <= (others => '0');
			on_timer <= (others => '0');
		 elsif on_timer > period/2 then
			out_clk <= '0';
		 else
			on_timer <= on_timer + 1;
	    end if;

			-- reset derived period
--	    if multiple > 10 then
--		    period_256 <= to_unsigned(std_period*256, period_256'length);
--	    end if;
--			
--			if period <= ((std_period*95)/100) then
--				period_256 <= to_unsigned(std_period*256, period_256'length);
--			end if;
--			
--			if period >= ((std_period*105)/100) then
--				period_256 <= to_unsigned(std_period*256, period_256'length);
--			end if;
    end if;
  end process;

end;
