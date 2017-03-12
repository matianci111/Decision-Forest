[data_train, data_test] = getData('Toy_Spiral'); % {'Toy_Gaussian', 'Toy_Spiral', 'Toy_Circle', 'Caltech'}
visualise = 1;
param.num = 4;         % Number of trees
param.splitNum = 200;     % Degree of randomness
param.split = 'IG';     % IGNORE THIS, NOT USEFUL
param.classID = 4; % 4 is distancelearner, the other three are shown in the weakTrain.m file
%stopping criteria
param.depth = 10;        % trees depth
param.emptypercentage = 0.05;
param.stopprob = 0.8;

trees = growTrees(data_train,param);

test_point = [-.5 -.7; .4 .3; -.7 .4; .5 -.5];

for n=1:4
    %leaves stand for which leave does a single test point come out from
    leaves = testTrees([test_point(n,:) 0],trees);
    leaveslist(:,n) = leaves;
    % average the class distributions of leaf nodes of all trees
    p_rf = trees(1).prob(leaves,:);
    p_rf_sum = sum(p_rf)/length(trees);

    rf{n,1 } = p_rf
    
    rf_sumlist(:,n) = p_rf_sum;
    rf_geolist(:,n) = p_rf_geomean;
    
    if visualise
        figure;
        visualise_leaf_with_label(trees, leaves);
        subplot(3,3,5);
        bar(p_rf_sum);
    end
end
% Q1 train decision forest
