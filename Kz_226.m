%z diretion 2*2*6 upscaling
ny_226=110;
nx_226=30;
nz_226=15;
kz_new=zeros(ny_226,nx_226,nz_226);

% left trans for constant pressure on left side x=0
%layers 1-3

for k=1:6:25
    for i=1:2:ny
        for j=1:2:nx


nx_d=2;
ny_d=2;
nz_d=6;
Tx_d=zeros(ny_d,nx_d+1,nz_d);
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

% trans for x direction for cells i between
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
% south T=0

for k1=1:nz_d
    for j1=1:nx_d
        i1=1;
        Ty_d(i1,j1,k1)=0;
    end
end

%north T=0

for k1=1:nz_d
    for j1=1:nx_d
        i1=ny_d+1;
        Ty_d(i1,j1,k1)=0;
    end
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

% Top T is face trans

Tz_d=zeros(ny_d,nx_d,nz_d+1);
i2=i;
k2=k;
for i1=1:ny_d
    j2=j;
    for j1=1:nx_d
        k1=1;
       Tz_d(i1,j1,k1)=(2*0.00633*400*kz(i2,j2,k2)/2^2);
      
      if Tz_d(i1,j1,k1)==0
          Tz_d(i1,j1,k1)=10^-15;
      end
       j2=j2+1;
    end 
    i2=i2+1;
end

% bottom T is face trans
i2=i;
k2=k+nz_d-1;
for i1=1:ny_d
    j2=j;
    for j1=1:nx_d
        k1=nz_d+1;
         Tz_d(i1,j1,k1)=(2*0.00633*400*kz(i2,j2,k2)/2^2);
      
      if Tz_d(i1,j1,k1)==0
          Tz_d(i1,j1,k1)=10^-15;
      end
       j2=j2+1;
    end
    i2=i2+1;
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
          if k1==nz_d
              r(a,1)=0;
          else
          r(a,1)=-Tz_d(i1,j1,k1+1);
          end
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
            if k1==1;
                s(a,1)=0;
            else
            s(a,1)=-Tz_d(i1,j1,k1);
            end
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
           if k1==1
               D_d(a,1)=Tz_d(i1,j1,k1);
           else
           D_d(a,1)=0;
           end
        end
    end
