library ieee;

-- Test vector controller for demodulator testbench
-- 1. generates clock and reset_n signals for "design under verification" (DUV)
-- 2. generates enable and ready signals for "design under verification" (DUV)
-- 3. reads inputs from file and send data to the DUV
-- 4. collects outputs from DUV and writes data to file
architecture clk of tvc_clock_divider is
   -- internal clock and reset_n signals (these signals are necessary
   -- because VHDL does not allow that output signals are read in the
   -- entity that generates them)
   signal clk_high_freq_i : std_logic;
	signal rst_i : std_logic := '0';

begin
   -- connect internal clock and reset_n to ports
   clk_high_freq     <= clk_high_freq_i;
   reset    <= rst_i;

   -- generate input clock
   clock_input : process
      constant half_clock_period : time := 10 ns;

		begin
         clk_high_freq_i <= '1';
      wait for half_clock_period;
      clk_high_freq_i <= '0';
      wait for half_clock_period;
   end process;

   reset_p : process(clk_high_freq_i)
      variable first : boolean := true;

   begin
      if falling_edge(clk_high_freq_i) then     -- handle reset_n; reset_n signal is low during first clock cycle only
         if first then
            first := false;
            rst_i <= '0';
         else
            rst_i <= '1';
			end if; -- first = true
		end if; -- falling_edge(clk_high_freq_i)
	end process; --process reset
	
end clk;