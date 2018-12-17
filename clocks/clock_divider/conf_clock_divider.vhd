configuration conf_clock_divider of tb_clock_divider is
      for structure
        for duv: clock_divider use entity work.clock_divider(Behavorial);
        end for;
        for tvc: tvc_clock_divider use entity work.tvc_clock_divider(clk);
        end for;
      end for;
end conf_clock_divider;