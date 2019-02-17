% This function gives the optimal prices given the strategy of the other
% player
function focs=focs(p1, p2, V0)
 global BETA;
 global c;
 % Get the Ws (continuation values)
 [W0, W1, W2]=getWs(V0);
 
 % Get the Ds
 D1=getD(p1,p2);
 D2=getD(p2,p1);
 D0=1-D1-D2;
 
 focs=1 - (1-D1).*(p1-c) +BETA.*(- W1 + D0.*W0 + D1.*W1 + D2.*W2);
 
end