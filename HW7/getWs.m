% This function gets Wn0, Wn1, and Wn2. Takes as arguments the Value
% function.
function [W0, W1, W2]=getWs(V0)
 global PI;
 % W0
 W0=PI(:,:,1)*V0*PI(:,:,1)';
 
 % W1
 W1=PI(:,:,2)*V0*PI(:,:,1)';
 
 % W2
 W2=PI(:,:,1)*V0*PI(:,:,2)';
 
end