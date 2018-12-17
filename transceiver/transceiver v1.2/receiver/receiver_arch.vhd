library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

architecture Behavioral of receiver is
	
  signal rst : std_logic;
	

  signal socadc : std_logic_vector(31 downto 0);
  signal win1 : signed(15 downto 0);
  signal win2 : signed(15 downto 0);
  signal encoded_data : std_logic_vector(9 downto 0);

  signal buffer_in : std_logic_vector(7 downto 0);
  signal buffer_out : signed(7 downto 0);

  signal from_decoder : std_logic_vector(7 downto 0);
  signal wout1 : std_logic_vector(15 downto 0);
  signal wout2 : std_logic_vector(15 downto 0);
  
  signal sndclk : std_logic;
  signal clk : std_logic;
  signal clk_3_2_MHz : std_logic;
  signal clk_32_kHz : std_logic;  
	
begin


win1 <= signed(socadc(31 downto 16));
win2 <= signed(socadc(15 downto 0));
rst <= KEY(0);
clk <= CLOCK_50;

process(sndclk)
begin
	if rising_edge(sndclk) then
		wout1 <= std_logic_vector(buffer_out) & "00000000";
		wout2 <= std_logic_vector(buffer_out) & "00000000";
	end if;
end process;



	audio_inst : entity work.audio_interface
		port map (
			LDATA => (wout1),
			RDATA => (wout2),
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
	clock_gen_3_2_MHz_inst : entity work.clock_gen_3_2_MHz
	   port map (
	   refclk => clk, -- clk 50MHz
	   rst => not rst,  -- reset active low
	   outclk_0 => clk_3_2_MHz -- 32 kHz clock
	   );
	
	clock_divider_inst : entity work.clock_divider
		generic map (
		clk_div => clk_div -- the output clock freq will be clk_high_freq / clk_div
		)		 
		port map (
		clk_high_freq => clk_3_2_MHz, -- high freq clock input
      reset => rst,
      clk_low_freq => clk_32_kHz -- low freq clock output
		);
	
	audiobuffer_inst : entity work.audiobuffer
		generic map (
		word_length => word_length
		 )
		port map (
			rst => rst,
			clk => clk,
			clk_in => sndclk,
			clk_out => clk_32_khz,
			data_in => signed(GPIO_0(7 downto 0)),
			data_out => buffer_out-- to gpio
			);
	
end Behavioral;