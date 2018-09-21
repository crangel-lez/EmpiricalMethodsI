% This is the demand for product b as a function of prices

function DB = DB(p)
 % Declare va, vb which are defined in hw2_exe.m
 global va;
 global vb;
 
 % Extract prices
 pa=p(1);
 pb=p(2);
 
 % Numerator of the demand function
 num =  exp(vb-pb);
 
 % Numerator of the demand function
 den = 1 + exp(va-pa) + exp(vb-pb);
 
 % Demand for the product b
 DB = num/den;
 
end