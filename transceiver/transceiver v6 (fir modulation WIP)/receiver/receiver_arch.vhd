library ieee;  
use ieee.std_logic_1164.ALL;  
use ieee.numeric_std.ALL;

architecture behavioral of receiver is
	signal reset_n : std_logic;

	-- adc interface
	
	
	-- demodulation
	signal data_in : std_logic_vector(9 downto 0);
	
	
	-- clock recovery
	signal binary : std_logic;
	
	-- deframing
	signal data_out_deframing : std_logic;

	-- serial to parallel
	signal delay_counter_out : std_logic_vector(3 downto 0);
	signal delay : std_logic;
	signal data_out_buffer : std_logic_vector(9 downto 0);

	-- decoding
	signal encoded_data : std_logic_vector(9 downto 0);

	-- buffer
	signal buffer_in : std_logic_vector(7 downto 0);
	signal buffer_out : signed(7 downto 0);

	
	-- audio codec
	signal wout1 : std_logic_vector(15 downto 0);
	signal wout2 : std_logic_vector(15 downto 0);
	signal socadc : std_logic_vector(31 downto 0);

	-- clock signals
	signal sndclk : std_logic;
	signal clk_200_MHz : std_logic;
	signal clk_50_MHz : std_logic;
	signal clk_20_MHz : std_logic;
	signal clk_320_kHz : std_logic;
	signal clk_32_kHz : std_logic;

	-- debug signals
	signal preamble_inserted : std_logic;
	signal preamble_found : std_logic;
	signal error_reset : std_logic;
	signal error_reset_toggle : std_logic;
	
begin
	reset_n <= KEY(0);
	delay <= KEY(1);
	clk_50_MHz <= CLOCK_50;
	data_in <= GPIO_0(9 downto 0);
	--clk_320_kHz <= GPIO_0(1);
	--preamble_inserted <= GPIO_0(2);
	
	--GPIO_1(0) <= data_in;
	GPIO_1(1) <= clk_32_kHz;
	GPIO_1(2) <= clk_320_kHz;
	GPIO_1(3) <= preamble_inserted;
	GPIO_1(4) <= preamble_found;
	GPIO_1(5) <= error_reset_toggle;

	LEDR(3 downto 0) <= delay_counter_out;
	LEDR(9) <= error_reset;

	--	 I think this does not have to be done in a seperate process like this because buffer out already works on 32.55kHz
	process(clk_32_kHz)
	begin
		if rising_edge(clk_32_kHz) then
			wout1 <= std_logic_vector(buffer_out) & "00000000";
			wout2 <= std_logic_vector(buffer_out) & "00000000";
		end if;
	end process;
	
	
	-- Instantiate the PLL 200MHz clock 
	clock_gen_200_MHz_inst : entity work.clk_200_MHz
		port map (
			refclk => clk_50_MHz, 							-- clk 50MHz
			rst => not reset_n,  							-- reset active high
			outclk_0 => clk_200_MHz 						-- 32 kHz clock
		);
		
	
	-- Instantiate the clock divider
	clock_divider_inst : entity work.clock_divider
		generic map (
			clk_div => 10 -- the output clock freq will be clk_high_freq / clk_div
		)		 
		port map (
			clk_high_freq => clk_200_MHz, 				-- high freq clock input
			reset => reset_n,									-- active low reset
			clk_low_freq => clk_20_MHz 					-- low freq clock output
		);
			
			
	-- Instantiate the demodulator	
	demodulation_inst: entity work.demodulator(behavioral)
	   generic map (
			Fclk => 20000000,								-- inpupt clock frequency
			Fhi => 2500000,								-- high input frequency
			Flo => 1250000,								-- low input frequency
			min_bounce => 4								-- minimum bounce?
		)
		port map (
			rst => reset_n,									-- active low reset
			clk => clk_20_MHz,								-- clock 20MHz
			input => signed(data_in),						-- signed data in 10 bits
			output => binary									-- binary output
		);
		
	
	-- Instantiate the clock recovery
	clk_recovery : entity work.clock_recovery
		generic map (
			std_period => 614, -- Fclk/Fsampple
			timeout => 200 -- clocks to wait before sending an out_clk
		)
		port map (
			rst => reset_n,									-- active low reset
			clk => clk_200_MHz,								-- input clock higher is better
			input => binary,									-- binary input stream
			out_clk => clk_320_kHz,							-- 320kHz clock for each bit output
			error_reset => error_reset,					-- the clock had to be reset
			error_reset_toggle => error_reset_toggle	-- each time the clock is reset
		);
		
		
	-- Instantiate the deframer	
	deframing_inst : entity work.deframing
		generic map (
			word_length_deframing => 10,
			preamble_receiver => 785,
			deframing_length => 32550
		)
		port map (
			data_in_deframing => binary,					-- binary input data stream			
			clk_deframing_in => clk_320_kHz,				-- 320kHz clock input
			reset => reset_n,									-- active low reset
			data_out_deframing => data_out_deframing,	-- binary output data stream
			--clk_deframing_out_serial => ,				-- 320kHz clock output not needed
			clk_deframing_out_parallel => clk_32_kHz,	-- output clock 32kHz
			preamble_found => preamble_found				-- debug signal high if preamble is found
		);	
	
	
	-- Instantiate the serial to parallel
	s_2_p_inst : entity work.s_2_p
		generic map (
			word_length_buffer => 10
		)
		port map (
			data_in_buffer => data_out_deframing,		-- serial input data stream
			clk_buffer_parallel => clk_32_kHz,			-- 32kHz clock input
			clk_buffer_serial => clk_320_kHz,			-- 320kHz clock input
			reset => reset_n,									-- active low reset
			delay => delay,									-- delay button input
			delay_counter_out => delay_counter_out,	-- delay counter output integer
			data_out_buffer => data_out_buffer			-- data out 10 bit parallel
		); 
		
		
	-- Instantiate the decoder
	decoder_inst: entity work.decoder_4B5B
		generic map (
			word_length_out_4B5B_decoder => 8
		)
		port map (
			data_in_4B5B_decoder => data_out_buffer,	-- data in decoder
			clk_4B5B_decoder => clk_32_kHz,				-- 32kHz clock input
			reset => reset_n,									-- active low reset
			data_out_4B5B_decoder => buffer_in			-- data out decoder
		);
		
		
	-- Instantiate the audio buffer	
	audiobuffer_inst : entity work.audiobuffer
		generic map (
			word_length => word_length
		 )
		port map (
			rst => reset_n,									-- active low reset
			clk => clk_32_kHz,								-- 32kHz clock input
			clk_in => sndclk,									-- used for fancy buffer
			clk_out => clk_32_kHz,							-- used for fancy buffer
			data_in => signed(buffer_in),					-- data in 
			data_out => buffer_out							-- data out		
		);
		
		
	-- Instantiate the audio codec
	audio_inst : entity work.audio_interface
		port map (
			LDATA => (wout1),
			RDATA => (wout2),
			clk => clk_50_MHz,
			Reset	=> reset_n,								-- active low reset
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
