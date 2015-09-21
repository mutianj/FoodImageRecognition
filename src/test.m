% % 'apple':    1;
% % 'banana':   2;
% % 'broccoli'  3;
% % 'burger'    4;
% % 'cookie'    5;
% % 'egg'       6;
% % 'frenchfry' 7;
% % 'hotdog'    8;
% % 'pasta'     9;
% % 'pizza'     10;
% % 'rice'      11;
% % 'salad'     12;
% % 'strawberry'13;
% % 'tomato'    14;

% setup;
% load('trainDescriptors.mat');
% load('ensemble.mat');
% load('rbfModel.mat');
% load('interModel.mat');

datadir = ('/Users/Ji/Documents/image_comdata/');
for i=1:260
    testName{i} = strcat(datadir,ImageName{i});
end;

load('testNameLabel.mat');

finalProb = zeros(260, 14);
Score = zeros(260,14);
for i=1:260  
    im = imread(testName{i});
    colorH = color_descriptor(im);
    phowH = computeHistogramFromImage(phowVocabulary, im);
    phowH = double(removeSpatialInformation(phowH));
    lbpH = computeLBPHistogramFromImage(LBPTrainVocabulary,im);
    kernel_test1 = hist_isect_c(phowH',double(phowTrainHistogram)');
    kernel_test1 = [(1:size(kernel_test1,1))',kernel_test1];
    kernel_test2 = hist_isect_c(colorH',double(ColorDescriptors)');
    kernel_test2 = [(1:size(kernel_test2,1))',kernel_test2];
    kernel_test3 = hist_isect_c(lbpH',double(lbpTrainHistogram)');
    kernel_test3 = [(1:size(kernel_test3,1))',kernel_test3];
    parfor class=1:14
        rbfPredPhow = libsvmpredict(double(class), phowH',rbfModelPhow{class});
        rbfPredColor = libsvmpredict(class, colorH',rbfModelColor{class});
        rbfPredLbp = libsvmpredict(class, lbpH', rbfModelLbp{class});

        interPredPhow = libsvmpredict(class, kernel_test1,interModelPhow{class});
        interPredColor = libsvmpredict(class, kernel_test2,interModelColor{class});
        interPredLbp = libsvmpredict(class, kernel_test3,interModelLbp{class});

        X=[rbfPredPhow,rbfPredColor,rbfPredLbp,interPredPhow,interPredColor,interPredLbp];
        [finalProb(i, class),score]=predict(ensPred{class},X);
        Score(i,class) = abs(score(1));
    end
end

rate = zeros(14,1);
for i=1:14
    trueP = 0;
    trueN = 0;
    Pos = 0;
    Neg = 0;
    for j=1:260
        if testLabel(j,i)==1
            Pos =Pos+1;
            if finalProb(j,i)==1
                trueP = trueP+1;
            end
        end
        if testLabel(j,i)==0
            Neg = Neg+1;
            if finalProb(j,i)==-1
                trueN = trueN+1;
            end
        end
    end
    rate(i) = trueP/Pos;
end