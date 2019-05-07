function properties_output( name,prmt )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fpath=[pwd '\output'];
fname=['\' name '.GRDECL'];
delete([fpath fname]);
fid=fopen([fpath fname ],'a');

prmt=prmt(:);
fprintf(fid,'%s\r\n',name);
fprintf(fid,' %d %d %d %d %d %d \r\n',prmt);
fprintf(fid,'/\r\n\r\n');

fclose(fid);
fclose('all');

end

