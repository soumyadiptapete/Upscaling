
nx=60;
ny=220;

for k=1:12:24
    for i=1:2:ny
        for j=1:2:nx
            
            k2=k;
            nz_d=12;
            poro_d=0;
            for k1=1:nz_d
                poro_d=poro_d+ poro(i,j,k2)+poro(i,j+1,k2)+poro(i+1,j,k2)+poro(i+1,j+1,k2);
                k2=k2+1;
            end
           poro2212(floor(i/2)+1,floor(j/2)+1,floor(k/12)+1)=poro_d/48;
        end
    end
end

for k=25:25
    for i=1:2:ny
        for j=1:2:nx
            
            k2=k;
            nz_d=11;
            poro_d=0;
            for k1=1:nz_d
                poro_d=poro_d+ poro(i,j,k2)+poro(i,j+1,k2)+poro(i+1,j,k2)+poro(i+1,j+1,k2);
                k2=k2+1;
            end
           poro2212(floor(i/2)+1,floor(j/2)+1,floor(k/12)+1)=poro_d/44;
        end
    end
end

for k=36:6:72
    for i=1:2:ny
        for j=1:2:nx
            
            k2=k;
            nz_d=12;
            poro_d=0;
            for k1=1:nz_d
                poro_d=poro_d+ poro(i,j,k2)+poro(i,j+1,k2)+poro(i+1,j,k2)+poro(i+1,j+1,k2);
                k2=k2+1;
            end
           poro2212(floor(i/2)+1,floor(j/2)+1,floor(k/12)+1)=poro_d/48;
        end
    end
end

for k=84:84
    for i=1:2:ny
        for j=1:2:nx
            
            k2=k;
            nz_d=2;
            poro_d=0;
            for k1=1:nz_d
                poro_d=poro_d+ poro(i,j,k2)+poro(i,j+1,k2)+poro(i+1,j,k2)+poro(i+1,j+1,k2);
                k2=k2+1;
            end
           poro2212(floor(i/2)+1,floor(j/2)+1,floor(k/12)+1)=poro_d/8;
        end
    end
end