end

 P=T\sparse(D_d);
 P=full(P);
 P=reshape(P,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P1(:,:,k1)=P(:,:,k1)';
 end
 %rate calculation
 q_d=0;
 k1=1;
 for i1=1:ny_d
     for j1=1:nx_d
         q_d=q_d+Tz_d(i1,j1,k1)*(1-P1(i1,j1,k1));
     end
 end
 kz_new(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)= q_d*nz_d*2/(nx_d*20*ny_d*10*0.00633);
        end
    end
end

% layers 31-35

k=31;
    for i=1:2:ny
        for j=1:2:nx
   
nx_d=2;
ny_d=2;
nz_d=5;
Tx_d=zeros(ny_d,nx_d+1,nz_d);
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

% trans for x direction for cells i between
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
% south T=0

for k1=1:nz_d
    for j1=1:nx_d
        i1=1;
        Ty_d(i1,j1,k1)=0;
    end
end

%north T=0

for k1=1:nz_d
    for j1=1:nx_d
        i1=ny_d+1;
        Ty_d(i1,j1,k1)=0;
    end
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

% Top T is face trans

Tz_d=zeros(ny_d,nx_d,nz_d+1);
i2=i;
k2=k;
for i1=1:ny_d
    j2=j;
    for j1=1:nx_d
        k1=1;
       Tz_d(i1,j1,k1)=(2*0.00633*400*kz(i2,j2,k2)/2^2);
      
      if Tz_d(i1,j1,k1)==0
          Tz_d(i1,j1,k1)=10^-15;
      end
       j2=j2+1;
    end 
    i2=i2+1;
end

% bottom T is face trans
i2=i;
k2=k+nz_d-1;
for i1=1:ny_d
    j2=j;
    for j1=1:nx_d
        k1=nz_d+1;
         Tz_d(i1,j1,k1)=(2*0.00633*400*kz(i2,j2,k2)/2^2);
      
      if Tz_d(i1,j1,k1)==0
          Tz_d(i1,j1,k1)=10^-15;
      end
       j2=j2+1;
    end
    i2=i2+1;
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
          if k1==nz_d
              r(a,1)=0;
          else
          r(a,1)=-Tz_d(i1,j1,k1+1);
          end
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
            if k1==1;
                s(a,1)=0;
            else
            s(a,1)=-Tz_d(i1,j1,k1);
            end
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
           if k1==1
               D_d(a,1)=Tz_d(i1,j1,k1);
           else
           D_d(a,1)=0;
           end
        end
    end
end

P=T\sparse(D_d);
 P=full(P);
 P=reshape(P,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P1(:,:,k1)=P(:,:,k1)';
 end
 
 %rate calculation
 q_d=0;
 k1=1;
 for i1=1:ny_d
     for j1=1:nx_d
         q_d=q_d+Tz_d(i1,j1,k1)*(1-P(i1,j1,k1));
     end
 end
kz_new(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)= q_d*nz_d*2/(nx_d*20*ny_d*10*0.00633);
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

% trans for x direction for cells i between
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
% south T=0

for k1=1:nz_d
    for j1=1:nx_d
        i1=1;
        Ty_d(i1,j1,k1)=0;
    end
end

%north T=0

for k1=1:nz_d
    for j1=1:nx_d
        i1=ny_d+1;
        Ty_d(i1,j1,k1)=0;
    end
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

% Top T is face trans

Tz_d=zeros(ny_d,nx_d,nz_d+1);
i2=i;
k2=k;
for i1=1:ny_d
    j2=j;
    for j1=1:nx_d
        k1=1;
       Tz_d(i1,j1,k1)=(2*0.00633*400*kz(i2,j2,k2)/2^2);
      
      if Tz_d(i1,j1,k1)==0
          Tz_d(i1,j1,k1)=10^-15;
      end
       j2=j2+1;
    end 
    i2=i2+1;
end

% bottom T is face trans
i2=i;
k2=k+nz_d-1;
for i1=1:ny_d
    j2=j;
    for j1=1:nx_d
        k1=nz_d+1;
         Tz_d(i1,j1,k1)=(2*0.00633*400*kz(i2,j2,k2)/2^2);
      
      if Tz_d(i1,j1,k1)==0
          Tz_d(i1,j1,k1)=10^-15;
      end
       j2=j2+1;
    end
    i2=i2+1;
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
          if k1==nz_d
              r(a,1)=0;
          else
          r(a,1)=-Tz_d(i1,j1,k1+1);
          end
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
            if k1==1;
                s(a,1)=0;
            else
            s(a,1)=-Tz_d(i1,j1,k1);
            end
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
           if k1==1
               D_d(a,1)=Tz_d(i1,j1,k1);
           else
           D_d(a,1)=0;
           end
        end
    end
end

P=T\sparse(D_d);
  P=full(P);
 P=reshape(P,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P1(:,:,k1)=P(:,:,k1)';
 end

 %rate calculation
 q_d=0;
 k1=1;
 for i1=1:ny_d
     for j1=1:nx_d
         q_d=q_d+Tz_d(i1,j1,k1)*(1-P1(i1,j1,k1));
     end
 end
 kz_new(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)= q_d*nz_d*2/(nx_d*20*ny_d*10*0.00633);
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

% trans for x direction for cells i between
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
% south T=0

for k1=1:nz_d
    for j1=1:nx_d
        i1=1;
        Ty_d(i1,j1,k1)=0;
    end
end

%north T=0

for k1=1:nz_d
    for j1=1:nx_d
        i1=ny_d+1;
        Ty_d(i1,j1,k1)=0;
    end
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

% Top T is face trans

Tz_d=zeros(ny_d,nx_d,nz_d+1);
i2=i;
k2=k;
for i1=1:ny_d
    j2=j;
    for j1=1:nx_d
        k1=1;
       Tz_d(i1,j1,k1)=(2*0.00633*400*kz(i2,j2,k2)/2^2);
      
      if Tz_d(i1,j1,k1)==0
          Tz_d(i1,j1,k1)=10^-15;
      end
       j2=j2+1;
    end 
    i2=i2+1;
end

% bottom T is face trans
i2=i;
k2=k+nz_d-1;
for i1=1:ny_d
    j2=j;
    for j1=1:nx_d
        k1=nz_d+1;
         Tz_d(i1,j1,k1)=(2*0.00633*400*kz(i2,j2,k2)/2^2);
      
      if Tz_d(i1,j1,k1)==0
          Tz_d(i1,j1,k1)=10^-15;
      end
       j2=j2+1;
    end
    i2=i2+1;
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
          if k1==nz_d
              r(a,1)=0;
          else
          r(a,1)=-Tz_d(i1,j1,k1+1);
          end
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
            if k1==1;
                s(a,1)=0;
            else
            s(a,1)=-Tz_d(i1,j1,k1);
            end
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
           if k1==1
               D_d(a,1)=Tz_d(i1,j1,k1);
           else
           D_d(a,1)=0;
           end
        end
    end
end

P=T\sparse(D_d);
 P=full(P);
 P=reshape(P,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P1(:,:,k1)=P(:,:,k1)';
 end

 
 %rate calculation
 q_d=0;
 k1=1;
 for i1=1:ny_d
     for j1=1:nx_d
         q_d=q_d+Tz_d(i1,j1,k1)*(1-P1(i1,j1,k1));
     end
 end
kz_new(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)= q_d*nz_d*2/(nx_d*20*ny_d*10*0.00633);
        end
    end

% set low perms to zero

for k=1:nz_226
    for i=1:ny_226
         for j=1:nx_226
             if kz_new(i,j,k)==0
                 kz_new(i,j,k)=10^-4;
             end
         end
    end
end

% new transmissibility calculation
Tz_226_perm=zeros(ny_226,nx_226,nz_226+1);
%top T=0;
for i=1:ny_226
    for j=1:nx_226
        k=1;
        Tz_226_perm(i,j,k)=0;
    end   
end

% bottom T=0
for i=1:ny_226
    for j=1:nx_226
        k=nz_226+1;
        Tz_226_perm(i,j,k)=0;
    end   
end

% Tz for between cells

for k=2:nz_226
  for  i=1:ny_226
    for j=1:nx_226

     T1=(2*0.00633*400*kz_new(i,j,k-1)/2^2);
     T2=(2*0.00633*400*kz_new(i,j,k)/2^2);
     Tz_226_perm(i,j,k)=T1*T2/(T1+T2); 
     
    end
  end
end
