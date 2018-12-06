-------------------------------------------------------------------------------
-- File: tvc_siso_gen_file_io_arch.vhd
-- Description: Architecture for tvc_siso_gen meant for functional
--   simulations that supply input from file and store output in file
-- Author: Sabih Gerez, University of Twente
-- Creation date: Wed Aug 11 00:31:04 CEST 2004
-------------------------------------------------------------------------------
-- $Rev: 221 $
-- $Author: gerezsh $
-- $Date: 2017-08-28 00:54:24 +0200 (Mon, 28 Aug 2017) $
-- $Log$
-------------------------------------------------------------------------------
-- $Log: tvc_siso_gen_file_io_arch.vhd,v $
-- Revision 1.3  2004/08/23 15:27:06  sabih
-- scan_shift permanently zero was missing
--
-- Revision 1.2  2004/08/23 13:15:31  sabih
-- friendlier termination message
--
-- Revision 1.1  2004/08/10 22:41:23  sabih
-- initial check in
--
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- 1. generates clock and reset signals for "design under verification" (DUV)
-- 2. reads inputs from file and send data to the DUV
-- 3. collects outputs from DUV and writes data to file
-------------------------------------------------------------------------------

architecture file_io of tvc_siso_gen is
  -- internal clock and reset signals (these signals are necessary
  -- because VHDL does not allow that output signals are read in the
  -- entity that generates them)
  signal clk_i, clk_j, rst_i: std_logic;

  -- input file
  file in_file: text open Read_mode is in_file_name;
  -- output file
  file out_file: text open Write_mode is out_file_name;

begin
  --  connect internal clock and reset to ports
  clk_unbuffer_parallel <= clk_i;
  clk_unbuffer_serial <= clk_j;
  reset <= rst_i;

  -- generate clock
  clock_parallel: process
  begin
    clk_i <= '1';
    wait for (half_clock_period*word_length_unbuffer);
    clk_i <= '0';
    wait for (half_clock_period*word_length_unbuffer);
  end process clock_parallel;


  clock_serial: process
  begin
    clk_j <= '1';
    wait for half_clock_period;
    clk_j <= '0';
    wait for half_clock_period;
  end process clock_serial;
  
  -- The hardware registers are clocked on the rising edge of the
  -- clock; the stimuli should be stable then and therefore change
  -- on the falling edge of the clock.
  
  -- Note that the first edge of the clock is a falling one.

  stimuli: process (clk_i, clk_j)
    variable first: boolean := true;

    variable inline, outline: line;
    variable good: boolean;

    variable input, output: integer;

    variable time_out_counter: integer;

  begin
    if falling_edge(clk_i)
    then
      -- handle reset; reset signal is high during first clock cycle only
      if first 
      then
	first := false;
	rst_i <= '0';
        time_out_counter := 0;
      else
	rst_i <= '1';
	

       assert not endfile(in_file)
          report "OK! Simulation stopped at end of input file." 
          severity failure;
       readline(in_file, inline);
       read(inline, input, good);
       assert good 
	  report "Error during input file processing." severity failure;

       -- encode input as a 2's complement signal
	  data_in_unbuffer <= std_logic_vector(to_unsigned(input, word_length_unbuffer));
          time_out_counter := 0;
	
          time_out_counter := time_out_counter + 1;
          if (time_out_counter > 100000)
          then
            assert false
              report "Time out while waiting for req!" severity failure;
          end if;

      end if; -- first
    end if; -- falling_edge(clk_i)

    if falling_edge(clk_j)
    then
	if (data_out_unbuffer = '0')
	then
           output := 0;
	else
	   output := 1;
	end if; --data_out_unbuffer = '0')
       write(outline, output);
       writeline(out_file, outline);
    end if;
  end process stimuli;

end file_io;
