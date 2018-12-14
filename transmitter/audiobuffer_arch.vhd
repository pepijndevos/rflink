architecture Behavioral of audiobuffer is
	
	 signal data_buf: out std_logic_vector(word_length-1 downto 0);

	
begin


process(clk)
begin
	if rising_edge(clk) then
		data_buf <= data_in;
		data_out <= data_buf;
	end if;
end process;

end Behavioral;
