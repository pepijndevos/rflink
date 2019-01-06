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

architecture behavioral of decoder_4B5B is
  -- registers
  signal data_out_tmp: std_logic_vector(word_length_out_4B5B_decoder-1 downto 0);
begin
  -- the next process is sequential and only sensitive to clk and reset
  seq: process(clk_4B5B_decoder, reset)
  begin
    if (reset = '0')
    then
	data_out_tmp <= (others =>'0');

    elsif rising_edge(clk_4B5B_decoder)
    then
        case data_in_4B5B_decoder(9 downto 0) is      
		--data_in(7 downto 0)|data_out_tmp(9 downto 0)
when "1011100100" => data_out_tmp <= "10000000";
when "1011101011" => data_out_tmp <= "10000001";
when "1011101100" => data_out_tmp <= "01111111";
when "1011110001" => data_out_tmp <= "10000010";
when "1011110010" => data_out_tmp <= "01111110";
when "1011110011" => data_out_tmp <= "10000011";
when "1011110100" => data_out_tmp <= "01111101";
when "1011110101" => data_out_tmp <= "10000100";
when "1011110110" => data_out_tmp <= "01111100";
when "1100001001" => data_out_tmp <= "10000101";
when "1100001010" => data_out_tmp <= "01111011";
when "1100001011" => data_out_tmp <= "10000110";
when "1100001100" => data_out_tmp <= "01111010";
when "1100001101" => data_out_tmp <= "10000111";
when "1100001110" => data_out_tmp <= "01111001";
when "1100010001" => data_out_tmp <= "10001000";
when "1100010010" => data_out_tmp <= "01111000";
when "1100010011" => data_out_tmp <= "10001001";
when "1100010100" => data_out_tmp <= "01110111";
when "1100010101" => data_out_tmp <= "10001010";
when "1100010110" => data_out_tmp <= "01110110";
when "1100011001" => data_out_tmp <= "10001011";
when "1100011010" => data_out_tmp <= "01110101";
when "1100011011" => data_out_tmp <= "10001100";
when "1100011100" => data_out_tmp <= "01110100";
when "1100011101" => data_out_tmp <= "10001101";
when "1100011110" => data_out_tmp <= "01110011";
when "1100100001" => data_out_tmp <= "10001110";
when "1100100010" => data_out_tmp <= "01110010";
when "1100100011" => data_out_tmp <= "10001111";
when "1100100100" => data_out_tmp <= "01110001";
when "1100100101" => data_out_tmp <= "10010000";
when "1100100110" => data_out_tmp <= "01110000";
when "1100101001" => data_out_tmp <= "10010001";
when "1100101010" => data_out_tmp <= "01101111";
when "1100101011" => data_out_tmp <= "10010010";
when "1100101100" => data_out_tmp <= "01101110";
when "1100101101" => data_out_tmp <= "10010011";
when "1100101110" => data_out_tmp <= "01101101";
when "1100110001" => data_out_tmp <= "10010100";
when "1100110010" => data_out_tmp <= "01101100";
when "1100110011" => data_out_tmp <= "10010101";
when "1100110100" => data_out_tmp <= "01101011";
when "1100110101" => data_out_tmp <= "10010110";
when "1100110110" => data_out_tmp <= "01101010";
when "1100111001" => data_out_tmp <= "10010111";
when "1100111010" => data_out_tmp <= "01101001";
when "1100111011" => data_out_tmp <= "10011000";
when "1100111100" => data_out_tmp <= "01101000";
when "1100111101" => data_out_tmp <= "10011001";
when "1101000010" => data_out_tmp <= "01100111";
when "1101000011" => data_out_tmp <= "10011010";
when "1101000100" => data_out_tmp <= "01100110";
when "1101000101" => data_out_tmp <= "10011011";
when "1101000110" => data_out_tmp <= "01100101";
when "1101001001" => data_out_tmp <= "10011100";
when "1101001010" => data_out_tmp <= "01100100";
when "1101001011" => data_out_tmp <= "10011101";
when "1101001100" => data_out_tmp <= "01100011";
when "1101001101" => data_out_tmp <= "10011110";
when "1101001110" => data_out_tmp <= "01100010";
when "1101010001" => data_out_tmp <= "10011111";
when "1101010010" => data_out_tmp <= "01100001";
when "1101010011" => data_out_tmp <= "10100000";
when "1101010100" => data_out_tmp <= "01100000";
when "1101010101" => data_out_tmp <= "10100001";
when "1101010110" => data_out_tmp <= "01011111";
when "1101011001" => data_out_tmp <= "10100010";
when "1101011010" => data_out_tmp <= "01011110";
when "1101011011" => data_out_tmp <= "10100011";
when "1101011100" => data_out_tmp <= "01011101";
when "1101011101" => data_out_tmp <= "10100100";
when "1101011110" => data_out_tmp <= "01011100";
when "1101100001" => data_out_tmp <= "10100101";
when "1101100010" => data_out_tmp <= "01011011";
when "1101100011" => data_out_tmp <= "10100110";
when "1101100100" => data_out_tmp <= "01011010";
when "1101100101" => data_out_tmp <= "10100111";
when "1101100110" => data_out_tmp <= "01011001";
when "1101101001" => data_out_tmp <= "10101000";
when "1101101010" => data_out_tmp <= "01011000";
when "1101101011" => data_out_tmp <= "10101001";
when "1101101100" => data_out_tmp <= "01010111";
when "1101101101" => data_out_tmp <= "10101010";
when "1101101110" => data_out_tmp <= "01010110";
when "1101110001" => data_out_tmp <= "10101011";
when "1101110010" => data_out_tmp <= "01010101";
when "1101110011" => data_out_tmp <= "10101100";
when "1101110100" => data_out_tmp <= "01010100";
when "1101110101" => data_out_tmp <= "10101101";
when "1101110110" => data_out_tmp <= "01010011";
when "1101111001" => data_out_tmp <= "10101110";
when "1101111010" => data_out_tmp <= "01010010";
when "1101111011" => data_out_tmp <= "10101111";
when "0100010001" => data_out_tmp <= "01010001";
when "0100010010" => data_out_tmp <= "10110000";
when "0100010101" => data_out_tmp <= "01010000";
when "0100010110" => data_out_tmp <= "10110001";
when "0100011001" => data_out_tmp <= "01001111";
when "0100011010" => data_out_tmp <= "10110010";
when "0100011101" => data_out_tmp <= "01001110";
when "0100100010" => data_out_tmp <= "10110011";
when "0100101110" => data_out_tmp <= "01001101";
when "0100110001" => data_out_tmp <= "10110100";
when "0100111001" => data_out_tmp <= "01001100";
when "0100111010" => data_out_tmp <= "10110101";
when "0101000101" => data_out_tmp <= "01001011";
when "0101000110" => data_out_tmp <= "10110110";
when "0101001110" => data_out_tmp <= "01001010";
when "0101010001" => data_out_tmp <= "10110111";
when "0101011101" => data_out_tmp <= "01001001";
when "0101100010" => data_out_tmp <= "10111000";
when "0101101110" => data_out_tmp <= "01001000";
when "0101110001" => data_out_tmp <= "10111001";
when "0101110010" => data_out_tmp <= "01000111";
when "0101110101" => data_out_tmp <= "10111010";
when "0101110110" => data_out_tmp <= "01000110";
when "0110001001" => data_out_tmp <= "10111011";
when "0110001010" => data_out_tmp <= "01000101";
when "0110001101" => data_out_tmp <= "10111100";
when "0110001110" => data_out_tmp <= "01000100";
when "0110010001" => data_out_tmp <= "10111101";
when "0110011101" => data_out_tmp <= "01000011";
when "0110100010" => data_out_tmp <= "10111110";
when "0110101110" => data_out_tmp <= "01000010";
when "0110110001" => data_out_tmp <= "10111111";
when "0110111001" => data_out_tmp <= "01000001";
when "0110111010" => data_out_tmp <= "11000000";
when "0111000101" => data_out_tmp <= "01000000";
when "0111000110" => data_out_tmp <= "11000001";
when "0111001001" => data_out_tmp <= "00111111";
when "0111001010" => data_out_tmp <= "11000010";
when "0111001101" => data_out_tmp <= "00111110";
when "0111001110" => data_out_tmp <= "11000011";
when "0111010001" => data_out_tmp <= "00111101";
when "0111010010" => data_out_tmp <= "11000100";
when "0111010101" => data_out_tmp <= "00111100";
when "0111010110" => data_out_tmp <= "11000101";
when "0111011001" => data_out_tmp <= "00111011";
when "0111011010" => data_out_tmp <= "11000110";
when "0111011101" => data_out_tmp <= "00111010";
when "1000100010" => data_out_tmp <= "11000111";
when "1000100101" => data_out_tmp <= "00111001";
when "1000100110" => data_out_tmp <= "11001000";
when "1000101001" => data_out_tmp <= "00111000";
when "1000101010" => data_out_tmp <= "11001001";
when "1000101101" => data_out_tmp <= "00110111";
when "1000101110" => data_out_tmp <= "11001010";
when "1000110001" => data_out_tmp <= "00110110";
when "1000110010" => data_out_tmp <= "11001011";
when "1000110101" => data_out_tmp <= "00110101";
when "1000110110" => data_out_tmp <= "11001100";
when "1000111001" => data_out_tmp <= "00110100";
when "1000111010" => data_out_tmp <= "11001101";
when "1001000101" => data_out_tmp <= "00110011";
when "1001000110" => data_out_tmp <= "11001110";
when "1001001110" => data_out_tmp <= "00110010";
when "1001010001" => data_out_tmp <= "11001111";
when "1001011101" => data_out_tmp <= "00110001";
when "1001100010" => data_out_tmp <= "11010000";
when "1001101110" => data_out_tmp <= "00110000";
when "1001110001" => data_out_tmp <= "11010001";
when "1001110010" => data_out_tmp <= "00101111";
when "1001110101" => data_out_tmp <= "11010010";
when "1001110110" => data_out_tmp <= "00101110";
when "1010001001" => data_out_tmp <= "11010011";
when "1010001010" => data_out_tmp <= "00101101";
when "1010001101" => data_out_tmp <= "11010100";
when "1010001110" => data_out_tmp <= "00101100";
when "1010010001" => data_out_tmp <= "11010101";
when "1010011101" => data_out_tmp <= "00101011";
when "1010100010" => data_out_tmp <= "11010110";
when "1010101110" => data_out_tmp <= "00101010";
when "1010110001" => data_out_tmp <= "11010111";
when "1010111001" => data_out_tmp <= "00101001";
when "1010111010" => data_out_tmp <= "11011000";
when "1011000101" => data_out_tmp <= "00101000";
when "1011000110" => data_out_tmp <= "11011001";
when "1011001110" => data_out_tmp <= "00100111";
when "1011010001" => data_out_tmp <= "11011010";
when "1011011101" => data_out_tmp <= "00100110";
when "1011100010" => data_out_tmp <= "11011011";
when "1011100101" => data_out_tmp <= "00100101";
when "1011100110" => data_out_tmp <= "11011100";
when "1011101001" => data_out_tmp <= "00100100";
when "1011101010" => data_out_tmp <= "11011101";
when "1011101101" => data_out_tmp <= "00100011";
when "1011101110" => data_out_tmp <= "11011110";
when "0100100101" => data_out_tmp <= "00100010";
when "0100100110" => data_out_tmp <= "11011111";
when "0100101001" => data_out_tmp <= "00100001";
when "0100101010" => data_out_tmp <= "11100000";
when "0100101101" => data_out_tmp <= "00100000";
when "0100110010" => data_out_tmp <= "11100001";
when "0100110101" => data_out_tmp <= "00011111";
when "0100110110" => data_out_tmp <= "11100010";
when "0101001001" => data_out_tmp <= "00011110";
when "0101001010" => data_out_tmp <= "11100011";
when "0101001101" => data_out_tmp <= "00011101";
when "0101010010" => data_out_tmp <= "11100100";
when "0101010101" => data_out_tmp <= "00011100";
when "0101010110" => data_out_tmp <= "11100101";
when "0101011001" => data_out_tmp <= "00011011";
when "0101011010" => data_out_tmp <= "11100110";
when "0101100101" => data_out_tmp <= "00011010";
when "0101100110" => data_out_tmp <= "11100111";
when "0101101001" => data_out_tmp <= "00011001";
when "0101101010" => data_out_tmp <= "11101000";
when "0101101101" => data_out_tmp <= "00011000";
when "0110010010" => data_out_tmp <= "11101001";
when "0110010101" => data_out_tmp <= "00010111";
when "0110010110" => data_out_tmp <= "11101010";
when "0110011001" => data_out_tmp <= "00010110";
when "0110011010" => data_out_tmp <= "11101011";
when "0110100101" => data_out_tmp <= "00010101";
when "0110100110" => data_out_tmp <= "11101100";
when "0110101001" => data_out_tmp <= "00010100";
when "0110101010" => data_out_tmp <= "11101101";
when "0110101101" => data_out_tmp <= "00010011";
when "0110110010" => data_out_tmp <= "11101110";
when "0110110101" => data_out_tmp <= "00010010";
when "0110110110" => data_out_tmp <= "11101111";
when "1001001001" => data_out_tmp <= "00010001";
when "1001001010" => data_out_tmp <= "11110000";
when "1001001101" => data_out_tmp <= "00010000";
when "1001010010" => data_out_tmp <= "11110001";
when "1001010101" => data_out_tmp <= "00001111";
when "1001010110" => data_out_tmp <= "11110010";
when "1001011001" => data_out_tmp <= "00001110";
when "1001011010" => data_out_tmp <= "11110011";
when "1001100101" => data_out_tmp <= "00001101";
when "1001100110" => data_out_tmp <= "11110100";
when "1001101001" => data_out_tmp <= "00001100";
when "1001101010" => data_out_tmp <= "11110101";
when "1001101101" => data_out_tmp <= "00001011";
when "1010010010" => data_out_tmp <= "11110110";
when "1010010101" => data_out_tmp <= "00001010";
when "1010010110" => data_out_tmp <= "11110111";
when "1010011001" => data_out_tmp <= "00001001";
when "1010011010" => data_out_tmp <= "11111000";
when "1010100101" => data_out_tmp <= "00001000";
when "1010100110" => data_out_tmp <= "11111001";
when "1010101001" => data_out_tmp <= "00000111";
when "1010101010" => data_out_tmp <= "11111010";
when "1010101101" => data_out_tmp <= "00000110";
when "1010110010" => data_out_tmp <= "11111011";
when "1010110101" => data_out_tmp <= "00000101";
when "1010110110" => data_out_tmp <= "11111100";
when "1011001001" => data_out_tmp <= "00000100";
when "1011001010" => data_out_tmp <= "11111101";
when "1011001101" => data_out_tmp <= "00000011";
when "1011010010" => data_out_tmp <= "11111110";
when "1011010101" => data_out_tmp <= "00000010";
when "1011010110" => data_out_tmp <= "11111111";
when "1011011001" => data_out_tmp <= "00000001";
when "1011011010" => data_out_tmp <= "00000000";
when others	=> data_out_tmp <= "00000000";
        end case;
    end if; -- (reset = '0')
  end process seq; 

  -- output register can be any of num1 or num2
  data_out_4B5B_decoder <= data_out_tmp;

end behavioral;
