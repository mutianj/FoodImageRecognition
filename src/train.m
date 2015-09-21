setup;
image_dir = '/Users/Ji/Documents/imageOrg';
class_list = cellstr(['apple     ';'banana    ';'broccoli  ';'burger    ';'cookie    ';
    'egg       ';'frenchfry ';'hotdog    ';'pasta     ';'pizza     ';'rice      ';
    'salad     ';'strawberry';'tomato    ']);
data_dir = strcat(image_dir, 'data');

% NumFiles = length(dir(fullfile(image_dir,'*.jpeg')));

% name = cell(NumFiles,1);
% label = NaN * ones(NumFiles,1);
% NumImgs = NaN * ones(14,1);
% Count = 0;
% for i=1:14
%     ClassNames = dir(fullfile(image_dir,[class_list{i} '*.jpeg*']));
%     NumImgs(i) = length(ClassNames);
%     for j=1:NumImgs(i)
%         Count  = Count + 1;
%       name{Count,1}=fullfile(image_dir,ClassNames(j).name);
%       label(Count) = i;
%     end
% end
%%
% TrainPercent = 0.3;
% 
% TrainCount = 0;
% TestCount = 0;
% TrainIndices = NaN * ones(NumFiles,1);
% TestIndices = NaN * ones(NumFiles,1);
% 
% for i=1:14
%     s = RandStream('mt19937ar','Seed',0);    
%     ClassIndices = find(label==i);
%     RandIndClass = randperm(s,NumImgs(i));
%     TrainSize = round(TrainPercent * NumImgs(i));
%     TestSize = NumImgs(i) - TrainSize;
%     TrainIndices(TrainCount+1:TrainCount+TrainSize) = ClassIndices(RandIndClass(1:TrainSize));
%     TestIndices(TestCount+1:TestCount+TestSize) = ClassIndices(RandIndClass(TrainSize+1:end));
%     TrainCount = TrainCount+TrainSize;
%     TestCount = TestCount + TestSize;
% end
% 
% TrainIndices = TrainIndices(1:TrainCount);
% TestIndices = TestIndices(1:TestCount);
% save('TrainTestIndices30p.mat','TrainIndices','TestIndices');
%%
% load('TrainTestIndices30p.mat'); % Loads 'TrainIndices','TestIndices')
% 
%     TrainNames = name(TrainIndices);
%     TrainLabels = label(TrainIndices);
%     TestNames = name(TestIndices);
%     TestLabels = label(TestIndices);
%     
%%
Name = load('NameLabels.mat');
TrainNames = Name.name;
TrainLabel = Name.label;

% PHOW descriptor Bag-of-Vocabulary
% load('/Users/Ji/Documents/imageOrgdata/PhowDescriptors.mat');
phowVocabulary = computePHOWVocabularyFromImageList(phowDescriptors, data_dir);
PHOWTrainHistograms = computeHistogramsFromImageList(phowVocabulary, TrainNames);
phowTrainHistogram = removeSpatialInformation(PHOWTrainHistograms, data_dir, 'phowTrainHistogram');

% LBP descriptor
% load('/Users/Ji/Documents/imageOrgdata/LBPDescriptors.mat'); % LBPDescriptors;
LBPTrainVocabulary = computeLBPVocabularyFromImageList(lbpDescriptors, data_dir);
lbpTrainHistogram = computeLBPHistogramFromImageList(TrainNames,LBPTrainVocabulary, data_dir, 'lbpTrainHistogram');

% Color descriptor
load('/Users/Ji/Documents/imageOrgdata/ColorDescriptors.mat'); % colorDescriptors

% linear SVM with RBF kernel training
[rbfModelPhow, rbfModelColor,rbfModelLbp, trainLabel, rbfPred, rbfProb] =...
    classification_rbf_train(TrainLabel, phowTrainHistogram, ColorDescritpors, lbpTrainHistogram);
% rbfModel.mat: rbfModelPhow, rbfModelColor, rbfModelLbp, rbfPred;

% liner SVM with intercept kernel training
[interModelPhow, interModelColor,interModelLbp, interPred, interProb] = ...
    classification_inter_train(TrainLabel, phowTrainHistogram, ColorDescritpors, lbpTrainHistogram);

% interModel.mat: interModelPhow, interModelColor, interModelLbp, intPred
rbfProb1=rbfProb(:,[1,3,5]);
interProb1=interProb(:,[1,3,5]);
% Model Fusion
ensPred = ensemble_train(trainLabel, rbfPred, interPred);
ensProb = ensemble_train(trainLabel, rbfProb, interProb);
% ensemble.mat: ens;


