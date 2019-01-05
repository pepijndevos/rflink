library ieee;  
use ieee.std_logic_1164.ALL;  
use ieee.numeric_std.ALL;

architecture behavioral of receiver is
	signal reset_n, reset1_n, reset2_n : std_logic;
	signal delay : std_logic;
	signal socadc : std_logic_vector(31 downto 0);
	signal encoded_data : std_logic_vector(9 downto 0);

	signal buffer_in : std_logic_vector(7 downto 0);
	signal buffer_out : signed(7 downto 0);
  
	signal data_in : std_logic;
	signal data_out_deframing : std_logic;
	signal data_out_buffer : std_logic_vector(9 downto 0);
	signal wout1 : std_logic_vector(15 downto 0);
	signal wout2 : std_logic_vector(15 downto 0);
	signal delay_counter_out : std_logic_vector(3 downto 0);
  
	signal sndclk : std_logic;
	signal clk_50_MHz : std_logic;
	signal clk_200_MHz : std_logic;
	signal clk_320_kHz : std_logic;
	signal clk_32_kHz : std_logic;  
	signal preamble_inserted : std_logic;
	signal preamble_found : std_logic;
	signal error_reset : std_logic;
	signal error_reset_multiple : std_logic;
	signal error_reset_period_low : std_logic;
	signal error_reset_period_high : std_logic;
	signal dynamic_enable_led : std_logic;
	signal period_up_btn	: std_logic;
   signal period_down_btn: std_logic;
	signal dynamic_enable_btn: std_logic;
	signal period_out : std_logic_vector(8 downto 0);
	
	
begin
	--reset_n <= KEY_0000000000(0);
	--delay <= KEY_0000000000(1);
	clk_50_MHz <= CLOCK_50;
	data_in <= GPIO_0(0);
	--clk_320_kHz <= GPIO_0(1);
	preamble_inserted <= GPIO_0(2);
	
	GPIO_1(0) <= data_in;
	GPIO_1(1) <= clk_32_kHz;
	GPIO_1(2) <= clk_320_kHz;
	GPIO_1(3) <= preamble_inserted;
	GPIO_1(4) <= preamble_found;
	GPIO_1(5) <= error_reset_multiple;
	GPIO_1(6) <= error_reset_period_low;
	GPIO_1(7) <= error_reset_period_high;

			
	--LEDR(3 downto 0) <= delay_counter_out;
	--LEDR(9) <= reset_n;
	--LEDR(8) <= error_reset;
	--LEDR(7) <= error_reset_multiple;
	--LEDR(6) <= error_reset_period_low;
	--LEDR(5) <= error_reset_period_high;
	reset_n <= (reset1_n or reset2_n);
	process(clk_32_kHz)
	begin
		if rising_edge(clk_32_kHz) then
			wout1 <= std_logic_vector(buffer_out) & "00000000";
			wout2 <= std_logic_vector(buffer_out) & "00000000";
		end if;
	end process;

	multiplexer_inst : entity work.multiplexer
		port map (
			clk => clk_50_MHz, 											-- clk 50MHz
			reset =>  reset_n,  											-- reset active low
			switches => SW,												-- swithces input
			buttons => KEY,												-- buttons input
			leds => LEDR,													-- leds output	
			-- switch combination "00000000000"
			leds_0000000000(9) => reset_n, 							-- leds input 		
			leds_0000000000(8) => error_reset, 						-- leds input 		
			leds_0000000000(7) => error_reset_multiple, 			-- leds input 		
			leds_0000000000(6) => error_reset_period_low, 		-- leds input 		
			leds_0000000000(5) => error_reset_period_high, 		-- leds input 		
			leds_0000000000(4) => open, 								-- leds input 		
			leds_0000000000(3 downto 0) => delay_counter_out, 	-- leds input 			
			buttons_0000000000(3) => open,							-- button 3 output
			buttons_0000000000(2) => open,							-- button 2 output
			buttons_0000000000(1) => delay,							-- button 1 output
			buttons_0000000000(0) => reset1_n,						-- button 0 output
			
			-- switch combination "10000000000"
			leds_1000000000(9) => dynamic_enable_led, 			-- leds input 		
			leds_1000000000(8 downto 0) => period_out,			-- leds input 				
			buttons_1000000000(3) => period_down_btn,				-- button 3 output
			buttons_1000000000(2) => period_up_btn,				-- button 2 output
			buttons_1000000000(1) => dynamic_enable_btn,			-- button 1 output
			buttons_1000000000(0) => reset2_n						-- button 0 output				
	
		);
	
	clock_gen_200_MHz_inst : entity work.clk_200_MHz
		port map (
			refclk => clk_50_MHz, -- clk 50MHz
			rst => not reset_n,  -- reset active high
			outclk_0 => clk_200_MHz -- 32 kHz clock
		);
	
--	clock_divider2_inst : entity work.clock_divider2
--		generic map (
--			clk_div => 10 -- the output clock freq will be clk_high_freq / clk_div
--			)		 
--		port map (
--			clk_high_freq => clk_3_255_MHz, 			-- high freq clock input
--			reset => reset_n,
--			clk_low_freq => clk_320_kHz 				-- low freq clock output
--			);
	
	
	clk_recovery : entity work.clock_recovery
		generic map (
			std_period => 154, -- Fclk/Fsampple
			timeout => 39 -- clocks to wait before sending an out_clk
		)
		port map (
			rst => reset_n,
			clk => clk_50_MHz,
			input => data_in,
			out_clk => clk_320_kHz,
			error_reset => error_reset,
			error_reset_multiple => error_reset_multiple,
			error_reset_period_low => error_reset_period_low,
			error_reset_period_high => error_reset_period_high,
			period_out => period_out,
			dynamic_enable_led => dynamic_enable_led,
		   period_up_btn =>period_up_btn,
			period_down_btn => period_down_btn,
			dynamic_enable_btn => dynamic_enable_btn
		);
	
	deframing_inst : entity work.deframing
		generic map (
			word_length_deframing => 10,
			preamble_receiver => 785,
			deframing_length => 3255
			)
		port map (
			data_in_deframing => data_in,
			clk_deframing_in => clk_320_kHz,
			reset => reset_n,
			data_out_deframing => data_out_deframing,
			--clk_deframing_out_serial => ,
			clk_deframing_out_parallel => clk_32_kHz,
			preamble_found => preamble_found
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
			delay => delay,
			delay_counter_out => delay_counter_out,
			data_out_buffer => data_out_buffer
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
