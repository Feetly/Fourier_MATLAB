% Author: Dhruv
close all
clear all
clc

t = -10 : 0.01 : 10 ;                           % Time Index
x = input( 'Function in terms of t in language matlab understand eg. [ cos( 2*t ) + ( t.^4 ) + exp( abs( t ) ) ] \n Note*: include all bracket as in above given example [ ( ) ] \n : ' ) ;          % Input Signal Function
disp ( e_o( x ) ) ;                             % Function to check if fn. is odd/even

function result = e_o( x ) 
    m_x = fliplr( x ) ;                         % x(-t)
    xe = 0.5 * ( x + m_x ) ;                    % Even Part
    xo = 0.5 * ( x - m_x ) ;                    % Odd Part
    result = '' ;                               % To Store Result
    if ( (xe == x ) == ( xo == x ) )            % Comparision
        result = ' Even & Odd Function ';        
    elseif xe == x                                 
        result = ' Even Function ' ;
    elseif xo == x
        result = ' Odd Function ' ;
    else
        result = ' Neither Odd/even Function ' ;
    end
end