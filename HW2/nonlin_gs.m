% This Function performs a nonlinear Gauss-Seidel iteration to solve the
% nonlinear system of equations described by the F.O.Cs

function nonlin_gs=nonlin_gs(p0, p1, tol, maxit, maxsubit)

 % An iteration consists of using the previous iterate pt-1 to solve for pt
 % by using a Gauss-Seidel Method. That is, given our previous iterate, we
 % solve for Pa from the f.o.c for firm A. Once we have this, we use this
 % price to solve for firm b's price Pb from its f.o.c
 
 
 for iter=1:maxit
     
     if norm(focs(p0))<tol | norm(focs(p1))<tol
         nonlin_gs= p1;
         break
     else
         % In order to solve for Pa from firm A's f.o.c, we use the secant
         % method. For this part, we perform a maximum of maxsubit iterations
         p_old=p0;
         p=p1;
         fold=focA(p_old);
     
         for subiter=1:maxsubit
            fval=focA(p);
            pa_0=p_old(1);
            pa_1=p(1);
         
            if abs(fval)<tol
                break
            else
            pa_next=pa_1 - ( (pa_1 - pa_0) / (fval-fold) )*fval;
             
            p_old(1)=pa_1;
            p(1)=pa_next;
             
            fold=fval;
            end
         end
         
         % Do the same for Good B
        fold=focB(p_old);
    
        for subiter=1:maxit
            fval=focB(p);
            pb_0=p_old(2);
            pb_1=p(2);
        
            if abs(fval)<tol
                break
            else
                pb_next=pb_1 - ( (pb_1-pb_0) / (fval-fold) )*fval;
            
                p_old(2)=pb_1;
                p(2)=pb_next;
            
                fold=fval;
            end
        end
        p0=p_old;
        p1=p;
     end
 end
 
end

% This function calculates the first-order condition for A
function focA = focA(p)
 % Extract prices
 pa=p(1);
 pb=p(2);
 
 % First Order Conditions
 % Di + Pi*D_Di(p)
 focA = DA(p) + pa*D_DA(p);
end

% This function calculates the first-order condition for B
function focB = focB(p)
 % Extract prices
 pa=p(1);
 pb=p(2);
 
 % First Order Conditions
 % Di + Pi*D_Di(p)
 focB = DB(p) + pb*D_DB(p);
end


% We define the derivative of the Demand for product A with respect to
% price a at prices p
function D_DA=D_DA(p)
 D_DA = -DA(p) * (1 - DA(p));
end

% This function defines the derivative of the Demand of product b with
% respect to product b at prices p

function D_DB = D_DB(p)
 D_DB = -DB(p)*(1-DB(p));
end