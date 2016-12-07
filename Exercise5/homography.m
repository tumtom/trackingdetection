function [ H ] = homography( M_s, M_d )

    [m, n] = size(M_s);
    A = zeros(n*2, 9);
    
    for i = 1:n
        x_s = M_s(1, i);
        y_s = M_s(2, i);
        w_s = M_s(3, i);
        
        x_d = M_d(1, i);
        y_d = M_d(2, i);
        w_d = M_d(3, i);
        
        A(2*i - 1, 4) = -w_d*x_s;
        A(2*i - 1, 5) = -w_d*y_s;
        A(2*i - 1, 6) = -w_d*w_s;
        
        A(2*i - 1, 7) = y_d*x_s;
        A(2*i - 1, 8) = y_d*y_s;
        A(2*i - 1, 9) = y_d*w_s;
               
        A(2*i, 1) = w_d*x_s;
        A(2*i, 2) = w_d*y_s;
        A(2*i, 3) = w_d*w_s;
        
        A(2*i, 7) = -x_d*x_s;
        A(2*i, 8) = -x_d*y_s;
        A(2*i, 9) = -x_d*w_s;     
    end
    
    %A = U*S*V'
    [U, S, V] = svd(A);
    
    h = V(:, 9);
    
    H = zeros(3,3);
    for row = 1:3
        for col = 1:3
            H(row, col) = h((row-1)*3+col, 1);
        end
    end
 
end

