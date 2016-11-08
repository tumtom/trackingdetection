function [ r,c,R ] = harris( I, sigma_d, sigma_i, alpha, threshold )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

R = response(I, sigma_d, sigma_i, alpha);

R = matrix_rescale(R,-1000,1000);

%filter
V = (R>threshold).*R;
%get coordinates for all filtered corners
[r,c] = find(V);

end

