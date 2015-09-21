function [kernel, options] = interCrossValidation(trainlabel, traindata)
kernel = hist_isect_c(traindata,traindata);
kernel = [(1:size(kernel,1))',kernel];
bestc=200;bestg=2;
bestcv=0;
for log2c = -1:8,
  for log2g = -1:0.5:2,
    cmd = ['-s 0 -t 4 -h 0 -w1 10 -w-1 1 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
    cv = do_binary_cross_validation(trainlabel, kernel, cmd, 5);
    if (cv > bestcv),
      bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
    end
    fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
  end
end
options=sprintf('-s 0 -t 4 -h 0 -w1 10 -w-1 1 -c %f -b 1 -g %f',bestc,bestg);