-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "05/01/2015 11:58:12"
                                                            
-- Vhdl Test Bench template for design  :  Filter
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
-----------------------------------------------------------------
-- the following is added to support writing with write/writeline
-----------------------------------------------------------------
USE ieee.std_logic_textio.all;
USE std.textio.all;

use ieee.std_logic_signed.all;
use ieee.numeric_std.all;                               

ENTITY tb_convolution IS
END tb_convolution;
ARCHITECTURE structure OF tb_convolution IS
                                               
-- signals                                                   
SIGNAL clk : STD_LOGIC :='0';
SIGNAL reset : STD_LOGIC;
SIGNAL signal_in : STD_LOGIC_VECTOR(10-1 DOWNTO 0);
SIGNAL signal_out : STD_LOGIC_VECTOR(10-1 DOWNTO 0);
SIGNAL wave_out : std_LOGIC_VECTOR(10-1 downto 0);
FILE out_file : TEXT OPEN WRITE_MODE IS "out_values.txt";

COMPONENT convolution
	PORT (
	clk : IN STD_LOGIC;
	reset : IN STD_LOGIC;
	signal_in : IN STD_LOGIC_VECTOR(10-1 DOWNTO 0);
	signal_out : OUT STD_LOGIC_VECTOR(10-1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT SignalFromLookUp
	PORT (
	clk : IN STD_LOGIC;
	reset : IN STD_LOGIC;
	wave_out : OUT STD_LOGIC_VECTOR(10-1 DOWNTO 0)
	);
END COMPONENT;

BEGIN
	duv : convolution
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	reset => reset,
	signal_in => signal_in,
	signal_out => signal_out
	);
	
	tvc : SignalFromLookUp
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	reset => reset,
	wave_out => signal_in
	);
	
	clk<=not clk after 50 ns;
	signal_in<=wave_out;
	
	
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once  
		  --do not put here variabes whicha re also changed in the always process
WAIT;                                                       
END PROCESS init;

                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations 

procedure p_stable is
	begin
	--set all signals to a default value
	reset<='1';	
end procedure p_stable;

procedure filter_test(constant c_loop : integer) is
variable l:line;
variable i:integer :=0;
begin
	loop1: while i <= c_loop loop
		wait until rising_edge(clk);
			i:=i+1;
			WRITE(l, i);
			WRITE(l, string'(" "));
			WRITE(l, to_integer(signed(wave_out)));
			WRITE(l, string'(" "));
			WRITE(l, to_integer(signed(signal_out)));
			WRITELINE(out_file, l);
			
	end loop loop1;
end filter_test;

                                     
BEGIN  -- code executes for every event on sensitivity list                                                          
  
	p_stable;
	filter_test(2048);
	
	assert false report "--No Failure at the end of the sim--"
	severity failure;
		  
--WAIT;                                                        
END PROCESS always;                                       
END structure;