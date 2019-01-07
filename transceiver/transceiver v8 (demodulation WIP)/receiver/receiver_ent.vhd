library ieee;  
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity receiver is
  generic(
		clk_div : integer := 100;
		word_length : integer := 8;
		adc_resolution : integer := 10
  );
  port(
	 CLOCK_50     	: in std_logic; 							-- 50 MHz Clock
	 AUD_ADCDAT   	: in std_logic; 							-- ADC Data
	 AUD_ADCLRCK  	: in std_logic; 							-- ADC data left/right select
	 AUD_BCLK     	: in std_logic; 							-- Digital Audio bit clock
	 AUD_DACLRCK  	: in std_logic; 							-- DAC data left/right select
	 KEY 			  		: in std_logic_vector(3 downto 0); 	-- reset key
	 GPIO_0 		  	: in std_logic_vector(53 downto 0); -- gpio input pins
	 GPIO_1					: out std_logic_vector(53 downto 0); -- gpio output pins
	 AUD_DACDAT   	: out std_logic; 							-- DAC data line
	 AUD_XCK      	: out std_logic; 							-- Codec master clock OUTPUT
	 FPGA_I2C_SCLK	: out std_logic; 							-- serial interface clock
	 FPGA_I2C_SDAT	: inout std_logic;		 				-- serial interface data
	 LEDR 					: out std_logic_vector(9 downto 0)  -- leds
	);

end receiver;
