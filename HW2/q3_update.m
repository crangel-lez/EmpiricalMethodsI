% This function performs the iterative procedure described in question 3.
% It takes as arguments the initial guess, the toelrance level, and the
% maximum nuymber of iterations allowed.

function q3_update = q3_update(p0, tol, maxits)
 
 % Compute next iterates using:
 % p_t+1 = 1/(1-D(p_t))

 pnext=zeros(2,1);
 pnext(1) = 1/(1-DA(p0));
 pnext(2) = 1/(1-DB(p0));

 % Distance between Points
 dist = norm( pnext - p0);

 % Iterate while distance is above tolerance level or we have hit maxits
 iters=1;

 while (dist>tol || iters<=maxits)
  p0=pnext;
  
  pnext(1) = 1/(1-DA(p0));
  pnext(2) = 1/(1-DB(p0));
  
  dist=norm(pnext-p0);
  iters=iters+1;
 end

q3_update = pnext;
end