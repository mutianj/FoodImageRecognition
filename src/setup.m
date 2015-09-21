% SETUP  Add the required search paths to MATLAB
if exist('vl_version') ~= 3, run('vlfeat/toolbox/vl_setup') ; end
run('libsvm/matlab/make');
addpath('libsvm');
addpath('libsvm/matlab');
mex hist_isect_c.c -lm;