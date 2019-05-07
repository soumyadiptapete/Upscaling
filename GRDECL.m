global poro nx ny nz;
fid=fopen('SPE10.GRDECL','r');
s1=fscanf(fid,'%s\n',1);
nx=fscanf(fid,'%d',1);
ny=fscanf(fid,'%d',1);
nz=fscanf(fid,'%d',1);
s2=fscanf(fid,' 1 F /\n%s\n',1);
COORD=fscanf(fid,'%g',[6 (nx+1)*(ny+1)]);
Xtop=reshape(COORD(1,:),nx+1,ny+1);
Xtop=Xtop';
Xbottom=reshape(COORD(4,:),nx+1,ny+1);
Xbottom=Xbottom';
Ytop=reshape(COORD(2,:),nx+1,ny+1);
Ytop=Ytop';
Ybottom=reshape(COORD(5,:),nx+1,ny+1);
Ybottom=Ybottom';
Ztop=reshape(COORD(3,:),nx+1,ny+1);
Ztop=Ztop';
Zbottom=reshape(COORD(6,:),nx+1,ny+1);
Zbottom=Zbottom';
d2=fscanf(fid,'\n/\n%s\n',1);
ZCORN_d=fscanf(fid,'%g',[1 8*nx*ny*nz]);
ZCORN_d=reshape(ZCORN_d,2*nx,2*ny,2*nz);
Zcorn=zeros(2*ny,2*nx,2*nz);
for i=1:2*nz
    Zcorn(:,:,i)=ZCORN_d(:,:,i)';
end
% % compute Xcorn and Ycorn
Xcorn=zeros(2*ny,2*nx,2*nz);
Ycorn=zeros(2*ny,2*nx,2*nz);
for k=1:2*nz
    for i=1:2*ny
        for j=1:2*nx
            a=floor(i/2)+1;
            b=floor(j/2)+1;
            alpha=Zcorn(i,j,k)-Ztop(a,b)/Zbottom(a,b)-Ztop(a,b);
            Xcorn(i,j,k)=Xtop(a,b)*(1-alpha)+Xbottom(a,b)*alpha;
            Ycorn(i,j,k)=Ytop(a,b)*(1-alpha)+Ybottom(a,b)*alpha;
            
        end
    end
end

s3=fscanf(fid,'\n/\n%s\n',1);
PORO_d=fscanf(fid,'%g', [6 nx*ny*nz/6]);
PORO_d=PORO_d(:);
PORO_d=reshape(PORO_d,nx,ny,nz);
poro=zeros(ny,nx,nz);
for i=1:nz
    poro(:,:,i)=PORO_d(:,:,i)';
end
s4=fscanf(fid,'\n/\n%s\n',1);
PERMX_d=fscanf(fid,'%g', [6 nx*ny*nz/6]);
PERMX_d=PERMX_d(:);
PERMX_d=reshape(PERMX_d,nx,ny,nz);
kx=zeros(ny,nx,nz);
for i=1:nz
    kx(:,:,i)=PERMX_d(:,:,i)';
end

s5=fscanf(fid,'\n/\n%s\n',1);
PERMY_d=fscanf(fid,'%g', [6 nx*ny*nz/6]);
PERMY_d=PERMY_d(:);
PERMY_d=reshape(PERMY_d,nx,ny,nz);
ky=zeros(ny,nx,nz);
for i=1:nz
    ky(:,:,i)=PERMY_d(:,:,i)';
end

s6=fscanf(fid,'\n/\n%s\n',1);
PERMZ_d=fscanf(fid,'%g', [6 nx*ny*nz/6]);
PERMZ_d=PERMZ_d(:);
PERMZ_d=reshape(PERMZ_d,nx,ny,nz);
kz=zeros(ny,nx,nz);
for i=1:nz
    kz(:,:,i)=PERMZ_d(:,:,i)';
end
clear PORO_d PERMX_d PERMY_d PERMZ_d COORD ZCORN_d s1 s2 s3 s4 s5 s6 d2 Xtop Xbottom Ytop Ybottom Ztop Zbottom;

% %set perms to zero in zero porosity cells
% for k=1:nz
%     for i=1:ny
%         for j=1:nx
%             if poro(i,j,k)==0
%                 kx(i,j,k)=10^-5;
%                 ky(i,j,k)=10^-5;
%                 kz(i,j,k)=10^-5;
%             end
%         end
%     end
% end

