architecture simple of audiobuffer is
	 signal data_buf: signed(word_length-1 downto 0);
begin


process(clk)
begin
	if rising_edge(clk_out) then
		data_buf <= data_in;
		data_out <= data_buf;
	end if;
end process;

end simple;
