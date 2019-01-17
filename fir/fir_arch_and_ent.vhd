-------------------------------------------------------------------------------
-- File: fir_arch_and_ent.vhd
-- Description: Generic FIR filter
-- Used for pulse shaping
-- Combined ent and arch due to issues
-- Author: Pepijn de Vos
-------------------------------------------------------------------------------

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
      reset_n    : in std_logic;
      clk    : in std_logic;
      sndclk : in std_logic;
      word   : in std_logic;
			btn		 : in std_logic;
			fir_led : out std_logic;
      resp   : out unsigned(w_out-1 downto 0)
    );
end;

architecture behavioral of fir is
	signal fir_enable : std_logic;
begin
  process(clk, reset_n)
    variable lastsnd : std_logic;
    variable counter : integer range coef'low to coef'high+1;
    variable acc : unsigned(w_acc-1 downto 0);
    variable buf : std_logic_vector (coef'low to coef'high);
  begin
    if reset_n = '0' then
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
				if (fir_enable = '1') then
					resp <= resize(acc/coef_scale, resp'length);
				else
					if (word = '1') then
						resp <= (others => '1');
					else
						resp <= (others => '0');
					end if;
				end if;

      end if;
      lastsnd := sndclk;
    end if;
  end process;

	fir_filter_enable: process(reset_n, btn)
	begin
		if (reset_n = '0') then
			fir_enable <= '1';
		elsif (rising_edge(btn)) then
			fir_enable <= not fir_enable;
		end if;
		fir_led <= fir_enable;
	end process fir_filter_enable;
end;
