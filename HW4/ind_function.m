function ind_fun=ind_function(x)

% Calculate the squared of the norms of the points
norms_squared=sum((x.^2),2);

% Create vector that is equal to one if norms_squared<=1 and 0 otherwise
npoints=length(x);
ind_fun=zeros(npoints,1);
ind_fun(norms_squared <= 1)=1;
end