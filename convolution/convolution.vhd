library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity convolution is
  generic (
	  word_length	: natural := 10
    );
	port 
	(
		clk			: in std_logic; -- At least the ADC frequency
		reset		: in std_logic;
		
		signal_in	: in std_logic_vector(word_length-1 downto 0);
		signal_out	: out std_logic_vector(word_length-1 downto 0)
	);
end entity;

architecture Behavorial of convolution is

	type buff_type is array(0 to 19) of std_logic_vector(word_length-1 downto 0);
	type filter_type is array(0 to 19) of std_logic_vector(word_length-1 downto 0);
	signal buff : buff_type;
	signal signal_out_tmp : std_logic_vector(10-1 downto 0);
	signal mult : std_logic_vector(20-1 downto 0);
 
	signal filter_low : filter_type :=
	(  
		0 => "0000000000",
		1 => "1110010000",
		2 => "1110010010",
		3 => "1111111001",
		4 => "0001000010",
		5 => "0000101011",
		6 => "0000000001",
		7 => "0000100000",
		8 => "0001010100",
		9 => "0000011010",
		10 => "1101110111",
		11 => "1100101001",
		12 => "1110111111",
		13 => "0010111110",
		14 => "0100001011",
		15 => "0001010001",
		16 => "1101110101",
		17 => "1101101111",
		18 => "1111101110",
		19 => "1111001001"
	);

begin
	Filter_process: process(clk, reset)
	begin
		if(reset='0') then
			buff <= (others =>(others => '0'));
		elsif(rising_edge(clk)) then
			for i in 0 to 20-1 loop
				mult <= (signed(signal_in) * signed(filter_low(i)));
				buff(i) <= signed(buff(i)) + signed(mult(20-1 downto 10));
			end loop;
			signal_out_tmp<=buff(0)(word_length-1 downto 0);
			
			for i in 0 to (word_length-1)-1 loop --shift the buffer
				buff(i) <= buff(i+1);
			end loop;			
		end if;
	end process Filter_process;
	
	--Make sure the output comes at the clock edge
	Output_process: process(clk)
	begin
		if(rising_edge(clk)) then
			signal_out<=signal_out_tmp;
		end if;
	end process Output_process;
end Behavorial;