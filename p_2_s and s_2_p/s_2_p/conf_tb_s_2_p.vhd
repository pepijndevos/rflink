configuration conf_tb_s_2_p of tb_buffer_top is
  for top 
    for tg: tb_buffer use entity work.tb_buffer(structure)
            generic map (word_length_deframing => 10,
			 preamble_receiver => 785,
			 deframing_length => 3000);
      for structure
        for duv: deframing use entity work.deframing(behavioral);
        end for;
        for duv2: s_2_p use entity work.s_2_p(behavioral);
        end for;
        for tvc: tvc_buffer use entity work.tvc_buffer(file_io)
            generic map (word_length_deframing => 10,
			 word_length_buffer => 10,
			 preamble_receiver => 785,
			 deframing_length => 3000,
                         in_file_name => "deframing.in",
                         out_file_name => "buffer.out");
        end for;
      end for;
    end for;
  end for;
end conf_tb_s_2_p;
