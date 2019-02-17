% Function obtains the transition probabilities for given p's

function D=getD(p1, p2)
 global NU;
 numerator=exp(NU-p1);
 denominator=1+exp(NU-p1)+exp(NU-p2);
 
 D=numerator./denominator;
end