function ens = ensemble_train(trainLabel, rbfPred, intPred)
ens = cell(1,14);
for i=1:14
    X = [rbfPred{i}, intPred{i}];
    Y = trainLabel{i};
    ens{i} = fitensemble(X,Y,'GentleBoost',300, 'Tree');
end
