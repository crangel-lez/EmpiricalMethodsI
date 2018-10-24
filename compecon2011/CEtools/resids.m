% This function simply returns the residuals between the data and the
% conditional expectation of y given x for dataset X,y, and coefficients b.
% This function will be used for the nonlsq matlab command.
function resids=resids(b,X,y)
 resids= ( y - exp(X*b) );
end