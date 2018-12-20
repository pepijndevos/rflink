library ieee;  
use ieee.std_logic_1164.ALL;  
use ieee.numeric_std.ALL;

architecture behavioral of receiver is
	signal reset_n : std_logic;

	signal socadc : std_logic_vector(31 downto 0);
	signal encoded_data : std_logic_vector(9 downto 0);

	signal buffer_in : std_logic_vector(7 downto 0);
	signal buffer_out : signed(7 downto 0);
  
	signal data_in_deframing : std_logic;
	signal data_out_deframing : std_logic;
	signal data_out_buffer : std_logic_vector(9 downto 0);
	signal wout1 : std_logic_vector(15 downto 0);
	signal wout2 : std_logic_vector(15 downto 0);
  
	signal sndclk : std_logic;
	signal clk_50_MHz : std_logic;
	signal clk_3_255_MHz : std_logic;
	signal clk_320_kHz : std_logic;
	signal clk_32_kHz : std_logic;  
	
begin
	reset_n <= KEY(0);
	clk_50_MHz <= CLOCK_50;
	data_in_deframing <= GPIO_0(0);

	process(clk_32_kHz)
	begin
		if rising_edge(clk_32_kHz) then
			wout1 <= std_logic_vector(buffer_out) & "00000000";
			wout2 <= std_logic_vector(buffer_out) & "00000000";
		end if;
	end process;

	
	
	
	clock_gen_3_255_MHz_inst : entity work.clk_3_255_MHz
	   port map (
			refclk => clk_50_MHz, -- clk 50MHz
			rst => not reset_n,  -- reset active high
			outclk_0 => clk_3_255_MHz -- 32 kHz clock
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
	
	
	s_2_p_inst : entity work.s_2_p
		generic map (
			word_length_buffer => 10
			)
		port map (
			data_in_buffer => data_out_deframing,
         clk_buffer_parallel => clk_32_kHz,
         clk_buffer_serial => clk_320_kHz,
         reset => reset_n,
         data_out_buffer => data_out_buffer
			); 
	
	deframing_inst : entity work.deframing
		generic map (
			word_length_deframing => 10,
			preamble_receiver => 785,
			deframing_length => 32550
			)
		port map (
			data_in_deframing => data_in_deframing,
			clk_deframing_in => clk_320_kHz,
			reset => reset_n,
			data_out_deframing => data_out_deframing,
			--clk_deframing_out_serial => ,
			clk_deframing_out_parallel => clk_32_kHz
			);	
	
			
		decoder_inst: entity work.decoder_4B5B
		generic map (
			word_length_out_4B5B_decoder => 8
		)
		port map (
			data_in_4B5B_decoder => data_out_buffer,
			clk_4B5B_decoder => clk_32_kHz,
			reset => reset_n, -- active low
			data_out_4B5B_decoder => buffer_in
		);
		
		
	audiobuffer_inst : entity work.audiobuffer
		generic map (
		word_length => word_length
		 )
		port map (
			rst => reset_n,
			clk => clk_32_kHz,
			clk_in => sndclk,
			clk_out => clk_32_kHz,
			data_in => signed(buffer_in),
			data_out => buffer_out-- to gpio
		);

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
	
		
end behavioral;
