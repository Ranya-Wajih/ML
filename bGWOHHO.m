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
%  MATLAB Code for                                                  %
%                                                                   %
% % E. Emary, Hossam M.Zawbaa, AboulElla Hassanien, Binary
% grey wolf optimization approaches for feature selection, Neurocomputing172(2016)371–381.
                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [Alpha_score,Alpha_pos]=bGWOHHO(Nagents,NIter,fobj) 
%Nagents: Is the number of wolves to be used
%NIter: is the total number of iterations to run the algorithm
%dim: is a scalar representing the problem dimension
%fobj: is a string representing the fitness function


Alpha_score=inf;
Beta_score=inf;
Delta_score=inf;
Prey_score=inf;

Alpha_pos=zeros(1,:);
Delta_pos=zeros(1,:);
Beta_pos=zeros(1,:);
Prey_pos=zeros(1,:);

Positions=initialization(Nagents,1,0)>0.5;

Convergence_curve=zeros(1,NIter);
ub=1; lb=0;
t=0;
while t<NIter
     for i=1:size(X,1)
    
        % fitness of locations
        fitness=fobj(X(i,:));
        % Update the location of Alpha
        if fitness<Prey_score
            Prey_score=fitness;
            Prey_pos=X(i,:);
        end
    end
    
  a=2-t*((2)/NIter);
A=2*a*rand()-a; 
       
     if abs(A)>=1
            %% Exploration:
            % Harris' hawks perch randomly based on 2 strategy:
            
            r=rand();
            rand_Hawk_index = floor(N*rand()+1);
            X_rand = X(rand_Hawk_index, :);
            X=zeros(1,:);
            if r<0.5
                % perch based on other family members
                X(i,:)=X_rand-rand()*abs(X_rand-2*rand()*X(i,:));
            elseif r>=0.5
                % perch on a random tall tree (random site inside group's home range)
                X(i,:)=(Prey_pos(1,:)-mean(X))-rand()*((ub-lb)*rand+lb);
            end
     elseif abs(A)<1  
     %% Exploitation:
     Positions(i,1)=CrossOver(X1,X2,X3); %equation 23 in paper
            
    for i=1:size(Positions,1)             
        fitness=feval(fobj,Positions(i,:));
        
        if fitness<Alpha_score 
            Alpha_score=fitness;
            Alpha_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness<Beta_score 
            Beta_score=fitness;
            Beta_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness>Beta_score && fitness<Delta_score 
            Delta_score=fitness; 
            Delta_pos=Positions(i,:);
        end
    end
     for i=1:size(position,1)% 
         for j=1:size(position,2)
       C1=2*rand();  A1=2*a*rand()-a;
       C2=2*rand();  A2=2*a*rand()-a;
       C3=2*rand(); A3=2*a*rand()-a;
        
               
             Alpha_score=abs(C1*Alpha_pos(1)-X(i,j));
              Beta_score=abs(C2*Beta_pos(1)-X(i,j));
             Delta_score=abs(C3*Delta_pos(1)-X(i,j));
         
         
            X1=Alpha_pos(j)-A1*Alpha_score;
            X2=Beta_pos(j)-A2*Beta_score; 
            X3=Delta_pos(j)-A3*Delta_score;
         
      X_av=(X1+X2+X3)/3; 
     
      T_Function=1/(1+exp(-10*(X_av-0.5))); %transfer function
      if T_Function >= rand()
        T_Function=1; 
      else
        T_Function=0; 
      end
      Positions(i,j)=T_Function;% Equation (3
        end 
     end      
            
            
          fprintf('%f:\t',Alpha_score);
        fprintf('%d',Alpha_pos(:));
        fprintf('\n');
    end
  
        
          t=t+1;    
  Convergence_curve(l)=Alpha_score;
end
        

   
    end
    



