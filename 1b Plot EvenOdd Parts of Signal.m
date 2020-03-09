% Author: Dhruv

close all
clear all
clc

t = -20 : 0.01 : 20 ;               % Time Index
x = input( 'Function in terms of t in language matlab understand eg. [ cos( 2*t ) + ( t.^4 ) + exp( abs( t ) ) ] \n Note*: include all bracket as in above given example [ ( ) ] \n : ' ) ;          % Input Signal Function
[ xe , xo ] = e_o( x ) ;            % xe = even part and xo = odd part. finding using function e_o(x)

subplot( 2 , 2 , 1 ) ;              % Plotting Original Signal
plot( t , x ) ;
title('Input') ; 
xlabel('Time') ;
ylabel('Amplitude');

subplot( 2 , 2 , 2 ) ;              % Plotting Odd Part of Signal
plot( t , xo+xe ) ;
title('Odd + Even Part Together') ;
xlabel('Time') ;
ylabel('Amplitude') ;

subplot( 2 , 2 , 3 ) ;              % Plotting Even Part of Signal
plot( t , xe ) ;
title('Even part') ;
xlabel('Time') ;
ylabel('Amplitude') ;

subplot( 2 , 2 , 4 ) ;              % Plotting Odd Part of Signal
plot( t , xo ) ;
title('Odd part') ;
xlabel('Time') ;
ylabel('Amplitude') ;


function [ xe , xo ] = e_o( x )     % Func to find even and odd parts
    m_x = fliplr( x ) ;             % to find x(-t)
    xe = 0.5 * ( x + m_x ) ;        % Even Part
    xo = 0.5 * ( x - m_x ) ;        % Odd Part
end