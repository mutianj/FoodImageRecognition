%% Input:
img ='/Users/Ji/Documents/imageOrg/banana_n07753592_562.JPEG'; % add address of a new image

setup;
load('trainDescriptors.mat');
load('ensemble.mat');
load('rbfModel.mat');
load('interModel.mat');

im = imread(img);
colorH = color_descriptor(im);
phowH = computeHistogramFromImage(phowVocabulary, im);
phowH = double(removeSpatialInformation(phowH));
lbpH = computeLBPHistogramFromImage(LBPTrainVocabulary,im);
kernel_test1 = hist_isect_c(phowH',double(phowTrainHistogram)');
kernel_test1 = [(1:size(kernel_test1,1))',kernel_test1];
kernel_test2 = hist_isect_c(colorH',double(colorDescriptors)');
kernel_test2 = [(1:size(kernel_test2,1))',kernel_test2];
kernel_test3 = hist_isect_c(lbpH',double(lbpTrainHistogram)');
kernel_test3 = [(1:size(kernel_test3,1))',kernel_test3];

pred = zeros(14,1);
for class = 1:14
	rbfPredPhow = libsvmpredict(double(class), phowH',rbfModelPhow{class});
	rbfPredColor = libsvmpredict(class, colorH',rbfModelColor{class});
	rbfPredLbp = libsvmpredict(class, lbpH', rbfModelLbp{class});
	interPredPhow = libsvmpredict(class, kernel_test1,interModelPhow{class});
	interPredColor = libsvmpredict(class, kernel_test2,interModelColor{class});
	interPredLbp = libsvmpredict(class, kernel_test3,interModelLbp{class});
	X=[rbfPredPhow,rbfPredColor,rbfPredLbp,interPredPhow,interPredColor,interPredLbp];
	pred(class)=predict(ens{class},X);
end