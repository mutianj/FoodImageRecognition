function histograms = computeColorHistogram(names, data_dir, file)
histograms = zeros(64,numel(names));
NumNames = length(names);
parfor i = 1:NumNames
    disp(i);
    im = imread(names{i});
    histograms(:, i) = color_descriptor(im);
end
eval([file ' = histograms;']);
cachePath = fullfile(data_dir, [file '.mat']) ;
vl_xmkdir(data_dir) ;
save(cachePath, file);