function [ M ] = moment_matrix ( I, x, y, sigma_d, sigma_i )
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
persistent L_x;
persistent L_y;
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

if  isempty(configuration) || ~ isequal(configuration,conf);
    G_Kernel_sigma_d = CreateGaussian(sigma_d);
    G_Kernel_sigma_i = CreateGaussian(sigma_i);

    G_sigma_d = conv2(I,G_Kernel_sigma_d,'same');
    %G_sigma_i = conv2(I,G_Kernel_sigma_i,'same');
   
    L_x = conv2(G_sigma_d,D_x,'same');
    L_y = conv2(G_sigma_d,D_y,'same');
    
   configuration = [sigma_d,sigma_i];
end

Part = [  [ L_x(x,y)^2,  L_x(x,y)*L_y(x,y) ]; [ L_x(x,y)*L_y(x,y), L_y(x,y)^2  ]  ];
M = (sigma_d)^2  * conv2(Part,G_Kernel_sigma_i) ;


end

