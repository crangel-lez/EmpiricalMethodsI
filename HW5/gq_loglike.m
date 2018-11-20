function log_like1=log_like1(x)
 % Declare the number of nodes to use
 global n_nodes;
 
 % First entry of x corresponds to gamma
 % Second entry of x corresponds to beta_0
 % Third entry of x corresponds to sigma_beta
 
 % Unpack x
 cgamma=x(1);
 beta_0=x(2);
 sigma_beta=x(3);
 
 % Obtain nodes and weights using Gaussian Quadrature
 [nodes, weights] = qnwnorm(n_nodes, beta_0, sigma_beta);
 
 % Will use the following variable to compute integral approximation
 integral_approx=zeros(100,1);
 
 % Compute the numerical approximation of the integral of each individual's
 % Likelihood
 for i=1:n_nodes
  integral_approx=integral_approx + weights(i)*Li(cgamma, nodes(i));
 end
 
 % Compute Log-Likelihood
 log_like1=sum(log(integral_approx));
end

% This private function calculates the Likelihood of each individual
% i.
function Li=Li(cgamma, cbeta)
 global X;
 global Y;
 global Z;
 Li=prod( ((logistic_cdf(cbeta*X+cgamma*Z+0)).^Y ) .* (( 1-logistic_cdf(cbeta*X+cgamma*Z+0)).^(1-Y)),2);
end