function [node,nodeL,nodeR] = splitNode(data,node,param, T)
% Split node

visualise = 1;

% Initilise child nodes
iter = param.splitNum;
nodeL = struct('idx',[],'t',nan,'dim',0,'prob',[]);
nodeR = struct('idx',[],'t',nan,'dim',0,'prob',[]);

if length(node.idx) <= 5 % make this node a leaf if has less than 5 data points
    node.t = nan;
    node.dim = 0;
    return;
end

idx = node.idx;
data = data(idx,:);
X = data(:,1:2);
Y = data(:,end);

opts.classifierID = 1;
opts.numSplits = 200;
opts.classifierCommitFirst = true;
g1l =[];
g2l =[];
g3l =[];
g4l =[];

g1total=0;
g2total=0;
g3total=0;
g4total=0;
for n = 1:70
opts.classifierID = 1;
[model1, bestgain1, final_index1, iglist1] = weakTrain(X, Y, opts);
g1total=g1total+bestgain1;
opts.classifierID = 2;
[model2, bestgain2, final_index2, iglist2] = weakTrain(X, Y, opts);
g2total=g2total+bestgain2;
opts.classifierID = 3;
[model3, bestgain3, final_index3, iglist3] = weakTrain(X, Y, opts);
g3total=g3total+bestgain3;
opts.classifierID = 4;
[model4, bestgain4, final_index4, iglist4] = weakTrain(X, Y, opts);
g4total=g4total+bestgain4;
end
g1a=g1total/70;
g2a=g2total/70;
g3a=g3total/70;
g4a=g4total/70;


%nodeL.idx = idx(final_index1);
%nodeR.idx = idx(~final_index1);

%if visualise
%    visualise_splitfunc(final_index1,data,model1.r,model1.t,bestgain1,0)
%    fprintf('Information gain = %f. \n',bestgain1);
%end

 end

function ig = getIG(data,idx) % Information Gain - the 'purity' of data labels in both child nodes after split. The higher the purer.
L = data(idx);
R = data(~idx);
H = getE(data);
HL = getE(L);
HR = getE(R);
ig = H - sum(idx)/length(idx)*HL - sum(~idx)/length(idx)*HR;
end

function H = getE(X) % Entropy
cdist= histc(X(:,1:end), unique(X(:,end))) + 1;
cdist= cdist/sum(cdist);
cdist= cdist .* log(cdist);
H = -sum(cdist);
end

function [node, ig_best, idx_best] = updateIG(node,ig_best,ig,t,idx,dim,idx_best) % Update information gain
if ig > ig_best
    ig_best = ig;
    node.t = t;
    node.dim = dim;
    idx_best = idx;
else
    idx_best = idx_best;
end
end