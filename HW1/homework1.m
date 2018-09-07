%% Economics Homework 1

%% Question 1:

% Define vector X
x=[1, 1.5, 3, 4, 5, 7, 9, 10];

% Compute The Values for y1=-2 + 0.5x
y1=-2 + 0.5.*x;

% Display y1
y1
% Compute the values for y2
y2= -2 + 0.5 .* x.^2;

% Display y2
y2

% Plot Y1, Y2 vs X
figure
plot(x, y1, x, y2)
title("Y1,Y2 vs. X")
xlabel("x")
legend("Y1", "Y2")
%% Question 2

% Create x vector
x=linspace(-10, 20);

% Calculate and display sum of the elements of x
sum_x=sum(x)

%% Question 3 

% Create A matrix
A=[2, 4, 6; 1, 7, 5; 3, 12, 4];

% Create vector b
b=[-2;3;10];

% Calculate and display C=A'b
C=A'*b;

% Calculate and display D=((A'A)^(-1))*b
D=inv(A'*A)*b

% Calculate and Display E= sum_i (sum_j aij*bi)
E=sum(sum(A.*b))

% F matrix is matrix with the 2nd row and 3rd column deleted

% Initialize F to A
F=A;

% Delete 2nd row
F(2,:) = [];

% Delete 3rd column and display F
F(:,3)=[]

% Solve the system Ax=b
x=A\b

%% Question 4
 
% Create block diagonal matrix

% Initialize B to a 15 x 15 zero matrix

% Comment: could have used kron product, it is generally faster in matlab and it saves you a lot of symbols in your code
B=blkdiag(A,A,A,A,A)


%% Question 5

% Create 5x3 matrix of randome distributions with mu= 10 and std=5

A=10+5*randn(5,3)

% Comment, again, could have shortened it by A = A>10 

% Replace the elements of A that are less than 10 with 0
A(A<10)=0;

% Replace the elements of A that are equal or greater tan 10 with 1
A(A>=10)=1

%% Question 6

% Import CSV file
data = csvread('datahw1.csv');

T=readtable('datahw1.csv', 'ReadVariableNames', false);

% Modify variable names
T.Properties.VariableNames = {'FirmID', 'Year', 'Export', 'RD', 'prod', 'cap'}

% comment : it's fine to use econometrics toolbox, but it's also good to do some data-cleaning
fitlm(T,'prod~Export+RD+cap')
