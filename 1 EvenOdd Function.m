close all
clear all
clc

t=-10:0.01:10;
x=sin(t);
[xe,xo]=e_o(x);
if xe==x
    disp('Even Function');
elseif xo==x
    disp('Odd Function');
else
    disp('Neither Odd/even Function');
end

subplot(3,1,1);
plot(t,x);
title('Your signal x')
subplot(3,1,2);
plot(t,xe);
title('Even part')
subplot(3,1,3);
plot(t,xo);
title('Odd part')

function [xe,xo] = e_o(x)
    m_x = fliplr(x);
    xe=0.5*(x+m_x);
    xo=0.5*(x-m_x);
end