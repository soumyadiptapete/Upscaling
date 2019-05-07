function [ Ja1 ] = Ja( i,j,k,a,b,g )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
global Xcorn Ycorn Zcorn;
X000=Xcorn(2*i-1,2*j-1,2*k-1);
Y000=Ycorn(2*i-1,2*j-1,2*k-1);
Z000=Zcorn(2*i-1,2*j-1,2*k-1);
X100=Xcorn(2*i-1,2*j,2*k-1);
Y100=Ycorn(2*i-1,2*j,2*k-1);
Z100=Zcorn(2*i-1,2*j,2*k-1);
X010=Xcorn(2*i,2*j-1,2*k-1);
Y010=Ycorn(2*i,2*j-1,2*k-1);
Z010=Zcorn(2*i,2*j-1,2*k-1);
X110=Xcorn(2*i,2*j,2*k-1);
Y110=Ycorn(2*i,2*j,2*k-1);
Z110=Zcorn(2*i,2*j,2*k-1);
X001=Xcorn(2*i-1,2*j-1,2*k);
Y001=Ycorn(2*i-1,2*j-1,2*k);
Z001=Zcorn(2*i-1,2*j-1,2*k);
X101=Xcorn(2*i-1,2*j,2*k);
Y101=Ycorn(2*i-1,2*j,2*k);
Z101=Zcorn(2*i-1,2*j,2*k);
X011=Xcorn(2*i,2*j-1,2*k);
Y011=Ycorn(2*i,2*j-1,2*k);
Z011=Zcorn(2*i,2*j-1,2*k);
X111=Xcorn(2*i,2*j,2*k);
Y111=Ycorn(2*i,2*j,2*k);
Z111=Zcorn(2*i,2*j,2*k);

syms A B G;
X(A,B,G)= X000*(1-A)*(1-B)*(1-G)+X100*A*(1-B)*(1-G)+X010*(1-A)*B*(1-G)+X001*(1-A)*(1-B)*G+X110*A*B*(1-G)+X011*(1-A)*B*G+X101*A*(1-B)*G+X111*A*B*G;
Y(A,B,G)= Y000*(1-A)*(1-B)*(1-G)+Y100*A*(1-B)*(1-G)+Y010*(1-A)*B*(1-G)+Y001*(1-A)*(1-B)*G+Y110*A*B*(1-G)+Y011*(1-A)*B*G+Y101*A*(1-B)*G+Y111*A*B*G;
Z(A,B,G)= Z000*(1-A)*(1-B)*(1-G)+Z100*A*(1-B)*(1-G)+Z010*(1-A)*B*(1-G)+Z001*(1-A)*(1-B)*G+Z110*A*B*(1-G)+Z011*(1-A)*B*G+Z101*A*(1-B)*G+Z111*A*B*G;
f=[X Y Z];
v=[A B G];
J(A,B,G)=jacobian(f,v);
Ja1=det(J(a,b,g));

end

