-- audio_interface
-- 
-- This entity implements A/D and D/A capability on the Altera DE2
-- WM8731 Audio Codec. Setup of the codec requires the use of I2C
-- to set parameters located in I2C registers. Setup options can
-- be found in the SCI_REG_ROM and SCI_DAT_ROM. This entity is
-- capable of sampling at 48 kHz with 16 bit samples, one sample
-- for the left channel and one sample for the right channel.
--
-- http://courses.engr.illinois.edu/ECE298/lectures/Sound-Documentation.html
--
--
-- Version 1.0
--
-- Designer: Koushik Roy
-- April 23, 2010
--
-- Changes July 16, 2014
-- 1) unused signal INIT removed
-- 2) non IEEE packages removed (and necessary changes are made)


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

