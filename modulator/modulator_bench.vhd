library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity modulatorbench is
end;

architecture testbench of modulatorbench is

  signal rst : std_logic := '0';
  signal clk : std_logic := '0';
  signal sampleclk : std_logic := '0';

  signal pulse : unsigned(9 downto 0) := "0000000000";
  signal sine : signed(9 downto 0);
  signal rcv_sine : signed(9 downto 0);
  signal binary : std_logic;

  signal noise : integer := 0;

begin
  rst <= '1' after 20 ns;
  clk <= not clk after 10 ns;
  sampleclk <= not sampleclk AFTER 100 ns;
  rcv_sine <= sine/2 + 100 + noise;


  -- pulse input
  process (sampleclk, rst)
	  variable idx : integer;
  begin
	  if rst = '0' then
		  idx := 0;
	  elsif rising_edge(sampleclk) then
		  case idx is
			  when 0 => pulse <= "0000000000";
			  when 1 => pulse <= "0001000000";
			  when 2 => pulse <= "1000000000";
			  when 3 => pulse <= "1110000000";
			  when 4 => pulse <= "1111111111";
			  when 5 => pulse <= "1111111111";
			  when 6 => pulse <= "1110000000";
			  when 7 => pulse <= "1000000000";
			  when 8 => pulse <= "0001000000";
			  when 9 => pulse <= "0000000000";
			  when others =>
		  end case;
		  if idx < 9 then
			  idx := idx+1;
		  else
			  idx := 0;
		  end if;
	  end if;
  end process;


-- noise
process
    variable seed1, seed2: positive;               -- seed values for random generator
    variable rand: real;   -- random real-number value in range 0 to 1.0  
    variable range_of_rand : real := 100.0;    -- the range of random values created will be 0 to +1000.
begin
    uniform(seed1, seed2, rand);   -- generate random number
    noise <= integer(rand*range_of_rand);  -- rescale to 0..1000, convert integer part 
    wait for 10 ns;
end process;


  mod_inst: entity work.modulator(behavioral)
    port map (rst => rst,
      clk => clk,
      input => pulse,
      output => sine);

  demod_inst: entity work.demodulator(behavioral)
    port map (rst => rst,
      clk => clk,
      input => rcv_sine,
      output => binary);
end;
