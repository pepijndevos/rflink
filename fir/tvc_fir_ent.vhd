-------------------------------------------------------------------------------
-- File: tb_fir.vhd
-- Description: Generic FIR filter test bench
-- Author: Big Boss Bakker
-------------------------------------------------------------------------------

library ieee, std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tvc_fir is
  generic(
        w_out       : natural := 10;
        in_file_name  : string;
        out_file_name : string
    );
    port(
        rst    : out std_logic;
        clk    : out std_logic;
        sndclk : out std_logic;
        word   : out std_logic;
        resp   : in unsigned(w_out-1 downto 0)
    );
end tvc_fir;
