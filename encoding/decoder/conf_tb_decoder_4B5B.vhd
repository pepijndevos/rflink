-------------------------------------------------------------------------------
-- File: conf_tb_decoder_4B5B.vhd
-- Description: 8B10B test bench
-- Author: Big Boss Bakker
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
