function [rbfModelPhow,rbfModelColor, rbfModelLbp, trainLabel, rbfPred, rbfProb] =...
    classification_rbf_train(label, PHOWHistogram, ColorHistogram, LBPHistogram)
trainLabel = cell(1,14);
rbfModelPhow = cell(1, 14);
rbfPredPhow = cell(1,14);
rbfProbPhow = cell(1,14);
rbfModelColor = cell(1,14);
rbfPredColor = cell(1,14);
rbfProbColor = cell(1,14);
rbfModelLbp = cell(1,14);
rbfPredLbp = cell(1,14);
rbfProbLbp = cell(1,14);
phowTrain = double(PHOWHistogram)';
colorTrain = double(ColorHistogram)';
lbpTrain = double(LBPHistogram)';
parfor i=1:14
    trainlabel = ones(size(label,1),1)*(-1);
    trainlabel(label==i)=1;
    trainLabel{i}=trainlabel;
    fprintf('Computing rbfModelPhow %f \n', i) ;
    rbfOptionPhow = rbfCrossValidation(trainlabel, phowTrain);
    rbfModelPhow{i}=libsvmtrain(trainlabel, phowTrain,rbfOptionPhow);
    [rbfPredPhow{i}, ~, rbfProbPhow{i}] = libsvmpredict(trainlabel, phowTrain,rbfModelPhow{i}, '-b 1');
    fprintf('Computing rbfModelColor %f \n', i) ;
    rbfOptionColor = rbfCrossValidation(trainlabel, colorTrain);
    rbfModelColor{i} = libsvmtrain(trainlabel, colorTrain, rbfOptionColor);
    [rbfPredColor{i}, ~, rbfProbColor{i}] = libsvmpredict(trainlabel, colorTrain,rbfModelColor{i}, '-b 1');
    fprintf('Computing rbfModelLBP %f \n', i) ;
    rbfOptionLbp = rbfCrossValidation(trainlabel, lbpTrain);
    rbfModelLbp{i} = libsvmtrain(trainlabel, lbpTrain, rbfOptionLbp);
    [rbfPredLbp{i}, ~, rbfProbLbp{i}] = libsvmpredict(trainlabel, lbpTrain,rbfModelLbp{i}, '-b 1');
end

rbfPred = cell(1,14);
rbfProb = cell(1,14);
for j=1:14
    rbfPred{j} = [rbfPredPhow{j}, rbfPredColor{j}, rbfPredLbp{j}];
    rbfProb{j} = [rbfProbPhow{j}, rbfProbColor{j}, rbfProbLbp{j}];
end

save('rbfModel2.mat', 'rbfModelPhow','rbfModelColor', 'rbfModelLbp', 'trainLabel', 'rbfPred', 'rbfProb');
