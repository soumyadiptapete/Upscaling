% transmissibility upscaler in y direction
% Layers 1-30
Ty_new=zeros(111,30,15);
for k=1:6:25
    for i=3:2:ny-1
        for j=2:2:nx
%upscaling in y-direction

nx_d=2;
ny_d=2;
nz_d=6;
k_d1=k;
N=nx_d*ny_d*nz_d;
for z=1:nz_d
    Tx_d(1,1,z)=0;
    Tx_d(2,1,z)=0;
    Tx_d(1,2,z)=Tx(i-1,j,k_d1);
    Tx_d(2,2,z)=Tx(i,j,k_d1);
    Tx_d(1,3,z)=0;
    Tx_d(2,3,z)=0;
    Ty_d(1,1,z)=2*0.00633*ky(i-1,j-1,k_d1)*400/10^2;
    Ty_d(2,1,z)=Ty(i,j-1,k_d1);
    Ty_d(3,1,z)=2*ky(i,j-1,k_d1)*0.00633*400/10^2;
    Ty_d(1,2,z)=2*ky(i-1,j,k_d1)*0.00633*400/10^2;
    Ty_d(2,2,z)=Ty(i,j,k_d1);
    Ty_d(3,2,z)=2*0.00633*ky(i,j,k_d1)*400/10^2;
    k_d1=k_d1+1;
end

for i1=1:2
    for j1=1:2
        z=1;
        Tz_d(i1,j1,z)=0;
        z=7;
        Tz_d(i1,j1,z)=0;
    end
end

k_d=k+1;
for z=2:6
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



 P=T\sparse(D_d);
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 %rate calculation
 q_d=0;
 for k1=1:nz_d
     q_d=q_d+Ty_d(1,1,k1)*(1-P_d(1,1,k1))+Ty_d(1,2,k1)*(1-P_d(1,2,k1));
 end
 
 Ty_new(((i-1)/2)+1,j/2,floor(k/6)+1)=q_d;
 
        end
    end
end
%layers 31-35


    for i=3:2:ny-1
        for j=2:2:nx
%upscaling in x-direction
k=31;
nx_d=2;
ny_d=2;
nz_d=5;
k_d1=k;
N=nx_d*ny_d*nz_d;
for z=1:nz_d
    Tx_d(1,1,z)=0;
    Tx_d(2,1,z)=0;
    Tx_d(1,2,z)=Tx(i-1,j,k_d1);
    Tx_d(2,2,z)=Tx(i,j,k_d1);
    Tx_d(1,3,z)=0;
    Tx_d(2,3,z)=0;
    Ty_d(1,1,z)=2*0.00633*ky(i-1,j-1,k_d1)*400/10^2;
    Ty_d(2,1,z)=Ty(i,j-1,k_d1);
    Ty_d(3,1,z)=2*ky(i,j-1,k_d1)*0.00633*400/10^2;
    Ty_d(1,2,z)=2*ky(i-1,j,k_d1)*0.00633*400/10^2;
    Ty_d(2,2,z)=Ty(i,j,k_d1);
    Ty_d(3,2,z)=2*0.00633*ky(i,j,k_d1)*400/10^2;
    k_d1=k_d1+1;
end

for i1=1:2
    for j1=1:2
        z=1;
        Tz_d(i1,j1,z)=0;
        z=6;
        Tz_d(i1,j1,z)=0;
    end
end

k_d=k+1;
for z=2:5
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



 P=T\sparse(D_d);
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 %rate calculation
 q_d=0;
 for k1=1:nz_d
     q_d=q_d+Ty_d(1,1,k1)*(1-P_d(1,1,k1))+Ty_d(1,2,k1)*(1-P_d(1,2,k1));
 end
 
  Ty_new(((i-1)/2)+1,j/2,floor(k/6)+1)=q_d;
 
        end
    end
    
    
%layers 36-83    
for k=36:6:78
    for i=3:2:ny-1
        for j=2:2:nx
%upscaling in x-direction
nx_d=2;
ny_d=2;
nz_d=6;
k_d1=k;
N=nx_d*ny_d*nz_d;
for z=1:nz_d
    Tx_d(1,1,z)=0;
    Tx_d(2,1,z)=0;
    Tx_d(1,2,z)=Tx(i-1,j,k_d1);
    Tx_d(2,2,z)=Tx(i,j,k_d1);
    Tx_d(1,3,z)=0;
    Tx_d(2,3,z)=0;
    Ty_d(1,1,z)=2*0.00633*ky(i-1,j-1,k_d1)*400/10^2;
    Ty_d(2,1,z)=Ty(i,j-1,k_d1);
    Ty_d(3,1,z)=2*ky(i,j-1,k_d1)*0.00633*400/10^2;
    Ty_d(1,2,z)=2*ky(i-1,j,k_d1)*0.00633*400/10^2;
    Ty_d(2,2,z)=Ty(i,j,k_d1);
    Ty_d(3,2,z)=2*0.00633*ky(i,j,k_d1)*400/10^2;
    k_d1=k_d1+1;
end

for i1=1:2
    for j1=1:2
        z=1;
        Tz_d(i1,j1,z)=0;
        z=7;
        Tz_d(i1,j1,z)=0;
    end
end

k_d=k+1;
for z=2:6
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



 P=T\sparse(D_d);
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 %rate calculation
 q_d=0;
 for k1=1:nz_d
     q_d=q_d+Ty_d(1,1,k1)*(1-P_d(1,1,k1))+Ty_d(1,2,k1)*(1-P_d(1,2,k1));
 end
 
  Ty_new(((i-1)/2)+1,j/2,floor(k/6)+1)=q_d;
 
        end
    end
end

%layers 84-85


    for i=3:2:ny-1
        for j=2:2:nx
%upscaling in x-direction
k=84;
nx_d=2;
ny_d=2;
nz_d=2;
k_d1=k;
N=nx_d*ny_d*nz_d;
for z=1:nz_d
    Tx_d(1,1,z)=0;
    Tx_d(2,1,z)=0;
    Tx_d(1,2,z)=Tx(i-1,j,k_d1);
    Tx_d(2,2,z)=Tx(i,j,k_d1);
    Tx_d(1,3,z)=0;
    Tx_d(2,3,z)=0;
    Ty_d(1,1,z)=2*0.00633*ky(i-1,j-1,k_d1)*400/10^2;
    Ty_d(2,1,z)=Ty(i,j-1,k_d1);
    Ty_d(3,1,z)=2*ky(i,j-1,k_d1)*0.00633*400/10^2;
    Ty_d(1,2,z)=2*ky(i-1,j,k_d1)*0.00633*400/10^2;
    Ty_d(2,2,z)=Ty(i,j,k_d1);
    Ty_d(3,2,z)=2*0.00633*ky(i,j,k_d1)*400/10^2;
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



 P=T\sparse(D_d);
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
 %rate calculation
 q_d=0;
 for k1=1:nz_d
     q_d=q_d+Ty_d(1,1,k1)*(1-P_d(1,1,k1))+Ty_d(1,2,k1)*(1-P_d(1,2,k1));
 end
 
 Ty_new(((i-1)/2)+1,j/2,floor(k/6)+1)=q_d;
 
        end
    end

Ty_226=Ty_new;
clear Ty_new;


