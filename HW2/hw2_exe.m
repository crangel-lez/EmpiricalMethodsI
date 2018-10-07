%% Declare Parameters 

% Make them global so that they can be read by the functions

% Qualities of eahc product
global va;
global vb;

%% Question 1: Consider the following parameterization: va=vb=2. What is the demand for each option if pa=pb=1?

% Define quality parameters
va=2;
vb=2;

% Define Price vector
p=[1,1];

% Compute and Display Demands

% Demand for product A
da=DA(p)

% Demand for product B
db=DB(p)

% Demand for the outside product
d0=D0(p)

%% Question 2. 
% Given the above parameterizations for values, use Broyden's method to 
% solve for the Nash pricing equilibrium. (Hint: There is a unique
% equilibrium.) Report the staring value and convergence criteria ( if it
% converges)

% Convergence Criteria: sqrt(machine epsilon)
% Starting value
x0=[1;1];

% Solve the System of Nonlinear Equations and time it
tic
prices_sol=broyden('focs', x0)
toc

%% Question 3.
% Now use a Gauss-Seidel Method (using the secant method for each subiteration) to
% solve for the pricing equilibrium. Which method is faster?

% Start with initial guess
tic
p0=[1;1];
p1=[2;2];
tol=0.00001;
maxit=1000;
maxsubit=1000;
sols=nonlin_gs(p0, p1, tol, maxit, maxsubit)
toc

%% Question 4.
% Lastly, use the following update rule to solve for the equilibrium:

% p_t+1 = 1/(1-D(p_t))

% Does this converge? Is it faster or slower than the other two methods?

% Tolerance levels (if the difference between two succesive iterates is
% less than tol, we have converged)
tol=sqrt(eps);

% Stop if we have exceeded maxits iterations
maxits=1000;

% Initial Guess
p0=[1;1];

% Solve the nonlinear system of equations using the proposed update rule
% and time it
tic
psols=q3_update(p0, tol, maxits);
toc

%% Question 5.
% Solve the pricing equlibrium (using your preferred method) for va=2 and
% vb=0:0.2:3. On the same graph, plot Pa and Pb as a function of the vector
% of vb.

vb_vector = 0:0.2:3;

n_vb=length(vb_vector);

pa_vector=zeros(n_vb,1);
pb_vector=zeros(n_vb,1);

x0=[1;1];
for i=1:n_vb
 vb = vb_vector(i);
 prices_sol = broyden('focs', x0);
 pa_vector(i) = prices_sol(1);
 pb_vector(i) = prices_sol(2);
 x0=prices_sol;
end
% so, where is the plot? your matlab code should print all the results
% needed.

