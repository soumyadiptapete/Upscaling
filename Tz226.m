% transmissibility upscaler for Z 2x2x6

%layers 1-30
Tz_226=zeros(110,30,16);
for k=7:6:25
    for i=2:2:ny
        for j=2:2:nx
        
            nx_d=2;
            ny_d=2;
            nz_d=6;
            k2=k-3;
            % x and y direction local ransmissibility
            for k1=1:nz_d
            Tx_d(1,1,k1)=0;
            Tx_d(1,2,k1)=Tx(i-1,j,k2);
            Tx_d(1,3,k1)=0;
            Tx_d(2,1,k1)=0;
            Tx_d(2,2,k1)=Tx(i,j,k2);
            Tx_d(2,3,k1)=0;
            Ty_d(1,1,k1)=0;
            Ty_d(2,1,k1)=0;
            Ty_d(2,1,k1)=Ty(i,j-1,k2);
            Ty_d(2,2,k1)=Ty(i,j,k2);
            Ty_d(3,1,k1)=0;
            Ty_d(3,2,k1)=0;
            k2=k2+1;
            end
            
            % z direction top half trans
            
            k2=k-3;
            k1=1;
            Tz_d(1,1,k1)=0.00633*2*kz(i-1,j-1,k2)*200/2;
            Tz_d(1,2,k1)=0.00633*2*kz(i-1,j,k2)*200/2;
            Tz_d(2,1,k1)=0.00633*2*kz(i,j-1,k2)*200/2;
            Tz_d(2,2,k1)=0.00633*2*kz(i,j,k2)*200/2;
            
            % z direction middle cells trans
            k2=k-2;
          for k1=2:nz_d
            Tz_d(1,1,k1)=Tz(i-1,j-1,k2);
            Tz_d(1,2,k1)=Tz(i-1,j,k2);
            Tz_d(2,1,k1)=Tz(i,j-1,k2);
            Tz_d(2,2,k1)=Tz(i,j,k2);
            k2=k2+1;
           end
            % z direction transmissibilities for bottom end
            k2=k+2;
            k1=nz_d+1;
            
            Tz_d(1,1,k1)=0.00633*2*kz(i-1,j-1,k2)*200/2;
            Tz_d(1,2,k1)=0.00633*2*kz(i-1,j,k2)*200/2;
            Tz_d(2,1,k1)=0.00633*2*kz(i,j-1,k2)*200/2;
            Tz_d(2,2,k1)=0.00633*2*kz(i,j,k2)*200/2;
            
N=nx_d*ny_d*nz_d;
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
              if k1==1
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
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
            
% rate calculation
q_d=0;

for i1=1:ny_d
    for j1=1:nx_d
        k1=1;
        q_d=q_d+ Tz_d(i1,j1,k1)*(1-P_d(i1,j1,k1));
    end
end

Tz_226(i/2,j/2,floor(k/6)+1)= q_d;

        end
    end
end

% for k=31

