-------------------------------------------------------------------------------
-- File: audiobuffer_ent.vhd
-- Description: An interface for connecting an audio signal acros clock domains
-- Author: Pepijn de Vos
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity audiobuffer is
  generic(word_length: integer:= 8);
	port(
	rst: in std_logic;
   clk: in std_logic;
   clk_in: in std_logic;
   clk_out: in std_logic;
	data_in: in signed(word_length-1 downto 0);
	data_out: out signed(word_length-1 downto 0)
	);
end audiobuffer;
