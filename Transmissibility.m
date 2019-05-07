% left trans for constant pressure on left side x=0

global Xcorn Ycorn Zcorn;

nz=85;
Tx=zeros(ny,nx+1,nz);
for k=1:nz
    for i=1:ny
        j=1;
        Tx(i,j,k)=0;
    end
end

% trans for x=right side

for k=1:nz
    for i=1:ny
        j=nx+1;
        Tx(i,j,k)=0;
    end
end

% trans for x direction for cells i between

for k=1:nz
    for i=1:ny
        for j=2:nx
%             T1=(2*0.00633*Ja(i,j-1,k,1,0.5,0.5)*kx(i,j-1,k)/(tx(i,j-1,k,1,0.5,0.5))^2);
%             T2=(2*0.00633*Ja(i,j,k,0,.5,.5)*kx(i,j,k)/(tx(i,j,k,0,0.5,0.5))^2);
            T1=(2*0.00633*400*kx(i,j-1,k)/20^2);
            T2=(2*0.00633*400*kx(i,j,k)/20^2);
            
            Tx(i,j,k)=T1*T2/(T1+T2);
            if Tx(i,j,k)==0
                Tx(i,j,k)=10^-4;
            end
        end
    end
end
Ty=zeros(ny+1,nx,nz);
% south T=0

for k=1:nz
    for j=1:nx
        i=1;
        Ty(i,j,k)=0;
    end
end

%north T=0

for k=1:nz
    for j=1:nx
        i=ny+1;
        Ty(i,j,k)=0;
    end
end
% T in y direction for rest of the cells

for k=1:nz
    for i=2:ny
        for j=1:nx
%             T1=(2*0.00633*Ja(i-1,j,k,0.5,1,0.5)*ky(i-1,j,k)/(ty(i-1,j,k,0.5,1,0.5))^2);
%             T2=(2*0.00633*Ja(i,j,k,0.5,0,.5)*ky(i,j,k)/(ty(i,j,k,0.5,0,0.5))^2);
            T1=(2*0.00633*400*ky(i-1,j,k)/10^2);
            T2=(2*0.00633*400*ky(i,j,k)/10^2);
            Ty(i,j,k)=T1*T2/(T1+T2);
            if Ty(i,j,k)==0
                Ty(i,j,k)=10^-4;
            end
        end
    end
end

% Top T=0

Tz=zeros(ny,nx,nz+1);
for i=1:ny
    for j=1:nx
        k=1;
        Tz(i,j,k)=0;
    end   
end

% bottom T=0
for i=1:ny
    for j=1:nx
        k=nz+1;
        Tz(i,j,k)=0;
    end   
end

% Tz for between cells

for k=2:nz
  for  i=1:ny
    for j=1:nx
%      T1=(2*0.00633*Ja(i,j,k-1,0.5,0.5,1)*kz(i,j,k-1)/(tz(i,j,k-1,0.5,0.5,1))^2);
%      T2=(2*0.00633*Ja(i,j,k,0.5,0.5,0)*kz(i,j,k)/(tz(i,j,k,0.5,0.5,0))^2);
     T1=(2*0.00633*400*kz(i,j,k-1)/2^2);
     T2=(2*0.00633*400*kz(i,j,k)/2^2);
     Tz(i,j,k)=T1*T2/(T1+T2); 
     if Tz(i,j,k)==0
                Tz(i,j,k)=10^-4;
      end
    end
  end
end


    
        


