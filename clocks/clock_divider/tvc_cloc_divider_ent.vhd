library ieee, std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tvc_clock_divider is
  generic(
        clk_div: integer := 10
    );
    port(
        clk_high_freq   : out std_logic;
        clk_low_freq    : in std_logic;
        reset           : out std_logic
    );
end tvc_clock_divider;
