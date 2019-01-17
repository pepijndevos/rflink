-------------------------------------------------------------------------------
-- File: tb_fir.vhd
-- Description: Generic FIR filter test bench
-- Author: Big Boss Bakker
-------------------------------------------------------------------------------

library ieee;

-- Test vector controller for demodulator testbench
-- 1. generates clock and reset_n signals for "design under verification" (DUV)
-- 2. generates enable and ready signals for "design under verification" (DUV)
-- 3. reads inputs from file and send data to the DUV
-- 4. collects outputs from DUV and writes data to file
architecture file_io of tvc_fir is
   -- internal clock and reset_n signals (these signals are necessary
   -- because VHDL does not allow that output signals are read in the
   -- entity that generates them)
   signal clk_i : std_logic;
   signal sndclk_i : std_logic;
   signal inclk : std_logic;
	signal rst_i : std_logic := '1';
   -- input file
   file in_file : text open Read_mode is in_file_name;
   -- output file
   file out_file : text open Write_mode is out_file_name;

begin
   -- connect internal clock and reset_n to ports
   clk <= clk_i;
   sndclk <= sndclk_i;
   rst <= rst_i;

   -- generate logic clock 50MHz
   clock_logic : process
      constant half_clock_period : time := 1 ns;

		begin
      clk_i <= '1';
      wait for half_clock_period;
      clk_i <= '0';
      wait for half_clock_period;
   end process;

   -- generate snd clock  3MHz
   clock_snd : process
      constant half_clock_period : time :=  17 ns;

		begin
      sndclk_i <= '1';
      wait for half_clock_period;
      sndclk_i <= '0';
      wait for half_clock_period;
   end process;

   -- generate input clock 300 kHz
   clock_input : process
      constant half_clock_period : time :=  170 ns;

		begin
      inclk <= '1';
      wait for half_clock_period;
      inclk <= '0';
      wait for half_clock_period;
   end process;

   -- The hardware registers are clocked on the rising edge of the
   -- clock; the stimuli should be stable then and therefore change
   -- on the falling edge of the clock.
   -- NOTE that the first edge of the clock is a falling one.

   reset_p : process(sndclk_i)
      variable first : boolean := true;

   begin
      if falling_edge(sndclk_i) then     -- handle reset_n; reset_n signal is low during first clock cycle only
         if first then
            first := false;
            rst_i <= '0';
         else
            rst_i <= '1';
			end if; -- first = true
		end if; -- falling_edge(clk_i)
	end process; --process reset


	stimuli : process(inclk)
	   variable inline : line;
      variable good   : boolean;
      variable input	 : integer;

		begin
		if rst_i = '0' then
			word <= '0';
		elsif falling_edge(inclk) then

			assert not endfile(in_file)
         report "OK! Simulation stopped at end of input file."
         severity failure;

         readline(in_file, inline);
         read(inline, input, good);
         assert good
         report "Error during input file processing." severity failure;
         if (input > 0) then
            word <= '1';
         else
            word <= '0';
            end if;
      end if;	-- if reset
   end process;

	output : process(sndclk_i)
	   variable outline  : line;
      variable output   : integer;

	begin
		if rst_i = '0' then
		-- nothing
		elsif falling_edge (sndclk_i) then
			output := to_integer(signed(resp));
         write(outline, output);
         writeline(out_file, outline);
		end if; -- if reset
	end process;
end file_io;
