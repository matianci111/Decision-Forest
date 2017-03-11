[data_train, data_test] = getData('Toy_Spiral'); % {'Toy_Gaussian', 'Toy_Spiral', 'Toy_Circle', 'Caltech'}

param.num = 4;         % Number of trees
param.splitNum = 200;     % Degree of randomness
param.split = 'IG';     % Currently support 'information gain' only

%stopping criteria
param.depth = 10;        % trees depth
param.emptypercentage = 0.05;
param.stopprob = 0.8;

trees = growTrees(data_train,param);
visualise_leaf(trees);

test_point = [-.5 -.7; .4 .3; -.7 .4; .5 -.5];

for n=1:4
    leaves = testTrees([test_point(n,:) 0],trees);
    % average the class distributions of leaf nodes of all trees
    p_rf = trees(1).prob(leaves,:);
    p_rf_sum = sum(p_rf)/length(trees);
    p1{n,1 } = p_rf
    
    rf_sumlist(:,n) = p_rf_sum;
end
% Q1 train decision forest
