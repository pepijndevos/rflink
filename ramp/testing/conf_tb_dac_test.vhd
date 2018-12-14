-------------------------------------------------------------------------------
-- File: conf_tb_siso_gen_gcd.vhd
-- Description: siso_gen configuration for use of gcd architecture
-- Author: Sabih Gerez, University of Twente
-- Creation date: Sun Jul 11 01:23:24 CEST 2004
-------------------------------------------------------------------------------

configuration conf_tb_dac_test of tb_dac_test is
  for top
    for duv: dac_test_interface use entity work.dac_test_interface(behavior);
    end for;
    for tvc: tvc_dac_interface use entity work.tvc_dac_interface(tester);
    end for;
  end for;
end conf_tb_dac_test;
