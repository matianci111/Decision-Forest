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
opts.numSplits = 100;
opts.classifierCommitFirst = true;

[model, bestgain, final_index, iglist] = weakTrain(X, Y, opts);

nodeL.idx = idx(final_index);
nodeR.idx = idx(~final_index);

if visualise
    visualise_splitfunc(final_index,data,model.r,model.t,bestgain,0)
    fprintf('Information gain = %f. \n',bestgain);
end

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