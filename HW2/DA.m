% This is the Demand function for the product A as a function of prices p = [Pa, Pb]

function DA = DA(p)
    % Quality parameters (declared in hw2_exe)
    global va;
    global vb;
    
    % Extract prices
    pa=p(1);
    pb=p(2);
    
    
    % Numerator of the demand function
    num = exp(va-pa);
    
    % Denominator of the demand function
    den = 1 + exp(va-pa) + exp(vb-pb);
    
    % Demand for product A
    DA=num/den;    
end
