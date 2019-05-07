%transmissibility upscaler in x-direction 2x2x12
%Layers 1-30
Tx_new=zeros(110,31,8);
for k=1:12:24
    for i=2:2:ny
        for j=3:2:nx-1
%upscaling in x-direction

nx_d=2;
ny_d=2;
nz_d=12;
k_d1=k;
N=nx_d*ny_d*nz_d;
for z=1:nz_d
    Tx_d(1,1,z)=2*kx(i-1,j-1,k_d1)*0.00633*400/20^2;
    Tx_d(2,1,z)=2*kx(i,j-1,k_d1)*0.00633*400/20^2;
    Tx_d(1,2,z)=Tx(i-1,j,k_d1);
    Tx_d(2,2,z)=Tx(i,j,k_d1);
    Tx_d(1,3,z)=2*kx(i-1,j,k_d1)*0.00633*400/20^2;
    Tx_d(2,3,z)=2*kx(i,j,k_d1)*0.00633*400/20^2;
    Ty_d(1,1,z)=0;
    Ty_d(2,1,z)=Ty(i,j-1,k_d1);
    Ty_d(3,1,z)=0;
    Ty_d(1,2,z)=0;
    Ty_d(2,2,z)=Ty(i,j,k_d1);
    Ty_d(3,2,z)=0;
    k_d1=k_d1+1;
end

for i1=1:2
    for j1=1:2
        z=1;
        Tz_d(i1,j1,z)=0;
        z=13;
        Tz_d(i1,j1,z)=0;
    end
end

k_d=k+1;
for z=2:12
   Tz_d(1,1,z)=Tz(i-1,j-1,k_d);
   Tz_d(1,2,z)=Tz(i-1,j,k_d);
   Tz_d(2,1,z)=Tz(i,j-1,k_d);
   Tz_d(2,2,z)=Tz(i,j,k_d);
 k_d=k_d+1;
 end

        
%i+1 diagonal
a=0;
l=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
              a=a+1;
            if j1==nx_d
                l(a,1)=0;
            else
            l(a,1)=-Tx_d(i1,j1+1,k1);
            end  
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
            if j1==1
                n(a,1)=0;
            else
            n(a,1)=-Tx_d(i1,j1,k1);
            end  
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
            p(a,1)=-Ty_d(i1+1,j1,k1);    
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
            q(a,1)=-Ty_d(i1,j1,k1);    
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
           if j1==1;
               D_d(a,1)=Tx_d(i1,j1,k1);
           else    
           D_d(a,1)=0;
           end
        end
    end
end



 P=T\sparse(D_d);
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 %rate calculation
 q_d=0;
 for k1=1:nz_d
     q_d=q_d+Tx_d(1,1,k1)*(1-P_d(1,1,k1))+Tx_d(2,1,k1)*(1-P_d(2,1,k1));
 end
 
 Tx_new(i/2,((j-1)/2)+1,floor(k/12)+1)=q_d;
 
        end
    end
end
%layers 25-35


    for i=2:2:ny
        for j=3:2:nx-1
%upscaling in x-direction
k=25;
nx_d=2;
ny_d=2;
nz_d=11;
k_d1=k;
N=nx_d*ny_d*nz_d;
for z=1:nz_d
    Tx_d(1,1,z)=2*kx(i-1,j-1,k_d1)*0.00633*400/20^2;
    Tx_d(2,1,z)=2*kx(i,j-1,k_d1)*0.00633*400/20^2;
    Tx_d(1,2,z)=Tx(i-1,j,k_d1);
    Tx_d(2,2,z)=Tx(i,j,k_d1);
    Tx_d(1,3,z)=2*kx(i-1,j,k_d1)*0.00633*400/20^2;
    Tx_d(2,3,z)=2*kx(i,j,k_d1)*0.00633*400/20^2;
    Ty_d(1,1,z)=0;
    Ty_d(2,1,z)=Ty(i,j-1,k_d1);
    Ty_d(3,1,z)=0;
    Ty_d(1,2,z)=0;
    Ty_d(2,2,z)=Ty(i,j,k_d1);
    Ty_d(3,2,z)=0;
    k_d1=k_d1+1;
end

for i1=1:2
    for j1=1:2
        z=1;
        Tz_d(i1,j1,z)=0;
        z=12;
        Tz_d(i1,j1,z)=0;
    end
end

k_d=k+1;
for z=2:11
   Tz_d(1,1,z)=Tz(i-1,j-1,k_d);
   Tz_d(1,2,z)=Tz(i-1,j,k_d);
   Tz_d(2,1,z)=Tz(i,j-1,k_d);
   Tz_d(2,2,z)=Tz(i,j,k_d);
 k_d=k_d+1;
 end

        
%i+1 diagonal
a=0;
l=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
              a=a+1;
            if j1==nx_d
                l(a,1)=0;
            else
            l(a,1)=-Tx_d(i1,j1+1,k1);
            end  
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
            if j1==1
                n(a,1)=0;
            else
            n(a,1)=-Tx_d(i1,j1,k1);
            end  
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
            p(a,1)=-Ty_d(i1+1,j1,k1);    
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
            q(a,1)=-Ty_d(i1,j1,k1);    
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
           if j1==1;
               D_d(a,1)=Tx_d(i1,j1,k1);
           else    
           D_d(a,1)=0;
           end
        end
    end
end



 P=T\sparse(D_d);
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 %rate calculation
 q_d=0;
 for k1=1:nz_d
     q_d=q_d+Tx_d(1,1,k1)*(1-P_d(1,1,k1))+Tx_d(2,1,k1)*(1-P_d(2,1,k1));
 end
 
 Tx_new(i/2,((j-1)/2)+1,floor(k/12)+1)=q_d;
 
        end
    end
    
    
