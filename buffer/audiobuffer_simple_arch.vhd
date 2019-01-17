-------------------------------------------------------------------------------
-- File: audiobuffer_simple_arch.vhd
-- Description: An implementation that just uses a flip-flop
-- Author: Pepijn de Vos
-------------------------------------------------------------------------------

architecture simple of audiobuffer is
	 signal data_buf: signed(word_length-1 downto 0);
begin


process(clk)
begin
	if rising_edge(clk) then
		data_buf <= data_in;
		data_out <= data_buf;
	end if;
end process;

end simple;
