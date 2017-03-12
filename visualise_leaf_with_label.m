function visualise_leaf_with_label(trees, leaves)
for L = 1:9
try
subplot(3,3,L);
if L <= size(leaves,2)
    what = leaves(1,L);
    tmp = trees(1).prob(leaves(1,L),:);
    bar(tmp);
    axis([0.5 3.5 0 1]);
end
end
end