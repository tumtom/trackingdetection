function [ M ] = moment_matrix ( I, x, y, k, sigma_d, sigma_i )
%calculates the moment-matrix for:
% - I: image matrix (doubles!)
% - x: image row
% - y: pixel column in row x
% - sigma_d: differentiation scale
% - sigma_i: integration scale
%output: moment-matrix

persistent configuration;
persistent D_x; 
persistent D_y;
persistent L_x2;
persistent L_y2;
persistent L_xy;
persistent G_sigma_d;
persistent G_Kernel_sigma_d;
persistent G_Kernel_sigma_i;

if isempty(D_x)
     D_x = [[-1,0,1];[-1,0,1];[-1,0,1]];
end

if isempty(D_y)
     D_y = [[-1,0,1];[-1,0,1];[-1,0,1]].';
end

conf = [sigma_d,sigma_i];

if  isempty(configuration) || ~ isequal(configuration,conf)
    %G_Kernel_sigma_d = CreateGaussian(sigma_d);
    G_Kernel_sigma_d = fspecial('gaussian',max(1,fix(3*sigma_d)),sigma_d);
    %G_Kernel_sigma_i = CreateGaussian(sigma_i);

    %G_sigma_d = conv2(I,G_Kernel_sigma_d,'same');
    %G_sigma_i = conv2(I,G_Kernel_sigma_i,'same');
   
    I_x = conv2(I,D_x,'same');
    I_y = conv2(I,D_y,'same');
    
    L_x2 = conv2(I_x.^2,G_Kernel_sigma_d,'same');
    L_y2 = conv2(I_y.^2,G_Kernel_sigma_d,'same');
    L_xy = conv2(I_y.*I_y,G_Kernel_sigma_d,'same');
   configuration = [sigma_d,sigma_i];
end

M = (L_x2.*L_y2 - (L_xy.^2)) - k * ((L_x2 + L_y2).^2);


end

