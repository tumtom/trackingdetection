function [ R ] = response( I, sigma_d, sigma_i, k )
%calculate the response for:
% - I: image matrix (doubles!)
% - sigma_d: differentiation scale
% - sigma_i: integration scale
% - k: parameter, usually between 0.04 and 0.06
%output: response for pixel x,y

persistent D_x; 
persistent D_y;

if isempty(D_x)
     D_x = [[-1,0,1];[-1,0,1];[-1,0,1]];
end

if isempty(D_y)
     D_y = [[-1,0,1];[-1,0,1];[-1,0,1]].';
end

G_Kernel_sigma_d = fspecial('gaussian',max(1,fix(3*sigma_d)),sigma_d);
%G_Kernel_sigma_i = fspecial('gaussian',max(1,fix(3*sigma_i)),sigma_i);

I_x = conv2(I,D_x,'same');
I_y = conv2(I,D_y,'same');
    
L_x2 = conv2(I_x.^2,G_Kernel_sigma_d,'same');
L_y2 = conv2(I_y.^2,G_Kernel_sigma_d,'same');
L_xy = conv2(I_y.*I_y,G_Kernel_sigma_d,'same');

R = (L_x2.*L_y2 - (L_xy.^2)) - k * ((L_x2 + L_y2).^2);

end

