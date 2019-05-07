% co-ordinates

X000=
X100=
X010=
X110=;
X001=
X101=
X011=
X111=;

Y000=
Y100=
Y010=
Y110=;
Y001=
Y101=
Y011=
Y111=;

Z000=
Z100=
Z010=
Z110=;
Z001=
Z101=
Z011=
Z111=;





% jacobian

syms A B G;
X(A,B,G)= X000*(1-A)*(1-B)*(1-G)+X100*A*(1-B)*(1-G)+X010*(1-A)*B*(1-G)+X001*(1-A)*(1-B)*G+X110*A*B*(1-G)+X011*(1-A)*B*G+X101*A*(1-B)*G+X111*A*B*G;
Y(A,B,G)= Y000*(1-A)*(1-B)*(1-G)+Y100*A*(1-B)*(1-G)+Y010*(1-A)*B*(1-G)+Y001*(1-A)*(1-B)*G+Y110*A*B*(1-G)+Y011*(1-A)*B*G+Y101*A*(1-B)*G+Y111*A*B*G;
Z(A,B,G)= Z000*(1-A)*(1-B)*(1-G)+Z100*A*(1-B)*(1-G)+Z010*(1-A)*B*(1-G)+Z001*(1-A)*(1-B)*G+Z110*A*B*(1-G)+Z011*(1-A)*B*G+Z101*A*(1-B)*G+Z111*A*B*G;
f=[X Y Z];
v=[A B G];
J(A,B,G)=jacobian(f,v);
J1(A,B,G)=int(int(int(J,A),B),G);
volume=J1(1,1,1)-J1(0,0,0);

%tangent vector-1
syms A B G;
X(A,B,G)= X000*(1-A)*(1-B)*(1-G)+X100*A*(1-B)*(1-G)+X010*(1-A)*B*(1-G)+X001*(1-A)*(1-B)*G+X110*A*B*(1-G)+X011*(1-A)*B*G+X101*A*(1-B)*G+X111*A*B*G;
Y(A,B,G)= Y000*(1-A)*(1-B)*(1-G)+Y100*A*(1-B)*(1-G)+Y010*(1-A)*B*(1-G)+Y001*(1-A)*(1-B)*G+Y110*A*B*(1-G)+Y011*(1-A)*B*G+Y101*A*(1-B)*G+Y111*A*B*G;
Z(A,B,G)= Z000*(1-A)*(1-B)*(1-G)+Z100*A*(1-B)*(1-G)+Z010*(1-A)*B*(1-G)+Z001*(1-A)*(1-B)*G+Z110*A*B*(1-G)+Z011*(1-A)*B*G+Z101*A*(1-B)*G+Z111*A*B*G;
i_comp(A,B,G)=diff(X,A);
j_comp(A,B,G)=diff(Y,A);
k_comp(A,B,G)=diff(Z,A);
% get values of a b g
icomp=i_comp(a,b,g);
jcomp=j_comp(a,b,g);
kcomp=k_comp(a,b,g);

%tangent vector-2
syms A B G;
X(A,B,G)= X000*(1-A)*(1-B)*(1-G)+X100*A*(1-B)*(1-G)+X010*(1-A)*B*(1-G)+X001*(1-A)*(1-B)*G+X110*A*B*(1-G)+X011*(1-A)*B*G+X101*A*(1-B)*G+X111*A*B*G;
Y(A,B,G)= Y000*(1-A)*(1-B)*(1-G)+Y100*A*(1-B)*(1-G)+Y010*(1-A)*B*(1-G)+Y001*(1-A)*(1-B)*G+Y110*A*B*(1-G)+Y011*(1-A)*B*G+Y101*A*(1-B)*G+Y111*A*B*G;
Z(A,B,G)= Z000*(1-A)*(1-B)*(1-G)+Z100*A*(1-B)*(1-G)+Z010*(1-A)*B*(1-G)+Z001*(1-A)*(1-B)*G+Z110*A*B*(1-G)+Z011*(1-A)*B*G+Z101*A*(1-B)*G+Z111*A*B*G;
i_comp(A,B,G)=diff(X,B);
j_comp(A,B,G)=diff(Y,B);
k_comp(A,B,G)=diff(Z,B);
% get values of a b g
icomp=i_comp(a,b,g);
jcomp=j_comp(a,b,g);
kcomp=k_comp(a,b,g);

