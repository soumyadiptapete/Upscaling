% porosity gross upscaling 2x2x6
nx=60;
ny=220;

for k=1:6:25
    for i=1:2:ny
        for j=1:2:nx
            nz_d=6;
            nx_d=2;
            ny_d=2;
            k2=k;
            i2=i;
            j2=j;
            poro_d=0;
            for k1=1:nz_d
                i2=i;
                for i1=1:ny_d
                    j2=j;
                    for j1=1:nx_d
                    poro_d=poro_d+ poro(i2,j2,k2);
                    j2=j2+1;
                    end
                 i2=i2+1;
                end
              k2=k2+1;
            end
           poro226(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)=poro_d/24;
        end
    end
end

for k=31:31
    for i=1:2:ny
        for j=1:2:nx
            nz_d=5;
            nx_d=2;
            ny_d=2;
            k2=k;
            i2=i;
            j2=j;
            poro_d=0;
            for k1=1:nz_d
                i2=i;
                for i1=1:ny_d
                    j2=j;
                    for j1=1:nx_d
                    poro_d=poro_d+ poro(i2,j2,k2);
                    j2=j2+1;
                    end
                 i2=i2+1;
                end
              k2=k2+1;
            end
           poro226(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)=poro_d/20;
        end
    end
end

for k=36:6:78
    for i=1:2:ny
        for j=1:2:nx
            nz_d=6;
            nx_d=2;
            ny_d=2;
            k2=k;
            i2=i;
            j2=j;
            poro_d=0;
            for k1=1:nz_d
                i2=i;
                for i1=1:ny_d
                    j2=j;
                    for j1=1:nx_d
                    poro_d=poro_d+ poro(i2,j2,k2);
                    j2=j2+1;
                    end
                 i2=i2+1;
                end
              k2=k2+1;
            end
           poro226(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)=poro_d/24;
        end
    end
end

for k=84:84
    for i=1:2:ny
        for j=1:2:nx
            nz_d=2;
            nx_d=2;
            ny_d=2;
            k2=k;
            i2=i;
            j2=j;
            poro_d=0;
            for k1=1:nz_d
                i2=i;
                for i1=1:ny_d
                    j2=j;
                    for j1=1:nx_d
                    poro_d=poro_d+ poro(i2,j2,k2);
                    j2=j2+1;
                    end
                 i2=i2+1;
                end
              k2=k2+1;
            end
           poro226(floor(i/2)+1,floor(j/2)+1,floor(k/6)+1)=poro_d/8;
        end
    end
end