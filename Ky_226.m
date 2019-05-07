% permeability upscaler in y-direction 2x2x6
ny_226=110;
nx_226=30;
nz_226=15;
ky_new=zeros(ny_226,nx_226,nz_226);

% layers 1-6
for k=1:6:25
    
    for i=1:2:ny
        for j=1:2:nx
   
nx_d=2;
ny_d=2;
nz_d=6;
Tx_d=zeros(ny_d,nx_d+1,nz_d);


% left trans for x= is zero
for k1=1:nz_d
    for i1=1:ny_d
        j1=1;
        Tx_d(i1,j1,k1)=0;
    end
end

% trans for x=right side

for k1=1:nz_d
    for i1=1:ny_d
        j1=nx_d+1;
        Tx_d(i1,j1,k1)=0;
    end
end

% trans for x direction for cells in between
k2=k;

for k1=1:nz_d
    i2=i;
    for i1=1:ny_d
        j2=j+1;
        for j1=2:nx_d
            
            T1=(2*0.00633*400*kx(i2,j2-1,k2)/20^2);
            T2=(2*0.00633*400*kx(i2,j2,k2)/20^2);
            
            Tx_d(i1,j1,k1)=T1*T2/(T1+T2);
            if Tx_d(i1,j1,k1)==0
                Tx_d(i1,j1,k1)=10^-15;
            end
            j2=j2+1;
        end
        i2=i2+1;
    end
    k2=k2+1;
end
Ty_d=zeros(ny_d+1,nx_d,nz_d);

i2=i;
k2=k;
i1=1;
for k1=1:nz_d
    j2=j;
    for j1=1:nx_d
        Ty_d(i1,j1,k1)=2*ky(i2,j2,k2)*0.00633*20*2/10;
        j2=j2+1;
    end
    k2=k2+1;
end
% south T=0

i2=i+ny_d-1;
k2=k;
i1=ny_d+1;
for k1=1:nz_d
    j2=j;
    for j1=1:nx_d
        Ty_d(i1,j1,k1)=2*ky(i2,j2,k2)*0.00633*20*2/10;
        j2=j2+1;
    end
    k2=k2+1;
end
% T in y direction for rest of the cells

k2=k;
for k1=1:nz_d
    i2=i+1;
    for i1=2:ny_d
        j2=j;
        for j1=1:nx_d
            
            T1=(2*0.00633*400*ky(i2-1,j2,k2)/10^2);
            T2=(2*0.00633*400*ky(i2,j2,k2)/10^2);
            Ty_d(i1,j1,k1)=T1*T2/(T1+T2);
            if Ty_d(i1,j1,k1)==0
                Ty_d(i1,j1,k1)=10^-15;
            end
            j2=j2+1;
        end
        i2=i2+1;
    end
    k2=k2+1;
end

% Top T is zero
k1=1;
for i1=1:ny_d
    for j1=1:nx_d
        Tz_d(i1,j1,k1)=0;
    end
end

% bottom T is zero
k1=nz_d+1;
for i1=1:ny_d
    for j1=1:nx_d
        Tz_d(i1,j1,k1)=0;
    end
end

% Tz for between cells
k2=k+1;
for k1=2:nz_d
    i2=i;
  for  i1=1:ny_d
      j2=j;
    for j1=1:nx_d
     T1=(2*0.00633*400*kz(i2,j2,k2-1)/2^2);
     T2=(2*0.00633*400*kz(i2,j2,k2)/2^2);
     Tz_d(i1,j1,k1)=T1*T2/(T1+T2); 
     if Tz_d(i1,j1,k1)==0
                Tz_d(i1,j1,k1)=10^-15;
     end
      j2=j2+1;
    end
    i2=i2+1;
  end
  k2=k2+1;
end

N=(nx_d)*(ny_d)*(nz_d);

%i+1 diagonal


a=0;
l=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
              a=a+1;
            
            l(a,1)=-Tx_d(i1,j1+1,k1);
           
          
        end
    end
end

%i-1 diagonal
a=0;
n=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
             a=a+1;
           
            n(a,1)=-Tx_d(i1,j1,k1);
            
           
        end
    end
end

