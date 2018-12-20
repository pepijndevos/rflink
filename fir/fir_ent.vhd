entity fir is
Generic (
    coef_scale : integer;
    w_acc : integer;
    w_out : integer := 16;
    coef : array_of_integers
);
    port (
      rst    : in std_logic;
      clk    : in std_logic;
      sndclk : in std_logic;
      word   : in std_logic;
      resp   : out unsigned(w_out-1 downto 0)
    );
end;