function PhowVocabulary = computePHOWVocabularyFromImageList(phowDescriptors,data_dir)
numWords = 1000 ;

descriptors = single([phowDescriptors{:}]) ;

% numDescriptors = size(descriptors,2) ;
% fprintf('%s: learning PCA rotation/projection\n', mfilename) ;
% x = bsxfun(@minus, descriptors, mean(descriptors,2)) ;
% X = x*x' / numDescriptors ;
% [V,D] = eig(X) ;
% d = diag(D) ;
% [d,perm] = sort(d,'descend') ;
% V = V(:,perm) ;
% projection = V(:,1:64)' ;
% clear X V D d ;
% descriptors = projection * descriptors ;

fprintf('Computing visual words and kdtree\n') ;
vl_twister('state', 1) ;

PhowVocabulary.words = vl_kmeans(descriptors, numWords, 'verbose', 'algorithm', 'elkan') ;
PhowVocabulary.kdtree = vl_kdtreebuild(PhowVocabulary.words) ;

cachePath = fullfile(data_dir, 'PhowVolcabulary.mat') ;
vl_xmkdir(data_dir);
save(cachePath, '-STRUCT', 'PhowVocabulary') ;

