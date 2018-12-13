architecture Behavioral of codec is

	COMPONENT audio_codec_clk
	PORT
	   (
		   refclk		:	 IN STD_LOGIC;
		   rst		:	 IN STD_LOGIC;
		   outclk_0		:	 OUT STD_LOGIC;
		   locked		:	 OUT STD_LOGIC
	   );
   END COMPONENT;

   COMPONENT clk_3_125MHz
	   PORT
 	   (
 		   outclk_0		:	 IN STD_LOGIC;
 		   reset		:	 IN STD_LOGIC;
 		   clk_31_25kHz		:	 OUT STD_LOGIC
 	   );
   END COMPONENT;
	
   signal rst : std_logic;
   signal socadc : std_logic_vector(31 downto 0);
   signal win1 : signed(15 downto 0);
   signal win2 : signed(15 downto 0);   
   signal wout1 : signed(15 downto 0);
   signal wout2 : signed(15 downto 0);
   signal sndclk : std_logic;
   signal clk : std_logic;
	signal outclk_0 : std_logic;
	signal clk_31_25kHz : std_logic;
	
begin


   win1 <= signed(socadc(31 downto 16));
   win2 <= signed(socadc(15 downto 0));
   rst <= KEY(0);
   clk <= CLOCK_50;
   GPIO_0(0) <= sndclk;
   GPIO_0(1) <= outclk_0; --AUD_BCLK;
   GPIO_0(2) <= clk_31_25kHz; --AUD_ADCLRCK;
   GPIO_0(3) <= clk_31_25kHz; --AUD_DACLRCK;
   AUD_BCLK <= outclk_0;
   AUD_ADCLRCK <= clk_31_25kHz;
   AUD_DACLRCK <= clk_31_25kHz;
	
	
	
	gen_clk_3_125_MHz : audio_codec_clk	
	   port map (
		   refclk => clk,
		   rst => rst,
		   outclk_0 =>outclk_0	
		);	
		
	gen_clk_31_25_kHz : clk_3_125MHz	
	   port map (
		   outclk_0 => outclk_0,
 		   reset => rst,
 		   clk_31_25kHz => clk_31_25kHz	
		
		);

	audio_inst : entity work.audio_interface
		port map (
			LDATA => std_logic_vector(wout1),
			RDATA => std_logic_vector(wout2),
			clk => clk,
			Reset	=> rst,
			INIT_FINISH	=> open,
			adc_full	=> open,
			AUD_MCLK => AUD_XCK,
			AUD_ADCLRCK => clk_31_25kHz,
			AUD_ADCDAT => AUD_ADCDAT,
			AUD_BCLK => outclk_0,
			data_over => sndclk,
			AUD_DACDAT => AUD_DACDAT,
			AUD_DACLRCK => clk_31_25kHz,
			I2C_SDAT => FPGA_I2C_SDAT,
			I2C_SCLK => FPGA_I2C_SCLK,
			ADCDATA => socadc
		);
		

process(sndclk)
begin
	if rising_edge(sndclk) then
		LEDR <= std_logic_vector(win1(15 downto 6));
		wout1 <= win1(15 downto 8) & "00000000";
		wout2 <= win1(15 downto 8) & "00000000";
	end if;
end process;
				

end Behavioral;
