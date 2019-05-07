% property comparer for 2x2x6
prop_fine=P;
prop_coarse=Pcoarse;
ny=220;
nx=60;
for k=1:35
    for i=1:ny
        for j=1:nx
            
            if rem(i,2)~=0
                i1=floor(i/2)+1;
            else
                i1=floor(i/2);
            end
            
             if rem(j,2)~=0
                j1=floor(j/2)+1;
            else
                j1=floor(j/2);
            end
             if rem(k,6)~=0
                k1=floor(k/6)+1;
            else
                k1=floor(k/6);
            end
            
            dprop(i,j,k)=prop_fine(i,j,k)-prop_coarse(i1,j1,k1);
        end
        
    end
end

for k=36:83
    for i=1:ny
        for j=1:nx
             if rem(i,2)~=0
                i1=floor(i/2)+1;
            else
                i1=floor(i/2);
            end
            
             if rem(j,2)~=0
                j1=floor(j/2)+1;
            else
                j1=floor(j/2);
             end
            k1=floor(k/6)+1;
            dprop(i,j,k)=prop_fine(i,j,k)-prop_coarse(i1,j1,k1);
            
        end
    end
end

for k=84:85
    for i=1:ny
        for j=1:nx
             if rem(i,2)~=0
                i1=floor(i/2)+1;
            else
                i1=floor(i/2);
            end
            
             if rem(j,2)~=0
                j1=floor(j/2)+1;
            else
                j1=floor(j/2);
             end
            k1=floor(k/6)+1;
            dprop(i,j,k)=prop_fine(i,j,k)-prop_coarse(i1,j1,k1);
            
        end
    end
end

