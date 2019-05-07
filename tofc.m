function [ tof_d ] = tofc( t_d )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
global e ;
b=sort(t_d);
for i=1:6
    if b(i)> e
        tof_d=b(i);
       break;
    end
   tof_d=10^18;
end

