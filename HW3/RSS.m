% This function returns the Residual sum of squares reported in HW3
function res_sq_sum=res_sq_sum(b,X,y)
 res_sq_sum= sum( ( y - exp(X*b) ).^2 );
end