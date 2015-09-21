function phowhistogram = removeSpatialInformation(histograms, data_dir, file)
% REMOVESPATIALINFORMATION From spatial to simple histogram
%   HISTOGRAM = REMOVESPATIALINFORMATION(HISTOGRAM) removes the
%   spatial information from the 2 x 2 spatial histogram HISTOGRAM.

phowhistogram = ...
    histograms(1:4:end,:) + ...
    histograms(2:4:end,:) + ...
    histograms(3:4:end,:) + ...
    histograms(4:4:end,:) ;

phowhistogram = phowhistogram / 4 ;
if nargin > 2
  saveH = true ;
else
  saveH = false ;
end
if saveH == true
    eval([file ' = phowhistogram;']);
    cachePath = fullfile(data_dir, [file '.mat']) ;
    vl_xmkdir(data_dir) ;
    save(cachePath, file);
end