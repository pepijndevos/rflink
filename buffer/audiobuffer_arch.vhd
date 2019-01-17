-------------------------------------------------------------------------------
-- File: audiobuffer_arch.vhd
-- Description: An interpolation buffer
-- Author: Pepijn de Vos
-------------------------------------------------------------------------------

architecture interpolate of audiobuffer is
	 signal data_buf_start: signed(word_length-1 downto 0);
	 signal data_buf_end: signed(word_length-1 downto 0);
	 signal last_clk_in: std_logic;
	 signal last_clk_out: std_logic;
	 signal counter: signed(31 downto 0);
	 signal in_period: signed(31 downto 0);
begin


process(clk)
	variable diff: signed(word_length downto 0);
begin
	if rst = '0' then
		data_buf_start <= (others => '0');
		data_buf_end <= (others => '0');
		last_clk_in <= '0';
		last_clk_out <= '0';
		counter <= (others => '0');
		in_period <= (others => '0');
	elsif rising_edge(clk) then
		if last_clk_out = '0' and clk_out = '1' then
			diff := resize(data_buf_end, word_length+1) - resize(data_buf_start, word_length+1);
			data_out <= resize(data_buf_start + diff * counter / in_period, data_out'length);
		end if;
		if last_clk_in = '0' and clk_in = '1' then
			data_buf_end <= data_in;
			data_buf_start <= data_buf_end;
			in_period <= counter;
			counter <= (others => '0');
		else
			counter <= counter + 1;
		end if;
		last_clk_in <= clk_in;
		last_clk_out <= clk_out;
	end if;
end process;

end interpolate;
