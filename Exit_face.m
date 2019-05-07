function [m_new,n_new,l_new,a01,b01,g01 ] = Exit_face(tof1,t111,t121,t211,t221,t311,t321,alpha_d,beta_d,gamma_d,m_d1,n_d1,l_d1)
global e;
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if abs(tof1-t111)<=e
    % exit on left face
    m_new=m_d1;
    n_new=n_d1-1;
    l_new=l_d1;
    a01=1;
    b01=beta_d;
    g01=gamma_d;
end

if abs(tof1-t121)<=e
    %exit on right face
    m_new=m_d1;
    n_new=n_d1+1;
    l_new=l_d1;
    a01=0;
    b01=beta_d;
    g01=gamma_d;
end

if abs(tof1-t211)<=e
    % exit on south face
    m_new=m_d1-1;
    n_new=n_d1;
    l_new=l_d1;
    b01=1;
    a01=alpha_d;
    g01=gamma_d;
end

if abs(tof1-t221)<=e
    %exit on north face
    m_new=m_d1+1;
    n_new=n_d1;
    l_new=l_d1;
    b01=0;
    a01=alpha_d;
    g01=gamma_d;
    
end

%exit on the top face
if abs(tof1-t311)<=e
    m_new=m_d1;
    n_new=n_d1;
    l_new=l_d1-1;
    a01=alpha_d;
    b01=beta_d;
    g01=1;
end
    %exit on the bottom face
if abs(tof1-t321)<=e
    m_new=m_d1;
    n_new=n_d1;
    l_new=l_d1+1;
    a01=alpha_d;
    b01=beta_d;
    g01=0;
end 


if(abs(tof1-t121)<=e && abs(tof1-t221)<=e)
    m_new=m_d1+1;
    n_new=n_d1+1;
    l_new=l_d1;
    a01=0;
    b01=0;
    g01=gamma_d;
end

if(abs(tof1-t221)<=e && abs(tof1-t111)<=e)
    m_new=m_d1+1;
    n_new=n_d1-1;
    l_new=l_d1;
    a01=1;
    b01=0;
    g01=gamma_d;
end
    
 if(abs(tof1-t111)<=e && abs(tof1-t211)<=e)
     m_new=m_d1-1;
    n_new=n_d1-1;
    l_new=l_d1;
    a01=1;
    b01=1;
    g01=gamma_d;
 end
 
if(abs(tof1-t121)<=e && abs(tof1-t211)<=e)
    m_new=m_d1-1;
    n_new=n_d1+1;
    l_new=l_d1;
    a01=0;
    b01=1;
    g01=gamma_d;
end
 
if (abs(tof1-t121)<=e && abs(tof1-t311)<=e)
    m_new=m_d1;
    n_new=n_d1+1;
    l_new=l_d1-1;
    a01=0;
    b01=beta_d;
    g01=1;
end
 
if(abs(tof1-t111)<=e && abs(tof1-t311)<=e)
    m_new=m_d1;
    n_new=n_d1-1;
    l_new=l_d1-1;
    a01=1;
    b01=beta_d;
    g01=1;
end
if(abs(tof1-t121)<=e && abs(tof1-t321)<=e)
    m_new=m_d1;
    n_new=n_d1+1;
    l_new=l_d1+1;
    a01=0;
    b01=beta_d;
    g01=0;
end

if(abs(tof1-t111)<=e && abs(tof1-t321)<=e)
    m_new=m_d1;
    n_new=n_d1-1;
    l_new=l_d1+1;
    a01=1;
    b01=beta_d;
    g01=0;
end

if (abs(tof1-t211)<=e && abs(tof1-t311)<=e)
    m_new=m_d1-1;
    n_new=n_d1;
    l_new=l_d1-1;
    a01=alpha_d;
    b01=1;
    g01=1;
end

if (abs(tof1-t221)<=e && abs(tof1-t311)<=e)
    m_new=m_d1+1;
    n_new=n_d1;
    l_new=l_d1-1;
    a01=alpha_d;
    b01=0;
    g01=1;
end

if (abs(tof1-t211)<=e && abs(tof1-t321)<=e)
    m_new=m_d1-1;
    n_new=n_d1;
    l_new=l_d1+1;
    a01=alpha_d;
    b01=1;
    g01=0;
end

if (abs(tof1-t221)<=e && abs(tof1-t321)<=e)
    m_new=m_d1+1;
    n_new=n_d1;
    l_new=l_d1+1;
    a01=alpha_d;
    b01=0;
    g01=0;
end

if(abs(tof1-t221)<=e && abs(tof1-t311)<=e && abs(tof1-t121)<=e)
   m_new=m_d1+1;
    n_new=n_d1+1;
    l_new=l_d1-1;
    a01=0;
    b01=0;
    g01=1;
end

if(abs(tof1-t221)<=e && abs(tof1-t311)<=e && abs(tof1-t111)<=e)
   m_new=m_d1+1;
    n_new=n_d1-1;
    l_new=l_d1-1;
    a01=1;
    b01=0;
    g01=1;
end

if(abs(tof1-t211)<=e && abs(tof1-t311)<=e && abs(tof1-t111)<=e)
   m_new=m_d1-1;
    n_new=n_d1-1;
    l_new=l_d1-1;
    a01=1;
    b01=1;
    g01=1;
end

if(abs(tof1-t211)<=e && abs(tof1-t311)<=e && abs(tof1-t121)<=e)
   m_new=m_d1-1;
    n_new=n_d1+1;
    l_new=l_d1-1;
    a01=0;
    b01=1;
    g01=1;
end

if(abs(tof1-t211)<=e && abs(tof1-t321)<=e && abs(tof1-t121)<=e)
   m_new=m_d1-1;
    n_new=n_d1+1;
    l_new=l_d1+1;
    a01=0;
    b01=1;
    g01=0;
end

if(abs(tof1-t221)<=e && abs(tof1-t321)<=e && abs(tof1-t121)<=e)
   m_new=m_d1+1;
    n_new=n_d1+1;
    l_new=l_d1+1;
    a01=0;
    b01=0;
    g01=0;
end

if(abs(tof1-t221)<=e && abs(tof1-t321)<=e && abs(tof1-t111)<=e)
   m_new=m_d1+1;
    n_new=n_d1-1;
    l_new=l_d1+1;
    a01=1;
    b01=0;
    g01=0;
end

if(abs(tof1-t211)<=e && abs(tof1-t321)<=e && abs(tof1-t111)<=e)
   m_new=m_d1-1;
    n_new=n_d1-1;
    l_new=l_d1+1;
    a01=1;
    b01=1;
    g01=0;
end


    
end

