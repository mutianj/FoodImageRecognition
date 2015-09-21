function [interModelPhow, interModelColor,interModelLbp, interPred, interProb] = ...
    classification_inter_train(label, PHOWHistogram, ColorHistogram, LBPHistogram)
interModelPhow = cell(1, 14);
interPredPhow = cell(1,14);
interProbPhow = cell(1,14);
interModelColor = cell(1,14);
interPredColor = cell(1,14);
interProbColor = cell(1,14);
interModelLbp = cell(1,14);
interPredLbp = cell(1,14);
interProbLbp = cell(1,14);
phowTrain = double(PHOWHistogram)';
colorTrain = double(ColorHistogram)';
lbpTrain = double(LBPHistogram)';
kernelTest1 = hist_isect_c(phowTrain,phowTrain);
kernelTest1 = [(1:size(kernelTest1,1))',kernelTest1];
kernelTest2 = hist_isect_c(colorTrain,colorTrain);
kernelTest2 = [(1:size(kernelTest2,1))',kernelTest2];
kernelTest3 = hist_isect_c(lbpTrain,lbpTrain);
kernelTest3 = [(1:size(kernelTest3,1))',kernelTest3];
parfor i=1:14
    trainlabel = ones(size(label,1),1)*(-1);
    trainlabel(label==i)=1;
    [kernelTrainPhow,interOptionPhow] = interCrossValidation(trainlabel, phowTrain);
    interModelPhow{i}=libsvmtrain(trainlabel, kernelTrainPhow,interOptionPhow);
    [interPredPhow{i}, ~, interProbPhow{i}] = libsvmpredict(trainlabel, kernelTest1,interModelPhow{i}, '-b 1');
    [kernelTrainColor,interOptionColor] = interCrossValidation(trainlabel, colorTrain);
    interModelColor{i} = libsvmtrain(trainlabel, kernelTrainColor, interOptionColor);
    [interPredColor{i}, ~, interProbColor{i}] = libsvmpredict(trainlabel, kernelTest2,interModelColor{i}, '-b 1');
    [kernelTrainLbp,interOptionLbp] = interCrossValidation(trainlabel, lbpTrain);
    interModelLbp{i} = libsvmtrain(trainlabel, kernelTrainLbp, interOptionLbp);
    [interPredLbp{i}, ~, interProbLbp{i}] = libsvmpredict(trainlabel, kernelTest3,interModelLbp{i}, '-b 1');
end

interPred = cell(1,14);
interProb = cell(1,14);
for j=1:14
    interPred{j} = [interPredPhow{j}, interPredColor{j}, interPredLbp{j}];
    interProb{j} = [interProbPhow{j}, interProbColor{j}, interProbLbp{j}];
end

save('intModel2.mat','interModelPhow', 'interModelColor','interModelLbp', 'interPred', 'interProb');