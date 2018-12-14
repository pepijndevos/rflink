library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;

architecture behavioral of modulator is

component waveform_gen

port (

  -- system signals
  clk         : in  std_logic;
  reset       : in  std_logic;
  
  -- clock-enable
  en          : in  std_logic;
  
  -- NCO frequency control
  phase_inc   : in  std_logic_vector(31 downto 0);
  
  -- Output waveforms
  sin_out     : out std_logic_vector(11 downto 0);
  cos_out     : out std_logic_vector(11 downto 0);
  squ_out     : out std_logic_vector(11 downto 0);
  saw_out     : out std_logic_vector(11 downto 0) );
  
end component;

signal phase_inc : std_logic_vector(31 downto 0);
signal sin_out : std_logic_vector(11 downto 0);
signal Fout : integer;

begin

output <= signed(sin_out(11 downto 2));
Fout <= Flo + (to_integer(input) * (Fhi-Flo) / 256);
phase_inc <= std_logic_vector(resize(Fout * unsigned'(X"100000000") / Fclk, 32));

  process(clk, rst)
  begin
    if rst = '0' then
    elsif rising_edge(clk) then
    end if;
  end process;

nco: waveform_gen port map (

  -- system signals
  clk         => clk,
  reset       => rst,
  
  -- clock-enable
  en          => '1',
  
  -- NCO frequency control
  phase_inc   => phase_inc,
  
  -- Output waveforms
  sin_out     => sin_out,
  cos_out     => open,
  squ_out     => open,
  saw_out     => open );

end;