%tangent vector-3

syms A B G;
X(A,B,G)= X000*(1-A)*(1-B)*(1-G)+X100*A*(1-B)*(1-G)+X010*(1-A)*B*(1-G)+X001*(1-A)*(1-B)*G+X110*A*B*(1-G)+X011*(1-A)*B*G+X101*A*(1-B)*G+X111*A*B*G;
Y(A,B,G)= Y000*(1-A)*(1-B)*(1-G)+Y100*A*(1-B)*(1-G)+Y010*(1-A)*B*(1-G)+Y001*(1-A)*(1-B)*G+Y110*A*B*(1-G)+Y011*(1-A)*B*G+Y101*A*(1-B)*G+Y111*A*B*G;
Z(A,B,G)= Z000*(1-A)*(1-B)*(1-G)+Z100*A*(1-B)*(1-G)+Z010*(1-A)*B*(1-G)+Z001*(1-A)*(1-B)*G+Z110*A*B*(1-G)+Z011*(1-A)*B*G+Z101*A*(1-B)*G+Z111*A*B*G;
i_comp(A,B,G)=diff(X,G);
j_comp(A,B,G)=diff(Y,G);
k_comp(A,B,G)=diff(Z,G);
% get values of a b g
icomp=i_comp(a,b,g);
jcomp=j_comp(a,b,g);
kcomp=k_comp(a,b,g);

% normal vector
% t2 xt3
% t2=[   ] t3=[   ] n1=cross(t2,t3)

% mean position

syms A B G;
X(A,B,G)= X000*(1-A)*(1-B)*(1-G)+X100*A*(1-B)*(1-G)+X010*(1-A)*B*(1-G)+X001*(1-A)*(1-B)*G+X110*A*B*(1-G)+X011*(1-A)*B*G+X101*A*(1-B)*G+X111*A*B*G;
Y(A,B,G)= Y000*(1-A)*(1-B)*(1-G)+Y100*A*(1-B)*(1-G)+Y010*(1-A)*B*(1-G)+Y001*(1-A)*(1-B)*G+Y110*A*B*(1-G)+Y011*(1-A)*B*G+Y101*A*(1-B)*G+Y111*A*B*G;
Z(A,B,G)= Z000*(1-A)*(1-B)*(1-G)+Z100*A*(1-B)*(1-G)+Z010*(1-A)*B*(1-G)+Z001*(1-A)*(1-B)*G+Z110*A*B*(1-G)+Z011*(1-A)*B*G+Z101*A*(1-B)*G+Z111*A*B*G;
f=[X Y Z];
v=[A B G];
J(A,B,G)=jacobian(f,v);
fx(A,B,G)=X(A,B,G)*J(A,B,G);
fx1(A,B,G)=int(int(int(fx,A),B),G);
fy(A,B,G)=Y(A,B,G)*J(A,B,G);
fy1(A,B,G)=int(int(int(fy,A),B),G);
fz(A,B,G)=Z(A,B,G)*J(A,B,G);
fz1(A,B,G)=int(int(int(fz,A),B),G);
J1(A,B,G)=int(int(int(J,A),B),G);
volume=J1(1,1,1)-J1(0,0,0);

icomp=(fx1(1,1,1)-fx1(0,0,0))/volume;
jcomp=(fy1(1,1,1)-fy1(0,0,0))/volume;
kcomp=(fz1(1,1,1)-fz1(0,0,0))/volume;



