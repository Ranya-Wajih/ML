% Hybrid Binary Grey Wolf with Harris Hawks Optimizer for           %
%              Feature Selection                                    %
%           By: Ranya Al-wajih, Said Jadid,NORSHAKIRAH AZIZ,        %
%            QASEM AL-TASHI,and NOUREEN TALPUR                      %
%                                                                   %
%           email: rania.wajih@gmail.com                            %
%                                                                   %
%                Main paper: Ranya Al-wajih                         %
%         Hybrid Binary Grey Wolf with Harris Hawks Optimizer for   %
%                 Feature Selection b                               %
%                                                                   %
%      IEEE Access DOI:    10.1109/ACCESS.2021.3060096              %
%      URL: https://ieeexplore.ieee.org/document/9356609            %       
%                                                                   %                   %
%  Developed in MATLAB R2019b                                       %
%                                                                   %
%  the original code of GWO is availble on                          %
 %         e-Mail: ali.mirjalili@gmail.com                          %
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
%-----------------------------------------------------------------------%



function [sFeat,Sf,Nf, Conv_curve]= BGWOHHO(feat, label, N, T)

fun=@FitnessFunction; 
D=size(feat,2); X=zeros(N,D); 
for i=1:N
  for d=1:D
    if rand() > 0.5
      X(i,d)=1;
    end
  end
end

 FitR=inf; 
fit=zeros(1,N);
for i=1:N
  fit(i)=fun(feat,label,X(i,:));
end 
ub=1; lb=0; t=1; Conv_curve=inf;  
[~,idx]=sort(fit,'ascend');   
Xalpha=X(idx(1),:); Xbeta=X(idx(2),:); Xdelta=X(idx(3),:);
Fitalpha=fit(idx(1)); Fitbeta=fit(idx(2)); Fitdelta=fit(idx(3));

figure(1); clf; axis([1 100 0 0.3]); xlabel('Number of iterations');
ylabel('Fitness Value'); title('Convergence Curve'); grid on;

while t <= T 
  for i=1:N
    fit(i)=fun(feat,label,X(i,:));
    if fit(i) < FitR
      FitR=fit(i); Xp=X(i,:);
    end
  end
 
 Xm=mean(X,1);
  for i=1:N 
a=2-2*(t/T);
A=2*a*rand()-a;
   %% Exploration 
    if abs(A) >= 1
      r=rand(); 
   
      %perching based on Random location 
      if r >= 0.5
          rand_Hawk_index= floor(N*rand()+1);
          X_rand=X(rand_Hawk_index,:);
          r1= rand(); C=2*rand();
        for d=1:D
          X(i,:)=X_rand-rand*r1*abs(X_rand -rand()-2*C*X(i,d));
        end
        %perching based on other family member
      elseif r < 0.5
        r3=rand(); C=2*rand();
        for d=1:D
          X(i,:)=(Xp(1,:)-Xm(d))-r3*(lb+C*(ub-lb));
        end
      end
       %% expoiltation 
    elseif abs(A) < 1
         
          %update the vlaue of C factor 
            C1=2*rand(); C2=2*rand(); C3=2*rand();
            %update the value of A factor 
               A1=2*a*rand()-a; A2=2*a*rand()-a; A3=2*a*rand()-a;
               
             Dalpha=abs(C1*Xalpha(d)-X(i,d));
             Dbeta=abs(C2*Xbeta(d)-X(i,d));
             Ddelta=abs(C3*Xdelta(d)-X(i,d));
         
         
            X1=Xalpha(d)-A1*Dalpha; X2=Xbeta(d)-A2*Dbeta; 
            X3=Xdelta(d)-A3*Ddelta;
            
      Xav=(X1+X2+X3)/3; 
      %transfer function
      Bin_transfer=1/(1+exp(-10*(Xav-0.5)));
      if Bin_transfer >= rand()
        X(i,d)=1; 
      else
        X(i,d)=0; 
      end
    end
    fit(i)=fun(feat,label,X(i,:)); 
    if fit(i) < Fitalpha
      Fitalpha=fit(i); Xalpha=X(i,:);
    end
    if fit(i) < Fitbeta && fit(i) > Fitalpha
      Fitbeta=fit(i); Xbeta=X(i,:);
    end
    if fit(i) < Fitdelta && fit(i) > Fitalpha && fit(i) > Fitbeta
      Fitdelta=fit(i); Xdelta=X(i,:);
    end
  Conv_curve(t)=FitR; 
  pause(1e-20); hold on;
  CG=plot(t,FitR,'Color','r','Marker','.'); set(CG,'MarkerSize',5);
  t=t+1;
   end
Pos=1:D; Sf=Pos(Xp==1); Nf=length(Sf); sFeat=feat(:,Sf);
end

end 