% Author: Dhruv
close all
clear all
clc

%##### Part 1 #####
t = 0:0.01:10-0.01; % Time index
x = sin(2*pi*5*t); % Signal x
y = exp(t);  % Signal y
nf = [256 512 1024 2048]; % possible sizes

names = ["sin(2*pi*5*t)" "exp(t)"];

figure(1)

subplot(2,2,1);
plot(t,x);
title(" x(t) : sin(2*pi*5*t) Periodic Original Signal");
xlabel('Time.') ;
ylabel('Amplitude') ;

subplot(2,2,2);
plot(t,y);
title(" y(t) : exp(t) Non Periodic Original Signal");
xlabel('Time.') ;
ylabel('Amplitude') ;

suptitle("Original Signals")

for j = 1:2
    if j == 1
        fn = x;
    else
        fn = y;
    end
    %##### Part 2 #####
    %### Case 1 ###     (with padding)
    for i = 1:4
        figure(2+(j-1)*8)
        [m,p,f,~] = my_func(fn,nf(i),0,0); % fourier transform of x
        subplot(2,2,i);
        plot(f,m);
        title("(n = "+string(nf(i))+" ) |X(k)| vs k for "+names(j));
        xlabel('Frequency (in Hertz)') ;
        ylabel('Magnitude') ;
        suptitle("Case 1 (Padding) : FFT Magnitude Graphs")
        
        figure(3+(j-1)*8)
        subplot(2,2,i);
        plot(f,p);
        title("(n = "+string(nf(i))+" ) Angle(X(k)) vs k for "+names(j));
        xlabel('Frequency (in Hertz)') ;
        ylabel('Phase (in Degress)') ;
        suptitle("Case 1 (Padding) : FFT Phase Graphs")
    end
    %### Case 2 ###      (without padding)
    for i = 1:4
        figure(4+(j-1)*8)
        [m,p,f,~] = my_func(fn,nf(i),1,0);
        subplot(2,2,i);
        plot(f,m);
        title("(n = "+string(nf(i))+" ) |X(k)| vs k for "+names(j));
        xlabel('Frequency (in Hertz)') ;
        ylabel('Magnitude') ;
        suptitle("Case 2 (Without Padding) : FFT Magnitude Graphs")
        
        figure(5+(j-1)*8)
        subplot(2,2,i);
        plot(f,p);
        title("(n = "+string(nf(i))+" ) Angle(X(k)) vs k for "+names(j));
        xlabel('Frequency (in Hertz)') ;
        ylabel('Phase (in Degress)') ;
        suptitle("Case 2 (Without Padding) : FFT Phase Graphs")
    end

    %##### Part 3 #####
    %### Case 1 ###
    for i = 1:4
        figure(6+(j-1)*8)
        [~,~,~,z1] = my_func(fn,nf(i),0,0);
        [~,~,~,z2] = my_func(z1,nf(i),0,1);
        subplot(2,2,i);
        plot((0:length(z2)-1)/100,z2);
        title("(n = "+string(nf(i))+" ) X(t) vs t for "+names(j));
        xlabel('Time.') ;
        ylabel('Amplitude') ;
        suptitle("Case 1 (Padding) : Inverse IFFT Original Graphs")
    end

    %### Case 2 ###
    for i = 1:4
        figure(7+(j-1)*8)
        [~,~,~,z1] = my_func(fn,nf(i),1,0);
        [~,~,~,z2] = my_func(z1,nf(i),1,1);
        subplot(2,2,i);
        plot((0:length(z2)-1)/100,z2);
        title("(n = "+string(nf(i))+" ) X(t) vs t for "+names(j));
        xlabel('Time.') ;
        ylabel('Amplitude') ;
        suptitle("Case 2 (Without Padding) : Inverse IFFT Original Graphs")
    end   
end

%##### Part 4 #####
%### Real/Imaginary Even/Odd Properties ###
xeven = cos(2*pi*5*t);
xodd = sin(2*pi*2*t);
[ m1,p1,f1,~ ] = my_func(xeven, length(xeven), 0, 0);
[ m2,p2,f2,~ ] = my_func(xodd, length(xodd), 0, 0);
p1(abs(p1) < 1e-6) = 0;
figure(16);
subplot(3,1,1);
plot(xeven);
title('Even Signal');
subplot(3,1,2);
plot(f1,m1);
title('FT Magnitude')
subplot(3,1,3);
plot(f1,p1);
title('FT Phase');
suptitle(" Property Prove : (Even/Odd) Observable that FT of xeven has a zero phase,i.e., FT is real")
%Observable that FT of xeven has a zero phase,i.e., FT is real
figure(17);
subplot(3,1,1);
plot(xodd);
title('Odd Signal');
subplot(3,1,2);
plot(f2,m2);
title('FT Magnitude');
subplot(3,1,3);
plot(f2,p2);
title('FT Phase');
suptitle(" Property Prove : (Even/Odd) Observable that FT of xodd has a +/-90 degree phase,i.e., FT is imaginary")
%Observable that FT of xeven has a +/-90 degree phase,i.e., FT is imaginary

