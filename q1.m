init;

[data_train, data_test] = getData('Toy_Spiral'); % {'Toy_Gaussian', 'Toy_Spiral', 'Toy_Circle', 'Caltech'}

param.num = 4;         % Number of trees
param.depth = 2;        % trees depth
param.splitNum = 1;     % Number of split functions to try
param.split = 'IG';     % Currently support 'information gain' only

trees = growTrees(data_train,param);

% Q1 train decision forest
