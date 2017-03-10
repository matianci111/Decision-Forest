[data_train, data_test] = getData('Toy_Spiral'); % {'Toy_Gaussian', 'Toy_Spiral', 'Toy_Circle', 'Caltech'}

param.num = 1;         % Number of trees
%note that the maximum needed depth is around 10
param.depth = 10;        % trees depth
param.splitNum = 15;     % Number of split functions to try
param.split = 'IG';     % Currently support 'information gain' only

trees = growTrees(data_train,param);

% Q1 train decision forest
