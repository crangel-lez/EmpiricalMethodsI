
% This file sets up the parameters of the model

% Number of Know-How levels
global L;
L=30;

% Vector of know-hows
global omegas;
omegas=(1:L)';

% Slope of the learning curve
global RHO;
RHO=0.85;

% Marginal cost of production with minimum know-how
global KAPPA;
KAPPA=10;

% Level at which learning curve flattens out
global small_l;
small_l=15;

% Quality of the good
global NU;
NU=10;

% Deprciation delta probability
global DELTA;
DELTA=0.03;

% Discount Factor
global BETA;
BETA=1/1.05;

% ETA
global ETA;
ETA=log(RHO)/log(2);

% Marginal Costs c
global c;
c=zeros(L,1);
c(1:small_l-1)=KAPPA*omegas(1:small_l-1).^ETA;
c(small_l:end)=KAPPA*(small_l^ETA);


% Transition Probabilities
global PI;
PI=zeros(L,L,2);

% Forgetting probabilities
forgetp0=1-(1-DELTA).^omegas(2:end);

% Remembering probabilities
rememberp0=1-forgetp0;

% Transition probabilities with no learning
PI(:,:,1)=diag(forgetp0,-1)+diag([1;rememberp0],0);

% Transition Probabilities with learning

% Probabilities of Learning nothing new 
no_newlearning=[1-(1-DELTA).^omegas(1:end-1); 1];

% Probabilities of Learning something new 
newlearning=1 - (1-(1-DELTA).^omegas(1:end-1));

PI(:,:,2)=diag(no_newlearning,0) + diag(newlearning, 1);
