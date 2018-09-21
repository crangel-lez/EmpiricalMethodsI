% Demand for the outside product as a function of prices

function D0 = D0(p)
 
 % Declare the quality parameters that are defined in hw2_exe.m
 global va;
 global vb;
 
 % Extract Prices
 pa = p(1);
 pb = p(2);
 
 % Numerator of the Demand Function for the outside product
 num = 1;
 
 % Denominator of the Demand Function for the outside product
 den = 1 + exp(va-pa) + exp(vb-pb);
 
 % Demand for the outside product
 D0 = num/den;
end