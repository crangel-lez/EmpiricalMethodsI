% This function computes and returns the log-likelihood reported in HW3 for
% variates X,y and coefficients b
function log_like=log_like(b,X,y)
 log_like=sum( -exp(X*b) +y.*(X*b) - log (factorial(y)));
end