% Author: Dhruv

close all
clear all
clc

x_n = input( '\n Enter First Signal x(n) eg. [1,2,3,4,0,6] : ' ) ;      % Input Signal 1. x_n = x[n]
h_n = input( '\n Enter Second Signal h(n) eg. [1,2,3] : ' ) ;           % Input Signal 2 h_n = h[n]
y_n_i = conv( x_n , h_n ) ;                                             % Convolution by conv in built fn. y_n_i = y[n] by inbuilt fn.
y_n_u = Test_Conv( x_n, h_n ) ;                                         % Convolution by own made fn. y_n_u = y[n] by our fn.

xo = input( '\n Enter Origin location Of Signal x(n) wrt 1st non-zero value in signal from -infinity \n eg. -1 if index of 1st value in signal is 2 units right of origin \n why -1 nd not -2 ? bcoz 0 is also an index in coding so if 1st value index corresponds to 1 which is 2 units ahead of origin \n means 0 is 1 unit left of 1st and -1 which is origin is 2 units left from 1st \n but if yr 1 value index is 3 units left of origin, yr origin value becomes 3.\n I hope u r clear with giving origin value, if not dont cut marks, contact me.\n Finall yr origin location value for Signal 1 : ' ) ;            % Index Location of Origin for Signal 1 = xo
ho = input( '\n Enter Origin location Of Signal h(n) wrt 1st non-zero value in signal from -infinity \n eg. 1 if 1st value corresponds to value at origin : ' ) ;            % Index Location of Origin for Signal 2 = ho
yo = xo + ho - 1;                                                       % Index Location of Origin of Convolution = yo

lx = length( x_n ) ;                                                    % Length of Signal 1 = lx
lh = length( h_n ) ;                                                    % Length of Signal 2 = hx
ly = lx + lh - 1 ;                                                      % Length of Convolution = lx     

tx = ( 1 - xo ) : 1 : ( lx - xo ) ;                                     % Time indexing of Signal 1 = tx
th = (1-ho) : 1 : ( lh - ho ) ;                                         % Time indexing of Signal 2 = th
ty = (1-yo) : 1 : ( ly - yo ) ;                                         % Time indexing of Convolution = ty

disp( "\n Convolved Singal: " ) ;                                       % Displaying Coeffs
disp( y_n_u ) ;

subplot( 2 , 2 , 1 ) ;                                                  % Ploting Signal 1
stem( tx , x_n ) ;
xlabel( ' Time ' ) ;
ylabel( ' Amplitude ' ) ;
title( ' Input Signal 1 (x[n]) ' ) ;

subplot( 2 , 2 , 2 ) ;                                                  % Ploting Signal 2
stem( th , h_n ) ; 
xlabel( ' Time ' ) ;
ylabel( ' Amplitude ' ) ;
title( ' Input Signal 2 (h[n]) ' ) ;

subplot( 2 , 2 , 3 ) ;                                                  % Ploting onvolution of own method
stem( ty , y_n_u ) ;
xlabel( ' Time ' ) ;
ylabel( ' Amplitude ' ) ;
title( 'Output Convolution Signal (y[n]) by own method ' ) ;

subplot( 2 , 2 , 4 ) ;                                                  % Ploting onvolution of conv fn
stem( ty , y_n_i ) ;
xlabel( ' Time ' ) ;
ylabel( ' Amplitude ' ) ;
title( ' Output Convolution Signal (y[n]) by conv agrument ' ) ;
