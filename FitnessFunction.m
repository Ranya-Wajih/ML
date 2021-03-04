% Hybrid Binary Grey Wolf with Harris Hawks Optimizer for
%              Feature Selection 
%           By: Ranya Al-wajih, Said Jadid,NORSHAKIRAH AZIZ1,
%            QASEM AL-TASHI1,and NOUREEN TALPUR1 
%         
%           email: rania.wajih@gmail.com
% 
%                Main paper: Ranya Al-wajih                                 %
%         Hybrid Binary Grey Wolf with Harris Hawks Optimizer for
%                 Feature Selection 
%                           
%                                                                                      %
%  Developed in MATLAB R2017a                                             %
%                                                                         %
%  the original code of GWO is availble on
 %         e-Mail: ali.mirjalili@gmail.com                           %
%                 seyedali.mirjalili@griffithuni.edu.au             %
%                                                                   %
%       Homepage: http://www.alimirjalili.com                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I acknowledge that this version of BGWOHHO has been written using
% a  portion of the following code:
%---------------------------------------------------------------------
%  MATLAB Code for                                                      %
% Too, Jingwei, et al. “A New Competitive Binary Grey Wolf Optimizer to %
% Solve the Feature Selection Problem in EMG Signals Classification.”   %
% Computers, vol. 7, no. 4, MDPI AG, Nov. 2018, p. 58,                  %
% doi:10.3390/computers7040058.                                         %
%-------------------------------------------------------------------------%
%  Fitness Function (Error Rate) source codes demo version                %
%         
%
%-------------------------------------------------------------------------%
function fitness=FitnessFunction(feat,label,X)
if sum(X==1)==0
  fitness=inf;
else
  fitness= KNNfunction(feat(:,X==1),label);
end
end

function ER= KNNfunction(feat,label)
%---// Parameter setting for k-value of KNN //
k=5; 
%---// Parameter setting for hold-out (20% for testing set) //
h=0.2;
Model=fitcknn(feat,label,'NumNeighbors',k,'Distance','euclidean'); 
C=crossval(Model,'holdout',h);
ER= kfoldLoss(C);
end
