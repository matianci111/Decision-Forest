for p=1:5
[data_train, data_test] = getData('Toy_Spiral'); % {'Toy_Gaussian', 'Toy_Spiral', 'Toy_Circle', 'Caltech'}
visualise = 0;
param.num = 30;         % Number of trees
param.splitNum = 70;     % Degree of randomness
param.split = 'IG';     % IGNORE THIS, NOT USEFUL
param.classID = 5; % 4 is distancelearner, the other three are shown in the weakTrain.m file
param.classID = p;
%stopping criteria
param.depth = 10;        % trees depth
param.emptypercentage = 0.05;
param.stopprob = 0.6;
trees = growTrees(data_train,param);

%test_point = [-.5 -.7; .4 .3; -.7 .4; .5 -.5];
for n=1:size(data_test,1)
    %leaves stand for which leave does a single test point come out from
    leaves = testTrees([data_test(n,1:end-1) 0],trees);
    % average the class distributions of leaf nodes of all trees
    p_rf = trees(1).prob(leaves,:);
    p_rf_sum = sum(p_rf)/length(trees);

    %rf{n,1 } = p_rf
    
    rf_sumlist(:,n) = p_rf_sum;
    %rf_geolist(:,n) = p_rf_geomean;
    [val, index] = max(p_rf_sum);
    output_data(n,:) = [data_test(n,1:end-1) index val];
    %{
    if visualise
        figure;
        visualise_leaf_with_label(trees, leaves);
        subplot(3,3,5);
        bar(p_rf_sum);
    end
    %}
end
subplot(2,3,p);
plot_toydata(data_train);
%(output_data(:,3)&1) (output_data(:,3)&2) (output_data(:,3)&3)
h = scatter(output_data(:,1),output_data(:,2),[],[((output_data(:,3)==1).*output_data(:,4)) ((output_data(:,3)==2).*output_data(:,4)) ((output_data(:,3)==3).*output_data(:,4))], 'filled');
uistack(h, 'bottom');
end
% Q1 train decision forest
