function [ I_Dx ] = x_gradient( I )
% applies the D_x kernel to the image I

D_x = [[-1,0,1];[-1,0,1];[-1,0,1]];
I_Dx = convolve(I,D_x,'border_extend');

end

