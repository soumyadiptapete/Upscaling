nx=nx_446;
ny=ny_446;
nz=nz_446;

N=(nx)*(ny)*(nz);
Pwfi=3000;
Pwfp=500;
%write the new transmissibilities
Tx=Tx_446_perm;
Ty=Ty_446_perm;
Tz=Tz_446_perm;

%write new permeabilities
kx=(kx_new.*ky_new).^0.5;

%i+1 diagonal


a=0;
l=zeros(N,1);
for k=1:nz
    for i=1:ny
        for j=1:nx
              a=a+1;
            
            l(a,1)=-Tx(i,j+1,k);
           
          
        end
    end
end

%i-1 diagonal
a=0;
n=zeros(N,1);
for k=1:nz
    for i=1:ny
        for j=1:nx
             a=a+1;
           
            n(a,1)=-Tx(i,j,k);
            
           
        end
    end
end

%j+1 diagonal
a=0;
p=zeros(N,1);
for k=1:nz
    for i=1:ny
        for j=1:nx
            a=a+1;
            p(a,1)=-Ty(i+1,j,k);
        end
    end
end

% j-1 diagonal
a=0;
q=zeros(N,1);
for k=1:nz
    for i=1:ny
        for j=1:nx
            a=a+1;
            q(a,1)=-Ty(i,j,k);
        end
    end
end

%k+1 diagonal
a=0;
r=zeros(N,1);
for k=1:nz
    for i=1:ny
        for j=1:nx
          a=a+1;
          r(a,1)=-Tz(i,j,k+1);
        end
    end
end

% k-1 diagonal

a=0;
s=zeros(N,1);
for k=1:nz
    for i=1:ny
        for j=1:nx
            a=a+1;
            s(a,1)=-Tz(i,j,k);
        end
    end
end

%Center diagonal

a=0;
c=zeros(N,1);
for k=1:nz
    for i=1:ny
        for j=1:nx
            a=a+1; 
           
            if i==28 && j==8 
               c(a,1)=(44/7)*kx(i,j,k)*(2)*0.00633/(log(0.14*(20^2+10^2)^0.5/0.25))+Tz(i,j,k)+Tz(i,j,k+1)+Ty(i,j,k)+Ty(i+1,j,k)+Tx(i,j,k)+Tx(i,j+1,k);
               
            elseif i==1 && j==1 || i==1 && j==15 || i==55 && j==1 || i==55 && j==15
               c(a,1)=(44/7)*kx(i,j,k)*(2)*0.00633/(log(0.14*(20^2+10^2)^0.5/0.25))+Tz(i,j,k)+Tz(i,j,k+1)+Ty(i,j,k)+Ty(i+1,j,k)+Tx(i,j,k)+Tx(i,j+1,k);
               
           else
          
            c(a,1)=Tz(i,j,k)+Tz(i,j,k+1)+Ty(i,j,k)+Ty(i+1,j,k)+Tx(i,j,k)+Tx(i,j+1,k);
            end
        end
    end
end
B=[];
T=[];

% Transmissibility matrix
B=[ r p l c n q s];
T=spdiags(B,[-nx*ny,-nx,-1,0,1,nx,nx*ny],nx*ny*nz,nx*ny*nz);

a=0;
D=zeros(nx*ny*nz,1);
for k=1:nz
    for i=1:ny
        for j=1:nx
           a=a+1;
           
           if i==28 && j==8
               D(a,1)= Pwfi*(44/7)*kx(i,j,k)*(2)*0.00633/(log(0.14*(20^2+10^2)^0.5/0.25));
               
            elseif i==1 && j==1 || i==1 && j==60 || i==220 && j==1 || i==220 && j==60
               D(a,1)= Pwfp*(44/7)*kx(i,j,k)*(2)*0.00633/(log(0.14*(20^2+10^2)^0.5/0.25));
               
           else
           D(a,1)=0;
           end
        end
    end
end

clear Xcorn Ycorn Zcorn  l n p q r s B c;

P1=sparse(T)\sparse(D);
P1=full(P1);
P1=reshape(P1,nx,ny,nz);
for k=1:nz
    P(:,:,k)=P1(:,:,k)';
end
clear P1;

qx= zeros(ny,nx+1,nz);
for k=1:nz
    for i=1:ny
        for j=2:nx
            
            qx(i,j,k)=-Tx(i,j,k)*(P(i,j,k)-P(i,j-1,k));
            
        end
    end
end

qy= zeros(ny+1,nx,nz);
for k=1:nz
    for i=2:ny
        for j=1:nx
            qy(i,j,k)=-Ty(i,j,k)*(P(i,j,k)-P(i-1,j,k));
        end
    end
end

qz= zeros(ny,nx,nz+1);
for k=2:nz
    for i=1:ny
        for j=1:nx
            qz(i,j,k)=-Tz(i,j,k)*(P(i,j,k)-P(i,j,k-1));
        end
    end
end



