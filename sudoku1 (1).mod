## Setting 9x9 matrix S
param S{{1,2,3,4,5,6,7,8,9},{1,2,3,4,5,6,7,8,9}} default 0, integer, >= 0, <= 9;


##setting up Binary integer problem
var x {i in 1..9, j in 1..9, k in 1..9} >= 0, <= 1, integer;


## objective fn 
minimize zero: 0;


#column constraint to make sure value occures only once 
subject to column_sum {j in 1..9, k in 1..9}: 
sum {i in 1..9} x[i,j,k] = 1;


##row constraint to make sure value occures only once  
subject to row_sum {i in 1..9, k in 1..9}: 
sum {j in 1..9}
 x[i,j,k] = 1;


 ##3x3 Submatrix constraint 
subject to 3x3_sum {p in {1,2,3}, q in {1,2,3}, k in 1..9}:
##sum of xk to make sure value occures only once in 3x3 submatrix using p,q
sum {i in 3*p-2..3*p, j in 3*q-2..3*q}
x[i,j,k]= 1;


##value constraint to make sure value occures only once 
subject to value_sum {i in 1..9, j in 1..9}: 
sum {k in 1..9}
 x[i,j,k] = 1;


## preserve the given values 
subject to given_vals {i in 1..9, j in 1..9: S[i,j] > 0}:
 x[i,j,S[i,j]] = 1;
