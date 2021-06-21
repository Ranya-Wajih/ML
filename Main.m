

%-------------------------------------------------------------------------%
%  Binary Grey Wolf Optimizer with Harris Hawk Optimization (BGWOBHHO) 
%                                                                         %                                    %
%-------------------------------------------------------------------------%


%---Inputs-----------------------------------------------------------------
% feat:   features
% label:  labelling
% N:      Number of particles
% T:      Maximum number of iterations
% *Note: k-value of KNN & hold-out setting can be modified in FitnessFunction.m
%---Outputs----------------------------------------------------------------
% sFeat:  Selected features
% Sf:     Selected feature index
% Nf:     Number of selected features
% curve:  Convergence curve
%--------------------------------------------------------------------------


clc, clear, close; 
% Benchmark data set 
load Exactly2.mat;

% Set 20% data as validation set
ho = 0.2; 
% Hold-out method
HO = cvpartition(label,'HoldOut',ho);

% Parameter setting
N=10; T=100;
% Binary Grey Wolf Optimizer with Harris Hawk Optimization
tic
[sFeat,Sf,Nf,Conv_curve]= BGWOHHO(feat,label,N,T);
time= toc;

%Accuracy
Acc = acc(sFeat,label,HO); 
% Plot convergence curve
figure(); plot(1:T,Conv_curve); xlabel('Number of iterations');
ylabel('Fitness Value'); title('BGWOHHO'); grid on;
fprintf('Accuracy: %f/ the hybrid Fitness: %f/the hybrid Dimensions: %f/ the hybrid Time: %f/n',Acc,mean(Conv_curve),Nf,time);
