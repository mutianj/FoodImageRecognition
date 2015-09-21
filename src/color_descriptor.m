function bin = color_descriptor(img)
% Create a 64-bin histogram descriptor for normailized r and g

r = double(img(:,:,1));
g = double(img(:,:,2));
b = double(img(:,:,3));
r_norm = r(:)./(r(:)+g(:)+b(:));
g_norm = g(:)./(r(:)+g(:)+b(:));
bin = linspace(0,1,32);
rbin = histc(r_norm, bin)/(size(r,1)*size(r,2));
gbin = histc(g_norm, bin)/(size(g,1)*size(g,2));
bin = [rbin', gbin']';