k=31;
    for i=2:2:ny
        for j=2:2:nx
        
            nx_d=2;
            ny_d=2;
            nz_d=6;
            k2=k-3;
            % x and y direction local ransmissibility
            for k1=1:nz_d
                if k1 ==nz_d
            Tx_d(1,1,k1)=0;
            Tx_d(1,2,k1)=Tx(i-1,j,k2)*0.5;
            Tx_d(1,3,k1)=0;
            Tx_d(2,1,k1)=0;
            Tx_d(2,2,k1)=Tx(i,j,k2)*0.5;
            Tx_d(2,3,k1)=0;
            Ty_d(1,1,k1)=0;
            Ty_d(2,1,k1)=0;
            Ty_d(2,1,k1)=Ty(i,j-1,k2)*0.5;
            Ty_d(2,2,k1)=Ty(i,j,k2)*0.5;
            Ty_d(3,1,k1)=0;
            Ty_d(3,2,k1)=0;
                else
            Tx_d(1,1,k1)=0;
            Tx_d(1,2,k1)=Tx(i-1,j,k2);
            Tx_d(1,3,k1)=0;
            Tx_d(2,1,k1)=0;
            Tx_d(2,2,k1)=Tx(i,j,k2);
            Tx_d(2,3,k1)=0;
            Ty_d(1,1,k1)=0;
            Ty_d(2,1,k1)=0;
            Ty_d(2,1,k1)=Ty(i,j-1,k2);
            Ty_d(2,2,k1)=Ty(i,j,k2);
            Ty_d(3,1,k1)=0;
            Ty_d(3,2,k1)=0;
            k2=k2+1;
                end
            end
            
            % z direction top half trans
            
            k2=k-3;
            k1=1;
            Tz_d(1,1,k1)=0.00633*2*kz(i-1,j-1,k2)*200/2;
            Tz_d(1,2,k1)=0.00633*2*kz(i-1,j,k2)*200/2;
            Tz_d(2,1,k1)=0.00633*2*kz(i,j-1,k2)*200/2;
            Tz_d(2,2,k1)=0.00633*2*kz(i,j,k2)*200/2;
            
            % z direction middle cells trans
            k2=k-2;
            for k1=2:nz_d
            Tz_d(1,1,k1)=Tz(i-1,j-1,k2);
            Tz_d(1,2,k1)=Tz(i-1,j,k2);
            Tz_d(2,1,k1)=Tz(i,j-1,k2);
            Tz_d(2,2,k1)=Tz(i,j,k2);
            k2=k2+1;
            end
            % z direction transmissibilities for bottom end
            k2=k+2;
            k1=nz_d+1;
            
            Tz_d(1,1,k1)=0.00633*2*kz(i-1,j-1,k2)*200/1;
            Tz_d(1,2,k1)=0.00633*2*kz(i-1,j,k2)*200/1;
            Tz_d(2,1,k1)=0.00633*2*kz(i,j-1,k2)*200/1;
            Tz_d(2,2,k1)=0.00633*2*kz(i,j,k2)*200/1;
            
N=nx_d*ny_d*nz_d;
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
              if k1==1
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
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
            
% rate calculation
q_d=0;

for i1=1:ny_d
    for j1=1:nx_d
        k1=1;
        q_d=q_d+ Tz_d(i1,j1,k1)*(1-P_d(i1,j1,k1));
    end
end

Tz_226(i/2,j/2,floor(k/6)+1)= q_d;

        end
    end

