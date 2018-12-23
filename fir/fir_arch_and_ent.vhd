library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;
use work.data_types.all;

entity fir is
Generic (
    coef_scale : integer;
    w_acc : integer;
    w_out : integer := 16;
    coef : array_of_integers(0 to 2)
);
    port (
      rst    : in std_logic;
      clk    : in std_logic;
      sndclk : in std_logic;
      word   : in std_logic;
      resp   : out unsigned(w_out-1 downto 0)
    );
end;

architecture behavioral of fir is
begin
  process(clk, rst)
    variable lastsnd : std_logic;
    variable counter : integer range coef'low to coef'high+1;
    variable acc : unsigned(w_acc-1 downto 0);
    variable buf : std_logic_vector (coef'low to coef'high);
  begin
    if rst = '0' then
      lastsnd := '0';
      counter := coef'low;
      acc := to_unsigned(0, acc'length);
      buf := (others => '0');
    elsif rising_edge(clk) then
      if lastsnd = '0' and sndclk = '1' then
        counter := coef'low;
        acc := to_unsigned(0, acc'length);
        buf := word & buf(coef'low to coef'high-1);
      end if;
      if counter <= coef'high then
        if buf(counter) = '1' then
          acc := acc + coef(counter);
        end if;
        counter := counter + 1;
      else
        resp <= resize(acc/coef_scale, resp'length);
      end if;
      lastsnd := sndclk;
    end if;
  end process;

end;
