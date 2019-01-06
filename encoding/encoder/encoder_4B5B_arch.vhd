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

architecture behavioral of encoder_4B5B is
  -- registers
  signal data_out_tmp: std_logic_vector(word_length_out_4B5B_encoder-1 downto 0);
begin
  -- the next process is sequential and only sensitive to clk and reset
  seq: process(clk_4B5B_encoder, reset)
  begin
    if (reset = '0')
    then
		data_out_tmp <= (others =>'0');

    elsif rising_edge(clk_4B5B_encoder)
    then
        case data_in_4B5B_encoder(7 downto 0) is      
		--data_in(7 downto 0)|data_out_tmp(9 downto 0)
when "10000000" => data_out_tmp <= "1011100100";
when "10000001" => data_out_tmp <= "1011101011";
when "01111111" => data_out_tmp <= "1011101100";
when "10000010" => data_out_tmp <= "1011110001";
when "01111110" => data_out_tmp <= "1011110010";
when "10000011" => data_out_tmp <= "1011110011";
when "01111101" => data_out_tmp <= "1011110100";
when "10000100" => data_out_tmp <= "1011110101";
when "01111100" => data_out_tmp <= "1011110110";
when "10000101" => data_out_tmp <= "1100001001";
when "01111011" => data_out_tmp <= "1100001010";
when "10000110" => data_out_tmp <= "1100001011";
when "01111010" => data_out_tmp <= "1100001100";
when "10000111" => data_out_tmp <= "1100001101";
when "01111001" => data_out_tmp <= "1100001110";
when "10001000" => data_out_tmp <= "1100010001";
when "01111000" => data_out_tmp <= "1100010010";
when "10001001" => data_out_tmp <= "1100010011";
when "01110111" => data_out_tmp <= "1100010100";
when "10001010" => data_out_tmp <= "1100010101";
when "01110110" => data_out_tmp <= "1100010110";
when "10001011" => data_out_tmp <= "1100011001";
when "01110101" => data_out_tmp <= "1100011010";
when "10001100" => data_out_tmp <= "1100011011";
when "01110100" => data_out_tmp <= "1100011100";
when "10001101" => data_out_tmp <= "1100011101";
when "01110011" => data_out_tmp <= "1100011110";
when "10001110" => data_out_tmp <= "1100100001";
when "01110010" => data_out_tmp <= "1100100010";
when "10001111" => data_out_tmp <= "1100100011";
when "01110001" => data_out_tmp <= "1100100100";
when "10010000" => data_out_tmp <= "1100100101";
when "01110000" => data_out_tmp <= "1100100110";
when "10010001" => data_out_tmp <= "1100101001";
when "01101111" => data_out_tmp <= "1100101010";
when "10010010" => data_out_tmp <= "1100101011";
when "01101110" => data_out_tmp <= "1100101100";
when "10010011" => data_out_tmp <= "1100101101";
when "01101101" => data_out_tmp <= "1100101110";
when "10010100" => data_out_tmp <= "1100110001";
when "01101100" => data_out_tmp <= "1100110010";
when "10010101" => data_out_tmp <= "1100110011";
when "01101011" => data_out_tmp <= "1100110100";
when "10010110" => data_out_tmp <= "1100110101";
when "01101010" => data_out_tmp <= "1100110110";
when "10010111" => data_out_tmp <= "1100111001";
when "01101001" => data_out_tmp <= "1100111010";
when "10011000" => data_out_tmp <= "1100111011";
when "01101000" => data_out_tmp <= "1100111100";
when "10011001" => data_out_tmp <= "1100111101";
when "01100111" => data_out_tmp <= "1101000010";
when "10011010" => data_out_tmp <= "1101000011";
when "01100110" => data_out_tmp <= "1101000100";
when "10011011" => data_out_tmp <= "1101000101";
when "01100101" => data_out_tmp <= "1101000110";
when "10011100" => data_out_tmp <= "1101001001";
when "01100100" => data_out_tmp <= "1101001010";
when "10011101" => data_out_tmp <= "1101001011";
when "01100011" => data_out_tmp <= "1101001100";
when "10011110" => data_out_tmp <= "1101001101";
when "01100010" => data_out_tmp <= "1101001110";
when "10011111" => data_out_tmp <= "1101010001";
when "01100001" => data_out_tmp <= "1101010010";
when "10100000" => data_out_tmp <= "1101010011";
when "01100000" => data_out_tmp <= "1101010100";
when "10100001" => data_out_tmp <= "1101010101";
when "01011111" => data_out_tmp <= "1101010110";
when "10100010" => data_out_tmp <= "1101011001";
when "01011110" => data_out_tmp <= "1101011010";
when "10100011" => data_out_tmp <= "1101011011";
when "01011101" => data_out_tmp <= "1101011100";
when "10100100" => data_out_tmp <= "1101011101";
when "01011100" => data_out_tmp <= "1101011110";
when "10100101" => data_out_tmp <= "1101100001";
when "01011011" => data_out_tmp <= "1101100010";
when "10100110" => data_out_tmp <= "1101100011";
when "01011010" => data_out_tmp <= "1101100100";
when "10100111" => data_out_tmp <= "1101100101";
when "01011001" => data_out_tmp <= "1101100110";
when "10101000" => data_out_tmp <= "1101101001";
when "01011000" => data_out_tmp <= "1101101010";
when "10101001" => data_out_tmp <= "1101101011";
when "01010111" => data_out_tmp <= "1101101100";
when "10101010" => data_out_tmp <= "1101101101";
when "01010110" => data_out_tmp <= "1101101110";
when "10101011" => data_out_tmp <= "1101110001";
when "01010101" => data_out_tmp <= "1101110010";
when "10101100" => data_out_tmp <= "1101110011";
when "01010100" => data_out_tmp <= "1101110100";
when "10101101" => data_out_tmp <= "1101110101";
when "01010011" => data_out_tmp <= "1101110110";
when "10101110" => data_out_tmp <= "1101111001";
when "01010010" => data_out_tmp <= "1101111010";
when "10101111" => data_out_tmp <= "1101111011";
when "01010001" => data_out_tmp <= "0100010001";
when "10110000" => data_out_tmp <= "0100010010";
when "01010000" => data_out_tmp <= "0100010101";
when "10110001" => data_out_tmp <= "0100010110";
when "01001111" => data_out_tmp <= "0100011001";
when "10110010" => data_out_tmp <= "0100011010";
when "01001110" => data_out_tmp <= "0100011101";
when "10110011" => data_out_tmp <= "0100100010";
when "01001101" => data_out_tmp <= "0100101110";
when "10110100" => data_out_tmp <= "0100110001";
when "01001100" => data_out_tmp <= "0100111001";
when "10110101" => data_out_tmp <= "0100111010";
when "01001011" => data_out_tmp <= "0101000101";
when "10110110" => data_out_tmp <= "0101000110";
when "01001010" => data_out_tmp <= "0101001110";
when "10110111" => data_out_tmp <= "0101010001";
when "01001001" => data_out_tmp <= "0101011101";
when "10111000" => data_out_tmp <= "0101100010";
when "01001000" => data_out_tmp <= "0101101110";
when "10111001" => data_out_tmp <= "0101110001";
when "01000111" => data_out_tmp <= "0101110010";
when "10111010" => data_out_tmp <= "0101110101";
when "01000110" => data_out_tmp <= "0101110110";
when "10111011" => data_out_tmp <= "0110001001";
when "01000101" => data_out_tmp <= "0110001010";
when "10111100" => data_out_tmp <= "0110001101";
when "01000100" => data_out_tmp <= "0110001110";
when "10111101" => data_out_tmp <= "0110010001";
when "01000011" => data_out_tmp <= "0110011101";
when "10111110" => data_out_tmp <= "0110100010";
when "01000010" => data_out_tmp <= "0110101110";
when "10111111" => data_out_tmp <= "0110110001";
when "01000001" => data_out_tmp <= "0110111001";
when "11000000" => data_out_tmp <= "0110111010";
when "01000000" => data_out_tmp <= "0111000101";
when "11000001" => data_out_tmp <= "0111000110";
when "00111111" => data_out_tmp <= "0111001001";
when "11000010" => data_out_tmp <= "0111001010";
when "00111110" => data_out_tmp <= "0111001101";
when "11000011" => data_out_tmp <= "0111001110";
when "00111101" => data_out_tmp <= "0111010001";
when "11000100" => data_out_tmp <= "0111010010";
when "00111100" => data_out_tmp <= "0111010101";
when "11000101" => data_out_tmp <= "0111010110";
when "00111011" => data_out_tmp <= "0111011001";
when "11000110" => data_out_tmp <= "0111011010";
when "00111010" => data_out_tmp <= "0111011101";
when "11000111" => data_out_tmp <= "1000100010";
when "00111001" => data_out_tmp <= "1000100101";
when "11001000" => data_out_tmp <= "1000100110";
when "00111000" => data_out_tmp <= "1000101001";
when "11001001" => data_out_tmp <= "1000101010";
when "00110111" => data_out_tmp <= "1000101101";
when "11001010" => data_out_tmp <= "1000101110";
when "00110110" => data_out_tmp <= "1000110001";
when "11001011" => data_out_tmp <= "1000110010";
when "00110101" => data_out_tmp <= "1000110101";
when "11001100" => data_out_tmp <= "1000110110";
when "00110100" => data_out_tmp <= "1000111001";
when "11001101" => data_out_tmp <= "1000111010";
when "00110011" => data_out_tmp <= "1001000101";
when "11001110" => data_out_tmp <= "1001000110";
when "00110010" => data_out_tmp <= "1001001110";
when "11001111" => data_out_tmp <= "1001010001";
when "00110001" => data_out_tmp <= "1001011101";
when "11010000" => data_out_tmp <= "1001100010";
when "00110000" => data_out_tmp <= "1001101110";
when "11010001" => data_out_tmp <= "1001110001";
when "00101111" => data_out_tmp <= "1001110010";
when "11010010" => data_out_tmp <= "1001110101";
when "00101110" => data_out_tmp <= "1001110110";
when "11010011" => data_out_tmp <= "1010001001";
when "00101101" => data_out_tmp <= "1010001010";
when "11010100" => data_out_tmp <= "1010001101";
when "00101100" => data_out_tmp <= "1010001110";
when "11010101" => data_out_tmp <= "1010010001";
when "00101011" => data_out_tmp <= "1010011101";
when "11010110" => data_out_tmp <= "1010100010";
when "00101010" => data_out_tmp <= "1010101110";
when "11010111" => data_out_tmp <= "1010110001";
when "00101001" => data_out_tmp <= "1010111001";
when "11011000" => data_out_tmp <= "1010111010";
when "00101000" => data_out_tmp <= "1011000101";
when "11011001" => data_out_tmp <= "1011000110";
when "00100111" => data_out_tmp <= "1011001110";
when "11011010" => data_out_tmp <= "1011010001";
when "00100110" => data_out_tmp <= "1011011101";
when "11011011" => data_out_tmp <= "1011100010";
when "00100101" => data_out_tmp <= "1011100101";
when "11011100" => data_out_tmp <= "1011100110";
when "00100100" => data_out_tmp <= "1011101001";
when "11011101" => data_out_tmp <= "1011101010";
when "00100011" => data_out_tmp <= "1011101101";
when "11011110" => data_out_tmp <= "1011101110";
when "00100010" => data_out_tmp <= "0100100101";
when "11011111" => data_out_tmp <= "0100100110";
when "00100001" => data_out_tmp <= "0100101001";
when "11100000" => data_out_tmp <= "0100101010";
when "00100000" => data_out_tmp <= "0100101101";
when "11100001" => data_out_tmp <= "0100110010";
when "00011111" => data_out_tmp <= "0100110101";
when "11100010" => data_out_tmp <= "0100110110";
when "00011110" => data_out_tmp <= "0101001001";
when "11100011" => data_out_tmp <= "0101001010";
when "00011101" => data_out_tmp <= "0101001101";
when "11100100" => data_out_tmp <= "0101010010";
when "00011100" => data_out_tmp <= "0101010101";
when "11100101" => data_out_tmp <= "0101010110";
when "00011011" => data_out_tmp <= "0101011001";
when "11100110" => data_out_tmp <= "0101011010";
when "00011010" => data_out_tmp <= "0101100101";
when "11100111" => data_out_tmp <= "0101100110";
when "00011001" => data_out_tmp <= "0101101001";
when "11101000" => data_out_tmp <= "0101101010";
when "00011000" => data_out_tmp <= "0101101101";
when "11101001" => data_out_tmp <= "0110010010";
when "00010111" => data_out_tmp <= "0110010101";
when "11101010" => data_out_tmp <= "0110010110";
when "00010110" => data_out_tmp <= "0110011001";
when "11101011" => data_out_tmp <= "0110011010";
when "00010101" => data_out_tmp <= "0110100101";
when "11101100" => data_out_tmp <= "0110100110";
when "00010100" => data_out_tmp <= "0110101001";
when "11101101" => data_out_tmp <= "0110101010";
when "00010011" => data_out_tmp <= "0110101101";
when "11101110" => data_out_tmp <= "0110110010";
when "00010010" => data_out_tmp <= "0110110101";
when "11101111" => data_out_tmp <= "0110110110";
when "00010001" => data_out_tmp <= "1001001001";
when "11110000" => data_out_tmp <= "1001001010";
when "00010000" => data_out_tmp <= "1001001101";
when "11110001" => data_out_tmp <= "1001010010";
when "00001111" => data_out_tmp <= "1001010101";
when "11110010" => data_out_tmp <= "1001010110";
when "00001110" => data_out_tmp <= "1001011001";
when "11110011" => data_out_tmp <= "1001011010";
when "00001101" => data_out_tmp <= "1001100101";
when "11110100" => data_out_tmp <= "1001100110";
when "00001100" => data_out_tmp <= "1001101001";
when "11110101" => data_out_tmp <= "1001101010";
when "00001011" => data_out_tmp <= "1001101101";
when "11110110" => data_out_tmp <= "1010010010";
when "00001010" => data_out_tmp <= "1010010101";
when "11110111" => data_out_tmp <= "1010010110";
when "00001001" => data_out_tmp <= "1010011001";
when "11111000" => data_out_tmp <= "1010011010";
when "00001000" => data_out_tmp <= "1010100101";
when "11111001" => data_out_tmp <= "1010100110";
when "00000111" => data_out_tmp <= "1010101001";
when "11111010" => data_out_tmp <= "1010101010";
when "00000110" => data_out_tmp <= "1010101101";
when "11111011" => data_out_tmp <= "1010110010";
when "00000101" => data_out_tmp <= "1010110101";
when "11111100" => data_out_tmp <= "1010110110";
when "00000100" => data_out_tmp <= "1011001001";
when "11111101" => data_out_tmp <= "1011001010";
when "00000011" => data_out_tmp <= "1011001101";
when "11111110" => data_out_tmp <= "1011010010";
when "00000010" => data_out_tmp <= "1011010101";
when "11111111" => data_out_tmp <= "1011010110";
when "00000001" => data_out_tmp <= "1011011001";
when "00000000" => data_out_tmp <= "1011011010";
when others	=> data_out_tmp <= "0000000000";
        end case;
    end if; -- (reset = '0')
  end process seq; 

  -- output register can be any of num1 or num2
  data_out_4B5B_encoder <= data_out_tmp;

end behavioral;
