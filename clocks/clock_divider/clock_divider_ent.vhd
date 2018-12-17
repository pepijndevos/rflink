LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
entity clock_divider is
  generic (clk_div: integer := 10);
  port(clk_high_freq    : in std_logic;
       reset 		: in std_logic;
       clk_low_freq     : out std_logic
       );
end clock_divider;

