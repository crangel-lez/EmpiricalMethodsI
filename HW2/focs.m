% This is the vector function that evaluates the firms' first order
% conditions

function focs = focs(p)
 % Extract prices
 pa=p(1);
 pb=p(2);
 
 % First Order Conditions
 % Di + Pi*D_Di(p)
 focs(1) = DA(p) + pa*D_DA(p);
 focs(2) = DB(p) + pb*D_DB(p);
 focs=focs';
%  good to use the non-singular version of FOC
end

% We define the derivative of the Demand for product A with respect to
% price a at prices p
function D_DA=D_DA(p)
 D_DA = -DA(p) * (1 - DA(p));
end

% This function defines the derivative of the Demand of product b with
% respect to product b at prices p

function D_DB = D_DB(p)
 D_DB = -DB(p)*(1-DB(p));
end
