function [ R ] = harris( I, sigma_d, sigma_i, alpha, threshold )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
clear moment_matrix;

[rows,cols] = size(I);

C = zeros(0,3);
R = size(I);

for r=1:rows
    for c=1:cols
        R(r,c) = response( I, r, c, sigma_d, sigma_i, alpha );
    end
end

end

