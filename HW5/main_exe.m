%% HW5
% all is good 

%Add CompEcon toolbox to path
addpath(genpath('../compecon2011'))

% Load Homework Data
load hw5.mat

% Store Data
global X;
global Y;
global Z;

X=data.X';
Y=data.Y';
Z=data.Z';


%% Question 1. 
% Assume u_i=0 for all i. (i.e. take u_i out of the model, so that
% u_0=sigma_u=sigma_u_beta=0). Use Guassian Quadrature using 20 nodes to
% calculate the log-likelihood function when beta_0=0.1, sigma_beta=1, and
% gamma =0.

% Number of Nodes to Use
global n_nodes;
n_nodes=20;

% Compute log-likelihood using Gaussian Quadrature
gq_loglike([0 0.1 1])

%% Question 2
% Now use Monte Carlo Methods using 100 nodes to calculate the
% log-likelihood function.
n_nodes=100;

% Compute the log-likelihood using Monte-Carlo (Fix Seed at 1).
mc_loglike1([0 0.1 1],1)

%% Question 3.
% Maximize(or minimize the negative) log-likelihood function with respect
% to the parameters using both integration techniques above. Use Matlab's
% fmincon without a supplied derivative to max (min) your objective
% function.

% Using First Integration Technique

% Initial Guess
x0=0.5*ones(1,3)

% Define Negative of Loglikelihood
neg_gqloglike=@(x) -gq_loglike(x);

% Lower Bounds
lb=[-Inf ; -Inf; eps];

% Upper Bounds 
ub=[Inf; Inf; Inf];

% Maximization
[gq_argmax, gq_maxval]=fmincon(neg_gqloglike, x0, [], [], [], [], lb, ub);

% Argmax
gq_argmax

% Maximized Value
gq_maxval

%% Using Second Integration Technique

% Initial Guess
x0=0.5*ones(1,3)

% Define Negative of Log-Likelihood
neg_mcloglike=@(x) -mc_loglike1(x,1);

% Lower Bounds
lb=[-Inf ; -Inf; eps];

% Upper Bounds
ub=[Inf; Inf; Inf];

% Maximization
[mc_argmax, mc_maxval]=fmincon(neg_mcloglike, x0, [], [], [], [], lb, ub);

% Argmax
mc_argmax

% Maximized Value
mc_maxval

%% Question 4

% Initial Guess
x0=[0,2,1.5,5,0.5,10]

% Lower Bounds
lb=[-Inf; -Inf; -Inf; eps; -Inf; eps];

% Upper Bounds
ub=[Inf; Inf; Inf; Inf; Inf; Inf];

% Define Negative of Log Likelihood
neg_full_mcloglike=@(x) -full_mcloglike(x,1);

% Maximization
[full_argmax, full_maxval]=fmincon(neg_full_mcloglike, x0, [], [], [], [], lb, ub);

% Argmax
full_argmax

% Maximized value
full_maxval

% Variance-Covariance Matrix

% Cholesky Matrix
R=[full_argmax(4) 0; full_argmax(5) full_argmax(6)];

% Variance-Covariance Matrix
sigma=R*R'
