% start the outer loop for selecting the initial alpha0 and beta0 values
% at centre of each cell



global p q r tofp  actofp  e  nx ny nz poro recursion_limit recursion_error;
nx=30;
ny=110;
nz=8;
poro=poro2212;
%error
e=0.00000001;

tofp(1:ny,1:nx,1:nz)=0;
actofp(1:ny,1:nx,1:nz)=0;

for r=1:nz
for p=1:ny

    for q=1:nx
        tofp(p,q,r)=0;
        actofp(p,q,r)=0;
        alpha0_s=0.5;
        beta0_s=0.5;
        gamma0_s=0.5;
        disp('TOFP');
        disp([q p r]);
        %select cell indices
        n=q;
        m=p;
        l=r;
        recursion_limit=0;
        singlecell_tofp_calculator(alpha0_s,beta0_s,gamma0_s,m,n,l,qx,qy,qz);
    end
  
end
end
TOFP=actofp;

% tofp(1:ny,1:nx,1:nz)=0;
% actofp(1:ny,1:nx,1:nz)=0;
% 
% for r=1:nz
% for p= 1:ny
% 
%     for q= 1:nx
%         
%         tofp(p,q,r)=0;
%         actofp(p,q,r)=0;
%         
%         alpha0_s=0.5;
%         beta0_s=0.5;
%         gamma0_s=0.5;
%         disp('TOFI');
%         disp([q p r]);
%         % select cell indices
%         n=q;
%         m=p;
%         l=r;
%         singlecell_tofp_calculator(alpha0_s,beta0_s,gamma0_s,m,n,l,-qx,-qy,-qz);
%         
%     end
%   
% end
% end
% TOFI=actofp;
% TTOF=TOFI+TOFP;
%         
           
            
        