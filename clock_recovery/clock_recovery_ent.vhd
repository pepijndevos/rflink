-------------------------------------------------------------------------------
-- File: clock_recovery_ent.vhd
-- Description: Recover a clock signal from a binary stream and a logic clock
-- Author: Pepijn de Vos
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_recovery is
    generic (
      -- Fclk/Fsampple
      std_period : integer := 614;
      -- clocks to wait before sending an out_clk
      timeout : integer := 154
      );
    port (
      rst    			: in std_logic;
      clk    			: in std_logic;
      input  			: in std_logic;
      out_clk			: out std_logic;
		HEX0				: out std_logic_vector(6 downto 0);
		HEX1				: out std_logic_vector(6 downto 0);
		HEX2				: out std_logic_vector(6 downto 0);
		HEX3				: out std_logic_vector(6 downto 0);
		HEX4				: out std_logic_vector(6 downto 0);
		HEX5				: out std_logic_vector(6 downto 0)

	 );
end;
