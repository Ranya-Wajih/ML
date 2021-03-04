
 %Hybrid Binary Grey Wolf with Harris Hawks Optimizer for
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
% Conv_curve:  Convergence curve
%--------------------------------------------------------------------------


clc, clear, close; 
% Benchmark data set 
load Zoo.mat; 
% Parameter setting
N=10; T=100;
% Binary Grey Wolf Optimizer with Harris Hawk Optimization
tic
[sFeat,Sf,Nf,Conv_curve]= BGWOHHO(feat,label,N,T);
time=toc;

% Plot convergence curve
figure(); 
plot(1:T,Conv_curve); xlabel('Number of iterations');
ylabel('Fitness Value'); title('BGWOHHO'); grid on;
fprintf('thybridDimensions: %f\thybrid Fitness:  %f\thybridTime: %f\n',...,
    Nf,mean(Conv_curve),time);

