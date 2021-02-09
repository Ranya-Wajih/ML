
 %   Hybrid Binary Grey Wolf with Harris Hawks Optimizer for
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
% % E. Emary, Hossam M.Zawbaa, AboulElla Hassanien, Binary
% grey wolf optimization approaches for feature selection, Neurocomputing172(2016)371–381.
                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%function main
%the main function calling the optimizer
global A trn vald;
clear;
clc;
 Search_Agents=10; 
 Maximum_iteration= 100;
A=load('Vote.dat');
r=randperm(size(A,1));
trn=r(1:floor(length(r)/2));
vald=r(floor(length(r)/2)+1:end);

tic
[Best_score,Best_Location, conv_Curve]=bGWOHHO(Search_Agents, ...
    Maximum_iteration,0,1,size(A,2)-1,'AccSz');
time=toc; 
printif('Acc  %f\Fitness:   %s\Dimentions: %d\Time:  %f\n', ...
    AccSz,Best_score,num2str(Best_Locatoin,'%1d'),sum(Best_Locatoin(:)),time);
