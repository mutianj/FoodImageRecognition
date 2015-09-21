function lbpVocabulary = computeLBPVocabularyFromImageList(LBPDescriptors, data_dir)
numWords = 1000 ;

fprintf('Computing visual words and kdtree\n') ;
descriptors = single([LBPDescriptors{:}]) ;
lbpVocabulary.words = vl_kmeans(descriptors, numWords, 'verbose', 'algorithm', 'elkan') ;
lbpVocabulary.kdtree = vl_kdtreebuild(lbpVocabulary.words) ;
cachePath = fullfile(data_dir, 'LBPVolcabulary.mat') ;
vl_xmkdir(data_dir);
save(cachePath, '-STRUCT', 'lbpVocabulary') ;