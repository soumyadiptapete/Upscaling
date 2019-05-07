function singlecell_tofp_calculator(alpha0_d,beta0_d,gamma0_d,m_d,n_d,l_d,qx_d,qy_d,qz_d)
global p q r tofp actofp poro nx ny nz e recursion_limit recursion_error
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
        qx_d1=qx_d;
        qy_d1=qy_d;
        qz_d1=qz_d;
        alpha0=alpha0_d;
        beta0=beta0_d;
        gamma0=gamma0_d;
        
 if(m_d>=1 && m_d<=ny && n_d>=1 && n_d<=nx && l_d>=1 && l_d<=nz)      
        q11=qx_d1(m_d,n_d,l_d);
        q12=qx_d1(m_d,n_d+1,l_d);  
        q21=qy_d1(m_d,n_d,l_d); 
        q22=qy_d1(m_d+1,n_d,l_d);
        q31=qz_d1(m_d,n_d,l_d);
        q32=qz_d1(m_d,n_d,l_d+1);
     
        dq1=q12-q11;
        dq2=q22-q21;
        dq3=q32-q31;

        if dq1~=0
            argalpha1=(q11)/(q11+alpha0*dq1);
            argalpha2=(q11+dq1)/(q11+alpha0*dq1);
        end
        if dq2~=0
            argbeta1=(q21)/(q21+beta0*dq2);
            argbeta2=(q21+dq2)/(q21+beta0*dq2);
        end  
        
         if dq3~=0
            arggamma1=(q31)/(q31+gamma0*dq3);
            arggamma2=(q31+dq3)/(q31+gamma0*dq3);
        end  
        
end
        %test boundary conditions
