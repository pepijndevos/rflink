architecture Behavioral of codec is

	
  signal rst : std_logic;
	

  signal socadc : std_logic_vector(31 downto 0);
  signal win1 : signed(15 downto 0);
  signal win2 : signed(15 downto 0);   
  
  signal wout1 : signed(15 downto 0);
  signal wout2 : signed(15 downto 0);
  
  signal sndclk : std_logic;

  signal clk : std_logic;
	
begin


win1 <= signed(socadc(31 downto 16));
win2 <= signed(socadc(15 downto 0));
rst <= KEY(0);
clk <= CLOCK_50;
GPIO_0(0) <= sndclk;
GPIO_0(1) <= AUD_BCLK;
GPIO_0(2) <= AUD_ADCLRCK;
GPIO_0(3) <= AUD_DACLRCK;

process(sndclk)
begin
	if rising_edge(sndclk) then
		LEDR <= std_logic_vector(win1(15 downto 6));
		wout1 <= win1(15 downto 8) & "00000000";
		wout2 <= win1(15 downto 8) & "00000000";
	end if;
end process;


	audio_inst : entity work.audio_interface
		port map (
			LDATA => std_logic_vector(wout1),
			RDATA => std_logic_vector(wout2),
			clk => clk,
			Reset	=> rst,
			INIT_FINISH	=> open,
			adc_full	=> open,
			AUD_MCLK => AUD_XCK,
			AUD_ADCLRCK => AUD_ADCLRCK,
			AUD_ADCDAT => AUD_ADCDAT,
			AUD_BCLK => AUD_BCLK,
			data_over => sndclk,
			AUD_DACDAT => AUD_DACDAT,
			AUD_DACLRCK => AUD_DACLRCK,
			I2C_SDAT => FPGA_I2C_SDAT,
			I2C_SCLK => FPGA_I2C_SCLK,
			ADCDATA => socadc
		);
	
				

end Behavioral;
