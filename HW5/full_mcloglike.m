function full_mcloglike=full_mcloglike(x, seed)
 global n_nodes;
 
 % First Entry of x is gamma
 % Second Entry of x is beta_0
 % Third Entry of x is u_0
 % Fourth Entry of x is R11 (R is the Lower Triangular Cholesky Matrix)
 % Fifth entry of x is R21
 % Sixth Entry of x is R22 
 
 % Unpack x
 cgamma=x(1);
 beta_0=x(2);
 u_0=x(3);
 
 % Define Lower Triangular Cholesky matrix
 R=[x(4) 0; x(5) x(6)];
 
 % Set seed for random draws
 rng(seed);
 
 % Generate two sequences of standard normal variates
 z_nodes=normrnd(0, 1, n_nodes, 2);
 
 % Generate Beta nodes
 beta_nodes=beta_0 + R(1,1)*z_nodes(:,1) + R(2,1)*z_nodes(:,2);
 
 % Generate u nodes
 u_nodes=u_0 + R(1,2)*z_nodes(:,1) + R(2,2)*z_nodes(:,2);
 
 % Perform Integral Approximation for each individual likelihood
 integral_approx=zeros(100,1);
 
 for i=1:n_nodes
  integral_approx=integral_approx + (1/n_nodes)*Li(cgamma, beta_nodes(i), u_nodes(i));
 end
 % Compute log-likelihood
 full_mcloglike=sum(log(integral_approx));
end

% Private Function that computes the likelihood of each individual
function Li=Li(cgamma, beta, u)
 global X;
 global Y;
 global Z;
 Li=prod( ((logistic_cdf(beta*X+cgamma*Z+u)).^Y ) .* (( 1-logistic_cdf(beta*X+cgamma*Z+u)).^(1-Y)),2);
end