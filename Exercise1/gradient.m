function [ gradient_magnitude, gradient_orientation ] = gradient( I )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

xgrad = x_gradient(I);
ygrad = y_gradient(I);

gradient_magnitude = sqrt(xgrad.^2 + ygrad.^2); 
gradient_orientation = atan(ygrad./xgrad);

end