% k=36
k=36;
 for i=2:2:ny
        for j=2:2:nx
        
            nx_d=2;
            ny_d=2;
            nz_d=6;
            k2=k-3;
            % x and y direction local ransmissibility
            for k1=1:nz_d
                if k1 ==1
            Tx_d(1,1,k1)=0;
            Tx_d(1,2,k1)=Tx(i-1,j,k2)*0.5;
            Tx_d(1,3,k1)=0;
            Tx_d(2,1,k1)=0;
            Tx_d(2,2,k1)=Tx(i,j,k2)*0.5;
            Tx_d(2,3,k1)=0;
            Ty_d(1,1,k1)=0;
            Ty_d(2,1,k1)=0;
            Ty_d(2,1,k1)=Ty(i,j-1,k2)*0.5;
            Ty_d(2,2,k1)=Ty(i,j,k2)*0.5;
            Ty_d(3,1,k1)=0;
            Ty_d(3,2,k1)=0;
                else
            Tx_d(1,1,k1)=0;
            Tx_d(1,2,k1)=Tx(i-1,j,k2);
            Tx_d(1,3,k1)=0;
            Tx_d(2,1,k1)=0;
            Tx_d(2,2,k1)=Tx(i,j,k2);
            Tx_d(2,3,k1)=0;
            Ty_d(1,1,k1)=0;
            Ty_d(2,1,k1)=0;
            Ty_d(2,1,k1)=Ty(i,j-1,k2);
            Ty_d(2,2,k1)=Ty(i,j,k2);
            Ty_d(3,1,k1)=0;
            Ty_d(3,2,k1)=0;
            k2=k2+1;
                end
            end
            
            % z direction top half trans
            
            k2=k-3;
            k1=1;
            Tz_d(1,1,k1)=0.00633*2*kz(i-1,j-1,k2)*200/1;
            Tz_d(1,2,k1)=0.00633*2*kz(i-1,j,k2)*200/1;
            Tz_d(2,1,k1)=0.00633*2*kz(i,j-1,k2)*200/1;
            Tz_d(2,2,k1)=0.00633*2*kz(i,j,k2)*200/1;
            
            % z direction middle cells trans
            k2=k-2;
            for k1=2:nz_d
            Tz_d(1,1,k1)=Tz(i-1,j-1,k2);
            Tz_d(1,2,k1)=Tz(i-1,j,k2);
            Tz_d(2,1,k1)=Tz(i,j-1,k2);
            Tz_d(2,2,k1)=Tz(i,j,k2);
            k2=k2+1;
            end
            % z direction transmissibilities for bottom end
            k2=k+2;
            k1=nz_d+1;
            
            Tz_d(1,1,k1)=0.00633*2*kz(i-1,j-1,k2)*200/2;
            Tz_d(1,2,k1)=0.00633*2*kz(i-1,j,k2)*200/2;
            Tz_d(2,1,k1)=0.00633*2*kz(i,j-1,k2)*200/2;
            Tz_d(2,2,k1)=0.00633*2*kz(i,j,k2)*200/2;
            
N=nx_d*ny_d*nz_d;
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
              if k1==1
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
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
            
% rate calculation
q_d=0;

for i1=1:ny_d
    for j1=1:nx_d
        k1=1;
        q_d=q_d+ Tz_d(i1,j1,k1)*(1-P_d(i1,j1,k1));
    end
end

Tz_226(i/2,j/2,floor(k/6)+1)= q_d;

        end
 end

    % k=42-78
    
for k=42:6:78
    for i=2:2:ny
        for j=2:2:nx
        
            nx_d=2;
            ny_d=2;
            nz_d=6;
            k2=k-3;
            % x and y direction local ransmissibility
            for k1=1:nz_d
            Tx_d(1,1,k1)=0;
            Tx_d(1,2,k1)=Tx(i-1,j,k2);
            Tx_d(1,3,k1)=0;
            Tx_d(2,1,k1)=0;
            Tx_d(2,2,k1)=Tx(i,j,k2);
            Tx_d(2,3,k1)=0;
            Ty_d(1,1,k1)=0;
            Ty_d(2,1,k1)=0;
            Ty_d(2,1,k1)=Ty(i,j-1,k2);
            Ty_d(2,2,k1)=Ty(i,j,k2);
            Ty_d(3,1,k1)=0;
            Ty_d(3,2,k1)=0;
            k2=k2+1;
            end
            
            % z direction top half trans
            
            k2=k-3;
            k1=1;
            Tz_d(1,1,k1)=0.00633*2*kz(i-1,j-1,k2)*200/2;
            Tz_d(1,2,k1)=0.00633*2*kz(i-1,j,k2)*200/2;
            Tz_d(2,1,k1)=0.00633*2*kz(i,j-1,k2)*200/2;
            Tz_d(2,2,k1)=0.00633*2*kz(i,j,k2)*200/2;
            
            % z direction middle cells trans
            k2=k-2;
            for k1=2:nz_d
            Tz_d(1,1,k1)=Tz(i-1,j-1,k2);
            Tz_d(1,2,k1)=Tz(i-1,j,k2);
            Tz_d(2,1,k1)=Tz(i,j-1,k2);
            Tz_d(2,2,k1)=Tz(i,j,k2);
            k2=k2+1;
            end
            % z direction transmissibilities for bottom end
            k2=k+2;
            k1=nz_d+1;
            
            Tz_d(1,1,k1)=0.00633*2*kz(i-1,j-1,k2)*200/2;
            Tz_d(1,2,k1)=0.00633*2*kz(i-1,j,k2)*200/2;
            Tz_d(2,1,k1)=0.00633*2*kz(i,j-1,k2)*200/2;
            Tz_d(2,2,k1)=0.00633*2*kz(i,j,k2)*200/2;
            
