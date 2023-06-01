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
var Di {I}>=0;#yards of cable type i to be made on Duplex machines
var Ri {I}>=0;#yards of cable type i to be made on Regular machines
var Si {I}>=0;#yards of cable type i to be outsourced

param Pi {i in I} = Zi[i]-Ci[i];#Profit for cable type i if made by Singular($/yard)
param Ti {i in I} = Zi[i]-Oi[i];#Profit for cable type i if outsourced ($/yard)

#Objective function

maximize Profit: sum {i in ID} (Pi[i]*Di[i]) + sum {i in IR} (Pi[i]*Ri[i])+sum {i in I} (Ti[i]*Si[i]);

#Constraints
subject to C1:sum {i in IR}(1/ri[i])*Ri[i]<=(NR*H*D*W);#Production Capacity of Regular Machines
subject to C2:sum {i in ID}(1/di[i])*Di[i]<=(ND*H*D*W);#Production Capacity of Duplex Machines
subject to C3 {i in IR}:Ri[i]+Di[i]+Si[i]=Qi[i];#Satisfy demand for cable types that can be made on Duplex or Regular Machines or Outsourced
subject to C4 {i in IDO}:Di[i]+Si[i]=Qi[i];#Satisfy demand for cable types that must be made on Duplex Machines or Outsourced





