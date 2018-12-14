library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity transmitter is
  generic(
  clk_div : integer := 100;
  
  );
  
  port(
  
		 CLOCK_50     : in std_logic; 							-- 50 MHz Clock
		 AUD_ADCDAT   : in std_logic; 							-- ADC Data
		 AUD_ADCLRCK  : in std_logic; 							-- ADC data left/right select
		 AUD_BCLK     : in std_logic; 							-- Digital Audio bit clock
		 AUD_DACLRCK  : in std_logic; 							-- DAC data left/right select
		 KEY 			  : in std_logic_vector(3 downto 0); 	-- reset key
		 
		 AUD_DACDAT   : out std_logic; 							-- DAC data line
		 AUD_XCK      : out std_logic; 							-- Codec master clock OUTPUT
		 FPGA_I2C_SCLK: out std_logic; 							-- serial interface clock
		 FPGA_I2C_SDAT: inout std_logic
		 
	   );

end transmitter;
