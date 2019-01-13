library ieee;  
use ieee.std_logic_1164.ALL;  
use ieee.numeric_std.ALL;

architecture behavioral of receiver is
	-- reset
	signal reset_n : std_logic;
	
	-- adc interface
	signal ready_out : std_logic;
	signal data_in : unsigned(adc_resolution-1 downto 0); 
	signal data_out : signed(adc_resolution-1 downto 0); 
	
	-- demodulation
	signal binary : std_logic;
	signal binary_ext : std_logic;
	signal binary_int : std_logic;
	signal binary_rec : std_logic;
	
	-- clock recovery
	-- empty because this has a clock output
	
	-- deframing
	signal data_in_deframing : std_logic;
	signal data_out_deframing : std_logic;
	
	-- serial to parallel
	signal delay : std_logic;
	signal data_out_buffer : std_logic_vector(9 downto 0);
	signal delay_counter_out : std_logic_vector(3 downto 0);

	-- decoding 
	signal encoded_data : std_logic_vector(9 downto 0);

	-- buffer
	signal buffer_in : std_logic_vector(7 downto 0);
	signal buffer_out : signed(7 downto 0);

	-- audio codec
	signal socadc : std_logic_vector(31 downto 0);
	signal wout1 : std_logic_vector(15 downto 0);
	signal wout2 : std_logic_vector(15 downto 0);
  
	-- clocks
	signal sndclk : std_logic;
	signal clk_50_MHz : std_logic;
	signal clk_20MHz : std_logic;
	signal clk_20MHz_ext : std_logic;
	signal clk_20MHz_int : std_logic;

	signal clk_320_kHz : std_logic;
	signal clk_320_kHz_ext : std_logic;
	signal clk_320_kHz_int : std_logic;
	signal clk_32_kHz : std_logic;  
	
	-- debugging
	signal preamble_inserted : std_logic;
	signal preamble_found : std_logic;
	
	-- pll component (yes quartus is buggy :))
	component clk_20_MHz is
		port (
			refclk   : in  std_logic := 'X'; -- clk
			rst      : in  std_logic := 'X'; -- reset
			outclk_0 : out std_logic;        -- clk
			locked   : out std_logic         -- export
		);
	end component clk_20_MHz;
	
begin
	-- reset input
	reset_n <= KEY(0);
	
	-- serial to parallel input
	delay <= KEY(1);

	-- data in input
	data_in <= unsigned(GPIO_0(9 downto 0));
	ready_out <= GPIO_0(10);

	-- clocks input
	clk_50_MHz <= CLOCK_50;
	
	clk_320_kHz_ext <= GPIO_0(11);
	clk_320_KHz <= clk_320_KHz_ext;
	
	clk_20MHz_ext <= GPIO_0(13);
	clk_20MHz <= clk_20MHz_int;

	-- binary data
	binary_ext <= GPIO_0(12);
	binary <= binary_ext;
	
	-- debugging inputs
	preamble_inserted <= GPIO_0(2);

	-- debugging outputs
--	GPIO_1(1) <= clk_32_kHz;
--	GPIO_1(2) <= clk_320_kHz_ext;
--	GPIO_1(3) <= clk_320_kHz_int;
--	GPIO_1(4) <= preamble_inserted;
--	GPIO_1(5) <= preamble_found;
--	GPIO_1(6) <= binary_int;
--	GPIO_1(7) <= binary_ext;

	-- led outputs
	LEDR(9) <= reset_n;
	LEDR(8) <= SW(0);
	LEDR(3 downto 0) <= delay_counter_out;	


	process(clk_32_kHz)
	begin
		if rising_edge(sndclk) then
			wout1 <= std_logic_vector(buffer_out) & "00000000";
			wout2 <= std_logic_vector(buffer_out) & "00000000";
		end if;
	end process;
	
	-- Instantiate the PLL 20MHz clock 
	clock_gen_20_MHz_inst : clk_20_MHz
		port map (
			refclk => clk_50_MHz, -- clk 50MHz
			rst => not reset_n,  -- reset active high
			outclk_0 => clk_20MHz_int -- 32 kHz clock
		);	
	
	-- Instantiate the adc interface		
	adc_inst: entity work.ADC_interface(adc_arch)
		port map (
			enable => '1',										-- should this alwasy be '1'?
			ready_out => ready_out,						-- ready_out for adc
			clk_20_MHz => clk_20MHz, 				-- Clock input: maximal (1/1) frequency
			reset_n => reset_n,								-- High active reset (I think this is a old comment)
			d_out => data_out,								-- data output i channel
			d_in => data_in										-- data input i channel
		);
		
			
	-- Instantiate the demodulator	
	demodulation_inst: entity work.demodulator(behavioral)
		generic map (
			Fclk => 20000000,								-- inpupt clock frequency
			Fhi => 2500000,									-- high input frequency
			Flo => 1250000,									-- low input frequency
			min_bounce => 1									-- minimum bounce?
		)
		port map (
			rst => reset_n,									-- active low reset
			clk => clk_20MHz,							-- clock 20MHz
			input => data_out,							-- signed 10 bits
			output => binary_int								-- binary output
		);
		
	
	-- Instantiate the clock recovery
	clk_recovery : entity work.clock_recovery
		generic map (
			std_period => 61 -- Fclk/Fsampple
		)
		port map (
			rst => reset_n,
			clk => clk_20MHz,
			input => binary,
			out_clk => clk_320_kHz_int,
			out_dat => binary_rec,
			HEX0 => HEX0,
			HEX1 => HEX1,
			HEX2 => HEX2,
			HEX3 => HEX3,
			HEX4 => HEX4,
			HEX5 => HEX5
		);
		
		
	-- Instantiate the deframer	
	deframing_inst : entity work.deframing
		generic map (
			word_length_deframing => 10,
			preamble_receiver => 785,
			deframing_length => 32550
		)
		port map (
			data_in_deframing => binary_rec,
			clk_deframing_in => clk_320_kHz,
			reset => reset_n,
			data_out_deframing => data_out_deframing,
			--clk_deframing_out_serial => ,
			clk_deframing_out_parallel => clk_32_kHz,
			preamble_found => preamble_found
		);	
	
	
	-- Instantiate the serial to parallel
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
	
	
	-- Instantiate the decoder
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
		
		
	-- Instantiate the audio buffer	
	audiobuffer_inst : entity work.audiobuffer
		generic map (
		word_length => word_length
		 )
		port map (
			rst => reset_n,
			clk => sndclk,
			clk_in => sndclk,
			clk_out => clk_32_kHz,
			data_in => signed(buffer_in),
			data_out => buffer_out-- to gpio
		);
		

	-- Instantiate the audio codec
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