%layers 36-83    
for k=36:12:72
    for i=2:2:ny
        for j=3:2:nx-1
%upscaling in x-direction
nx_d=2;
ny_d=2;
nz_d=12;
k_d1=k;
N=nx_d*ny_d*nz_d;
for z=1:nz_d
    Tx_d(1,1,z)=2*kx(i-1,j-1,k_d1)*0.00633*400/20^2;
    Tx_d(2,1,z)=2*kx(i,j-1,k_d1)*0.00633*400/20^2;
    Tx_d(1,2,z)=Tx(i-1,j,k_d1);
    Tx_d(2,2,z)=Tx(i,j,k_d1);
    Tx_d(1,3,z)=2*kx(i-1,j,k_d1)*0.00633*400/20^2;
    Tx_d(2,3,z)=2*kx(i,j,k_d1)*0.00633*400/20^2;
    Ty_d(1,1,z)=0;
    Ty_d(2,1,z)=Ty(i,j-1,k_d1);
    Ty_d(3,1,z)=0;
    Ty_d(1,2,z)=0;
    Ty_d(2,2,z)=Ty(i,j,k_d1);
    Ty_d(3,2,z)=0;
    k_d1=k_d1+1;
end

for i1=1:2
    for j1=1:2
        z=1;
        Tz_d(i1,j1,z)=0;
        z=13;
        Tz_d(i1,j1,z)=0;
    end
end

k_d=k+1;
for z=2:12
   Tz_d(1,1,z)=Tz(i-1,j-1,k_d);
   Tz_d(1,2,z)=Tz(i-1,j,k_d);
   Tz_d(2,1,z)=Tz(i,j-1,k_d);
   Tz_d(2,2,z)=Tz(i,j,k_d);
 k_d=k_d+1;
 end

        
%i+1 diagonal
a=0;
l=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
              a=a+1;
            if j1==nx_d
                l(a,1)=0;
            else
            l(a,1)=-Tx_d(i1,j1+1,k1);
            end  
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
            if j1==1
                n(a,1)=0;
            else
            n(a,1)=-Tx_d(i1,j1,k1);
            end  
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
            p(a,1)=-Ty_d(i1+1,j1,k1);    
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
            q(a,1)=-Ty_d(i1,j1,k1);    
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
           if j1==1;
               D_d(a,1)=Tx_d(i1,j1,k1);
           else    
           D_d(a,1)=0;
           end
        end
    end
end



 P=T\sparse(D_d);
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 %rate calculation
 q_d=0;
 for k1=1:nz_d
     q_d=q_d+Tx_d(1,1,k1)*(1-P_d(1,1,k1))+Tx_d(2,1,k1)*(1-P_d(2,1,k1));
 end
 
 Tx_new(i/2,((j-1)/2)+1,floor(k/12)+1)=q_d;
 
        end
    end
end

%layers 84-85


    for i=2:2:ny
        for j=3:2:nx-1
%upscaling in x-direction
k=84;
nx_d=2;
ny_d=2;
nz_d=2;
k_d1=k;
N=nx_d*ny_d*nz_d;
for z=1:nz_d
    Tx_d(1,1,z)=2*kx(i-1,j-1,k_d1)*0.00633*400/20^2;
    Tx_d(2,1,z)=2*kx(i,j-1,k_d1)*0.00633*400/20^2;
    Tx_d(1,2,z)=Tx(i-1,j,k_d1);
    Tx_d(2,2,z)=Tx(i,j,k_d1);
    Tx_d(1,3,z)=2*kx(i-1,j,k_d1)*0.00633*400/20^2;
    Tx_d(2,3,z)=2*kx(i,j,k_d1)*0.00633*400/20^2;
    Ty_d(1,1,z)=0;
    Ty_d(2,1,z)=Ty(i,j-1,k_d1);
    Ty_d(3,1,z)=0;
    Ty_d(1,2,z)=0;
    Ty_d(2,2,z)=Ty(i,j,k_d1);
    Ty_d(3,2,z)=0;
    k_d1=k_d1+1;
end

for i1=1:2
    for j1=1:2
        z=1;
        Tz_d(i1,j1,z)=0;
        z=3;
        Tz_d(i1,j1,z)=0;
    end
end

k_d=k+1;
for z=2:2
   Tz_d(1,1,z)=Tz(i-1,j-1,k_d);
   Tz_d(1,2,z)=Tz(i-1,j,k_d);
   Tz_d(2,1,z)=Tz(i,j-1,k_d);
   Tz_d(2,2,z)=Tz(i,j,k_d);
 k_d=k_d+1;
 end

        
%i+1 diagonal
a=0;
l=zeros(N,1);
for k1=1:nz_d
    for i1=1:ny_d
        for j1=1:nx_d
              a=a+1;
            if j1==nx_d
                l(a,1)=0;
            else
            l(a,1)=-Tx_d(i1,j1+1,k1);
            end  
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
            if j1==1
                n(a,1)=0;
            else
            n(a,1)=-Tx_d(i1,j1,k1);
            end  
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
            p(a,1)=-Ty_d(i1+1,j1,k1);    
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
            q(a,1)=-Ty_d(i1,j1,k1);    
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
           if j1==1;
               D_d(a,1)=Tx_d(i1,j1,k1);
           else    
           D_d(a,1)=0;
           end
        end
    end
end



 P=T\sparse(D_d);
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 %rate calculation
 q_d=0;
 for k1=1:nz_d
     q_d=q_d+Tx_d(1,1,k1)*(1-P_d(1,1,k1))+Tx_d(2,1,k1)*(1-P_d(2,1,k1));
 end
 
 Tx_new(i/2,((j-1)/2)+1,floor(k/12)+1)=q_d;
 
        end
    end

Tx_2212=Tx_new;
clear Tx_new;

