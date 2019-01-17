library ieee;
use ieee.std_logic_1164.all;

entity tb_p_2_s is 
  generic(word_length_unbuffer: natural := 10);
end tb_p_2_s;

architecture structure of tb_p_2_s is
  -- declare components to be instantiated
  component p_2_s
    generic (word_length_unbuffer: natural);
    port (data_in_unbuffer: in std_logic_vector(word_length_unbuffer-1 downto 0);
          clk_unbuffer_parallel: in std_logic;
	      clk_unbuffer_serial: in std_logic;
          reset: in std_logic;
  
          data_out_unbuffer: out std_logic);
  end component;

  component tvc_p_2_s 
    generic (word_length_unbuffer: natural := 10;
             in_file_name: string := "p_2_s.in";
             out_file_name: string := "p_2_s.out");
    port (data_in_unbuffer: out std_logic_vector(word_length_unbuffer-1 downto 0);
          clk_unbuffer_parallel: out std_logic;
	      clk_unbuffer_serial: out std_logic;
          reset: out std_logic;
  
          data_out_unbuffer: in std_logic);
  end component;

  -- declare local signals
  signal data_in_unbuffer: std_logic_vector(word_length_unbuffer-1 downto 0); 
  signal data_out_unbuffer: std_logic;
  signal clk_unbuffer_parallel, clk_unbuffer_serial, reset: std_logic;
begin
  -- instantiate and interconnect components
  -- note that the generic word_length is passed to the subblocks
  duv: p_2_s
    generic map (word_length_unbuffer => word_length_unbuffer)
    port map (data_in_unbuffer => data_in_unbuffer, clk_unbuffer_parallel => clk_unbuffer_parallel, clk_unbuffer_serial => clk_unbuffer_serial, reset => reset, 
	      data_out_unbuffer => data_out_unbuffer);
  tvc: tvc_p_2_s
    generic map (word_length_unbuffer => word_length_unbuffer)
    port map (data_in_unbuffer => data_in_unbuffer, clk_unbuffer_parallel => clk_unbuffer_parallel, clk_unbuffer_serial => clk_unbuffer_serial, reset => reset, 
              data_out_unbuffer => data_out_unbuffer);
end structure;

-------------------------------------------------------------------------------
-- top level testbench (to bind generic word length)
-------------------------------------------------------------------------------

entity tb_p_2_s_top is
end tb_p_2_s_top;

architecture top of tb_p_2_s_top is
  component tb_p_2_s
    generic(word_length: natural := 8);
  end component;
begin
  tg: tb_p_2_s;
end top;
