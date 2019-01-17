-------------------------------------------------------------------------------
-- File: tb_p_2_s.vhd
-- Description: Parallel to serial conversion test bench
-- Author: Big Boss Bakker
-------------------------------------------------------------------------------


library ieee, std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tvc_unbuffer is
  generic (word_length_unbuffer: natural := 10;
           in_file_name: string := "unbuffer.in";
           out_file_name: string := "unbuffer.out";
           half_clock_period: time := 100 ns);
  port (data_in_unbuffer: out std_logic_vector(word_length_unbuffer-1 downto 0);
        clk_unbuffer_parallel: out std_logic;
        clk_unbuffer_serial: out std_logic;
        reset: out std_logic;
        data_out_unbuffer: in std_logic);
end tvc_unbuffer;
