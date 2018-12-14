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
		SW : in std_logic_vector(9 downto 0);
		
	   );
end codec;
