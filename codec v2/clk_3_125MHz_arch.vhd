-- audio_interface
-- 
-- This entity implements A/D and D/A capability on the Altera DE2
-- WM8731 Audio Codec. Setup of the codec requires the use of I2C
-- to set parameters located in I2C registers. Setup options can
-- be found in the SCI_REG_ROM and SCI_DAT_ROM. This entity is
-- capable of sampling at 48 kHz with 16 bit samples, one sample
-- for the left channel and one sample for the right channel.
--
-- http://courses.engr.illinois.edu/ECE298/lectures/Sound-Documentation.html
--
--
-- Version 1.0
--
-- Designer: Koushik Roy
-- April 23, 2010
--
-- Changes July 16, 2014
-- 1) unused signal INIT removed
-- 2) non IEEE packages removed (and necessary changes are made)


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
entity ckk_3_125MHz is
  port(outclk_0      : in std_logic;
		 reset 			: in std_logic;
		 clk_31_25kHz  : out std_logic
	   );
end ckk_3_125MHz;


ARCHITECTURE Behavorial OF ckk_3_125MHz IS

signal Bcount : integer range 0 to 31;
signal adc_count : integer range 0 to 32;


BEGIN

	adc_proc : process(Clk, bck0, bck1, adck0, adck1, Reset, adc_count, flag)
	variable adc_reg_val : std_logic_vector(31 downto 0);
	begin
		if (Reset = '0') then
			adc_reg_val := (OTHERS => '0'); 
			adc_count <= 31;
			adc_full <= '0';
		elsif(rising_edge(Clk)) then
			adc_reg_val(adc_count) := AUD_ADCDAT; -- put the bits in the 32 bits word
			adc_full <= '0';
			if (adc_count = 0) then
				adc_full <= '1';
			   ADCDATA <= adc_reg_val; -- put the 32 bit word in the ADCDATA
			end if;
			
			if (adck0 = '1' and adck1 = '0') then -- Rising edge
				adc_count <= 31; -- Read in more new ADC data on a ADCLRC rising edge
			elsif ( (not (adc_count = 0)) and bck0 = '0' and bck1 = '1') then -- Falling edge
					adc_count <= adc_count - 1; -- When not feeding with new data, shift new bit in
			end if;
			
		end if;
	end process;
			

		
	SCLK_int <= I2C_counter(9) or SCLK_inhibit; -- SCLK = CLK / 512 = 97.65 kHz ~= 100 kHz
	--SCLK_int <= I2C_counter(3) or SCLK_inhibit; -- For simulation only
	AUD_MCLK <= I2C_counter(1); -- MCLK = CLK / 4 --used to be 2, changed to 1.
	--MCLK_GPIO <= I2C_counter(2);
	I2C_SCLK <= SCLK_int;
	

	AUD_DACDAT <= LRDATA(Bcount);
	--AUD_DACDAT <= adc_reg_val(Bcount);
	data_over <= flag1;
	init_finish <= init_over;
	--ADCDATA <= adc_reg_val; -- put the 32 bit word in the ADCDATA
	
			
end Behavorial;
