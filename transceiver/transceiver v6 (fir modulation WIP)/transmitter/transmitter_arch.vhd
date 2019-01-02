library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;
use work.data_types.all;


architecture structure of transmitter is
	signal reset_n : std_logic;

	-- audio codec
	signal socadc : std_logic_vector(31 downto 0);
	signal win1 : signed(15 downto 0);
	signal win2 : signed(15 downto 0);
	signal wout1 : std_logic_vector(15 downto 0);
	signal wout2 : std_logic_vector(15 downto 0);
    
	-- encoder
	signal encoded_data : std_logic_vector(9 downto 0);
	signal encoder_out : std_logic_vector(9 downto 0);

	-- buffer
	signal buffer_in : std_logic_vector(7 downto 0);
	signal buffer_out : signed(7 downto 0);

	-- clock
	signal sndclk : std_logic;
	signal clk_50_MHz : std_logic;
	signal clk_3_255_MHz : std_logic;
	signal clk_320_kHz : std_logic;
	signal clk_32_kHz : std_logic; 
	signal clk_40_MHz : std_logic; 
	signal clk_20_MHz : std_logic; 
  
	-- parallel to serial
	signal data_in_unbuffer : std_logic_vector(9 downto 0);
	signal data_out_unbuffer : std_logic;
  
	-- fir
	signal pulse : unsigned(7 downto 0) := "00000000";
	signal fir_enable : std_logic;
	signal fir_led : std_logic;

	-- modulation
	signal sine : signed(9 downto 0);

	-- debug signals
	signal frame_ins : std_logic;
  
begin
	win1 <= signed(socadc(31 downto 16));
	win2 <= signed(socadc(15 downto 0));
	reset_n <= KEY(0);
	fir_enable <= KEY(1);
	clk_50_MHz <= CLOCK_50;

	GPIO_0(9 downto 0) <= std_logic_vector(sine);
	GPIO_0(10) <= clk_320_kHz;
	GPIO_0(11) <= frame_ins;
	LEDR(0) <= fir_led;
	LEDR(9) <= reset_n;
	
	audio_inst : entity work.audio_interface
		port map (
			LDATA => (wout1),
			RDATA => (wout2),
			clk => clk_50_MHz,
			Reset	=> reset_n,
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
		
		
	clock_3_255_MHz_40_MHz_inst : entity work.clk_3_40_MHz
		port map (
			refclk => clk_50_MHz, -- clk 50MHz
			rst => not reset_n,  -- reset active low
			outclk_0 => clk_3_255_MHz, -- 3.255 MHz clock
			outclk_1 => clk_40_MHz -- 40 MHz clock
		);
	
	clock_divider_inst : entity work.clock_divider
		generic map (
			clk_div => 100 -- the output clock freq will be clk_high_freq / clk_div
		)		 
		port map (
			clk_high_freq => clk_3_255_MHz, 			-- high freq clock input
			reset => reset_n,
			clk_low_freq => clk_32_kHz 				-- low freq clock output
		);
	
	clock_divider2_inst : entity work.clock_divider2
		generic map (
			clk_div => 10 -- the output clock freq will be clk_high_freq / clk_div
		)		 
		port map (
			clk_high_freq => clk_3_255_MHz, 			-- high freq clock input
			reset => reset_n,
			clk_low_freq => clk_320_kHz 				-- low freq clock output
		);
	
	
	clock_divider3_inst : entity work.clock_divider3
		generic map (
			clk_div => 2 -- the output clock freq will be clk_high_freq / clk_div
		)		 
		port map (
			clk_high_freq => clk_40_MHz, 			-- high freq clock input
			reset => reset_n,
			clk_low_freq => clk_20_MHz 				-- low freq clock output
		);	
	
	audiobuffer_inst : entity work.audiobuffer
		generic map (
			word_length => word_length
		)
		port map (
			rst => reset_n,
			clk => clk_32_kHz,
			clk_in => sndclk, -- relevant for complex audiobuffer
			clk_out => clk_32_kHz, -- relevant for complex audiobuffer
			data_in => signed(socadc(31 downto 24)),
			data_out => buffer_out
		);
	
	
	encoder_inst : entity work.encoder_4B5B
		port map (
			data_in_4B5B_encoder => std_logic_vector(buffer_out),
			clk_4B5B_encoder => clk_32_kHz,
			reset => reset_n,
			data_out_4B5B_encoder => encoder_out		
		);
	
		
	framing_inst : entity work.framing
		generic map (
			word_length_framing => 10,
			preamble_transmitter => 785,
			framing_length => 32550
		)
	
		port map (
			data_in_framing => encoder_out,
			clk_framing => clk_32_kHz,
			reset => reset_n,
			frame_ins => frame_ins,
			data_out_framing => data_in_unbuffer
		);	
	
	
	p_2_s_inst : entity work.p_2_s
		generic map (
			word_length_unbuffer => 10
		)
		port map (
			data_in_unbuffer => data_in_unbuffer,
         clk_unbuffer_parallel => clk_32_kHz,
         clk_unbuffer_serial => clk_320_kHz,
         reset => reset_n,
         data_out_unbuffer => data_out_unbuffer
		); 
	
		
	fir_inst: entity work.fir(behavioral) 
		generic map (
			coef_scale => 4,				
			w_acc => 16,
			w_out => pulse'length,
			coef => (262, 498, 262)
		)
		port map (
			reset_n => reset_n,									-- Active low reset
			clk => clk_50_MHz, 									-- logic clock that drives the fir logic
			sndclk => clk_3_255_MHz, 						-- oversampled pulse clock, 10 times bit clock
			word => data_out_unbuffer,					-- data in
			btn => fir_enable,									-- button to enable or disable fir filter
			fir_led => fir_led,									-- debug output led
			resp => pulse												-- data out
		);
 
	mod_inst: entity work.modulator(behavioral)
		generic map (
			Fclk => 20000000,										-- 20 MHz reference clock (see clk input)
			Fhi => 2500000,											-- Low frequency
			Flo => 1250000											-- high frequency
		)
		port map (
			rst => reset_n,											-- Active low reset
			clk => clk_20_MHz, 									-- 20 MHz
			input => pulse,											-- data in
			output => sine											-- data out
		);
		
end structure;
