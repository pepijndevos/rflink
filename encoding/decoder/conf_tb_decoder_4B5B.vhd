-------------------------------------------------------------------------------
-- File: conf_tb_siso_gen_gcd.vhd
-- Description: siso_gen configuration for use of gcd architecture
-- Author: Sabih Gerez, University of Twente
-- Creation date: Sun Jul 11 01:23:24 CEST 2004
-------------------------------------------------------------------------------
-- $Rev: 8 $
-- $Author: gerezsh $
-- $Date: 2008-06-29 15:55:28 +0200 (Sun, 29 Jun 2008) $
-- $Log$
-------------------------------------------------------------------------------
-- $Log: conf_tb_siso_gen_gcd.vhd,v $
-- Revision 1.2  2004/08/10 22:43:03  sabih
-- adapted for new tvc architecture name
--
-- Revision 1.1  2004/07/10 23:46:56  sabih
-- initial check in
--
-------------------------------------------------------------------------------

configuration conf_tb_siso_gen_fourBfiveB_decoder of tb_siso_gen_top is
  for top 
    for tg: tb_siso_gen use entity work.tb_siso_gen(structure)
            generic map (word_length_in_4B5B_decoder => 10,
			 word_length_out_4B5B_decoder => 8);
      for structure
        for duv: siso_gen_4B5B_decoder use entity work.siso_gen_4B5B_decoder(fourBfiveB_decoder);
        end for;
        for tvc: tvc_siso_gen use entity work.tvc_siso_gen(file_io)
            generic map (word_length_in_4B5B_decoder => 10,
			 word_length_out_4B5B_decoder =>8,
                         in_file_name => "4B5B_decoder.in",
                         out_file_name => "4B5B_decoder.out");
        end for;
      end for;
    end for;
  end for;
end conf_tb_siso_gen_fourBfiveB_decoder;