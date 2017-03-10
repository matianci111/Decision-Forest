function [node,nodeL,nodeR] = splitNode(data,node,param, T)
% Split node

visualise = 1;

% Initilise child nodes
iter = param.splitNum;
nodeL = struct('idx',[],'model',struct,'splitfun',0,'isleaf',0,'prob',[]);
nodeR = struct('idx',[],'model',struct,'splitfun',0,'isleaf',0,'prob',[]);

if length(node.idx) <= 5 % make this node a leaf if has less than 5 data points stopping criteria
    node.isleaf = 1;
    return;
end

idx = node.idx;
data = data(idx,:);
X = data(:,1:2);
Y = data(:,end);

%initialize parameters, classifiercommitfirst is unavailable
opts.classifierID = 0;
opts.numSplits = 200;
opts.classifierCommitFirst = true;
index = [];
bestgain=0;
finalclassifier =0;
model = struct;

%train to split the data using all 4 split functions
opts.classifierID = 1;
[model1, bestgain1, final_index1, iglist1] = weakTrain(X, Y, opts);

opts.classifierID = 2;
[model2, bestgain2, final_index2, iglist2] = weakTrain(X, Y, opts);

opts.classifierID = 3;
[model3, bestgain3, final_index3, iglist3] = weakTrain(X, Y, opts);

opts.classifierID = 4;
[model4, bestgain4, final_index4, iglist4] = weakTrain(X, Y, opts);

%choose the best split function and use its models to determine future test
%data
if bestgain1>=bestgain2 && bestgain1>=bestgain3 && bestgain1>=bestgain4
    index = final_index1;
    finalclassifier=1;
    model = model1;
end
if bestgain2>=bestgain1 && bestgain2>=bestgain3 && bestgain2>=bestgain4
    index = final_index2;
    finalclassifier=2;
    model = model2;
end
if bestgain3>=bestgain2 && bestgain3>=bestgain1 && bestgain3>=bestgain4
    index = final_index3;
    finalclassifier=3;
    model = model3;
end
if bestgain4>=bestgain2 && bestgain4>=bestgain3 && bestgain4>=bestgain1
    index = final_index4;
    finalclassifier=4;
    model = model4;
end


node.splitfun = finalclassifier;
node.model = model;
nodeL.idx = idx(index);
nodeR.idx = idx(~index);

%if visualise
%    visualise_splitfunc(final_index1,data,model1.r,model1.t,bestgain1,0)
%    fprintf('Information gain = %f. \n',bestgain1);
%end

end