%### Linearity ###
z = x + y;
[m,~,f,~] = my_func(z,1000,0,0);             %fourier transform of z
[m1,~,~,~] = my_func(x,1000,0,0);          %fourier transform of x
[m2,~,~,~] = my_func(y,1000,0,0);          %fourier transform of y
md = m1+m2-m;                                %difference between magnitudes
md(md<1e-6)=0;                               %setting very small values of magnitude difference to 0
ctr =0;
for i=1:1000
    if(md(i)~=0)                             %if magnitude difference is 0 for all elements linearity will hold
        ctr=ctr+1;
    end
end
if (ctr<5)
    figure(18);
    subplot(2,1,1);                              %plots
    plot(f,m);
    title('Magnitude of fft(x+y)');
    subplot(2,1,2);
    plot(f,m1+m2);
    title('Magnitude of fft(x)+fft(y)');
    suptitle(" Property Prove : (Linearity) Observable")
end

%### Convolution ###
z = conv(x,y);
[m,p,f,fz]=my_func(z,nf(4),0,0);       %fourier transform of z
[m1,p1,f1,fx]=my_func(x,nf(4),0,0);    %fourier transform of x
[m2,p2,f2,fy]=my_func(y,nf(4),0,0);    %fourier transform of y
fz1=fftshift(fx).*fftshift(fy);        %multiplication of fourier transform of x and y
md1=(m-abs(fz1)/length(fz1));          %difference between magnitudes of f_z and f_z1
md1(md1<1e-6)=0;                       %setting very small values of magnitude difference to 0
for i=1:1000
    if(md(i)~=0)                       %if magnitude difference is 0 for all elements of f_z and f_z1 the convolution prropery will hold
        ctr=ctr+1;
    end
end
if (ctr<5)
    figure(19);
    subplot(2,2,1);
    plot(f,m);
    title('Magnitude of fft(conv(x,y))');
    subplot(2,2,2);
    plot(f,abs(fz1)/length(fz1));
    title('Magnitude of fft(x)*fft(y)');
    subplot(2,2,3);
    plot(f,p);
    title('Phase of fft(conv(x,y))');
    subplot(2,2,4);
    plot(f,angle(fz1)*180/pi);
    title('Phase of fft(x)*fft(y)'); 
    suptitle(" Property Prove : (Convolution) Observable")
end
    
%### Time Shift ###
figure(20);
x = sin(t);
[xn] = shift(x,2);

x_fft = fftshift(fft(x))/length(x);
xn_fft = fftshift(fft(xn)*exp(-1i*2))/length(x);

z = x_fft - xn_fft;
z((abs(z) < 1)) = 0; 
plot(angle(z));
title('Differnce in Phases in fftold*exp and fftnew. Observable Time shift Property holds for sin(t)'); 

function [ m,p,f,z ] = my_func(x, ns, pp , inv) % x is signal, ns is size, pp is wihtpu padding control and inv is to take fft or ifft control
    m=0;    % init. process
    p=0;    % init. process
    f=0;    % init. process
    if (pp == 1) && (length(x) < ns)
        ns = length(x);
    end 
    if inv == 1
        z = ifft(x,ns);
    else
        z = fft(x,ns); % z_fft
        zn = fftshift(z); % Shifted fft
        n = length(zn); 
        f = (-n/2:n/2-1)*(100/n); % f is frequncy set
        zn(abs(zn) < 1e-6) = 0;          %Removing small noises
        m = abs(zn)/n;      % m is magnitude
        p = angle(zn)*180/pi;         %p is Phase
    end  
end

function [ shifted ] = shift(x, delay)
    shifted = circshift(x,-delay*100);
    if delay > 0
        tn = 10+0.01:0.01:10+delay;
        shifted(end-delay*100+1:end) = sin(tn);
    else
        tn = delay:0.01:0-0.01;
        shifted(1:abs(delay)*100) = sin(tn) ;
    end
end