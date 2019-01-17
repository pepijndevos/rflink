-------------------------------------------------------------------------------
-- File: conf_tb_framing.vhd
-- Description: Test bench for framing
-- Author: Big Boss Bakker
-------------------------------------------------------------------------------


configuration conf_tb_framing of tb_framing_top is
  for top
    for tg: tb_framing use entity work.tb_framing(structure)
            generic map (word_length_framing => 10,
			 preamble_transmitter => 785,
			 framing_length => 3000);
      for structure
        for duv: framing use entity work.framing(behavioral);
        end for;
        for tvc: tvc_framing use entity work.tvc_framing(file_io)
            generic map (word_length_framing => 10,
			 preamble_transmitter => 785,
			 framing_length => 3000,
                         in_file_name => "framing.in",
                         out_file_name => "framing.out");
        end for;
      end for;
    end for;
  end for;
end conf_tb_framing;
