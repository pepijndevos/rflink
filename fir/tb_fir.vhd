-------------------------------------------------------------------------------
-- File: tb_fir.vhd
-- Description: Generic FIR filter test bench
-- Author: Big Boss Bakker
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.data_types.all;

--Entity for synchronization testbench
entity tb_fir is
    generic(
        coef_scale : integer;
    	w_acc : integer;
    	w_out : integer := 16;
    	coef : array_of_integers;
        in_file_name  : string;
        out_file_name : string
    );
end tb_fir;

--Architecture for synchronization testbench
architecture structure of tb_fir is
    -- declare components to be instantiated

    component fir
    generic (
    	coef_scale : integer;
    	w_acc : integer;
        w_out : integer;
        coef : array_of_integers
    );
    port (
        rst    : in std_logic;
        clk    : in std_logic;
        sndclk : in std_logic;
        word   : in std_logic;
        resp   : out unsigned(w_out-1 downto 0)
    );
    end component;

    component tvc_fir
        generic (
            w_out           : natural;
            in_file_name    : string;
            out_file_name   : string
	    );
        port (
            rst    : out std_logic;
            clk    : out std_logic;
            sndclk : out std_logic;
            word   : out std_logic;
            resp   : in unsigned(w_out-1 downto 0)
        );
    end component;

    -- declare local signals
    signal clk, sndclk, rst, word : std_logic;
    signal resp : unsigned(w_out-1 downto 0);

begin

    duv: fir
    	generic map (
            coef_scale => coef_scale,
            w_out => w_out,
            w_acc => w_acc,
            coef => coef
    	)
    	port map (
            clk => clk,
            sndclk => sndclk,
    		rst => rst,
    		word => word,
    		resp => resp
    	);
    tvc : tvc_fir
        generic map(
            w_out     => w_out,
            in_file_name  => in_file_name,
            out_file_name => out_file_name
        )
        port map(
            clk => clk,
            sndclk => sndclk,
    		rst => rst,
    		word => word,
    		resp => resp
        );
end structure;

entity tb_fir_top is
end tb_fir_top;

-- top level testbench (to define generic word length)
architecture top of tb_fir_top is
    component tb_fir
    end component;
begin
    tg : tb_fir;
end top;
