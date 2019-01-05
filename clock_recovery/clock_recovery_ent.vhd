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
		error_reset : out std_logic;
		error_reset_multiple : out std_logic;
		error_reset_period_low : out std_logic;
		error_reset_period_high : out std_logic;
		
		period_out 		: out std_logic_vector(8 downto 0);
		period_up_btn	: in std_logic := '0';
		period_down_btn: in std_logic := '0';
		dynamic_enable_btn: in std_logic := '0';
		dynamic_enable_led: out std_logic
    );
end;
