% Question 1
% Estimate the parameter vector Beta using the maximum likelihood estimator
% computed via the Nelder-Mead simplex method

% Load Data
load('hw3.mat');

% Define the Objective function 
min_lnL=@(b) (-log_like(b, X, y));

% Initial Guess
b0= ones(6,1);

% Set Options for Nelder-Mead
options_mle_nm=optimset('MaxFunEvals', 1000,'TolFun',1e-12);

% always set the stopping citeria, otherwise you run risk of finding bogus
% solution

% Perform Nelder-Mead Optimization
[bsol_nm, fval, exitflag, output]=fminsearch(min_lnL, b0, options_mle_nm);
% Display Optimizer's report
output

% Estimate
bsol_nm

%% Question 2
% Estimate the Parameter vector beta using the maximum likelihood estimator
% computed via a Quasi-Newton Optimization Method, report which method you
% choose.

% Define Objective Function
min_lnL= @(b) (-log_like(b, X, y));

% The following fminunc performs a maximization of the log-likelihood
% function using BFGS. (Use same initial guess as before)
[bsol_qn,fval,exitflag,output]=fminunc(min_lnL, b0);

% Display Results
output
bsol_qn

% All your results are very different from one another, in every section.
% that should not happen. it indicates something is profoundly wrong. My
% codes that I run on your data give approximately the same answer in all
% sections. Check out what was wrong.


%% Question 3
% Estimate the parameter vector beta using nonlinear least squares
% estimator computed using the command lsqnonlin. What computation method
% are you using?

% Define Objective Function
residuals= @(b) resids(b, X, y);

% Specify Options. We are Using Levenberg-Marquadt
options_nonls=optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', 'MaxFunctionEvaluations', 10000, 'FunctionTolerance', 1e-6, 'MaxIterations', 400, 'Display', 'off');

% Optimize
[bsol_lsqnonlin, resnorm,rep_resid,exitflag,output]=lsqnonlin(residuals, bsol_qn, [], [], options_nonls);

% Report Results
output
bsol_lsqnonlin

%% Question 4
% Estimate the parameter vector beta using the nonlinear least squares
% method estimator computed using the Nelder-Mead Simplex Method

% Define The Objective Function
rss=@(b) RSS(b, X,y);

% Set Options for Nelder-Mead
options_ls_nm=optimset('MaxFunEvals', 10000);

% Optimize and Report Results
[bsol_rss_nm,fval,exitflag,output]=fminsearch(rss,b0, options_ls_nm);
output
bsol_rss_nm

%% Question 5
% Test all four approaches with regard to the choice of initial values.
% ROughly rank them in order of robustness and time to convergence. Submit
% a short writeup summarizing your results.

% Create 80 Initial Guesses Drawn from a Uniform(0,1)
% Obtain the Estimates 
% Calculate the Standard Deviation of each beta coefficient

n0=80;

% Matrix For Storing vector estimates using MLE and Nelder-Mead

B_mle_nm=zeros(6,n0);

% Matrix for Storing vector estimates using MLE and Quasi-Newton
B_mle_qn=zeros(6,n0);

% Matrix for Storing vector estimates using nonlinear least swuares
B_lsqnon=zeros(6,n0);

% Matrix for Storing vector estimates using nonlinear least squares and
% Nelder-Mead
B_lsqnon_nm=zeros(6,n0);

% Matrix for Storing the computation times of MLE using Nelder-Mead
mle_nm_time=zeros(n0,1);

% Matrix for storing the computation times of MLE using Quasi Newton
mle_qn_time=zeros(n0,1);

% Matrix for Storing the computation times of Nonlinear Least Squares
% Command
lsqnonlin_time=zeros(n0,1);

% Matrix for Storing the computation times of Nonlinear least squares using
% Nelder-Mead
nonls_nm_time=zeros(n0,1);

% Options for Nelder-Mead Optimizations
options_nm=optimset('MaxFunEvals', 10000, 'Display', 'off');

% Options for 'Quasi-Newton' Options
options_qn=optimoptions(@fminunc, 'MaxFunctionEvaluations', 10000, 'Display', 'off');

% Options for Nonlinear Least Squares Command
options_nonls=optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', 'MaxFunctionEvaluations', 10000, 'FunctionTolerance', 1e-6, 'MaxIterations', 400, 'Display', 'off');

for i=1:n0
    b0s=rand(6,1);
    
    % Solve using MLE and Nelder-Mead
    tic;
    B_mle_nm(:,i)=fminsearch(min_lnL, b0s, options_nm);
    mle_nm_time(i)=toc;
    
    % Solve using MLE and Quasi-Newton
    tic;
    B_mle_qn(:,i)=fminunc(min_lnL, b0s, options_qn);
    mle_qn_time=toc;
    
    % Solve using Nonlsq
    tic;
    B_lsqnon(:,i)=lsqnonlin(residuals, b0s, [], [], options_nonls);
    lsqnonlin_time=toc;
    
    % Solve using Nonlsq and Nealder-Mead
    tic;
    B_lsqnon_nm(:,i)=fminsearch(rss, b0s, options_nm);
    nonls_nm_time=toc;
    
end

%% Compute Standard DEviations and Timings

% Standard Deviation of Maximum Likelihood using Nelder-Mead
std_mle_nm=std(B_mle_nm, 0, 2);

% Standard Deviation of Maximum Likelihood using Quasi-Newton
std_mle_qn=std(B_mle_qn, 0, 2);

% Standard Deviation of Nonlsq command
std_lsqnon=std(B_lsqnon, 0, 2);

% Standard Deviation of Nonlinear least squares using Nelder-Mead
std_lsqnon_nm=std(B_lsqnon_nm, 0, 2);

% Average Time Taken by Maximum Likelihood using Nelder-Mead
avg_time_mle_nm=mean(mle_nm_time);

% Average Time taken by MLE using Quasi-Newton
avg_time_mle_qn=mean(mle_qn_time);

% Average Time Taken by Nonlsq command
avg_time_nonlsq=mean(lsqnonlin_time);

% Average Time Taken by nonlinear least squares using Nelder-Mead
avg_time_nonls_nm=mean(nonls_nm_time);

%% Display Results
% Table for Displaying Standard Deviations
stds=table(std_mle_nm, std_mle_qn, std_lsqnon, std_lsqnon_nm, 'VariableNames', {'MLENM', 'MLEQN', 'LSQNONLIN', 'NLSNM'}, 'rowNames', {'b0' ,'b1', 'b2', 'b3', 'b4', 'b5'})

avg_times=table(avg_time_mle_nm, avg_time_mle_qn, avg_time_nonlsq, avg_time_nonls_nm, 'VariableNames', {'MLENM', 'MLEQN', 'LSQNONLIN', 'NLSNM'})
