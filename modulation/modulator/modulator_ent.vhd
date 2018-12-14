library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity modulator is
    generic (
      Fclk : integer := 50000000;
      Fhi : integer := 2500000;
      Flo : integer := 1250000
      );
    port (
      rst    : in std_logic;
      clk    : in std_logic;
      input   : in unsigned(7 downto 0);
      output : out signed(9 downto 0)
    );
end;
