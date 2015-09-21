function lbphistograms = computeLBPHistogramFromImageList(names, vocabulary, data_dir, file)
start = tic ;
lbphistograms = cell(1,numel(names)) ;
parfor i = 1:length(names)
  if exist(names{i}, 'file')
    fullPath = names{i} ;
  else
    fullPath = fullfile('data','images',[names{i} '.jpg']) ;
  end
  fprintf('Extracting histogram from %s (time remaining %.2fs)\n', fullPath, ...
          (length(names)-i) * toc(start)/i) ;
  lbphistograms{i} = computeLBPHistogramFromImage(vocabulary, fullPath) ;
end
lbphistograms = [lbphistograms{:}] ;

eval([file ' = lbphistograms;']);
cachePath = fullfile(data_dir, [file '.mat']) ;
vl_xmkdir(data_dir) ;
save(cachePath, file);
