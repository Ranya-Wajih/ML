function X=initialization(N,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries

if Boundary_no==1
    X=rand(N,dim).*(ub-lb)+lb;
end 
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
       X(:,i)=rand(N,1).*(ub_i-lb_i)+lb_i;
    end
end
end