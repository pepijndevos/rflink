configuration conf_fir of tb_fir_top is
  for top
    for tg: tb_fir use entity work.tb_fir(structure)
      generic map (coef_scale => 4,
        w_acc => 14,
        w_out => 8,
        coef => (262, 498, 262),
        in_file_name => "data.in",
        out_file_name => "data.out");
      for structure
        for duv: fir use entity work.fir(behavioral);
        end for;
        for tvc: tvc_fir use entity work.tvc_fir(file_io);
        end for;
      end for;
    end for;
  end for;
end conf_fir;