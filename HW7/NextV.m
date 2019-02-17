% This function takes as inputs the prices and Old Value Function and returns the updated value
% function

function nextV=NextV(p1, p2, Vold)
 global BETA;
 global c;
 
 % Get the Ds
 D1=getD(p1,p2);
 D2=getD(p2,p1);
 D0=1-D1-D2;
 
  % Get the Ws (continuation values)
 [W0, W1, W2]=getWs(Vold);
 
 % Compute updated Values
 
 nextV=D1.*(p1-c) + BETA.*(D0.*W0 + D1.*W1 + D2.*W2);
 
end