while(m_d<=ny && m_d>=1 && n_d<=nx && n_d>=1 && l_d<=nz && l_d>=1)
    
     recursion_limit=recursion_limit+1;
       if recursion_limit==490
           recursion_error(p,q,r)=1;
           break;
       end
    
        % straight line conditions
        if abs(dq1)<=e && abs(dq2)>e && abs(dq3)>e
           t11= -alpha0/q11;
           t12=(1-alpha0)/q11;
           
           if argbeta1<=0
               t21=100000;
           else
               t21=(1/dq2)*log(argbeta1);
           end
           
           if argbeta2<=0
               t22=100000;
           else
               t22=(1/dq2)*log(argbeta2);
           end
           
            if arggamma1<=0
               t31=100000;
           else
               t31=(1/dq3)*log(arggamma1);
           end
           
           if arggamma2<=0
               t32=100000;
           else
               t32=(1/dq3)*log(arggamma2);
           end
           t=[t11 t12 t21 t22 t31 t32];
           tof_curr=tofc(t);
            if tof_curr==10^18
               actofp(p,q,r)=tof_curr;
               break;
           end
           alpha=alpha0+q11*tof_curr;
           beta=beta0*exp(dq2*tof_curr)+q21*((exp(dq2*tof_curr)-1)/(dq2));
           gamma=gamma0*exp(dq3*tof_curr)+q31*((exp(dq3*tof_curr)-1)/(dq3));
           tofp(p,q,r)= tofp(p,q,r)+tof_curr;
           actofp(p,q,r)=actofp(p,q,r)+(tof_curr*poro(m_d,n_d,l_d)*400);
           [m_d2,n_d2,l_d2,alpha0,beta0,gamma0]=Exit_face(tof_curr,t11,t12,t21,t22,t31,t32,alpha,beta,gamma,m_d,n_d,l_d);
           singlecell_tofp_calculator(alpha0,beta0,gamma0,m_d2,n_d2,l_d2,qx_d1,qy_d1,qz_d1);
           break;
           
        elseif(abs(dq2)<=e && abs(dq1)>e && abs(dq3)>e)
             t21= -beta0/q21;
           t22=(1-beta0)/q21;
           
           if argalpha1<=0
               t11=100000;
           else
               t11=(1/dq1)*log(argalpha1);
           end
           
           if argalpha2<=0
               t12=100000;
           else
               t12=(1/dq1)*log(argalpha2);
           end
            if arggamma1<=0
               t31=100000;
           else
               t31=(1/dq3)*log(arggamma1);
           end
           
           if arggamma2<=0
               t32=100000;
           else
               t32=(1/dq3)*log(arggamma2);
           end
           t=[t11 t12 t21 t22 t31 t32];
           tof_curr=tofc(t);
            if tof_curr==10^18
               actofp(p,q,r)=tof_curr;
               break;
           end
           beta=beta0+q21*tof_curr;
           alpha=alpha0*exp(dq1*tof_curr)+q11*((exp(dq1*tof_curr)-1)/(dq1));
           gamma=gamma0*exp(dq3*tof_curr)+q31*((exp(dq3*tof_curr)-1)/(dq3));
           tofp(p,q,r)= tofp(p,q,r)+tof_curr;
           actofp(p,q,r)=actofp(p,q,r)+(tof_curr*poro(m_d,n_d,l_d)*400);
           [m_d2,n_d2,l_d2,alpha0,beta0,gamma0]=Exit_face(tof_curr,t11,t12,t21,t22,t31,t32,alpha,beta,gamma,m_d,n_d,l_d);
           singlecell_tofp_calculator(alpha0,beta0,gamma0,m_d2,n_d2,l_d2,qx_d1,qy_d1,qz_d1);
           break;
           
        elseif(abs(dq3)<=e && abs(dq2)>e && abs(dq3)>e)
           t31= -gamma0/q31;
           t32=(1-gamma0)/q31;
            if argalpha1<=0
               t11=100000;
           else
               t11=(1/dq1)*log(argalpha1);
           end
           
           if argalpha2<=0
               t12=100000;
           else
               t12=(1/dq1)*log(argalpha2);
           end
            if argbeta1<=0
               t21=100000;
           else
               t21=(1/dq2)*log(argbeta1);
           end
           
           if argbeta2<=0
               t22=100000;
           else
               t22=(1/dq2)*log(argbeta2);
           end
           
           t=[t11 t12 t21 t22 t31 t32];
           tof_curr=tofc(t);
            if tof_curr==10^18
               actofp(p,q,r)=tof_curr;
               break;
           end
           gamma=gamma0+q31*tof_curr;
           alpha=alpha0*exp(dq1*tof_curr)+q11*((exp(dq1*tof_curr)-1)/(dq1));
           beta=beta0+q21*tof_curr;
           tofp(p,q,r)= tofp(p,q,r)+tof_curr;
           actofp(p,q,r)=actofp(p,q,r)+(tof_curr*poro(m_d,n_d,l_d)*400);
           [m_d2,n_d2,l_d2,alpha0,beta0,gamma0]=Exit_face(tof_curr,t11,t12,t21,t22,t31,t32,alpha,beta,gamma,m_d,n_d,l_d);
           singlecell_tofp_calculator(alpha0,beta0,gamma0,m_d2,n_d2,l_d2,qx_d1,qy_d1,qz_d1);
           break;           
        
        elseif ( abs(dq1)<=e && abs(dq2)<=e && abs(dq3)>e)
           t11= -alpha0/q11;
           t12=(1-alpha0)/q11;
           t21= -beta0/q21;
           t22=(1-beta0)/q21;
           if arggamma1<=0
               t31=100000;
           else
               t31=(1/dq3)*log(arggamma1);
           end
           
           if arggamma2<=0
               t32=100000;
           else
               t32=(1/dq3)*log(arggamma2);
           end
           t=[t11 t12 t21 t22 t31 t32];
           tof_curr=tofc(t);
            if tof_curr==10^18
               actofp(p,q,r)=tof_curr;
               break;
           end
           alpha=alpha0+q11*tof_curr;
           beta=beta0+q21*tof_curr;
           gamma=gamma0*exp(dq3*tof_curr)+q31*((exp(dq3*tof_curr)-1)/(dq3));
           tofp(p,q,r)= tofp(p,q,r)+tof_curr;
           actofp(p,q,r)=actofp(p,q,r)+(tof_curr*poro(m_d,n_d,l_d)*400);
           [m_d2,n_d2,l_d2,alpha0,beta0,gamma0]=Exit_face(tof_curr,t11,t12,t21,t22,t31,t32,alpha,beta,gamma,m_d,n_d,l_d);
           singlecell_tofp_calculator(alpha0,beta0,gamma0,m_d2,n_d2,l_d2,qx_d1,qy_d1,qz_d1);
           break;
            
        elseif(abs(dq2)<=e && abs(dq3)<=e && abs(dq1)>e)
           t21= -beta0/q21;
           t22=(1-beta0)/q21;
           t31= -gamma0/q31;
           t32=(1-gamma0)/q31;
           if argalpha1<=0
               t11=100000;
           else
               t11=(1/dq1)*log(argalpha1);
           end
           
           if argalpha2<=0
               t12=100000;
           else
               t12=(1/dq1)*log(argalpha2);
           end
            t=[t11 t12 t21 t22 t31 t32];
           tof_curr=tofc(t);
            if tof_curr==10^18
               actofp(p,q,r)=tof_curr;
               break;
           end
           gamma=gamma0+q31*tof_curr;
           alpha=alpha0*exp(dq1*tof_curr)+q11*((exp(dq1*tof_curr)-1)/(dq1));
           beta=beta0+q21*tof_curr;
           tofp(p,q,r)= tofp(p,q,r)+tof_curr;
           actofp(p,q,r)=actofp(p,q,r)+(tof_curr*poro(m_d,n_d,l_d)*400);
           [m_d2,n_d2,l_d2,alpha0,beta0,gamma0]=Exit_face(tof_curr,t11,t12,t21,t22,t31,t32,alpha,beta,gamma,m_d,n_d,l_d);
           singlecell_tofp_calculator(alpha0,beta0,gamma0,m_d2,n_d2,l_d2,qx_d1,qy_d1,qz_d1);
           break;  
           
        elseif(abs(dq1)<=e && abs(dq2)>e && abs(dq3)<=e)
           t31= -gamma0/q31;
           t32=(1-gamma0)/q31;
           t11= -alpha0/q11;
           t12=(1-alpha0)/q11;
            if argbeta1<=0
               t21=100000;
           else
               t21=(1/dq2)*log(argbeta1);
           end
           
           if argbeta2<=0
               t22=100000;
           else
               t22=(1/dq2)*log(argbeta2);
           end
           
           
           t=[t11 t12 t21 t22 t31 t32];
           tof_curr=tofc(t);
            if tof_curr==10^18
               actofp(p,q,r)=tof_curr;
               break;
           end
           gamma=gamma0+q31*tof_curr;
           alpha=alpha0+q11*tof_curr;
           beta=beta0*exp(dq2*tof_curr)+q21*((exp(dq2*tof_curr)-1)/(dq2));
           tofp(p,q,r)= tofp(p,q,r)+tof_curr;
           actofp(p,q,r)=actofp(p,q,r)+(tof_curr*poro(m_d,n_d,l_d)*400);
           [m_d2,n_d2,l_d2,alpha0,beta0,gamma0]=Exit_face(tof_curr,t11,t12,t21,t22,t31,t32,alpha,beta,gamma,m_d,n_d,l_d);
           singlecell_tofp_calculator(alpha0,beta0,gamma0,m_d2,n_d2,l_d2,qx_d1,qy_d1,qz_d1);
           break; 
           
        elseif(abs(dq1)<=e && abs(dq2)<=e && abs(dq3)<=e)
           t11= -alpha0/q11;
           t12=(1-alpha0)/q11;
           t21= -beta0/q21;
           t22=(1-beta0)/q21;
           t31= -gamma0/q31;
           t32=(1-gamma0)/q31;
            t=[t11 t12 t21 t22 t31 t32];
           tof_curr=tofc(t);
            if tof_curr==10^18
               actofp(p,q,r)=tof_curr;
               break;
           end
           gamma=gamma0+q31*tof_curr;
           alpha=alpha0+q11*tof_curr;
           beta=beta0+q21*tof_curr;
           tofp(p,q,r)= tofp(p,q,r)+tof_curr;
           actofp(p,q,r)=actofp(p,q,r)+(tof_curr*poro(m_d,n_d,l_d)*400);
           [m_d2,n_d2,l_d2,alpha0,beta0,gamma0]=Exit_face(tof_curr,t11,t12,t21,t22,t31,t32,alpha,beta,gamma,m_d,n_d,l_d);
           singlecell_tofp_calculator(alpha0,beta0,gamma0,m_d2,n_d2,l_d2,qx_d1,qy_d1,qz_d1);
           break; 
            
        % producer cell
        elseif(q11>=0 && q12<=0 && q21>=0 && q22<=0 && q31>=0 && q32<=0)
            tof_curr=0;
            tofp(p,q,r)=tofp(p,q,r)+tof_curr;
            actofp(p,q,r)=actofp(p,q,r)+ tof_curr;
            break;
            
        %injector cell
        elseif(q11<=0 && q12>=0 && q21<=0 && q22>=0 && q31<=0 && q32>=0)
            tof_curr=0;
            tofp(p,q,r)=tofp(p,q,r)+tof_curr;
            actofp(p,q,r)=actofp(p,q,r)+ tof_curr;
            alpha0=0;
            beta0=0;
            gamma0=0;
            m_d2=m_d+1;
            n_d2=n_d+1;
            if m_d2>ny
                m_d2=m_d-1;
            end
            if n_d2>nx
                n_d2=n_d-1;
            end
            l_d2=l_d;
           singlecell_tofp_calculator(alpha0,beta0,gamma0,m_d2,n_d2,l_d2,qx_d1,qy_d1,qz_d1);
            break;
            
         % stagnation point   
           elseif(q11<=0 && q12>=0 && q21<=0 && q22>=0 && q31<=0 && q32>=0)
            tof_curr=0;
            tof_curr=0;
            tofp(p,q,r)=tofp(p,q,r)+tof_curr;
            actofp(p,q,r)=actofp(p,q,r)+ tof_curr;
            break;
            
            
        else
            if(argalpha1<=0)
                t11=100000;
            else
                t11=(1/dq1)*log(argalpha1);
            end
            if(argalpha2<=0)
                t12=100000;
            else
                t12=(1/dq1)*log(argalpha2);
            end
           if argbeta1<=0
               t21=100000;
           else
               t21=(1/dq2)*log(argbeta1);
           end
           
           if argbeta2<=0
               t22=100000;
           else
               t22=(1/dq2)*log(argbeta2);
           end
              if arggamma1<=0
               t31=100000;
           else
               t31=(1/dq3)*log(arggamma1);
           end
           
           if arggamma2<=0
               t32=100000;
           else
               t32=(1/dq3)*log(arggamma2);
           end
           t=[t11 t12 t21 t22 t31 t32];
           tof_curr=tofc(t);
           if tof_curr==10^18
               actofp(p,q,r)=tof_curr;
               break;
           end
           beta=beta0*exp(dq2*tof_curr)+q21*((exp(dq2*tof_curr)-1)/(dq2));
           alpha=alpha0*exp(dq1*tof_curr)+q11*((exp(dq1*tof_curr)-1)/(dq1));
           gamma=gamma0*exp(dq3*tof_curr)+q31*((exp(dq3*tof_curr)-1)/(dq3));
           tofp(p,q,r)= tofp(p,q,r)+tof_curr;
           actofp(p,q,r)=actofp(p,q,r)+(tof_curr*poro(m_d,n_d,l_d)*400);
           [m_d2,n_d2,l_d2,alpha0,beta0,gamma0]=Exit_face(tof_curr,t11,t12,t21,t22,t31,t32,alpha,beta,gamma,m_d,n_d,l_d);
           singlecell_tofp_calculator(alpha0,beta0,gamma0,m_d2,n_d2,l_d2,qx_d1,qy_d1,qz_d1);
           break;
        
        end
end

