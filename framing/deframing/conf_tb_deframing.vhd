-------------------------------------------------------------------------------
-- File: conf_tb_deframing.vhd
-- Description: Test bench for deframing
-- Author: Jelle Bakker
-------------------------------------------------------------------------------

configuration conf_tb_deframing of tb_top is
  for top
    for tg: tb_deframing use entity work.tb_deframing(structure)
            generic map (word_length_deframing => 10,
			 preamble_receiver => 785,
			 deframing_length => 3000);
      for structure
        for duv: deframing use entity work.deframing(behavioral);
        end for;
        for tvc: tvc_deframing use entity work.tvc_deframing(file_io)
            generic map (word_length_deframing => 10,
			 preamble_receiver => 785,
			 deframing_length => 20,
                         in_file_name => "deframing.in",
                         out_file_name => "deframing.out");
        end for;
      end for;
    end for;
  end for;
end conf_tb_deframing;
