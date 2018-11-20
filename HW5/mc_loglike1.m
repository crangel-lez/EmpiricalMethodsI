function mc_loglike1=mc_loglike1(x, seed)
 global n_nodes;
 
 % Unpack x
 % First entry of x corresponds to gamma
 % Second entry of x corresponds to beta_0
 % Third entry of x corresponds to sigma_beta
 cgamma=x(1);
 beta_0=x(2);
 sigma_beta=x(3);
 
 % Fix Seed for the following draws
 rng(seed);
 
 % Obtain the nodes
 nodes=normrnd(beta_0, sigma_beta, 100, 1);
 
 % Will Store the numerical approximation to the integral of each
 % individual's likelihood function here.
 integral_approx=zeros(100,1);
 
 % Perform Numerical Approximation
 for i=1:n_nodes
  integral_approx=integral_approx+(1/n_nodes)*Li(cgamma, nodes(i));
 end
 % Obtain the log-likehood function
 mc_loglike1=sum(log(integral_approx));
end

% Compute each individual's Likelihood function
function Li=Li(cgamma, beta)
 global X;
 global Y;
 global Z;
 Li=prod( ((logistic_cdf(beta*X+cgamma*Z+0)).^Y ) .* (( 1-logistic_cdf(beta*X+cgamma*Z+0)).^(1-Y)),2);
end