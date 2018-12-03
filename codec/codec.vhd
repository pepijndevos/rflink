library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity codec is
  port(CLOCK_50    : in std_logic;
		 AUD_ADCDAT  : in std_logic;
		 AUD_ADCLRCK : in std_logic;
		 AUD_BCLK    : in std_logic;
		 AUD_DACDAT  : out std_logic;
		 AUD_DACLRCK : in std_logic;
		 AUD_XCK     : out std_logic;
		 FPGA_I2C_SCLK: out std_logic;
		 FPGA_I2C_SDAT: inout std_logic;
		 GPIO_0 : out std_logic_vector(53 downto 0);
		 LEDR : out std_logic_vector(9 downto 0);
		 KEY : in std_logic_vector(3 downto 0)
	   );
end codec;
