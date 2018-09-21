% broyden-seidel method

function bseidel=bseidel(x0)

% We need the initial Jacobian approximation
A0=fdjac('f', x0);

% Evalute f at x0
f0=f(x0);

% We need out next iterate. Define d=x_(k+1) - x_(k). Then
% A0*d=-f0

% Solve for d using Gauss-Seidel








end