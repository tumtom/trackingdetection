function [ C ] = harris( I, sigma_d, sigma_i, alpha, threshold )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

[rows,cols] = size(I);

C = zeros(0,3);

for r=1:rows
    for c=1:cols
        R = response( I, r, c, sigma_d, sigma_i, alpha );
        if (abs(R) >= threshold)
            C = [C;[r,c,R]];
        end
    end
end

end

