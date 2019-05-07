function [coord] = grid_output( bdry,dims )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xs=bdry(1);
xe=bdry(2);
ys=bdry(3);
ye=bdry(4);
zs=bdry(5);
ze=bdry(6);
nx=dims(1);
ny=dims(2);
nz=dims(3);

x_vect=xs:(xe-xs)/nx:xe;
y_vect=ys:(ye-ys)/ny:ye;
z_vect=zs:(ze-zs)/nz:ze;

x=repmat(x_vect',1,ny+1);
y=repmat(y_vect,nx+1,1);
coord=[x(:),y(:),zs.*ones((nx+1)*(ny+1),1),x(:),y(:),ze.*ones((nx+1)*(ny+1),1)];
z_vect2=[z_vect(:,1:nz);z_vect(:,2:nz+1)];
z_vect2=z_vect2(:);
z_vect2=z_vect2';
zcorn=ones(4*nx*ny,1)*z_vect2;
actnum=ones(nx,ny,nz);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fpath=[pwd '\output'];
fname='\grid.GRDECL';
delete([fpath fname]);
fid=fopen([fpath fname ],'a');

fprintf(fid,'%s\r\n','SPECGRID');
fprintf(fid,' %d  %d  %d  1  F  /\r\n',nx,ny,nz);

fprintf(fid,'%s\r\n','COORD');
fprintf(fid,' %f %f %f %f %f %f \r\n',coord');
fprintf(fid,'/\r\n\r\n');

fprintf(fid,'%s\r\n','ZCORN');
fprintf(fid,' %f %f %f %f %f %f \r\n',zcorn);
fprintf(fid,'/\r\n\r\n');

fprintf(fid,'%s\r\n','ACTNUM');
fprintf(fid,' %d %d %d %d %d %d \r\n',actnum);
fprintf(fid,'/\r\n\r\n');

fprintf(fid,'%s\r\n','PERMX');
fprintf(fid,' %d %d %d %d %d %d \r\n',actnum);
fprintf(fid,'/\r\n\r\n');

fclose(fid);
fclose('all');

end

