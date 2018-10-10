function resids=resids(b,X,y)
 %b=b';
 resids= ( y - exp(X*b) );
end