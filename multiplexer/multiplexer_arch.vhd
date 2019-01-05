-------------------------------------------------------------------------------
-- File: siso_gen_gcd_arch.vhd
-- Description: siso_gen architecture for computing greatest common divider
-- Author: Sabih Gerez, University of Twente
-- Creation date: Sun Jul 11 00:37:33 CEST 2004
-------------------------------------------------------------------------------
-- $Rev: 8 $
-- $Author: gerezsh $
-- $Date: 2008-06-29 15:55:28 +0200 (Sun, 29 Jun 2008) $
-- $Log$
-------------------------------------------------------------------------------
-- $Log: siso_gen_gcd_arch.vhd,v $
-- Revision 1.1  2004/07/10 23:46:56  sabih
-- initial check in
--
-------------------------------------------------------------------------------



-- this architecture needs arithmetic functions
library ieee;
use ieee.numeric_std.all;

architecture behavioral of multiplexer is
  -- registers
  signal leds_out_tmp: std_logic_vector(9 downto 0);
  signal buttons_0000000000_temp, buttons_1000000000_temp, buttons_0100000000_temp, buttons_0010000000_temp, buttons_0001000000_temp, buttons_0000100000_temp,buttons_0000010000_temp, buttons_0000001000_temp, buttons_0000000100_temp, buttons_0000000010_temp, buttons_0000000001_temp : std_logic_vector(3 downto 0); 
begin
  -- the next process is sequential and only sensitive to clk and reset
  seq: process(clk, reset)
  begin
    if (reset = '0')
    then
				buttons_0000000000_temp <= (others =>'0');
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= (others =>'0');		
				leds_out_tmp <= (others =>'0');
    elsif rising_edge(clk)
    then
        case switches(9 downto 0) is      
		--data_in(7 downto 0)|data_out_tmp(9 downto 0)
			when "0000000000" => 
				buttons_0000000000_temp <= buttons;
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= (others =>'0');
				leds_out_tmp <= leds_0000000000;
			when "1000000000" => 
				buttons_0000000000_temp <= (others =>'0');
				buttons_1000000000_temp <= buttons;
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= (others =>'0');
				leds_out_tmp <= leds_1000000000;
			when "0100000000" => 
				buttons_0000000000_temp <= (others =>'0');
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= buttons;
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= (others =>'0');
				leds_out_tmp <= leds_0100000000;
			when "0010000000" => 
				buttons_0000000000_temp <= (others =>'0');
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= buttons;
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= (others =>'0');
				leds_out_tmp <= leds_0010000000;
			when "0001000000" => 
				buttons_0000000000_temp <= (others =>'0');
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= buttons;
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= (others =>'0');
				leds_out_tmp <= leds_0001000000;
			when "0000100000" => 
				buttons_0000000000_temp <= (others =>'0');
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= buttons;
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= (others =>'0');
				leds_out_tmp <= leds_0000100000;
			when "0000010000" => 
				buttons_0000000000_temp <= (others =>'0');
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= buttons;
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= (others =>'0');
				leds_out_tmp <= leds_0000010000;
			when "0000001000" => 
				buttons_0000000000_temp <= (others =>'0');
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= buttons;
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= (others =>'0');
				leds_out_tmp <= leds_0000001000;
			when "0000000100" => 
				buttons_0000000000_temp <= (others =>'0');
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= buttons;
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= (others =>'0');
				leds_out_tmp <= leds_0000000100;
			when "0000000010" => 
				buttons_0000000000_temp <= (others =>'0');
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= buttons;
				buttons_0000000001_temp <= (others =>'0');
				leds_out_tmp <= leds_0000000010;				
			when "0000000001" => 
				buttons_0000000000_temp <= (others =>'0');
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= buttons;
				leds_out_tmp <= leds_0000000001;	
			when others	=> 
				buttons_0000000000_temp <= buttons;
				buttons_1000000000_temp <= (others =>'0');
				buttons_0100000000_temp <= (others =>'0');
				buttons_0010000000_temp <= (others =>'0');
				buttons_0001000000_temp <= (others =>'0');
				buttons_0000100000_temp <= (others =>'0');
				buttons_0000010000_temp <= (others =>'0');
				buttons_0000001000_temp <= (others =>'0');
				buttons_0000000100_temp <= (others =>'0');
				buttons_0000000010_temp <= (others =>'0');
				buttons_0000000001_temp <= (others =>'0');
				leds_out_tmp <= (others =>'1');
        end case;
    end if; -- (reset = '0')
  end process seq; 

  -- output register can be any of num1 or num2
  buttons_0000000000 <= buttons_0000000000_temp;
  buttons_1000000000 <= buttons_1000000000_temp;
  buttons_0100000000 <= buttons_0100000000_temp;
  buttons_0010000000 <= buttons_0010000000_temp;
  buttons_0001000000 <= buttons_0001000000_temp;
  buttons_0000100000 <= buttons_0000100000_temp;
  buttons_0000010000 <= buttons_0000010000_temp;
  buttons_0000001000 <= buttons_0000001000_temp;
  buttons_0000000100 <= buttons_0000000100_temp;
  buttons_0000000010 <= buttons_0000000010_temp;
  buttons_0000000001 <= buttons_0000000001_temp;
  leds <= leds_out_tmp;

end behavioral;