%j+1 diagonal
a=0;
p=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            if i1==ny_d
                p(a,1)=0;
            else
            p(a,1)=-Ty_d(i1+1,j1,k1);
            end
        end
    end
end

% j-1 diagonal
a=0;
q=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            if i1==1
                q(a,1)=0;
            else
            
            q(a,1)=-Ty_d(i1,j1,k1);
            end
        end
    end
end

%k+1 diagonal
a=0;
r=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
          a=a+1;
          
          r(a,1)=-Tz_d(i1,j1,k1+1);
         
        end
    end
end

% k-1 diagonal

a=0;
s=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            
            s(a,1)=-Tz_d(i1,j1,k1);
            
        end
    end
end

%Center diagonal

a=0;
c=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1; 
           
            c(a,1)=Tz_d(i1,j1,k1)+Tz_d(i1,j1,k1+1)+Ty_d(i1,j1,k1)+Ty_d(i1+1,j1,k1)+Tx_d(i1,j1,k1)+Tx_d(i1,j1+1,k1);
            
        end
    end
end

% Transmissibility matrix
B=[ r p l c n q s];
T=spdiags(B,[-nx_d*ny_d,-nx_d,-1,0,1,nx_d,nx_d*ny_d],nx_d*ny_d*nz_d,nx_d*ny_d*nz_d);

