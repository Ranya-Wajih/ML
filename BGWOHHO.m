 
%       Hybrid Binary Grey Wolf with Harris Hawks Optimizer for
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
%  Developed in MATLAB R2019a                                             %
%                                                                         %
%  the original code of GWO is availble on                                %
%                                                                         %
%       Homepage: https://github.com/JingweiToo/Binary-Grey-Wolf-Optimization-for-Feature-Selection.git                          %
%
%  the original code of HHO is available on 
%      Homepage:
%_________________________________________________________________________%
% I acknowledge that this version of BGWOPSO has been written using
% a large portion of the following code:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  Hybrid Algorithm of Particle Swarm Optimization and Grey
%      Wolf Optimizer for Improving Convergence Performance         %
%                                                                   %
%                                                                   %
%  According to:                                                    %
%  Narinder Singh and S. B. Singh, November 2017                    %

%                      narindersinghgoria@ymail.com                 %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





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

fitR=inf; 
fit=zeros(1,N);
for i=1:N
  fit(i)=fun(feat,label,X(i,:));
end 
ub=1; lb=0; t=1; Conv_curve=inf;  
[~,idx]=sort(fit,'ascend');   
Xalpha=X(idx(1),:); Xbeta=X(idx(2),:); Xdelta=X(idx(3),:);
Fitalpha=fit(idx(1)); Fitbeta=fit(idx(2)); Fitdelta=fit(idx(3));

figure(1); clf; axis([1 100 0 0.2]); xlabel('Number of iterations');
ylabel('Fitness Value'); title('Convergence Curve'); grid on;

while t <= T
%      a=2-2*(t/T); 
  for i=1:N
    fit(i)=fun(feat,label,X(i,:));
    if fit(i) < fitR
      fitR=fit(i); Xp=X(i,:);
    end
  end
 Xm=mean(X,1);
  for i=1:N
%     E0=-1+2*rand();
%     E=2*E0*(1-(t/T)); 
a=2-2*(t/T);
A=2*a*rand()-a;
   %% Exploration 
    if abs(A) >= 1
      q=rand(); 
      %perching based on Random location 
      if q >= 0.5
          rand_Hawk_index= floor(N*rand()+1);
          X_rand=X(rand_Hawk_index,:); r1= rand(); r2=rand();
        for d=1:D
          X(i,:)=X_rand-rand*r1*abs(X_rand - rand()-2*r2*X(i,d));
        end
        %perching based on other family member
      elseif q < 0.5
        r3=rand(); r4=rand();
        for d=1:D
          X(i,:)=(Xp(1,:)-Xm(d))-r3*(lb+r4*(ub-lb));
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
      TF=1/(1+exp(-10*(Xav-0.5)));
      if TF >= rand()
        X(i,d)=1; 
      else
        X(i,d)=0; 
      end
    end
     for l=1:N
    fit(l)=fun(feat,label,X(l,:)); 
    if fit(i) < Fitalpha
      Fitalpha=fit(l); Xalpha=X(l,:);
    end
    if fit(l) < Fitbeta && fit(l) > Fitalpha
      Fitbeta=fit(l); Xbeta=X(l,:);
    end
    if fit(l) < Fitdelta && fit(l) > Fitalpha && fit(l) > Fitbeta
      Fitdelta=fit(l); Xdelta=X(l,:);
    end
     end
  Conv_curve(t)=Fitalpha; 
  pause(1e-20); hold on;
  CG=plot(t,Fitalpha,'Color','r','Marker','.'); set(CG,'MarkerSize',5);
  t=t+1;
   end
Pos=1:D; Sf=Pos(Xalpha==1); Nf=length(Sf); sFeat=feat(:,Sf);
end

end 