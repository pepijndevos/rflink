configuration conf_tb_p_2_s of tb_p_2_s_top is  
  for top 
    for tg: tb_p_2_s use entity work.tb_p_2_s(structure)
            generic map (word_length_unbuffer => 10);
      for structure
        for duv: p_2_s use entity work.p_2_s(behavioral);
        end for;
        for tvc: tvc_p_2_s use entity work.tvc_p_2_s(file_io)
            generic map (word_length_unbuffer => 10,
             in_file_name => "p_2_s.in",
             out_file_name => "p_2_s.out");
        end for;
      end for;
    end for;
  end for;
end conf_tb_p_2_s;
