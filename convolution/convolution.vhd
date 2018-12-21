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

	type buff_type is array(0 to 19) of std_logic_vector(20-1 downto 0);
	type filter_type is array(0 to 19) of std_logic_vector(word_length-1 downto 0);
	signal buff : buff_type;
	signal signal_out_tmp : std_logic_vector(10-1 downto 0);
 
	signal filter : filter_type :=
	(  
		0 => "0000000000",
		1 => "1111111111",
		2 => "0000001101",
		3 => "0000000101",
		4 => "1111101101",
		5 => "1111111001",
		6 => "0000000101",
		7 => "1111110111",
		8 => "0000101111",
		9 => "0010011111",
		10 => "0010011111",
		11 => "0000101111",
		12 => "1111110111",
		13 => "0000000101",
		14 => "1111111001",
		15 => "1111101101",
		16 => "0000000101",
		17 => "0000001101",
		18 => "1111111111",
		19 => "0000000000"
	);

begin

	Filter_process: process(clk, reset)
	begin
		if(reset='0') then
			buff <= (others =>(others => '0'));
		elsif(rising_edge(clk)) then
			for i in 0 to 20-1 loop
				buff(i) <= signed(buff(i)) + signed(signal_in) * signed(filter(i));
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