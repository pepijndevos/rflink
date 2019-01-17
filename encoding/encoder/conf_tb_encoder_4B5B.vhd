-------------------------------------------------------------------------------
-- File: conf_tb_encoder_4B5B.vhd
-- Description: Test bench for 8B10B encoding
-- Author: Big Boss Bakker
-------------------------------------------------------------------------------

configuration conf_tb_siso_gen_fourBfiveB_encoder of tb_siso_gen_top is
  for top
    for tg: tb_siso_gen use entity work.tb_siso_gen(structure)
            generic map (word_length_in_4B5B_encoder => 8,
			 word_length_out_4B5B_encoder => 10);
      for structure
        for duv: 4B5B_encoder use entity work.4B5B_encoder(fourBfiveB_encoder);
        end for;
        for tvc: tvc_siso_gen use entity work.tvc_siso_gen(file_io)
            generic map (word_length_in_4B5B_encoder => 8,
			 word_length_out_4B5B_encoder =>10,
                         in_file_name => "4B5B_encoder.in",
                         out_file_name => "4B5B_encoder.out");
        end for;
      end for;
    end for;
  end for;
end conf_tb_siso_gen_fourBfiveB_encoder;
