library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;
use work.data_types.all;

architecture behavioral of fir is
begin
  process(clk, rst)
    variable lastsnd : std_logic;
    variable counter : integer range coef'low to coef'high+1;
    variable acc : unsigned(w_acc-1 downto 0);
    type buf_type is array (coef'low to coef'high) of std_logic;
    variable buf : buf_type;
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
