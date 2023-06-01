param ND:=15;#Number of Duplex Machine
param NDO:=4;#Number of cable types that can be only made on Duplex machine
param NDR:=11;#Number of cable types that can be only made on Regular machine
param NR:=90;#Number of Regular machines
param NT:=15;#Number of Cable Types
#Index Sets
set I:={1..ND}; #Cable types
set ID:={1..NDO+NDR}; #Cable types that can be made on duplex machines
set IDO:={1..NDO}; #Cable types that can be made only on duplex machines
set IDR:={NDO+1..NDO+NDR}; #Cable types that can be made either on Duplex or Regular machines
set IR:={NDO+1..NDO+NDR}; #Cable types that can be made on regular machines

#Parameters
param Ci {I}>=0; #Production cost for cable type i($/yard)
param di {ID}>=0; #yard/hour required for cable type i on a duplex machine
param Oi {I}>=0; #Outsourced cost for cable type i($/yard)
param Qi {I}>=0; #Demand for cable type i (yards)
param ri {I}>=0; #yard/hour required for cable type i on a regular machine
param Zi {I}>=0; #selling price for cable type i($/yard)

#Time Parameters
param H integer = 24;#number of hours/day that machines operate 
param D integer = 7;#number of days/week that machines operate
param W integer = 13;#number of weeks/quarter

#Decision Variables
var w1 >=0;#Cost of Regular Machine/hour
var w2 >=0;#Cost of Duplex Machine/hour
var w3 {I}>=0;#Cost of Producing cable i/yard

param Pi {i in I} = Zi[i]-Ci[i];#Profit for cable type i if made by Singular($/yard)
param Ti {i in I} = Zi[i]-Oi[i];#Profit for cable type i if outsourced ($/yard)

#Dual Objective function

minimize Cost: w1*NR*H*D*W + w2*ND*H*D*W + sum {i in I} (w3[i]*Qi[i]);

#Dual Constraints
subject to C1 {i in ID}:((1/di[i])*w2)+w3[i]>=Pi[i];#Min cost to produce cable i on Duplex Machine
subject to C2 {i in IR}:((1/ri[i])*w1)+w3[i]>=Pi[i];#Min cost to produce cable i on Regualr Machine
subject to C3 {i in I}:w3[i]>=Ti[i];#Min cost to outsource cable i






