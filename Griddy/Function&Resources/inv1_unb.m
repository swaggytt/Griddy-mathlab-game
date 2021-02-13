
% Copyright 2019 The University of Texas at Austin
%
% For licensing information see
%                http://www.cs.utexas.edu/users/flame/license.html 
%                                                                                 
% Programmed by: Name of author
%                Email of author

function [ B_out ] = inv_unb( A, B )

  [ ATL, ATR, ...
    ABL, ABR ] = FLA_Part_2x2( A, ...
                               0, 0, 'FLA_TL' );

  [ BTL, BTR, ...
    BBL, BBR ] = FLA_Part_2x2( B, ...
                               0, 0, 'FLA_TL' );

  while ( size( ATL, 1 ) < size( A, 1 ) )

    [ A00,  a01,     A02,  ...
      a10t, alpha11, a12t, ...
      A20,  a21,     A22 ] = FLA_Repart_2x2_to_3x3( ATL, ATR, ...
                                                    ABL, ABR, ...
                                                    1, 1, 'FLA_BR' );

    [ B00,  b01,    B02,  ...
      b10t, beta11, b12t, ...
      B20,  b21,    B22 ] = FLA_Repart_2x2_to_3x3( BTL, BTR, ...
                                                   BBL, BBR, ...
                                                   1, 1, 'FLA_BR' );

    %------------------------------------------------------------%
    
    if alpha11 == 0
        index = 1;
        while a21(index) == 0
            index = index + 1;
        end
        
        tmpa = alpha11;
        tmpa10t = a10t;
        tmpa12t = a12t;
        
        alpha11 = a21(index);
        a10t = A20(index,:);
        a12t = A22(index,:);
        
        a21(index) = tmpa;
        A20(index,:) = tmpa10t;
        A22(index,:) = tmpa12t;
        
        tmpb = beta11;
        tmpb10t = b10t;
        tmpb12t = b12t;
        
        beta11 = b21(index);
        b10t = B20(index,:);
        b12t = B22(index,:);
        
        b21(index) = tmpb;
        B20(index,:) = tmpb10t;
        B22(index,:) = tmpb12t;
    end
    
    a01 = a01 / alpha11;
    A02 = A02 - a01*a12t;
    
    a21 = a21/alpha11;
    A22 = A22 - a21*a12t;
    
    B00 = B00 - a01*b10t;
    b01 = b01 + (-1*beta11 * a01);
    
    B20 = B20 - a21*b10t;
    b21 = b21 + ( -1*beta11 * a21);
    
    B02 = B02 - a01*b12t;
    B22 = B22 - a21*b12t;
   
    a12t = a12t/alpha11;
    b10t = b10t/alpha11;
    beta11 = beta11/alpha11;
  
    
    alpha11 = 1;
    a21 = zeros(size(a21));
    a01 = zeros(size(a01));

    %------------------------------------------------------------%

    [ ATL, ATR, ...
      ABL, ABR ] = FLA_Cont_with_3x3_to_2x2( A00,  a01,     A02,  ...
                                             a10t, alpha11, a12t, ...
                                             A20,  a21,     A22, ...
                                             'FLA_TL' );

    [ BTL, BTR, ...
      BBL, BBR ] = FLA_Cont_with_3x3_to_2x2( B00,  b01,    B02,  ...
                                             b10t, beta11, b12t, ...
                                             B20,  b21,    B22, ...
                                             'FLA_TL' );

  end
  B_out = [ BTL, BTR
            BBL, BBR ];

return
