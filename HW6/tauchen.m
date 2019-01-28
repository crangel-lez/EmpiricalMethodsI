% ECON 522
% SPring 2005
% approximating AR process with markov via equally space grid points
% x(t)=ro*x(t-1)+u

%syntax:  [prob]=eqgrid(N,mu,ro,sigma)

function [prob,grid,invdist]=tauchen(N,mu,ro,sigma)

% N, number of grid points,
% mu, mean of the error term
% ro, AR(1) parameter
% sigma, std. of the error process


mux=mu/(1-ro);
sigmax=sigma/sqrt(1-ro^2);

epsl=mux-3*sigmax;       % this area (betw eps1 and epsl) is going to capture more than 99 per cent,
epsh=mux+3*sigmax;       % i.e. prob that an observation fall into this area( 3 std dev far from the mean) is at least 99%. 
eps=linspace(epsl,epsh,N);
w=(eps(2)-eps(1))/2;   % half of the steps between the grids

if N==1; prob=1;  
else
 
    p=zeros(N);
    p(:,1)=normcdf(((eps(1)+w-mu)*ones(N,1)-ro*eps')/sigma);    %prob that future shock will be eps(1), i.e.{P11, P21,..,Pn1}'
    p(:,N)=ones(N,1)-normcdf(((eps(N)-w-mu)*ones(N,1)-ro*eps')/sigma);    %the last column of the transition matrix
        for j=2:(N-1)
            p(:,j)=normcdf(((eps(j)+w-mu)*ones(N,1)-ro*eps')/sigma)-normcdf(((eps(j)-w-mu)*ones(N,1)-ro*eps')/sigma);
        end
end
    prob=p;
    grid=eps;
    
    
    Trans= prob';
probst = (1/N)*ones(N,1); % initial distribution of states
test = 1;

  while test > 10^(-8);
      probst1 = Trans*probst;
      test=max(abs(probst1-probst));
      probst = probst1;   
   end
invdist=probst;


