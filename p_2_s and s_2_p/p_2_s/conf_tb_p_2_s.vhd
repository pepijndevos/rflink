configuration conf_tb_unbuffer of tb_unbuffer_top is  
  for top 
    for tg: tb_unbuffer use entity work.tb_unbuffer(structure)
            generic map (word_length_unbuffer => 10);
      for structure
        for duv: unbuffer use entity work.p_2_s(behavioral);
        end for;
        for tvc: tvc_unbuffer use entity work.tvc_unbuffer(file_io)
            generic map (word_length_unbuffer => 10,
             in_file_name => "p_2_s.in",
             out_file_name => "p_2_s.out");
        end for;
      end for;
    end for;
  end for;
end conf_tb_unbuffer;
