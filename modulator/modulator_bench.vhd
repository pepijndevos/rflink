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
  signal sample : signed(0 downto 0) := "0";

  signal pulse : unsigned(7 downto 0) := "00000000";
  signal pulse_out : signed(9 downto 0) := (others => '0');
  signal sine : signed(9 downto 0);
  signal rcv_sine : signed(9 downto 0);
  signal binary : std_logic;

  signal noise : integer := 0;

begin
  rst <= '1' after 20 ns;
  clk <= not clk after 10 ns;
  sampleclk <= not sampleclk AFTER 100 ns;
  sample <= not sample AFTER 2000 ns;
  rcv_sine <= sine/2 + 100 + noise;
  pulse <= unsigned(pulse_out(7 downto 0));


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

  fir_inst: entity work.fir(behavioral)
  generic map (
    coef_scale => 4,
    w_acc => 32,
    w_in => 1,
    w_out => pulse_out'length,
    coef => (262, 498, 262)
  )
  port map (
    rst => rst,
    clk => clk,
    sndclk => sampleclk,
    word => sample,
    resp => pulse_out
);

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