a=0;
D_d=zeros(nx_d*ny_d*nz_d,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
           a=a+1;
           if i1==1
               D_d(a,1)=Ty_d(i1,j1,k1);
           else
           D_d(a,1)=0;
           end
        end
    end
end

 P_d=T\sparse(D_d);
 P_d=full(P_d);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 
 %rate calculation
 i1=1;
 q_d=0;
 for k1=1:nz_d
     for j1=1:nx_d
         q_d=q_d+Ty_d(i1,j1,k1)*(1-P_d(i1,j1,k1));
     end
 end
 ky_new(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)= q_d*ny_d*10/(nx_d*20*nz_d*2*0.00633);
        end
    end
end

% layers 31-35

for i=1:2:ny
        for j=1:2:nx
   
nx_d=2;
ny_d=2;
nz_d=5;
Tx_d=zeros(ny_d,nx_d+1,nz_d);
Tx_d=zeros(ny_d,nx_d+1,nz_d);

% left trans for x= is zero
for k1=1:nz_d
    for i1=1:ny_d
        j1=1;
        Tx_d(i1,j1,k1)=0;
    end
end

% trans for x=right side

for k1=1:nz_d
    for i1=1:ny_d
        j1=nx_d+1;
        Tx_d(i1,j1,k1)=0;
    end
end

% trans for x direction for cells in between
k2=k;

for k1=1:nz_d
    i2=i;
    for i1=1:ny_d
        j2=j+1;
        for j1=2:nx_d
            
            T1=(2*0.00633*400*kx(i2,j2-1,k2)/20^2);
            T2=(2*0.00633*400*kx(i2,j2,k2)/20^2);
            
            Tx_d(i1,j1,k1)=T1*T2/(T1+T2);
            if Tx_d(i1,j1,k1)==0
                Tx_d(i1,j1,k1)=10^-15;
            end
            j2=j2+1;
        end
        i2=i2+1;
    end
    k2=k2+1;
end
Ty_d=zeros(ny_d+1,nx_d,nz_d);

i2=i;
k2=k;
i1=1;
for k1=1:nz_d
    j2=j;
    for j1=1:nx_d
        Ty_d(i1,j1,k1)=2*ky(i2,j2,k2)*0.00633*20*2/10;
        j2=j2+1;
    end
    k2=k2+1;
end
% south T=0

i2=i+ny_d-1;
k2=k;
i1=ny_d+1;
for k1=1:nz_d
    j2=j;
    for j1=1:nx_d
        Ty_d(i1,j1,k1)=2*ky(i2,j2,k2)*0.00633*20*2/10;
        j2=j2+1;
    end
    k2=k2+1;
end
% T in y direction for rest of the cells

k2=k;
for k1=1:nz_d
    i2=i+1;
    for i1=2:ny_d
        j2=j;
        for j1=1:nx_d
            
            T1=(2*0.00633*400*ky(i2-1,j2,k2)/10^2);
            T2=(2*0.00633*400*ky(i2,j2,k2)/10^2);
            Ty_d(i1,j1,k1)=T1*T2/(T1+T2);
            if Ty_d(i1,j1,k1)==0
                Ty_d(i1,j1,k1)=10^-15;
            end
            j2=j2+1;
        end
        i2=i2+1;
    end
    k2=k2+1;
end

% Top T is zero
k1=1;
for i1=1:ny_d
    for j1=1:nx_d
        Tz_d(i1,j1,k1)=0;
    end
end

% bottom T is zero
k1=nz_d+1;
for i1=1:ny_d
    for j1=1:nx_d
        Tz_d(i1,j1,k1)=0;
    end
end

% Tz for between cells
k2=k+1;
for k1=2:nz_d
    i2=i;
  for  i1=1:ny_d
      j2=j;
    for j1=1:nx_d
     T1=(2*0.00633*400*kz(i2,j2,k2-1)/2^2);
     T2=(2*0.00633*400*kz(i2,j2,k2)/2^2);
     Tz_d(i1,j1,k1)=T1*T2/(T1+T2); 
     if Tz_d(i1,j1,k1)==0
                Tz_d(i1,j1,k1)=10^-15;
     end
      j2=j2+1;
    end
    i2=i2+1;
  end
  k2=k2+1;
end

N=(nx_d)*(ny_d)*(nz_d);

%i+1 diagonal


a=0;
l=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
              a=a+1;
            
            l(a,1)=-Tx_d(i1,j1+1,k1);
           
          
        end
    end
end

%i-1 diagonal
a=0;
n=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
             a=a+1;
           
            n(a,1)=-Tx_d(i1,j1,k1);
            
           
        end
    end
end

%j+1 diagonal
a=0;
p=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            if i1==ny_d
                p(a,1)=0;
            else
            p(a,1)=-Ty_d(i1+1,j1,k1);
            end
        end
    end
end

% j-1 diagonal
a=0;
q=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            if i1==1
                q(a,1)=0;
            else
            
            q(a,1)=-Ty_d(i1,j1,k1);
            end
        end
    end
end

%k+1 diagonal
a=0;
r=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
          a=a+1;
          
          r(a,1)=-Tz_d(i1,j1,k1+1);
         
        end
    end
end

% k-1 diagonal

a=0;
s=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            
            s(a,1)=-Tz_d(i1,j1,k1);
            
        end
    end
end

%Center diagonal

a=0;
c=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1; 
           
            c(a,1)=Tz_d(i1,j1,k1)+Tz_d(i1,j1,k1+1)+Ty_d(i1,j1,k1)+Ty_d(i1+1,j1,k1)+Tx_d(i1,j1,k1)+Tx_d(i1,j1+1,k1);
            
        end
    end
end

% Transmissibility matrix
B=[ r p l c n q s];
T=spdiags(B,[-nx_d*ny_d,-nx_d,-1,0,1,nx_d,nx_d*ny_d],nx_d*ny_d*nz_d,nx_d*ny_d*nz_d);

a=0;
D_d=zeros(nx_d*ny_d*nz_d,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
           a=a+1;
           if i1==1
               D_d(a,1)=Ty_d(i1,j1,k1);
           else
           D_d(a,1)=0;
           end
        end
    end
end

 P_d=T\sparse(D_d);
 P_d=full(P_d);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 
 %rate calculation
 i1=1;
 q_d=0;
 for k1=1:nz_d
     for j1=1:nx_d
         q_d=q_d+Ty_d(i1,j1,k1)*(1-P_d(i1,j1,k1));
     end
 end
 ky_new(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)= q_d*ny_d*10/(nx_d*20*nz_d*2*0.00633);
        end
end

% layers 36-83

for k=36:6:78
    for i=1:2:ny
        for j=1:2:nx
   
nx_d=2;
ny_d=2;
nz_d=6;
Tx_d=zeros(ny_d,nx_d+1,nz_d);


% left trans for x= is zero
for k1=1:nz_d
    for i1=1:ny_d
        j1=1;
        Tx_d(i1,j1,k1)=0;
    end
end

% trans for x=right side

for k1=1:nz_d
    for i1=1:ny_d
        j1=nx_d+1;
        Tx_d(i1,j1,k1)=0;
    end
end

% trans for x direction for cells in between
k2=k;

for k1=1:nz_d
    i2=i;
    for i1=1:ny_d
        j2=j+1;
        for j1=2:nx_d
            
            T1=(2*0.00633*400*kx(i2,j2-1,k2)/20^2);
            T2=(2*0.00633*400*kx(i2,j2,k2)/20^2);
            
            Tx_d(i1,j1,k1)=T1*T2/(T1+T2);
            if Tx_d(i1,j1,k1)==0
                Tx_d(i1,j1,k1)=10^-15;
            end
            j2=j2+1;
        end
        i2=i2+1;
    end
    k2=k2+1;
end
Ty_d=zeros(ny_d+1,nx_d,nz_d);

i2=i;
k2=k;
i1=1;
for k1=1:nz_d
    j2=j;
    for j1=1:nx_d
        Ty_d(i1,j1,k1)=2*ky(i2,j2,k2)*0.00633*20*2/10;
        j2=j2+1;
    end
    k2=k2+1;
end
% south T=0

i2=i+ny_d-1;
k2=k;
i1=ny_d+1;
for k1=1:nz_d
    j2=j;
    for j1=1:nx_d
        Ty_d(i1,j1,k1)=2*ky(i2,j2,k2)*0.00633*20*2/10;
        j2=j2+1;
    end
    k2=k2+1;
end
% T in y direction for rest of the cells

k2=k;
for k1=1:nz_d
    i2=i+1;
    for i1=2:ny_d
        j2=j;
        for j1=1:nx_d
            
            T1=(2*0.00633*400*ky(i2-1,j2,k2)/10^2);
            T2=(2*0.00633*400*ky(i2,j2,k2)/10^2);
            Ty_d(i1,j1,k1)=T1*T2/(T1+T2);
            if Ty_d(i1,j1,k1)==0
                Ty_d(i1,j1,k1)=10^-15;
            end
            j2=j2+1;
        end
        i2=i2+1;
    end
    k2=k2+1;
end

% Top T is zero
k1=1;
for i1=1:ny_d
    for j1=1:nx_d
        Tz_d(i1,j1,k1)=0;
    end
end

% bottom T is zero
k1=nz_d+1;
for i1=1:ny_d
    for j1=1:nx_d
        Tz_d(i1,j1,k1)=0;
    end
end

% Tz for between cells
k2=k+1;
for k1=2:nz_d
    i2=i;
  for  i1=1:ny_d
      j2=j;
    for j1=1:nx_d
     T1=(2*0.00633*400*kz(i2,j2,k2-1)/2^2);
     T2=(2*0.00633*400*kz(i2,j2,k2)/2^2);
     Tz_d(i1,j1,k1)=T1*T2/(T1+T2); 
     if Tz_d(i1,j1,k1)==0
                Tz_d(i1,j1,k1)=10^-15;
     end
      j2=j2+1;
    end
    i2=i2+1;
  end
  k2=k2+1;
end

N=(nx_d)*(ny_d)*(nz_d);

%i+1 diagonal


a=0;
l=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
              a=a+1;
            
            l(a,1)=-Tx_d(i1,j1+1,k1);
           
          
        end
    end
end

%i-1 diagonal
a=0;
n=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
             a=a+1;
           
            n(a,1)=-Tx_d(i1,j1,k1);
            
           
        end
    end
end

%j+1 diagonal
a=0;
p=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            if i1==ny_d
                p(a,1)=0;
            else
            p(a,1)=-Ty_d(i1+1,j1,k1);
            end
        end
    end
end

% j-1 diagonal
a=0;
q=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            if i1==1
                q(a,1)=0;
            else
            
            q(a,1)=-Ty_d(i1,j1,k1);
            end
        end
    end
end

%k+1 diagonal
a=0;
r=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
          a=a+1;
          
          r(a,1)=-Tz_d(i1,j1,k1+1);
         
        end
    end
end

% k-1 diagonal

a=0;
s=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            
            s(a,1)=-Tz_d(i1,j1,k1);
            
        end
    end
end

%Center diagonal

a=0;
c=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1; 
           
            c(a,1)=Tz_d(i1,j1,k1)+Tz_d(i1,j1,k1+1)+Ty_d(i1,j1,k1)+Ty_d(i1+1,j1,k1)+Tx_d(i1,j1,k1)+Tx_d(i1,j1+1,k1);
            
        end
    end
end

% Transmissibility matrix
B=[ r p l c n q s];
T=spdiags(B,[-nx_d*ny_d,-nx_d,-1,0,1,nx_d,nx_d*ny_d],nx_d*ny_d*nz_d,nx_d*ny_d*nz_d);

a=0;
D_d=zeros(nx_d*ny_d*nz_d,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
           a=a+1;
           if i1==1
               D_d(a,1)=Ty_d(i1,j1,k1);
           else
           D_d(a,1)=0;
           end
        end
    end
end

 P_d=T\sparse(D_d);
 P_d=full(P_d);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 
 %rate calculation
 i1=1;
 q_d=0;
 for k1=1:nz_d
     for j1=1:nx_d
         q_d=q_d+Ty_d(i1,j1,k1)*(1-P_d(i1,j1,k1));
     end
 end
 ky_new(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)= q_d*ny_d*10/(nx_d*20*nz_d*2*0.00633);
        end
    end
end

% layers 84-85

k=84;
    for i=1:2:ny
        for j=1:2:nx
   
nx_d=2;
ny_d=2;
nz_d=2;
Tx_d=zeros(ny_d,nx_d+1,nz_d);


% left trans for x= is zero
for k1=1:nz_d
    for i1=1:ny_d
        j1=1;
        Tx_d(i1,j1,k1)=0;
    end
end

% trans for x=right side

for k1=1:nz_d
    for i1=1:ny_d
        j1=nx_d+1;
        Tx_d(i1,j1,k1)=0;
    end
end

% trans for x direction for cells in between
k2=k;

for k1=1:nz_d
    i2=i;
    for i1=1:ny_d
        j2=j+1;
        for j1=2:nx_d
            
            T1=(2*0.00633*400*kx(i2,j2-1,k2)/20^2);
            T2=(2*0.00633*400*kx(i2,j2,k2)/20^2);
            
            Tx_d(i1,j1,k1)=T1*T2/(T1+T2);
            if Tx_d(i1,j1,k1)==0
                Tx_d(i1,j1,k1)=10^-15;
            end
            j2=j2+1;
        end
        i2=i2+1;
    end
    k2=k2+1;
end
Ty_d=zeros(ny_d+1,nx_d,nz_d);

i2=i;
k2=k;
i1=1;
for k1=1:nz_d
    j2=j;
    for j1=1:nx_d
        Ty_d(i1,j1,k1)=2*ky(i2,j2,k2)*0.00633*20*2/10;
        j2=j2+1;
    end
    k2=k2+1;
end
% south T=0

i2=i+ny_d-1;
k2=k;
i1=ny_d+1;
for k1=1:nz_d
    j2=j;
    for j1=1:nx_d
        Ty_d(i1,j1,k1)=2*ky(i2,j2,k2)*0.00633*20*2/10;
        j2=j2+1;
    end
    k2=k2+1;
end
% T in y direction for rest of the cells

k2=k;
for k1=1:nz_d
    i2=i+1;
    for i1=2:ny_d
        j2=j;
        for j1=1:nx_d
            
            T1=(2*0.00633*400*ky(i2-1,j2,k2)/10^2);
            T2=(2*0.00633*400*ky(i2,j2,k2)/10^2);
            Ty_d(i1,j1,k1)=T1*T2/(T1+T2);
            if Ty_d(i1,j1,k1)==0
                Ty_d(i1,j1,k1)=10^-15;
            end
            j2=j2+1;
        end
        i2=i2+1;
    end
    k2=k2+1;
end

% Top T is zero
k1=1;
for i1=1:ny_d
    for j1=1:nx_d
        Tz_d(i1,j1,k1)=0;
    end
end

% bottom T is zero
k1=nz_d+1;
for i1=1:ny_d
    for j1=1:nx_d
        Tz_d(i1,j1,k1)=0;
    end
end

% Tz for between cells
k2=k+1;
for k1=2:nz_d
    i2=i;
  for  i1=1:ny_d
      j2=j;
    for j1=1:nx_d
     T1=(2*0.00633*400*kz(i2,j2,k2-1)/2^2);
     T2=(2*0.00633*400*kz(i2,j2,k2)/2^2);
     Tz_d(i1,j1,k1)=T1*T2/(T1+T2); 
     if Tz_d(i1,j1,k1)==0
                Tz_d(i1,j1,k1)=10^-15;
     end
      j2=j2+1;
    end
    i2=i2+1;
  end
  k2=k2+1;
end

N=(nx_d)*(ny_d)*(nz_d);

%i+1 diagonal


a=0;
l=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
              a=a+1;
            
            l(a,1)=-Tx_d(i1,j1+1,k1);
           
          
        end
    end
end

%i-1 diagonal
a=0;
n=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
             a=a+1;
           
            n(a,1)=-Tx_d(i1,j1,k1);
            
           
        end
    end
end

%j+1 diagonal
a=0;
p=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            if i1==ny_d
                p(a,1)=0;
            else
            p(a,1)=-Ty_d(i1+1,j1,k1);
            end
        end
    end
end

% j-1 diagonal
a=0;
q=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            if i1==1
                q(a,1)=0;
            else
            
            q(a,1)=-Ty_d(i1,j1,k1);
            end
        end
    end
end

%k+1 diagonal
a=0;
r=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
          a=a+1;
          
          r(a,1)=-Tz_d(i1,j1,k1+1);
         
        end
    end
end

% k-1 diagonal

a=0;
s=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1;
            
            s(a,1)=-Tz_d(i1,j1,k1);
            
        end
    end
end

%Center diagonal

a=0;
c=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
            a=a+1; 
           
            c(a,1)=Tz_d(i1,j1,k1)+Tz_d(i1,j1,k1+1)+Ty_d(i1,j1,k1)+Ty_d(i1+1,j1,k1)+Tx_d(i1,j1,k1)+Tx_d(i1,j1+1,k1);
            
        end
    end
end

% Transmissibility matrix
B=[ r p l c n q s];
T=spdiags(B,[-nx_d*ny_d,-nx_d,-1,0,1,nx_d,nx_d*ny_d],nx_d*ny_d*nz_d,nx_d*ny_d*nz_d);

a=0;
D_d=zeros(nx_d*ny_d*nz_d,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
           a=a+1;
           if i1==1
               D_d(a,1)=Ty_d(i1,j1,k1);
           else
           D_d(a,1)=0;
           end
        end
    end
end

 P_d=T\sparse(D_d);
 P_d=full(P_d);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 
 %rate calculation
 i1=1;
 q_d=0;
 for k1=1:nz_d
     for j1=1:nx_d
         q_d=q_d+Ty_d(i1,j1,k1)*(1-P_d(i1,j1,k1));
     end
 end
 ky_new(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)= q_d*ny_d*10/(nx_d*20*nz_d*2*0.00633);
        end
    end

    % set zero perms to low value

for k=1:nz_226
    for i=1:ny_226
        for j=1:nx_226
            if ky_new(i,j,k)==0
                ky_new(i,j,k)=10^-4;
                
            end
        end
    end
end
% new transmissibility calculation
Ty_226_perm=zeros(ny_226+1,nx_226,nz_226);
% side t=0
for k=1:nz_226
    for j=1:nx_226
        i=1;
        Ty_226_perm(i,j,k)=0;
    end   
end

% bottom T=0
for k=1:nz_226
    for j=1:nx_226
        i=ny_226+1;
        Ty_226_perm(i,j,k)=0;
    end   
end
% Ty for between cells

for k=1:nz_226
  for  i=2:ny_226
    for j=1:nx_226

     T1=(2*0.00633*400*ky_new(i-1,j,k)/10^2);
     T2=(2*0.00633*400*ky_new(i,j,k)/10^2);
     Ty_226_perm(i,j,k)=T1*T2/(T1+T2); 
    end
  end
end
