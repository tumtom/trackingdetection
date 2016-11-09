function [ V ] = LoG( I, r, c, sigma_i )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

persistent D_x; 
persistent D_y;

if isempty(D_x)
     D_x = [[-1,0,1];[-1,0,1];[-1,0,1]];
end

if isempty(D_y)
     D_y = [[-1,0,1];[-1,0,1];[-1,0,1]].';
end

G_Kernel_sigma_i = fspecial('gaussian',max(1,fix(3*sigma_i)),sigma_i);

L = conv2(I,G_Kernel_sigma_i,'same');
    
L_xx = conv2(conv2(L,D_x,'same'),D_x,'same');
L_yy = conv2(conv2(L,D_y,'same'),D_y,'same');

V = abs( sigma_i^2 * (L_xx(r,c) + L_yy(r,c)));

end

