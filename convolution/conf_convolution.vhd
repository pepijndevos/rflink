configuration conf_convolution of tb_convolution is
      for structure
        for duv: convolution use entity work.convolution(Behavorial);
        end for;
		  for tvc : SignalFromLookUp use entity work.SignalFromLookUp(Behavorial);
        end for;
      end for;
end conf_convolution;