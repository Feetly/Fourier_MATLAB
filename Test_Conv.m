function y_n = Test_Conv( x_n , h_n )                                       % To get Conv of two signals using polynomial coefficent method
    y_n = ( zeros( 1 , ( length ( x_n ) + length( h_n ) - 1 ) ) ) ;         % Initialiazing y_n i.e Output
    for i = 1 : ( length ( x_n ) + length( h_n ) - 1 )                      % Loop For computation
        y_n( i ) = 0 ;
        for j = 1 : i
            if ( j <= length( x_n ) && ( i - j + 1 ) <= length( h_n ) )
                y_n( i ) = y_n( i ) + x_n( j ) * h_n( i - j + 1 ) ;
            end
        end
    end
end