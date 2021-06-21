%-------------------------------------------------------------------------%
%  (Error Rate) source codes demo version                %
%         
%
%-------------------------------------------------------------------------%
function fitness=get_function(feat,label,X)
if sum(X==1)==0
  fitness=inf;
else
  fitness= wrapperKNN(feat(:,X==1),label);
end
end

function ER= wrapperKNN(feat,label)
%---// Parameter setting for k-value of KNN //
k=5; 
%---// Parameter setting for hold-out (20% for testing set) //
ho=0.2;
Model=fitcknn(feat,label,'NumNeighbors',k,'Distance','euclidean'); 
C=crossval(Model,'holdout',ho);
ER=kfoldLoss(C);
end