N=nx_d*ny_d*nz_d;
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
              if k1==1
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
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
            
% rate calculation
q_d=0;

for i1=1:ny_d
    for j1=1:nx_d
        k1=1;
        q_d=q_d+ Tz_d(i1,j1,k1)*(1-P_d(i1,j1,k1));
    end
end

Tz_226(i/2,j/2,floor(k/6)+1)= q_d;

        end
    end
end

% k=84 layer

k=84;
for i=2:2:ny
        for j=2:2:nx
        
            nx_d=2;
            ny_d=2;
            nz_d=4;
            k2=k-3;
            % x and y direction local ransmissibility
            for k1=1:nz_d
            Tx_d(1,1,k1)=0;
            Tx_d(1,2,k1)=Tx(i-1,j,k2);
            Tx_d(1,3,k1)=0;
            Tx_d(2,1,k1)=0;
            Tx_d(2,2,k1)=Tx(i,j,k2);
            Tx_d(2,3,k1)=0;
            Ty_d(1,1,k1)=0;
            Ty_d(2,1,k1)=0;
            Ty_d(2,1,k1)=Ty(i,j-1,k2);
            Ty_d(2,2,k1)=Ty(i,j,k2);
            Ty_d(3,1,k1)=0;
            Ty_d(3,2,k1)=0;
            k2=k2+1;
            end
            
            
            % z direction top half trans
            
            k2=k-3;
            k1=1;
            Tz_d(1,1,k1)=0.00633*2*kz(i-1,j-1,k2)*200/2;
            Tz_d(1,2,k1)=0.00633*2*kz(i-1,j,k2)*200/2;
            Tz_d(2,1,k1)=0.00633*2*kz(i,j-1,k2)*200/2;
            Tz_d(2,2,k1)=0.00633*2*kz(i,j,k2)*200/2;
            
            % z direction middle cells trans
            k2=k-2;
            for k1=2:nz_d
            Tz_d(1,1,k1)=Tz(i-1,j-1,k2);
            Tz_d(1,2,k1)=Tz(i-1,j,k2);
            Tz_d(2,1,k1)=Tz(i,j-1,k2);
            Tz_d(2,2,k1)=Tz(i,j,k2);
            k2=k2+1;
            end
            % z direction transmissibilities for bottom end
            k2=k;
            k1=nz_d+1;
            
            Tz_d(1,1,k1)=0.00633*2*kz(i-1,j-1,k2)*200/2;
            Tz_d(1,2,k1)=0.00633*2*kz(i-1,j,k2)*200/2;
            Tz_d(2,1,k1)=0.00633*2*kz(i,j-1,k2)*200/2;
            Tz_d(2,2,k1)=0.00633*2*kz(i,j,k2)*200/2;
            
N=nx_d*ny_d*nz_d;
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
              if k1==1
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
 
 P_d=full(P);
 P_d=reshape(P_d,nx_d,ny_d,nz_d);
 for k1=1:nz_d
     P_d(:,:,k1)=P_d(:,:,k1)';
 end
            
% rate calculation
q_d=0;

for i1=1:ny_d
    for j1=1:nx_d
        k1=1;
        q_d=q_d+ Tz_d(i1,j1,k1)*(1-P_d(i1,j1,k1));
    end
end

Tz_226(i/2,j/2,floor(k/6)+1)= q_d;

        end
    end
    
          