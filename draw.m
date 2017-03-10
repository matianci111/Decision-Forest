clear

load incrementingnumberofrepetition.mat
x=1:100;
plot(x,g1l,x,g2l,x,g3l,x,g4l)
title('degree of randomness vs best information gain');
legend('Axis Alignment','2D Linear','Conic Section','Decision Learner', 'location', 'southeast')