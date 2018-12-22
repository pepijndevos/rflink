library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

entity clock_recovery is
    generic (
      -- Fclk/Fsampple
      std_period : integer := 20;
      -- clocks to wait before sending an out_clk
      timeout : integer := 5
      );
    port (
      rst    			: in std_logic;
      clk    			: in std_logic;
      input  			: in std_logic;
      out_clk			: out std_logic;
			error_reset : out std_logic;
			error_reset_toggle : out std_logic
    );
end;
