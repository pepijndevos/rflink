library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity modulatorbench is
end;

architecture testbench of modulatorbench is

  signal rst : std_logic := '0';
  signal clk_50_MHz : std_logic := '0';
  signal clk_20_MHz : std_logic := '0';
  signal clk_320_kHz : std_logic := '0';
  signal outclk : std_logic := '0';
  signal sample : unsigned(7 downto 0);

  signal pulse : unsigned(7 downto 0) := "00000000";
  signal sine : signed(9 downto 0);
  signal rcv_sine : signed(9 downto 0);
  signal binary : std_logic;

  signal noise : integer := 0;

begin
  rst <= '1' after 20 ns;
  clk_50_MHz <= not clk_50_MHz after 10 ns; -- 50 MHz
  clk_20_MHz <= not clk_20_MHz after 25 ns; -- 20 MHz
  clk_320_kHz <= not clk_320_kHz after 1536 ns; -- 325.5 kHz MHz
  --sample <= not sample AFTER 2000 ns;
  rcv_sine <= sine/2 + 100 + noise;


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

-- samples
process(clk_320_kHz)
    variable seed1, seed2: positive;               -- seed values for random generator
    variable rand: real;   -- random real-number value in range 0 to 1.0  
    variable range_of_rand : real := 100.0;    -- the range of random values created will be 0 to +1000.
begin
    if rising_edge(clk_320_kHz) then
      uniform(seed1, seed2, rand);   -- generate random number
      if rand > 0.5 then
        sample <= to_unsigned(255, sample'length);
      else
        sample <= to_unsigned(0, sample'length);
      end if;
    end if;
end process;

--  fir_inst: entity work.fir(behavioral)
--  generic map (
--    coef_scale => 4,
--    w_acc => 16,
--    w_out => pulse'length,
--    coef => (262, 498, 262)
--  )
--  port map (
--    rst => rst,
--    clk => clk,
--    sndclk => sampleclk,
--    word => sample,
--    resp => pulse
--);

  mod_inst: entity work.modulator(behavioral)
    port map (rst => rst,
      clk => clk_50_MHz,
      input => sample,
      output => sine);

  demod_inst: entity work.demodulator(behavioral)
    port map (rst => rst,
      clk => clk_20_MHz,
      input => rcv_sine,
      output => binary);

--  recovery_inst: entity work.clock_recovery(behavioral)
--  generic map (
--      std_period => 50,
--      timeout => 25
--  )
--    port map (rst => rst,
--      clk => clk,
--      input => binary,
--      out_clk => outclk);
end;
